<?php

namespace App\Console\Commands;

use App\Models\SubPeriod;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class AutoActivateSubPeriod extends Command
{
    protected $signature = 'subperiod:auto-activate';
    protected $description = 'Auto activate sub period based on current date';

    public function handle()
    {
        DB::transaction(function () {

            $today = now();

            $subPeriod = SubPeriod::whereDate('start_date', '<=', $today)
                ->whereDate('end_date', '>=', $today)
                ->orderBy('start_date')
                ->first();

            if (!$subPeriod) {
                Log::warning('No subperiod matched today');
                return;
            }

            // 🔥 penting: skip kalau sudah aktif
            if ($subPeriod->is_active) {
                return;
            }

            SubPeriod::where('period_id', $subPeriod->period_id)
                ->update(['is_active' => false]);

            $subPeriod->update(['is_active' => true]);

            Log::info("Activated SubPeriod: {$subPeriod->name}");
        });

        return Command::SUCCESS;
    }
}
