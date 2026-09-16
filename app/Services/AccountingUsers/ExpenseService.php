<?php

namespace App\Services\AccountingUsers;

use App\Enums\MetaTypeTransactionEnum;
use App\Enums\NormalBalanceEnum;
use App\Enums\TransactionStatus;
use App\Enums\TransactionType;
use App\Helpers\TransactionHelper;
use App\Models\Transaction;
use App\Models\UserAccountBalance;
use App\Services\TransactionBaseService;
use Exception;
use Illuminate\Support\Facades\DB;

class ExpenseService extends TransactionBaseService
{
    /**
     * Handle expense transaction.
     *
     * Journal:
     * Debit  : Akun Pengeluaran (Beberapa line)
     * Credit : Kas User
     *
     * @throws Exception
     */
    public function handle(array $data): Transaction
    {
        return DB::transaction(function () use ($data) {
            $status = $data['status'] ?? TransactionStatus::DRAFT->value;

            // 1. Lock & ambil UserAccountBalance Kas Sumber
            $userBalance = UserAccountBalance::query()
                ->with('userAccount')
                ->lockForUpdate()
                ->findOrFail($data['user_account_balance_id']);

            $oldBalance = [
                'allocated_balance' => $userBalance->allocated_balance,
                'income_balance'    => $userBalance->income_balance,
                'used_balance'      => $userBalance->used_balance,
                'remaining_balance' => $userBalance->remaining_balance,
            ];

            $totalExpense = collect($data['expense_lines'])->sum('amount');

            $parentDescription = !empty($data['description'])
                ? $data['description']
                : collect($data['expense_lines'])->pluck('description')->filter()->implode(' dan ');

            if (empty($parentDescription)) {
                $parentDescription = 'Transaksi Pengeluaran';
            }

            $data['description'] = $parentDescription;

            $lines = [];

            // Debit akun tujuan (Pengeluaran)
            foreach ($data['expense_lines'] as $expense) {
                $lineDesc = !empty($expense['description'])
                    ? $expense['description']
                    : TransactionHelper::generateLineDescription(
                        $expense['coa_id'],
                        $expense['description'] ?? null
                    );

                $lines[] = $this->line(
                    $expense['coa_id'],
                    $expense['amount'],
                    NormalBalanceEnum::DEBIT->value,
                    MetaTypeTransactionEnum::MAIN,
                    $lineDesc
                );
            }

            // Credit kas user
            $lines[] = $this->line(
                $userBalance->userAccount->coa_id,
                $totalExpense,
                NormalBalanceEnum::CREDIT->value,
                MetaTypeTransactionEnum::MAIN,
                "Mutasi Kas Keluar"
            );

            if (! in_array($status, [TransactionStatus::DRAFT->value, TransactionStatus::POSTED->value])) {
                throw new Exception('Status transaksi tidak valid.');
            }

            $transaction = $this->storeTransaction(
                $data,
                $lines,
                $totalExpense,
                TransactionType::EXPENSE
            );

            if ($status === TransactionStatus::POSTED->value) {
                // Update saldo Kas Sumber (remaining_balance berkurang)
                $userBalance->increment('used_balance', $totalExpense);
                $userBalance->decrement('remaining_balance', $totalExpense);

                // Update saldo UserAccountBalance untuk tiap Akun Pengeluaran (jika terdaftar di UserAccount)
                $this->updateExpenseAccountBalances(
                    $data['expense_lines'],
                    $transaction->period_id,
                    $transaction->sub_period_id,
                    $transaction
                );

                // Create Journal Entry & Update General Ledger CoaBalance
                $this->generateJournal(
                    [
                        'transaction_date' => $transaction->transaction_date,
                        'description'      => $transaction->description,
                        'period_id'        => $transaction->period_id,
                        'sub_period_id'    => $transaction->sub_period_id,
                    ],
                    $lines,
                    collect($lines)->sum('debit'),
                    collect($lines)->sum('credit'),
                    'EXP',
                    $transaction
                );

                // Audit Log Update Saldo Kas Sumber
                $isDeficit = $userBalance->remaining_balance < 0;
                $this->logger->log(
                    action: 'UPDATE',
                    module: 'USER_ACCOUNT_BALANCE',
                    subject: $userBalance,
                    description: $isDeficit
                        ? 'Saldo pengguna menjadi DEFISIT (minus) akibat transaksi pengeluaran.'
                        : 'Saldo pengguna berkurang karena transaksi pengeluaran.',
                    old: $oldBalance,
                    new: [
                        'allocated_balance' => $userBalance->allocated_balance,
                        'income_balance'    => $userBalance->income_balance,
                        'used_balance'      => $userBalance->used_balance,
                        'remaining_balance' => $userBalance->remaining_balance,
                    ],
                    additionalData: [
                        'transaction_id'     => $transaction->id,
                        'transaction_number' => $transaction->transaction_number,
                        'expense_amount'     => $totalExpense,
                        'is_deficit'         => $isDeficit,
                    ]
                );
            }

            // Audit Log Transaction Created
            $this->logger->log(
                action: 'CREATE',
                module: 'TRANSACTION_EXPENSE',
                subject: $transaction,
                description: 'Membuat transaksi pengeluaran.',
                old: [],
                new: [
                    'transaction_id'     => $transaction->id,
                    'transaction_number' => $transaction->transaction_number,
                    'transaction_date'   => $transaction->transaction_date,
                    'total_amount'       => $totalExpense,
                    'status'             => $transaction->status,
                ],
                additionalData: [
                    'transaction_type' => TransactionType::EXPENSE->value,
                    'period_id'        => $transaction->period_id,
                    'sub_period_id'    => $transaction->sub_period_id,
                ]
            );

            return $transaction;
        });
    }

    /**
     * Post a draft transaction.
     *
     * @throws Exception
     */
    public function postTransaction(string $id): Transaction
    {
        return DB::transaction(function () use ($id) {
            $transaction = Transaction::query()
                ->with(['transactionLines'])
                ->lockForUpdate()
                ->findOrFail($id);

            if ($transaction->status !== TransactionStatus::DRAFT->value) {
                throw new Exception('Hanya transaksi DRAFT yang dapat diposting.');
            }

            $cashLine = $transaction->transactionLines
                ->where('position', NormalBalanceEnum::CREDIT->value)
                ->first();

            if (! $cashLine) {
                throw new Exception('Akun kas tidak ditemukan.');
            }

            $userBalance = UserAccountBalance::query()
                ->with('userAccount')
                ->lockForUpdate()
                ->whereHas('userAccount', function ($q) use ($cashLine) {
                    $q->where('coa_id', $cashLine->chart_of_account_id);
                })
                ->where('period_id', $transaction->period_id)
                ->where('sub_period_id', $transaction->sub_period_id)
                ->firstOrFail();

            $oldBalance = [
                'used_balance'      => $userBalance->used_balance,
                'remaining_balance' => $userBalance->remaining_balance,
            ];

            // Update Saldo Kas Sumber
            $userBalance->increment('used_balance', $transaction->gross_amount);
            $userBalance->decrement('remaining_balance', $transaction->gross_amount);

            // Update Saldo UserAccountBalance Akun-Akun Pengeluaran
            $debitLines = $transaction->transactionLines
                ->where('position', NormalBalanceEnum::DEBIT->value)
                ->map(fn($line) => [
                    'coa_id' => $line->chart_of_account_id,
                    'amount' => $line->amount,
                ])
                ->toArray();

            $this->updateExpenseAccountBalances(
                $debitLines,
                $transaction->period_id,
                $transaction->sub_period_id,
                $transaction
            );

            // Build journal lines
            $lines = $transaction->transactionLines->map(function ($line) {
                return [
                    'coa_id'      => $line->chart_of_account_id,
                    'amount'      => $line->amount,
                    'position'    => $line->position,
                    'debit'       => $line->position == NormalBalanceEnum::DEBIT->value ? $line->amount : 0,
                    'credit'      => $line->position == NormalBalanceEnum::CREDIT->value ? $line->amount : 0,
                    'meta_type'   => $line->meta_type,
                    'description' => $line->description,
                ];
            })->values()->toArray();

            $transaction->update([
                'status' => TransactionStatus::POSTED->value,
            ]);

            // Generate Journal Entry
            $totalDebit = $transaction->transactionLines
                ->where('position', NormalBalanceEnum::DEBIT->value)
                ->sum('amount');

            $totalCredit = $transaction->transactionLines
                ->where('position', NormalBalanceEnum::CREDIT->value)
                ->sum('amount');

            self::generateJournal(
                [
                    'transaction_date' => $transaction->transaction_date,
                    'description'      => $transaction->description,
                    'period_id'        => $transaction->period_id,
                    'sub_period_id'    => $transaction->sub_period_id,
                ],
                $lines,
                $totalDebit,
                $totalCredit,
                'EXP',
                $transaction
            );

            // Audit Balance
            $this->logger->log(
                action: 'UPDATE',
                module: 'USER_ACCOUNT_BALANCE',
                subject: $userBalance,
                description: 'Posting transaksi mengurangi saldo user.',
                old: $oldBalance,
                new: [
                    'used_balance'      => $userBalance->used_balance,
                    'remaining_balance' => $userBalance->remaining_balance,
                ],
                additionalData: [
                    'transaction_id'     => $transaction->id,
                    'transaction_number' => $transaction->transaction_number,
                    'is_deficit'         => $userBalance->remaining_balance < 0,
                ]
            );

            return $transaction->fresh(['transactionLines']);
        });
    }

    /**
     * Helper privat untuk meng-update UserAccountBalance milik COA pengeluaran.
     */
    private function updateExpenseAccountBalances(
        array $expenseLines,
        string $periodId,
        string $subPeriodId,
        Transaction $transaction
    ): void {
        foreach ($expenseLines as $expenseLine) {
            $amount = (float) $expenseLine['amount'];

            $expenseUserBalance = UserAccountBalance::query()
                ->whereHas('userAccount', function ($q) use ($expenseLine) {
                    $q->where('coa_id', $expenseLine['coa_id']);
                })
                ->where('period_id', $periodId)
                ->where('sub_period_id', $subPeriodId)
                ->lockForUpdate()
                ->first();

            if ($expenseUserBalance) {
                $oldExpenseBalance = [
                    'used_balance'      => $expenseUserBalance->used_balance,
                    'remaining_balance' => $expenseUserBalance->remaining_balance,
                ];

                $expenseUserBalance->increment('used_balance', $amount);
                $expenseUserBalance->decrement('remaining_balance', $amount);

                $this->logger->log(
                    action: 'UPDATE',
                    module: 'USER_ACCOUNT_BALANCE',
                    subject: $expenseUserBalance,
                    description: 'Saldo akun pengeluaran bertambah penggunaannya karena transaksi pengeluaran.',
                    old: $oldExpenseBalance,
                    new: [
                        'used_balance'      => $expenseUserBalance->used_balance,
                        'remaining_balance' => $expenseUserBalance->remaining_balance,
                    ],
                    additionalData: [
                        'transaction_id'     => $transaction->id,
                        'transaction_number' => $transaction->transaction_number,
                        'expense_amount'     => $amount,
                    ]
                );
            }
        }
    }
}
