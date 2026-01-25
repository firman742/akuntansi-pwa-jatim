<?php

namespace App\Http\Controllers\Bendahara\Master;

use App\Models\Period;
use App\Models\AccountType;
use Illuminate\Http\Request;
use App\Models\ChartOfAccount;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use App\Http\Requests\StorePeriodRequest;
use App\Http\Requests\UpdatePeriodRequest;

class COAController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $chartOfAccounts = ChartOfAccount::with(['accountType', 'creator', 'parent'])
            ->orderBy('code')
            ->get();

        return view('pages.menus.bendahara.master.coa.index', compact('chartOfAccounts'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $accountTypes = AccountType::orderBy('name')->get();

        $parents = ChartOfAccount::orderBy('code')->get();

        return view('pages.menus.bendahara.master.coa.create', compact(
            'accountTypes',
            'parents'
        ));
    }

    public function generateCode(?string $parentId = null): array
    {
        if ($parentId) {
            // Parent ada → level > 1
            $parent = ChartOfAccount::findOrFail($parentId);
            $level = $parent->level + 1;

            // Ambil semua child parent
            $children = ChartOfAccount::where('parent_id', $parent->id)
                ->orderBy('code')
                ->get();

            // Tentukan posisi digit sesuai level (level 2 → index 2, dsb)
            $codeStr = str_pad($parent->code, 5, '0', STR_PAD_LEFT);
            $codeArr = str_split($codeStr);
            $position = min($level + 1, 5) - 1; // index 0-based

            if ($children->isEmpty()) {
                // Belum ada child → set digit level ke 1
                $codeArr[$position] = '1';
            } else {
                $lastChild = $children->last();
                $grandChildren = ChartOfAccount::where('parent_id', $lastChild->id)
                    ->orderBy('code')
                    ->get();

                if ($grandChildren->isNotEmpty()) {
                    // Rekursif ke child terakhir
                    return $this->generateCode($lastChild->id);
                }

                // Last child tidak punya anak → increment digit
                $lastCodeArr = str_split(str_pad($lastChild->code, 5, '0', STR_PAD_LEFT));
                $currentDigit = (int)$lastCodeArr[$position];
                $codeArr[$position] = (string)($currentDigit + 1);
            }

            $code = implode('', $codeArr);
            $order = $children->max('order') ? $children->max('order') + 1 : 1;
        } else {
            // Root (parent_id null / level 1)
            $level = 1;

            $children = ChartOfAccount::whereNull('parent_id')
                ->orderBy('code')
                ->get();

            if ($children->isEmpty()) {
                $code = '10000';
                $order = 1;
            } else {
                $lastRoot = $children->last();
                $lastCode = str_pad($lastRoot->code, 5, '0', STR_PAD_LEFT);
                $firstDigit = (int)substr($lastCode, 0, 1) + 1;

                $code = $firstDigit . '0000'; // level 1 root baru
                $order = $lastRoot->order + 1;
            }
        }

        return [
            'code'  => $code,
            'level' => $level,
            'order' => $order,
        ];
    }


    /**
     * Generate kode COA otomatis untuk frontend (JSON)
     */
    public function generateCodeApi(Request $request)
    {
        $parentId = $request->query('parent_id'); // ambil dari query ?parent_id=

        $result = $this->generateCode($parentId);

        return response()->json([
            'code' => $result['code'],
            'level' => $result['level'],
            'order' => $result['order'],
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'account_type_id' => 'required|exists:account_types,id',
            'parent_id' => 'nullable|exists:chart_of_accounts,id',
            'description' => 'nullable|string',
            'is_active' => 'boolean',
            'normal_balance' => 'required|in:debit,credit',
        ]);

        // Gunakan generateCode untuk otomatis kode, level, dan order
        $result = $this->generateCode($validated['parent_id'] ?? null);

        ChartOfAccount::create([
            'code' => $result['code'],
            'name' => $validated['name'],
            'account_type_id' => $validated['account_type_id'],
            'parent_id' => $validated['parent_id'] ?? null,
            'level' => $result['level'],
            'order' => $result['order'],
            'normal_balance' => $validated['normal_balance'],
            'description' => $validated['description'] ?? null,
            'is_active' => $validated['is_active'] ?? true,
            'created_by' => Auth::id(),
        ]);

        return redirect()->route('bendahara.master.coa.index')
            ->with('success', 'Akun COA berhasil dibuat dengan kode: ' . $result['code']);
    }


    /**
     * Display the specified resource.
     */
    public function show(Period $period)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Period $period)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdatePeriodRequest $request, Period $period)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Period $period)
    {
        //
    }
}
