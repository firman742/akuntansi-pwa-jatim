<?php

namespace App\Http\Controllers\Bendahara\Master;

use App\Models\AccountType;
use App\Http\Controllers\Controller;

class AccountTypeController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $accountTypes = AccountType::all();
        return view('pages.menus.bendahara.master.account-types.index', compact('accountTypes'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('pages.menus.bendahara.master.account-types.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store()
    {
        $validated = request()->validate([
            'name' => 'required|string|max:255',
            'description' => 'nullable|string',
            'is_active' => 'required|boolean',
        ]);

        AccountType::create($validated);

        return redirect()->route('bendahara.master.account-types.index')->with('success', 'Account Type created successfully.');
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $accountType = AccountType::findOrFail($id);

        return view('pages.menus.bendahara.master.account-types.edit', compact('accountType'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(string $id)
    {
        $accountType = AccountType::findOrFail($id);

        $validated = request()->validate([
            'name' => 'required|string|max:255',
            'description' => 'nullable|string',
            'is_active' => 'required|boolean',
        ]);

        $accountType->update($validated);

        return redirect()->route('bendahara.master.account-types.index')->with('success', 'Account Type updated successfully.');
    }

    /**
     * Remove the specified resource from storage.
     * TODO: Add check to prevent deletion if Account Type is in use on COA.
     */
    public function destroy(string $id)
    {
        $accountType = AccountType::findOrFail($id);
        $accountType->delete();

        return redirect()->route('bendahara.master.account-types.index')->with('success', 'Account Type deleted successfully.');
    }
}
