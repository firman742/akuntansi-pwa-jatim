<?php

namespace Database\Seeders;

use App\Models\Journal;
use App\Models\Transaction;
use App\Enums\TransactionType;
use App\Models\ChartOfAccount;
use App\Models\TransactionLine;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class TransactionSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::transaction(function () {

            // ===== Ambil COA Penting =====
            $cash    = ChartOfAccount::where('code', 'like', '111%')->first(); // Kas
            $income  = ChartOfAccount::where('code', 'like', '41%')->first();  // Pendapatan
            $expense = ChartOfAccount::where('code', 'like', '51%')->first();  // Beban

            if (!$cash || !$income || !$expense) {
                throw new \Exception('COA Kas / Pendapatan / Beban tidak ditemukan');
            }

            /*
            |--------------------------------------------------------------------------
            | INCOME
            |--------------------------------------------------------------------------
            */
            Transaction::factory()
                ->count(5)
                ->state([
                    'transaction_type' => TransactionType::INCOME,
                    'description'      => 'Penerimaan kas',
                    'status'           => 'POSTED',
                ])
                ->create()
                ->each(function (Transaction $trx) use ($cash, $income) {

                    $amount = fake()->numberBetween(500_000, 5_000_000);

                    // === Transaction Lines ===
                    $trx->transactionLines()->createMany([
                        [
                            'chart_of_account_id' => $cash->id,
                            'description'         => 'Kas masuk',
                            'debit_amount'        => $amount,
                            'credit_amount'       => 0,
                            'line_type'           => 'DEBIT',
                        ],
                        [
                            'chart_of_account_id' => $income->id,
                            'description'         => 'Pendapatan',
                            'debit_amount'        => 0,
                            'credit_amount'       => $amount,
                            'line_type'           => 'CREDIT',
                        ],
                    ]);

                    $trx->update(['total_amount' => $amount]);

                    // === Journal ===
                    $journal = Journal::create([
                        'journal_number' => 'JR-' . now()->format('Ymd') . '-' . strtoupper(fake()->bothify('###')),
                        'journal_date'   => $trx->transaction_date,
                        'description'    => $trx->description,
                        'total_debit'    => $amount,
                        'total_credit'   => $amount,
                        'posted_by'      => $trx->created_by,
                        'posted_at'      => now(),
                        'period_id'      => $trx->period_id,
                        'transaction_id'=> $trx->id,
                    ]);

                    // === Journal Details ===
                    $journal->details()->createMany([
                        [
                            'coa_id'      => $cash->id,
                            'debit'       => $amount,
                            'credit'      => 0,
                            'description' => 'Kas masuk',
                        ],
                        [
                            'coa_id'      => $income->id,
                            'debit'       => 0,
                            'credit'      => $amount,
                            'description' => 'Pendapatan',
                        ],
                    ]);
                });

            /*
            |--------------------------------------------------------------------------
            | EXPENSE
            |--------------------------------------------------------------------------
            */
            Transaction::factory()
                ->count(5)
                ->state([
                    'transaction_type' => TransactionType::EXPENSE,
                    'description'      => 'Pengeluaran kas',
                    'status'           => 'POSTED',
                ])
                ->create()
                ->each(function (Transaction $trx) use ($cash, $expense) {

                    $amount = fake()->numberBetween(200_000, 3_000_000);

                    // === Transaction Lines ===
                    $trx->transactionLines()->createMany([
                        [
                            'chart_of_account_id' => $expense->id,
                            'description'         => 'Beban operasional',
                            'debit_amount'        => $amount,
                            'credit_amount'       => 0,
                            'line_type'           => 'DEBIT',
                        ],
                        [
                            'chart_of_account_id' => $cash->id,
                            'description'         => 'Kas keluar',
                            'debit_amount'        => 0,
                            'credit_amount'       => $amount,
                            'line_type'           => 'CREDIT',
                        ],
                    ]);

                    $trx->update(['total_amount' => $amount]);

                    // === Journal ===
                    $journal = Journal::create([
                        'journal_number' => 'JR-' . now()->format('Ymd') . '-' . strtoupper(fake()->bothify('###')),
                        'journal_date'   => $trx->transaction_date,
                        'description'    => $trx->description,
                        'total_debit'    => $amount,
                        'total_credit'   => $amount,
                        'posted_by'      => $trx->created_by,
                        'posted_at'      => now(),
                        'period_id'      => $trx->period_id,
                        'transaction_id'=> $trx->id,
                    ]);

                    // === Journal Details ===
                    $journal->details()->createMany([
                        [
                            'coa_id'      => $expense->id,
                            'debit'       => $amount,
                            'credit'      => 0,
                            'description' => 'Beban operasional',
                        ],
                        [
                            'coa_id'      => $cash->id,
                            'debit'       => 0,
                            'credit'      => $amount,
                            'description' => 'Kas keluar',
                        ],
                    ]);
                });
        });
    }
}
