<?php

namespace App\Services\AccountingUsers;

use App\Enums\MetaTypeTransactionEnum;
use App\Enums\NormalBalanceEnum;
use App\Enums\TransactionStatus;
use App\Enums\TransactionType;
use App\Models\Transaction;
use App\Models\UserAccountBalance;
use App\Services\TransactionBaseService;
use Carbon\Carbon;
use Exception;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class ExpenseService extends TransactionBaseService
{
    /**
     * Handle expense transaction
     * 
     * Journal:
     * Debit  : Akun Pengeluaran
     * Credit : Kas User
     *
     * @param array $data
     * @return Transaction
     * @throws ValidationException
     * @throws \Exception
     */
    public function handle(array $data): Transaction
    {
        return DB::transaction(function () use ($data) {

            $status = $data['status'] ?? TransactionStatus::DRAFT->value;
            $userBalance = UserAccountBalance::query()
                ->with('userAccount')
                ->lockForUpdate()
                ->findOrFail(
                    $data['user_account_balance_id']
                );

            $oldBalance = [
                'used_balance' => $userBalance->used_balance,
                'remaining_balance' => $userBalance->remaining_balance,
            ];

            $totalExpense = collect($data['expense_lines'])->sum('amount');

            // Validasi saldo
            if ($userBalance->remaining_balance < $totalExpense) {
                throw new Exception('Periode tidak valid atau sudah ditutup.');
            }

            $lines = [];

            // Debit akun tujuan
            foreach ($data['expense_lines'] as $expense) {

                $lines[] = $this->line(
                    $expense['coa_id'],
                    $expense['amount'],
                    NormalBalanceEnum::DEBIT->value,
                    MetaTypeTransactionEnum::MAIN,
                    $expense['description'] ?? 'Pengeluaran'
                );
            }

            // Credit kas user
            $lines[] = $this->line(
                $userBalance->userAccount->coa_id,
                $totalExpense,
                NormalBalanceEnum::CREDIT->value,
                MetaTypeTransactionEnum::MAIN,
                'Kas Keluar'
            );

            /**
             * =====================================================
             * STORE TRANSACTION
             * ====================================================
             * 
             * STATUS DRAFT: Simpan transaksi tanpa mengurangi saldo user
             * STATUS POSTED: Tidak diperbolehkan, karena transaksi harus melalui DRAFT atau SUBMITTED terlebih dahulu
             */
            if ($status === TransactionStatus::DRAFT->value) {
                $transaction = $this->storeTransaction(
                    $data,
                    $lines,
                    $totalExpense,
                    TransactionType::EXPENSE
                );
            } elseif ($status === TransactionStatus::POSTED->value) {
                $transaction = $this->storeTransaction(
                    $data,
                    $lines,
                    $totalExpense,
                    TransactionType::EXPENSE
                );

                // Update saldo user : 
                // Pengeluaran -> Saldo digunakan Bertambah dan Saldo Tersisa Berkurang
                $userBalance->increment('used_balance', $totalExpense);
                $userBalance->decrement('remaining_balance', $totalExpense);

                // Create Journal
                $this->generateJournal(
                    [
                        'transaction_date' => $transaction->transaction_date,
                        'description' => $transaction->description,
                        'period_id' => $transaction->period_id,
                        'sub_period_id' => $transaction->sub_period_id,
                    ],
                    $lines,
                    collect($lines)->sum('debit'),
                    collect($lines)->sum('credit'),
                    'EXP',
                    $transaction
                );

                /**
                 * =====================================================
                 * AUDIT LOG - USER BALANCE UPDATED
                 * =====================================================
                 */
                $this->logger->log(
                    action: 'UPDATE',
                    module: 'USER_ACCOUNT_BALANCE',
                    subject: $userBalance,
                    description: 'Saldo pengguna berkurang karena transaksi pengeluaran.',
                    old: $oldBalance,
                    new: [
                        'used_balance' => $userBalance->used_balance,
                        'remaining_balance' => $userBalance->remaining_balance,
                    ],
                    additionalData: [
                        'transaction_id' => $transaction->id,
                        'transaction_number' => $transaction->transaction_number,
                        'expense_amount' => $totalExpense,
                    ]
                );
            } else {
                throw new Exception('Status transaksi tidak valid.');
            }

            /**
             * =====================================================
             * AUDIT LOG - TRANSACTION CREATED
             * =====================================================
             */
            $this->logger->log(
                action: 'CREATE',
                module: 'TRANSACTION_EXPENSE',
                subject: $transaction,
                description: 'Membuat transaksi pengeluaran.',
                old: [],
                new: [
                    'transaction_id' => $transaction->id,
                    'transaction_number' => $transaction->transaction_number,
                    'transaction_date' => $transaction->transaction_date,
                    'total_amount' => $totalExpense,
                    'status' => $transaction->status,
                    'lines' => collect($lines)->map(function ($line) {
                        return [
                            'coa_id' => $line['coa_id'],
                            'position' => $line['position'],
                            'amount' => $line['amount'],
                            'description' => $line['description'],
                        ];
                    })->toArray(),
                ],
                additionalData: [
                    'transaction_type' => TransactionType::EXPENSE->value,
                    'period_id' => $transaction->period_id,
                    'sub_period_id' => $transaction->sub_period_id,
                ]
            );

            return $transaction;
        });
    }

    /**
     * Update transaction
     * STATUS DRAFT: Update transaksi tanpa mengurangi saldo user
     * STATUS POSTED: Update transaksi dan kurangi saldo user dan generate jurnal
     *
     * @param string $id
     * @param array $data
     * @return Transaction
     * @throws \Exception
     */
    public function update(string $id, array $data): Transaction
    {
        return DB::transaction(function () use ($data, $id) {
            $status = $data['status'] ?? TransactionStatus::DRAFT->value;

            $transaction = Transaction::query()
                ->with('lines')
                ->lockForUpdate()
                ->findOrFail($id);

            $userBalance = UserAccountBalance::query()
                ->with('userAccount')
                ->lockForUpdate()
                ->findOrFail(
                    $data['user_account_balance_id']
                );

            $oldBalance = [
                'used_balance' => $userBalance->used_balance,
                'remaining_balance' => $userBalance->remaining_balance,
            ];

            $totalExpense = collect($data['expense_lines'])->sum('amount');

            // Validasi saldo
            if ($userBalance->remaining_balance + $transaction->total_amount < $totalExpense) {
                throw new Exception('Saldo tidak mencukupi untuk transaksi ini.');
            }

            $lines = [];

            // Debit akun tujuan
            foreach ($data['expense_lines'] as $expense) {

                $lines[] = $this->line(
                    $expense['coa_id'],
                    $expense['amount'],
                    NormalBalanceEnum::DEBIT->value,
                    MetaTypeTransactionEnum::MAIN,
                    $expense['description'] ?? 'Pengeluaran'
                );
            }

            // Credit kas user
            $lines[] = $this->line(
                $userBalance->userAccount->coa_id,
                $totalExpense,
                NormalBalanceEnum::CREDIT->value,
                MetaTypeTransactionEnum::MAIN,
                'Kas Keluar'
            );

            if ($status === TransactionStatus::DRAFT->value) {
                $transaction = $this->storeTransaction(
                    $data,
                    $lines,
                    $totalExpense,
                    TransactionType::EXPENSE
                );
            } elseif ($status === TransactionStatus::POSTED->value) {
                $transaction = $this->storeTransaction(
                    $data,
                    $lines,
                    $totalExpense,
                    TransactionType::EXPENSE
                );

                // Update saldo user
                $userBalance->increment('used_balance', $totalExpense);
                $userBalance->decrement('remaining_balance', $totalExpense);

                /**
                 * =====================================================
                 * AUDIT LOG - USER BALANCE UPDATED
                 * =====================================================
                 */
                $this->logger->log(
                    action: 'UPDATE',
                    module: 'USER_ACCOUNT_BALANCE',
                    subject: $userBalance,
                    description: 'Saldo pengguna berkurang karena transaksi pengeluaran.',
                    old: $oldBalance,
                    new: [
                        'used_balance' => $userBalance->used_balance,
                        'remaining_balance' => $userBalance->remaining_balance,
                    ],
                    additionalData: [
                        'transaction_id' => $transaction->id,
                        'transaction_number' => $transaction->transaction_number,
                        'expense_amount' => $totalExpense,
                    ]
                );
            } else {
                throw new Exception('Status transaksi tidak valid.');
            }

            /**
             * =====================================================
             * AUDIT LOG - TRANSACTION UPDATED
             * =====================================================
             */
            $this->logger->log(
                action: 'UPDATE',
                module: 'TRANSACTION_EXPENSE',
                subject: $transaction,
                description: 'Memperbarui transaksi pengeluaran.',
                old: [
                    'transaction_id' => $transaction->id,
                    'transaction_number' => $transaction->transaction_number,
                    'transaction_date' => $transaction->transaction_date,
                    'total_amount' => $transaction->total_amount,
                    'status' => $transaction->status,
                    'lines' => $transaction->lines->map(function ($line) {
                        return [
                            'coa_id' => $line->chart_of_account_id,
                            'position' => $line->position,
                            'amount' => $line->amount,
                            'description' => $line->description,
                        ];
                    })->toArray(),
                ],
                new: [
                    'transaction_id' => $transaction->id,
                    'transaction_number' => $transaction->transaction_number,
                    'transaction_date' => $transaction->transaction_date,
                    'total_amount' => $totalExpense,
                    'status' => $status,
                    'lines' => collect($lines)->map(function ($line) {
                        return [
                            'coa_id' => $line['coa_id'],
                            'position' => $line['position'],
                            'amount' => $line['amount'],
                            'description' => $line['description'],
                        ];
                    })->toArray(),
                ],
                additionalData: [
                    'transaction_type' => TransactionType::EXPENSE->value,
                    'period_id' => $transaction->period_id,
                    'sub_period_id' => $transaction->sub_period_id,
                ]
            );

            return $transaction;
        });
    }


    /**
     * Post a transaction.
     * STEPS:
     * 1. Lock the transaction for update.
     * 2. Check if the transaction is in DRAFT status.
     * 3. Lock the user balance for update.
     * 4. Check if the user balance is sufficient.
     * 5. Update the user balance.
     * 6. Build the transaction lines.
     * 7. Update the transaction status to POSTED.
     * 8. Generate the journal entry.
     * 9. Log the changes in user balance and transaction status.
     *
     * @param string $id
     * @return Transaction
     * @throws \Exception
     */
    public function postTransaction(string $id): Transaction
    {
        return DB::transaction(function () use ($id) {

            $transaction = Transaction::query()
                ->with([
                    'transactionLines',
                ])
                ->lockForUpdate()
                ->findOrFail($id);

            if ($transaction->status !== TransactionStatus::DRAFT->value) {
                throw new Exception(
                    'Hanya transaksi DRAFT yang dapat diposting.'
                );
            }

            /*
            |--------------------------------------------------------------------------
            | Ambil akun kas user
            |--------------------------------------------------------------------------
            */
            $cashLine = $transaction->transactionLines
                ->where('position', NormalBalanceEnum::CREDIT->value)
                ->first();

            if (!$cashLine) {
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

            /*
            |--------------------------------------------------------------------------
            | Validasi saldo
            |--------------------------------------------------------------------------
            */
            if ($userBalance->remaining_balance < $transaction->gross_amount) {
                throw new Exception('Saldo kas tidak mencukupi.');
            }

            /*
            |--------------------------------------------------------------------------
            | Update User Balance
            |--------------------------------------------------------------------------
            */
            $oldBalance = [
                'used_balance' => $userBalance->used_balance,
                'remaining_balance' => $userBalance->remaining_balance,
            ];

            $userBalance->increment(
                'used_balance',
                $transaction->gross_amount
            );

            $userBalance->decrement(
                'remaining_balance',
                $transaction->gross_amount
            );

            /*
            |--------------------------------------------------------------------------
            | Build journal lines
            |--------------------------------------------------------------------------
            */
            $lines = $transaction->transactionLines->map(function ($line) {

                return [

                    'coa_id' => $line->chart_of_account_id,

                    'amount' => $line->amount,

                    'position' => $line->position,

                    'debit' => $line->position == NormalBalanceEnum::DEBIT->value
                        ? $line->amount
                        : 0,

                    'credit' => $line->position == NormalBalanceEnum::CREDIT->value
                        ? $line->amount
                        : 0,

                    'meta_type' => $line->meta_type,

                    'description' => $line->description,

                ];
            })->values()->toArray();

            /*
            |--------------------------------------------------------------------------
            | Update Status
            |--------------------------------------------------------------------------
            */

            $transaction->update([
                'status' => TransactionStatus::POSTED->value,
            ]);

            /*
            |--------------------------------------------------------------------------
            | Generate Journal
            |--------------------------------------------------------------------------
            */
            $totalDebit = $transaction->transactionLines
                ->where('position', NormalBalanceEnum::DEBIT->value)
                ->sum('amount');

            $totalCredit = $transaction->transactionLines
                ->where('position', NormalBalanceEnum::CREDIT->value)
                ->sum('amount');

            self::generateJournal(
                [
                    'transaction_date' => $transaction->transaction_date,
                    'description' => $transaction->description,
                    'period_id' => $transaction->period_id,
                    'sub_period_id' => $transaction->sub_period_id,
                ],
                $lines,
                $totalDebit,
                $totalCredit,
                'EXP',
                $transaction

            );

            /*
            |--------------------------------------------------------------------------
            | Audit Balance
            |--------------------------------------------------------------------------
            */

            $this->logger->log(
                action: 'UPDATE',
                module: 'USER_ACCOUNT_BALANCE',
                subject: $userBalance,
                description: 'Posting transaksi mengurangi saldo user.',
                old: $oldBalance,
                new: [
                    'used_balance' => $userBalance->used_balance,
                    'remaining_balance' => $userBalance->remaining_balance,
                ],
                additionalData: [
                    'transaction_id' => $transaction->id,
                    'transaction_number' => $transaction->transaction_number,
                ]
            );

            return $transaction->fresh([
                'transactionLines',
            ]);
        });
    }


    /**
     * Cancel a transaction.
     * STEPS:
     * 1. Lock the transaction for update.
     * 2. Check if the transaction is in DRAFT status.
     * 3. Lock the user balance for update.
     * 4. Update the user balance -> reserve (Kebalikan dari posted / dana nya kembali).
     * 5. Update the transaction status to RESERVED.
     *
     * @param string $id
     * @return Transaction
     * @throws \Exception
     */
    public function cancelTransaction(string $id): Transaction
    {
        return DB::transaction(function () use ($id) {

            $transaction = Transaction::query()
                ->with([
                    'transactionLines',
                ])
                ->lockForUpdate()
                ->findOrFail($id);

            if ($transaction->status !== TransactionStatus::DRAFT->value) {
                throw new Exception(
                    'Hanya transaksi DRAFT yang dapat dibatalkan.'
                );
            }

            /*
            |--------------------------------------------------------------------------
            | Ambil akun kas user
            |--------------------------------------------------------------------------
            */
            $cashLine = $transaction->transactionLines
                ->where('position', NormalBalanceEnum::CREDIT->value)
                ->first();

            if (!$cashLine) {
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

            /*
            |--------------------------------------------------------------------------
            | Update User Balance Akun Kas -> Dana Akun Kas kembali
            |--------------------------------------------------------------------------
            */
            $oldBalance = [
                'used_balance' => $userBalance->used_balance,
                'remaining_balance' => $userBalance->remaining_balance,
            ];

            $userBalance->decrement(
                'used_balance',
                $transaction->gross_amount
            );

            $userBalance->increment(
                'remaining_balance',
                $transaction->gross_amount
            );


            /*
            |--------------------------------------------------------------------------
            | Ambil Akun Pengeluaran
            |--------------------------------------------------------------------------
            */
            $expenseLines = $transaction->transactionLines
                ->where('position', NormalBalanceEnum::DEBIT->value)
                ->values();

            if ($expenseLines->isEmpty()) {
                throw new Exception('Akun pengeluaran tidak ditemukan.');
            }

            $expenseUsedBalance = UserAccountBalance::query()
                ->with('userAccount')
                ->lockForUpdate()
                ->whereHas('userAccount', function ($q) use ($expenseLines) {
                    $q->whereIn('coa_id', $expenseLines->pluck('chart_of_account_id'));
                })
                ->where('period_id', $transaction->period_id)
                ->where('sub_period_id', $transaction->sub_period_id)
                ->first();

            /*
            |--------------------------------------------------------------------------
            | Update User Balance Akun Pengeluaran -> Dana Akun Pengeluaran kembali
            |--------------------------------------------------------------------------
            */
            if ($expenseUsedBalance) {
                $oldExpenseBalance = [
                    'used_balance' => $expenseUsedBalance->used_balance,
                    'remaining_balance' => $expenseUsedBalance->remaining_balance,
                ];

                $expenseUsedBalance->increment(
                    'used_balance',
                    $transaction->gross_amount
                );

                $expenseUsedBalance->decrement(
                    'remaining_balance',
                    $transaction->gross_amount
                );

                /*
                |--------------------------------------------------------------------------
                | Audit Balance Akun Pengeluaran
                |--------------------------------------------------------------------------
                */

                $this->logger->log(
                    action: 'UPDATE',
                    module: 'USER_ACCOUNT_BALANCE',
                    subject: $expenseUsedBalance,
                    description: 'Membatalkan transaksi mengembalikan saldo akun pengeluaran.',
                    old: $oldExpenseBalance,
                    new: [
                        'used_balance' => $expenseUsedBalance->used_balance,
                        'remaining_balance' => $expenseUsedBalance->remaining_balance,
                    ],
                    additionalData: [
                        'transaction_id' => $transaction->id,
                        'transaction_number' => $transaction->transaction_number,
                    ]
                );
            }

            /*
            |--------------------------------------------------------------------------
            | Update Status to REVERSED
            |--------------------------------------------------------------------------
            */

            $transaction->update([
                'status' => TransactionStatus::REVERSED->value,
            ]);

            /*
            |--------------------------------------------------------------------------
            | Audit Balance
            |--------------------------------------------------------------------------
            */

            $this->logger->log(
                action: 'UPDATE',
                module: 'USER_ACCOUNT_BALANCE',
                subject: $userBalance,
                description: 'Membatalkan transaksi mengembalikan saldo user.',
                old: $oldBalance,
                new: [
                    'used_balance' => $userBalance->used_balance,
                    'remaining_balance' => $userBalance->remaining_balance,
                ],
                additionalData: [
                    'transaction_id' => $transaction->id,
                    'transaction_number' => $transaction->transaction_number,
                ]
            );

            return $transaction->fresh([
                'transactionLines',
            ]);
        });
    }
}
