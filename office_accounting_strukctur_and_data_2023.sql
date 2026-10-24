-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 23 Okt 2026 pada 20.33
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
('a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'ASET', 'Sumber daya ekonomi yang dimiliki perusahaan (kas, piutang, persediaan, tanah, gedung).', 1, '2026-10-18 21:13:36', '2026-10-18 21:13:36'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567891', 'KEWAJIBAN', 'Kewajiban atau hutang perusahaan kepada pihak lain (utang usaha, utang bank, obligasi).', 1, '2026-10-18 21:13:36', '2026-10-18 21:13:36'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567892', 'EKUITAS', 'Kepemilikan pemilik dalam perusahaan setelah dikurangi kewajiban (modal saham, laba ditahan).', 1, '2026-10-18 21:13:36', '2026-10-18 21:13:36'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567893', 'PENDAPATAN', 'account type representing the inflow of economic benefits from business activities.', 1, '2026-10-18 21:13:36', '2026-10-18 21:13:36'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567894', 'BEBAN', 'account type representing the outflow of economic benefits incurred in the process of generating revenue.', 1, '2026-10-18 21:13:36', '2026-10-18 21:13:36');

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
('01a152c0-fb80-7263-8028-39604ec96e74', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas (11100) pada sub periode Juli 2022 dengan jumlah 194,604,157.00', 'App\\Models\\OpeningBalance', '01a152c0-fb75-7111-8ae5-933ae535fe53', '[]', '{\"chart_of_account_id\":\"fde4c6ca-4c2c-4764-8027-19270a9e752d\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"sub_period_id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"balance_type\":\"DEBIT\",\"amount\":194604157,\"created_by\":\"01a1525d-6541-71d8-a795-c2ec45ab6289\",\"is_correction\":false,\"id\":\"01a152c0-fb75-7111-8ae5-933ae535fe53\",\"updated_at\":\"2026-10-19T06:02:21.000000Z\",\"created_at\":\"2026-10-19T06:02:21.000000Z\",\"chart_of_account\":{\"id\":\"fde4c6ca-4c2c-4764-8027-19270a9e752d\",\"code\":\"11100\",\"name\":\"Kas\",\"parent_id\":\"69670f62-db4b-4cf3-9d59-ea1782710a9a\",\"level\":\"2\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"name\":\"Juli 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\"}}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"fde4c6ca-4c2c-4764-8027-19270a9e752d\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"sub_period_id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"opening_balance\":194604157,\"debit_total\":0,\"credit_total\":0,\"current_balance\":194604157,\"last_transaction_at\":\"2026-10-19T06:02:21.000000Z\",\"id\":\"01a152c0-fb7a-71aa-bb4e-a273e09dc79a\",\"updated_at\":\"2026-10-19T06:02:21.000000Z\",\"created_at\":\"2026-10-19T06:02:21.000000Z\"}}', '2026-10-18 23:02:21', '2026-10-18 23:02:21'),
('01a152c1-4415-704c-8d0d-a516bacdcbbb', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas Ditangan (11110) pada sub periode Juli 2022 dengan jumlah 4,983,047.00', 'App\\Models\\OpeningBalance', '01a152c1-43ef-7094-955b-a6daff8f6e3e', '[]', '{\"chart_of_account_id\":\"a63a0d86-6c19-415e-a12c-16e8a8399fda\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"sub_period_id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"balance_type\":\"DEBIT\",\"amount\":4983047,\"created_by\":\"01a1525d-6541-71d8-a795-c2ec45ab6289\",\"is_correction\":false,\"id\":\"01a152c1-43ef-7094-955b-a6daff8f6e3e\",\"updated_at\":\"2026-10-19T06:02:39.000000Z\",\"created_at\":\"2026-10-19T06:02:39.000000Z\",\"chart_of_account\":{\"id\":\"a63a0d86-6c19-415e-a12c-16e8a8399fda\",\"code\":\"11110\",\"name\":\"Kas Ditangan\",\"parent_id\":\"fde4c6ca-4c2c-4764-8027-19270a9e752d\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"name\":\"Juli 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\"}}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"a63a0d86-6c19-415e-a12c-16e8a8399fda\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"sub_period_id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"opening_balance\":4983047,\"debit_total\":0,\"credit_total\":0,\"current_balance\":4983047,\"last_transaction_at\":\"2026-10-19T06:02:40.000000Z\",\"id\":\"01a152c1-4406-73be-b7f0-d1de8925aee2\",\"updated_at\":\"2026-10-19T06:02:40.000000Z\",\"created_at\":\"2026-10-19T06:02:40.000000Z\"}}', '2026-10-18 23:02:40', '2026-10-18 23:02:40'),
('01a152c1-b14f-7083-b4d1-749e6d764d0d', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas di Bank Jatim (11120) pada sub periode Juli 2022 dengan jumlah 405,484,747.00', 'App\\Models\\OpeningBalance', '01a152c1-b144-73f9-b861-2ea2971692d0', '[]', '{\"chart_of_account_id\":\"07273ff4-96b4-4756-8f70-a34e66bb36d0\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"sub_period_id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"balance_type\":\"DEBIT\",\"amount\":405484747,\"created_by\":\"01a1525d-6541-71d8-a795-c2ec45ab6289\",\"is_correction\":false,\"id\":\"01a152c1-b144-73f9-b861-2ea2971692d0\",\"updated_at\":\"2026-10-19T06:03:07.000000Z\",\"created_at\":\"2026-10-19T06:03:07.000000Z\",\"chart_of_account\":{\"id\":\"07273ff4-96b4-4756-8f70-a34e66bb36d0\",\"code\":\"11120\",\"name\":\"Kas di Bank Jatim\",\"parent_id\":\"fde4c6ca-4c2c-4764-8027-19270a9e752d\",\"level\":\"3\",\"order\":\"2\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"name\":\"Juli 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\"}}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"07273ff4-96b4-4756-8f70-a34e66bb36d0\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"sub_period_id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"opening_balance\":405484747,\"debit_total\":0,\"credit_total\":0,\"current_balance\":405484747,\"last_transaction_at\":\"2026-10-19T06:03:07.000000Z\",\"id\":\"01a152c1-b149-7325-aa9b-84e0abdc11f0\",\"updated_at\":\"2026-10-19T06:03:07.000000Z\",\"created_at\":\"2026-10-19T06:03:07.000000Z\"}}', '2026-10-18 23:03:07', '2026-10-18 23:03:07'),
('01a152c2-19cf-727b-8c9c-dc8d6cfba04f', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas di Bank Jatim Dr. Soetomo (11130) pada sub periode Juli 2022 dengan jumlah 1,156,982,563.00', 'App\\Models\\OpeningBalance', '01a152c2-19c1-7094-aae3-df9c922c1a58', '[]', '{\"chart_of_account_id\":\"217611bd-73a7-48d8-be5e-9b67041b0093\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"sub_period_id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"balance_type\":\"DEBIT\",\"amount\":1156982563,\"created_by\":\"01a1525d-6541-71d8-a795-c2ec45ab6289\",\"is_correction\":false,\"id\":\"01a152c2-19c1-7094-aae3-df9c922c1a58\",\"updated_at\":\"2026-10-19T06:03:34.000000Z\",\"created_at\":\"2026-10-19T06:03:34.000000Z\",\"chart_of_account\":{\"id\":\"217611bd-73a7-48d8-be5e-9b67041b0093\",\"code\":\"11130\",\"name\":\"Kas di Bank Jatim Dr. Soetomo\",\"parent_id\":\"fde4c6ca-4c2c-4764-8027-19270a9e752d\",\"level\":\"3\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"name\":\"Juli 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\"}}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"217611bd-73a7-48d8-be5e-9b67041b0093\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"sub_period_id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"opening_balance\":1156982563,\"debit_total\":0,\"credit_total\":0,\"current_balance\":1156982563,\"last_transaction_at\":\"2026-10-19T06:03:34.000000Z\",\"id\":\"01a152c2-19c6-7247-8a97-0d71edfdf3fa\",\"updated_at\":\"2026-10-19T06:03:34.000000Z\",\"created_at\":\"2026-10-19T06:03:34.000000Z\"}}', '2026-10-18 23:03:34', '2026-10-18 23:03:34'),
('01a152c2-8f9b-71ee-91c2-bfd096d5ff65', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas di Bank Bukopin Syariah (11140) pada sub periode Juli 2022 dengan jumlah 377,940,865.00', 'App\\Models\\OpeningBalance', '01a152c2-8f8a-7239-b2ca-4d74c59c8261', '[]', '{\"chart_of_account_id\":\"a3654a7f-7b1e-4982-92bd-51bc3b688329\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"sub_period_id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"balance_type\":\"DEBIT\",\"amount\":377940865,\"created_by\":\"01a1525d-6541-71d8-a795-c2ec45ab6289\",\"is_correction\":false,\"id\":\"01a152c2-8f8a-7239-b2ca-4d74c59c8261\",\"updated_at\":\"2026-10-19T06:04:04.000000Z\",\"created_at\":\"2026-10-19T06:04:04.000000Z\",\"chart_of_account\":{\"id\":\"a3654a7f-7b1e-4982-92bd-51bc3b688329\",\"code\":\"11140\",\"name\":\"Kas di Bank Bukopin Syariah\",\"parent_id\":\"fde4c6ca-4c2c-4764-8027-19270a9e752d\",\"level\":\"3\",\"order\":\"4\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"name\":\"Juli 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\"}}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"a3654a7f-7b1e-4982-92bd-51bc3b688329\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"sub_period_id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"opening_balance\":377940865,\"debit_total\":0,\"credit_total\":0,\"current_balance\":377940865,\"last_transaction_at\":\"2026-10-19T06:04:04.000000Z\",\"id\":\"01a152c2-8f93-73e4-8d1c-10c02581507b\",\"updated_at\":\"2026-10-19T06:04:04.000000Z\",\"created_at\":\"2026-10-19T06:04:04.000000Z\"}}', '2026-10-18 23:04:04', '2026-10-18 23:04:04'),
('01a152c3-0233-7095-ab37-31fe73c78c7e', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Piutang Karyawan (11300) pada sub periode Juli 2022 dengan jumlah 1,800,000.00', 'App\\Models\\OpeningBalance', '01a152c3-021d-70c0-b4f1-bedea99e8736', '[]', '{\"chart_of_account_id\":\"54a2c8f7-8bf2-4baf-a30e-52863c7b15db\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"sub_period_id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"balance_type\":\"DEBIT\",\"amount\":1800000,\"created_by\":\"01a1525d-6541-71d8-a795-c2ec45ab6289\",\"is_correction\":false,\"id\":\"01a152c3-021d-70c0-b4f1-bedea99e8736\",\"updated_at\":\"2026-10-19T06:04:34.000000Z\",\"created_at\":\"2026-10-19T06:04:34.000000Z\",\"chart_of_account\":{\"id\":\"54a2c8f7-8bf2-4baf-a30e-52863c7b15db\",\"code\":\"11300\",\"name\":\"Piutang Karyawan\",\"parent_id\":\"69670f62-db4b-4cf3-9d59-ea1782710a9a\",\"level\":\"2\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"name\":\"Juli 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\"}}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"54a2c8f7-8bf2-4baf-a30e-52863c7b15db\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"sub_period_id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"opening_balance\":1800000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":1800000,\"last_transaction_at\":\"2026-10-19T06:04:34.000000Z\",\"id\":\"01a152c3-0224-73ee-95c3-655e3e7a2110\",\"updated_at\":\"2026-10-19T06:04:34.000000Z\",\"created_at\":\"2026-10-19T06:04:34.000000Z\"}}', '2026-10-18 23:04:34', '2026-10-18 23:04:34'),
('01a152c3-7252-7102-887c-838950a419f2', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Piutang Lainnya (11400) pada sub periode Juli 2022 dengan jumlah 921,735,276.00', 'App\\Models\\OpeningBalance', '01a152c3-7246-7366-82aa-958464bd6b50', '[]', '{\"chart_of_account_id\":\"3c63e3d3-31df-40ee-a780-b36f628c1b3e\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"sub_period_id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"balance_type\":\"DEBIT\",\"amount\":921735276,\"created_by\":\"01a1525d-6541-71d8-a795-c2ec45ab6289\",\"is_correction\":false,\"id\":\"01a152c3-7246-7366-82aa-958464bd6b50\",\"updated_at\":\"2026-10-19T06:05:02.000000Z\",\"created_at\":\"2026-10-19T06:05:02.000000Z\",\"chart_of_account\":{\"id\":\"3c63e3d3-31df-40ee-a780-b36f628c1b3e\",\"code\":\"11400\",\"name\":\"Piutang Lainnya\",\"parent_id\":\"69670f62-db4b-4cf3-9d59-ea1782710a9a\",\"level\":\"2\",\"order\":\"4\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"name\":\"Juli 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\"}}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"3c63e3d3-31df-40ee-a780-b36f628c1b3e\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"sub_period_id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"opening_balance\":921735276,\"debit_total\":0,\"credit_total\":0,\"current_balance\":921735276,\"last_transaction_at\":\"2026-10-19T06:05:02.000000Z\",\"id\":\"01a152c3-724c-702f-8963-b45a9313c57a\",\"updated_at\":\"2026-10-19T06:05:02.000000Z\",\"created_at\":\"2026-10-19T06:05:02.000000Z\"}}', '2026-10-18 23:05:02', '2026-10-18 23:05:02'),
('01a152c3-dd1d-71c6-90be-08512bc4a6e8', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kendaraan (12300) pada sub periode Juli 2022 dengan jumlah 460,769,432.00', 'App\\Models\\OpeningBalance', '01a152c3-dd07-720b-9c79-67be7b76bfea', '[]', '{\"chart_of_account_id\":\"e51f3483-8b24-4b95-bcb7-56c47e85456d\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"sub_period_id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"balance_type\":\"DEBIT\",\"amount\":460769432,\"created_by\":\"01a1525d-6541-71d8-a795-c2ec45ab6289\",\"is_correction\":false,\"id\":\"01a152c3-dd07-720b-9c79-67be7b76bfea\",\"updated_at\":\"2026-10-19T06:05:30.000000Z\",\"created_at\":\"2026-10-19T06:05:30.000000Z\",\"chart_of_account\":{\"id\":\"e51f3483-8b24-4b95-bcb7-56c47e85456d\",\"code\":\"12300\",\"name\":\"Kendaraan\",\"parent_id\":\"7265dbca-563d-4f78-9251-f55930a8a93a\",\"level\":\"2\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-19T04:13:37.000000Z\",\"updated_at\":\"2026-10-19T04:13:37.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"name\":\"Juli 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\"}}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"e51f3483-8b24-4b95-bcb7-56c47e85456d\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"sub_period_id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"opening_balance\":460769432,\"debit_total\":0,\"credit_total\":0,\"current_balance\":460769432,\"last_transaction_at\":\"2026-10-19T06:05:30.000000Z\",\"id\":\"01a152c3-dd10-7296-8400-f4ae98c3797e\",\"updated_at\":\"2026-10-19T06:05:30.000000Z\",\"created_at\":\"2026-10-19T06:05:30.000000Z\"}}', '2026-10-18 23:05:30', '2026-10-18 23:05:30'),
('01a152c4-5e73-709e-bbdd-3b43833bcd98', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Akumulasi Depresiasi Kendaraan (12310) pada sub periode Juli 2022 dengan jumlah 144,000,000.00', 'App\\Models\\OpeningBalance', '01a152c4-5e64-72e8-863a-49c10267df43', '[]', '{\"chart_of_account_id\":\"5f5c44e2-728d-4fd5-bb5d-431361a7891c\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"sub_period_id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"balance_type\":\"CREDIT\",\"amount\":144000000,\"created_by\":\"01a1525d-6541-71d8-a795-c2ec45ab6289\",\"is_correction\":false,\"id\":\"01a152c4-5e64-72e8-863a-49c10267df43\",\"updated_at\":\"2026-10-19T06:06:03.000000Z\",\"created_at\":\"2026-10-19T06:06:03.000000Z\",\"chart_of_account\":{\"id\":\"5f5c44e2-728d-4fd5-bb5d-431361a7891c\",\"code\":\"12310\",\"name\":\"Akumulasi Depresiasi Kendaraan\",\"parent_id\":\"e51f3483-8b24-4b95-bcb7-56c47e85456d\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-19T04:13:37.000000Z\",\"updated_at\":\"2026-10-19T04:13:37.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"name\":\"Juli 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\"}}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"5f5c44e2-728d-4fd5-bb5d-431361a7891c\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"sub_period_id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"opening_balance\":144000000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":144000000,\"last_transaction_at\":\"2026-10-19T06:06:03.000000Z\",\"id\":\"01a152c4-5e6b-708f-9f08-b9707e6152de\",\"updated_at\":\"2026-10-19T06:06:03.000000Z\",\"created_at\":\"2026-10-19T06:06:03.000000Z\"}}', '2026-10-18 23:06:03', '2026-10-18 23:06:03'),
('01a152c4-d171-7047-aa02-e20d9b37588c', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Meubel (12400) pada sub periode Juli 2022 dengan jumlah 15,500,000.00', 'App\\Models\\OpeningBalance', '01a152c4-d163-73bd-9860-93a4d98752b5', '[]', '{\"chart_of_account_id\":\"b22b30bd-f081-4d6d-bb12-1b9d39238239\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"sub_period_id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"balance_type\":\"DEBIT\",\"amount\":15500000,\"created_by\":\"01a1525d-6541-71d8-a795-c2ec45ab6289\",\"is_correction\":false,\"id\":\"01a152c4-d163-73bd-9860-93a4d98752b5\",\"updated_at\":\"2026-10-19T06:06:32.000000Z\",\"created_at\":\"2026-10-19T06:06:32.000000Z\",\"chart_of_account\":{\"id\":\"b22b30bd-f081-4d6d-bb12-1b9d39238239\",\"code\":\"12400\",\"name\":\"Meubel\",\"parent_id\":\"7265dbca-563d-4f78-9251-f55930a8a93a\",\"level\":\"2\",\"order\":\"4\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-19T04:13:37.000000Z\",\"updated_at\":\"2026-10-19T04:13:37.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"name\":\"Juli 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\"}}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"b22b30bd-f081-4d6d-bb12-1b9d39238239\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"sub_period_id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"opening_balance\":15500000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":15500000,\"last_transaction_at\":\"2026-10-19T06:06:32.000000Z\",\"id\":\"01a152c4-d16a-7372-91c4-0185a241a45b\",\"updated_at\":\"2026-10-19T06:06:32.000000Z\",\"created_at\":\"2026-10-19T06:06:32.000000Z\"}}', '2026-10-18 23:06:32', '2026-10-18 23:06:32'),
('01a152c5-2149-721c-9cdc-f76848c92ae0', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Akumulasi Depresiasi Meubel (12410) pada sub periode Juli 2022 dengan jumlah 13,376,668.00', 'App\\Models\\OpeningBalance', '01a152c5-2131-735b-8bdd-dd05ebd68c40', '[]', '{\"chart_of_account_id\":\"757cde74-832b-4164-97be-82b78afb6b9f\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"sub_period_id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"balance_type\":\"CREDIT\",\"amount\":13376668,\"created_by\":\"01a1525d-6541-71d8-a795-c2ec45ab6289\",\"is_correction\":false,\"id\":\"01a152c5-2131-735b-8bdd-dd05ebd68c40\",\"updated_at\":\"2026-10-19T06:06:53.000000Z\",\"created_at\":\"2026-10-19T06:06:53.000000Z\",\"chart_of_account\":{\"id\":\"757cde74-832b-4164-97be-82b78afb6b9f\",\"code\":\"12410\",\"name\":\"Akumulasi Depresiasi Meubel\",\"parent_id\":\"b22b30bd-f081-4d6d-bb12-1b9d39238239\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-19T04:13:37.000000Z\",\"updated_at\":\"2026-10-19T04:13:37.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"name\":\"Juli 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\"}}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"757cde74-832b-4164-97be-82b78afb6b9f\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"sub_period_id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"opening_balance\":13376668,\"debit_total\":0,\"credit_total\":0,\"current_balance\":13376668,\"last_transaction_at\":\"2026-10-19T06:06:53.000000Z\",\"id\":\"01a152c5-213b-70de-b770-9411145077f6\",\"updated_at\":\"2026-10-19T06:06:53.000000Z\",\"created_at\":\"2026-10-19T06:06:53.000000Z\"}}', '2026-10-18 23:06:53', '2026-10-18 23:06:53'),
('01a152c5-7a47-7209-b3c0-f2daf693c8cb', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Peralatan Kantor (12500) pada sub periode Juli 2022 dengan jumlah 46,059,000.00', 'App\\Models\\OpeningBalance', '01a152c5-7a36-71ae-8a39-221eed4deff4', '[]', '{\"chart_of_account_id\":\"0f9579c0-6cc3-4458-aa0b-f9a15acd9578\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"sub_period_id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"balance_type\":\"DEBIT\",\"amount\":46059000,\"created_by\":\"01a1525d-6541-71d8-a795-c2ec45ab6289\",\"is_correction\":false,\"id\":\"01a152c5-7a36-71ae-8a39-221eed4deff4\",\"updated_at\":\"2026-10-19T06:07:16.000000Z\",\"created_at\":\"2026-10-19T06:07:16.000000Z\",\"chart_of_account\":{\"id\":\"0f9579c0-6cc3-4458-aa0b-f9a15acd9578\",\"code\":\"12500\",\"name\":\"Peralatan Kantor\",\"parent_id\":\"7265dbca-563d-4f78-9251-f55930a8a93a\",\"level\":\"2\",\"order\":\"5\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-19T04:13:37.000000Z\",\"updated_at\":\"2026-10-19T04:13:37.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"name\":\"Juli 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\"}}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"0f9579c0-6cc3-4458-aa0b-f9a15acd9578\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"sub_period_id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"opening_balance\":46059000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":46059000,\"last_transaction_at\":\"2026-10-19T06:07:16.000000Z\",\"id\":\"01a152c5-7a3e-737a-bbc4-cafc089154b2\",\"updated_at\":\"2026-10-19T06:07:16.000000Z\",\"created_at\":\"2026-10-19T06:07:16.000000Z\"}}', '2026-10-18 23:07:16', '2026-10-18 23:07:16'),
('01a152c5-d512-7269-8893-30766bc0d727', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Akumulasi Depresiasi Peralatan Kantor (12510) pada sub periode Juli 2022 dengan jumlah 25,236,667.00', 'App\\Models\\OpeningBalance', '01a152c5-d504-70e7-b97b-277144cc634a', '[]', '{\"chart_of_account_id\":\"902753ad-a0f2-4506-bb23-e77b2fab6f32\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"sub_period_id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"balance_type\":\"CREDIT\",\"amount\":25236667,\"created_by\":\"01a1525d-6541-71d8-a795-c2ec45ab6289\",\"is_correction\":false,\"id\":\"01a152c5-d504-70e7-b97b-277144cc634a\",\"updated_at\":\"2026-10-19T06:07:39.000000Z\",\"created_at\":\"2026-10-19T06:07:39.000000Z\",\"chart_of_account\":{\"id\":\"902753ad-a0f2-4506-bb23-e77b2fab6f32\",\"code\":\"12510\",\"name\":\"Akumulasi Depresiasi Peralatan Kantor\",\"parent_id\":\"0f9579c0-6cc3-4458-aa0b-f9a15acd9578\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-19T04:13:37.000000Z\",\"updated_at\":\"2026-10-19T04:13:37.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"name\":\"Juli 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\"}}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"902753ad-a0f2-4506-bb23-e77b2fab6f32\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"sub_period_id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"opening_balance\":25236667,\"debit_total\":0,\"credit_total\":0,\"current_balance\":25236667,\"last_transaction_at\":\"2026-10-19T06:07:39.000000Z\",\"id\":\"01a152c5-d50a-7385-8ff5-97b720bc8f51\",\"updated_at\":\"2026-10-19T06:07:39.000000Z\",\"created_at\":\"2026-10-19T06:07:39.000000Z\"}}', '2026-10-18 23:07:39', '2026-10-18 23:07:39'),
('01a152c6-80e0-72f1-b0ce-c20931862d18', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Modal Tetap (31100) pada sub periode Juli 2022 dengan jumlah 339,715,097.00', 'App\\Models\\OpeningBalance', '01a152c6-80cc-723f-8ffb-964debf01ba9', '[]', '{\"chart_of_account_id\":\"df8898d0-483f-41a2-8d75-e107da9959ed\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"sub_period_id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"balance_type\":\"CREDIT\",\"amount\":339715097,\"created_by\":\"01a1525d-6541-71d8-a795-c2ec45ab6289\",\"is_correction\":false,\"id\":\"01a152c6-80cc-723f-8ffb-964debf01ba9\",\"updated_at\":\"2026-10-19T06:08:23.000000Z\",\"created_at\":\"2026-10-19T06:08:23.000000Z\",\"chart_of_account\":{\"id\":\"df8898d0-483f-41a2-8d75-e107da9959ed\",\"code\":\"31100\",\"name\":\"Modal Tetap\",\"parent_id\":\"c3421138-08a8-4e81-a760-88484c7e689d\",\"level\":\"2\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567892\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-19T04:13:38.000000Z\",\"updated_at\":\"2026-10-19T04:13:38.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"name\":\"Juli 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\"}}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"df8898d0-483f-41a2-8d75-e107da9959ed\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"sub_period_id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"opening_balance\":339715097,\"debit_total\":0,\"credit_total\":0,\"current_balance\":339715097,\"last_transaction_at\":\"2026-10-19T06:08:23.000000Z\",\"id\":\"01a152c6-80d4-7296-ad3a-f8bf223fc952\",\"updated_at\":\"2026-10-19T06:08:23.000000Z\",\"created_at\":\"2026-10-19T06:08:23.000000Z\"}}', '2026-10-18 23:08:23', '2026-10-18 23:08:23'),
('01a152c6-dbbb-734a-95cd-3a145e1c410c', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Modal Lancar (31200) pada sub periode Juli 2022 dengan jumlah 368,679,944.00', 'App\\Models\\OpeningBalance', '01a152c6-dbac-7080-bc84-7aa123b54ec0', '[]', '{\"chart_of_account_id\":\"ea8c6555-0f32-4df4-b036-5c92a59dc58a\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"sub_period_id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"balance_type\":\"CREDIT\",\"amount\":368679944,\"created_by\":\"01a1525d-6541-71d8-a795-c2ec45ab6289\",\"is_correction\":false,\"id\":\"01a152c6-dbac-7080-bc84-7aa123b54ec0\",\"updated_at\":\"2026-10-19T06:08:46.000000Z\",\"created_at\":\"2026-10-19T06:08:46.000000Z\",\"chart_of_account\":{\"id\":\"ea8c6555-0f32-4df4-b036-5c92a59dc58a\",\"code\":\"31200\",\"name\":\"Modal Lancar\",\"parent_id\":\"c3421138-08a8-4e81-a760-88484c7e689d\",\"level\":\"2\",\"order\":\"2\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567892\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-19T04:13:38.000000Z\",\"updated_at\":\"2026-10-19T04:13:38.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"name\":\"Juli 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\"}}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"ea8c6555-0f32-4df4-b036-5c92a59dc58a\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"sub_period_id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"opening_balance\":368679944,\"debit_total\":0,\"credit_total\":0,\"current_balance\":368679944,\"last_transaction_at\":\"2026-10-19T06:08:46.000000Z\",\"id\":\"01a152c6-dbb4-73ae-9a67-bec3cf4e0479\",\"updated_at\":\"2026-10-19T06:08:46.000000Z\",\"created_at\":\"2026-10-19T06:08:46.000000Z\"}}', '2026-10-18 23:08:46', '2026-10-18 23:08:46'),
('01a152c7-c8e0-720f-a114-8f51b0bf71cc', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Selisih Lebih/Kurang (31300) pada sub periode Juli 2022 dengan jumlah 2,694,850,711.00', 'App\\Models\\OpeningBalance', '01a152c7-c8d1-71d0-aba3-71cf1dbd1f9f', '[]', '{\"chart_of_account_id\":\"14dc35fc-8cf0-47f2-b41f-55de875caf32\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"sub_period_id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"balance_type\":\"CREDIT\",\"amount\":2694850711,\"created_by\":\"01a1525d-6541-71d8-a795-c2ec45ab6289\",\"is_correction\":false,\"id\":\"01a152c7-c8d1-71d0-aba3-71cf1dbd1f9f\",\"updated_at\":\"2026-10-19T06:09:47.000000Z\",\"created_at\":\"2026-10-19T06:09:47.000000Z\",\"chart_of_account\":{\"id\":\"14dc35fc-8cf0-47f2-b41f-55de875caf32\",\"code\":\"31300\",\"name\":\"Selisih Lebih\\/Kurang\",\"parent_id\":\"c3421138-08a8-4e81-a760-88484c7e689d\",\"level\":\"2\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567892\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-19T04:13:38.000000Z\",\"updated_at\":\"2026-10-19T04:13:38.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"name\":\"Juli 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\"}}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"14dc35fc-8cf0-47f2-b41f-55de875caf32\",\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"sub_period_id\":\"01a1525d-69d6-7254-8a66-6c28c53928d8\",\"opening_balance\":2694850711,\"debit_total\":0,\"credit_total\":0,\"current_balance\":2694850711,\"last_transaction_at\":\"2026-10-19T06:09:47.000000Z\",\"id\":\"01a152c7-c8d8-7134-9e39-d4a70f72edfd\",\"updated_at\":\"2026-10-19T06:09:47.000000Z\",\"created_at\":\"2026-10-19T06:09:47.000000Z\"}}', '2026-10-18 23:09:47', '2026-10-18 23:09:47'),
('01a152c8-3614-70e0-920c-467acc6d61c1', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'closed', 'SUB_PERIOD', 'Sub periode Juli 2022 berhasil ditutup.', 'App\\Models\\SubPeriod', '01a1525d-69d6-7254-8a66-6c28c53928d8', '{\"is_closed\":false}', '{\"is_closed\":true}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"period_id\":\"01a1525d-6938-70aa-ab21-1653fea3792a\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_active\":null}', '2026-10-18 23:10:15', '2026-10-18 23:10:15'),
('01a152ca-72c2-73c9-a466-5d8145f46d1f', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas (11100) pada sub periode Januari 2023 dengan jumlah 194,604,157.00', 'App\\Models\\OpeningBalance', '01a152ca-72aa-71e3-91b9-aaa63071421d', '[]', '{\"chart_of_account_id\":\"fde4c6ca-4c2c-4764-8027-19270a9e752d\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"balance_type\":\"DEBIT\",\"amount\":194604157,\"created_by\":\"01a1525d-6541-71d8-a795-c2ec45ab6289\",\"is_correction\":false,\"id\":\"01a152ca-72aa-71e3-91b9-aaa63071421d\",\"updated_at\":\"2026-10-19T06:12:41.000000Z\",\"created_at\":\"2026-10-19T06:12:41.000000Z\",\"chart_of_account\":{\"id\":\"fde4c6ca-4c2c-4764-8027-19270a9e752d\",\"code\":\"11100\",\"name\":\"Kas\",\"parent_id\":\"69670f62-db4b-4cf3-9d59-ea1782710a9a\",\"level\":\"2\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\"}}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"fde4c6ca-4c2c-4764-8027-19270a9e752d\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"opening_balance\":194604157,\"debit_total\":0,\"credit_total\":0,\"current_balance\":194604157,\"last_transaction_at\":\"2026-10-19T06:12:41.000000Z\",\"id\":\"01a152ca-72b3-7137-8ad7-86c5f17a3e91\",\"updated_at\":\"2026-10-19T06:12:41.000000Z\",\"created_at\":\"2026-10-19T06:12:41.000000Z\"}}', '2026-10-18 23:12:41', '2026-10-18 23:12:41'),
('01a152ca-ab21-7163-aa9d-d66f15f37daf', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas Ditangan (11110) pada sub periode Januari 2023 dengan jumlah 4,983,047.00', 'App\\Models\\OpeningBalance', '01a152ca-ab11-704a-abc0-c31c4fe90383', '[]', '{\"chart_of_account_id\":\"a63a0d86-6c19-415e-a12c-16e8a8399fda\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"balance_type\":\"DEBIT\",\"amount\":4983047,\"created_by\":\"01a1525d-6541-71d8-a795-c2ec45ab6289\",\"is_correction\":false,\"id\":\"01a152ca-ab11-704a-abc0-c31c4fe90383\",\"updated_at\":\"2026-10-19T06:12:56.000000Z\",\"created_at\":\"2026-10-19T06:12:56.000000Z\",\"chart_of_account\":{\"id\":\"a63a0d86-6c19-415e-a12c-16e8a8399fda\",\"code\":\"11110\",\"name\":\"Kas Ditangan\",\"parent_id\":\"fde4c6ca-4c2c-4764-8027-19270a9e752d\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\"}}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"a63a0d86-6c19-415e-a12c-16e8a8399fda\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"opening_balance\":4983047,\"debit_total\":0,\"credit_total\":0,\"current_balance\":4983047,\"last_transaction_at\":\"2026-10-19T06:12:56.000000Z\",\"id\":\"01a152ca-ab18-716b-8e10-802da61946b7\",\"updated_at\":\"2026-10-19T06:12:56.000000Z\",\"created_at\":\"2026-10-19T06:12:56.000000Z\"}}', '2026-10-18 23:12:56', '2026-10-18 23:12:56'),
('01a152ca-e6b1-702b-abec-8025176582bc', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas di Bank Jatim (11120) pada sub periode Januari 2023 dengan jumlah 405,484,747.00', 'App\\Models\\OpeningBalance', '01a152ca-e697-7308-a8d2-90c28e10b390', '[]', '{\"chart_of_account_id\":\"07273ff4-96b4-4756-8f70-a34e66bb36d0\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"balance_type\":\"DEBIT\",\"amount\":405484747,\"created_by\":\"01a1525d-6541-71d8-a795-c2ec45ab6289\",\"is_correction\":false,\"id\":\"01a152ca-e697-7308-a8d2-90c28e10b390\",\"updated_at\":\"2026-10-19T06:13:11.000000Z\",\"created_at\":\"2026-10-19T06:13:11.000000Z\",\"chart_of_account\":{\"id\":\"07273ff4-96b4-4756-8f70-a34e66bb36d0\",\"code\":\"11120\",\"name\":\"Kas di Bank Jatim\",\"parent_id\":\"fde4c6ca-4c2c-4764-8027-19270a9e752d\",\"level\":\"3\",\"order\":\"2\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\"}}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"07273ff4-96b4-4756-8f70-a34e66bb36d0\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"opening_balance\":405484747,\"debit_total\":0,\"credit_total\":0,\"current_balance\":405484747,\"last_transaction_at\":\"2026-10-19T06:13:11.000000Z\",\"id\":\"01a152ca-e6a3-7080-97a4-c14539af3224\",\"updated_at\":\"2026-10-19T06:13:11.000000Z\",\"created_at\":\"2026-10-19T06:13:11.000000Z\"}}', '2026-10-18 23:13:11', '2026-10-18 23:13:11'),
('01a152cb-23f3-70e9-8470-b2a112ee1cfd', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas di Bank Jatim Dr. Soetomo (11130) pada sub periode Januari 2023 dengan jumlah 1,156,982,563.00', 'App\\Models\\OpeningBalance', '01a152cb-23df-7281-a66d-ed70ceaa2cd9', '[]', '{\"chart_of_account_id\":\"217611bd-73a7-48d8-be5e-9b67041b0093\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"balance_type\":\"DEBIT\",\"amount\":1156982563,\"created_by\":\"01a1525d-6541-71d8-a795-c2ec45ab6289\",\"is_correction\":false,\"id\":\"01a152cb-23df-7281-a66d-ed70ceaa2cd9\",\"updated_at\":\"2026-10-19T06:13:27.000000Z\",\"created_at\":\"2026-10-19T06:13:27.000000Z\",\"chart_of_account\":{\"id\":\"217611bd-73a7-48d8-be5e-9b67041b0093\",\"code\":\"11130\",\"name\":\"Kas di Bank Jatim Dr. Soetomo\",\"parent_id\":\"fde4c6ca-4c2c-4764-8027-19270a9e752d\",\"level\":\"3\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\"}}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"217611bd-73a7-48d8-be5e-9b67041b0093\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"opening_balance\":1156982563,\"debit_total\":0,\"credit_total\":0,\"current_balance\":1156982563,\"last_transaction_at\":\"2026-10-19T06:13:27.000000Z\",\"id\":\"01a152cb-23e7-7358-ba98-57e5ef5e0cde\",\"updated_at\":\"2026-10-19T06:13:27.000000Z\",\"created_at\":\"2026-10-19T06:13:27.000000Z\"}}', '2026-10-18 23:13:27', '2026-10-18 23:13:27'),
('01a152cb-72bb-7244-b168-bd090a535a4c', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas di Bank Bukopin Syariah (11140) pada sub periode Januari 2023 dengan jumlah 377,940,865.00', 'App\\Models\\OpeningBalance', '01a152cb-7295-73c2-8cc9-0283e3fa818a', '[]', '{\"chart_of_account_id\":\"a3654a7f-7b1e-4982-92bd-51bc3b688329\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"balance_type\":\"DEBIT\",\"amount\":377940865,\"created_by\":\"01a1525d-6541-71d8-a795-c2ec45ab6289\",\"is_correction\":false,\"id\":\"01a152cb-7295-73c2-8cc9-0283e3fa818a\",\"updated_at\":\"2026-10-19T06:13:47.000000Z\",\"created_at\":\"2026-10-19T06:13:47.000000Z\",\"chart_of_account\":{\"id\":\"a3654a7f-7b1e-4982-92bd-51bc3b688329\",\"code\":\"11140\",\"name\":\"Kas di Bank Bukopin Syariah\",\"parent_id\":\"fde4c6ca-4c2c-4764-8027-19270a9e752d\",\"level\":\"3\",\"order\":\"4\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\"}}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"a3654a7f-7b1e-4982-92bd-51bc3b688329\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"opening_balance\":377940865,\"debit_total\":0,\"credit_total\":0,\"current_balance\":377940865,\"last_transaction_at\":\"2026-10-19T06:13:47.000000Z\",\"id\":\"01a152cb-72a2-731f-9f72-f272578d0664\",\"updated_at\":\"2026-10-19T06:13:47.000000Z\",\"created_at\":\"2026-10-19T06:13:47.000000Z\"}}', '2026-10-18 23:13:47', '2026-10-18 23:13:47');
INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `module`, `description`, `subject_type`, `subject_id`, `old_values`, `new_values`, `ip_address`, `user_agent`, `additional_data`, `created_at`, `updated_at`) VALUES
('01a152cb-ba68-73c5-ac76-f0361f45d641', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Piutang Karyawan (11300) pada sub periode Januari 2023 dengan jumlah 1,800,000.00', 'App\\Models\\OpeningBalance', '01a152cb-ba5d-73dd-ae63-b5ce20b8481b', '[]', '{\"chart_of_account_id\":\"54a2c8f7-8bf2-4baf-a30e-52863c7b15db\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"balance_type\":\"DEBIT\",\"amount\":1800000,\"created_by\":\"01a1525d-6541-71d8-a795-c2ec45ab6289\",\"is_correction\":false,\"id\":\"01a152cb-ba5d-73dd-ae63-b5ce20b8481b\",\"updated_at\":\"2026-10-19T06:14:05.000000Z\",\"created_at\":\"2026-10-19T06:14:05.000000Z\",\"chart_of_account\":{\"id\":\"54a2c8f7-8bf2-4baf-a30e-52863c7b15db\",\"code\":\"11300\",\"name\":\"Piutang Karyawan\",\"parent_id\":\"69670f62-db4b-4cf3-9d59-ea1782710a9a\",\"level\":\"2\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\"}}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"54a2c8f7-8bf2-4baf-a30e-52863c7b15db\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"opening_balance\":1800000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":1800000,\"last_transaction_at\":\"2026-10-19T06:14:05.000000Z\",\"id\":\"01a152cb-ba62-70f2-995b-60b139bd498f\",\"updated_at\":\"2026-10-19T06:14:05.000000Z\",\"created_at\":\"2026-10-19T06:14:05.000000Z\"}}', '2026-10-18 23:14:05', '2026-10-18 23:14:05'),
('01a152cb-f68b-7267-9f4d-295a2cb994db', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Piutang Lainnya (11400) pada sub periode Januari 2023 dengan jumlah 921,735,276.00', 'App\\Models\\OpeningBalance', '01a152cb-f67c-72cb-8833-76354a1dd3df', '[]', '{\"chart_of_account_id\":\"3c63e3d3-31df-40ee-a780-b36f628c1b3e\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"balance_type\":\"DEBIT\",\"amount\":921735276,\"created_by\":\"01a1525d-6541-71d8-a795-c2ec45ab6289\",\"is_correction\":false,\"id\":\"01a152cb-f67c-72cb-8833-76354a1dd3df\",\"updated_at\":\"2026-10-19T06:14:21.000000Z\",\"created_at\":\"2026-10-19T06:14:21.000000Z\",\"chart_of_account\":{\"id\":\"3c63e3d3-31df-40ee-a780-b36f628c1b3e\",\"code\":\"11400\",\"name\":\"Piutang Lainnya\",\"parent_id\":\"69670f62-db4b-4cf3-9d59-ea1782710a9a\",\"level\":\"2\",\"order\":\"4\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\"}}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"3c63e3d3-31df-40ee-a780-b36f628c1b3e\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"opening_balance\":921735276,\"debit_total\":0,\"credit_total\":0,\"current_balance\":921735276,\"last_transaction_at\":\"2026-10-19T06:14:21.000000Z\",\"id\":\"01a152cb-f683-72d9-845f-ae7e1c275248\",\"updated_at\":\"2026-10-19T06:14:21.000000Z\",\"created_at\":\"2026-10-19T06:14:21.000000Z\"}}', '2026-10-18 23:14:21', '2026-10-18 23:14:21'),
('01a152cc-360f-73a9-bf0b-4500ebf1571c', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kendaraan (12300) pada sub periode Januari 2023 dengan jumlah 460,769,432.00', 'App\\Models\\OpeningBalance', '01a152cc-3604-7014-a62e-862822046c50', '[]', '{\"chart_of_account_id\":\"e51f3483-8b24-4b95-bcb7-56c47e85456d\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"balance_type\":\"DEBIT\",\"amount\":460769432,\"created_by\":\"01a1525d-6541-71d8-a795-c2ec45ab6289\",\"is_correction\":false,\"id\":\"01a152cc-3604-7014-a62e-862822046c50\",\"updated_at\":\"2026-10-19T06:14:37.000000Z\",\"created_at\":\"2026-10-19T06:14:37.000000Z\",\"chart_of_account\":{\"id\":\"e51f3483-8b24-4b95-bcb7-56c47e85456d\",\"code\":\"12300\",\"name\":\"Kendaraan\",\"parent_id\":\"7265dbca-563d-4f78-9251-f55930a8a93a\",\"level\":\"2\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-19T04:13:37.000000Z\",\"updated_at\":\"2026-10-19T04:13:37.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\"}}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"e51f3483-8b24-4b95-bcb7-56c47e85456d\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"opening_balance\":460769432,\"debit_total\":0,\"credit_total\":0,\"current_balance\":460769432,\"last_transaction_at\":\"2026-10-19T06:14:37.000000Z\",\"id\":\"01a152cc-3609-7091-9ce5-aea29a93524e\",\"updated_at\":\"2026-10-19T06:14:37.000000Z\",\"created_at\":\"2026-10-19T06:14:37.000000Z\"}}', '2026-10-18 23:14:37', '2026-10-18 23:14:37'),
('01a152cc-7e9e-7161-ba23-19a14d0decb3', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Akumulasi Depresiasi Kendaraan (12310) pada sub periode Januari 2023 dengan jumlah 144,000,000.00', 'App\\Models\\OpeningBalance', '01a152cc-7e86-700b-8dfc-415a7b2755e4', '[]', '{\"chart_of_account_id\":\"5f5c44e2-728d-4fd5-bb5d-431361a7891c\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"balance_type\":\"CREDIT\",\"amount\":144000000,\"created_by\":\"01a1525d-6541-71d8-a795-c2ec45ab6289\",\"is_correction\":false,\"id\":\"01a152cc-7e86-700b-8dfc-415a7b2755e4\",\"updated_at\":\"2026-10-19T06:14:55.000000Z\",\"created_at\":\"2026-10-19T06:14:55.000000Z\",\"chart_of_account\":{\"id\":\"5f5c44e2-728d-4fd5-bb5d-431361a7891c\",\"code\":\"12310\",\"name\":\"Akumulasi Depresiasi Kendaraan\",\"parent_id\":\"e51f3483-8b24-4b95-bcb7-56c47e85456d\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-19T04:13:37.000000Z\",\"updated_at\":\"2026-10-19T04:13:37.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\"}}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"5f5c44e2-728d-4fd5-bb5d-431361a7891c\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"opening_balance\":144000000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":144000000,\"last_transaction_at\":\"2026-10-19T06:14:55.000000Z\",\"id\":\"01a152cc-7e8d-7301-ab50-ef56d577d3b0\",\"updated_at\":\"2026-10-19T06:14:55.000000Z\",\"created_at\":\"2026-10-19T06:14:55.000000Z\"}}', '2026-10-18 23:14:55', '2026-10-18 23:14:55'),
('01a152cc-b8ff-7029-8885-5bd1accbe362', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Meubel (12400) pada sub periode Januari 2023 dengan jumlah 15,500,000.00', 'App\\Models\\OpeningBalance', '01a152cc-b8ee-7220-86a6-5f73df1ef306', '[]', '{\"chart_of_account_id\":\"b22b30bd-f081-4d6d-bb12-1b9d39238239\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"balance_type\":\"DEBIT\",\"amount\":15500000,\"created_by\":\"01a1525d-6541-71d8-a795-c2ec45ab6289\",\"is_correction\":false,\"id\":\"01a152cc-b8ee-7220-86a6-5f73df1ef306\",\"updated_at\":\"2026-10-19T06:15:10.000000Z\",\"created_at\":\"2026-10-19T06:15:10.000000Z\",\"chart_of_account\":{\"id\":\"b22b30bd-f081-4d6d-bb12-1b9d39238239\",\"code\":\"12400\",\"name\":\"Meubel\",\"parent_id\":\"7265dbca-563d-4f78-9251-f55930a8a93a\",\"level\":\"2\",\"order\":\"4\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-19T04:13:37.000000Z\",\"updated_at\":\"2026-10-19T04:13:37.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\"}}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"b22b30bd-f081-4d6d-bb12-1b9d39238239\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"opening_balance\":15500000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":15500000,\"last_transaction_at\":\"2026-10-19T06:15:10.000000Z\",\"id\":\"01a152cc-b8f7-70c6-9754-568e0eb854aa\",\"updated_at\":\"2026-10-19T06:15:10.000000Z\",\"created_at\":\"2026-10-19T06:15:10.000000Z\"}}', '2026-10-18 23:15:10', '2026-10-18 23:15:10'),
('01a152cc-f57b-7162-836d-d3e824ea4b34', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Akumulasi Depresiasi Meubel (12410) pada sub periode Januari 2023 dengan jumlah 13,376,668.00', 'App\\Models\\OpeningBalance', '01a152cc-f56a-701e-998f-4533f720f470', '[]', '{\"chart_of_account_id\":\"757cde74-832b-4164-97be-82b78afb6b9f\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"balance_type\":\"CREDIT\",\"amount\":13376668,\"created_by\":\"01a1525d-6541-71d8-a795-c2ec45ab6289\",\"is_correction\":false,\"id\":\"01a152cc-f56a-701e-998f-4533f720f470\",\"updated_at\":\"2026-10-19T06:15:26.000000Z\",\"created_at\":\"2026-10-19T06:15:26.000000Z\",\"chart_of_account\":{\"id\":\"757cde74-832b-4164-97be-82b78afb6b9f\",\"code\":\"12410\",\"name\":\"Akumulasi Depresiasi Meubel\",\"parent_id\":\"b22b30bd-f081-4d6d-bb12-1b9d39238239\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-19T04:13:37.000000Z\",\"updated_at\":\"2026-10-19T04:13:37.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\"}}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"757cde74-832b-4164-97be-82b78afb6b9f\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"opening_balance\":13376668,\"debit_total\":0,\"credit_total\":0,\"current_balance\":13376668,\"last_transaction_at\":\"2026-10-19T06:15:26.000000Z\",\"id\":\"01a152cc-f572-7304-924a-2c5842f54f5d\",\"updated_at\":\"2026-10-19T06:15:26.000000Z\",\"created_at\":\"2026-10-19T06:15:26.000000Z\"}}', '2026-10-18 23:15:26', '2026-10-18 23:15:26'),
('01a152cd-2e06-738e-b209-d020bfb90e73', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Peralatan Kantor (12500) pada sub periode Januari 2023 dengan jumlah 46,059,000.00', 'App\\Models\\OpeningBalance', '01a152cd-2df0-72ad-a116-d616f12e0671', '[]', '{\"chart_of_account_id\":\"0f9579c0-6cc3-4458-aa0b-f9a15acd9578\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"balance_type\":\"DEBIT\",\"amount\":46059000,\"created_by\":\"01a1525d-6541-71d8-a795-c2ec45ab6289\",\"is_correction\":false,\"id\":\"01a152cd-2df0-72ad-a116-d616f12e0671\",\"updated_at\":\"2026-10-19T06:15:40.000000Z\",\"created_at\":\"2026-10-19T06:15:40.000000Z\",\"chart_of_account\":{\"id\":\"0f9579c0-6cc3-4458-aa0b-f9a15acd9578\",\"code\":\"12500\",\"name\":\"Peralatan Kantor\",\"parent_id\":\"7265dbca-563d-4f78-9251-f55930a8a93a\",\"level\":\"2\",\"order\":\"5\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-19T04:13:37.000000Z\",\"updated_at\":\"2026-10-19T04:13:37.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\"}}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"0f9579c0-6cc3-4458-aa0b-f9a15acd9578\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"opening_balance\":46059000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":46059000,\"last_transaction_at\":\"2026-10-19T06:15:40.000000Z\",\"id\":\"01a152cd-2df7-70c9-9dce-a7e9966e9c1c\",\"updated_at\":\"2026-10-19T06:15:40.000000Z\",\"created_at\":\"2026-10-19T06:15:40.000000Z\"}}', '2026-10-18 23:15:40', '2026-10-18 23:15:40'),
('01a152cd-6447-702b-ae24-92a3eb404841', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Akumulasi Depresiasi Peralatan Kantor (12510) pada sub periode Januari 2023 dengan jumlah 25,236,667.00', 'App\\Models\\OpeningBalance', '01a152cd-642e-7172-9209-4eda582aad2d', '[]', '{\"chart_of_account_id\":\"902753ad-a0f2-4506-bb23-e77b2fab6f32\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"balance_type\":\"CREDIT\",\"amount\":25236667,\"created_by\":\"01a1525d-6541-71d8-a795-c2ec45ab6289\",\"is_correction\":false,\"id\":\"01a152cd-642e-7172-9209-4eda582aad2d\",\"updated_at\":\"2026-10-19T06:15:54.000000Z\",\"created_at\":\"2026-10-19T06:15:54.000000Z\",\"chart_of_account\":{\"id\":\"902753ad-a0f2-4506-bb23-e77b2fab6f32\",\"code\":\"12510\",\"name\":\"Akumulasi Depresiasi Peralatan Kantor\",\"parent_id\":\"0f9579c0-6cc3-4458-aa0b-f9a15acd9578\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-19T04:13:37.000000Z\",\"updated_at\":\"2026-10-19T04:13:37.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\"}}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"902753ad-a0f2-4506-bb23-e77b2fab6f32\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"opening_balance\":25236667,\"debit_total\":0,\"credit_total\":0,\"current_balance\":25236667,\"last_transaction_at\":\"2026-10-19T06:15:54.000000Z\",\"id\":\"01a152cd-6439-7306-a041-628766a08d01\",\"updated_at\":\"2026-10-19T06:15:54.000000Z\",\"created_at\":\"2026-10-19T06:15:54.000000Z\"}}', '2026-10-18 23:15:54', '2026-10-18 23:15:54'),
('01a152cd-afd3-729a-aa9d-732ec2cbcb70', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Modal Tetap (31100) pada sub periode Januari 2023 dengan jumlah 339,715,097.00', 'App\\Models\\OpeningBalance', '01a152cd-afbf-7107-bf77-5b49e9041245', '[]', '{\"chart_of_account_id\":\"df8898d0-483f-41a2-8d75-e107da9959ed\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"balance_type\":\"CREDIT\",\"amount\":339715097,\"created_by\":\"01a1525d-6541-71d8-a795-c2ec45ab6289\",\"is_correction\":false,\"id\":\"01a152cd-afbf-7107-bf77-5b49e9041245\",\"updated_at\":\"2026-10-19T06:16:14.000000Z\",\"created_at\":\"2026-10-19T06:16:14.000000Z\",\"chart_of_account\":{\"id\":\"df8898d0-483f-41a2-8d75-e107da9959ed\",\"code\":\"31100\",\"name\":\"Modal Tetap\",\"parent_id\":\"c3421138-08a8-4e81-a760-88484c7e689d\",\"level\":\"2\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567892\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-19T04:13:38.000000Z\",\"updated_at\":\"2026-10-19T04:13:38.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\"}}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"df8898d0-483f-41a2-8d75-e107da9959ed\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"opening_balance\":339715097,\"debit_total\":0,\"credit_total\":0,\"current_balance\":339715097,\"last_transaction_at\":\"2026-10-19T06:16:14.000000Z\",\"id\":\"01a152cd-afc8-71a7-bebc-edf3e2943468\",\"updated_at\":\"2026-10-19T06:16:14.000000Z\",\"created_at\":\"2026-10-19T06:16:14.000000Z\"}}', '2026-10-18 23:16:14', '2026-10-18 23:16:14'),
('01a152cd-f8c3-7386-b253-45ea3129ba27', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Modal Lancar (31200) pada sub periode Januari 2023 dengan jumlah 368,679,944.00', 'App\\Models\\OpeningBalance', '01a152cd-f8ab-73ad-9c37-d7f5106c437d', '[]', '{\"chart_of_account_id\":\"ea8c6555-0f32-4df4-b036-5c92a59dc58a\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"balance_type\":\"CREDIT\",\"amount\":368679944,\"created_by\":\"01a1525d-6541-71d8-a795-c2ec45ab6289\",\"is_correction\":false,\"id\":\"01a152cd-f8ab-73ad-9c37-d7f5106c437d\",\"updated_at\":\"2026-10-19T06:16:32.000000Z\",\"created_at\":\"2026-10-19T06:16:32.000000Z\",\"chart_of_account\":{\"id\":\"ea8c6555-0f32-4df4-b036-5c92a59dc58a\",\"code\":\"31200\",\"name\":\"Modal Lancar\",\"parent_id\":\"c3421138-08a8-4e81-a760-88484c7e689d\",\"level\":\"2\",\"order\":\"2\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567892\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-19T04:13:38.000000Z\",\"updated_at\":\"2026-10-19T04:13:38.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\"}}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"ea8c6555-0f32-4df4-b036-5c92a59dc58a\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"opening_balance\":368679944,\"debit_total\":0,\"credit_total\":0,\"current_balance\":368679944,\"last_transaction_at\":\"2026-10-19T06:16:32.000000Z\",\"id\":\"01a152cd-f8b7-7113-9e60-6d7f462919b0\",\"updated_at\":\"2026-10-19T06:16:32.000000Z\",\"created_at\":\"2026-10-19T06:16:32.000000Z\"}}', '2026-10-18 23:16:32', '2026-10-18 23:16:32'),
('01a152ce-363a-73b8-a830-20a9206753b5', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Selisih Lebih/Kurang (31300) pada sub periode Januari 2023 dengan jumlah 2,694,850,711.00', 'App\\Models\\OpeningBalance', '01a152ce-362a-73bd-94f6-60ce7bc6aa3f', '[]', '{\"chart_of_account_id\":\"14dc35fc-8cf0-47f2-b41f-55de875caf32\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"balance_type\":\"CREDIT\",\"amount\":2694850711,\"created_by\":\"01a1525d-6541-71d8-a795-c2ec45ab6289\",\"is_correction\":false,\"id\":\"01a152ce-362a-73bd-94f6-60ce7bc6aa3f\",\"updated_at\":\"2026-10-19T06:16:48.000000Z\",\"created_at\":\"2026-10-19T06:16:48.000000Z\",\"chart_of_account\":{\"id\":\"14dc35fc-8cf0-47f2-b41f-55de875caf32\",\"code\":\"31300\",\"name\":\"Selisih Lebih\\/Kurang\",\"parent_id\":\"c3421138-08a8-4e81-a760-88484c7e689d\",\"level\":\"2\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567892\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-10-19T04:13:38.000000Z\",\"updated_at\":\"2026-10-19T04:13:38.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-10-19T04:13:36.000000Z\",\"updated_at\":\"2026-10-19T04:13:36.000000Z\"}}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"coa_balance\":{\"chart_of_account_id\":\"14dc35fc-8cf0-47f2-b41f-55de875caf32\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\",\"opening_balance\":2694850711,\"debit_total\":0,\"credit_total\":0,\"current_balance\":2694850711,\"last_transaction_at\":\"2026-10-19T06:16:48.000000Z\",\"id\":\"01a152ce-3631-7171-9c93-188979df5ad8\",\"updated_at\":\"2026-10-19T06:16:48.000000Z\",\"created_at\":\"2026-10-19T06:16:48.000000Z\"}}', '2026-10-18 23:16:48', '2026-10-18 23:16:48'),
('01a152f6-ddfe-70de-92e7-a672e5703048', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a152f6-ddcc-73b9-aee0-1ff5c8724fa9', '[]', '{\"transaction_id\":\"01a152f6-ddcc-73b9-aee0-1ff5c8724fa9\",\"transaction_number\":\"TRX-INC-20261019070112\",\"transaction_date\":\"2023-01-01T00:00:00.000000Z\",\"total_amount\":733644,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"fde4c6ca-4c2c-4764-8027-19270a9e752d\",\"position\":\"DEBIT\",\"amount\":733644,\"description\":\"Mutasi Kas Masuk\"},{\"coa_id\":\"e6db6cf4-dec7-4ac2-81f6-f14660c0c1c2\",\"position\":\"CREDIT\",\"amount\":733644,\"description\":\"Penerimaan bunga dari bank\"}]}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"INCOME\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-19 00:01:12', '2026-10-19 00:01:12'),
('01a152f6-ddff-73dd-bb63-85f210187ee7', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '01a152d2-b241-7034-936a-88d4da21bd88', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"0.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"194604157.00\"}', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":733644,\"used_balance\":\"0.00\",\"remaining_balance\":195337801}', '182.253.50.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a152f6-ddcc-73b9-aee0-1ff5c8724fa9\",\"transaction_number\":\"TRX-INC-20261019070112\",\"income_amount\":733644}', '2026-10-19 00:01:12', '2026-10-19 00:01:12'),
('01a15956-6cc5-72eb-bdba-751839dc252c', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DELETE', 'TRANSACTION_INCOME', 'Menghapus transaksi penerimaan dan berkas lampirannya.', 'App\\Models\\Transaction', '01a152f6-ddcc-73b9-aee0-1ff5c8724fa9', '{\"transaction_id\":\"01a152f6-ddcc-73b9-aee0-1ff5c8724fa9\",\"transaction_number\":\"TRX-INC-20261019070112\",\"transaction_date\":\"2023-01-01\",\"total_amount\":733644,\"description\":\"Penerimaan bunga dari bank\",\"status\":\"POSTED\"}', '[]', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"INCOME\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 05:43:18', '2026-10-20 05:43:18'),
('01a15956-6cc9-71e7-bd2b-b0d989aba64a', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna dikembalikan karena penghapusan transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '01a152d2-b241-7034-936a-88d4da21bd88', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"733644.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"195337801.00\"}', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"0.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"194604157.00\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a152f6-ddcc-73b9-aee0-1ff5c8724fa9\",\"transaction_number\":\"TRX-INC-20261019070112\"}', '2026-10-20 05:43:18', '2026-10-20 05:43:18'),
('01a15957-5e7b-7299-b8dd-c749ef1e5b9d', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a15957-5e51-7113-bb26-b2600e39d9b5', '[]', '{\"transaction_id\":\"01a15957-5e51-7113-bb26-b2600e39d9b5\",\"transaction_number\":\"TRX-INC-20261020124420\",\"transaction_date\":\"2023-01-01T00:00:00.000000Z\",\"total_amount\":733644,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"217611bd-73a7-48d8-be5e-9b67041b0093\",\"position\":\"DEBIT\",\"amount\":733644,\"description\":\"Mutasi Kas Masuk\"},{\"coa_id\":\"e6db6cf4-dec7-4ac2-81f6-f14660c0c1c2\",\"position\":\"CREDIT\",\"amount\":733644,\"description\":\"Penerimaan bunga dari bank\"}]}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"INCOME\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 05:44:20', '2026-10-20 05:44:20'),
('01a15957-5e7d-7013-83be-3653220cc022', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '01a152d4-97a6-7063-9238-f45fe20fcae4', '{\"allocated_balance\":\"1156982563.00\",\"income_balance\":\"0.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"1156982563.00\"}', '{\"allocated_balance\":\"1156982563.00\",\"income_balance\":733644,\"used_balance\":\"0.00\",\"remaining_balance\":1157716207}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a15957-5e51-7113-bb26-b2600e39d9b5\",\"transaction_number\":\"TRX-INC-20261020124420\",\"income_amount\":733644}', '2026-10-20 05:44:20', '2026-10-20 05:44:20'),
('01a15958-7d9a-71c6-be1b-958fb7f0a579', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna berkurang karena transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a152d4-97a6-7063-9238-f45fe20fcae4', '{\"allocated_balance\":\"1156982563.00\",\"income_balance\":\"733644.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"1157716207.00\"}', '{\"allocated_balance\":\"1156982563.00\",\"income_balance\":\"733644.00\",\"used_balance\":146728,\"remaining_balance\":1157569479}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a15958-7d5c-710b-96e3-c0351f316d47\",\"transaction_number\":\"TRX-EXP-20261020124533\",\"expense_amount\":146728,\"is_deficit\":false}', '2026-10-20 05:45:33', '2026-10-20 05:45:33'),
('01a15958-7d9d-724a-ba53-86824a731a92', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a15958-7d5c-710b-96e3-c0351f316d47', '[]', '{\"transaction_id\":\"01a15958-7d5c-710b-96e3-c0351f316d47\",\"transaction_number\":\"TRX-EXP-20261020124533\",\"transaction_date\":\"2023-01-01T00:00:00.000000Z\",\"total_amount\":146728,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 05:45:33', '2026-10-20 05:45:33'),
('01a15959-2c7c-73e4-a087-50d72725d863', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo akun pengeluaran bertambah penggunaannya karena transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a152d2-b241-7034-936a-88d4da21bd88', '{\"used_balance\":\"0.00\",\"remaining_balance\":\"194604157.00\"}', '{\"used_balance\":200000000,\"remaining_balance\":-5395843}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a15959-2c69-708c-b6e2-1b3d48c4dc27\",\"transaction_number\":\"TRX-EXP-20261020124618\",\"expense_amount\":200000000}', '2026-10-20 05:46:18', '2026-10-20 05:46:18'),
('01a15959-2c9e-738e-9583-360f370fc457', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna berkurang karena transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a152d4-97a6-7063-9238-f45fe20fcae4', '{\"allocated_balance\":\"1156982563.00\",\"income_balance\":\"733644.00\",\"used_balance\":\"146728.00\",\"remaining_balance\":\"1157569479.00\"}', '{\"allocated_balance\":\"1156982563.00\",\"income_balance\":\"733644.00\",\"used_balance\":200146728,\"remaining_balance\":957569479}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a15959-2c69-708c-b6e2-1b3d48c4dc27\",\"transaction_number\":\"TRX-EXP-20261020124618\",\"expense_amount\":200000000,\"is_deficit\":false}', '2026-10-20 05:46:18', '2026-10-20 05:46:18'),
('01a15959-2ca0-719d-a266-4df0e442bb1a', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a15959-2c69-708c-b6e2-1b3d48c4dc27', '[]', '{\"transaction_id\":\"01a15959-2c69-708c-b6e2-1b3d48c4dc27\",\"transaction_number\":\"TRX-EXP-20261020124618\",\"transaction_date\":\"2023-01-13T00:00:00.000000Z\",\"total_amount\":200000000,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 05:46:18', '2026-10-20 05:46:18'),
('01a1595b-af3e-7124-93b8-a8babe32996b', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna berkurang karena transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a152d4-97a6-7063-9238-f45fe20fcae4', '{\"allocated_balance\":\"1156982563.00\",\"income_balance\":\"733644.00\",\"used_balance\":\"200146728.00\",\"remaining_balance\":\"957569479.00\"}', '{\"allocated_balance\":\"1156982563.00\",\"income_balance\":\"733644.00\",\"used_balance\":200176728,\"remaining_balance\":957539479}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a1595b-ae78-71d9-98f6-657707b187f2\",\"transaction_number\":\"TRX-EXP-20261020124903\",\"expense_amount\":30000,\"is_deficit\":false}', '2026-10-20 05:49:03', '2026-10-20 05:49:03'),
('01a1595b-af41-7347-a38e-3b2b984c96b3', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a1595b-ae78-71d9-98f6-657707b187f2', '[]', '{\"transaction_id\":\"01a1595b-ae78-71d9-98f6-657707b187f2\",\"transaction_number\":\"TRX-EXP-20261020124903\",\"transaction_date\":\"2023-01-27T00:00:00.000000Z\",\"total_amount\":30000,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 05:49:03', '2026-10-20 05:49:03'),
('01a15975-b14d-709a-a420-241929831a0d', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Pengembalian saldo kas sumber karena penghapusan transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a152d4-97a6-7063-9238-f45fe20fcae4', '{\"used_balance\":\"200176728.00\",\"remaining_balance\":\"957539479.00\"}', '{\"used_balance\":176728,\"remaining_balance\":1157539479}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a15959-2c69-708c-b6e2-1b3d48c4dc27\",\"transaction_number\":\"TRX-EXP-20261020124618\",\"reverted_amount\":200000000}', '2026-10-20 06:17:27', '2026-10-20 06:17:27'),
('01a15975-b158-7113-bfb0-78508ce93989', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Pengembalian saldo akun pengeluaran karena penghapusan transaksi.', 'App\\Models\\UserAccountBalance', '01a152d2-b241-7034-936a-88d4da21bd88', '{\"used_balance\":\"200000000.00\",\"remaining_balance\":\"-5395843.00\"}', '{\"used_balance\":0,\"remaining_balance\":194604157}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a15959-2c69-708c-b6e2-1b3d48c4dc27\",\"transaction_number\":\"TRX-EXP-20261020124618\",\"reverted_amount\":\"200000000.00\"}', '2026-10-20 06:17:27', '2026-10-20 06:17:27'),
('01a15975-b176-7221-b2f7-a247c0156cc6', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DELETE', 'TRANSACTION_EXPENSE', 'Menghapus transaksi pengeluaran.', 'App\\Models\\Transaction', '01a15959-2c69-708c-b6e2-1b3d48c4dc27', '{\"transaction_id\":\"01a15959-2c69-708c-b6e2-1b3d48c4dc27\",\"transaction_number\":\"TRX-EXP-20261020124618\",\"transaction_date\":\"2023-01-13\",\"total_amount\":200000000,\"status\":\"POSTED\",\"description\":\"Pengisian kas\"}', '[]', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 06:17:27', '2026-10-20 06:17:27'),
('01a1597d-5b9a-728d-b3ba-12df249efae0', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a1597d-5b69-7290-8577-7b56a7a65052', '[]', '{\"transaction_id\":\"01a1597d-5b69-7290-8577-7b56a7a65052\",\"transaction_number\":\"TRX-INC-20261020132550\",\"transaction_date\":\"2023-01-01T00:00:00.000000Z\",\"total_amount\":1000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"217611bd-73a7-48d8-be5e-9b67041b0093\",\"position\":\"DEBIT\",\"amount\":1000000,\"description\":\"Mutasi Kas Masuk\"},{\"coa_id\":\"fde4c6ca-4c2c-4764-8027-19270a9e752d\",\"position\":\"CREDIT\",\"amount\":1000000,\"description\":\"test penerimaan dari Kas\"}]}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"INCOME\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 06:25:50', '2026-10-20 06:25:50'),
('01a1597d-5b9b-728d-9b40-67ec1d6e3c01', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '01a152d4-97a6-7063-9238-f45fe20fcae4', '{\"allocated_balance\":\"1156982563.00\",\"income_balance\":\"733644.00\",\"used_balance\":\"176728.00\",\"remaining_balance\":\"1157539479.00\"}', '{\"allocated_balance\":\"1156982563.00\",\"income_balance\":1733644,\"used_balance\":\"176728.00\",\"remaining_balance\":1158539479}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a1597d-5b69-7290-8577-7b56a7a65052\",\"transaction_number\":\"TRX-INC-20261020132550\",\"income_amount\":1000000}', '2026-10-20 06:25:50', '2026-10-20 06:25:50'),
('01a1597d-5b9c-7119-9ba3-607078c838d9', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo akun sumber berkurang karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '01a152d2-b241-7034-936a-88d4da21bd88', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"0.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"194604157.00\"}', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"0.00\",\"used_balance\":1000000,\"remaining_balance\":193604157}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a1597d-5b69-7290-8577-7b56a7a65052\",\"transaction_number\":\"TRX-INC-20261020132550\",\"deducted_amount\":1000000}', '2026-10-20 06:25:50', '2026-10-20 06:25:50'),
('01a1598a-5175-73ba-a530-b9622c758caa', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo akun pengeluaran bertambah karena transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a152d2-b241-7034-936a-88d4da21bd88', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"0.00\",\"used_balance\":\"1000000.00\",\"remaining_balance\":\"193604157.00\"}', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":200000000,\"used_balance\":\"1000000.00\",\"remaining_balance\":393604157}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a1598a-5165-7169-b7db-eedb29557d7a\",\"transaction_number\":\"TRX-EXP-20261020133959\",\"expense_amount\":200000000}', '2026-10-20 06:39:59', '2026-10-20 06:39:59'),
('01a1598a-518a-710c-ace4-932f963dd1e1', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna berkurang karena transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a152d4-97a6-7063-9238-f45fe20fcae4', '{\"allocated_balance\":\"1156982563.00\",\"income_balance\":\"1733644.00\",\"used_balance\":\"176728.00\",\"remaining_balance\":\"1158539479.00\"}', '{\"allocated_balance\":\"1156982563.00\",\"income_balance\":\"1733644.00\",\"used_balance\":200176728,\"remaining_balance\":958539479}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a1598a-5165-7169-b7db-eedb29557d7a\",\"transaction_number\":\"TRX-EXP-20261020133959\",\"expense_amount\":200000000,\"is_deficit\":false}', '2026-10-20 06:39:59', '2026-10-20 06:39:59'),
('01a1598a-518c-7038-b5b1-119181016368', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a1598a-5165-7169-b7db-eedb29557d7a', '[]', '{\"transaction_id\":\"01a1598a-5165-7169-b7db-eedb29557d7a\",\"transaction_number\":\"TRX-EXP-20261020133959\",\"transaction_date\":\"2023-01-13T00:00:00.000000Z\",\"total_amount\":200000000,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 06:39:59', '2026-10-20 06:39:59'),
('01a1598a-a9bc-70aa-b97b-9699614811c8', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DELETE', 'TRANSACTION_INCOME', 'Menghapus transaksi penerimaan dan berkas lampirannya.', 'App\\Models\\Transaction', '01a1597d-5b69-7290-8577-7b56a7a65052', '{\"transaction_id\":\"01a1597d-5b69-7290-8577-7b56a7a65052\",\"transaction_number\":\"TRX-INC-20261020132550\",\"transaction_date\":\"2023-01-01\",\"total_amount\":1000000,\"description\":\"test penerimaan dari Kas\",\"status\":\"POSTED\"}', '[]', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"INCOME\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 06:40:22', '2026-10-20 06:40:22'),
('01a1598a-a9bf-704f-98b2-0dcc422a48cb', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna dikembalikan karena penghapusan transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '01a152d4-97a6-7063-9238-f45fe20fcae4', '{\"allocated_balance\":\"1156982563.00\",\"income_balance\":\"1733644.00\",\"used_balance\":\"200176728.00\",\"remaining_balance\":\"958539479.00\"}', '{\"allocated_balance\":\"1156982563.00\",\"income_balance\":\"733644.00\",\"used_balance\":\"200176728.00\",\"remaining_balance\":\"957539479.00\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a1597d-5b69-7290-8577-7b56a7a65052\",\"transaction_number\":\"TRX-INC-20261020132550\"}', '2026-10-20 06:40:22', '2026-10-20 06:40:22'),
('01a1598a-a9c1-7079-a538-7ec504c6c14a', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo akun sumber dikembalikan karena penghapusan transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '01a152d2-b241-7034-936a-88d4da21bd88', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":\"1000000.00\",\"remaining_balance\":\"393604157.00\"}', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"394604157.00\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a1597d-5b69-7290-8577-7b56a7a65052\",\"transaction_number\":\"TRX-INC-20261020132550\"}', '2026-10-20 06:40:22', '2026-10-20 06:40:22'),
('01a1598b-538c-7272-9cde-c57aba6d583c', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Pengembalian saldo kas sumber karena penghapusan transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a152d4-97a6-7063-9238-f45fe20fcae4', '{\"allocated_balance\":\"1156982563.00\",\"income_balance\":\"733644.00\",\"used_balance\":\"200176728.00\",\"remaining_balance\":\"957539479.00\"}', '{\"allocated_balance\":\"1156982563.00\",\"income_balance\":\"733644.00\",\"used_balance\":200146728,\"remaining_balance\":957569479}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a1595b-ae78-71d9-98f6-657707b187f2\",\"transaction_number\":\"TRX-EXP-20261020124903\",\"reverted_amount\":30000}', '2026-10-20 06:41:05', '2026-10-20 06:41:05'),
('01a1598b-53ac-7345-8d7f-383cf37c830d', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DELETE', 'TRANSACTION_EXPENSE', 'Menghapus transaksi pengeluaran.', 'App\\Models\\Transaction', '01a1595b-ae78-71d9-98f6-657707b187f2', '{\"transaction_id\":\"01a1595b-ae78-71d9-98f6-657707b187f2\",\"transaction_number\":\"TRX-EXP-20261020124903\",\"transaction_date\":\"2023-01-27\",\"total_amount\":30000,\"status\":\"POSTED\",\"description\":\"Biaya Admin Giro\"}', '[]', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 06:41:05', '2026-10-20 06:41:05'),
('01a1598b-f38f-706a-83f4-3fbe3e95d6c1', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna berkurang karena transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a152d4-97a6-7063-9238-f45fe20fcae4', '{\"allocated_balance\":\"1156982563.00\",\"income_balance\":\"733644.00\",\"used_balance\":\"200146728.00\",\"remaining_balance\":\"957569479.00\"}', '{\"allocated_balance\":\"1156982563.00\",\"income_balance\":\"733644.00\",\"used_balance\":200176728,\"remaining_balance\":957539479}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a1598b-f350-70ea-a8be-344bb42ec447\",\"transaction_number\":\"TRX-EXP-20261020134146\",\"expense_amount\":30000,\"is_deficit\":false}', '2026-10-20 06:41:46', '2026-10-20 06:41:46'),
('01a1598b-f391-70b5-b8f5-a32a92b79a28', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a1598b-f350-70ea-a8be-344bb42ec447', '[]', '{\"transaction_id\":\"01a1598b-f350-70ea-a8be-344bb42ec447\",\"transaction_number\":\"TRX-EXP-20261020134146\",\"transaction_date\":\"2023-01-27T00:00:00.000000Z\",\"total_amount\":30000,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 06:41:46', '2026-10-20 06:41:46'),
('01a1598b-f7e1-71e3-967f-caf0221e054e', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna berkurang karena transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a152d4-97a6-7063-9238-f45fe20fcae4', '{\"allocated_balance\":\"1156982563.00\",\"income_balance\":\"733644.00\",\"used_balance\":\"200176728.00\",\"remaining_balance\":\"957539479.00\"}', '{\"allocated_balance\":\"1156982563.00\",\"income_balance\":\"733644.00\",\"used_balance\":200206728,\"remaining_balance\":957509479}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a1598b-f7be-72db-909c-15b6f5924325\",\"transaction_number\":\"TRX-EXP-20261020134147\",\"expense_amount\":30000,\"is_deficit\":false}', '2026-10-20 06:41:47', '2026-10-20 06:41:47');
INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `module`, `description`, `subject_type`, `subject_id`, `old_values`, `new_values`, `ip_address`, `user_agent`, `additional_data`, `created_at`, `updated_at`) VALUES
('01a1598b-f7e3-71c8-a601-11a040a03052', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a1598b-f7be-72db-909c-15b6f5924325', '[]', '{\"transaction_id\":\"01a1598b-f7be-72db-909c-15b6f5924325\",\"transaction_number\":\"TRX-EXP-20261020134147\",\"transaction_date\":\"2023-01-27T00:00:00.000000Z\",\"total_amount\":30000,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 06:41:47', '2026-10-20 06:41:47'),
('01a1598c-2616-73ad-b157-f17dadd7ddbf', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Pengembalian saldo kas sumber karena penghapusan transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a152d4-97a6-7063-9238-f45fe20fcae4', '{\"allocated_balance\":\"1156982563.00\",\"income_balance\":\"733644.00\",\"used_balance\":\"200206728.00\",\"remaining_balance\":\"957509479.00\"}', '{\"allocated_balance\":\"1156982563.00\",\"income_balance\":\"733644.00\",\"used_balance\":200176728,\"remaining_balance\":957539479}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a1598b-f350-70ea-a8be-344bb42ec447\",\"transaction_number\":\"TRX-EXP-20261020134146\",\"reverted_amount\":30000}', '2026-10-20 06:41:59', '2026-10-20 06:41:59'),
('01a1598c-264f-71bd-b35e-5e549862ebdb', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DELETE', 'TRANSACTION_EXPENSE', 'Menghapus transaksi pengeluaran.', 'App\\Models\\Transaction', '01a1598b-f350-70ea-a8be-344bb42ec447', '{\"transaction_id\":\"01a1598b-f350-70ea-a8be-344bb42ec447\",\"transaction_number\":\"TRX-EXP-20261020134146\",\"transaction_date\":\"2023-01-27\",\"total_amount\":30000,\"status\":\"POSTED\",\"description\":\"Biaya Admin Giro\"}', '[]', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 06:41:59', '2026-10-20 06:41:59'),
('01a159b8-4e31-7300-9ee6-c606c1260298', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna berkurang karena transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a152d2-b241-7034-936a-88d4da21bd88', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"394604157.00\"}', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":2000000,\"remaining_balance\":392604157}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a159b8-4dfd-719a-9c6c-3c51505bba39\",\"transaction_number\":\"TRX-EXP-20261020143013\",\"expense_amount\":2000000,\"is_deficit\":false}', '2026-10-20 07:30:13', '2026-10-20 07:30:13'),
('01a159b8-4e34-70d7-a0c3-0afcdc1cdeee', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a159b8-4dfd-719a-9c6c-3c51505bba39', '[]', '{\"transaction_id\":\"01a159b8-4dfd-719a-9c6c-3c51505bba39\",\"transaction_number\":\"TRX-EXP-20261020143013\",\"transaction_date\":\"2023-01-02T00:00:00.000000Z\",\"total_amount\":2000000,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 07:30:13', '2026-10-20 07:30:13'),
('01a159b9-5496-7310-acb4-6c00cc8d0299', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna berkurang karena transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a152d2-b241-7034-936a-88d4da21bd88', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":\"2000000.00\",\"remaining_balance\":\"392604157.00\"}', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":5000000,\"remaining_balance\":389604157}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a159b9-5468-7034-a962-37e0bf59a275\",\"transaction_number\":\"TRX-EXP-20261020143120\",\"expense_amount\":3000000,\"is_deficit\":false}', '2026-10-20 07:31:20', '2026-10-20 07:31:20'),
('01a159b9-5499-7093-ab3b-62e0c6201899', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a159b9-5468-7034-a962-37e0bf59a275', '[]', '{\"transaction_id\":\"01a159b9-5468-7034-a962-37e0bf59a275\",\"transaction_number\":\"TRX-EXP-20261020143120\",\"transaction_date\":\"2023-01-05T00:00:00.000000Z\",\"total_amount\":3000000,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 07:31:20', '2026-10-20 07:31:20'),
('01a159ba-2a64-7365-a98e-b48070f07619', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna berkurang karena transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a152d2-b241-7034-936a-88d4da21bd88', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":\"5000000.00\",\"remaining_balance\":\"389604157.00\"}', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":65000000,\"remaining_balance\":329604157}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a159ba-2a17-7061-8959-94f0ba815020\",\"transaction_number\":\"TRX-EXP-20261020143215\",\"expense_amount\":60000000,\"is_deficit\":false}', '2026-10-20 07:32:15', '2026-10-20 07:32:15'),
('01a159ba-2a68-73d4-af7a-7bec81cc713c', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a159ba-2a17-7061-8959-94f0ba815020', '[]', '{\"transaction_id\":\"01a159ba-2a17-7061-8959-94f0ba815020\",\"transaction_number\":\"TRX-EXP-20261020143215\",\"transaction_date\":\"2023-01-05T00:00:00.000000Z\",\"total_amount\":60000000,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 07:32:15', '2026-10-20 07:32:15'),
('01a159ba-c93e-70a9-95b6-6d18f7bffeec', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna berkurang karena transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a152d2-b241-7034-936a-88d4da21bd88', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":\"65000000.00\",\"remaining_balance\":\"329604157.00\"}', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":65002500,\"remaining_balance\":329601657}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a159ba-c911-7123-aab0-050a4120af5a\",\"transaction_number\":\"TRX-EXP-20261020143255\",\"expense_amount\":2500,\"is_deficit\":false}', '2026-10-20 07:32:55', '2026-10-20 07:32:55'),
('01a159ba-c949-721f-90f2-67c1c16fd2de', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a159ba-c911-7123-aab0-050a4120af5a', '[]', '{\"transaction_id\":\"01a159ba-c911-7123-aab0-050a4120af5a\",\"transaction_number\":\"TRX-EXP-20261020143255\",\"transaction_date\":\"2023-01-05T00:00:00.000000Z\",\"total_amount\":2500,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 07:32:55', '2026-10-20 07:32:55'),
('01a159bb-98be-71fd-89ad-124869e6d41b', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna berkurang karena transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a152d2-b241-7034-936a-88d4da21bd88', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":\"65002500.00\",\"remaining_balance\":\"329601657.00\"}', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":65202500,\"remaining_balance\":329401657}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a159bb-9882-71b5-b6fb-231090a6956f\",\"transaction_number\":\"TRX-EXP-20261020143348\",\"expense_amount\":200000,\"is_deficit\":false}', '2026-10-20 07:33:48', '2026-10-20 07:33:48'),
('01a159bb-98c1-73db-9f7a-5af9a87a758e', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a159bb-9882-71b5-b6fb-231090a6956f', '[]', '{\"transaction_id\":\"01a159bb-9882-71b5-b6fb-231090a6956f\",\"transaction_number\":\"TRX-EXP-20261020143348\",\"transaction_date\":\"2023-01-05T00:00:00.000000Z\",\"total_amount\":200000,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 07:33:48', '2026-10-20 07:33:48'),
('01a159bc-2495-7216-912e-8ffb417fc398', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna berkurang karena transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a152d2-b241-7034-936a-88d4da21bd88', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":\"65202500.00\",\"remaining_balance\":\"329401657.00\"}', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":65502500,\"remaining_balance\":329101657}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a159bc-245f-7375-8055-7a44cfb4037a\",\"transaction_number\":\"TRX-EXP-20261020143424\",\"expense_amount\":300000,\"is_deficit\":false}', '2026-10-20 07:34:24', '2026-10-20 07:34:24'),
('01a159bc-2497-70b7-a2ee-d39d90ee62b2', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a159bc-245f-7375-8055-7a44cfb4037a', '[]', '{\"transaction_id\":\"01a159bc-245f-7375-8055-7a44cfb4037a\",\"transaction_number\":\"TRX-EXP-20261020143424\",\"transaction_date\":\"2023-01-07T00:00:00.000000Z\",\"total_amount\":300000,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 07:34:24', '2026-10-20 07:34:24'),
('01a159bc-b4cc-73b9-8bca-9a4df46a4c8a', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna berkurang karena transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a152d2-b241-7034-936a-88d4da21bd88', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":\"65502500.00\",\"remaining_balance\":\"329101657.00\"}', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":65902500,\"remaining_balance\":328701657}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a159bc-b49c-703c-b753-af118f3cce65\",\"transaction_number\":\"TRX-EXP-20261020143501\",\"expense_amount\":400000,\"is_deficit\":false}', '2026-10-20 07:35:01', '2026-10-20 07:35:01'),
('01a159bc-b4ce-7017-aafd-25c9d55be017', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a159bc-b49c-703c-b753-af118f3cce65', '[]', '{\"transaction_id\":\"01a159bc-b49c-703c-b753-af118f3cce65\",\"transaction_number\":\"TRX-EXP-20261020143501\",\"transaction_date\":\"2023-01-07T00:00:00.000000Z\",\"total_amount\":400000,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 07:35:01', '2026-10-20 07:35:01'),
('01a159bd-e04a-7087-bd08-c458619a28b8', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna berkurang karena transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a152d2-b241-7034-936a-88d4da21bd88', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":\"65902500.00\",\"remaining_balance\":\"328701657.00\"}', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":66102500,\"remaining_balance\":328501657}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a159bd-e023-72c7-ab31-ab7aaebd3a1f\",\"transaction_number\":\"TRX-EXP-20261020143618\",\"expense_amount\":200000,\"is_deficit\":false}', '2026-10-20 07:36:18', '2026-10-20 07:36:18'),
('01a159bd-e04d-70d0-8a26-d2e5f144cbaa', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a159bd-e023-72c7-ab31-ab7aaebd3a1f', '[]', '{\"transaction_id\":\"01a159bd-e023-72c7-ab31-ab7aaebd3a1f\",\"transaction_number\":\"TRX-EXP-20261020143618\",\"transaction_date\":\"2023-01-07T00:00:00.000000Z\",\"total_amount\":200000,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 07:36:18', '2026-10-20 07:36:18'),
('01a159c1-633e-7315-8000-62d8a598dcc7', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna berkurang karena transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a152d2-b241-7034-936a-88d4da21bd88', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":\"66102500.00\",\"remaining_balance\":\"328501657.00\"}', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":77007500,\"remaining_balance\":317596657}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a159c1-62dc-7251-a8a8-c83b16d8bb77\",\"transaction_number\":\"TRX-EXP-20261020144008\",\"expense_amount\":10905000,\"is_deficit\":false}', '2026-10-20 07:40:08', '2026-10-20 07:40:08'),
('01a159c1-6341-7344-9001-cf72ab5ed33f', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a159c1-62dc-7251-a8a8-c83b16d8bb77', '[]', '{\"transaction_id\":\"01a159c1-62dc-7251-a8a8-c83b16d8bb77\",\"transaction_number\":\"TRX-EXP-20261020144008\",\"transaction_date\":\"2023-01-07T00:00:00.000000Z\",\"total_amount\":10905000,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 07:40:08', '2026-10-20 07:40:08'),
('01a159c1-664d-7078-8bdb-42162198cb76', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna berkurang karena transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a152d2-b241-7034-936a-88d4da21bd88', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":\"77007500.00\",\"remaining_balance\":\"317596657.00\"}', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":87912500,\"remaining_balance\":306691657}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a159c1-65c7-73bf-8a52-ab752ddbb0e5\",\"transaction_number\":\"TRX-EXP-20261020144009\",\"expense_amount\":10905000,\"is_deficit\":false}', '2026-10-20 07:40:09', '2026-10-20 07:40:09'),
('01a159c1-6650-705b-aaaa-004238b68f14', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a159c1-65c7-73bf-8a52-ab752ddbb0e5', '[]', '{\"transaction_id\":\"01a159c1-65c7-73bf-8a52-ab752ddbb0e5\",\"transaction_number\":\"TRX-EXP-20261020144009\",\"transaction_date\":\"2023-01-07T00:00:00.000000Z\",\"total_amount\":10905000,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 07:40:09', '2026-10-20 07:40:09'),
('01a159c1-6bf4-70fc-b377-29fa5aa70a7c', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna berkurang karena transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a152d2-b241-7034-936a-88d4da21bd88', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":\"87912500.00\",\"remaining_balance\":\"306691657.00\"}', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":98817500,\"remaining_balance\":295786657}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a159c1-6b92-7293-aed9-605594dbb999\",\"transaction_number\":\"TRX-EXP-20261020144010\",\"expense_amount\":10905000,\"is_deficit\":false}', '2026-10-20 07:40:10', '2026-10-20 07:40:10'),
('01a159c1-6bf6-705e-b420-0583dc3bd90e', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a159c1-6b92-7293-aed9-605594dbb999', '[]', '{\"transaction_id\":\"01a159c1-6b92-7293-aed9-605594dbb999\",\"transaction_number\":\"TRX-EXP-20261020144010\",\"transaction_date\":\"2023-01-07T00:00:00.000000Z\",\"total_amount\":10905000,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 07:40:10', '2026-10-20 07:40:10'),
('01a159c2-9394-7035-a203-ef0ba63ece1b', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Pengembalian saldo kas sumber karena penghapusan transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a152d2-b241-7034-936a-88d4da21bd88', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":\"98817500.00\",\"remaining_balance\":\"295786657.00\"}', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":87912500,\"remaining_balance\":306691657}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a159c1-62dc-7251-a8a8-c83b16d8bb77\",\"transaction_number\":\"TRX-EXP-20261020144008\",\"reverted_amount\":10905000}', '2026-10-20 07:41:26', '2026-10-20 07:41:26'),
('01a159c2-93e7-72ee-b808-2dd31bf2232c', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DELETE', 'TRANSACTION_EXPENSE', 'Menghapus transaksi pengeluaran.', 'App\\Models\\Transaction', '01a159c1-62dc-7251-a8a8-c83b16d8bb77', '{\"transaction_id\":\"01a159c1-62dc-7251-a8a8-c83b16d8bb77\",\"transaction_number\":\"TRX-EXP-20261020144008\",\"transaction_date\":\"2023-01-07\",\"total_amount\":10905000,\"status\":\"POSTED\",\"description\":\"Transport verifikasi LK (6,7,8 Jan 2023) an Zubaidatul Hidayah (PDA Sidoarjo) dan Tambahan transport Rapat persiapan verifikasi keuangan (17 Des 2017) an. Martiningsih dan Transport verifikasi LK (6,7,8 Jan 2023) an Martiningsih (PDA Ponorogo) dan Pembelian Klip (yuli) dan Tinta print Data Print, lem, isi staples dan Tinta print Data Print, lem, isi staples dan Parkir\"}', '[]', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 07:41:26', '2026-10-20 07:41:26'),
('01a159c2-adfc-7078-bf8c-d38749839b5e', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Pengembalian saldo kas sumber karena penghapusan transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a152d2-b241-7034-936a-88d4da21bd88', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":\"87912500.00\",\"remaining_balance\":\"306691657.00\"}', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":77007500,\"remaining_balance\":317596657}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a159c1-65c7-73bf-8a52-ab752ddbb0e5\",\"transaction_number\":\"TRX-EXP-20261020144009\",\"reverted_amount\":10905000}', '2026-10-20 07:41:33', '2026-10-20 07:41:33'),
('01a159c2-ae49-726f-813a-cba743eb56dd', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DELETE', 'TRANSACTION_EXPENSE', 'Menghapus transaksi pengeluaran.', 'App\\Models\\Transaction', '01a159c1-65c7-73bf-8a52-ab752ddbb0e5', '{\"transaction_id\":\"01a159c1-65c7-73bf-8a52-ab752ddbb0e5\",\"transaction_number\":\"TRX-EXP-20261020144009\",\"transaction_date\":\"2023-01-07\",\"total_amount\":10905000,\"status\":\"POSTED\",\"description\":\"Transport verifikasi LK (6,7,8 Jan 2023) an Zubaidatul Hidayah (PDA Sidoarjo) dan Tambahan transport Rapat persiapan verifikasi keuangan (17 Des 2017) an. Martiningsih dan Transport verifikasi LK (6,7,8 Jan 2023) an Martiningsih (PDA Ponorogo) dan Pembelian Klip (yuli) dan Tinta print Data Print, lem, isi staples dan Tinta print Data Print, lem, isi staples dan Parkir\"}', '[]', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 07:41:33', '2026-10-20 07:41:33'),
('01a159ee-b32b-7076-a94c-d0e28d2621d8', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna berkurang karena transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a152d2-b241-7034-936a-88d4da21bd88', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":\"77007500.00\",\"remaining_balance\":\"317596657.00\"}', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":86765000,\"remaining_balance\":307839157}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a159ee-b2c3-73ad-a0ab-15fc298346dc\",\"transaction_number\":\"TRX-EXP-20261020152937\",\"expense_amount\":9757500,\"is_deficit\":false}', '2026-10-20 08:29:38', '2026-10-20 08:29:38'),
('01a159ee-b335-72a0-a291-00132ef6e909', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a159ee-b2c3-73ad-a0ab-15fc298346dc', '[]', '{\"transaction_id\":\"01a159ee-b2c3-73ad-a0ab-15fc298346dc\",\"transaction_number\":\"TRX-EXP-20261020152937\",\"transaction_date\":\"2023-01-08T00:00:00.000000Z\",\"total_amount\":9757500,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 08:29:38', '2026-10-20 08:29:38'),
('01a159f1-3f85-7069-beee-18a1d0fa7d83', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna berkurang karena transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a152d2-b241-7034-936a-88d4da21bd88', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":\"86765000.00\",\"remaining_balance\":\"307839157.00\"}', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":130677975,\"remaining_balance\":263926182}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a159f1-3f4f-73b4-aa2d-e6dc4e5cc881\",\"transaction_number\":\"TRX-EXP-20261020153225\",\"expense_amount\":43912975,\"is_deficit\":false}', '2026-10-20 08:32:25', '2026-10-20 08:32:25'),
('01a159f1-3f87-718e-a759-ccad4d442f01', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a159f1-3f4f-73b4-aa2d-e6dc4e5cc881', '[]', '{\"transaction_id\":\"01a159f1-3f4f-73b4-aa2d-e6dc4e5cc881\",\"transaction_number\":\"TRX-EXP-20261020153225\",\"transaction_date\":\"2023-01-10T00:00:00.000000Z\",\"total_amount\":43912975,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 08:32:25', '2026-10-20 08:32:25'),
('01a159f1-f14e-72c5-b268-16e165222beb', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna berkurang karena transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a152d2-b241-7034-936a-88d4da21bd88', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":\"130677975.00\",\"remaining_balance\":\"263926182.00\"}', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":165677975,\"remaining_balance\":228926182}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a159f1-f121-7225-9555-db217567f41e\",\"transaction_number\":\"TRX-EXP-20261020153310\",\"expense_amount\":35000000,\"is_deficit\":false}', '2026-10-20 08:33:10', '2026-10-20 08:33:10'),
('01a159f1-f150-719a-894b-82b1b54a6e77', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a159f1-f121-7225-9555-db217567f41e', '[]', '{\"transaction_id\":\"01a159f1-f121-7225-9555-db217567f41e\",\"transaction_number\":\"TRX-EXP-20261020153310\",\"transaction_date\":\"2023-01-13T00:00:00.000000Z\",\"total_amount\":35000000,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 08:33:10', '2026-10-20 08:33:10'),
('01a159f6-dfba-7193-b493-89b53bcff6e0', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna berkurang karena transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a152d2-b241-7034-936a-88d4da21bd88', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":\"165677975.00\",\"remaining_balance\":\"228926182.00\"}', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":185377975,\"remaining_balance\":209226182}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a159f6-df9a-7188-8de2-644c55dc8782\",\"transaction_number\":\"TRX-EXP-20261020153833\",\"expense_amount\":19700000,\"is_deficit\":false}', '2026-10-20 08:38:33', '2026-10-20 08:38:33'),
('01a159f6-dfbb-70c4-b011-bd8233ebcf6d', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a159f6-df9a-7188-8de2-644c55dc8782', '[]', '{\"transaction_id\":\"01a159f6-df9a-7188-8de2-644c55dc8782\",\"transaction_number\":\"TRX-EXP-20261020153833\",\"transaction_date\":\"2023-01-16T00:00:00.000000Z\",\"total_amount\":19700000,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 08:38:33', '2026-10-20 08:38:33'),
('01a159f8-ff4e-7045-bfe3-d22406f55dac', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a159f8-ff19-720f-8c97-7138392d926c', '[]', '{\"transaction_id\":\"01a159f8-ff19-720f-8c97-7138392d926c\",\"transaction_number\":\"TRX-INC-20261020154052\",\"transaction_date\":\"2023-01-21T00:00:00.000000Z\",\"total_amount\":50000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"fde4c6ca-4c2c-4764-8027-19270a9e752d\",\"position\":\"DEBIT\",\"amount\":50000000,\"description\":\"Mutasi Kas Masuk\"},{\"coa_id\":\"d0cf1368-347c-4b97-99b6-c0fc88f0392e\",\"position\":\"CREDIT\",\"amount\":50000000,\"description\":\"Pemasukan dari Gubernur Jatim untuk bantuan Muswil diberikan ke bu Candra tunai\"}]}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"INCOME\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 08:40:52', '2026-10-20 08:40:52'),
('01a159f8-ff4f-7129-af29-188dc6177f9a', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '01a152d2-b241-7034-936a-88d4da21bd88', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"200000000.00\",\"used_balance\":\"185377975.00\",\"remaining_balance\":\"209226182.00\"}', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":250000000,\"used_balance\":\"185377975.00\",\"remaining_balance\":259226182}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a159f8-ff19-720f-8c97-7138392d926c\",\"transaction_number\":\"TRX-INC-20261020154052\",\"income_amount\":50000000}', '2026-10-20 08:40:52', '2026-10-20 08:40:52'),
('01a159fa-2ee4-7156-babf-f734e1b53224', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna berkurang karena transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a152d2-b241-7034-936a-88d4da21bd88', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"250000000.00\",\"used_balance\":\"185377975.00\",\"remaining_balance\":\"259226182.00\"}', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"250000000.00\",\"used_balance\":285380475,\"remaining_balance\":159223682}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a159fa-2ea6-73b5-8c7c-d84068fcff22\",\"transaction_number\":\"TRX-EXP-20261020154210\",\"expense_amount\":100002500,\"is_deficit\":false}', '2026-10-20 08:42:10', '2026-10-20 08:42:10'),
('01a159fa-2ee6-7226-a77d-0457b0a8f859', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a159fa-2ea6-73b5-8c7c-d84068fcff22', '[]', '{\"transaction_id\":\"01a159fa-2ea6-73b5-8c7c-d84068fcff22\",\"transaction_number\":\"TRX-EXP-20261020154210\",\"transaction_date\":\"2023-01-24T00:00:00.000000Z\",\"total_amount\":100002500,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 08:42:10', '2026-10-20 08:42:10'),
('01a159fb-78e5-726d-97fa-8b98c8133d9c', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna berkurang karena transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a152d2-b241-7034-936a-88d4da21bd88', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"250000000.00\",\"used_balance\":\"285380475.00\",\"remaining_balance\":\"159223682.00\"}', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"250000000.00\",\"used_balance\":337903525,\"remaining_balance\":106700632}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a159fb-78ba-71dd-bcbe-3cda5690d8e8\",\"transaction_number\":\"TRX-EXP-20261020154335\",\"expense_amount\":52523050,\"is_deficit\":false}', '2026-10-20 08:43:35', '2026-10-20 08:43:35'),
('01a159fb-78e7-725a-ad27-2fd454d32fa6', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a159fb-78ba-71dd-bcbe-3cda5690d8e8', '[]', '{\"transaction_id\":\"01a159fb-78ba-71dd-bcbe-3cda5690d8e8\",\"transaction_number\":\"TRX-EXP-20261020154335\",\"transaction_date\":\"2023-01-25T00:00:00.000000Z\",\"total_amount\":52523050,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 08:43:35', '2026-10-20 08:43:35'),
('01a159fc-d7f0-7005-b345-bca559664104', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a159fc-d7c5-7149-b40c-9dcd74decdfb', '[]', '{\"transaction_id\":\"01a159fc-d7c5-7149-b40c-9dcd74decdfb\",\"transaction_number\":\"TRX-INC-20261020154504\",\"transaction_date\":\"2023-01-27T00:00:00.000000Z\",\"total_amount\":175000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"fde4c6ca-4c2c-4764-8027-19270a9e752d\",\"position\":\"DEBIT\",\"amount\":175000000,\"description\":\"Mutasi Kas Masuk\"},{\"coa_id\":\"3aed7fc1-a08f-4eee-a040-29e34c846836\",\"position\":\"CREDIT\",\"amount\":175000000,\"description\":\"Pemasukan bantuan Muswil dari PWM (cek bank Muamalat)\"}]}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"INCOME\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 08:45:05', '2026-10-20 08:45:05'),
('01a159fc-d7f2-7000-b71c-0ef4e797918f', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '01a152d2-b241-7034-936a-88d4da21bd88', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"250000000.00\",\"used_balance\":\"337903525.00\",\"remaining_balance\":\"106700632.00\"}', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":425000000,\"used_balance\":\"337903525.00\",\"remaining_balance\":281700632}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a159fc-d7c5-7149-b40c-9dcd74decdfb\",\"transaction_number\":\"TRX-INC-20261020154504\",\"income_amount\":175000000}', '2026-10-20 08:45:05', '2026-10-20 08:45:05'),
('01a159fe-14f5-7360-87ea-45f007e0edd3', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna berkurang karena transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a152d2-b241-7034-936a-88d4da21bd88', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"425000000.00\",\"used_balance\":\"337903525.00\",\"remaining_balance\":\"281700632.00\"}', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"425000000.00\",\"used_balance\":347439025,\"remaining_balance\":272165132}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a159fe-14c7-70da-a37d-84a6f63f8717\",\"transaction_number\":\"TRX-EXP-20261020154626\",\"expense_amount\":9535500,\"is_deficit\":false}', '2026-10-20 08:46:26', '2026-10-20 08:46:26'),
('01a159fe-14f7-7224-8212-80a455a2b6e5', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a159fe-14c7-70da-a37d-84a6f63f8717', '[]', '{\"transaction_id\":\"01a159fe-14c7-70da-a37d-84a6f63f8717\",\"transaction_number\":\"TRX-EXP-20261020154626\",\"transaction_date\":\"2023-01-27T00:00:00.000000Z\",\"total_amount\":9535500,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 08:46:26', '2026-10-20 08:46:26'),
('01a159fe-a357-71a3-97db-61273d9845d1', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna berkurang karena transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a152d2-b241-7034-936a-88d4da21bd88', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"425000000.00\",\"used_balance\":\"347439025.00\",\"remaining_balance\":\"272165132.00\"}', '{\"allocated_balance\":\"194604157.00\",\"income_balance\":\"425000000.00\",\"used_balance\":352439025,\"remaining_balance\":267165132}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a159fe-a2e2-7242-ae59-2fae214c4e62\",\"transaction_number\":\"TRX-EXP-20261020154702\",\"expense_amount\":5000000,\"is_deficit\":false}', '2026-10-20 08:47:02', '2026-10-20 08:47:02'),
('01a159fe-a359-709c-ac6f-c9900ba98f4d', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a159fe-a2e2-7242-ae59-2fae214c4e62', '[]', '{\"transaction_id\":\"01a159fe-a2e2-7242-ae59-2fae214c4e62\",\"transaction_number\":\"TRX-EXP-20261020154702\",\"transaction_date\":\"2023-01-31T00:00:00.000000Z\",\"total_amount\":5000000,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 08:47:02', '2026-10-20 08:47:02'),
('01a15aa0-24ed-71ba-8999-8492105ff1af', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna berkurang karena transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a15a9c-6036-734b-9bb0-5b81acdf14cd', '{\"allocated_balance\":\"4983047.00\",\"income_balance\":\"0.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"4983047.00\"}', '{\"allocated_balance\":\"4983047.00\",\"income_balance\":\"0.00\",\"used_balance\":402500,\"remaining_balance\":4580547}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a15aa0-24c7-7397-9b2c-e78d7e10de30\",\"transaction_number\":\"TRX-EXP-20261020184327\",\"expense_amount\":402500,\"is_deficit\":false}', '2026-10-20 11:43:27', '2026-10-20 11:43:27'),
('01a15aa0-24f8-73a8-b5b6-29fdf1af3cd4', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a15aa0-24c7-7397-9b2c-e78d7e10de30', '[]', '{\"transaction_id\":\"01a15aa0-24c7-7397-9b2c-e78d7e10de30\",\"transaction_number\":\"TRX-EXP-20261020184327\",\"transaction_date\":\"2023-01-01T00:00:00.000000Z\",\"total_amount\":402500,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 11:43:27', '2026-10-20 11:43:27'),
('01a15aa2-d6b0-7039-9456-8f77a969614c', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '01a15aa2-d691-70e1-b12f-03d38ca381c6', '[]', '{\"transaction_id\":\"01a15aa2-d691-70e1-b12f-03d38ca381c6\",\"transaction_number\":\"TRX-INC-20261020184623\",\"transaction_date\":\"2023-01-01T00:00:00.000000Z\",\"total_amount\":200000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"a63a0d86-6c19-415e-a12c-16e8a8399fda\",\"position\":\"DEBIT\",\"amount\":200000,\"description\":\"Mutasi Kas Masuk\"},{\"coa_id\":\"54a2c8f7-8bf2-4baf-a30e-52863c7b15db\",\"position\":\"CREDIT\",\"amount\":200000,\"description\":\"Cicilan 3 Pak Edi\"}]}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"INCOME\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 11:46:23', '2026-10-20 11:46:23'),
('01a15aa2-d6b1-71b0-952b-1cd63d4b76dd', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '01a15a9c-6036-734b-9bb0-5b81acdf14cd', '{\"allocated_balance\":\"4983047.00\",\"income_balance\":\"0.00\",\"used_balance\":\"402500.00\",\"remaining_balance\":\"4580547.00\"}', '{\"allocated_balance\":\"4983047.00\",\"income_balance\":200000,\"used_balance\":\"402500.00\",\"remaining_balance\":4780547}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a15aa2-d691-70e1-b12f-03d38ca381c6\",\"transaction_number\":\"TRX-INC-20261020184623\",\"income_amount\":200000}', '2026-10-20 11:46:23', '2026-10-20 11:46:23'),
('01a15aa4-c2ad-7194-9ffe-daa9e110b3d7', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna berkurang karena transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a15a9c-6036-734b-9bb0-5b81acdf14cd', '{\"allocated_balance\":\"4983047.00\",\"income_balance\":\"200000.00\",\"used_balance\":\"402500.00\",\"remaining_balance\":\"4780547.00\"}', '{\"allocated_balance\":\"4983047.00\",\"income_balance\":\"200000.00\",\"used_balance\":1305000,\"remaining_balance\":3878047}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a15aa4-c27e-7293-8c0a-bf150d01d619\",\"transaction_number\":\"TRX-EXP-20261020184829\",\"expense_amount\":902500,\"is_deficit\":false}', '2026-10-20 11:48:29', '2026-10-20 11:48:29'),
('01a15aa4-c2af-7247-885c-b220089b150b', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a15aa4-c27e-7293-8c0a-bf150d01d619', '[]', '{\"transaction_id\":\"01a15aa4-c27e-7293-8c0a-bf150d01d619\",\"transaction_number\":\"TRX-EXP-20261020184829\",\"transaction_date\":\"2023-01-02T00:00:00.000000Z\",\"total_amount\":902500,\"status\":\"POSTED\"}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 11:48:29', '2026-10-20 11:48:29'),
('01a15cdb-020b-722d-95fa-19208030aa04', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna berkurang karena transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a15a9c-6036-734b-9bb0-5b81acdf14cd', '{\"allocated_balance\":\"4983047.00\",\"income_balance\":\"200000.00\",\"used_balance\":\"1305000.00\",\"remaining_balance\":\"3878047.00\"}', '{\"allocated_balance\":\"4983047.00\",\"income_balance\":\"200000.00\",\"used_balance\":1448000,\"remaining_balance\":3735047}', '36.78.121.117', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_id\":\"01a15cdb-01d9-7227-bd48-be2bd9d98ab8\",\"transaction_number\":\"TRX-EXP-20261021050659\",\"expense_amount\":143000,\"is_deficit\":false}', '2026-10-20 22:06:59', '2026-10-20 22:06:59'),
('01a15cdb-020d-7024-acb1-a9cb040630a5', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a15cdb-01d9-7227-bd48-be2bd9d98ab8', '[]', '{\"transaction_id\":\"01a15cdb-01d9-7227-bd48-be2bd9d98ab8\",\"transaction_number\":\"TRX-EXP-20261021050659\",\"transaction_date\":\"2023-01-02T00:00:00.000000Z\",\"total_amount\":143000,\"status\":\"POSTED\"}', '36.78.121.117', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a1525d-6a17-70ce-862c-331933a6b4b0\",\"sub_period_id\":\"01a1525d-6a46-7371-9dbf-1fc8564337e7\"}', '2026-10-20 22:06:59', '2026-10-20 22:06:59');

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
('0159713a-ac72-4c17-a5b6-8352806762c1', '12200', 'Gedung', '7265dbca-563d-4f78-9251-f55930a8a93a', '2', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:37', '2026-10-18 21:13:37', NULL),
('07273ff4-96b4-4756-8f70-a34e66bb36d0', '11120', 'Kas di Bank Jatim', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:36', '2026-10-18 21:13:36', NULL),
('07c0b1d5-c1b2-426f-afd3-1e5db0ef4f15', '57207', 'Biaya Program Majelis Hukum dan HAM', '966cf05c-3c1e-4058-8da6-121f84bf8c57', '4', '7', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:43', '2026-10-18 21:13:43', NULL),
('07c9a867-c2e3-41e5-ab42-929d97c947d2', '41600', 'Simpanan Wajib Peserta', '5afd9a05-58cf-431c-a1f3-d7f3552db08f', '3', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:39', '2026-10-18 21:13:39', NULL),
('0843a6ab-d620-4879-9a9a-a3147d9ac471', '58300', 'Hadiah', '9306d1b1-c8c5-4f57-9adb-a981d678de21', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:43', '2026-10-18 21:13:43', NULL),
('0ec1d989-42d6-4b22-b5fc-d46f69f3ca47', '44004', 'Pendapatan Pembangunan ATC', '93556b2c-37cd-4485-ad00-b5c68e1f33d2', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:39', '2026-10-18 21:13:39', NULL),
('0f3cda5b-5055-459d-8d8d-5e5d68f77675', '42000', 'Kontribusi Amal Usaha', 'a2548395-e459-4ae8-8b64-34e4bba29636', '2', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:39', '2026-10-18 21:13:39', NULL),
('0f9579c0-6cc3-4458-aa0b-f9a15acd9578', '12500', 'Peralatan Kantor', '7265dbca-563d-4f78-9251-f55930a8a93a', '2', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:37', '2026-10-18 21:13:37', NULL),
('10b6dc05-cc5d-44f4-9bb8-a7f5c9f6d3a3', '52014', 'Biaya Komunikasi', 'ca927261-a07f-4069-b341-1da4715f8735', '3', '14', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:41', '2026-10-18 21:13:41', NULL),
('14dc35fc-8cf0-47f2-b41f-55de875caf32', '31300', 'Selisih Lebih/Kurang', 'c3421138-08a8-4e81-a760-88484c7e689d', '2', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567892', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:38', '2026-10-18 21:13:38', NULL),
('1dc22728-2840-44a6-98ef-28897c3e4274', '59000', 'Biaya Administrasi Bank', 'f2cbf766-2947-48e3-9805-43baa3995e18', '2', '9', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:43', '2026-10-18 21:13:43', NULL),
('217611bd-73a7-48d8-be5e-9b67041b0093', '11130', 'Kas di Bank Jatim Dr. Soetomo', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:36', '2026-10-18 21:13:36', NULL),
('21b0be96-38c9-43d3-adb8-6e12deb1a102', '41200', 'Dana Wajib Organisasi', '5afd9a05-58cf-431c-a1f3-d7f3552db08f', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:38', '2026-10-18 21:13:38', NULL),
('2b03559e-ddf0-4e3c-9256-a86032fa2bda', '57100', 'Biaya Pelaksanaan Program', 'a80f9290-d3ed-4a53-bee4-d6b3b3132655', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:42', '2026-10-18 21:13:42', NULL),
('2de2c5c6-9053-4d1f-9f8f-773dc660512b', '22100', 'Hutang PPN', '376339c8-b760-479a-89e2-97995ed7b3ea', '2', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567891', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:38', '2026-10-18 21:13:38', NULL),
('2dee313b-f6d5-4a67-a6c8-6543bcd9972e', '43100', 'Pendapatan Bunga Bank', 'e6db6cf4-dec7-4ac2-81f6-f14660c0c1c2', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:39', '2026-10-18 21:13:39', NULL),
('2ebe8ddb-e1c2-4da4-b0bb-15dba502c9dc', '22200', 'Hutang PPh 21', '376339c8-b760-479a-89e2-97995ed7b3ea', '2', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567891', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:38', '2026-10-18 21:13:38', NULL),
('3342e9fa-a2a8-4777-87d8-fb31912a74f3', '54000', 'Biaya Persidangan', 'f2cbf766-2947-48e3-9805-43baa3995e18', '2', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:41', '2026-10-18 21:13:41', NULL),
('376339c8-b760-479a-89e2-97995ed7b3ea', '22000', 'Hutang Pajak', NULL, '1', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567891', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:38', '2026-10-18 21:13:38', NULL),
('386f9d14-1253-40df-b09b-afb1938d507a', '58200', 'Dana Sehat Muhammadiyah', '9306d1b1-c8c5-4f57-9adb-a981d678de21', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:43', '2026-10-18 21:13:43', NULL),
('38f0b478-7b9f-488e-8747-13d743638a7a', '52600', 'Biaya Pemeliharaan Gedung', 'ca927261-a07f-4069-b341-1da4715f8735', '3', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:40', '2026-10-18 21:13:40', NULL),
('3a6d0b45-bcdf-4322-956a-36909c9b9c3d', '42300', 'Kontribusi Bidang Ekonomi', '0f3cda5b-5055-459d-8d8d-5e5d68f77675', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:39', '2026-10-18 21:13:39', NULL),
('3aed7fc1-a08f-4eee-a040-29e34c846836', '41400', 'Muhammadiyah', '5afd9a05-58cf-431c-a1f3-d7f3552db08f', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:39', '2026-10-18 21:13:39', NULL),
('3ba8e8bb-fe4e-4658-af3f-18923b3722f7', '51005', 'Tunjangan', 'eddb12cc-89d3-4a23-9dbe-2631b540191a', '3', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:40', '2026-10-18 21:13:40', NULL),
('3c146a69-c72e-4394-a165-cda538947fff', '57201', 'Biaya Program Majelis Tablig dan Ketarjihan', '966cf05c-3c1e-4058-8da6-121f84bf8c57', '4', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:42', '2026-10-18 21:13:42', NULL),
('3c63e3d3-31df-40ee-a780-b36f628c1b3e', '11400', 'Piutang Lainnya', '69670f62-db4b-4cf3-9d59-ea1782710a9a', '2', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:36', '2026-10-18 21:13:36', NULL),
('40c08639-0031-45f8-9774-003a59f0a06d', '44002', 'Kerjasama Eksternal', '93556b2c-37cd-4485-ad00-b5c68e1f33d2', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:39', '2026-10-18 21:13:39', NULL),
('4188429a-411b-47b5-be56-8cd2ad12a042', '44003', 'Pendapatan Sewa ATC', '93556b2c-37cd-4485-ad00-b5c68e1f33d2', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:39', '2026-10-18 21:13:39', NULL),
('420ff500-8f4c-404c-abd6-9bad93eff4af', '53100', 'Depresiasi Gedung', '8426372e-1021-455c-8ad7-7195b2425481', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:41', '2026-10-18 21:13:41', NULL),
('45fbfc68-5387-4bfa-8b3e-2e0c0ee05245', '57800', 'Biaya Operasional Inklusi', 'a80f9290-d3ed-4a53-bee4-d6b3b3132655', '3', '8', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:43', '2026-10-18 21:13:43', NULL),
('4d7681a6-f811-45b8-aae1-ab6269b27292', '43200', 'Pendapatan Deposito', 'e6db6cf4-dec7-4ac2-81f6-f14660c0c1c2', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:39', '2026-10-18 21:13:39', NULL),
('535aaf43-9bd1-4da7-942c-c451d43f1da8', '22400', 'Hutang PPh Final', '376339c8-b760-479a-89e2-97995ed7b3ea', '2', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567891', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:38', '2026-10-18 21:13:38', NULL),
('545f5382-e38c-43bd-a9f0-0f44327b36d5', '52011', 'Biaya Kerumahtanggaan', 'ca927261-a07f-4069-b341-1da4715f8735', '3', '11', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:41', '2026-10-18 21:13:41', NULL),
('54a2c8f7-8bf2-4baf-a30e-52863c7b15db', '11300', 'Piutang Karyawan', '69670f62-db4b-4cf3-9d59-ea1782710a9a', '2', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:36', '2026-10-18 21:13:36', NULL),
('56937cd4-a01f-46d2-8c58-34eb640b1c8d', '52010', 'Biaya Pemeliharaan Peralatan Kantor', 'ca927261-a07f-4069-b341-1da4715f8735', '3', '10', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:41', '2026-10-18 21:13:41', NULL),
('56a3c4f6-d165-4f3d-81a3-7afb856e1520', '41100', 'Iuran Anggota', '5afd9a05-58cf-431c-a1f3-d7f3552db08f', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:38', '2026-10-18 21:13:38', NULL),
('58913402-2f31-41b3-8f29-442f5a203139', '41300', 'Zakat Infaq Shadaqoh Organisasi', '5afd9a05-58cf-431c-a1f3-d7f3552db08f', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:38', '2026-10-18 21:13:38', NULL),
('5934d883-8403-4e1b-be51-bfd87a4950ab', '44005', 'Pendapatan Inklusi', '93556b2c-37cd-4485-ad00-b5c68e1f33d2', '3', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:39', '2026-10-18 21:13:39', NULL),
('5afd9a05-58cf-431c-a1f3-d7f3552db08f', '41000', 'Pendapatan Organisasi', 'a2548395-e459-4ae8-8b64-34e4bba29636', '2', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:38', '2026-10-18 21:13:38', NULL),
('5b1066bc-288a-421f-b554-523d64ce9295', '51001', 'Biaya Gaji Karyawan & Staf', 'eddb12cc-89d3-4a23-9dbe-2631b540191a', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:40', '2026-10-18 21:13:40', NULL),
('5ebedf2c-d685-41fe-937d-bb9f3c3e6fa6', '52015', 'Biaya Administrasi Kantor Lainnya', 'ca927261-a07f-4069-b341-1da4715f8735', '3', '15', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:41', '2026-10-18 21:13:41', NULL),
('5f5c44e2-728d-4fd5-bb5d-431361a7891c', '12310', 'Akumulasi Depresiasi Kendaraan', 'e51f3483-8b24-4b95-bcb7-56c47e85456d', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:37', '2026-10-18 21:13:37', NULL),
('6806e476-237b-4db0-9732-d6487dd7de00', '53400', 'Depresiasi Peralatan Kantor', '8426372e-1021-455c-8ad7-7195b2425481', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:41', '2026-10-18 21:13:41', NULL),
('68539801-9d15-4c54-bd79-294aad72912f', '11200', 'Kas Bon', '69670f62-db4b-4cf3-9d59-ea1782710a9a', '2', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:36', '2026-10-18 21:13:36', NULL),
('69670f62-db4b-4cf3-9d59-ea1782710a9a', '11000', 'Aset Lancar', NULL, '1', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:36', '2026-10-18 21:13:36', NULL),
('6a0227fd-84f3-40bc-8693-6b1edbd836b1', '12210', 'Akumulasi Depresiasi Gedung', '0159713a-ac72-4c17-a5b6-8352806762c1', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:37', '2026-10-18 21:13:37', NULL),
('6a6499da-2347-4b2a-9ecc-1a10623f0710', '12100', 'Tanah', '7265dbca-563d-4f78-9251-f55930a8a93a', '2', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:37', '2026-10-18 21:13:37', NULL),
('6af539ad-1478-40bb-ad1d-7a101055dc9c', '52800', 'Biaya Asuransi kendaraan', 'ca927261-a07f-4069-b341-1da4715f8735', '3', '8', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:40', '2026-10-18 21:13:40', NULL),
('6b417011-8fde-4be3-a30b-5b25132f9cbe', '57202', 'Biaya Program Pendidikan Anak Usia Dini, Dasar dan Menengah', '966cf05c-3c1e-4058-8da6-121f84bf8c57', '4', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:42', '2026-10-18 21:13:42', NULL),
('71206ec3-fed1-45d1-92d3-6e8f7fbf6467', '53200', 'Depresiasi Kendaraan', '8426372e-1021-455c-8ad7-7195b2425481', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:41', '2026-10-18 21:13:41', NULL),
('7265dbca-563d-4f78-9251-f55930a8a93a', '12000', 'Aset Tidak Lancar', NULL, '1', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:37', '2026-10-18 21:13:37', NULL),
('728194df-d7e3-4e86-a565-b52040d0fc81', '59300', 'Biaya Materai', '1dc22728-2840-44a6-98ef-28897c3e4274', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:43', '2026-10-18 21:13:43', NULL),
('746adf43-84d2-4ae9-a86a-de40ab511c8b', '57209', 'Biaya Program Penelitian dan Pengembangan Aisyiyah', '966cf05c-3c1e-4058-8da6-121f84bf8c57', '4', '9', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:43', '2026-10-18 21:13:43', NULL),
('757cde74-832b-4164-97be-82b78afb6b9f', '12410', 'Akumulasi Depresiasi Meubel', 'b22b30bd-f081-4d6d-bb12-1b9d39238239', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:37', '2026-10-18 21:13:37', NULL),
('773c6650-da28-43c5-9e58-e5cf96a7820e', '22300', 'Hutang PPh 23', '376339c8-b760-479a-89e2-97995ed7b3ea', '2', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567891', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:38', '2026-10-18 21:13:38', NULL),
('82241006-263f-4be7-a5ab-856596307692', '55300', 'Biaya Akomodasi', 'da96fdd8-4e1e-4892-92a9-79139f1ee124', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:42', '2026-10-18 21:13:42', NULL),
('8426372e-1021-455c-8ad7-7195b2425481', '53000', 'Biaya Depresiasi Aset Tetap', 'f2cbf766-2947-48e3-9805-43baa3995e18', '2', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:41', '2026-10-18 21:13:41', NULL),
('8495fc04-2c0f-40ac-8187-bbb035488ca5', '21000', 'Hutang Pihak Lain', NULL, '1', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567891', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:38', '2026-10-18 21:13:38', NULL),
('88a67975-06bf-4dbe-b1ee-5caaa9212505', '57600', 'Biaya operasional ATC', 'a80f9290-d3ed-4a53-bee4-d6b3b3132655', '3', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:43', '2026-10-18 21:13:43', NULL),
('8b442de5-2474-43cd-a2d2-e16c43ccf387', '42500', 'Kontribusi Lainnya', '0f3cda5b-5055-459d-8d8d-5e5d68f77675', '3', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:39', '2026-10-18 21:13:39', NULL),
('8b4c6709-0d76-4eff-b034-1261fc42a678', '51002', 'Honorarium/Kontrak', 'eddb12cc-89d3-4a23-9dbe-2631b540191a', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:40', '2026-10-18 21:13:40', NULL),
('8bc1f9ed-24aa-4e5b-8f6e-adc561d0b739', '54300', 'Biaya Sidang Tanwir', '3342e9fa-a2a8-4777-87d8-fb31912a74f3', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:41', '2026-10-18 21:13:41', NULL),
('8ea7b710-f98a-4881-8fdb-db9dbaa31f87', '57700', 'Biaya Pembangunan ATC', 'a80f9290-d3ed-4a53-bee4-d6b3b3132655', '3', '7', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:43', '2026-10-18 21:13:43', NULL),
('902753ad-a0f2-4506-bb23-e77b2fab6f32', '12510', 'Akumulasi Depresiasi Peralatan Kantor', '0f9579c0-6cc3-4458-aa0b-f9a15acd9578', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:37', '2026-10-18 21:13:37', NULL),
('91861619-4d6e-485d-afa3-a3ddd1038ffd', '57300', 'Biaya kehumasan', 'a80f9290-d3ed-4a53-bee4-d6b3b3132655', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:43', '2026-10-18 21:13:43', NULL),
('918b135d-a3ea-47ee-9b4b-d02793a483eb', '52400', 'Biaya Cetak-Cetak', 'ca927261-a07f-4069-b341-1da4715f8735', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:40', '2026-10-18 21:13:40', NULL),
('9289e0c9-c5f1-48ba-9bf1-24134c0c0848', '57208', 'Biaya Program Lembaga Budaya Seni dan Olah Raga', '966cf05c-3c1e-4058-8da6-121f84bf8c57', '4', '8', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:43', '2026-10-18 21:13:43', NULL),
('9306d1b1-c8c5-4f57-9adb-a981d678de21', '58000', 'Biaya Kesejahteraan', 'f2cbf766-2947-48e3-9805-43baa3995e18', '2', '8', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:43', '2026-10-18 21:13:43', NULL),
('93556b2c-37cd-4485-ad00-b5c68e1f33d2', '44000', 'Pendapatan Kerjasama', 'a2548395-e459-4ae8-8b64-34e4bba29636', '2', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:39', '2026-10-18 21:13:39', NULL),
('9379f29b-27a8-4f16-a434-80370a8a625d', '59100', 'Biaya Pajak Bank', '1dc22728-2840-44a6-98ef-28897c3e4274', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:43', '2026-10-18 21:13:43', NULL),
('95bb9b8c-a02d-413b-a22d-69f79c8f69c1', '52500', 'Biaya Pengiriman', 'ca927261-a07f-4069-b341-1da4715f8735', '3', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:40', '2026-10-18 21:13:40', NULL),
('966cf05c-3c1e-4058-8da6-121f84bf8c57', '57200', 'Biaya Pelaksanaan Program Majelis & Lembaga', 'a80f9290-d3ed-4a53-bee4-d6b3b3132655', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:42', '2026-10-18 21:13:42', NULL),
('9763bfd2-f7a5-4959-85d1-681a7866b758', '42200', 'Kontribusi Bidang Kesehatan', '0f3cda5b-5055-459d-8d8d-5e5d68f77675', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:39', '2026-10-18 21:13:39', NULL),
('9d09958c-0bcf-40ad-b0aa-7cbcff9e3396', '52100', 'Biaya Kertas & ATK', 'ca927261-a07f-4069-b341-1da4715f8735', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:40', '2026-10-18 21:13:40', NULL),
('9d0aaabc-a02f-4aa9-bd14-293bc74ac24c', '11800', 'Pajak Dibayar Dimuka', '69670f62-db4b-4cf3-9d59-ea1782710a9a', '2', '8', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:37', '2026-10-18 21:13:37', NULL),
('9e9430cf-4733-4a62-aec5-be3b1aec108c', '57400', 'Biaya Diskusi dan Kajian', 'a80f9290-d3ed-4a53-bee4-d6b3b3132655', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:43', '2026-10-18 21:13:43', NULL),
('a2548395-e459-4ae8-8b64-34e4bba29636', '40000', 'Pendapatan', NULL, '1', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:38', '2026-10-18 21:13:38', NULL),
('a332ec1f-1086-4baf-81b8-bd6368f76425', '11820', 'PPh Dibayar Dimuka', '9d0aaabc-a02f-4aa9-bd14-293bc74ac24c', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:37', '2026-10-18 21:13:37', NULL),
('a3654a7f-7b1e-4982-92bd-51bc3b688329', '11140', 'Kas di Bank Bukopin Syariah', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:36', '2026-10-18 21:13:36', NULL),
('a5195e2e-a156-49e5-b5a0-80ea61ebcb25', '11810', 'PPN Masukan', '9d0aaabc-a02f-4aa9-bd14-293bc74ac24c', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:37', '2026-10-18 21:13:37', NULL),
('a56fbc97-5851-4bcd-a3a8-c5fd2e479868', '55200', 'Biaya Transport Lokal', 'da96fdd8-4e1e-4892-92a9-79139f1ee124', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:42', '2026-10-18 21:13:42', NULL),
('a63a0d86-6c19-415e-a12c-16e8a8399fda', '11110', 'Kas Ditangan', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:36', '2026-10-18 21:13:36', NULL),
('a6de1d9c-a293-42ba-81ea-ea323546fce2', '11600', 'Tabungan Bueka Assakinah', '69670f62-db4b-4cf3-9d59-ea1782710a9a', '2', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:37', '2026-10-18 21:13:37', NULL),
('a6ed472b-5760-4208-8475-7c4a6c6b590b', '44001', 'Kerjasama Internal', '93556b2c-37cd-4485-ad00-b5c68e1f33d2', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:39', '2026-10-18 21:13:39', NULL),
('a80f9290-d3ed-4a53-bee4-d6b3b3132655', '57000', 'Biaya Program Organisasi', 'f2cbf766-2947-48e3-9805-43baa3995e18', '2', '7', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:42', '2026-10-18 21:13:42', NULL),
('a9eba201-b18d-49d5-90c9-91a1c380de89', '59200', 'Biaya Bunga Bank', '1dc22728-2840-44a6-98ef-28897c3e4274', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:43', '2026-10-18 21:13:43', NULL),
('ac3c3366-b999-4679-a55f-21f354a16ab8', '42100', 'Kontribusi Bidang Pendidikan', '0f3cda5b-5055-459d-8d8d-5e5d68f77675', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:39', '2026-10-18 21:13:39', NULL),
('ae5c7707-0f31-49ac-887f-42618104552c', '57205', 'Biaya Program Pimbinaan Kader', '966cf05c-3c1e-4058-8da6-121f84bf8c57', '4', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:42', '2026-10-18 21:13:42', NULL),
('b10f8046-1fd1-4ecd-9d11-9234795440b7', '57500', 'Biaya Pelaksanaan Program Kerjasama', 'a80f9290-d3ed-4a53-bee4-d6b3b3132655', '3', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:43', '2026-10-18 21:13:43', NULL),
('b22b30bd-f081-4d6d-bb12-1b9d39238239', '12400', 'Meubel', '7265dbca-563d-4f78-9251-f55930a8a93a', '2', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:37', '2026-10-18 21:13:37', NULL),
('b2fa48ba-58ea-4c26-8d22-55a5cab54a07', '52700', 'Biaya Pemeliharaan Kendaraan', 'ca927261-a07f-4069-b341-1da4715f8735', '3', '7', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:40', '2026-10-18 21:13:40', NULL),
('b7a89777-0db8-4098-b4fb-e324af14436e', '54200', 'Biaya Sidang Muswil/Muspimwil/Konsolidasi & Pembinaan AMM', '3342e9fa-a2a8-4777-87d8-fb31912a74f3', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:41', '2026-10-18 21:13:41', NULL),
('b8297b98-cf13-4c0e-8059-d1963767183a', '52900', 'Biaya Pemeliharaan Meubel', 'ca927261-a07f-4069-b341-1da4715f8735', '3', '9', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:40', '2026-10-18 21:13:40', NULL),
('b83b2cf8-b4ec-4d2e-8694-04bf58bf4237', '57204', 'Biaya Program Ekonomi dan Ketenagakerjaan', '966cf05c-3c1e-4058-8da6-121f84bf8c57', '4', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:42', '2026-10-18 21:13:42', NULL),
('b8ef7dd7-9448-4a06-8fe6-dd78fa4f4a67', '52300', 'Biaya surat kabar & langganan Media', 'ca927261-a07f-4069-b341-1da4715f8735', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:40', '2026-10-18 21:13:40', NULL),
('bb345ca5-48a7-41e1-b4f7-2892e876b53b', '59999', 'Biaya Sosial & Lainnya', 'f2cbf766-2947-48e3-9805-43baa3995e18', '2', '10', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:43', '2026-10-18 21:13:43', NULL),
('bdf553f9-8062-4f27-9d98-d4703921c3d4', '53300', 'Depresiasi Meubel', '8426372e-1021-455c-8ad7-7195b2425481', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:41', '2026-10-18 21:13:41', NULL),
('bf575919-9801-45cf-afc8-868cea1e7066', '51003', 'Insentif Lembur Karyawan & Staf', 'eddb12cc-89d3-4a23-9dbe-2631b540191a', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:40', '2026-10-18 21:13:40', NULL),
('c0b0222e-d24f-45e0-a439-d81e3a5b5b6c', '57203', 'Biaya Program Majelis Kesehatan', '966cf05c-3c1e-4058-8da6-121f84bf8c57', '4', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:42', '2026-10-18 21:13:42', NULL),
('c125b827-b451-4b41-bcee-ec53e35b1ce0', '51004', 'Uang Makan Karyawan & Staf', 'eddb12cc-89d3-4a23-9dbe-2631b540191a', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:40', '2026-10-18 21:13:40', NULL),
('c1dbe39f-5b4d-4046-abb1-d84388b46723', '52012', 'Biaya BBM', 'ca927261-a07f-4069-b341-1da4715f8735', '3', '12', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:41', '2026-10-18 21:13:41', NULL),
('c3421138-08a8-4e81-a760-88484c7e689d', '31000', 'Aset Bersih', NULL, '1', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567892', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:38', '2026-10-18 21:13:38', NULL),
('c4ae0536-f42c-4785-854d-4f2180a936a5', '55400', 'Perdiem Pengiriman Utusan', 'da96fdd8-4e1e-4892-92a9-79139f1ee124', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:42', '2026-10-18 21:13:42', NULL),
('c9f4ed84-c694-44e5-93f5-0c273481e6e3', '54400', 'Biaya Sidang Muktamar', '3342e9fa-a2a8-4777-87d8-fb31912a74f3', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:41', '2026-10-18 21:13:41', NULL),
('ca927261-a07f-4069-b341-1da4715f8735', '52000', 'Biaya Tata Usaha Administrasi Kantor', 'f2cbf766-2947-48e3-9805-43baa3995e18', '2', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:40', '2026-10-18 21:13:40', NULL),
('d091792e-990d-4f5b-8795-32064cd10d23', '42400', 'Kontribusi Media', '0f3cda5b-5055-459d-8d8d-5e5d68f77675', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:39', '2026-10-18 21:13:39', NULL),
('d0cf1368-347c-4b97-99b6-c0fc88f0392e', '41500', 'Dana Bantuan Organisasi Lainnya', '5afd9a05-58cf-431c-a1f3-d7f3552db08f', '3', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:39', '2026-10-18 21:13:39', NULL),
('d6ee4095-bab6-4143-95a3-c61b3bd47667', '57206', 'Biaya Program Kesejahteraan Sosial', '966cf05c-3c1e-4058-8da6-121f84bf8c57', '4', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:42', '2026-10-18 21:13:42', NULL),
('d8bcabe8-a64d-4af9-87ee-94d7a2dad1f7', '54100', 'Biaya Sidang Rutin, Pleno dll', '3342e9fa-a2a8-4777-87d8-fb31912a74f3', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:41', '2026-10-18 21:13:41', NULL),
('da9192c0-a4d4-4460-a8da-e749ff26aae7', '57210', 'Biaya Program Lingkungan Hidup dan Penanggulangan Bencana', '966cf05c-3c1e-4058-8da6-121f84bf8c57', '4', '10', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:43', '2026-10-18 21:13:43', NULL),
('da96fdd8-4e1e-4892-92a9-79139f1ee124', '55000', 'Biaya Perjalanan Dinas', 'f2cbf766-2947-48e3-9805-43baa3995e18', '2', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:41', '2026-10-18 21:13:41', NULL),
('df8898d0-483f-41a2-8d75-e107da9959ed', '31100', 'Modal Tetap', 'c3421138-08a8-4e81-a760-88484c7e689d', '2', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567892', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:38', '2026-10-18 21:13:38', NULL),
('dfca8b6c-5b37-410c-a4fb-a939792edd63', '52200', 'Biaya Listrik, Telepon, Air, & Internet', 'ca927261-a07f-4069-b341-1da4715f8735', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:40', '2026-10-18 21:13:40', NULL),
('e3666622-08f3-4efc-9d49-8e63626ab11f', '56000', 'Biaya Pengembangan SDM', 'f2cbf766-2947-48e3-9805-43baa3995e18', '2', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:42', '2026-10-18 21:13:42', NULL),
('e46aa620-6712-4ee1-bae3-47fd6a09e3dc', '12600', 'Investasi Jangka Panjang', '7265dbca-563d-4f78-9251-f55930a8a93a', '2', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:38', '2026-10-18 21:13:38', NULL),
('e51f3483-8b24-4b95-bcb7-56c47e85456d', '12300', 'Kendaraan', '7265dbca-563d-4f78-9251-f55930a8a93a', '2', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:37', '2026-10-18 21:13:37', NULL),
('e64435ad-0fd3-4d4d-87dc-10ba7dc171a4', '58100', 'Tunjangan Hari Raya', '9306d1b1-c8c5-4f57-9adb-a981d678de21', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:43', '2026-10-18 21:13:43', NULL),
('e6db6cf4-dec7-4ac2-81f6-f14660c0c1c2', '43000', 'Pendapatan Jasa Bank (Neto)', 'a2548395-e459-4ae8-8b64-34e4bba29636', '2', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:39', '2026-10-18 21:13:39', NULL),
('ea8c6555-0f32-4df4-b036-5c92a59dc58a', '31200', 'Modal Lancar', 'c3421138-08a8-4e81-a760-88484c7e689d', '2', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567892', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:38', '2026-10-18 21:13:38', NULL),
('ead97936-cbb9-41ec-a101-4534a94086c2', '11700', 'Kos Wonorejo', '69670f62-db4b-4cf3-9d59-ea1782710a9a', '2', '7', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:37', '2026-10-18 21:13:37', NULL),
('eddb12cc-89d3-4a23-9dbe-2631b540191a', '51000', 'Biaya Personalia', 'f2cbf766-2947-48e3-9805-43baa3995e18', '2', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:40', '2026-10-18 21:13:40', NULL),
('ef0ab049-3707-4b8e-a7ba-53d1f3ad3694', '52013', 'Biaya Parkir', 'ca927261-a07f-4069-b341-1da4715f8735', '3', '13', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:41', '2026-10-18 21:13:41', NULL),
('efea6b42-9857-4194-aad9-3090e2971a40', '55100', 'Biaya Tiket', 'da96fdd8-4e1e-4892-92a9-79139f1ee124', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:42', '2026-10-18 21:13:42', NULL),
('f2cbf766-2947-48e3-9805-43baa3995e18', '50000', 'Beban Operasional', NULL, '1', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-18 21:13:40', '2026-10-18 21:13:40', NULL),
('f8e99bee-b99a-4e06-8485-816e9e7cc363', '11500', 'Penyertaan Modal Bueka Assakinah', '69670f62-db4b-4cf3-9d59-ea1782710a9a', '2', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:37', '2026-10-18 21:13:37', NULL),
('fde4c6ca-4c2c-4764-8027-19270a9e752d', '11100', 'Kas', '69670f62-db4b-4cf3-9d59-ea1782710a9a', '2', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-18 21:13:36', '2026-10-18 21:13:36', NULL);

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
('01a152c8-35dd-7374-9789-3e338a69ebb9', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DEBIT', 194604157.00, '2026-10-18 23:10:15', '2026-10-18 23:10:15'),
('01a152c8-35e6-71a9-b634-233fd483c9b2', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DEBIT', 4983047.00, '2026-10-18 23:10:15', '2026-10-18 23:10:15'),
('01a152c8-35ee-7181-9ac5-12d96b63aa15', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', '07273ff4-96b4-4756-8f70-a34e66bb36d0', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DEBIT', 405484747.00, '2026-10-18 23:10:15', '2026-10-18 23:10:15'),
('01a152c8-35f1-71cd-85f6-77cb7348b808', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', '217611bd-73a7-48d8-be5e-9b67041b0093', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DEBIT', 1156982563.00, '2026-10-18 23:10:15', '2026-10-18 23:10:15'),
('01a152c8-35f3-729f-9df4-2188140f02d1', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', 'a3654a7f-7b1e-4982-92bd-51bc3b688329', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DEBIT', 377940865.00, '2026-10-18 23:10:15', '2026-10-18 23:10:15'),
('01a152c8-35f7-71e3-86af-57e95f0c0a47', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', '54a2c8f7-8bf2-4baf-a30e-52863c7b15db', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DEBIT', 1800000.00, '2026-10-18 23:10:15', '2026-10-18 23:10:15'),
('01a152c8-35f9-710f-b537-7d6c83bf43a5', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', '3c63e3d3-31df-40ee-a780-b36f628c1b3e', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DEBIT', 921735276.00, '2026-10-18 23:10:15', '2026-10-18 23:10:15'),
('01a152c8-35fc-700b-a308-6d87988a1f4a', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', 'e51f3483-8b24-4b95-bcb7-56c47e85456d', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DEBIT', 460769432.00, '2026-10-18 23:10:15', '2026-10-18 23:10:15'),
('01a152c8-35ff-72cb-bff1-04e31038f3f0', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', '5f5c44e2-728d-4fd5-bb5d-431361a7891c', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREDIT', 144000000.00, '2026-10-18 23:10:15', '2026-10-18 23:10:15'),
('01a152c8-3601-7239-be46-e4f4866e5776', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', 'b22b30bd-f081-4d6d-bb12-1b9d39238239', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DEBIT', 15500000.00, '2026-10-18 23:10:15', '2026-10-18 23:10:15'),
('01a152c8-3603-730b-91a4-5026393499a7', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', '757cde74-832b-4164-97be-82b78afb6b9f', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREDIT', 13376668.00, '2026-10-18 23:10:15', '2026-10-18 23:10:15'),
('01a152c8-3605-7240-8017-375172bac174', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', '0f9579c0-6cc3-4458-aa0b-f9a15acd9578', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DEBIT', 46059000.00, '2026-10-18 23:10:15', '2026-10-18 23:10:15'),
('01a152c8-3607-736d-a38b-51178ac7d67d', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', '902753ad-a0f2-4506-bb23-e77b2fab6f32', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREDIT', 25236667.00, '2026-10-18 23:10:15', '2026-10-18 23:10:15'),
('01a152c8-360a-71b3-a804-b2be222693bd', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', 'df8898d0-483f-41a2-8d75-e107da9959ed', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREDIT', 339715097.00, '2026-10-18 23:10:15', '2026-10-18 23:10:15'),
('01a152c8-360c-7146-9168-bbb54d6abc6b', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', 'ea8c6555-0f32-4df4-b036-5c92a59dc58a', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREDIT', 368679944.00, '2026-10-18 23:10:15', '2026-10-18 23:10:15'),
('01a152c8-360d-70b9-9338-496deb2d1d00', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', '14dc35fc-8cf0-47f2-b41f-55de875caf32', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREDIT', 2694850711.00, '2026-10-18 23:10:15', '2026-10-18 23:10:15');

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
('01a152c0-fb7a-71aa-bb4e-a273e09dc79a', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', 194604157.00, 0.00, 0.00, 0.00, '2026-10-18 23:02:21', NULL, '2026-10-18 23:02:21', '2026-10-18 23:21:42'),
('01a152c1-4406-73be-b7f0-d1de8925aee2', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', 4983047.00, 0.00, 0.00, 0.00, '2026-10-18 23:02:40', NULL, '2026-10-18 23:02:40', '2026-10-20 11:39:20'),
('01a152c1-b149-7325-aa9b-84e0abdc11f0', '07273ff4-96b4-4756-8f70-a34e66bb36d0', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', 405484747.00, 0.00, 0.00, 405484747.00, '2026-10-18 23:03:07', NULL, '2026-10-18 23:03:07', '2026-10-18 23:03:07'),
('01a152c2-19c6-7247-8a97-0d71edfdf3fa', '217611bd-73a7-48d8-be5e-9b67041b0093', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', 1156982563.00, 0.00, 0.00, 0.00, '2026-10-18 23:03:34', NULL, '2026-10-18 23:03:34', '2026-10-18 23:23:46'),
('01a152c2-8f93-73e4-8d1c-10c02581507b', 'a3654a7f-7b1e-4982-92bd-51bc3b688329', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', 377940865.00, 0.00, 0.00, 377940865.00, '2026-10-18 23:04:04', NULL, '2026-10-18 23:04:04', '2026-10-18 23:04:04'),
('01a152c3-0224-73ee-95c3-655e3e7a2110', '54a2c8f7-8bf2-4baf-a30e-52863c7b15db', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', 1800000.00, 0.00, 0.00, 1800000.00, '2026-10-18 23:04:34', NULL, '2026-10-18 23:04:34', '2026-10-18 23:04:34'),
('01a152c3-724c-702f-8963-b45a9313c57a', '3c63e3d3-31df-40ee-a780-b36f628c1b3e', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', 921735276.00, 0.00, 0.00, 921735276.00, '2026-10-18 23:05:02', NULL, '2026-10-18 23:05:02', '2026-10-18 23:05:02'),
('01a152c3-dd10-7296-8400-f4ae98c3797e', 'e51f3483-8b24-4b95-bcb7-56c47e85456d', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', 460769432.00, 0.00, 0.00, 460769432.00, '2026-10-18 23:05:30', NULL, '2026-10-18 23:05:30', '2026-10-18 23:05:30'),
('01a152c4-5e6b-708f-9f08-b9707e6152de', '5f5c44e2-728d-4fd5-bb5d-431361a7891c', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', 144000000.00, 0.00, 0.00, 144000000.00, '2026-10-18 23:06:03', NULL, '2026-10-18 23:06:03', '2026-10-18 23:06:03'),
('01a152c4-d16a-7372-91c4-0185a241a45b', 'b22b30bd-f081-4d6d-bb12-1b9d39238239', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', 15500000.00, 0.00, 0.00, 15500000.00, '2026-10-18 23:06:32', NULL, '2026-10-18 23:06:32', '2026-10-18 23:06:32'),
('01a152c5-213b-70de-b770-9411145077f6', '757cde74-832b-4164-97be-82b78afb6b9f', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', 13376668.00, 0.00, 0.00, 13376668.00, '2026-10-18 23:06:53', NULL, '2026-10-18 23:06:53', '2026-10-18 23:06:53'),
('01a152c5-7a3e-737a-bbc4-cafc089154b2', '0f9579c0-6cc3-4458-aa0b-f9a15acd9578', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', 46059000.00, 0.00, 0.00, 46059000.00, '2026-10-18 23:07:16', NULL, '2026-10-18 23:07:16', '2026-10-18 23:07:16'),
('01a152c5-d50a-7385-8ff5-97b720bc8f51', '902753ad-a0f2-4506-bb23-e77b2fab6f32', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', 25236667.00, 0.00, 0.00, 25236667.00, '2026-10-18 23:07:39', NULL, '2026-10-18 23:07:39', '2026-10-18 23:07:39'),
('01a152c6-80d4-7296-ad3a-f8bf223fc952', 'df8898d0-483f-41a2-8d75-e107da9959ed', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', 339715097.00, 0.00, 0.00, 339715097.00, '2026-10-18 23:08:23', NULL, '2026-10-18 23:08:23', '2026-10-18 23:08:23'),
('01a152c6-dbb4-73ae-9a67-bec3cf4e0479', 'ea8c6555-0f32-4df4-b036-5c92a59dc58a', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', 368679944.00, 0.00, 0.00, 368679944.00, '2026-10-18 23:08:46', NULL, '2026-10-18 23:08:46', '2026-10-18 23:08:46'),
('01a152c7-c8d8-7134-9e39-d4a70f72edfd', '14dc35fc-8cf0-47f2-b41f-55de875caf32', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', 2694850711.00, 0.00, 0.00, 2694850711.00, '2026-10-18 23:09:47', NULL, '2026-10-18 23:09:47', '2026-10-18 23:09:47'),
('01a152ca-72b3-7137-8ad7-86c5f17a3e91', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', 194604157.00, 425000000.00, 352439025.00, 267165132.00, '2026-10-20 08:47:02', NULL, '2026-10-18 23:12:41', '2026-10-20 08:47:02'),
('01a152ca-ab18-716b-8e10-802da61946b7', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', 4983047.00, 118185975.00, 1448000.00, 121721022.00, '2026-10-20 22:06:59', NULL, '2026-10-18 23:12:56', '2026-10-20 22:06:59'),
('01a152ca-e6a3-7080-97a4-c14539af3224', '07273ff4-96b4-4756-8f70-a34e66bb36d0', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', 405484747.00, 0.00, 0.00, 405484747.00, '2026-10-18 23:13:11', NULL, '2026-10-18 23:13:11', '2026-10-18 23:13:11'),
('01a152cb-23e7-7358-ba98-57e5ef5e0cde', '217611bd-73a7-48d8-be5e-9b67041b0093', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', 1156982563.00, 733644.00, 200176728.00, 957539479.00, '2026-10-20 06:41:59', NULL, '2026-10-18 23:13:27', '2026-10-20 06:41:59'),
('01a152cb-72a2-731f-9f72-f272578d0664', 'a3654a7f-7b1e-4982-92bd-51bc3b688329', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', 377940865.00, 0.00, 0.00, 377940865.00, '2026-10-18 23:13:47', NULL, '2026-10-18 23:13:47', '2026-10-18 23:13:47'),
('01a152cb-ba62-70f2-995b-60b139bd498f', '54a2c8f7-8bf2-4baf-a30e-52863c7b15db', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', 1800000.00, 0.00, 200000.00, 1600000.00, '2026-10-20 11:46:23', NULL, '2026-10-18 23:14:05', '2026-10-20 11:46:23'),
('01a152cb-f683-72d9-845f-ae7e1c275248', '3c63e3d3-31df-40ee-a780-b36f628c1b3e', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', 921735276.00, 0.00, 0.00, 921735276.00, '2026-10-18 23:14:21', NULL, '2026-10-18 23:14:21', '2026-10-18 23:14:21'),
('01a152cc-3609-7091-9ce5-aea29a93524e', 'e51f3483-8b24-4b95-bcb7-56c47e85456d', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', 460769432.00, 0.00, 0.00, 460769432.00, '2026-10-18 23:14:37', NULL, '2026-10-18 23:14:37', '2026-10-18 23:14:37'),
('01a152cc-7e8d-7301-ab50-ef56d577d3b0', '5f5c44e2-728d-4fd5-bb5d-431361a7891c', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', 144000000.00, 0.00, 0.00, 144000000.00, '2026-10-18 23:14:55', NULL, '2026-10-18 23:14:55', '2026-10-18 23:14:55'),
('01a152cc-b8f7-70c6-9754-568e0eb854aa', 'b22b30bd-f081-4d6d-bb12-1b9d39238239', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', 15500000.00, 0.00, 0.00, 15500000.00, '2026-10-18 23:15:10', NULL, '2026-10-18 23:15:10', '2026-10-18 23:15:10'),
('01a152cc-f572-7304-924a-2c5842f54f5d', '757cde74-832b-4164-97be-82b78afb6b9f', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', 13376668.00, 0.00, 0.00, 13376668.00, '2026-10-18 23:15:26', NULL, '2026-10-18 23:15:26', '2026-10-18 23:15:26'),
('01a152cd-2df7-70c9-9dce-a7e9966e9c1c', '0f9579c0-6cc3-4458-aa0b-f9a15acd9578', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', 46059000.00, 0.00, 0.00, 46059000.00, '2026-10-18 23:15:40', NULL, '2026-10-18 23:15:40', '2026-10-18 23:15:40'),
('01a152cd-6439-7306-a041-628766a08d01', '902753ad-a0f2-4506-bb23-e77b2fab6f32', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', 25236667.00, 0.00, 0.00, 25236667.00, '2026-10-18 23:15:54', NULL, '2026-10-18 23:15:54', '2026-10-18 23:15:54'),
('01a152cd-afc8-71a7-bebc-edf3e2943468', 'df8898d0-483f-41a2-8d75-e107da9959ed', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', 339715097.00, 0.00, 0.00, 339715097.00, '2026-10-18 23:16:14', NULL, '2026-10-18 23:16:14', '2026-10-18 23:16:14'),
('01a152cd-f8b7-7113-9e60-6d7f462919b0', 'ea8c6555-0f32-4df4-b036-5c92a59dc58a', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', 368679944.00, 0.00, 0.00, 368679944.00, '2026-10-18 23:16:32', NULL, '2026-10-18 23:16:32', '2026-10-18 23:16:32'),
('01a152ce-3631-7171-9c93-188979df5ad8', '14dc35fc-8cf0-47f2-b41f-55de875caf32', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', 2694850711.00, 0.00, 0.00, 2694850711.00, '2026-10-18 23:16:48', NULL, '2026-10-18 23:16:48', '2026-10-18 23:16:48'),
('01a152f6-ddf5-7239-940d-b053a7efcec3', 'e6db6cf4-dec7-4ac2-81f6-f14660c0c1c2', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', 0.00, 0.00, 733644.00, -733644.00, '2026-10-20 05:44:20', NULL, '2026-10-19 00:01:12', '2026-10-20 05:44:20'),
('01a15958-7d82-705d-9ce5-a3d84001d0de', '1dc22728-2840-44a6-98ef-28897c3e4274', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', 0.00, 191728.00, 0.00, -191728.00, '2026-10-20 08:43:35', NULL, '2026-10-20 05:45:33', '2026-10-20 08:43:35'),
('01a159ba-2a48-7267-b687-fd4c752d1c23', 'b83b2cf8-b4ec-4d2e-8694-04bf58bf4237', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', 0.00, 112520550.00, 0.00, -112520550.00, '2026-10-20 08:43:35', NULL, '2026-10-20 07:32:15', '2026-10-20 08:43:35'),
('01a159bb-98a3-719a-97c2-6c22314e04f7', 'bf575919-9801-45cf-afc8-868cea1e7066', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', 0.00, 200000.00, 0.00, -200000.00, '2026-10-20 07:33:48', NULL, '2026-10-20 07:33:48', '2026-10-20 07:33:48'),
('01a159bc-247d-73fb-8584-2c0df5ca2f14', 'b7a89777-0db8-4098-b4fb-e324af14436e', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', 0.00, 122222500.00, 0.00, -122222500.00, '2026-10-20 11:48:29', NULL, '2026-10-20 07:34:24', '2026-10-20 11:48:29'),
('01a159c1-6313-729b-aa7c-b01288c13510', '9d09958c-0bcf-40ad-b0aa-7cbcff9e3396', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', 0.00, 225000.00, 0.00, -225000.00, '2026-10-20 07:41:33', NULL, '2026-10-20 07:40:08', '2026-10-20 07:41:33'),
('01a159c1-6331-7148-a2b7-782c0f8a5f6c', 'ef0ab049-3707-4b8e-a7ba-53d1f3ad3694', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', 0.00, 412500.00, 0.00, -412500.00, '2026-10-20 11:43:27', NULL, '2026-10-20 07:40:08', '2026-10-20 11:43:27'),
('01a159f8-ff45-7072-81ab-6f6590e70433', 'd0cf1368-347c-4b97-99b6-c0fc88f0392e', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', 0.00, 0.00, 50000000.00, -50000000.00, '2026-10-20 08:40:52', NULL, '2026-10-20 08:40:52', '2026-10-20 08:40:52'),
('01a159fc-d7e4-7136-9e06-887811f33ad4', '3aed7fc1-a08f-4eee-a040-29e34c846836', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', 0.00, 0.00, 175000000.00, -175000000.00, '2026-10-20 08:45:05', NULL, '2026-10-20 08:45:04', '2026-10-20 08:45:05'),
('01a159fe-14df-7168-81b9-98c71641bc71', 'a56fbc97-5851-4bcd-a3a8-c5fd2e479868', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', 0.00, 162500.00, 0.00, -162500.00, '2026-10-20 08:46:26', NULL, '2026-10-20 08:46:26', '2026-10-20 08:46:26'),
('01a15cdb-01fd-7184-b807-c8192c2a349e', 'dfca8b6c-5b37-410c-a4fb-a939792edd63', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', 0.00, 143000.00, 0.00, -143000.00, '2026-10-20 22:06:59', NULL, '2026-10-20 22:06:59', '2026-10-20 22:06:59');

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
('01a1525d-4288-720f-9813-986a83c14b95', 'APP_NAME', 'My Laravel App', 'string', 'Nama aplikasi yang akan ditampilkan di berbagai tempat seperti judul halaman.', 1, '2026-10-18 21:13:26', '2026-10-18 21:13:26'),
('01a1525d-42a8-7194-a716-95861fdaa95c', 'APP_DESCRIPTION', 'Sistem Informasi Akuntansi untuk pengelolaan keuangan, jurnal, dan laporan secara terintegrasi.', 'string', 'Deskripsi singkat tentang aplikasi yang dapat digunakan untuk SEO atau ditampilkan di halaman utama.', 1, '2026-10-18 21:13:26', '2026-10-18 21:13:26'),
('01a1525d-42e6-71ad-b0a2-549c32410b4e', 'APP_TAGLINE', 'Sistem Informasi Akuntansi untuk pengelolaan keuangan, jurnal, dan laporan secara terintegrasi.', 'string', 'Tagline atau slogan yang menggambarkan nilai utama aplikasi.', 1, '2026-10-18 21:13:26', '2026-10-18 21:13:26'),
('01a1525d-431e-7068-8308-3fa097980a0c', 'APP_LOGO', NULL, 'image', 'Logo aplikasi yang akan ditampilkan di header atau halaman login.', 1, '2026-10-18 21:13:26', '2026-10-18 21:13:26'),
('01a1525d-435c-7048-ae4b-e6a4a1bd58e9', 'APP_BACKGROUND_LOGIN', NULL, 'image', 'Gambar latar belakang untuk halaman login aplikasi.', 1, '2026-10-18 21:13:26', '2026-10-18 21:13:26');

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
('01a152d2-b247-7264-a6db-9df48f808088', 'JRN-20261019062142', '2023-01-01', 'Pembagian saldo ke pengguna', 194604157.00, 194604157.00, '01a1525d-6541-71d8-a795-c2ec45ab6289', '2026-10-19 06:21:42', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', NULL, '2026-10-18 23:21:42', '2026-10-18 23:21:42'),
('01a152d4-97b1-73cb-94dc-a322fd57eec7', 'JRN-20261019062346', '2026-10-19', 'Pembagian saldo ke pengguna', 1156982563.00, 1156982563.00, '01a1525d-6541-71d8-a795-c2ec45ab6289', '2026-10-19 06:23:46', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', NULL, '2026-10-18 23:23:46', '2026-10-18 23:23:46'),
('01a15957-5e5f-724f-a352-f903818f068a', 'JR-INC-20261020124420', '2023-01-01', 'Penerimaan bunga dari bank', 733644.00, 733644.00, '01a1525d-6541-71d8-a795-c2ec45ab6289', '2026-10-20 12:44:20', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a15957-5e51-7113-bb26-b2600e39d9b5', '2026-10-20 05:44:20', '2026-10-20 05:44:20'),
('01a15958-7d7a-722f-9d2c-9db0108131a8', 'JR-EXP-20261020124533', '2023-01-01', 'Pembayaran pajak tabungan', 146728.00, 146728.00, '01a1525d-6541-71d8-a795-c2ec45ab6289', '2026-10-20 12:45:33', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a15958-7d5c-710b-96e3-c0351f316d47', '2026-10-20 05:45:33', '2026-10-20 05:45:33'),
('01a1598a-5178-72d4-9d07-27a4988117b8', 'JR-EXP-20261020133959', '2023-01-13', 'Pengisian kas', 200000000.00, 200000000.00, '01a1525d-6541-71d8-a795-c2ec45ab6289', '2026-10-20 13:39:59', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a1598a-5165-7169-b7db-eedb29557d7a', '2026-10-20 06:39:59', '2026-10-20 06:39:59'),
('01a1598b-f7cc-7180-ae3a-2f99e3b031f1', 'JR-EXP-20261020134147', '2023-01-27', 'Biaya Admin Giro', 30000.00, 30000.00, '01a1525d-6541-71d8-a795-c2ec45ab6289', '2026-10-20 13:41:47', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a1598b-f7be-72db-909c-15b6f5924325', '2026-10-20 06:41:47', '2026-10-20 06:41:47'),
('01a159b8-4e14-71e0-bdec-68a6c3a5fe89', 'JR-EXP-20261020143013', '2023-01-02', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301021122537792517 Pengisian kas operasional', 2000000.00, 2000000.00, '01a1525d-6541-71d8-a795-c2ec45ab6289', '2026-10-20 14:30:13', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a159b8-4dfd-719a-9c6c-3c51505bba39', '2026-10-20 07:30:13', '2026-10-20 07:30:13'),
('01a159b9-547b-7283-ad77-0c8da0f7bc0d', 'JR-EXP-20261020143120', '2023-01-05', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301051121506253692 Tim UMPRO audensi dengan Gubernur', 3000000.00, 3000000.00, '01a1525d-6541-71d8-a795-c2ec45ab6289', '2026-10-20 14:31:20', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a159b9-5468-7034-a962-37e0bf59a275', '2026-10-20 07:31:20', '2026-10-20 07:31:20'),
('01a159ba-2a2f-73c6-9610-1785521501d2', 'JR-EXP-20261020143215', '2023-01-05', 'Transfer ke BSI norek. 7187244565 an. ABD Rochim reff. 2301051121506826136 Pembangunan Café termin ke 4', 60000000.00, 60000000.00, '01a1525d-6541-71d8-a795-c2ec45ab6289', '2026-10-20 14:32:15', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a159ba-2a17-7061-8959-94f0ba815020', '2026-10-20 07:32:15', '2026-10-20 07:32:15'),
('01a159ba-c92a-7024-90ad-428c786c9bc2', 'JR-EXP-20261020143255', '2023-01-05', 'Administrasi Bank', 2500.00, 2500.00, '01a1525d-6541-71d8-a795-c2ec45ab6289', '2026-10-20 14:32:55', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a159ba-c911-7123-aab0-050a4120af5a', '2026-10-20 07:32:55', '2026-10-20 07:32:55'),
('01a159bb-9897-73cb-a0cb-b830b7f20ea5', 'JR-EXP-20261020143348', '2023-01-05', 'Uang Lembur Yuli untuk persiapan pemeriksaan laporan keuangan (09.00 - 21.00)', 200000.00, 200000.00, '01a1525d-6541-71d8-a795-c2ec45ab6289', '2026-10-20 14:33:48', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a159bb-9882-71b5-b6fb-231090a6956f', '2026-10-20 07:33:48', '2026-10-20 07:33:48'),
('01a159bc-246a-72bb-bd45-d6f06af8b520', 'JR-EXP-20261020143424', '2023-01-07', 'Tambahan transport Rapat persiapan verifikasi keuangan (17 Des 2017) an Kristin Muslimah', 300000.00, 300000.00, '01a1525d-6541-71d8-a795-c2ec45ab6289', '2026-10-20 14:34:24', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a159bc-245f-7375-8055-7a44cfb4037a', '2026-10-20 07:34:24', '2026-10-20 07:34:24'),
('01a159bc-b4b2-71ab-89b6-16ef16cfeb69', 'JR-EXP-20261020143501', '2023-01-07', 'Transport verifikasi LK (6,7,8 Jan 2023) an Kristin Muslimah (PDA Kediri)', 400000.00, 400000.00, '01a1525d-6541-71d8-a795-c2ec45ab6289', '2026-10-20 14:35:01', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a159bc-b49c-703c-b753-af118f3cce65', '2026-10-20 07:35:01', '2026-10-20 07:35:01'),
('01a159bd-e030-7106-8ecb-30c9a3e51cc0', 'JR-EXP-20261020143618', '2023-01-07', 'Tambahan transport Rapat persiapan verifikasi keuangan (17 Des 2017) an. Zubaidatul Hidayah', 200000.00, 200000.00, '01a1525d-6541-71d8-a795-c2ec45ab6289', '2026-10-20 14:36:18', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a159bd-e023-72c7-ab31-ab7aaebd3a1f', '2026-10-20 07:36:18', '2026-10-20 07:36:18'),
('01a159c1-6bac-710c-9683-289deccb4fce', 'JR-EXP-20261020144010', '2023-01-07', 'Transport verifikasi LK (6,7,8 Jan 2023) an Zubaidatul Hidayah (PDA Sidoarjo) dan Tambahan transport Rapat persiapan verifikasi keuangan (17 Des 2017) an. Martiningsih dan Transport verifikasi LK (6,7,8 Jan 2023) an Martiningsih (PDA Ponorogo) dan Pembelian Klip (yuli) dan Tinta print Data Print, lem, isi staples dan Tinta print Data Print, lem, isi staples dan Parkir', 10905000.00, 10905000.00, '01a1525d-6541-71d8-a795-c2ec45ab6289', '2026-10-20 14:40:10', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a159c1-6b92-7293-aed9-605594dbb999', '2026-10-20 07:40:10', '2026-10-20 07:40:10'),
('01a159ee-b2eb-7349-8dab-86a66225be3e', 'JR-EXP-20261020152938', '2023-01-08', 'Transfer ke Bank Jatim Norek. 6202209605 an. Siti Zubaidatul Hidayah (PDA Sidoarjo) reff. JMB371957650 untuk pembayaran honor verifikasi keuangan Aisyiyah dan Transfer ke Bank Syariah Indonesia Norek. 7181048365 an. Martiningsih (PDA Ponorogo) reff. 2301081121511786044 untuk pembayaran honor verifikasi keuangan Aisyiyah dan Biaya Administrasi Bank dan Transfer ke Bank BRI Norek. 625301004203538  an. Kristin Muslimah (PDA Kediri) reff.  497918192617 untuk pembayaran honor verifikasi keuangan Aisyiyah dan Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301081122548316455 untuk pembayaran honor pendamping verifikasi LK Aisyiyah dan Pembayaran honor pendamping verifikasi LK Aisyiyah 3 hari di tambah transpot (Bu Candra Rp. 1.000.000, biaya admin bank Rp. 2500  Bu Anna Marina Rp. 750.000 biaya bank 2500  Bu Heni Rp. 2.500.000 dan Biaya Administrasi Bank', 9757500.00, 9757500.00, '01a1525d-6541-71d8-a795-c2ec45ab6289', '2026-10-20 15:29:38', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a159ee-b2c3-73ad-a0ab-15fc298346dc', '2026-10-20 08:29:38', '2026-10-20 08:29:38'),
('01a159f1-3f68-70b9-927a-e56468ed965c', 'JR-EXP-20261020153225', '2023-01-10', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref. 2301101122551693942 Operasional ATC dan Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301101121515400945 Keperluan tim verifikasi, dana surat keterangan konsultan, dan pembuatan laporan 1% dari dana hibah', 43912975.00, 43912975.00, '01a1525d-6541-71d8-a795-c2ec45ab6289', '2026-10-20 15:32:25', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a159f1-3f4f-73b4-aa2d-e6dc4e5cc881', '2026-10-20 08:32:25', '2026-10-20 08:32:25'),
('01a159f1-f135-7159-a875-e83173897bbd', 'JR-EXP-20261020153310', '2023-01-13', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301131122557316522 untuk kebutuhan Muswil', 35000000.00, 35000000.00, '01a1525d-6541-71d8-a795-c2ec45ab6289', '2026-10-20 15:33:10', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a159f1-f121-7225-9555-db217567f41e', '2026-10-20 08:33:10', '2026-10-20 08:33:10'),
('01a159f6-dfa6-73b0-9183-233ac38c37d4', 'JR-EXP-20261020153833', '2023-01-16', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301131122557316522 untuk kebutuhan Muswil', 19700000.00, 19700000.00, '01a1525d-6541-71d8-a795-c2ec45ab6289', '2026-10-20 15:38:33', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a159f6-df9a-7188-8de2-644c55dc8782', '2026-10-20 08:38:33', '2026-10-20 08:38:33'),
('01a159f8-ff34-70a0-99d9-76ca79405176', 'JR-INC-20261020154052', '2023-01-21', 'Pemasukan dari Gubernur Jatim untuk bantuan Muswil diberikan ke bu Candra tunai', 50000000.00, 50000000.00, '01a1525d-6541-71d8-a795-c2ec45ab6289', '2026-10-20 15:40:52', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a159f8-ff19-720f-8c97-7138392d926c', '2026-10-20 08:40:52', '2026-10-20 08:40:52'),
('01a159fa-2ec3-7149-a795-a88e113cfe29', 'JR-EXP-20261020154210', '2023-01-24', 'Transfer ke BRI Norek. 115901020724505 an. Fitrijah Hidajati ref. 2301241122573568558 untuk kekurangan dana Muswil dan Biaya Administrasi Bank', 100002500.00, 100002500.00, '01a1525d-6541-71d8-a795-c2ec45ab6289', '2026-10-20 15:42:10', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a159fa-2ea6-73b5-8c7c-d84068fcff22', '2026-10-20 08:42:10', '2026-10-20 08:42:10'),
('01a159fb-78ca-7181-ae8f-14a1a7d18c5a', 'JR-EXP-20261020154335', '2023-01-25', 'Transfer ke BCA an. Rahmad Deky Zakaria Norek. 0190548848 ref.2301251121539574926 untuk membayaran interior termin 1 dan Biaya Administrasi Bank', 52523050.00, 52523050.00, '01a1525d-6541-71d8-a795-c2ec45ab6289', '2026-10-20 15:43:35', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a159fb-78ba-71dd-bcbe-3cda5690d8e8', '2026-10-20 08:43:35', '2026-10-20 08:43:35'),
('01a159fc-d7d4-7256-a9f9-75264181e557', 'JR-INC-20261020154504', '2023-01-27', 'Pemasukan bantuan Muswil dari PWM (cek bank Muamalat)', 175000000.00, 175000000.00, '01a1525d-6541-71d8-a795-c2ec45ab6289', '2026-10-20 15:45:04', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a159fc-d7c5-7149-b40c-9dcd74decdfb', '2026-10-20 08:45:04', '2026-10-20 08:45:04'),
('01a159fe-14d9-71ee-89fd-5a3c0b8ab33a', 'JR-EXP-20261020154626', '2023-01-27', 'Transport (grab) mengantar cek bank Muamallat dan mencairkan cek bank Muamalllat di Jl. Darmo Surabaya, Administrasi bank (yuli) dan Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301271122579384345 untuk honor pegawai PWA', 9535500.00, 9535500.00, '01a1525d-6541-71d8-a795-c2ec45ab6289', '2026-10-20 15:46:26', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a159fe-14c7-70da-a37d-84a6f63f8717', '2026-10-20 08:46:26', '2026-10-20 08:46:26'),
('01a159fe-a2f6-718e-9f2e-8d129eba41d4', 'JR-EXP-20261020154702', '2023-01-31', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301311122586946308 untuk kas operasional', 5000000.00, 5000000.00, '01a1525d-6541-71d8-a795-c2ec45ab6289', '2026-10-20 15:47:02', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a159fe-a2e2-7242-ae59-2fae214c4e62', '2026-10-20 08:47:02', '2026-10-20 08:47:02'),
('01a15a9c-6041-7180-8f83-05d2557e463c', 'JRN-20261020183920', '2026-10-20', 'Pembagian saldo ke pengguna', 4983047.00, 4983047.00, '01a1525d-6541-71d8-a795-c2ec45ab6289', '2026-10-20 18:39:20', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', NULL, '2026-10-20 11:39:20', '2026-10-20 11:39:20'),
('01a15aa0-24d7-7099-ade3-2d94b05682e2', 'JR-EXP-20261020184327', '2023-01-01', 'Transfer Parkir + Biaya', 402500.00, 402500.00, '01a1525d-6864-72ea-ad31-f231a54b1b9e', '2026-10-20 18:43:27', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a15aa0-24c7-7397-9b2c-e78d7e10de30', '2026-10-20 11:43:27', '2026-10-20 11:43:27'),
('01a15aa2-d69d-7265-aa5c-92ebd4aa97d0', 'JR-INC-20261020184623', '2023-01-01', 'Cicilan 3 Pak Edi', 200000.00, 200000.00, '01a1525d-6864-72ea-ad31-f231a54b1b9e', '2026-10-20 18:46:23', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a15aa2-d691-70e1-b12f-03d38ca381c6', '2026-10-20 11:46:23', '2026-10-20 11:46:23'),
('01a15aa4-c28b-703b-b0ac-d3bb1d0388ea', 'JR-EXP-20261020184829', '2023-01-02', 'Transfer Transport Tim Panlih Daerah', 902500.00, 902500.00, '01a1525d-6864-72ea-ad31-f231a54b1b9e', '2026-10-20 18:48:29', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a15aa4-c27e-7293-8c0a-bf150d01d619', '2026-10-20 11:48:29', '2026-10-20 11:48:29'),
('01a15cdb-01f0-7313-84d7-45a941946d64', 'JR-EXP-20261021050659', '2023-01-02', 'Biaya Zoom', 143000.00, 143000.00, '01a1525d-6864-72ea-ad31-f231a54b1b9e', '2026-10-21 05:06:59', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a15cdb-01d9-7227-bd48-be2bd9d98ab8', '2026-10-20 22:06:59', '2026-10-20 22:06:59');

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
('01a152d2-b249-7233-82ec-84f9f3b1cb2d', '01a152d2-b247-7264-a6db-9df48f808088', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 194604157.00, 0.00, 'Distribusi saldo ke user', '2026-10-18 23:21:42', '2026-10-18 23:21:42'),
('01a152d2-b24a-722a-8d49-3c7bca5379f9', '01a152d2-b247-7264-a6db-9df48f808088', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 0.00, 194604157.00, 'Pengurangan saldo akun', '2026-10-18 23:21:42', '2026-10-18 23:21:42'),
('01a152d4-97bc-715e-8d0f-2494eddbcb09', '01a152d4-97b1-73cb-94dc-a322fd57eec7', '217611bd-73a7-48d8-be5e-9b67041b0093', 1156982563.00, 0.00, 'Distribusi saldo ke user', '2026-10-18 23:23:46', '2026-10-18 23:23:46'),
('01a152d4-97bf-73f0-8ed0-fa3363373b52', '01a152d4-97b1-73cb-94dc-a322fd57eec7', '217611bd-73a7-48d8-be5e-9b67041b0093', 0.00, 1156982563.00, 'Pengurangan saldo akun', '2026-10-18 23:23:46', '2026-10-18 23:23:46'),
('01a15957-5e62-7063-bab5-e9a4b617727e', '01a15957-5e5f-724f-a352-f903818f068a', '217611bd-73a7-48d8-be5e-9b67041b0093', 733644.00, 0.00, 'Mutasi Kas Masuk', '2026-10-20 05:44:20', '2026-10-20 05:44:20'),
('01a15957-5e6e-73d3-863d-049329b000e1', '01a15957-5e5f-724f-a352-f903818f068a', 'e6db6cf4-dec7-4ac2-81f6-f14660c0c1c2', 0.00, 733644.00, 'Penerimaan bunga dari bank', '2026-10-20 05:44:20', '2026-10-20 05:44:20'),
('01a15958-7d7d-71d0-b2d6-e8bf9870384e', '01a15958-7d7a-722f-9d2c-9db0108131a8', '1dc22728-2840-44a6-98ef-28897c3e4274', 146728.00, 0.00, 'Pembayaran pajak tabungan', '2026-10-20 05:45:33', '2026-10-20 05:45:33'),
('01a15958-7d8c-73d0-8833-97a5818836c6', '01a15958-7d7a-722f-9d2c-9db0108131a8', '217611bd-73a7-48d8-be5e-9b67041b0093', 0.00, 146728.00, 'Mutasi Kas Keluar', '2026-10-20 05:45:33', '2026-10-20 05:45:33'),
('01a1598a-517b-71f1-ba1c-67b7374bcb3c', '01a1598a-5178-72d4-9d07-27a4988117b8', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 200000000.00, 0.00, 'Pengisian kas', '2026-10-20 06:39:59', '2026-10-20 06:39:59'),
('01a1598a-5184-71d5-a06a-461e8d846806', '01a1598a-5178-72d4-9d07-27a4988117b8', '217611bd-73a7-48d8-be5e-9b67041b0093', 0.00, 200000000.00, 'Mutasi Kas Keluar', '2026-10-20 06:39:59', '2026-10-20 06:39:59'),
('01a1598b-f7ce-70d6-b297-c22dcfa4ac42', '01a1598b-f7cc-7180-ae3a-2f99e3b031f1', '1dc22728-2840-44a6-98ef-28897c3e4274', 30000.00, 0.00, 'Biaya Admin Giro', '2026-10-20 06:41:47', '2026-10-20 06:41:47'),
('01a1598b-f7d9-7127-9f5a-df2aa2cc1801', '01a1598b-f7cc-7180-ae3a-2f99e3b031f1', '217611bd-73a7-48d8-be5e-9b67041b0093', 0.00, 30000.00, 'Mutasi Kas Keluar', '2026-10-20 06:41:47', '2026-10-20 06:41:47'),
('01a159b8-4e18-7111-87c4-de4f95fb5e6e', '01a159b8-4e14-71e0-bdec-68a6c3a5fe89', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', 2000000.00, 0.00, 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301021122537792517 Pengisian kas operasional', '2026-10-20 07:30:13', '2026-10-20 07:30:13'),
('01a159b8-4e28-720e-932e-fd94d4268ab8', '01a159b8-4e14-71e0-bdec-68a6c3a5fe89', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 0.00, 2000000.00, 'Mutasi Kas Keluar', '2026-10-20 07:30:13', '2026-10-20 07:30:13'),
('01a159b9-547d-7329-8181-ba6717cc6033', '01a159b9-547b-7283-ad77-0c8da0f7bc0d', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', 3000000.00, 0.00, 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301051121506253692 Tim UMPRO audensi dengan Gubernur', '2026-10-20 07:31:20', '2026-10-20 07:31:20'),
('01a159b9-5488-73b2-96a4-c7f19ffe924b', '01a159b9-547b-7283-ad77-0c8da0f7bc0d', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 0.00, 3000000.00, 'Mutasi Kas Keluar', '2026-10-20 07:31:20', '2026-10-20 07:31:20'),
('01a159ba-2a37-72e4-8070-99655ae3361c', '01a159ba-2a2f-73c6-9610-1785521501d2', 'b83b2cf8-b4ec-4d2e-8694-04bf58bf4237', 60000000.00, 0.00, 'Transfer ke BSI norek. 7187244565 an. ABD Rochim reff. 2301051121506826136 Pembangunan Café termin ke 4', '2026-10-20 07:32:15', '2026-10-20 07:32:15'),
('01a159ba-2a57-7364-b9eb-e0188ff3a699', '01a159ba-2a2f-73c6-9610-1785521501d2', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 0.00, 60000000.00, 'Mutasi Kas Keluar', '2026-10-20 07:32:15', '2026-10-20 07:32:15'),
('01a159ba-c92c-72ac-9023-959f4d779e84', '01a159ba-c92a-7024-90ad-428c786c9bc2', '1dc22728-2840-44a6-98ef-28897c3e4274', 2500.00, 0.00, 'Administrasi Bank', '2026-10-20 07:32:55', '2026-10-20 07:32:55'),
('01a159ba-c937-72ff-b515-8dd913d4bf0e', '01a159ba-c92a-7024-90ad-428c786c9bc2', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 0.00, 2500.00, 'Mutasi Kas Keluar', '2026-10-20 07:32:55', '2026-10-20 07:32:55'),
('01a159bb-989a-7225-a87a-f646f2e60d16', '01a159bb-9897-73cb-a0cb-b830b7f20ea5', 'bf575919-9801-45cf-afc8-868cea1e7066', 200000.00, 0.00, 'Uang Lembur Yuli untuk persiapan pemeriksaan laporan keuangan (09.00 - 21.00)', '2026-10-20 07:33:48', '2026-10-20 07:33:48'),
('01a159bb-98b3-731a-9409-0b9393ca032c', '01a159bb-9897-73cb-a0cb-b830b7f20ea5', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 0.00, 200000.00, 'Mutasi Kas Keluar', '2026-10-20 07:33:48', '2026-10-20 07:33:48'),
('01a159bc-246c-7211-84c8-de86f1a4de99', '01a159bc-246a-72bb-bd45-d6f06af8b520', 'b7a89777-0db8-4098-b4fb-e324af14436e', 300000.00, 0.00, 'Tambahan transport Rapat persiapan verifikasi keuangan (17 Des 2017) an Kristin Muslimah', '2026-10-20 07:34:24', '2026-10-20 07:34:24'),
('01a159bc-2488-7030-8720-bc89cd731019', '01a159bc-246a-72bb-bd45-d6f06af8b520', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 0.00, 300000.00, 'Mutasi Kas Keluar', '2026-10-20 07:34:24', '2026-10-20 07:34:24'),
('01a159bc-b4b5-727e-8932-20ff99932c2d', '01a159bc-b4b2-71ab-89b6-16ef16cfeb69', 'b7a89777-0db8-4098-b4fb-e324af14436e', 400000.00, 0.00, 'Transport verifikasi LK (6,7,8 Jan 2023) an Kristin Muslimah (PDA Kediri)', '2026-10-20 07:35:01', '2026-10-20 07:35:01'),
('01a159bc-b4c2-71cb-a0bd-a93131b092c5', '01a159bc-b4b2-71ab-89b6-16ef16cfeb69', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 0.00, 400000.00, 'Mutasi Kas Keluar', '2026-10-20 07:35:01', '2026-10-20 07:35:01'),
('01a159bd-e032-7361-9b0b-8caff04993d9', '01a159bd-e030-7106-8ecb-30c9a3e51cc0', 'b7a89777-0db8-4098-b4fb-e324af14436e', 200000.00, 0.00, 'Tambahan transport Rapat persiapan verifikasi keuangan (17 Des 2017) an. Zubaidatul Hidayah', '2026-10-20 07:36:18', '2026-10-20 07:36:18'),
('01a159bd-e041-7085-abdd-331b3d34c760', '01a159bd-e030-7106-8ecb-30c9a3e51cc0', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 0.00, 200000.00, 'Mutasi Kas Keluar', '2026-10-20 07:36:18', '2026-10-20 07:36:18'),
('01a159c1-6bae-7083-9b1d-2f257b1ae5b5', '01a159c1-6bac-710c-9683-289deccb4fce', 'b7a89777-0db8-4098-b4fb-e324af14436e', 300000.00, 0.00, 'Transport verifikasi LK (6,7,8 Jan 2023) an Zubaidatul Hidayah (PDA Sidoarjo)', '2026-10-20 07:40:10', '2026-10-20 07:40:10'),
('01a159c1-6bbf-7150-aef0-9a4f7b7ac18d', '01a159c1-6bac-710c-9683-289deccb4fce', 'b7a89777-0db8-4098-b4fb-e324af14436e', 450000.00, 0.00, 'Tambahan transport Rapat persiapan verifikasi keuangan (17 Des 2017) an. Martiningsih', '2026-10-20 07:40:10', '2026-10-20 07:40:10'),
('01a159c1-6bcc-7216-aa07-697c73d2997a', '01a159c1-6bac-710c-9683-289deccb4fce', 'b7a89777-0db8-4098-b4fb-e324af14436e', 500000.00, 0.00, 'Transport verifikasi LK (6,7,8 Jan 2023) an Martiningsih (PDA Ponorogo)', '2026-10-20 07:40:10', '2026-10-20 07:40:10'),
('01a159c1-6bd2-732f-b3b9-76b7ddc9c820', '01a159c1-6bac-710c-9683-289deccb4fce', '9d09958c-0bcf-40ad-b0aa-7cbcff9e3396', 120000.00, 0.00, 'Pembelian Klip (yuli)', '2026-10-20 07:40:10', '2026-10-20 07:40:10'),
('01a159c1-6bd8-7238-9286-7c5c41998307', '01a159c1-6bac-710c-9683-289deccb4fce', '9d09958c-0bcf-40ad-b0aa-7cbcff9e3396', 105000.00, 0.00, 'Tinta print Data Print, lem, isi staples', '2026-10-20 07:40:10', '2026-10-20 07:40:10'),
('01a159c1-6be0-73e3-8f3d-a15b9f6a5bdb', '01a159c1-6bac-710c-9683-289deccb4fce', 'b7a89777-0db8-4098-b4fb-e324af14436e', 9420000.00, 0.00, 'Tinta print Data Print, lem, isi staples', '2026-10-20 07:40:10', '2026-10-20 07:40:10'),
('01a159c1-6be5-712f-81f9-ffe55598c050', '01a159c1-6bac-710c-9683-289deccb4fce', 'ef0ab049-3707-4b8e-a7ba-53d1f3ad3694', 10000.00, 0.00, 'Parkir', '2026-10-20 07:40:10', '2026-10-20 07:40:10'),
('01a159c1-6beb-7022-a3e3-cc102acb8ef5', '01a159c1-6bac-710c-9683-289deccb4fce', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 0.00, 10905000.00, 'Mutasi Kas Keluar', '2026-10-20 07:40:10', '2026-10-20 07:40:10'),
('01a159ee-b2ee-7269-ac82-aa104c8d76f3', '01a159ee-b2eb-7349-8dab-86a66225be3e', 'b7a89777-0db8-4098-b4fb-e324af14436e', 1500000.00, 0.00, 'Transfer ke Bank Jatim Norek. 6202209605 an. Siti Zubaidatul Hidayah (PDA Sidoarjo) reff. JMB371957650 untuk pembayaran honor verifikasi keuangan Aisyiyah', '2026-10-20 08:29:38', '2026-10-20 08:29:38'),
('01a159ee-b2f8-72a5-98b0-b5b816d1b42d', '01a159ee-b2eb-7349-8dab-86a66225be3e', 'b7a89777-0db8-4098-b4fb-e324af14436e', 1500000.00, 0.00, 'Transfer ke Bank Syariah Indonesia Norek. 7181048365 an. Martiningsih (PDA Ponorogo) reff. 2301081121511786044 untuk pembayaran honor verifikasi keuangan Aisyiyah', '2026-10-20 08:29:38', '2026-10-20 08:29:38'),
('01a159ee-b301-7066-837c-d7cdba693fae', '01a159ee-b2eb-7349-8dab-86a66225be3e', '1dc22728-2840-44a6-98ef-28897c3e4274', 2500.00, 0.00, 'Biaya Administrasi Bank', '2026-10-20 08:29:38', '2026-10-20 08:29:38'),
('01a159ee-b308-7135-9c3c-569f31f0f85a', '01a159ee-b2eb-7349-8dab-86a66225be3e', 'b7a89777-0db8-4098-b4fb-e324af14436e', 1500000.00, 0.00, 'Transfer ke Bank BRI Norek. 625301004203538  an. Kristin Muslimah (PDA Kediri) reff.  497918192617 untuk pembayaran honor verifikasi keuangan Aisyiyah', '2026-10-20 08:29:38', '2026-10-20 08:29:38'),
('01a159ee-b30e-719a-9018-5fb39e4a1640', '01a159ee-b2eb-7349-8dab-86a66225be3e', 'b7a89777-0db8-4098-b4fb-e324af14436e', 1000000.00, 0.00, 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301081122548316455 untuk pembayaran honor pendamping verifikasi LK Aisyiyah', '2026-10-20 08:29:38', '2026-10-20 08:29:38'),
('01a159ee-b312-7015-9310-fbe62b823cd9', '01a159ee-b2eb-7349-8dab-86a66225be3e', 'b7a89777-0db8-4098-b4fb-e324af14436e', 4250000.00, 0.00, 'Pembayaran honor pendamping verifikasi LK Aisyiyah 3 hari di tambah transpot (Bu Candra Rp. 1.000.000, biaya admin bank Rp. 2500  Bu Anna Marina Rp. 750.000 biaya bank 2500  Bu Heni Rp. 2.500.000', '2026-10-20 08:29:38', '2026-10-20 08:29:38'),
('01a159ee-b31c-7267-9f08-092a185f9087', '01a159ee-b2eb-7349-8dab-86a66225be3e', '1dc22728-2840-44a6-98ef-28897c3e4274', 5000.00, 0.00, 'Biaya Administrasi Bank', '2026-10-20 08:29:38', '2026-10-20 08:29:38'),
('01a159ee-b322-73bd-8a6c-8acfdd11ef8a', '01a159ee-b2eb-7349-8dab-86a66225be3e', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 0.00, 9757500.00, 'Mutasi Kas Keluar', '2026-10-20 08:29:38', '2026-10-20 08:29:38'),
('01a159f1-3f6a-702a-8506-8f15d7851598', '01a159f1-3f68-70b9-927a-e56468ed965c', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', 21190000.00, 0.00, 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref. 2301101122551693942 Operasional ATC', '2026-10-20 08:32:25', '2026-10-20 08:32:25'),
('01a159f1-3f76-7131-bb28-e37f5712a1ea', '01a159f1-3f68-70b9-927a-e56468ed965c', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', 22722975.00, 0.00, 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301101121515400945 Keperluan tim verifikasi, dana surat keterangan konsultan, dan pembuatan laporan 1% dari dana hibah', '2026-10-20 08:32:25', '2026-10-20 08:32:25'),
('01a159f1-3f7d-7201-8342-e770ed0d3677', '01a159f1-3f68-70b9-927a-e56468ed965c', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 0.00, 43912975.00, 'Mutasi Kas Keluar', '2026-10-20 08:32:25', '2026-10-20 08:32:25'),
('01a159f1-f137-70e2-b882-a361bf3ce42e', '01a159f1-f135-7159-a875-e83173897bbd', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', 35000000.00, 0.00, 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301131122557316522 untuk kebutuhan Muswil', '2026-10-20 08:33:10', '2026-10-20 08:33:10'),
('01a159f1-f144-72f8-a372-18d2fc196b9a', '01a159f1-f135-7159-a875-e83173897bbd', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 0.00, 35000000.00, 'Mutasi Kas Keluar', '2026-10-20 08:33:10', '2026-10-20 08:33:10'),
('01a159f6-dfa8-7290-a79d-dc6cfe2f1f12', '01a159f6-dfa6-73b0-9183-233ac38c37d4', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', 19700000.00, 0.00, 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301131122557316522 untuk kebutuhan Muswil', '2026-10-20 08:38:33', '2026-10-20 08:38:33'),
('01a159f6-dfb3-7229-b9e9-2bcdb65b779d', '01a159f6-dfa6-73b0-9183-233ac38c37d4', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 0.00, 19700000.00, 'Mutasi Kas Keluar', '2026-10-20 08:38:33', '2026-10-20 08:38:33'),
('01a159f8-ff37-71bb-aadf-07b74c4cc974', '01a159f8-ff34-70a0-99d9-76ca79405176', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 50000000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-20 08:40:52', '2026-10-20 08:40:52'),
('01a159f8-ff42-7230-9604-68b0c96eb71e', '01a159f8-ff34-70a0-99d9-76ca79405176', 'd0cf1368-347c-4b97-99b6-c0fc88f0392e', 0.00, 50000000.00, 'Pemasukan dari Gubernur Jatim untuk bantuan Muswil diberikan ke bu Candra tunai', '2026-10-20 08:40:52', '2026-10-20 08:40:52'),
('01a159fa-2ec5-729c-b030-19157d8bff42', '01a159fa-2ec3-7149-a795-a88e113cfe29', 'b7a89777-0db8-4098-b4fb-e324af14436e', 100000000.00, 0.00, 'Transfer ke BRI Norek. 115901020724505 an. Fitrijah Hidajati ref. 2301241122573568558 untuk kekurangan dana Muswil', '2026-10-20 08:42:10', '2026-10-20 08:42:10'),
('01a159fa-2ecf-728e-80ba-bc1d33fc8efa', '01a159fa-2ec3-7149-a795-a88e113cfe29', '1dc22728-2840-44a6-98ef-28897c3e4274', 2500.00, 0.00, 'Biaya Administrasi Bank', '2026-10-20 08:42:10', '2026-10-20 08:42:10'),
('01a159fa-2edc-7342-9e64-e6f0f8075101', '01a159fa-2ec3-7149-a795-a88e113cfe29', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 0.00, 100002500.00, 'Mutasi Kas Keluar', '2026-10-20 08:42:10', '2026-10-20 08:42:10'),
('01a159fb-78cc-71ed-bd5a-c33b427a5d3d', '01a159fb-78ca-7181-ae8f-14a1a7d18c5a', 'b83b2cf8-b4ec-4d2e-8694-04bf58bf4237', 52520550.00, 0.00, 'Transfer ke BCA an. Rahmad Deky Zakaria Norek. 0190548848 ref.2301251121539574926 untuk membayaran interior termin 1', '2026-10-20 08:43:35', '2026-10-20 08:43:35'),
('01a159fb-78d8-7001-8126-b731b48f8d74', '01a159fb-78ca-7181-ae8f-14a1a7d18c5a', '1dc22728-2840-44a6-98ef-28897c3e4274', 2500.00, 0.00, 'Biaya Administrasi Bank', '2026-10-20 08:43:35', '2026-10-20 08:43:35'),
('01a159fb-78de-7237-b807-f4c8e86d02d5', '01a159fb-78ca-7181-ae8f-14a1a7d18c5a', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 0.00, 52523050.00, 'Mutasi Kas Keluar', '2026-10-20 08:43:35', '2026-10-20 08:43:35'),
('01a159fc-d7d6-7269-9004-133d73201d85', '01a159fc-d7d4-7256-a9f9-75264181e557', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 175000000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-20 08:45:04', '2026-10-20 08:45:04'),
('01a159fc-d7e0-7012-8459-e75fffce7176', '01a159fc-d7d4-7256-a9f9-75264181e557', '3aed7fc1-a08f-4eee-a040-29e34c846836', 0.00, 175000000.00, 'Pemasukan bantuan Muswil dari PWM (cek bank Muamalat)', '2026-10-20 08:45:04', '2026-10-20 08:45:04'),
('01a159fe-14db-72c3-9a02-66f2e518b982', '01a159fe-14d9-71ee-89fd-5a3c0b8ab33a', 'a56fbc97-5851-4bcd-a3a8-c5fd2e479868', 162500.00, 0.00, 'Transport (grab) mengantar cek bank Muamallat dan mencairkan cek bank Muamalllat di Jl. Darmo Surabaya, Administrasi bank (yuli)', '2026-10-20 08:46:26', '2026-10-20 08:46:26'),
('01a159fe-14e4-711d-a049-42bac1296e6c', '01a159fe-14d9-71ee-89fd-5a3c0b8ab33a', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', 9373000.00, 0.00, 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301271122579384345 untuk honor pegawai PWA', '2026-10-20 08:46:26', '2026-10-20 08:46:26'),
('01a159fe-14ea-71de-8e52-f075eef7a00c', '01a159fe-14d9-71ee-89fd-5a3c0b8ab33a', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 0.00, 9535500.00, 'Mutasi Kas Keluar', '2026-10-20 08:46:26', '2026-10-20 08:46:26'),
('01a159fe-a2f9-72eb-86cb-ab0ff2c47fa8', '01a159fe-a2f6-718e-9f2e-8d129eba41d4', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', 5000000.00, 0.00, 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301311122586946308 untuk kas operasional', '2026-10-20 08:47:02', '2026-10-20 08:47:02'),
('01a159fe-a348-7273-b6df-f064d5f878a4', '01a159fe-a2f6-718e-9f2e-8d129eba41d4', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 0.00, 5000000.00, 'Mutasi Kas Keluar', '2026-10-20 08:47:02', '2026-10-20 08:47:02'),
('01a15a9c-6046-73ed-a7cc-0fae447dce89', '01a15a9c-6041-7180-8f83-05d2557e463c', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', 4983047.00, 0.00, 'Distribusi saldo ke user', '2026-10-20 11:39:20', '2026-10-20 11:39:20'),
('01a15a9c-6048-7353-85d4-1131f5f4905d', '01a15a9c-6041-7180-8f83-05d2557e463c', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', 0.00, 4983047.00, 'Pengurangan saldo akun', '2026-10-20 11:39:20', '2026-10-20 11:39:20'),
('01a15aa0-24da-71d1-896c-823fb943a4a5', '01a15aa0-24d7-7099-ade3-2d94b05682e2', 'ef0ab049-3707-4b8e-a7ba-53d1f3ad3694', 402500.00, 0.00, 'Transfer Parkir + Biaya', '2026-10-20 11:43:27', '2026-10-20 11:43:27'),
('01a15aa0-24e4-7160-b275-3dcd34cb1529', '01a15aa0-24d7-7099-ade3-2d94b05682e2', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', 0.00, 402500.00, 'Mutasi Kas Keluar', '2026-10-20 11:43:27', '2026-10-20 11:43:27'),
('01a15aa2-d69f-7062-847a-2870676b9d1a', '01a15aa2-d69d-7265-aa5c-92ebd4aa97d0', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', 200000.00, 0.00, 'Mutasi Kas Masuk', '2026-10-20 11:46:23', '2026-10-20 11:46:23'),
('01a15aa2-d6a8-7336-8f51-803f090ecd22', '01a15aa2-d69d-7265-aa5c-92ebd4aa97d0', '54a2c8f7-8bf2-4baf-a30e-52863c7b15db', 0.00, 200000.00, 'Cicilan 3 Pak Edi', '2026-10-20 11:46:23', '2026-10-20 11:46:23'),
('01a15aa4-c28d-7129-80a9-b0eda35024c5', '01a15aa4-c28b-703b-b0ac-d3bb1d0388ea', 'b7a89777-0db8-4098-b4fb-e324af14436e', 902500.00, 0.00, 'Transfer Transport Tim Panlih Daerah', '2026-10-20 11:48:29', '2026-10-20 11:48:29'),
('01a15aa4-c29a-71a6-8e31-9f4eab2d058f', '01a15aa4-c28b-703b-b0ac-d3bb1d0388ea', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', 0.00, 902500.00, 'Mutasi Kas Keluar', '2026-10-20 11:48:29', '2026-10-20 11:48:29'),
('01a15cdb-01f4-7125-be70-a14f33e9c27d', '01a15cdb-01f0-7313-84d7-45a941946d64', 'dfca8b6c-5b37-410c-a4fb-a939792edd63', 143000.00, 0.00, 'Biaya Zoom', '2026-10-20 22:06:59', '2026-10-20 22:06:59'),
('01a15cdb-0203-7103-8ce6-978fd14bb325', '01a15cdb-01f0-7313-84d7-45a941946d64', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', 0.00, 143000.00, 'Mutasi Kas Keluar', '2026-10-20 22:06:59', '2026-10-20 22:06:59');

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
(19, '2026_05_25_061327_create_user_account_balances_table', 1),
(20, '2026_05_26_175556_create_activity_logs_table', 1),
(21, '2026_06_01_082259_create_coa_requests_table', 1),
(22, '2026_06_04_180354_create_balance_requests_table', 1),
(23, '2026_06_11_085417_create_configurations_table', 1),
(24, '2026_06_21_081023_create_account_topups_table', 1),
(25, '2026_08_30_162544_add_income_balance_to_user_account_balances_table', 1);

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
('01a1525d-4efd-70d6-8625-c9d2f8855b44', 'App\\Models\\User', '01a1525d-6225-70cd-ad6f-a9ad3ff95da8'),
('01a1525d-55cd-720f-9a8c-581d5e2b74eb', 'App\\Models\\User', '01a1525d-6541-71d8-a795-c2ec45ab6289'),
('01a1525d-5b20-7018-8871-fab0a5298acd', 'App\\Models\\User', '01a1525d-6541-71d8-a795-c2ec45ab6289'),
('01a1525d-5b20-7018-8871-fab0a5298acd', 'App\\Models\\User', '01a1525d-6864-72ea-ad31-f231a54b1b9e');

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
('01a152c0-fb75-7111-8ae5-933ae535fe53', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DEBIT', 194604157.00, 0, NULL, '2026-10-18 23:02:21', '2026-10-18 23:02:21'),
('01a152c1-43ef-7094-955b-a6daff8f6e3e', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DEBIT', 4983047.00, 0, NULL, '2026-10-18 23:02:39', '2026-10-18 23:02:39'),
('01a152c1-b144-73f9-b861-2ea2971692d0', '07273ff4-96b4-4756-8f70-a34e66bb36d0', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DEBIT', 405484747.00, 0, NULL, '2026-10-18 23:03:07', '2026-10-18 23:03:07'),
('01a152c2-19c1-7094-aae3-df9c922c1a58', '217611bd-73a7-48d8-be5e-9b67041b0093', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DEBIT', 1156982563.00, 0, NULL, '2026-10-18 23:03:34', '2026-10-18 23:03:34'),
('01a152c2-8f8a-7239-b2ca-4d74c59c8261', 'a3654a7f-7b1e-4982-92bd-51bc3b688329', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DEBIT', 377940865.00, 0, NULL, '2026-10-18 23:04:04', '2026-10-18 23:04:04'),
('01a152c3-021d-70c0-b4f1-bedea99e8736', '54a2c8f7-8bf2-4baf-a30e-52863c7b15db', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DEBIT', 1800000.00, 0, NULL, '2026-10-18 23:04:34', '2026-10-18 23:04:34'),
('01a152c3-7246-7366-82aa-958464bd6b50', '3c63e3d3-31df-40ee-a780-b36f628c1b3e', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DEBIT', 921735276.00, 0, NULL, '2026-10-18 23:05:02', '2026-10-18 23:05:02'),
('01a152c3-dd07-720b-9c79-67be7b76bfea', 'e51f3483-8b24-4b95-bcb7-56c47e85456d', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DEBIT', 460769432.00, 0, NULL, '2026-10-18 23:05:30', '2026-10-18 23:05:30'),
('01a152c4-5e64-72e8-863a-49c10267df43', '5f5c44e2-728d-4fd5-bb5d-431361a7891c', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREDIT', 144000000.00, 0, NULL, '2026-10-18 23:06:03', '2026-10-18 23:06:03'),
('01a152c4-d163-73bd-9860-93a4d98752b5', 'b22b30bd-f081-4d6d-bb12-1b9d39238239', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DEBIT', 15500000.00, 0, NULL, '2026-10-18 23:06:32', '2026-10-18 23:06:32'),
('01a152c5-2131-735b-8bdd-dd05ebd68c40', '757cde74-832b-4164-97be-82b78afb6b9f', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREDIT', 13376668.00, 0, NULL, '2026-10-18 23:06:53', '2026-10-18 23:06:53'),
('01a152c5-7a36-71ae-8a39-221eed4deff4', '0f9579c0-6cc3-4458-aa0b-f9a15acd9578', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DEBIT', 46059000.00, 0, NULL, '2026-10-18 23:07:16', '2026-10-18 23:07:16'),
('01a152c5-d504-70e7-b97b-277144cc634a', '902753ad-a0f2-4506-bb23-e77b2fab6f32', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREDIT', 25236667.00, 0, NULL, '2026-10-18 23:07:39', '2026-10-18 23:07:39'),
('01a152c6-80cc-723f-8ffb-964debf01ba9', 'df8898d0-483f-41a2-8d75-e107da9959ed', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREDIT', 339715097.00, 0, NULL, '2026-10-18 23:08:23', '2026-10-18 23:08:23'),
('01a152c6-dbac-7080-bc84-7aa123b54ec0', 'ea8c6555-0f32-4df4-b036-5c92a59dc58a', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREDIT', 368679944.00, 0, NULL, '2026-10-18 23:08:46', '2026-10-18 23:08:46'),
('01a152c7-c8d1-71d0-aba3-71cf1dbd1f9f', '14dc35fc-8cf0-47f2-b41f-55de875caf32', '01a1525d-6938-70aa-ab21-1653fea3792a', '01a1525d-69d6-7254-8a66-6c28c53928d8', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREDIT', 2694850711.00, 0, NULL, '2026-10-18 23:09:47', '2026-10-18 23:09:47'),
('01a152ca-72aa-71e3-91b9-aaa63071421d', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DEBIT', 194604157.00, 0, NULL, '2026-10-18 23:12:41', '2026-10-18 23:12:41'),
('01a152ca-ab11-704a-abc0-c31c4fe90383', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DEBIT', 4983047.00, 0, NULL, '2026-10-18 23:12:56', '2026-10-18 23:12:56'),
('01a152ca-e697-7308-a8d2-90c28e10b390', '07273ff4-96b4-4756-8f70-a34e66bb36d0', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DEBIT', 405484747.00, 0, NULL, '2026-10-18 23:13:11', '2026-10-18 23:13:11'),
('01a152cb-23df-7281-a66d-ed70ceaa2cd9', '217611bd-73a7-48d8-be5e-9b67041b0093', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DEBIT', 1156982563.00, 0, NULL, '2026-10-18 23:13:27', '2026-10-18 23:13:27'),
('01a152cb-7295-73c2-8cc9-0283e3fa818a', 'a3654a7f-7b1e-4982-92bd-51bc3b688329', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DEBIT', 377940865.00, 0, NULL, '2026-10-18 23:13:47', '2026-10-18 23:13:47'),
('01a152cb-ba5d-73dd-ae63-b5ce20b8481b', '54a2c8f7-8bf2-4baf-a30e-52863c7b15db', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DEBIT', 1800000.00, 0, NULL, '2026-10-18 23:14:05', '2026-10-18 23:14:05'),
('01a152cb-f67c-72cb-8833-76354a1dd3df', '3c63e3d3-31df-40ee-a780-b36f628c1b3e', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DEBIT', 921735276.00, 0, NULL, '2026-10-18 23:14:21', '2026-10-18 23:14:21'),
('01a152cc-3604-7014-a62e-862822046c50', 'e51f3483-8b24-4b95-bcb7-56c47e85456d', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DEBIT', 460769432.00, 0, NULL, '2026-10-18 23:14:37', '2026-10-18 23:14:37'),
('01a152cc-7e86-700b-8dfc-415a7b2755e4', '5f5c44e2-728d-4fd5-bb5d-431361a7891c', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREDIT', 144000000.00, 0, NULL, '2026-10-18 23:14:55', '2026-10-18 23:14:55'),
('01a152cc-b8ee-7220-86a6-5f73df1ef306', 'b22b30bd-f081-4d6d-bb12-1b9d39238239', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DEBIT', 15500000.00, 0, NULL, '2026-10-18 23:15:10', '2026-10-18 23:15:10'),
('01a152cc-f56a-701e-998f-4533f720f470', '757cde74-832b-4164-97be-82b78afb6b9f', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREDIT', 13376668.00, 0, NULL, '2026-10-18 23:15:26', '2026-10-18 23:15:26'),
('01a152cd-2df0-72ad-a116-d616f12e0671', '0f9579c0-6cc3-4458-aa0b-f9a15acd9578', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'DEBIT', 46059000.00, 0, NULL, '2026-10-18 23:15:40', '2026-10-18 23:15:40'),
('01a152cd-642e-7172-9209-4eda582aad2d', '902753ad-a0f2-4506-bb23-e77b2fab6f32', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREDIT', 25236667.00, 0, NULL, '2026-10-18 23:15:54', '2026-10-18 23:15:54'),
('01a152cd-afbf-7107-bf77-5b49e9041245', 'df8898d0-483f-41a2-8d75-e107da9959ed', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREDIT', 339715097.00, 0, NULL, '2026-10-18 23:16:14', '2026-10-18 23:16:14'),
('01a152cd-f8ab-73ad-9c37-d7f5106c437d', 'ea8c6555-0f32-4df4-b036-5c92a59dc58a', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREDIT', 368679944.00, 0, NULL, '2026-10-18 23:16:32', '2026-10-18 23:16:32'),
('01a152ce-362a-73bd-94f6-60ce7bc6aa3f', '14dc35fc-8cf0-47f2-b41f-55de875caf32', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'CREDIT', 2694850711.00, 0, NULL, '2026-10-18 23:16:48', '2026-10-18 23:16:48');

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
('01a1525d-6938-70aa-ab21-1653fea3792a', '2022', 'Fiscal year 2022', '2022-01-01', '2022-12-31', '2026-10-18 21:13:35', '2026-10-18 21:13:35'),
('01a1525d-6a17-70ce-862c-331933a6b4b0', '2023', 'Fiscal year 2023', '2023-01-01', '2023-12-31', '2026-10-18 21:13:36', '2026-10-18 21:13:36');

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
('01a1525d-4481-7334-a768-415b31abb15e', 'view dashboard superadmin', 'web', 'Dashboard', 'Akses dashboard superadmin', 1, '2026-10-18 21:13:26', '2026-10-18 21:13:26'),
('01a1525d-44e2-72fa-84ad-df830f28faa1', 'view dashboard bendahara', 'web', 'Dashboard', 'Akses dashboard bendahara', 1, '2026-10-18 21:13:26', '2026-10-18 21:13:26'),
('01a1525d-453d-7334-b7dc-211234315606', 'user view', 'web', 'User Management', 'Melihat data user', 1, '2026-10-18 21:13:26', '2026-10-18 21:13:26'),
('01a1525d-45a7-7116-a26f-7fb48818a1d3', 'user create', 'web', 'User Management', 'Membuat user baru', 1, '2026-10-18 21:13:26', '2026-10-18 21:13:26'),
('01a1525d-45e3-71cd-a5ae-374d1db1995b', 'user update', 'web', 'User Management', 'Mengubah data user', 1, '2026-10-18 21:13:26', '2026-10-18 21:13:26'),
('01a1525d-4617-726a-802b-39b50c871095', 'user delete', 'web', 'User Management', 'Menghapus user', 1, '2026-10-18 21:13:26', '2026-10-18 21:13:26'),
('01a1525d-4647-73e0-ae9f-40e884caad30', 'role view', 'web', 'Role & Permission', 'Melihat role', 1, '2026-10-18 21:13:26', '2026-10-18 21:13:26'),
('01a1525d-4676-73df-9767-f98eec47940e', 'role create', 'web', 'Role & Permission', 'Membuat role', 1, '2026-10-18 21:13:27', '2026-10-18 21:13:27'),
('01a1525d-46ba-71d7-a3b7-e7b2681ea53f', 'role update', 'web', 'Role & Permission', 'Mengubah role', 1, '2026-10-18 21:13:27', '2026-10-18 21:13:27'),
('01a1525d-46f9-70a0-afd6-9eec2960bc7a', 'role delete', 'web', 'Role & Permission', 'Menghapus role', 1, '2026-10-18 21:13:27', '2026-10-18 21:13:27'),
('01a1525d-473e-7371-8caf-d04e4a0ab082', 'permission view', 'web', 'Role & Permission', 'Melihat permission', 1, '2026-10-18 21:13:27', '2026-10-18 21:13:27'),
('01a1525d-4779-7260-b792-c9cceb4e8ba0', 'permission create', 'web', 'Role & Permission', 'Membuat permission', 1, '2026-10-18 21:13:27', '2026-10-18 21:13:27'),
('01a1525d-47bc-72a2-a045-a59efe3c2d8b', 'permission update', 'web', 'Role & Permission', 'Mengubah permission', 1, '2026-10-18 21:13:27', '2026-10-18 21:13:27'),
('01a1525d-47fe-7105-baa0-66a1083f3ee9', 'permission delete', 'web', 'Role & Permission', 'Menghapus permission', 1, '2026-10-18 21:13:27', '2026-10-18 21:13:27'),
('01a1525d-483b-716f-a8fc-70c6d055805f', 'coa view', 'web', 'Master COA', 'Melihat chart of account', 1, '2026-10-18 21:13:27', '2026-10-18 21:13:27'),
('01a1525d-488c-72cd-8c12-add653d9a9a7', 'coa create', 'web', 'Master COA', 'Membuat akun COA', 1, '2026-10-18 21:13:27', '2026-10-18 21:13:27'),
('01a1525d-48e9-7025-9880-113d83e0c24a', 'coa update', 'web', 'Master COA', 'Mengubah akun COA', 1, '2026-10-18 21:13:27', '2026-10-18 21:13:27'),
('01a1525d-493d-705d-b9a1-2a443ddebde6', 'coa delete', 'web', 'Master COA', 'Menghapus akun COA', 1, '2026-10-18 21:13:27', '2026-10-18 21:13:27'),
('01a1525d-4989-70c7-9e56-6db37ae62def', 'coa import', 'web', 'Master COA', 'Import akun COA', 0, '2026-10-18 21:13:27', '2026-10-18 21:13:27'),
('01a1525d-49dd-73f3-8c5d-8315fb4dc7a4', 'coa assign user', 'web', 'Master COA', 'Menambahkan user ke COA', 0, '2026-10-18 21:13:27', '2026-10-18 21:13:27'),
('01a1525d-4a31-7245-82e9-751659963dc6', 'coa remove user', 'web', 'Master COA', 'Menghapus user dari COA', 0, '2026-10-18 21:13:27', '2026-10-18 21:13:27'),
('01a1525d-4a7e-71b3-a72f-0af664510c67', 'coa request create', 'web', 'Master COA', 'Request pembuatan akun COA', 0, '2026-10-18 21:13:28', '2026-10-18 21:13:28'),
('01a1525d-4ad4-72ae-b437-b417b395772d', 'journal post', 'web', 'Transactions', 'Posting jurnal umum', 1, '2026-10-18 21:13:28', '2026-10-18 21:13:28'),
('01a1525d-4b22-7258-bac9-4455bfc429ad', 'journal view', 'web', 'Transactions', 'Melihat jurnal umum', 1, '2026-10-18 21:13:28', '2026-10-18 21:13:28'),
('01a1525d-4b6f-73a2-84a3-5e3fab7f326c', 'transaction income create', 'web', 'Transactions', 'Input transaksi pemasukan', 1, '2026-10-18 21:13:28', '2026-10-18 21:13:28'),
('01a1525d-4bd5-7046-b8cb-57c8149de27f', 'transaction expense create', 'web', 'Transactions', 'Input transaksi pengeluaran', 1, '2026-10-18 21:13:28', '2026-10-18 21:13:28'),
('01a1525d-4c27-72f1-b349-052d1a1771e0', 'transaction import', 'web', 'Transactions', 'Import transaksi', 0, '2026-10-18 21:13:28', '2026-10-18 21:13:28'),
('01a1525d-4c74-72ef-bfd5-88c33743766b', 'ledger create', 'web', 'Ledger', 'Generate buku besar', 1, '2026-10-18 21:13:28', '2026-10-18 21:13:28'),
('01a1525d-4ccb-723f-a7fb-6a0a4b6eed7b', 'ledger view', 'web', 'Ledger', 'Melihat buku besar', 1, '2026-10-18 21:13:28', '2026-10-18 21:13:28'),
('01a1525d-4d22-731d-add3-ef1b8d24fe31', 'ledger view by account', 'web', 'Ledger', 'Melihat buku besar per akun', 1, '2026-10-18 21:13:28', '2026-10-18 21:13:28'),
('01a1525d-4d69-733f-962f-a1de76f364b1', 'report general journal view', 'web', 'Reports', 'Melihat laporan jurnal umum', 1, '2026-10-18 21:13:28', '2026-10-18 21:13:28'),
('01a1525d-4d9d-729f-900d-0ca9c8cde222', 'report general journal export', 'web', 'Reports', 'Export laporan jurnal umum', 0, '2026-10-18 21:13:28', '2026-10-18 21:13:28'),
('01a1525d-4dda-732a-b6a1-7765923ba11b', 'report trial balance view', 'web', 'Reports', 'Melihat neraca saldo', 1, '2026-10-18 21:13:28', '2026-10-18 21:13:28'),
('01a1525d-4e0f-73b8-98e6-844456e7ffa7', 'report trial balance export', 'web', 'Reports', 'Export neraca saldo', 0, '2026-10-18 21:13:28', '2026-10-18 21:13:28'),
('01a1525d-4e4b-7153-9bb3-33a85d9841e9', 'report ledger view', 'web', 'Reports', 'Melihat laporan buku besar', 1, '2026-10-18 21:13:29', '2026-10-18 21:13:29'),
('01a1525d-4e82-73ec-b3a5-a81a160dad0a', 'report ledger export', 'web', 'Reports', 'Export laporan buku besar', 0, '2026-10-18 21:13:29', '2026-10-18 21:13:29');

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
('01a1525d-4efd-70d6-8625-c9d2f8855b44', 'SUPER ADMIN', 'web', '2026-10-18 21:13:29', '2026-10-18 21:13:29'),
('01a1525d-55cd-720f-9a8c-581d5e2b74eb', 'BENDAHARA', 'web', '2026-10-18 21:13:30', '2026-10-18 21:13:30'),
('01a1525d-5b20-7018-8871-fab0a5298acd', 'ACCOUNTING USER', 'web', '2026-10-18 21:13:32', '2026-10-18 21:13:32');

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
('01a1525d-4481-7334-a768-415b31abb15e', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-44e2-72fa-84ad-df830f28faa1', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-44e2-72fa-84ad-df830f28faa1', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-453d-7334-b7dc-211234315606', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-45a7-7116-a26f-7fb48818a1d3', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-45e3-71cd-a5ae-374d1db1995b', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4617-726a-802b-39b50c871095', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4647-73e0-ae9f-40e884caad30', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4676-73df-9767-f98eec47940e', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-46ba-71d7-a3b7-e7b2681ea53f', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-46f9-70a0-afd6-9eec2960bc7a', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-473e-7371-8caf-d04e4a0ab082', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4779-7260-b792-c9cceb4e8ba0', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-47bc-72a2-a045-a59efe3c2d8b', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-47fe-7105-baa0-66a1083f3ee9', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-483b-716f-a8fc-70c6d055805f', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-483b-716f-a8fc-70c6d055805f', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-483b-716f-a8fc-70c6d055805f', '01a1525d-5b20-7018-8871-fab0a5298acd'),
('01a1525d-488c-72cd-8c12-add653d9a9a7', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-488c-72cd-8c12-add653d9a9a7', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-48e9-7025-9880-113d83e0c24a', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-48e9-7025-9880-113d83e0c24a', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-493d-705d-b9a1-2a443ddebde6', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-493d-705d-b9a1-2a443ddebde6', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-4989-70c7-9e56-6db37ae62def', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4989-70c7-9e56-6db37ae62def', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-49dd-73f3-8c5d-8315fb4dc7a4', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-49dd-73f3-8c5d-8315fb4dc7a4', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-4a31-7245-82e9-751659963dc6', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4a31-7245-82e9-751659963dc6', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-4a7e-71b3-a72f-0af664510c67', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4a7e-71b3-a72f-0af664510c67', '01a1525d-5b20-7018-8871-fab0a5298acd'),
('01a1525d-4ad4-72ae-b437-b417b395772d', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4ad4-72ae-b437-b417b395772d', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-4b22-7258-bac9-4455bfc429ad', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4b22-7258-bac9-4455bfc429ad', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-4b22-7258-bac9-4455bfc429ad', '01a1525d-5b20-7018-8871-fab0a5298acd'),
('01a1525d-4b6f-73a2-84a3-5e3fab7f326c', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4b6f-73a2-84a3-5e3fab7f326c', '01a1525d-5b20-7018-8871-fab0a5298acd'),
('01a1525d-4bd5-7046-b8cb-57c8149de27f', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4bd5-7046-b8cb-57c8149de27f', '01a1525d-5b20-7018-8871-fab0a5298acd'),
('01a1525d-4c27-72f1-b349-052d1a1771e0', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4c27-72f1-b349-052d1a1771e0', '01a1525d-5b20-7018-8871-fab0a5298acd'),
('01a1525d-4c74-72ef-bfd5-88c33743766b', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4c74-72ef-bfd5-88c33743766b', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-4ccb-723f-a7fb-6a0a4b6eed7b', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4ccb-723f-a7fb-6a0a4b6eed7b', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-4d22-731d-add3-ef1b8d24fe31', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4d22-731d-add3-ef1b8d24fe31', '01a1525d-5b20-7018-8871-fab0a5298acd'),
('01a1525d-4d69-733f-962f-a1de76f364b1', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4d69-733f-962f-a1de76f364b1', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-4d9d-729f-900d-0ca9c8cde222', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4d9d-729f-900d-0ca9c8cde222', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-4dda-732a-b6a1-7765923ba11b', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4dda-732a-b6a1-7765923ba11b', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-4e0f-73b8-98e6-844456e7ffa7', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4e0f-73b8-98e6-844456e7ffa7', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-4e4b-7153-9bb3-33a85d9841e9', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4e4b-7153-9bb3-33a85d9841e9', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-4e4b-7153-9bb3-33a85d9841e9', '01a1525d-5b20-7018-8871-fab0a5298acd'),
('01a1525d-4e82-73ec-b3a5-a81a160dad0a', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4e82-73ec-b3a5-a81a160dad0a', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-4e82-73ec-b3a5-a81a160dad0a', '01a1525d-5b20-7018-8871-fab0a5298acd');

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
('DIQWvfUdYmzbO0xpFQqNzWs8rW68WSsI6NSdyQ0a', NULL, '74.7.242.25', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.4; +https://openai.com/gptbot)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWFpxYUpxemd3M3NzMk82bllqd0pibFFZTXFscXRwSkJ2RVQ5ZlJyQiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDU6Imh0dHBzOi8vZGlzcG9zaXNpLmVuZ2luZWVyaW5nLXVtc3VyYS5pZC9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1792592525),
('IWt6rHUwcb7oihhIBEZbubb9yGHZ8MlrsVHOakYC', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '36.78.121.117', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiejgyODJ1bWZETXl5RjZxcVpJQ212SEs2NFc4WGRscE82bFhBS25qTCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NTQ6Imh0dHBzOi8vZGlzcG9zaXNpLmVuZ2luZWVyaW5nLXVtc3VyYS5pZC91c2VyL2Rhc2hib2FyZCI7czo1OiJyb3V0ZSI7czoxNDoidXNlci5kYXNoYm9hcmQiO31zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7czozNjoiMDFhMTUyNWQtNjg2NC03MmVhLWFkMzEtZjIzMWE1NGIxYjllIjt9', 1792572454),
('SVip5ML4LRCd5RiHMnFLo9M5eDwZfj45sRf5PMdi', NULL, '74.7.243.201', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.4; +https://openai.com/gptbot)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoic3g4aTBSU0F3VDE5SWViSnkyWUlDZjhHYktRbXlEZGNJREZJaFF1eCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDk6Imh0dHBzOi8vd3d3LmRpc3Bvc2lzaS5lbmdpbmVlcmluZy11bXN1cmEuaWQvbG9naW4iO3M6NToicm91dGUiO3M6NToibG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1792592626),
('uX5FJw4wEnk7exI6Doob8LZGINTSs92Yx2AMDx14', NULL, '68.183.116.184', 'Mozilla/5.0 (X11; Linux x86_64; rv:153.0) Gecko/20100101 Firefox/153.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaXJWNVBFRHRIMFVjeEJBNUVaUkU4TDFXTm5ma2lLQXk5d0lUdkNLcSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDU6Imh0dHBzOi8vZGlzcG9zaXNpLmVuZ2luZWVyaW5nLXVtc3VyYS5pZC9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1792747720),
('XvUT4xtSjmC20DlE6kkdqftKe2B3uWfSHLBaUHNI', '01a1525d-6541-71d8-a795-c2ec45ab6289', '36.78.121.117', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoic0FXR3BERnNrY0o1ckYwWEg5eE1ld0ttb3pKanQ2S0NMV3JoM2FvayI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6OTk6Imh0dHBzOi8vZGlzcG9zaXNpLmVuZ2luZWVyaW5nLXVtc3VyYS5pZC9iZW5kYWhhcmEvY29hLWJhbGFuY2VzLzAxYTE1MmNhLTcyYjMtNzEzNy04YWQ3LTg2YzVmMTdhM2U5MSI7czo1OiJyb3V0ZSI7czoyNzoiYmVuZGFoYXJhLmNvYS1iYWxhbmNlcy5zaG93Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO3M6MzY6IjAxYTE1MjVkLTY1NDEtNzFkOC1hNzk1LWMyZWM0NWFiNjI4OSI7fQ==', 1792572857),
('yGoSqooxhn5nzrxWOboNjCCjEn4Q3QlJCQMC9GkZ', '01a1525d-6541-71d8-a795-c2ec45ab6289', '118.99.84.8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiQWJTbDdLbzdvNnRXT0lkd1FlSEtXWXZrb2lxbEZmM2lwbmtmQzh4NiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NTk6Imh0dHBzOi8vZGlzcG9zaXNpLmVuZ2luZWVyaW5nLXVtc3VyYS5pZC9iZW5kYWhhcmEvZGFzaGJvYXJkIjtzOjU6InJvdXRlIjtzOjE5OiJiZW5kYWhhcmEuZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO3M6MzY6IjAxYTE1MjVkLTY1NDEtNzFkOC1hNzk1LWMyZWM0NWFiNjI4OSI7fQ==', 1792762338);

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
('01a1525d-69d6-7254-8a66-6c28c53928d8', '01a1525d-6938-70aa-ab21-1653fea3792a', 'Desember 2022', 'Bulan Desember 2022', '2022-12-01', '2022-12-31', 1, '2026-10-19 06:10:15', '01a1525d-6541-71d8-a795-c2ec45ab6289', '2026-10-18 21:13:36', '2026-10-18 23:10:15'),
('01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a1525d-6a17-70ce-862c-331933a6b4b0', 'Januari 2023', 'Bulan Januari 2023', '2023-01-01', '2023-01-31', 0, NULL, NULL, '2026-10-18 21:13:36', '2026-10-18 21:13:36');

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
('01a15957-5e51-7113-bb26-b2600e39d9b5', 'TRX-INC-20261020124420', '2023-01-01', 'INCOME', 'Penerimaan bunga dari bank', 'POSTED', 733644.00, 733644.00, NULL, NULL, '01a1525d-6541-71d8-a795-c2ec45ab6289', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', NULL, '2026-10-20 05:44:20', '2026-10-20 05:44:20'),
('01a15958-7d5c-710b-96e3-c0351f316d47', 'TRX-EXP-20261020124533', '2023-01-01', 'EXPENSE', 'Pembayaran pajak tabungan', 'POSTED', 146728.00, 146728.00, NULL, NULL, '01a1525d-6541-71d8-a795-c2ec45ab6289', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', NULL, '2026-10-20 05:45:33', '2026-10-20 05:45:33'),
('01a1598a-5165-7169-b7db-eedb29557d7a', 'TRX-EXP-20261020133959', '2023-01-13', 'EXPENSE', 'Pengisian kas', 'POSTED', 200000000.00, 200000000.00, NULL, NULL, '01a1525d-6541-71d8-a795-c2ec45ab6289', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', NULL, '2026-10-20 06:39:59', '2026-10-20 06:39:59'),
('01a1598b-f7be-72db-909c-15b6f5924325', 'TRX-EXP-20261020134147', '2023-01-27', 'EXPENSE', 'Biaya Admin Giro', 'POSTED', 30000.00, 30000.00, NULL, NULL, '01a1525d-6541-71d8-a795-c2ec45ab6289', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', NULL, '2026-10-20 06:41:47', '2026-10-20 06:41:47'),
('01a159b8-4dfd-719a-9c6c-3c51505bba39', 'TRX-EXP-20261020143013', '2023-01-02', 'EXPENSE', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301021122537792517 Pengisian kas operasional', 'POSTED', 2000000.00, 2000000.00, NULL, NULL, '01a1525d-6541-71d8-a795-c2ec45ab6289', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', NULL, '2026-10-20 07:30:13', '2026-10-20 07:30:13'),
('01a159b9-5468-7034-a962-37e0bf59a275', 'TRX-EXP-20261020143120', '2023-01-05', 'EXPENSE', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301051121506253692 Tim UMPRO audensi dengan Gubernur', 'POSTED', 3000000.00, 3000000.00, NULL, NULL, '01a1525d-6541-71d8-a795-c2ec45ab6289', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', NULL, '2026-10-20 07:31:20', '2026-10-20 07:31:20'),
('01a159ba-2a17-7061-8959-94f0ba815020', 'TRX-EXP-20261020143215', '2023-01-05', 'EXPENSE', 'Transfer ke BSI norek. 7187244565 an. ABD Rochim reff. 2301051121506826136 Pembangunan Café termin ke 4', 'POSTED', 60000000.00, 60000000.00, NULL, NULL, '01a1525d-6541-71d8-a795-c2ec45ab6289', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', NULL, '2026-10-20 07:32:15', '2026-10-20 07:32:15'),
('01a159ba-c911-7123-aab0-050a4120af5a', 'TRX-EXP-20261020143255', '2023-01-05', 'EXPENSE', 'Administrasi Bank', 'POSTED', 2500.00, 2500.00, NULL, NULL, '01a1525d-6541-71d8-a795-c2ec45ab6289', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', NULL, '2026-10-20 07:32:55', '2026-10-20 07:32:55'),
('01a159bb-9882-71b5-b6fb-231090a6956f', 'TRX-EXP-20261020143348', '2023-01-05', 'EXPENSE', 'Uang Lembur Yuli untuk persiapan pemeriksaan laporan keuangan (09.00 - 21.00)', 'POSTED', 200000.00, 200000.00, NULL, NULL, '01a1525d-6541-71d8-a795-c2ec45ab6289', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', NULL, '2026-10-20 07:33:48', '2026-10-20 07:33:48'),
('01a159bc-245f-7375-8055-7a44cfb4037a', 'TRX-EXP-20261020143424', '2023-01-07', 'EXPENSE', 'Tambahan transport Rapat persiapan verifikasi keuangan (17 Des 2017) an Kristin Muslimah', 'POSTED', 300000.00, 300000.00, NULL, NULL, '01a1525d-6541-71d8-a795-c2ec45ab6289', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', NULL, '2026-10-20 07:34:24', '2026-10-20 07:34:24'),
('01a159bc-b49c-703c-b753-af118f3cce65', 'TRX-EXP-20261020143501', '2023-01-07', 'EXPENSE', 'Transport verifikasi LK (6,7,8 Jan 2023) an Kristin Muslimah (PDA Kediri)', 'POSTED', 400000.00, 400000.00, NULL, NULL, '01a1525d-6541-71d8-a795-c2ec45ab6289', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', NULL, '2026-10-20 07:35:01', '2026-10-20 07:35:01'),
('01a159bd-e023-72c7-ab31-ab7aaebd3a1f', 'TRX-EXP-20261020143618', '2023-01-07', 'EXPENSE', 'Tambahan transport Rapat persiapan verifikasi keuangan (17 Des 2017) an. Zubaidatul Hidayah', 'POSTED', 200000.00, 200000.00, NULL, NULL, '01a1525d-6541-71d8-a795-c2ec45ab6289', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', NULL, '2026-10-20 07:36:18', '2026-10-20 07:36:18'),
('01a159c1-6b92-7293-aed9-605594dbb999', 'TRX-EXP-20261020144010', '2023-01-07', 'EXPENSE', 'Transport verifikasi LK (6,7,8 Jan 2023) an Zubaidatul Hidayah (PDA Sidoarjo) dan Tambahan transport Rapat persiapan verifikasi keuangan (17 Des 2017) an. Martiningsih dan Transport verifikasi LK (6,7,8 Jan 2023) an Martiningsih (PDA Ponorogo) dan Pembelian Klip (yuli) dan Tinta print Data Print, lem, isi staples dan Tinta print Data Print, lem, isi staples dan Parkir', 'POSTED', 10905000.00, 10905000.00, NULL, NULL, '01a1525d-6541-71d8-a795-c2ec45ab6289', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', NULL, '2026-10-20 07:40:10', '2026-10-20 07:40:10'),
('01a159ee-b2c3-73ad-a0ab-15fc298346dc', 'TRX-EXP-20261020152937', '2023-01-08', 'EXPENSE', 'Transfer ke Bank Jatim Norek. 6202209605 an. Siti Zubaidatul Hidayah (PDA Sidoarjo) reff. JMB371957650 untuk pembayaran honor verifikasi keuangan Aisyiyah dan Transfer ke Bank Syariah Indonesia Norek. 7181048365 an. Martiningsih (PDA Ponorogo) reff. 2301081121511786044 untuk pembayaran honor verifikasi keuangan Aisyiyah dan Biaya Administrasi Bank dan Transfer ke Bank BRI Norek. 625301004203538  an. Kristin Muslimah (PDA Kediri) reff.  497918192617 untuk pembayaran honor verifikasi keuangan Aisyiyah dan Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301081122548316455 untuk pembayaran honor pendamping verifikasi LK Aisyiyah dan Pembayaran honor pendamping verifikasi LK Aisyiyah 3 hari di tambah transpot (Bu Candra Rp. 1.000.000, biaya admin bank Rp. 2500  Bu Anna Marina Rp. 750.000 biaya bank 2500  Bu Heni Rp. 2.500.000 dan Biaya Administrasi Bank', 'POSTED', 9757500.00, 9757500.00, NULL, NULL, '01a1525d-6541-71d8-a795-c2ec45ab6289', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', NULL, '2026-10-20 08:29:37', '2026-10-20 08:29:37'),
('01a159f1-3f4f-73b4-aa2d-e6dc4e5cc881', 'TRX-EXP-20261020153225', '2023-01-10', 'EXPENSE', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref. 2301101122551693942 Operasional ATC dan Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301101121515400945 Keperluan tim verifikasi, dana surat keterangan konsultan, dan pembuatan laporan 1% dari dana hibah', 'POSTED', 43912975.00, 43912975.00, NULL, NULL, '01a1525d-6541-71d8-a795-c2ec45ab6289', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', NULL, '2026-10-20 08:32:25', '2026-10-20 08:32:25'),
('01a159f1-f121-7225-9555-db217567f41e', 'TRX-EXP-20261020153310', '2023-01-13', 'EXPENSE', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301131122557316522 untuk kebutuhan Muswil', 'POSTED', 35000000.00, 35000000.00, NULL, NULL, '01a1525d-6541-71d8-a795-c2ec45ab6289', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', NULL, '2026-10-20 08:33:10', '2026-10-20 08:33:10'),
('01a159f6-df9a-7188-8de2-644c55dc8782', 'TRX-EXP-20261020153833', '2023-01-16', 'EXPENSE', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301131122557316522 untuk kebutuhan Muswil', 'POSTED', 19700000.00, 19700000.00, NULL, NULL, '01a1525d-6541-71d8-a795-c2ec45ab6289', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', NULL, '2026-10-20 08:38:33', '2026-10-20 08:38:33'),
('01a159f8-ff19-720f-8c97-7138392d926c', 'TRX-INC-20261020154052', '2023-01-21', 'INCOME', 'Pemasukan dari Gubernur Jatim untuk bantuan Muswil diberikan ke bu Candra tunai', 'POSTED', 50000000.00, 50000000.00, NULL, NULL, '01a1525d-6541-71d8-a795-c2ec45ab6289', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', NULL, '2026-10-20 08:40:52', '2026-10-20 08:40:52'),
('01a159fa-2ea6-73b5-8c7c-d84068fcff22', 'TRX-EXP-20261020154210', '2023-01-24', 'EXPENSE', 'Transfer ke BRI Norek. 115901020724505 an. Fitrijah Hidajati ref. 2301241122573568558 untuk kekurangan dana Muswil dan Biaya Administrasi Bank', 'POSTED', 100002500.00, 100002500.00, NULL, NULL, '01a1525d-6541-71d8-a795-c2ec45ab6289', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', NULL, '2026-10-20 08:42:10', '2026-10-20 08:42:10'),
('01a159fb-78ba-71dd-bcbe-3cda5690d8e8', 'TRX-EXP-20261020154335', '2023-01-25', 'EXPENSE', 'Transfer ke BCA an. Rahmad Deky Zakaria Norek. 0190548848 ref.2301251121539574926 untuk membayaran interior termin 1 dan Biaya Administrasi Bank', 'POSTED', 52523050.00, 52523050.00, NULL, NULL, '01a1525d-6541-71d8-a795-c2ec45ab6289', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', NULL, '2026-10-20 08:43:35', '2026-10-20 08:43:35'),
('01a159fc-d7c5-7149-b40c-9dcd74decdfb', 'TRX-INC-20261020154504', '2023-01-27', 'INCOME', 'Pemasukan bantuan Muswil dari PWM (cek bank Muamalat)', 'POSTED', 175000000.00, 175000000.00, NULL, NULL, '01a1525d-6541-71d8-a795-c2ec45ab6289', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', NULL, '2026-10-20 08:45:04', '2026-10-20 08:45:04'),
('01a159fe-14c7-70da-a37d-84a6f63f8717', 'TRX-EXP-20261020154626', '2023-01-27', 'EXPENSE', 'Transport (grab) mengantar cek bank Muamallat dan mencairkan cek bank Muamalllat di Jl. Darmo Surabaya, Administrasi bank (yuli) dan Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301271122579384345 untuk honor pegawai PWA', 'POSTED', 9535500.00, 9535500.00, NULL, NULL, '01a1525d-6541-71d8-a795-c2ec45ab6289', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', NULL, '2026-10-20 08:46:26', '2026-10-20 08:46:26'),
('01a159fe-a2e2-7242-ae59-2fae214c4e62', 'TRX-EXP-20261020154702', '2023-01-31', 'EXPENSE', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301311122586946308 untuk kas operasional', 'POSTED', 5000000.00, 5000000.00, NULL, NULL, '01a1525d-6541-71d8-a795-c2ec45ab6289', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', NULL, '2026-10-20 08:47:02', '2026-10-20 08:47:02'),
('01a15aa0-24c7-7397-9b2c-e78d7e10de30', 'TRX-EXP-20261020184327', '2023-01-01', 'EXPENSE', 'Transfer Parkir + Biaya', 'POSTED', 402500.00, 402500.00, NULL, NULL, '01a1525d-6864-72ea-ad31-f231a54b1b9e', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', NULL, '2026-10-20 11:43:27', '2026-10-20 11:43:27'),
('01a15aa2-d691-70e1-b12f-03d38ca381c6', 'TRX-INC-20261020184623', '2023-01-01', 'INCOME', 'Cicilan 3 Pak Edi', 'POSTED', 200000.00, 200000.00, NULL, NULL, '01a1525d-6864-72ea-ad31-f231a54b1b9e', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', NULL, '2026-10-20 11:46:23', '2026-10-20 11:46:23'),
('01a15aa4-c27e-7293-8c0a-bf150d01d619', 'TRX-EXP-20261020184829', '2023-01-02', 'EXPENSE', 'Transfer Transport Tim Panlih Daerah', 'POSTED', 902500.00, 902500.00, NULL, NULL, '01a1525d-6864-72ea-ad31-f231a54b1b9e', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', NULL, '2026-10-20 11:48:29', '2026-10-20 11:48:29'),
('01a15cdb-01d9-7227-bd48-be2bd9d98ab8', 'TRX-EXP-20261021050659', '2023-01-02', 'EXPENSE', 'Biaya Zoom', 'POSTED', 143000.00, 143000.00, NULL, NULL, '01a1525d-6864-72ea-ad31-f231a54b1b9e', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', NULL, '2026-10-20 22:06:59', '2026-10-20 22:06:59');

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
('01a15957-5e57-7173-bf5c-4c777e7bf839', '01a15957-5e51-7113-bb26-b2600e39d9b5', '217611bd-73a7-48d8-be5e-9b67041b0093', 'DEBIT', 733644.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-20 05:44:20', '2026-10-20 05:44:20'),
('01a15957-5e58-73d3-955b-91b9b17e75f9', '01a15957-5e51-7113-bb26-b2600e39d9b5', 'e6db6cf4-dec7-4ac2-81f6-f14660c0c1c2', 'CREDIT', 733644.00, 'MAIN', 'Penerimaan bunga dari bank', '2026-10-20 05:44:20', '2026-10-20 05:44:20'),
('01a15958-7d63-72cd-a48a-e4db0b494953', '01a15958-7d5c-710b-96e3-c0351f316d47', '1dc22728-2840-44a6-98ef-28897c3e4274', 'DEBIT', 146728.00, 'MAIN', 'Pembayaran pajak tabungan', '2026-10-20 05:45:33', '2026-10-20 05:45:33'),
('01a15958-7d65-7287-86a3-6228f311286b', '01a15958-7d5c-710b-96e3-c0351f316d47', '217611bd-73a7-48d8-be5e-9b67041b0093', 'CREDIT', 146728.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-20 05:45:33', '2026-10-20 05:45:33'),
('01a1598a-516a-71a5-8163-3d044419562c', '01a1598a-5165-7169-b7db-eedb29557d7a', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 'DEBIT', 200000000.00, 'MAIN', 'Pengisian kas', '2026-10-20 06:39:59', '2026-10-20 06:39:59'),
('01a1598a-516b-70e2-b07e-7ec6e2942f2e', '01a1598a-5165-7169-b7db-eedb29557d7a', '217611bd-73a7-48d8-be5e-9b67041b0093', 'CREDIT', 200000000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-20 06:39:59', '2026-10-20 06:39:59'),
('01a1598b-f7c5-7197-b383-434bd5c73e89', '01a1598b-f7be-72db-909c-15b6f5924325', '1dc22728-2840-44a6-98ef-28897c3e4274', 'DEBIT', 30000.00, 'MAIN', 'Biaya Admin Giro', '2026-10-20 06:41:47', '2026-10-20 06:41:47'),
('01a1598b-f7c6-7062-806f-e68e6f1d66f0', '01a1598b-f7be-72db-909c-15b6f5924325', '217611bd-73a7-48d8-be5e-9b67041b0093', 'CREDIT', 30000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-20 06:41:47', '2026-10-20 06:41:47'),
('01a159b8-4e06-7182-9659-acb59ff1fbf0', '01a159b8-4dfd-719a-9c6c-3c51505bba39', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', 'DEBIT', 2000000.00, 'MAIN', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301021122537792517 Pengisian kas operasional', '2026-10-20 07:30:13', '2026-10-20 07:30:13'),
('01a159b8-4e09-71c0-8834-731b6feb4880', '01a159b8-4dfd-719a-9c6c-3c51505bba39', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 'CREDIT', 2000000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-20 07:30:13', '2026-10-20 07:30:13'),
('01a159b9-546e-71c8-ac2d-99dbd98b06a2', '01a159b9-5468-7034-a962-37e0bf59a275', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', 'DEBIT', 3000000.00, 'MAIN', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301051121506253692 Tim UMPRO audensi dengan Gubernur', '2026-10-20 07:31:20', '2026-10-20 07:31:20'),
('01a159b9-5470-7035-bfd6-22fbdeff3100', '01a159b9-5468-7034-a962-37e0bf59a275', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 'CREDIT', 3000000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-20 07:31:20', '2026-10-20 07:31:20'),
('01a159ba-2a1e-733c-b4ea-6ce880a0ebc1', '01a159ba-2a17-7061-8959-94f0ba815020', 'b83b2cf8-b4ec-4d2e-8694-04bf58bf4237', 'DEBIT', 60000000.00, 'MAIN', 'Transfer ke BSI norek. 7187244565 an. ABD Rochim reff. 2301051121506826136 Pembangunan Café termin ke 4', '2026-10-20 07:32:15', '2026-10-20 07:32:15'),
('01a159ba-2a1f-728a-a6e2-ddf83cae3a39', '01a159ba-2a17-7061-8959-94f0ba815020', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 'CREDIT', 60000000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-20 07:32:15', '2026-10-20 07:32:15'),
('01a159ba-c916-72a2-bb67-c6107f962564', '01a159ba-c911-7123-aab0-050a4120af5a', '1dc22728-2840-44a6-98ef-28897c3e4274', 'DEBIT', 2500.00, 'MAIN', 'Administrasi Bank', '2026-10-20 07:32:55', '2026-10-20 07:32:55'),
('01a159ba-c920-700f-9e90-4bb73bcd639d', '01a159ba-c911-7123-aab0-050a4120af5a', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 'CREDIT', 2500.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-20 07:32:55', '2026-10-20 07:32:55'),
('01a159bb-9888-7294-a3d5-449f4657061e', '01a159bb-9882-71b5-b6fb-231090a6956f', 'bf575919-9801-45cf-afc8-868cea1e7066', 'DEBIT', 200000.00, 'MAIN', 'Uang Lembur Yuli untuk persiapan pemeriksaan laporan keuangan (09.00 - 21.00)', '2026-10-20 07:33:48', '2026-10-20 07:33:48'),
('01a159bb-988a-7248-b17d-aea4f7387b37', '01a159bb-9882-71b5-b6fb-231090a6956f', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 'CREDIT', 200000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-20 07:33:48', '2026-10-20 07:33:48'),
('01a159bc-2464-73e9-953e-07951ac0f156', '01a159bc-245f-7375-8055-7a44cfb4037a', 'b7a89777-0db8-4098-b4fb-e324af14436e', 'DEBIT', 300000.00, 'MAIN', 'Tambahan transport Rapat persiapan verifikasi keuangan (17 Des 2017) an Kristin Muslimah', '2026-10-20 07:34:24', '2026-10-20 07:34:24'),
('01a159bc-2465-72f8-a887-4ecf19faac8b', '01a159bc-245f-7375-8055-7a44cfb4037a', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 'CREDIT', 300000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-20 07:34:24', '2026-10-20 07:34:24'),
('01a159bc-b4a5-7118-b20f-c2821a4a0be1', '01a159bc-b49c-703c-b753-af118f3cce65', 'b7a89777-0db8-4098-b4fb-e324af14436e', 'DEBIT', 400000.00, 'MAIN', 'Transport verifikasi LK (6,7,8 Jan 2023) an Kristin Muslimah (PDA Kediri)', '2026-10-20 07:35:01', '2026-10-20 07:35:01'),
('01a159bc-b4a8-7207-b53c-0d6ed7ca3b66', '01a159bc-b49c-703c-b753-af118f3cce65', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 'CREDIT', 400000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-20 07:35:01', '2026-10-20 07:35:01'),
('01a159bd-e029-71aa-9e45-0bd48a761e2b', '01a159bd-e023-72c7-ab31-ab7aaebd3a1f', 'b7a89777-0db8-4098-b4fb-e324af14436e', 'DEBIT', 200000.00, 'MAIN', 'Tambahan transport Rapat persiapan verifikasi keuangan (17 Des 2017) an. Zubaidatul Hidayah', '2026-10-20 07:36:18', '2026-10-20 07:36:18'),
('01a159bd-e02a-73a3-a090-e944690678d9', '01a159bd-e023-72c7-ab31-ab7aaebd3a1f', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 'CREDIT', 200000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-20 07:36:18', '2026-10-20 07:36:18'),
('01a159c1-6b99-72e4-9931-9bd6d123c347', '01a159c1-6b92-7293-aed9-605594dbb999', 'b7a89777-0db8-4098-b4fb-e324af14436e', 'DEBIT', 300000.00, 'MAIN', 'Transport verifikasi LK (6,7,8 Jan 2023) an Zubaidatul Hidayah (PDA Sidoarjo)', '2026-10-20 07:40:10', '2026-10-20 07:40:10'),
('01a159c1-6b9a-71b2-9045-ee21bd4eed92', '01a159c1-6b92-7293-aed9-605594dbb999', 'b7a89777-0db8-4098-b4fb-e324af14436e', 'DEBIT', 450000.00, 'MAIN', 'Tambahan transport Rapat persiapan verifikasi keuangan (17 Des 2017) an. Martiningsih', '2026-10-20 07:40:10', '2026-10-20 07:40:10'),
('01a159c1-6b9b-7370-8dce-db98482e8f5b', '01a159c1-6b92-7293-aed9-605594dbb999', 'b7a89777-0db8-4098-b4fb-e324af14436e', 'DEBIT', 500000.00, 'MAIN', 'Transport verifikasi LK (6,7,8 Jan 2023) an Martiningsih (PDA Ponorogo)', '2026-10-20 07:40:10', '2026-10-20 07:40:10'),
('01a159c1-6b9c-70f0-a389-f735a00b7d9f', '01a159c1-6b92-7293-aed9-605594dbb999', '9d09958c-0bcf-40ad-b0aa-7cbcff9e3396', 'DEBIT', 120000.00, 'MAIN', 'Pembelian Klip (yuli)', '2026-10-20 07:40:10', '2026-10-20 07:40:10'),
('01a159c1-6b9d-7070-ad15-401e9f2f2bf3', '01a159c1-6b92-7293-aed9-605594dbb999', '9d09958c-0bcf-40ad-b0aa-7cbcff9e3396', 'DEBIT', 105000.00, 'MAIN', 'Tinta print Data Print, lem, isi staples', '2026-10-20 07:40:10', '2026-10-20 07:40:10'),
('01a159c1-6b9d-7070-ad15-401e9f5313ad', '01a159c1-6b92-7293-aed9-605594dbb999', 'b7a89777-0db8-4098-b4fb-e324af14436e', 'DEBIT', 9420000.00, 'MAIN', 'Tinta print Data Print, lem, isi staples', '2026-10-20 07:40:10', '2026-10-20 07:40:10'),
('01a159c1-6b9e-711a-b17d-0dcd704f86e5', '01a159c1-6b92-7293-aed9-605594dbb999', 'ef0ab049-3707-4b8e-a7ba-53d1f3ad3694', 'DEBIT', 10000.00, 'MAIN', 'Parkir', '2026-10-20 07:40:10', '2026-10-20 07:40:10'),
('01a159c1-6b9f-7211-9048-d0a297c0b19a', '01a159c1-6b92-7293-aed9-605594dbb999', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 'CREDIT', 10905000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-20 07:40:10', '2026-10-20 07:40:10'),
('01a159ee-b2c9-7194-a0d4-7de88947ffc1', '01a159ee-b2c3-73ad-a0ab-15fc298346dc', 'b7a89777-0db8-4098-b4fb-e324af14436e', 'DEBIT', 1500000.00, 'MAIN', 'Transfer ke Bank Jatim Norek. 6202209605 an. Siti Zubaidatul Hidayah (PDA Sidoarjo) reff. JMB371957650 untuk pembayaran honor verifikasi keuangan Aisyiyah', '2026-10-20 08:29:37', '2026-10-20 08:29:37'),
('01a159ee-b2cb-70b0-903b-17d1ea5f6d66', '01a159ee-b2c3-73ad-a0ab-15fc298346dc', 'b7a89777-0db8-4098-b4fb-e324af14436e', 'DEBIT', 1500000.00, 'MAIN', 'Transfer ke Bank Syariah Indonesia Norek. 7181048365 an. Martiningsih (PDA Ponorogo) reff. 2301081121511786044 untuk pembayaran honor verifikasi keuangan Aisyiyah', '2026-10-20 08:29:37', '2026-10-20 08:29:37'),
('01a159ee-b2cd-7054-bc07-42c4cea7c56b', '01a159ee-b2c3-73ad-a0ab-15fc298346dc', '1dc22728-2840-44a6-98ef-28897c3e4274', 'DEBIT', 2500.00, 'MAIN', 'Biaya Administrasi Bank', '2026-10-20 08:29:37', '2026-10-20 08:29:37'),
('01a159ee-b2ce-7115-8a58-f4d276cabd5e', '01a159ee-b2c3-73ad-a0ab-15fc298346dc', 'b7a89777-0db8-4098-b4fb-e324af14436e', 'DEBIT', 1500000.00, 'MAIN', 'Transfer ke Bank BRI Norek. 625301004203538  an. Kristin Muslimah (PDA Kediri) reff.  497918192617 untuk pembayaran honor verifikasi keuangan Aisyiyah', '2026-10-20 08:29:37', '2026-10-20 08:29:37'),
('01a159ee-b2cf-70b9-8341-2e7b32e177e8', '01a159ee-b2c3-73ad-a0ab-15fc298346dc', 'b7a89777-0db8-4098-b4fb-e324af14436e', 'DEBIT', 1000000.00, 'MAIN', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301081122548316455 untuk pembayaran honor pendamping verifikasi LK Aisyiyah', '2026-10-20 08:29:37', '2026-10-20 08:29:37'),
('01a159ee-b2d0-73fd-b2aa-a277eca09e08', '01a159ee-b2c3-73ad-a0ab-15fc298346dc', 'b7a89777-0db8-4098-b4fb-e324af14436e', 'DEBIT', 4250000.00, 'MAIN', 'Pembayaran honor pendamping verifikasi LK Aisyiyah 3 hari di tambah transpot (Bu Candra Rp. 1.000.000, biaya admin bank Rp. 2500  Bu Anna Marina Rp. 750.000 biaya bank 2500  Bu Heni Rp. 2.500.000', '2026-10-20 08:29:38', '2026-10-20 08:29:38'),
('01a159ee-b2d4-7391-9574-720aa9f86155', '01a159ee-b2c3-73ad-a0ab-15fc298346dc', '1dc22728-2840-44a6-98ef-28897c3e4274', 'DEBIT', 5000.00, 'MAIN', 'Biaya Administrasi Bank', '2026-10-20 08:29:38', '2026-10-20 08:29:38'),
('01a159ee-b2d7-732e-a472-de9fbc2684f8', '01a159ee-b2c3-73ad-a0ab-15fc298346dc', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 'CREDIT', 9757500.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-20 08:29:38', '2026-10-20 08:29:38'),
('01a159f1-3f58-7377-9401-b054630da781', '01a159f1-3f4f-73b4-aa2d-e6dc4e5cc881', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', 'DEBIT', 21190000.00, 'MAIN', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref. 2301101122551693942 Operasional ATC', '2026-10-20 08:32:25', '2026-10-20 08:32:25'),
('01a159f1-3f59-702e-a5ea-8b333c946f26', '01a159f1-3f4f-73b4-aa2d-e6dc4e5cc881', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', 'DEBIT', 22722975.00, 'MAIN', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301101121515400945 Keperluan tim verifikasi, dana surat keterangan konsultan, dan pembuatan laporan 1% dari dana hibah', '2026-10-20 08:32:25', '2026-10-20 08:32:25'),
('01a159f1-3f5b-72b5-ad75-0a9c81582b74', '01a159f1-3f4f-73b4-aa2d-e6dc4e5cc881', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 'CREDIT', 43912975.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-20 08:32:25', '2026-10-20 08:32:25'),
('01a159f1-f127-731e-acf4-faefca04cac2', '01a159f1-f121-7225-9555-db217567f41e', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', 'DEBIT', 35000000.00, 'MAIN', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301131122557316522 untuk kebutuhan Muswil', '2026-10-20 08:33:10', '2026-10-20 08:33:10'),
('01a159f1-f12e-71e7-8366-3ac5a9ee2e7d', '01a159f1-f121-7225-9555-db217567f41e', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 'CREDIT', 35000000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-20 08:33:10', '2026-10-20 08:33:10'),
('01a159f6-df9f-7399-b50e-00e25c4da64e', '01a159f6-df9a-7188-8de2-644c55dc8782', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', 'DEBIT', 19700000.00, 'MAIN', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301131122557316522 untuk kebutuhan Muswil', '2026-10-20 08:38:33', '2026-10-20 08:38:33'),
('01a159f6-dfa0-73eb-bfef-4ffcb158ba13', '01a159f6-df9a-7188-8de2-644c55dc8782', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 'CREDIT', 19700000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-20 08:38:33', '2026-10-20 08:38:33'),
('01a159f8-ff1f-70de-a9c1-b69c1d55dfbf', '01a159f8-ff19-720f-8c97-7138392d926c', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 'DEBIT', 50000000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-20 08:40:52', '2026-10-20 08:40:52'),
('01a159f8-ff20-72b5-84cb-3af00c83648c', '01a159f8-ff19-720f-8c97-7138392d926c', 'd0cf1368-347c-4b97-99b6-c0fc88f0392e', 'CREDIT', 50000000.00, 'MAIN', 'Pemasukan dari Gubernur Jatim untuk bantuan Muswil diberikan ke bu Candra tunai', '2026-10-20 08:40:52', '2026-10-20 08:40:52'),
('01a159fa-2eb0-7388-b9fd-9aa3ec4f76bf', '01a159fa-2ea6-73b5-8c7c-d84068fcff22', 'b7a89777-0db8-4098-b4fb-e324af14436e', 'DEBIT', 100000000.00, 'MAIN', 'Transfer ke BRI Norek. 115901020724505 an. Fitrijah Hidajati ref. 2301241122573568558 untuk kekurangan dana Muswil', '2026-10-20 08:42:10', '2026-10-20 08:42:10'),
('01a159fa-2eb4-70f2-8618-5c449c732b98', '01a159fa-2ea6-73b5-8c7c-d84068fcff22', '1dc22728-2840-44a6-98ef-28897c3e4274', 'DEBIT', 2500.00, 'MAIN', 'Biaya Administrasi Bank', '2026-10-20 08:42:10', '2026-10-20 08:42:10'),
('01a159fa-2eb5-7261-9fe3-a4404344a5ed', '01a159fa-2ea6-73b5-8c7c-d84068fcff22', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 'CREDIT', 100002500.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-20 08:42:10', '2026-10-20 08:42:10'),
('01a159fb-78bf-7199-bb0c-f9c62ecabc92', '01a159fb-78ba-71dd-bcbe-3cda5690d8e8', 'b83b2cf8-b4ec-4d2e-8694-04bf58bf4237', 'DEBIT', 52520550.00, 'MAIN', 'Transfer ke BCA an. Rahmad Deky Zakaria Norek. 0190548848 ref.2301251121539574926 untuk membayaran interior termin 1', '2026-10-20 08:43:35', '2026-10-20 08:43:35'),
('01a159fb-78c1-72e2-bb8d-63c73908800a', '01a159fb-78ba-71dd-bcbe-3cda5690d8e8', '1dc22728-2840-44a6-98ef-28897c3e4274', 'DEBIT', 2500.00, 'MAIN', 'Biaya Administrasi Bank', '2026-10-20 08:43:35', '2026-10-20 08:43:35'),
('01a159fb-78c2-71b7-ac63-842b80e43304', '01a159fb-78ba-71dd-bcbe-3cda5690d8e8', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 'CREDIT', 52523050.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-20 08:43:35', '2026-10-20 08:43:35'),
('01a159fc-d7cb-718d-8cea-58c5e2852d28', '01a159fc-d7c5-7149-b40c-9dcd74decdfb', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 'DEBIT', 175000000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-20 08:45:04', '2026-10-20 08:45:04'),
('01a159fc-d7cd-7313-8182-6027559edf38', '01a159fc-d7c5-7149-b40c-9dcd74decdfb', '3aed7fc1-a08f-4eee-a040-29e34c846836', 'CREDIT', 175000000.00, 'MAIN', 'Pemasukan bantuan Muswil dari PWM (cek bank Muamalat)', '2026-10-20 08:45:04', '2026-10-20 08:45:04'),
('01a159fe-14d0-71cb-b4a6-ae622a13c213', '01a159fe-14c7-70da-a37d-84a6f63f8717', 'a56fbc97-5851-4bcd-a3a8-c5fd2e479868', 'DEBIT', 162500.00, 'MAIN', 'Transport (grab) mengantar cek bank Muamallat dan mencairkan cek bank Muamalllat di Jl. Darmo Surabaya, Administrasi bank (yuli)', '2026-10-20 08:46:26', '2026-10-20 08:46:26'),
('01a159fe-14d1-70d8-9b3b-0ce76b470ca3', '01a159fe-14c7-70da-a37d-84a6f63f8717', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', 'DEBIT', 9373000.00, 'MAIN', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301271122579384345 untuk honor pegawai PWA', '2026-10-20 08:46:26', '2026-10-20 08:46:26'),
('01a159fe-14d2-721d-ba11-4d45b738cef9', '01a159fe-14c7-70da-a37d-84a6f63f8717', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 'CREDIT', 9535500.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-20 08:46:26', '2026-10-20 08:46:26'),
('01a159fe-a2eb-71d3-8770-7fc391659347', '01a159fe-a2e2-7242-ae59-2fae214c4e62', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', 'DEBIT', 5000000.00, 'MAIN', 'Transfer ke bank Mandiri an. Fitroni Rizal Sahrani Norek. 1410014458509 ref 2301311122586946308 untuk kas operasional', '2026-10-20 08:47:02', '2026-10-20 08:47:02'),
('01a159fe-a2ed-7083-b54c-bc60087ca052', '01a159fe-a2e2-7242-ae59-2fae214c4e62', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', 'CREDIT', 5000000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-20 08:47:02', '2026-10-20 08:47:02'),
('01a15aa0-24ce-7194-a555-981eb56616d8', '01a15aa0-24c7-7397-9b2c-e78d7e10de30', 'ef0ab049-3707-4b8e-a7ba-53d1f3ad3694', 'DEBIT', 402500.00, 'MAIN', 'Transfer Parkir + Biaya', '2026-10-20 11:43:27', '2026-10-20 11:43:27'),
('01a15aa0-24d0-7399-b583-e78c318b4c1c', '01a15aa0-24c7-7397-9b2c-e78d7e10de30', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', 'CREDIT', 402500.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-20 11:43:27', '2026-10-20 11:43:27'),
('01a15aa2-d697-707a-8d86-e124d408edab', '01a15aa2-d691-70e1-b12f-03d38ca381c6', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', 'DEBIT', 200000.00, 'MAIN', 'Mutasi Kas Masuk', '2026-10-20 11:46:23', '2026-10-20 11:46:23'),
('01a15aa2-d698-734f-a843-52cb56bb5ae1', '01a15aa2-d691-70e1-b12f-03d38ca381c6', '54a2c8f7-8bf2-4baf-a30e-52863c7b15db', 'CREDIT', 200000.00, 'MAIN', 'Cicilan 3 Pak Edi', '2026-10-20 11:46:23', '2026-10-20 11:46:23'),
('01a15aa4-c283-7076-98d4-6998da88af76', '01a15aa4-c27e-7293-8c0a-bf150d01d619', 'b7a89777-0db8-4098-b4fb-e324af14436e', 'DEBIT', 902500.00, 'MAIN', 'Transfer Transport Tim Panlih Daerah', '2026-10-20 11:48:29', '2026-10-20 11:48:29'),
('01a15aa4-c285-72d3-902e-bec8e972b01b', '01a15aa4-c27e-7293-8c0a-bf150d01d619', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', 'CREDIT', 902500.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-20 11:48:29', '2026-10-20 11:48:29'),
('01a15cdb-01e4-7380-8ca7-02dce06f570b', '01a15cdb-01d9-7227-bd48-be2bd9d98ab8', 'dfca8b6c-5b37-410c-a4fb-a939792edd63', 'DEBIT', 143000.00, 'MAIN', 'Biaya Zoom', '2026-10-20 22:06:59', '2026-10-20 22:06:59'),
('01a15cdb-01e6-7196-9d33-a2106ab330e8', '01a15cdb-01d9-7227-bd48-be2bd9d98ab8', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', 'CREDIT', 143000.00, 'MAIN', 'Mutasi Kas Keluar', '2026-10-20 22:06:59', '2026-10-20 22:06:59');

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
('01a1525d-6225-70cd-ad6f-a9ad3ff95da8', 'Super Admin', NULL, NULL, 'superadmin@example.com', NULL, '$2y$12$u70avDub1.diYuFi/on.BevCwAECamoKPmYq0VzBEyyMdw67ppKi.', 1, NULL, '2026-10-18 21:13:34', '2026-10-18 21:13:34'),
('01a1525d-6541-71d8-a795-c2ec45ab6289', 'Bendahara', NULL, NULL, 'bendahara@example.com', NULL, '$2y$12$qkSos3xBU0AL.cRHdW4GjufGJPNn9v0bCgD9IJm5ijU0uyRnISEfG', 0, NULL, '2026-10-18 21:13:34', '2026-10-18 21:13:34'),
('01a1525d-6864-72ea-ad31-f231a54b1b9e', 'Pemegang Kas Operasional', NULL, NULL, 'pemegang-kas@example.com', NULL, '$2y$12$SuY0Ywnp/0lDbvHgGHvwce0OY9dA4F.uGvXHVzIlRuYRWDU54nPOW', 0, NULL, '2026-10-18 21:13:35', '2026-10-18 21:13:35');

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
('01a1525d-897f-73c6-9999-cfc3f2bb8120', '01a1525d-6541-71d8-a795-c2ec45ab6289', '0159713a-ac72-4c17-a5b6-8352806762c1', '2026-10-18 21:13:44', '2026-10-18 21:13:44'),
('01a1525d-899d-730d-bc9c-753d6478f8d2', '01a1525d-6541-71d8-a795-c2ec45ab6289', '07273ff4-96b4-4756-8f70-a34e66bb36d0', '2026-10-18 21:13:44', '2026-10-18 21:13:44'),
('01a1525d-89b3-70d5-a372-e507f696b66f', '01a1525d-6541-71d8-a795-c2ec45ab6289', '07c0b1d5-c1b2-426f-afd3-1e5db0ef4f15', '2026-10-18 21:13:44', '2026-10-18 21:13:44'),
('01a1525d-89c9-7286-8b8b-672d8a079fa3', '01a1525d-6541-71d8-a795-c2ec45ab6289', '07c9a867-c2e3-41e5-ab42-929d97c947d2', '2026-10-18 21:13:44', '2026-10-18 21:13:44'),
('01a1525d-89e3-722e-a339-fabb35f300e0', '01a1525d-6541-71d8-a795-c2ec45ab6289', '0843a6ab-d620-4879-9a9a-a3147d9ac471', '2026-10-18 21:13:44', '2026-10-18 21:13:44'),
('01a1525d-89fa-736f-b81b-314111504f38', '01a1525d-6541-71d8-a795-c2ec45ab6289', '0ec1d989-42d6-4b22-b5fc-d46f69f3ca47', '2026-10-18 21:13:44', '2026-10-18 21:13:44'),
('01a1525d-8a12-725e-aca8-bca2c6f33dc5', '01a1525d-6541-71d8-a795-c2ec45ab6289', '0f3cda5b-5055-459d-8d8d-5e5d68f77675', '2026-10-18 21:13:44', '2026-10-18 21:13:44'),
('01a1525d-8a26-71b8-bf25-fd328ca67cd4', '01a1525d-6541-71d8-a795-c2ec45ab6289', '0f9579c0-6cc3-4458-aa0b-f9a15acd9578', '2026-10-18 21:13:44', '2026-10-18 21:13:44'),
('01a1525d-8a3c-70b6-9609-754d040102c7', '01a1525d-6541-71d8-a795-c2ec45ab6289', '10b6dc05-cc5d-44f4-9bb8-a7f5c9f6d3a3', '2026-10-18 21:13:44', '2026-10-18 21:13:44'),
('01a1525d-8a60-7238-b4b0-c123a4300132', '01a1525d-6541-71d8-a795-c2ec45ab6289', '14dc35fc-8cf0-47f2-b41f-55de875caf32', '2026-10-18 21:13:44', '2026-10-18 21:13:44'),
('01a1525d-8a90-73b1-82fa-c114ef6663c5', '01a1525d-6541-71d8-a795-c2ec45ab6289', '1dc22728-2840-44a6-98ef-28897c3e4274', '2026-10-18 21:13:44', '2026-10-18 21:13:44'),
('01a1525d-8ac9-7000-be0a-8687936322f5', '01a1525d-6541-71d8-a795-c2ec45ab6289', '217611bd-73a7-48d8-be5e-9b67041b0093', '2026-10-18 21:13:44', '2026-10-18 21:13:44'),
('01a1525d-8af8-70a9-b818-1a930a486aaf', '01a1525d-6541-71d8-a795-c2ec45ab6289', '21b0be96-38c9-43d3-adb8-6e12deb1a102', '2026-10-18 21:13:44', '2026-10-18 21:13:44'),
('01a1525d-8b27-72aa-885e-4956456b682c', '01a1525d-6541-71d8-a795-c2ec45ab6289', '2b03559e-ddf0-4e3c-9256-a86032fa2bda', '2026-10-18 21:13:44', '2026-10-18 21:13:44'),
('01a1525d-8b53-72aa-be11-288da1cb890a', '01a1525d-6541-71d8-a795-c2ec45ab6289', '2de2c5c6-9053-4d1f-9f8f-773dc660512b', '2026-10-18 21:13:44', '2026-10-18 21:13:44'),
('01a1525d-8b80-71eb-9af1-9929f9007b2d', '01a1525d-6541-71d8-a795-c2ec45ab6289', '2dee313b-f6d5-4a67-a6c8-6543bcd9972e', '2026-10-18 21:13:44', '2026-10-18 21:13:44'),
('01a1525d-8baf-7347-b8ed-64bd7d590a46', '01a1525d-6541-71d8-a795-c2ec45ab6289', '2ebe8ddb-e1c2-4da4-b0bb-15dba502c9dc', '2026-10-18 21:13:44', '2026-10-18 21:13:44'),
('01a1525d-8bde-7117-990b-30d9b221acae', '01a1525d-6541-71d8-a795-c2ec45ab6289', '3342e9fa-a2a8-4777-87d8-fb31912a74f3', '2026-10-18 21:13:44', '2026-10-18 21:13:44'),
('01a1525d-8c0e-7223-b652-3de519eb5c5b', '01a1525d-6541-71d8-a795-c2ec45ab6289', '376339c8-b760-479a-89e2-97995ed7b3ea', '2026-10-18 21:13:44', '2026-10-18 21:13:44'),
('01a1525d-8c44-7078-8337-2ca509b87822', '01a1525d-6541-71d8-a795-c2ec45ab6289', '386f9d14-1253-40df-b09b-afb1938d507a', '2026-10-18 21:13:44', '2026-10-18 21:13:44'),
('01a1525d-8c79-701b-b67a-b8a2da52aeba', '01a1525d-6541-71d8-a795-c2ec45ab6289', '38f0b478-7b9f-488e-8747-13d743638a7a', '2026-10-18 21:13:44', '2026-10-18 21:13:44'),
('01a1525d-8cb8-70ef-9ba2-88ff6d4a4546', '01a1525d-6541-71d8-a795-c2ec45ab6289', '3a6d0b45-bcdf-4322-956a-36909c9b9c3d', '2026-10-18 21:13:45', '2026-10-18 21:13:45'),
('01a1525d-8cf1-7081-9758-8ff85d537512', '01a1525d-6541-71d8-a795-c2ec45ab6289', '3aed7fc1-a08f-4eee-a040-29e34c846836', '2026-10-18 21:13:45', '2026-10-18 21:13:45'),
('01a1525d-8d24-716f-b860-518449efad1b', '01a1525d-6541-71d8-a795-c2ec45ab6289', '3ba8e8bb-fe4e-4658-af3f-18923b3722f7', '2026-10-18 21:13:45', '2026-10-18 21:13:45'),
('01a1525d-8d4e-714e-b80a-e680204cd899', '01a1525d-6541-71d8-a795-c2ec45ab6289', '3c146a69-c72e-4394-a165-cda538947fff', '2026-10-18 21:13:45', '2026-10-18 21:13:45'),
('01a1525d-8d85-71b2-ac62-37ce78a49d2b', '01a1525d-6541-71d8-a795-c2ec45ab6289', '3c63e3d3-31df-40ee-a780-b36f628c1b3e', '2026-10-18 21:13:45', '2026-10-18 21:13:45'),
('01a1525d-8dc6-73b5-8e89-446822004b7b', '01a1525d-6541-71d8-a795-c2ec45ab6289', '40c08639-0031-45f8-9774-003a59f0a06d', '2026-10-18 21:13:45', '2026-10-18 21:13:45'),
('01a1525d-8deb-7309-b488-b1ffb27e91eb', '01a1525d-6541-71d8-a795-c2ec45ab6289', '4188429a-411b-47b5-be56-8cd2ad12a042', '2026-10-18 21:13:45', '2026-10-18 21:13:45'),
('01a1525d-8e01-70f1-90cd-b41ddb5bed0b', '01a1525d-6541-71d8-a795-c2ec45ab6289', '420ff500-8f4c-404c-abd6-9bad93eff4af', '2026-10-18 21:13:45', '2026-10-18 21:13:45'),
('01a1525d-8e15-707e-a110-1a5e39dfae71', '01a1525d-6541-71d8-a795-c2ec45ab6289', '45fbfc68-5387-4bfa-8b3e-2e0c0ee05245', '2026-10-18 21:13:45', '2026-10-18 21:13:45'),
('01a1525d-8e2c-72b2-ae1b-d6400441e3e1', '01a1525d-6541-71d8-a795-c2ec45ab6289', '4d7681a6-f811-45b8-aae1-ab6269b27292', '2026-10-18 21:13:45', '2026-10-18 21:13:45'),
('01a1525d-8e3f-72aa-bb26-a0927f43e99a', '01a1525d-6541-71d8-a795-c2ec45ab6289', '535aaf43-9bd1-4da7-942c-c451d43f1da8', '2026-10-18 21:13:45', '2026-10-18 21:13:45'),
('01a1525d-8e53-7238-a3ec-8f0ea5dc76e9', '01a1525d-6541-71d8-a795-c2ec45ab6289', '545f5382-e38c-43bd-a9f0-0f44327b36d5', '2026-10-18 21:13:45', '2026-10-18 21:13:45'),
('01a1525d-8e6a-703f-8b46-e906c8e51383', '01a1525d-6541-71d8-a795-c2ec45ab6289', '54a2c8f7-8bf2-4baf-a30e-52863c7b15db', '2026-10-18 21:13:45', '2026-10-18 21:13:45'),
('01a1525d-8e86-7234-808c-d65a4af3a6c3', '01a1525d-6541-71d8-a795-c2ec45ab6289', '56937cd4-a01f-46d2-8c58-34eb640b1c8d', '2026-10-18 21:13:45', '2026-10-18 21:13:45'),
('01a1525d-8ea3-7166-a517-421fa0ba2701', '01a1525d-6541-71d8-a795-c2ec45ab6289', '56a3c4f6-d165-4f3d-81a3-7afb856e1520', '2026-10-18 21:13:45', '2026-10-18 21:13:45'),
('01a1525d-8ebc-729f-b519-fe3cf02d4c30', '01a1525d-6541-71d8-a795-c2ec45ab6289', '58913402-2f31-41b3-8f29-442f5a203139', '2026-10-18 21:13:45', '2026-10-18 21:13:45'),
('01a1525d-8eea-71e1-a389-3e59fcd67a94', '01a1525d-6541-71d8-a795-c2ec45ab6289', '5934d883-8403-4e1b-be51-bfd87a4950ab', '2026-10-18 21:13:45', '2026-10-18 21:13:45'),
('01a1525d-8f16-723c-b1d3-2d1fddaf0580', '01a1525d-6541-71d8-a795-c2ec45ab6289', '5afd9a05-58cf-431c-a1f3-d7f3552db08f', '2026-10-18 21:13:45', '2026-10-18 21:13:45'),
('01a1525d-8f34-73c0-a00b-fad7870c490d', '01a1525d-6541-71d8-a795-c2ec45ab6289', '5b1066bc-288a-421f-b554-523d64ce9295', '2026-10-18 21:13:45', '2026-10-18 21:13:45'),
('01a1525d-8f58-739c-b3ad-e0640065d33a', '01a1525d-6541-71d8-a795-c2ec45ab6289', '5ebedf2c-d685-41fe-937d-bb9f3c3e6fa6', '2026-10-18 21:13:45', '2026-10-18 21:13:45'),
('01a1525d-8f7a-7176-b516-8c5c429f481f', '01a1525d-6541-71d8-a795-c2ec45ab6289', '5f5c44e2-728d-4fd5-bb5d-431361a7891c', '2026-10-18 21:13:45', '2026-10-18 21:13:45'),
('01a1525d-8f9b-7050-a7f7-64002952afbc', '01a1525d-6541-71d8-a795-c2ec45ab6289', '6806e476-237b-4db0-9732-d6487dd7de00', '2026-10-18 21:13:45', '2026-10-18 21:13:45'),
('01a1525d-8fbf-73bd-a19b-1c1779b70bff', '01a1525d-6541-71d8-a795-c2ec45ab6289', '68539801-9d15-4c54-bd79-294aad72912f', '2026-10-18 21:13:45', '2026-10-18 21:13:45'),
('01a1525d-8fe3-7370-b196-d674bf906353', '01a1525d-6541-71d8-a795-c2ec45ab6289', '69670f62-db4b-4cf3-9d59-ea1782710a9a', '2026-10-18 21:13:45', '2026-10-18 21:13:45'),
('01a1525d-9003-70c3-9cc4-d983dbab1e5a', '01a1525d-6541-71d8-a795-c2ec45ab6289', '6a0227fd-84f3-40bc-8693-6b1edbd836b1', '2026-10-18 21:13:45', '2026-10-18 21:13:45'),
('01a1525d-9022-71ad-a589-0abe4ff4142f', '01a1525d-6541-71d8-a795-c2ec45ab6289', '6a6499da-2347-4b2a-9ecc-1a10623f0710', '2026-10-18 21:13:45', '2026-10-18 21:13:45'),
('01a1525d-9046-70b4-8f00-8d14d3493af8', '01a1525d-6541-71d8-a795-c2ec45ab6289', '6af539ad-1478-40bb-ad1d-7a101055dc9c', '2026-10-18 21:13:45', '2026-10-18 21:13:45'),
('01a1525d-9077-71fd-8f71-610d379cb569', '01a1525d-6541-71d8-a795-c2ec45ab6289', '6b417011-8fde-4be3-a30b-5b25132f9cbe', '2026-10-18 21:13:45', '2026-10-18 21:13:45'),
('01a1525d-90a8-707f-b3d5-f2be997d39cc', '01a1525d-6541-71d8-a795-c2ec45ab6289', '71206ec3-fed1-45d1-92d3-6e8f7fbf6467', '2026-10-18 21:13:46', '2026-10-18 21:13:46'),
('01a1525d-90cf-71df-9c0f-3f1558b0eb8b', '01a1525d-6541-71d8-a795-c2ec45ab6289', '7265dbca-563d-4f78-9251-f55930a8a93a', '2026-10-18 21:13:46', '2026-10-18 21:13:46'),
('01a1525d-90fc-7198-b486-12d774329b96', '01a1525d-6541-71d8-a795-c2ec45ab6289', '728194df-d7e3-4e86-a565-b52040d0fc81', '2026-10-18 21:13:46', '2026-10-18 21:13:46'),
('01a1525d-9123-716e-bdb6-a477868ff56f', '01a1525d-6541-71d8-a795-c2ec45ab6289', '746adf43-84d2-4ae9-a86a-de40ab511c8b', '2026-10-18 21:13:46', '2026-10-18 21:13:46'),
('01a1525d-914e-727a-90f1-28dc5cb532df', '01a1525d-6541-71d8-a795-c2ec45ab6289', '757cde74-832b-4164-97be-82b78afb6b9f', '2026-10-18 21:13:46', '2026-10-18 21:13:46'),
('01a1525d-9171-71d5-9320-5c028981a250', '01a1525d-6541-71d8-a795-c2ec45ab6289', '773c6650-da28-43c5-9e58-e5cf96a7820e', '2026-10-18 21:13:46', '2026-10-18 21:13:46'),
('01a1525d-9196-7158-8664-39b1d0706a2b', '01a1525d-6541-71d8-a795-c2ec45ab6289', '82241006-263f-4be7-a5ab-856596307692', '2026-10-18 21:13:46', '2026-10-18 21:13:46'),
('01a1525d-91c7-73d2-92f2-4402762631b3', '01a1525d-6541-71d8-a795-c2ec45ab6289', '8426372e-1021-455c-8ad7-7195b2425481', '2026-10-18 21:13:46', '2026-10-18 21:13:46'),
('01a1525d-91f4-730e-a6a5-c09cf90dffcf', '01a1525d-6541-71d8-a795-c2ec45ab6289', '8495fc04-2c0f-40ac-8187-bbb035488ca5', '2026-10-18 21:13:46', '2026-10-18 21:13:46'),
('01a1525d-9224-73db-bb7e-d5099d75fab3', '01a1525d-6541-71d8-a795-c2ec45ab6289', '88a67975-06bf-4dbe-b1ee-5caaa9212505', '2026-10-18 21:13:46', '2026-10-18 21:13:46'),
('01a1525d-924c-73f5-a2c5-10fb30603d94', '01a1525d-6541-71d8-a795-c2ec45ab6289', '8b442de5-2474-43cd-a2d2-e16c43ccf387', '2026-10-18 21:13:46', '2026-10-18 21:13:46'),
('01a1525d-926f-72d2-a617-b15301f1fbb6', '01a1525d-6541-71d8-a795-c2ec45ab6289', '8b4c6709-0d76-4eff-b034-1261fc42a678', '2026-10-18 21:13:46', '2026-10-18 21:13:46'),
('01a1525d-9296-7073-931c-981a01942d4e', '01a1525d-6541-71d8-a795-c2ec45ab6289', '8bc1f9ed-24aa-4e5b-8f6e-adc561d0b739', '2026-10-18 21:13:46', '2026-10-18 21:13:46'),
('01a1525d-92d8-703e-8cf1-0f46fc19152c', '01a1525d-6541-71d8-a795-c2ec45ab6289', '8ea7b710-f98a-4881-8fdb-db9dbaa31f87', '2026-10-18 21:13:46', '2026-10-18 21:13:46'),
('01a1525d-9364-7117-a17c-f3e707c45991', '01a1525d-6541-71d8-a795-c2ec45ab6289', '902753ad-a0f2-4506-bb23-e77b2fab6f32', '2026-10-18 21:13:46', '2026-10-18 21:13:46'),
('01a1525d-938b-71ee-8008-000376422373', '01a1525d-6541-71d8-a795-c2ec45ab6289', '91861619-4d6e-485d-afa3-a3ddd1038ffd', '2026-10-18 21:13:46', '2026-10-18 21:13:46'),
('01a1525d-93aa-7317-b658-42fabb127143', '01a1525d-6541-71d8-a795-c2ec45ab6289', '918b135d-a3ea-47ee-9b4b-d02793a483eb', '2026-10-18 21:13:46', '2026-10-18 21:13:46'),
('01a1525d-93c2-7004-971b-387278d07bfa', '01a1525d-6541-71d8-a795-c2ec45ab6289', '9289e0c9-c5f1-48ba-9bf1-24134c0c0848', '2026-10-18 21:13:46', '2026-10-18 21:13:46'),
('01a1525d-93df-73b5-9f8d-8a5514ee1858', '01a1525d-6541-71d8-a795-c2ec45ab6289', '9306d1b1-c8c5-4f57-9adb-a981d678de21', '2026-10-18 21:13:46', '2026-10-18 21:13:46'),
('01a1525d-93fe-73db-adfe-1f5620dd657c', '01a1525d-6541-71d8-a795-c2ec45ab6289', '93556b2c-37cd-4485-ad00-b5c68e1f33d2', '2026-10-18 21:13:46', '2026-10-18 21:13:46'),
('01a1525d-941c-73d6-9b10-afb314587943', '01a1525d-6541-71d8-a795-c2ec45ab6289', '9379f29b-27a8-4f16-a434-80370a8a625d', '2026-10-18 21:13:46', '2026-10-18 21:13:46'),
('01a1525d-943e-737d-bf04-f2967b5abc70', '01a1525d-6541-71d8-a795-c2ec45ab6289', '95bb9b8c-a02d-413b-a22d-69f79c8f69c1', '2026-10-18 21:13:46', '2026-10-18 21:13:46'),
('01a1525d-945e-73cf-b38d-5a327315396a', '01a1525d-6541-71d8-a795-c2ec45ab6289', '966cf05c-3c1e-4058-8da6-121f84bf8c57', '2026-10-18 21:13:46', '2026-10-18 21:13:46'),
('01a1525d-947b-70ba-8d15-16128e448604', '01a1525d-6541-71d8-a795-c2ec45ab6289', '9763bfd2-f7a5-4959-85d1-681a7866b758', '2026-10-18 21:13:47', '2026-10-18 21:13:47'),
('01a1525d-94b6-725a-8840-79940aa15844', '01a1525d-6541-71d8-a795-c2ec45ab6289', '9d09958c-0bcf-40ad-b0aa-7cbcff9e3396', '2026-10-18 21:13:47', '2026-10-18 21:13:47'),
('01a1525d-94ea-714c-bb0b-acbe68b04822', '01a1525d-6541-71d8-a795-c2ec45ab6289', '9d0aaabc-a02f-4aa9-bd14-293bc74ac24c', '2026-10-18 21:13:47', '2026-10-18 21:13:47'),
('01a1525d-955e-72d6-bd6e-a03c4d8d265c', '01a1525d-6541-71d8-a795-c2ec45ab6289', '9e9430cf-4733-4a62-aec5-be3b1aec108c', '2026-10-18 21:13:47', '2026-10-18 21:13:47'),
('01a1525d-957c-704a-ba78-c542e4b239f8', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'a2548395-e459-4ae8-8b64-34e4bba29636', '2026-10-18 21:13:47', '2026-10-18 21:13:47'),
('01a1525d-9594-710f-9ee3-9ed5956def03', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'a332ec1f-1086-4baf-81b8-bd6368f76425', '2026-10-18 21:13:47', '2026-10-18 21:13:47'),
('01a1525d-95ab-7357-b648-41c6ec2915d1', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'a3654a7f-7b1e-4982-92bd-51bc3b688329', '2026-10-18 21:13:47', '2026-10-18 21:13:47'),
('01a1525d-95c0-73b7-af15-b272dce699e8', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'a5195e2e-a156-49e5-b5a0-80ea61ebcb25', '2026-10-18 21:13:47', '2026-10-18 21:13:47'),
('01a1525d-95d8-7359-abe8-567fc5614c23', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'a56fbc97-5851-4bcd-a3a8-c5fd2e479868', '2026-10-18 21:13:47', '2026-10-18 21:13:47'),
('01a1525d-95f4-7098-8f6c-aa1921aca904', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', '2026-10-18 21:13:47', '2026-10-18 21:13:47'),
('01a1525d-9619-72a8-91a1-b2a1dc9d2f53', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'a6de1d9c-a293-42ba-81ea-ea323546fce2', '2026-10-18 21:13:47', '2026-10-18 21:13:47'),
('01a1525d-963d-70da-9323-c8bee25851fe', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'a6ed472b-5760-4208-8475-7c4a6c6b590b', '2026-10-18 21:13:47', '2026-10-18 21:13:47'),
('01a1525d-9659-72e2-8c40-b2fb5235fed9', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'a80f9290-d3ed-4a53-bee4-d6b3b3132655', '2026-10-18 21:13:47', '2026-10-18 21:13:47'),
('01a1525d-9692-7154-b26a-4aea665145ef', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'a9eba201-b18d-49d5-90c9-91a1c380de89', '2026-10-18 21:13:47', '2026-10-18 21:13:47'),
('01a1525d-96ff-7236-b616-c8b75842ba16', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'ac3c3366-b999-4679-a55f-21f354a16ab8', '2026-10-18 21:13:47', '2026-10-18 21:13:47'),
('01a1525d-97be-7045-96e1-fd0b88c1a74d', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'ae5c7707-0f31-49ac-887f-42618104552c', '2026-10-18 21:13:47', '2026-10-18 21:13:47'),
('01a1525d-97e6-7373-b62c-32f993561373', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'b10f8046-1fd1-4ecd-9d11-9234795440b7', '2026-10-18 21:13:47', '2026-10-18 21:13:47'),
('01a1525d-9802-70cf-baeb-fd185d4df553', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'b22b30bd-f081-4d6d-bb12-1b9d39238239', '2026-10-18 21:13:47', '2026-10-18 21:13:47'),
('01a1525d-981c-7357-ab27-de9a35ba8a72', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'b2fa48ba-58ea-4c26-8d22-55a5cab54a07', '2026-10-18 21:13:47', '2026-10-18 21:13:47'),
('01a1525d-9833-70d9-a9f4-1478c27fe718', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'b7a89777-0db8-4098-b4fb-e324af14436e', '2026-10-18 21:13:47', '2026-10-18 21:13:47'),
('01a1525d-9850-7270-bcca-5a195ae10b50', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'b8297b98-cf13-4c0e-8059-d1963767183a', '2026-10-18 21:13:47', '2026-10-18 21:13:47'),
('01a1525d-986d-7220-903c-24326aacdb61', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'b83b2cf8-b4ec-4d2e-8694-04bf58bf4237', '2026-10-18 21:13:48', '2026-10-18 21:13:48'),
('01a1525d-988c-709e-9f06-abbd26d365bd', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'b8ef7dd7-9448-4a06-8fe6-dd78fa4f4a67', '2026-10-18 21:13:48', '2026-10-18 21:13:48'),
('01a1525d-98ab-7103-b8a1-db27314f6830', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'bb345ca5-48a7-41e1-b4f7-2892e876b53b', '2026-10-18 21:13:48', '2026-10-18 21:13:48'),
('01a1525d-98cd-7191-ac8a-7faddd3bbe22', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'bdf553f9-8062-4f27-9d98-d4703921c3d4', '2026-10-18 21:13:48', '2026-10-18 21:13:48'),
('01a1525d-990b-7133-ac9f-5b8835869e54', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'bf575919-9801-45cf-afc8-868cea1e7066', '2026-10-18 21:13:48', '2026-10-18 21:13:48'),
('01a1525d-9929-73e3-a69f-83f1552d5327', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'c0b0222e-d24f-45e0-a439-d81e3a5b5b6c', '2026-10-18 21:13:48', '2026-10-18 21:13:48'),
('01a1525d-994b-7203-8172-5e3cf1af4d96', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'c125b827-b451-4b41-bcee-ec53e35b1ce0', '2026-10-18 21:13:48', '2026-10-18 21:13:48'),
('01a1525d-996f-715f-b7d2-037e67ac290b', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'c1dbe39f-5b4d-4046-abb1-d84388b46723', '2026-10-18 21:13:48', '2026-10-18 21:13:48'),
('01a1525d-998d-7109-a77d-c0e255cf19b6', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'c3421138-08a8-4e81-a760-88484c7e689d', '2026-10-18 21:13:48', '2026-10-18 21:13:48'),
('01a1525d-99ae-703f-991c-dfd2ccec3369', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'c4ae0536-f42c-4785-854d-4f2180a936a5', '2026-10-18 21:13:48', '2026-10-18 21:13:48'),
('01a1525d-99d1-7382-91de-837adfcb68b3', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'c9f4ed84-c694-44e5-93f5-0c273481e6e3', '2026-10-18 21:13:48', '2026-10-18 21:13:48'),
('01a1525d-99f0-7017-950d-0563f1d3e8dd', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'ca927261-a07f-4069-b341-1da4715f8735', '2026-10-18 21:13:48', '2026-10-18 21:13:48'),
('01a1525d-9a0e-7060-93ab-70b11b45bd9e', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'd091792e-990d-4f5b-8795-32064cd10d23', '2026-10-18 21:13:48', '2026-10-18 21:13:48'),
('01a1525d-9a30-70cf-a0a6-35e3d91d7509', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'd0cf1368-347c-4b97-99b6-c0fc88f0392e', '2026-10-18 21:13:48', '2026-10-18 21:13:48'),
('01a1525d-9a51-7335-8db2-99ff05d79ea3', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'd6ee4095-bab6-4143-95a3-c61b3bd47667', '2026-10-18 21:13:48', '2026-10-18 21:13:48'),
('01a1525d-9a6d-725d-950c-af5044890c3d', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'd8bcabe8-a64d-4af9-87ee-94d7a2dad1f7', '2026-10-18 21:13:48', '2026-10-18 21:13:48'),
('01a1525d-9a89-7046-b48f-27a17e82ac5d', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'da9192c0-a4d4-4460-a8da-e749ff26aae7', '2026-10-18 21:13:48', '2026-10-18 21:13:48'),
('01a1525d-9ab5-7223-9c1c-5f4be767b88c', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'da96fdd8-4e1e-4892-92a9-79139f1ee124', '2026-10-18 21:13:48', '2026-10-18 21:13:48'),
('01a1525d-9ad8-704d-bc9d-6b4f673ba987', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'df8898d0-483f-41a2-8d75-e107da9959ed', '2026-10-18 21:13:48', '2026-10-18 21:13:48'),
('01a1525d-9b05-7386-8d4d-06f456ee3b63', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'dfca8b6c-5b37-410c-a4fb-a939792edd63', '2026-10-18 21:13:48', '2026-10-18 21:13:48'),
('01a1525d-9b3a-7142-b284-12893041007e', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'e3666622-08f3-4efc-9d49-8e63626ab11f', '2026-10-18 21:13:48', '2026-10-18 21:13:48'),
('01a1525d-9b6d-726a-9f99-637ab654aacf', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'e46aa620-6712-4ee1-bae3-47fd6a09e3dc', '2026-10-18 21:13:48', '2026-10-18 21:13:48'),
('01a1525d-9b9e-73ea-9d89-0bccfc7f835e', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'e51f3483-8b24-4b95-bcb7-56c47e85456d', '2026-10-18 21:13:48', '2026-10-18 21:13:48'),
('01a1525d-9bce-726e-8886-c32b0941d353', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'e64435ad-0fd3-4d4d-87dc-10ba7dc171a4', '2026-10-18 21:13:48', '2026-10-18 21:13:48'),
('01a1525d-9bfa-730f-8c99-ac8f391bc544', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'e6db6cf4-dec7-4ac2-81f6-f14660c0c1c2', '2026-10-18 21:13:48', '2026-10-18 21:13:48'),
('01a1525d-9c2e-718a-8a41-be3fbd1b5f64', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'ea8c6555-0f32-4df4-b036-5c92a59dc58a', '2026-10-18 21:13:48', '2026-10-18 21:13:48'),
('01a1525d-9c65-7159-819a-b9e68e2aaef1', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'ead97936-cbb9-41ec-a101-4534a94086c2', '2026-10-18 21:13:49', '2026-10-18 21:13:49'),
('01a1525d-9c93-702b-8d6d-4385193c7f76', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'eddb12cc-89d3-4a23-9dbe-2631b540191a', '2026-10-18 21:13:49', '2026-10-18 21:13:49'),
('01a1525d-9cb5-7102-bb7b-82b624e5c892', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'ef0ab049-3707-4b8e-a7ba-53d1f3ad3694', '2026-10-18 21:13:49', '2026-10-18 21:13:49'),
('01a1525d-9cd5-7234-8e72-2308dbce8ea2', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'efea6b42-9857-4194-aad9-3090e2971a40', '2026-10-18 21:13:49', '2026-10-18 21:13:49'),
('01a1525d-9cf1-7348-9b5a-f70802235e51', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'f2cbf766-2947-48e3-9805-43baa3995e18', '2026-10-18 21:13:49', '2026-10-18 21:13:49'),
('01a1525d-9d10-7390-befd-03a7b2f88602', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'f8e99bee-b99a-4e06-8485-816e9e7cc363', '2026-10-18 21:13:49', '2026-10-18 21:13:49'),
('01a1525d-9d31-7108-adac-7827294592d4', '01a1525d-6541-71d8-a795-c2ec45ab6289', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', '2026-10-18 21:13:49', '2026-10-18 21:13:49'),
('01a1525d-9d50-72a9-b9eb-aef36792a632', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '0159713a-ac72-4c17-a5b6-8352806762c1', '2026-10-18 21:13:49', '2026-10-18 21:13:49'),
('01a1525d-9d7a-730c-94f3-e8d5d1df00e5', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '07273ff4-96b4-4756-8f70-a34e66bb36d0', '2026-10-18 21:13:49', '2026-10-18 21:13:49'),
('01a1525d-9daf-72de-b16f-8d9e6fd37e96', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '07c0b1d5-c1b2-426f-afd3-1e5db0ef4f15', '2026-10-18 21:13:49', '2026-10-18 21:13:49'),
('01a1525d-9ddc-729d-897a-936665d22cdc', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '07c9a867-c2e3-41e5-ab42-929d97c947d2', '2026-10-18 21:13:49', '2026-10-18 21:13:49'),
('01a1525d-9e08-72e6-8d11-8a4c54e7de51', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '0843a6ab-d620-4879-9a9a-a3147d9ac471', '2026-10-18 21:13:49', '2026-10-18 21:13:49'),
('01a1525d-9e3c-7105-b7e6-ca55d714eb8e', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '0ec1d989-42d6-4b22-b5fc-d46f69f3ca47', '2026-10-18 21:13:49', '2026-10-18 21:13:49'),
('01a1525d-9e68-72e8-a148-73e08013a0d4', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '0f3cda5b-5055-459d-8d8d-5e5d68f77675', '2026-10-18 21:13:49', '2026-10-18 21:13:49'),
('01a1525d-9e8c-71c3-b6ed-1f732fe9e5d5', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '0f9579c0-6cc3-4458-aa0b-f9a15acd9578', '2026-10-18 21:13:49', '2026-10-18 21:13:49'),
('01a1525d-9eb0-70d3-9bb0-e6e8464200fa', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '10b6dc05-cc5d-44f4-9bb8-a7f5c9f6d3a3', '2026-10-18 21:13:49', '2026-10-18 21:13:49'),
('01a1525d-9ed1-7152-a64d-0e8184ae242f', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '14dc35fc-8cf0-47f2-b41f-55de875caf32', '2026-10-18 21:13:49', '2026-10-18 21:13:49'),
('01a1525d-9f0b-71e7-bb03-8c76756cda77', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '1dc22728-2840-44a6-98ef-28897c3e4274', '2026-10-18 21:13:49', '2026-10-18 21:13:49'),
('01a1525d-9f57-71e5-aee5-6ad22c96dae1', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '217611bd-73a7-48d8-be5e-9b67041b0093', '2026-10-18 21:13:49', '2026-10-18 21:13:49'),
('01a1525d-9fb9-707b-b26a-9b8d10a14ff7', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '21b0be96-38c9-43d3-adb8-6e12deb1a102', '2026-10-18 21:13:49', '2026-10-18 21:13:49'),
('01a1525d-9fdb-719f-97d5-1669a6936a06', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '2b03559e-ddf0-4e3c-9256-a86032fa2bda', '2026-10-18 21:13:49', '2026-10-18 21:13:49'),
('01a1525d-9ff0-711d-a10e-bc14b49ce5de', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '2de2c5c6-9053-4d1f-9f8f-773dc660512b', '2026-10-18 21:13:49', '2026-10-18 21:13:49'),
('01a1525d-a007-7303-989b-a5d70e076643', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '2dee313b-f6d5-4a67-a6c8-6543bcd9972e', '2026-10-18 21:13:49', '2026-10-18 21:13:49'),
('01a1525d-a029-7053-9c0a-56c4e39586ab', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '2ebe8ddb-e1c2-4da4-b0bb-15dba502c9dc', '2026-10-18 21:13:49', '2026-10-18 21:13:49'),
('01a1525d-a053-706d-bfa2-9c83b29f8b8e', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '3342e9fa-a2a8-4777-87d8-fb31912a74f3', '2026-10-18 21:13:50', '2026-10-18 21:13:50'),
('01a1525d-a09b-73b8-9d32-4f1902fcae76', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '376339c8-b760-479a-89e2-97995ed7b3ea', '2026-10-18 21:13:50', '2026-10-18 21:13:50'),
('01a1525d-a0eb-717a-8514-32a8f0064f87', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '386f9d14-1253-40df-b09b-afb1938d507a', '2026-10-18 21:13:50', '2026-10-18 21:13:50'),
('01a1525d-a10a-7211-bb98-3a3cac828a4c', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '38f0b478-7b9f-488e-8747-13d743638a7a', '2026-10-18 21:13:50', '2026-10-18 21:13:50'),
('01a1525d-a122-712a-ab6d-c82f6fd8dbdc', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '3a6d0b45-bcdf-4322-956a-36909c9b9c3d', '2026-10-18 21:13:50', '2026-10-18 21:13:50'),
('01a1525d-a141-733a-a344-1d0599ee238c', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '3aed7fc1-a08f-4eee-a040-29e34c846836', '2026-10-18 21:13:50', '2026-10-18 21:13:50'),
('01a1525d-a15f-73a3-9757-801972c1931a', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '3ba8e8bb-fe4e-4658-af3f-18923b3722f7', '2026-10-18 21:13:50', '2026-10-18 21:13:50'),
('01a1525d-a17c-731e-bdcb-ca72d6a3ce8b', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '3c146a69-c72e-4394-a165-cda538947fff', '2026-10-18 21:13:50', '2026-10-18 21:13:50'),
('01a1525d-a196-7258-b61e-448daf1c3bbd', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '3c63e3d3-31df-40ee-a780-b36f628c1b3e', '2026-10-18 21:13:50', '2026-10-18 21:13:50'),
('01a1525d-a1c8-7095-ab75-d5d44d2ae6cc', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '40c08639-0031-45f8-9774-003a59f0a06d', '2026-10-18 21:13:50', '2026-10-18 21:13:50'),
('01a1525d-a228-71ce-89a0-8b39dc4de386', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '4188429a-411b-47b5-be56-8cd2ad12a042', '2026-10-18 21:13:50', '2026-10-18 21:13:50'),
('01a1525d-a267-7080-82ce-5c31f80e8807', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '420ff500-8f4c-404c-abd6-9bad93eff4af', '2026-10-18 21:13:50', '2026-10-18 21:13:50'),
('01a1525d-a27e-7257-a288-1c88af5e59f8', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '45fbfc68-5387-4bfa-8b3e-2e0c0ee05245', '2026-10-18 21:13:50', '2026-10-18 21:13:50'),
('01a1525d-a298-7244-8dae-200721473ace', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '4d7681a6-f811-45b8-aae1-ab6269b27292', '2026-10-18 21:13:50', '2026-10-18 21:13:50'),
('01a1525d-a2b4-7162-992b-1e1192424197', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '535aaf43-9bd1-4da7-942c-c451d43f1da8', '2026-10-18 21:13:50', '2026-10-18 21:13:50'),
('01a1525d-a2d0-71df-be20-f6e3db4ff81e', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '545f5382-e38c-43bd-a9f0-0f44327b36d5', '2026-10-18 21:13:50', '2026-10-18 21:13:50'),
('01a1525d-a2ed-705a-b612-92f55131eac1', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '54a2c8f7-8bf2-4baf-a30e-52863c7b15db', '2026-10-18 21:13:50', '2026-10-18 21:13:50'),
('01a1525d-a314-72bf-bec3-38e553b93dd7', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '56937cd4-a01f-46d2-8c58-34eb640b1c8d', '2026-10-18 21:13:50', '2026-10-18 21:13:50'),
('01a1525d-a33a-7292-b81f-eebf47ecc452', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '56a3c4f6-d165-4f3d-81a3-7afb856e1520', '2026-10-18 21:13:50', '2026-10-18 21:13:50'),
('01a1525d-a35b-70cb-9056-f18b91272674', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '58913402-2f31-41b3-8f29-442f5a203139', '2026-10-18 21:13:50', '2026-10-18 21:13:50'),
('01a1525d-a374-706f-98cc-be8169d32404', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '5934d883-8403-4e1b-be51-bfd87a4950ab', '2026-10-18 21:13:50', '2026-10-18 21:13:50'),
('01a1525d-a3a5-7241-b683-60d5b3ae7d3b', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '5afd9a05-58cf-431c-a1f3-d7f3552db08f', '2026-10-18 21:13:50', '2026-10-18 21:13:50'),
('01a1525d-a3e0-73d1-879b-3a4df126d17b', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '5b1066bc-288a-421f-b554-523d64ce9295', '2026-10-18 21:13:50', '2026-10-18 21:13:50'),
('01a1525d-a428-7155-ba93-3415e2762d1b', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '5ebedf2c-d685-41fe-937d-bb9f3c3e6fa6', '2026-10-18 21:13:51', '2026-10-18 21:13:51'),
('01a1525d-a469-735f-8cc0-6df66948ab70', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '5f5c44e2-728d-4fd5-bb5d-431361a7891c', '2026-10-18 21:13:51', '2026-10-18 21:13:51'),
('01a1525d-a49d-729f-a926-9b90b2820dab', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '6806e476-237b-4db0-9732-d6487dd7de00', '2026-10-18 21:13:51', '2026-10-18 21:13:51'),
('01a1525d-a4de-73ca-b69a-cba44de3b7a1', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '68539801-9d15-4c54-bd79-294aad72912f', '2026-10-18 21:13:51', '2026-10-18 21:13:51'),
('01a1525d-a533-736b-9197-926fada169ce', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '69670f62-db4b-4cf3-9d59-ea1782710a9a', '2026-10-18 21:13:51', '2026-10-18 21:13:51'),
('01a1525d-a553-7064-9910-d4267089872a', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '6a0227fd-84f3-40bc-8693-6b1edbd836b1', '2026-10-18 21:13:51', '2026-10-18 21:13:51'),
('01a1525d-a574-7001-a9a7-fefe95d54bb9', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '6a6499da-2347-4b2a-9ecc-1a10623f0710', '2026-10-18 21:13:51', '2026-10-18 21:13:51'),
('01a1525d-a591-7384-bc68-fabf434a716c', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '6af539ad-1478-40bb-ad1d-7a101055dc9c', '2026-10-18 21:13:51', '2026-10-18 21:13:51'),
('01a1525d-a5b2-72f5-916f-badf4e1960f3', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '6b417011-8fde-4be3-a30b-5b25132f9cbe', '2026-10-18 21:13:51', '2026-10-18 21:13:51'),
('01a1525d-a5d4-70b9-883f-53cf95577844', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '71206ec3-fed1-45d1-92d3-6e8f7fbf6467', '2026-10-18 21:13:51', '2026-10-18 21:13:51'),
('01a1525d-a5ec-71ae-bd1d-d63a6e8cd525', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '7265dbca-563d-4f78-9251-f55930a8a93a', '2026-10-18 21:13:51', '2026-10-18 21:13:51'),
('01a1525d-a602-71a8-913b-a0ff3d353915', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '728194df-d7e3-4e86-a565-b52040d0fc81', '2026-10-18 21:13:51', '2026-10-18 21:13:51'),
('01a1525d-a622-7104-948a-6fafdf789957', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '746adf43-84d2-4ae9-a86a-de40ab511c8b', '2026-10-18 21:13:51', '2026-10-18 21:13:51'),
('01a1525d-a648-706d-917a-0c758a294b56', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '757cde74-832b-4164-97be-82b78afb6b9f', '2026-10-18 21:13:51', '2026-10-18 21:13:51'),
('01a1525d-a673-707c-8ad3-105583e4e0d5', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '773c6650-da28-43c5-9e58-e5cf96a7820e', '2026-10-18 21:13:51', '2026-10-18 21:13:51'),
('01a1525d-a699-719c-9a80-4d390bae20c4', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '82241006-263f-4be7-a5ab-856596307692', '2026-10-18 21:13:51', '2026-10-18 21:13:51'),
('01a1525d-a6b8-704c-bbb8-02a99c41acf0', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '8426372e-1021-455c-8ad7-7195b2425481', '2026-10-18 21:13:51', '2026-10-18 21:13:51'),
('01a1525d-a6da-72dd-9e59-df21e73f4cc8', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '8495fc04-2c0f-40ac-8187-bbb035488ca5', '2026-10-18 21:13:51', '2026-10-18 21:13:51'),
('01a1525d-a6f4-700b-9cad-bbd6abcd2762', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '88a67975-06bf-4dbe-b1ee-5caaa9212505', '2026-10-18 21:13:51', '2026-10-18 21:13:51'),
('01a1525d-a70f-70ed-839e-d467c640359f', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '8b442de5-2474-43cd-a2d2-e16c43ccf387', '2026-10-18 21:13:51', '2026-10-18 21:13:51'),
('01a1525d-a732-70fc-93b0-2baa346b3d2a', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '8b4c6709-0d76-4eff-b034-1261fc42a678', '2026-10-18 21:13:51', '2026-10-18 21:13:51'),
('01a1525d-a764-70ae-8384-638e5d84d903', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '8bc1f9ed-24aa-4e5b-8f6e-adc561d0b739', '2026-10-18 21:13:51', '2026-10-18 21:13:51'),
('01a1525d-a792-7395-a3e6-4d5a044b3d80', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '8ea7b710-f98a-4881-8fdb-db9dbaa31f87', '2026-10-18 21:13:51', '2026-10-18 21:13:51'),
('01a1525d-a7bf-71ac-946a-37d43d08e10b', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '902753ad-a0f2-4506-bb23-e77b2fab6f32', '2026-10-18 21:13:51', '2026-10-18 21:13:51'),
('01a1525d-a7eb-7069-adaa-3926a32b1269', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '91861619-4d6e-485d-afa3-a3ddd1038ffd', '2026-10-18 21:13:51', '2026-10-18 21:13:51'),
('01a1525d-a80f-72ca-b5cd-0b09ca125ed5', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '918b135d-a3ea-47ee-9b4b-d02793a483eb', '2026-10-18 21:13:52', '2026-10-18 21:13:52'),
('01a1525d-a836-71d0-b58c-74f179f8372f', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '9289e0c9-c5f1-48ba-9bf1-24134c0c0848', '2026-10-18 21:13:52', '2026-10-18 21:13:52'),
('01a1525d-a862-7304-b8f6-12f82ec70d83', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '9306d1b1-c8c5-4f57-9adb-a981d678de21', '2026-10-18 21:13:52', '2026-10-18 21:13:52'),
('01a1525d-a8a4-7005-8bd7-6c9553d6e829', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '93556b2c-37cd-4485-ad00-b5c68e1f33d2', '2026-10-18 21:13:52', '2026-10-18 21:13:52'),
('01a1525d-a8cc-72f6-a2cd-c40d108de06f', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '9379f29b-27a8-4f16-a434-80370a8a625d', '2026-10-18 21:13:52', '2026-10-18 21:13:52'),
('01a1525d-a8eb-70f0-ac33-230bd09b9a02', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '95bb9b8c-a02d-413b-a22d-69f79c8f69c1', '2026-10-18 21:13:52', '2026-10-18 21:13:52'),
('01a1525d-a909-721b-abaf-938a434c1c7d', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '966cf05c-3c1e-4058-8da6-121f84bf8c57', '2026-10-18 21:13:52', '2026-10-18 21:13:52'),
('01a1525d-a929-7175-b5a0-6e85281b214d', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '9763bfd2-f7a5-4959-85d1-681a7866b758', '2026-10-18 21:13:52', '2026-10-18 21:13:52'),
('01a1525d-a94c-71f6-a915-8750d0413963', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '9d09958c-0bcf-40ad-b0aa-7cbcff9e3396', '2026-10-18 21:13:52', '2026-10-18 21:13:52'),
('01a1525d-a966-7222-8f2f-3247ca407559', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '9d0aaabc-a02f-4aa9-bd14-293bc74ac24c', '2026-10-18 21:13:52', '2026-10-18 21:13:52'),
('01a1525d-a98d-7288-a477-ca9bc4693ab6', '01a1525d-6864-72ea-ad31-f231a54b1b9e', '9e9430cf-4733-4a62-aec5-be3b1aec108c', '2026-10-18 21:13:52', '2026-10-18 21:13:52'),
('01a1525d-a9c0-7091-95d6-ecb3e494b43d', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'a2548395-e459-4ae8-8b64-34e4bba29636', '2026-10-18 21:13:52', '2026-10-18 21:13:52'),
('01a1525d-a9ea-72cb-8052-631418e4b227', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'a332ec1f-1086-4baf-81b8-bd6368f76425', '2026-10-18 21:13:52', '2026-10-18 21:13:52'),
('01a1525d-aa0d-72fc-9338-15f4746d6e50', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'a3654a7f-7b1e-4982-92bd-51bc3b688329', '2026-10-18 21:13:52', '2026-10-18 21:13:52'),
('01a1525d-aa2d-70c8-ae7f-08eb6f00e5b8', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'a5195e2e-a156-49e5-b5a0-80ea61ebcb25', '2026-10-18 21:13:52', '2026-10-18 21:13:52'),
('01a1525d-aa49-7107-a569-698bd22039ae', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'a56fbc97-5851-4bcd-a3a8-c5fd2e479868', '2026-10-18 21:13:52', '2026-10-18 21:13:52'),
('01a1525d-aa62-721e-b032-14ef9e809112', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'a63a0d86-6c19-415e-a12c-16e8a8399fda', '2026-10-18 21:13:52', '2026-10-18 21:13:52'),
('01a1525d-aa7e-7315-907c-6c16ab6889dd', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'a6de1d9c-a293-42ba-81ea-ea323546fce2', '2026-10-18 21:13:52', '2026-10-18 21:13:52'),
('01a1525d-aaa6-71e0-8661-a21e640d16c2', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'a6ed472b-5760-4208-8475-7c4a6c6b590b', '2026-10-18 21:13:52', '2026-10-18 21:13:52'),
('01a1525d-aacd-70f0-b67c-59df5ea1c804', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'a80f9290-d3ed-4a53-bee4-d6b3b3132655', '2026-10-18 21:13:52', '2026-10-18 21:13:52'),
('01a1525d-aafa-72f5-aef0-48bfa262bc85', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'a9eba201-b18d-49d5-90c9-91a1c380de89', '2026-10-18 21:13:52', '2026-10-18 21:13:52'),
('01a1525d-ab1b-7003-9aff-96b142d0c35d', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'ac3c3366-b999-4679-a55f-21f354a16ab8', '2026-10-18 21:13:52', '2026-10-18 21:13:52'),
('01a1525d-ab35-735f-8d44-304189442b21', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'ae5c7707-0f31-49ac-887f-42618104552c', '2026-10-18 21:13:52', '2026-10-18 21:13:52'),
('01a1525d-ab4b-7166-bf0c-22f140367f3b', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'b10f8046-1fd1-4ecd-9d11-9234795440b7', '2026-10-18 21:13:52', '2026-10-18 21:13:52'),
('01a1525d-ab5f-72eb-9864-deffd110231c', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'b22b30bd-f081-4d6d-bb12-1b9d39238239', '2026-10-18 21:13:52', '2026-10-18 21:13:52'),
('01a1525d-ab76-70d7-ad45-76f1b498a2ca', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'b2fa48ba-58ea-4c26-8d22-55a5cab54a07', '2026-10-18 21:13:52', '2026-10-18 21:13:52'),
('01a1525d-ab98-73b8-8918-c3028b8201ca', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'b7a89777-0db8-4098-b4fb-e324af14436e', '2026-10-18 21:13:52', '2026-10-18 21:13:52'),
('01a1525d-abbe-70b8-a50e-6904cbd035e9', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'b8297b98-cf13-4c0e-8059-d1963767183a', '2026-10-18 21:13:52', '2026-10-18 21:13:52'),
('01a1525d-abdd-70d4-abb6-19dc8aea3b9a', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'b83b2cf8-b4ec-4d2e-8694-04bf58bf4237', '2026-10-18 21:13:52', '2026-10-18 21:13:52'),
('01a1525d-abfb-70b5-9d0a-733b79009bb4', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'b8ef7dd7-9448-4a06-8fe6-dd78fa4f4a67', '2026-10-18 21:13:53', '2026-10-18 21:13:53'),
('01a1525d-ac1f-728d-a0a0-89c5e20de898', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'bb345ca5-48a7-41e1-b4f7-2892e876b53b', '2026-10-18 21:13:53', '2026-10-18 21:13:53'),
('01a1525d-ac3d-7367-bd99-0822ba563652', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'bdf553f9-8062-4f27-9d98-d4703921c3d4', '2026-10-18 21:13:53', '2026-10-18 21:13:53'),
('01a1525d-ac57-705b-b02b-cefab0b1a75e', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'bf575919-9801-45cf-afc8-868cea1e7066', '2026-10-18 21:13:53', '2026-10-18 21:13:53'),
('01a1525d-ac87-71ce-9e08-d0a8c289724e', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'c0b0222e-d24f-45e0-a439-d81e3a5b5b6c', '2026-10-18 21:13:53', '2026-10-18 21:13:53'),
('01a1525d-acd7-73ef-8fc3-0f022e3e4f43', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'c125b827-b451-4b41-bcee-ec53e35b1ce0', '2026-10-18 21:13:53', '2026-10-18 21:13:53'),
('01a1525d-ad19-7148-9a4f-eb525cf02c28', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'c1dbe39f-5b4d-4046-abb1-d84388b46723', '2026-10-18 21:13:53', '2026-10-18 21:13:53'),
('01a1525d-ad4c-70c7-85c7-5f486788aa06', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'c3421138-08a8-4e81-a760-88484c7e689d', '2026-10-18 21:13:53', '2026-10-18 21:13:53'),
('01a1525d-ad80-73da-9c9d-13dcf187e3fd', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'c4ae0536-f42c-4785-854d-4f2180a936a5', '2026-10-18 21:13:53', '2026-10-18 21:13:53'),
('01a1525d-adba-7241-95b0-b34912fb09ab', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'c9f4ed84-c694-44e5-93f5-0c273481e6e3', '2026-10-18 21:13:53', '2026-10-18 21:13:53'),
('01a1525d-adf3-73f6-a16c-abcd5337143e', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'ca927261-a07f-4069-b341-1da4715f8735', '2026-10-18 21:13:53', '2026-10-18 21:13:53'),
('01a1525d-ae34-7219-a360-4db3223416f5', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'd091792e-990d-4f5b-8795-32064cd10d23', '2026-10-18 21:13:53', '2026-10-18 21:13:53'),
('01a1525d-ae6f-7364-bc2d-17200b735c92', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'd0cf1368-347c-4b97-99b6-c0fc88f0392e', '2026-10-18 21:13:53', '2026-10-18 21:13:53'),
('01a1525d-aeae-702d-9049-cc361f7bfbd5', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'd6ee4095-bab6-4143-95a3-c61b3bd47667', '2026-10-18 21:13:53', '2026-10-18 21:13:53'),
('01a1525d-aeed-7231-bc7a-1a6f6e7b142e', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'd8bcabe8-a64d-4af9-87ee-94d7a2dad1f7', '2026-10-18 21:13:53', '2026-10-18 21:13:53'),
('01a1525d-af33-701d-b892-047ea6aad226', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'da9192c0-a4d4-4460-a8da-e749ff26aae7', '2026-10-18 21:13:53', '2026-10-18 21:13:53'),
('01a1525d-af71-71d4-9844-6345946f26ce', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'da96fdd8-4e1e-4892-92a9-79139f1ee124', '2026-10-18 21:13:53', '2026-10-18 21:13:53'),
('01a1525d-afad-704a-8948-20061dfecb1e', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'df8898d0-483f-41a2-8d75-e107da9959ed', '2026-10-18 21:13:53', '2026-10-18 21:13:53'),
('01a1525d-aff0-70b5-80c8-4a4e62dea34f', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'dfca8b6c-5b37-410c-a4fb-a939792edd63', '2026-10-18 21:13:54', '2026-10-18 21:13:54'),
('01a1525d-b030-71d9-8ba7-b0c4529f6e2e', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'e3666622-08f3-4efc-9d49-8e63626ab11f', '2026-10-18 21:13:54', '2026-10-18 21:13:54'),
('01a1525d-b066-72bf-a2dd-e99f9d203794', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'e46aa620-6712-4ee1-bae3-47fd6a09e3dc', '2026-10-18 21:13:54', '2026-10-18 21:13:54'),
('01a1525d-b087-72ea-a434-80b4b49cd6f4', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'e51f3483-8b24-4b95-bcb7-56c47e85456d', '2026-10-18 21:13:54', '2026-10-18 21:13:54'),
('01a1525d-b0ad-73ae-ba11-3a4766088286', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'e64435ad-0fd3-4d4d-87dc-10ba7dc171a4', '2026-10-18 21:13:54', '2026-10-18 21:13:54'),
('01a1525d-b0d2-71b7-9d3e-128dba5d3db9', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'e6db6cf4-dec7-4ac2-81f6-f14660c0c1c2', '2026-10-18 21:13:54', '2026-10-18 21:13:54'),
('01a1525d-b102-7167-8ab8-78f00d3ee5f4', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'ea8c6555-0f32-4df4-b036-5c92a59dc58a', '2026-10-18 21:13:54', '2026-10-18 21:13:54'),
('01a1525d-b12b-72ac-a635-53718b4ca397', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'ead97936-cbb9-41ec-a101-4534a94086c2', '2026-10-18 21:13:54', '2026-10-18 21:13:54'),
('01a1525d-b14e-73a5-93ec-bef7ce4b103d', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'eddb12cc-89d3-4a23-9dbe-2631b540191a', '2026-10-18 21:13:54', '2026-10-18 21:13:54'),
('01a1525d-b16f-7392-bdba-c6bff4d7c398', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'ef0ab049-3707-4b8e-a7ba-53d1f3ad3694', '2026-10-18 21:13:54', '2026-10-18 21:13:54'),
('01a1525d-b192-70e0-93b9-15b1b87d828b', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'efea6b42-9857-4194-aad9-3090e2971a40', '2026-10-18 21:13:54', '2026-10-18 21:13:54'),
('01a1525d-b1ba-7303-b747-4f6437825454', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'f2cbf766-2947-48e3-9805-43baa3995e18', '2026-10-18 21:13:54', '2026-10-18 21:13:54'),
('01a1525d-b1d9-718e-bd4c-78189ff0893e', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'f8e99bee-b99a-4e06-8485-816e9e7cc363', '2026-10-18 21:13:54', '2026-10-18 21:13:54'),
('01a1525d-b1f4-7365-875a-9f70e4d1dffe', '01a1525d-6864-72ea-ad31-f231a54b1b9e', 'fde4c6ca-4c2c-4764-8027-19270a9e752d', '2026-10-18 21:13:54', '2026-10-18 21:13:54');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_account_balances`
--

CREATE TABLE `user_account_balances` (
  `id` char(36) NOT NULL,
  `user_account_id` char(36) NOT NULL,
  `coa_balance_id` char(36) NOT NULL,
  `period_id` char(36) NOT NULL,
  `sub_period_id` char(36) NOT NULL,
  `allocated_by` char(36) NOT NULL,
  `allocated_balance` decimal(15,2) NOT NULL DEFAULT 0.00,
  `income_balance` decimal(15,2) NOT NULL DEFAULT 0.00,
  `used_balance` decimal(15,2) NOT NULL DEFAULT 0.00,
  `remaining_balance` decimal(15,2) NOT NULL DEFAULT 0.00,
  `allocated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `user_account_balances`
--

INSERT INTO `user_account_balances` (`id`, `user_account_id`, `coa_balance_id`, `period_id`, `sub_period_id`, `allocated_by`, `allocated_balance`, `income_balance`, `used_balance`, `remaining_balance`, `allocated_at`, `deleted_at`, `created_at`, `updated_at`) VALUES
('01a152d2-b241-7034-936a-88d4da21bd88', '01a1525d-9d31-7108-adac-7827294592d4', '01a152c0-fb7a-71aa-bb4e-a273e09dc79a', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a1525d-6541-71d8-a795-c2ec45ab6289', 194604157.00, 425000000.00, 352439025.00, 267165132.00, '2026-10-18 23:21:42', NULL, '2026-10-18 23:21:42', '2026-10-20 08:47:02'),
('01a152d4-97a6-7063-9238-f45fe20fcae4', '01a1525d-8ac9-7000-be0a-8687936322f5', '01a152c2-19c6-7247-8a97-0d71edfdf3fa', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a1525d-6541-71d8-a795-c2ec45ab6289', 1156982563.00, 733644.00, 200176728.00, 957539479.00, '2026-10-18 23:23:46', NULL, '2026-10-18 23:23:46', '2026-10-20 06:41:59'),
('01a15a9c-6036-734b-9bb0-5b81acdf14cd', '01a1525d-aa62-721e-b032-14ef9e809112', '01a152c1-4406-73be-b7f0-d1de8925aee2', '01a1525d-6a17-70ce-862c-331933a6b4b0', '01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a1525d-6541-71d8-a795-c2ec45ab6289', 4983047.00, 200000.00, 1448000.00, 3735047.00, '2026-10-20 11:39:20', NULL, '2026-10-20 11:39:20', '2026-10-20 22:06:59');

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
-- Indeks untuk tabel `user_account_balances`
--
ALTER TABLE `user_account_balances`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_account_balance` (`user_account_id`,`coa_balance_id`,`sub_period_id`),
  ADD KEY `user_account_balances_coa_balance_id_foreign` (`coa_balance_id`),
  ADD KEY `user_account_balances_period_id_foreign` (`period_id`),
  ADD KEY `user_account_balances_sub_period_id_foreign` (`sub_period_id`),
  ADD KEY `user_account_balances_allocated_by_foreign` (`allocated_by`);

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

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

--
-- Ketidakleluasaan untuk tabel `user_account_balances`
--
ALTER TABLE `user_account_balances`
  ADD CONSTRAINT `user_account_balances_allocated_by_foreign` FOREIGN KEY (`allocated_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_account_balances_coa_balance_id_foreign` FOREIGN KEY (`coa_balance_id`) REFERENCES `coa_balances` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_account_balances_period_id_foreign` FOREIGN KEY (`period_id`) REFERENCES `periods` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_account_balances_sub_period_id_foreign` FOREIGN KEY (`sub_period_id`) REFERENCES `sub_periods` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_account_balances_user_account_id_foreign` FOREIGN KEY (`user_account_id`) REFERENCES `user_accounts` (`id`) ON DELETE CASCADE;
COMMIT;
