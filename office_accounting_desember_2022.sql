-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 27 Okt 2026 pada 00.33
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
('01a1793e-e3c0-72fc-be2b-cc244b4fcc1d', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Tabungan Bueka Assakinah (11600) pada sub periode Desember 2022 dengan jumlah 676,151,976.00', 'App\\Models\\OpeningBalance', '01a1793e-e3af-709c-a6e5-15a2351aa1be', '[]', '{\"chart_of_account_id\":\"e6579eb2-defa-4737-a29d-3d38d6a8bbb6\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"sub_period_id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"balance_type\":\"DEBIT\",\"amount\":676151976,\"created_by\":\"01a1792e-5006-7295-87ce-69d0ddc1b0bd\",\"is_correction\":false,\"id\":\"01a1793e-e3af-709c-a6e5-15a2351aa1be\",\"updated_at\":\"2026-10-26T17:25:27.000000Z\",\"created_at\":\"2026-10-26T17:25:27.000000Z\",\"chart_of_account\":{\"id\":\"e6579eb2-defa-4737-a29d-3d38d6a8bbb6\",\"code\":\"11600\",\"name\":\"Tabungan Bueka Assakinah\",\"parent_id\":\"98507351-f369-4453-b27c-000a2aa83ae7\",\"level\":\"2\",\"order\":\"6\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-26T17:07:22.000000Z\",\"updated_at\":\"2026-10-26T17:07:22.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-26T17:07:21.000000Z\",\"updated_at\":\"2026-10-26T17:07:21.000000Z\"}}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"e6579eb2-defa-4737-a29d-3d38d6a8bbb6\",\"period_id\":\"01a1792e-532a-71c5-9f47-bf4b3f756557\",\"sub_period_id\":\"01a1792e-5359-72cf-8044-02a860ff46d3\",\"opening_balance\":676151976,\"debit_total\":0,\"credit_total\":0,\"current_balance\":676151976,\"last_transaction_at\":\"2026-10-26T17:25:27.000000Z\",\"id\":\"01a1793e-e3b7-724e-94e2-4d892849c27c\",\"updated_at\":\"2026-10-26T17:25:27.000000Z\",\"created_at\":\"2026-10-26T17:25:27.000000Z\"}}', '2026-10-26 10:25:27', '2026-10-26 10:25:27');

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
('01a17937-fc75-7223-b441-ca0537d86b85', 'dc604ee1-502c-456b-8b3d-006762ecedf2', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', 377940865.00, 0.00, 0.00, 377940865.00, '2026-10-26 10:17:54', NULL, '2026-10-26 10:17:54', '2026-10-26 10:17:54'),
('01a17938-4bc1-7062-afbd-06b4f6864022', 'f0b2f862-b909-4d51-aab8-35aa1a569506', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', 1800000.00, 0.00, 0.00, 1800000.00, '2026-10-26 10:18:14', NULL, '2026-10-26 10:18:14', '2026-10-26 10:18:14'),
('01a17939-0bdb-7222-b966-5c40725561ea', 'bd645eab-8d27-47ca-9e1e-eac912720710', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', 245583300.00, 0.00, 0.00, 245583300.00, '2026-10-26 10:19:04', NULL, '2026-10-26 10:19:04', '2026-10-26 10:19:04'),
('01a1793a-22b6-7291-a8c3-3e7143402795', '58045d05-2f17-4bdc-89cf-9e51f72eec73', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', 460769432.00, 0.00, 0.00, 460769432.00, '2026-10-26 10:20:15', NULL, '2026-10-26 10:20:15', '2026-10-26 10:20:15'),
('01a1793a-8482-728d-b637-e2c0c616804f', '20e39474-a65a-4ca5-b57d-890040ebf0de', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', 144000000.00, 0.00, 0.00, 144000000.00, '2026-10-26 10:20:40', NULL, '2026-10-26 10:20:40', '2026-10-26 10:20:40'),
('01a1793a-d428-71af-ae90-d3db81704ce4', '5542cf94-e5bd-46af-b6b3-54952a6d4da0', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', 15500000.00, 0.00, 0.00, 15500000.00, '2026-10-26 10:21:00', NULL, '2026-10-26 10:21:00', '2026-10-26 10:21:00'),
('01a1793b-99bc-7169-9e73-2c448ef723e0', '53402b88-500b-4d58-a421-dc0370942f23', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', 13376668.00, 0.00, 0.00, 13376668.00, '2026-10-26 10:21:51', NULL, '2026-10-26 10:21:51', '2026-10-26 10:21:51'),
('01a1793b-ff72-7172-9871-2f9c5e8cb60c', '010f231d-89cd-433b-968e-9831ab0acae0', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', 46059000.00, 0.00, 0.00, 46059000.00, '2026-10-26 10:22:17', NULL, '2026-10-26 10:22:17', '2026-10-26 10:22:17'),
('01a1793c-7683-7298-b3ff-2fdd76864000', 'b3498af8-7715-4285-99c0-e838e553cc93', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', 25236667.00, 0.00, 0.00, 25236667.00, '2026-10-26 10:22:48', NULL, '2026-10-26 10:22:48', '2026-10-26 10:22:48'),
('01a1793e-e3b7-724e-94e2-4d892849c27c', 'e6579eb2-defa-4737-a29d-3d38d6a8bbb6', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', 676151976.00, 0.00, 0.00, 676151976.00, '2026-10-26 10:25:27', NULL, '2026-10-26 10:25:27', '2026-10-26 10:25:27');

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
('01a17937-fc6f-72c9-b352-7f0dd5de7c3a', 'dc604ee1-502c-456b-8b3d-006762ecedf2', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 377940865.00, 0, NULL, '2026-10-26 10:17:54', '2026-10-26 10:17:54'),
('01a17938-4bbc-73d4-ad10-58b13ac2e51b', 'f0b2f862-b909-4d51-aab8-35aa1a569506', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 1800000.00, 0, NULL, '2026-10-26 10:18:14', '2026-10-26 10:18:14'),
('01a17939-0bd0-7396-9851-5ffa05053d16', 'bd645eab-8d27-47ca-9e1e-eac912720710', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 245583300.00, 0, NULL, '2026-10-26 10:19:04', '2026-10-26 10:19:04'),
('01a1793a-22b1-710f-b4bb-29a536f87032', '58045d05-2f17-4bdc-89cf-9e51f72eec73', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 460769432.00, 0, NULL, '2026-10-26 10:20:15', '2026-10-26 10:20:15'),
('01a1793a-847c-7190-abfb-65d83a4dd692', '20e39474-a65a-4ca5-b57d-890040ebf0de', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', 144000000.00, 0, NULL, '2026-10-26 10:20:40', '2026-10-26 10:20:40'),
('01a1793a-d41f-72a4-8567-0c7c2d0b85bf', '5542cf94-e5bd-46af-b6b3-54952a6d4da0', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 15500000.00, 0, NULL, '2026-10-26 10:21:00', '2026-10-26 10:21:00'),
('01a1793b-99b6-739a-80c3-8eb393ce5e1f', '53402b88-500b-4d58-a421-dc0370942f23', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', 13376668.00, 0, NULL, '2026-10-26 10:21:51', '2026-10-26 10:21:51'),
('01a1793b-ff6b-70de-b597-3ea4fff23f91', '010f231d-89cd-433b-968e-9831ab0acae0', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 46059000.00, 0, NULL, '2026-10-26 10:22:17', '2026-10-26 10:22:17'),
('01a1793c-767d-71e3-ab04-29c1fc1a74b8', 'b3498af8-7715-4285-99c0-e838e553cc93', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'CREDIT', 25236667.00, 0, NULL, '2026-10-26 10:22:48', '2026-10-26 10:22:48'),
('01a1793e-e3af-709c-a6e5-15a2351aa1be', 'e6579eb2-defa-4737-a29d-3d38d6a8bbb6', '01a1792e-532a-71c5-9f47-bf4b3f756557', '01a1792e-5359-72cf-8044-02a860ff46d3', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', 'DEBIT', 676151976.00, 0, NULL, '2026-10-26 10:25:27', '2026-10-26 10:25:27');

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
('Dzt6jKeHtE6KqMArk62bFEVbu3c5RJ9UPnlmKajy', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiaFZqNTI1bWlnUVRuU2hPM2w0NFZnajhQQ213RlFUYUxmQnc4TUgwSSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MTY5OiJodHRwczovL2Rpc3Bvc2lzaS5lbmdpbmVlcmluZy11bXN1cmEuaWQvYmVuZGFoYXJhL3JlcG9ydHMvdHJpYWwtYmFsYW5jZT9wZXJpb2RfaWQ9MDFhMTc5MmUtNTMyYS03MWM1LTlmNDctYmY0YjNmNzU2NTU3JnN1Yl9wZXJpb2RfaWQ9MDFhMTc5MmUtNTM1OS03MmNmLTgwNDQtMDJhODYwZmY0NmQzIjtzOjU6InJvdXRlIjtzOjM3OiJiZW5kYWhhcmEucmVwb3J0cy50cmlhbC1iYWxhbmNlLmluZGV4Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO3M6MzY6IjAxYTE3OTJlLTUwMDYtNzI5NS04N2NlLTY5ZDBkZGMxYjBiZCI7fQ==', 1793035606),
('gzzJAdg4gl76EloACfArbFGWiOUZgOaHHh7sUMAQ', '01a1792e-5006-7295-87ce-69d0ddc1b0bd', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiMElxUk52dHZzZHVPZ3M2UVREUFlidE40QlhvNnV6cnc5aUgwVjZHNSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo0MToiaHR0cDovL2xvY2FsaG9zdDo4MDAwL2JlbmRhaGFyYS9kYXNoYm9hcmQiO31zOjk6Il9wcmV2aW91cyI7YToyOntzOjM6InVybCI7czo0MzoiaHR0cDovL2xvY2FsaG9zdDo4MDAwL2JlbmRhaGFyYS9tYXN0ZXIvY29hcyI7czo1OiJyb3V0ZSI7czoyNzoiYmVuZGFoYXJhLm1hc3Rlci5jb2FzLmluZGV4Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO3M6MzY6IjAxYTE3OTJlLTUwMDYtNzI5NS04N2NlLTY5ZDBkZGMxYjBiZCI7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjQ6ImMxYWUwOWM5ODdmNTRlYWYyZDVjMjAzMmQwZjI4Y2ViYzExZDZiMTRlNTIzNWY4Nzk3ZTFjNWI2ZDA2MDJjYzIiO30=', 1793034746),
('SfSwJ4QYfo23e86pDaKzTZY4nLtneXVoU5FW0SuZ', NULL, '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiNG1aNWxaTW92RzdzTTlRSnBSTjFIWUpNSUk0TllKVFZGOUlIZmM2NCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo1NDoiaHR0cHM6Ly9kaXNwb3Npc2kuZW5naW5lZXJpbmctdW1zdXJhLmlkL3VzZXIvZGFzaGJvYXJkIjt9czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDU6Imh0dHBzOi8vZGlzcG9zaXNpLmVuZ2luZWVyaW5nLXVtc3VyYS5pZC9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1793034848);

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
('01a1792e-5359-72cf-8044-02a860ff46d3', '01a1792e-532a-71c5-9f47-bf4b3f756557', 'Desember 2022', 'Bulan Desember 2022', '2022-12-01', '2022-12-31', 0, NULL, NULL, '2026-10-26 10:07:21', '2026-10-26 10:07:21'),
('01a1792e-538c-7153-9c05-c54696b8b603', '01a1792e-5372-735b-9610-0a8975517760', 'Januari 2023', 'Bulan Januari 2023', '2023-01-01', '2023-01-31', 0, NULL, NULL, '2026-10-26 10:07:21', '2026-10-26 10:07:21');

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
