<?php

namespace Database\Seeders;

use App\Enums\NormalBalanceEnum;
use App\Enums\TransactionType;
use App\Helpers\TransactionNumberHelper;
use App\Models\ChartOfAccount;
use App\Models\Journal;
use App\Models\OpeningBalance;
use App\Models\Period;
use App\Models\Transaction;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class TransactionSeeder extends Seeder
{
    public function run(): void
    {
        DB::transaction(function () {

            $period = Period::active()->firstOrFail();
            $periodCode = $period->start_date->format('Ym');

            /*
            |--------------------------------------------------------------------------
            | Ambil COA utama
            |--------------------------------------------------------------------------
            */
            $cashAccounts = ChartOfAccount::where('code', 'like', '111%')->get();
            $income       = ChartOfAccount::where('code', 'like', '41%')->firstOrFail();
            $expense      = ChartOfAccount::where('code', 'like', '51%')->firstOrFail();

            /*
            |--------------------------------------------------------------------------
            | Pastikan Opening Balance ada
            |--------------------------------------------------------------------------
            */
            foreach ($cashAccounts as $cash) {
                OpeningBalance::firstOrCreate([
                    'chart_of_account_id' => $cash->id,
                    'period_id'           => $period->id,
                ], [
                    'balance_type' => 'DEBIT',
                    'amount'       => fake()->numberBetween(5_000_000, 20_000_000),
                    'created_by'   => 1,
                ]);
            }

            /*
            |--------------------------------------------------------------------------
            | TRANSAKSI PER AKUN KAS (≥10 INCOME & EXPENSE)
            |--------------------------------------------------------------------------
            */
            foreach ($cashAccounts as $cash) {

                // =====================
                // INCOME
                // =====================
                for ($i = 1; $i <= 10; $i++) {

                    $amount = fake()->numberBetween(500_000, 5_000_000);

                    $trx = Transaction::factory()->create([
                        'transaction_type'   => TransactionType::INCOME,
                        'description'        => 'Penerimaan kas',
                        'transaction_number' => TransactionNumberHelper::generate(
                            $cash->code,
                            $periodCode
                        ),
                        'period_id'          => $period->id,
                    ]);

                    $trx->transactionLines()->createMany([
                        [
                            'chart_of_account_id' => $cash->id,
                            'debit_amount'        => $amount,
                            'credit_amount'       => 0,
                            'line_type'           => NormalBalanceEnum::DEBIT->value,
                        ],
                        [
                            'chart_of_account_id' => $income->id,
                            'debit_amount'        => 0,
                            'credit_amount'       => $amount,
                            'line_type'           => NormalBalanceEnum::CREDIT->value,
                        ],
                    ]);

                    $trx->update(['total_amount' => $amount]);

                    $journal = Journal::create([
                        'journal_number' => 'JR-' . $trx->transaction_number,
                        'journal_date'   => $trx->transaction_date,
                        'description'    => $trx->description,
                        'total_debit'    => $amount,
                        'total_credit'   => $amount,
                        'posted_by'      => $trx->created_by,
                        'posted_at'      => now(),
                        'period_id'      => $period->id,
                        'transaction_id'=> $trx->id,
                    ]);

                    $journal->details()->createMany([
                        [
                            'coa_id' => $cash->id,
                            'debit'  => $amount,
                            'credit' => 0,
                        ],
                        [
                            'coa_id' => $income->id,
                            'debit'  => 0,
                            'credit' => $amount,
                        ],
                    ]);
                }

                // =====================
                // EXPENSE
                // =====================
                for ($i = 1; $i <= 10; $i++) {

                    $amount = fake()->numberBetween(200_000, 3_000_000);

                    $trx = Transaction::factory()->create([
                        'transaction_type'   => TransactionType::EXPENSE,
                        'description'        => 'Pengeluaran kas',
                        'transaction_number' => TransactionNumberHelper::generate(
                            $cash->code,
                            $periodCode
                        ),
                        'period_id'          => $period->id,
                    ]);

                    $trx->transactionLines()->createMany([
                        [
                            'chart_of_account_id' => $expense->id,
                            'debit_amount'        => $amount,
                            'credit_amount'       => 0,
                            'line_type'           => NormalBalanceEnum::DEBIT->value,
                        ],
                        [
                            'chart_of_account_id' => $cash->id,
                            'debit_amount'        => 0,
                            'credit_amount'       => $amount,
                            'line_type'           => NormalBalanceEnum::CREDIT->value,
                        ],
                    ]);

                    $trx->update(['total_amount' => $amount]);

                    $journal = Journal::create([
                        'journal_number' => 'JR-' . $trx->transaction_number,
                        'journal_date'   => $trx->transaction_date,
                        'description'    => $trx->description,
                        'total_debit'    => $amount,
                        'total_credit'   => $amount,
                        'posted_by'      => $trx->created_by,
                        'posted_at'      => now(),
                        'period_id'      => $period->id,
                        'transaction_id'=> $trx->id,
                    ]);

                    $journal->details()->createMany([
                        [
                            'coa_id' => $expense->id,
                            'debit'  => $amount,
                            'credit' => 0,
                        ],
                        [
                            'coa_id' => $cash->id,
                            'debit'  => 0,
                            'credit' => $amount,
                        ],
                    ]);
                }
            }
        });
    }
    
}
