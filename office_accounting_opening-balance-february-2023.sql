-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 03 Nov 2026 pada 14.42
-- Versi server: 10.6.28-MariaDB-cll-lve-log
-- Versi PHP: 8.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Basis data: `enginee4_accounting`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `account_topups`
--

CREATE TABLE `account_topups` (
  `id` char(36) NOT NULL,
  `chart_of_account_id` char(36) NOT NULL,
  `period_id` char(36) NOT NULL,
  `sub_period_id` char(36) NOT NULL,
  `created_by` char(36) NOT NULL,
  `amount` double NOT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `account_types`
--

CREATE TABLE `account_types` (
  `id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `account_types`
--

INSERT INTO `account_types` (`id`, `name`, `description`, `is_active`, `created_at`, `updated_at`) VALUES
('a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'ASET', 'Sumber daya ekonomi yang dimiliki perusahaan (kas, piutang, persediaan, tanah, gedung).', 1, '2026-10-26 10:07:21', '2026-10-26 10:07:21'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567891', 'KEWAJIBAN', 'Kewajiban atau hutang perusahaan kepada pihak lain (utang usaha, utang bank, obligasi).', 1, '2026-10-26 10:07:21', '2026-10-26 10:07:21'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567892', 'EKUITAS', 'Kepemilikan pemilik dalam perusahaan setelah dikurangi kewajiban (modal saham, laba ditahan).', 1, '2026-10-26 10:07:21', '2026-10-26 10:07:21'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567893', 'PENDAPATAN', 'account type representing the inflow of economic benefits from business activities.', 1, '2026-10-26 10:07:21', '2026-10-26 10:07:21'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567894', 'BEBAN', 'account type representing the outflow of economic benefits incurred in the process of generating revenue.', 1, '2026-10-26 10:07:21', '2026-10-26 10:07:21');

-- --------------------------------------------------------

--
-- Struktur dari tabel `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` char(36) NOT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `action` varchar(255) NOT NULL,
  `module` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `subject_type` varchar(255) DEFAULT NULL,
  `subject_id` char(36) DEFAULT NULL,
  `old_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_values`)),
  `new_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_values`)),
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `additional_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`additional_data`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `activity_logs`
--

INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `module`, `description`, `subject_type`, `subject_id`, `old_values`, `new_values`, `ip_address`, `user_agent`, `additional_data`, `created_at`, `updated_at`) VALUES
('01a17936-5e3a-726b-9e58-866e8a816774', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas (11100) pada sub periode Desember 2022 dengan jumlah 194,604,157.00', 'App\\Models\\OpeningBalance', '01a17936-5e27-7270-841d-ab31f298ee81', '[]', '{\"chart_of_account_id\":\"64bf8847-e02b-4b2b-a547-e10b8a4d5cb7\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"sub_period_id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"balance_type\":\"DEBIT\",\"amount\":194604157,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a17936-5e27-7270-841d-ab31f298ee81\",\"updated_at\":\"2026-10-26T17:16:08.000000Z\",\"created_at\":\"2026-10-26T17:16:08.000000Z\",\"chart_of_account\":{\"id\":\"64bf8847-e02b-4b2b-a547-e10b8a4d5cb7\",\"code\":\"11100\",\"name\":\"Kas\",\"parent_id\":\"98507351-f369-4453-b27c-000a2aa83ae7\",\"level\":\"2\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\"}}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"64bf8847-e02b-4b2b-a547-e10b8a4d5cb7\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"sub_period_id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"opening_balance\":194604157,\"debit_total\":0,\"credit_total\":0,\"current_balance\":194604157,\"last_transaction_at\":\"2026-10-26T17:16:08.000000Z\",\"id\":\"01a17936-5e31-707f-963c-90d0c2d5f81c\",\"updated_at\":\"2026-10-26T17:16:08.000000Z\",\"created_at\":\"2026-10-26T17:16:08.000000Z\"}}', '2026-10-26 10:16:08', '2026-10-26 10:16:08'),
('01a17936-cb55-70ab-a384-5b0a469e7674', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas Ditangan (11110) pada sub periode Desember 2022 dengan jumlah 4,983,047.00', 'App\\Models\\OpeningBalance', '01a17936-cb3c-70d3-a646-dac580bf314d', '[]', '{\"chart_of_account_id\":\"ad67895d-ef05-4fd3-965c-d793289a3c60\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"sub_period_id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"balance_type\":\"DEBIT\",\"amount\":4983047,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a17936-cb3c-70d3-a646-dac580bf314d\",\"updated_at\":\"2026-10-26T17:16:36.000000Z\",\"created_at\":\"2026-10-26T17:16:36.000000Z\",\"chart_of_account\":{\"id\":\"ad67895d-ef05-4fd3-965c-d793289a3c60\",\"code\":\"11110\",\"name\":\"Kas Ditangan\",\"parent_id\":\"64bf8847-e02b-4b2b-a547-e10b8a4d5cb7\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\"}}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"ad67895d-ef05-4fd3-965c-d793289a3c60\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"sub_period_id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"opening_balance\":4983047,\"debit_total\":0,\"credit_total\":0,\"current_balance\":4983047,\"last_transaction_at\":\"2026-10-26T17:16:36.000000Z\",\"id\":\"01a17936-cb43-72ac-b852-5df6d3c94890\",\"updated_at\":\"2026-10-26T17:16:36.000000Z\",\"created_at\":\"2026-10-26T17:16:36.000000Z\"}}', '2026-10-26 10:16:36', '2026-10-26 10:16:36'),
('01a17937-39a6-714d-9888-690694745719', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas di Bank Jatim (11120) pada sub periode Desember 2022 dengan jumlah 385,384,747.00', 'App\\Models\\OpeningBalance', '01a17937-3997-72a2-8701-913e7588d774', '[]', '{\"chart_of_account_id\":\"3bedac29-10e0-4a32-9e4a-f546f7a801e6\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"sub_period_id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"balance_type\":\"DEBIT\",\"amount\":385384747,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a17937-3997-72a2-8701-913e7588d774\",\"updated_at\":\"2026-10-26T17:17:04.000000Z\",\"created_at\":\"2026-10-26T17:17:04.000000Z\",\"chart_of_account\":{\"id\":\"3bedac29-10e0-4a32-9e4a-f546f7a801e6\",\"code\":\"11120\",\"name\":\"Kas di Bank Jatim\",\"parent_id\":\"64bf8847-e02b-4b2b-a547-e10b8a4d5cb7\",\"level\":\"3\",\"order\":\"2\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\"}}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"3bedac29-10e0-4a32-9e4a-f546f7a801e6\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"sub_period_id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"opening_balance\":385384747,\"debit_total\":0,\"credit_total\":0,\"current_balance\":385384747,\"last_transaction_at\":\"2026-10-26T17:17:04.000000Z\",\"id\":\"01a17937-399e-726a-be0f-8bdbfc5dff59\",\"updated_at\":\"2026-10-26T17:17:04.000000Z\",\"created_at\":\"2026-10-26T17:17:04.000000Z\"}}', '2026-10-26 10:17:04', '2026-10-26 10:17:04'),
('01a17937-a0c3-730d-afaa-3c7dbbe530a1', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas di Bank Jatim Dr. Soetomo (11130) pada sub periode Desember 2022 dengan jumlah 1,156,982,563.00', 'App\\Models\\OpeningBalance', '01a17937-a0b4-7048-a006-f7323d326418', '[]', '{\"chart_of_account_id\":\"b8e89210-2ad3-44b5-b835-c66c8f8d2f0c\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"sub_period_id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"balance_type\":\"DEBIT\",\"amount\":1156982563,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a17937-a0b4-7048-a006-f7323d326418\",\"updated_at\":\"2026-10-26T17:17:31.000000Z\",\"created_at\":\"2026-10-26T17:17:31.000000Z\",\"chart_of_account\":{\"id\":\"b8e89210-2ad3-44b5-b835-c66c8f8d2f0c\",\"code\":\"11130\",\"name\":\"Kas di Bank Jatim Dr. Soetomo\",\"parent_id\":\"64bf8847-e02b-4b2b-a547-e10b8a4d5cb7\",\"level\":\"3\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\"}}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"b8e89210-2ad3-44b5-b835-c66c8f8d2f0c\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"sub_period_id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"opening_balance\":1156982563,\"debit_total\":0,\"credit_total\":0,\"current_balance\":1156982563,\"last_transaction_at\":\"2026-10-26T17:17:31.000000Z\",\"id\":\"01a17937-a0ba-706b-9e65-f936282e5bf0\",\"updated_at\":\"2026-10-26T17:17:31.000000Z\",\"created_at\":\"2026-10-26T17:17:31.000000Z\"}}', '2026-10-26 10:17:31', '2026-10-26 10:17:31'),
('01a17937-fc7d-720f-9f51-31e8994ad62a', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas di Bank Bukopin Syariah (11140) pada sub periode Desember 2022 dengan jumlah 377,940,865.00', 'App\\Models\\OpeningBalance', '01a17937-fc6f-72c9-b352-7f0dd5de7c3a', '[]', '{\"chart_of_account_id\":\"dc604ee1-502c-456b-8b3d-006762ecedf2\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"sub_period_id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"balance_type\":\"DEBIT\",\"amount\":377940865,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a17937-fc6f-72c9-b352-7f0dd5de7c3a\",\"updated_at\":\"2026-10-26T17:17:54.000000Z\",\"created_at\":\"2026-10-26T17:17:54.000000Z\",\"chart_of_account\":{\"id\":\"dc604ee1-502c-456b-8b3d-006762ecedf2\",\"code\":\"11140\",\"name\":\"Kas di Bank Bukopin Syariah\",\"parent_id\":\"64bf8847-e02b-4b2b-a547-e10b8a4d5cb7\",\"level\":\"3\",\"order\":\"4\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\"}}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"dc604ee1-502c-456b-8b3d-006762ecedf2\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"sub_period_id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"opening_balance\":377940865,\"debit_total\":0,\"credit_total\":0,\"current_balance\":377940865,\"last_transaction_at\":\"2026-10-26T17:17:54.000000Z\",\"id\":\"01a17937-fc75-7223-b441-ca0537d86b85\",\"updated_at\":\"2026-10-26T17:17:54.000000Z\",\"created_at\":\"2026-10-26T17:17:54.000000Z\"}}', '2026-10-26 10:17:54', '2026-10-26 10:17:54'),
('01a17938-4bd6-726e-b12d-bdc66bf97308', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Piutang Karyawan (11300) pada sub periode Desember 2022 dengan jumlah 1,800,000.00', 'App\\Models\\OpeningBalance', '01a17938-4bbc-73d4-ad10-58b13ac2e51b', '[]', '{\"chart_of_account_id\":\"f0b2f862-b909-4d51-aab8-35aa1a569506\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"sub_period_id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"balance_type\":\"DEBIT\",\"amount\":1800000,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a17938-4bbc-73d4-ad10-58b13ac2e51b\",\"updated_at\":\"2026-10-26T17:18:14.000000Z\",\"created_at\":\"2026-10-26T17:18:14.000000Z\",\"chart_of_account\":{\"id\":\"f0b2f862-b909-4d51-aab8-35aa1a569506\",\"code\":\"11300\",\"name\":\"Piutang Karyawan\",\"parent_id\":\"98507351-f369-4453-b27c-000a2aa83ae7\",\"level\":\"2\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\"}}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"f0b2f862-b909-4d51-aab8-35aa1a569506\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"sub_period_id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"opening_balance\":1800000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":1800000,\"last_transaction_at\":\"2026-10-26T17:18:14.000000Z\",\"id\":\"01a17938-4bc1-7062-afbd-06b4f6864022\",\"updated_at\":\"2026-10-26T17:18:14.000000Z\",\"created_at\":\"2026-10-26T17:18:14.000000Z\"}}', '2026-10-26 10:18:14', '2026-10-26 10:18:14'),
('01a17939-0be8-73ec-99fa-ebcc08bbbb94', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Penyertaan Modal Bueka Assakinah (11500) pada sub periode Desember 2022 dengan jumlah 245,583,300.00', 'App\\Models\\OpeningBalance', '01a17939-0bd0-7396-9851-5ffa05053d16', '[]', '{\"chart_of_account_id\":\"bd645eab-8d27-47ca-9e1e-eac912720710\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"sub_period_id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"balance_type\":\"DEBIT\",\"amount\":245583300,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a17939-0bd0-7396-9851-5ffa05053d16\",\"updated_at\":\"2026-10-26T17:19:04.000000Z\",\"created_at\":\"2026-10-26T17:19:04.000000Z\",\"chart_of_account\":{\"id\":\"bd645eab-8d27-47ca-9e1e-eac912720710\",\"code\":\"11500\",\"name\":\"Penyertaan Modal Bueka Assakinah\",\"parent_id\":\"98507351-f369-4453-b27c-000a2aa83ae7\",\"level\":\"2\",\"order\":\"5\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\"}}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"bd645eab-8d27-47ca-9e1e-eac912720710\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"sub_period_id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"opening_balance\":245583300,\"debit_total\":0,\"credit_total\":0,\"current_balance\":245583300,\"last_transaction_at\":\"2026-10-26T17:19:04.000000Z\",\"id\":\"01a17939-0bdb-7222-b966-5c40725561ea\",\"updated_at\":\"2026-10-26T17:19:04.000000Z\",\"created_at\":\"2026-10-26T17:19:04.000000Z\"}}', '2026-10-26 10:19:04', '2026-10-26 10:19:04'),
('01a17939-99c9-73fa-a156-31b2caff8a7f', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kos Wonorejo (11700) pada sub periode Desember 2022 dengan jumlah 676,151,976.00', 'App\\Models\\OpeningBalance', '01a17939-99b3-7055-8541-ca726ac615d1', '[]', '{\"chart_of_account_id\":\"943a3993-3c67-42b4-9fd3-969319245e31\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"sub_period_id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"balance_type\":\"DEBIT\",\"amount\":676151976,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a17939-99b3-7055-8541-ca726ac615d1\",\"updated_at\":\"2026-10-26T17:19:40.000000Z\",\"created_at\":\"2026-10-26T17:19:40.000000Z\",\"chart_of_account\":{\"id\":\"943a3993-3c67-42b4-9fd3-969319245e31\",\"code\":\"11700\",\"name\":\"Kos Wonorejo\",\"parent_id\":\"98507351-f369-4453-b27c-000a2aa83ae7\",\"level\":\"2\",\"order\":\"7\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\"}}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"943a3993-3c67-42b4-9fd3-969319245e31\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"sub_period_id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"opening_balance\":676151976,\"debit_total\":0,\"credit_total\":0,\"current_balance\":676151976,\"last_transaction_at\":\"2026-10-26T17:19:40.000000Z\",\"id\":\"01a17939-99ba-736a-b551-32ea8590f579\",\"updated_at\":\"2026-10-26T17:19:40.000000Z\",\"created_at\":\"2026-10-26T17:19:40.000000Z\"}}', '2026-10-26 10:19:40', '2026-10-26 10:19:40'),
('01a1793a-22be-73cd-b39f-e51fad0f430f', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kendaraan (12300) pada sub periode Desember 2022 dengan jumlah 460,769,432.00', 'App\\Models\\OpeningBalance', '01a1793a-22b1-710f-b4bb-29a536f87032', '[]', '{\"chart_of_account_id\":\"58045d05-2f17-4bdc-89cf-9e51f72eec73\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"sub_period_id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"balance_type\":\"DEBIT\",\"amount\":460769432,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a1793a-22b1-710f-b4bb-29a536f87032\",\"updated_at\":\"2026-10-26T17:20:15.000000Z\",\"created_at\":\"2026-10-26T17:20:15.000000Z\",\"chart_of_account\":{\"id\":\"58045d05-2f17-4bdc-89cf-9e51f72eec73\",\"code\":\"12300\",\"name\":\"Kendaraan\",\"parent_id\":\"1980f7f4-9342-454b-b2ad-7546f8a9cef1\",\"level\":\"2\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\"}}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"58045d05-2f17-4bdc-89cf-9e51f72eec73\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"sub_period_id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"opening_balance\":460769432,\"debit_total\":0,\"credit_total\":0,\"current_balance\":460769432,\"last_transaction_at\":\"2026-10-26T17:20:15.000000Z\",\"id\":\"01a1793a-22b6-7291-a8c3-3e7143402795\",\"updated_at\":\"2026-10-26T17:20:15.000000Z\",\"created_at\":\"2026-10-26T17:20:15.000000Z\"}}', '2026-10-26 10:20:15', '2026-10-26 10:20:15'),
('01a1793a-8489-7279-9773-38515ba4b009', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Akumulasi Depresiasi Kendaraan (12310) pada sub periode Desember 2022 dengan jumlah 144,000,000.00', 'App\\Models\\OpeningBalance', '01a1793a-847c-7190-abfb-65d83a4dd692', '[]', '{\"chart_of_account_id\":\"20e39474-a65a-4ca5-b57d-890040ebf0de\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"sub_period_id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"balance_type\":\"CREDIT\",\"amount\":144000000,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a1793a-847c-7190-abfb-65d83a4dd692\",\"updated_at\":\"2026-10-26T17:20:40.000000Z\",\"created_at\":\"2026-10-26T17:20:40.000000Z\",\"chart_of_account\":{\"id\":\"20e39474-a65a-4ca5-b57d-890040ebf0de\",\"code\":\"12310\",\"name\":\"Akumulasi Depresiasi Kendaraan\",\"parent_id\":\"58045d05-2f17-4bdc-89cf-9e51f72eec73\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\"}}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"20e39474-a65a-4ca5-b57d-890040ebf0de\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"sub_period_id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"opening_balance\":144000000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":144000000,\"last_transaction_at\":\"2026-10-26T17:20:40.000000Z\",\"id\":\"01a1793a-8482-728d-b637-e2c0c616804f\",\"updated_at\":\"2026-10-26T17:20:40.000000Z\",\"created_at\":\"2026-10-26T17:20:40.000000Z\"}}', '2026-10-26 10:20:40', '2026-10-26 10:20:40'),
('01a1793a-d440-712f-9949-dc8283a8b541', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Meubel (12400) pada sub periode Desember 2022 dengan jumlah 15,500,000.00', 'App\\Models\\OpeningBalance', '01a1793a-d41f-72a4-8567-0c7c2d0b85bf', '[]', '{\"chart_of_account_id\":\"5542cf94-e5bd-46af-b6b3-54952a6d4da0\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"sub_period_id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"balance_type\":\"DEBIT\",\"amount\":15500000,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a1793a-d41f-72a4-8567-0c7c2d0b85bf\",\"updated_at\":\"2026-10-26T17:21:00.000000Z\",\"created_at\":\"2026-10-26T17:21:00.000000Z\",\"chart_of_account\":{\"id\":\"5542cf94-e5bd-46af-b6b3-54952a6d4da0\",\"code\":\"12400\",\"name\":\"Meubel\",\"parent_id\":\"1980f7f4-9342-454b-b2ad-7546f8a9cef1\",\"level\":\"2\",\"order\":\"4\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\"}}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"5542cf94-e5bd-46af-b6b3-54952a6d4da0\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"sub_period_id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"opening_balance\":15500000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":15500000,\"last_transaction_at\":\"2026-10-26T17:21:00.000000Z\",\"id\":\"01a1793a-d428-71af-ae90-d3db81704ce4\",\"updated_at\":\"2026-10-26T17:21:00.000000Z\",\"created_at\":\"2026-10-26T17:21:00.000000Z\"}}', '2026-10-26 10:21:00', '2026-10-26 10:21:00'),
('01a1793b-99c4-720c-84d7-dfb425440028', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Akumulasi Depresiasi Meubel (12410) pada sub periode Desember 2022 dengan jumlah 13,376,668.00', 'App\\Models\\OpeningBalance', '01a1793b-99b6-739a-80c3-8eb393ce5e1f', '[]', '{\"chart_of_account_id\":\"53402b88-500b-4d58-a421-dc0370942f23\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"sub_period_id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"balance_type\":\"CREDIT\",\"amount\":13376668,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a1793b-99b6-739a-80c3-8eb393ce5e1f\",\"updated_at\":\"2026-10-26T17:21:51.000000Z\",\"created_at\":\"2026-10-26T17:21:51.000000Z\",\"chart_of_account\":{\"id\":\"53402b88-500b-4d58-a421-dc0370942f23\",\"code\":\"12410\",\"name\":\"Akumulasi Depresiasi Meubel\",\"parent_id\":\"5542cf94-e5bd-46af-b6b3-54952a6d4da0\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\"}}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"53402b88-500b-4d58-a421-dc0370942f23\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"sub_period_id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"opening_balance\":13376668,\"debit_total\":0,\"credit_total\":0,\"current_balance\":13376668,\"last_transaction_at\":\"2026-10-26T17:21:51.000000Z\",\"id\":\"01a1793b-99bc-7169-9e73-2c448ef723e0\",\"updated_at\":\"2026-10-26T17:21:51.000000Z\",\"created_at\":\"2026-10-26T17:21:51.000000Z\"}}', '2026-10-26 10:21:51', '2026-10-26 10:21:51'),
('01a1793b-ff7a-726d-9b3b-370832fd6156', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Peralatan Kantor (12500) pada sub periode Desember 2022 dengan jumlah 46,059,000.00', 'App\\Models\\OpeningBalance', '01a1793b-ff6b-70de-b597-3ea4fff23f91', '[]', '{\"chart_of_account_id\":\"010f231d-89cd-433b-968e-9831ab0acae0\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"sub_period_id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"balance_type\":\"DEBIT\",\"amount\":46059000,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a1793b-ff6b-70de-b597-3ea4fff23f91\",\"updated_at\":\"2026-10-26T17:22:17.000000Z\",\"created_at\":\"2026-10-26T17:22:17.000000Z\",\"chart_of_account\":{\"id\":\"010f231d-89cd-433b-968e-9831ab0acae0\",\"code\":\"12500\",\"name\":\"Peralatan Kantor\",\"parent_id\":\"1980f7f4-9342-454b-b2ad-7546f8a9cef1\",\"level\":\"2\",\"order\":\"5\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\"}}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"010f231d-89cd-433b-968e-9831ab0acae0\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"sub_period_id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"opening_balance\":46059000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":46059000,\"last_transaction_at\":\"2026-10-26T17:22:17.000000Z\",\"id\":\"01a1793b-ff72-7172-9871-2f9c5e8cb60c\",\"updated_at\":\"2026-10-26T17:22:17.000000Z\",\"created_at\":\"2026-10-26T17:22:17.000000Z\"}}', '2026-10-26 10:22:17', '2026-10-26 10:22:17'),
('01a1793c-7690-73e6-b76d-60aba7368e70', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Akumulasi Depresiasi Peralatan Kantor (12510) pada sub periode Desember 2022 dengan jumlah 25,236,667.00', 'App\\Models\\OpeningBalance', '01a1793c-767d-71e3-ab04-29c1fc1a74b8', '[]', '{\"chart_of_account_id\":\"b3498af8-7715-4285-99c0-e838e553cc93\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"sub_period_id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"balance_type\":\"CREDIT\",\"amount\":25236667,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a1793c-767d-71e3-ab04-29c1fc1a74b8\",\"updated_at\":\"2026-10-26T17:22:48.000000Z\",\"created_at\":\"2026-10-26T17:22:48.000000Z\",\"chart_of_account\":{\"id\":\"b3498af8-7715-4285-99c0-e838e553cc93\",\"code\":\"12510\",\"name\":\"Akumulasi Depresiasi Peralatan Kantor\",\"parent_id\":\"010f231d-89cd-433b-968e-9831ab0acae0\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\"}}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"b3498af8-7715-4285-99c0-e838e553cc93\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"sub_period_id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"opening_balance\":25236667,\"debit_total\":0,\"credit_total\":0,\"current_balance\":25236667,\"last_transaction_at\":\"2026-10-26T17:22:48.000000Z\",\"id\":\"01a1793c-7683-7298-b3ff-2fdd76864000\",\"updated_at\":\"2026-10-26T17:22:48.000000Z\",\"created_at\":\"2026-10-26T17:22:48.000000Z\"}}', '2026-10-26 10:22:48', '2026-10-26 10:22:48'),
('01a1793e-e3c0-72fc-be2b-cc244b4fcc1d', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Tabungan Bueka Assakinah (11600) pada sub periode Desember 2022 dengan jumlah 676,151,976.00', 'App\\Models\\OpeningBalance', '01a1793e-e3af-709c-a6e5-15a2351aa1be', '[]', '{\"chart_of_account_id\":\"e6579eb2-defa-4737-a29d-3d38d6a8bbb6\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"sub_period_id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"balance_type\":\"DEBIT\",\"amount\":676151976,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a1793e-e3af-709c-a6e5-15a2351aa1be\",\"updated_at\":\"2026-10-26T17:25:27.000000Z\",\"created_at\":\"2026-10-26T17:25:27.000000Z\",\"chart_of_account\":{\"id\":\"e6579eb2-defa-4737-a29d-3d38d6a8bbb6\",\"code\":\"11600\",\"name\":\"Tabungan Bueka Assakinah\",\"parent_id\":\"98507351-f369-4453-b27c-000a2aa83ae7\",\"level\":\"2\",\"order\":\"6\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\"}}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"e6579eb2-defa-4737-a29d-3d38d6a8bbb6\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"sub_period_id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"opening_balance\":676151976,\"debit_total\":0,\"credit_total\":0,\"current_balance\":676151976,\"last_transaction_at\":\"2026-10-26T17:25:27.000000Z\",\"id\":\"01a1793e-e3b7-724e-94e2-4d892849c27c\",\"updated_at\":\"2026-10-26T17:25:27.000000Z\",\"created_at\":\"2026-10-26T17:25:27.000000Z\"}}', '2026-10-26 10:25:27', '2026-10-26 10:25:27'),
('01a17957-8d6e-71e5-86d5-ee442f6e1c2b', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'closed', 'SUB_PERIOD', 'Sub periode Desember 2022 berhasil ditutup.', 'App\\Models\\SubPeriod', '01a1792e-5359-72cf-8044-02a860ff46d3', '{\"is_closed\":false}', '{\"is_closed\":true}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_active\":null}', '2026-10-26 10:52:23', '2026-10-26 10:52:23'),
('01a17957-ffe1-72e7-a7cd-28c78990ddfa', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas (11100) pada sub periode Januari 2023 dengan jumlah 194,604,157.00', 'App\\Models\\OpeningBalance', '01a17957-ffce-720a-9180-9625034a1ae1', '[]', '{\"chart_of_account_id\":\"64bf8847-e02b-4b2b-a547-e10b8a4d5cb7\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"balance_type\":\"DEBIT\",\"amount\":194604157,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a17957-ffce-720a-9180-9625034a1ae1\",\"updated_at\":\"2026-10-26T17:52:52.000000Z\",\"created_at\":\"2026-10-26T17:52:52.000000Z\",\"chart_of_account\":{\"id\":\"64bf8847-e02b-4b2b-a547-e10b8a4d5cb7\",\"code\":\"11100\",\"name\":\"Kas\",\"parent_id\":\"98507351-f369-4453-b27c-000a2aa83ae7\",\"level\":\"2\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\"}}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"64bf8847-e02b-4b2b-a547-e10b8a4d5cb7\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"opening_balance\":194604157,\"debit_total\":0,\"credit_total\":0,\"current_balance\":194604157,\"last_transaction_at\":\"2026-10-26T17:52:52.000000Z\",\"id\":\"01a17957-ffd8-722e-aec0-d06e2f4a770f\",\"updated_at\":\"2026-10-26T17:52:52.000000Z\",\"created_at\":\"2026-10-26T17:52:52.000000Z\"}}', '2026-10-26 10:52:52', '2026-10-26 10:52:52'),
('01a17958-457a-72a7-91c2-58f4736c6f42', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas Ditangan (11110) pada sub periode Januari 2023 dengan jumlah 4,983,047.00', 'App\\Models\\OpeningBalance', '01a17958-456a-73e6-af9a-a2bb837aec83', '[]', '{\"chart_of_account_id\":\"ad67895d-ef05-4fd3-965c-d793289a3c60\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"balance_type\":\"DEBIT\",\"amount\":4983047,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a17958-456a-73e6-af9a-a2bb837aec83\",\"updated_at\":\"2026-10-26T17:53:10.000000Z\",\"created_at\":\"2026-10-26T17:53:10.000000Z\",\"chart_of_account\":{\"id\":\"ad67895d-ef05-4fd3-965c-d793289a3c60\",\"code\":\"11110\",\"name\":\"Kas Ditangan\",\"parent_id\":\"64bf8847-e02b-4b2b-a547-e10b8a4d5cb7\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\"}}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"ad67895d-ef05-4fd3-965c-d793289a3c60\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"opening_balance\":4983047,\"debit_total\":0,\"credit_total\":0,\"current_balance\":4983047,\"last_transaction_at\":\"2026-10-26T17:53:10.000000Z\",\"id\":\"01a17958-4572-73b6-afd3-0f424b96edd2\",\"updated_at\":\"2026-10-26T17:53:10.000000Z\",\"created_at\":\"2026-10-26T17:53:10.000000Z\"}}', '2026-10-26 10:53:10', '2026-10-26 10:53:10'),
('01a17958-78eb-71c9-894a-a8cdfe81d99a', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas di Bank Jatim (11120) pada sub periode Januari 2023 dengan jumlah 385,384,747.00', 'App\\Models\\OpeningBalance', '01a17958-78da-7009-bb45-46f2c7508912', '[]', '{\"chart_of_account_id\":\"3bedac29-10e0-4a32-9e4a-f546f7a801e6\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"balance_type\":\"DEBIT\",\"amount\":385384747,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a17958-78da-7009-bb45-46f2c7508912\",\"updated_at\":\"2026-10-26T17:53:23.000000Z\",\"created_at\":\"2026-10-26T17:53:23.000000Z\",\"chart_of_account\":{\"id\":\"3bedac29-10e0-4a32-9e4a-f546f7a801e6\",\"code\":\"11120\",\"name\":\"Kas di Bank Jatim\",\"parent_id\":\"64bf8847-e02b-4b2b-a547-e10b8a4d5cb7\",\"level\":\"3\",\"order\":\"2\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\"}}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"3bedac29-10e0-4a32-9e4a-f546f7a801e6\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"opening_balance\":385384747,\"debit_total\":0,\"credit_total\":0,\"current_balance\":385384747,\"last_transaction_at\":\"2026-10-26T17:53:23.000000Z\",\"id\":\"01a17958-78e1-7294-8ed2-d49a55f807e0\",\"updated_at\":\"2026-10-26T17:53:23.000000Z\",\"created_at\":\"2026-10-26T17:53:23.000000Z\"}}', '2026-10-26 10:53:23', '2026-10-26 10:53:23'),
('01a17959-1454-7195-8d57-d29c5865741f', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas di Bank Jatim Dr. Soetomo (11130) pada sub periode Januari 2023 dengan jumlah 1,156,982,563.00', 'App\\Models\\OpeningBalance', '01a17959-1412-7297-8369-e0c20d1a0aef', '[]', '{\"chart_of_account_id\":\"b8e89210-2ad3-44b5-b835-c66c8f8d2f0c\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"balance_type\":\"DEBIT\",\"amount\":1156982563,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a17959-1412-7297-8369-e0c20d1a0aef\",\"updated_at\":\"2026-10-26T17:54:03.000000Z\",\"created_at\":\"2026-10-26T17:54:03.000000Z\",\"chart_of_account\":{\"id\":\"b8e89210-2ad3-44b5-b835-c66c8f8d2f0c\",\"code\":\"11130\",\"name\":\"Kas di Bank Jatim Dr. Soetomo\",\"parent_id\":\"64bf8847-e02b-4b2b-a547-e10b8a4d5cb7\",\"level\":\"3\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\"}}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"b8e89210-2ad3-44b5-b835-c66c8f8d2f0c\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"opening_balance\":1156982563,\"debit_total\":0,\"credit_total\":0,\"current_balance\":1156982563,\"last_transaction_at\":\"2026-10-26T17:54:03.000000Z\",\"id\":\"01a17959-141a-70ae-a249-58696efe8334\",\"updated_at\":\"2026-10-26T17:54:03.000000Z\",\"created_at\":\"2026-10-26T17:54:03.000000Z\"}}', '2026-10-26 10:54:03', '2026-10-26 10:54:03'),
('01a17959-4924-716f-84f3-75deaa3507fa', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas di Bank Bukopin Syariah (11140) pada sub periode Januari 2023 dengan jumlah 377,940,865.00', 'App\\Models\\OpeningBalance', '01a17959-4915-73fa-975e-a7e18c93f00b', '[]', '{\"chart_of_account_id\":\"dc604ee1-502c-456b-8b3d-006762ecedf2\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"balance_type\":\"DEBIT\",\"amount\":377940865,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a17959-4915-73fa-975e-a7e18c93f00b\",\"updated_at\":\"2026-10-26T17:54:16.000000Z\",\"created_at\":\"2026-10-26T17:54:16.000000Z\",\"chart_of_account\":{\"id\":\"dc604ee1-502c-456b-8b3d-006762ecedf2\",\"code\":\"11140\",\"name\":\"Kas di Bank Bukopin Syariah\",\"parent_id\":\"64bf8847-e02b-4b2b-a547-e10b8a4d5cb7\",\"level\":\"3\",\"order\":\"4\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\"}}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"dc604ee1-502c-456b-8b3d-006762ecedf2\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"opening_balance\":377940865,\"debit_total\":0,\"credit_total\":0,\"current_balance\":377940865,\"last_transaction_at\":\"2026-10-26T17:54:16.000000Z\",\"id\":\"01a17959-491c-722d-9cf8-f0ab767b62dd\",\"updated_at\":\"2026-10-26T17:54:16.000000Z\",\"created_at\":\"2026-10-26T17:54:16.000000Z\"}}', '2026-10-26 10:54:16', '2026-10-26 10:54:16'),
('01a17959-7930-71b1-bff0-496dc6c931af', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Piutang Karyawan (11300) pada sub periode Januari 2023 dengan jumlah 1,800,000.00', 'App\\Models\\OpeningBalance', '01a17959-791c-73f0-82b0-a39c51a4f87d', '[]', '{\"chart_of_account_id\":\"f0b2f862-b909-4d51-aab8-35aa1a569506\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"balance_type\":\"DEBIT\",\"amount\":1800000,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a17959-791c-73f0-82b0-a39c51a4f87d\",\"updated_at\":\"2026-10-26T17:54:29.000000Z\",\"created_at\":\"2026-10-26T17:54:29.000000Z\",\"chart_of_account\":{\"id\":\"f0b2f862-b909-4d51-aab8-35aa1a569506\",\"code\":\"11300\",\"name\":\"Piutang Karyawan\",\"parent_id\":\"98507351-f369-4453-b27c-000a2aa83ae7\",\"level\":\"2\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\"}}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"f0b2f862-b909-4d51-aab8-35aa1a569506\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"opening_balance\":1800000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":1800000,\"last_transaction_at\":\"2026-10-26T17:54:29.000000Z\",\"id\":\"01a17959-7927-7266-9e16-048a1cfc6eb6\",\"updated_at\":\"2026-10-26T17:54:29.000000Z\",\"created_at\":\"2026-10-26T17:54:29.000000Z\"}}', '2026-10-26 10:54:29', '2026-10-26 10:54:29');
INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `module`, `description`, `subject_type`, `subject_id`, `old_values`, `new_values`, `ip_address`, `user_agent`, `additional_data`, `created_at`, `updated_at`) VALUES
('01a17960-830a-709e-a512-349dd86f7ad6', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Penyertaan Modal Bueka Assakinah (11500) pada sub periode Januari 2023 dengan jumlah 245,583,300.00', 'App\\Models\\OpeningBalance', '01a17960-82f4-703a-b8c4-56cb7d68db37', '[]', '{\"chart_of_account_id\":\"bd645eab-8d27-47ca-9e1e-eac912720710\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"balance_type\":\"DEBIT\",\"amount\":245583300,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a17960-82f4-703a-b8c4-56cb7d68db37\",\"updated_at\":\"2026-10-26T18:02:10.000000Z\",\"created_at\":\"2026-10-26T18:02:10.000000Z\",\"chart_of_account\":{\"id\":\"bd645eab-8d27-47ca-9e1e-eac912720710\",\"code\":\"11500\",\"name\":\"Penyertaan Modal Bueka Assakinah\",\"parent_id\":\"98507351-f369-4453-b27c-000a2aa83ae7\",\"level\":\"2\",\"order\":\"5\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\"}}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"bd645eab-8d27-47ca-9e1e-eac912720710\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"opening_balance\":245583300,\"debit_total\":0,\"credit_total\":0,\"current_balance\":245583300,\"last_transaction_at\":\"2026-10-26T18:02:10.000000Z\",\"id\":\"01a17960-82fd-71ac-9545-ed41f125f8b0\",\"updated_at\":\"2026-10-26T18:02:10.000000Z\",\"created_at\":\"2026-10-26T18:02:10.000000Z\"}}', '2026-10-26 11:02:10', '2026-10-26 11:02:10'),
('01a17960-c39f-70e0-868a-a0e388023b97', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Tabungan Bueka Assakinah (11600) pada sub periode Januari 2023 dengan jumlah 676,151,976.00', 'App\\Models\\OpeningBalance', '01a17960-c393-7047-b6a5-dba810f8d691', '[]', '{\"chart_of_account_id\":\"e6579eb2-defa-4737-a29d-3d38d6a8bbb6\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"balance_type\":\"DEBIT\",\"amount\":676151976,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a17960-c393-7047-b6a5-dba810f8d691\",\"updated_at\":\"2026-10-26T18:02:27.000000Z\",\"created_at\":\"2026-10-26T18:02:27.000000Z\",\"chart_of_account\":{\"id\":\"e6579eb2-defa-4737-a29d-3d38d6a8bbb6\",\"code\":\"11600\",\"name\":\"Tabungan Bueka Assakinah\",\"parent_id\":\"98507351-f369-4453-b27c-000a2aa83ae7\",\"level\":\"2\",\"order\":\"6\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\"}}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"e6579eb2-defa-4737-a29d-3d38d6a8bbb6\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"opening_balance\":676151976,\"debit_total\":0,\"credit_total\":0,\"current_balance\":676151976,\"last_transaction_at\":\"2026-10-26T18:02:27.000000Z\",\"id\":\"01a17960-c399-71dd-af19-ef931de77768\",\"updated_at\":\"2026-10-26T18:02:27.000000Z\",\"created_at\":\"2026-10-26T18:02:27.000000Z\"}}', '2026-10-26 11:02:27', '2026-10-26 11:02:27'),
('01a17961-0bb9-7136-82b6-a467dea28d59', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kendaraan (12300) pada sub periode Januari 2023 dengan jumlah 460,769,432.00', 'App\\Models\\OpeningBalance', '01a17961-0bae-7044-aa37-6ce4957567fa', '[]', '{\"chart_of_account_id\":\"58045d05-2f17-4bdc-89cf-9e51f72eec73\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"balance_type\":\"DEBIT\",\"amount\":460769432,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a17961-0bae-7044-aa37-6ce4957567fa\",\"updated_at\":\"2026-10-26T18:02:45.000000Z\",\"created_at\":\"2026-10-26T18:02:45.000000Z\",\"chart_of_account\":{\"id\":\"58045d05-2f17-4bdc-89cf-9e51f72eec73\",\"code\":\"12300\",\"name\":\"Kendaraan\",\"parent_id\":\"1980f7f4-9342-454b-b2ad-7546f8a9cef1\",\"level\":\"2\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\"}}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"58045d05-2f17-4bdc-89cf-9e51f72eec73\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"opening_balance\":460769432,\"debit_total\":0,\"credit_total\":0,\"current_balance\":460769432,\"last_transaction_at\":\"2026-10-26T18:02:45.000000Z\",\"id\":\"01a17961-0bb3-7256-a7a5-7cd6c676920a\",\"updated_at\":\"2026-10-26T18:02:45.000000Z\",\"created_at\":\"2026-10-26T18:02:45.000000Z\"}}', '2026-10-26 11:02:45', '2026-10-26 11:02:45'),
('01a17961-4664-7218-afd2-b2841dea46f3', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Akumulasi Depresiasi Kendaraan (12310) pada sub periode Januari 2023 dengan jumlah 144,000,000.00', 'App\\Models\\OpeningBalance', '01a17961-4659-7167-bdff-300a2f45be65', '[]', '{\"chart_of_account_id\":\"20e39474-a65a-4ca5-b57d-890040ebf0de\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"balance_type\":\"CREDIT\",\"amount\":144000000,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a17961-4659-7167-bdff-300a2f45be65\",\"updated_at\":\"2026-10-26T18:03:00.000000Z\",\"created_at\":\"2026-10-26T18:03:00.000000Z\",\"chart_of_account\":{\"id\":\"20e39474-a65a-4ca5-b57d-890040ebf0de\",\"code\":\"12310\",\"name\":\"Akumulasi Depresiasi Kendaraan\",\"parent_id\":\"58045d05-2f17-4bdc-89cf-9e51f72eec73\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\"}}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"20e39474-a65a-4ca5-b57d-890040ebf0de\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"opening_balance\":144000000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":144000000,\"last_transaction_at\":\"2026-10-26T18:03:00.000000Z\",\"id\":\"01a17961-465e-734f-a0a2-c04b61ac7a1a\",\"updated_at\":\"2026-10-26T18:03:00.000000Z\",\"created_at\":\"2026-10-26T18:03:00.000000Z\"}}', '2026-10-26 11:03:00', '2026-10-26 11:03:00'),
('01a17961-a00f-7325-9ac3-70b4df00121a', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Meubel (12400) pada sub periode Januari 2023 dengan jumlah 15,500,000.00', 'App\\Models\\OpeningBalance', '01a17961-9ff4-73fe-9dec-8dff548bd540', '[]', '{\"chart_of_account_id\":\"5542cf94-e5bd-46af-b6b3-54952a6d4da0\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"balance_type\":\"DEBIT\",\"amount\":15500000,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a17961-9ff4-73fe-9dec-8dff548bd540\",\"updated_at\":\"2026-10-26T18:03:23.000000Z\",\"created_at\":\"2026-10-26T18:03:23.000000Z\",\"chart_of_account\":{\"id\":\"5542cf94-e5bd-46af-b6b3-54952a6d4da0\",\"code\":\"12400\",\"name\":\"Meubel\",\"parent_id\":\"1980f7f4-9342-454b-b2ad-7546f8a9cef1\",\"level\":\"2\",\"order\":\"4\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\"}}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"5542cf94-e5bd-46af-b6b3-54952a6d4da0\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"opening_balance\":15500000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":15500000,\"last_transaction_at\":\"2026-10-26T18:03:23.000000Z\",\"id\":\"01a17961-9ff9-700e-acca-f9eed290b9ad\",\"updated_at\":\"2026-10-26T18:03:23.000000Z\",\"created_at\":\"2026-10-26T18:03:23.000000Z\"}}', '2026-10-26 11:03:23', '2026-10-26 11:03:23'),
('01a17961-d8d7-738f-a9a4-efc46f976f61', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Akumulasi Depresiasi Meubel (12410) pada sub periode Januari 2023 dengan jumlah 13,376,668.00', 'App\\Models\\OpeningBalance', '01a17961-d8c8-725d-ae8f-e3106caa8dff', '[]', '{\"chart_of_account_id\":\"53402b88-500b-4d58-a421-dc0370942f23\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"balance_type\":\"CREDIT\",\"amount\":13376668,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a17961-d8c8-725d-ae8f-e3106caa8dff\",\"updated_at\":\"2026-10-26T18:03:38.000000Z\",\"created_at\":\"2026-10-26T18:03:38.000000Z\",\"chart_of_account\":{\"id\":\"53402b88-500b-4d58-a421-dc0370942f23\",\"code\":\"12410\",\"name\":\"Akumulasi Depresiasi Meubel\",\"parent_id\":\"5542cf94-e5bd-46af-b6b3-54952a6d4da0\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\"}}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"53402b88-500b-4d58-a421-dc0370942f23\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"opening_balance\":13376668,\"debit_total\":0,\"credit_total\":0,\"current_balance\":13376668,\"last_transaction_at\":\"2026-10-26T18:03:38.000000Z\",\"id\":\"01a17961-d8cf-7051-b2a5-8ac90de50c25\",\"updated_at\":\"2026-10-26T18:03:38.000000Z\",\"created_at\":\"2026-10-26T18:03:38.000000Z\"}}', '2026-10-26 11:03:38', '2026-10-26 11:03:38'),
('01a17962-1792-70a1-93a5-950a6e8dc965', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Peralatan Kantor (12500) pada sub periode Januari 2023 dengan jumlah 46,059,000.00', 'App\\Models\\OpeningBalance', '01a17962-1780-7399-b3b8-6415808050b2', '[]', '{\"chart_of_account_id\":\"010f231d-89cd-433b-968e-9831ab0acae0\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"balance_type\":\"DEBIT\",\"amount\":46059000,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a17962-1780-7399-b3b8-6415808050b2\",\"updated_at\":\"2026-10-26T18:03:54.000000Z\",\"created_at\":\"2026-10-26T18:03:54.000000Z\",\"chart_of_account\":{\"id\":\"010f231d-89cd-433b-968e-9831ab0acae0\",\"code\":\"12500\",\"name\":\"Peralatan Kantor\",\"parent_id\":\"1980f7f4-9342-454b-b2ad-7546f8a9cef1\",\"level\":\"2\",\"order\":\"5\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\"}}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"010f231d-89cd-433b-968e-9831ab0acae0\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"opening_balance\":46059000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":46059000,\"last_transaction_at\":\"2026-10-26T18:03:54.000000Z\",\"id\":\"01a17962-1788-72b1-9778-5b487dcd1907\",\"updated_at\":\"2026-10-26T18:03:54.000000Z\",\"created_at\":\"2026-10-26T18:03:54.000000Z\"}}', '2026-10-26 11:03:54', '2026-10-26 11:03:54'),
('01a17962-5f99-71bf-8ad4-a022619eea9c', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Akumulasi Depresiasi Peralatan Kantor (12510) pada sub periode Januari 2023 dengan jumlah 25,236,667.00', 'App\\Models\\OpeningBalance', '01a17962-5f87-724f-8e59-e737b2018e55', '[]', '{\"chart_of_account_id\":\"b3498af8-7715-4285-99c0-e838e553cc93\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"balance_type\":\"CREDIT\",\"amount\":25236667,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a17962-5f87-724f-8e59-e737b2018e55\",\"updated_at\":\"2026-10-26T18:04:12.000000Z\",\"created_at\":\"2026-10-26T18:04:12.000000Z\",\"chart_of_account\":{\"id\":\"b3498af8-7715-4285-99c0-e838e553cc93\",\"code\":\"12510\",\"name\":\"Akumulasi Depresiasi Peralatan Kantor\",\"parent_id\":\"010f231d-89cd-433b-968e-9831ab0acae0\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\"}}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"b3498af8-7715-4285-99c0-e838e553cc93\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\",\"opening_balance\":25236667,\"debit_total\":0,\"credit_total\":0,\"current_balance\":25236667,\"last_transaction_at\":\"2026-10-26T18:04:12.000000Z\",\"id\":\"01a17962-5f8f-7072-9aed-2d4eb099ed17\",\"updated_at\":\"2026-10-26T18:04:12.000000Z\",\"created_at\":\"2026-10-26T18:04:12.000000Z\"}}', '2026-10-26 11:04:12', '2026-10-26 11:04:12'),
('01a17966-d1b0-718b-8cad-9143f0abb6f5', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17966-d181-7074-8789-cedca4e44b34', '[]', '{\"transaction_id\":\"01a17966-d181-7074-8789-cedca4e44b34\",\"transaction_number\":\"TRX-EXP-20261026180903\",\"transaction_date\":\"2023-01-02T00:00:00.000000Z\",\"total_amount\":2000000,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-26 11:09:03', '2026-10-26 11:09:03'),
('01a17969-afd2-7000-86aa-825fc4367ea3', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17969-af99-7125-8ddf-efcc84b9cb69', '[]', '{\"transaction_id\":\"01a17969-af99-7125-8ddf-efcc84b9cb69\",\"transaction_number\":\"TRX-EXP-20261026181211\",\"transaction_date\":\"2023-01-05T00:00:00.000000Z\",\"total_amount\":3000000,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-26 11:12:11', '2026-10-26 11:12:11'),
('01a1796b-08e3-7025-938b-e34fbd6d9502', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a1796b-08a3-71eb-9ba7-aea0e1e6d807', '[]', '{\"transaction_id\":\"01a1796b-08a3-71eb-9ba7-aea0e1e6d807\",\"transaction_number\":\"TRX-EXP-20261026181340\",\"transaction_date\":\"2023-01-05T00:00:00.000000Z\",\"total_amount\":60000000,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-26 11:13:40', '2026-10-26 11:13:40'),
('01a1796b-bb19-7319-b870-ff88e075f8cb', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a1796b-baec-7017-b530-ca664f132e7e', '[]', '{\"transaction_id\":\"01a1796b-baec-7017-b530-ca664f132e7e\",\"transaction_number\":\"TRX-EXP-20261026181425\",\"transaction_date\":\"2023-01-05T00:00:00.000000Z\",\"total_amount\":2500,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-26 11:14:25', '2026-10-26 11:14:25'),
('01a1796c-87f7-73d2-9236-a36d5d8654ef', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a1796c-87c5-71cc-bc43-d128253b5312', '[]', '{\"transaction_id\":\"01a1796c-87c5-71cc-bc43-d128253b5312\",\"transaction_number\":\"TRX-EXP-20261026181518\",\"transaction_date\":\"2023-01-05T00:00:00.000000Z\",\"total_amount\":200000,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-26 11:15:18', '2026-10-26 11:15:18'),
('01a17970-e74c-73f6-b821-49eda3f9567c', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17970-e6a1-7344-9896-eec5738b2bf2', '[]', '{\"transaction_id\":\"01a17970-e6a1-7344-9896-eec5738b2bf2\",\"transaction_number\":\"TRX-EXP-20261026182004\",\"transaction_date\":\"2023-01-07T00:00:00.000000Z\",\"total_amount\":11805000,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-26 11:20:04', '2026-10-26 11:20:04'),
('01a17974-9c75-73bf-9048-e82ce7254c43', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17974-9bf0-70aa-a6b7-9022aebba6ec', '[]', '{\"transaction_id\":\"01a17974-9bf0-70aa-a6b7-9022aebba6ec\",\"transaction_number\":\"TRX-EXP-20261026182407\",\"transaction_date\":\"2023-01-08T00:00:00.000000Z\",\"total_amount\":9757500,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-26 11:24:07', '2026-10-26 11:24:07'),
('01a17976-f3a1-702e-afef-ac62d8512c7b', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17976-f378-72c3-b569-23411b62c3bf', '[]', '{\"transaction_id\":\"01a17976-f378-72c3-b569-23411b62c3bf\",\"transaction_number\":\"TRX-EXP-20261026182641\",\"transaction_date\":\"2023-01-10T00:00:00.000000Z\",\"total_amount\":43912975,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-26 11:26:41', '2026-10-26 11:26:41'),
('01a17977-d273-7284-8660-b24d9897b218', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17977-d24d-702a-9a46-2669b9f696a9', '[]', '{\"transaction_id\":\"01a17977-d24d-702a-9a46-2669b9f696a9\",\"transaction_number\":\"TRX-EXP-20261026182738\",\"transaction_date\":\"2023-01-13T00:00:00.000000Z\",\"total_amount\":35000000,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-26 11:27:38', '2026-10-26 11:27:38'),
('01a1797b-329a-70a8-a249-ffb68c8bfc04', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a1797b-327a-7329-bfb4-f91464c4c06d', '[]', '{\"transaction_id\":\"01a1797b-327a-7329-bfb4-f91464c4c06d\",\"transaction_number\":\"TRX-EXP-20261026183119\",\"transaction_date\":\"2023-01-13T00:00:00.000000Z\",\"total_amount\":200000000,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-26 11:31:19', '2026-10-26 11:31:19'),
('01a1797c-a1eb-705e-8463-c0abf7844f90', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a1797c-a1bc-71b4-828b-8320156d3ce2', '[]', '{\"transaction_id\":\"01a1797c-a1bc-71b4-828b-8320156d3ce2\",\"transaction_number\":\"TRX-EXP-20261026183253\",\"transaction_date\":\"2023-01-16T00:00:00.000000Z\",\"total_amount\":19700000,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-26 11:32:53', '2026-10-26 11:32:53'),
('01a17980-2bdd-710b-864f-ddb535316f07', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17980-2bb2-71fa-aeb5-16c2cc75f59d', '[]', '{\"transaction_id\":\"01a17980-2bb2-71fa-aeb5-16c2cc75f59d\",\"transaction_number\":\"TRX-INC-20261026183645\",\"total_amount\":50000000,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-26 11:36:45', '2026-10-26 11:36:45'),
('01a17982-39fc-729d-af70-1c2a78b81ac7', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17982-39d4-70e3-8370-126e795fb2e8', '[]', '{\"transaction_id\":\"01a17982-39d4-70e3-8370-126e795fb2e8\",\"transaction_number\":\"TRX-EXP-20261026183900\",\"transaction_date\":\"2023-01-24T00:00:00.000000Z\",\"total_amount\":100002500,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-26 11:39:00', '2026-10-26 11:39:00'),
('01a1798d-e6c3-7103-9ea9-db32615d2f48', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a1798d-e66d-7357-be23-56892312b096', '[]', '{\"transaction_id\":\"01a1798d-e66d-7357-be23-56892312b096\",\"transaction_number\":\"TRX-EXP-20261026185145\",\"transaction_date\":\"2023-01-25T00:00:00.000000Z\",\"total_amount\":52523050,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-26 11:51:45', '2026-10-26 11:51:45'),
('01a1798e-d07c-7162-bc94-91c910215686', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a1798e-d057-7220-9879-455af2f76612', '[]', '{\"transaction_id\":\"01a1798e-d057-7220-9879-455af2f76612\",\"transaction_number\":\"TRX-INC-20261026185245\",\"total_amount\":175000000,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-26 11:52:45', '2026-10-26 11:52:45'),
('01a17991-38cb-70f6-b5bd-41d50e967f39', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17991-38a0-7318-ad56-503bc8f435da', '[]', '{\"transaction_id\":\"01a17991-38a0-7318-ad56-503bc8f435da\",\"transaction_number\":\"TRX-EXP-20261026185522\",\"transaction_date\":\"2023-01-27T00:00:00.000000Z\",\"total_amount\":9535500,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-26 11:55:22', '2026-10-26 11:55:22'),
('01a17992-9758-706f-8501-2ca7ebc27c48', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17992-972d-71b4-aaf2-624e6abae914', '[]', '{\"transaction_id\":\"01a17992-972d-71b4-aaf2-624e6abae914\",\"transaction_number\":\"TRX-EXP-20261026185652\",\"transaction_date\":\"2023-01-31T00:00:00.000000Z\",\"total_amount\":5000000,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-26 11:56:52', '2026-10-26 11:56:52'),
('01a17d74-9a33-7088-bf82-ee4543c3623b', '01a1792e-5292-7359-a09b-260b0c33e831', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17d74-9a06-714e-b562-3632207e3b12', '[]', '{\"transaction_id\":\"01a17d74-9a06-714e-b562-3632207e3b12\",\"transaction_number\":\"TRX-EXP-20261027130236\",\"transaction_date\":\"2023-01-01T00:00:00.000000Z\",\"total_amount\":402500,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 06:02:36', '2026-10-27 06:02:36'),
('01a17d76-1f3e-7323-b29d-75513c8cb8c1', '01a1792e-5292-7359-a09b-260b0c33e831', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17d76-1f0c-702b-af44-def1f293e711', '[]', '{\"transaction_id\":\"01a17d76-1f0c-702b-af44-def1f293e711\",\"transaction_number\":\"TRX-INC-20261027130415\",\"total_amount\":200000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 06:04:15', '2026-10-27 06:04:15'),
('01a17d79-0ac4-7218-96b9-6700196422da', '01a1792e-5292-7359-a09b-260b0c33e831', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17d79-0a76-7368-9163-f333afa1d400', '[]', '{\"transaction_id\":\"01a17d79-0a76-7368-9163-f333afa1d400\",\"transaction_number\":\"TRX-EXP-20261027130726\",\"transaction_date\":\"2023-01-02T00:00:00.000000Z\",\"total_amount\":1045500,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 06:07:27', '2026-10-27 06:07:27'),
('01a17d7b-72db-73d4-9350-fc4ed41b1c56', '01a1792e-5292-7359-a09b-260b0c33e831', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17d7b-7290-7112-93bc-35763e65d74d', '[]', '{\"transaction_id\":\"01a17d7b-7290-7112-93bc-35763e65d74d\",\"transaction_number\":\"TRX-EXP-20261027131004\",\"transaction_date\":\"2023-01-03T00:00:00.000000Z\",\"total_amount\":2580500,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 06:10:04', '2026-10-27 06:10:04'),
('01a17d7c-fb44-7192-a888-e61967fe99b2', '01a1792e-5292-7359-a09b-260b0c33e831', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17d7c-fb0c-71bb-8249-dc454815cedd', '[]', '{\"transaction_id\":\"01a17d7c-fb0c-71bb-8249-dc454815cedd\",\"transaction_number\":\"TRX-EXP-20261027131145\",\"transaction_date\":\"2023-01-04T00:00:00.000000Z\",\"total_amount\":661700,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 06:11:45', '2026-10-27 06:11:45'),
('01a17d7e-0615-7095-9925-fa3268127003', '01a1792e-5292-7359-a09b-260b0c33e831', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17d7e-05f9-7281-b15e-ef8b6d599177', '[]', '{\"transaction_id\":\"01a17d7e-05f9-7281-b15e-ef8b6d599177\",\"transaction_number\":\"TRX-EXP-20261027131253\",\"transaction_date\":\"2023-01-05T00:00:00.000000Z\",\"total_amount\":1002500,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 06:12:53', '2026-10-27 06:12:53'),
('01a17d81-5db1-718e-9af4-c544b8e20a13', '01a1792e-5292-7359-a09b-260b0c33e831', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17d81-5d4b-73b1-8cb3-6efb59ff2648', '[]', '{\"transaction_id\":\"01a17d81-5d4b-73b1-8cb3-6efb59ff2648\",\"transaction_number\":\"TRX-EXP-20261027131632\",\"transaction_date\":\"2023-01-06T00:00:00.000000Z\",\"total_amount\":2925000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 06:16:32', '2026-10-27 06:16:32'),
('01a17d84-2f0f-72f9-b1f7-6d13ed808dae', '01a1792e-5292-7359-a09b-260b0c33e831', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17d84-2ec8-70ec-a8a9-ae8658bb4210', '[]', '{\"transaction_id\":\"01a17d84-2ec8-70ec-a8a9-ae8658bb4210\",\"transaction_number\":\"TRX-EXP-20261027131937\",\"transaction_date\":\"2023-01-07T00:00:00.000000Z\",\"total_amount\":1350000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 06:19:37', '2026-10-27 06:19:37'),
('01a17d85-a5c4-71e2-92b1-3c5526fd8043', '01a1792e-5292-7359-a09b-260b0c33e831', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17d85-a595-71d0-a6ed-1a88073847f6', '[]', '{\"transaction_id\":\"01a17d85-a595-71d0-a6ed-1a88073847f6\",\"transaction_number\":\"TRX-EXP-20261027132113\",\"transaction_date\":\"2023-01-08T00:00:00.000000Z\",\"total_amount\":377500,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 06:21:13', '2026-10-27 06:21:13'),
('01a17d86-aa46-73d9-8e74-828a9b3815d2', '01a1792e-5292-7359-a09b-260b0c33e831', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17d86-aa26-706d-a0c8-d64b3dd7ecf2', '[]', '{\"transaction_id\":\"01a17d86-aa26-706d-a0c8-d64b3dd7ecf2\",\"transaction_number\":\"TRX-EXP-20261027132219\",\"transaction_date\":\"2023-01-09T00:00:00.000000Z\",\"total_amount\":23000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 06:22:19', '2026-10-27 06:22:19'),
('01a17d8a-ee9d-72be-a3e2-a2e15fe60ccb', '01a1792e-5292-7359-a09b-260b0c33e831', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17d8a-ee2b-7285-956a-9e32ac702117', '[]', '{\"transaction_id\":\"01a17d8a-ee2b-7285-956a-9e32ac702117\",\"transaction_number\":\"TRX-EXP-20261027132659\",\"transaction_date\":\"2023-01-10T00:00:00.000000Z\",\"total_amount\":43007975,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 06:26:59', '2026-10-27 06:26:59'),
('01a17d8c-6d7d-73f9-b8e3-fc6004cad8ed', '01a1792e-5292-7359-a09b-260b0c33e831', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17d8c-6d4c-737e-921f-bc91f259556e', '[]', '{\"transaction_id\":\"01a17d8c-6d4c-737e-921f-bc91f259556e\",\"transaction_number\":\"TRX-EXP-20261027132837\",\"transaction_date\":\"2023-01-11T00:00:00.000000Z\",\"total_amount\":2069000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 06:28:37', '2026-10-27 06:28:37'),
('01a17d8d-c608-7140-a16a-0469088f480d', '01a1792e-5292-7359-a09b-260b0c33e831', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17d8d-c5cd-7316-9d47-58a68cf88f46', '[]', '{\"transaction_id\":\"01a17d8d-c5cd-7316-9d47-58a68cf88f46\",\"transaction_number\":\"TRX-EXP-20261027133005\",\"transaction_date\":\"2023-01-12T00:00:00.000000Z\",\"total_amount\":327730,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 06:30:05', '2026-10-27 06:30:05'),
('01a17d8f-116a-71d8-bdf7-785ce00f403c', '01a1792e-5292-7359-a09b-260b0c33e831', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17d8f-113b-70a0-948b-92ab405ad41b', '[]', '{\"transaction_id\":\"01a17d8f-113b-70a0-948b-92ab405ad41b\",\"transaction_number\":\"TRX-EXP-20261027133130\",\"transaction_date\":\"2023-01-13T00:00:00.000000Z\",\"total_amount\":30070440,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 06:31:30', '2026-10-27 06:31:30'),
('01a17d90-51cc-73d1-9d03-0750c1894072', '01a1792e-5292-7359-a09b-260b0c33e831', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17d90-51a2-73e6-8830-7a589760c782', '[]', '{\"transaction_id\":\"01a17d90-51a2-73e6-8830-7a589760c782\",\"transaction_number\":\"TRX-EXP-20261027133252\",\"transaction_date\":\"2023-01-16T00:00:00.000000Z\",\"total_amount\":19705000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 06:32:52', '2026-10-27 06:32:52'),
('01a17d92-54ff-7270-b0d0-990c11206a4c', '01a1792e-5292-7359-a09b-260b0c33e831', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17d92-54cf-72f8-ae9f-7d2fcebab9d8', '[]', '{\"transaction_id\":\"01a17d92-54cf-72f8-ae9f-7d2fcebab9d8\",\"transaction_number\":\"TRX-EXP-20261027133504\",\"transaction_date\":\"2023-01-17T00:00:00.000000Z\",\"total_amount\":1183500,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 06:35:04', '2026-10-27 06:35:04'),
('01a17d9b-8cee-73f8-80c1-2b92173816bf', '01a1792e-5292-7359-a09b-260b0c33e831', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17d9b-8cae-7344-be2e-fe39864bbc40', '[]', '{\"transaction_id\":\"01a17d9b-8cae-7344-be2e-fe39864bbc40\",\"transaction_number\":\"TRX-INC-20261027134508\",\"total_amount\":217000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 06:45:08', '2026-10-27 06:45:08'),
('01a17d9d-fcda-7106-9718-4fc8d53f32ae', '01a1792e-5292-7359-a09b-260b0c33e831', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17d9d-fc88-710a-ae6f-a9eb3c98419c', '[]', '{\"transaction_id\":\"01a17d9d-fc88-710a-ae6f-a9eb3c98419c\",\"transaction_number\":\"TRX-EXP-20261027134748\",\"transaction_date\":\"2023-01-18T00:00:00.000000Z\",\"total_amount\":251500,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 06:47:48', '2026-10-27 06:47:48'),
('01a17d9e-a384-70ff-b011-0bfe00fe8355', '01a1792e-5292-7359-a09b-260b0c33e831', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17d9e-a35b-7061-8236-4cdd96a4a781', '[]', '{\"transaction_id\":\"01a17d9e-a35b-7061-8236-4cdd96a4a781\",\"transaction_number\":\"TRX-EXP-20261027134830\",\"transaction_date\":\"2023-01-19T00:00:00.000000Z\",\"total_amount\":13000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 06:48:30', '2026-10-27 06:48:30'),
('01a17da3-e02f-718e-ac9d-abdbb00e2b14', '01a1792e-5292-7359-a09b-260b0c33e831', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17da3-dfe8-72b3-b7ef-ba4aee560f65', '[]', '{\"transaction_id\":\"01a17da3-dfe8-72b3-b7ef-ba4aee560f65\",\"transaction_number\":\"TRX-EXP-20261027135414\",\"transaction_date\":\"2023-01-22T00:00:00.000000Z\",\"total_amount\":1900000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 06:54:14', '2026-10-27 06:54:14'),
('01a17da4-e201-71fc-8526-c9149d23fea6', '01a1792e-5292-7359-a09b-260b0c33e831', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17da4-e1d7-71f9-81c6-14632be9a012', '[]', '{\"transaction_id\":\"01a17da4-e1d7-71f9-81c6-14632be9a012\",\"transaction_number\":\"TRX-EXP-20261027135520\",\"transaction_date\":\"2023-01-24T00:00:00.000000Z\",\"total_amount\":650000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 06:55:20', '2026-10-27 06:55:20'),
('01a17da5-7651-7318-8ec6-b3541aeb5e86', '01a1792e-5292-7359-a09b-260b0c33e831', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17da5-7626-70af-bc40-48dbba531f9d', '[]', '{\"transaction_id\":\"01a17da5-7626-70af-bc40-48dbba531f9d\",\"transaction_number\":\"TRX-EXP-20261027135558\",\"transaction_date\":\"2023-01-26T00:00:00.000000Z\",\"total_amount\":555000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 06:55:58', '2026-10-27 06:55:58'),
('01a17da6-85fa-71eb-8839-d96cfa36f5e8', '01a1792e-5292-7359-a09b-260b0c33e831', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17da6-85d4-714d-8ba0-610d21aa7838', '[]', '{\"transaction_id\":\"01a17da6-85d4-714d-8ba0-610d21aa7838\",\"transaction_number\":\"TRX-EXP-20261027135707\",\"transaction_date\":\"2023-01-27T00:00:00.000000Z\",\"total_amount\":1527500,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 06:57:07', '2026-10-27 06:57:07'),
('01a17da7-661e-731d-99a0-66977b9a7549', '01a1792e-5292-7359-a09b-260b0c33e831', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17da7-65fa-72f6-a7a5-4f190e4d83fc', '[]', '{\"transaction_id\":\"01a17da7-65fa-72f6-a7a5-4f190e4d83fc\",\"transaction_number\":\"TRX-EXP-20261027135805\",\"transaction_date\":\"2023-01-28T00:00:00.000000Z\",\"total_amount\":452500,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 06:58:05', '2026-10-27 06:58:05'),
('01a17da9-000b-7323-8bc0-d69adb914aa7', '01a1792e-5292-7359-a09b-260b0c33e831', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17da8-ffdf-737b-b1dc-d66fece257e6', '[]', '{\"transaction_id\":\"01a17da8-ffdf-737b-b1dc-d66fece257e6\",\"transaction_number\":\"TRX-EXP-20261027135949\",\"transaction_date\":\"2023-01-30T00:00:00.000000Z\",\"total_amount\":1989700,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 06:59:50', '2026-10-27 06:59:50'),
('01a17dae-dca7-7396-9b08-2fe43d3ad820', '01a1792e-5292-7359-a09b-260b0c33e831', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17dae-dbd4-7306-9f4d-8dfc4af69d7e', '[]', '{\"transaction_id\":\"01a17dae-dbd4-7306-9f4d-8dfc4af69d7e\",\"transaction_number\":\"TRX-EXP-20261027140613\",\"transaction_date\":\"2023-01-31T00:00:00.000000Z\",\"total_amount\":8305000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 07:06:14', '2026-10-27 07:06:14');
INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `module`, `description`, `subject_type`, `subject_id`, `old_values`, `new_values`, `ip_address`, `user_agent`, `additional_data`, `created_at`, `updated_at`) VALUES
('01a17dbd-dc3b-71f4-a470-b9240d2aa070', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dbd-dc1e-71c1-bcef-76dd0da2806d', '[]', '{\"transaction_id\":\"01a17dbd-dc1e-71c1-bcef-76dd0da2806d\",\"transaction_number\":\"TRX-INC-20261027142237\",\"total_amount\":1000000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:22:37', '2026-10-27 07:22:37'),
('01a17dbe-5eeb-7001-936d-451806cc14ca', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dbe-5ecc-725a-b911-e8512fc61018', '[]', '{\"transaction_id\":\"01a17dbe-5ecc-725a-b911-e8512fc61018\",\"transaction_number\":\"TRX-INC-20261027142310\",\"total_amount\":25000000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:23:10', '2026-10-27 07:23:10'),
('01a17dbe-ffd8-72a3-b6d6-921c04657104', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dbe-ffb2-73f2-8788-6c82fade3fed', '[]', '{\"transaction_id\":\"01a17dbe-ffb2-73f2-8788-6c82fade3fed\",\"transaction_number\":\"TRX-INC-20261027142351\",\"total_amount\":300000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:23:51', '2026-10-27 07:23:51'),
('01a17dbf-820c-71a2-b117-7cc4bb3b8fc4', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dbf-81e9-7090-be05-dddf377a58a1', '[]', '{\"transaction_id\":\"01a17dbf-81e9-7090-be05-dddf377a58a1\",\"transaction_number\":\"TRX-INC-20261027142425\",\"total_amount\":3000000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:24:25', '2026-10-27 07:24:25'),
('01a17dc0-5d85-73f6-b24c-7062a0c587e0', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dc0-5d62-7114-9c41-20d0e7e219c7', '[]', '{\"transaction_id\":\"01a17dc0-5d62-7114-9c41-20d0e7e219c7\",\"transaction_number\":\"TRX-INC-20261027142521\",\"total_amount\":7500000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:25:21', '2026-10-27 07:25:21'),
('01a17dc0-f1f3-720d-a766-a39b48885279', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dc0-f1c3-71dd-bbbe-117fdb7fb5c3', '[]', '{\"transaction_id\":\"01a17dc0-f1c3-71dd-bbbe-117fdb7fb5c3\",\"transaction_number\":\"TRX-INC-20261027142559\",\"total_amount\":5000000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:25:59', '2026-10-27 07:25:59'),
('01a17dc1-9a24-71b4-8e19-0932bac72be5', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dc1-9a03-72fa-8f1f-f7e55fd763b9', '[]', '{\"transaction_id\":\"01a17dc1-9a03-72fa-8f1f-f7e55fd763b9\",\"transaction_number\":\"TRX-INC-20261027142642\",\"total_amount\":10000000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:26:42', '2026-10-27 07:26:42'),
('01a17dc2-3f2f-71f7-84f0-966b711869e8', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dc2-3f07-7154-82a9-da03ee0d4e86', '[]', '{\"transaction_id\":\"01a17dc2-3f07-7154-82a9-da03ee0d4e86\",\"transaction_number\":\"TRX-INC-20261027142724\",\"total_amount\":20000000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:27:24', '2026-10-27 07:27:24'),
('01a17dc3-5a5b-704c-a48b-c0bc9bf5105a', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dc3-5a34-70e8-b247-635f308d2e2c', '[]', '{\"transaction_id\":\"01a17dc3-5a34-70e8-b247-635f308d2e2c\",\"transaction_number\":\"TRX-INC-20261027142837\",\"total_amount\":5000000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:28:37', '2026-10-27 07:28:37'),
('01a17dc4-4ac3-710e-ba8b-f4761a4ab436', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dc4-4aa7-7218-a00a-804273587661', '[]', '{\"transaction_id\":\"01a17dc4-4aa7-7218-a00a-804273587661\",\"transaction_number\":\"TRX-INC-20261027142938\",\"total_amount\":1500000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:29:38', '2026-10-27 07:29:38'),
('01a17dc4-d4ca-7072-8b7a-7cb13493b211', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dc4-d49a-7215-862e-0df01df505d3', '[]', '{\"transaction_id\":\"01a17dc4-d49a-7215-862e-0df01df505d3\",\"transaction_number\":\"TRX-INC-20261027143013\",\"total_amount\":3000000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:30:13', '2026-10-27 07:30:13'),
('01a17dc5-6fec-71b8-9ac2-82041e933f37', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dc5-6f8b-70a7-bf52-c15e2977426a', '[]', '{\"transaction_id\":\"01a17dc5-6f8b-70a7-bf52-c15e2977426a\",\"transaction_number\":\"TRX-INC-20261027143053\",\"total_amount\":2250000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:30:53', '2026-10-27 07:30:53'),
('01a17dc5-fb6f-70b4-9f50-132d3b1a234b', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dc5-fb54-7165-9734-16cb382277fb', '[]', '{\"transaction_id\":\"01a17dc5-fb54-7165-9734-16cb382277fb\",\"transaction_number\":\"TRX-INC-20261027143129\",\"total_amount\":5000000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:31:29', '2026-10-27 07:31:29'),
('01a17dc6-94fd-7062-9bfc-7864d1930694', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dc6-94d8-71e1-affb-d0c25037e0ca', '[]', '{\"transaction_id\":\"01a17dc6-94d8-71e1-affb-d0c25037e0ca\",\"transaction_number\":\"TRX-INC-20261027143208\",\"total_amount\":10000000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:32:08', '2026-10-27 07:32:08'),
('01a17dc7-1a74-7064-a784-f7fcefbaf392', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dc7-1a58-726b-a06d-d3835c80ef2a', '[]', '{\"transaction_id\":\"01a17dc7-1a58-726b-a06d-d3835c80ef2a\",\"transaction_number\":\"TRX-INC-20261027143242\",\"total_amount\":5000000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:32:42', '2026-10-27 07:32:42'),
('01a17dc7-9818-70b5-a6d0-f60407b69a7b', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dc7-97f5-7074-b03f-db444ff1854e', '[]', '{\"transaction_id\":\"01a17dc7-97f5-7074-b03f-db444ff1854e\",\"transaction_number\":\"TRX-INC-20261027143314\",\"total_amount\":5000000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:33:15', '2026-10-27 07:33:15'),
('01a17dc8-320d-71c6-8f03-18d162be7f23', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dc8-31ea-71b3-a229-1e738e2cf4f5', '[]', '{\"transaction_id\":\"01a17dc8-31ea-71b3-a229-1e738e2cf4f5\",\"transaction_number\":\"TRX-INC-20261027143354\",\"total_amount\":2500000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:33:54', '2026-10-27 07:33:54'),
('01a17dc8-bd91-7213-9e73-5e7b7f73c4d8', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dc8-bd69-7155-a990-b8cde1810de8', '[]', '{\"transaction_id\":\"01a17dc8-bd69-7155-a990-b8cde1810de8\",\"transaction_number\":\"TRX-INC-20261027143430\",\"total_amount\":10000000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:34:30', '2026-10-27 07:34:30'),
('01a17dc9-4bd9-71d8-957a-5248922d2514', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dc9-4bb3-70f3-91e5-741e4406ce89', '[]', '{\"transaction_id\":\"01a17dc9-4bb3-70f3-91e5-741e4406ce89\",\"transaction_number\":\"TRX-INC-20261027143506\",\"total_amount\":5000000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:35:06', '2026-10-27 07:35:06'),
('01a17dc9-ce45-7060-afac-0558fbda5b96', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dc9-ce20-72cc-8c43-c3b9fb9695da', '[]', '{\"transaction_id\":\"01a17dc9-ce20-72cc-8c43-c3b9fb9695da\",\"transaction_number\":\"TRX-INC-20261027143539\",\"total_amount\":1000000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:35:39', '2026-10-27 07:35:39'),
('01a17dca-591f-72fd-bf73-4a46eb302dea', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dca-58f8-710a-bc1c-c45ba6bf15af', '[]', '{\"transaction_id\":\"01a17dca-58f8-710a-bc1c-c45ba6bf15af\",\"transaction_number\":\"TRX-INC-20261027143615\",\"total_amount\":3000000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:36:15', '2026-10-27 07:36:15'),
('01a17dca-bf4b-701a-8d4e-6a535b4941da', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dca-bf2c-715c-b820-1b2fb7b3c8ac', '[]', '{\"transaction_id\":\"01a17dca-bf2c-715c-b820-1b2fb7b3c8ac\",\"transaction_number\":\"TRX-INC-20261027143641\",\"total_amount\":20000000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:36:41', '2026-10-27 07:36:41'),
('01a17dcb-306c-7011-a50e-9dd514418a78', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dcb-3048-7116-8e1c-98f0d1467bac', '[]', '{\"transaction_id\":\"01a17dcb-3048-7116-8e1c-98f0d1467bac\",\"transaction_number\":\"TRX-INC-20261027143710\",\"total_amount\":250000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:37:10', '2026-10-27 07:37:10'),
('01a17dcb-bd1a-7138-a346-c3220e242c65', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dcb-bcf4-705a-ab28-0f40c73dead5', '[]', '{\"transaction_id\":\"01a17dcb-bcf4-705a-ab28-0f40c73dead5\",\"transaction_number\":\"TRX-INC-20261027143746\",\"total_amount\":700000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:37:46', '2026-10-27 07:37:46'),
('01a17dcc-3b19-7033-9036-d2e9b8479e1b', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dcc-3af0-73ee-b70a-1be7e64000d7', '[]', '{\"transaction_id\":\"01a17dcc-3af0-73ee-b70a-1be7e64000d7\",\"transaction_number\":\"TRX-INC-20261027143818\",\"total_amount\":10000000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:38:18', '2026-10-27 07:38:18'),
('01a17dcc-a124-707c-ba93-3836e8e99948', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dcc-a0f2-7221-a5bb-70f6de82170f', '[]', '{\"transaction_id\":\"01a17dcc-a0f2-7221-a5bb-70f6de82170f\",\"transaction_number\":\"TRX-INC-20261027143844\",\"total_amount\":5000000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:38:45', '2026-10-27 07:38:45'),
('01a17dcd-282f-7162-a993-7826fe649e0a', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dcd-280d-725c-8732-b5534a86b120', '[]', '{\"transaction_id\":\"01a17dcd-280d-725c-8732-b5534a86b120\",\"transaction_number\":\"TRX-INC-20261027143919\",\"total_amount\":3000000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:39:19', '2026-10-27 07:39:19'),
('01a17dcd-c4ff-70cd-9ef7-ca1011864768', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dcd-c4c4-73d8-b11d-b2967a6cfa71', '[]', '{\"transaction_id\":\"01a17dcd-c4c4-73d8-b11d-b2967a6cfa71\",\"transaction_number\":\"TRX-INC-20261027143959\",\"total_amount\":10000000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:39:59', '2026-10-27 07:39:59'),
('01a17dce-47e1-7283-8490-8de8d6cee293', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dce-47ac-7227-89f1-e0f7ccbceb5a', '[]', '{\"transaction_id\":\"01a17dce-47ac-7227-89f1-e0f7ccbceb5a\",\"transaction_number\":\"TRX-INC-20261027144033\",\"total_amount\":2500000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:40:33', '2026-10-27 07:40:33'),
('01a17dcf-1474-732b-bec9-981c4131bba0', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dcf-145b-7129-8327-b3dc55ecf4c3', '[]', '{\"transaction_id\":\"01a17dcf-145b-7129-8327-b3dc55ecf4c3\",\"transaction_number\":\"TRX-INC-20261027144125\",\"total_amount\":250000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:41:25', '2026-10-27 07:41:25'),
('01a17dcf-75d4-72a6-9e75-cd681a165f58', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dcf-75af-739e-8230-07ea38d8fa2e', '[]', '{\"transaction_id\":\"01a17dcf-75af-739e-8230-07ea38d8fa2e\",\"transaction_number\":\"TRX-INC-20261027144150\",\"total_amount\":1000000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:41:50', '2026-10-27 07:41:50'),
('01a17dcf-d554-723f-bcec-5d80ea593680', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dcf-d525-70ee-a9eb-b46e3f326095', '[]', '{\"transaction_id\":\"01a17dcf-d525-70ee-a9eb-b46e3f326095\",\"transaction_number\":\"TRX-INC-20261027144214\",\"total_amount\":2500000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:42:14', '2026-10-27 07:42:14'),
('01a17dd0-752c-73a4-8768-a47f58fba725', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dd0-7510-72f0-96a5-dae16265494e', '[]', '{\"transaction_id\":\"01a17dd0-7510-72f0-96a5-dae16265494e\",\"transaction_number\":\"TRX-INC-20261027144255\",\"total_amount\":20000000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:42:55', '2026-10-27 07:42:55'),
('01a17dd1-5fa7-7230-84b6-5024706e7654', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dd1-5f88-71e2-81e4-c221146ac511', '[]', '{\"transaction_id\":\"01a17dd1-5f88-71e2-81e4-c221146ac511\",\"transaction_number\":\"TRX-INC-20261027144355\",\"total_amount\":415107,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:43:55', '2026-10-27 07:43:55'),
('01a17dd2-c234-7175-8f27-fc019be81739', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17dd2-c20c-713a-b5a9-4ed906bf8d8a', '[]', '{\"transaction_id\":\"01a17dd2-c20c-713a-b5a9-4ed906bf8d8a\",\"transaction_number\":\"TRX-EXP-20261027144526\",\"transaction_date\":\"2023-01-16T00:00:00.000000Z\",\"total_amount\":83021,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 07:45:26', '2026-10-27 07:45:26'),
('01a17dd3-8299-72b3-9af9-e2612ad07b9c', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DELETE', 'TRANSACTION_INCOME', 'Menghapus transaksi penerimaan dan berkas lampirannya.', 'App\\Models\\Transaction', '01a17dd1-5f88-71e2-81e4-c221146ac511', '{\"transaction_id\":\"01a17dd1-5f88-71e2-81e4-c221146ac511\",\"transaction_number\":\"TRX-INC-20261027144355\",\"transaction_date\":\"2023-01-16\",\"total_amount\":415107,\"description\":\"Penerimaan bunga tabungan\",\"status\":\"POSTED\"}', '[]', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"INCOME\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 07:46:15', '2026-10-27 07:46:15'),
('01a17dd4-3179-7015-a244-9b6472df45d6', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dd4-3151-7339-992d-68936cd17902', '[]', '{\"transaction_id\":\"01a17dd4-3151-7339-992d-68936cd17902\",\"transaction_number\":\"TRX-INC-20261027144700\",\"total_amount\":415107,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:47:00', '2026-10-27 07:47:00'),
('01a17dd4-edac-7385-80a9-656a09d72e0a', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dd4-ed91-70e2-a44c-7b2cdae43faa', '[]', '{\"transaction_id\":\"01a17dd4-ed91-70e2-a44c-7b2cdae43faa\",\"transaction_number\":\"TRX-INC-20261027144748\",\"total_amount\":10000000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:47:48', '2026-10-27 07:47:48'),
('01a17dd5-70a0-7135-a459-cef33c8738fb', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dd5-7082-71ed-b5b1-19c850e6b220', '[]', '{\"transaction_id\":\"01a17dd5-7082-71ed-b5b1-19c850e6b220\",\"transaction_number\":\"TRX-INC-20261027144822\",\"total_amount\":5000000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:48:22', '2026-10-27 07:48:22'),
('01a17dd6-3106-7333-b318-bc63d0444f49', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dd6-30df-709d-a329-6a66c76838c3', '[]', '{\"transaction_id\":\"01a17dd6-30df-709d-a329-6a66c76838c3\",\"transaction_number\":\"TRX-INC-20261027144911\",\"total_amount\":5000000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:49:11', '2026-10-27 07:49:11'),
('01a17dd6-c6f1-727a-8d2d-590e7dde5655', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dd6-c6cc-7217-bb31-29b026691fd9', '[]', '{\"transaction_id\":\"01a17dd6-c6cc-7217-bb31-29b026691fd9\",\"transaction_number\":\"TRX-INC-20261027144950\",\"total_amount\":500000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:49:50', '2026-10-27 07:49:50'),
('01a17dd7-6324-707f-8d0b-e9e17e3269af', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dd7-62fe-71bd-96e6-129d5ac18c7d', '[]', '{\"transaction_id\":\"01a17dd7-62fe-71bd-96e6-129d5ac18c7d\",\"transaction_number\":\"TRX-INC-20261027145030\",\"total_amount\":10000000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:50:30', '2026-10-27 07:50:30'),
('01a17dd7-f707-70c5-a1fc-6db01f37b703', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dd7-f6e5-710c-b430-b72c74f3ad5b', '[]', '{\"transaction_id\":\"01a17dd7-f6e5-710c-b430-b72c74f3ad5b\",\"transaction_number\":\"TRX-INC-20261027145107\",\"total_amount\":250000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:51:07', '2026-10-27 07:51:07'),
('01a17dd8-777b-7385-bd55-a9708970a63b', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dd8-7755-72d6-b00c-1851c22495bc', '[]', '{\"transaction_id\":\"01a17dd8-7755-72d6-b00c-1851c22495bc\",\"transaction_number\":\"TRX-INC-20261027145140\",\"total_amount\":3000000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:51:40', '2026-10-27 07:51:40'),
('01a17dd9-34d1-71bf-b9ac-6f28b9115682', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17dd9-34a2-71ae-90a6-d3db7938991b', '[]', '{\"transaction_id\":\"01a17dd9-34a2-71ae-90a6-d3db7938991b\",\"transaction_number\":\"TRX-EXP-20261027145229\",\"transaction_date\":\"2023-01-27T00:00:00.000000Z\",\"total_amount\":8000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 07:52:29', '2026-10-27 07:52:29'),
('01a17ddc-3816-7062-b5bb-0d3b268725f0', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17ddc-37f7-7110-8cff-be4dd3f89ac6', '[]', '{\"transaction_id\":\"01a17ddc-37f7-7110-8cff-be4dd3f89ac6\",\"transaction_number\":\"TRX-INC-20261027145546\",\"total_amount\":733644,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 07:55:46', '2026-10-27 07:55:46'),
('01a17ddc-f80a-71ce-8c4d-307184f462d4', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17ddc-f7d9-70f1-8e0c-2ebbd5029691', '[]', '{\"transaction_id\":\"01a17ddc-f7d9-70f1-8e0c-2ebbd5029691\",\"transaction_number\":\"TRX-EXP-20261027145635\",\"transaction_date\":\"2023-01-01T00:00:00.000000Z\",\"total_amount\":146728,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 07:56:35', '2026-10-27 07:56:35'),
('01a17ddd-94f5-70f2-ad98-b98a988c0e50', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17ddd-94d1-700a-a623-859e3fe29ea3', '[]', '{\"transaction_id\":\"01a17ddd-94d1-700a-a623-859e3fe29ea3\",\"transaction_number\":\"TRX-EXP-20261027145715\",\"transaction_date\":\"2023-01-27T00:00:00.000000Z\",\"total_amount\":30000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 07:57:16', '2026-10-27 07:57:16'),
('01a17de9-de88-71c1-96e4-a5ea7f97bab7', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17de9-de63-7123-9545-fdb8f5f145e0', '[]', '{\"transaction_id\":\"01a17de9-de63-7123-9545-fdb8f5f145e0\",\"transaction_number\":\"TRX-INC-20261027151041\",\"total_amount\":2400000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 08:10:41', '2026-10-27 08:10:41'),
('01a17dea-7a94-72ae-bcbe-f7555e73b48e', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dea-7a71-731f-a74f-f05d47528657', '[]', '{\"transaction_id\":\"01a17dea-7a71-731f-a74f-f05d47528657\",\"transaction_number\":\"TRX-INC-20261027151121\",\"total_amount\":529300,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 08:11:21', '2026-10-27 08:11:21'),
('01a17deb-74ab-71c2-9ade-2a875ca4d5e6', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17deb-7481-7070-8c36-35e08ea37bc5', '[]', '{\"transaction_id\":\"01a17deb-7481-7070-8c36-35e08ea37bc5\",\"transaction_number\":\"TRX-INC-20261027151225\",\"total_amount\":5509500,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 08:12:25', '2026-10-27 08:12:25'),
('01a17dec-59db-705c-af4a-a212e1dfaa4d', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dec-59b1-73a8-b2b8-f1572bcaa35c', '[]', '{\"transaction_id\":\"01a17dec-59b1-73a8-b2b8-f1572bcaa35c\",\"transaction_number\":\"TRX-INC-20261027151323\",\"total_amount\":13994700,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 08:13:23', '2026-10-27 08:13:23'),
('01a17ded-1104-7243-a4db-cba8d434ae3c', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17ded-10ed-7035-81b7-d530edb65749', '[]', '{\"transaction_id\":\"01a17ded-10ed-7035-81b7-d530edb65749\",\"transaction_number\":\"TRX-INC-20261027151410\",\"total_amount\":2593500,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 08:14:10', '2026-10-27 08:14:10'),
('01a17ded-e197-7171-a12e-1818eb63b810', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17ded-e175-725b-a452-3a9bb6bfc430', '[]', '{\"transaction_id\":\"01a17ded-e175-725b-a452-3a9bb6bfc430\",\"transaction_number\":\"TRX-INC-20261027151504\",\"total_amount\":3216000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 08:15:04', '2026-10-27 08:15:04'),
('01a17dee-ef07-737f-bcc5-f6cd964fe70b', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a17dee-eeea-7151-a39b-606f051116f9', '[]', '{\"transaction_id\":\"01a17dee-eeea-7151-a39b-606f051116f9\",\"transaction_number\":\"TRX-INC-20261027151613\",\"total_amount\":344359,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '[]', '2026-10-27 08:16:13', '2026-10-27 08:16:13'),
('01a17def-a914-737e-804b-9ae776b6a478', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17def-a8f7-713d-bceb-4e90e1ae0ba2', '[]', '{\"transaction_id\":\"01a17def-a8f7-713d-bceb-4e90e1ae0ba2\",\"transaction_number\":\"TRX-EXP-20261027151700\",\"transaction_date\":\"2023-01-02T00:00:00.000000Z\",\"total_amount\":105860,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 08:17:00', '2026-10-27 08:17:00'),
('01a17df0-caf3-715f-ba47-c60eb5565873', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17df0-cad2-7334-8a37-b7dd6f8dcbb7', '[]', '{\"transaction_id\":\"01a17df0-cad2-7334-8a37-b7dd6f8dcbb7\",\"transaction_number\":\"TRX-EXP-20261027151814\",\"transaction_date\":\"2023-01-12T00:00:00.000000Z\",\"total_amount\":9502900,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 08:18:15', '2026-10-27 08:18:15'),
('01a17df1-ddfa-7006-a547-b59c06472b25', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17df1-ddd3-7144-ac42-a0aba0fceb35', '[]', '{\"transaction_id\":\"01a17df1-ddd3-7144-ac42-a0aba0fceb35\",\"transaction_number\":\"TRX-EXP-20261027151925\",\"transaction_date\":\"2023-01-15T00:00:00.000000Z\",\"total_amount\":10000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 08:19:25', '2026-10-27 08:19:25'),
('01a17df2-ad4f-72e4-be8d-efd305679680', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17df2-ad1d-7107-a1b9-a5348c938ee5', '[]', '{\"transaction_id\":\"01a17df2-ad1d-7107-a1b9-a5348c938ee5\",\"transaction_number\":\"TRX-EXP-20261027152018\",\"transaction_date\":\"2023-01-18T00:00:00.000000Z\",\"total_amount\":300030000,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 08:20:18', '2026-10-27 08:20:18'),
('01a17df3-b4c6-7132-b114-5a78275908a9', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17df3-b4a7-732d-85cc-cefef3fd03ad', '[]', '{\"transaction_id\":\"01a17df3-b4a7-732d-85cc-cefef3fd03ad\",\"transaction_number\":\"TRX-EXP-20261027152125\",\"transaction_date\":\"2023-01-30T00:00:00.000000Z\",\"total_amount\":5512400,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 08:21:25', '2026-10-27 08:21:25'),
('01a17df4-4752-7230-849e-98c92669aa4d', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a17df4-469f-73eb-b42a-8d1d6e85d74d', '[]', '{\"transaction_id\":\"01a17df4-469f-73eb-b42a-8d1d6e85d74d\",\"transaction_number\":\"TRX-EXP-20261027152203\",\"transaction_date\":\"2023-01-31T00:00:00.000000Z\",\"total_amount\":68871,\"status\":\"POSTED\"}', '82.158.130.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1792e-538c-7153-9c05-c54696b8b603\"}', '2026-10-27 08:22:03', '2026-10-27 08:22:03'),
('01a1a055-aa3f-739e-bcf8-f38017e5d0fd', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'SUB_PERIOD', 'Sub periode Februari 2023 berhasil dibuat.', 'App\\Models\\SubPeriod', '01a1a055-aa31-705d-8a07-8046c7f96db0', '[]', '{\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"name\":\"Februari 2023\",\"description\":null,\"start_date\":\"2023-02-01T00:00:00.000000Z\",\"end_date\":\"2023-02-28T00:00:00.000000Z\",\"id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"updated_at\":\"2026-11-03T07:35:31.000000Z\",\"created_at\":\"2026-11-03T07:35:31.000000Z\"}', '118.99.111.203', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:159.0) Gecko/20100101 Firefox/159.0', '{\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"start_date\":\"2023-02-01\",\"end_date\":\"2023-02-28\",\"is_active\":false}', '2026-11-03 00:35:31', '2026-11-03 00:35:31'),
('01a1a055-cf80-72f6-93fb-e84f498e581a', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'closed', 'SUB_PERIOD', 'Sub periode Januari 2023 berhasil ditutup.', 'App\\Models\\SubPeriod', '01a1792e-538c-7153-9c05-c54696b8b603', '{\"is_closed\":false}', '{\"is_closed\":true}', '118.99.111.203', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:159.0) Gecko/20100101 Firefox/159.0', '{\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_active\":null}', '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a056-18e9-70ec-9392-981d6772d0e1', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas (11100) pada sub periode Februari 2023 dengan jumlah 267,165,132.00', 'App\\Models\\OpeningBalance', '01a1a056-18d9-72c5-919d-23a3b7e806d7', '[]', '{\"chart_of_account_id\":\"64bf8847-e02b-4b2b-a547-e10b8a4d5cb7\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"balance_type\":\"DEBIT\",\"amount\":267165132,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a1a056-18d9-72c5-919d-23a3b7e806d7\",\"updated_at\":\"2026-11-03T07:35:59.000000Z\",\"created_at\":\"2026-11-03T07:35:59.000000Z\",\"chart_of_account\":{\"id\":\"64bf8847-e02b-4b2b-a547-e10b8a4d5cb7\",\"code\":\"11100\",\"name\":\"Kas\",\"parent_id\":\"98507351-f369-4453-b27c-000a2aa83ae7\",\"level\":\"2\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"name\":\"Februari 2023\",\"description\":null,\"start_date\":\"2023-02-01T00:00:00.000000Z\",\"end_date\":\"2023-02-28T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-11-03T07:35:31.000000Z\",\"updated_at\":\"2026-11-03T07:35:31.000000Z\"}}', '118.99.111.203', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:159.0) Gecko/20100101 Firefox/159.0', '{\"coa_balance\":{\"chart_of_account_id\":\"64bf8847-e02b-4b2b-a547-e10b8a4d5cb7\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"opening_balance\":267165132,\"debit_total\":0,\"credit_total\":0,\"current_balance\":267165132,\"last_transaction_at\":\"2026-11-03T07:35:59.000000Z\",\"id\":\"01a1a056-18e1-7252-bc81-9f71095bdd78\",\"updated_at\":\"2026-11-03T07:35:59.000000Z\",\"created_at\":\"2026-11-03T07:35:59.000000Z\"}}', '2026-11-03 00:35:59', '2026-11-03 00:35:59'),
('01a1a056-52de-7018-9ab7-b25d92846bc0', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas Ditangan (11110) pada sub periode Februari 2023 dengan jumlah 1,009,977.00', 'App\\Models\\OpeningBalance', '01a1a056-52d0-7383-a0d7-52a9f75a2177', '[]', '{\"chart_of_account_id\":\"ad67895d-ef05-4fd3-965c-d793289a3c60\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"balance_type\":\"DEBIT\",\"amount\":1009977,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a1a056-52d0-7383-a0d7-52a9f75a2177\",\"updated_at\":\"2026-11-03T07:36:14.000000Z\",\"created_at\":\"2026-11-03T07:36:14.000000Z\",\"chart_of_account\":{\"id\":\"ad67895d-ef05-4fd3-965c-d793289a3c60\",\"code\":\"11110\",\"name\":\"Kas Ditangan\",\"parent_id\":\"64bf8847-e02b-4b2b-a547-e10b8a4d5cb7\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"name\":\"Februari 2023\",\"description\":null,\"start_date\":\"2023-02-01T00:00:00.000000Z\",\"end_date\":\"2023-02-28T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-11-03T07:35:31.000000Z\",\"updated_at\":\"2026-11-03T07:35:31.000000Z\"}}', '118.99.111.203', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:159.0) Gecko/20100101 Firefox/159.0', '{\"coa_balance\":{\"chart_of_account_id\":\"ad67895d-ef05-4fd3-965c-d793289a3c60\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"opening_balance\":1009977,\"debit_total\":0,\"credit_total\":0,\"current_balance\":1009977,\"last_transaction_at\":\"2026-11-03T07:36:14.000000Z\",\"id\":\"01a1a056-52d6-73b5-961f-3043f9a35f88\",\"updated_at\":\"2026-11-03T07:36:14.000000Z\",\"created_at\":\"2026-11-03T07:36:14.000000Z\"}}', '2026-11-03 00:36:14', '2026-11-03 00:36:14'),
('01a1a056-8803-71bd-9f4a-a73dffc6e52a', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas di Bank Jatim (11120) pada sub periode Februari 2023 dengan jumlah 624,708,833.00', 'App\\Models\\OpeningBalance', '01a1a056-87f0-72d2-8189-fcccf601cda3', '[]', '{\"chart_of_account_id\":\"3bedac29-10e0-4a32-9e4a-f546f7a801e6\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"balance_type\":\"DEBIT\",\"amount\":624708833,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a1a056-87f0-72d2-8189-fcccf601cda3\",\"updated_at\":\"2026-11-03T07:36:27.000000Z\",\"created_at\":\"2026-11-03T07:36:27.000000Z\",\"chart_of_account\":{\"id\":\"3bedac29-10e0-4a32-9e4a-f546f7a801e6\",\"code\":\"11120\",\"name\":\"Kas di Bank Jatim\",\"parent_id\":\"64bf8847-e02b-4b2b-a547-e10b8a4d5cb7\",\"level\":\"3\",\"order\":\"2\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"name\":\"Februari 2023\",\"description\":null,\"start_date\":\"2023-02-01T00:00:00.000000Z\",\"end_date\":\"2023-02-28T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-11-03T07:35:31.000000Z\",\"updated_at\":\"2026-11-03T07:35:31.000000Z\"}}', '118.99.111.203', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:159.0) Gecko/20100101 Firefox/159.0', '{\"coa_balance\":{\"chart_of_account_id\":\"3bedac29-10e0-4a32-9e4a-f546f7a801e6\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"opening_balance\":624708833,\"debit_total\":0,\"credit_total\":0,\"current_balance\":624708833,\"last_transaction_at\":\"2026-11-03T07:36:27.000000Z\",\"id\":\"01a1a056-87f6-71be-9d52-11f7c8c6ff3d\",\"updated_at\":\"2026-11-03T07:36:27.000000Z\",\"created_at\":\"2026-11-03T07:36:27.000000Z\"}}', '2026-11-03 00:36:27', '2026-11-03 00:36:27'),
('01a1a056-e69c-71e6-b353-2fb08c54cb9a', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas di Bank Jatim Dr. Soetomo (11130) pada sub periode Februari 2023 dengan jumlah 957,539,479.00', 'App\\Models\\OpeningBalance', '01a1a056-e68b-71c4-bcdf-d06e824e0b5f', '[]', '{\"chart_of_account_id\":\"b8e89210-2ad3-44b5-b835-c66c8f8d2f0c\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"balance_type\":\"DEBIT\",\"amount\":957539479,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a1a056-e68b-71c4-bcdf-d06e824e0b5f\",\"updated_at\":\"2026-11-03T07:36:52.000000Z\",\"created_at\":\"2026-11-03T07:36:52.000000Z\",\"chart_of_account\":{\"id\":\"b8e89210-2ad3-44b5-b835-c66c8f8d2f0c\",\"code\":\"11130\",\"name\":\"Kas di Bank Jatim Dr. Soetomo\",\"parent_id\":\"64bf8847-e02b-4b2b-a547-e10b8a4d5cb7\",\"level\":\"3\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"name\":\"Februari 2023\",\"description\":null,\"start_date\":\"2023-02-01T00:00:00.000000Z\",\"end_date\":\"2023-02-28T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-11-03T07:35:31.000000Z\",\"updated_at\":\"2026-11-03T07:35:31.000000Z\"}}', '118.99.111.203', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:159.0) Gecko/20100101 Firefox/159.0', '{\"coa_balance\":{\"chart_of_account_id\":\"b8e89210-2ad3-44b5-b835-c66c8f8d2f0c\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"opening_balance\":957539479,\"debit_total\":0,\"credit_total\":0,\"current_balance\":957539479,\"last_transaction_at\":\"2026-11-03T07:36:52.000000Z\",\"id\":\"01a1a056-e693-73e8-956a-7c7972dff985\",\"updated_at\":\"2026-11-03T07:36:52.000000Z\",\"created_at\":\"2026-11-03T07:36:52.000000Z\"}}', '2026-11-03 00:36:52', '2026-11-03 00:36:52'),
('01a1a057-2182-721c-a928-265838906a6f', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas di Bank Bukopin Syariah (11140) pada sub periode Februari 2023 dengan jumlah 91,298,375.00', 'App\\Models\\OpeningBalance', '01a1a057-216e-713f-8b12-d94630e0d6a6', '[]', '{\"chart_of_account_id\":\"dc604ee1-502c-456b-8b3d-006762ecedf2\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"balance_type\":\"DEBIT\",\"amount\":91298375,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a1a057-216e-713f-8b12-d94630e0d6a6\",\"updated_at\":\"2026-11-03T07:37:07.000000Z\",\"created_at\":\"2026-11-03T07:37:07.000000Z\",\"chart_of_account\":{\"id\":\"dc604ee1-502c-456b-8b3d-006762ecedf2\",\"code\":\"11140\",\"name\":\"Kas di Bank Bukopin Syariah\",\"parent_id\":\"64bf8847-e02b-4b2b-a547-e10b8a4d5cb7\",\"level\":\"3\",\"order\":\"4\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"name\":\"Februari 2023\",\"description\":null,\"start_date\":\"2023-02-01T00:00:00.000000Z\",\"end_date\":\"2023-02-28T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-11-03T07:35:31.000000Z\",\"updated_at\":\"2026-11-03T07:35:31.000000Z\"}}', '118.99.111.203', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:159.0) Gecko/20100101 Firefox/159.0', '{\"coa_balance\":{\"chart_of_account_id\":\"dc604ee1-502c-456b-8b3d-006762ecedf2\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"opening_balance\":91298375,\"debit_total\":0,\"credit_total\":0,\"current_balance\":91298375,\"last_transaction_at\":\"2026-11-03T07:37:07.000000Z\",\"id\":\"01a1a057-2176-719f-b716-bc2591a56236\",\"updated_at\":\"2026-11-03T07:37:07.000000Z\",\"created_at\":\"2026-11-03T07:37:07.000000Z\"}}', '2026-11-03 00:37:07', '2026-11-03 00:37:07');
INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `module`, `description`, `subject_type`, `subject_id`, `old_values`, `new_values`, `ip_address`, `user_agent`, `additional_data`, `created_at`, `updated_at`) VALUES
('01a1a057-593e-734a-884c-b928d6820290', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Piutang Karyawan (11300) pada sub periode Februari 2023 dengan jumlah 1,600,000.00', 'App\\Models\\OpeningBalance', '01a1a057-5926-720b-bfd0-d36fbe715246', '[]', '{\"chart_of_account_id\":\"f0b2f862-b909-4d51-aab8-35aa1a569506\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"balance_type\":\"DEBIT\",\"amount\":1600000,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a1a057-5926-720b-bfd0-d36fbe715246\",\"updated_at\":\"2026-11-03T07:37:21.000000Z\",\"created_at\":\"2026-11-03T07:37:21.000000Z\",\"chart_of_account\":{\"id\":\"f0b2f862-b909-4d51-aab8-35aa1a569506\",\"code\":\"11300\",\"name\":\"Piutang Karyawan\",\"parent_id\":\"98507351-f369-4453-b27c-000a2aa83ae7\",\"level\":\"2\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"name\":\"Februari 2023\",\"description\":null,\"start_date\":\"2023-02-01T00:00:00.000000Z\",\"end_date\":\"2023-02-28T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-11-03T07:35:31.000000Z\",\"updated_at\":\"2026-11-03T07:35:31.000000Z\"}}', '118.99.111.203', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:159.0) Gecko/20100101 Firefox/159.0', '{\"coa_balance\":{\"chart_of_account_id\":\"f0b2f862-b909-4d51-aab8-35aa1a569506\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"opening_balance\":1600000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":1600000,\"last_transaction_at\":\"2026-11-03T07:37:21.000000Z\",\"id\":\"01a1a057-592f-7047-8430-51f35e52fb48\",\"updated_at\":\"2026-11-03T07:37:21.000000Z\",\"created_at\":\"2026-11-03T07:37:21.000000Z\"}}', '2026-11-03 00:37:21', '2026-11-03 00:37:21'),
('01a1a057-af44-72b6-94b8-e567e24abcbf', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Penyertaan Modal Bueka Assakinah (11500) pada sub periode Februari 2023 dengan jumlah 245,583,300.00', 'App\\Models\\OpeningBalance', '01a1a057-af2b-7250-8b02-43a83ef736ac', '[]', '{\"chart_of_account_id\":\"bd645eab-8d27-47ca-9e1e-eac912720710\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"balance_type\":\"DEBIT\",\"amount\":245583300,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a1a057-af2b-7250-8b02-43a83ef736ac\",\"updated_at\":\"2026-11-03T07:37:43.000000Z\",\"created_at\":\"2026-11-03T07:37:43.000000Z\",\"chart_of_account\":{\"id\":\"bd645eab-8d27-47ca-9e1e-eac912720710\",\"code\":\"11500\",\"name\":\"Penyertaan Modal Bueka Assakinah\",\"parent_id\":\"98507351-f369-4453-b27c-000a2aa83ae7\",\"level\":\"2\",\"order\":\"5\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"name\":\"Februari 2023\",\"description\":null,\"start_date\":\"2023-02-01T00:00:00.000000Z\",\"end_date\":\"2023-02-28T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-11-03T07:35:31.000000Z\",\"updated_at\":\"2026-11-03T07:35:31.000000Z\"}}', '118.99.111.203', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:159.0) Gecko/20100101 Firefox/159.0', '{\"coa_balance\":{\"chart_of_account_id\":\"bd645eab-8d27-47ca-9e1e-eac912720710\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"opening_balance\":245583300,\"debit_total\":0,\"credit_total\":0,\"current_balance\":245583300,\"last_transaction_at\":\"2026-11-03T07:37:43.000000Z\",\"id\":\"01a1a057-af36-71bd-83b4-3f1c7ab634ad\",\"updated_at\":\"2026-11-03T07:37:43.000000Z\",\"created_at\":\"2026-11-03T07:37:43.000000Z\"}}', '2026-11-03 00:37:43', '2026-11-03 00:37:43'),
('01a1a058-06ac-70f2-812c-1a753e62c8eb', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Tabungan Bueka Assakinah (11600) pada sub periode Februari 2023 dengan jumlah 676,151,976.00', 'App\\Models\\OpeningBalance', '01a1a058-068a-7038-a1f5-28be8a18492e', '[]', '{\"chart_of_account_id\":\"e6579eb2-defa-4737-a29d-3d38d6a8bbb6\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"balance_type\":\"DEBIT\",\"amount\":676151976,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a1a058-068a-7038-a1f5-28be8a18492e\",\"updated_at\":\"2026-11-03T07:38:05.000000Z\",\"created_at\":\"2026-11-03T07:38:05.000000Z\",\"chart_of_account\":{\"id\":\"e6579eb2-defa-4737-a29d-3d38d6a8bbb6\",\"code\":\"11600\",\"name\":\"Tabungan Bueka Assakinah\",\"parent_id\":\"98507351-f369-4453-b27c-000a2aa83ae7\",\"level\":\"2\",\"order\":\"6\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"name\":\"Februari 2023\",\"description\":null,\"start_date\":\"2023-02-01T00:00:00.000000Z\",\"end_date\":\"2023-02-28T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-11-03T07:35:31.000000Z\",\"updated_at\":\"2026-11-03T07:35:31.000000Z\"}}', '118.99.111.203', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:159.0) Gecko/20100101 Firefox/159.0', '{\"coa_balance\":{\"chart_of_account_id\":\"e6579eb2-defa-4737-a29d-3d38d6a8bbb6\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"opening_balance\":676151976,\"debit_total\":0,\"credit_total\":0,\"current_balance\":676151976,\"last_transaction_at\":\"2026-11-03T07:38:05.000000Z\",\"id\":\"01a1a058-0697-709f-a7c4-d76fbdff2504\",\"updated_at\":\"2026-11-03T07:38:05.000000Z\",\"created_at\":\"2026-11-03T07:38:05.000000Z\"}}', '2026-11-03 00:38:05', '2026-11-03 00:38:05'),
('01a1a058-a682-734b-9fd9-8e21ac2668ac', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kendaraan (12300) pada sub periode Februari 2023 dengan jumlah 460,769,432.00', 'App\\Models\\OpeningBalance', '01a1a058-a66b-709d-a08e-4c033648dac8', '[]', '{\"chart_of_account_id\":\"58045d05-2f17-4bdc-89cf-9e51f72eec73\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"balance_type\":\"DEBIT\",\"amount\":460769432,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a1a058-a66b-709d-a08e-4c033648dac8\",\"updated_at\":\"2026-11-03T07:38:46.000000Z\",\"created_at\":\"2026-11-03T07:38:46.000000Z\",\"chart_of_account\":{\"id\":\"58045d05-2f17-4bdc-89cf-9e51f72eec73\",\"code\":\"12300\",\"name\":\"Kendaraan\",\"parent_id\":\"1980f7f4-9342-454b-b2ad-7546f8a9cef1\",\"level\":\"2\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"name\":\"Februari 2023\",\"description\":null,\"start_date\":\"2023-02-01T00:00:00.000000Z\",\"end_date\":\"2023-02-28T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-11-03T07:35:31.000000Z\",\"updated_at\":\"2026-11-03T07:35:31.000000Z\"}}', '118.99.111.203', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:159.0) Gecko/20100101 Firefox/159.0', '{\"coa_balance\":{\"chart_of_account_id\":\"58045d05-2f17-4bdc-89cf-9e51f72eec73\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"opening_balance\":460769432,\"debit_total\":0,\"credit_total\":0,\"current_balance\":460769432,\"last_transaction_at\":\"2026-11-03T07:38:46.000000Z\",\"id\":\"01a1a058-a671-7021-bc1f-876ebeef9a51\",\"updated_at\":\"2026-11-03T07:38:46.000000Z\",\"created_at\":\"2026-11-03T07:38:46.000000Z\"}}', '2026-11-03 00:38:46', '2026-11-03 00:38:46'),
('01a1a058-dae1-704a-a5e0-47d53f07e359', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Akumulasi Depresiasi Kendaraan (12310) pada sub periode Februari 2023 dengan jumlah 144,000,000.00', 'App\\Models\\OpeningBalance', '01a1a058-dacd-73f9-ba41-8447c65c417d', '[]', '{\"chart_of_account_id\":\"20e39474-a65a-4ca5-b57d-890040ebf0de\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"balance_type\":\"CREDIT\",\"amount\":144000000,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a1a058-dacd-73f9-ba41-8447c65c417d\",\"updated_at\":\"2026-11-03T07:39:00.000000Z\",\"created_at\":\"2026-11-03T07:39:00.000000Z\",\"chart_of_account\":{\"id\":\"20e39474-a65a-4ca5-b57d-890040ebf0de\",\"code\":\"12310\",\"name\":\"Akumulasi Depresiasi Kendaraan\",\"parent_id\":\"58045d05-2f17-4bdc-89cf-9e51f72eec73\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"name\":\"Februari 2023\",\"description\":null,\"start_date\":\"2023-02-01T00:00:00.000000Z\",\"end_date\":\"2023-02-28T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-11-03T07:35:31.000000Z\",\"updated_at\":\"2026-11-03T07:35:31.000000Z\"}}', '118.99.111.203', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:159.0) Gecko/20100101 Firefox/159.0', '{\"coa_balance\":{\"chart_of_account_id\":\"20e39474-a65a-4ca5-b57d-890040ebf0de\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"opening_balance\":144000000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":144000000,\"last_transaction_at\":\"2026-11-03T07:39:00.000000Z\",\"id\":\"01a1a058-dad5-700c-af06-26da1f38c678\",\"updated_at\":\"2026-11-03T07:39:00.000000Z\",\"created_at\":\"2026-11-03T07:39:00.000000Z\"}}', '2026-11-03 00:39:00', '2026-11-03 00:39:00'),
('01a1a059-12ee-7358-9ce5-051e02d1d343', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Meubel (12400) pada sub periode Februari 2023 dengan jumlah 15,500,000.00', 'App\\Models\\OpeningBalance', '01a1a059-12e1-7019-b597-091b699250a8', '[]', '{\"chart_of_account_id\":\"5542cf94-e5bd-46af-b6b3-54952a6d4da0\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"balance_type\":\"DEBIT\",\"amount\":15500000,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a1a059-12e1-7019-b597-091b699250a8\",\"updated_at\":\"2026-11-03T07:39:14.000000Z\",\"created_at\":\"2026-11-03T07:39:14.000000Z\",\"chart_of_account\":{\"id\":\"5542cf94-e5bd-46af-b6b3-54952a6d4da0\",\"code\":\"12400\",\"name\":\"Meubel\",\"parent_id\":\"1980f7f4-9342-454b-b2ad-7546f8a9cef1\",\"level\":\"2\",\"order\":\"4\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"name\":\"Februari 2023\",\"description\":null,\"start_date\":\"2023-02-01T00:00:00.000000Z\",\"end_date\":\"2023-02-28T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-11-03T07:35:31.000000Z\",\"updated_at\":\"2026-11-03T07:35:31.000000Z\"}}', '118.99.111.203', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:159.0) Gecko/20100101 Firefox/159.0', '{\"coa_balance\":{\"chart_of_account_id\":\"5542cf94-e5bd-46af-b6b3-54952a6d4da0\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"opening_balance\":15500000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":15500000,\"last_transaction_at\":\"2026-11-03T07:39:14.000000Z\",\"id\":\"01a1a059-12e7-7388-afa7-9a3e96607462\",\"updated_at\":\"2026-11-03T07:39:14.000000Z\",\"created_at\":\"2026-11-03T07:39:14.000000Z\"}}', '2026-11-03 00:39:14', '2026-11-03 00:39:14'),
('01a1a059-4746-71d1-8e97-757547a5c23b', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Akumulasi Depresiasi Meubel (12410) pada sub periode Februari 2023 dengan jumlah 13,376,668.00', 'App\\Models\\OpeningBalance', '01a1a059-473a-700e-8ca1-61bd57f023c3', '[]', '{\"chart_of_account_id\":\"53402b88-500b-4d58-a421-dc0370942f23\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"balance_type\":\"CREDIT\",\"amount\":13376668,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a1a059-473a-700e-8ca1-61bd57f023c3\",\"updated_at\":\"2026-11-03T07:39:27.000000Z\",\"created_at\":\"2026-11-03T07:39:27.000000Z\",\"chart_of_account\":{\"id\":\"53402b88-500b-4d58-a421-dc0370942f23\",\"code\":\"12410\",\"name\":\"Akumulasi Depresiasi Meubel\",\"parent_id\":\"5542cf94-e5bd-46af-b6b3-54952a6d4da0\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"name\":\"Februari 2023\",\"description\":null,\"start_date\":\"2023-02-01T00:00:00.000000Z\",\"end_date\":\"2023-02-28T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-11-03T07:35:31.000000Z\",\"updated_at\":\"2026-11-03T07:35:31.000000Z\"}}', '118.99.111.203', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:159.0) Gecko/20100101 Firefox/159.0', '{\"coa_balance\":{\"chart_of_account_id\":\"53402b88-500b-4d58-a421-dc0370942f23\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"opening_balance\":13376668,\"debit_total\":0,\"credit_total\":0,\"current_balance\":13376668,\"last_transaction_at\":\"2026-11-03T07:39:27.000000Z\",\"id\":\"01a1a059-473f-7008-b463-66e530c759d1\",\"updated_at\":\"2026-11-03T07:39:27.000000Z\",\"created_at\":\"2026-11-03T07:39:27.000000Z\"}}', '2026-11-03 00:39:27', '2026-11-03 00:39:27'),
('01a1a059-833e-710f-bb7a-c9eb476a939f', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Akumulasi Depresiasi Peralatan Kantor (12510) pada sub periode Februari 2023 dengan jumlah 25,236,667.00', 'App\\Models\\OpeningBalance', '01a1a059-832b-7188-88fa-a5c12ae66e1e', '[]', '{\"chart_of_account_id\":\"b3498af8-7715-4285-99c0-e838e553cc93\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"balance_type\":\"CREDIT\",\"amount\":25236667,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a1a059-832b-7188-88fa-a5c12ae66e1e\",\"updated_at\":\"2026-11-03T07:39:43.000000Z\",\"created_at\":\"2026-11-03T07:39:43.000000Z\",\"chart_of_account\":{\"id\":\"b3498af8-7715-4285-99c0-e838e553cc93\",\"code\":\"12510\",\"name\":\"Akumulasi Depresiasi Peralatan Kantor\",\"parent_id\":\"010f231d-89cd-433b-968e-9831ab0acae0\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"name\":\"Februari 2023\",\"description\":null,\"start_date\":\"2023-02-01T00:00:00.000000Z\",\"end_date\":\"2023-02-28T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-11-03T07:35:31.000000Z\",\"updated_at\":\"2026-11-03T07:35:31.000000Z\"}}', '118.99.111.203', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:159.0) Gecko/20100101 Firefox/159.0', '{\"coa_balance\":{\"chart_of_account_id\":\"b3498af8-7715-4285-99c0-e838e553cc93\",\"period_id\":\"01a1792e-5372-735b-9610-0a8975517760\",\"sub_period_id\":\"01a1a055-aa31-705d-8a07-8046c7f96db0\",\"opening_balance\":25236667,\"debit_total\":0,\"credit_total\":0,\"current_balance\":25236667,\"last_transaction_at\":\"2026-11-03T07:39:43.000000Z\",\"id\":\"01a1a059-8334-72a4-89bb-58bcf9e51319\",\"updated_at\":\"2026-11-03T07:39:43.000000Z\",\"created_at\":\"2026-11-03T07:39:43.000000Z\"}}', '2026-11-03 00:39:43', '2026-11-03 00:39:43');

-- --------------------------------------------------------

--
-- Struktur dari tabel `balance_requests`
--

CREATE TABLE `balance_requests` (
  `id` char(36) NOT NULL,
  `requester_id` char(36) NOT NULL,
  `approver_id` char(36) DEFAULT NULL,
  `user_account_id` char(36) NOT NULL,
  `source_coa_id` char(36) DEFAULT NULL,
  `period_id` char(36) NOT NULL,
  `sub_period_id` char(36) NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `status` enum('pending','approved','rejected','canceled') NOT NULL DEFAULT 'pending',
  `purpose` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `approval_notes` text DEFAULT NULL,
  `rejected_at` timestamp NULL DEFAULT NULL,
  `rejection_reason` text DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `budget_allocations`
--

CREATE TABLE `budget_allocations` (
  `id` char(36) NOT NULL,
  `from_chart_of_account_id` char(36) NOT NULL,
  `to_chart_of_account_id` char(36) NOT NULL,
  `period_id` char(36) NOT NULL,
  `sub_period_id` char(36) NOT NULL,
  `created_by` char(36) DEFAULT NULL,
  `amount` decimal(15,2) NOT NULL,
  `allocation_type` enum('manual','auto') NOT NULL DEFAULT 'auto',
  `description` varchar(255) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `chart_of_accounts`
--

CREATE TABLE `chart_of_accounts` (
  `id` char(36) NOT NULL,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `parent_id` char(36) DEFAULT NULL,
  `level` varchar(255) DEFAULT NULL,
  `order` varchar(255) DEFAULT NULL,
  `account_type_id` char(36) NOT NULL,
  `description` text DEFAULT NULL,
  `normal_balance` enum('DEBIT','CREDIT') NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_by` char(36) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `chart_of_accounts`
--

INSERT INTO `chart_of_accounts` (`id`, `code`, `name`, `parent_id`, `level`, `order`, `account_type_id`, `description`, `normal_balance`, `is_active`, `created_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
('010f231d-89cd-433b-968e-9831ab0acae0', '12500', 'Peralatan Kantor', '1980f7f4-9342-454b-b2ad-7546f8a9cef1', '2', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:22', '2026-10-26 10:07:22', NULL),
('0275447c-ef3a-42c0-a5a4-99e80174202d', '42500', 'Kontribusi Lainnya', 'ddb0233b-12c2-46fa-ac1a-ad64a6fdffe8', '3', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('07ea22a4-26b8-41f7-b72b-c83a72167d5b', '31200', 'Modal Lancar', '9d2e525c-d95f-4204-a442-f149853a1f89', '2', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567892', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:22', '2026-10-26 10:07:22', NULL),
('084d9998-26f9-4e60-9673-eb1464e6e379', '57100', 'Biaya Pelaksanaan Program', 'bc1b8182-25c0-488b-84d5-68c90b1ad23c', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('0f81ff76-3716-49c5-b62f-c2fe71ec69b3', '31100', 'Modal Tetap', '9d2e525c-d95f-4204-a442-f149853a1f89', '2', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567892', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:22', '2026-10-26 10:07:22', NULL),
('11e7e933-ef9b-4dde-a920-315f93980fbe', '42300', 'Kontribusi Bidang Ekonomi', 'ddb0233b-12c2-46fa-ac1a-ad64a6fdffe8', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('15d08eb5-60ee-4fca-a440-546aef11ff68', '52011', 'Biaya Kerumahtanggaan', '97d314b2-8775-48ce-859f-2d07ef6cd337', '3', '11', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('1638884c-8d9c-4db7-963a-f5169cb09400', '54100', 'Biaya Sidang Rutin, Pleno dll', 'b9326201-1b8c-47ba-ba37-9a815071060c', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('1980f7f4-9342-454b-b2ad-7546f8a9cef1', '12000', 'Aset Tidak Lancar', NULL, '1', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:22', '2026-10-26 10:07:22', NULL),
('1d075a3d-b8f1-4cbe-af32-d720d0b63d99', '57500', 'Biaya Pelaksanaan Program Kerjasama', 'bc1b8182-25c0-488b-84d5-68c90b1ad23c', '3', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:25', '2026-10-26 10:07:25', NULL),
('20e39474-a65a-4ca5-b57d-890040ebf0de', '12310', 'Akumulasi Depresiasi Kendaraan', '58045d05-2f17-4bdc-89cf-9e51f72eec73', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:22', '2026-10-26 10:07:22', NULL),
('2124ed4f-89b8-4141-867a-b8f727dea154', '57205', 'Biaya Program Pimbinaan Kader', 'c5805496-4642-4c37-902e-8e61bbbe0fe9', '4', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('25c9837f-2d00-4d5a-ac4f-3cca3986cd2c', '57202', 'Biaya Program Pendidikan Anak Usia Dini, Dasar dan Menengah', 'c5805496-4642-4c37-902e-8e61bbbe0fe9', '4', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('26f197be-d846-4c9b-ad42-3f1f7fd05e2b', '52014', 'Biaya Komunikasi', '97d314b2-8775-48ce-859f-2d07ef6cd337', '3', '14', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('282726c6-14ac-430f-a23f-d48de1ab7e5d', '44002', 'Kerjasama Eksternal', '711d6463-1665-4710-b2fb-30af0dc1e664', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('2d10b459-e593-4abe-9dd4-d1ae34a1db88', '57600', 'Biaya operasional ATC', 'bc1b8182-25c0-488b-84d5-68c90b1ad23c', '3', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:25', '2026-10-26 10:07:25', NULL),
('31fa7f1a-65f0-4946-b807-b688716c9ece', '12100', 'Tanah', '1980f7f4-9342-454b-b2ad-7546f8a9cef1', '2', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:22', '2026-10-26 10:07:22', NULL),
('321ea434-93c5-4d64-8ccf-b2b086e35f4d', '55300', 'Biaya Akomodasi', '8ac00223-9ddc-44f0-9003-883c1bca639c', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('33401409-a814-4d69-af88-e6aab94e65a4', '44004', 'Pendapatan Pembangunan ATC', '711d6463-1665-4710-b2fb-30af0dc1e664', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('345a9584-2788-47b3-978b-4dc9e20019ef', '52012', 'Biaya BBM', '97d314b2-8775-48ce-859f-2d07ef6cd337', '3', '12', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('34f0c888-19c7-49e6-b451-3ee517c89817', '51004', 'Uang Makan Karyawan & Staf', 'b1253b84-a194-4a34-aaa4-0ad25a5b753c', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('3572cceb-b225-4dde-8f96-84c95f5b389d', '52010', 'Biaya Pemeliharaan Peralatan Kantor', '97d314b2-8775-48ce-859f-2d07ef6cd337', '3', '10', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('359e2a06-6206-4452-a57b-0726a6f0ff95', '52300', 'Biaya surat kabar & langganan Media', '97d314b2-8775-48ce-859f-2d07ef6cd337', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('3977d722-ebce-4252-9cca-b4a65a22876f', '58300', 'Hadiah', 'c4e074ba-4570-423e-b8b6-5690453120b5', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:25', '2026-10-26 10:07:25', NULL),
('39cf7382-a796-4540-8639-119610794864', '57207', 'Biaya Program Majelis Hukum dan HAM', 'c5805496-4642-4c37-902e-8e61bbbe0fe9', '4', '7', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('3af6ca87-fdde-4bb2-ae53-4b547d814912', '44005', 'Pendapatan Inklusi', '711d6463-1665-4710-b2fb-30af0dc1e664', '3', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('3af9a1f6-445b-437c-8c17-733ac4f6b330', '52013', 'Biaya Parkir', '97d314b2-8775-48ce-859f-2d07ef6cd337', '3', '13', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('3bedac29-10e0-4a32-9e4a-f546f7a801e6', '11120', 'Kas di Bank Jatim', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:21', '2026-10-26 10:07:21', NULL),
('3ea66bfc-d9d9-4112-910d-3f79470a44d7', '41000', 'Pendapatan Organisasi', 'e571cb0d-59ea-4434-acaf-c49027e6102e', '2', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:22', '2026-10-26 10:07:22', NULL),
('3f2aae12-675c-4361-bbd7-46bade7fbc68', '42400', 'Kontribusi Media', 'ddb0233b-12c2-46fa-ac1a-ad64a6fdffe8', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('3f3ad8a4-e3a8-4264-bc0e-33a4b49d0344', '54400', 'Biaya Sidang Muktamar', 'b9326201-1b8c-47ba-ba37-9a815071060c', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('42205c22-6765-4780-9f84-6abfe4183ef1', '12200', 'Gedung', '1980f7f4-9342-454b-b2ad-7546f8a9cef1', '2', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:22', '2026-10-26 10:07:22', NULL),
('432d5f17-a71f-4269-830a-6eda6a711b30', '53200', 'Depresiasi Kendaraan', 'adbd3981-c5e2-4d1c-ad8f-517ef182665b', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('447417a0-c4a0-47d7-a26c-20ace6b277a5', '57400', 'Biaya Diskusi dan Kajian', 'bc1b8182-25c0-488b-84d5-68c90b1ad23c', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('4b1493eb-71c4-4fdc-9b94-862c313cfef5', '52200', 'Biaya Listrik, Telepon, Air, & Internet', '97d314b2-8775-48ce-859f-2d07ef6cd337', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('4d2150f9-61a1-4047-9f2e-18bf649e700b', '57210', 'Biaya Program Lingkungan Hidup dan Penanggulangan Bencana', 'c5805496-4642-4c37-902e-8e61bbbe0fe9', '4', '10', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('4dc29692-975f-482f-b7d0-ee44b410ce11', '55200', 'Biaya Transport Lokal', '8ac00223-9ddc-44f0-9003-883c1bca639c', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('502c6443-3788-46d5-842c-6907760bab5d', '52600', 'Biaya Pemeliharaan Gedung', '97d314b2-8775-48ce-859f-2d07ef6cd337', '3', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('53402b88-500b-4d58-a421-dc0370942f23', '12410', 'Akumulasi Depresiasi Meubel', '5542cf94-e5bd-46af-b6b3-54952a6d4da0', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:22', '2026-10-26 10:07:22', NULL),
('5542cf94-e5bd-46af-b6b3-54952a6d4da0', '12400', 'Meubel', '1980f7f4-9342-454b-b2ad-7546f8a9cef1', '2', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:22', '2026-10-26 10:07:22', NULL),
('5667a9b0-c57d-4c9e-bb39-5f38a587e649', '57208', 'Biaya Program Lembaga Budaya Seni dan Olah Raga', 'c5805496-4642-4c37-902e-8e61bbbe0fe9', '4', '8', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('58045d05-2f17-4bdc-89cf-9e51f72eec73', '12300', 'Kendaraan', '1980f7f4-9342-454b-b2ad-7546f8a9cef1', '2', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:22', '2026-10-26 10:07:22', NULL),
('58882c34-1ca0-4af9-8831-ab160748b48d', '31300', 'Selisih Lebih/Kurang', '9d2e525c-d95f-4204-a442-f149853a1f89', '2', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567892', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:22', '2026-10-26 10:07:22', NULL),
('5966307e-6e50-43da-aeb6-171a838e1ad1', '57209', 'Biaya Program Penelitian dan Pengembangan Aisyiyah', 'c5805496-4642-4c37-902e-8e61bbbe0fe9', '4', '9', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('5d121272-39ff-430a-9747-d2778985531c', '57204', 'Biaya Program Ekonomi dan Ketenagakerjaan', 'c5805496-4642-4c37-902e-8e61bbbe0fe9', '4', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('5d137200-2a11-49be-8ae4-b2f6e89d149b', '52100', 'Biaya Kertas & ATK', '97d314b2-8775-48ce-859f-2d07ef6cd337', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('5e2faaa4-6d8a-470b-8dc7-9944523b207d', '11200', 'Kas Bon', '98507351-f369-4453-b27c-000a2aa83ae7', '2', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:22', '2026-10-26 10:07:22', NULL),
('606cccc9-e4fd-4abe-9b27-2391c7302bc5', '51003', 'Insentif Lembur Karyawan & Staf', 'b1253b84-a194-4a34-aaa4-0ad25a5b753c', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('612982a1-3742-4197-bb24-19cd345b6ea3', '55100', 'Biaya Tiket', '8ac00223-9ddc-44f0-9003-883c1bca639c', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('647d236e-d87f-4fb2-8384-95f4aac31c1d', '54300', 'Biaya Sidang Tanwir', 'b9326201-1b8c-47ba-ba37-9a815071060c', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', '11100', 'Kas', '98507351-f369-4453-b27c-000a2aa83ae7', '2', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:21', '2026-10-26 10:07:21', NULL),
('652677ff-bda5-43aa-aebc-72b2316b1b2a', '54200', 'Biaya Sidang Muswil/Muspimwil/Konsolidasi & Pembinaan AMM', 'b9326201-1b8c-47ba-ba37-9a815071060c', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('69db5ffb-0401-4e45-8f5d-12dd818bfa89', '52400', 'Biaya Cetak-Cetak', '97d314b2-8775-48ce-859f-2d07ef6cd337', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('711d6463-1665-4710-b2fb-30af0dc1e664', '44000', 'Pendapatan Kerjasama', 'e571cb0d-59ea-4434-acaf-c49027e6102e', '2', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('722e32e0-3b7d-4927-90f1-5a733e1fb723', '41300', 'Zakat Infaq Shadaqoh Organisasi', '3ea66bfc-d9d9-4112-910d-3f79470a44d7', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:22', '2026-10-26 10:07:22', NULL),
('7703cbfd-b06b-4acf-97cc-7cf6f0b3d94c', '52500', 'Biaya Pengiriman', '97d314b2-8775-48ce-859f-2d07ef6cd337', '3', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('77feaec0-e773-4716-aac8-cd3b08e31d47', '41400', 'Muhammadiyah', '3ea66bfc-d9d9-4112-910d-3f79470a44d7', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:22', '2026-10-26 10:07:22', NULL),
('7dc4f8dd-9f03-45f2-aac9-4dfe20680aa4', '51001', 'Biaya Gaji Karyawan & Staf', 'b1253b84-a194-4a34-aaa4-0ad25a5b753c', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('803d85d9-ada0-4573-81dc-1b6384bd5d59', '44001', 'Kerjasama Internal', '711d6463-1665-4710-b2fb-30af0dc1e664', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('83b231e2-5339-4184-9cb3-6c3737bbee93', '43000', 'Pendapatan Jasa Bank (Neto)', 'e571cb0d-59ea-4434-acaf-c49027e6102e', '2', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('8ac00223-9ddc-44f0-9003-883c1bca639c', '55000', 'Biaya Perjalanan Dinas', 'dc0cb5c6-891f-4739-a748-25e00eff192a', '2', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('8d2b0181-1547-409b-a288-19954f2399be', '53300', 'Depresiasi Meubel', 'adbd3981-c5e2-4d1c-ad8f-517ef182665b', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('903dc389-7285-443b-a8d3-05b74405aaed', '57700', 'Biaya Pembangunan ATC', 'bc1b8182-25c0-488b-84d5-68c90b1ad23c', '3', '7', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:25', '2026-10-26 10:07:25', NULL),
('92f9968f-f894-4d26-be0c-654369502780', '41100', 'Iuran Anggota', '3ea66bfc-d9d9-4112-910d-3f79470a44d7', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:22', '2026-10-26 10:07:22', NULL),
('943a3993-3c67-42b4-9fd3-969319245e31', '11700', 'Kos Wonorejo', '98507351-f369-4453-b27c-000a2aa83ae7', '2', '7', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:22', '2026-10-26 10:07:22', NULL),
('95a7ed84-8c0a-4124-832b-c9c2b27017e4', '53400', 'Depresiasi Peralatan Kantor', 'adbd3981-c5e2-4d1c-ad8f-517ef182665b', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('96b49412-8021-4bec-9c3e-775fe44a76d6', '57800', 'Biaya Operasional Inklusi', 'bc1b8182-25c0-488b-84d5-68c90b1ad23c', '3', '8', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:25', '2026-10-26 10:07:25', NULL),
('97d314b2-8775-48ce-859f-2d07ef6cd337', '52000', 'Biaya Tata Usaha Administrasi Kantor', 'dc0cb5c6-891f-4739-a748-25e00eff192a', '2', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('98507351-f369-4453-b27c-000a2aa83ae7', '11000', 'Aset Lancar', NULL, '1', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:21', '2026-10-26 10:07:21', NULL),
('992bb6b7-dc96-40a4-844f-9ee27c6ea624', '12600', 'Investasi Jangka Panjang', '1980f7f4-9342-454b-b2ad-7546f8a9cef1', '2', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:22', '2026-10-26 10:07:22', NULL),
('9d2e525c-d95f-4204-a442-f149853a1f89', '31000', 'Aset Bersih', NULL, '1', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567892', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:22', '2026-10-26 10:07:22', NULL),
('9d630aba-892a-4099-9e12-2ad4fb685a96', '21000', 'Hutang Pihak Lain', NULL, '1', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567891', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:22', '2026-10-26 10:07:22', NULL),
('9e66ffab-1485-4411-87df-e2fd46e8dccc', '56000', 'Biaya Pengembangan SDM', 'dc0cb5c6-891f-4739-a748-25e00eff192a', '2', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('a07169ae-8be3-4db7-9fe0-9961831c418f', '11400', 'Piutang Lainnya', '98507351-f369-4453-b27c-000a2aa83ae7', '2', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:22', '2026-10-26 10:07:22', NULL),
('a15b742a-f0f8-45a0-9f92-6f4dd317a6c9', '42100', 'Kontribusi Bidang Pendidikan', 'ddb0233b-12c2-46fa-ac1a-ad64a6fdffe8', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('a1e86fce-2b4f-455c-b99a-8af1708dd4fd', '41600', 'Simpanan Wajib Peserta', '3ea66bfc-d9d9-4112-910d-3f79470a44d7', '3', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('a87aebbc-1b35-447a-a724-f1d62be1a44c', '57206', 'Biaya Program Kesejahteraan Sosial', 'c5805496-4642-4c37-902e-8e61bbbe0fe9', '4', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('a9d14811-0fb8-4c08-bc05-52c0a6539761', '44003', 'Pendapatan Sewa ATC', '711d6463-1665-4710-b2fb-30af0dc1e664', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('ad354b98-b236-4a1c-b7b5-e32757f43623', '51002', 'Honorarium/Kontrak', 'b1253b84-a194-4a34-aaa4-0ad25a5b753c', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('ad67895d-ef05-4fd3-965c-d793289a3c60', '11110', 'Kas Ditangan', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:21', '2026-10-26 10:07:21', NULL),
('adbd3981-c5e2-4d1c-ad8f-517ef182665b', '53000', 'Biaya Depresiasi Aset Tetap', 'dc0cb5c6-891f-4739-a748-25e00eff192a', '2', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('b1253b84-a194-4a34-aaa4-0ad25a5b753c', '51000', 'Biaya Personalia', 'dc0cb5c6-891f-4739-a748-25e00eff192a', '2', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('b1b4d087-609a-49e7-889a-92e06fac611d', '57203', 'Biaya Program Majelis Kesehatan', 'c5805496-4642-4c37-902e-8e61bbbe0fe9', '4', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('b3498af8-7715-4285-99c0-e838e553cc93', '12510', 'Akumulasi Depresiasi Peralatan Kantor', '010f231d-89cd-433b-968e-9831ab0acae0', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:22', '2026-10-26 10:07:22', NULL),
('b8e89210-2ad3-44b5-b835-c66c8f8d2f0c', '11130', 'Kas di Bank Jatim Dr. Soetomo', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:22', '2026-10-26 10:07:22', NULL),
('b9326201-1b8c-47ba-ba37-9a815071060c', '54000', 'Biaya Persidangan', 'dc0cb5c6-891f-4739-a748-25e00eff192a', '2', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('bc1b8182-25c0-488b-84d5-68c90b1ad23c', '57000', 'Biaya Program Organisasi', 'dc0cb5c6-891f-4739-a748-25e00eff192a', '2', '7', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('bd645eab-8d27-47ca-9e1e-eac912720710', '11500', 'Penyertaan Modal Bueka Assakinah', '98507351-f369-4453-b27c-000a2aa83ae7', '2', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:22', '2026-10-26 10:07:22', NULL),
('bd9eebb6-2213-449f-86bd-baf830297eac', '41200', 'Dana Wajib Organisasi', '3ea66bfc-d9d9-4112-910d-3f79470a44d7', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:22', '2026-10-26 10:07:22', NULL),
('c4e074ba-4570-423e-b8b6-5690453120b5', '58000', 'Biaya Kesejahteraan', 'dc0cb5c6-891f-4739-a748-25e00eff192a', '2', '8', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:25', '2026-10-26 10:07:25', NULL),
('c5805496-4642-4c37-902e-8e61bbbe0fe9', '57200', 'Biaya Pelaksanaan Program Majelis & Lembaga', 'bc1b8182-25c0-488b-84d5-68c90b1ad23c', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('c972f56b-7bcb-43be-836e-5409f39cfcc1', '58200', 'Dana Sehat Muhammadiyah', 'c4e074ba-4570-423e-b8b6-5690453120b5', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:25', '2026-10-26 10:07:25', NULL),
('cd26292d-ed27-4e29-af2f-d3bd7c9ccb94', '52015', 'Biaya Administrasi Kantor Lainnya', '97d314b2-8775-48ce-859f-2d07ef6cd337', '3', '15', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('cdc2398f-76f8-4a5e-8251-5afdc8a94d29', '41500', 'Dana Bantuan Organisasi Lainnya', '3ea66bfc-d9d9-4112-910d-3f79470a44d7', '3', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('ced6d26a-92a4-425f-803d-23a1675a27bb', '57300', 'Biaya kehumasan', 'bc1b8182-25c0-488b-84d5-68c90b1ad23c', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('d1f7b506-e20d-4272-8bdb-049198caa7ca', '51005', 'Tunjangan', 'b1253b84-a194-4a34-aaa4-0ad25a5b753c', '3', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('d232990b-5c62-4b8f-a09b-05d0c0802050', '42200', 'Kontribusi Bidang Kesehatan', 'ddb0233b-12c2-46fa-ac1a-ad64a6fdffe8', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('d2fd6adc-0357-4b77-ab00-0e4ae242b7ee', '52900', 'Biaya Pemeliharaan Meubel', '97d314b2-8775-48ce-859f-2d07ef6cd337', '3', '9', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('dc0cb5c6-891f-4739-a748-25e00eff192a', '50000', 'Beban Operasional', NULL, '1', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('dc604ee1-502c-456b-8b3d-006762ecedf2', '11140', 'Kas di Bank Bukopin Syariah', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:22', '2026-10-26 10:07:22', NULL),
('dc928dc1-d9d9-4c7f-bd29-1655d41d51c7', '57201', 'Biaya Program Majelis Tablig dan Ketarjihan', 'c5805496-4642-4c37-902e-8e61bbbe0fe9', '4', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('ddb0233b-12c2-46fa-ac1a-ad64a6fdffe8', '42000', 'Kontribusi Amal Usaha', 'e571cb0d-59ea-4434-acaf-c49027e6102e', '2', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('dedf1111-bfe7-4aca-b144-a8037b941ad1', '58100', 'Tunjangan Hari Raya', 'c4e074ba-4570-423e-b8b6-5690453120b5', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:25', '2026-10-26 10:07:25', NULL),
('e1574175-9eb0-4621-9821-fbcc6ab78709', '55400', 'Perdiem Pengiriman Utusan', '8ac00223-9ddc-44f0-9003-883c1bca639c', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('e2b8d9c8-2e37-4350-af98-f5fff13f743f', '52800', 'Biaya Asuransi kendaraan', '97d314b2-8775-48ce-859f-2d07ef6cd337', '3', '8', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL),
('e4ccc7de-a8b4-4e23-9840-21a940bb2e4c', '12210', 'Akumulasi Depresiasi Gedung', '42205c22-6765-4780-9f84-6abfe4183ef1', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:22', '2026-10-26 10:07:22', NULL),
('e571cb0d-59ea-4434-acaf-c49027e6102e', '40000', 'Pendapatan', NULL, '1', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:22', '2026-10-26 10:07:22', NULL),
('e6579eb2-defa-4737-a29d-3d38d6a8bbb6', '11600', 'Tabungan Bueka Assakinah', '98507351-f369-4453-b27c-000a2aa83ae7', '2', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:22', '2026-10-26 10:07:22', NULL),
('e7d35619-9874-4274-8a71-cd739d923554', '59000', 'Biaya Administrasi Bank', 'dc0cb5c6-891f-4739-a748-25e00eff192a', '2', '9', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:25', '2026-10-26 10:07:25', NULL),
('ea004e69-4772-48e3-93af-ac5874e2786c', '53100', 'Depresiasi Gedung', 'adbd3981-c5e2-4d1c-ad8f-517ef182665b', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:24', '2026-10-26 10:07:24', NULL),
('f0b2f862-b909-4d51-aab8-35aa1a569506', '11300', 'Piutang Karyawan', '98507351-f369-4453-b27c-000a2aa83ae7', '2', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 10:07:22', '2026-10-26 10:07:22', NULL),
('f6cb5434-a42a-41cc-8cd2-f7ebd46f485f', '59999', 'Biaya Sosial & Lainnya', 'dc0cb5c6-891f-4739-a748-25e00eff192a', '2', '10', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:25', '2026-10-26 10:07:25', NULL),
('fde4a381-dde7-4ade-b28c-92d51e46158e', '52700', 'Biaya Pemeliharaan Kendaraan', '97d314b2-8775-48ce-859f-2d07ef6cd337', '3', '7', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 10:07:23', '2026-10-26 10:07:23', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `closing_balances`
--

CREATE TABLE `closing_balances` (
  `id` char(36) NOT NULL,
  `period_id` char(36) DEFAULT NULL,
  `sub_period_id` char(36) NOT NULL,
  `chart_of_account_id` char(36) NOT NULL,
  `created_by` char(36) DEFAULT NULL,
  `balance_type` enum('DEBIT','CREDIT') NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `closing_balances`
--

INSERT INTO `closing_balances` (`id`, `period_id`, `sub_period_id`, `chart_of_account_id`, `created_by`, `balance_type`, `amount`, `created_at`, `updated_at`) VALUES
('01a17957-8d3e-725c-99e1-05c5afa16482', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 194604157.00, '2026-10-26 10:52:23', '2026-10-26 10:52:23'),
('01a17957-8d44-7259-9071-3a9d30cf45b2', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', 'ad67895d-ef05-4fd3-965c-d793289a3c60', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 4983047.00, '2026-10-26 10:52:23', '2026-10-26 10:52:23'),
('01a17957-8d4a-703d-9376-4218ecd2b9bc', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 385384747.00, '2026-10-26 10:52:23', '2026-10-26 10:52:23'),
('01a17957-8d4b-7285-875a-66135a0feba5', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', 'b8e89210-2ad3-44b5-b835-c66c8f8d2f0c', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 1156982563.00, '2026-10-26 10:52:23', '2026-10-26 10:52:23'),
('01a17957-8d4d-7307-909a-786ace8d138d', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', 'dc604ee1-502c-456b-8b3d-006762ecedf2', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 377940865.00, '2026-10-26 10:52:23', '2026-10-26 10:52:23'),
('01a17957-8d50-7331-a74d-138a6517273a', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', 'f0b2f862-b909-4d51-aab8-35aa1a569506', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 1800000.00, '2026-10-26 10:52:23', '2026-10-26 10:52:23'),
('01a17957-8d52-73c0-8765-12b9d1820652', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', 'bd645eab-8d27-47ca-9e1e-eac912720710', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 245583300.00, '2026-10-26 10:52:23', '2026-10-26 10:52:23'),
('01a17957-8d55-71cc-b797-23cb8fac9ffb', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', '58045d05-2f17-4bdc-89cf-9e51f72eec73', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 460769432.00, '2026-10-26 10:52:23', '2026-10-26 10:52:23'),
('01a17957-8d59-7219-8ef8-6743f56624e5', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', '20e39474-a65a-4ca5-b57d-890040ebf0de', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', 144000000.00, '2026-10-26 10:52:23', '2026-10-26 10:52:23'),
('01a17957-8d5d-7116-aab9-1a5ea48259af', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', '5542cf94-e5bd-46af-b6b3-54952a6d4da0', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 15500000.00, '2026-10-26 10:52:23', '2026-10-26 10:52:23'),
('01a17957-8d5f-7211-ae85-00edce44bebf', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', '53402b88-500b-4d58-a421-dc0370942f23', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', 13376668.00, '2026-10-26 10:52:23', '2026-10-26 10:52:23'),
('01a17957-8d62-7143-a77a-41a1c42fbe35', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', '010f231d-89cd-433b-968e-9831ab0acae0', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 46059000.00, '2026-10-26 10:52:23', '2026-10-26 10:52:23'),
('01a17957-8d65-7236-bbc4-c90b883f58aa', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', 'b3498af8-7715-4285-99c0-e838e553cc93', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', 25236667.00, '2026-10-26 10:52:23', '2026-10-26 10:52:23'),
('01a17957-8d67-7061-b6af-1aabcea3e44b', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', 'e6579eb2-defa-4737-a29d-3d38d6a8bbb6', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 676151976.00, '2026-10-26 10:52:23', '2026-10-26 10:52:23'),
('01a1a055-cf1e-7084-a643-aba6c8393bc6', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 267165132.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf25-73c4-93e2-e747bf3071b8', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 'ad67895d-ef05-4fd3-965c-d793289a3c60', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 1009977.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf26-7098-ba82-3f29911bad0e', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 624708833.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf28-72f5-af1a-90a91b61c8cd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 'b8e89210-2ad3-44b5-b835-c66c8f8d2f0c', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 957539479.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf2e-72eb-940f-ff10a6f2b40c', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 'dc604ee1-502c-456b-8b3d-006762ecedf2', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 91298375.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf2f-710b-abc7-52ef49bfbeb6', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 'f0b2f862-b909-4d51-aab8-35aa1a569506', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 1600000.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf31-72cf-a381-a6103c2e57fa', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 'bd645eab-8d27-47ca-9e1e-eac912720710', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 245583300.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf33-706c-838c-d1bbfd4e7fb0', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 'e6579eb2-defa-4737-a29d-3d38d6a8bbb6', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 676151976.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf34-722a-851b-8666287286cb', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '58045d05-2f17-4bdc-89cf-9e51f72eec73', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 460769432.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf36-7196-b60c-1fb3088e7ad8', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '20e39474-a65a-4ca5-b57d-890040ebf0de', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', 144000000.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf38-71ee-b70b-142a71c2867f', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '5542cf94-e5bd-46af-b6b3-54952a6d4da0', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 15500000.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf3a-70a9-a225-a6b82f4569f1', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '53402b88-500b-4d58-a421-dc0370942f23', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', 13376668.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf3b-7200-83da-38e04e2ab3c3', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '010f231d-89cd-433b-968e-9831ab0acae0', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 46059000.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf3d-71d6-953a-c400ff55f214', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 'b3498af8-7715-4285-99c0-e838e553cc93', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', 25236667.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf40-7027-9c7c-3889e6bced4f', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '5d121272-39ff-430a-9747-d2778985531c', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', -112520550.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf41-7168-b318-3099c4b16e8a', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 'e7d35619-9874-4274-8a71-cd739d923554', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', -503280.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf43-73c9-95ec-f2d8f6a783af', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '606cccc9-e4fd-4abe-9b27-2391c7302bc5', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', -800000.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf45-702a-9f39-551c80743ef1', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '652677ff-bda5-43aa-aebc-72b2316b1b2a', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', -456968000.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf47-72f7-b859-160ccfd61057', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '5d137200-2a11-49be-8ae4-b2f6e89d149b', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', -325000.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf4a-7104-af6a-1d6066dc7f8e', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '3af9a1f6-445b-437c-8c17-733ac4f6b330', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', -412500.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf4c-702b-82af-1b31192cf5d7', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', -289000000.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf4d-73db-9095-7993c91df807', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '77feaec0-e773-4716-aac8-cd3b08e31d47', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', -175000000.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf4f-72c6-a6c5-a30a410cedc5', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '4dc29692-975f-482f-b7d0-ee44b410ce11', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', -4637500.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf51-725e-b06d-fbab354caed6', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '4b1493eb-71c4-4fdc-9b94-862c313cfef5', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', -1780870.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf53-7017-92e6-6762551c8dab', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '084d9998-26f9-4e60-9673-eb1464e6e379', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', -64256175.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf55-72d2-97f4-4475445097fa', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '15d08eb5-60ee-4fca-a440-546aef11ff68', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', -402500.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf57-7022-a679-eda5bbfbee88', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '1638884c-8d9c-4db7-963a-f5169cb09400', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', -45000.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf59-70bb-aa8d-774c2e2aacc6', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '25c9837f-2d00-4d5a-ac4f-3cca3986cd2c', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', -702500.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf5b-72f1-ad3b-cc3859df3528', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '7703cbfd-b06b-4acf-97cc-7cf6f0b3d94c', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', -23000.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf5c-739a-9bf9-9225cc3ac712', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '2d10b459-e593-4abe-9dd4-d1ae34a1db88', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', -15190000.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf5e-73f8-8358-875dc18164df', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 'fde4a381-dde7-4ade-b28c-92d51e46158e', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', -4485500.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf60-726d-9cd0-0b3e392774fc', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '345a9584-2788-47b3-978b-4dc9e20019ef', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', -100000.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf62-7114-bdb8-258bc591cc28', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 'cd26292d-ed27-4e29-af2f-d3bd7c9ccb94', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', -730000.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf64-7138-93a4-0b10c0180a00', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '3977d722-ebce-4252-9cca-b4a65a22876f', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', -1350000.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf66-7193-9857-f85098f85fd7', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 'ad354b98-b236-4a1c-b7b5-e32757f43623', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', -1375000.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf68-722a-a3f4-d66c17bcc22a', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '7dc4f8dd-9f03-45f2-aac9-4dfe20680aa4', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', -4000000.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf6a-70fa-b958-b1a983464f0f', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '34f0c888-19c7-49e6-b451-3ee517c89817', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', -1000000.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf6d-7364-afba-577a7fb254e1', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 'f6cb5434-a42a-41cc-8cd2-f7ebd46f485f', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', -502500.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf6f-702a-91d3-abeb25154801', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '83b231e2-5339-4184-9cb3-6c3737bbee93', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', -2022410.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf71-73bd-a9f6-d30e8ecad282', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 'e571cb0d-59ea-4434-acaf-c49027e6102e', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', -8209500.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf73-73e9-9aac-127f9ffbfea0', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '711d6463-1665-4710-b2fb-30af0dc1e664', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', -5509500.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40'),
('01a1a055-cf75-72da-87fe-d45e4776f572', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '58882c34-1ca0-4af9-8831-ab160748b48d', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', 13994700.00, '2026-11-03 00:35:40', '2026-11-03 00:35:40');

-- --------------------------------------------------------

--
-- Struktur dari tabel `coa_balances`
--

CREATE TABLE `coa_balances` (
  `id` char(36) NOT NULL,
  `chart_of_account_id` char(36) NOT NULL,
  `period_id` char(36) NOT NULL,
  `sub_period_id` char(36) NOT NULL,
  `opening_balance` decimal(20,2) NOT NULL,
  `debit_total` decimal(20,2) NOT NULL,
  `credit_total` decimal(20,2) NOT NULL,
  `current_balance` decimal(20,2) NOT NULL,
  `last_transaction_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `coa_balances`
--

INSERT INTO `coa_balances` (`id`, `chart_of_account_id`, `period_id`, `sub_period_id`, `opening_balance`, `debit_total`, `credit_total`, `current_balance`, `last_transaction_at`, `deleted_at`, `created_at`, `updated_at`) VALUES
('01a17936-5e31-707f-963c-90d0c2d5f81c', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', 194604157.00, 0.00, 0.00, 194604157.00, '2026-10-26 10:16:08', NULL, '2026-10-26 10:16:08', '2026-10-26 10:16:08'),
('01a17936-cb43-72ac-b852-5df6d3c94890', 'ad67895d-ef05-4fd3-965c-d793289a3c60', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', 4983047.00, 0.00, 0.00, 4983047.00, '2026-10-26 10:16:36', NULL, '2026-10-26 10:16:36', '2026-10-26 10:16:36'),
('01a17937-399e-726a-be0f-8bdbfc5dff59', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', 385384747.00, 0.00, 0.00, 385384747.00, '2026-10-26 10:17:04', NULL, '2026-10-26 10:17:04', '2026-10-26 10:17:04'),
('01a17937-a0ba-706b-9e65-f936282e5bf0', 'b8e89210-2ad3-44b5-b835-c66c8f8d2f0c', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', 1156982563.00, 0.00, 0.00, 1156982563.00, '2026-10-26 10:17:31', NULL, '2026-10-26 10:17:31', '2026-10-26 10:17:31'),
('01a17937-fc75-7223-b441-ca0537d86b85', 'dc604ee1-502c-456b-8b3d-006762ecedf2', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', 377941047.00, 0.00, 0.00, 377941047.00, '2026-10-26 10:17:54', NULL, '2026-10-26 10:17:54', '2026-10-26 10:17:54'),
('01a17938-4bc1-7062-afbd-06b4f6864022', 'f0b2f862-b909-4d51-aab8-35aa1a569506', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', 1800000.00, 0.00, 0.00, 1800000.00, '2026-10-26 10:18:14', NULL, '2026-10-26 10:18:14', '2026-10-26 10:18:14'),
('01a17939-0bdb-7222-b966-5c40725561ea', 'bd645eab-8d27-47ca-9e1e-eac912720710', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', 245583300.00, 0.00, 0.00, 245583300.00, '2026-10-26 10:19:04', NULL, '2026-10-26 10:19:04', '2026-10-26 10:19:04'),
('01a1793a-22b6-7291-a8c3-3e7143402795', '58045d05-2f17-4bdc-89cf-9e51f72eec73', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', 460769432.00, 0.00, 0.00, 460769432.00, '2026-10-26 10:20:15', NULL, '2026-10-26 10:20:15', '2026-10-26 10:20:15'),
('01a1793a-8482-728d-b637-e2c0c616804f', '20e39474-a65a-4ca5-b57d-890040ebf0de', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', 144000000.00, 0.00, 0.00, 144000000.00, '2026-10-26 10:20:40', NULL, '2026-10-26 10:20:40', '2026-10-26 10:20:40'),
('01a1793a-d428-71af-ae90-d3db81704ce4', '5542cf94-e5bd-46af-b6b3-54952a6d4da0', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', 15500000.00, 0.00, 0.00, 15500000.00, '2026-10-26 10:21:00', NULL, '2026-10-26 10:21:00', '2026-10-26 10:21:00'),
('01a1793b-99bc-7169-9e73-2c448ef723e0', '53402b88-500b-4d58-a421-dc0370942f23', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', 13376668.00, 0.00, 0.00, 13376668.00, '2026-10-26 10:21:51', NULL, '2026-10-26 10:21:51', '2026-10-26 10:21:51'),
('01a1793b-ff72-7172-9871-2f9c5e8cb60c', '010f231d-89cd-433b-968e-9831ab0acae0', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', 46059000.00, 0.00, 0.00, 46059000.00, '2026-10-26 10:22:17', NULL, '2026-10-26 10:22:17', '2026-10-26 10:22:17'),
('01a1793c-7683-7298-b3ff-2fdd76864000', 'b3498af8-7715-4285-99c0-e838e553cc93', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', 25236667.00, 0.00, 0.00, 25236667.00, '2026-10-26 10:22:48', NULL, '2026-10-26 10:22:48', '2026-10-26 10:22:48'),
('01a1793e-e3b7-724e-94e2-4d892849c27c', 'e6579eb2-defa-4737-a29d-3d38d6a8bbb6', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', 676151976.00, 0.00, 0.00, 676151976.00, '2026-10-26 10:25:27', NULL, '2026-10-26 10:25:27', '2026-10-26 10:25:27'),
('01a17957-ffd8-722e-aec0-d06e2f4a770f', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 194604157.00, 425000000.00, 352439025.00, 267165132.00, '2026-10-26 11:56:52', NULL, '2026-10-26 10:52:52', '2026-10-26 11:56:52'),
('01a17958-4572-73b6-afd3-0f424b96edd2', 'ad67895d-ef05-4fd3-965c-d793289a3c60', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 4983047.00, 118402975.00, 122376045.00, 1009977.00, '2026-10-27 07:06:14', NULL, '2026-10-26 10:53:10', '2026-10-27 07:06:14'),
('01a17958-78e1-7294-8ed2-d49a55f807e0', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 385384747.00, 239415107.00, 91021.00, 624708833.00, '2026-10-27 07:52:29', NULL, '2026-10-26 10:53:23', '2026-10-27 07:52:29'),
('01a17959-141a-70ae-a249-58696efe8334', 'b8e89210-2ad3-44b5-b835-c66c8f8d2f0c', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 1156982563.00, 733644.00, 200176728.00, 957539479.00, '2026-10-27 07:57:16', NULL, '2026-10-26 10:54:03', '2026-10-27 07:57:16'),
('01a17959-491c-722d-9cf8-f0ab767b62dd', 'dc604ee1-502c-456b-8b3d-006762ecedf2', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 377941047.00, 28587359.00, 315230031.00, 91298375.00, '2026-10-27 08:22:03', NULL, '2026-10-26 10:54:16', '2026-10-27 08:22:03'),
('01a17959-7927-7266-9e16-048a1cfc6eb6', 'f0b2f862-b909-4d51-aab8-35aa1a569506', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 1800000.00, 0.00, 200000.00, 1600000.00, '2026-10-27 06:04:15', NULL, '2026-10-26 10:54:29', '2026-10-27 06:04:15'),
('01a17960-82fd-71ac-9545-ed41f125f8b0', 'bd645eab-8d27-47ca-9e1e-eac912720710', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 245583300.00, 0.00, 0.00, 245583300.00, '2026-10-26 11:02:10', NULL, '2026-10-26 11:02:10', '2026-10-26 11:02:10'),
('01a17960-c399-71dd-af19-ef931de77768', 'e6579eb2-defa-4737-a29d-3d38d6a8bbb6', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 676151976.00, 0.00, 0.00, 676151976.00, '2026-10-26 11:02:27', NULL, '2026-10-26 11:02:27', '2026-10-26 11:02:27'),
('01a17961-0bb3-7256-a7a5-7cd6c676920a', '58045d05-2f17-4bdc-89cf-9e51f72eec73', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 460769432.00, 0.00, 0.00, 460769432.00, '2026-10-26 11:02:45', NULL, '2026-10-26 11:02:45', '2026-10-26 11:02:45'),
('01a17961-465e-734f-a0a2-c04b61ac7a1a', '20e39474-a65a-4ca5-b57d-890040ebf0de', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 144000000.00, 0.00, 0.00, 144000000.00, '2026-10-26 11:03:00', NULL, '2026-10-26 11:03:00', '2026-10-26 11:03:00'),
('01a17961-9ff9-700e-acca-f9eed290b9ad', '5542cf94-e5bd-46af-b6b3-54952a6d4da0', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 15500000.00, 0.00, 0.00, 15500000.00, '2026-10-26 11:03:23', NULL, '2026-10-26 11:03:23', '2026-10-26 11:03:23'),
('01a17961-d8cf-7051-b2a5-8ac90de50c25', '53402b88-500b-4d58-a421-dc0370942f23', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 13376668.00, 0.00, 0.00, 13376668.00, '2026-10-26 11:03:38', NULL, '2026-10-26 11:03:38', '2026-10-26 11:03:38'),
('01a17962-1788-72b1-9778-5b487dcd1907', '010f231d-89cd-433b-968e-9831ab0acae0', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 46059000.00, 0.00, 0.00, 46059000.00, '2026-10-26 11:03:54', NULL, '2026-10-26 11:03:54', '2026-10-26 11:03:54'),
('01a17962-5f8f-7072-9aed-2d4eb099ed17', 'b3498af8-7715-4285-99c0-e838e553cc93', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 25236667.00, 0.00, 0.00, 25236667.00, '2026-10-26 11:04:12', NULL, '2026-10-26 11:04:12', '2026-10-26 11:04:12'),
('01a1796b-08cd-7069-ad47-22258a3c33a0', '5d121272-39ff-430a-9747-d2778985531c', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 0.00, 112520550.00, 0.00, -112520550.00, '2026-10-26 11:51:45', NULL, '2026-10-26 11:13:40', '2026-10-26 11:51:45'),
('01a1796b-bb06-71c4-b8d0-822899861899', 'e7d35619-9874-4274-8a71-cd739d923554', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 0.00, 503280.00, 0.00, -503280.00, '2026-10-27 08:22:03', NULL, '2026-10-26 11:14:25', '2026-10-27 08:22:03'),
('01a1796c-87df-70d8-aded-d97a5d4c05d1', '606cccc9-e4fd-4abe-9b27-2391c7302bc5', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 0.00, 800000.00, 0.00, -800000.00, '2026-10-27 07:06:14', NULL, '2026-10-26 11:15:18', '2026-10-27 07:06:14'),
('01a17970-e6e8-7319-9d51-98d9ad7aab39', '652677ff-bda5-43aa-aebc-72b2316b1b2a', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 0.00, 456968000.00, 0.00, -456968000.00, '2026-10-27 08:20:18', NULL, '2026-10-26 11:20:04', '2026-10-27 08:20:18'),
('01a17970-e715-7174-bf5f-4f6b0757e308', '5d137200-2a11-49be-8ae4-b2f6e89d149b', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 0.00, 325000.00, 0.00, -325000.00, '2026-10-27 06:55:20', NULL, '2026-10-26 11:20:04', '2026-10-27 06:55:20'),
('01a17970-e73c-726c-8f38-86fa5ddd1d79', '3af9a1f6-445b-437c-8c17-733ac4f6b330', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 0.00, 412500.00, 0.00, -412500.00, '2026-10-27 06:02:36', NULL, '2026-10-26 11:20:04', '2026-10-27 06:02:36'),
('01a17980-2bd4-701a-b3a5-9d8596e6e92e', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 0.00, 0.00, 289000000.00, -289000000.00, '2026-10-27 07:51:40', NULL, '2026-10-26 11:36:45', '2026-10-27 07:51:40'),
('01a1798e-d073-73be-aa5e-46362ca36b1b', '77feaec0-e773-4716-aac8-cd3b08e31d47', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 0.00, 0.00, 175000000.00, -175000000.00, '2026-10-26 11:52:45', NULL, '2026-10-26 11:52:45', '2026-10-26 11:52:45'),
('01a17991-38bb-7052-b6d7-76ff6ec595a0', '4dc29692-975f-482f-b7d0-ee44b410ce11', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 0.00, 4637500.00, 0.00, -4637500.00, '2026-10-27 07:06:14', NULL, '2026-10-26 11:55:22', '2026-10-27 07:06:14'),
('01a17d79-0aa1-718e-82a6-ef6663393db9', '4b1493eb-71c4-4fdc-9b94-862c313cfef5', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 0.00, 1780870.00, 0.00, -1780870.00, '2026-10-27 07:06:14', NULL, '2026-10-27 06:07:27', '2026-10-27 07:06:14'),
('01a17d7b-72b5-72ff-88c7-98ee4f629588', '084d9998-26f9-4e60-9673-eb1464e6e379', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 0.00, 64256175.00, 0.00, -64256175.00, '2026-10-27 08:21:25', NULL, '2026-10-27 06:10:04', '2026-10-27 08:21:25'),
('01a17d84-2ee4-7287-9a66-700a463c9fba', '15d08eb5-60ee-4fca-a440-546aef11ff68', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 0.00, 402500.00, 0.00, -402500.00, '2026-10-27 06:19:37', NULL, '2026-10-27 06:19:37', '2026-10-27 06:19:37'),
('01a17d84-2ef9-72ab-bbcc-506da3333511', '1638884c-8d9c-4db7-963a-f5169cb09400', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 0.00, 45000.00, 0.00, -45000.00, '2026-10-27 06:19:37', NULL, '2026-10-27 06:19:37', '2026-10-27 06:19:37'),
('01a17d84-2f02-723f-8f0c-9a755c98480a', '25c9837f-2d00-4d5a-ac4f-3cca3986cd2c', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 0.00, 702500.00, 0.00, -702500.00, '2026-10-27 06:21:13', NULL, '2026-10-27 06:19:37', '2026-10-27 06:21:13'),
('01a17d86-aa37-738d-829d-e678863544c7', '7703cbfd-b06b-4acf-97cc-7cf6f0b3d94c', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 0.00, 23000.00, 0.00, -23000.00, '2026-10-27 06:22:19', NULL, '2026-10-27 06:22:19', '2026-10-27 06:22:19'),
('01a17d8a-ee65-7147-b7ed-6dbb88014899', '2d10b459-e593-4abe-9dd4-d1ae34a1db88', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 0.00, 15190000.00, 0.00, -15190000.00, '2026-10-27 06:26:59', NULL, '2026-10-27 06:26:59', '2026-10-27 06:26:59'),
('01a17d90-51b7-708c-95f5-9163aea8315d', 'fde4a381-dde7-4ade-b28c-92d51e46158e', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 0.00, 4702500.00, 217000.00, -4485500.00, '2026-10-27 06:45:08', NULL, '2026-10-27 06:32:52', '2026-10-27 06:45:08'),
('01a17d92-54e1-7232-be4e-d4d722683cb8', '345a9584-2788-47b3-978b-4dc9e20019ef', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 0.00, 100000.00, 0.00, -100000.00, '2026-10-27 06:35:04', NULL, '2026-10-27 06:35:04', '2026-10-27 06:35:04'),
('01a17d9d-fcad-72d6-8226-42f39cbb7208', 'cd26292d-ed27-4e29-af2f-d3bd7c9ccb94', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 0.00, 730000.00, 0.00, -730000.00, '2026-10-27 06:55:58', NULL, '2026-10-27 06:47:48', '2026-10-27 06:55:58'),
('01a17da3-e005-7209-a0c1-75115a3efa03', '3977d722-ebce-4252-9cca-b4a65a22876f', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 0.00, 1350000.00, 0.00, -1350000.00, '2026-10-27 06:59:50', NULL, '2026-10-27 06:54:14', '2026-10-27 06:59:50'),
('01a17da6-85e6-7112-99ca-9855c4ba938f', 'ad354b98-b236-4a1c-b7b5-e32757f43623', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 0.00, 1375000.00, 0.00, -1375000.00, '2026-10-27 06:57:07', NULL, '2026-10-27 06:57:07', '2026-10-27 06:57:07'),
('01a17dae-dc27-7375-b250-1d6990b747df', '7dc4f8dd-9f03-45f2-aac9-4dfe20680aa4', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 0.00, 4000000.00, 0.00, -4000000.00, '2026-10-27 07:06:14', NULL, '2026-10-27 07:06:14', '2026-10-27 07:06:14'),
('01a17dae-dc34-7359-8506-4d560de6b413', '34f0c888-19c7-49e6-b451-3ee517c89817', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 0.00, 1000000.00, 0.00, -1000000.00, '2026-10-27 07:06:14', NULL, '2026-10-27 07:06:14', '2026-10-27 07:06:14'),
('01a17dae-dc91-733f-b0a0-ce8012475249', 'f6cb5434-a42a-41cc-8cd2-f7ebd46f485f', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 0.00, 502500.00, 0.00, -502500.00, '2026-10-27 07:06:14', NULL, '2026-10-27 07:06:14', '2026-10-27 07:06:14'),
('01a17dd4-316f-72eb-84f0-54e5da8b8d81', '83b231e2-5339-4184-9cb3-6c3737bbee93', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 0.00, 0.00, 2022410.00, -2022410.00, '2026-10-27 08:16:13', NULL, '2026-10-27 07:47:00', '2026-10-27 08:16:13'),
('01a17de9-de7d-724b-b7af-88701cf4cb81', 'e571cb0d-59ea-4434-acaf-c49027e6102e', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 0.00, 0.00, 8209500.00, -8209500.00, '2026-10-27 08:15:04', NULL, '2026-10-27 08:10:41', '2026-10-27 08:15:04'),
('01a17deb-7497-73ee-bf3b-3ffae6ae6e1d', '711d6463-1665-4710-b2fb-30af0dc1e664', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 0.00, 0.00, 5509500.00, -5509500.00, '2026-10-27 08:12:25', NULL, '2026-10-27 08:12:25', '2026-10-27 08:12:25'),
('01a17dec-59d1-70ff-a677-4625d612448b', '58882c34-1ca0-4af9-8831-ab160748b48d', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', 0.00, 0.00, 13994700.00, 13994700.00, '2026-10-27 08:13:23', NULL, '2026-10-27 08:13:23', '2026-10-27 08:13:23'),
('01a1a056-18e1-7252-bc81-9f71095bdd78', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', '01a1792e-5372-735b-9610-0a8975517760', '01a1a055-aa31-705d-8a07-8046c7f96db0', 267165132.00, 0.00, 0.00, 267165132.00, '2026-11-03 00:35:59', NULL, '2026-11-03 00:35:59', '2026-11-03 00:35:59'),
('01a1a056-52d6-73b5-961f-3043f9a35f88', 'ad67895d-ef05-4fd3-965c-d793289a3c60', '01a1792e-5372-735b-9610-0a8975517760', '01a1a055-aa31-705d-8a07-8046c7f96db0', 1009977.00, 0.00, 0.00, 1009977.00, '2026-11-03 00:36:14', NULL, '2026-11-03 00:36:14', '2026-11-03 00:36:14'),
('01a1a056-87f6-71be-9d52-11f7c8c6ff3d', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', '01a1792e-5372-735b-9610-0a8975517760', '01a1a055-aa31-705d-8a07-8046c7f96db0', 624708833.00, 0.00, 0.00, 624708833.00, '2026-11-03 00:36:27', NULL, '2026-11-03 00:36:27', '2026-11-03 00:36:27'),
('01a1a056-e693-73e8-956a-7c7972dff985', 'b8e89210-2ad3-44b5-b835-c66c8f8d2f0c', '01a1792e-5372-735b-9610-0a8975517760', '01a1a055-aa31-705d-8a07-8046c7f96db0', 957539479.00, 0.00, 0.00, 957539479.00, '2026-11-03 00:36:52', NULL, '2026-11-03 00:36:52', '2026-11-03 00:36:52'),
('01a1a057-2176-719f-b716-bc2591a56236', 'dc604ee1-502c-456b-8b3d-006762ecedf2', '01a1792e-5372-735b-9610-0a8975517760', '01a1a055-aa31-705d-8a07-8046c7f96db0', 91298375.00, 0.00, 0.00, 91298375.00, '2026-11-03 00:37:07', NULL, '2026-11-03 00:37:07', '2026-11-03 00:37:07'),
('01a1a057-592f-7047-8430-51f35e52fb48', 'f0b2f862-b909-4d51-aab8-35aa1a569506', '01a1792e-5372-735b-9610-0a8975517760', '01a1a055-aa31-705d-8a07-8046c7f96db0', 1600000.00, 0.00, 0.00, 1600000.00, '2026-11-03 00:37:21', NULL, '2026-11-03 00:37:21', '2026-11-03 00:37:21'),
('01a1a057-af36-71bd-83b4-3f1c7ab634ad', 'bd645eab-8d27-47ca-9e1e-eac912720710', '01a1792e-5372-735b-9610-0a8975517760', '01a1a055-aa31-705d-8a07-8046c7f96db0', 245583300.00, 0.00, 0.00, 245583300.00, '2026-11-03 00:37:43', NULL, '2026-11-03 00:37:43', '2026-11-03 00:37:43'),
('01a1a058-0697-709f-a7c4-d76fbdff2504', 'e6579eb2-defa-4737-a29d-3d38d6a8bbb6', '01a1792e-5372-735b-9610-0a8975517760', '01a1a055-aa31-705d-8a07-8046c7f96db0', 676151976.00, 0.00, 0.00, 676151976.00, '2026-11-03 00:38:05', NULL, '2026-11-03 00:38:05', '2026-11-03 00:38:05'),
('01a1a058-a671-7021-bc1f-876ebeef9a51', '58045d05-2f17-4bdc-89cf-9e51f72eec73', '01a1792e-5372-735b-9610-0a8975517760', '01a1a055-aa31-705d-8a07-8046c7f96db0', 460769432.00, 0.00, 0.00, 460769432.00, '2026-11-03 00:38:46', NULL, '2026-11-03 00:38:46', '2026-11-03 00:38:46'),
('01a1a058-dad5-700c-af06-26da1f38c678', '20e39474-a65a-4ca5-b57d-890040ebf0de', '01a1792e-5372-735b-9610-0a8975517760', '01a1a055-aa31-705d-8a07-8046c7f96db0', 144000000.00, 0.00, 0.00, 144000000.00, '2026-11-03 00:39:00', NULL, '2026-11-03 00:39:00', '2026-11-03 00:39:00'),
('01a1a059-12e7-7388-afa7-9a3e96607462', '5542cf94-e5bd-46af-b6b3-54952a6d4da0', '01a1792e-5372-735b-9610-0a8975517760', '01a1a055-aa31-705d-8a07-8046c7f96db0', 15500000.00, 0.00, 0.00, 15500000.00, '2026-11-03 00:39:14', NULL, '2026-11-03 00:39:14', '2026-11-03 00:39:14'),
('01a1a059-473f-7008-b463-66e530c759d1', '53402b88-500b-4d58-a421-dc0370942f23', '01a1792e-5372-735b-9610-0a8975517760', '01a1a055-aa31-705d-8a07-8046c7f96db0', 13376668.00, 0.00, 0.00, 13376668.00, '2026-11-03 00:39:27', NULL, '2026-11-03 00:39:27', '2026-11-03 00:39:27'),
('01a1a059-8334-72a4-89bb-58bcf9e51319', 'b3498af8-7715-4285-99c0-e838e553cc93', '01a1792e-5372-735b-9610-0a8975517760', '01a1a055-aa31-705d-8a07-8046c7f96db0', 25236667.00, 0.00, 0.00, 25236667.00, '2026-11-03 00:39:43', NULL, '2026-11-03 00:39:43', '2026-11-03 00:39:43');

-- --------------------------------------------------------

--
-- Struktur dari tabel `coa_requests`
--

CREATE TABLE `coa_requests` (
  `id` char(36) NOT NULL,
  `requester_id` char(36) NOT NULL,
  `approver_id` char(36) DEFAULT NULL,
  `parent_coa_id` char(36) DEFAULT NULL,
  `account_type_id` char(36) NOT NULL,
  `sub_period_id` char(36) DEFAULT NULL,
  `proposed_name` varchar(255) NOT NULL,
  `proposed_code` varchar(255) DEFAULT NULL,
  `normal_balance` enum('DEBIT','CREDIT') NOT NULL,
  `status` enum('pending','approved','rejected','canceled') NOT NULL DEFAULT 'pending',
  `description` text DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `approval_notes` text DEFAULT NULL,
  `rejected_at` timestamp NULL DEFAULT NULL,
  `rejection_reason` text DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `configurations`
--

CREATE TABLE `configurations` (
  `id` char(36) NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `type` enum('string','integer','boolean','array','json','image') NOT NULL DEFAULT 'string',
  `description` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `configurations`
--

INSERT INTO `configurations` (`id`, `key`, `value`, `type`, `description`, `is_active`, `created_at`, `updated_at`) VALUES
('01a1792e-395a-7003-9842-7346227b9173', 'APP_NAME', 'My Laravel App', 'string', 'Nama aplikasi yang akan ditampilkan di berbagai tempat seperti judul halaman.', 1, '2026-10-26 10:07:14', '2026-10-26 10:07:14'),
('01a1792e-3995-7255-a7e4-3bd492b9db04', 'APP_DESCRIPTION', 'Sistem Informasi Akuntansi untuk pengelolaan keuangan, jurnal, dan laporan secara terintegrasi.', 'string', 'Deskripsi singkat tentang aplikasi yang dapat digunakan untuk SEO atau ditampilkan di halaman utama.', 1, '2026-10-26 10:07:14', '2026-10-26 10:07:14'),
('01a1792e-39b3-72bb-8b6d-c8077d63393c', 'APP_TAGLINE', 'Sistem Informasi Akuntansi untuk pengelolaan keuangan, jurnal, dan laporan secara terintegrasi.', 'string', 'Tagline atau slogan yang menggambarkan nilai utama aplikasi.', 1, '2026-10-26 10:07:14', '2026-10-26 10:07:14'),
('01a1792e-39d0-7117-a5e2-72a211a30389', 'APP_LOGO', NULL, 'image', 'Logo aplikasi yang akan ditampilkan di header atau halaman login.', 1, '2026-10-26 10:07:15', '2026-10-26 10:07:15'),
('01a1792e-39eb-719c-9636-e17dd0cd0db5', 'APP_BACKGROUND_LOGIN', NULL, 'image', 'Gambar latar belakang untuk halaman login aplikasi.', 1, '2026-10-26 10:07:15', '2026-10-26 10:07:15');

-- --------------------------------------------------------

--
-- Struktur dari tabel `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `journals`
--

CREATE TABLE `journals` (
  `id` char(36) NOT NULL,
  `journal_number` varchar(255) NOT NULL,
  `journal_date` date NOT NULL,
  `description` text DEFAULT NULL,
  `total_debit` decimal(15,2) NOT NULL,
  `total_credit` decimal(15,2) NOT NULL,
  `posted_by` char(36) DEFAULT NULL,
  `posted_at` datetime DEFAULT NULL,
  `period_id` char(36) NOT NULL,
  `sub_period_id` char(36) DEFAULT NULL,
  `transaction_id` char(36) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `journals`
--

INSERT INTO `journals` (`id`, `journal_number`, `journal_date`, `description`, `total_debit`, `total_credit`, `posted_by`, `posted_at`, `period_id`, `sub_period_id`, `transaction_id`, `created_at`, `updated_at`) VALUES
('01a17966-d197-70cc-ab47-b8c416c9dcb7', 'JR-EXP-20261026180903', '2023-01-02', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301021122537792517 Pengisian kas operasional', 2000000.00, 2000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-26 18:09:03', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17966-d181-7074-8789-cedca4e44b34', '2026-10-26 11:09:03', '2026-10-26 11:09:03'),
('01a17969-afae-7387-ba13-9c0928c7a4ab', 'JR-EXP-20261026181211', '2023-01-05', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301051121506253692 Tim UMPRO audensi dengan Gubernur', 3000000.00, 3000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-26 18:12:11', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17969-af99-7125-8ddf-efcc84b9cb69', '2026-10-26 11:12:11', '2026-10-26 11:12:11'),
('01a1796b-08ba-70a4-b833-1d3e6df0c5bf', 'JR-EXP-20261026181340', '2023-01-05', 'Transfer ke BSI norek. 7187244565 an. ABD Rochim reff. 2301051121506826136 Pembangunan Café termin ke 4', 60000000.00, 60000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-26 18:13:40', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a1796b-08a3-71eb-9ba7-aea0e1e6d807', '2026-10-26 11:13:40', '2026-10-26 11:13:40'),
('01a1796b-baf8-7186-afea-c098c5e1f232', 'JR-EXP-20261026181425', '2023-01-05', 'Administrasi Bank', 2500.00, 2500.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-26 18:14:25', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a1796b-baec-7017-b530-ca664f132e7e', '2026-10-26 11:14:25', '2026-10-26 11:14:25'),
('01a1796c-87d9-7145-b044-249585918731', 'JR-EXP-20261026181518', '2023-01-05', 'Uang Lembur Yuli untuk persiapan pemeriksaan laporan keuangan (09.00 - 21.00)', 200000.00, 200000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-26 18:15:18', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a1796c-87c5-71cc-bc43-d128253b5312', '2026-10-26 11:15:18', '2026-10-26 11:15:18'),
('01a17970-e6d3-7158-af3b-d5b74c9367fb', 'JR-EXP-20261026182004', '2023-01-07', 'Tambahan transport Rapat persiapan verifikasi keuangan (17 Des 2017) an Kristin Muslimah dan Transport verifikasi LK (6,7,8 Jan 2023) an Kristin Muslimah (PDA Kediri) dan Tambahan transport Rapat persiapan verifikasi keuangan (17 Des 2017) an. Zubaidatul Hidayah dan Transport verifikasi LK (6,7,8 Jan 2023) an Zubaidatul Hidayah (PDA Sidoarjo) dan Tambahan transport Rapat persiapan verifikasi keuangan (17 Des 2017) an. Martiningsih dan Transport verifikasi LK (6,7,8 Jan 2023) an Martiningsih (PDA Ponorogo) dan Pembelian Klip (yuli) dan Tinta print Data Print, lem, isi staples dan Transfer ke Mandiri Norek. 1400075255555 an. Nawasaka Wisesa reff. 2301071122547782273 untuk pelunasan hotel (full board) dan Parkir', 11805000.00, 11805000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-26 18:20:04', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17970-e6a1-7344-9896-eec5738b2bf2', '2026-10-26 11:20:04', '2026-10-26 11:20:04'),
('01a17974-9c0f-7366-a34c-250af0baa1c1', 'JR-EXP-20261026182407', '2023-01-08', 'Transfer ke Bank Jatim Norek. 6202209605 an. Siti Zubaidatul Hidayah (PDA Sidoarjo) reff. JMB371957650 untuk pembayaran honor verifikasi keuangan Aisyiyah dan Transfer ke Bank Syariah Indonesia Norek. 7181048365 an. Martiningsih (PDA Ponorogo) reff. 2301081121511786044 untuk pembayaran honor verifikasi keuangan Aisyiyah dan Biaya administrasi bank dan Transfer ke Bank BRI Norek. 625301004203538  an. Kristin Muslimah (PDA Kediri) reff.  497918192617 untuk pembayaran honor verifikasi keuangan Aisyiyah dan Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301081122548316455 untuk pembayaran honor pendamping verifikasi LK Aisyiyah dan Pembayaran honor pendamping verifikasi LK Aisyiyah 3 hari di tambah transpot (Bu Candra Rp. 1.000.000, biaya admin bank Rp. 2500  Bu Anna Marina Rp. 750.000 biaya bank 2500  Bu Heni Rp. 2.500.000 dan Biaya administrasi bank', 9757500.00, 9757500.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-26 18:24:07', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17974-9bf0-70aa-a6b7-9022aebba6ec', '2026-10-26 11:24:07', '2026-10-26 11:24:07'),
('01a17976-f387-7315-befb-e87f091ee5ad', 'JR-EXP-20261026182641', '2023-01-10', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref. 2301101122551693942 Operasional ATC dan Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301101121515400945 Keperluan tim verifikasi, dana surat keterangan konsultan, dan pembuatan laporan 1% dari dana hibah', 43912975.00, 43912975.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-26 18:26:41', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17976-f378-72c3-b569-23411b62c3bf', '2026-10-26 11:26:41', '2026-10-26 11:26:41'),
('01a17977-d257-73bc-957c-b5bccade54a8', 'JR-EXP-20261026182738', '2023-01-13', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301131122557316522 untuk kebutuhan Muswil', 35000000.00, 35000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-26 18:27:38', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17977-d24d-702a-9a46-2669b9f696a9', '2026-10-26 11:27:38', '2026-10-26 11:27:38'),
('01a1797b-3287-73eb-8deb-20feba9f018d', 'JR-EXP-20261026183119', '2023-01-13', 'Pengisian Kas Bendahara dari Bank Jatim Soetomo', 200000000.00, 200000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-26 18:31:19', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a1797b-327a-7329-bfb4-f91464c4c06d', '2026-10-26 11:31:19', '2026-10-26 11:31:19'),
('01a1797c-a1cf-7271-8da0-3492c7ee5349', 'JR-EXP-20261026183253', '2023-01-16', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301131122557316522 untuk kebutuhan Muswil', 19700000.00, 19700000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-26 18:32:53', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a1797c-a1bc-71b4-828b-8320156d3ce2', '2026-10-26 11:32:53', '2026-10-26 11:32:53'),
('01a17980-2bbf-734d-b2a5-082ae2873bf4', 'JR-INC-20261026183645', '2023-01-21', 'Pemasukan dari Gubernur Jatim untuk bantuan Muswil diberikan ke bu Candra tunai', 50000000.00, 50000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-26 18:36:45', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17980-2bb2-71fa-aeb5-16c2cc75f59d', '2026-10-26 11:36:45', '2026-10-26 11:36:45'),
('01a17982-39df-7226-9ae3-5e2f4cc0e83d', 'JR-EXP-20261026183900', '2023-01-24', 'Transfer ke BRI Norek. 115901020724505 an. Fitrijah Hidajati ref. 2301241122573568558 untuk kekurangan dana Muswil dan Biaya Administrasi Bank', 100002500.00, 100002500.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-26 18:39:00', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17982-39d4-70e3-8370-126e795fb2e8', '2026-10-26 11:39:00', '2026-10-26 11:39:00'),
('01a1798d-e68f-729d-9122-5b76a1b9c8ba', 'JR-EXP-20261026185145', '2023-01-25', 'Transfer ke BCA an. Rahmad Deky Zakaria Norek. 0190548848 ref.2301251121539574926 untuk membayaran interior termin 1 dan Biaya Administrasi Bank', 52523050.00, 52523050.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-26 18:51:45', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a1798d-e66d-7357-be23-56892312b096', '2026-10-26 11:51:45', '2026-10-26 11:51:45'),
('01a1798e-d061-70f5-b5ad-16717f7b2871', 'JR-INC-20261026185245', '2023-01-27', 'Pemasukan bantuan Muswil dari PWM (cek bank Muamalat)', 175000000.00, 175000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-26 18:52:45', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a1798e-d057-7220-9879-455af2f76612', '2026-10-26 11:52:45', '2026-10-26 11:52:45'),
('01a17991-38af-737d-af5d-10513edd7daf', 'JR-EXP-20261026185522', '2023-01-27', 'Transport (grab) mengantar cek bank Muamallat dan mencairkan cek bank Muamalllat di Jl. Darmo Surabaya, Administrasi bank (yuli) dan Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301271122579384345 untuk honor pegawai PWA', 9535500.00, 9535500.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-26 18:55:22', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17991-38a0-7318-ad56-503bc8f435da', '2026-10-26 11:55:22', '2026-10-26 11:55:22'),
('01a17992-9740-73f5-b48a-58f22c41f3a4', 'JR-EXP-20261026185652', '2023-01-31', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301311122586946308 untuk kas operasional', 5000000.00, 5000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-26 18:56:52', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17992-972d-71b4-aaf2-624e6abae914', '2026-10-26 11:56:52', '2026-10-26 11:56:52'),
('01a17d74-9a15-705b-a898-fdaa98ecb7f7', 'JR-EXP-20261027130236', '2023-01-01', 'Transfer Parkir + Biaya', 402500.00, 402500.00, '01a1792e-5292-7359-a09b-260b0c33e831', '2026-10-27 13:02:36', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17d74-9a06-714e-b562-3632207e3b12', '2026-10-27 06:02:36', '2026-10-27 06:02:36'),
('01a17d76-1f1c-7182-b86a-2d813f764ad6', 'JR-INC-20261027130415', '2023-01-01', 'Cicilan 3 Pak Edi', 200000.00, 200000.00, '01a1792e-5292-7359-a09b-260b0c33e831', '2026-10-27 13:04:15', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17d76-1f0c-702b-af44-def1f293e711', '2026-10-27 06:04:15', '2026-10-27 06:04:15'),
('01a17d79-0a8b-717a-88ef-d7c925f2c434', 'JR-EXP-20261027130726', '2023-01-02', 'Transfer Transport Tim Panlih Daerah dan Zoom', 1045500.00, 1045500.00, '01a1792e-5292-7359-a09b-260b0c33e831', '2026-10-27 13:07:26', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17d79-0a76-7368-9163-f333afa1d400', '2026-10-27 06:07:26', '2026-10-27 06:07:26'),
('01a17d7b-72a5-7354-963f-9d0641b4fa7d', 'JR-EXP-20261027131004', '2023-01-03', 'Listrik Desember Pesma dan Honor Pembina Mahasiswa (B Asmawati) dan Honor Pembina Mahasiswa (B Faridah) dan Honor Pembina Mahasiswa (B Fitriyah) dan Honor Pembina Mahasiswa (B Enik) dan Sopir ke Asrama Haji', 2580500.00, 2580500.00, '01a1792e-5292-7359-a09b-260b0c33e831', '2026-10-27 13:10:04', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17d7b-7290-7112-93bc-35763e65d74d', '2026-10-27 06:10:04', '2026-10-27 06:10:04'),
('01a17d7c-fb28-7230-aa16-2ca87c4b35e4', 'JR-EXP-20261027131145', '2023-01-04', 'Listrik Gg 3 No 33', 661700.00, 661700.00, '01a1792e-5292-7359-a09b-260b0c33e831', '2026-10-27 13:11:45', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17d7c-fb0c-71bb-8249-dc454815cedd', '2026-10-27 06:11:45', '2026-10-27 06:11:45'),
('01a17d7e-0605-7016-8492-9c3079352732', 'JR-EXP-20261027131253', '2023-01-05', 'Transfer Transport & Akomodasi Tim UMPO Survey', 1002500.00, 1002500.00, '01a1792e-5292-7359-a09b-260b0c33e831', '2026-10-27 13:12:53', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17d7e-05f9-7281-b15e-ef8b6d599177', '2026-10-27 06:12:53', '2026-10-27 06:12:53'),
('01a17d81-5d6d-72e4-a7ca-395cfc549c9c', 'JR-EXP-20261027131632', '2023-01-06', 'Honor Pembina Mahasiswa (B Candra) dan Honor Pembina Mahasiswa (B Rukmini) dan Honor Pembina Mahasiswa (B Sugiarti) dan Transfer Tansport Rapat Panlih & Audensi ke PWM dan Transport Tim Panlih Daerah Lamongan dan Konsumsi Rapat & Audensi PWM dan Konsumsi Audensi Ahlul Bait dan Grab B Heni', 2925000.00, 2925000.00, '01a1792e-5292-7359-a09b-260b0c33e831', '2026-10-27 13:16:32', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17d81-5d4b-73b1-8cb3-6efb59ff2648', '2026-10-27 06:16:32', '2026-10-27 06:16:32'),
('01a17d84-2ed9-7186-90e3-19b4579c1c03', 'JR-EXP-20261027131937', '2023-01-07', 'Transfer Iuran RT 2 Bln 2 Rumah dan Transfer Transport Acara M. Dikdas di Malang Mobil PWA dan Gojek Riwa Riwi Hotel dan Bensin & Tol Acara M. Dikdasmen di Malang Mobil B Lutfah', 1350000.00, 1350000.00, '01a1792e-5292-7359-a09b-260b0c33e831', '2026-10-27 13:19:37', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17d84-2ec8-70ec-a8a9-ae8658bb4210', '2026-10-27 06:19:37', '2026-10-27 06:19:37'),
('01a17d85-a5a8-7384-80f0-06ee58f31580', 'JR-EXP-20261027132113', '2023-01-08', 'Transfer Sarapan Acara M. Dikdasmen di Malang dan Grab Bawa Berkas ke PWM', 377500.00, 377500.00, '01a1792e-5292-7359-a09b-260b0c33e831', '2026-10-27 13:21:13', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17d85-a595-71d0-a6ed-1a88073847f6', '2026-10-27 06:21:13', '2026-10-27 06:21:13'),
('01a17d86-aa31-73fc-98e5-ffedd1b8a1c6', 'JR-EXP-20261027132219', '2023-01-09', 'Gosend B Heni', 23000.00, 23000.00, '01a1792e-5292-7359-a09b-260b0c33e831', '2026-10-27 13:22:19', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17d86-aa26-706d-a0c8-d64b3dd7ecf2', '2026-10-27 06:22:19', '2026-10-27 06:22:19'),
('01a17d8a-ee45-7159-9d70-4ba618b1d67f', 'JR-EXP-20261027132659', '2023-01-10', 'Transfer Transport Audensi ke Gubernur & Takziyah Ayah B Umi H dan Transfer Keperluan Ke Asrama Haji dan Transfer Honor Pembina Mahasiswa (B UMMAH) dan Operasional ATC Jan - Maret dan Transfer Dana Pph 1,5 % Dana Srt Keterangan Konsultan dan Pembuatan Laporan 1 % dan Transfer Honor Pembina Mahasiswa (B Umi T) dan Transfer Honor Pembina Mahasiswa (B Ana) dan Transfer Transport Menghadiri dan Transfer Transport Rapat Pimpinan di ATC 3 Mobil dan Konsumsi Rapat di ATC', 43007975.00, 43007975.00, '01a1792e-5292-7359-a09b-260b0c33e831', '2026-10-27 13:26:59', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17d8a-ee2b-7285-956a-9e32ac702117', '2026-10-27 06:26:59', '2026-10-27 06:26:59'),
('01a17d8c-6d5e-7138-94ef-602172c61507', 'JR-EXP-20261027132837', '2023-01-11', 'Transfer Honor Pembina Mahasiswa (B. Ila & P Rosidin) dan Kekurangan Rapat Di ATC', 2069000.00, 2069000.00, '01a1792e-5292-7359-a09b-260b0c33e831', '2026-10-27 13:28:37', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17d8c-6d4c-737e-921f-bc91f259556e', '2026-10-27 06:28:37', '2026-10-27 06:28:37'),
('01a17d8d-c5e3-72fb-be82-4581c9591773', 'JR-EXP-20261027133005', '2023-01-12', 'Indihome', 327730.00, 327730.00, '01a1792e-5292-7359-a09b-260b0c33e831', '2026-10-27 13:30:05', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17d8d-c5cd-7316-9d47-58a68cf88f46', '2026-10-27 06:30:05', '2026-10-27 06:30:05'),
('01a17d8f-1148-72b0-a689-e49f3e64d423', 'JR-EXP-20261027133130', '2023-01-13', 'Transfer Dana Musywil dan PDAM rumah rungkut', 30070440.00, 30070440.00, '01a1792e-5292-7359-a09b-260b0c33e831', '2026-10-27 13:31:30', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17d8f-113b-70a0-948b-92ab405ad41b', '2026-10-27 06:31:30', '2026-10-27 06:31:30'),
('01a17d90-51b0-71ba-86bc-4ebad4e2c3ce', 'JR-EXP-20261027133252', '2023-01-16', 'Transfer Servis Inova Hitam dan Transfer Keperluan Pesma 1 Semester', 19705000.00, 19705000.00, '01a1792e-5292-7359-a09b-260b0c33e831', '2026-10-27 13:32:52', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17d90-51a2-73e6-8830-7a589760c782', '2026-10-27 06:32:52', '2026-10-27 06:32:52'),
('01a17d92-54da-7315-9bab-11c9e88cae19', 'JR-EXP-20261027133504', '2023-01-17', 'Bensin dan Transport Rapat dari Malang (Panlih & Persiapan Musywil) dan Transport Tim Panlih Daerah (lamongan & Gresik) dan Gocar Mbk Nurul dari PWA', 1183500.00, 1183500.00, '01a1792e-5292-7359-a09b-260b0c33e831', '2026-10-27 13:35:04', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17d92-54cf-72f8-ae9f-7d2fcebab9d8', '2026-10-27 06:35:04', '2026-10-27 06:35:04'),
('01a17d9b-8cc6-7360-ae86-90f60a100543', 'JR-INC-20261027134508', '2023-01-17', 'Saldo Servis Inova Hitam', 217000.00, 217000.00, '01a1792e-5292-7359-a09b-260b0c33e831', '2026-10-27 13:45:08', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17d9b-8cae-7344-be2e-fe39864bbc40', '2026-10-27 06:45:08', '2026-10-27 06:45:08'),
('01a17d9d-fc9d-7287-948f-f2cd44579a5a', 'JR-EXP-20261027134748', '2023-01-18', 'Stempel LPPA dan Gocar Mbk Nurul dari PWA', 251500.00, 251500.00, '01a1792e-5292-7359-a09b-260b0c33e831', '2026-10-27 13:47:48', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17d9d-fc88-710a-ae6f-a9eb3c98419c', '2026-10-27 06:47:48', '2026-10-27 06:47:48'),
('01a17d9e-a365-701b-8d0a-f0b87df34312', 'JR-EXP-20261027134830', '2023-01-19', 'Gosend Undangan Pembukaan Musywil', 13000.00, 13000.00, '01a1792e-5292-7359-a09b-260b0c33e831', '2026-10-27 13:48:30', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17d9e-a35b-7061-8236-4cdd96a4a781', '2026-10-27 06:48:30', '2026-10-27 06:48:30'),
('01a17da3-dff7-737b-9853-4852cbcd0dbb', 'JR-EXP-20261027135414', '2023-01-22', 'Transfer Karangan Bunga Musywil PWM dan Transport Tim Verifikasi dari Ponorogo (Musywil) dan Pengembalian Kelebihan Transfer Dana Musywil (Sampang) dan Pengembalian SWP Musywil (KLL)', 1900000.00, 1900000.00, '01a1792e-5292-7359-a09b-260b0c33e831', '2026-10-27 13:54:14', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17da3-dfe8-72b3-b7ef-ba4aee560f65', '2026-10-27 06:54:14', '2026-10-27 06:54:14'),
('01a17da4-e1e3-73e7-a83e-70f3a9095af5', 'JR-EXP-20261027135520', '2023-01-24', 'Materai dan Transport & Uang Makan Monev Pemprov ke Asrama ATC', 650000.00, 650000.00, '01a1792e-5292-7359-a09b-260b0c33e831', '2026-10-27 13:55:20', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17da4-e1d7-71f9-81c6-14632be9a012', '2026-10-27 06:55:20', '2026-10-27 06:55:20'),
('01a17da5-7634-701b-89e3-6c60eb77c9f2', 'JR-EXP-20261027135558', '2023-01-26', 'Contener 82L', 555000.00, 555000.00, '01a1792e-5292-7359-a09b-260b0c33e831', '2026-10-27 13:55:58', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17da5-7626-70af-bc40-48dbba531f9d', '2026-10-27 06:55:58', '2026-10-27 06:55:58'),
('01a17da6-85df-7281-b5b6-c5ff487f6f7a', 'JR-EXP-20261027135707', '2023-01-27', 'Transfer Honor Media Ig 27 Konten SIA 1 dan Transfer Transport Acara DP3AK 2 Kali', 1527500.00, 1527500.00, '01a1792e-5292-7359-a09b-260b0c33e831', '2026-10-27 13:57:07', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17da6-85d4-714d-8ba0-610d21aa7838', '2026-10-27 06:57:07', '2026-10-27 06:57:07'),
('01a17da7-6607-706a-b0ac-6ef8f4da4668', 'JR-EXP-20261027135805', '2023-01-28', 'Transfer Transport Acara ke Gresik', 452500.00, 452500.00, '01a1792e-5292-7359-a09b-260b0c33e831', '2026-10-27 13:58:05', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17da7-65fa-72f6-a7a5-4f190e4d83fc', '2026-10-27 06:58:05', '2026-10-27 06:58:05'),
('01a17da8-ffef-7031-8e47-2405b4d4af94', 'JR-EXP-20261027135949', '2023-01-30', 'Transfer Karangan Bunga Warek UMSIDA dan Keperluan Rapat Tim 11 di ATC', 1989700.00, 1989700.00, '01a1792e-5292-7359-a09b-260b0c33e831', '2026-10-27 13:59:49', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17da8-ffdf-737b-b1dc-d66fece257e6', '2026-10-27 06:59:49', '2026-10-27 06:59:49'),
('01a17dae-dc1b-7285-957c-8ddc15fe18b2', 'JR-EXP-20261027140614', '2023-01-31', 'Transfer Honor (Hikma) dan Uang Makan dan Insentif  Musywil dan Transfer Honor l (Yuli) dan Uang Makan dan Insentif  Musywil dan Pulsa Operasional dan Transport Operasional Ke BSB dan B Heni dan Transfer Tansport Ke Nganjuk (Menghadiri) dan Transport dari Malang (Tamu Kodam) dan Bensin Mobil PWA (Tamu Kodam) dan Sopir Mobil PWA (Tamu Kodam) dan Transfer Takziyah Ke PAk Ali Laziz MU', 8305000.00, 8305000.00, '01a1792e-5292-7359-a09b-260b0c33e831', '2026-10-27 14:06:14', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dae-dbd4-7306-9f4d-8dfc4af69d7e', '2026-10-27 07:06:14', '2026-10-27 07:06:14'),
('01a17dbd-dc27-727c-87e6-63f3892127ed', 'JR-INC-20261027142237', '2023-01-04', 'Sumbangan Musywil Bagus Irawa', 1000000.00, 1000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:22:37', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dbd-dc1e-71c1-bcef-76dd0da2806d', '2026-10-27 07:22:37', '2026-10-27 07:22:37'),
('01a17dbe-5ed4-7014-9411-07909a00b66f', 'JR-INC-20261027142310', '2023-01-04', 'Sumbangan Musywil UMSurabaya', 25000000.00, 25000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:23:10', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dbe-5ecc-725a-b911-e8512fc61018', '2026-10-27 07:23:10', '2026-10-27 07:23:10'),
('01a17dbe-ffc4-7321-a86d-6b43a4b03efc', 'JR-INC-20261027142351', '2023-01-04', 'Pemasukan', 300000.00, 300000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:23:51', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dbe-ffb2-73f2-8788-6c82fade3fed', '2026-10-27 07:23:51', '2026-10-27 07:23:51'),
('01a17dbf-81f5-71e6-953e-fe1640ee25f6', 'JR-INC-20261027142425', '2023-01-05', 'Sumbangan Musywil SMP M 2 Taman', 3000000.00, 3000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:24:25', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dbf-81e9-7090-be05-dddf377a58a1', '2026-10-27 07:24:25', '2026-10-27 07:24:25'),
('01a17dc0-5d6e-72f0-8913-da03fa6a99ab', 'JR-INC-20261027142521', '2023-01-05', 'Sumbangan RSA Dahlan Kediri', 7500000.00, 7500000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:25:21', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dc0-5d62-7114-9c41-20d0e7e219c7', '2026-10-27 07:25:21', '2026-10-27 07:25:21'),
('01a17dc0-f1d3-73bb-a263-2e1b730bcc19', 'JR-INC-20261027142559', '2023-01-05', 'Sumbangan SMA M 2 Surabaya', 5000000.00, 5000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:25:59', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dc0-f1c3-71dd-bbbe-117fdb7fb5c3', '2026-10-27 07:25:59', '2026-10-27 07:25:59'),
('01a17dc1-9a0b-7285-ba1e-0777ea7c035d', 'JR-INC-20261027142642', '2023-01-05', 'Sumbangan RSI Aisyiyah Malang', 10000000.00, 10000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:26:42', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dc1-9a03-72fa-8f1f-f7e55fd763b9', '2026-10-27 07:26:42', '2026-10-27 07:26:42'),
('01a17dc2-3f13-7390-8843-0ecdcff17807', 'JR-INC-20261027142724', '2023-01-05', 'Sumbangan Musywil RSIA Nganjuk', 20000000.00, 20000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:27:24', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dc2-3f07-7154-82a9-da03ee0d4e86', '2026-10-27 07:27:24', '2026-10-27 07:27:24'),
('01a17dc3-5a3f-7164-bfc0-35629a3f89a5', 'JR-INC-20261027142837', '2023-01-05', 'Sumbangan Musywil SMA M 2 Sidoarjo', 5000000.00, 5000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:28:37', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dc3-5a34-70e8-b247-635f308d2e2c', '2026-10-27 07:28:37', '2026-10-27 07:28:37'),
('01a17dc4-4ab0-7074-ac5a-bc6766414f07', 'JR-INC-20261027142938', '2023-01-06', 'Sumbangan Musywil SDM 1 Sidoarjo', 1500000.00, 1500000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:29:38', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dc4-4aa7-7218-a00a-804273587661', '2026-10-27 07:29:38', '2026-10-27 07:29:38'),
('01a17dc4-d4a8-701c-b8ff-57be0b404fb7', 'JR-INC-20261027143013', '2023-01-06', 'Sumbangan Musywil SMP M 1 Sidoarjo', 3000000.00, 3000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:30:13', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dc4-d49a-7215-862e-0df01df505d3', '2026-10-27 07:30:13', '2026-10-27 07:30:13'),
('01a17dc5-6fc2-7050-b376-8ec2baf8ab8d', 'JR-INC-20261027143053', '2023-01-06', 'Pembayaran Simpanan Wajib Organisasi', 2250000.00, 2250000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:30:53', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dc5-6f8b-70a7-bf52-c15e2977426a', '2026-10-27 07:30:53', '2026-10-27 07:30:53'),
('01a17dc5-fb5e-7057-8f66-f01047e74b55', 'JR-INC-20261027143129', '2023-01-06', 'Sumbangan Musywil UMSIDA', 5000000.00, 5000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:31:29', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dc5-fb54-7165-9734-16cb382277fb', '2026-10-27 07:31:29', '2026-10-27 07:31:29'),
('01a17dc6-94e4-71ed-b0dc-667194ce1899', 'JR-INC-20261027143208', '2023-01-06', 'Sumbangan Musywil RS Aisyiyah Bojonegoro', 10000000.00, 10000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:32:08', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dc6-94d8-71e1-affb-d0c25037e0ca', '2026-10-27 07:32:08', '2026-10-27 07:32:08'),
('01a17dc7-1a60-716a-b2c9-73688845aa55', 'JR-INC-20261027143242', '2023-01-06', 'Sumbangan Musywil SMA M Gresik', 5000000.00, 5000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:32:42', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dc7-1a58-726b-a06d-d3835c80ef2a', '2026-10-27 07:32:42', '2026-10-27 07:32:42'),
('01a17dc7-97ff-70ae-8704-0cd1040ab90b', 'JR-INC-20261027143315', '2023-01-07', 'Sumbangan Musywil UMJ', 5000000.00, 5000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:33:15', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dc7-97f5-7074-b03f-db444ff1854e', '2026-10-27 07:33:15', '2026-10-27 07:33:15'),
('01a17dc8-31f7-708e-af97-87e245ec94b5', 'JR-INC-20261027143354', '2023-01-09', 'Irvand Gustari', 2500000.00, 2500000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:33:54', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dc8-31ea-71b3-a229-1e738e2cf4f5', '2026-10-27 07:33:54', '2026-10-27 07:33:54'),
('01a17dc8-bd77-7175-897a-5d87551ca846', 'JR-INC-20261027143430', '2023-01-09', 'Mumtaz ( Aad)', 10000000.00, 10000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:34:30', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dc8-bd69-7155-a990-b8cde1810de8', '2026-10-27 07:34:30', '2026-10-27 07:34:30'),
('01a17dc9-4bbc-734e-87e8-cc1653182a98', 'JR-INC-20261027143506', '2023-01-09', 'UM Lamongan', 5000000.00, 5000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:35:06', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dc9-4bb3-70f3-91e5-741e4406ce89', '2026-10-27 07:35:06', '2026-10-27 07:35:06'),
('01a17dc9-ce2d-7397-8802-7554369bb41f', 'JR-INC-20261027143539', '2023-01-09', 'M Idaham.', 1000000.00, 1000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:35:39', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dc9-ce20-72cc-8c43-c3b9fb9695da', '2026-10-27 07:35:39', '2026-10-27 07:35:39'),
('01a17dca-5902-710f-923d-8c9a071fd231', 'JR-INC-20261027143615', '2023-01-09', 'SMPM 12 GKB', 3000000.00, 3000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:36:15', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dca-58f8-710a-bc1c-c45ba6bf15af', '2026-10-27 07:36:15', '2026-10-27 07:36:15'),
('01a17dca-bf35-71b8-adf0-574cd4db1885', 'JR-INC-20261027143641', '2023-01-10', 'RSU Aisyiyah Ponorogo', 20000000.00, 20000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:36:41', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dca-bf2c-715c-b820-1b2fb7b3c8ac', '2026-10-27 07:36:41', '2026-10-27 07:36:41'),
('01a17dcb-3056-72f7-ba11-acc2c1fdc21e', 'JR-INC-20261027143710', '2023-01-11', 'Ati Fatur.', 250000.00, 250000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:37:10', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dcb-3048-7116-8e1c-98f0d1467bac', '2026-10-27 07:37:10', '2026-10-27 07:37:10'),
('01a17dcb-bcfd-71ff-b763-ad806994bf5c', 'JR-INC-20261027143746', '2023-01-12', 'Asrofi', 700000.00, 700000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:37:46', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dcb-bcf4-705a-ab28-0f40c73dead5', '2026-10-27 07:37:46', '2026-10-27 07:37:46'),
('01a17dcc-3b00-725a-a86e-660c02622cb9', 'JR-INC-20261027143818', '2023-01-12', 'Prof Zaenudin M', 10000000.00, 10000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:38:18', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dcc-3af0-73ee-b70a-1be7e64000d7', '2026-10-27 07:38:18', '2026-10-27 07:38:18'),
('01a17dcc-a106-714c-933e-ccfef04f196f', 'JR-INC-20261027143844', '2023-01-12', 'SMKM 7 Gondang', 5000000.00, 5000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:38:44', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dcc-a0f2-7221-a5bb-70f6de82170f', '2026-10-27 07:38:44', '2026-10-27 07:38:44'),
('01a17dcd-281a-735b-8f2e-4743c6c19dd0', 'JR-INC-20261027143919', '2023-01-13', 'Pemasukan', 3000000.00, 3000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:39:19', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dcd-280d-725c-8732-b5534a86b120', '2026-10-27 07:39:19', '2026-10-27 07:39:19'),
('01a17dcd-c4da-7394-b127-44b811248b3e', 'JR-INC-20261027143959', '2023-01-13', 'RSM Gresik', 10000000.00, 10000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:39:59', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dcd-c4c4-73d8-b11d-b2967a6cfa71', '2026-10-27 07:39:59', '2026-10-27 07:39:59'),
('01a17dce-47c4-71f5-bcfb-0821fbf5fb6b', 'JR-INC-20261027144033', '2023-01-13', 'SD M 2 GKB', 2500000.00, 2500000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:40:33', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dce-47ac-7227-89f1-e0f7ccbceb5a', '2026-10-27 07:40:33', '2026-10-27 07:40:33'),
('01a17dcf-1464-70d9-8ae6-dbf02f201985', 'JR-INC-20261027144125', '2023-01-13', 'Nur Hayati', 250000.00, 250000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:41:25', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dcf-145b-7129-8327-b3dc55ecf4c3', '2026-10-27 07:41:25', '2026-10-27 07:41:25'),
('01a17dcf-75bd-7285-aefb-96a4bfbc7d34', 'JR-INC-20261027144150', '2023-01-13', 'dr. Qonita', 1000000.00, 1000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:41:50', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dcf-75af-739e-8230-07ea38d8fa2e', '2026-10-27 07:41:50', '2026-10-27 07:41:50'),
('01a17dcf-d537-7330-8b26-c65b643c1c13', 'JR-INC-20261027144214', '2023-01-15', 'SMAM 10 Gresik', 2500000.00, 2500000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:42:14', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dcf-d525-70ee-a9eb-b46e3f326095', '2026-10-27 07:42:14', '2026-10-27 07:42:14'),
('01a17dd0-751a-7142-a35f-3ca0dfef5629', 'JR-INC-20261027144255', '2023-01-15', 'PAN Jatim', 20000000.00, 20000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:42:55', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dd0-7510-72f0-96a5-dae16265494e', '2026-10-27 07:42:55', '2026-10-27 07:42:55'),
('01a17dd2-c21a-7245-ae79-c014f93602eb', 'JR-EXP-20261027144526', '2023-01-16', 'Pembayaran pajak tabungan', 83021.00, 83021.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:45:26', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dd2-c20c-713a-b5a9-4ed906bf8d8a', '2026-10-27 07:45:26', '2026-10-27 07:45:26'),
('01a17dd4-315c-72ae-a51a-02cf1d777591', 'JR-INC-20261027144700', '2023-01-16', 'Penerimaan bunga tabungan', 415107.00, 415107.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:47:00', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dd4-3151-7339-992d-68936cd17902', '2026-10-27 07:47:00', '2026-10-27 07:47:00'),
('01a17dd4-ed99-7381-a883-e63ffc5819e9', 'JR-INC-20261027144748', '2023-01-18', 'RS Siti Khodijah', 10000000.00, 10000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:47:48', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dd4-ed91-70e2-a44c-7b2cdae43faa', '2026-10-27 07:47:48', '2026-10-27 07:47:48'),
('01a17dd5-708c-720c-a629-a1ed15199ada', 'JR-INC-20261027144822', '2023-01-18', 'Parahita', 5000000.00, 5000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:48:22', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dd5-7082-71ed-b5b1-19c850e6b220', '2026-10-27 07:48:22', '2026-10-27 07:48:22'),
('01a17dd6-30ec-7137-a8e6-3b21d7cfef16', 'JR-INC-20261027144911', '2023-01-18', 'Universitas Muhammadiyah Gresik', 5000000.00, 5000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:49:11', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dd6-30df-709d-a329-6a66c76838c3', '2026-10-27 07:49:11', '2026-10-27 07:49:11'),
('01a17dd6-c6d8-707e-990d-ef6c5a47245e', 'JR-INC-20261027144950', '2023-01-19', 'Muhajir', 500000.00, 500000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:49:50', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dd6-c6cc-7217-bb31-29b026691fd9', '2026-10-27 07:49:50', '2026-10-27 07:49:50'),
('01a17dd7-630c-72fb-9b91-a568fa3fd33d', 'JR-INC-20261027145030', '2023-01-20', 'Widati Muhajir', 10000000.00, 10000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:50:30', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dd7-62fe-71bd-96e6-129d5ac18c7d', '2026-10-27 07:50:30', '2026-10-27 07:50:30'),
('01a17dd7-f6ef-7161-8217-f3c5c6ad5727', 'JR-INC-20261027145107', '2023-01-21', 'Pemasukan', 250000.00, 250000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:51:07', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dd7-f6e5-710c-b430-b72c74f3ad5b', '2026-10-27 07:51:07', '2026-10-27 07:51:07'),
('01a17dd8-775f-720c-b69e-48da90b7edc8', 'JR-INC-20261027145140', '2023-01-28', 'Pemasukan', 3000000.00, 3000000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:51:40', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dd8-7755-72d6-b00c-1851c22495bc', '2026-10-27 07:51:40', '2026-10-27 07:51:40'),
('01a17dd9-34b7-71c8-bd27-ebebffba9d2f', 'JR-EXP-20261027145229', '2023-01-27', 'Pembayaran adminitrasi tabungan', 8000.00, 8000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:52:29', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dd9-34a2-71ae-90a6-d3db7938991b', '2026-10-27 07:52:29', '2026-10-27 07:52:29'),
('01a17ddc-3800-713d-8203-cad95f9c8657', 'JR-INC-20261027145546', '2023-01-01', 'Penerimaan bunga dari bank', 733644.00, 733644.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:55:46', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17ddc-37f7-7110-8cff-be4dd3f89ac6', '2026-10-27 07:55:46', '2026-10-27 07:55:46'),
('01a17ddc-f7f3-7050-93dd-c237ec75b31a', 'JR-EXP-20261027145635', '2023-01-01', 'Pembayaran pajak tabungan', 146728.00, 146728.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:56:35', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17ddc-f7d9-70f1-8e0c-2ebbd5029691', '2026-10-27 07:56:35', '2026-10-27 07:56:35'),
('01a17ddd-94dc-7155-a176-118b80a8252c', 'JR-EXP-20261027145715', '2023-01-27', 'Biaya Admin Giro', 30000.00, 30000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 14:57:15', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17ddd-94d1-700a-a623-859e3fe29ea3', '2026-10-27 07:57:15', '2026-10-27 07:57:15'),
('01a17de9-de6c-7318-a245-83376d640383', 'JR-INC-20261027151041', '2023-01-02', 'TRF DR INDAH UMU CHILMI BRI', 2400000.00, 2400000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 15:10:41', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17de9-de63-7123-9545-fdb8f5f145e0', '2026-10-27 08:10:41', '2026-10-27 08:10:41'),
('01a17dea-7a7d-71e7-935e-306807690b8c', 'JR-INC-20261027151121', '2023-01-02', 'Bagi Hasil', 529300.00, 529300.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 15:11:21', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dea-7a71-731f-a74f-f05d47528657', '2026-10-27 08:11:21', '2026-10-27 08:11:21'),
('01a17deb-7489-7264-bcf2-948fb1eb5b37', 'JR-INC-20261027151225', '2023-01-09', 'SPP Mahasiswa KIP UMSIDA dari Kota Mojoerto', 5509500.00, 5509500.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 15:12:25', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17deb-7481-7070-8c36-35e08ea37bc5', '2026-10-27 08:12:25', '2026-10-27 08:12:25'),
('01a17dec-59bc-72ec-93d4-065c4c6bd162', 'JR-INC-20261027151323', '2023-01-12', 'TRF DR BPK MUKHTAMIL PRA BANK BNI', 13994700.00, 13994700.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 15:13:23', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dec-59b1-73a8-b2b8-f1572bcaa35c', '2026-10-27 08:13:23', '2026-10-27 08:13:23'),
('01a17ded-10f4-706d-a735-7efc62f4afc9', 'JR-INC-20261027151410', '2023-01-14', 'TRF DR Bank Bukopin Syari Dummy', 2593500.00, 2593500.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 15:14:10', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17ded-10ed-7035-81b7-d530edb65749', '2026-10-27 08:14:10', '2026-10-27 08:14:10'),
('01a17ded-e182-739d-a6f7-d594f46378a2', 'JR-INC-20261027151504', '2023-01-31', 'Pemasukan', 3216000.00, 3216000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 15:15:04', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17ded-e175-725b-a452-3a9bb6bfc430', '2026-10-27 08:15:04', '2026-10-27 08:15:04'),
('01a17dee-eef2-708b-bfb5-98a2c34f8cb7', 'JR-INC-20261027151613', '2023-01-31', 'Bagi Hasil', 344359.00, 344359.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 15:16:13', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17dee-eeea-7151-a39b-606f051116f9', '2026-10-27 08:16:13', '2026-10-27 08:16:13'),
('01a17def-a8ff-7011-bf4b-7c4f138fc58a', 'JR-EXP-20261027151700', '2023-01-02', 'Pajak', 105860.00, 105860.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 15:17:00', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17def-a8f7-713d-bceb-4e90e1ae0ba2', '2026-10-27 08:17:00', '2026-10-27 08:17:00'),
('01a17df0-cadc-72fa-915e-3446c5a8a85a', 'JR-EXP-20261027151815', '2023-01-12', 'Pengembalian Talangan Uang Inklusi untuk Living Cost 2 Mahasiswa Beasiswa Persayarikatan di UMSIDA dan SKN', 9502900.00, 9502900.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 15:18:15', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17df0-cad2-7334-8a37-b7dd6f8dcbb7', '2026-10-27 08:18:15', '2026-10-27 08:18:15'),
('01a17df1-dddd-731b-8201-1ae260cc36be', 'JR-EXP-20261027151925', '2023-01-15', 'Biaya Administrasi', 10000.00, 10000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 15:19:25', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17df1-ddd3-7144-ac42-a0aba0fceb35', '2026-10-27 08:19:25', '2026-10-27 08:19:25'),
('01a17df2-ad2b-73e4-a99d-1e8745226a80', 'JR-EXP-20261027152018', '2023-01-18', 'RTGS Ke BRI (Panitia Musywil) dan Biaya RTGS', 300030000.00, 300030000.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 15:20:18', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17df2-ad1d-7107-a1b9-a5348c938ee5', '2026-10-27 08:20:18', '2026-10-27 08:20:18'),
('01a17df3-b4b1-71cc-b16f-a91e0f796856', 'JR-EXP-20261027152125', '2023-01-30', 'Pengembalian SPP Mahasiswa KIP UMSIDA dari Kota Mojoerto dan SKN', 5512400.00, 5512400.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 15:21:25', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17df3-b4a7-732d-85cc-cefef3fd03ad', '2026-10-27 08:21:25', '2026-10-27 08:21:25'),
('01a17df4-46ef-7046-90c4-6c19f7590269', 'JR-EXP-20261027152203', '2023-01-31', 'Pajak', 68871.00, 68871.00, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-27 15:22:03', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a17df4-469f-73eb-b42a-8d1d6e85d74d', '2026-10-27 08:22:03', '2026-10-27 08:22:03');

-- --------------------------------------------------------

--
-- Struktur dari tabel `journal_details`
--

CREATE TABLE `journal_details` (
  `id` char(36) NOT NULL,
  `journal_id` char(36) NOT NULL,
  `chart_of_account_id` char(36) NOT NULL,
  `debit` decimal(15,2) NOT NULL DEFAULT 0.00,
  `credit` decimal(15,2) NOT NULL DEFAULT 0.00,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `journal_details`
--

INSERT INTO `journal_details` (`id`, `journal_id`, `chart_of_account_id`, `debit`, `credit`, `description`, `created_at`, `updated_at`) VALUES
('01a17966-d199-738c-b555-76ec029f9763', '01a17966-d197-70cc-ab47-b8c416c9dcb7', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 2000000.00, 0.00, 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301021122537792517 Pengisian kas operasional', '2026-10-26 11:09:03', '2026-10-26 11:09:03'),
('01a17966-d1a4-7196-a27f-ba9505eb42b6', '01a17966-d197-70cc-ab47-b8c416c9dcb7', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 0.00, 2000000.00, 'Mutasi Kas Keluar', '2026-10-26 11:09:03', '2026-10-26 11:09:03'),
('01a17969-afb9-73d7-beec-1ddaf51cec82', '01a17969-afae-7387-ba13-9c0928c7a4ab', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 3000000.00, 0.00, 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301051121506253692 Tim UMPRO audensi dengan Gubernur', '2026-10-26 11:12:11', '2026-10-26 11:12:11'),
('01a17969-afc3-7030-bbbd-04e2059227f8', '01a17969-afae-7387-ba13-9c0928c7a4ab', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 0.00, 3000000.00, 'Mutasi Kas Keluar', '2026-10-26 11:12:11', '2026-10-26 11:12:11'),
('01a1796b-08c5-7012-8b27-2cd7616204d9', '01a1796b-08ba-70a4-b833-1d3e6df0c5bf', '5d121272-39ff-430a-9747-d2778985531c', 60000000.00, 0.00, 'Transfer ke BSI norek. 7187244565 an. ABD Rochim reff. 2301051121506826136 Pembangunan Café termin ke 4', '2026-10-26 11:13:40', '2026-10-26 11:13:40'),
('01a1796b-08d7-7271-b4c3-9e2b8dc65df5', '01a1796b-08ba-70a4-b833-1d3e6df0c5bf', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 0.00, 60000000.00, 'Mutasi Kas Keluar', '2026-10-26 11:13:40', '2026-10-26 11:13:40'),
('01a1796b-bafc-71ef-b933-306f61876051', '01a1796b-baf8-7186-afea-c098c5e1f232', 'e7d35619-9874-4274-8a71-cd739d923554', 2500.00, 0.00, 'Administrasi Bank', '2026-10-26 11:14:25', '2026-10-26 11:14:25'),
('01a1796b-bb0f-70eb-9e54-971af5839639', '01a1796b-baf8-7186-afea-c098c5e1f232', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 0.00, 2500.00, 'Mutasi Kas Keluar', '2026-10-26 11:14:25', '2026-10-26 11:14:25'),
('01a1796c-87db-72f7-85a6-d08f886dc898', '01a1796c-87d9-7145-b044-249585918731', '606cccc9-e4fd-4abe-9b27-2391c7302bc5', 200000.00, 0.00, 'Uang Lembur Yuli untuk persiapan pemeriksaan laporan keuangan (09.00 - 21.00)', '2026-10-26 11:15:18', '2026-10-26 11:15:18'),
('01a1796c-87ef-7096-8475-82b8db7663fa', '01a1796c-87d9-7145-b044-249585918731', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 0.00, 200000.00, 'Mutasi Kas Keluar', '2026-10-26 11:15:18', '2026-10-26 11:15:18'),
('01a17970-e6d8-7026-ab42-1c9ed56edb64', '01a17970-e6d3-7158-af3b-d5b74c9367fb', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 300000.00, 0.00, 'Tambahan transport Rapat persiapan verifikasi keuangan (17 Des 2017) an Kristin Muslimah', '2026-10-26 11:20:04', '2026-10-26 11:20:04'),
('01a17970-e6f1-7252-9f83-4144c7a131a7', '01a17970-e6d3-7158-af3b-d5b74c9367fb', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 400000.00, 0.00, 'Transport verifikasi LK (6,7,8 Jan 2023) an Kristin Muslimah (PDA Kediri)', '2026-10-26 11:20:04', '2026-10-26 11:20:04'),
('01a17970-e6f8-701a-b056-ca2baba5b6d5', '01a17970-e6d3-7158-af3b-d5b74c9367fb', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 200000.00, 0.00, 'Tambahan transport Rapat persiapan verifikasi keuangan (17 Des 2017) an. Zubaidatul Hidayah', '2026-10-26 11:20:04', '2026-10-26 11:20:04'),
('01a17970-e6fd-7164-baaf-fd58a0c484aa', '01a17970-e6d3-7158-af3b-d5b74c9367fb', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 300000.00, 0.00, 'Transport verifikasi LK (6,7,8 Jan 2023) an Zubaidatul Hidayah (PDA Sidoarjo)', '2026-10-26 11:20:04', '2026-10-26 11:20:04'),
('01a17970-e707-7198-85ec-0a866eeb9ec9', '01a17970-e6d3-7158-af3b-d5b74c9367fb', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 450000.00, 0.00, 'Tambahan transport Rapat persiapan verifikasi keuangan (17 Des 2017) an. Martiningsih', '2026-10-26 11:20:04', '2026-10-26 11:20:04'),
('01a17970-e70c-70f4-856f-96b19bdc1f17', '01a17970-e6d3-7158-af3b-d5b74c9367fb', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 500000.00, 0.00, 'Transport verifikasi LK (6,7,8 Jan 2023) an Martiningsih (PDA Ponorogo)', '2026-10-26 11:20:04', '2026-10-26 11:20:04'),
('01a17970-e711-7087-b5e8-37775d83a5f8', '01a17970-e6d3-7158-af3b-d5b74c9367fb', '5d137200-2a11-49be-8ae4-b2f6e89d149b', 120000.00, 0.00, 'Pembelian Klip (yuli)', '2026-10-26 11:20:04', '2026-10-26 11:20:04'),
('01a17970-e71b-73ac-99ee-0d1b5e8b05d8', '01a17970-e6d3-7158-af3b-d5b74c9367fb', '5d137200-2a11-49be-8ae4-b2f6e89d149b', 105000.00, 0.00, 'Tinta print Data Print, lem, isi staples', '2026-10-26 11:20:04', '2026-10-26 11:20:04'),
('01a17970-e723-7208-a52a-987a206e56b1', '01a17970-e6d3-7158-af3b-d5b74c9367fb', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 9420000.00, 0.00, 'Transfer ke Mandiri Norek. 1400075255555 an. Nawasaka Wisesa reff. 2301071122547782273 untuk pelunasan hotel (full board)', '2026-10-26 11:20:04', '2026-10-26 11:20:04'),
('01a17970-e734-7142-b920-2e5877ed8cf1', '01a17970-e6d3-7158-af3b-d5b74c9367fb', '3af9a1f6-445b-437c-8c17-733ac4f6b330', 10000.00, 0.00, 'Parkir', '2026-10-26 11:20:04', '2026-10-26 11:20:04'),
('01a17970-e742-7070-bdde-a32791ef83fc', '01a17970-e6d3-7158-af3b-d5b74c9367fb', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 0.00, 11805000.00, 'Mutasi Kas Keluar', '2026-10-26 11:20:04', '2026-10-26 11:20:04'),
('01a17974-9c14-7297-bf45-4d4ac0a8a9c3', '01a17974-9c0f-7366-a34c-250af0baa1c1', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 1500000.00, 0.00, 'Transfer ke Bank Jatim Norek. 6202209605 an. Siti Zubaidatul Hidayah (PDA Sidoarjo) reff. JMB371957650 untuk pembayaran honor verifikasi keuangan Aisyiyah', '2026-10-26 11:24:07', '2026-10-26 11:24:07'),
('01a17974-9c21-714d-98f1-50f903eb3290', '01a17974-9c0f-7366-a34c-250af0baa1c1', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 1500000.00, 0.00, 'Transfer ke Bank Syariah Indonesia Norek. 7181048365 an. Martiningsih (PDA Ponorogo) reff. 2301081121511786044 untuk pembayaran honor verifikasi keuangan Aisyiyah', '2026-10-26 11:24:07', '2026-10-26 11:24:07'),
('01a17974-9c28-7271-9f31-37784c989164', '01a17974-9c0f-7366-a34c-250af0baa1c1', 'e7d35619-9874-4274-8a71-cd739d923554', 2500.00, 0.00, 'Biaya administrasi bank', '2026-10-26 11:24:07', '2026-10-26 11:24:07'),
('01a17974-9c2e-717a-8cd1-51e397657e31', '01a17974-9c0f-7366-a34c-250af0baa1c1', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 1500000.00, 0.00, 'Transfer ke Bank BRI Norek. 625301004203538  an. Kristin Muslimah (PDA Kediri) reff.  497918192617 untuk pembayaran honor verifikasi keuangan Aisyiyah', '2026-10-26 11:24:07', '2026-10-26 11:24:07'),
('01a17974-9c3c-70e9-880d-380b9063b1ee', '01a17974-9c0f-7366-a34c-250af0baa1c1', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 1000000.00, 0.00, 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301081122548316455 untuk pembayaran honor pendamping verifikasi LK Aisyiyah', '2026-10-26 11:24:07', '2026-10-26 11:24:07'),
('01a17974-9c49-7183-a73f-74483479db7a', '01a17974-9c0f-7366-a34c-250af0baa1c1', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 4250000.00, 0.00, 'Pembayaran honor pendamping verifikasi LK Aisyiyah 3 hari di tambah transpot (Bu Candra Rp. 1.000.000, biaya admin bank Rp. 2500  Bu Anna Marina Rp. 750.000 biaya bank 2500  Bu Heni Rp. 2.500.000', '2026-10-26 11:24:07', '2026-10-26 11:24:07'),
('01a17974-9c58-73d5-841a-9f892b26c995', '01a17974-9c0f-7366-a34c-250af0baa1c1', 'e7d35619-9874-4274-8a71-cd739d923554', 5000.00, 0.00, 'Biaya administrasi bank', '2026-10-26 11:24:07', '2026-10-26 11:24:07'),
('01a17974-9c66-73dc-983f-c4c0c62822d7', '01a17974-9c0f-7366-a34c-250af0baa1c1', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 0.00, 9757500.00, 'Mutasi Kas Keluar', '2026-10-26 11:24:07', '2026-10-26 11:24:07'),
('01a17976-f389-70d3-85cb-d82c7ec74da6', '01a17976-f387-7315-befb-e87f091ee5ad', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 21190000.00, 0.00, 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref. 2301101122551693942 Operasional ATC', '2026-10-26 11:26:41', '2026-10-26 11:26:41'),
('01a17976-f394-7039-83d7-724934ddc004', '01a17976-f387-7315-befb-e87f091ee5ad', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 22722975.00, 0.00, 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301101121515400945 Keperluan tim verifikasi, dana surat keterangan konsultan, dan pembuatan laporan 1% dari dana hibah', '2026-10-26 11:26:41', '2026-10-26 11:26:41'),
('01a17976-f39a-7005-944a-823e7a5139c6', '01a17976-f387-7315-befb-e87f091ee5ad', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 0.00, 43912975.00, 'Mutasi Kas Keluar', '2026-10-26 11:26:41', '2026-10-26 11:26:41'),
('01a17977-d25e-7169-94ae-249a52e25af0', '01a17977-d257-73bc-957c-b5bccade54a8', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 35000000.00, 0.00, 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301131122557316522 untuk kebutuhan Muswil', '2026-10-26 11:27:38', '2026-10-26 11:27:38'),
('01a17977-d267-7396-8d2c-adc07930b1a2', '01a17977-d257-73bc-957c-b5bccade54a8', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 0.00, 35000000.00, 'Mutasi Kas Keluar', '2026-10-26 11:27:38', '2026-10-26 11:27:38'),
('01a1797b-328b-7078-a2b6-770d2d6df30b', '01a1797b-3287-73eb-8deb-20feba9f018d', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 200000000.00, 0.00, 'Pengisian Kas Bendahara dari Bank Jatim Soetomo', '2026-10-26 11:31:19', '2026-10-26 11:31:19'),
('01a1797b-3294-71bf-a539-75e7c844f333', '01a1797b-3287-73eb-8deb-20feba9f018d', 'b8e89210-2ad3-44b5-b835-c66c8f8d2f0c', 0.00, 200000000.00, 'Mutasi Kas Keluar', '2026-10-26 11:31:19', '2026-10-26 11:31:19'),
('01a1797c-a1d5-7114-9616-8cc0c477234b', '01a1797c-a1cf-7271-8da0-3492c7ee5349', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 19700000.00, 0.00, 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301131122557316522 untuk kebutuhan Muswil', '2026-10-26 11:32:53', '2026-10-26 11:32:53'),
('01a1797c-a1df-7234-8ed4-6ec7f50812b6', '01a1797c-a1cf-7271-8da0-3492c7ee5349', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 0.00, 19700000.00, 'Mutasi Kas Keluar', '2026-10-26 11:32:53', '2026-10-26 11:32:53'),
('01a17980-2bc2-717c-acec-9806291b979d', '01a17980-2bbf-734d-b2a5-082ae2873bf4', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 50000000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-26 11:36:45', '2026-10-26 11:36:45'),
('01a17980-2bd1-7367-8a06-0f59d93f1d0d', '01a17980-2bbf-734d-b2a5-082ae2873bf4', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 50000000.00, 'Pemasukan dari Gubernur Jatim untuk bantuan Muswil diberikan ke bu Candra tunai', '2026-10-26 11:36:45', '2026-10-26 11:36:45'),
('01a17982-39e1-73a3-9460-6c5dab000ea7', '01a17982-39df-7226-9ae3-5e2f4cc0e83d', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 100000000.00, 0.00, 'Transfer ke BRI Norek. 115901020724505 an. Fitrijah Hidajati ref. 2301241122573568558 untuk kekurangan dana Muswil', '2026-10-26 11:39:00', '2026-10-26 11:39:00'),
('01a17982-39ea-72d6-97ab-bdf3bb99fc11', '01a17982-39df-7226-9ae3-5e2f4cc0e83d', 'e7d35619-9874-4274-8a71-cd739d923554', 2500.00, 0.00, 'Biaya Administrasi Bank', '2026-10-26 11:39:00', '2026-10-26 11:39:00'),
('01a17982-39f3-7087-9505-0de1be083000', '01a17982-39df-7226-9ae3-5e2f4cc0e83d', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 0.00, 100002500.00, 'Mutasi Kas Keluar', '2026-10-26 11:39:00', '2026-10-26 11:39:00'),
('01a1798d-e691-717f-a9e8-692543785285', '01a1798d-e68f-729d-9122-5b76a1b9c8ba', '5d121272-39ff-430a-9747-d2778985531c', 52520550.00, 0.00, 'Transfer ke BCA an. Rahmad Deky Zakaria Norek. 0190548848 ref.2301251121539574926 untuk membayaran interior termin 1', '2026-10-26 11:51:45', '2026-10-26 11:51:45'),
('01a1798d-e6ab-711d-8870-5e0072c6ca9f', '01a1798d-e68f-729d-9122-5b76a1b9c8ba', 'e7d35619-9874-4274-8a71-cd739d923554', 2500.00, 0.00, 'Biaya Administrasi Bank', '2026-10-26 11:51:45', '2026-10-26 11:51:45'),
('01a1798d-e6bb-7017-8c31-3759097a1d83', '01a1798d-e68f-729d-9122-5b76a1b9c8ba', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 0.00, 52523050.00, 'Mutasi Kas Keluar', '2026-10-26 11:51:45', '2026-10-26 11:51:45'),
('01a1798e-d064-7353-9ec7-f6fc3c66d71f', '01a1798e-d061-70f5-b5ad-16717f7b2871', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 175000000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-26 11:52:45', '2026-10-26 11:52:45'),
('01a1798e-d06f-70e5-85f7-bbf17aaabf0b', '01a1798e-d061-70f5-b5ad-16717f7b2871', '77feaec0-e773-4716-aac8-cd3b08e31d47', 0.00, 175000000.00, 'Pemasukan bantuan Muswil dari PWM (cek bank Muamalat)', '2026-10-26 11:52:45', '2026-10-26 11:52:45'),
('01a17991-38b4-717f-88e3-cd99a2d53a28', '01a17991-38af-737d-af5d-10513edd7daf', '4dc29692-975f-482f-b7d0-ee44b410ce11', 162500.00, 0.00, 'Transport (grab) mengantar cek bank Muamallat dan mencairkan cek bank Muamalllat di Jl. Darmo Surabaya, Administrasi bank (yuli)', '2026-10-26 11:55:22', '2026-10-26 11:55:22'),
('01a17991-38bf-72df-88c3-4ca15257100e', '01a17991-38af-737d-af5d-10513edd7daf', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 9373000.00, 0.00, 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301271122579384345 untuk honor pegawai PWA', '2026-10-26 11:55:22', '2026-10-26 11:55:22'),
('01a17991-38c4-708a-a6a0-1862d0e5f096', '01a17991-38af-737d-af5d-10513edd7daf', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 0.00, 9535500.00, 'Mutasi Kas Keluar', '2026-10-26 11:55:22', '2026-10-26 11:55:22'),
('01a17992-9742-722f-a92b-d04a20023655', '01a17992-9740-73f5-b48a-58f22c41f3a4', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 5000000.00, 0.00, 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301311122586946308 untuk kas operasional', '2026-10-26 11:56:52', '2026-10-26 11:56:52'),
('01a17992-9750-7273-b812-109cd446cde0', '01a17992-9740-73f5-b48a-58f22c41f3a4', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 0.00, 5000000.00, 'Mutasi Kas Keluar', '2026-10-26 11:56:52', '2026-10-26 11:56:52'),
('01a17d74-9a18-7090-a1c8-8f0ad70a14bc', '01a17d74-9a15-705b-a898-fdaa98ecb7f7', '3af9a1f6-445b-437c-8c17-733ac4f6b330', 402500.00, 0.00, 'Transfer Parkir + Biaya', '2026-10-27 06:02:36', '2026-10-27 06:02:36'),
('01a17d74-9a25-705a-a491-d9a694530fc9', '01a17d74-9a15-705b-a898-fdaa98ecb7f7', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 0.00, 402500.00, 'Mutasi Kas Keluar', '2026-10-27 06:02:36', '2026-10-27 06:02:36'),
('01a17d76-1f1f-720e-a89c-ef3fe3b8f3bd', '01a17d76-1f1c-7182-b86a-2d813f764ad6', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 200000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 06:04:15', '2026-10-27 06:04:15'),
('01a17d76-1f32-73f0-82f9-306e9c9722c6', '01a17d76-1f1c-7182-b86a-2d813f764ad6', 'f0b2f862-b909-4d51-aab8-35aa1a569506', 0.00, 200000.00, 'Cicilan 3 Pak Edi', '2026-10-27 06:04:15', '2026-10-27 06:04:15'),
('01a17d79-0a90-7173-8205-5afebe23400d', '01a17d79-0a8b-717a-88ef-d7c925f2c434', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 902500.00, 0.00, 'Transfer Transport Tim Panlih Daerah', '2026-10-27 06:07:26', '2026-10-27 06:07:26'),
('01a17d79-0a9d-702a-8fbc-28ce0f1813f4', '01a17d79-0a8b-717a-88ef-d7c925f2c434', '4b1493eb-71c4-4fdc-9b94-862c313cfef5', 143000.00, 0.00, 'Zoom', '2026-10-27 06:07:27', '2026-10-27 06:07:27'),
('01a17d79-0ab1-71f9-a23f-4231c460023a', '01a17d79-0a8b-717a-88ef-d7c925f2c434', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 0.00, 1045500.00, 'Mutasi Kas Keluar', '2026-10-27 06:07:27', '2026-10-27 06:07:27'),
('01a17d7b-72a6-725b-b244-558be9b71c30', '01a17d7b-72a5-7354-963f-9d0641b4fa7d', '4b1493eb-71c4-4fdc-9b94-862c313cfef5', 480500.00, 0.00, 'Listrik Desember Pesma', '2026-10-27 06:10:04', '2026-10-27 06:10:04'),
('01a17d7b-72b2-7185-8bcf-2bf7bf73455b', '01a17d7b-72a5-7354-963f-9d0641b4fa7d', '084d9998-26f9-4e60-9673-eb1464e6e379', 500000.00, 0.00, 'Honor Pembina Mahasiswa (B Asmawati)', '2026-10-27 06:10:04', '2026-10-27 06:10:04'),
('01a17d7b-72b9-715e-800d-47f699fdd1ec', '01a17d7b-72a5-7354-963f-9d0641b4fa7d', '084d9998-26f9-4e60-9673-eb1464e6e379', 500000.00, 0.00, 'Honor Pembina Mahasiswa (B Faridah)', '2026-10-27 06:10:04', '2026-10-27 06:10:04'),
('01a17d7b-72c1-71f3-a558-932e9a82086c', '01a17d7b-72a5-7354-963f-9d0641b4fa7d', '084d9998-26f9-4e60-9673-eb1464e6e379', 500000.00, 0.00, 'Honor Pembina Mahasiswa (B Fitriyah)', '2026-10-27 06:10:04', '2026-10-27 06:10:04'),
('01a17d7b-72c6-70d3-a080-2b194c1fd34f', '01a17d7b-72a5-7354-963f-9d0641b4fa7d', '084d9998-26f9-4e60-9673-eb1464e6e379', 500000.00, 0.00, 'Honor Pembina Mahasiswa (B Enik)', '2026-10-27 06:10:04', '2026-10-27 06:10:04'),
('01a17d7b-72ca-7172-b95e-5d083b7a5cd1', '01a17d7b-72a5-7354-963f-9d0641b4fa7d', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 100000.00, 0.00, 'Sopir ke Asrama Haji', '2026-10-27 06:10:04', '2026-10-27 06:10:04'),
('01a17d7b-72d1-7261-9b4f-ed3c79910ba3', '01a17d7b-72a5-7354-963f-9d0641b4fa7d', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 0.00, 2580500.00, 'Mutasi Kas Keluar', '2026-10-27 06:10:04', '2026-10-27 06:10:04'),
('01a17d7c-fb2a-7368-94e2-37ab2be28072', '01a17d7c-fb28-7230-aa16-2ca87c4b35e4', '4b1493eb-71c4-4fdc-9b94-862c313cfef5', 661700.00, 0.00, 'Listrik Gg 3 No 33', '2026-10-27 06:11:45', '2026-10-27 06:11:45'),
('01a17d7c-fb39-73b8-b66d-b06c3a5db84b', '01a17d7c-fb28-7230-aa16-2ca87c4b35e4', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 0.00, 661700.00, 'Mutasi Kas Keluar', '2026-10-27 06:11:45', '2026-10-27 06:11:45'),
('01a17d7e-0607-7045-b71e-6f442b4e2b96', '01a17d7e-0605-7016-8492-9c3079352732', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 1002500.00, 0.00, 'Transfer Transport & Akomodasi Tim UMPO Survey', '2026-10-27 06:12:53', '2026-10-27 06:12:53'),
('01a17d7e-060f-7204-aa95-96b23db3f254', '01a17d7e-0605-7016-8492-9c3079352732', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 0.00, 1002500.00, 'Mutasi Kas Keluar', '2026-10-27 06:12:53', '2026-10-27 06:12:53'),
('01a17d81-5d70-72e8-b8bf-5d9cf29278d2', '01a17d81-5d6d-72e4-a7ca-395cfc549c9c', '084d9998-26f9-4e60-9673-eb1464e6e379', 500000.00, 0.00, 'Honor Pembina Mahasiswa (B Candra)', '2026-10-27 06:16:32', '2026-10-27 06:16:32'),
('01a17d81-5d7a-72d3-b66d-a924cf35e76a', '01a17d81-5d6d-72e4-a7ca-395cfc549c9c', '084d9998-26f9-4e60-9673-eb1464e6e379', 500000.00, 0.00, 'Honor Pembina Mahasiswa (B Rukmini)', '2026-10-27 06:16:32', '2026-10-27 06:16:32'),
('01a17d81-5d83-73a6-aa34-a9519e016cb9', '01a17d81-5d6d-72e4-a7ca-395cfc549c9c', '084d9998-26f9-4e60-9673-eb1464e6e379', 500000.00, 0.00, 'Honor Pembina Mahasiswa (B Sugiarti)', '2026-10-27 06:16:32', '2026-10-27 06:16:32'),
('01a17d81-5d88-72c1-9f02-6d1daabb60af', '01a17d81-5d6d-72e4-a7ca-395cfc549c9c', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 402500.00, 0.00, 'Transfer Tansport Rapat Panlih & Audensi ke PWM', '2026-10-27 06:16:32', '2026-10-27 06:16:32'),
('01a17d81-5d8c-72ff-af68-19c2933f47d0', '01a17d81-5d6d-72e4-a7ca-395cfc549c9c', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 300000.00, 0.00, 'Transport Tim Panlih Daerah Lamongan', '2026-10-27 06:16:32', '2026-10-27 06:16:32'),
('01a17d81-5d93-731a-9516-8748a6ce747d', '01a17d81-5d6d-72e4-a7ca-395cfc549c9c', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 225500.00, 0.00, 'Konsumsi Rapat & Audensi PWM', '2026-10-27 06:16:32', '2026-10-27 06:16:32'),
('01a17d81-5d9e-72fe-8e9a-3f575d06621d', '01a17d81-5d6d-72e4-a7ca-395cfc549c9c', '084d9998-26f9-4e60-9673-eb1464e6e379', 450000.00, 0.00, 'Konsumsi Audensi Ahlul Bait', '2026-10-27 06:16:32', '2026-10-27 06:16:32'),
('01a17d81-5da4-70a5-89ce-b1a3b81f8a34', '01a17d81-5d6d-72e4-a7ca-395cfc549c9c', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 47000.00, 0.00, 'Grab B Heni', '2026-10-27 06:16:32', '2026-10-27 06:16:32'),
('01a17d81-5daa-7185-96a7-8fa55e868270', '01a17d81-5d6d-72e4-a7ca-395cfc549c9c', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 0.00, 2925000.00, 'Mutasi Kas Keluar', '2026-10-27 06:16:32', '2026-10-27 06:16:32'),
('01a17d84-2edb-70b7-aefd-2358564e8861', '01a17d84-2ed9-7186-90e3-19b4579c1c03', '15d08eb5-60ee-4fca-a440-546aef11ff68', 402500.00, 0.00, 'Transfer Iuran RT 2 Bln 2 Rumah', '2026-10-27 06:19:37', '2026-10-27 06:19:37'),
('01a17d84-2eee-718b-89dd-86f9b4bf548f', '01a17d84-2ed9-7186-90e3-19b4579c1c03', '4dc29692-975f-482f-b7d0-ee44b410ce11', 552500.00, 0.00, 'Transfer Transport Acara M. Dikdas di Malang Mobil PWA', '2026-10-27 06:19:37', '2026-10-27 06:19:37'),
('01a17d84-2ef6-70a1-87ad-a101e4a1cc12', '01a17d84-2ed9-7186-90e3-19b4579c1c03', '1638884c-8d9c-4db7-963a-f5169cb09400', 45000.00, 0.00, 'Gojek Riwa Riwi Hotel', '2026-10-27 06:19:37', '2026-10-27 06:19:37'),
('01a17d84-2eff-7067-b28f-da47997a033a', '01a17d84-2ed9-7186-90e3-19b4579c1c03', '25c9837f-2d00-4d5a-ac4f-3cca3986cd2c', 350000.00, 0.00, 'Bensin & Tol Acara M. Dikdasmen di Malang Mobil B Lutfah', '2026-10-27 06:19:37', '2026-10-27 06:19:37'),
('01a17d84-2f07-705c-870c-082203a567e3', '01a17d84-2ed9-7186-90e3-19b4579c1c03', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 0.00, 1350000.00, 'Mutasi Kas Keluar', '2026-10-27 06:19:37', '2026-10-27 06:19:37'),
('01a17d85-a5aa-703c-9527-5f5f99499443', '01a17d85-a5a8-7384-80f0-06ee58f31580', '25c9837f-2d00-4d5a-ac4f-3cca3986cd2c', 352500.00, 0.00, 'Transfer Sarapan Acara M. Dikdasmen di Malang', '2026-10-27 06:21:13', '2026-10-27 06:21:13'),
('01a17d85-a5b5-71d0-812f-a497e24dd67b', '01a17d85-a5a8-7384-80f0-06ee58f31580', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 25000.00, 0.00, 'Grab Bawa Berkas ke PWM', '2026-10-27 06:21:13', '2026-10-27 06:21:13'),
('01a17d85-a5bc-7039-bb08-7d2d55fdc468', '01a17d85-a5a8-7384-80f0-06ee58f31580', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 0.00, 377500.00, 'Mutasi Kas Keluar', '2026-10-27 06:21:13', '2026-10-27 06:21:13'),
('01a17d86-aa33-7185-95e4-757caf949176', '01a17d86-aa31-73fc-98e5-ffedd1b8a1c6', '7703cbfd-b06b-4acf-97cc-7cf6f0b3d94c', 23000.00, 0.00, 'Gosend B Heni', '2026-10-27 06:22:19', '2026-10-27 06:22:19'),
('01a17d86-aa3f-72ce-b39b-ea4d8d6f3a14', '01a17d86-aa31-73fc-98e5-ffedd1b8a1c6', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 0.00, 23000.00, 'Mutasi Kas Keluar', '2026-10-27 06:22:19', '2026-10-27 06:22:19'),
('01a17d8a-ee48-70af-b1d9-7a08e8e33552', '01a17d8a-ee45-7159-9d70-4ba618b1d67f', '4dc29692-975f-482f-b7d0-ee44b410ce11', 802500.00, 0.00, 'Transfer Transport Audensi ke Gubernur & Takziyah Ayah B Umi H', '2026-10-27 06:26:59', '2026-10-27 06:26:59'),
('01a17d8a-ee54-72b0-a6b1-a2792ae9a5d4', '01a17d8a-ee45-7159-9d70-4ba618b1d67f', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 327500.00, 0.00, 'Transfer Keperluan Ke Asrama Haji', '2026-10-27 06:26:59', '2026-10-27 06:26:59'),
('01a17d8a-ee5a-73d8-92a4-1a174c47af1d', '01a17d8a-ee45-7159-9d70-4ba618b1d67f', '084d9998-26f9-4e60-9673-eb1464e6e379', 502500.00, 0.00, 'Transfer Honor Pembina Mahasiswa (B UMMAH)', '2026-10-27 06:26:59', '2026-10-27 06:26:59'),
('01a17d8a-ee61-7203-ba1f-eb0f8254f95c', '01a17d8a-ee45-7159-9d70-4ba618b1d67f', '2d10b459-e593-4abe-9dd4-d1ae34a1db88', 15190000.00, 0.00, 'Operasional ATC Jan - Maret', '2026-10-27 06:26:59', '2026-10-27 06:26:59'),
('01a17d8a-ee6f-73fb-bf93-97621eedf1b3', '01a17d8a-ee45-7159-9d70-4ba618b1d67f', '084d9998-26f9-4e60-9673-eb1464e6e379', 22725475.00, 0.00, 'Transfer Dana Pph 1,5 % Dana Srt Keterangan Konsultan dan Pembuatan Laporan 1 %', '2026-10-27 06:26:59', '2026-10-27 06:26:59'),
('01a17d8a-ee77-736a-bbbe-69d9a231a344', '01a17d8a-ee45-7159-9d70-4ba618b1d67f', '084d9998-26f9-4e60-9673-eb1464e6e379', 502500.00, 0.00, 'Transfer Honor Pembina Mahasiswa (B Umi T)', '2026-10-27 06:26:59', '2026-10-27 06:26:59'),
('01a17d8a-ee7f-72df-ae20-756dcdbf6ec3', '01a17d8a-ee45-7159-9d70-4ba618b1d67f', '084d9998-26f9-4e60-9673-eb1464e6e379', 502500.00, 0.00, 'Transfer Honor Pembina Mahasiswa (B Ana)', '2026-10-27 06:26:59', '2026-10-27 06:26:59'),
('01a17d8a-ee87-721b-b380-c3e9ab724ca7', '01a17d8a-ee45-7159-9d70-4ba618b1d67f', '4dc29692-975f-482f-b7d0-ee44b410ce11', 252500.00, 0.00, 'Transfer Transport Menghadiri', '2026-10-27 06:26:59', '2026-10-27 06:26:59'),
('01a17d8a-ee8d-7269-8c38-c8657ca43362', '01a17d8a-ee45-7159-9d70-4ba618b1d67f', '084d9998-26f9-4e60-9673-eb1464e6e379', 1202500.00, 0.00, 'Transfer Transport Rapat Pimpinan di ATC 3 Mobil', '2026-10-27 06:26:59', '2026-10-27 06:26:59'),
('01a17d8a-ee92-72fc-9c53-67192986e61e', '01a17d8a-ee45-7159-9d70-4ba618b1d67f', '084d9998-26f9-4e60-9673-eb1464e6e379', 1000000.00, 0.00, 'Konsumsi Rapat di ATC', '2026-10-27 06:26:59', '2026-10-27 06:26:59'),
('01a17d8a-ee97-73c6-bc87-6ff8f3a02625', '01a17d8a-ee45-7159-9d70-4ba618b1d67f', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 0.00, 43007975.00, 'Mutasi Kas Keluar', '2026-10-27 06:26:59', '2026-10-27 06:26:59'),
('01a17d8c-6d62-7065-915e-207ed25f9dfd', '01a17d8c-6d5e-7138-94ef-602172c61507', '084d9998-26f9-4e60-9673-eb1464e6e379', 1000000.00, 0.00, 'Transfer Honor Pembina Mahasiswa (B. Ila & P Rosidin)', '2026-10-27 06:28:37', '2026-10-27 06:28:37'),
('01a17d8c-6d6f-7314-977e-7e4acb0401b5', '01a17d8c-6d5e-7138-94ef-602172c61507', '084d9998-26f9-4e60-9673-eb1464e6e379', 1069000.00, 0.00, 'Kekurangan Rapat Di ATC', '2026-10-27 06:28:37', '2026-10-27 06:28:37'),
('01a17d8c-6d76-7378-8beb-5a70c39cc70f', '01a17d8c-6d5e-7138-94ef-602172c61507', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 0.00, 2069000.00, 'Mutasi Kas Keluar', '2026-10-27 06:28:37', '2026-10-27 06:28:37'),
('01a17d8d-c5e6-708e-b932-e1c30603a57d', '01a17d8d-c5e3-72fb-be82-4581c9591773', '4b1493eb-71c4-4fdc-9b94-862c313cfef5', 327730.00, 0.00, 'Indihome', '2026-10-27 06:30:05', '2026-10-27 06:30:05'),
('01a17d8d-c5f9-72a5-825b-93cd93739b8c', '01a17d8d-c5e3-72fb-be82-4581c9591773', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 0.00, 327730.00, 'Mutasi Kas Keluar', '2026-10-27 06:30:05', '2026-10-27 06:30:05'),
('01a17d8f-114b-7253-aed0-55ab04e18cdd', '01a17d8f-1148-72b0-a689-e49f3e64d423', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 30002500.00, 0.00, 'Transfer Dana Musywil', '2026-10-27 06:31:30', '2026-10-27 06:31:30'),
('01a17d8f-1158-71f6-b606-208400ed5777', '01a17d8f-1148-72b0-a689-e49f3e64d423', '4b1493eb-71c4-4fdc-9b94-862c313cfef5', 67940.00, 0.00, 'PDAM rumah rungkut', '2026-10-27 06:31:30', '2026-10-27 06:31:30'),
('01a17d8f-1160-7068-924d-29e0f61c6c4e', '01a17d8f-1148-72b0-a689-e49f3e64d423', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 0.00, 30070440.00, 'Mutasi Kas Keluar', '2026-10-27 06:31:30', '2026-10-27 06:31:30'),
('01a17d90-51b2-73a5-aae7-68b5475b7a43', '01a17d90-51b0-71ba-86bc-4ebad4e2c3ce', 'fde4a381-dde7-4ade-b28c-92d51e46158e', 4702500.00, 0.00, 'Transfer Servis Inova Hitam', '2026-10-27 06:32:52', '2026-10-27 06:32:52'),
('01a17d90-51bd-728a-9d1f-14ed96178ad2', '01a17d90-51b0-71ba-86bc-4ebad4e2c3ce', '084d9998-26f9-4e60-9673-eb1464e6e379', 15002500.00, 0.00, 'Transfer Keperluan Pesma 1 Semester', '2026-10-27 06:32:52', '2026-10-27 06:32:52'),
('01a17d90-51c4-717d-b204-cdcb1f4c4845', '01a17d90-51b0-71ba-86bc-4ebad4e2c3ce', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 0.00, 19705000.00, 'Mutasi Kas Keluar', '2026-10-27 06:32:52', '2026-10-27 06:32:52'),
('01a17d92-54dc-7136-a634-c702a9252142', '01a17d92-54da-7315-9bab-11c9e88cae19', '345a9584-2788-47b3-978b-4dc9e20019ef', 100000.00, 0.00, 'Bensin', '2026-10-27 06:35:04', '2026-10-27 06:35:04'),
('01a17d92-54e6-723e-bca2-7566472349b4', '01a17d92-54da-7315-9bab-11c9e88cae19', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 400000.00, 0.00, 'Transport Rapat dari Malang (Panlih & Persiapan Musywil)', '2026-10-27 06:35:04', '2026-10-27 06:35:04'),
('01a17d92-54ec-7094-a620-33aba4ef5f49', '01a17d92-54da-7315-9bab-11c9e88cae19', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 600000.00, 0.00, 'Transport Tim Panlih Daerah (lamongan & Gresik)', '2026-10-27 06:35:04', '2026-10-27 06:35:04'),
('01a17d92-54f1-72d5-9263-1c46e199e36e', '01a17d92-54da-7315-9bab-11c9e88cae19', '4dc29692-975f-482f-b7d0-ee44b410ce11', 83500.00, 0.00, 'Gocar Mbk Nurul dari PWA', '2026-10-27 06:35:04', '2026-10-27 06:35:04'),
('01a17d92-54f6-70d4-a505-e8e531e2b379', '01a17d92-54da-7315-9bab-11c9e88cae19', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 0.00, 1183500.00, 'Mutasi Kas Keluar', '2026-10-27 06:35:04', '2026-10-27 06:35:04'),
('01a17d9b-8cca-73d0-89dc-470ea5f41d7e', '01a17d9b-8cc6-7360-ae86-90f60a100543', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 217000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 06:45:08', '2026-10-27 06:45:08'),
('01a17d9b-8cdc-70f3-bfc2-47c67391450e', '01a17d9b-8cc6-7360-ae86-90f60a100543', 'fde4a381-dde7-4ade-b28c-92d51e46158e', 0.00, 217000.00, 'Saldo Servis Inova Hitam', '2026-10-27 06:45:08', '2026-10-27 06:45:08'),
('01a17d9d-fca0-73e6-aa65-de8bcde16ab6', '01a17d9d-fc9d-7287-948f-f2cd44579a5a', 'cd26292d-ed27-4e29-af2f-d3bd7c9ccb94', 175000.00, 0.00, 'Stempel LPPA', '2026-10-27 06:47:48', '2026-10-27 06:47:48'),
('01a17d9d-fcc4-718d-bdb6-e08c7836f818', '01a17d9d-fc9d-7287-948f-f2cd44579a5a', '4dc29692-975f-482f-b7d0-ee44b410ce11', 76500.00, 0.00, 'Gocar Mbk Nurul dari PWA', '2026-10-27 06:47:48', '2026-10-27 06:47:48'),
('01a17d9d-fcd0-7289-b175-8a1dbe1e117a', '01a17d9d-fc9d-7287-948f-f2cd44579a5a', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 0.00, 251500.00, 'Mutasi Kas Keluar', '2026-10-27 06:47:48', '2026-10-27 06:47:48'),
('01a17d9e-a367-7224-aac2-904d2dda19fc', '01a17d9e-a365-701b-8d0a-f0b87df34312', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 13000.00, 0.00, 'Gosend Undangan Pembukaan Musywil', '2026-10-27 06:48:30', '2026-10-27 06:48:30'),
('01a17d9e-a374-7003-a419-356765fa142b', '01a17d9e-a365-701b-8d0a-f0b87df34312', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 0.00, 13000.00, 'Mutasi Kas Keluar', '2026-10-27 06:48:30', '2026-10-27 06:48:30'),
('01a17da3-dff9-712a-96cf-db2abaf5fc17', '01a17da3-dff7-737b-9853-4852cbcd0dbb', '3977d722-ebce-4252-9cca-b4a65a22876f', 600000.00, 0.00, 'Transfer Karangan Bunga Musywil PWM', '2026-10-27 06:54:14', '2026-10-27 06:54:14'),
('01a17da3-e011-70f5-b71c-1c25ce32d1db', '01a17da3-dff7-737b-9853-4852cbcd0dbb', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 500000.00, 0.00, 'Transport Tim Verifikasi dari Ponorogo (Musywil)', '2026-10-27 06:54:14', '2026-10-27 06:54:14'),
('01a17da3-e01a-72f9-ad13-29d89cb7bc45', '01a17da3-dff7-737b-9853-4852cbcd0dbb', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 500000.00, 0.00, 'Pengembalian Kelebihan Transfer Dana Musywil (Sampang)', '2026-10-27 06:54:14', '2026-10-27 06:54:14'),
('01a17da3-e020-7244-82ad-19145d87a5d1', '01a17da3-dff7-737b-9853-4852cbcd0dbb', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 300000.00, 0.00, 'Pengembalian SWP Musywil (KLL)', '2026-10-27 06:54:14', '2026-10-27 06:54:14'),
('01a17da3-e027-71b7-82f8-f6a72b0c7ac7', '01a17da3-dff7-737b-9853-4852cbcd0dbb', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 0.00, 1900000.00, 'Mutasi Kas Keluar', '2026-10-27 06:54:14', '2026-10-27 06:54:14'),
('01a17da4-e1ef-7295-968d-08117780ab7b', '01a17da4-e1e3-73e7-a83e-70f3a9095af5', '5d137200-2a11-49be-8ae4-b2f6e89d149b', 100000.00, 0.00, 'Materai', '2026-10-27 06:55:20', '2026-10-27 06:55:20'),
('01a17da4-e1f7-7012-a154-00ba8b3c2118', '01a17da4-e1e3-73e7-a83e-70f3a9095af5', '084d9998-26f9-4e60-9673-eb1464e6e379', 550000.00, 0.00, 'Transport & Uang Makan Monev Pemprov ke Asrama ATC', '2026-10-27 06:55:20', '2026-10-27 06:55:20'),
('01a17da4-e1fb-71cd-8b48-a2e876a27b53', '01a17da4-e1e3-73e7-a83e-70f3a9095af5', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 0.00, 650000.00, 'Mutasi Kas Keluar', '2026-10-27 06:55:20', '2026-10-27 06:55:20'),
('01a17da5-763d-724d-9e08-2f69afcdbcd0', '01a17da5-7634-701b-89e3-6c60eb77c9f2', 'cd26292d-ed27-4e29-af2f-d3bd7c9ccb94', 555000.00, 0.00, 'Contener 82L', '2026-10-27 06:55:58', '2026-10-27 06:55:58'),
('01a17da5-7647-723d-a6e6-9f5a0136fb8b', '01a17da5-7634-701b-89e3-6c60eb77c9f2', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 0.00, 555000.00, 'Mutasi Kas Keluar', '2026-10-27 06:55:58', '2026-10-27 06:55:58'),
('01a17da6-85e1-738f-a98b-5cdfaf4f901d', '01a17da6-85df-7281-b5b6-c5ff487f6f7a', 'ad354b98-b236-4a1c-b7b5-e32757f43623', 1375000.00, 0.00, 'Transfer Honor Media Ig 27 Konten SIA 1', '2026-10-27 06:57:07', '2026-10-27 06:57:07'),
('01a17da6-85ee-7239-b6be-f32b6b2af70d', '01a17da6-85df-7281-b5b6-c5ff487f6f7a', '4dc29692-975f-482f-b7d0-ee44b410ce11', 152500.00, 0.00, 'Transfer Transport Acara DP3AK 2 Kali', '2026-10-27 06:57:07', '2026-10-27 06:57:07'),
('01a17da6-85f3-71f1-924d-fd60c8857192', '01a17da6-85df-7281-b5b6-c5ff487f6f7a', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 0.00, 1527500.00, 'Mutasi Kas Keluar', '2026-10-27 06:57:07', '2026-10-27 06:57:07'),
('01a17da7-6609-72cb-87fb-cbfd366edb1a', '01a17da7-6607-706a-b0ac-6ef8f4da4668', '4dc29692-975f-482f-b7d0-ee44b410ce11', 452500.00, 0.00, 'Transfer Transport Acara ke Gresik', '2026-10-27 06:58:05', '2026-10-27 06:58:05'),
('01a17da7-6617-7253-84a1-fac789d23be3', '01a17da7-6607-706a-b0ac-6ef8f4da4668', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 0.00, 452500.00, 'Mutasi Kas Keluar', '2026-10-27 06:58:05', '2026-10-27 06:58:05'),
('01a17da8-fff1-70d4-8c05-f8b323401e7a', '01a17da8-ffef-7031-8e47-2405b4d4af94', '3977d722-ebce-4252-9cca-b4a65a22876f', 750000.00, 0.00, 'Transfer Karangan Bunga Warek UMSIDA', '2026-10-27 06:59:50', '2026-10-27 06:59:50'),
('01a17da8-fffe-701e-a5b2-9052375af88f', '01a17da8-ffef-7031-8e47-2405b4d4af94', '084d9998-26f9-4e60-9673-eb1464e6e379', 1239700.00, 0.00, 'Keperluan Rapat Tim 11 di ATC', '2026-10-27 06:59:50', '2026-10-27 06:59:50'),
('01a17da9-0004-714a-9e60-b0e77e94e62f', '01a17da8-ffef-7031-8e47-2405b4d4af94', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 0.00, 1989700.00, 'Mutasi Kas Keluar', '2026-10-27 06:59:50', '2026-10-27 06:59:50'),
('01a17dae-dc1e-737e-b2df-19e2e4a12aa3', '01a17dae-dc1b-7285-957c-8ddc15fe18b2', '7dc4f8dd-9f03-45f2-aac9-4dfe20680aa4', 2000000.00, 0.00, 'Transfer Honor (Hikma)', '2026-10-27 07:06:14', '2026-10-27 07:06:14'),
('01a17dae-dc30-7024-8cb9-63ba7377280e', '01a17dae-dc1b-7285-957c-8ddc15fe18b2', '34f0c888-19c7-49e6-b451-3ee517c89817', 500000.00, 0.00, 'Uang Makan', '2026-10-27 07:06:14', '2026-10-27 07:06:14'),
('01a17dae-dc3a-7051-8f00-381045c8f4f9', '01a17dae-dc1b-7285-957c-8ddc15fe18b2', '606cccc9-e4fd-4abe-9b27-2391c7302bc5', 300000.00, 0.00, 'Insentif  Musywil', '2026-10-27 07:06:14', '2026-10-27 07:06:14'),
('01a17dae-dc44-7013-8208-c52a31b05d13', '01a17dae-dc1b-7285-957c-8ddc15fe18b2', '7dc4f8dd-9f03-45f2-aac9-4dfe20680aa4', 2000000.00, 0.00, 'Transfer Honor l (Yuli)', '2026-10-27 07:06:14', '2026-10-27 07:06:14'),
('01a17dae-dc4c-70fe-b1d2-82ea83b554fe', '01a17dae-dc1b-7285-957c-8ddc15fe18b2', '34f0c888-19c7-49e6-b451-3ee517c89817', 500000.00, 0.00, 'Uang Makan', '2026-10-27 07:06:14', '2026-10-27 07:06:14'),
('01a17dae-dc55-71a4-ba47-01a9cf28a965', '01a17dae-dc1b-7285-957c-8ddc15fe18b2', '606cccc9-e4fd-4abe-9b27-2391c7302bc5', 300000.00, 0.00, 'Insentif  Musywil', '2026-10-27 07:06:14', '2026-10-27 07:06:14'),
('01a17dae-dc5f-7285-9382-00dbffd1b960', '01a17dae-dc1b-7285-957c-8ddc15fe18b2', '4b1493eb-71c4-4fdc-9b94-862c313cfef5', 100000.00, 0.00, 'Pulsa Operasional', '2026-10-27 07:06:14', '2026-10-27 07:06:14'),
('01a17dae-dc68-72f0-9718-71cfb50ab855', '01a17dae-dc1b-7285-957c-8ddc15fe18b2', '4dc29692-975f-482f-b7d0-ee44b410ce11', 100000.00, 0.00, 'Transport Operasional Ke BSB dan B Heni', '2026-10-27 07:06:14', '2026-10-27 07:06:14'),
('01a17dae-dc70-7061-b3ca-f65b58b7924c', '01a17dae-dc1b-7285-957c-8ddc15fe18b2', '4dc29692-975f-482f-b7d0-ee44b410ce11', 1252500.00, 0.00, 'Transfer Tansport Ke Nganjuk (Menghadiri)', '2026-10-27 07:06:14', '2026-10-27 07:06:14'),
('01a17dae-dc7a-71bc-8353-15a68cd128ea', '01a17dae-dc1b-7285-957c-8ddc15fe18b2', '4dc29692-975f-482f-b7d0-ee44b410ce11', 500000.00, 0.00, 'Transport dari Malang (Tamu Kodam)', '2026-10-27 07:06:14', '2026-10-27 07:06:14'),
('01a17dae-dc80-71bb-bd69-d9a1da872a5e', '01a17dae-dc1b-7285-957c-8ddc15fe18b2', '4dc29692-975f-482f-b7d0-ee44b410ce11', 100000.00, 0.00, 'Bensin Mobil PWA (Tamu Kodam)', '2026-10-27 07:06:14', '2026-10-27 07:06:14'),
('01a17dae-dc88-7284-81d9-ff21904a7301', '01a17dae-dc1b-7285-957c-8ddc15fe18b2', '4dc29692-975f-482f-b7d0-ee44b410ce11', 150000.00, 0.00, 'Sopir Mobil PWA (Tamu Kodam)', '2026-10-27 07:06:14', '2026-10-27 07:06:14'),
('01a17dae-dc8d-70f9-9c84-fb7c9e7a4571', '01a17dae-dc1b-7285-957c-8ddc15fe18b2', 'f6cb5434-a42a-41cc-8cd2-f7ebd46f485f', 502500.00, 0.00, 'Transfer Takziyah Ke PAk Ali Laziz MU', '2026-10-27 07:06:14', '2026-10-27 07:06:14'),
('01a17dae-dc9a-70f3-bcfe-3298087759c7', '01a17dae-dc1b-7285-957c-8ddc15fe18b2', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 0.00, 8305000.00, 'Mutasi Kas Keluar', '2026-10-27 07:06:14', '2026-10-27 07:06:14'),
('01a17dbd-dc29-720e-8bd0-57454e67f44d', '01a17dbd-dc27-727c-87e6-63f3892127ed', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 1000000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:22:37', '2026-10-27 07:22:37'),
('01a17dbd-dc34-7198-b932-1e236b2b9bdf', '01a17dbd-dc27-727c-87e6-63f3892127ed', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 1000000.00, 'Sumbangan Musywil Bagus Irawa', '2026-10-27 07:22:37', '2026-10-27 07:22:37'),
('01a17dbe-5ed6-706a-b5f2-f613d26b1047', '01a17dbe-5ed4-7014-9411-07909a00b66f', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 25000000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:23:10', '2026-10-27 07:23:10'),
('01a17dbe-5ee0-72e1-aee3-3e4f09997070', '01a17dbe-5ed4-7014-9411-07909a00b66f', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 25000000.00, 'Sumbangan Musywil UMSurabaya', '2026-10-27 07:23:10', '2026-10-27 07:23:10'),
('01a17dbe-ffc6-7253-9854-16d5b162d717', '01a17dbe-ffc4-7321-a86d-6b43a4b03efc', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 300000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:23:51', '2026-10-27 07:23:51'),
('01a17dbe-ffd1-711d-a071-fce75ab6f6cb', '01a17dbe-ffc4-7321-a86d-6b43a4b03efc', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 300000.00, 'Pemasukan', '2026-10-27 07:23:51', '2026-10-27 07:23:51'),
('01a17dbf-81f8-70d6-b43d-4c9fe826988e', '01a17dbf-81f5-71e6-953e-fe1640ee25f6', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 3000000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:24:25', '2026-10-27 07:24:25'),
('01a17dbf-8203-7307-9904-aca149d3e4bd', '01a17dbf-81f5-71e6-953e-fe1640ee25f6', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 3000000.00, 'Sumbangan Musywil SMP M 2 Taman', '2026-10-27 07:24:25', '2026-10-27 07:24:25'),
('01a17dc0-5d70-73b4-9923-b7072e1aa73a', '01a17dc0-5d6e-72f0-8913-da03fa6a99ab', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 7500000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:25:21', '2026-10-27 07:25:21'),
('01a17dc0-5d7d-732e-a6eb-58416591fef7', '01a17dc0-5d6e-72f0-8913-da03fa6a99ab', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 7500000.00, 'Sumbangan RSA Dahlan Kediri', '2026-10-27 07:25:21', '2026-10-27 07:25:21'),
('01a17dc0-f1d5-727f-8f5e-9ca4cf34e724', '01a17dc0-f1d3-73bb-a263-2e1b730bcc19', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 5000000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:25:59', '2026-10-27 07:25:59'),
('01a17dc0-f1e7-7134-9f51-ac2c3dd7affd', '01a17dc0-f1d3-73bb-a263-2e1b730bcc19', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 5000000.00, 'Sumbangan SMA M 2 Surabaya', '2026-10-27 07:25:59', '2026-10-27 07:25:59'),
('01a17dc1-9a0f-721e-86e5-920217f1fa86', '01a17dc1-9a0b-7285-ba1e-0777ea7c035d', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 10000000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:26:42', '2026-10-27 07:26:42'),
('01a17dc1-9a1a-7290-aa6c-2e1e39d6c287', '01a17dc1-9a0b-7285-ba1e-0777ea7c035d', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 10000000.00, 'Sumbangan RSI Aisyiyah Malang', '2026-10-27 07:26:42', '2026-10-27 07:26:42'),
('01a17dc2-3f16-733e-9aed-23bd5ddc0ee4', '01a17dc2-3f13-7390-8843-0ecdcff17807', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 20000000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:27:24', '2026-10-27 07:27:24'),
('01a17dc2-3f26-7094-9c03-a3dff5e8bd81', '01a17dc2-3f13-7390-8843-0ecdcff17807', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 20000000.00, 'Sumbangan Musywil RSIA Nganjuk', '2026-10-27 07:27:24', '2026-10-27 07:27:24'),
('01a17dc3-5a41-73ca-b6ec-54798732bee0', '01a17dc3-5a3f-7164-bfc0-35629a3f89a5', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 5000000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:28:37', '2026-10-27 07:28:37'),
('01a17dc3-5a51-7331-b02a-6c63901d4248', '01a17dc3-5a3f-7164-bfc0-35629a3f89a5', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 5000000.00, 'Sumbangan Musywil SMA M 2 Sidoarjo', '2026-10-27 07:28:37', '2026-10-27 07:28:37'),
('01a17dc4-4ab2-7096-b031-214582692738', '01a17dc4-4ab0-7074-ac5a-bc6766414f07', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 1500000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:29:38', '2026-10-27 07:29:38'),
('01a17dc4-4abc-7071-baf5-f6a1bdf3ae08', '01a17dc4-4ab0-7074-ac5a-bc6766414f07', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 1500000.00, 'Sumbangan Musywil SDM 1 Sidoarjo', '2026-10-27 07:29:38', '2026-10-27 07:29:38'),
('01a17dc4-d4aa-72bd-84c3-24263fa2c4d6', '01a17dc4-d4a8-701c-b8ff-57be0b404fb7', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 3000000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:30:13', '2026-10-27 07:30:13'),
('01a17dc4-d4c0-7190-8c02-e68157ab8221', '01a17dc4-d4a8-701c-b8ff-57be0b404fb7', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 3000000.00, 'Sumbangan Musywil SMP M 1 Sidoarjo', '2026-10-27 07:30:13', '2026-10-27 07:30:13'),
('01a17dc5-6fca-703d-be22-fe3a8a5ac938', '01a17dc5-6fc2-7050-b376-8ec2baf8ab8d', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 2250000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:30:53', '2026-10-27 07:30:53'),
('01a17dc5-6fde-71fc-b20c-fcc424fe2004', '01a17dc5-6fc2-7050-b376-8ec2baf8ab8d', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 2250000.00, 'Pembayaran Simpanan Wajib Organisasi', '2026-10-27 07:30:53', '2026-10-27 07:30:53'),
('01a17dc5-fb5f-704a-a240-4fe8b4b35910', '01a17dc5-fb5e-7057-8f66-f01047e74b55', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 5000000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:31:29', '2026-10-27 07:31:29'),
('01a17dc5-fb68-7141-b131-f5a48669655d', '01a17dc5-fb5e-7057-8f66-f01047e74b55', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 5000000.00, 'Sumbangan Musywil UMSIDA', '2026-10-27 07:31:29', '2026-10-27 07:31:29'),
('01a17dc6-94e6-73c5-bda3-a305e736d27e', '01a17dc6-94e4-71ed-b0dc-667194ce1899', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 10000000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:32:08', '2026-10-27 07:32:08'),
('01a17dc6-94f2-7094-8aca-657a22cd1732', '01a17dc6-94e4-71ed-b0dc-667194ce1899', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 10000000.00, 'Sumbangan Musywil RS Aisyiyah Bojonegoro', '2026-10-27 07:32:08', '2026-10-27 07:32:08'),
('01a17dc7-1a62-73e1-8cfb-24c4cd4f9a5f', '01a17dc7-1a60-716a-b2c9-73688845aa55', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 5000000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:32:42', '2026-10-27 07:32:42'),
('01a17dc7-1a6c-71aa-94c6-6ff64cb161d9', '01a17dc7-1a60-716a-b2c9-73688845aa55', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 5000000.00, 'Sumbangan Musywil SMA M Gresik', '2026-10-27 07:32:42', '2026-10-27 07:32:42'),
('01a17dc7-9801-72f4-8972-37a2b02384da', '01a17dc7-97ff-70ae-8704-0cd1040ab90b', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 5000000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:33:15', '2026-10-27 07:33:15'),
('01a17dc7-980f-7280-852c-3f3c1b315626', '01a17dc7-97ff-70ae-8704-0cd1040ab90b', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 5000000.00, 'Sumbangan Musywil UMJ', '2026-10-27 07:33:15', '2026-10-27 07:33:15'),
('01a17dc8-31f9-72d5-b0ad-d7de959a2235', '01a17dc8-31f7-708e-af97-87e245ec94b5', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 2500000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:33:54', '2026-10-27 07:33:54'),
('01a17dc8-3205-7056-b02e-2cae2861b99d', '01a17dc8-31f7-708e-af97-87e245ec94b5', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 2500000.00, 'Irvand Gustari', '2026-10-27 07:33:54', '2026-10-27 07:33:54'),
('01a17dc8-bd7a-730c-a056-6135b7a2220c', '01a17dc8-bd77-7175-897a-5d87551ca846', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 10000000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:34:30', '2026-10-27 07:34:30'),
('01a17dc8-bd87-731e-a1d9-7dc625d4b9c8', '01a17dc8-bd77-7175-897a-5d87551ca846', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 10000000.00, 'Mumtaz ( Aad)', '2026-10-27 07:34:30', '2026-10-27 07:34:30'),
('01a17dc9-4bbe-73d1-baa8-a11100d24583', '01a17dc9-4bbc-734e-87e8-cc1653182a98', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 5000000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:35:06', '2026-10-27 07:35:06'),
('01a17dc9-4bd1-72db-92d5-1311f70c88f8', '01a17dc9-4bbc-734e-87e8-cc1653182a98', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 5000000.00, 'UM Lamongan', '2026-10-27 07:35:06', '2026-10-27 07:35:06'),
('01a17dc9-ce30-7011-8c35-ca00954cca7c', '01a17dc9-ce2d-7397-8802-7554369bb41f', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 1000000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:35:39', '2026-10-27 07:35:39'),
('01a17dc9-ce3c-715b-9451-b279367afdd6', '01a17dc9-ce2d-7397-8802-7554369bb41f', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 1000000.00, 'M Idaham.', '2026-10-27 07:35:39', '2026-10-27 07:35:39'),
('01a17dca-5904-7336-9d16-13046cc080f0', '01a17dca-5902-710f-923d-8c9a071fd231', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 3000000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:36:15', '2026-10-27 07:36:15'),
('01a17dca-5912-72e1-b024-fbe39a0ebcda', '01a17dca-5902-710f-923d-8c9a071fd231', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 3000000.00, 'SMPM 12 GKB', '2026-10-27 07:36:15', '2026-10-27 07:36:15'),
('01a17dca-bf3a-73ce-bcff-df186c8aa97f', '01a17dca-bf35-71b8-adf0-574cd4db1885', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 20000000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:36:41', '2026-10-27 07:36:41'),
('01a17dca-bf44-7131-936a-60fe778f3c1f', '01a17dca-bf35-71b8-adf0-574cd4db1885', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 20000000.00, 'RSU Aisyiyah Ponorogo', '2026-10-27 07:36:41', '2026-10-27 07:36:41'),
('01a17dcb-3058-71a9-9192-3ec7e17348de', '01a17dcb-3056-72f7-ba11-acc2c1fdc21e', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 250000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:37:10', '2026-10-27 07:37:10'),
('01a17dcb-3065-709d-8a3e-b7ce675fa112', '01a17dcb-3056-72f7-ba11-acc2c1fdc21e', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 250000.00, 'Ati Fatur.', '2026-10-27 07:37:10', '2026-10-27 07:37:10'),
('01a17dcb-bcff-7294-91cf-462fd31e1c3f', '01a17dcb-bcfd-71ff-b763-ad806994bf5c', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 700000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:37:46', '2026-10-27 07:37:46'),
('01a17dcb-bd13-71fc-9566-6b12a81fffca', '01a17dcb-bcfd-71ff-b763-ad806994bf5c', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 700000.00, 'Asrofi', '2026-10-27 07:37:46', '2026-10-27 07:37:46'),
('01a17dcc-3b02-71af-967e-f9129db97f18', '01a17dcc-3b00-725a-a86e-660c02622cb9', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 10000000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:38:18', '2026-10-27 07:38:18'),
('01a17dcc-3b12-727f-9c89-29e9b1c73ff4', '01a17dcc-3b00-725a-a86e-660c02622cb9', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 10000000.00, 'Prof Zaenudin M', '2026-10-27 07:38:18', '2026-10-27 07:38:18'),
('01a17dcc-a108-716b-a725-29d1a2dfd14c', '01a17dcc-a106-714c-933e-ccfef04f196f', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 5000000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:38:45', '2026-10-27 07:38:45'),
('01a17dcc-a119-7204-9ee0-64705612d9cb', '01a17dcc-a106-714c-933e-ccfef04f196f', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 5000000.00, 'SMKM 7 Gondang', '2026-10-27 07:38:45', '2026-10-27 07:38:45'),
('01a17dcd-281c-7140-be29-72b17361cd6f', '01a17dcd-281a-735b-8f2e-4743c6c19dd0', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 3000000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:39:19', '2026-10-27 07:39:19'),
('01a17dcd-2828-7383-93e1-c4006e124c3b', '01a17dcd-281a-735b-8f2e-4743c6c19dd0', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 3000000.00, 'Pemasukan', '2026-10-27 07:39:19', '2026-10-27 07:39:19'),
('01a17dcd-c4dd-7143-b83e-d3a5d966cb7b', '01a17dcd-c4da-7394-b127-44b811248b3e', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 10000000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:39:59', '2026-10-27 07:39:59'),
('01a17dcd-c4f5-7043-9b5f-06da85b3c30a', '01a17dcd-c4da-7394-b127-44b811248b3e', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 10000000.00, 'RSM Gresik', '2026-10-27 07:39:59', '2026-10-27 07:39:59'),
('01a17dce-47ca-73d3-b369-6f2c583d667f', '01a17dce-47c4-71f5-bcfb-0821fbf5fb6b', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 2500000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:40:33', '2026-10-27 07:40:33'),
('01a17dce-47da-715c-930c-ab0854d7c25c', '01a17dce-47c4-71f5-bcfb-0821fbf5fb6b', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 2500000.00, 'SD M 2 GKB', '2026-10-27 07:40:33', '2026-10-27 07:40:33'),
('01a17dcf-1465-71e6-927b-ba92c0512194', '01a17dcf-1464-70d9-8ae6-dbf02f201985', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 250000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:41:25', '2026-10-27 07:41:25'),
('01a17dcf-146e-71c2-b7a7-04b111735d5c', '01a17dcf-1464-70d9-8ae6-dbf02f201985', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 250000.00, 'Nur Hayati', '2026-10-27 07:41:25', '2026-10-27 07:41:25'),
('01a17dcf-75bf-72da-9b37-dfd1978ca59d', '01a17dcf-75bd-7285-aefb-96a4bfbc7d34', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 1000000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:41:50', '2026-10-27 07:41:50'),
('01a17dcf-75cd-70e4-8db9-4e00713f05a1', '01a17dcf-75bd-7285-aefb-96a4bfbc7d34', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 1000000.00, 'dr. Qonita', '2026-10-27 07:41:50', '2026-10-27 07:41:50'),
('01a17dcf-d53a-73d0-b00d-84e7f5a68aa2', '01a17dcf-d537-7330-8b26-c65b643c1c13', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 2500000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:42:14', '2026-10-27 07:42:14'),
('01a17dcf-d54a-70c0-b10b-543a5fcbeb0f', '01a17dcf-d537-7330-8b26-c65b643c1c13', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 2500000.00, 'SMAM 10 Gresik', '2026-10-27 07:42:14', '2026-10-27 07:42:14'),
('01a17dd0-751c-72ca-83ff-b3d0961d8062', '01a17dd0-751a-7142-a35f-3ca0dfef5629', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 20000000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:42:55', '2026-10-27 07:42:55'),
('01a17dd0-7525-737b-9a43-73ab86a27371', '01a17dd0-751a-7142-a35f-3ca0dfef5629', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 20000000.00, 'PAN Jatim', '2026-10-27 07:42:55', '2026-10-27 07:42:55'),
('01a17dd2-c21c-73b9-84f0-8158c769f012', '01a17dd2-c21a-7245-ae79-c014f93602eb', 'e7d35619-9874-4274-8a71-cd739d923554', 83021.00, 0.00, 'Pembayaran pajak tabungan', '2026-10-27 07:45:26', '2026-10-27 07:45:26'),
('01a17dd2-c227-7122-8225-d107f86374a5', '01a17dd2-c21a-7245-ae79-c014f93602eb', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 0.00, 83021.00, 'Mutasi Kas Keluar', '2026-10-27 07:45:26', '2026-10-27 07:45:26');
INSERT INTO `journal_details` (`id`, `journal_id`, `chart_of_account_id`, `debit`, `credit`, `description`, `created_at`, `updated_at`) VALUES
('01a17dd4-315e-7124-8950-fa3995fa7691', '01a17dd4-315c-72ae-a51a-02cf1d777591', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 415107.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:47:00', '2026-10-27 07:47:00'),
('01a17dd4-316b-71ea-b313-34b109daffe6', '01a17dd4-315c-72ae-a51a-02cf1d777591', '83b231e2-5339-4184-9cb3-6c3737bbee93', 0.00, 415107.00, 'Penerimaan bunga tabungan', '2026-10-27 07:47:00', '2026-10-27 07:47:00'),
('01a17dd4-ed9b-7379-8522-c5b3b2572a7e', '01a17dd4-ed99-7381-a883-e63ffc5819e9', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 10000000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:47:48', '2026-10-27 07:47:48'),
('01a17dd4-eda5-71da-be1e-dd9eb55945ed', '01a17dd4-ed99-7381-a883-e63ffc5819e9', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 10000000.00, 'RS Siti Khodijah', '2026-10-27 07:47:48', '2026-10-27 07:47:48'),
('01a17dd5-708d-70a3-a1c7-f68cf0f6d959', '01a17dd5-708c-720c-a629-a1ed15199ada', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 5000000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:48:22', '2026-10-27 07:48:22'),
('01a17dd5-7098-7131-9048-06561e0bd628', '01a17dd5-708c-720c-a629-a1ed15199ada', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 5000000.00, 'Parahita', '2026-10-27 07:48:22', '2026-10-27 07:48:22'),
('01a17dd6-30ef-72fd-a0ff-31219b1686c7', '01a17dd6-30ec-7137-a8e6-3b21d7cfef16', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 5000000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:49:11', '2026-10-27 07:49:11'),
('01a17dd6-30fd-70a6-a3f4-07bb2a59e0c9', '01a17dd6-30ec-7137-a8e6-3b21d7cfef16', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 5000000.00, 'Universitas Muhammadiyah Gresik', '2026-10-27 07:49:11', '2026-10-27 07:49:11'),
('01a17dd6-c6dc-7259-8c78-4681c28e8522', '01a17dd6-c6d8-707e-990d-ef6c5a47245e', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 500000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:49:50', '2026-10-27 07:49:50'),
('01a17dd6-c6e6-73a9-b8f9-f54f72ab2c88', '01a17dd6-c6d8-707e-990d-ef6c5a47245e', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 500000.00, 'Muhajir', '2026-10-27 07:49:50', '2026-10-27 07:49:50'),
('01a17dd7-630e-7366-9f52-a49caaeae6c5', '01a17dd7-630c-72fb-9b91-a568fa3fd33d', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 10000000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:50:30', '2026-10-27 07:50:30'),
('01a17dd7-631b-7145-a8fc-803b5978c84c', '01a17dd7-630c-72fb-9b91-a568fa3fd33d', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 10000000.00, 'Widati Muhajir', '2026-10-27 07:50:30', '2026-10-27 07:50:30'),
('01a17dd7-f6f1-7347-8b0d-46f7010083f8', '01a17dd7-f6ef-7161-8217-f3c5c6ad5727', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 250000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:51:07', '2026-10-27 07:51:07'),
('01a17dd7-f6fa-7074-aa0f-b842529fda19', '01a17dd7-f6ef-7161-8217-f3c5c6ad5727', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 250000.00, 'Pemasukan', '2026-10-27 07:51:07', '2026-10-27 07:51:07'),
('01a17dd8-7761-73c9-9646-2374d15a54fe', '01a17dd8-775f-720c-b69e-48da90b7edc8', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 3000000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:51:40', '2026-10-27 07:51:40'),
('01a17dd8-776f-7011-a033-23fdc9a5b9fc', '01a17dd8-775f-720c-b69e-48da90b7edc8', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 0.00, 3000000.00, 'Pemasukan', '2026-10-27 07:51:40', '2026-10-27 07:51:40'),
('01a17dd9-34ba-71fe-be9a-e30b01084d64', '01a17dd9-34b7-71c8-bd27-ebebffba9d2f', 'e7d35619-9874-4274-8a71-cd739d923554', 8000.00, 0.00, 'Pembayaran adminitrasi tabungan', '2026-10-27 07:52:29', '2026-10-27 07:52:29'),
('01a17dd9-34c9-7377-941f-42e54b2e2ce4', '01a17dd9-34b7-71c8-bd27-ebebffba9d2f', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 0.00, 8000.00, 'Mutasi Kas Keluar', '2026-10-27 07:52:29', '2026-10-27 07:52:29'),
('01a17ddc-3802-72ed-aab4-3e51bb6cddeb', '01a17ddc-3800-713d-8203-cad95f9c8657', 'b8e89210-2ad3-44b5-b835-c66c8f8d2f0c', 733644.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 07:55:46', '2026-10-27 07:55:46'),
('01a17ddc-380d-719e-9459-c652471cab59', '01a17ddc-3800-713d-8203-cad95f9c8657', '83b231e2-5339-4184-9cb3-6c3737bbee93', 0.00, 733644.00, 'Penerimaan bunga dari bank', '2026-10-27 07:55:46', '2026-10-27 07:55:46'),
('01a17ddc-f7f5-7063-b0f7-3b622484e81a', '01a17ddc-f7f3-7050-93dd-c237ec75b31a', 'e7d35619-9874-4274-8a71-cd739d923554', 146728.00, 0.00, 'Pembayaran pajak tabungan', '2026-10-27 07:56:35', '2026-10-27 07:56:35'),
('01a17ddc-f803-7239-b566-00654911110a', '01a17ddc-f7f3-7050-93dd-c237ec75b31a', 'b8e89210-2ad3-44b5-b835-c66c8f8d2f0c', 0.00, 146728.00, 'Mutasi Kas Keluar', '2026-10-27 07:56:35', '2026-10-27 07:56:35'),
('01a17ddd-94de-711f-80c7-403354dcde9d', '01a17ddd-94dc-7155-a176-118b80a8252c', 'e7d35619-9874-4274-8a71-cd739d923554', 30000.00, 0.00, 'Biaya Admin Giro', '2026-10-27 07:57:15', '2026-10-27 07:57:15'),
('01a17ddd-94ea-7331-a3cf-b09785f51b42', '01a17ddd-94dc-7155-a176-118b80a8252c', 'b8e89210-2ad3-44b5-b835-c66c8f8d2f0c', 0.00, 30000.00, 'Mutasi Kas Keluar', '2026-10-27 07:57:16', '2026-10-27 07:57:16'),
('01a17de9-de6e-70cb-8bf1-338937e3599d', '01a17de9-de6c-7318-a245-83376d640383', 'dc604ee1-502c-456b-8b3d-006762ecedf2', 2400000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 08:10:41', '2026-10-27 08:10:41'),
('01a17de9-de79-7122-b087-a78e79d3a008', '01a17de9-de6c-7318-a245-83376d640383', 'e571cb0d-59ea-4434-acaf-c49027e6102e', 0.00, 2400000.00, 'TRF DR INDAH UMU CHILMI BRI', '2026-10-27 08:10:41', '2026-10-27 08:10:41'),
('01a17dea-7a80-737a-b6b5-6f6623198582', '01a17dea-7a7d-71e7-935e-306807690b8c', 'dc604ee1-502c-456b-8b3d-006762ecedf2', 529300.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 08:11:21', '2026-10-27 08:11:21'),
('01a17dea-7a8d-73b2-a519-22d13cc60148', '01a17dea-7a7d-71e7-935e-306807690b8c', '83b231e2-5339-4184-9cb3-6c3737bbee93', 0.00, 529300.00, 'Bagi Hasil', '2026-10-27 08:11:21', '2026-10-27 08:11:21'),
('01a17deb-748b-708d-98d8-fa492ee99eec', '01a17deb-7489-7264-bcf2-948fb1eb5b37', 'dc604ee1-502c-456b-8b3d-006762ecedf2', 5509500.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 08:12:25', '2026-10-27 08:12:25'),
('01a17deb-7494-724a-820a-6ee3ad4abe00', '01a17deb-7489-7264-bcf2-948fb1eb5b37', '711d6463-1665-4710-b2fb-30af0dc1e664', 0.00, 5509500.00, 'SPP Mahasiswa KIP UMSIDA dari Kota Mojoerto', '2026-10-27 08:12:25', '2026-10-27 08:12:25'),
('01a17dec-59be-72b3-8ae8-534cea8a872b', '01a17dec-59bc-72ec-93d4-065c4c6bd162', 'dc604ee1-502c-456b-8b3d-006762ecedf2', 13994700.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 08:13:23', '2026-10-27 08:13:23'),
('01a17dec-59cc-734a-8f29-a2e130bbc4a5', '01a17dec-59bc-72ec-93d4-065c4c6bd162', '58882c34-1ca0-4af9-8831-ab160748b48d', 0.00, 13994700.00, 'TRF DR BPK MUKHTAMIL PRA BANK BNI', '2026-10-27 08:13:23', '2026-10-27 08:13:23'),
('01a17ded-10f6-7017-8348-ee96ae38b43d', '01a17ded-10f4-706d-a735-7efc62f4afc9', 'dc604ee1-502c-456b-8b3d-006762ecedf2', 2593500.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 08:14:10', '2026-10-27 08:14:10'),
('01a17ded-10fe-72b4-b366-1a2d00e518b7', '01a17ded-10f4-706d-a735-7efc62f4afc9', 'e571cb0d-59ea-4434-acaf-c49027e6102e', 0.00, 2593500.00, 'TRF DR Bank Bukopin Syari Dummy', '2026-10-27 08:14:10', '2026-10-27 08:14:10'),
('01a17ded-e184-7277-ae0a-f36b15749339', '01a17ded-e182-739d-a6f7-d594f46378a2', 'dc604ee1-502c-456b-8b3d-006762ecedf2', 3216000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 08:15:04', '2026-10-27 08:15:04'),
('01a17ded-e18e-70ae-9027-3448fd8876c8', '01a17ded-e182-739d-a6f7-d594f46378a2', 'e571cb0d-59ea-4434-acaf-c49027e6102e', 0.00, 3216000.00, 'Pemasukan', '2026-10-27 08:15:04', '2026-10-27 08:15:04'),
('01a17dee-eef5-73e5-acf9-8a4f02b61bfa', '01a17dee-eef2-708b-bfb5-98a2c34f8cb7', 'dc604ee1-502c-456b-8b3d-006762ecedf2', 344359.00, 0.00, 'Mutasi Kas Masuk', '2026-10-27 08:16:13', '2026-10-27 08:16:13'),
('01a17dee-eeff-7148-82bd-2f37c055c2c7', '01a17dee-eef2-708b-bfb5-98a2c34f8cb7', '83b231e2-5339-4184-9cb3-6c3737bbee93', 0.00, 344359.00, 'Bagi Hasil', '2026-10-27 08:16:13', '2026-10-27 08:16:13'),
('01a17def-a901-70d1-bb85-b1abb8743b32', '01a17def-a8ff-7011-bf4b-7c4f138fc58a', 'e7d35619-9874-4274-8a71-cd739d923554', 105860.00, 0.00, 'Pajak', '2026-10-27 08:17:00', '2026-10-27 08:17:00'),
('01a17def-a90c-71c6-916f-99a170ee65fd', '01a17def-a8ff-7011-bf4b-7c4f138fc58a', 'dc604ee1-502c-456b-8b3d-006762ecedf2', 0.00, 105860.00, 'Mutasi Kas Keluar', '2026-10-27 08:17:00', '2026-10-27 08:17:00'),
('01a17df0-cadd-73d2-a7cc-5cb015d1d853', '01a17df0-cadc-72fa-915e-3446c5a8a85a', '084d9998-26f9-4e60-9673-eb1464e6e379', 9500000.00, 0.00, 'Pengembalian Talangan Uang Inklusi untuk Living Cost 2 Mahasiswa Beasiswa Persayarikatan di UMSIDA', '2026-10-27 08:18:15', '2026-10-27 08:18:15'),
('01a17df0-cae7-7026-82c2-3e07c729419f', '01a17df0-cadc-72fa-915e-3446c5a8a85a', 'e7d35619-9874-4274-8a71-cd739d923554', 2900.00, 0.00, 'SKN', '2026-10-27 08:18:15', '2026-10-27 08:18:15'),
('01a17df0-caec-72ef-9927-bb527f1c65d4', '01a17df0-cadc-72fa-915e-3446c5a8a85a', 'dc604ee1-502c-456b-8b3d-006762ecedf2', 0.00, 9502900.00, 'Mutasi Kas Keluar', '2026-10-27 08:18:15', '2026-10-27 08:18:15'),
('01a17df1-dddf-709a-aca7-c826a597e80e', '01a17df1-dddd-731b-8201-1ae260cc36be', 'e7d35619-9874-4274-8a71-cd739d923554', 10000.00, 0.00, 'Biaya Administrasi', '2026-10-27 08:19:25', '2026-10-27 08:19:25'),
('01a17df1-ddec-7061-a8dc-c35a330e30bc', '01a17df1-dddd-731b-8201-1ae260cc36be', 'dc604ee1-502c-456b-8b3d-006762ecedf2', 0.00, 10000.00, 'Mutasi Kas Keluar', '2026-10-27 08:19:25', '2026-10-27 08:19:25'),
('01a17df2-ad2d-731a-b5ca-95e749b2d468', '01a17df2-ad2b-73e4-a99d-1e8745226a80', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 300000000.00, 0.00, 'RTGS Ke BRI (Panitia Musywil)', '2026-10-27 08:20:18', '2026-10-27 08:20:18'),
('01a17df2-ad3b-7372-9bd3-cdcc615b08bc', '01a17df2-ad2b-73e4-a99d-1e8745226a80', 'e7d35619-9874-4274-8a71-cd739d923554', 30000.00, 0.00, 'Biaya RTGS', '2026-10-27 08:20:18', '2026-10-27 08:20:18'),
('01a17df2-ad44-726f-88e2-5330bc0aad9a', '01a17df2-ad2b-73e4-a99d-1e8745226a80', 'dc604ee1-502c-456b-8b3d-006762ecedf2', 0.00, 300030000.00, 'Mutasi Kas Keluar', '2026-10-27 08:20:18', '2026-10-27 08:20:18'),
('01a17df3-b4b3-73bf-a713-10542b536041', '01a17df3-b4b1-71cc-b16f-a91e0f796856', '084d9998-26f9-4e60-9673-eb1464e6e379', 5509500.00, 0.00, 'Pengembalian SPP Mahasiswa KIP UMSIDA dari Kota Mojoerto', '2026-10-27 08:21:25', '2026-10-27 08:21:25'),
('01a17df3-b4bb-72a8-b8f4-71ad5d24254d', '01a17df3-b4b1-71cc-b16f-a91e0f796856', 'e7d35619-9874-4274-8a71-cd739d923554', 2900.00, 0.00, 'SKN', '2026-10-27 08:21:25', '2026-10-27 08:21:25'),
('01a17df3-b4c1-7228-a18e-954b3a86d803', '01a17df3-b4b1-71cc-b16f-a91e0f796856', 'dc604ee1-502c-456b-8b3d-006762ecedf2', 0.00, 5512400.00, 'Mutasi Kas Keluar', '2026-10-27 08:21:25', '2026-10-27 08:21:25'),
('01a17df4-46f2-7165-82b1-da843f6ac741', '01a17df4-46ef-7046-90c4-6c19f7590269', 'e7d35619-9874-4274-8a71-cd739d923554', 68871.00, 0.00, 'Pajak', '2026-10-27 08:22:03', '2026-10-27 08:22:03'),
('01a17df4-4700-70b6-ab63-857e6ceb3b1f', '01a17df4-46ef-7046-90c4-6c19f7590269', 'dc604ee1-502c-456b-8b3d-006762ecedf2', 0.00, 68871.00, 'Mutasi Kas Keluar', '2026-10-27 08:22:03', '2026-10-27 08:22:03');

-- --------------------------------------------------------

--
-- Struktur dari tabel `media`
--

CREATE TABLE `media` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` char(36) NOT NULL,
  `uuid` char(36) DEFAULT NULL,
  `collection_name` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `mime_type` varchar(255) DEFAULT NULL,
  `disk` varchar(255) NOT NULL,
  `conversions_disk` varchar(255) DEFAULT NULL,
  `size` bigint(20) UNSIGNED NOT NULL,
  `manipulations` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`manipulations`)),
  `custom_properties` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`custom_properties`)),
  `generated_conversions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`generated_conversions`)),
  `responsive_images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`responsive_images`)),
  `order_column` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_01_13_163600_create_permission_tables', 1),
(5, '2026_01_14_190900_create_periods_table', 1),
(6, '2026_01_15_164038_create_sub_periods_table', 1),
(7, '2026_01_18_163017_create_account_types_table', 1),
(8, '2026_01_18_170119_create_chart_of_accounts_table', 1),
(9, '2026_01_21_035339_create_opening_balances_table', 1),
(10, '2026_01_21_035716_create_transactions_table', 1),
(11, '2026_01_21_040204_create_transaction_lines_table', 1),
(12, '2026_01_25_112636_create_user_accounts_table', 1),
(13, '2026_01_25_153318_create_journals_table', 1),
(14, '2026_01_25_153717_create_journal_details_table', 1),
(15, '2026_02_13_034610_create_media_table', 1),
(16, '2026_04_04_161651_create_closing_balances_table', 1),
(17, '2026_05_23_192828_create_coa_balances_table', 1),
(18, '2026_05_23_194011_create_budget_allocations_table', 1),
(19, '2026_05_26_175556_create_activity_logs_table', 1),
(20, '2026_06_01_082259_create_coa_requests_table', 1),
(21, '2026_06_04_180354_create_balance_requests_table', 1),
(22, '2026_06_11_085417_create_configurations_table', 1),
(23, '2026_06_21_081023_create_account_topups_table', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` char(36) NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` char(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` char(36) NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` char(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
('01a1792e-40a5-70ca-bf7e-9b0b5cb36469', 'App\\Models\\User', '01a1792e-4da2-7241-a431-fab908ebcc7c'),
('01a1792e-4484-71d7-a02a-1a15a1bd2bd8', 'App\\Models\\User', '01a1792e-5006-7295-87ce-69d0ddc1b0bd'),
('01a1792e-4845-73b5-b7f1-606a73430783', 'App\\Models\\User', '01a1792e-5006-7295-87ce-69d0ddc1b0bd'),
('01a1792e-4845-73b5-b7f1-606a73430783', 'App\\Models\\User', '01a1792e-5292-7359-a09b-260b0c33e831');

-- --------------------------------------------------------

--
-- Struktur dari tabel `opening_balances`
--

CREATE TABLE `opening_balances` (
  `id` char(36) NOT NULL,
  `chart_of_account_id` char(36) NOT NULL,
  `period_id` char(36) NOT NULL,
  `sub_period_id` char(36) DEFAULT NULL,
  `created_by` char(36) DEFAULT NULL,
  `balance_type` enum('DEBIT','CREDIT') NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `is_correction` tinyint(1) NOT NULL DEFAULT 0,
  `correction_reason` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `opening_balances`
--

INSERT INTO `opening_balances` (`id`, `chart_of_account_id`, `period_id`, `sub_period_id`, `created_by`, `balance_type`, `amount`, `is_correction`, `correction_reason`, `created_at`, `updated_at`) VALUES
('01a17936-5e27-7270-841d-ab31f298ee81', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 194604157.00, 0, NULL, '2026-10-26 10:16:08', '2026-10-26 10:16:08'),
('01a17936-cb3c-70d3-a646-dac580bf314d', 'ad67895d-ef05-4fd3-965c-d793289a3c60', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 4983047.00, 0, NULL, '2026-10-26 10:16:36', '2026-10-26 10:16:36'),
('01a17937-3997-72a2-8701-913e7588d774', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 385384747.00, 0, NULL, '2026-10-26 10:17:04', '2026-10-26 10:17:04'),
('01a17937-a0b4-7048-a006-f7323d326418', 'b8e89210-2ad3-44b5-b835-c66c8f8d2f0c', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 1156982563.00, 0, NULL, '2026-10-26 10:17:31', '2026-10-26 10:17:31'),
('01a17937-fc6f-72c9-b352-7f0dd5de7c3a', 'dc604ee1-502c-456b-8b3d-006762ecedf2', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 377941047.00, 0, NULL, '2026-10-26 10:17:54', '2026-10-26 10:17:54'),
('01a17938-4bbc-73d4-ad10-58b13ac2e51b', 'f0b2f862-b909-4d51-aab8-35aa1a569506', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 1800000.00, 0, NULL, '2026-10-26 10:18:14', '2026-10-26 10:18:14'),
('01a17939-0bd0-7396-9851-5ffa05053d16', 'bd645eab-8d27-47ca-9e1e-eac912720710', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 245583300.00, 0, NULL, '2026-10-26 10:19:04', '2026-10-26 10:19:04'),
('01a1793a-22b1-710f-b4bb-29a536f87032', '58045d05-2f17-4bdc-89cf-9e51f72eec73', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 460769432.00, 0, NULL, '2026-10-26 10:20:15', '2026-10-26 10:20:15'),
('01a1793a-847c-7190-abfb-65d83a4dd692', '20e39474-a65a-4ca5-b57d-890040ebf0de', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', 144000000.00, 0, NULL, '2026-10-26 10:20:40', '2026-10-26 10:20:40'),
('01a1793a-d41f-72a4-8567-0c7c2d0b85bf', '5542cf94-e5bd-46af-b6b3-54952a6d4da0', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 15500000.00, 0, NULL, '2026-10-26 10:21:00', '2026-10-26 10:21:00'),
('01a1793b-99b6-739a-80c3-8eb393ce5e1f', '53402b88-500b-4d58-a421-dc0370942f23', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', 13376668.00, 0, NULL, '2026-10-26 10:21:51', '2026-10-26 10:21:51'),
('01a1793b-ff6b-70de-b597-3ea4fff23f91', '010f231d-89cd-433b-968e-9831ab0acae0', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 46059000.00, 0, NULL, '2026-10-26 10:22:17', '2026-10-26 10:22:17'),
('01a1793c-767d-71e3-ab04-29c1fc1a74b8', 'b3498af8-7715-4285-99c0-e838e553cc93', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', 25236667.00, 0, NULL, '2026-10-26 10:22:48', '2026-10-26 10:22:48'),
('01a1793e-e3af-709c-a6e5-15a2351aa1be', 'e6579eb2-defa-4737-a29d-3d38d6a8bbb6', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 676151976.00, 0, NULL, '2026-10-26 10:25:27', '2026-10-26 10:25:27'),
('01a17957-ffce-720a-9180-9625034a1ae1', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 194604157.00, 0, NULL, '2026-10-26 10:52:52', '2026-10-26 10:52:52'),
('01a17958-456a-73e6-af9a-a2bb837aec83', 'ad67895d-ef05-4fd3-965c-d793289a3c60', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 4983047.00, 0, NULL, '2026-10-26 10:53:10', '2026-10-26 10:53:10'),
('01a17958-78da-7009-bb45-46f2c7508912', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 385384747.00, 0, NULL, '2026-10-26 10:53:23', '2026-10-26 10:53:23'),
('01a17959-1412-7297-8369-e0c20d1a0aef', 'b8e89210-2ad3-44b5-b835-c66c8f8d2f0c', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 1156982563.00, 0, NULL, '2026-10-26 10:54:03', '2026-10-26 10:54:03'),
('01a17959-4915-73fa-975e-a7e18c93f00b', 'dc604ee1-502c-456b-8b3d-006762ecedf2', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 377941047.00, 0, NULL, '2026-10-26 10:54:16', '2026-10-26 10:54:16'),
('01a17959-791c-73f0-82b0-a39c51a4f87d', 'f0b2f862-b909-4d51-aab8-35aa1a569506', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 1800000.00, 0, NULL, '2026-10-26 10:54:29', '2026-10-26 10:54:29'),
('01a17960-82f4-703a-b8c4-56cb7d68db37', 'bd645eab-8d27-47ca-9e1e-eac912720710', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 245583300.00, 0, NULL, '2026-10-26 11:02:10', '2026-10-26 11:02:10'),
('01a17960-c393-7047-b6a5-dba810f8d691', 'e6579eb2-defa-4737-a29d-3d38d6a8bbb6', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 676151976.00, 0, NULL, '2026-10-26 11:02:27', '2026-10-26 11:02:27'),
('01a17961-0bae-7044-aa37-6ce4957567fa', '58045d05-2f17-4bdc-89cf-9e51f72eec73', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 460769432.00, 0, NULL, '2026-10-26 11:02:45', '2026-10-26 11:02:45'),
('01a17961-4659-7167-bdff-300a2f45be65', '20e39474-a65a-4ca5-b57d-890040ebf0de', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', 144000000.00, 0, NULL, '2026-10-26 11:03:00', '2026-10-26 11:03:00'),
('01a17961-9ff4-73fe-9dec-8dff548bd540', '5542cf94-e5bd-46af-b6b3-54952a6d4da0', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 15500000.00, 0, NULL, '2026-10-26 11:03:23', '2026-10-26 11:03:23'),
('01a17961-d8c8-725d-ae8f-e3106caa8dff', '53402b88-500b-4d58-a421-dc0370942f23', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', 13376668.00, 0, NULL, '2026-10-26 11:03:38', '2026-10-26 11:03:38'),
('01a17962-1780-7399-b3b8-6415808050b2', '010f231d-89cd-433b-968e-9831ab0acae0', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 46059000.00, 0, NULL, '2026-10-26 11:03:54', '2026-10-26 11:03:54'),
('01a17962-5f87-724f-8e59-e737b2018e55', 'b3498af8-7715-4285-99c0-e838e553cc93', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', 25236667.00, 0, NULL, '2026-10-26 11:04:12', '2026-10-26 11:04:12'),
('01a1a056-18d9-72c5-919d-23a3b7e806d7', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', '01a1792e-5372-735b-9610-0a8975517760', '01a1a055-aa31-705d-8a07-8046c7f96db0', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 267165132.00, 0, NULL, '2026-11-03 00:35:59', '2026-11-03 00:35:59'),
('01a1a056-52d0-7383-a0d7-52a9f75a2177', 'ad67895d-ef05-4fd3-965c-d793289a3c60', '01a1792e-5372-735b-9610-0a8975517760', '01a1a055-aa31-705d-8a07-8046c7f96db0', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 1009977.00, 0, NULL, '2026-11-03 00:36:14', '2026-11-03 00:36:14'),
('01a1a056-87f0-72d2-8189-fcccf601cda3', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', '01a1792e-5372-735b-9610-0a8975517760', '01a1a055-aa31-705d-8a07-8046c7f96db0', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 624708833.00, 0, NULL, '2026-11-03 00:36:27', '2026-11-03 00:36:27'),
('01a1a056-e68b-71c4-bcdf-d06e824e0b5f', 'b8e89210-2ad3-44b5-b835-c66c8f8d2f0c', '01a1792e-5372-735b-9610-0a8975517760', '01a1a055-aa31-705d-8a07-8046c7f96db0', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 957539479.00, 0, NULL, '2026-11-03 00:36:52', '2026-11-03 00:36:52'),
('01a1a057-216e-713f-8b12-d94630e0d6a6', 'dc604ee1-502c-456b-8b3d-006762ecedf2', '01a1792e-5372-735b-9610-0a8975517760', '01a1a055-aa31-705d-8a07-8046c7f96db0', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 91298375.00, 0, NULL, '2026-11-03 00:37:07', '2026-11-03 00:37:07'),
('01a1a057-5926-720b-bfd0-d36fbe715246', 'f0b2f862-b909-4d51-aab8-35aa1a569506', '01a1792e-5372-735b-9610-0a8975517760', '01a1a055-aa31-705d-8a07-8046c7f96db0', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 1600000.00, 0, NULL, '2026-11-03 00:37:21', '2026-11-03 00:37:21'),
('01a1a057-af2b-7250-8b02-43a83ef736ac', 'bd645eab-8d27-47ca-9e1e-eac912720710', '01a1792e-5372-735b-9610-0a8975517760', '01a1a055-aa31-705d-8a07-8046c7f96db0', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 245583300.00, 0, NULL, '2026-11-03 00:37:43', '2026-11-03 00:37:43'),
('01a1a058-068a-7038-a1f5-28be8a18492e', 'e6579eb2-defa-4737-a29d-3d38d6a8bbb6', '01a1792e-5372-735b-9610-0a8975517760', '01a1a055-aa31-705d-8a07-8046c7f96db0', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 676151976.00, 0, NULL, '2026-11-03 00:38:05', '2026-11-03 00:38:05'),
('01a1a058-a66b-709d-a08e-4c033648dac8', '58045d05-2f17-4bdc-89cf-9e51f72eec73', '01a1792e-5372-735b-9610-0a8975517760', '01a1a055-aa31-705d-8a07-8046c7f96db0', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 460769432.00, 0, NULL, '2026-11-03 00:38:46', '2026-11-03 00:38:46'),
('01a1a058-dacd-73f9-ba41-8447c65c417d', '20e39474-a65a-4ca5-b57d-890040ebf0de', '01a1792e-5372-735b-9610-0a8975517760', '01a1a055-aa31-705d-8a07-8046c7f96db0', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', 144000000.00, 0, NULL, '2026-11-03 00:39:00', '2026-11-03 00:39:00'),
('01a1a059-12e1-7019-b597-091b699250a8', '5542cf94-e5bd-46af-b6b3-54952a6d4da0', '01a1792e-5372-735b-9610-0a8975517760', '01a1a055-aa31-705d-8a07-8046c7f96db0', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 15500000.00, 0, NULL, '2026-11-03 00:39:14', '2026-11-03 00:39:14'),
('01a1a059-473a-700e-8ca1-61bd57f023c3', '53402b88-500b-4d58-a421-dc0370942f23', '01a1792e-5372-735b-9610-0a8975517760', '01a1a055-aa31-705d-8a07-8046c7f96db0', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', 13376668.00, 0, NULL, '2026-11-03 00:39:27', '2026-11-03 00:39:27'),
('01a1a059-832b-7188-88fa-a5c12ae66e1e', 'b3498af8-7715-4285-99c0-e838e553cc93', '01a1792e-5372-735b-9610-0a8975517760', '01a1a055-aa31-705d-8a07-8046c7f96db0', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', 25236667.00, 0, NULL, '2026-11-03 00:39:43', '2026-11-03 00:39:43');

-- --------------------------------------------------------

--
-- Struktur dari tabel `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `periods`
--

CREATE TABLE `periods` (
  `id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `periods`
--

INSERT INTO `periods` (`id`, `name`, `description`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES
('01a1792e-532a-71c5-9f47-bf4b3f756557', '2022', 'Fiscal year 2022', '2022-01-01', '2022-12-31', '2026-10-26 10:07:21', '2026-10-26 10:07:21'),
('01a1792e-5372-735b-9610-0a8975517760', '2023', 'Fiscal year 2023', '2023-01-01', '2023-12-31', '2026-10-26 10:07:21', '2026-10-26 10:07:21');

-- --------------------------------------------------------

--
-- Struktur dari tabel `permissions`
--

CREATE TABLE `permissions` (
  `id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `group` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `group`, `description`, `is_default`, `created_at`, `updated_at`) VALUES
('01a1792e-3a71-7028-8ceb-dda845e9baed', 'view dashboard superadmin', 'web', 'Dashboard', 'Akses dashboard superadmin', 1, '2026-10-26 10:07:15', '2026-10-26 10:07:15'),
('01a1792e-3aa8-73b7-82e4-029e3934c68b', 'view dashboard bendahara', 'web', 'Dashboard', 'Akses dashboard bendahara', 1, '2026-10-26 10:07:15', '2026-10-26 10:07:15'),
('01a1792e-3ad7-7290-84ac-d151b80b843c', 'user view', 'web', 'User Management', 'Melihat data user', 1, '2026-10-26 10:07:15', '2026-10-26 10:07:15'),
('01a1792e-3b01-7280-bddd-ba78063ef420', 'user create', 'web', 'User Management', 'Membuat user baru', 1, '2026-10-26 10:07:15', '2026-10-26 10:07:15'),
('01a1792e-3b2f-7229-8e84-040335c58663', 'user update', 'web', 'User Management', 'Mengubah data user', 1, '2026-10-26 10:07:15', '2026-10-26 10:07:15'),
('01a1792e-3b5d-73ee-97b5-706e1a5adc75', 'user delete', 'web', 'User Management', 'Menghapus user', 1, '2026-10-26 10:07:15', '2026-10-26 10:07:15'),
('01a1792e-3b87-71d9-a66d-915ce216191f', 'role view', 'web', 'Role & Permission', 'Melihat role', 1, '2026-10-26 10:07:15', '2026-10-26 10:07:15'),
('01a1792e-3bb2-7312-8e42-2b88aa8d1679', 'role create', 'web', 'Role & Permission', 'Membuat role', 1, '2026-10-26 10:07:15', '2026-10-26 10:07:15'),
('01a1792e-3bdf-70a2-8e91-a7f52796ed86', 'role update', 'web', 'Role & Permission', 'Mengubah role', 1, '2026-10-26 10:07:15', '2026-10-26 10:07:15'),
('01a1792e-3c0f-7081-be44-33df9e7ce5d1', 'role delete', 'web', 'Role & Permission', 'Menghapus role', 1, '2026-10-26 10:07:15', '2026-10-26 10:07:15'),
('01a1792e-3c39-733d-9905-f348884cc9d1', 'permission view', 'web', 'Role & Permission', 'Melihat permission', 1, '2026-10-26 10:07:15', '2026-10-26 10:07:15'),
('01a1792e-3c66-716b-9b95-028fc22ce8cf', 'permission create', 'web', 'Role & Permission', 'Membuat permission', 1, '2026-10-26 10:07:15', '2026-10-26 10:07:15'),
('01a1792e-3c94-73d0-b1e0-9e724fbbc1a1', 'permission update', 'web', 'Role & Permission', 'Mengubah permission', 1, '2026-10-26 10:07:15', '2026-10-26 10:07:15'),
('01a1792e-3cc4-714d-8758-872a1bab5763', 'permission delete', 'web', 'Role & Permission', 'Menghapus permission', 1, '2026-10-26 10:07:15', '2026-10-26 10:07:15'),
('01a1792e-3cf2-728f-9ca0-86896561b2ff', 'coa view', 'web', 'Master COA', 'Melihat chart of account', 1, '2026-10-26 10:07:15', '2026-10-26 10:07:15'),
('01a1792e-3d1d-71c9-b0e3-2241aee29c71', 'coa create', 'web', 'Master COA', 'Membuat akun COA', 1, '2026-10-26 10:07:15', '2026-10-26 10:07:15'),
('01a1792e-3d47-7357-8a98-9a8983faddfc', 'coa update', 'web', 'Master COA', 'Mengubah akun COA', 1, '2026-10-26 10:07:15', '2026-10-26 10:07:15'),
('01a1792e-3d72-7252-97bc-3c0f17528a47', 'coa delete', 'web', 'Master COA', 'Menghapus akun COA', 1, '2026-10-26 10:07:15', '2026-10-26 10:07:15'),
('01a1792e-3da2-72c2-bbb3-3e44b16d393f', 'coa import', 'web', 'Master COA', 'Import akun COA', 0, '2026-10-26 10:07:16', '2026-10-26 10:07:16'),
('01a1792e-3dce-721f-b016-6019137162df', 'coa assign user', 'web', 'Master COA', 'Menambahkan user ke COA', 0, '2026-10-26 10:07:16', '2026-10-26 10:07:16'),
('01a1792e-3dfa-7397-ae0c-ff834bacde05', 'coa remove user', 'web', 'Master COA', 'Menghapus user dari COA', 0, '2026-10-26 10:07:16', '2026-10-26 10:07:16'),
('01a1792e-3e27-70bf-a445-1897f5189667', 'coa request create', 'web', 'Master COA', 'Request pembuatan akun COA', 0, '2026-10-26 10:07:16', '2026-10-26 10:07:16'),
('01a1792e-3e54-7300-812f-1a3e5151c961', 'journal post', 'web', 'Transactions', 'Posting jurnal umum', 1, '2026-10-26 10:07:16', '2026-10-26 10:07:16'),
('01a1792e-3e7d-7307-88de-712b2007c8cd', 'journal view', 'web', 'Transactions', 'Melihat jurnal umum', 1, '2026-10-26 10:07:16', '2026-10-26 10:07:16'),
('01a1792e-3ea7-71e4-9176-60a1ab3f4ffe', 'transaction income create', 'web', 'Transactions', 'Input transaksi pemasukan', 1, '2026-10-26 10:07:16', '2026-10-26 10:07:16'),
('01a1792e-3ed1-7399-a73c-26ddb58c573f', 'transaction expense create', 'web', 'Transactions', 'Input transaksi pengeluaran', 1, '2026-10-26 10:07:16', '2026-10-26 10:07:16'),
('01a1792e-3efb-711d-86e6-c521a3c0c358', 'transaction import', 'web', 'Transactions', 'Import transaksi', 0, '2026-10-26 10:07:16', '2026-10-26 10:07:16'),
('01a1792e-3f28-727b-a780-60f6ac558b5b', 'ledger create', 'web', 'Ledger', 'Generate buku besar', 1, '2026-10-26 10:07:16', '2026-10-26 10:07:16'),
('01a1792e-3f52-71ef-bb72-c9ad2e735c1b', 'ledger view', 'web', 'Ledger', 'Melihat buku besar', 1, '2026-10-26 10:07:16', '2026-10-26 10:07:16'),
('01a1792e-3f7b-716c-8d48-a0f5dcbc467e', 'ledger view by account', 'web', 'Ledger', 'Melihat buku besar per akun', 1, '2026-10-26 10:07:16', '2026-10-26 10:07:16'),
('01a1792e-3fa2-73fc-b267-03375918e25a', 'report general journal view', 'web', 'Reports', 'Melihat laporan jurnal umum', 1, '2026-10-26 10:07:16', '2026-10-26 10:07:16'),
('01a1792e-3fcb-7312-9260-beb7088fb25c', 'report general journal export', 'web', 'Reports', 'Export laporan jurnal umum', 0, '2026-10-26 10:07:16', '2026-10-26 10:07:16'),
('01a1792e-3ff3-70a4-98d0-7251ca39b9d3', 'report trial balance view', 'web', 'Reports', 'Melihat neraca saldo', 1, '2026-10-26 10:07:16', '2026-10-26 10:07:16'),
('01a1792e-401c-708f-bef6-e357dbbbbb47', 'report trial balance export', 'web', 'Reports', 'Export neraca saldo', 0, '2026-10-26 10:07:16', '2026-10-26 10:07:16'),
('01a1792e-4043-70dc-bdec-1b62dd29e7ac', 'report ledger view', 'web', 'Reports', 'Melihat laporan buku besar', 1, '2026-10-26 10:07:16', '2026-10-26 10:07:16'),
('01a1792e-406b-7298-b1ca-0faa26976a8e', 'report ledger export', 'web', 'Reports', 'Export laporan buku besar', 0, '2026-10-26 10:07:16', '2026-10-26 10:07:16');

-- --------------------------------------------------------

--
-- Struktur dari tabel `roles`
--

CREATE TABLE `roles` (
  `id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
('01a1792e-40a5-70ca-bf7e-9b0b5cb36469', 'SUPER ADMIN', 'web', '2026-10-26 10:07:16', '2026-10-26 10:07:16'),
('01a1792e-4484-71d7-a02a-1a15a1bd2bd8', 'BENDAHARA', 'web', '2026-10-26 10:07:17', '2026-10-26 10:07:17'),
('01a1792e-4845-73b5-b7f1-606a73430783', 'ACCOUNTING USER', 'web', '2026-10-26 10:07:18', '2026-10-26 10:07:18');

-- --------------------------------------------------------

--
-- Struktur dari tabel `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` char(36) NOT NULL,
  `role_id` char(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
('01a1792e-3a71-7028-8ceb-dda845e9baed', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3aa8-73b7-82e4-029e3934c68b', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3aa8-73b7-82e4-029e3934c68b', '01a1792e-4484-71d7-a02a-1a15a1bd2bd8'),
('01a1792e-3ad7-7290-84ac-d151b80b843c', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3b01-7280-bddd-ba78063ef420', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3b2f-7229-8e84-040335c58663', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3b5d-73ee-97b5-706e1a5adc75', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3b87-71d9-a66d-915ce216191f', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3bb2-7312-8e42-2b88aa8d1679', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3bdf-70a2-8e91-a7f52796ed86', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3c0f-7081-be44-33df9e7ce5d1', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3c39-733d-9905-f348884cc9d1', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3c66-716b-9b95-028fc22ce8cf', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3c94-73d0-b1e0-9e724fbbc1a1', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3cc4-714d-8758-872a1bab5763', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3cf2-728f-9ca0-86896561b2ff', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3cf2-728f-9ca0-86896561b2ff', '01a1792e-4484-71d7-a02a-1a15a1bd2bd8'),
('01a1792e-3cf2-728f-9ca0-86896561b2ff', '01a1792e-4845-73b5-b7f1-606a73430783'),
('01a1792e-3d1d-71c9-b0e3-2241aee29c71', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3d1d-71c9-b0e3-2241aee29c71', '01a1792e-4484-71d7-a02a-1a15a1bd2bd8'),
('01a1792e-3d47-7357-8a98-9a8983faddfc', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3d47-7357-8a98-9a8983faddfc', '01a1792e-4484-71d7-a02a-1a15a1bd2bd8'),
('01a1792e-3d72-7252-97bc-3c0f17528a47', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3d72-7252-97bc-3c0f17528a47', '01a1792e-4484-71d7-a02a-1a15a1bd2bd8'),
('01a1792e-3da2-72c2-bbb3-3e44b16d393f', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3da2-72c2-bbb3-3e44b16d393f', '01a1792e-4484-71d7-a02a-1a15a1bd2bd8'),
('01a1792e-3dce-721f-b016-6019137162df', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3dce-721f-b016-6019137162df', '01a1792e-4484-71d7-a02a-1a15a1bd2bd8'),
('01a1792e-3dfa-7397-ae0c-ff834bacde05', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3dfa-7397-ae0c-ff834bacde05', '01a1792e-4484-71d7-a02a-1a15a1bd2bd8'),
('01a1792e-3e27-70bf-a445-1897f5189667', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3e27-70bf-a445-1897f5189667', '01a1792e-4845-73b5-b7f1-606a73430783'),
('01a1792e-3e54-7300-812f-1a3e5151c961', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3e54-7300-812f-1a3e5151c961', '01a1792e-4484-71d7-a02a-1a15a1bd2bd8'),
('01a1792e-3e7d-7307-88de-712b2007c8cd', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3e7d-7307-88de-712b2007c8cd', '01a1792e-4484-71d7-a02a-1a15a1bd2bd8'),
('01a1792e-3e7d-7307-88de-712b2007c8cd', '01a1792e-4845-73b5-b7f1-606a73430783'),
('01a1792e-3ea7-71e4-9176-60a1ab3f4ffe', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3ea7-71e4-9176-60a1ab3f4ffe', '01a1792e-4845-73b5-b7f1-606a73430783'),
('01a1792e-3ed1-7399-a73c-26ddb58c573f', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3ed1-7399-a73c-26ddb58c573f', '01a1792e-4845-73b5-b7f1-606a73430783'),
('01a1792e-3efb-711d-86e6-c521a3c0c358', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3efb-711d-86e6-c521a3c0c358', '01a1792e-4845-73b5-b7f1-606a73430783'),
('01a1792e-3f28-727b-a780-60f6ac558b5b', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3f28-727b-a780-60f6ac558b5b', '01a1792e-4484-71d7-a02a-1a15a1bd2bd8'),
('01a1792e-3f52-71ef-bb72-c9ad2e735c1b', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3f52-71ef-bb72-c9ad2e735c1b', '01a1792e-4484-71d7-a02a-1a15a1bd2bd8'),
('01a1792e-3f7b-716c-8d48-a0f5dcbc467e', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3f7b-716c-8d48-a0f5dcbc467e', '01a1792e-4845-73b5-b7f1-606a73430783'),
('01a1792e-3fa2-73fc-b267-03375918e25a', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3fa2-73fc-b267-03375918e25a', '01a1792e-4484-71d7-a02a-1a15a1bd2bd8'),
('01a1792e-3fcb-7312-9260-beb7088fb25c', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3fcb-7312-9260-beb7088fb25c', '01a1792e-4484-71d7-a02a-1a15a1bd2bd8'),
('01a1792e-3ff3-70a4-98d0-7251ca39b9d3', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-3ff3-70a4-98d0-7251ca39b9d3', '01a1792e-4484-71d7-a02a-1a15a1bd2bd8'),
('01a1792e-401c-708f-bef6-e357dbbbbb47', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-401c-708f-bef6-e357dbbbbb47', '01a1792e-4484-71d7-a02a-1a15a1bd2bd8'),
('01a1792e-4043-70dc-bdec-1b62dd29e7ac', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-4043-70dc-bdec-1b62dd29e7ac', '01a1792e-4484-71d7-a02a-1a15a1bd2bd8'),
('01a1792e-4043-70dc-bdec-1b62dd29e7ac', '01a1792e-4845-73b5-b7f1-606a73430783'),
('01a1792e-406b-7298-b1ca-0faa26976a8e', '01a1792e-40a5-70ca-bf7e-9b0b5cb36469'),
('01a1792e-406b-7298-b1ca-0faa26976a8e', '01a1792e-4484-71d7-a02a-1a15a1bd2bd8'),
('01a1792e-406b-7298-b1ca-0faa26976a8e', '01a1792e-4845-73b5-b7f1-606a73430783');

-- --------------------------------------------------------

--
-- Struktur dari tabel `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` char(36) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('Xt3FenpFfbAMNm5pW6W0upFQHOicTcbkNQe5zddx', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '118.99.111.203', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:159.0) Gecko/20100101 Firefox/159.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiWVhvTnR2WHRjOUVlalpiR1N3ZjZuaG1Hd3pUM1FKUjFtZHkwbFlnbiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NjY6Imh0dHBzOi8vZGlzcG9zaXNpLmVuZ2luZWVyaW5nLXVtc3VyYS5pZC91c2VyL3RyYW5zYWN0aW9ucy9leHBlbnNlcyI7czo1OiJyb3V0ZSI7czozMjoidXNlci50cmFuc2FjdGlvbnMuZXhwZW5zZXMuaW5kZXgiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7czozNjoiMDFhMTc5MmUtNTAwNi03Mjk1LTg3Y2UtNjlkMGRkYzFiMGJkIjt9', 1793691708);

-- --------------------------------------------------------

--
-- Struktur dari tabel `sub_periods`
--

CREATE TABLE `sub_periods` (
  `id` char(36) NOT NULL,
  `period_id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `is_closed` tinyint(1) NOT NULL DEFAULT 0,
  `closed_at` datetime DEFAULT NULL,
  `closed_by` char(36) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `sub_periods`
--

INSERT INTO `sub_periods` (`id`, `period_id`, `name`, `description`, `start_date`, `end_date`, `is_closed`, `closed_at`, `closed_by`, `created_at`, `updated_at`) VALUES
('01a1792e-5359-72cf-8044-02a860ff46d3', '01a1792e-532a-71c5-9f47-bf4b3f756557', 'Desember 2022', 'Bulan Desember 2022', '2022-12-01', '2022-12-31', 1, '2026-10-26 17:52:23', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-26 10:07:21', '2026-10-26 10:52:23'),
('01a1792e-538c-7153-9c05-c54696b8b603', '01a1792e-5372-735b-9610-0a8975517760', 'Januari 2023', 'Bulan Januari 2023', '2023-01-01', '2023-01-31', 1, '2026-11-03 07:35:40', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2026-10-26 10:07:21', '2026-11-03 00:35:40'),
('01a1a055-aa31-705d-8a07-8046c7f96db0', '01a1792e-5372-735b-9610-0a8975517760', 'Februari 2023', NULL, '2023-02-01', '2023-02-28', 0, NULL, NULL, '2026-11-03 00:35:31', '2026-11-03 00:35:31');

-- --------------------------------------------------------

--
-- Struktur dari tabel `transactions`
--

CREATE TABLE `transactions` (
  `id` char(36) NOT NULL,
  `transaction_number` varchar(255) NOT NULL,
  `transaction_date` date NOT NULL,
  `transaction_type` enum('INCOME','EXPENSE','TRANSFER') NOT NULL DEFAULT 'INCOME',
  `description` text DEFAULT NULL,
  `status` enum('DRAFT','POSTED','REVERSED') NOT NULL DEFAULT 'DRAFT',
  `gross_amount` decimal(18,2) NOT NULL,
  `net_amount` decimal(18,2) NOT NULL,
  `referencree_number` varchar(255) DEFAULT NULL,
  `receipt_path` varchar(255) DEFAULT NULL,
  `created_by` char(36) DEFAULT NULL,
  `period_id` char(36) NOT NULL,
  `sub_period_id` char(36) DEFAULT NULL,
  `posted_at` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `transactions`
--

INSERT INTO `transactions` (`id`, `transaction_number`, `transaction_date`, `transaction_type`, `description`, `status`, `gross_amount`, `net_amount`, `referencree_number`, `receipt_path`, `created_by`, `period_id`, `sub_period_id`, `posted_at`, `created_at`, `updated_at`) VALUES
('01a17966-d181-7074-8789-cedca4e44b34', 'TRX-EXP-20261026180903', '2023-01-02', 'EXPENSE', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301021122537792517 Pengisian kas operasional', 'POSTED', 2000000.00, 2000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-26 11:09:03', '2026-10-26 11:09:03'),
('01a17969-af99-7125-8ddf-efcc84b9cb69', 'TRX-EXP-20261026181211', '2023-01-05', 'EXPENSE', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301051121506253692 Tim UMPRO audensi dengan Gubernur', 'POSTED', 3000000.00, 3000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-26 11:12:11', '2026-10-26 11:12:11'),
('01a1796b-08a3-71eb-9ba7-aea0e1e6d807', 'TRX-EXP-20261026181340', '2023-01-05', 'EXPENSE', 'Transfer ke BSI norek. 7187244565 an. ABD Rochim reff. 2301051121506826136 Pembangunan Café termin ke 4', 'POSTED', 60000000.00, 60000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-26 11:13:40', '2026-10-26 11:13:40'),
('01a1796b-baec-7017-b530-ca664f132e7e', 'TRX-EXP-20261026181425', '2023-01-05', 'EXPENSE', 'Administrasi Bank', 'POSTED', 2500.00, 2500.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-26 11:14:25', '2026-10-26 11:14:25'),
('01a1796c-87c5-71cc-bc43-d128253b5312', 'TRX-EXP-20261026181518', '2023-01-05', 'EXPENSE', 'Uang Lembur Yuli untuk persiapan pemeriksaan laporan keuangan (09.00 - 21.00)', 'POSTED', 200000.00, 200000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-26 11:15:18', '2026-10-26 11:15:18'),
('01a17970-e6a1-7344-9896-eec5738b2bf2', 'TRX-EXP-20261026182004', '2023-01-07', 'EXPENSE', 'Tambahan transport Rapat persiapan verifikasi keuangan (17 Des 2017) an Kristin Muslimah dan Transport verifikasi LK (6,7,8 Jan 2023) an Kristin Muslimah (PDA Kediri) dan Tambahan transport Rapat persiapan verifikasi keuangan (17 Des 2017) an. Zubaidatul Hidayah dan Transport verifikasi LK (6,7,8 Jan 2023) an Zubaidatul Hidayah (PDA Sidoarjo) dan Tambahan transport Rapat persiapan verifikasi keuangan (17 Des 2017) an. Martiningsih dan Transport verifikasi LK (6,7,8 Jan 2023) an Martiningsih (PDA Ponorogo) dan Pembelian Klip (yuli) dan Tinta print Data Print, lem, isi staples dan Transfer ke Mandiri Norek. 1400075255555 an. Nawasaka Wisesa reff. 2301071122547782273 untuk pelunasan hotel (full board) dan Parkir', 'POSTED', 11805000.00, 11805000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-26 11:20:04', '2026-10-26 11:20:04'),
('01a17974-9bf0-70aa-a6b7-9022aebba6ec', 'TRX-EXP-20261026182407', '2023-01-08', 'EXPENSE', 'Transfer ke Bank Jatim Norek. 6202209605 an. Siti Zubaidatul Hidayah (PDA Sidoarjo) reff. JMB371957650 untuk pembayaran honor verifikasi keuangan Aisyiyah dan Transfer ke Bank Syariah Indonesia Norek. 7181048365 an. Martiningsih (PDA Ponorogo) reff. 2301081121511786044 untuk pembayaran honor verifikasi keuangan Aisyiyah dan Biaya administrasi bank dan Transfer ke Bank BRI Norek. 625301004203538  an. Kristin Muslimah (PDA Kediri) reff.  497918192617 untuk pembayaran honor verifikasi keuangan Aisyiyah dan Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301081122548316455 untuk pembayaran honor pendamping verifikasi LK Aisyiyah dan Pembayaran honor pendamping verifikasi LK Aisyiyah 3 hari di tambah transpot (Bu Candra Rp. 1.000.000, biaya admin bank Rp. 2500  Bu Anna Marina Rp. 750.000 biaya bank 2500  Bu Heni Rp. 2.500.000 dan Biaya administrasi bank', 'POSTED', 9757500.00, 9757500.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-26 11:24:07', '2026-10-26 11:24:07'),
('01a17976-f378-72c3-b569-23411b62c3bf', 'TRX-EXP-20261026182641', '2023-01-10', 'EXPENSE', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref. 2301101122551693942 Operasional ATC dan Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301101121515400945 Keperluan tim verifikasi, dana surat keterangan konsultan, dan pembuatan laporan 1% dari dana hibah', 'POSTED', 43912975.00, 43912975.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-26 11:26:41', '2026-10-26 11:26:41'),
('01a17977-d24d-702a-9a46-2669b9f696a9', 'TRX-EXP-20261026182738', '2023-01-13', 'EXPENSE', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301131122557316522 untuk kebutuhan Muswil', 'POSTED', 35000000.00, 35000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-26 11:27:38', '2026-10-26 11:27:38'),
('01a1797b-327a-7329-bfb4-f91464c4c06d', 'TRX-EXP-20261026183119', '2023-01-13', 'EXPENSE', 'Pengisian Kas Bendahara dari Bank Jatim Soetomo', 'POSTED', 200000000.00, 200000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-26 11:31:19', '2026-10-26 11:31:19'),
('01a1797c-a1bc-71b4-828b-8320156d3ce2', 'TRX-EXP-20261026183253', '2023-01-16', 'EXPENSE', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301131122557316522 untuk kebutuhan Muswil', 'POSTED', 19700000.00, 19700000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-26 11:32:53', '2026-10-26 11:32:53'),
('01a17980-2bb2-71fa-aeb5-16c2cc75f59d', 'TRX-INC-20261026183645', '2023-01-21', 'INCOME', 'Pemasukan dari Gubernur Jatim untuk bantuan Muswil diberikan ke bu Candra tunai', 'POSTED', 50000000.00, 50000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-26 11:36:45', '2026-10-26 11:36:45'),
('01a17982-39d4-70e3-8370-126e795fb2e8', 'TRX-EXP-20261026183900', '2023-01-24', 'EXPENSE', 'Transfer ke BRI Norek. 115901020724505 an. Fitrijah Hidajati ref. 2301241122573568558 untuk kekurangan dana Muswil dan Biaya Administrasi Bank', 'POSTED', 100002500.00, 100002500.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-26 11:39:00', '2026-10-26 11:39:00'),
('01a1798d-e66d-7357-be23-56892312b096', 'TRX-EXP-20261026185145', '2023-01-25', 'EXPENSE', 'Transfer ke BCA an. Rahmad Deky Zakaria Norek. 0190548848 ref.2301251121539574926 untuk membayaran interior termin 1 dan Biaya Administrasi Bank', 'POSTED', 52523050.00, 52523050.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-26 11:51:45', '2026-10-26 11:51:45'),
('01a1798e-d057-7220-9879-455af2f76612', 'TRX-INC-20261026185245', '2023-01-27', 'INCOME', 'Pemasukan bantuan Muswil dari PWM (cek bank Muamalat)', 'POSTED', 175000000.00, 175000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-26 11:52:45', '2026-10-26 11:52:45'),
('01a17991-38a0-7318-ad56-503bc8f435da', 'TRX-EXP-20261026185522', '2023-01-27', 'EXPENSE', 'Transport (grab) mengantar cek bank Muamallat dan mencairkan cek bank Muamalllat di Jl. Darmo Surabaya, Administrasi bank (yuli) dan Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301271122579384345 untuk honor pegawai PWA', 'POSTED', 9535500.00, 9535500.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-26 11:55:22', '2026-10-26 11:55:22'),
('01a17992-972d-71b4-aaf2-624e6abae914', 'TRX-EXP-20261026185652', '2023-01-31', 'EXPENSE', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301311122586946308 untuk kas operasional', 'POSTED', 5000000.00, 5000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-26 11:56:52', '2026-10-26 11:56:52'),
('01a17d74-9a06-714e-b562-3632207e3b12', 'TRX-EXP-20261027130236', '2023-01-01', 'EXPENSE', 'Transfer Parkir + Biaya', 'POSTED', 402500.00, 402500.00, NULL, NULL, '01a1792e-5292-7359-a09b-260b0c33e831', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 06:02:36', '2026-10-27 06:02:36'),
('01a17d76-1f0c-702b-af44-def1f293e711', 'TRX-INC-20261027130415', '2023-01-01', 'INCOME', 'Cicilan 3 Pak Edi', 'POSTED', 200000.00, 200000.00, NULL, NULL, '01a1792e-5292-7359-a09b-260b0c33e831', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 06:04:15', '2026-10-27 06:04:15'),
('01a17d79-0a76-7368-9163-f333afa1d400', 'TRX-EXP-20261027130726', '2023-01-02', 'EXPENSE', 'Transfer Transport Tim Panlih Daerah dan Zoom', 'POSTED', 1045500.00, 1045500.00, NULL, NULL, '01a1792e-5292-7359-a09b-260b0c33e831', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 06:07:26', '2026-10-27 06:07:26'),
('01a17d7b-7290-7112-93bc-35763e65d74d', 'TRX-EXP-20261027131004', '2023-01-03', 'EXPENSE', 'Listrik Desember Pesma dan Honor Pembina Mahasiswa (B Asmawati) dan Honor Pembina Mahasiswa (B Faridah) dan Honor Pembina Mahasiswa (B Fitriyah) dan Honor Pembina Mahasiswa (B Enik) dan Sopir ke Asrama Haji', 'POSTED', 2580500.00, 2580500.00, NULL, NULL, '01a1792e-5292-7359-a09b-260b0c33e831', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 06:10:04', '2026-10-27 06:10:04'),
('01a17d7c-fb0c-71bb-8249-dc454815cedd', 'TRX-EXP-20261027131145', '2023-01-04', 'EXPENSE', 'Listrik Gg 3 No 33', 'POSTED', 661700.00, 661700.00, NULL, NULL, '01a1792e-5292-7359-a09b-260b0c33e831', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 06:11:45', '2026-10-27 06:11:45'),
('01a17d7e-05f9-7281-b15e-ef8b6d599177', 'TRX-EXP-20261027131253', '2023-01-05', 'EXPENSE', 'Transfer Transport & Akomodasi Tim UMPO Survey', 'POSTED', 1002500.00, 1002500.00, NULL, NULL, '01a1792e-5292-7359-a09b-260b0c33e831', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 06:12:53', '2026-10-27 06:12:53'),
('01a17d81-5d4b-73b1-8cb3-6efb59ff2648', 'TRX-EXP-20261027131632', '2023-01-06', 'EXPENSE', 'Honor Pembina Mahasiswa (B Candra) dan Honor Pembina Mahasiswa (B Rukmini) dan Honor Pembina Mahasiswa (B Sugiarti) dan Transfer Tansport Rapat Panlih & Audensi ke PWM dan Transport Tim Panlih Daerah Lamongan dan Konsumsi Rapat & Audensi PWM dan Konsumsi Audensi Ahlul Bait dan Grab B Heni', 'POSTED', 2925000.00, 2925000.00, NULL, NULL, '01a1792e-5292-7359-a09b-260b0c33e831', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 06:16:32', '2026-10-27 06:16:32'),
('01a17d84-2ec8-70ec-a8a9-ae8658bb4210', 'TRX-EXP-20261027131937', '2023-01-07', 'EXPENSE', 'Transfer Iuran RT 2 Bln 2 Rumah dan Transfer Transport Acara M. Dikdas di Malang Mobil PWA dan Gojek Riwa Riwi Hotel dan Bensin & Tol Acara M. Dikdasmen di Malang Mobil B Lutfah', 'POSTED', 1350000.00, 1350000.00, NULL, NULL, '01a1792e-5292-7359-a09b-260b0c33e831', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 06:19:37', '2026-10-27 06:19:37'),
('01a17d85-a595-71d0-a6ed-1a88073847f6', 'TRX-EXP-20261027132113', '2023-01-08', 'EXPENSE', 'Transfer Sarapan Acara M. Dikdasmen di Malang dan Grab Bawa Berkas ke PWM', 'POSTED', 377500.00, 377500.00, NULL, NULL, '01a1792e-5292-7359-a09b-260b0c33e831', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 06:21:13', '2026-10-27 06:21:13'),
('01a17d86-aa26-706d-a0c8-d64b3dd7ecf2', 'TRX-EXP-20261027132219', '2023-01-09', 'EXPENSE', 'Gosend B Heni', 'POSTED', 23000.00, 23000.00, NULL, NULL, '01a1792e-5292-7359-a09b-260b0c33e831', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 06:22:19', '2026-10-27 06:22:19'),
('01a17d8a-ee2b-7285-956a-9e32ac702117', 'TRX-EXP-20261027132659', '2023-01-10', 'EXPENSE', 'Transfer Transport Audensi ke Gubernur & Takziyah Ayah B Umi H dan Transfer Keperluan Ke Asrama Haji dan Transfer Honor Pembina Mahasiswa (B UMMAH) dan Operasional ATC Jan - Maret dan Transfer Dana Pph 1,5 % Dana Srt Keterangan Konsultan dan Pembuatan Laporan 1 % dan Transfer Honor Pembina Mahasiswa (B Umi T) dan Transfer Honor Pembina Mahasiswa (B Ana) dan Transfer Transport Menghadiri dan Transfer Transport Rapat Pimpinan di ATC 3 Mobil dan Konsumsi Rapat di ATC', 'POSTED', 43007975.00, 43007975.00, NULL, NULL, '01a1792e-5292-7359-a09b-260b0c33e831', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 06:26:59', '2026-10-27 06:26:59'),
('01a17d8c-6d4c-737e-921f-bc91f259556e', 'TRX-EXP-20261027132837', '2023-01-11', 'EXPENSE', 'Transfer Honor Pembina Mahasiswa (B. Ila & P Rosidin) dan Kekurangan Rapat Di ATC', 'POSTED', 2069000.00, 2069000.00, NULL, NULL, '01a1792e-5292-7359-a09b-260b0c33e831', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 06:28:37', '2026-10-27 06:28:37'),
('01a17d8d-c5cd-7316-9d47-58a68cf88f46', 'TRX-EXP-20261027133005', '2023-01-12', 'EXPENSE', 'Indihome', 'POSTED', 327730.00, 327730.00, NULL, NULL, '01a1792e-5292-7359-a09b-260b0c33e831', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 06:30:05', '2026-10-27 06:30:05'),
('01a17d8f-113b-70a0-948b-92ab405ad41b', 'TRX-EXP-20261027133130', '2023-01-13', 'EXPENSE', 'Transfer Dana Musywil dan PDAM rumah rungkut', 'POSTED', 30070440.00, 30070440.00, NULL, NULL, '01a1792e-5292-7359-a09b-260b0c33e831', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 06:31:30', '2026-10-27 06:31:30'),
('01a17d90-51a2-73e6-8830-7a589760c782', 'TRX-EXP-20261027133252', '2023-01-16', 'EXPENSE', 'Transfer Servis Inova Hitam dan Transfer Keperluan Pesma 1 Semester', 'POSTED', 19705000.00, 19705000.00, NULL, NULL, '01a1792e-5292-7359-a09b-260b0c33e831', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 06:32:52', '2026-10-27 06:32:52'),
('01a17d92-54cf-72f8-ae9f-7d2fcebab9d8', 'TRX-EXP-20261027133504', '2023-01-17', 'EXPENSE', 'Bensin dan Transport Rapat dari Malang (Panlih & Persiapan Musywil) dan Transport Tim Panlih Daerah (lamongan & Gresik) dan Gocar Mbk Nurul dari PWA', 'POSTED', 1183500.00, 1183500.00, NULL, NULL, '01a1792e-5292-7359-a09b-260b0c33e831', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 06:35:04', '2026-10-27 06:35:04'),
('01a17d9b-8cae-7344-be2e-fe39864bbc40', 'TRX-INC-20261027134508', '2023-01-17', 'INCOME', 'Saldo Servis Inova Hitam', 'POSTED', 217000.00, 217000.00, NULL, NULL, '01a1792e-5292-7359-a09b-260b0c33e831', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 06:45:08', '2026-10-27 06:45:08'),
('01a17d9d-fc88-710a-ae6f-a9eb3c98419c', 'TRX-EXP-20261027134748', '2023-01-18', 'EXPENSE', 'Stempel LPPA dan Gocar Mbk Nurul dari PWA', 'POSTED', 251500.00, 251500.00, NULL, NULL, '01a1792e-5292-7359-a09b-260b0c33e831', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 06:47:48', '2026-10-27 06:47:48'),
('01a17d9e-a35b-7061-8236-4cdd96a4a781', 'TRX-EXP-20261027134830', '2023-01-19', 'EXPENSE', 'Gosend Undangan Pembukaan Musywil', 'POSTED', 13000.00, 13000.00, NULL, NULL, '01a1792e-5292-7359-a09b-260b0c33e831', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 06:48:30', '2026-10-27 06:48:30'),
('01a17da3-dfe8-72b3-b7ef-ba4aee560f65', 'TRX-EXP-20261027135414', '2023-01-22', 'EXPENSE', 'Transfer Karangan Bunga Musywil PWM dan Transport Tim Verifikasi dari Ponorogo (Musywil) dan Pengembalian Kelebihan Transfer Dana Musywil (Sampang) dan Pengembalian SWP Musywil (KLL)', 'POSTED', 1900000.00, 1900000.00, NULL, NULL, '01a1792e-5292-7359-a09b-260b0c33e831', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 06:54:14', '2026-10-27 06:54:14'),
('01a17da4-e1d7-71f9-81c6-14632be9a012', 'TRX-EXP-20261027135520', '2023-01-24', 'EXPENSE', 'Materai dan Transport & Uang Makan Monev Pemprov ke Asrama ATC', 'POSTED', 650000.00, 650000.00, NULL, NULL, '01a1792e-5292-7359-a09b-260b0c33e831', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 06:55:20', '2026-10-27 06:55:20'),
('01a17da5-7626-70af-bc40-48dbba531f9d', 'TRX-EXP-20261027135558', '2023-01-26', 'EXPENSE', 'Contener 82L', 'POSTED', 555000.00, 555000.00, NULL, NULL, '01a1792e-5292-7359-a09b-260b0c33e831', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 06:55:58', '2026-10-27 06:55:58'),
('01a17da6-85d4-714d-8ba0-610d21aa7838', 'TRX-EXP-20261027135707', '2023-01-27', 'EXPENSE', 'Transfer Honor Media Ig 27 Konten SIA 1 dan Transfer Transport Acara DP3AK 2 Kali', 'POSTED', 1527500.00, 1527500.00, NULL, NULL, '01a1792e-5292-7359-a09b-260b0c33e831', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 06:57:07', '2026-10-27 06:57:07'),
('01a17da7-65fa-72f6-a7a5-4f190e4d83fc', 'TRX-EXP-20261027135805', '2023-01-28', 'EXPENSE', 'Transfer Transport Acara ke Gresik', 'POSTED', 452500.00, 452500.00, NULL, NULL, '01a1792e-5292-7359-a09b-260b0c33e831', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 06:58:05', '2026-10-27 06:58:05'),
('01a17da8-ffdf-737b-b1dc-d66fece257e6', 'TRX-EXP-20261027135949', '2023-01-30', 'EXPENSE', 'Transfer Karangan Bunga Warek UMSIDA dan Keperluan Rapat Tim 11 di ATC', 'POSTED', 1989700.00, 1989700.00, NULL, NULL, '01a1792e-5292-7359-a09b-260b0c33e831', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 06:59:49', '2026-10-27 06:59:49'),
('01a17dae-dbd4-7306-9f4d-8dfc4af69d7e', 'TRX-EXP-20261027140613', '2023-01-31', 'EXPENSE', 'Transfer Honor (Hikma) dan Uang Makan dan Insentif  Musywil dan Transfer Honor l (Yuli) dan Uang Makan dan Insentif  Musywil dan Pulsa Operasional dan Transport Operasional Ke BSB dan B Heni dan Transfer Tansport Ke Nganjuk (Menghadiri) dan Transport dari Malang (Tamu Kodam) dan Bensin Mobil PWA (Tamu Kodam) dan Sopir Mobil PWA (Tamu Kodam) dan Transfer Takziyah Ke PAk Ali Laziz MU', 'POSTED', 8305000.00, 8305000.00, NULL, NULL, '01a1792e-5292-7359-a09b-260b0c33e831', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:06:13', '2026-10-27 07:06:13'),
('01a17dbd-dc1e-71c1-bcef-76dd0da2806d', 'TRX-INC-20261027142237', '2023-01-04', 'INCOME', 'Sumbangan Musywil Bagus Irawa', 'POSTED', 1000000.00, 1000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:22:37', '2026-10-27 07:22:37'),
('01a17dbe-5ecc-725a-b911-e8512fc61018', 'TRX-INC-20261027142310', '2023-01-04', 'INCOME', 'Sumbangan Musywil UMSurabaya', 'POSTED', 25000000.00, 25000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:23:10', '2026-10-27 07:23:10'),
('01a17dbe-ffb2-73f2-8788-6c82fade3fed', 'TRX-INC-20261027142351', '2023-01-04', 'INCOME', 'Pemasukan', 'POSTED', 300000.00, 300000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:23:51', '2026-10-27 07:23:51'),
('01a17dbf-81e9-7090-be05-dddf377a58a1', 'TRX-INC-20261027142425', '2023-01-05', 'INCOME', 'Sumbangan Musywil SMP M 2 Taman', 'POSTED', 3000000.00, 3000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:24:25', '2026-10-27 07:24:25'),
('01a17dc0-5d62-7114-9c41-20d0e7e219c7', 'TRX-INC-20261027142521', '2023-01-05', 'INCOME', 'Sumbangan RSA Dahlan Kediri', 'POSTED', 7500000.00, 7500000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:25:21', '2026-10-27 07:25:21'),
('01a17dc0-f1c3-71dd-bbbe-117fdb7fb5c3', 'TRX-INC-20261027142559', '2023-01-05', 'INCOME', 'Sumbangan SMA M 2 Surabaya', 'POSTED', 5000000.00, 5000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:25:59', '2026-10-27 07:25:59'),
('01a17dc1-9a03-72fa-8f1f-f7e55fd763b9', 'TRX-INC-20261027142642', '2023-01-05', 'INCOME', 'Sumbangan RSI Aisyiyah Malang', 'POSTED', 10000000.00, 10000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:26:42', '2026-10-27 07:26:42'),
('01a17dc2-3f07-7154-82a9-da03ee0d4e86', 'TRX-INC-20261027142724', '2023-01-05', 'INCOME', 'Sumbangan Musywil RSIA Nganjuk', 'POSTED', 20000000.00, 20000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:27:24', '2026-10-27 07:27:24'),
('01a17dc3-5a34-70e8-b247-635f308d2e2c', 'TRX-INC-20261027142837', '2023-01-05', 'INCOME', 'Sumbangan Musywil SMA M 2 Sidoarjo', 'POSTED', 5000000.00, 5000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:28:37', '2026-10-27 07:28:37'),
('01a17dc4-4aa7-7218-a00a-804273587661', 'TRX-INC-20261027142938', '2023-01-06', 'INCOME', 'Sumbangan Musywil SDM 1 Sidoarjo', 'POSTED', 1500000.00, 1500000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:29:38', '2026-10-27 07:29:38'),
('01a17dc4-d49a-7215-862e-0df01df505d3', 'TRX-INC-20261027143013', '2023-01-06', 'INCOME', 'Sumbangan Musywil SMP M 1 Sidoarjo', 'POSTED', 3000000.00, 3000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:30:13', '2026-10-27 07:30:13'),
('01a17dc5-6f8b-70a7-bf52-c15e2977426a', 'TRX-INC-20261027143053', '2023-01-06', 'INCOME', 'Pembayaran Simpanan Wajib Organisasi', 'POSTED', 2250000.00, 2250000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:30:53', '2026-10-27 07:30:53'),
('01a17dc5-fb54-7165-9734-16cb382277fb', 'TRX-INC-20261027143129', '2023-01-06', 'INCOME', 'Sumbangan Musywil UMSIDA', 'POSTED', 5000000.00, 5000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:31:29', '2026-10-27 07:31:29'),
('01a17dc6-94d8-71e1-affb-d0c25037e0ca', 'TRX-INC-20261027143208', '2023-01-06', 'INCOME', 'Sumbangan Musywil RS Aisyiyah Bojonegoro', 'POSTED', 10000000.00, 10000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:32:08', '2026-10-27 07:32:08'),
('01a17dc7-1a58-726b-a06d-d3835c80ef2a', 'TRX-INC-20261027143242', '2023-01-06', 'INCOME', 'Sumbangan Musywil SMA M Gresik', 'POSTED', 5000000.00, 5000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:32:42', '2026-10-27 07:32:42'),
('01a17dc7-97f5-7074-b03f-db444ff1854e', 'TRX-INC-20261027143314', '2023-01-07', 'INCOME', 'Sumbangan Musywil UMJ', 'POSTED', 5000000.00, 5000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:33:14', '2026-10-27 07:33:14'),
('01a17dc8-31ea-71b3-a229-1e738e2cf4f5', 'TRX-INC-20261027143354', '2023-01-09', 'INCOME', 'Irvand Gustari', 'POSTED', 2500000.00, 2500000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:33:54', '2026-10-27 07:33:54'),
('01a17dc8-bd69-7155-a990-b8cde1810de8', 'TRX-INC-20261027143430', '2023-01-09', 'INCOME', 'Mumtaz ( Aad)', 'POSTED', 10000000.00, 10000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:34:30', '2026-10-27 07:34:30'),
('01a17dc9-4bb3-70f3-91e5-741e4406ce89', 'TRX-INC-20261027143506', '2023-01-09', 'INCOME', 'UM Lamongan', 'POSTED', 5000000.00, 5000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:35:06', '2026-10-27 07:35:06'),
('01a17dc9-ce20-72cc-8c43-c3b9fb9695da', 'TRX-INC-20261027143539', '2023-01-09', 'INCOME', 'M Idaham.', 'POSTED', 1000000.00, 1000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:35:39', '2026-10-27 07:35:39'),
('01a17dca-58f8-710a-bc1c-c45ba6bf15af', 'TRX-INC-20261027143615', '2023-01-09', 'INCOME', 'SMPM 12 GKB', 'POSTED', 3000000.00, 3000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:36:15', '2026-10-27 07:36:15'),
('01a17dca-bf2c-715c-b820-1b2fb7b3c8ac', 'TRX-INC-20261027143641', '2023-01-10', 'INCOME', 'RSU Aisyiyah Ponorogo', 'POSTED', 20000000.00, 20000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:36:41', '2026-10-27 07:36:41'),
('01a17dcb-3048-7116-8e1c-98f0d1467bac', 'TRX-INC-20261027143710', '2023-01-11', 'INCOME', 'Ati Fatur.', 'POSTED', 250000.00, 250000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:37:10', '2026-10-27 07:37:10'),
('01a17dcb-bcf4-705a-ab28-0f40c73dead5', 'TRX-INC-20261027143746', '2023-01-12', 'INCOME', 'Asrofi', 'POSTED', 700000.00, 700000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:37:46', '2026-10-27 07:37:46'),
('01a17dcc-3af0-73ee-b70a-1be7e64000d7', 'TRX-INC-20261027143818', '2023-01-12', 'INCOME', 'Prof Zaenudin M', 'POSTED', 10000000.00, 10000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:38:18', '2026-10-27 07:38:18'),
('01a17dcc-a0f2-7221-a5bb-70f6de82170f', 'TRX-INC-20261027143844', '2023-01-12', 'INCOME', 'SMKM 7 Gondang', 'POSTED', 5000000.00, 5000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:38:44', '2026-10-27 07:38:44'),
('01a17dcd-280d-725c-8732-b5534a86b120', 'TRX-INC-20261027143919', '2023-01-13', 'INCOME', 'Pemasukan', 'POSTED', 3000000.00, 3000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:39:19', '2026-10-27 07:39:19'),
('01a17dcd-c4c4-73d8-b11d-b2967a6cfa71', 'TRX-INC-20261027143959', '2023-01-13', 'INCOME', 'RSM Gresik', 'POSTED', 10000000.00, 10000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:39:59', '2026-10-27 07:39:59'),
('01a17dce-47ac-7227-89f1-e0f7ccbceb5a', 'TRX-INC-20261027144033', '2023-01-13', 'INCOME', 'SD M 2 GKB', 'POSTED', 2500000.00, 2500000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:40:33', '2026-10-27 07:40:33'),
('01a17dcf-145b-7129-8327-b3dc55ecf4c3', 'TRX-INC-20261027144125', '2023-01-13', 'INCOME', 'Nur Hayati', 'POSTED', 250000.00, 250000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:41:25', '2026-10-27 07:41:25'),
('01a17dcf-75af-739e-8230-07ea38d8fa2e', 'TRX-INC-20261027144150', '2023-01-13', 'INCOME', 'dr. Qonita', 'POSTED', 1000000.00, 1000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:41:50', '2026-10-27 07:41:50'),
('01a17dcf-d525-70ee-a9eb-b46e3f326095', 'TRX-INC-20261027144214', '2023-01-15', 'INCOME', 'SMAM 10 Gresik', 'POSTED', 2500000.00, 2500000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:42:14', '2026-10-27 07:42:14'),
('01a17dd0-7510-72f0-96a5-dae16265494e', 'TRX-INC-20261027144255', '2023-01-15', 'INCOME', 'PAN Jatim', 'POSTED', 20000000.00, 20000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:42:55', '2026-10-27 07:42:55'),
('01a17dd2-c20c-713a-b5a9-4ed906bf8d8a', 'TRX-EXP-20261027144526', '2023-01-16', 'EXPENSE', 'Pembayaran pajak tabungan', 'POSTED', 83021.00, 83021.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:45:26', '2026-10-27 07:45:26'),
('01a17dd4-3151-7339-992d-68936cd17902', 'TRX-INC-20261027144700', '2023-01-16', 'INCOME', 'Penerimaan bunga tabungan', 'POSTED', 415107.00, 415107.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:47:00', '2026-10-27 07:47:00'),
('01a17dd4-ed91-70e2-a44c-7b2cdae43faa', 'TRX-INC-20261027144748', '2023-01-18', 'INCOME', 'RS Siti Khodijah', 'POSTED', 10000000.00, 10000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:47:48', '2026-10-27 07:47:48'),
('01a17dd5-7082-71ed-b5b1-19c850e6b220', 'TRX-INC-20261027144822', '2023-01-18', 'INCOME', 'Parahita', 'POSTED', 5000000.00, 5000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:48:22', '2026-10-27 07:48:22'),
('01a17dd6-30df-709d-a329-6a66c76838c3', 'TRX-INC-20261027144911', '2023-01-18', 'INCOME', 'Universitas Muhammadiyah Gresik', 'POSTED', 5000000.00, 5000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:49:11', '2026-10-27 07:49:11'),
('01a17dd6-c6cc-7217-bb31-29b026691fd9', 'TRX-INC-20261027144950', '2023-01-19', 'INCOME', 'Muhajir', 'POSTED', 500000.00, 500000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:49:50', '2026-10-27 07:49:50'),
('01a17dd7-62fe-71bd-96e6-129d5ac18c7d', 'TRX-INC-20261027145030', '2023-01-20', 'INCOME', 'Widati Muhajir', 'POSTED', 10000000.00, 10000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:50:30', '2026-10-27 07:50:30'),
('01a17dd7-f6e5-710c-b430-b72c74f3ad5b', 'TRX-INC-20261027145107', '2023-01-21', 'INCOME', 'Pemasukan', 'POSTED', 250000.00, 250000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:51:07', '2026-10-27 07:51:07'),
('01a17dd8-7755-72d6-b00c-1851c22495bc', 'TRX-INC-20261027145140', '2023-01-28', 'INCOME', 'Pemasukan', 'POSTED', 3000000.00, 3000000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:51:40', '2026-10-27 07:51:40'),
('01a17dd9-34a2-71ae-90a6-d3db7938991b', 'TRX-EXP-20261027145229', '2023-01-27', 'EXPENSE', 'Pembayaran adminitrasi tabungan', 'POSTED', 8000.00, 8000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:52:29', '2026-10-27 07:52:29'),
('01a17ddc-37f7-7110-8cff-be4dd3f89ac6', 'TRX-INC-20261027145546', '2023-01-01', 'INCOME', 'Penerimaan bunga dari bank', 'POSTED', 733644.00, 733644.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:55:46', '2026-10-27 07:55:46'),
('01a17ddc-f7d9-70f1-8e0c-2ebbd5029691', 'TRX-EXP-20261027145635', '2023-01-01', 'EXPENSE', 'Pembayaran pajak tabungan', 'POSTED', 146728.00, 146728.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:56:35', '2026-10-27 07:56:35'),
('01a17ddd-94d1-700a-a623-859e3fe29ea3', 'TRX-EXP-20261027145715', '2023-01-27', 'EXPENSE', 'Biaya Admin Giro', 'POSTED', 30000.00, 30000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 07:57:15', '2026-10-27 07:57:15'),
('01a17de9-de63-7123-9545-fdb8f5f145e0', 'TRX-INC-20261027151041', '2023-01-02', 'INCOME', 'TRF DR INDAH UMU CHILMI BRI', 'POSTED', 2400000.00, 2400000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 08:10:41', '2026-10-27 08:10:41'),
('01a17dea-7a71-731f-a74f-f05d47528657', 'TRX-INC-20261027151121', '2023-01-02', 'INCOME', 'Bagi Hasil', 'POSTED', 529300.00, 529300.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 08:11:21', '2026-10-27 08:11:21'),
('01a17deb-7481-7070-8c36-35e08ea37bc5', 'TRX-INC-20261027151225', '2023-01-09', 'INCOME', 'SPP Mahasiswa KIP UMSIDA dari Kota Mojoerto', 'POSTED', 5509500.00, 5509500.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 08:12:25', '2026-10-27 08:12:25'),
('01a17dec-59b1-73a8-b2b8-f1572bcaa35c', 'TRX-INC-20261027151323', '2023-01-12', 'INCOME', 'TRF DR BPK MUKHTAMIL PRA BANK BNI', 'POSTED', 13994700.00, 13994700.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 08:13:23', '2026-10-27 08:13:23'),
('01a17ded-10ed-7035-81b7-d530edb65749', 'TRX-INC-20261027151410', '2023-01-14', 'INCOME', 'TRF DR Bank Bukopin Syari Dummy', 'POSTED', 2593500.00, 2593500.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 08:14:10', '2026-10-27 08:14:10'),
('01a17ded-e175-725b-a452-3a9bb6bfc430', 'TRX-INC-20261027151504', '2023-01-31', 'INCOME', 'Pemasukan', 'POSTED', 3216000.00, 3216000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 08:15:04', '2026-10-27 08:15:04'),
('01a17dee-eeea-7151-a39b-606f051116f9', 'TRX-INC-20261027151613', '2023-01-31', 'INCOME', 'Bagi Hasil', 'POSTED', 344359.00, 344359.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 08:16:13', '2026-10-27 08:16:13'),
('01a17def-a8f7-713d-bceb-4e90e1ae0ba2', 'TRX-EXP-20261027151700', '2023-01-02', 'EXPENSE', 'Pajak', 'POSTED', 105860.00, 105860.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 08:17:00', '2026-10-27 08:17:00'),
('01a17df0-cad2-7334-8a37-b7dd6f8dcbb7', 'TRX-EXP-20261027151814', '2023-01-12', 'EXPENSE', 'Pengembalian Talangan Uang Inklusi untuk Living Cost 2 Mahasiswa Beasiswa Persayarikatan di UMSIDA dan SKN', 'POSTED', 9502900.00, 9502900.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 08:18:14', '2026-10-27 08:18:14'),
('01a17df1-ddd3-7144-ac42-a0aba0fceb35', 'TRX-EXP-20261027151925', '2023-01-15', 'EXPENSE', 'Biaya Administrasi', 'POSTED', 10000.00, 10000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 08:19:25', '2026-10-27 08:19:25'),
('01a17df2-ad1d-7107-a1b9-a5348c938ee5', 'TRX-EXP-20261027152018', '2023-01-18', 'EXPENSE', 'RTGS Ke BRI (Panitia Musywil) dan Biaya RTGS', 'POSTED', 300030000.00, 300030000.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 08:20:18', '2026-10-27 08:20:18'),
('01a17df3-b4a7-732d-85cc-cefef3fd03ad', 'TRX-EXP-20261027152125', '2023-01-30', 'EXPENSE', 'Pengembalian SPP Mahasiswa KIP UMSIDA dari Kota Mojoerto dan SKN', 'POSTED', 5512400.00, 5512400.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 08:21:25', '2026-10-27 08:21:25'),
('01a17df4-469f-73eb-b42a-8d1d6e85d74d', 'TRX-EXP-20261027152203', '2023-01-31', 'EXPENSE', 'Pajak', 'POSTED', 68871.00, 68871.00, NULL, NULL, '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '01a1792e-5372-735b-9610-0a8975517760', '01a1792e-538c-7153-9c05-c54696b8b603', NULL, '2026-10-27 08:22:03', '2026-10-27 08:22:03');

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaction_lines`
--

CREATE TABLE `transaction_lines` (
  `id` char(36) NOT NULL,
  `transaction_id` char(36) NOT NULL,
  `chart_of_account_id` char(36) NOT NULL,
  `position` enum('DEBIT','CREDIT') NOT NULL DEFAULT 'DEBIT',
  `amount` decimal(18,2) NOT NULL,
  `meta_type` enum('MAIN','TAX','INTEREST') NOT NULL DEFAULT 'MAIN',
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `transaction_lines`
--

INSERT INTO `transaction_lines` (`id`, `transaction_id`, `chart_of_account_id`, `position`, `amount`, `meta_type`, `description`, `created_at`, `updated_at`) VALUES
('01a17966-d191-716d-bb7d-8128b9be3377', '01a17966-d181-7074-8789-cedca4e44b34', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'DEBIT', 2000000.00, 'MAIN', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301021122537792517 Pengisian kas operasional', '2026-10-26 11:09:03', '2026-10-26 11:09:03'),
('01a17966-d193-7093-849e-89c1f4a40572', '01a17966-d181-7074-8789-cedca4e44b34', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 'CREDIT', 2000000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-26 11:09:03', '2026-10-26 11:09:03'),
('01a17969-afa8-7202-bdfd-fdb53a86b6ff', '01a17969-af99-7125-8ddf-efcc84b9cb69', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'DEBIT', 3000000.00, 'MAIN', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301051121506253692 Tim UMPRO audensi dengan Gubernur', '2026-10-26 11:12:11', '2026-10-26 11:12:11'),
('01a17969-afaa-70a4-b14a-24ea8e4ff60b', '01a17969-af99-7125-8ddf-efcc84b9cb69', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 'CREDIT', 3000000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-26 11:12:11', '2026-10-26 11:12:11'),
('01a1796b-08b5-71cb-9529-0bd6da7d93ad', '01a1796b-08a3-71eb-9ba7-aea0e1e6d807', '5d121272-39ff-430a-9747-d2778985531c', 'DEBIT', 60000000.00, 'MAIN', 'Transfer ke BSI norek. 7187244565 an. ABD Rochim reff. 2301051121506826136 Pembangunan Café termin ke 4', '2026-10-26 11:13:40', '2026-10-26 11:13:40'),
('01a1796b-08b7-71d2-820a-f0d7482cf695', '01a1796b-08a3-71eb-9ba7-aea0e1e6d807', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 'CREDIT', 60000000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-26 11:13:40', '2026-10-26 11:13:40'),
('01a1796b-baf5-7291-b88b-d023d8d8886a', '01a1796b-baec-7017-b530-ca664f132e7e', 'e7d35619-9874-4274-8a71-cd739d923554', 'DEBIT', 2500.00, 'MAIN', 'Administrasi Bank', '2026-10-26 11:14:25', '2026-10-26 11:14:25'),
('01a1796b-baf6-710c-a9ce-2b1a8917a931', '01a1796b-baec-7017-b530-ca664f132e7e', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 'CREDIT', 2500.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-26 11:14:25', '2026-10-26 11:14:25'),
('01a1796c-87d5-71a3-84b2-c9bd7e7f7813', '01a1796c-87c5-71cc-bc43-d128253b5312', '606cccc9-e4fd-4abe-9b27-2391c7302bc5', 'DEBIT', 200000.00, 'MAIN', 'Uang Lembur Yuli untuk persiapan pemeriksaan laporan keuangan (09.00 - 21.00)', '2026-10-26 11:15:18', '2026-10-26 11:15:18'),
('01a1796c-87d6-7373-a6a0-a1c8ca57ce82', '01a1796c-87c5-71cc-bc43-d128253b5312', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 'CREDIT', 200000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-26 11:15:18', '2026-10-26 11:15:18'),
('01a17970-e6ac-739d-bfad-63dcce566efb', '01a17970-e6a1-7344-9896-eec5738b2bf2', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 'DEBIT', 300000.00, 'MAIN', 'Tambahan transport Rapat persiapan verifikasi keuangan (17 Des 2017) an Kristin Muslimah', '2026-10-26 11:20:04', '2026-10-26 11:20:04'),
('01a17970-e6ba-72ae-aa71-2f23b1230fc8', '01a17970-e6a1-7344-9896-eec5738b2bf2', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 'DEBIT', 400000.00, 'MAIN', 'Transport verifikasi LK (6,7,8 Jan 2023) an Kristin Muslimah (PDA Kediri)', '2026-10-26 11:20:04', '2026-10-26 11:20:04'),
('01a17970-e6c0-7370-8089-491d47df23d3', '01a17970-e6a1-7344-9896-eec5738b2bf2', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 'DEBIT', 200000.00, 'MAIN', 'Tambahan transport Rapat persiapan verifikasi keuangan (17 Des 2017) an. Zubaidatul Hidayah', '2026-10-26 11:20:04', '2026-10-26 11:20:04'),
('01a17970-e6c2-7220-8188-03afe93cd43d', '01a17970-e6a1-7344-9896-eec5738b2bf2', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 'DEBIT', 300000.00, 'MAIN', 'Transport verifikasi LK (6,7,8 Jan 2023) an Zubaidatul Hidayah (PDA Sidoarjo)', '2026-10-26 11:20:04', '2026-10-26 11:20:04'),
('01a17970-e6c4-70fc-93da-8a1dbb60b3e5', '01a17970-e6a1-7344-9896-eec5738b2bf2', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 'DEBIT', 450000.00, 'MAIN', 'Tambahan transport Rapat persiapan verifikasi keuangan (17 Des 2017) an. Martiningsih', '2026-10-26 11:20:04', '2026-10-26 11:20:04'),
('01a17970-e6c6-726b-b495-545159e1ab28', '01a17970-e6a1-7344-9896-eec5738b2bf2', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 'DEBIT', 500000.00, 'MAIN', 'Transport verifikasi LK (6,7,8 Jan 2023) an Martiningsih (PDA Ponorogo)', '2026-10-26 11:20:04', '2026-10-26 11:20:04'),
('01a17970-e6c8-72f8-87dc-58e3c09ac745', '01a17970-e6a1-7344-9896-eec5738b2bf2', '5d137200-2a11-49be-8ae4-b2f6e89d149b', 'DEBIT', 120000.00, 'MAIN', 'Pembelian Klip (yuli)', '2026-10-26 11:20:04', '2026-10-26 11:20:04'),
('01a17970-e6ca-73b4-a4f9-a89bb40464f6', '01a17970-e6a1-7344-9896-eec5738b2bf2', '5d137200-2a11-49be-8ae4-b2f6e89d149b', 'DEBIT', 105000.00, 'MAIN', 'Tinta print Data Print, lem, isi staples', '2026-10-26 11:20:04', '2026-10-26 11:20:04'),
('01a17970-e6cc-7034-b73d-aa22e7056efc', '01a17970-e6a1-7344-9896-eec5738b2bf2', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 'DEBIT', 9420000.00, 'MAIN', 'Transfer ke Mandiri Norek. 1400075255555 an. Nawasaka Wisesa reff. 2301071122547782273 untuk pelunasan hotel (full board)', '2026-10-26 11:20:04', '2026-10-26 11:20:04'),
('01a17970-e6cd-71ec-b5f1-2657f51f10be', '01a17970-e6a1-7344-9896-eec5738b2bf2', '3af9a1f6-445b-437c-8c17-733ac4f6b330', 'DEBIT', 10000.00, 'MAIN', 'Parkir', '2026-10-26 11:20:04', '2026-10-26 11:20:04'),
('01a17970-e6cf-720e-93db-ef76689e572e', '01a17970-e6a1-7344-9896-eec5738b2bf2', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 'CREDIT', 11805000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-26 11:20:04', '2026-10-26 11:20:04'),
('01a17974-9bfe-7014-83fd-edc430510086', '01a17974-9bf0-70aa-a6b7-9022aebba6ec', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 'DEBIT', 1500000.00, 'MAIN', 'Transfer ke Bank Jatim Norek. 6202209605 an. Siti Zubaidatul Hidayah (PDA Sidoarjo) reff. JMB371957650 untuk pembayaran honor verifikasi keuangan Aisyiyah', '2026-10-26 11:24:07', '2026-10-26 11:24:07'),
('01a17974-9c00-7280-82ee-d66e399b7946', '01a17974-9bf0-70aa-a6b7-9022aebba6ec', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 'DEBIT', 1500000.00, 'MAIN', 'Transfer ke Bank Syariah Indonesia Norek. 7181048365 an. Martiningsih (PDA Ponorogo) reff. 2301081121511786044 untuk pembayaran honor verifikasi keuangan Aisyiyah', '2026-10-26 11:24:07', '2026-10-26 11:24:07'),
('01a17974-9c01-70f0-b6d7-1ffb9d4e0997', '01a17974-9bf0-70aa-a6b7-9022aebba6ec', 'e7d35619-9874-4274-8a71-cd739d923554', 'DEBIT', 2500.00, 'MAIN', 'Biaya administrasi bank', '2026-10-26 11:24:07', '2026-10-26 11:24:07'),
('01a17974-9c02-72b9-b486-d686b830c6e1', '01a17974-9bf0-70aa-a6b7-9022aebba6ec', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 'DEBIT', 1500000.00, 'MAIN', 'Transfer ke Bank BRI Norek. 625301004203538  an. Kristin Muslimah (PDA Kediri) reff.  497918192617 untuk pembayaran honor verifikasi keuangan Aisyiyah', '2026-10-26 11:24:07', '2026-10-26 11:24:07'),
('01a17974-9c03-7252-8b0b-b9ef1a459c25', '01a17974-9bf0-70aa-a6b7-9022aebba6ec', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 'DEBIT', 1000000.00, 'MAIN', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301081122548316455 untuk pembayaran honor pendamping verifikasi LK Aisyiyah', '2026-10-26 11:24:07', '2026-10-26 11:24:07'),
('01a17974-9c04-7332-8fe9-6444f672385b', '01a17974-9bf0-70aa-a6b7-9022aebba6ec', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 'DEBIT', 4250000.00, 'MAIN', 'Pembayaran honor pendamping verifikasi LK Aisyiyah 3 hari di tambah transpot (Bu Candra Rp. 1.000.000, biaya admin bank Rp. 2500  Bu Anna Marina Rp. 750.000 biaya bank 2500  Bu Heni Rp. 2.500.000', '2026-10-26 11:24:07', '2026-10-26 11:24:07'),
('01a17974-9c0b-72b5-a2dc-9c5859fbbf2e', '01a17974-9bf0-70aa-a6b7-9022aebba6ec', 'e7d35619-9874-4274-8a71-cd739d923554', 'DEBIT', 5000.00, 'MAIN', 'Biaya administrasi bank', '2026-10-26 11:24:07', '2026-10-26 11:24:07'),
('01a17974-9c0c-7102-994f-61ec35166f26', '01a17974-9bf0-70aa-a6b7-9022aebba6ec', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 'CREDIT', 9757500.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-26 11:24:07', '2026-10-26 11:24:07'),
('01a17976-f382-704a-9183-9ac8e444f404', '01a17976-f378-72c3-b569-23411b62c3bf', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'DEBIT', 21190000.00, 'MAIN', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref. 2301101122551693942 Operasional ATC', '2026-10-26 11:26:41', '2026-10-26 11:26:41'),
('01a17976-f384-715f-aeab-6bb62e0d1029', '01a17976-f378-72c3-b569-23411b62c3bf', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'DEBIT', 22722975.00, 'MAIN', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301101121515400945 Keperluan tim verifikasi, dana surat keterangan konsultan, dan pembuatan laporan 1% dari dana hibah', '2026-10-26 11:26:41', '2026-10-26 11:26:41'),
('01a17976-f385-70ea-9dc1-050fb6fb46ba', '01a17976-f378-72c3-b569-23411b62c3bf', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 'CREDIT', 43912975.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-26 11:26:41', '2026-10-26 11:26:41'),
('01a17977-d254-7011-8b86-577ebc1af964', '01a17977-d24d-702a-9a46-2669b9f696a9', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'DEBIT', 35000000.00, 'MAIN', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301131122557316522 untuk kebutuhan Muswil', '2026-10-26 11:27:38', '2026-10-26 11:27:38'),
('01a17977-d255-71c5-8bc2-ba8e6f059324', '01a17977-d24d-702a-9a46-2669b9f696a9', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 'CREDIT', 35000000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-26 11:27:38', '2026-10-26 11:27:38'),
('01a1797b-3284-71a7-90d9-f59f03326be1', '01a1797b-327a-7329-bfb4-f91464c4c06d', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 'DEBIT', 200000000.00, 'MAIN', 'Pengisian Kas Bendahara dari Bank Jatim Soetomo', '2026-10-26 11:31:19', '2026-10-26 11:31:19'),
('01a1797b-3285-726e-a3d7-fa2338cc3936', '01a1797b-327a-7329-bfb4-f91464c4c06d', 'b8e89210-2ad3-44b5-b835-c66c8f8d2f0c', 'CREDIT', 200000000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-26 11:31:19', '2026-10-26 11:31:19'),
('01a1797c-a1c7-72e6-bcad-fa236ebb5260', '01a1797c-a1bc-71b4-828b-8320156d3ce2', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'DEBIT', 19700000.00, 'MAIN', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301131122557316522 untuk kebutuhan Muswil', '2026-10-26 11:32:53', '2026-10-26 11:32:53'),
('01a1797c-a1cd-7008-9c95-21dd39846533', '01a1797c-a1bc-71b4-828b-8320156d3ce2', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 'CREDIT', 19700000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-26 11:32:53', '2026-10-26 11:32:53'),
('01a17980-2bb8-7333-9569-dd67ec17676d', '01a17980-2bb2-71fa-aeb5-16c2cc75f59d', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 'DEBIT', 50000000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-26 11:36:45', '2026-10-26 11:36:45'),
('01a17980-2bb9-7028-a33c-8ec474043697', '01a17980-2bb2-71fa-aeb5-16c2cc75f59d', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 50000000.00, 'MAIN', 'Pemasukan dari Gubernur Jatim untuk bantuan Muswil diberikan ke bu Candra tunai', '2026-10-26 11:36:45', '2026-10-26 11:36:45'),
('01a17982-39db-7318-ac01-13374c6a4412', '01a17982-39d4-70e3-8370-126e795fb2e8', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 'DEBIT', 100000000.00, 'MAIN', 'Transfer ke BRI Norek. 115901020724505 an. Fitrijah Hidajati ref. 2301241122573568558 untuk kekurangan dana Muswil', '2026-10-26 11:39:00', '2026-10-26 11:39:00'),
('01a17982-39dc-7392-9531-922dee641509', '01a17982-39d4-70e3-8370-126e795fb2e8', 'e7d35619-9874-4274-8a71-cd739d923554', 'DEBIT', 2500.00, 'MAIN', 'Biaya Administrasi Bank', '2026-10-26 11:39:00', '2026-10-26 11:39:00'),
('01a17982-39dd-70f4-ad16-973bc9074a62', '01a17982-39d4-70e3-8370-126e795fb2e8', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 'CREDIT', 100002500.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-26 11:39:00', '2026-10-26 11:39:00'),
('01a1798d-e67e-713b-8a34-7358b21895d3', '01a1798d-e66d-7357-be23-56892312b096', '5d121272-39ff-430a-9747-d2778985531c', 'DEBIT', 52520550.00, 'MAIN', 'Transfer ke BCA an. Rahmad Deky Zakaria Norek. 0190548848 ref.2301251121539574926 untuk membayaran interior termin 1', '2026-10-26 11:51:45', '2026-10-26 11:51:45'),
('01a1798d-e686-7385-b958-90470a69c6cf', '01a1798d-e66d-7357-be23-56892312b096', 'e7d35619-9874-4274-8a71-cd739d923554', 'DEBIT', 2500.00, 'MAIN', 'Biaya Administrasi Bank', '2026-10-26 11:51:45', '2026-10-26 11:51:45'),
('01a1798d-e687-721b-82b6-e39aeb742ed0', '01a1798d-e66d-7357-be23-56892312b096', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 'CREDIT', 52523050.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-26 11:51:45', '2026-10-26 11:51:45'),
('01a1798e-d05e-730c-8f48-7bf5637975da', '01a1798e-d057-7220-9879-455af2f76612', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 'DEBIT', 175000000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-26 11:52:45', '2026-10-26 11:52:45'),
('01a1798e-d05f-71b2-849d-972e68baa0d3', '01a1798e-d057-7220-9879-455af2f76612', '77feaec0-e773-4716-aac8-cd3b08e31d47', 'CREDIT', 175000000.00, 'MAIN', 'Pemasukan bantuan Muswil dari PWM (cek bank Muamalat)', '2026-10-26 11:52:45', '2026-10-26 11:52:45'),
('01a17991-38ab-73bf-9e76-b1cde15d5864', '01a17991-38a0-7318-ad56-503bc8f435da', '4dc29692-975f-482f-b7d0-ee44b410ce11', 'DEBIT', 162500.00, 'MAIN', 'Transport (grab) mengantar cek bank Muamallat dan mencairkan cek bank Muamalllat di Jl. Darmo Surabaya, Administrasi bank (yuli)', '2026-10-26 11:55:22', '2026-10-26 11:55:22'),
('01a17991-38ac-73c6-be00-cd6524019e36', '01a17991-38a0-7318-ad56-503bc8f435da', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'DEBIT', 9373000.00, 'MAIN', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301271122579384345 untuk honor pegawai PWA', '2026-10-26 11:55:22', '2026-10-26 11:55:22'),
('01a17991-38ad-7204-b4fc-a3106b4831b6', '01a17991-38a0-7318-ad56-503bc8f435da', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 'CREDIT', 9535500.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-26 11:55:22', '2026-10-26 11:55:22'),
('01a17992-9739-7388-ab9e-951ab3e009ae', '01a17992-972d-71b4-aaf2-624e6abae914', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'DEBIT', 5000000.00, 'MAIN', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301311122586946308 untuk kas operasional', '2026-10-26 11:56:52', '2026-10-26 11:56:52'),
('01a17992-973b-7348-aaa8-2a28f762e9e8', '01a17992-972d-71b4-aaf2-624e6abae914', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', 'CREDIT', 5000000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-26 11:56:52', '2026-10-26 11:56:52'),
('01a17d74-9a10-73d1-adf8-a4d74dd62cd7', '01a17d74-9a06-714e-b562-3632207e3b12', '3af9a1f6-445b-437c-8c17-733ac4f6b330', 'DEBIT', 402500.00, 'MAIN', 'Transfer Parkir + Biaya', '2026-10-27 06:02:36', '2026-10-27 06:02:36'),
('01a17d74-9a12-71b3-b2d1-56880887845a', '01a17d74-9a06-714e-b562-3632207e3b12', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'CREDIT', 402500.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 06:02:36', '2026-10-27 06:02:36'),
('01a17d76-1f16-7271-a888-32226d761948', '01a17d76-1f0c-702b-af44-def1f293e711', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'DEBIT', 200000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 06:04:15', '2026-10-27 06:04:15'),
('01a17d76-1f19-7056-9a41-92ffe7058c36', '01a17d76-1f0c-702b-af44-def1f293e711', 'f0b2f862-b909-4d51-aab8-35aa1a569506', 'CREDIT', 200000.00, 'MAIN', 'Cicilan 3 Pak Edi', '2026-10-27 06:04:15', '2026-10-27 06:04:15'),
('01a17d79-0a85-70d2-a781-3e71eaa45428', '01a17d79-0a76-7368-9163-f333afa1d400', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 'DEBIT', 902500.00, 'MAIN', 'Transfer Transport Tim Panlih Daerah', '2026-10-27 06:07:26', '2026-10-27 06:07:26'),
('01a17d79-0a88-73c4-ac8e-960bc9560080', '01a17d79-0a76-7368-9163-f333afa1d400', '4b1493eb-71c4-4fdc-9b94-862c313cfef5', 'DEBIT', 143000.00, 'MAIN', 'Zoom', '2026-10-27 06:07:26', '2026-10-27 06:07:26'),
('01a17d79-0a89-7011-92fb-66798a037e91', '01a17d79-0a76-7368-9163-f333afa1d400', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'CREDIT', 1045500.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 06:07:26', '2026-10-27 06:07:26'),
('01a17d7b-729e-7352-8ded-f726725dda64', '01a17d7b-7290-7112-93bc-35763e65d74d', '4b1493eb-71c4-4fdc-9b94-862c313cfef5', 'DEBIT', 480500.00, 'MAIN', 'Listrik Desember Pesma', '2026-10-27 06:10:04', '2026-10-27 06:10:04'),
('01a17d7b-72a0-712f-be3e-ee251275ea01', '01a17d7b-7290-7112-93bc-35763e65d74d', '084d9998-26f9-4e60-9673-eb1464e6e379', 'DEBIT', 500000.00, 'MAIN', 'Honor Pembina Mahasiswa (B Asmawati)', '2026-10-27 06:10:04', '2026-10-27 06:10:04'),
('01a17d7b-72a1-73a0-85fd-5c45cb91aef8', '01a17d7b-7290-7112-93bc-35763e65d74d', '084d9998-26f9-4e60-9673-eb1464e6e379', 'DEBIT', 500000.00, 'MAIN', 'Honor Pembina Mahasiswa (B Faridah)', '2026-10-27 06:10:04', '2026-10-27 06:10:04'),
('01a17d7b-72a1-73a0-85fd-5c45cc8a39a8', '01a17d7b-7290-7112-93bc-35763e65d74d', '084d9998-26f9-4e60-9673-eb1464e6e379', 'DEBIT', 500000.00, 'MAIN', 'Honor Pembina Mahasiswa (B Fitriyah)', '2026-10-27 06:10:04', '2026-10-27 06:10:04'),
('01a17d7b-72a2-7336-86b7-639ea7260b58', '01a17d7b-7290-7112-93bc-35763e65d74d', '084d9998-26f9-4e60-9673-eb1464e6e379', 'DEBIT', 500000.00, 'MAIN', 'Honor Pembina Mahasiswa (B Enik)', '2026-10-27 06:10:04', '2026-10-27 06:10:04'),
('01a17d7b-72a3-7172-b8bf-9d8edd273156', '01a17d7b-7290-7112-93bc-35763e65d74d', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 'DEBIT', 100000.00, 'MAIN', 'Sopir ke Asrama Haji', '2026-10-27 06:10:04', '2026-10-27 06:10:04'),
('01a17d7b-72a3-7172-b8bf-9d8eddcb8c48', '01a17d7b-7290-7112-93bc-35763e65d74d', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'CREDIT', 2580500.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 06:10:04', '2026-10-27 06:10:04'),
('01a17d7c-fb22-71a3-adb5-45cb88cc04db', '01a17d7c-fb0c-71bb-8249-dc454815cedd', '4b1493eb-71c4-4fdc-9b94-862c313cfef5', 'DEBIT', 661700.00, 'MAIN', 'Listrik Gg 3 No 33', '2026-10-27 06:11:45', '2026-10-27 06:11:45'),
('01a17d7c-fb23-71db-b257-8ba060dca44f', '01a17d7c-fb0c-71bb-8249-dc454815cedd', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'CREDIT', 661700.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 06:11:45', '2026-10-27 06:11:45'),
('01a17d7e-0602-7089-8848-fa667ee6d7f2', '01a17d7e-05f9-7281-b15e-ef8b6d599177', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 'DEBIT', 1002500.00, 'MAIN', 'Transfer Transport & Akomodasi Tim UMPO Survey', '2026-10-27 06:12:53', '2026-10-27 06:12:53'),
('01a17d7e-0604-706a-af58-57e7ee514e22', '01a17d7e-05f9-7281-b15e-ef8b6d599177', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'CREDIT', 1002500.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 06:12:53', '2026-10-27 06:12:53'),
('01a17d81-5d50-7247-9c1c-f9cf060099c8', '01a17d81-5d4b-73b1-8cb3-6efb59ff2648', '084d9998-26f9-4e60-9673-eb1464e6e379', 'DEBIT', 500000.00, 'MAIN', 'Honor Pembina Mahasiswa (B Candra)', '2026-10-27 06:16:32', '2026-10-27 06:16:32'),
('01a17d81-5d52-7163-ac41-9913ee1a57ec', '01a17d81-5d4b-73b1-8cb3-6efb59ff2648', '084d9998-26f9-4e60-9673-eb1464e6e379', 'DEBIT', 500000.00, 'MAIN', 'Honor Pembina Mahasiswa (B Rukmini)', '2026-10-27 06:16:32', '2026-10-27 06:16:32'),
('01a17d81-5d53-716f-a980-5e618059a921', '01a17d81-5d4b-73b1-8cb3-6efb59ff2648', '084d9998-26f9-4e60-9673-eb1464e6e379', 'DEBIT', 500000.00, 'MAIN', 'Honor Pembina Mahasiswa (B Sugiarti)', '2026-10-27 06:16:32', '2026-10-27 06:16:32'),
('01a17d81-5d60-710f-bbe6-3ff6cae7b4a6', '01a17d81-5d4b-73b1-8cb3-6efb59ff2648', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 'DEBIT', 402500.00, 'MAIN', 'Transfer Tansport Rapat Panlih & Audensi ke PWM', '2026-10-27 06:16:32', '2026-10-27 06:16:32'),
('01a17d81-5d61-71ed-a5b9-4d71fdfd4a9c', '01a17d81-5d4b-73b1-8cb3-6efb59ff2648', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 'DEBIT', 300000.00, 'MAIN', 'Transport Tim Panlih Daerah Lamongan', '2026-10-27 06:16:32', '2026-10-27 06:16:32'),
('01a17d81-5d63-738e-9ad4-1ba12f6d0a58', '01a17d81-5d4b-73b1-8cb3-6efb59ff2648', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 'DEBIT', 225500.00, 'MAIN', 'Konsumsi Rapat & Audensi PWM', '2026-10-27 06:16:32', '2026-10-27 06:16:32'),
('01a17d81-5d65-72dc-ad11-004ebd09aa57', '01a17d81-5d4b-73b1-8cb3-6efb59ff2648', '084d9998-26f9-4e60-9673-eb1464e6e379', 'DEBIT', 450000.00, 'MAIN', 'Konsumsi Audensi Ahlul Bait', '2026-10-27 06:16:32', '2026-10-27 06:16:32'),
('01a17d81-5d67-7066-8f9f-5c3f398d79df', '01a17d81-5d4b-73b1-8cb3-6efb59ff2648', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 'DEBIT', 47000.00, 'MAIN', 'Grab B Heni', '2026-10-27 06:16:32', '2026-10-27 06:16:32'),
('01a17d81-5d68-7288-82d8-918f243777dd', '01a17d81-5d4b-73b1-8cb3-6efb59ff2648', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'CREDIT', 2925000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 06:16:32', '2026-10-27 06:16:32'),
('01a17d84-2ed3-73ae-bbb3-80bd58773c23', '01a17d84-2ec8-70ec-a8a9-ae8658bb4210', '15d08eb5-60ee-4fca-a440-546aef11ff68', 'DEBIT', 402500.00, 'MAIN', 'Transfer Iuran RT 2 Bln 2 Rumah', '2026-10-27 06:19:37', '2026-10-27 06:19:37'),
('01a17d84-2ed5-7119-8a59-34cfeabf3038', '01a17d84-2ec8-70ec-a8a9-ae8658bb4210', '4dc29692-975f-482f-b7d0-ee44b410ce11', 'DEBIT', 552500.00, 'MAIN', 'Transfer Transport Acara M. Dikdas di Malang Mobil PWA', '2026-10-27 06:19:37', '2026-10-27 06:19:37'),
('01a17d84-2ed5-7119-8a59-34cfeb5f9d68', '01a17d84-2ec8-70ec-a8a9-ae8658bb4210', '1638884c-8d9c-4db7-963a-f5169cb09400', 'DEBIT', 45000.00, 'MAIN', 'Gojek Riwa Riwi Hotel', '2026-10-27 06:19:37', '2026-10-27 06:19:37'),
('01a17d84-2ed6-72a3-a055-609bc49a415c', '01a17d84-2ec8-70ec-a8a9-ae8658bb4210', '25c9837f-2d00-4d5a-ac4f-3cca3986cd2c', 'DEBIT', 350000.00, 'MAIN', 'Bensin & Tol Acara M. Dikdasmen di Malang Mobil B Lutfah', '2026-10-27 06:19:37', '2026-10-27 06:19:37'),
('01a17d84-2ed7-7379-a718-679aaa3703d7', '01a17d84-2ec8-70ec-a8a9-ae8658bb4210', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'CREDIT', 1350000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 06:19:37', '2026-10-27 06:19:37'),
('01a17d85-a5a3-703e-9ce1-8bcc3e85fa5f', '01a17d85-a595-71d0-a6ed-1a88073847f6', '25c9837f-2d00-4d5a-ac4f-3cca3986cd2c', 'DEBIT', 352500.00, 'MAIN', 'Transfer Sarapan Acara M. Dikdasmen di Malang', '2026-10-27 06:21:13', '2026-10-27 06:21:13'),
('01a17d85-a5a5-70df-83e2-34b378951535', '01a17d85-a595-71d0-a6ed-1a88073847f6', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 'DEBIT', 25000.00, 'MAIN', 'Grab Bawa Berkas ke PWM', '2026-10-27 06:21:13', '2026-10-27 06:21:13'),
('01a17d85-a5a6-705e-92eb-781a5e1d1ed9', '01a17d85-a595-71d0-a6ed-1a88073847f6', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'CREDIT', 377500.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 06:21:13', '2026-10-27 06:21:13'),
('01a17d86-aa2e-73d6-ab2a-cfd3b145c031', '01a17d86-aa26-706d-a0c8-d64b3dd7ecf2', '7703cbfd-b06b-4acf-97cc-7cf6f0b3d94c', 'DEBIT', 23000.00, 'MAIN', 'Gosend B Heni', '2026-10-27 06:22:19', '2026-10-27 06:22:19'),
('01a17d86-aa30-71d7-81ed-8db7a70a86a5', '01a17d86-aa26-706d-a0c8-d64b3dd7ecf2', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'CREDIT', 23000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 06:22:19', '2026-10-27 06:22:19'),
('01a17d8a-ee32-704f-99a5-4e092bc24536', '01a17d8a-ee2b-7285-956a-9e32ac702117', '4dc29692-975f-482f-b7d0-ee44b410ce11', 'DEBIT', 802500.00, 'MAIN', 'Transfer Transport Audensi ke Gubernur & Takziyah Ayah B Umi H', '2026-10-27 06:26:59', '2026-10-27 06:26:59'),
('01a17d8a-ee34-72ac-b07a-168bebfe86c8', '01a17d8a-ee2b-7285-956a-9e32ac702117', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 'DEBIT', 327500.00, 'MAIN', 'Transfer Keperluan Ke Asrama Haji', '2026-10-27 06:26:59', '2026-10-27 06:26:59'),
('01a17d8a-ee38-70e0-b948-9f51c2c6ee8d', '01a17d8a-ee2b-7285-956a-9e32ac702117', '084d9998-26f9-4e60-9673-eb1464e6e379', 'DEBIT', 502500.00, 'MAIN', 'Transfer Honor Pembina Mahasiswa (B UMMAH)', '2026-10-27 06:26:59', '2026-10-27 06:26:59'),
('01a17d8a-ee39-7067-875d-7cebf734a4ea', '01a17d8a-ee2b-7285-956a-9e32ac702117', '2d10b459-e593-4abe-9dd4-d1ae34a1db88', 'DEBIT', 15190000.00, 'MAIN', 'Operasional ATC Jan - Maret', '2026-10-27 06:26:59', '2026-10-27 06:26:59'),
('01a17d8a-ee3a-73b1-b4c2-120dba01665d', '01a17d8a-ee2b-7285-956a-9e32ac702117', '084d9998-26f9-4e60-9673-eb1464e6e379', 'DEBIT', 22725475.00, 'MAIN', 'Transfer Dana Pph 1,5 % Dana Srt Keterangan Konsultan dan Pembuatan Laporan 1 %', '2026-10-27 06:26:59', '2026-10-27 06:26:59'),
('01a17d8a-ee3c-71f5-b8c7-bb914b380efe', '01a17d8a-ee2b-7285-956a-9e32ac702117', '084d9998-26f9-4e60-9673-eb1464e6e379', 'DEBIT', 502500.00, 'MAIN', 'Transfer Honor Pembina Mahasiswa (B Umi T)', '2026-10-27 06:26:59', '2026-10-27 06:26:59'),
('01a17d8a-ee3d-726f-a6a4-209aed533d79', '01a17d8a-ee2b-7285-956a-9e32ac702117', '084d9998-26f9-4e60-9673-eb1464e6e379', 'DEBIT', 502500.00, 'MAIN', 'Transfer Honor Pembina Mahasiswa (B Ana)', '2026-10-27 06:26:59', '2026-10-27 06:26:59'),
('01a17d8a-ee3e-72ae-b2d9-56df7042d79b', '01a17d8a-ee2b-7285-956a-9e32ac702117', '4dc29692-975f-482f-b7d0-ee44b410ce11', 'DEBIT', 252500.00, 'MAIN', 'Transfer Transport Menghadiri', '2026-10-27 06:26:59', '2026-10-27 06:26:59'),
('01a17d8a-ee40-72ca-b342-574fc26dcc32', '01a17d8a-ee2b-7285-956a-9e32ac702117', '084d9998-26f9-4e60-9673-eb1464e6e379', 'DEBIT', 1202500.00, 'MAIN', 'Transfer Transport Rapat Pimpinan di ATC 3 Mobil', '2026-10-27 06:26:59', '2026-10-27 06:26:59'),
('01a17d8a-ee41-728a-849f-d8172e3e2566', '01a17d8a-ee2b-7285-956a-9e32ac702117', '084d9998-26f9-4e60-9673-eb1464e6e379', 'DEBIT', 1000000.00, 'MAIN', 'Konsumsi Rapat di ATC', '2026-10-27 06:26:59', '2026-10-27 06:26:59'),
('01a17d8a-ee42-7163-94fa-3c5845de7ef3', '01a17d8a-ee2b-7285-956a-9e32ac702117', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'CREDIT', 43007975.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 06:26:59', '2026-10-27 06:26:59'),
('01a17d8c-6d53-737b-92e7-9071ccb5c6b7', '01a17d8c-6d4c-737e-921f-bc91f259556e', '084d9998-26f9-4e60-9673-eb1464e6e379', 'DEBIT', 1000000.00, 'MAIN', 'Transfer Honor Pembina Mahasiswa (B. Ila & P Rosidin)', '2026-10-27 06:28:37', '2026-10-27 06:28:37'),
('01a17d8c-6d54-722b-87db-ddb17c763122', '01a17d8c-6d4c-737e-921f-bc91f259556e', '084d9998-26f9-4e60-9673-eb1464e6e379', 'DEBIT', 1069000.00, 'MAIN', 'Kekurangan Rapat Di ATC', '2026-10-27 06:28:37', '2026-10-27 06:28:37'),
('01a17d8c-6d56-7089-abe4-d07c1eaf4f73', '01a17d8c-6d4c-737e-921f-bc91f259556e', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'CREDIT', 2069000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 06:28:37', '2026-10-27 06:28:37'),
('01a17d8d-c5db-72ef-95de-9c8afd79c6ed', '01a17d8d-c5cd-7316-9d47-58a68cf88f46', '4b1493eb-71c4-4fdc-9b94-862c313cfef5', 'DEBIT', 327730.00, 'MAIN', 'Indihome', '2026-10-27 06:30:05', '2026-10-27 06:30:05'),
('01a17d8d-c5dd-70ff-8e85-e3f37d56e0de', '01a17d8d-c5cd-7316-9d47-58a68cf88f46', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'CREDIT', 327730.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 06:30:05', '2026-10-27 06:30:05'),
('01a17d8f-1143-7133-a429-67ffcd6ab798', '01a17d8f-113b-70a0-948b-92ab405ad41b', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 'DEBIT', 30002500.00, 'MAIN', 'Transfer Dana Musywil', '2026-10-27 06:31:30', '2026-10-27 06:31:30'),
('01a17d8f-1145-7334-a6fe-adb7643158cb', '01a17d8f-113b-70a0-948b-92ab405ad41b', '4b1493eb-71c4-4fdc-9b94-862c313cfef5', 'DEBIT', 67940.00, 'MAIN', 'PDAM rumah rungkut', '2026-10-27 06:31:30', '2026-10-27 06:31:30'),
('01a17d8f-1146-7103-ba33-50b638fb67b6', '01a17d8f-113b-70a0-948b-92ab405ad41b', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'CREDIT', 30070440.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 06:31:30', '2026-10-27 06:31:30'),
('01a17d90-51ad-71b7-9225-ca92d7330b87', '01a17d90-51a2-73e6-8830-7a589760c782', 'fde4a381-dde7-4ade-b28c-92d51e46158e', 'DEBIT', 4702500.00, 'MAIN', 'Transfer Servis Inova Hitam', '2026-10-27 06:32:52', '2026-10-27 06:32:52'),
('01a17d90-51ae-7266-97d6-c31c59ca1b8f', '01a17d90-51a2-73e6-8830-7a589760c782', '084d9998-26f9-4e60-9673-eb1464e6e379', 'DEBIT', 15002500.00, 'MAIN', 'Transfer Keperluan Pesma 1 Semester', '2026-10-27 06:32:52', '2026-10-27 06:32:52'),
('01a17d90-51af-73b6-a290-0c087ce8378c', '01a17d90-51a2-73e6-8830-7a589760c782', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'CREDIT', 19705000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 06:32:52', '2026-10-27 06:32:52'),
('01a17d92-54d4-738d-8f70-9ab876c1c96a', '01a17d92-54cf-72f8-ae9f-7d2fcebab9d8', '345a9584-2788-47b3-978b-4dc9e20019ef', 'DEBIT', 100000.00, 'MAIN', 'Bensin', '2026-10-27 06:35:04', '2026-10-27 06:35:04'),
('01a17d92-54d5-71b3-a05b-293e9e0644f3', '01a17d92-54cf-72f8-ae9f-7d2fcebab9d8', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 'DEBIT', 400000.00, 'MAIN', 'Transport Rapat dari Malang (Panlih & Persiapan Musywil)', '2026-10-27 06:35:04', '2026-10-27 06:35:04'),
('01a17d92-54d6-7358-b31c-d7a18a3a7b3e', '01a17d92-54cf-72f8-ae9f-7d2fcebab9d8', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 'DEBIT', 600000.00, 'MAIN', 'Transport Tim Panlih Daerah (lamongan & Gresik)', '2026-10-27 06:35:04', '2026-10-27 06:35:04'),
('01a17d92-54d7-72de-a5ae-ae52d50cdb28', '01a17d92-54cf-72f8-ae9f-7d2fcebab9d8', '4dc29692-975f-482f-b7d0-ee44b410ce11', 'DEBIT', 83500.00, 'MAIN', 'Gocar Mbk Nurul dari PWA', '2026-10-27 06:35:04', '2026-10-27 06:35:04'),
('01a17d92-54d8-7278-a76f-5430b8a04c25', '01a17d92-54cf-72f8-ae9f-7d2fcebab9d8', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'CREDIT', 1183500.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 06:35:04', '2026-10-27 06:35:04'),
('01a17d9b-8cb5-73bd-9181-cb2f431a5539', '01a17d9b-8cae-7344-be2e-fe39864bbc40', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'DEBIT', 217000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 06:45:08', '2026-10-27 06:45:08'),
('01a17d9b-8cb6-700d-bd0a-9a05b50b8508', '01a17d9b-8cae-7344-be2e-fe39864bbc40', 'fde4a381-dde7-4ade-b28c-92d51e46158e', 'CREDIT', 217000.00, 'MAIN', 'Saldo Servis Inova Hitam', '2026-10-27 06:45:08', '2026-10-27 06:45:08'),
('01a17d9d-fc94-711e-9d60-043dba854f06', '01a17d9d-fc88-710a-ae6f-a9eb3c98419c', 'cd26292d-ed27-4e29-af2f-d3bd7c9ccb94', 'DEBIT', 175000.00, 'MAIN', 'Stempel LPPA', '2026-10-27 06:47:48', '2026-10-27 06:47:48'),
('01a17d9d-fc98-735a-be7a-e1bf7b79d85e', '01a17d9d-fc88-710a-ae6f-a9eb3c98419c', '4dc29692-975f-482f-b7d0-ee44b410ce11', 'DEBIT', 76500.00, 'MAIN', 'Gocar Mbk Nurul dari PWA', '2026-10-27 06:47:48', '2026-10-27 06:47:48'),
('01a17d9d-fc9a-72a7-b6e2-e6a1dcf9eed9', '01a17d9d-fc88-710a-ae6f-a9eb3c98419c', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'CREDIT', 251500.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 06:47:48', '2026-10-27 06:47:48'),
('01a17d9e-a362-738a-94a4-13a29925ce3d', '01a17d9e-a35b-7061-8236-4cdd96a4a781', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 'DEBIT', 13000.00, 'MAIN', 'Gosend Undangan Pembukaan Musywil', '2026-10-27 06:48:30', '2026-10-27 06:48:30'),
('01a17d9e-a363-71b4-93e8-42041785d7b8', '01a17d9e-a35b-7061-8236-4cdd96a4a781', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'CREDIT', 13000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 06:48:30', '2026-10-27 06:48:30'),
('01a17da3-dfef-7257-9a5a-b43a35e4caee', '01a17da3-dfe8-72b3-b7ef-ba4aee560f65', '3977d722-ebce-4252-9cca-b4a65a22876f', 'DEBIT', 600000.00, 'MAIN', 'Transfer Karangan Bunga Musywil PWM', '2026-10-27 06:54:14', '2026-10-27 06:54:14'),
('01a17da3-dff1-7051-99bd-ad94cd90c872', '01a17da3-dfe8-72b3-b7ef-ba4aee560f65', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 'DEBIT', 500000.00, 'MAIN', 'Transport Tim Verifikasi dari Ponorogo (Musywil)', '2026-10-27 06:54:14', '2026-10-27 06:54:14'),
('01a17da3-dff2-7157-8c62-495cf939d98d', '01a17da3-dfe8-72b3-b7ef-ba4aee560f65', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 'DEBIT', 500000.00, 'MAIN', 'Pengembalian Kelebihan Transfer Dana Musywil (Sampang)', '2026-10-27 06:54:14', '2026-10-27 06:54:14'),
('01a17da3-dff3-721a-b2e2-55422f154f49', '01a17da3-dfe8-72b3-b7ef-ba4aee560f65', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 'DEBIT', 300000.00, 'MAIN', 'Pengembalian SWP Musywil (KLL)', '2026-10-27 06:54:14', '2026-10-27 06:54:14'),
('01a17da3-dff4-72b0-bbe1-0e97a6541d86', '01a17da3-dfe8-72b3-b7ef-ba4aee560f65', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'CREDIT', 1900000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 06:54:14', '2026-10-27 06:54:14'),
('01a17da4-e1de-7172-854a-18a2819dba57', '01a17da4-e1d7-71f9-81c6-14632be9a012', '5d137200-2a11-49be-8ae4-b2f6e89d149b', 'DEBIT', 100000.00, 'MAIN', 'Materai', '2026-10-27 06:55:20', '2026-10-27 06:55:20'),
('01a17da4-e1e0-7319-a28d-9517ce217bf9', '01a17da4-e1d7-71f9-81c6-14632be9a012', '084d9998-26f9-4e60-9673-eb1464e6e379', 'DEBIT', 550000.00, 'MAIN', 'Transport & Uang Makan Monev Pemprov ke Asrama ATC', '2026-10-27 06:55:20', '2026-10-27 06:55:20'),
('01a17da4-e1e1-7105-bd0c-46fdbc48d49c', '01a17da4-e1d7-71f9-81c6-14632be9a012', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'CREDIT', 650000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 06:55:20', '2026-10-27 06:55:20'),
('01a17da5-7631-7035-b151-6acf1815669c', '01a17da5-7626-70af-bc40-48dbba531f9d', 'cd26292d-ed27-4e29-af2f-d3bd7c9ccb94', 'DEBIT', 555000.00, 'MAIN', 'Contener 82L', '2026-10-27 06:55:58', '2026-10-27 06:55:58'),
('01a17da5-7632-70d5-8b30-2dc81974b243', '01a17da5-7626-70af-bc40-48dbba531f9d', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'CREDIT', 555000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 06:55:58', '2026-10-27 06:55:58'),
('01a17da6-85dc-703f-a654-0c4a1f39720d', '01a17da6-85d4-714d-8ba0-610d21aa7838', 'ad354b98-b236-4a1c-b7b5-e32757f43623', 'DEBIT', 1375000.00, 'MAIN', 'Transfer Honor Media Ig 27 Konten SIA 1', '2026-10-27 06:57:07', '2026-10-27 06:57:07'),
('01a17da6-85dd-720b-9a95-7388e427671d', '01a17da6-85d4-714d-8ba0-610d21aa7838', '4dc29692-975f-482f-b7d0-ee44b410ce11', 'DEBIT', 152500.00, 'MAIN', 'Transfer Transport Acara DP3AK 2 Kali', '2026-10-27 06:57:07', '2026-10-27 06:57:07'),
('01a17da6-85de-7040-b2f6-a8107fe18a0f', '01a17da6-85d4-714d-8ba0-610d21aa7838', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'CREDIT', 1527500.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 06:57:07', '2026-10-27 06:57:07'),
('01a17da7-6604-7048-a26e-37ffe3eac291', '01a17da7-65fa-72f6-a7a5-4f190e4d83fc', '4dc29692-975f-482f-b7d0-ee44b410ce11', 'DEBIT', 452500.00, 'MAIN', 'Transfer Transport Acara ke Gresik', '2026-10-27 06:58:05', '2026-10-27 06:58:05'),
('01a17da7-6605-70c2-a9a1-c60792a5325b', '01a17da7-65fa-72f6-a7a5-4f190e4d83fc', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'CREDIT', 452500.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 06:58:05', '2026-10-27 06:58:05'),
('01a17da8-ffeb-70e9-b476-6eead2e4bda2', '01a17da8-ffdf-737b-b1dc-d66fece257e6', '3977d722-ebce-4252-9cca-b4a65a22876f', 'DEBIT', 750000.00, 'MAIN', 'Transfer Karangan Bunga Warek UMSIDA', '2026-10-27 06:59:49', '2026-10-27 06:59:49'),
('01a17da8-ffec-737c-925e-5ce6ccb9597c', '01a17da8-ffdf-737b-b1dc-d66fece257e6', '084d9998-26f9-4e60-9673-eb1464e6e379', 'DEBIT', 1239700.00, 'MAIN', 'Keperluan Rapat Tim 11 di ATC', '2026-10-27 06:59:49', '2026-10-27 06:59:49'),
('01a17da8-ffed-72ad-8916-e5b8ebaa9af4', '01a17da8-ffdf-737b-b1dc-d66fece257e6', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'CREDIT', 1989700.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 06:59:49', '2026-10-27 06:59:49'),
('01a17dae-dbfc-70d3-970c-498e730e9ada', '01a17dae-dbd4-7306-9f4d-8dfc4af69d7e', '7dc4f8dd-9f03-45f2-aac9-4dfe20680aa4', 'DEBIT', 2000000.00, 'MAIN', 'Transfer Honor (Hikma)', '2026-10-27 07:06:14', '2026-10-27 07:06:14'),
('01a17dae-dc00-731a-9c60-4073023a2158', '01a17dae-dbd4-7306-9f4d-8dfc4af69d7e', '34f0c888-19c7-49e6-b451-3ee517c89817', 'DEBIT', 500000.00, 'MAIN', 'Uang Makan', '2026-10-27 07:06:14', '2026-10-27 07:06:14'),
('01a17dae-dc03-7151-9444-f754ed4e04ba', '01a17dae-dbd4-7306-9f4d-8dfc4af69d7e', '606cccc9-e4fd-4abe-9b27-2391c7302bc5', 'DEBIT', 300000.00, 'MAIN', 'Insentif  Musywil', '2026-10-27 07:06:14', '2026-10-27 07:06:14'),
('01a17dae-dc05-70ac-ad14-7889e36f3b19', '01a17dae-dbd4-7306-9f4d-8dfc4af69d7e', '7dc4f8dd-9f03-45f2-aac9-4dfe20680aa4', 'DEBIT', 2000000.00, 'MAIN', 'Transfer Honor l (Yuli)', '2026-10-27 07:06:14', '2026-10-27 07:06:14'),
('01a17dae-dc07-7347-9bea-3464896cdb68', '01a17dae-dbd4-7306-9f4d-8dfc4af69d7e', '34f0c888-19c7-49e6-b451-3ee517c89817', 'DEBIT', 500000.00, 'MAIN', 'Uang Makan', '2026-10-27 07:06:14', '2026-10-27 07:06:14'),
('01a17dae-dc09-72f4-bb69-1699d0e72a94', '01a17dae-dbd4-7306-9f4d-8dfc4af69d7e', '606cccc9-e4fd-4abe-9b27-2391c7302bc5', 'DEBIT', 300000.00, 'MAIN', 'Insentif  Musywil', '2026-10-27 07:06:14', '2026-10-27 07:06:14'),
('01a17dae-dc0b-70a9-a7f5-cfdf342e7377', '01a17dae-dbd4-7306-9f4d-8dfc4af69d7e', '4b1493eb-71c4-4fdc-9b94-862c313cfef5', 'DEBIT', 100000.00, 'MAIN', 'Pulsa Operasional', '2026-10-27 07:06:14', '2026-10-27 07:06:14'),
('01a17dae-dc0c-73bd-ab9e-94dcf12d7c15', '01a17dae-dbd4-7306-9f4d-8dfc4af69d7e', '4dc29692-975f-482f-b7d0-ee44b410ce11', 'DEBIT', 100000.00, 'MAIN', 'Transport Operasional Ke BSB dan B Heni', '2026-10-27 07:06:14', '2026-10-27 07:06:14'),
('01a17dae-dc0e-70d1-ac88-25474381034e', '01a17dae-dbd4-7306-9f4d-8dfc4af69d7e', '4dc29692-975f-482f-b7d0-ee44b410ce11', 'DEBIT', 1252500.00, 'MAIN', 'Transfer Tansport Ke Nganjuk (Menghadiri)', '2026-10-27 07:06:14', '2026-10-27 07:06:14'),
('01a17dae-dc10-705c-9f97-ea607d2c4e1e', '01a17dae-dbd4-7306-9f4d-8dfc4af69d7e', '4dc29692-975f-482f-b7d0-ee44b410ce11', 'DEBIT', 500000.00, 'MAIN', 'Transport dari Malang (Tamu Kodam)', '2026-10-27 07:06:14', '2026-10-27 07:06:14'),
('01a17dae-dc15-720e-9c47-6c65f994ab04', '01a17dae-dbd4-7306-9f4d-8dfc4af69d7e', '4dc29692-975f-482f-b7d0-ee44b410ce11', 'DEBIT', 100000.00, 'MAIN', 'Bensin Mobil PWA (Tamu Kodam)', '2026-10-27 07:06:14', '2026-10-27 07:06:14'),
('01a17dae-dc16-73f1-a2d9-035077af6421', '01a17dae-dbd4-7306-9f4d-8dfc4af69d7e', '4dc29692-975f-482f-b7d0-ee44b410ce11', 'DEBIT', 150000.00, 'MAIN', 'Sopir Mobil PWA (Tamu Kodam)', '2026-10-27 07:06:14', '2026-10-27 07:06:14'),
('01a17dae-dc17-7284-88d1-bf7fe3d4857f', '01a17dae-dbd4-7306-9f4d-8dfc4af69d7e', 'f6cb5434-a42a-41cc-8cd2-f7ebd46f485f', 'DEBIT', 502500.00, 'MAIN', 'Transfer Takziyah Ke PAk Ali Laziz MU', '2026-10-27 07:06:14', '2026-10-27 07:06:14'),
('01a17dae-dc18-71a5-926c-243e90e95c42', '01a17dae-dbd4-7306-9f4d-8dfc4af69d7e', 'ad67895d-ef05-4fd3-965c-d793289a3c60', 'CREDIT', 8305000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 07:06:14', '2026-10-27 07:06:14'),
('01a17dbd-dc23-7293-96fb-685dbd2152a8', '01a17dbd-dc1e-71c1-bcef-76dd0da2806d', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 1000000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:22:37', '2026-10-27 07:22:37'),
('01a17dbd-dc25-7364-9d16-6511663d1d4c', '01a17dbd-dc1e-71c1-bcef-76dd0da2806d', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 1000000.00, 'MAIN', 'Sumbangan Musywil Bagus Irawa', '2026-10-27 07:22:37', '2026-10-27 07:22:37'),
('01a17dbe-5ed1-70be-80c1-e96a94e2da22', '01a17dbe-5ecc-725a-b911-e8512fc61018', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 25000000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:23:10', '2026-10-27 07:23:10'),
('01a17dbe-5ed3-72cb-88cb-06421f3941c0', '01a17dbe-5ecc-725a-b911-e8512fc61018', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 25000000.00, 'MAIN', 'Sumbangan Musywil UMSurabaya', '2026-10-27 07:23:10', '2026-10-27 07:23:10'),
('01a17dbe-ffbc-70e6-a1e1-7c27ff419497', '01a17dbe-ffb2-73f2-8788-6c82fade3fed', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 300000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:23:51', '2026-10-27 07:23:51'),
('01a17dbe-ffc0-7350-af37-558da05a89f1', '01a17dbe-ffb2-73f2-8788-6c82fade3fed', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 300000.00, 'MAIN', 'Pemasukan', '2026-10-27 07:23:51', '2026-10-27 07:23:51'),
('01a17dbf-81f0-70ae-9957-657b1a1968b0', '01a17dbf-81e9-7090-be05-dddf377a58a1', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 3000000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:24:25', '2026-10-27 07:24:25'),
('01a17dbf-81f2-70d9-b5e6-383d93c12c85', '01a17dbf-81e9-7090-be05-dddf377a58a1', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 3000000.00, 'MAIN', 'Sumbangan Musywil SMP M 2 Taman', '2026-10-27 07:24:25', '2026-10-27 07:24:25'),
('01a17dc0-5d69-726e-9db0-f3b546bd5dad', '01a17dc0-5d62-7114-9c41-20d0e7e219c7', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 7500000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:25:21', '2026-10-27 07:25:21'),
('01a17dc0-5d6b-7087-b388-5fd319db3e8e', '01a17dc0-5d62-7114-9c41-20d0e7e219c7', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 7500000.00, 'MAIN', 'Sumbangan RSA Dahlan Kediri', '2026-10-27 07:25:21', '2026-10-27 07:25:21'),
('01a17dc0-f1cc-7125-b423-df7beb1d56cd', '01a17dc0-f1c3-71dd-bbbe-117fdb7fb5c3', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 5000000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:25:59', '2026-10-27 07:25:59'),
('01a17dc0-f1cf-70c0-b5b4-3e119dcbefe8', '01a17dc0-f1c3-71dd-bbbe-117fdb7fb5c3', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 5000000.00, 'MAIN', 'Sumbangan SMA M 2 Surabaya', '2026-10-27 07:25:59', '2026-10-27 07:25:59'),
('01a17dc1-9a08-7086-9b62-052583ff5257', '01a17dc1-9a03-72fa-8f1f-f7e55fd763b9', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 10000000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:26:42', '2026-10-27 07:26:42'),
('01a17dc1-9a09-7098-b64b-9e1f4c7802de', '01a17dc1-9a03-72fa-8f1f-f7e55fd763b9', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 10000000.00, 'MAIN', 'Sumbangan RSI Aisyiyah Malang', '2026-10-27 07:26:42', '2026-10-27 07:26:42'),
('01a17dc2-3f0d-71d4-a291-0de5b4b4c392', '01a17dc2-3f07-7154-82a9-da03ee0d4e86', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 20000000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:27:24', '2026-10-27 07:27:24'),
('01a17dc2-3f0f-724e-9447-16a2a1bdd41b', '01a17dc2-3f07-7154-82a9-da03ee0d4e86', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 20000000.00, 'MAIN', 'Sumbangan Musywil RSIA Nganjuk', '2026-10-27 07:27:24', '2026-10-27 07:27:24'),
('01a17dc3-5a3b-72bf-8420-31fd8a0d3c18', '01a17dc3-5a34-70e8-b247-635f308d2e2c', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 5000000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:28:37', '2026-10-27 07:28:37'),
('01a17dc3-5a3c-720c-b7a7-a46f31fd9980', '01a17dc3-5a34-70e8-b247-635f308d2e2c', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 5000000.00, 'MAIN', 'Sumbangan Musywil SMA M 2 Sidoarjo', '2026-10-27 07:28:37', '2026-10-27 07:28:37'),
('01a17dc4-4aad-7226-a89e-61515b4accb3', '01a17dc4-4aa7-7218-a00a-804273587661', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 1500000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:29:38', '2026-10-27 07:29:38'),
('01a17dc4-4aae-72dd-953e-b1214e7dea00', '01a17dc4-4aa7-7218-a00a-804273587661', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 1500000.00, 'MAIN', 'Sumbangan Musywil SDM 1 Sidoarjo', '2026-10-27 07:29:38', '2026-10-27 07:29:38'),
('01a17dc4-d4a0-717c-ac6d-f29a373e004d', '01a17dc4-d49a-7215-862e-0df01df505d3', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 3000000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:30:13', '2026-10-27 07:30:13'),
('01a17dc4-d4a3-73cc-9a90-a6dde308cac0', '01a17dc4-d49a-7215-862e-0df01df505d3', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 3000000.00, 'MAIN', 'Sumbangan Musywil SMP M 1 Sidoarjo', '2026-10-27 07:30:13', '2026-10-27 07:30:13'),
('01a17dc5-6fa8-73ac-a75d-c228d296b9d1', '01a17dc5-6f8b-70a7-bf52-c15e2977426a', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 2250000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:30:53', '2026-10-27 07:30:53'),
('01a17dc5-6fb1-7254-92f0-c873d56b065c', '01a17dc5-6f8b-70a7-bf52-c15e2977426a', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 2250000.00, 'MAIN', 'Pembayaran Simpanan Wajib Organisasi', '2026-10-27 07:30:53', '2026-10-27 07:30:53'),
('01a17dc5-fb5a-709e-9caa-f12f2b83524f', '01a17dc5-fb54-7165-9734-16cb382277fb', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 5000000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:31:29', '2026-10-27 07:31:29'),
('01a17dc5-fb5c-712b-a098-10509f3588f9', '01a17dc5-fb54-7165-9734-16cb382277fb', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 5000000.00, 'MAIN', 'Sumbangan Musywil UMSIDA', '2026-10-27 07:31:29', '2026-10-27 07:31:29'),
('01a17dc6-94e0-7346-9f20-35b69607a9fd', '01a17dc6-94d8-71e1-affb-d0c25037e0ca', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 10000000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:32:08', '2026-10-27 07:32:08'),
('01a17dc6-94e2-7229-96ac-1d75dc16b0d7', '01a17dc6-94d8-71e1-affb-d0c25037e0ca', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 10000000.00, 'MAIN', 'Sumbangan Musywil RS Aisyiyah Bojonegoro', '2026-10-27 07:32:08', '2026-10-27 07:32:08'),
('01a17dc7-1a5d-7065-91d3-29649e4c1d13', '01a17dc7-1a58-726b-a06d-d3835c80ef2a', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 5000000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:32:42', '2026-10-27 07:32:42'),
('01a17dc7-1a5e-7020-a173-adf894b71619', '01a17dc7-1a58-726b-a06d-d3835c80ef2a', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 5000000.00, 'MAIN', 'Sumbangan Musywil SMA M Gresik', '2026-10-27 07:32:42', '2026-10-27 07:32:42'),
('01a17dc7-97fb-7349-bc4b-1f660a94e94c', '01a17dc7-97f5-7074-b03f-db444ff1854e', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 5000000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:33:15', '2026-10-27 07:33:15'),
('01a17dc7-97fc-7057-a5a8-f397ffe6cfa6', '01a17dc7-97f5-7074-b03f-db444ff1854e', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 5000000.00, 'MAIN', 'Sumbangan Musywil UMJ', '2026-10-27 07:33:15', '2026-10-27 07:33:15'),
('01a17dc8-31f2-73ff-a761-808daf3e2ff6', '01a17dc8-31ea-71b3-a229-1e738e2cf4f5', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 2500000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:33:54', '2026-10-27 07:33:54'),
('01a17dc8-31f4-73d2-bf07-f3e23a2ef6f3', '01a17dc8-31ea-71b3-a229-1e738e2cf4f5', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 2500000.00, 'MAIN', 'Irvand Gustari', '2026-10-27 07:33:54', '2026-10-27 07:33:54'),
('01a17dc8-bd71-738d-8e8d-9b1a73ab27a8', '01a17dc8-bd69-7155-a990-b8cde1810de8', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 10000000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:34:30', '2026-10-27 07:34:30'),
('01a17dc8-bd73-708c-8707-f42e23523ed9', '01a17dc8-bd69-7155-a990-b8cde1810de8', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 10000000.00, 'MAIN', 'Mumtaz ( Aad)', '2026-10-27 07:34:30', '2026-10-27 07:34:30'),
('01a17dc9-4bb9-72e3-b77f-bf1a4b163214', '01a17dc9-4bb3-70f3-91e5-741e4406ce89', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 5000000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:35:06', '2026-10-27 07:35:06'),
('01a17dc9-4bba-7300-bb00-7d33dba780dd', '01a17dc9-4bb3-70f3-91e5-741e4406ce89', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 5000000.00, 'MAIN', 'UM Lamongan', '2026-10-27 07:35:06', '2026-10-27 07:35:06'),
('01a17dc9-ce29-731c-91de-af46e74c8db3', '01a17dc9-ce20-72cc-8c43-c3b9fb9695da', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 1000000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:35:39', '2026-10-27 07:35:39'),
('01a17dc9-ce2b-7323-b2ea-32f3ab55d952', '01a17dc9-ce20-72cc-8c43-c3b9fb9695da', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 1000000.00, 'MAIN', 'M Idaham.', '2026-10-27 07:35:39', '2026-10-27 07:35:39'),
('01a17dca-58fe-71f2-a2c9-ba645e3e5713', '01a17dca-58f8-710a-bc1c-c45ba6bf15af', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 3000000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:36:15', '2026-10-27 07:36:15'),
('01a17dca-5900-7230-9d3c-3197fd4b3f5c', '01a17dca-58f8-710a-bc1c-c45ba6bf15af', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 3000000.00, 'MAIN', 'SMPM 12 GKB', '2026-10-27 07:36:15', '2026-10-27 07:36:15'),
('01a17dca-bf31-70ca-80b1-eef723b00410', '01a17dca-bf2c-715c-b820-1b2fb7b3c8ac', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 20000000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:36:41', '2026-10-27 07:36:41'),
('01a17dca-bf32-7218-8893-112972354083', '01a17dca-bf2c-715c-b820-1b2fb7b3c8ac', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 20000000.00, 'MAIN', 'RSU Aisyiyah Ponorogo', '2026-10-27 07:36:41', '2026-10-27 07:36:41'),
('01a17dcb-3052-715e-989f-37cec5637c9c', '01a17dcb-3048-7116-8e1c-98f0d1467bac', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 250000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:37:10', '2026-10-27 07:37:10'),
('01a17dcb-3054-702d-8698-b331dd4dce96', '01a17dcb-3048-7116-8e1c-98f0d1467bac', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 250000.00, 'MAIN', 'Ati Fatur.', '2026-10-27 07:37:10', '2026-10-27 07:37:10'),
('01a17dcb-bcfa-7215-b0d7-7b01fdc63846', '01a17dcb-bcf4-705a-ab28-0f40c73dead5', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 700000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:37:46', '2026-10-27 07:37:46'),
('01a17dcb-bcfb-73f1-9385-c1669a490037', '01a17dcb-bcf4-705a-ab28-0f40c73dead5', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 700000.00, 'MAIN', 'Asrofi', '2026-10-27 07:37:46', '2026-10-27 07:37:46'),
('01a17dcc-3af6-7199-81e9-baabc17342cd', '01a17dcc-3af0-73ee-b70a-1be7e64000d7', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 10000000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:38:18', '2026-10-27 07:38:18'),
('01a17dcc-3afe-71ba-a356-78c0a7a2fc3a', '01a17dcc-3af0-73ee-b70a-1be7e64000d7', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 10000000.00, 'MAIN', 'Prof Zaenudin M', '2026-10-27 07:38:18', '2026-10-27 07:38:18'),
('01a17dcc-a0f9-71f0-8a7a-b061e94e63a8', '01a17dcc-a0f2-7221-a5bb-70f6de82170f', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 5000000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:38:44', '2026-10-27 07:38:44'),
('01a17dcc-a104-71b8-8b43-d6e5ce4881f2', '01a17dcc-a0f2-7221-a5bb-70f6de82170f', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 5000000.00, 'MAIN', 'SMKM 7 Gondang', '2026-10-27 07:38:44', '2026-10-27 07:38:44'),
('01a17dcd-2815-720a-8bcc-db70bed892d7', '01a17dcd-280d-725c-8732-b5534a86b120', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 3000000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:39:19', '2026-10-27 07:39:19'),
('01a17dcd-2817-72a5-8e26-968a6bb6a07e', '01a17dcd-280d-725c-8732-b5534a86b120', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 3000000.00, 'MAIN', 'Pemasukan', '2026-10-27 07:39:19', '2026-10-27 07:39:19'),
('01a17dcd-c4d2-7183-9589-35d720597fab', '01a17dcd-c4c4-73d8-b11d-b2967a6cfa71', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 10000000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:39:59', '2026-10-27 07:39:59'),
('01a17dcd-c4d5-7199-af31-ff2936b71451', '01a17dcd-c4c4-73d8-b11d-b2967a6cfa71', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 10000000.00, 'MAIN', 'RSM Gresik', '2026-10-27 07:39:59', '2026-10-27 07:39:59');
INSERT INTO `transaction_lines` (`id`, `transaction_id`, `chart_of_account_id`, `position`, `amount`, `meta_type`, `description`, `created_at`, `updated_at`) VALUES
('01a17dce-47b8-7345-bea1-4522de4b2746', '01a17dce-47ac-7227-89f1-e0f7ccbceb5a', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 2500000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:40:33', '2026-10-27 07:40:33'),
('01a17dce-47bb-72a1-b484-5b5c55958620', '01a17dce-47ac-7227-89f1-e0f7ccbceb5a', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 2500000.00, 'MAIN', 'SD M 2 GKB', '2026-10-27 07:40:33', '2026-10-27 07:40:33'),
('01a17dcf-1461-7269-9c03-0d3f4fc651b7', '01a17dcf-145b-7129-8327-b3dc55ecf4c3', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 250000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:41:25', '2026-10-27 07:41:25'),
('01a17dcf-1462-7334-8042-94faac96771e', '01a17dcf-145b-7129-8327-b3dc55ecf4c3', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 250000.00, 'MAIN', 'Nur Hayati', '2026-10-27 07:41:25', '2026-10-27 07:41:25'),
('01a17dcf-75b7-7296-a598-a0451d6ad795', '01a17dcf-75af-739e-8230-07ea38d8fa2e', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 1000000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:41:50', '2026-10-27 07:41:50'),
('01a17dcf-75ba-7168-9733-7c2b645eac96', '01a17dcf-75af-739e-8230-07ea38d8fa2e', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 1000000.00, 'MAIN', 'dr. Qonita', '2026-10-27 07:41:50', '2026-10-27 07:41:50'),
('01a17dcf-d530-72fe-8e70-6c7ee71175ee', '01a17dcf-d525-70ee-a9eb-b46e3f326095', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 2500000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:42:14', '2026-10-27 07:42:14'),
('01a17dcf-d533-724c-ab6b-eb224d11ed6d', '01a17dcf-d525-70ee-a9eb-b46e3f326095', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 2500000.00, 'MAIN', 'SMAM 10 Gresik', '2026-10-27 07:42:14', '2026-10-27 07:42:14'),
('01a17dd0-7517-73d6-b0c4-0905ffac6a42', '01a17dd0-7510-72f0-96a5-dae16265494e', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 20000000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:42:55', '2026-10-27 07:42:55'),
('01a17dd0-7518-7033-af1a-a667fec32701', '01a17dd0-7510-72f0-96a5-dae16265494e', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 20000000.00, 'MAIN', 'PAN Jatim', '2026-10-27 07:42:55', '2026-10-27 07:42:55'),
('01a17dd2-c217-73b4-aad5-b459b931bd60', '01a17dd2-c20c-713a-b5a9-4ed906bf8d8a', 'e7d35619-9874-4274-8a71-cd739d923554', 'DEBIT', 83021.00, 'MAIN', 'Pembayaran pajak tabungan', '2026-10-27 07:45:26', '2026-10-27 07:45:26'),
('01a17dd2-c218-7201-ba87-de3dc0e1b05b', '01a17dd2-c20c-713a-b5a9-4ed906bf8d8a', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'CREDIT', 83021.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 07:45:26', '2026-10-27 07:45:26'),
('01a17dd4-3158-72dd-a0e4-80aec7994e50', '01a17dd4-3151-7339-992d-68936cd17902', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 415107.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:47:00', '2026-10-27 07:47:00'),
('01a17dd4-315a-7336-a420-e23ad50bca60', '01a17dd4-3151-7339-992d-68936cd17902', '83b231e2-5339-4184-9cb3-6c3737bbee93', 'CREDIT', 415107.00, 'MAIN', 'Penerimaan bunga tabungan', '2026-10-27 07:47:00', '2026-10-27 07:47:00'),
('01a17dd4-ed96-71ad-82f2-6b678418744c', '01a17dd4-ed91-70e2-a44c-7b2cdae43faa', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 10000000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:47:48', '2026-10-27 07:47:48'),
('01a17dd4-ed97-723b-bf12-4e3b8acaf852', '01a17dd4-ed91-70e2-a44c-7b2cdae43faa', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 10000000.00, 'MAIN', 'RS Siti Khodijah', '2026-10-27 07:47:48', '2026-10-27 07:47:48'),
('01a17dd5-7089-7243-bbfc-5b707e6b29b5', '01a17dd5-7082-71ed-b5b1-19c850e6b220', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 5000000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:48:22', '2026-10-27 07:48:22'),
('01a17dd5-708a-7141-ba97-6655ec8db0c7', '01a17dd5-7082-71ed-b5b1-19c850e6b220', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 5000000.00, 'MAIN', 'Parahita', '2026-10-27 07:48:22', '2026-10-27 07:48:22'),
('01a17dd6-30e7-71db-983f-e6cdf5d7b6e1', '01a17dd6-30df-709d-a329-6a66c76838c3', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 5000000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:49:11', '2026-10-27 07:49:11'),
('01a17dd6-30e9-73a6-af9e-cc3d6e35c4ea', '01a17dd6-30df-709d-a329-6a66c76838c3', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 5000000.00, 'MAIN', 'Universitas Muhammadiyah Gresik', '2026-10-27 07:49:11', '2026-10-27 07:49:11'),
('01a17dd6-c6d4-7112-824f-adb64a3a35e5', '01a17dd6-c6cc-7217-bb31-29b026691fd9', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 500000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:49:50', '2026-10-27 07:49:50'),
('01a17dd6-c6d5-721e-83b5-538eb3dd2395', '01a17dd6-c6cc-7217-bb31-29b026691fd9', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 500000.00, 'MAIN', 'Muhajir', '2026-10-27 07:49:50', '2026-10-27 07:49:50'),
('01a17dd7-6305-731e-8f51-bd0755b9eb69', '01a17dd7-62fe-71bd-96e6-129d5ac18c7d', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 10000000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:50:30', '2026-10-27 07:50:30'),
('01a17dd7-6308-72c1-9f73-f2de88fdfb6f', '01a17dd7-62fe-71bd-96e6-129d5ac18c7d', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 10000000.00, 'MAIN', 'Widati Muhajir', '2026-10-27 07:50:30', '2026-10-27 07:50:30'),
('01a17dd7-f6eb-7078-8078-52fd2e1d4cd9', '01a17dd7-f6e5-710c-b430-b72c74f3ad5b', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 250000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:51:07', '2026-10-27 07:51:07'),
('01a17dd7-f6ed-7115-b40b-8803528cb643', '01a17dd7-f6e5-710c-b430-b72c74f3ad5b', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 250000.00, 'MAIN', 'Pemasukan', '2026-10-27 07:51:07', '2026-10-27 07:51:07'),
('01a17dd8-775b-701b-a641-d2c8edc76500', '01a17dd8-7755-72d6-b00c-1851c22495bc', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'DEBIT', 3000000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:51:40', '2026-10-27 07:51:40'),
('01a17dd8-775d-7277-8156-51223fd653e9', '01a17dd8-7755-72d6-b00c-1851c22495bc', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', 'CREDIT', 3000000.00, 'MAIN', 'Pemasukan', '2026-10-27 07:51:40', '2026-10-27 07:51:40'),
('01a17dd9-34b1-7090-9737-30a1ca132fe8', '01a17dd9-34a2-71ae-90a6-d3db7938991b', 'e7d35619-9874-4274-8a71-cd739d923554', 'DEBIT', 8000.00, 'MAIN', 'Pembayaran adminitrasi tabungan', '2026-10-27 07:52:29', '2026-10-27 07:52:29'),
('01a17dd9-34b4-7043-aa2d-3143bbc343a5', '01a17dd9-34a2-71ae-90a6-d3db7938991b', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', 'CREDIT', 8000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 07:52:29', '2026-10-27 07:52:29'),
('01a17ddc-37fc-70a4-9c39-a941c80711ce', '01a17ddc-37f7-7110-8cff-be4dd3f89ac6', 'b8e89210-2ad3-44b5-b835-c66c8f8d2f0c', 'DEBIT', 733644.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 07:55:46', '2026-10-27 07:55:46'),
('01a17ddc-37fe-7317-b2c1-27164188d06d', '01a17ddc-37f7-7110-8cff-be4dd3f89ac6', '83b231e2-5339-4184-9cb3-6c3737bbee93', 'CREDIT', 733644.00, 'MAIN', 'Penerimaan bunga dari bank', '2026-10-27 07:55:46', '2026-10-27 07:55:46'),
('01a17ddc-f7ee-7186-8c12-13c34d2f3078', '01a17ddc-f7d9-70f1-8e0c-2ebbd5029691', 'e7d35619-9874-4274-8a71-cd739d923554', 'DEBIT', 146728.00, 'MAIN', 'Pembayaran pajak tabungan', '2026-10-27 07:56:35', '2026-10-27 07:56:35'),
('01a17ddc-f7f0-73c9-a7c8-353901c49f38', '01a17ddc-f7d9-70f1-8e0c-2ebbd5029691', 'b8e89210-2ad3-44b5-b835-c66c8f8d2f0c', 'CREDIT', 146728.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 07:56:35', '2026-10-27 07:56:35'),
('01a17ddd-94d9-7238-a240-9b479f480cc4', '01a17ddd-94d1-700a-a623-859e3fe29ea3', 'e7d35619-9874-4274-8a71-cd739d923554', 'DEBIT', 30000.00, 'MAIN', 'Biaya Admin Giro', '2026-10-27 07:57:15', '2026-10-27 07:57:15'),
('01a17ddd-94da-702e-a63e-47fab403c7ee', '01a17ddd-94d1-700a-a623-859e3fe29ea3', 'b8e89210-2ad3-44b5-b835-c66c8f8d2f0c', 'CREDIT', 30000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 07:57:15', '2026-10-27 07:57:15'),
('01a17de9-de68-71d3-8338-959ea8d41740', '01a17de9-de63-7123-9545-fdb8f5f145e0', 'dc604ee1-502c-456b-8b3d-006762ecedf2', 'DEBIT', 2400000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 08:10:41', '2026-10-27 08:10:41'),
('01a17de9-de69-73ca-bef3-fa7801e0e0b3', '01a17de9-de63-7123-9545-fdb8f5f145e0', 'e571cb0d-59ea-4434-acaf-c49027e6102e', 'CREDIT', 2400000.00, 'MAIN', 'TRF DR INDAH UMU CHILMI BRI', '2026-10-27 08:10:41', '2026-10-27 08:10:41'),
('01a17dea-7a78-71aa-8588-227d0e4edefe', '01a17dea-7a71-731f-a74f-f05d47528657', 'dc604ee1-502c-456b-8b3d-006762ecedf2', 'DEBIT', 529300.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 08:11:21', '2026-10-27 08:11:21'),
('01a17dea-7a7a-72ec-b31a-0f8a23944e7f', '01a17dea-7a71-731f-a74f-f05d47528657', '83b231e2-5339-4184-9cb3-6c3737bbee93', 'CREDIT', 529300.00, 'MAIN', 'Bagi Hasil', '2026-10-27 08:11:21', '2026-10-27 08:11:21'),
('01a17deb-7486-7311-9c11-2cbe4a598c2d', '01a17deb-7481-7070-8c36-35e08ea37bc5', 'dc604ee1-502c-456b-8b3d-006762ecedf2', 'DEBIT', 5509500.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 08:12:25', '2026-10-27 08:12:25'),
('01a17deb-7487-7392-bfb7-90fcebd5e83a', '01a17deb-7481-7070-8c36-35e08ea37bc5', '711d6463-1665-4710-b2fb-30af0dc1e664', 'CREDIT', 5509500.00, 'MAIN', 'SPP Mahasiswa KIP UMSIDA dari Kota Mojoerto', '2026-10-27 08:12:25', '2026-10-27 08:12:25'),
('01a17dec-59b8-73bb-9e12-02ff71dd12c0', '01a17dec-59b1-73a8-b2b8-f1572bcaa35c', 'dc604ee1-502c-456b-8b3d-006762ecedf2', 'DEBIT', 13994700.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 08:13:23', '2026-10-27 08:13:23'),
('01a17dec-59ba-72c2-b328-1610f385c66d', '01a17dec-59b1-73a8-b2b8-f1572bcaa35c', '58882c34-1ca0-4af9-8831-ab160748b48d', 'CREDIT', 13994700.00, 'MAIN', 'TRF DR BPK MUKHTAMIL PRA BANK BNI', '2026-10-27 08:13:23', '2026-10-27 08:13:23'),
('01a17ded-10f1-73f7-bdbe-f42bd62f9d8e', '01a17ded-10ed-7035-81b7-d530edb65749', 'dc604ee1-502c-456b-8b3d-006762ecedf2', 'DEBIT', 2593500.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 08:14:10', '2026-10-27 08:14:10'),
('01a17ded-10f3-7242-a82a-944d61d5519f', '01a17ded-10ed-7035-81b7-d530edb65749', 'e571cb0d-59ea-4434-acaf-c49027e6102e', 'CREDIT', 2593500.00, 'MAIN', 'TRF DR Bank Bukopin Syari Dummy', '2026-10-27 08:14:10', '2026-10-27 08:14:10'),
('01a17ded-e17d-7324-8ba3-94af9b9ab8e7', '01a17ded-e175-725b-a452-3a9bb6bfc430', 'dc604ee1-502c-456b-8b3d-006762ecedf2', 'DEBIT', 3216000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 08:15:04', '2026-10-27 08:15:04'),
('01a17ded-e17f-709a-983c-18fad4c736c8', '01a17ded-e175-725b-a452-3a9bb6bfc430', 'e571cb0d-59ea-4434-acaf-c49027e6102e', 'CREDIT', 3216000.00, 'MAIN', 'Pemasukan', '2026-10-27 08:15:04', '2026-10-27 08:15:04'),
('01a17dee-eeef-725a-8c5e-3456b7a8c5d7', '01a17dee-eeea-7151-a39b-606f051116f9', 'dc604ee1-502c-456b-8b3d-006762ecedf2', 'DEBIT', 344359.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-27 08:16:13', '2026-10-27 08:16:13'),
('01a17dee-eef0-7387-9a0c-1893d80fec08', '01a17dee-eeea-7151-a39b-606f051116f9', '83b231e2-5339-4184-9cb3-6c3737bbee93', 'CREDIT', 344359.00, 'MAIN', 'Bagi Hasil', '2026-10-27 08:16:13', '2026-10-27 08:16:13'),
('01a17def-a8fc-718c-a303-d014c7dfc4ab', '01a17def-a8f7-713d-bceb-4e90e1ae0ba2', 'e7d35619-9874-4274-8a71-cd739d923554', 'DEBIT', 105860.00, 'MAIN', 'Pajak', '2026-10-27 08:17:00', '2026-10-27 08:17:00'),
('01a17def-a8fd-7368-99fd-746a49dd25e5', '01a17def-a8f7-713d-bceb-4e90e1ae0ba2', 'dc604ee1-502c-456b-8b3d-006762ecedf2', 'CREDIT', 105860.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 08:17:00', '2026-10-27 08:17:00'),
('01a17df0-cad8-73c7-bce6-51709a805715', '01a17df0-cad2-7334-8a37-b7dd6f8dcbb7', '084d9998-26f9-4e60-9673-eb1464e6e379', 'DEBIT', 9500000.00, 'MAIN', 'Pengembalian Talangan Uang Inklusi untuk Living Cost 2 Mahasiswa Beasiswa Persayarikatan di UMSIDA', '2026-10-27 08:18:15', '2026-10-27 08:18:15'),
('01a17df0-cad9-7096-948a-e88a8413e1fe', '01a17df0-cad2-7334-8a37-b7dd6f8dcbb7', 'e7d35619-9874-4274-8a71-cd739d923554', 'DEBIT', 2900.00, 'MAIN', 'SKN', '2026-10-27 08:18:15', '2026-10-27 08:18:15'),
('01a17df0-cada-7335-8c87-ef5f3afab581', '01a17df0-cad2-7334-8a37-b7dd6f8dcbb7', 'dc604ee1-502c-456b-8b3d-006762ecedf2', 'CREDIT', 9502900.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 08:18:15', '2026-10-27 08:18:15'),
('01a17df1-ddda-7300-af6d-b3dfda05e9bd', '01a17df1-ddd3-7144-ac42-a0aba0fceb35', 'e7d35619-9874-4274-8a71-cd739d923554', 'DEBIT', 10000.00, 'MAIN', 'Biaya Administrasi', '2026-10-27 08:19:25', '2026-10-27 08:19:25'),
('01a17df1-dddb-70fe-a1fa-347a29a30291', '01a17df1-ddd3-7144-ac42-a0aba0fceb35', 'dc604ee1-502c-456b-8b3d-006762ecedf2', 'CREDIT', 10000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 08:19:25', '2026-10-27 08:19:25'),
('01a17df2-ad26-7148-b6f3-14aeac4609eb', '01a17df2-ad1d-7107-a1b9-a5348c938ee5', '652677ff-bda5-43aa-aebc-72b2316b1b2a', 'DEBIT', 300000000.00, 'MAIN', 'RTGS Ke BRI (Panitia Musywil)', '2026-10-27 08:20:18', '2026-10-27 08:20:18'),
('01a17df2-ad27-7322-a988-599d35ab14b8', '01a17df2-ad1d-7107-a1b9-a5348c938ee5', 'e7d35619-9874-4274-8a71-cd739d923554', 'DEBIT', 30000.00, 'MAIN', 'Biaya RTGS', '2026-10-27 08:20:18', '2026-10-27 08:20:18'),
('01a17df2-ad29-704b-843a-f80d73dd3713', '01a17df2-ad1d-7107-a1b9-a5348c938ee5', 'dc604ee1-502c-456b-8b3d-006762ecedf2', 'CREDIT', 300030000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 08:20:18', '2026-10-27 08:20:18'),
('01a17df3-b4ad-7396-b02a-a0c4649375dd', '01a17df3-b4a7-732d-85cc-cefef3fd03ad', '084d9998-26f9-4e60-9673-eb1464e6e379', 'DEBIT', 5509500.00, 'MAIN', 'Pengembalian SPP Mahasiswa KIP UMSIDA dari Kota Mojoerto', '2026-10-27 08:21:25', '2026-10-27 08:21:25'),
('01a17df3-b4af-71e0-a123-b3df890413de', '01a17df3-b4a7-732d-85cc-cefef3fd03ad', 'e7d35619-9874-4274-8a71-cd739d923554', 'DEBIT', 2900.00, 'MAIN', 'SKN', '2026-10-27 08:21:25', '2026-10-27 08:21:25'),
('01a17df3-b4b0-71f4-8f94-9cf4bc24d09a', '01a17df3-b4a7-732d-85cc-cefef3fd03ad', 'dc604ee1-502c-456b-8b3d-006762ecedf2', 'CREDIT', 5512400.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 08:21:25', '2026-10-27 08:21:25'),
('01a17df4-46eb-707a-9a05-250552e12be7', '01a17df4-469f-73eb-b42a-8d1d6e85d74d', 'e7d35619-9874-4274-8a71-cd739d923554', 'DEBIT', 68871.00, 'MAIN', 'Pajak', '2026-10-27 08:22:03', '2026-10-27 08:22:03'),
('01a17df4-46ec-71a2-9412-ab34241c38ac', '01a17df4-469f-73eb-b42a-8d1d6e85d74d', 'dc604ee1-502c-456b-8b3d-006762ecedf2', 'CREDIT', 68871.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-27 08:22:03', '2026-10-27 08:22:03');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `no_telp` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `is_superadmin` tinyint(1) NOT NULL DEFAULT 0,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `name`, `no_telp`, `address`, `email`, `email_verified_at`, `password`, `is_superadmin`, `remember_token`, `created_at`, `updated_at`) VALUES
('01a1792e-4da2-7241-a431-fab908ebcc7c', 'Super Admin', NULL, NULL, 'superadmin@example.com', NULL, '$2y$12$FbLrnGjHxykLJxsiMA33XelJyfGW/IfWyNY3pk0eW7hrFvnKJ67wq', 1, NULL, '2026-10-26 10:07:20', '2026-10-26 10:07:20'),
('01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'Bendahara', NULL, NULL, 'bendahara@example.com', NULL, '$2y$12$R1aP7VshJqR2TEN7ydizfu6CZe62X5VZFR1BNddKXug9pkDSu9DHG', 0, NULL, '2026-10-26 10:07:20', '2026-10-26 10:07:20'),
('01a1792e-5292-7359-a09b-260b0c33e831', 'Pemegang Kas Operasional', NULL, NULL, 'pemegang-kas@example.com', NULL, '$2y$12$TWF.aJijk4DbpRgZuJHy1.9n4OWnvFtnZI.xBMfd4YBUzERGv.Ep6', 0, NULL, '2026-10-26 10:07:21', '2026-10-26 10:07:21');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_accounts`
--

CREATE TABLE `user_accounts` (
  `id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `coa_id` char(36) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `user_accounts`
--

INSERT INTO `user_accounts` (`id`, `user_id`, `coa_id`, `created_at`, `updated_at`) VALUES
('01a1792e-62d3-7093-b821-e0a4ecdac414', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '010f231d-89cd-433b-968e-9831ab0acae0', '2026-10-26 10:07:25', '2026-10-26 10:07:25'),
('01a1792e-62e8-729b-b74d-ccaa8e6a3949', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '0275447c-ef3a-42c0-a5a4-99e80174202d', '2026-10-26 10:07:25', '2026-10-26 10:07:25'),
('01a1792e-62fd-70e4-aad8-9a19b3b879f2', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '07ea22a4-26b8-41f7-b72b-c83a72167d5b', '2026-10-26 10:07:25', '2026-10-26 10:07:25'),
('01a1792e-6313-7068-b804-8e0a3dd4c9e5', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '084d9998-26f9-4e60-9673-eb1464e6e379', '2026-10-26 10:07:25', '2026-10-26 10:07:25'),
('01a1792e-632b-73f8-97bb-53796fed4637', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '0f81ff76-3716-49c5-b62f-c2fe71ec69b3', '2026-10-26 10:07:25', '2026-10-26 10:07:25'),
('01a1792e-6340-71af-8db7-775adfa1ad07', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '11e7e933-ef9b-4dde-a920-315f93980fbe', '2026-10-26 10:07:25', '2026-10-26 10:07:25'),
('01a1792e-6354-71d8-9656-1cff1c747579', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '15d08eb5-60ee-4fca-a440-546aef11ff68', '2026-10-26 10:07:25', '2026-10-26 10:07:25'),
('01a1792e-6369-739e-bc69-1b04fcbc9bbd', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '1638884c-8d9c-4db7-963a-f5169cb09400', '2026-10-26 10:07:25', '2026-10-26 10:07:25'),
('01a1792e-637e-70f4-bcb7-6ddd21799d44', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '1980f7f4-9342-454b-b2ad-7546f8a9cef1', '2026-10-26 10:07:25', '2026-10-26 10:07:25'),
('01a1792e-6393-7241-8a26-3e79e2f63fab', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '1d075a3d-b8f1-4cbe-af32-d720d0b63d99', '2026-10-26 10:07:25', '2026-10-26 10:07:25'),
('01a1792e-63a8-70c4-946f-b50e78944ace', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '20e39474-a65a-4ca5-b57d-890040ebf0de', '2026-10-26 10:07:25', '2026-10-26 10:07:25'),
('01a1792e-63bd-722b-b608-169218ff6660', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2124ed4f-89b8-4141-867a-b8f727dea154', '2026-10-26 10:07:25', '2026-10-26 10:07:25'),
('01a1792e-63d2-71ac-ba95-d331e127fdde', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '25c9837f-2d00-4d5a-ac4f-3cca3986cd2c', '2026-10-26 10:07:25', '2026-10-26 10:07:25'),
('01a1792e-63e8-73ff-bc42-64a88317a13e', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '26f197be-d846-4c9b-ad42-3f1f7fd05e2b', '2026-10-26 10:07:25', '2026-10-26 10:07:25'),
('01a1792e-63fd-73a6-8513-a7a76f6c620c', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '282726c6-14ac-430f-a23f-d48de1ab7e5d', '2026-10-26 10:07:25', '2026-10-26 10:07:25'),
('01a1792e-6411-72fb-8788-7538ea032eaf', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '2d10b459-e593-4abe-9dd4-d1ae34a1db88', '2026-10-26 10:07:25', '2026-10-26 10:07:25'),
('01a1792e-6426-7267-bb79-fe022aa95fb0', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '31fa7f1a-65f0-4946-b807-b688716c9ece', '2026-10-26 10:07:25', '2026-10-26 10:07:25'),
('01a1792e-643c-73fb-b454-c4e4222b8834', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '321ea434-93c5-4d64-8ccf-b2b086e35f4d', '2026-10-26 10:07:25', '2026-10-26 10:07:25'),
('01a1792e-6455-703d-8e9d-90321e3be3bd', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '33401409-a814-4d69-af88-e6aab94e65a4', '2026-10-26 10:07:25', '2026-10-26 10:07:25'),
('01a1792e-646a-703f-bf09-8462d2a70756', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '345a9584-2788-47b3-978b-4dc9e20019ef', '2026-10-26 10:07:25', '2026-10-26 10:07:25'),
('01a1792e-6480-7327-85ab-8b51a2665736', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '34f0c888-19c7-49e6-b451-3ee517c89817', '2026-10-26 10:07:25', '2026-10-26 10:07:25'),
('01a1792e-6496-7133-a212-b1ae1e1f8d20', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '3572cceb-b225-4dde-8f96-84c95f5b389d', '2026-10-26 10:07:25', '2026-10-26 10:07:25'),
('01a1792e-64af-72c5-8c74-b9c69e72b0a4', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '359e2a06-6206-4452-a57b-0726a6f0ff95', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-64c4-708f-9fc7-9fda8820396b', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '3977d722-ebce-4252-9cca-b4a65a22876f', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-64da-7102-ab53-bcb085371bee', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '39cf7382-a796-4540-8639-119610794864', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-64f0-70b4-ae9a-2def63b0fb59', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '3af6ca87-fdde-4bb2-ae53-4b547d814912', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-6506-735a-8f45-7cb5bd1f33c3', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '3af9a1f6-445b-437c-8c17-733ac4f6b330', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-651c-731a-8dc5-1bb3cffd588f', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-6534-70a8-9100-b46abe45f7ab', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '3ea66bfc-d9d9-4112-910d-3f79470a44d7', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-654d-7034-9455-7485f3e505e4', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '3f2aae12-675c-4361-bbd7-46bade7fbc68', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-6563-70f4-91a3-b5241f7f3653', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '3f3ad8a4-e3a8-4264-bc0e-33a4b49d0344', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-6578-719a-a146-324b3166db55', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '42205c22-6765-4780-9f84-6abfe4183ef1', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-658e-73c1-bc4a-4c5ef782073d', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '432d5f17-a71f-4269-830a-6eda6a711b30', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-65a3-7221-b448-0c0a96c2a3a4', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '447417a0-c4a0-47d7-a26c-20ace6b277a5', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-65b8-73dc-b8f9-facd35ad0774', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '4b1493eb-71c4-4fdc-9b94-862c313cfef5', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-65cd-7194-8896-aef2a4d9eac3', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '4d2150f9-61a1-4047-9f2e-18bf649e700b', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-65e3-7013-9364-3ebe7c790ad6', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '4dc29692-975f-482f-b7d0-ee44b410ce11', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-65fa-72c5-b966-da2c8b53ff84', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '502c6443-3788-46d5-842c-6907760bab5d', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-6612-71af-be86-ba212200fb19', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '53402b88-500b-4d58-a421-dc0370942f23', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-662b-706c-8d95-d20c4c302524', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '5542cf94-e5bd-46af-b6b3-54952a6d4da0', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-6641-70da-bd61-9a8a964a1b5d', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '5667a9b0-c57d-4c9e-bb39-5f38a587e649', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-6658-7387-a5c6-67639576bb21', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '58045d05-2f17-4bdc-89cf-9e51f72eec73', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-666d-712a-a517-ee123bdf2dc5', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '58882c34-1ca0-4af9-8831-ab160748b48d', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-6682-7151-8616-ed73fdaf998f', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '5966307e-6e50-43da-aeb6-171a838e1ad1', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-6698-7048-a5d3-a4e956ee05c9', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '5d121272-39ff-430a-9747-d2778985531c', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-66ae-73bb-9eeb-64d16e6d51b7', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '5d137200-2a11-49be-8ae4-b2f6e89d149b', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-66c5-712c-a06c-73336424d56f', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '5e2faaa4-6d8a-470b-8dc7-9944523b207d', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-66dd-73be-927e-6fa319b09e13', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '606cccc9-e4fd-4abe-9b27-2391c7302bc5', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-66f3-7029-9ccb-457f9bbdbe7d', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '612982a1-3742-4197-bb24-19cd345b6ea3', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-6708-7201-8036-6e0ca7028a01', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '647d236e-d87f-4fb2-8384-95f4aac31c1d', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-671c-7345-a3f4-54533e61a3b7', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-6732-7183-b510-0936beb05fcb', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '652677ff-bda5-43aa-aebc-72b2316b1b2a', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-6748-7359-9788-c95e392d6adc', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '69db5ffb-0401-4e45-8f5d-12dd818bfa89', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-675f-712d-81a6-cc4348bdc874', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '711d6463-1665-4710-b2fb-30af0dc1e664', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-6776-70b1-9edc-dfbd3e7570a3', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '722e32e0-3b7d-4927-90f1-5a733e1fb723', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-678c-7279-9ea5-10ba5c890f18', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '7703cbfd-b06b-4acf-97cc-7cf6f0b3d94c', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-67a6-70b6-88f2-c6f6f9406095', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '77feaec0-e773-4716-aac8-cd3b08e31d47', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-67bb-7355-9d7b-853ef4df0fb7', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '7dc4f8dd-9f03-45f2-aac9-4dfe20680aa4', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-67d4-7121-9f15-9e02c8ec9412', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '803d85d9-ada0-4573-81dc-1b6384bd5d59', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-67ee-7159-99da-cbaa0d980f25', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '83b231e2-5339-4184-9cb3-6c3737bbee93', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-6804-702b-9d6f-b1201c3766b3', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '8ac00223-9ddc-44f0-9003-883c1bca639c', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-681d-7272-b478-4d71dbfc6009', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '8d2b0181-1547-409b-a288-19954f2399be', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-6834-7360-b476-6998d94849d8', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '903dc389-7285-443b-a8d3-05b74405aaed', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-684a-7029-a09e-557760c21e3c', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '92f9968f-f894-4d26-be0c-654369502780', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-6861-70bf-a2ce-21d25e2676c2', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '943a3993-3c67-42b4-9fd3-969319245e31', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-6879-7083-a72f-1b3e2684cdbe', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '95a7ed84-8c0a-4124-832b-c9c2b27017e4', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-6893-73b3-afa3-61860fa51944', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '96b49412-8021-4bec-9c3e-775fe44a76d6', '2026-10-26 10:07:26', '2026-10-26 10:07:26'),
('01a1792e-68ab-7077-97d8-69759d48af64', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '97d314b2-8775-48ce-859f-2d07ef6cd337', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-68c2-7004-82d4-36eb7366a404', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '98507351-f369-4453-b27c-000a2aa83ae7', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-68e1-70b2-b9f6-b6a9a6c5a8a8', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '992bb6b7-dc96-40a4-844f-9ee27c6ea624', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-68fc-72ff-8e08-95f37622e813', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '9d2e525c-d95f-4204-a442-f149853a1f89', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6912-71d9-883c-b3e10fe7cce1', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '9d630aba-892a-4099-9e12-2ad4fb685a96', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6928-7288-af48-849beabbdf2c', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '9e66ffab-1485-4411-87df-e2fd46e8dccc', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-693f-72a1-ae69-39fbf2fd7197', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'a07169ae-8be3-4db7-9fe0-9961831c418f', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6955-7335-9375-034239c56f79', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'a15b742a-f0f8-45a0-9f92-6f4dd317a6c9', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-696b-736f-ac28-5d7a9373f392', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'a1e86fce-2b4f-455c-b99a-8af1708dd4fd', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-697f-712e-ab84-5a7f1ce57e67', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'a87aebbc-1b35-447a-a724-f1d62be1a44c', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6993-7135-a4a5-3973a3c86c5a', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'a9d14811-0fb8-4c08-bc05-52c0a6539761', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-69a8-726b-adca-02d427598cec', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'ad354b98-b236-4a1c-b7b5-e32757f43623', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-69bd-7358-ba35-ac19aad402d5', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'ad67895d-ef05-4fd3-965c-d793289a3c60', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-69d2-7174-8f40-5136622a8709', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'adbd3981-c5e2-4d1c-ad8f-517ef182665b', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-69e6-732d-9f80-bbef969c0f56', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'b1253b84-a194-4a34-aaa4-0ad25a5b753c', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-69fc-73d2-ba59-e1204e195943', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'b1b4d087-609a-49e7-889a-92e06fac611d', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6a12-71d0-ada9-bf27deedab93', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'b3498af8-7715-4285-99c0-e838e553cc93', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6a27-72f6-b873-f2e2cb9ed6cc', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'b8e89210-2ad3-44b5-b835-c66c8f8d2f0c', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6a3f-71e3-813e-0dfbda6fb32b', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'b9326201-1b8c-47ba-ba37-9a815071060c', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6a54-71a6-a0ac-ad543527f23a', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'bc1b8182-25c0-488b-84d5-68c90b1ad23c', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6a68-7069-9920-91ab39f65f19', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'bd645eab-8d27-47ca-9e1e-eac912720710', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6a7d-711e-ab29-2253b5c5e0be', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'bd9eebb6-2213-449f-86bd-baf830297eac', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6a92-738c-b412-cc930fd84da2', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'c4e074ba-4570-423e-b8b6-5690453120b5', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6aa7-70d1-9f9e-39e19fff951f', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'c5805496-4642-4c37-902e-8e61bbbe0fe9', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6ac0-71f0-ae3a-1856d2f12075', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'c972f56b-7bcb-43be-836e-5409f39cfcc1', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6ad5-715d-8f31-4e63513df61b', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'cd26292d-ed27-4e29-af2f-d3bd7c9ccb94', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6ae9-7159-99ab-21dfbd1e92b0', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6aff-7159-aea2-415a5953778c', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'ced6d26a-92a4-425f-803d-23a1675a27bb', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6b14-71a4-a99f-a3f34bbbf340', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'd1f7b506-e20d-4272-8bdb-049198caa7ca', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6b2a-71b1-989a-8b63fe6d91d7', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'd232990b-5c62-4b8f-a09b-05d0c0802050', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6b3e-717d-84f5-ebc0ab5e6bac', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'd2fd6adc-0357-4b77-ab00-0e4ae242b7ee', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6b54-7090-a2fa-f149ad4d8187', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'dc0cb5c6-891f-4739-a748-25e00eff192a', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6b69-72a2-b296-36b3e0e58793', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'dc604ee1-502c-456b-8b3d-006762ecedf2', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6b7e-7033-8e3a-a5002541ae5b', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'dc928dc1-d9d9-4c7f-bd29-1655d41d51c7', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6b93-7176-ab4c-9e1eaa2fe05c', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'ddb0233b-12c2-46fa-ac1a-ad64a6fdffe8', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6ba8-713d-94fa-be18a7ffafd0', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'dedf1111-bfe7-4aca-b144-a8037b941ad1', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6bbc-70b2-bdae-3afde5907cab', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'e1574175-9eb0-4621-9821-fbcc6ab78709', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6bd0-73be-bb5e-0530503b1d07', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'e2b8d9c8-2e37-4350-af98-f5fff13f743f', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6be5-71fb-85a4-dbd0305e423e', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'e4ccc7de-a8b4-4e23-9840-21a940bb2e4c', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6bf9-7251-a751-71febb3dd73d', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'e571cb0d-59ea-4434-acaf-c49027e6102e', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6c0e-7092-805c-fcf7f0b24586', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'e6579eb2-defa-4737-a29d-3d38d6a8bbb6', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6c23-7242-b383-6450979ecacb', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'e7d35619-9874-4274-8a71-cd739d923554', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6c38-7023-bc07-36ee3fb93d17', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'ea004e69-4772-48e3-93af-ac5874e2786c', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6c4e-719d-a11c-076a5989c8a1', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'f0b2f862-b909-4d51-aab8-35aa1a569506', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6c63-72c0-b77c-d5963ad28360', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'f6cb5434-a42a-41cc-8cd2-f7ebd46f485f', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6c78-7167-9ea4-c1106598b5fa', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'fde4a381-dde7-4ade-b28c-92d51e46158e', '2026-10-26 10:07:27', '2026-10-26 10:07:27'),
('01a1792e-6c8d-701d-8c46-aef764427e2f', '01a1792e-5292-7359-a09b-260b0c33e831', '010f231d-89cd-433b-968e-9831ab0acae0', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6ca2-72d8-99b1-c715700fd1c0', '01a1792e-5292-7359-a09b-260b0c33e831', '0275447c-ef3a-42c0-a5a4-99e80174202d', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6cb7-7350-9f77-4dbd16ca202d', '01a1792e-5292-7359-a09b-260b0c33e831', '07ea22a4-26b8-41f7-b72b-c83a72167d5b', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6ccc-71e7-b075-897d0e30023a', '01a1792e-5292-7359-a09b-260b0c33e831', '084d9998-26f9-4e60-9673-eb1464e6e379', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6ce1-72c5-9a4d-ba1e255c717f', '01a1792e-5292-7359-a09b-260b0c33e831', '0f81ff76-3716-49c5-b62f-c2fe71ec69b3', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6cf5-7201-b89b-2f6afb41d7e3', '01a1792e-5292-7359-a09b-260b0c33e831', '11e7e933-ef9b-4dde-a920-315f93980fbe', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6d0b-7331-a6b2-e200f3f16ab1', '01a1792e-5292-7359-a09b-260b0c33e831', '15d08eb5-60ee-4fca-a440-546aef11ff68', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6d20-7396-afda-7edaa7653aa2', '01a1792e-5292-7359-a09b-260b0c33e831', '1638884c-8d9c-4db7-963a-f5169cb09400', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6d34-7339-badd-cdf01987f5bc', '01a1792e-5292-7359-a09b-260b0c33e831', '1980f7f4-9342-454b-b2ad-7546f8a9cef1', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6d48-717f-ad6f-581fa3902ef0', '01a1792e-5292-7359-a09b-260b0c33e831', '1d075a3d-b8f1-4cbe-af32-d720d0b63d99', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6d5c-73fa-8af6-7cbacf1b0e5c', '01a1792e-5292-7359-a09b-260b0c33e831', '20e39474-a65a-4ca5-b57d-890040ebf0de', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6d70-7238-95bf-18888563afba', '01a1792e-5292-7359-a09b-260b0c33e831', '2124ed4f-89b8-4141-867a-b8f727dea154', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6d83-7023-9643-7cea541e5509', '01a1792e-5292-7359-a09b-260b0c33e831', '25c9837f-2d00-4d5a-ac4f-3cca3986cd2c', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6d96-736f-b7ab-03828bf33b68', '01a1792e-5292-7359-a09b-260b0c33e831', '26f197be-d846-4c9b-ad42-3f1f7fd05e2b', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6dac-725e-8cdb-6454bf8b8ea8', '01a1792e-5292-7359-a09b-260b0c33e831', '282726c6-14ac-430f-a23f-d48de1ab7e5d', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6dc0-704f-bfc7-ddf5e079830c', '01a1792e-5292-7359-a09b-260b0c33e831', '2d10b459-e593-4abe-9dd4-d1ae34a1db88', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6dd3-725f-bc54-33d3036cdc53', '01a1792e-5292-7359-a09b-260b0c33e831', '31fa7f1a-65f0-4946-b807-b688716c9ece', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6de7-703b-bfdf-1ddd6d20486f', '01a1792e-5292-7359-a09b-260b0c33e831', '321ea434-93c5-4d64-8ccf-b2b086e35f4d', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6dff-7393-b830-fb9ce8a3abd4', '01a1792e-5292-7359-a09b-260b0c33e831', '33401409-a814-4d69-af88-e6aab94e65a4', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6e15-70cd-8093-2fb7b75c6aa0', '01a1792e-5292-7359-a09b-260b0c33e831', '345a9584-2788-47b3-978b-4dc9e20019ef', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6e28-70b6-8ee2-88cbabad873a', '01a1792e-5292-7359-a09b-260b0c33e831', '34f0c888-19c7-49e6-b451-3ee517c89817', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6e3c-7380-aaf3-a21a6f350dca', '01a1792e-5292-7359-a09b-260b0c33e831', '3572cceb-b225-4dde-8f96-84c95f5b389d', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6e4f-723f-8a3c-9d77f9dcb204', '01a1792e-5292-7359-a09b-260b0c33e831', '359e2a06-6206-4452-a57b-0726a6f0ff95', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6e63-7057-afac-8eb7df7366f1', '01a1792e-5292-7359-a09b-260b0c33e831', '3977d722-ebce-4252-9cca-b4a65a22876f', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6e7d-7108-91fc-7de48355df9c', '01a1792e-5292-7359-a09b-260b0c33e831', '39cf7382-a796-4540-8639-119610794864', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6e9a-7205-99e1-d973b04562b8', '01a1792e-5292-7359-a09b-260b0c33e831', '3af6ca87-fdde-4bb2-ae53-4b547d814912', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6ebb-73fb-8978-4f8d59b2b5b9', '01a1792e-5292-7359-a09b-260b0c33e831', '3af9a1f6-445b-437c-8c17-733ac4f6b330', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6edc-72ed-9a6f-f059d3f689fd', '01a1792e-5292-7359-a09b-260b0c33e831', '3bedac29-10e0-4a32-9e4a-f546f7a801e6', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6efa-7254-8a77-445ba9251815', '01a1792e-5292-7359-a09b-260b0c33e831', '3ea66bfc-d9d9-4112-910d-3f79470a44d7', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6f16-7380-b133-c420ff8737ab', '01a1792e-5292-7359-a09b-260b0c33e831', '3f2aae12-675c-4361-bbd7-46bade7fbc68', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6f2c-71a3-a08c-96f37835b9e0', '01a1792e-5292-7359-a09b-260b0c33e831', '3f3ad8a4-e3a8-4264-bc0e-33a4b49d0344', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6f42-7237-971c-8425bcec91b9', '01a1792e-5292-7359-a09b-260b0c33e831', '42205c22-6765-4780-9f84-6abfe4183ef1', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6f5a-7280-b6d4-b8c74d4c86d1', '01a1792e-5292-7359-a09b-260b0c33e831', '432d5f17-a71f-4269-830a-6eda6a711b30', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6f75-7260-bf75-56244ff7dabc', '01a1792e-5292-7359-a09b-260b0c33e831', '447417a0-c4a0-47d7-a26c-20ace6b277a5', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6f8d-7104-9344-516d22b5f811', '01a1792e-5292-7359-a09b-260b0c33e831', '4b1493eb-71c4-4fdc-9b94-862c313cfef5', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6faa-7189-91b8-45403c137a83', '01a1792e-5292-7359-a09b-260b0c33e831', '4d2150f9-61a1-4047-9f2e-18bf649e700b', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6fce-703a-9b6d-708c2c6328c7', '01a1792e-5292-7359-a09b-260b0c33e831', '4dc29692-975f-482f-b7d0-ee44b410ce11', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-6fe9-715d-af8e-1750827cfa20', '01a1792e-5292-7359-a09b-260b0c33e831', '502c6443-3788-46d5-842c-6907760bab5d', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-7008-7084-8248-6a06e3e506c7', '01a1792e-5292-7359-a09b-260b0c33e831', '53402b88-500b-4d58-a421-dc0370942f23', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-7022-72c2-be0d-b72f803881e2', '01a1792e-5292-7359-a09b-260b0c33e831', '5542cf94-e5bd-46af-b6b3-54952a6d4da0', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-703e-71b1-bfcb-ee505d3d3657', '01a1792e-5292-7359-a09b-260b0c33e831', '5667a9b0-c57d-4c9e-bb39-5f38a587e649', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-7060-70ce-ba84-cac0179595a1', '01a1792e-5292-7359-a09b-260b0c33e831', '58045d05-2f17-4bdc-89cf-9e51f72eec73', '2026-10-26 10:07:28', '2026-10-26 10:07:28'),
('01a1792e-7081-7035-b887-609c8465ec72', '01a1792e-5292-7359-a09b-260b0c33e831', '58882c34-1ca0-4af9-8831-ab160748b48d', '2026-10-26 10:07:29', '2026-10-26 10:07:29'),
('01a1792e-70a5-70c1-a55e-3e6b8fe1b826', '01a1792e-5292-7359-a09b-260b0c33e831', '5966307e-6e50-43da-aeb6-171a838e1ad1', '2026-10-26 10:07:29', '2026-10-26 10:07:29'),
('01a1792e-70c4-73bf-bf8b-f8dee2cc9ed3', '01a1792e-5292-7359-a09b-260b0c33e831', '5d121272-39ff-430a-9747-d2778985531c', '2026-10-26 10:07:29', '2026-10-26 10:07:29'),
('01a1792e-70e3-716c-920d-38a9a9eb88a4', '01a1792e-5292-7359-a09b-260b0c33e831', '5d137200-2a11-49be-8ae4-b2f6e89d149b', '2026-10-26 10:07:29', '2026-10-26 10:07:29'),
('01a1792e-70fd-7145-b5b3-7e030e8cdfa2', '01a1792e-5292-7359-a09b-260b0c33e831', '5e2faaa4-6d8a-470b-8dc7-9944523b207d', '2026-10-26 10:07:29', '2026-10-26 10:07:29'),
('01a1792e-7125-7029-a719-f64b71a30061', '01a1792e-5292-7359-a09b-260b0c33e831', '606cccc9-e4fd-4abe-9b27-2391c7302bc5', '2026-10-26 10:07:29', '2026-10-26 10:07:29'),
('01a1792e-7143-72da-a624-dbfbf257d19d', '01a1792e-5292-7359-a09b-260b0c33e831', '612982a1-3742-4197-bb24-19cd345b6ea3', '2026-10-26 10:07:29', '2026-10-26 10:07:29'),
('01a1792e-7162-705d-9c11-9fac0765d689', '01a1792e-5292-7359-a09b-260b0c33e831', '647d236e-d87f-4fb2-8384-95f4aac31c1d', '2026-10-26 10:07:29', '2026-10-26 10:07:29'),
('01a1792e-717f-717b-9d5c-803a493fbcb8', '01a1792e-5292-7359-a09b-260b0c33e831', '64bf8847-e02b-4b2b-a547-e10b8a4d5cb7', '2026-10-26 10:07:29', '2026-10-26 10:07:29'),
('01a1792e-719e-713b-babf-0cf161f5e4a2', '01a1792e-5292-7359-a09b-260b0c33e831', '652677ff-bda5-43aa-aebc-72b2316b1b2a', '2026-10-26 10:07:29', '2026-10-26 10:07:29'),
('01a1792e-71c6-725c-a418-eaa6be09e829', '01a1792e-5292-7359-a09b-260b0c33e831', '69db5ffb-0401-4e45-8f5d-12dd818bfa89', '2026-10-26 10:07:29', '2026-10-26 10:07:29'),
('01a1792e-71e6-712a-875c-2440356b3e09', '01a1792e-5292-7359-a09b-260b0c33e831', '711d6463-1665-4710-b2fb-30af0dc1e664', '2026-10-26 10:07:29', '2026-10-26 10:07:29'),
('01a1792e-720a-700c-8acd-d930b931af37', '01a1792e-5292-7359-a09b-260b0c33e831', '722e32e0-3b7d-4927-90f1-5a733e1fb723', '2026-10-26 10:07:29', '2026-10-26 10:07:29'),
('01a1792e-7231-73c8-b57a-4b687310fbcd', '01a1792e-5292-7359-a09b-260b0c33e831', '7703cbfd-b06b-4acf-97cc-7cf6f0b3d94c', '2026-10-26 10:07:29', '2026-10-26 10:07:29'),
('01a1792e-724e-7068-824a-c9308f98172e', '01a1792e-5292-7359-a09b-260b0c33e831', '77feaec0-e773-4716-aac8-cd3b08e31d47', '2026-10-26 10:07:29', '2026-10-26 10:07:29'),
('01a1792e-726f-72dc-acef-e9ff984f94fa', '01a1792e-5292-7359-a09b-260b0c33e831', '7dc4f8dd-9f03-45f2-aac9-4dfe20680aa4', '2026-10-26 10:07:29', '2026-10-26 10:07:29'),
('01a1792e-728d-7226-a2a4-a3404d9ee505', '01a1792e-5292-7359-a09b-260b0c33e831', '803d85d9-ada0-4573-81dc-1b6384bd5d59', '2026-10-26 10:07:29', '2026-10-26 10:07:29'),
('01a1792e-72a9-7081-b7c7-8366885be24a', '01a1792e-5292-7359-a09b-260b0c33e831', '83b231e2-5339-4184-9cb3-6c3737bbee93', '2026-10-26 10:07:29', '2026-10-26 10:07:29'),
('01a1792e-72c8-71d6-9c54-69fba8ec3b14', '01a1792e-5292-7359-a09b-260b0c33e831', '8ac00223-9ddc-44f0-9003-883c1bca639c', '2026-10-26 10:07:29', '2026-10-26 10:07:29'),
('01a1792e-72e4-70ec-aa75-00cd8188b47a', '01a1792e-5292-7359-a09b-260b0c33e831', '8d2b0181-1547-409b-a288-19954f2399be', '2026-10-26 10:07:29', '2026-10-26 10:07:29'),
('01a1792e-7304-7395-98ac-91be237ccf23', '01a1792e-5292-7359-a09b-260b0c33e831', '903dc389-7285-443b-a8d3-05b74405aaed', '2026-10-26 10:07:29', '2026-10-26 10:07:29'),
('01a1792e-731e-73ff-9bdc-70d7bdc09c57', '01a1792e-5292-7359-a09b-260b0c33e831', '92f9968f-f894-4d26-be0c-654369502780', '2026-10-26 10:07:29', '2026-10-26 10:07:29'),
('01a1792e-7339-7334-badd-d1a9e7f8446e', '01a1792e-5292-7359-a09b-260b0c33e831', '943a3993-3c67-42b4-9fd3-969319245e31', '2026-10-26 10:07:29', '2026-10-26 10:07:29'),
('01a1792e-7354-72c4-8356-d4f051c571b7', '01a1792e-5292-7359-a09b-260b0c33e831', '95a7ed84-8c0a-4124-832b-c9c2b27017e4', '2026-10-26 10:07:29', '2026-10-26 10:07:29'),
('01a1792e-7371-7013-a470-ed2a88f27e1a', '01a1792e-5292-7359-a09b-260b0c33e831', '96b49412-8021-4bec-9c3e-775fe44a76d6', '2026-10-26 10:07:29', '2026-10-26 10:07:29'),
('01a1792e-738b-7342-b331-0ddc849fd071', '01a1792e-5292-7359-a09b-260b0c33e831', '97d314b2-8775-48ce-859f-2d07ef6cd337', '2026-10-26 10:07:29', '2026-10-26 10:07:29'),
('01a1792e-73a7-73e1-864d-c823b165d549', '01a1792e-5292-7359-a09b-260b0c33e831', '98507351-f369-4453-b27c-000a2aa83ae7', '2026-10-26 10:07:29', '2026-10-26 10:07:29'),
('01a1792e-73c3-72cf-9a3a-a4dea045a30a', '01a1792e-5292-7359-a09b-260b0c33e831', '992bb6b7-dc96-40a4-844f-9ee27c6ea624', '2026-10-26 10:07:29', '2026-10-26 10:07:29'),
('01a1792e-73df-70a7-8332-dcfbe2c24e73', '01a1792e-5292-7359-a09b-260b0c33e831', '9d2e525c-d95f-4204-a442-f149853a1f89', '2026-10-26 10:07:29', '2026-10-26 10:07:29'),
('01a1792e-73fd-726f-af0b-636b493be3e4', '01a1792e-5292-7359-a09b-260b0c33e831', '9d630aba-892a-4099-9e12-2ad4fb685a96', '2026-10-26 10:07:29', '2026-10-26 10:07:29'),
('01a1792e-7419-71c8-a806-0c84a34dc627', '01a1792e-5292-7359-a09b-260b0c33e831', '9e66ffab-1485-4411-87df-e2fd46e8dccc', '2026-10-26 10:07:29', '2026-10-26 10:07:29'),
('01a1792e-743b-703d-98ea-074fdafa6a84', '01a1792e-5292-7359-a09b-260b0c33e831', 'a07169ae-8be3-4db7-9fe0-9961831c418f', '2026-10-26 10:07:29', '2026-10-26 10:07:29'),
('01a1792e-7460-7137-a16d-7c2f3ee5b71a', '01a1792e-5292-7359-a09b-260b0c33e831', 'a15b742a-f0f8-45a0-9f92-6f4dd317a6c9', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-747e-70a2-91de-3b0a007a5281', '01a1792e-5292-7359-a09b-260b0c33e831', 'a1e86fce-2b4f-455c-b99a-8af1708dd4fd', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-74a0-7389-8a3e-e5c1f5b6643a', '01a1792e-5292-7359-a09b-260b0c33e831', 'a87aebbc-1b35-447a-a724-f1d62be1a44c', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-74be-70ff-a466-7f496fb5b2eb', '01a1792e-5292-7359-a09b-260b0c33e831', 'a9d14811-0fb8-4c08-bc05-52c0a6539761', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-74e1-723d-90f8-7a550827a5da', '01a1792e-5292-7359-a09b-260b0c33e831', 'ad354b98-b236-4a1c-b7b5-e32757f43623', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-7500-73a9-82c8-b4e132882599', '01a1792e-5292-7359-a09b-260b0c33e831', 'ad67895d-ef05-4fd3-965c-d793289a3c60', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-751a-714b-a2a8-3cf2d91dd544', '01a1792e-5292-7359-a09b-260b0c33e831', 'adbd3981-c5e2-4d1c-ad8f-517ef182665b', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-7538-70e1-86ef-925f41cd2c11', '01a1792e-5292-7359-a09b-260b0c33e831', 'b1253b84-a194-4a34-aaa4-0ad25a5b753c', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-7551-7305-ade8-62f643af9298', '01a1792e-5292-7359-a09b-260b0c33e831', 'b1b4d087-609a-49e7-889a-92e06fac611d', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-7569-70cc-9983-39c3c8ae5058', '01a1792e-5292-7359-a09b-260b0c33e831', 'b3498af8-7715-4285-99c0-e838e553cc93', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-7582-737e-b9b3-92f9acc746b5', '01a1792e-5292-7359-a09b-260b0c33e831', 'b8e89210-2ad3-44b5-b835-c66c8f8d2f0c', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-75a1-722c-9715-d2c19e3b16c5', '01a1792e-5292-7359-a09b-260b0c33e831', 'b9326201-1b8c-47ba-ba37-9a815071060c', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-75c1-72c6-a47a-98f8b5ba46fb', '01a1792e-5292-7359-a09b-260b0c33e831', 'bc1b8182-25c0-488b-84d5-68c90b1ad23c', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-75dc-7177-a0f1-0146a7e240f3', '01a1792e-5292-7359-a09b-260b0c33e831', 'bd645eab-8d27-47ca-9e1e-eac912720710', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-75f6-732d-9083-94323c3555e3', '01a1792e-5292-7359-a09b-260b0c33e831', 'bd9eebb6-2213-449f-86bd-baf830297eac', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-7610-72f3-9ea7-cb847027df9f', '01a1792e-5292-7359-a09b-260b0c33e831', 'c4e074ba-4570-423e-b8b6-5690453120b5', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-762c-70dd-a070-6c5cfe589ce4', '01a1792e-5292-7359-a09b-260b0c33e831', 'c5805496-4642-4c37-902e-8e61bbbe0fe9', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-764e-700f-9cff-b19df27ed978', '01a1792e-5292-7359-a09b-260b0c33e831', 'c972f56b-7bcb-43be-836e-5409f39cfcc1', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-766c-73fa-8460-4f5eea78a127', '01a1792e-5292-7359-a09b-260b0c33e831', 'cd26292d-ed27-4e29-af2f-d3bd7c9ccb94', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-7685-70fc-a53d-684fec244e34', '01a1792e-5292-7359-a09b-260b0c33e831', 'cdc2398f-76f8-4a5e-8251-5afdc8a94d29', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-76a0-73c1-b5e4-5375380179f6', '01a1792e-5292-7359-a09b-260b0c33e831', 'ced6d26a-92a4-425f-803d-23a1675a27bb', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-76c3-72d2-915a-7c140f93f8c4', '01a1792e-5292-7359-a09b-260b0c33e831', 'd1f7b506-e20d-4272-8bdb-049198caa7ca', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-76e1-718e-ac03-bb2117e07ddb', '01a1792e-5292-7359-a09b-260b0c33e831', 'd232990b-5c62-4b8f-a09b-05d0c0802050', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-7703-714c-b06a-081ec8d994fd', '01a1792e-5292-7359-a09b-260b0c33e831', 'd2fd6adc-0357-4b77-ab00-0e4ae242b7ee', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-7725-715f-bc7c-6e18a21f140b', '01a1792e-5292-7359-a09b-260b0c33e831', 'dc0cb5c6-891f-4739-a748-25e00eff192a', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-7744-7227-a226-82394fbb74a7', '01a1792e-5292-7359-a09b-260b0c33e831', 'dc604ee1-502c-456b-8b3d-006762ecedf2', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-7760-7086-bedd-cde1de36a963', '01a1792e-5292-7359-a09b-260b0c33e831', 'dc928dc1-d9d9-4c7f-bd29-1655d41d51c7', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-777c-7355-9278-2f1c85f5da01', '01a1792e-5292-7359-a09b-260b0c33e831', 'ddb0233b-12c2-46fa-ac1a-ad64a6fdffe8', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-7799-70ce-a469-553f2c068cc1', '01a1792e-5292-7359-a09b-260b0c33e831', 'dedf1111-bfe7-4aca-b144-a8037b941ad1', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-77b7-7297-9667-4cf67b4bee0a', '01a1792e-5292-7359-a09b-260b0c33e831', 'e1574175-9eb0-4621-9821-fbcc6ab78709', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-77da-7354-a39c-0521eccba503', '01a1792e-5292-7359-a09b-260b0c33e831', 'e2b8d9c8-2e37-4350-af98-f5fff13f743f', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-77f8-72ae-a00d-18f812e52ad4', '01a1792e-5292-7359-a09b-260b0c33e831', 'e4ccc7de-a8b4-4e23-9840-21a940bb2e4c', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-7817-7029-9625-6b631d92d23f', '01a1792e-5292-7359-a09b-260b0c33e831', 'e571cb0d-59ea-4434-acaf-c49027e6102e', '2026-10-26 10:07:30', '2026-10-26 10:07:30'),
('01a1792e-7839-73f4-9f5f-c1f74c14e74e', '01a1792e-5292-7359-a09b-260b0c33e831', 'e6579eb2-defa-4737-a29d-3d38d6a8bbb6', '2026-10-26 10:07:31', '2026-10-26 10:07:31'),
('01a1792e-785a-7255-8c1b-26484d447e57', '01a1792e-5292-7359-a09b-260b0c33e831', 'e7d35619-9874-4274-8a71-cd739d923554', '2026-10-26 10:07:31', '2026-10-26 10:07:31'),
('01a1792e-7874-71bd-9d1a-a8be3c0d2861', '01a1792e-5292-7359-a09b-260b0c33e831', 'ea004e69-4772-48e3-93af-ac5874e2786c', '2026-10-26 10:07:31', '2026-10-26 10:07:31'),
('01a1792e-7892-7105-a96e-61845f5dc46c', '01a1792e-5292-7359-a09b-260b0c33e831', 'f0b2f862-b909-4d51-aab8-35aa1a569506', '2026-10-26 10:07:31', '2026-10-26 10:07:31'),
('01a1792e-78b6-72bd-8183-6595ccbc2a83', '01a1792e-5292-7359-a09b-260b0c33e831', 'f6cb5434-a42a-41cc-8cd2-f7ebd46f485f', '2026-10-26 10:07:31', '2026-10-26 10:07:31'),
('01a1792e-78df-712f-971a-897a65a15e74', '01a1792e-5292-7359-a09b-260b0c33e831', 'fde4a381-dde7-4ade-b28c-92d51e46158e', '2026-10-26 10:07:31', '2026-10-26 10:07:31');

--
-- Indeks untuk tabel yang dibuang
--

--
-- Indeks untuk tabel `account_topups`
--
ALTER TABLE `account_topups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_topups_chart_of_account_id_foreign` (`chart_of_account_id`),
  ADD KEY `account_topups_period_id_foreign` (`period_id`),
  ADD KEY `account_topups_sub_period_id_foreign` (`sub_period_id`),
  ADD KEY `account_topups_created_by_foreign` (`created_by`);

--
-- Indeks untuk tabel `account_types`
--
ALTER TABLE `account_types`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `activity_logs_user_id_action_module_index` (`user_id`,`action`,`module`),
  ADD KEY `activity_logs_subject_type_subject_id_index` (`subject_type`,`subject_id`);

--
-- Indeks untuk tabel `balance_requests`
--
ALTER TABLE `balance_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `balance_requests_requester_id_foreign` (`requester_id`),
  ADD KEY `balance_requests_approver_id_foreign` (`approver_id`),
  ADD KEY `balance_requests_user_account_id_foreign` (`user_account_id`),
  ADD KEY `balance_requests_source_coa_id_foreign` (`source_coa_id`),
  ADD KEY `balance_requests_period_id_foreign` (`period_id`),
  ADD KEY `balance_requests_sub_period_id_foreign` (`sub_period_id`);

--
-- Indeks untuk tabel `budget_allocations`
--
ALTER TABLE `budget_allocations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `budget_allocations_from_chart_of_account_id_foreign` (`from_chart_of_account_id`),
  ADD KEY `budget_allocations_to_chart_of_account_id_foreign` (`to_chart_of_account_id`),
  ADD KEY `budget_allocations_period_id_foreign` (`period_id`),
  ADD KEY `budget_allocations_sub_period_id_foreign` (`sub_period_id`),
  ADD KEY `budget_allocations_created_by_foreign` (`created_by`);

--
-- Indeks untuk tabel `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indeks untuk tabel `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indeks untuk tabel `chart_of_accounts`
--
ALTER TABLE `chart_of_accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `chart_of_accounts_code_unique` (`code`),
  ADD KEY `chart_of_accounts_parent_id_foreign` (`parent_id`),
  ADD KEY `chart_of_accounts_account_type_id_foreign` (`account_type_id`),
  ADD KEY `chart_of_accounts_created_by_foreign` (`created_by`);

--
-- Indeks untuk tabel `closing_balances`
--
ALTER TABLE `closing_balances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `closing_balances_period_id_foreign` (`period_id`),
  ADD KEY `closing_balances_sub_period_id_foreign` (`sub_period_id`),
  ADD KEY `closing_balances_chart_of_account_id_foreign` (`chart_of_account_id`),
  ADD KEY `closing_balances_created_by_foreign` (`created_by`);

--
-- Indeks untuk tabel `coa_balances`
--
ALTER TABLE `coa_balances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `coa_balances_chart_of_account_id_foreign` (`chart_of_account_id`),
  ADD KEY `coa_balances_period_id_foreign` (`period_id`),
  ADD KEY `coa_balances_sub_period_id_foreign` (`sub_period_id`);

--
-- Indeks untuk tabel `coa_requests`
--
ALTER TABLE `coa_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `coa_requests_requester_id_foreign` (`requester_id`),
  ADD KEY `coa_requests_approver_id_foreign` (`approver_id`),
  ADD KEY `coa_requests_parent_coa_id_foreign` (`parent_coa_id`),
  ADD KEY `coa_requests_account_type_id_foreign` (`account_type_id`),
  ADD KEY `coa_requests_sub_period_id_foreign` (`sub_period_id`);

--
-- Indeks untuk tabel `configurations`
--
ALTER TABLE `configurations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `configurations_key_unique` (`key`);

--
-- Indeks untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indeks untuk tabel `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indeks untuk tabel `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `journals`
--
ALTER TABLE `journals`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `journals_journal_number_unique` (`journal_number`),
  ADD KEY `journals_posted_by_foreign` (`posted_by`),
  ADD KEY `journals_period_id_foreign` (`period_id`),
  ADD KEY `journals_sub_period_id_foreign` (`sub_period_id`),
  ADD KEY `journals_transaction_id_foreign` (`transaction_id`);

--
-- Indeks untuk tabel `journal_details`
--
ALTER TABLE `journal_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `journal_details_journal_id_foreign` (`journal_id`),
  ADD KEY `journal_details_chart_of_account_id_foreign` (`chart_of_account_id`);

--
-- Indeks untuk tabel `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `media_uuid_unique` (`uuid`),
  ADD KEY `media_model_type_model_id_index` (`model_type`,`model_id`),
  ADD KEY `media_order_column_index` (`order_column`);

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indeks untuk tabel `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indeks untuk tabel `opening_balances`
--
ALTER TABLE `opening_balances`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_opening_balance` (`chart_of_account_id`,`period_id`,`sub_period_id`),
  ADD KEY `opening_balances_period_id_foreign` (`period_id`),
  ADD KEY `opening_balances_sub_period_id_foreign` (`sub_period_id`),
  ADD KEY `opening_balances_created_by_foreign` (`created_by`);

--
-- Indeks untuk tabel `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indeks untuk tabel `periods`
--
ALTER TABLE `periods`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indeks untuk tabel `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indeks untuk tabel `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indeks untuk tabel `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indeks untuk tabel `sub_periods`
--
ALTER TABLE `sub_periods`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sub_periods_period_id_foreign` (`period_id`),
  ADD KEY `sub_periods_closed_by_foreign` (`closed_by`);

--
-- Indeks untuk tabel `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `transactions_transaction_number_unique` (`transaction_number`),
  ADD KEY `transactions_period_id_foreign` (`period_id`),
  ADD KEY `transactions_sub_period_id_foreign` (`sub_period_id`),
  ADD KEY `transactions_created_by_foreign` (`created_by`);

--
-- Indeks untuk tabel `transaction_lines`
--
ALTER TABLE `transaction_lines`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaction_lines_transaction_id_foreign` (`transaction_id`),
  ADD KEY `transaction_lines_chart_of_account_id_foreign` (`chart_of_account_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indeks untuk tabel `user_accounts`
--
ALTER TABLE `user_accounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_accounts_user_id_foreign` (`user_id`),
  ADD KEY `user_accounts_coa_id_foreign` (`coa_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `media`
--
ALTER TABLE `media`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `account_topups`
--
ALTER TABLE `account_topups`
  ADD CONSTRAINT `account_topups_chart_of_account_id_foreign` FOREIGN KEY (`chart_of_account_id`) REFERENCES `chart_of_accounts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `account_topups_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `account_topups_period_id_foreign` FOREIGN KEY (`period_id`) REFERENCES `periods` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `account_topups_sub_period_id_foreign` FOREIGN KEY (`sub_period_id`) REFERENCES `sub_periods` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `activity_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `balance_requests`
--
ALTER TABLE `balance_requests`
  ADD CONSTRAINT `balance_requests_approver_id_foreign` FOREIGN KEY (`approver_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `balance_requests_period_id_foreign` FOREIGN KEY (`period_id`) REFERENCES `periods` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `balance_requests_requester_id_foreign` FOREIGN KEY (`requester_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `balance_requests_source_coa_id_foreign` FOREIGN KEY (`source_coa_id`) REFERENCES `coa_balances` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `balance_requests_sub_period_id_foreign` FOREIGN KEY (`sub_period_id`) REFERENCES `sub_periods` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `balance_requests_user_account_id_foreign` FOREIGN KEY (`user_account_id`) REFERENCES `user_accounts` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `budget_allocations`
--
ALTER TABLE `budget_allocations`
  ADD CONSTRAINT `budget_allocations_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `budget_allocations_from_chart_of_account_id_foreign` FOREIGN KEY (`from_chart_of_account_id`) REFERENCES `chart_of_accounts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `budget_allocations_period_id_foreign` FOREIGN KEY (`period_id`) REFERENCES `periods` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `budget_allocations_sub_period_id_foreign` FOREIGN KEY (`sub_period_id`) REFERENCES `sub_periods` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `budget_allocations_to_chart_of_account_id_foreign` FOREIGN KEY (`to_chart_of_account_id`) REFERENCES `chart_of_accounts` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `chart_of_accounts`
--
ALTER TABLE `chart_of_accounts`
  ADD CONSTRAINT `chart_of_accounts_account_type_id_foreign` FOREIGN KEY (`account_type_id`) REFERENCES `account_types` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `chart_of_accounts_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `chart_of_accounts_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `chart_of_accounts` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `closing_balances`
--
ALTER TABLE `closing_balances`
  ADD CONSTRAINT `closing_balances_chart_of_account_id_foreign` FOREIGN KEY (`chart_of_account_id`) REFERENCES `chart_of_accounts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `closing_balances_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `closing_balances_period_id_foreign` FOREIGN KEY (`period_id`) REFERENCES `periods` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `closing_balances_sub_period_id_foreign` FOREIGN KEY (`sub_period_id`) REFERENCES `sub_periods` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `coa_balances`
--
ALTER TABLE `coa_balances`
  ADD CONSTRAINT `coa_balances_chart_of_account_id_foreign` FOREIGN KEY (`chart_of_account_id`) REFERENCES `chart_of_accounts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `coa_balances_period_id_foreign` FOREIGN KEY (`period_id`) REFERENCES `periods` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `coa_balances_sub_period_id_foreign` FOREIGN KEY (`sub_period_id`) REFERENCES `sub_periods` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `coa_requests`
--
ALTER TABLE `coa_requests`
  ADD CONSTRAINT `coa_requests_account_type_id_foreign` FOREIGN KEY (`account_type_id`) REFERENCES `account_types` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `coa_requests_approver_id_foreign` FOREIGN KEY (`approver_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `coa_requests_parent_coa_id_foreign` FOREIGN KEY (`parent_coa_id`) REFERENCES `chart_of_accounts` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `coa_requests_requester_id_foreign` FOREIGN KEY (`requester_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `coa_requests_sub_period_id_foreign` FOREIGN KEY (`sub_period_id`) REFERENCES `sub_periods` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `journals`
--
ALTER TABLE `journals`
  ADD CONSTRAINT `journals_period_id_foreign` FOREIGN KEY (`period_id`) REFERENCES `periods` (`id`),
  ADD CONSTRAINT `journals_posted_by_foreign` FOREIGN KEY (`posted_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `journals_sub_period_id_foreign` FOREIGN KEY (`sub_period_id`) REFERENCES `sub_periods` (`id`),
  ADD CONSTRAINT `journals_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`);

--
-- Ketidakleluasaan untuk tabel `journal_details`
--
ALTER TABLE `journal_details`
  ADD CONSTRAINT `journal_details_chart_of_account_id_foreign` FOREIGN KEY (`chart_of_account_id`) REFERENCES `chart_of_accounts` (`id`),
  ADD CONSTRAINT `journal_details_journal_id_foreign` FOREIGN KEY (`journal_id`) REFERENCES `journals` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `opening_balances`
--
ALTER TABLE `opening_balances`
  ADD CONSTRAINT `opening_balances_chart_of_account_id_foreign` FOREIGN KEY (`chart_of_account_id`) REFERENCES `chart_of_accounts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `opening_balances_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `opening_balances_period_id_foreign` FOREIGN KEY (`period_id`) REFERENCES `periods` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `opening_balances_sub_period_id_foreign` FOREIGN KEY (`sub_period_id`) REFERENCES `sub_periods` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `sessions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `sub_periods`
--
ALTER TABLE `sub_periods`
  ADD CONSTRAINT `sub_periods_closed_by_foreign` FOREIGN KEY (`closed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `sub_periods_period_id_foreign` FOREIGN KEY (`period_id`) REFERENCES `periods` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `transactions_period_id_foreign` FOREIGN KEY (`period_id`) REFERENCES `periods` (`id`),
  ADD CONSTRAINT `transactions_sub_period_id_foreign` FOREIGN KEY (`sub_period_id`) REFERENCES `sub_periods` (`id`);

--
-- Ketidakleluasaan untuk tabel `transaction_lines`
--
ALTER TABLE `transaction_lines`
  ADD CONSTRAINT `transaction_lines_chart_of_account_id_foreign` FOREIGN KEY (`chart_of_account_id`) REFERENCES `chart_of_accounts` (`id`),
  ADD CONSTRAINT `transaction_lines_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `user_accounts`
--
ALTER TABLE `user_accounts`
  ADD CONSTRAINT `user_accounts_coa_id_foreign` FOREIGN KEY (`coa_id`) REFERENCES `chart_of_accounts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_accounts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;
