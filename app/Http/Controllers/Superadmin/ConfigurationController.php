<?php

namespace App\Http\Controllers\Superadmin;

use App\Http\Controllers\Controller;
use App\Http\Requests\Superadmin\Configurations\UpdateConfigurationRequest;
use App\Models\Configuration;
use App\Services\Superadmin\ConfigurationService;
use Exception;
use Illuminate\Http\RedirectResponse;
use Illuminate\View\View;

class ConfigurationController extends Controller
{
    /**
     * Show the form for editing the specified resource.
     *
     * @return View
     */
    public function edit(): View
    {
        $settings = Configuration::get()->keyBy('key');

        return view('pages.menus.superadmin.configurations.edit', compact('settings'));
    }


    /**
     * Update the specified resource in storage.
     * 
     * @param UpdateConfigurationRequest $request
     * @return RedirectResponse
     * @throws Exception
     */
    public function update(UpdateConfigurationRequest $request, ConfigurationService $service): RedirectResponse
    {
        try {
            $service->update($request->validated());

            return redirect()
                ->route('superadmin.configurations.edit')
                ->with('success', 'Konfigurasi berhasil diperbarui.');
        } catch (Exception $e) {
            return back()
                ->withInput()
                ->withErrors(['error' => 'Terjadi kesalahan saat mengubah pengaturan: ' . $e->getMessage()]);
        }
    }
}
