@props([])

@php
    use \Illuminate\Support\Str;

    $tabs = collect($slot->toHtml())
        ->matchAll('/title="([^"]+)"/')
        ->flatten()
        ->values();
@endphp

<div
    x-data="{
        activeTab: '{{ Str::slug($tabs->first()) }}'
    }"
>

    {{-- Tab Header --}}
    <div class="mb-6 border-b border-gray-200">
        <nav class="-mb-px flex flex-wrap gap-2">

            @foreach ($tabs as $tab)

                <button
                    type="button"
                    @click="activeTab = '{{ Str::slug($tab) }}'"
                    :class="activeTab === '{{ Str::slug($tab) }}'
                        ? 'border-primary-500 text-primary-600'
                        : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'"
                    class="border-b-2 px-4 py-2 text-sm font-medium transition-all"
                >
                    {{ $tab }}
                </button>

            @endforeach

        </nav>
    </div>

    {{-- Tab Content --}}
    {{ $slot }}

</div>