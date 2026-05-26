@extends('layouts.app')

@section('title', 'Daftar COA Saya')

@section('content')
    <x-common.page-breadcrumb pageTitle="Daftar COA Saya" />

    @php
        $debitCoas = $coas->where('normal_balance', 'DEBIT');
        $creditCoas = $coas->where('normal_balance', 'CREDIT');
    @endphp

    <div class="space-y-6">

        {{-- Header --}}
        <div class="bg-white rounded-2xl border border-gray-200 p-6 shadow-sm">
            <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-4">

                <div>
                    <h1 class="text-2xl font-bold text-gray-800">
                        Daftar COA Saya
                    </h1>

                    <p class="text-sm text-gray-500 mt-1">
                        Daftar akun COA yang dapat diakses oleh pengguna.
                    </p>
                </div>

                <div class="flex gap-3">

                    <div class="bg-green-50 border border-green-100 rounded-xl px-5 py-4 min-w-[120px]">
                        <div class="text-xs font-semibold uppercase text-green-600">
                            Debit
                        </div>

                        <div class="text-2xl font-bold text-green-700 mt-1">
                            {{ $debitCoas->count() }}
                        </div>
                    </div>

                    <div class="bg-red-50 border border-red-100 rounded-xl px-5 py-4 min-w-[120px]">
                        <div class="text-xs font-semibold uppercase text-red-600">
                            Credit
                        </div>

                        <div class="text-2xl font-bold text-red-700 mt-1">
                            {{ $creditCoas->count() }}
                        </div>
                    </div>

                </div>

            </div>
        </div>

        <div class="grid grid-cols-1 gap-4 md:grid-cols-2 xl:grid-cols-2">
            {{-- DEBIT --}}
            <div class="bg-white rounded-2xl border border-green-200 shadow-sm overflow-hidden">

                <div class="px-4 py-4 border-b border-green-100 bg-green-50">
                    <div class="flex items-center justify-between">
                        <div>
                            <h2 class="text-lg font-bold text-green-700">
                                COA Normal Balance Debit
                            </h2>

                            <p class="text-sm text-green-600 mt-1">
                                Akun dengan posisi saldo normal debit.
                            </p>
                        </div>

                        <div
                            class="bg-white text-green-700 border border-green-200 px-4 py-2 rounded-xl text-sm font-semibold">
                            {{ $debitCoas->count() }} COA
                        </div>
                    </div>
                </div>

                @if ($debitCoas->isEmpty())
                    <div class="p-10 text-center text-gray-500">
                        Tidak ada COA debit.
                    </div>
                @else
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th class="px-4 py-4 text-left text-xs font-semibold text-gray-500 uppercase">
                                        Kode
                                    </th>

                                    <th class="px-4 py-4 text-left text-xs font-semibold text-gray-500 uppercase">
                                        Nama COA
                                    </th>

                                    <th class="px-4 py-4 text-left text-xs font-semibold text-gray-500 uppercase">
                                        Parent
                                    </th>

                                    <th class="px-4 py-4 text-left text-xs font-semibold text-gray-500 uppercase">
                                        Level
                                    </th>

                                    <th class="px-4 py-4 text-left text-xs font-semibold text-gray-500 uppercase">
                                        Status
                                    </th>
                                </tr>
                            </thead>

                            <tbody class="divide-y divide-gray-100">
                                @foreach ($debitCoas as $coa)
                                    <tr class="hover:bg-green-50/40 transition">
                                        <td class="px-4 py-4 font-semibold text-gray-800">
                                            {{ $coa->code }}
                                        </td>

                                        <td class="px-4 py-4">
                                            <div>
                                                <div class="font-medium text-gray-800">
                                                    {{ $coa->name }}
                                                </div>

                                                @if ($coa->description)
                                                    <div class="text-sm text-gray-500 mt-1">
                                                        {{ $coa->description }}
                                                    </div>
                                                @endif
                                            </div>
                                        </td>

                                        <td class="px-4 py-4">
                                            @if ($coa->parent)
                                                <div>
                                                    <div class="font-medium text-gray-700">
                                                        {{ $coa->parent->code }}
                                                    </div>

                                                    <div class="text-sm text-gray-500">
                                                        {{ $coa->parent->name }}
                                                    </div>
                                                </div>
                                            @else
                                                <span class="text-gray-400 text-sm">
                                                    -
                                                </span>
                                            @endif
                                        </td>

                                        <td class="px-4 py-4">
                                            <span
                                                class="px-2 py-1 rounded-full bg-blue-100 text-blue-700 text-xs font-semibold">
                                                Level {{ $coa->level }}
                                            </span>
                                        </td>

                                        <td class="px-4 py-4">
                                            @if ($coa->is_active)
                                                <span
                                                    class="px-3 py-1 rounded-full bg-green-100 text-green-700 text-xs font-semibold">
                                                    Aktif
                                                </span>
                                            @else
                                                <span
                                                    class="px-3 py-1 rounded-full bg-red-100 text-red-700 text-xs font-semibold">
                                                    Nonaktif
                                                </span>
                                            @endif
                                        </td>
                                    </tr>
                                @endforeach
                            </tbody>

                        </table>
                    </div>
                @endif
            </div>

            {{-- CREDIT --}}
            <div class="bg-white rounded-2xl border border-red-200 shadow-sm overflow-hidden">

                <div class="px-4 py-4 border-b border-red-100 bg-red-50">
                    <div class="flex items-center justify-between">
                        <div>
                            <h2 class="text-lg font-bold text-red-700">
                                COA Normal Balance Credit
                            </h2>

                            <p class="text-sm text-red-600 mt-1">
                                Akun dengan posisi saldo normal credit.
                            </p>
                        </div>

                        <div
                            class="bg-white text-red-700 border border-red-200 px-4 py-2 rounded-xl text-sm font-semibold">
                            {{ $creditCoas->count() }} COA
                        </div>
                    </div>
                </div>

                @if ($creditCoas->isEmpty())
                    <div class="p-10 text-center text-gray-500">
                        Tidak ada COA credit.
                    </div>
                @else
                    <div class="overflow-x-auto">
                        <table class="w-full min-w-[900px]">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th class="px-4 py-4 text-left text-xs font-semibold text-gray-500 uppercase">
                                        Kode
                                    </th>

                                    <th class="px-4 py-4 text-left text-xs font-semibold text-gray-500 uppercase">
                                        Nama COA
                                    </th>

                                    <th class="px-4 py-4 text-left text-xs font-semibold text-gray-500 uppercase">
                                        Parent
                                    </th>

                                    <th class="px-4 py-4 text-left text-xs font-semibold text-gray-500 uppercase">
                                        Level
                                    </th>

                                    <th class="px-4 py-4 text-left text-xs font-semibold text-gray-500 uppercase">
                                        Status
                                    </th>
                                </tr>
                            </thead>

                            <tbody class="divide-y divide-gray-100">
                                @foreach ($creditCoas as $coa)
                                    <tr class="hover:bg-red-50/40 transition">
                                        <td class="px-4 py-4 font-semibold text-gray-800">
                                            {{ $coa->code }}
                                        </td>

                                        <td class="px-4 py-4">
                                            <div>
                                                <div class="font-medium text-gray-800">
                                                    {{ $coa->name }}
                                                </div>

                                                @if ($coa->description)
                                                    <div class="text-sm text-gray-500 mt-1">
                                                        {{ $coa->description }}
                                                    </div>
                                                @endif
                                            </div>
                                        </td>

                                        <td class="px-4 py-4">
                                            @if ($coa->parent)
                                                <div>
                                                    <div class="font-medium text-gray-700">
                                                        {{ $coa->parent->code }}
                                                    </div>

                                                    <div class="text-sm text-gray-500">
                                                        {{ $coa->parent->name }}
                                                    </div>
                                                </div>
                                            @else
                                                <span class="text-gray-400 text-sm">
                                                    -
                                                </span>
                                            @endif
                                        </td>

                                        <td class="px-4 py-4">
                                            <span
                                                class="px-2 py-1 rounded-full bg-blue-100 text-blue-700 text-xs font-semibold">
                                                Level {{ $coa->level }}
                                            </span>
                                        </td>

                                        <td class="px-4 py-4">
                                            @if ($coa->is_active)
                                                <span
                                                    class="px-3 py-1 rounded-full bg-green-100 text-green-700 text-xs font-semibold">
                                                    Aktif
                                                </span>
                                            @else
                                                <span
                                                    class="px-3 py-1 rounded-full bg-red-100 text-red-700 text-xs font-semibold">
                                                    Nonaktif
                                                </span>
                                            @endif
                                        </td>
                                    </tr>
                                @endforeach
                            </tbody>

                        </table>
                    </div>
                @endif
            </div>
        </div>

    </div>
@endsection
