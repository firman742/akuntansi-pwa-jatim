-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 08 Jul 2026 pada 11.27
-- Versi server: 10.6.27-MariaDB-cll-lve-log
-- Versi PHP: 8.4.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Database: `enginee4_accounting`
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
('a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'ASET', 'Sumber daya ekonomi yang dimiliki perusahaan (kas, piutang, persediaan, tanah, gedung).', 1, '2026-07-07 03:40:02', '2026-07-07 03:40:02'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567891', 'KEWAJIBAN', 'Kewajiban atau hutang perusahaan kepada pihak lain (utang usaha, utang bank, obligasi).', 1, '2026-07-07 03:40:02', '2026-07-07 03:40:02'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567892', 'EKUITAS', 'Kepemilikan pemilik dalam perusahaan setelah dikurangi kewajiban (modal saham, laba ditahan).', 1, '2026-07-07 03:40:02', '2026-07-07 03:40:02'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567893', 'PENDAPATAN', 'account type representing the inflow of economic benefits from business activities.', 1, '2026-07-07 03:40:02', '2026-07-07 03:40:02'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567894', 'BEBAN', 'account type representing the outflow of economic benefits incurred in the process of generating revenue.', 1, '2026-07-07 03:40:02', '2026-07-07 03:40:02');

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
('019f3c35-09c4-708d-9aca-5d2187f641b6', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'PERIOD', 'Periode 2022 berhasil dibuat.', 'App\\Models\\Period', '019f3c35-09b8-737c-8683-733385ec91c9', '[]', '{\"name\":\"2022\",\"description\":\"Tahun 2022\",\"start_date\":\"2022-01-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"updated_at\":\"2026-07-07T10:52:16.000000Z\",\"created_at\":\"2026-07-07T10:52:16.000000Z\",\"is_active\":false}', '110.136.89.140', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"start_date\":\"2022-01-01\",\"end_date\":\"2022-12-31\"}', '2026-07-07 03:52:16', '2026-07-07 03:52:16'),
('019f3c35-ba93-72ae-ba8a-7ff999935e61', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'SUB_PERIOD', 'Sub periode Desember 2022 berhasil dibuat.', 'App\\Models\\SubPeriod', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', '[]', '{\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"updated_at\":\"2026-07-07T10:53:01.000000Z\",\"created_at\":\"2026-07-07T10:53:01.000000Z\"}', '110.136.89.140', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"start_date\":\"2022-12-01\",\"end_date\":\"2022-12-31\",\"is_active\":false}', '2026-07-07 03:53:01', '2026-07-07 03:53:01'),
('019f3c36-9926-72b8-ad1b-67f96b6540c7', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas (11100) pada sub periode Desember 2022 dengan jumlah 194,604,157.00', 'App\\Models\\OpeningBalance', '019f3c36-9917-713e-b2d1-f102488f1700', '[]', '{\"chart_of_account_id\":\"d9c57730-6928-4e5d-ac29-bf2f6dd9895f\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"balance_type\":\"DEBIT\",\"amount\":194604157,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3c36-9917-713e-b2d1-f102488f1700\",\"updated_at\":\"2026-07-07T10:53:58.000000Z\",\"created_at\":\"2026-07-07T10:53:58.000000Z\",\"chart_of_account\":{\"id\":\"d9c57730-6928-4e5d-ac29-bf2f6dd9895f\",\"code\":\"11100\",\"name\":\"Kas\",\"parent_id\":\"060c7786-2d80-4af6-a7f3-4d8dba51c049\",\"level\":\"2\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:02.000000Z\",\"updated_at\":\"2026-07-07T10:40:02.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T10:53:01.000000Z\",\"updated_at\":\"2026-07-07T10:53:01.000000Z\"}}', '110.136.89.140', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"d9c57730-6928-4e5d-ac29-bf2f6dd9895f\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"opening_balance\":194604157,\"debit_total\":0,\"credit_total\":0,\"current_balance\":194604157,\"last_transaction_at\":\"2026-07-07T10:53:58.000000Z\",\"id\":\"019f3c36-991d-7337-9ba8-4382cf490412\",\"updated_at\":\"2026-07-07T10:53:58.000000Z\",\"created_at\":\"2026-07-07T10:53:58.000000Z\"}}', '2026-07-07 03:53:58', '2026-07-07 03:53:58'),
('019f3c38-371a-70b4-a67a-89c6f18848bb', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas Ditangan (11110) pada sub periode Desember 2022 dengan jumlah 4,983,047.00', 'App\\Models\\OpeningBalance', '019f3c38-3706-70a7-acc6-1bca6955199c', '[]', '{\"chart_of_account_id\":\"7e3a051c-a73b-485c-865c-f7259792967d\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"balance_type\":\"DEBIT\",\"amount\":4983047,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3c38-3706-70a7-acc6-1bca6955199c\",\"updated_at\":\"2026-07-07T10:55:44.000000Z\",\"created_at\":\"2026-07-07T10:55:44.000000Z\",\"chart_of_account\":{\"id\":\"7e3a051c-a73b-485c-865c-f7259792967d\",\"code\":\"11110\",\"name\":\"Kas Ditangan\",\"parent_id\":\"d9c57730-6928-4e5d-ac29-bf2f6dd9895f\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:02.000000Z\",\"updated_at\":\"2026-07-07T10:40:02.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T10:53:01.000000Z\",\"updated_at\":\"2026-07-07T10:53:01.000000Z\"}}', '110.136.89.140', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"7e3a051c-a73b-485c-865c-f7259792967d\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"opening_balance\":4983047,\"debit_total\":0,\"credit_total\":0,\"current_balance\":4983047,\"last_transaction_at\":\"2026-07-07T10:55:44.000000Z\",\"id\":\"019f3c38-370f-727e-8e18-f10583035e1a\",\"updated_at\":\"2026-07-07T10:55:44.000000Z\",\"created_at\":\"2026-07-07T10:55:44.000000Z\"}}', '2026-07-07 03:55:44', '2026-07-07 03:55:44'),
('019f3c38-b228-7148-8f02-99cf90994552', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas di Bank Jatim (11120) pada sub periode Desember 2022 dengan jumlah 385,384,747.00', 'App\\Models\\OpeningBalance', '019f3c38-b21b-7163-abfc-595d64f0261e', '[]', '{\"chart_of_account_id\":\"fc646e17-8f59-466f-8bea-74a29c39bdad\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"balance_type\":\"DEBIT\",\"amount\":385384747,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3c38-b21b-7163-abfc-595d64f0261e\",\"updated_at\":\"2026-07-07T10:56:16.000000Z\",\"created_at\":\"2026-07-07T10:56:16.000000Z\",\"chart_of_account\":{\"id\":\"fc646e17-8f59-466f-8bea-74a29c39bdad\",\"code\":\"11120\",\"name\":\"Kas di Bank Jatim\",\"parent_id\":\"d9c57730-6928-4e5d-ac29-bf2f6dd9895f\",\"level\":\"3\",\"order\":\"2\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:02.000000Z\",\"updated_at\":\"2026-07-07T10:40:02.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T10:53:01.000000Z\",\"updated_at\":\"2026-07-07T10:53:01.000000Z\"}}', '110.136.89.140', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"fc646e17-8f59-466f-8bea-74a29c39bdad\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"opening_balance\":385384747,\"debit_total\":0,\"credit_total\":0,\"current_balance\":385384747,\"last_transaction_at\":\"2026-07-07T10:56:16.000000Z\",\"id\":\"019f3c38-b220-73a9-a6e0-bf4d57bd92e3\",\"updated_at\":\"2026-07-07T10:56:16.000000Z\",\"created_at\":\"2026-07-07T10:56:16.000000Z\"}}', '2026-07-07 03:56:16', '2026-07-07 03:56:16'),
('019f3c39-5fff-70fb-b029-9a67f383759b', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas di Bank Jatim Dr. Soetomo (11130) pada sub periode Desember 2022 dengan jumlah 1,156,982,563.00', 'App\\Models\\OpeningBalance', '019f3c39-5fec-7243-90b4-2a34fd440fe5', '[]', '{\"chart_of_account_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"balance_type\":\"DEBIT\",\"amount\":1156982563,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3c39-5fec-7243-90b4-2a34fd440fe5\",\"updated_at\":\"2026-07-07T10:57:00.000000Z\",\"created_at\":\"2026-07-07T10:57:00.000000Z\",\"chart_of_account\":{\"id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"code\":\"11130\",\"name\":\"Kas di Bank Jatim Dr. Soetomo\",\"parent_id\":\"d9c57730-6928-4e5d-ac29-bf2f6dd9895f\",\"level\":\"3\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:02.000000Z\",\"updated_at\":\"2026-07-07T10:40:02.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T10:53:01.000000Z\",\"updated_at\":\"2026-07-07T10:53:01.000000Z\"}}', '110.136.89.140', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"opening_balance\":1156982563,\"debit_total\":0,\"credit_total\":0,\"current_balance\":1156982563,\"last_transaction_at\":\"2026-07-07T10:57:00.000000Z\",\"id\":\"019f3c39-5ff3-72a1-a97e-4e0e40f66193\",\"updated_at\":\"2026-07-07T10:57:00.000000Z\",\"created_at\":\"2026-07-07T10:57:00.000000Z\"}}', '2026-07-07 03:57:00', '2026-07-07 03:57:00'),
('019f3c39-b840-738c-b8d4-c576242c0d46', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas di Bank Bukopin Syariah (11140) pada sub periode Desember 2022 dengan jumlah 377,940,865.00', 'App\\Models\\OpeningBalance', '019f3c39-b833-73c2-b107-b4fb67a74610', '[]', '{\"chart_of_account_id\":\"ff336d58-31ed-49b6-8df8-6ea403800108\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"balance_type\":\"DEBIT\",\"amount\":377940865,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3c39-b833-73c2-b107-b4fb67a74610\",\"updated_at\":\"2026-07-07T10:57:23.000000Z\",\"created_at\":\"2026-07-07T10:57:23.000000Z\",\"chart_of_account\":{\"id\":\"ff336d58-31ed-49b6-8df8-6ea403800108\",\"code\":\"11140\",\"name\":\"Kas di Bank Bukopin Syariah\",\"parent_id\":\"d9c57730-6928-4e5d-ac29-bf2f6dd9895f\",\"level\":\"3\",\"order\":\"4\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:02.000000Z\",\"updated_at\":\"2026-07-07T10:40:02.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T10:53:01.000000Z\",\"updated_at\":\"2026-07-07T10:53:01.000000Z\"}}', '110.136.89.140', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"ff336d58-31ed-49b6-8df8-6ea403800108\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"opening_balance\":377940865,\"debit_total\":0,\"credit_total\":0,\"current_balance\":377940865,\"last_transaction_at\":\"2026-07-07T10:57:23.000000Z\",\"id\":\"019f3c39-b839-7063-8b30-05179204b11e\",\"updated_at\":\"2026-07-07T10:57:23.000000Z\",\"created_at\":\"2026-07-07T10:57:23.000000Z\"}}', '2026-07-07 03:57:23', '2026-07-07 03:57:23'),
('019f3c3a-1913-72ca-ab22-f4462e512e41', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Piutang Karyawan (11300) pada sub periode Desember 2022 dengan jumlah 1,800,000.00', 'App\\Models\\OpeningBalance', '019f3c3a-1905-71e9-b640-92c88e6b6652', '[]', '{\"chart_of_account_id\":\"700e4c22-26f3-43ce-8ef0-b32b8920e93c\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"balance_type\":\"DEBIT\",\"amount\":1800000,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3c3a-1905-71e9-b640-92c88e6b6652\",\"updated_at\":\"2026-07-07T10:57:48.000000Z\",\"created_at\":\"2026-07-07T10:57:48.000000Z\",\"chart_of_account\":{\"id\":\"700e4c22-26f3-43ce-8ef0-b32b8920e93c\",\"code\":\"11300\",\"name\":\"Piutang Karyawan\",\"parent_id\":\"060c7786-2d80-4af6-a7f3-4d8dba51c049\",\"level\":\"2\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:02.000000Z\",\"updated_at\":\"2026-07-07T10:40:02.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T10:53:01.000000Z\",\"updated_at\":\"2026-07-07T10:53:01.000000Z\"}}', '110.136.89.140', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"700e4c22-26f3-43ce-8ef0-b32b8920e93c\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"opening_balance\":1800000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":1800000,\"last_transaction_at\":\"2026-07-07T10:57:48.000000Z\",\"id\":\"019f3c3a-190a-73d4-ae0b-131ddb79d0cf\",\"updated_at\":\"2026-07-07T10:57:48.000000Z\",\"created_at\":\"2026-07-07T10:57:48.000000Z\"}}', '2026-07-07 03:57:48', '2026-07-07 03:57:48'),
('019f3c3a-7627-7198-a93e-326923f3aa71', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Penyertaan Modal Bueka Assakinah (11500) pada sub periode Desember 2022 dengan jumlah 245,583,300.00', 'App\\Models\\OpeningBalance', '019f3c3a-761b-717d-9989-402153655555', '[]', '{\"chart_of_account_id\":\"6865e20e-43b2-48ce-b3a3-653078468886\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"balance_type\":\"DEBIT\",\"amount\":245583300,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3c3a-761b-717d-9989-402153655555\",\"updated_at\":\"2026-07-07T10:58:12.000000Z\",\"created_at\":\"2026-07-07T10:58:12.000000Z\",\"chart_of_account\":{\"id\":\"6865e20e-43b2-48ce-b3a3-653078468886\",\"code\":\"11500\",\"name\":\"Penyertaan Modal Bueka Assakinah\",\"parent_id\":\"060c7786-2d80-4af6-a7f3-4d8dba51c049\",\"level\":\"2\",\"order\":\"5\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:02.000000Z\",\"updated_at\":\"2026-07-07T10:40:02.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T10:53:01.000000Z\",\"updated_at\":\"2026-07-07T10:53:01.000000Z\"}}', '110.136.89.140', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"6865e20e-43b2-48ce-b3a3-653078468886\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"opening_balance\":245583300,\"debit_total\":0,\"credit_total\":0,\"current_balance\":245583300,\"last_transaction_at\":\"2026-07-07T10:58:12.000000Z\",\"id\":\"019f3c3a-7620-736a-9fb3-cd239b8385e0\",\"updated_at\":\"2026-07-07T10:58:12.000000Z\",\"created_at\":\"2026-07-07T10:58:12.000000Z\"}}', '2026-07-07 03:58:12', '2026-07-07 03:58:12'),
('019f3c3a-d990-7017-b346-6e6e53097d20', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Tabungan Bueka Assakinah (11600) pada sub periode Desember 2022 dengan jumlah 676,151,976.00', 'App\\Models\\OpeningBalance', '019f3c3a-d97d-72a0-9fa4-b7bd13f25342', '[]', '{\"chart_of_account_id\":\"27ef2784-5982-421c-bb3f-96a51777fbf3\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"balance_type\":\"DEBIT\",\"amount\":676151976,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3c3a-d97d-72a0-9fa4-b7bd13f25342\",\"updated_at\":\"2026-07-07T10:58:37.000000Z\",\"created_at\":\"2026-07-07T10:58:37.000000Z\",\"chart_of_account\":{\"id\":\"27ef2784-5982-421c-bb3f-96a51777fbf3\",\"code\":\"11600\",\"name\":\"Tabungan Bueka Assakinah\",\"parent_id\":\"060c7786-2d80-4af6-a7f3-4d8dba51c049\",\"level\":\"2\",\"order\":\"6\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:02.000000Z\",\"updated_at\":\"2026-07-07T10:40:02.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T10:53:01.000000Z\",\"updated_at\":\"2026-07-07T10:53:01.000000Z\"}}', '110.136.89.140', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"27ef2784-5982-421c-bb3f-96a51777fbf3\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"opening_balance\":676151976,\"debit_total\":0,\"credit_total\":0,\"current_balance\":676151976,\"last_transaction_at\":\"2026-07-07T10:58:37.000000Z\",\"id\":\"019f3c3a-d984-707a-8b8f-93c10423cecd\",\"updated_at\":\"2026-07-07T10:58:37.000000Z\",\"created_at\":\"2026-07-07T10:58:37.000000Z\"}}', '2026-07-07 03:58:37', '2026-07-07 03:58:37'),
('019f3c3e-34c4-73e4-8d03-11136f7a397e', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kendaraan (12300) pada sub periode Desember 2022 dengan jumlah 460,769,432.00', 'App\\Models\\OpeningBalance', '019f3c3e-34b1-73ed-931d-46340e0f427e', '[]', '{\"chart_of_account_id\":\"41fbc782-5794-409d-8507-f99fed76fe8b\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"balance_type\":\"DEBIT\",\"amount\":460769432,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3c3e-34b1-73ed-931d-46340e0f427e\",\"updated_at\":\"2026-07-07T11:02:17.000000Z\",\"created_at\":\"2026-07-07T11:02:17.000000Z\",\"chart_of_account\":{\"id\":\"41fbc782-5794-409d-8507-f99fed76fe8b\",\"code\":\"12300\",\"name\":\"Kendaraan\",\"parent_id\":\"cda7e544-e669-4f9c-9b6f-f6ba07500cef\",\"level\":\"2\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:03.000000Z\",\"updated_at\":\"2026-07-07T10:40:03.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T10:53:01.000000Z\",\"updated_at\":\"2026-07-07T10:53:01.000000Z\"}}', '110.136.89.140', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"41fbc782-5794-409d-8507-f99fed76fe8b\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"opening_balance\":460769432,\"debit_total\":0,\"credit_total\":0,\"current_balance\":460769432,\"last_transaction_at\":\"2026-07-07T11:02:17.000000Z\",\"id\":\"019f3c3e-34b9-71fc-a687-f015c6cccf8a\",\"updated_at\":\"2026-07-07T11:02:17.000000Z\",\"created_at\":\"2026-07-07T11:02:17.000000Z\"}}', '2026-07-07 04:02:17', '2026-07-07 04:02:17'),
('019f3c40-cdd8-72e0-b8a1-6bfc92e8c8e3', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Meubel (12400) pada sub periode Desember 2022 dengan jumlah 15,500,000.00', 'App\\Models\\OpeningBalance', '019f3c40-cdc7-7103-a103-6df909c8e1d9', '[]', '{\"chart_of_account_id\":\"225f7e5c-8132-4aff-bccd-9c1e07ebc65f\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"balance_type\":\"DEBIT\",\"amount\":15500000,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3c40-cdc7-7103-a103-6df909c8e1d9\",\"updated_at\":\"2026-07-07T11:05:07.000000Z\",\"created_at\":\"2026-07-07T11:05:07.000000Z\",\"chart_of_account\":{\"id\":\"225f7e5c-8132-4aff-bccd-9c1e07ebc65f\",\"code\":\"12400\",\"name\":\"Meubel\",\"parent_id\":\"cda7e544-e669-4f9c-9b6f-f6ba07500cef\",\"level\":\"2\",\"order\":\"4\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:03.000000Z\",\"updated_at\":\"2026-07-07T10:40:03.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T10:53:01.000000Z\",\"updated_at\":\"2026-07-07T10:53:01.000000Z\"}}', '110.136.89.140', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"225f7e5c-8132-4aff-bccd-9c1e07ebc65f\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"opening_balance\":15500000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":15500000,\"last_transaction_at\":\"2026-07-07T11:05:07.000000Z\",\"id\":\"019f3c40-cdcd-7297-bc07-fdc2961f1316\",\"updated_at\":\"2026-07-07T11:05:07.000000Z\",\"created_at\":\"2026-07-07T11:05:07.000000Z\"}}', '2026-07-07 04:05:07', '2026-07-07 04:05:07'),
('019f3c41-4ce1-730a-ad9a-21bf2d70c7fb', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Peralatan Kantor (12500) pada sub periode Desember 2022 dengan jumlah 46,059,000.00', 'App\\Models\\OpeningBalance', '019f3c41-4cd0-72f6-acef-b16cc707c4eb', '[]', '{\"chart_of_account_id\":\"44fb2678-eb3c-4af8-88ea-e9654dcc88ac\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"balance_type\":\"DEBIT\",\"amount\":46059000,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3c41-4cd0-72f6-acef-b16cc707c4eb\",\"updated_at\":\"2026-07-07T11:05:40.000000Z\",\"created_at\":\"2026-07-07T11:05:40.000000Z\",\"chart_of_account\":{\"id\":\"44fb2678-eb3c-4af8-88ea-e9654dcc88ac\",\"code\":\"12500\",\"name\":\"Peralatan Kantor\",\"parent_id\":\"cda7e544-e669-4f9c-9b6f-f6ba07500cef\",\"level\":\"2\",\"order\":\"5\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:03.000000Z\",\"updated_at\":\"2026-07-07T10:40:03.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T10:53:01.000000Z\",\"updated_at\":\"2026-07-07T10:53:01.000000Z\"}}', '110.136.89.140', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"44fb2678-eb3c-4af8-88ea-e9654dcc88ac\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"opening_balance\":46059000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":46059000,\"last_transaction_at\":\"2026-07-07T11:05:40.000000Z\",\"id\":\"019f3c41-4cd8-7355-a444-ef7b20030674\",\"updated_at\":\"2026-07-07T11:05:40.000000Z\",\"created_at\":\"2026-07-07T11:05:40.000000Z\"}}', '2026-07-07 04:05:40', '2026-07-07 04:05:40'),
('019f3c76-db76-72f4-8a3d-498d2f8c2310', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Akumulasi Depresiasi Kendaraan (12310) pada sub periode Desember 2022 dengan jumlah 144,000,000.00', 'App\\Models\\OpeningBalance', '019f3c76-db68-7277-b74a-d1d19a844b80', '[]', '{\"chart_of_account_id\":\"92aa553e-6ee4-48e9-a7f7-02acaba8ecd0\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"balance_type\":\"CREDIT\",\"amount\":144000000,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3c76-db68-7277-b74a-d1d19a844b80\",\"updated_at\":\"2026-07-07T12:04:10.000000Z\",\"created_at\":\"2026-07-07T12:04:10.000000Z\",\"chart_of_account\":{\"id\":\"92aa553e-6ee4-48e9-a7f7-02acaba8ecd0\",\"code\":\"12310\",\"name\":\"Akumulasi Depresiasi Kendaraan\",\"parent_id\":\"41fbc782-5794-409d-8507-f99fed76fe8b\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:03.000000Z\",\"updated_at\":\"2026-07-07T10:40:03.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T10:53:01.000000Z\",\"updated_at\":\"2026-07-07T10:53:01.000000Z\"}}', '110.136.89.140', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"92aa553e-6ee4-48e9-a7f7-02acaba8ecd0\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"opening_balance\":144000000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":144000000,\"last_transaction_at\":\"2026-07-07T12:04:10.000000Z\",\"id\":\"019f3c76-db6f-709c-9633-96120a81707a\",\"updated_at\":\"2026-07-07T12:04:10.000000Z\",\"created_at\":\"2026-07-07T12:04:10.000000Z\"}}', '2026-07-07 05:04:10', '2026-07-07 05:04:10'),
('019f3c77-77f8-73c2-b132-298a6048dd2e', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Akumulasi Depresiasi Meubel (12410) pada sub periode Desember 2022 dengan jumlah 13,376,668.00', 'App\\Models\\OpeningBalance', '019f3c77-77d7-73cb-b2f3-ac0195e13a7f', '[]', '{\"chart_of_account_id\":\"7fecbf43-5f25-49e8-8068-a4aed1808cd4\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"balance_type\":\"CREDIT\",\"amount\":13376668,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3c77-77d7-73cb-b2f3-ac0195e13a7f\",\"updated_at\":\"2026-07-07T12:04:50.000000Z\",\"created_at\":\"2026-07-07T12:04:50.000000Z\",\"chart_of_account\":{\"id\":\"7fecbf43-5f25-49e8-8068-a4aed1808cd4\",\"code\":\"12410\",\"name\":\"Akumulasi Depresiasi Meubel\",\"parent_id\":\"225f7e5c-8132-4aff-bccd-9c1e07ebc65f\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:03.000000Z\",\"updated_at\":\"2026-07-07T10:40:03.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T10:53:01.000000Z\",\"updated_at\":\"2026-07-07T10:53:01.000000Z\"}}', '110.136.89.140', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"7fecbf43-5f25-49e8-8068-a4aed1808cd4\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"opening_balance\":13376668,\"debit_total\":0,\"credit_total\":0,\"current_balance\":13376668,\"last_transaction_at\":\"2026-07-07T12:04:50.000000Z\",\"id\":\"019f3c77-77df-7379-8556-1adadfb30e1c\",\"updated_at\":\"2026-07-07T12:04:50.000000Z\",\"created_at\":\"2026-07-07T12:04:50.000000Z\"}}', '2026-07-07 05:04:50', '2026-07-07 05:04:50'),
('019f3c77-e8e1-7046-a352-ee4d0bea7c8d', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Akumulasi Depresiasi Peralatan Kantor (12510) pada sub periode Desember 2022 dengan jumlah 25,236,667.00', 'App\\Models\\OpeningBalance', '019f3c77-e8d2-72e0-9725-314235b613e2', '[]', '{\"chart_of_account_id\":\"bed710fe-7648-4fe7-9b9b-b1f2f960cee7\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"balance_type\":\"CREDIT\",\"amount\":25236667,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3c77-e8d2-72e0-9725-314235b613e2\",\"updated_at\":\"2026-07-07T12:05:19.000000Z\",\"created_at\":\"2026-07-07T12:05:19.000000Z\",\"chart_of_account\":{\"id\":\"bed710fe-7648-4fe7-9b9b-b1f2f960cee7\",\"code\":\"12510\",\"name\":\"Akumulasi Depresiasi Peralatan Kantor\",\"parent_id\":\"44fb2678-eb3c-4af8-88ea-e9654dcc88ac\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:03.000000Z\",\"updated_at\":\"2026-07-07T10:40:03.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T10:53:01.000000Z\",\"updated_at\":\"2026-07-07T10:53:01.000000Z\"}}', '110.136.89.140', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"bed710fe-7648-4fe7-9b9b-b1f2f960cee7\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"opening_balance\":25236667,\"debit_total\":0,\"credit_total\":0,\"current_balance\":25236667,\"last_transaction_at\":\"2026-07-07T12:05:19.000000Z\",\"id\":\"019f3c77-e8d8-7345-889f-ceafdddee745\",\"updated_at\":\"2026-07-07T12:05:19.000000Z\",\"created_at\":\"2026-07-07T12:05:19.000000Z\"}}', '2026-07-07 05:05:19', '2026-07-07 05:05:19'),
('019f3c78-c4ee-722f-bec9-4ed143dd8492', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Modal Tetap (31100) pada sub periode Desember 2022 dengan jumlah 339,715,097.00', 'App\\Models\\OpeningBalance', '019f3c78-c4e1-7035-be34-b618c678afe4', '[]', '{\"chart_of_account_id\":\"3fab3482-9af2-4d47-92f0-b6a42980348c\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"balance_type\":\"DEBIT\",\"amount\":339715097,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3c78-c4e1-7035-be34-b618c678afe4\",\"updated_at\":\"2026-07-07T12:06:15.000000Z\",\"created_at\":\"2026-07-07T12:06:15.000000Z\",\"chart_of_account\":{\"id\":\"3fab3482-9af2-4d47-92f0-b6a42980348c\",\"code\":\"31100\",\"name\":\"Modal Tetap\",\"parent_id\":\"99796640-5f95-4ad6-bf89-7121444ade40\",\"level\":\"2\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567892\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:03.000000Z\",\"updated_at\":\"2026-07-07T10:40:03.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T10:53:01.000000Z\",\"updated_at\":\"2026-07-07T10:53:01.000000Z\"}}', '110.136.89.140', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"3fab3482-9af2-4d47-92f0-b6a42980348c\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"opening_balance\":339715097,\"debit_total\":0,\"credit_total\":0,\"current_balance\":339715097,\"last_transaction_at\":\"2026-07-07T12:06:15.000000Z\",\"id\":\"019f3c78-c4e7-72f4-9ee3-a09eeaf376db\",\"updated_at\":\"2026-07-07T12:06:15.000000Z\",\"created_at\":\"2026-07-07T12:06:15.000000Z\"}}', '2026-07-07 05:06:15', '2026-07-07 05:06:15'),
('019f3c79-6c66-72e9-b8b4-25724f581b56', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Modal Lancar (31200) pada sub periode Desember 2022 dengan jumlah 368,679,944.00', 'App\\Models\\OpeningBalance', '019f3c79-6c59-72a2-b480-ed9c3045acfa', '[]', '{\"chart_of_account_id\":\"db8f505b-44a6-45f5-8d10-f8d15bea1af4\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"balance_type\":\"DEBIT\",\"amount\":368679944,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3c79-6c59-72a2-b480-ed9c3045acfa\",\"updated_at\":\"2026-07-07T12:06:58.000000Z\",\"created_at\":\"2026-07-07T12:06:58.000000Z\",\"chart_of_account\":{\"id\":\"db8f505b-44a6-45f5-8d10-f8d15bea1af4\",\"code\":\"31200\",\"name\":\"Modal Lancar\",\"parent_id\":\"99796640-5f95-4ad6-bf89-7121444ade40\",\"level\":\"2\",\"order\":\"2\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567892\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:03.000000Z\",\"updated_at\":\"2026-07-07T10:40:03.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T10:53:01.000000Z\",\"updated_at\":\"2026-07-07T10:53:01.000000Z\"}}', '110.136.89.140', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"db8f505b-44a6-45f5-8d10-f8d15bea1af4\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"opening_balance\":368679944,\"debit_total\":0,\"credit_total\":0,\"current_balance\":368679944,\"last_transaction_at\":\"2026-07-07T12:06:58.000000Z\",\"id\":\"019f3c79-6c5f-7158-a589-85be7fc1da36\",\"updated_at\":\"2026-07-07T12:06:58.000000Z\",\"created_at\":\"2026-07-07T12:06:58.000000Z\"}}', '2026-07-07 05:06:58', '2026-07-07 05:06:58'),
('019f3c79-dc47-7112-aa62-f75b8eab53ef', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Selisih Lebih/Kurang (31300) pada sub periode Desember 2022 dengan jumlah 2,674,750,712.00', 'App\\Models\\OpeningBalance', '019f3c79-dc31-726d-a9e1-943a83ef4b1c', '[]', '{\"chart_of_account_id\":\"34946f7c-6f05-4bb7-ba94-01afba90ff43\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"balance_type\":\"CREDIT\",\"amount\":2674750712,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3c79-dc31-726d-a9e1-943a83ef4b1c\",\"updated_at\":\"2026-07-07T12:07:27.000000Z\",\"created_at\":\"2026-07-07T12:07:27.000000Z\",\"chart_of_account\":{\"id\":\"34946f7c-6f05-4bb7-ba94-01afba90ff43\",\"code\":\"31300\",\"name\":\"Selisih Lebih\\/Kurang\",\"parent_id\":\"99796640-5f95-4ad6-bf89-7121444ade40\",\"level\":\"2\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567892\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:03.000000Z\",\"updated_at\":\"2026-07-07T10:40:03.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T10:53:01.000000Z\",\"updated_at\":\"2026-07-07T10:53:01.000000Z\"}}', '110.136.89.140', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"34946f7c-6f05-4bb7-ba94-01afba90ff43\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"opening_balance\":2674750712,\"debit_total\":0,\"credit_total\":0,\"current_balance\":2674750712,\"last_transaction_at\":\"2026-07-07T12:07:27.000000Z\",\"id\":\"019f3c79-dc39-7019-a98f-41d614a7f2fd\",\"updated_at\":\"2026-07-07T12:07:27.000000Z\",\"created_at\":\"2026-07-07T12:07:27.000000Z\"}}', '2026-07-07 05:07:27', '2026-07-07 05:07:27'),
('019f3c7c-2036-72df-9bf3-c56f38659f8f', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Selisih Lebih/Kurang (31300) pada sub periode Desember 2022 dengan jumlah 2,674,750,712.00', 'App\\Models\\OpeningBalance', '019f3c7c-202a-71f9-b517-634cea2a64f1', '[]', '{\"chart_of_account_id\":\"34946f7c-6f05-4bb7-ba94-01afba90ff43\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"balance_type\":\"DEBIT\",\"amount\":2674750712,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3c7c-202a-71f9-b517-634cea2a64f1\",\"updated_at\":\"2026-07-07T12:09:55.000000Z\",\"created_at\":\"2026-07-07T12:09:55.000000Z\",\"chart_of_account\":{\"id\":\"34946f7c-6f05-4bb7-ba94-01afba90ff43\",\"code\":\"31300\",\"name\":\"Selisih Lebih\\/Kurang\",\"parent_id\":\"99796640-5f95-4ad6-bf89-7121444ade40\",\"level\":\"2\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567892\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:03.000000Z\",\"updated_at\":\"2026-07-07T10:40:03.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T10:53:01.000000Z\",\"updated_at\":\"2026-07-07T10:53:01.000000Z\"}}', '110.136.89.140', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"34946f7c-6f05-4bb7-ba94-01afba90ff43\",\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"sub_period_id\":\"019f3c35-ba89-732a-bff8-3a8e7f80e1a2\",\"opening_balance\":2674750712,\"debit_total\":0,\"credit_total\":0,\"current_balance\":2674750712,\"last_transaction_at\":\"2026-07-07T12:09:55.000000Z\",\"id\":\"019f3c7c-2030-70fd-bbed-af36d952fc25\",\"updated_at\":\"2026-07-07T12:09:55.000000Z\",\"created_at\":\"2026-07-07T12:09:55.000000Z\"}}', '2026-07-07 05:09:55', '2026-07-07 05:09:55'),
('019f3c7d-fda3-712e-859f-675ca275b531', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'closed', 'SUB_PERIOD', 'Sub periode Desember 2022 berhasil ditutup.', 'App\\Models\\SubPeriod', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', '{\"is_closed\":false}', '{\"is_closed\":true}', '110.136.89.140', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"period_id\":\"019f3c35-09b8-737c-8683-733385ec91c9\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_active\":null}', '2026-07-07 05:11:57', '2026-07-07 05:11:57'),
('019f3c7f-83b0-730a-80c5-d0f4c77c7023', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'PERIOD', 'Periode 2023 berhasil dibuat.', 'App\\Models\\Period', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '[]', '{\"name\":\"2023\",\"description\":\"Tahun 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-12-31T00:00:00.000000Z\",\"id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"updated_at\":\"2026-07-07T12:13:37.000000Z\",\"created_at\":\"2026-07-07T12:13:37.000000Z\",\"is_active\":false}', '110.136.89.140', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"start_date\":\"2023-01-01\",\"end_date\":\"2023-12-31\"}', '2026-07-07 05:13:37', '2026-07-07 05:13:37'),
('019f3c80-09e9-7281-a5ba-be2d81e87b1c', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'SUB_PERIOD', 'Sub periode Januari 2023 berhasil dibuat.', 'App\\Models\\SubPeriod', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '[]', '{\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"name\":\"Januari 2023\",\"description\":\"Bulan januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"updated_at\":\"2026-07-07T12:14:11.000000Z\",\"created_at\":\"2026-07-07T12:14:11.000000Z\"}', '110.136.89.140', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"start_date\":\"2023-01-01\",\"end_date\":\"2023-01-31\",\"is_active\":false}', '2026-07-07 05:14:11', '2026-07-07 05:14:11'),
('019f3fe9-9cee-70e7-8b2d-c8125927394b', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas (11100) pada sub periode Januari 2023 dengan jumlah 194,604,157.00', 'App\\Models\\OpeningBalance', '019f3fe9-9cd8-7303-a064-f16742d22de3', '[]', '{\"chart_of_account_id\":\"d9c57730-6928-4e5d-ac29-bf2f6dd9895f\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"balance_type\":\"DEBIT\",\"amount\":194604157,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3fe9-9cd8-7303-a064-f16742d22de3\",\"updated_at\":\"2026-07-08T04:08:22.000000Z\",\"created_at\":\"2026-07-08T04:08:22.000000Z\",\"chart_of_account\":{\"id\":\"d9c57730-6928-4e5d-ac29-bf2f6dd9895f\",\"code\":\"11100\",\"name\":\"Kas\",\"parent_id\":\"060c7786-2d80-4af6-a7f3-4d8dba51c049\",\"level\":\"2\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:02.000000Z\",\"updated_at\":\"2026-07-07T10:40:02.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"name\":\"Januari 2023\",\"description\":\"Bulan januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T12:14:11.000000Z\",\"updated_at\":\"2026-07-07T12:14:11.000000Z\"}}', '110.137.100.73', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"d9c57730-6928-4e5d-ac29-bf2f6dd9895f\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"opening_balance\":194604157,\"debit_total\":0,\"credit_total\":0,\"current_balance\":194604157,\"last_transaction_at\":\"2026-07-08T04:08:22.000000Z\",\"id\":\"019f3fe9-9ce2-7338-8789-8bebd0eb0556\",\"updated_at\":\"2026-07-08T04:08:22.000000Z\",\"created_at\":\"2026-07-08T04:08:22.000000Z\"}}', '2026-07-07 21:08:22', '2026-07-07 21:08:22');
INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `module`, `description`, `subject_type`, `subject_id`, `old_values`, `new_values`, `ip_address`, `user_agent`, `additional_data`, `created_at`, `updated_at`) VALUES
('019f3fe9-ece9-72ca-b37f-971b893cae45', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas Ditangan (11110) pada sub periode Januari 2023 dengan jumlah 4,983,047.00', 'App\\Models\\OpeningBalance', '019f3fe9-ecda-70f1-b736-aafa597a64dd', '[]', '{\"chart_of_account_id\":\"7e3a051c-a73b-485c-865c-f7259792967d\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"balance_type\":\"DEBIT\",\"amount\":4983047,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3fe9-ecda-70f1-b736-aafa597a64dd\",\"updated_at\":\"2026-07-08T04:08:42.000000Z\",\"created_at\":\"2026-07-08T04:08:42.000000Z\",\"chart_of_account\":{\"id\":\"7e3a051c-a73b-485c-865c-f7259792967d\",\"code\":\"11110\",\"name\":\"Kas Ditangan\",\"parent_id\":\"d9c57730-6928-4e5d-ac29-bf2f6dd9895f\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:02.000000Z\",\"updated_at\":\"2026-07-07T10:40:02.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"name\":\"Januari 2023\",\"description\":\"Bulan januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T12:14:11.000000Z\",\"updated_at\":\"2026-07-07T12:14:11.000000Z\"}}', '110.137.100.73', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"7e3a051c-a73b-485c-865c-f7259792967d\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"opening_balance\":4983047,\"debit_total\":0,\"credit_total\":0,\"current_balance\":4983047,\"last_transaction_at\":\"2026-07-08T04:08:42.000000Z\",\"id\":\"019f3fe9-ece0-702f-ad68-9b8621e61167\",\"updated_at\":\"2026-07-08T04:08:42.000000Z\",\"created_at\":\"2026-07-08T04:08:42.000000Z\"}}', '2026-07-07 21:08:42', '2026-07-07 21:08:42'),
('019f3fea-3f25-70c3-851e-5590b3debc13', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas di Bank Jatim (11120) pada sub periode Januari 2023 dengan jumlah 385,384,747.00', 'App\\Models\\OpeningBalance', '019f3fea-3f18-73f4-85b1-7b444d1b63c8', '[]', '{\"chart_of_account_id\":\"fc646e17-8f59-466f-8bea-74a29c39bdad\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"balance_type\":\"DEBIT\",\"amount\":385384747,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3fea-3f18-73f4-85b1-7b444d1b63c8\",\"updated_at\":\"2026-07-08T04:09:04.000000Z\",\"created_at\":\"2026-07-08T04:09:04.000000Z\",\"chart_of_account\":{\"id\":\"fc646e17-8f59-466f-8bea-74a29c39bdad\",\"code\":\"11120\",\"name\":\"Kas di Bank Jatim\",\"parent_id\":\"d9c57730-6928-4e5d-ac29-bf2f6dd9895f\",\"level\":\"3\",\"order\":\"2\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:02.000000Z\",\"updated_at\":\"2026-07-07T10:40:02.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"name\":\"Januari 2023\",\"description\":\"Bulan januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T12:14:11.000000Z\",\"updated_at\":\"2026-07-07T12:14:11.000000Z\"}}', '110.137.100.73', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"fc646e17-8f59-466f-8bea-74a29c39bdad\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"opening_balance\":385384747,\"debit_total\":0,\"credit_total\":0,\"current_balance\":385384747,\"last_transaction_at\":\"2026-07-08T04:09:04.000000Z\",\"id\":\"019f3fea-3f1e-728c-996a-83c3007fa359\",\"updated_at\":\"2026-07-08T04:09:04.000000Z\",\"created_at\":\"2026-07-08T04:09:04.000000Z\"}}', '2026-07-07 21:09:04', '2026-07-07 21:09:04'),
('019f3fea-80ec-71c9-921a-592ab0d61dec', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas di Bank Jatim Dr. Soetomo (11130) pada sub periode Januari 2023 dengan jumlah 1,156,982,563.00', 'App\\Models\\OpeningBalance', '019f3fea-80d9-7262-a0eb-42258509392b', '[]', '{\"chart_of_account_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"balance_type\":\"DEBIT\",\"amount\":1156982563,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3fea-80d9-7262-a0eb-42258509392b\",\"updated_at\":\"2026-07-08T04:09:20.000000Z\",\"created_at\":\"2026-07-08T04:09:20.000000Z\",\"chart_of_account\":{\"id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"code\":\"11130\",\"name\":\"Kas di Bank Jatim Dr. Soetomo\",\"parent_id\":\"d9c57730-6928-4e5d-ac29-bf2f6dd9895f\",\"level\":\"3\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:02.000000Z\",\"updated_at\":\"2026-07-07T10:40:02.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"name\":\"Januari 2023\",\"description\":\"Bulan januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T12:14:11.000000Z\",\"updated_at\":\"2026-07-07T12:14:11.000000Z\"}}', '110.137.100.73', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"opening_balance\":1156982563,\"debit_total\":0,\"credit_total\":0,\"current_balance\":1156982563,\"last_transaction_at\":\"2026-07-08T04:09:20.000000Z\",\"id\":\"019f3fea-80df-7366-8493-f35f199a09be\",\"updated_at\":\"2026-07-08T04:09:20.000000Z\",\"created_at\":\"2026-07-08T04:09:20.000000Z\"}}', '2026-07-07 21:09:20', '2026-07-07 21:09:20'),
('019f3fea-dedf-717f-8f28-260643a763a9', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas di Bank Bukopin Syariah (11140) pada sub periode Januari 2023 dengan jumlah 377,940,865.00', 'App\\Models\\OpeningBalance', '019f3fea-ded1-723e-8e52-6018681a16de', '[]', '{\"chart_of_account_id\":\"ff336d58-31ed-49b6-8df8-6ea403800108\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"balance_type\":\"DEBIT\",\"amount\":377940865,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3fea-ded1-723e-8e52-6018681a16de\",\"updated_at\":\"2026-07-08T04:09:44.000000Z\",\"created_at\":\"2026-07-08T04:09:44.000000Z\",\"chart_of_account\":{\"id\":\"ff336d58-31ed-49b6-8df8-6ea403800108\",\"code\":\"11140\",\"name\":\"Kas di Bank Bukopin Syariah\",\"parent_id\":\"d9c57730-6928-4e5d-ac29-bf2f6dd9895f\",\"level\":\"3\",\"order\":\"4\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:02.000000Z\",\"updated_at\":\"2026-07-07T10:40:02.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"name\":\"Januari 2023\",\"description\":\"Bulan januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T12:14:11.000000Z\",\"updated_at\":\"2026-07-07T12:14:11.000000Z\"}}', '110.137.100.73', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"ff336d58-31ed-49b6-8df8-6ea403800108\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"opening_balance\":377940865,\"debit_total\":0,\"credit_total\":0,\"current_balance\":377940865,\"last_transaction_at\":\"2026-07-08T04:09:44.000000Z\",\"id\":\"019f3fea-ded8-737b-bb62-93092f5358e5\",\"updated_at\":\"2026-07-08T04:09:44.000000Z\",\"created_at\":\"2026-07-08T04:09:44.000000Z\"}}', '2026-07-07 21:09:44', '2026-07-07 21:09:44'),
('019f3feb-16c0-707a-aee2-7928ded27d06', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Piutang Karyawan (11300) pada sub periode Januari 2023 dengan jumlah 1,800,000.00', 'App\\Models\\OpeningBalance', '019f3feb-16b3-7388-a5d9-311b693b8ffe', '[]', '{\"chart_of_account_id\":\"700e4c22-26f3-43ce-8ef0-b32b8920e93c\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"balance_type\":\"DEBIT\",\"amount\":1800000,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3feb-16b3-7388-a5d9-311b693b8ffe\",\"updated_at\":\"2026-07-08T04:09:59.000000Z\",\"created_at\":\"2026-07-08T04:09:59.000000Z\",\"chart_of_account\":{\"id\":\"700e4c22-26f3-43ce-8ef0-b32b8920e93c\",\"code\":\"11300\",\"name\":\"Piutang Karyawan\",\"parent_id\":\"060c7786-2d80-4af6-a7f3-4d8dba51c049\",\"level\":\"2\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:02.000000Z\",\"updated_at\":\"2026-07-07T10:40:02.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"name\":\"Januari 2023\",\"description\":\"Bulan januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T12:14:11.000000Z\",\"updated_at\":\"2026-07-07T12:14:11.000000Z\"}}', '110.137.100.73', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"700e4c22-26f3-43ce-8ef0-b32b8920e93c\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"opening_balance\":1800000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":1800000,\"last_transaction_at\":\"2026-07-08T04:09:59.000000Z\",\"id\":\"019f3feb-16b8-7044-8897-cf2f9356100a\",\"updated_at\":\"2026-07-08T04:09:59.000000Z\",\"created_at\":\"2026-07-08T04:09:59.000000Z\"}}', '2026-07-07 21:09:59', '2026-07-07 21:09:59'),
('019f3feb-e8bd-7285-ab02-19040396e506', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Piutang Lainnya (11400) pada sub periode Januari 2023 dengan jumlah 921,735,276.00', 'App\\Models\\OpeningBalance', '019f3feb-e8ae-70e5-ad6c-4539936328c8', '[]', '{\"chart_of_account_id\":\"f67c7605-fd55-4d04-8065-738b2feff09a\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"balance_type\":\"DEBIT\",\"amount\":921735276,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3feb-e8ae-70e5-ad6c-4539936328c8\",\"updated_at\":\"2026-07-08T04:10:52.000000Z\",\"created_at\":\"2026-07-08T04:10:52.000000Z\",\"chart_of_account\":{\"id\":\"f67c7605-fd55-4d04-8065-738b2feff09a\",\"code\":\"11400\",\"name\":\"Piutang Lainnya\",\"parent_id\":\"060c7786-2d80-4af6-a7f3-4d8dba51c049\",\"level\":\"2\",\"order\":\"4\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:02.000000Z\",\"updated_at\":\"2026-07-07T10:40:02.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"name\":\"Januari 2023\",\"description\":\"Bulan januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T12:14:11.000000Z\",\"updated_at\":\"2026-07-07T12:14:11.000000Z\"}}', '110.137.100.73', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"f67c7605-fd55-4d04-8065-738b2feff09a\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"opening_balance\":921735276,\"debit_total\":0,\"credit_total\":0,\"current_balance\":921735276,\"last_transaction_at\":\"2026-07-08T04:10:52.000000Z\",\"id\":\"019f3feb-e8b4-713e-9fd2-ae086cfbaebf\",\"updated_at\":\"2026-07-08T04:10:52.000000Z\",\"created_at\":\"2026-07-08T04:10:52.000000Z\"}}', '2026-07-07 21:10:52', '2026-07-07 21:10:52'),
('019f3fec-d3e0-70ce-bc68-0709d7009fb2', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kendaraan (12300) pada sub periode Januari 2023 dengan jumlah 460,769,432.00', 'App\\Models\\OpeningBalance', '019f3fec-d3cd-70e1-b374-632be38f1f6d', '[]', '{\"chart_of_account_id\":\"41fbc782-5794-409d-8507-f99fed76fe8b\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"balance_type\":\"DEBIT\",\"amount\":460769432,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3fec-d3cd-70e1-b374-632be38f1f6d\",\"updated_at\":\"2026-07-08T04:11:53.000000Z\",\"created_at\":\"2026-07-08T04:11:53.000000Z\",\"chart_of_account\":{\"id\":\"41fbc782-5794-409d-8507-f99fed76fe8b\",\"code\":\"12300\",\"name\":\"Kendaraan\",\"parent_id\":\"cda7e544-e669-4f9c-9b6f-f6ba07500cef\",\"level\":\"2\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:03.000000Z\",\"updated_at\":\"2026-07-07T10:40:03.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"name\":\"Januari 2023\",\"description\":\"Bulan januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T12:14:11.000000Z\",\"updated_at\":\"2026-07-07T12:14:11.000000Z\"}}', '110.137.100.73', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"41fbc782-5794-409d-8507-f99fed76fe8b\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"opening_balance\":460769432,\"debit_total\":0,\"credit_total\":0,\"current_balance\":460769432,\"last_transaction_at\":\"2026-07-08T04:11:53.000000Z\",\"id\":\"019f3fec-d3d2-7256-b4d4-f11188ac9e93\",\"updated_at\":\"2026-07-08T04:11:53.000000Z\",\"created_at\":\"2026-07-08T04:11:53.000000Z\"}}', '2026-07-07 21:11:53', '2026-07-07 21:11:53'),
('019f3fed-2095-71d0-a987-caa09225dd4d', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Akumulasi Depresiasi Kendaraan (12310) pada sub periode Januari 2023 dengan jumlah 144,000,000.00', 'App\\Models\\OpeningBalance', '019f3fed-2082-7041-a68c-182db12d82ee', '[]', '{\"chart_of_account_id\":\"92aa553e-6ee4-48e9-a7f7-02acaba8ecd0\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"balance_type\":\"CREDIT\",\"amount\":144000000,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3fed-2082-7041-a68c-182db12d82ee\",\"updated_at\":\"2026-07-08T04:12:12.000000Z\",\"created_at\":\"2026-07-08T04:12:12.000000Z\",\"chart_of_account\":{\"id\":\"92aa553e-6ee4-48e9-a7f7-02acaba8ecd0\",\"code\":\"12310\",\"name\":\"Akumulasi Depresiasi Kendaraan\",\"parent_id\":\"41fbc782-5794-409d-8507-f99fed76fe8b\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:03.000000Z\",\"updated_at\":\"2026-07-07T10:40:03.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"name\":\"Januari 2023\",\"description\":\"Bulan januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T12:14:11.000000Z\",\"updated_at\":\"2026-07-07T12:14:11.000000Z\"}}', '110.137.100.73', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"92aa553e-6ee4-48e9-a7f7-02acaba8ecd0\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"opening_balance\":144000000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":144000000,\"last_transaction_at\":\"2026-07-08T04:12:12.000000Z\",\"id\":\"019f3fed-2089-71c4-b292-370ad78eeda7\",\"updated_at\":\"2026-07-08T04:12:12.000000Z\",\"created_at\":\"2026-07-08T04:12:12.000000Z\"}}', '2026-07-07 21:12:12', '2026-07-07 21:12:12'),
('019f3fed-5ba0-72cf-8578-cce3fb2e9490', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Meubel (12400) pada sub periode Januari 2023 dengan jumlah 15,500,000.00', 'App\\Models\\OpeningBalance', '019f3fed-5b8d-73ba-aedc-4792f52f9c91', '[]', '{\"chart_of_account_id\":\"225f7e5c-8132-4aff-bccd-9c1e07ebc65f\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"balance_type\":\"DEBIT\",\"amount\":15500000,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3fed-5b8d-73ba-aedc-4792f52f9c91\",\"updated_at\":\"2026-07-08T04:12:27.000000Z\",\"created_at\":\"2026-07-08T04:12:27.000000Z\",\"chart_of_account\":{\"id\":\"225f7e5c-8132-4aff-bccd-9c1e07ebc65f\",\"code\":\"12400\",\"name\":\"Meubel\",\"parent_id\":\"cda7e544-e669-4f9c-9b6f-f6ba07500cef\",\"level\":\"2\",\"order\":\"4\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:03.000000Z\",\"updated_at\":\"2026-07-07T10:40:03.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"name\":\"Januari 2023\",\"description\":\"Bulan januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T12:14:11.000000Z\",\"updated_at\":\"2026-07-07T12:14:11.000000Z\"}}', '110.137.100.73', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"225f7e5c-8132-4aff-bccd-9c1e07ebc65f\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"opening_balance\":15500000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":15500000,\"last_transaction_at\":\"2026-07-08T04:12:27.000000Z\",\"id\":\"019f3fed-5b95-7218-9bdc-295171018889\",\"updated_at\":\"2026-07-08T04:12:27.000000Z\",\"created_at\":\"2026-07-08T04:12:27.000000Z\"}}', '2026-07-07 21:12:27', '2026-07-07 21:12:27'),
('019f3fed-a26f-73cb-b2bc-fd5e88f910f5', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Akumulasi Depresiasi Meubel (12410) pada sub periode Januari 2023 dengan jumlah 13,376,668.00', 'App\\Models\\OpeningBalance', '019f3fed-a259-73df-92bc-36d1744b1f91', '[]', '{\"chart_of_account_id\":\"7fecbf43-5f25-49e8-8068-a4aed1808cd4\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"balance_type\":\"CREDIT\",\"amount\":13376668,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3fed-a259-73df-92bc-36d1744b1f91\",\"updated_at\":\"2026-07-08T04:12:46.000000Z\",\"created_at\":\"2026-07-08T04:12:46.000000Z\",\"chart_of_account\":{\"id\":\"7fecbf43-5f25-49e8-8068-a4aed1808cd4\",\"code\":\"12410\",\"name\":\"Akumulasi Depresiasi Meubel\",\"parent_id\":\"225f7e5c-8132-4aff-bccd-9c1e07ebc65f\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:03.000000Z\",\"updated_at\":\"2026-07-07T10:40:03.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"name\":\"Januari 2023\",\"description\":\"Bulan januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T12:14:11.000000Z\",\"updated_at\":\"2026-07-07T12:14:11.000000Z\"}}', '110.137.100.73', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"7fecbf43-5f25-49e8-8068-a4aed1808cd4\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"opening_balance\":13376668,\"debit_total\":0,\"credit_total\":0,\"current_balance\":13376668,\"last_transaction_at\":\"2026-07-08T04:12:46.000000Z\",\"id\":\"019f3fed-a262-72cb-accb-8d74a031ce10\",\"updated_at\":\"2026-07-08T04:12:46.000000Z\",\"created_at\":\"2026-07-08T04:12:46.000000Z\"}}', '2026-07-07 21:12:46', '2026-07-07 21:12:46'),
('019f3fed-e8ca-7311-981f-8f8b34447ba6', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Peralatan Kantor (12500) pada sub periode Januari 2023 dengan jumlah 46,059,000.00', 'App\\Models\\OpeningBalance', '019f3fed-e8b8-73d6-babe-b3daae05af22', '[]', '{\"chart_of_account_id\":\"44fb2678-eb3c-4af8-88ea-e9654dcc88ac\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"balance_type\":\"DEBIT\",\"amount\":46059000,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3fed-e8b8-73d6-babe-b3daae05af22\",\"updated_at\":\"2026-07-08T04:13:04.000000Z\",\"created_at\":\"2026-07-08T04:13:04.000000Z\",\"chart_of_account\":{\"id\":\"44fb2678-eb3c-4af8-88ea-e9654dcc88ac\",\"code\":\"12500\",\"name\":\"Peralatan Kantor\",\"parent_id\":\"cda7e544-e669-4f9c-9b6f-f6ba07500cef\",\"level\":\"2\",\"order\":\"5\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:03.000000Z\",\"updated_at\":\"2026-07-07T10:40:03.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"name\":\"Januari 2023\",\"description\":\"Bulan januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T12:14:11.000000Z\",\"updated_at\":\"2026-07-07T12:14:11.000000Z\"}}', '110.137.100.73', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"44fb2678-eb3c-4af8-88ea-e9654dcc88ac\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"opening_balance\":46059000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":46059000,\"last_transaction_at\":\"2026-07-08T04:13:04.000000Z\",\"id\":\"019f3fed-e8c0-7365-a2f7-473b78e81cf9\",\"updated_at\":\"2026-07-08T04:13:04.000000Z\",\"created_at\":\"2026-07-08T04:13:04.000000Z\"}}', '2026-07-07 21:13:04', '2026-07-07 21:13:04'),
('019f3fee-3837-739b-b18d-5438a178f104', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Akumulasi Depresiasi Peralatan Kantor (12510) pada sub periode Januari 2023 dengan jumlah 25,236,667.00', 'App\\Models\\OpeningBalance', '019f3fee-3823-737f-8647-ca186fbad10b', '[]', '{\"chart_of_account_id\":\"bed710fe-7648-4fe7-9b9b-b1f2f960cee7\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"balance_type\":\"CREDIT\",\"amount\":25236667,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3fee-3823-737f-8647-ca186fbad10b\",\"updated_at\":\"2026-07-08T04:13:24.000000Z\",\"created_at\":\"2026-07-08T04:13:24.000000Z\",\"chart_of_account\":{\"id\":\"bed710fe-7648-4fe7-9b9b-b1f2f960cee7\",\"code\":\"12510\",\"name\":\"Akumulasi Depresiasi Peralatan Kantor\",\"parent_id\":\"44fb2678-eb3c-4af8-88ea-e9654dcc88ac\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:03.000000Z\",\"updated_at\":\"2026-07-07T10:40:03.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"name\":\"Januari 2023\",\"description\":\"Bulan januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T12:14:11.000000Z\",\"updated_at\":\"2026-07-07T12:14:11.000000Z\"}}', '110.137.100.73', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"bed710fe-7648-4fe7-9b9b-b1f2f960cee7\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"opening_balance\":25236667,\"debit_total\":0,\"credit_total\":0,\"current_balance\":25236667,\"last_transaction_at\":\"2026-07-08T04:13:24.000000Z\",\"id\":\"019f3fee-382c-72bf-b0fa-3c986be0f0f6\",\"updated_at\":\"2026-07-08T04:13:24.000000Z\",\"created_at\":\"2026-07-08T04:13:24.000000Z\"}}', '2026-07-07 21:13:24', '2026-07-07 21:13:24'),
('019f3fef-10c1-7214-a9bd-ddd35deb6d32', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Modal Tetap (31100) pada sub periode Januari 2023 dengan jumlah 339,715,097.00', 'App\\Models\\OpeningBalance', '019f3fef-10b4-72e1-8e2e-8e4faa2be8dc', '[]', '{\"chart_of_account_id\":\"3fab3482-9af2-4d47-92f0-b6a42980348c\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"balance_type\":\"CREDIT\",\"amount\":339715097,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3fef-10b4-72e1-8e2e-8e4faa2be8dc\",\"updated_at\":\"2026-07-08T04:14:19.000000Z\",\"created_at\":\"2026-07-08T04:14:19.000000Z\",\"chart_of_account\":{\"id\":\"3fab3482-9af2-4d47-92f0-b6a42980348c\",\"code\":\"31100\",\"name\":\"Modal Tetap\",\"parent_id\":\"99796640-5f95-4ad6-bf89-7121444ade40\",\"level\":\"2\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567892\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:03.000000Z\",\"updated_at\":\"2026-07-07T10:40:03.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"name\":\"Januari 2023\",\"description\":\"Bulan januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T12:14:11.000000Z\",\"updated_at\":\"2026-07-07T12:14:11.000000Z\"}}', '110.137.100.73', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"3fab3482-9af2-4d47-92f0-b6a42980348c\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"opening_balance\":339715097,\"debit_total\":0,\"credit_total\":0,\"current_balance\":339715097,\"last_transaction_at\":\"2026-07-08T04:14:19.000000Z\",\"id\":\"019f3fef-10ba-7198-8433-dec76c25580d\",\"updated_at\":\"2026-07-08T04:14:19.000000Z\",\"created_at\":\"2026-07-08T04:14:19.000000Z\"}}', '2026-07-07 21:14:19', '2026-07-07 21:14:19'),
('019f3fef-54f5-731b-b4d5-b071332afbf2', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Modal Lancar (31200) pada sub periode Januari 2023 dengan jumlah 368,679,944.00', 'App\\Models\\OpeningBalance', '019f3fef-54e3-732d-9faf-f091b0b9ffc2', '[]', '{\"chart_of_account_id\":\"db8f505b-44a6-45f5-8d10-f8d15bea1af4\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"balance_type\":\"CREDIT\",\"amount\":368679944,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3fef-54e3-732d-9faf-f091b0b9ffc2\",\"updated_at\":\"2026-07-08T04:14:37.000000Z\",\"created_at\":\"2026-07-08T04:14:37.000000Z\",\"chart_of_account\":{\"id\":\"db8f505b-44a6-45f5-8d10-f8d15bea1af4\",\"code\":\"31200\",\"name\":\"Modal Lancar\",\"parent_id\":\"99796640-5f95-4ad6-bf89-7121444ade40\",\"level\":\"2\",\"order\":\"2\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567892\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:03.000000Z\",\"updated_at\":\"2026-07-07T10:40:03.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"name\":\"Januari 2023\",\"description\":\"Bulan januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T12:14:11.000000Z\",\"updated_at\":\"2026-07-07T12:14:11.000000Z\"}}', '110.137.100.73', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"db8f505b-44a6-45f5-8d10-f8d15bea1af4\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"opening_balance\":368679944,\"debit_total\":0,\"credit_total\":0,\"current_balance\":368679944,\"last_transaction_at\":\"2026-07-08T04:14:37.000000Z\",\"id\":\"019f3fef-54ee-7201-ba5c-3a4b4482b20c\",\"updated_at\":\"2026-07-08T04:14:37.000000Z\",\"created_at\":\"2026-07-08T04:14:37.000000Z\"}}', '2026-07-07 21:14:37', '2026-07-07 21:14:37'),
('019f3fef-8feb-7297-82a8-8184dc812262', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Selisih Lebih/Kurang (31300) pada sub periode Januari 2023 dengan jumlah 2,674,750,712.00', 'App\\Models\\OpeningBalance', '019f3fef-8fde-7233-9c46-b8b686a0f2a7', '[]', '{\"chart_of_account_id\":\"34946f7c-6f05-4bb7-ba94-01afba90ff43\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"balance_type\":\"CREDIT\",\"amount\":2674750712,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3fef-8fde-7233-9c46-b8b686a0f2a7\",\"updated_at\":\"2026-07-08T04:14:52.000000Z\",\"created_at\":\"2026-07-08T04:14:52.000000Z\",\"chart_of_account\":{\"id\":\"34946f7c-6f05-4bb7-ba94-01afba90ff43\",\"code\":\"31300\",\"name\":\"Selisih Lebih\\/Kurang\",\"parent_id\":\"99796640-5f95-4ad6-bf89-7121444ade40\",\"level\":\"2\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567892\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:03.000000Z\",\"updated_at\":\"2026-07-07T10:40:03.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"name\":\"Januari 2023\",\"description\":\"Bulan januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T12:14:11.000000Z\",\"updated_at\":\"2026-07-07T12:14:11.000000Z\"}}', '110.137.100.73', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"34946f7c-6f05-4bb7-ba94-01afba90ff43\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"opening_balance\":2674750712,\"debit_total\":0,\"credit_total\":0,\"current_balance\":2674750712,\"last_transaction_at\":\"2026-07-08T04:14:52.000000Z\",\"id\":\"019f3fef-8fe3-72dd-88aa-7a76ecb0472a\",\"updated_at\":\"2026-07-08T04:14:52.000000Z\",\"created_at\":\"2026-07-08T04:14:52.000000Z\"}}', '2026-07-07 21:14:52', '2026-07-07 21:14:52');

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
('02e0f19e-fe7c-4af8-9840-eba30817c41e', '55300', 'Biaya Akomodasi', '69339cd7-dd8c-4966-bb0d-ad14dc3d9bd1', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('03ea188f-4a5a-49a1-a360-afbcee575894', '54000', 'Biaya Persidangan', '931fa6b3-6053-4b8e-8f45-5dc87115dcb6', '2', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('05b667e2-951b-4735-83e7-6761a059c2d4', '41000', 'Pendapatan Organisasi', '8f516b93-3983-41be-a7d9-37a2364355b3', '2', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('060c7786-2d80-4af6-a7f3-4d8dba51c049', '11000', 'Aset Lancar', NULL, '1', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:02', '2026-07-07 03:40:02', NULL),
('06165d42-2fb0-4393-9a8f-f445880be667', '42100', 'Kontribusi Bidang Pendidikan', '0ba8ade3-8dc6-4ffb-89c7-50e579be3146', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('06d411e4-689d-4f6d-bb2e-c9f44aeab33d', '22000', 'Hutang Pajak', NULL, '1', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567891', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('0b374ecb-94f5-41ba-9e48-36082946c81e', '57800', 'Biaya Operasional Inklusi', 'dc16f8fe-a09e-4399-a227-7320a3f32feb', '3', '8', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:05', '2026-07-07 03:40:05', NULL),
('0ba8ade3-8dc6-4ffb-89c7-50e579be3146', '42000', 'Kontribusi Amal Usaha', '8f516b93-3983-41be-a7d9-37a2364355b3', '2', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('0dcf66b6-8ba6-40b3-89e7-282aa84c03e5', '57200', 'Biaya Pelaksanaan Program Majelis & Lembaga', 'dc16f8fe-a09e-4399-a227-7320a3f32feb', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('10af2cdc-0754-4d24-871d-46ad9bdb8f98', '12200', 'Gedung', 'cda7e544-e669-4f9c-9b6f-f6ba07500cef', '2', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('11a7616a-06e7-4757-84c2-79d6f91406ef', '59300', 'Biaya Materai', '2ffe0b7f-2bc6-4dac-9940-e53393a90f58', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:05', '2026-07-07 03:40:05', NULL),
('132603d3-0f4b-4c28-8e39-e05a89642d98', '57206', 'Biaya Program Kesejahteraan Sosial', '0dcf66b6-8ba6-40b3-89e7-282aa84c03e5', '4', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('1f3e9890-fa94-4611-9531-cbabb4f9091e', '44004', 'Pendapatan Pembangunan ATC', '290bef48-1174-4bb0-8c01-0d5b17108128', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('225f7e5c-8132-4aff-bccd-9c1e07ebc65f', '12400', 'Meubel', 'cda7e544-e669-4f9c-9b6f-f6ba07500cef', '2', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('22863257-23b1-40b2-81b5-625a579e4887', '52010', 'Biaya Pemeliharaan Peralatan Kantor', 'd7d9901c-9785-4410-aae6-2c4236b5648d', '3', '10', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('23ce33b2-eb43-4bad-aeff-715f9e4f8a06', '57300', 'Biaya kehumasan', 'dc16f8fe-a09e-4399-a227-7320a3f32feb', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:05', '2026-07-07 03:40:05', NULL),
('258febc1-f6d2-49bd-be01-08741fe511da', '12600', 'Investasi Jangka Panjang', 'cda7e544-e669-4f9c-9b6f-f6ba07500cef', '2', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('2697d4da-bd60-4ada-9ab3-8f75a3dcc793', '55200', 'Biaya Transport Lokal', '69339cd7-dd8c-4966-bb0d-ad14dc3d9bd1', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('27b3424e-5e94-48db-8d12-af1165d6ed2f', '51001', 'Biaya Gaji Karyawan & Staf', 'd40db36e-328b-43fd-ae0a-2fb09fcef5c2', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('27ef2784-5982-421c-bb3f-96a51777fbf3', '11600', 'Tabungan Bueka Assakinah', '060c7786-2d80-4af6-a7f3-4d8dba51c049', '2', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:02', '2026-07-07 03:40:02', NULL),
('290bef48-1174-4bb0-8c01-0d5b17108128', '44000', 'Pendapatan Kerjasama', '8f516b93-3983-41be-a7d9-37a2364355b3', '2', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('29b45798-4894-4b34-8b98-6763e573bb7a', '43200', 'Pendapatan Deposito', '638a512b-cab3-4d52-b467-7193ccc1feb3', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('2c677359-98b2-440d-ae53-dcae5095841e', '52300', 'Biaya surat kabar & langganan Media', 'd7d9901c-9785-4410-aae6-2c4236b5648d', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('2f1adb90-a4d5-4c63-8ed9-7f4109b1890d', '52600', 'Biaya Pemeliharaan Gedung', 'd7d9901c-9785-4410-aae6-2c4236b5648d', '3', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('2fc91e28-cafa-42d5-a383-960bd2304d79', '22100', 'Hutang PPN', '06d411e4-689d-4f6d-bb2e-c9f44aeab33d', '2', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567891', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('2ffe0b7f-2bc6-4dac-9940-e53393a90f58', '59000', 'Biaya Administrasi Bank', '931fa6b3-6053-4b8e-8f45-5dc87115dcb6', '2', '9', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:05', '2026-07-07 03:40:05', NULL),
('34946f7c-6f05-4bb7-ba94-01afba90ff43', '31300', 'Selisih Lebih/Kurang', '99796640-5f95-4ad6-bf89-7121444ade40', '2', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567892', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('36c76a75-5dd6-48bd-b474-bde2c2b9e7d3', '53200', 'Depresiasi Kendaraan', '8e772f65-a3e0-4d09-8783-132811d324b5', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('37aaef0a-ab7e-4bc1-8f6f-fb6028a3277e', '52013', 'Biaya Parkir', 'd7d9901c-9785-4410-aae6-2c4236b5648d', '3', '13', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('3f354843-3d12-4886-ae4d-a0cf7ff5c6c4', '22300', 'Hutang PPh 23', '06d411e4-689d-4f6d-bb2e-c9f44aeab33d', '2', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567891', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('3fab3482-9af2-4d47-92f0-b6a42980348c', '31100', 'Modal Tetap', '99796640-5f95-4ad6-bf89-7121444ade40', '2', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567892', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('41dd99c8-6337-4697-ac01-ffb1bf79540b', '42300', 'Kontribusi Bidang Ekonomi', '0ba8ade3-8dc6-4ffb-89c7-50e579be3146', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('41fbc782-5794-409d-8507-f99fed76fe8b', '12300', 'Kendaraan', 'cda7e544-e669-4f9c-9b6f-f6ba07500cef', '2', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('44fb2678-eb3c-4af8-88ea-e9654dcc88ac', '12500', 'Peralatan Kantor', 'cda7e544-e669-4f9c-9b6f-f6ba07500cef', '2', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('46a3a069-49e2-403a-a208-ae7cf8219249', '12100', 'Tanah', 'cda7e544-e669-4f9c-9b6f-f6ba07500cef', '2', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('4755ebf2-c52b-4f64-8281-176d879ac1aa', '57209', 'Biaya Program Penelitian dan Pengembangan Aisyiyah', '0dcf66b6-8ba6-40b3-89e7-282aa84c03e5', '4', '9', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:05', '2026-07-07 03:40:05', NULL),
('48b61973-5d46-469e-9ae3-afd4a3be5fae', '52012', 'Biaya BBM', 'd7d9901c-9785-4410-aae6-2c4236b5648d', '3', '12', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('4a6caa70-24ca-45b3-b752-57f72b56a930', '52014', 'Biaya Komunikasi', 'd7d9901c-9785-4410-aae6-2c4236b5648d', '3', '14', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('4b7fc140-c63d-4001-8704-c0ece2a4ec7b', '52100', 'Biaya Kertas & ATK', 'd7d9901c-9785-4410-aae6-2c4236b5648d', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('4cf55425-0f8b-4b44-ad53-26c1dab32558', '52400', 'Biaya Cetak-Cetak', 'd7d9901c-9785-4410-aae6-2c4236b5648d', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('4dde9b7f-95c6-47e7-ade5-9cb403950064', '56000', 'Biaya Pengembangan SDM', '931fa6b3-6053-4b8e-8f45-5dc87115dcb6', '2', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('56962e72-737c-4932-a1c1-4d7cf41db900', '41600', 'Simpanan Wajib Peserta', '05b667e2-951b-4735-83e7-6761a059c2d4', '3', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('58890adf-02ff-4976-9357-7840f15e5c8d', '44005', 'Pendapatan Inklusi', '290bef48-1174-4bb0-8c01-0d5b17108128', '3', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('591c8ff4-1887-4259-b966-890f724424e3', '57205', 'Biaya Program Pimbinaan Kader', '0dcf66b6-8ba6-40b3-89e7-282aa84c03e5', '4', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('5afb25f5-ea51-4978-8159-60aef27c29e0', '54300', 'Biaya Sidang Tanwir', '03ea188f-4a5a-49a1-a360-afbcee575894', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('5b11c6ca-5d87-4837-ad30-e91953c5a1a9', '58000', 'Biaya Kesejahteraan', '931fa6b3-6053-4b8e-8f45-5dc87115dcb6', '2', '8', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:05', '2026-07-07 03:40:05', NULL),
('5c2b1cd4-d67d-4a13-8d27-ca888f5f02f2', '52200', 'Biaya Listrik, Telepon, Air, & Internet', 'd7d9901c-9785-4410-aae6-2c4236b5648d', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('5e5b9787-1c85-40fb-a997-52b1bb7e7ed5', '59200', 'Biaya Bunga Bank', '2ffe0b7f-2bc6-4dac-9940-e53393a90f58', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:05', '2026-07-07 03:40:05', NULL),
('605dc218-d091-47b2-a7f2-0effb402d2d4', '53300', 'Depresiasi Meubel', '8e772f65-a3e0-4d09-8783-132811d324b5', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('610faad3-6e8f-4791-8608-cb0eb19688be', '54400', 'Biaya Sidang Muktamar', '03ea188f-4a5a-49a1-a360-afbcee575894', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('638a512b-cab3-4d52-b467-7193ccc1feb3', '43000', 'Pendapatan Jasa Bank (Neto)', '8f516b93-3983-41be-a7d9-37a2364355b3', '2', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('640af4d9-6891-4840-9a50-8c009ca3f486', '51003', 'Insentif Lembur Karyawan & Staf', 'd40db36e-328b-43fd-ae0a-2fb09fcef5c2', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('6486b0ff-c08e-4b4a-b6bd-6cf40c1d93dd', '53400', 'Depresiasi Peralatan Kantor', '8e772f65-a3e0-4d09-8783-132811d324b5', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('6865e20e-43b2-48ce-b3a3-653078468886', '11500', 'Penyertaan Modal Bueka Assakinah', '060c7786-2d80-4af6-a7f3-4d8dba51c049', '2', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:02', '2026-07-07 03:40:02', NULL),
('69339cd7-dd8c-4966-bb0d-ad14dc3d9bd1', '55000', 'Biaya Perjalanan Dinas', '931fa6b3-6053-4b8e-8f45-5dc87115dcb6', '2', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('6afbe99c-65df-4128-a16c-fa5827c8347f', '51002', 'Honorarium/Kontrak', 'd40db36e-328b-43fd-ae0a-2fb09fcef5c2', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('6f9dd6c1-e799-4bef-8a44-04ce7e7a1dec', '57400', 'Biaya Diskusi dan Kajian', 'dc16f8fe-a09e-4399-a227-7320a3f32feb', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:05', '2026-07-07 03:40:05', NULL),
('700e4c22-26f3-43ce-8ef0-b32b8920e93c', '11300', 'Piutang Karyawan', '060c7786-2d80-4af6-a7f3-4d8dba51c049', '2', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:02', '2026-07-07 03:40:02', NULL),
('724f6c78-1a44-4f74-bf40-fd9b43963ba3', '57203', 'Biaya Program Majelis Kesehatan', '0dcf66b6-8ba6-40b3-89e7-282aa84c03e5', '4', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('76a20fad-6338-4545-9a9e-4acc355eeb3e', '59999', 'Biaya Sosial & Lainnya', '931fa6b3-6053-4b8e-8f45-5dc87115dcb6', '2', '10', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:05', '2026-07-07 03:40:05', NULL),
('7b4c8d7b-ff7f-436d-b874-a6058efa0f36', '43100', 'Pendapatan Bunga Bank', '638a512b-cab3-4d52-b467-7193ccc1feb3', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('7e3a051c-a73b-485c-865c-f7259792967d', '11110', 'Kas Ditangan', 'd9c57730-6928-4e5d-ac29-bf2f6dd9895f', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:02', '2026-07-07 03:40:02', NULL),
('7fecbf43-5f25-49e8-8068-a4aed1808cd4', '12410', 'Akumulasi Depresiasi Meubel', '225f7e5c-8132-4aff-bccd-9c1e07ebc65f', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('80489af9-a27f-469d-aabb-16681c5cf916', '11130', 'Kas di Bank Jatim Dr. Soetomo', 'd9c57730-6928-4e5d-ac29-bf2f6dd9895f', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:02', '2026-07-07 03:40:02', NULL),
('81f580a0-1436-4a81-84a3-93d197075930', '58100', 'Tunjangan Hari Raya', '5b11c6ca-5d87-4837-ad30-e91953c5a1a9', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:05', '2026-07-07 03:40:05', NULL),
('852153e1-1905-487f-9176-56fac68a9968', '42200', 'Kontribusi Bidang Kesehatan', '0ba8ade3-8dc6-4ffb-89c7-50e579be3146', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('89b2bd63-45a5-4376-9301-75f7c5c6869f', '41200', 'Dana Wajib Organisasi', '05b667e2-951b-4735-83e7-6761a059c2d4', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('8dcd1a44-abb4-4383-8182-51e4416392e8', '52900', 'Biaya Pemeliharaan Meubel', 'd7d9901c-9785-4410-aae6-2c4236b5648d', '3', '9', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('8e772f65-a3e0-4d09-8783-132811d324b5', '53000', 'Biaya Depresiasi Aset Tetap', '931fa6b3-6053-4b8e-8f45-5dc87115dcb6', '2', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('8eafa0f0-e378-418c-a53a-73a879cb392f', '52015', 'Biaya Administrasi Kantor Lainnya', 'd7d9901c-9785-4410-aae6-2c4236b5648d', '3', '15', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('8f516b93-3983-41be-a7d9-37a2364355b3', '40000', 'Pendapatan', NULL, '1', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('92aa553e-6ee4-48e9-a7f7-02acaba8ecd0', '12310', 'Akumulasi Depresiasi Kendaraan', '41fbc782-5794-409d-8507-f99fed76fe8b', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('931fa6b3-6053-4b8e-8f45-5dc87115dcb6', '50000', 'Beban Operasional', NULL, '1', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('98c63964-bd5e-4fe0-886b-ff6663c73fdc', '55400', 'Perdiem Pengiriman Utusan', '69339cd7-dd8c-4966-bb0d-ad14dc3d9bd1', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('99796640-5f95-4ad6-bf89-7121444ade40', '31000', 'Aset Bersih', NULL, '1', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567892', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('9d1306f9-10c9-4820-bc3e-e2486c49e8cd', '57100', 'Biaya Pelaksanaan Program', 'dc16f8fe-a09e-4399-a227-7320a3f32feb', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('9f5ccef8-b43a-4686-9dc3-d6199a74ce89', '11700', 'Kos Wonorejo', '060c7786-2d80-4af6-a7f3-4d8dba51c049', '2', '7', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:02', '2026-07-07 03:40:02', NULL),
('9fa5994e-9de7-4284-af4f-df5f7490e4a6', '41100', 'Iuran Anggota', '05b667e2-951b-4735-83e7-6761a059c2d4', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('a32ae99f-0c4c-44e5-9282-6fc6f4cf51de', '54100', 'Biaya Sidang Rutin, Pleno dll', '03ea188f-4a5a-49a1-a360-afbcee575894', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('a5e6167d-c666-42f0-bc88-b75ac70e6ab0', '44001', 'Kerjasama Internal', '290bef48-1174-4bb0-8c01-0d5b17108128', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('ac1a013b-b327-4084-8d52-52440f6bcb54', '51005', 'Tunjangan', 'd40db36e-328b-43fd-ae0a-2fb09fcef5c2', '3', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('ac8a1463-4a4c-4cb1-a0e4-b00c2d9cf522', '57208', 'Biaya Program Lembaga Budaya Seni dan Olah Raga', '0dcf66b6-8ba6-40b3-89e7-282aa84c03e5', '4', '8', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('afd34085-9d09-4ff0-9d09-c07c85a6b595', '59100', 'Biaya Pajak Bank', '2ffe0b7f-2bc6-4dac-9940-e53393a90f58', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:05', '2026-07-07 03:40:05', NULL),
('b01e653a-9e3b-44d1-a81c-f981c7b2acbe', '55100', 'Biaya Tiket', '69339cd7-dd8c-4966-bb0d-ad14dc3d9bd1', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('b2046255-9dc2-406b-ae9a-fd47cf6bddb2', '58300', 'Hadiah', '5b11c6ca-5d87-4837-ad30-e91953c5a1a9', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:05', '2026-07-07 03:40:05', NULL),
('b27bdc66-661a-4dd0-9831-e779426c372a', '52011', 'Biaya Kerumahtanggaan', 'd7d9901c-9785-4410-aae6-2c4236b5648d', '3', '11', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('b472d3a2-353d-484e-accf-1c80167f6000', '57202', 'Biaya Program Pendidikan Anak Usia Dini, Dasar dan Menengah', '0dcf66b6-8ba6-40b3-89e7-282aa84c03e5', '4', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('b840fcec-a9c1-4afc-9824-f6fca25211ba', '21000', 'Hutang Pihak Lain', NULL, '1', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567891', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('b89aeb06-4c14-44b2-9a3a-97f8619e47c8', '57600', 'Biaya operasional ATC', 'dc16f8fe-a09e-4399-a227-7320a3f32feb', '3', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:05', '2026-07-07 03:40:05', NULL),
('bb63ab0e-2314-4079-b255-915ed295b322', '57210', 'Biaya Program Lingkungan Hidup dan Penanggulangan Bencana', '0dcf66b6-8ba6-40b3-89e7-282aa84c03e5', '4', '10', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:05', '2026-07-07 03:40:05', NULL),
('bbca9830-3900-41a5-a233-774c581874e8', '11800', 'Pajak Dibayar Dimuka', '060c7786-2d80-4af6-a7f3-4d8dba51c049', '2', '8', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:02', '2026-07-07 03:40:02', NULL),
('bbd6859d-aae9-435a-bf0a-7543c4fb6321', '51004', 'Uang Makan Karyawan & Staf', 'd40db36e-328b-43fd-ae0a-2fb09fcef5c2', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('bca4163c-d2f5-4b28-a022-83059cfecaa2', '42500', 'Kontribusi Lainnya', '0ba8ade3-8dc6-4ffb-89c7-50e579be3146', '3', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('bed710fe-7648-4fe7-9b9b-b1f2f960cee7', '12510', 'Akumulasi Depresiasi Peralatan Kantor', '44fb2678-eb3c-4af8-88ea-e9654dcc88ac', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('c1211db4-92a4-4343-9bf6-10c9adeeb912', '53100', 'Depresiasi Gedung', '8e772f65-a3e0-4d09-8783-132811d324b5', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('c2f2d0bb-303d-4913-8df0-c6030afe4501', '57500', 'Biaya Pelaksanaan Program Kerjasama', 'dc16f8fe-a09e-4399-a227-7320a3f32feb', '3', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:05', '2026-07-07 03:40:05', NULL),
('c845664e-4939-4188-9b5a-177cd7bd5ed7', '41500', 'Dana Bantuan Organisasi Lainnya', '05b667e2-951b-4735-83e7-6761a059c2d4', '3', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('cbf1ae59-be94-468d-a0b1-14f125f5b831', '54200', 'Biaya Sidang Muswil/Muspimwil/Konsolidasi & Pembinaan AMM', '03ea188f-4a5a-49a1-a360-afbcee575894', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('cc07e75b-1119-4e8f-b7d1-f782842d1770', '58200', 'Dana Sehat Muhammadiyah', '5b11c6ca-5d87-4837-ad30-e91953c5a1a9', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:05', '2026-07-07 03:40:05', NULL),
('cc841ad2-0e5b-43f7-909e-d31ce5563706', '42400', 'Kontribusi Media', '0ba8ade3-8dc6-4ffb-89c7-50e579be3146', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('cda7e544-e669-4f9c-9b6f-f6ba07500cef', '12000', 'Aset Tidak Lancar', NULL, '1', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('ce1441a5-5f7e-46d7-8cc7-3f9bae862ae3', '22400', 'Hutang PPh Final', '06d411e4-689d-4f6d-bb2e-c9f44aeab33d', '2', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567891', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('cfe855aa-e85d-40f2-96a4-e34d46c904f3', '57207', 'Biaya Program Majelis Hukum dan HAM', '0dcf66b6-8ba6-40b3-89e7-282aa84c03e5', '4', '7', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('d40db36e-328b-43fd-ae0a-2fb09fcef5c2', '51000', 'Biaya Personalia', '931fa6b3-6053-4b8e-8f45-5dc87115dcb6', '2', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('d43c41c7-4cfa-42c7-81be-b99ca8e1621b', '52500', 'Biaya Pengiriman', 'd7d9901c-9785-4410-aae6-2c4236b5648d', '3', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('d650d3c0-ca9f-4587-9a11-cdfefa1e3115', '57700', 'Biaya Pembangunan ATC', 'dc16f8fe-a09e-4399-a227-7320a3f32feb', '3', '7', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:05', '2026-07-07 03:40:05', NULL),
('d7305d55-a17b-4f18-bb71-83e624522e8f', '41300', 'Zakat Infaq Shadaqoh Organisasi', '05b667e2-951b-4735-83e7-6761a059c2d4', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('d73463de-abb8-4e44-9f77-92d375acb1e8', '57204', 'Biaya Program Ekonomi dan Ketenagakerjaan', '0dcf66b6-8ba6-40b3-89e7-282aa84c03e5', '4', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('d7d9901c-9785-4410-aae6-2c4236b5648d', '52000', 'Biaya Tata Usaha Administrasi Kantor', '931fa6b3-6053-4b8e-8f45-5dc87115dcb6', '2', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('d96a0838-d30f-4e12-93a5-f61ee741d39d', '11810', 'PPN Masukan', 'bbca9830-3900-41a5-a233-774c581874e8', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('d9c57730-6928-4e5d-ac29-bf2f6dd9895f', '11100', 'Kas', '060c7786-2d80-4af6-a7f3-4d8dba51c049', '2', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:02', '2026-07-07 03:40:02', NULL),
('db8f505b-44a6-45f5-8d10-f8d15bea1af4', '31200', 'Modal Lancar', '99796640-5f95-4ad6-bf89-7121444ade40', '2', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567892', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('dc16f8fe-a09e-4399-a227-7320a3f32feb', '57000', 'Biaya Program Organisasi', '931fa6b3-6053-4b8e-8f45-5dc87115dcb6', '2', '7', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('dd9958f5-23ee-467f-be58-8bd553eceeac', '44003', 'Pendapatan Sewa ATC', '290bef48-1174-4bb0-8c01-0d5b17108128', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('dead6c90-51ca-4b56-b953-9ce8a362108f', '52700', 'Biaya Pemeliharaan Kendaraan', 'd7d9901c-9785-4410-aae6-2c4236b5648d', '3', '7', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('e2eda7c2-e10e-47e3-bb99-9a68bd2294cf', '52800', 'Biaya Asuransi kendaraan', 'd7d9901c-9785-4410-aae6-2c4236b5648d', '3', '8', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('e5032396-b524-43e4-aaf0-c8de44d4c99a', '57201', 'Biaya Program Majelis Tablig dan Ketarjihan', '0dcf66b6-8ba6-40b3-89e7-282aa84c03e5', '4', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:04', '2026-07-07 03:40:04', NULL),
('e8d6d3cc-494f-463d-a264-763e3e72c155', '11820', 'PPh Dibayar Dimuka', 'bbca9830-3900-41a5-a233-774c581874e8', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('f0ab0d30-708d-4536-b5c6-448b058d7a75', '44002', 'Kerjasama Eksternal', '290bef48-1174-4bb0-8c01-0d5b17108128', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('f415012f-1f66-4b77-a725-6682e2ffd02b', '22200', 'Hutang PPh 21', '06d411e4-689d-4f6d-bb2e-c9f44aeab33d', '2', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567891', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('f67c7605-fd55-4d04-8065-738b2feff09a', '11400', 'Piutang Lainnya', '060c7786-2d80-4af6-a7f3-4d8dba51c049', '2', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:02', '2026-07-07 03:40:02', NULL),
('f6c24672-0eeb-4f58-a71c-8f8bad115f5b', '41400', 'Muhammadiyah', '05b667e2-951b-4735-83e7-6761a059c2d4', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('f8832dae-00e3-4d46-9e05-991b3e02f16a', '12210', 'Akumulasi Depresiasi Gedung', '10af2cdc-0754-4d24-871d-46ad9bdb8f98', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'CREDIT', 1, NULL, '2026-07-07 03:40:03', '2026-07-07 03:40:03', NULL),
('fc646e17-8f59-466f-8bea-74a29c39bdad', '11120', 'Kas di Bank Jatim', 'd9c57730-6928-4e5d-ac29-bf2f6dd9895f', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:02', '2026-07-07 03:40:02', NULL),
('fee7e8c7-a5e4-4a0f-bf77-62db604ee500', '11200', 'Kas Bon', '060c7786-2d80-4af6-a7f3-4d8dba51c049', '2', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:02', '2026-07-07 03:40:02', NULL),
('ff336d58-31ed-49b6-8df8-6ea403800108', '11140', 'Kas di Bank Bukopin Syariah', 'd9c57730-6928-4e5d-ac29-bf2f6dd9895f', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-07-07 03:40:02', '2026-07-07 03:40:02', NULL);

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
('019f3c7d-fd7c-71d8-8cfa-4cd6dab87eda', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', 'd9c57730-6928-4e5d-ac29-bf2f6dd9895f', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 194604157.00, '2026-07-07 05:11:57', '2026-07-07 05:11:57'),
('019f3c7d-fd83-71f6-8f38-00d0cca94114', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', '7e3a051c-a73b-485c-865c-f7259792967d', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 4983047.00, '2026-07-07 05:11:57', '2026-07-07 05:11:57'),
('019f3c7d-fd88-7360-b5e6-82b1eedacf7a', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', 'fc646e17-8f59-466f-8bea-74a29c39bdad', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 385384747.00, '2026-07-07 05:11:57', '2026-07-07 05:11:57'),
('019f3c7d-fd8a-704e-8fec-7f4ee917e753', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', '80489af9-a27f-469d-aabb-16681c5cf916', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 1156982563.00, '2026-07-07 05:11:57', '2026-07-07 05:11:57'),
('019f3c7d-fd8c-73eb-bc46-e2279871686f', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', 'ff336d58-31ed-49b6-8df8-6ea403800108', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 377940865.00, '2026-07-07 05:11:57', '2026-07-07 05:11:57'),
('019f3c7d-fd8d-7164-9cd8-57e22ab5ad52', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', '700e4c22-26f3-43ce-8ef0-b32b8920e93c', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 1800000.00, '2026-07-07 05:11:57', '2026-07-07 05:11:57'),
('019f3c7d-fd8f-7306-99b5-8a837fd681eb', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', '6865e20e-43b2-48ce-b3a3-653078468886', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 245583300.00, '2026-07-07 05:11:57', '2026-07-07 05:11:57'),
('019f3c7d-fd90-7337-a1b6-86c71119f0a3', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', '27ef2784-5982-421c-bb3f-96a51777fbf3', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 676151976.00, '2026-07-07 05:11:57', '2026-07-07 05:11:57'),
('019f3c7d-fd92-737e-83e6-79a546a03ab9', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', '41fbc782-5794-409d-8507-f99fed76fe8b', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 460769432.00, '2026-07-07 05:11:57', '2026-07-07 05:11:57'),
('019f3c7d-fd93-704a-87b5-2d0c8a717abb', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', '225f7e5c-8132-4aff-bccd-9c1e07ebc65f', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 15500000.00, '2026-07-07 05:11:57', '2026-07-07 05:11:57'),
('019f3c7d-fd95-73fa-b8d9-32b55fd17fe4', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', '44fb2678-eb3c-4af8-88ea-e9654dcc88ac', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 46059000.00, '2026-07-07 05:11:57', '2026-07-07 05:11:57'),
('019f3c7d-fd96-71e9-a565-e564404486f4', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', '92aa553e-6ee4-48e9-a7f7-02acaba8ecd0', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'CREDIT', 144000000.00, '2026-07-07 05:11:57', '2026-07-07 05:11:57'),
('019f3c7d-fd98-738b-9cad-23fa603cbb3c', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', '7fecbf43-5f25-49e8-8068-a4aed1808cd4', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'CREDIT', 13376668.00, '2026-07-07 05:11:57', '2026-07-07 05:11:57'),
('019f3c7d-fd99-7052-afed-cf689d507310', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', 'bed710fe-7648-4fe7-9b9b-b1f2f960cee7', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'CREDIT', 25236667.00, '2026-07-07 05:11:57', '2026-07-07 05:11:57'),
('019f3c7d-fd9a-72ac-a08e-69de9000c414', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', '3fab3482-9af2-4d47-92f0-b6a42980348c', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'CREDIT', 339715097.00, '2026-07-07 05:11:57', '2026-07-07 05:11:57'),
('019f3c7d-fd9c-7121-85ce-6f0da8b41ba6', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', 'db8f505b-44a6-45f5-8d10-f8d15bea1af4', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'CREDIT', 368679944.00, '2026-07-07 05:11:57', '2026-07-07 05:11:57'),
('019f3c7d-fd9d-7371-83c1-51b73b1e7b0f', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', '34946f7c-6f05-4bb7-ba94-01afba90ff43', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'CREDIT', 2674750712.00, '2026-07-07 05:11:57', '2026-07-07 05:11:57');

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
('019f3c36-991d-7337-9ba8-4382cf490412', 'd9c57730-6928-4e5d-ac29-bf2f6dd9895f', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', 194604157.00, 0.00, 0.00, 194604157.00, '2026-07-07 03:53:58', NULL, '2026-07-07 03:53:58', '2026-07-07 03:53:58'),
('019f3c38-370f-727e-8e18-f10583035e1a', '7e3a051c-a73b-485c-865c-f7259792967d', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', 4983047.00, 0.00, 0.00, 4983047.00, '2026-07-07 03:55:44', NULL, '2026-07-07 03:55:44', '2026-07-07 03:55:44'),
('019f3c38-b220-73a9-a6e0-bf4d57bd92e3', 'fc646e17-8f59-466f-8bea-74a29c39bdad', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', 385384747.00, 0.00, 0.00, 385384747.00, '2026-07-07 03:56:16', NULL, '2026-07-07 03:56:16', '2026-07-07 03:56:16'),
('019f3c39-5ff3-72a1-a97e-4e0e40f66193', '80489af9-a27f-469d-aabb-16681c5cf916', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', 1156982563.00, 0.00, 0.00, 1156982563.00, '2026-07-07 03:57:00', NULL, '2026-07-07 03:57:00', '2026-07-07 03:57:00'),
('019f3c39-b839-7063-8b30-05179204b11e', 'ff336d58-31ed-49b6-8df8-6ea403800108', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', 377940865.00, 0.00, 0.00, 377940865.00, '2026-07-07 03:57:23', NULL, '2026-07-07 03:57:23', '2026-07-07 03:57:23'),
('019f3c3a-190a-73d4-ae0b-131ddb79d0cf', '700e4c22-26f3-43ce-8ef0-b32b8920e93c', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', 1800000.00, 0.00, 0.00, 1800000.00, '2026-07-07 03:57:48', NULL, '2026-07-07 03:57:48', '2026-07-07 03:57:48'),
('019f3c3a-7620-736a-9fb3-cd239b8385e0', '6865e20e-43b2-48ce-b3a3-653078468886', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', 245583300.00, 0.00, 0.00, 245583300.00, '2026-07-07 03:58:12', NULL, '2026-07-07 03:58:12', '2026-07-07 03:58:12'),
('019f3c3a-d984-707a-8b8f-93c10423cecd', '27ef2784-5982-421c-bb3f-96a51777fbf3', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', 676151976.00, 0.00, 0.00, 676151976.00, '2026-07-07 03:58:37', NULL, '2026-07-07 03:58:37', '2026-07-07 03:58:37'),
('019f3c3e-34b9-71fc-a687-f015c6cccf8a', '41fbc782-5794-409d-8507-f99fed76fe8b', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', 460769432.00, 0.00, 0.00, 460769432.00, '2026-07-07 04:02:17', NULL, '2026-07-07 04:02:17', '2026-07-07 04:02:17'),
('019f3c40-cdcd-7297-bc07-fdc2961f1316', '225f7e5c-8132-4aff-bccd-9c1e07ebc65f', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', 15500000.00, 0.00, 0.00, 15500000.00, '2026-07-07 04:05:07', NULL, '2026-07-07 04:05:07', '2026-07-07 04:05:07'),
('019f3c41-4cd8-7355-a444-ef7b20030674', '44fb2678-eb3c-4af8-88ea-e9654dcc88ac', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', 46059000.00, 0.00, 0.00, 46059000.00, '2026-07-07 04:05:40', NULL, '2026-07-07 04:05:40', '2026-07-07 04:05:40'),
('019f3c76-db6f-709c-9633-96120a81707a', '92aa553e-6ee4-48e9-a7f7-02acaba8ecd0', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', 144000000.00, 0.00, 0.00, 144000000.00, '2026-07-07 05:04:10', NULL, '2026-07-07 05:04:10', '2026-07-07 05:04:10'),
('019f3c77-77df-7379-8556-1adadfb30e1c', '7fecbf43-5f25-49e8-8068-a4aed1808cd4', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', 13376668.00, 0.00, 0.00, 13376668.00, '2026-07-07 05:04:50', NULL, '2026-07-07 05:04:50', '2026-07-07 05:04:50'),
('019f3c77-e8d8-7345-889f-ceafdddee745', 'bed710fe-7648-4fe7-9b9b-b1f2f960cee7', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', 25236667.00, 0.00, 0.00, 25236667.00, '2026-07-07 05:05:19', NULL, '2026-07-07 05:05:19', '2026-07-07 05:05:19'),
('019f3c78-c4e7-72f4-9ee3-a09eeaf376db', '3fab3482-9af2-4d47-92f0-b6a42980348c', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', 339715097.00, 0.00, 0.00, 339715097.00, '2026-07-07 05:06:15', NULL, '2026-07-07 05:06:15', '2026-07-07 05:06:15'),
('019f3c79-6c5f-7158-a589-85be7fc1da36', 'db8f505b-44a6-45f5-8d10-f8d15bea1af4', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', 368679944.00, 0.00, 0.00, 368679944.00, '2026-07-07 05:06:58', NULL, '2026-07-07 05:06:58', '2026-07-07 05:06:58'),
('019f3c7c-2030-70fd-bbed-af36d952fc25', '34946f7c-6f05-4bb7-ba94-01afba90ff43', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', 2674750712.00, 0.00, 0.00, 2674750712.00, '2026-07-07 05:09:55', NULL, '2026-07-07 05:09:55', '2026-07-07 05:09:55'),
('019f3fe9-9ce2-7338-8789-8bebd0eb0556', 'd9c57730-6928-4e5d-ac29-bf2f6dd9895f', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', 194604157.00, 0.00, 0.00, 194604157.00, '2026-07-07 21:08:22', NULL, '2026-07-07 21:08:22', '2026-07-07 21:08:22'),
('019f3fe9-ece0-702f-ad68-9b8621e61167', '7e3a051c-a73b-485c-865c-f7259792967d', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', 4983047.00, 0.00, 0.00, 4983047.00, '2026-07-07 21:08:42', NULL, '2026-07-07 21:08:42', '2026-07-07 21:08:42'),
('019f3fea-3f1e-728c-996a-83c3007fa359', 'fc646e17-8f59-466f-8bea-74a29c39bdad', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', 385384747.00, 0.00, 0.00, 385384747.00, '2026-07-07 21:09:04', NULL, '2026-07-07 21:09:04', '2026-07-07 21:09:04'),
('019f3fea-80df-7366-8493-f35f199a09be', '80489af9-a27f-469d-aabb-16681c5cf916', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', 1156982563.00, 0.00, 0.00, 1156982563.00, '2026-07-07 21:09:20', NULL, '2026-07-07 21:09:20', '2026-07-07 21:09:20'),
('019f3fea-ded8-737b-bb62-93092f5358e5', 'ff336d58-31ed-49b6-8df8-6ea403800108', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', 377940865.00, 0.00, 0.00, 377940865.00, '2026-07-07 21:09:44', NULL, '2026-07-07 21:09:44', '2026-07-07 21:09:44'),
('019f3feb-16b8-7044-8897-cf2f9356100a', '700e4c22-26f3-43ce-8ef0-b32b8920e93c', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', 1800000.00, 0.00, 0.00, 1800000.00, '2026-07-07 21:09:59', NULL, '2026-07-07 21:09:59', '2026-07-07 21:09:59'),
('019f3feb-e8b4-713e-9fd2-ae086cfbaebf', 'f67c7605-fd55-4d04-8065-738b2feff09a', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', 921735276.00, 0.00, 0.00, 921735276.00, '2026-07-07 21:10:52', NULL, '2026-07-07 21:10:52', '2026-07-07 21:10:52'),
('019f3fec-d3d2-7256-b4d4-f11188ac9e93', '41fbc782-5794-409d-8507-f99fed76fe8b', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', 460769432.00, 0.00, 0.00, 460769432.00, '2026-07-07 21:11:53', NULL, '2026-07-07 21:11:53', '2026-07-07 21:11:53'),
('019f3fed-2089-71c4-b292-370ad78eeda7', '92aa553e-6ee4-48e9-a7f7-02acaba8ecd0', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', 144000000.00, 0.00, 0.00, 144000000.00, '2026-07-07 21:12:12', NULL, '2026-07-07 21:12:12', '2026-07-07 21:12:12'),
('019f3fed-5b95-7218-9bdc-295171018889', '225f7e5c-8132-4aff-bccd-9c1e07ebc65f', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', 15500000.00, 0.00, 0.00, 15500000.00, '2026-07-07 21:12:27', NULL, '2026-07-07 21:12:27', '2026-07-07 21:12:27'),
('019f3fed-a262-72cb-accb-8d74a031ce10', '7fecbf43-5f25-49e8-8068-a4aed1808cd4', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', 13376668.00, 0.00, 0.00, 13376668.00, '2026-07-07 21:12:46', NULL, '2026-07-07 21:12:46', '2026-07-07 21:12:46'),
('019f3fed-e8c0-7365-a2f7-473b78e81cf9', '44fb2678-eb3c-4af8-88ea-e9654dcc88ac', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', 46059000.00, 0.00, 0.00, 46059000.00, '2026-07-07 21:13:04', NULL, '2026-07-07 21:13:04', '2026-07-07 21:13:04'),
('019f3fee-382c-72bf-b0fa-3c986be0f0f6', 'bed710fe-7648-4fe7-9b9b-b1f2f960cee7', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', 25236667.00, 0.00, 0.00, 25236667.00, '2026-07-07 21:13:24', NULL, '2026-07-07 21:13:24', '2026-07-07 21:13:24'),
('019f3fef-10ba-7198-8433-dec76c25580d', '3fab3482-9af2-4d47-92f0-b6a42980348c', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', 339715097.00, 0.00, 0.00, 339715097.00, '2026-07-07 21:14:19', NULL, '2026-07-07 21:14:19', '2026-07-07 21:14:19'),
('019f3fef-54ee-7201-ba5c-3a4b4482b20c', 'db8f505b-44a6-45f5-8d10-f8d15bea1af4', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', 368679944.00, 0.00, 0.00, 368679944.00, '2026-07-07 21:14:37', NULL, '2026-07-07 21:14:37', '2026-07-07 21:14:37'),
('019f3fef-8fe3-72dd-88aa-7a76ecb0472a', '34946f7c-6f05-4bb7-ba94-01afba90ff43', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', 2674750712.00, 0.00, 0.00, 2674750712.00, '2026-07-07 21:14:52', NULL, '2026-07-07 21:14:52', '2026-07-07 21:14:52');

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
('019f3c29-c4a9-7023-a558-9a46bf89b81c', 'APP_NAME', 'My Laravel App', 'string', 'Nama aplikasi yang akan ditampilkan di berbagai tempat seperti judul halaman.', 1, '2026-07-07 03:39:58', '2026-07-07 03:39:58'),
('019f3c29-c4c4-701d-a6ed-0dacd6991cc0', 'APP_DESCRIPTION', 'Sistem Informasi Akuntansi untuk pengelolaan keuangan, jurnal, dan laporan secara terintegrasi.', 'string', 'Deskripsi singkat tentang aplikasi yang dapat digunakan untuk SEO atau ditampilkan di halaman utama.', 1, '2026-07-07 03:39:58', '2026-07-07 03:39:58'),
('019f3c29-c4d8-7300-b156-64b457c77540', 'APP_TAGLINE', 'Sistem Informasi Akuntansi untuk pengelolaan keuangan, jurnal, dan laporan secara terintegrasi.', 'string', 'Tagline atau slogan yang menggambarkan nilai utama aplikasi.', 1, '2026-07-07 03:39:58', '2026-07-07 03:39:58'),
('019f3c29-c4ec-710c-80f2-a7a91e5c3581', 'APP_LOGO', NULL, 'image', 'Logo aplikasi yang akan ditampilkan di header atau halaman login.', 1, '2026-07-07 03:39:58', '2026-07-07 03:39:58'),
('019f3c29-c4ff-708a-8089-da2b280c8699', 'APP_BACKGROUND_LOGIN', NULL, 'image', 'Gambar latar belakang untuk halaman login aplikasi.', 1, '2026-07-07 03:39:58', '2026-07-07 03:39:58');

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
(19, '2026_05_25_061327_create_user_account_balances_table', 1),
(20, '2026_05_26_175556_create_activity_logs_table', 1),
(21, '2026_06_01_082259_create_coa_requests_table', 1),
(22, '2026_06_04_180354_create_balance_requests_table', 1),
(23, '2026_06_11_085417_create_configurations_table', 1),
(24, '2026_06_21_081023_create_account_topups_table', 1);

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
('019f3c29-c992-73be-b23b-25b0c16f4407', 'App\\Models\\User', '019f3c29-d287-707a-8a4d-25d249fe7e86'),
('019f3c29-cc6b-70b0-b5f3-b0a2b8eb5788', 'App\\Models\\User', '019f3c29-d401-730d-a58f-9fac0918ea2c'),
('019f3c29-cee7-71a6-8e16-6cd4d9f537d3', 'App\\Models\\User', '019f3c29-d401-730d-a58f-9fac0918ea2c'),
('019f3c29-cee7-71a6-8e16-6cd4d9f537d3', 'App\\Models\\User', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5');

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
('019f3c36-9917-713e-b2d1-f102488f1700', 'd9c57730-6928-4e5d-ac29-bf2f6dd9895f', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 194604157.00, 0, NULL, '2026-07-07 03:53:58', '2026-07-07 03:53:58'),
('019f3c38-3706-70a7-acc6-1bca6955199c', '7e3a051c-a73b-485c-865c-f7259792967d', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 4983047.00, 0, NULL, '2026-07-07 03:55:44', '2026-07-07 03:55:44'),
('019f3c38-b21b-7163-abfc-595d64f0261e', 'fc646e17-8f59-466f-8bea-74a29c39bdad', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 385384747.00, 0, NULL, '2026-07-07 03:56:16', '2026-07-07 03:56:16'),
('019f3c39-5fec-7243-90b4-2a34fd440fe5', '80489af9-a27f-469d-aabb-16681c5cf916', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 1156982563.00, 0, NULL, '2026-07-07 03:57:00', '2026-07-07 03:57:00'),
('019f3c39-b833-73c2-b107-b4fb67a74610', 'ff336d58-31ed-49b6-8df8-6ea403800108', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 377940865.00, 0, NULL, '2026-07-07 03:57:23', '2026-07-07 03:57:23'),
('019f3c3a-1905-71e9-b640-92c88e6b6652', '700e4c22-26f3-43ce-8ef0-b32b8920e93c', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 1800000.00, 0, NULL, '2026-07-07 03:57:48', '2026-07-07 03:57:48'),
('019f3c3a-761b-717d-9989-402153655555', '6865e20e-43b2-48ce-b3a3-653078468886', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 245583300.00, 0, NULL, '2026-07-07 03:58:12', '2026-07-07 03:58:12'),
('019f3c3a-d97d-72a0-9fa4-b7bd13f25342', '27ef2784-5982-421c-bb3f-96a51777fbf3', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 676151976.00, 0, NULL, '2026-07-07 03:58:37', '2026-07-07 03:58:37'),
('019f3c3e-34b1-73ed-931d-46340e0f427e', '41fbc782-5794-409d-8507-f99fed76fe8b', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 460769432.00, 0, NULL, '2026-07-07 04:02:17', '2026-07-07 04:02:17'),
('019f3c40-cdc7-7103-a103-6df909c8e1d9', '225f7e5c-8132-4aff-bccd-9c1e07ebc65f', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 15500000.00, 0, NULL, '2026-07-07 04:05:07', '2026-07-07 04:05:07'),
('019f3c41-4cd0-72f6-acef-b16cc707c4eb', '44fb2678-eb3c-4af8-88ea-e9654dcc88ac', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 46059000.00, 0, NULL, '2026-07-07 04:05:40', '2026-07-07 04:05:40'),
('019f3c76-db68-7277-b74a-d1d19a844b80', '92aa553e-6ee4-48e9-a7f7-02acaba8ecd0', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'CREDIT', 144000000.00, 0, NULL, '2026-07-07 05:04:10', '2026-07-07 05:04:10'),
('019f3c77-77d7-73cb-b2f3-ac0195e13a7f', '7fecbf43-5f25-49e8-8068-a4aed1808cd4', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'CREDIT', 13376668.00, 0, NULL, '2026-07-07 05:04:50', '2026-07-07 05:04:50'),
('019f3c77-e8d2-72e0-9725-314235b613e2', 'bed710fe-7648-4fe7-9b9b-b1f2f960cee7', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'CREDIT', 25236667.00, 0, NULL, '2026-07-07 05:05:19', '2026-07-07 05:05:19'),
('019f3c78-c4e1-7035-be34-b618c678afe4', '3fab3482-9af2-4d47-92f0-b6a42980348c', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 339715097.00, 0, NULL, '2026-07-07 05:06:15', '2026-07-07 05:06:15'),
('019f3c79-6c59-72a2-b480-ed9c3045acfa', 'db8f505b-44a6-45f5-8d10-f8d15bea1af4', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 368679944.00, 0, NULL, '2026-07-07 05:06:58', '2026-07-07 05:06:58'),
('019f3c7c-202a-71f9-b517-634cea2a64f1', '34946f7c-6f05-4bb7-ba94-01afba90ff43', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 2674750712.00, 0, NULL, '2026-07-07 05:09:55', '2026-07-07 05:09:55'),
('019f3fe9-9cd8-7303-a064-f16742d22de3', 'd9c57730-6928-4e5d-ac29-bf2f6dd9895f', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 194604157.00, 0, NULL, '2026-07-07 21:08:22', '2026-07-07 21:08:22'),
('019f3fe9-ecda-70f1-b736-aafa597a64dd', '7e3a051c-a73b-485c-865c-f7259792967d', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 4983047.00, 0, NULL, '2026-07-07 21:08:42', '2026-07-07 21:08:42'),
('019f3fea-3f18-73f4-85b1-7b444d1b63c8', 'fc646e17-8f59-466f-8bea-74a29c39bdad', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 385384747.00, 0, NULL, '2026-07-07 21:09:04', '2026-07-07 21:09:04'),
('019f3fea-80d9-7262-a0eb-42258509392b', '80489af9-a27f-469d-aabb-16681c5cf916', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 1156982563.00, 0, NULL, '2026-07-07 21:09:20', '2026-07-07 21:09:20'),
('019f3fea-ded1-723e-8e52-6018681a16de', 'ff336d58-31ed-49b6-8df8-6ea403800108', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 377940865.00, 0, NULL, '2026-07-07 21:09:44', '2026-07-07 21:09:44'),
('019f3feb-16b3-7388-a5d9-311b693b8ffe', '700e4c22-26f3-43ce-8ef0-b32b8920e93c', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 1800000.00, 0, NULL, '2026-07-07 21:09:59', '2026-07-07 21:09:59'),
('019f3feb-e8ae-70e5-ad6c-4539936328c8', 'f67c7605-fd55-4d04-8065-738b2feff09a', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 921735276.00, 0, NULL, '2026-07-07 21:10:52', '2026-07-07 21:10:52'),
('019f3fec-d3cd-70e1-b374-632be38f1f6d', '41fbc782-5794-409d-8507-f99fed76fe8b', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 460769432.00, 0, NULL, '2026-07-07 21:11:53', '2026-07-07 21:11:53'),
('019f3fed-2082-7041-a68c-182db12d82ee', '92aa553e-6ee4-48e9-a7f7-02acaba8ecd0', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'CREDIT', 144000000.00, 0, NULL, '2026-07-07 21:12:12', '2026-07-07 21:12:12'),
('019f3fed-5b8d-73ba-aedc-4792f52f9c91', '225f7e5c-8132-4aff-bccd-9c1e07ebc65f', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 15500000.00, 0, NULL, '2026-07-07 21:12:27', '2026-07-07 21:12:27'),
('019f3fed-a259-73df-92bc-36d1744b1f91', '7fecbf43-5f25-49e8-8068-a4aed1808cd4', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'CREDIT', 13376668.00, 0, NULL, '2026-07-07 21:12:46', '2026-07-07 21:12:46'),
('019f3fed-e8b8-73d6-babe-b3daae05af22', '44fb2678-eb3c-4af8-88ea-e9654dcc88ac', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'DEBIT', 46059000.00, 0, NULL, '2026-07-07 21:13:04', '2026-07-07 21:13:04'),
('019f3fee-3823-737f-8647-ca186fbad10b', 'bed710fe-7648-4fe7-9b9b-b1f2f960cee7', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'CREDIT', 25236667.00, 0, NULL, '2026-07-07 21:13:24', '2026-07-07 21:13:24'),
('019f3fef-10b4-72e1-8e2e-8e4faa2be8dc', '3fab3482-9af2-4d47-92f0-b6a42980348c', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'CREDIT', 339715097.00, 0, NULL, '2026-07-07 21:14:19', '2026-07-07 21:14:19'),
('019f3fef-54e3-732d-9faf-f091b0b9ffc2', 'db8f505b-44a6-45f5-8d10-f8d15bea1af4', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'CREDIT', 368679944.00, 0, NULL, '2026-07-07 21:14:37', '2026-07-07 21:14:37'),
('019f3fef-8fde-7233-9c46-b8b686a0f2a7', '34946f7c-6f05-4bb7-ba94-01afba90ff43', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'CREDIT', 2674750712.00, 0, NULL, '2026-07-07 21:14:52', '2026-07-07 21:14:52');

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
('019f3c35-09b8-737c-8683-733385ec91c9', '2022', 'Tahun 2022', '2022-01-01', '2022-12-31', '2026-07-07 03:52:16', '2026-07-07 03:52:16'),
('019f3c7f-83a5-7303-bcaa-a3e095677c5f', '2023', 'Tahun 2023', '2023-01-01', '2023-12-31', '2026-07-07 05:13:37', '2026-07-07 05:13:37');

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
('019f3c29-c55d-7145-8adb-3c286964c188', 'view dashboard superadmin', 'web', 'Dashboard', 'Akses dashboard superadmin', 1, '2026-07-07 03:39:58', '2026-07-07 03:39:58'),
('019f3c29-c581-73a0-a557-4e3225d6ea2e', 'view dashboard bendahara', 'web', 'Dashboard', 'Akses dashboard bendahara', 1, '2026-07-07 03:39:58', '2026-07-07 03:39:58'),
('019f3c29-c5a0-73cd-a404-3b3193a441a8', 'user view', 'web', 'User Management', 'Melihat data user', 1, '2026-07-07 03:39:58', '2026-07-07 03:39:58'),
('019f3c29-c5bd-7222-ba36-887d065c473e', 'user create', 'web', 'User Management', 'Membuat user baru', 1, '2026-07-07 03:39:58', '2026-07-07 03:39:58'),
('019f3c29-c5dc-72ac-9a60-16afc140963f', 'user update', 'web', 'User Management', 'Mengubah data user', 1, '2026-07-07 03:39:58', '2026-07-07 03:39:58'),
('019f3c29-c5fa-73ae-a1f9-d277b64eeea5', 'user delete', 'web', 'User Management', 'Menghapus user', 1, '2026-07-07 03:39:58', '2026-07-07 03:39:58'),
('019f3c29-c616-7391-8c89-24d01e61c970', 'role view', 'web', 'Role & Permission', 'Melihat role', 1, '2026-07-07 03:39:58', '2026-07-07 03:39:58'),
('019f3c29-c632-70ca-af2b-26e6783fa631', 'role create', 'web', 'Role & Permission', 'Membuat role', 1, '2026-07-07 03:39:58', '2026-07-07 03:39:58'),
('019f3c29-c64e-73c8-98b3-25858005dee8', 'role update', 'web', 'Role & Permission', 'Mengubah role', 1, '2026-07-07 03:39:58', '2026-07-07 03:39:58'),
('019f3c29-c66a-71db-b9f5-891345cd5d3b', 'role delete', 'web', 'Role & Permission', 'Menghapus role', 1, '2026-07-07 03:39:58', '2026-07-07 03:39:58'),
('019f3c29-c685-71de-9ee4-be7dc2c48b02', 'permission view', 'web', 'Role & Permission', 'Melihat permission', 1, '2026-07-07 03:39:58', '2026-07-07 03:39:58'),
('019f3c29-c6a1-730b-8638-776453be8d66', 'permission create', 'web', 'Role & Permission', 'Membuat permission', 1, '2026-07-07 03:39:58', '2026-07-07 03:39:58'),
('019f3c29-c6bd-726d-b2b6-e3d08840d098', 'permission update', 'web', 'Role & Permission', 'Mengubah permission', 1, '2026-07-07 03:39:58', '2026-07-07 03:39:58'),
('019f3c29-c6db-72ad-ae77-562e71a45fc0', 'permission delete', 'web', 'Role & Permission', 'Menghapus permission', 1, '2026-07-07 03:39:58', '2026-07-07 03:39:58'),
('019f3c29-c6f8-7299-8385-abd2b0d3009e', 'coa view', 'web', 'Master COA', 'Melihat chart of account', 1, '2026-07-07 03:39:58', '2026-07-07 03:39:58'),
('019f3c29-c714-72ac-91f3-145594fc8004', 'coa create', 'web', 'Master COA', 'Membuat akun COA', 1, '2026-07-07 03:39:58', '2026-07-07 03:39:58'),
('019f3c29-c737-71a1-9d4b-f398a889135c', 'coa update', 'web', 'Master COA', 'Mengubah akun COA', 1, '2026-07-07 03:39:58', '2026-07-07 03:39:58'),
('019f3c29-c75a-720e-93be-b53664262a4b', 'coa delete', 'web', 'Master COA', 'Menghapus akun COA', 1, '2026-07-07 03:39:58', '2026-07-07 03:39:58'),
('019f3c29-c777-73d3-89e4-20a836457812', 'coa import', 'web', 'Master COA', 'Import akun COA', 0, '2026-07-07 03:39:58', '2026-07-07 03:39:58'),
('019f3c29-c793-7114-8040-b7a8331a545d', 'coa assign user', 'web', 'Master COA', 'Menambahkan user ke COA', 0, '2026-07-07 03:39:58', '2026-07-07 03:39:58'),
('019f3c29-c7b0-7270-81cf-181cbb31da88', 'coa remove user', 'web', 'Master COA', 'Menghapus user dari COA', 0, '2026-07-07 03:39:58', '2026-07-07 03:39:58'),
('019f3c29-c7d0-7289-abeb-8d5e04d03f39', 'coa request create', 'web', 'Master COA', 'Request pembuatan akun COA', 0, '2026-07-07 03:39:58', '2026-07-07 03:39:58'),
('019f3c29-c7ef-71cf-b1c3-4834eaa7ef02', 'journal post', 'web', 'Transactions', 'Posting jurnal umum', 1, '2026-07-07 03:39:58', '2026-07-07 03:39:58'),
('019f3c29-c80d-72a4-838d-8d160a8d56b2', 'journal view', 'web', 'Transactions', 'Melihat jurnal umum', 1, '2026-07-07 03:39:58', '2026-07-07 03:39:58'),
('019f3c29-c82a-7114-8c48-b355b37a4854', 'transaction income create', 'web', 'Transactions', 'Input transaksi pemasukan', 1, '2026-07-07 03:39:59', '2026-07-07 03:39:59'),
('019f3c29-c847-73d6-a96e-9fc65d6079a8', 'transaction expense create', 'web', 'Transactions', 'Input transaksi pengeluaran', 1, '2026-07-07 03:39:59', '2026-07-07 03:39:59'),
('019f3c29-c863-70c3-a5a3-23aac82293b3', 'transaction import', 'web', 'Transactions', 'Import transaksi', 0, '2026-07-07 03:39:59', '2026-07-07 03:39:59'),
('019f3c29-c884-720a-8159-5e239072caee', 'ledger create', 'web', 'Ledger', 'Generate buku besar', 1, '2026-07-07 03:39:59', '2026-07-07 03:39:59'),
('019f3c29-c8a0-713e-832b-75596fc20b8a', 'ledger view', 'web', 'Ledger', 'Melihat buku besar', 1, '2026-07-07 03:39:59', '2026-07-07 03:39:59'),
('019f3c29-c8bd-7391-814d-8db147066dd8', 'ledger view by account', 'web', 'Ledger', 'Melihat buku besar per akun', 1, '2026-07-07 03:39:59', '2026-07-07 03:39:59'),
('019f3c29-c8da-71d5-872a-1ee4f81b3aa8', 'report general journal view', 'web', 'Reports', 'Melihat laporan jurnal umum', 1, '2026-07-07 03:39:59', '2026-07-07 03:39:59'),
('019f3c29-c8f7-7216-b679-d3886ac79aa8', 'report general journal export', 'web', 'Reports', 'Export laporan jurnal umum', 0, '2026-07-07 03:39:59', '2026-07-07 03:39:59'),
('019f3c29-c913-7164-ba09-753594a3cc08', 'report trial balance view', 'web', 'Reports', 'Melihat neraca saldo', 1, '2026-07-07 03:39:59', '2026-07-07 03:39:59'),
('019f3c29-c930-7039-a591-5f3cc0cd4f59', 'report trial balance export', 'web', 'Reports', 'Export neraca saldo', 0, '2026-07-07 03:39:59', '2026-07-07 03:39:59'),
('019f3c29-c94c-70ad-908b-1a15c3436989', 'report ledger view', 'web', 'Reports', 'Melihat laporan buku besar', 1, '2026-07-07 03:39:59', '2026-07-07 03:39:59'),
('019f3c29-c969-70c2-88e4-3aa2f0c441b5', 'report ledger export', 'web', 'Reports', 'Export laporan buku besar', 0, '2026-07-07 03:39:59', '2026-07-07 03:39:59');

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
('019f3c29-c992-73be-b23b-25b0c16f4407', 'SUPER ADMIN', 'web', '2026-07-07 03:39:59', '2026-07-07 03:39:59'),
('019f3c29-cc6b-70b0-b5f3-b0a2b8eb5788', 'BENDAHARA', 'web', '2026-07-07 03:40:00', '2026-07-07 03:40:00'),
('019f3c29-cee7-71a6-8e16-6cd4d9f537d3', 'ACCOUNTING USER', 'web', '2026-07-07 03:40:00', '2026-07-07 03:40:00');

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
('019f3c29-c55d-7145-8adb-3c286964c188', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c581-73a0-a557-4e3225d6ea2e', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c581-73a0-a557-4e3225d6ea2e', '019f3c29-cc6b-70b0-b5f3-b0a2b8eb5788'),
('019f3c29-c5a0-73cd-a404-3b3193a441a8', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c5bd-7222-ba36-887d065c473e', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c5dc-72ac-9a60-16afc140963f', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c5fa-73ae-a1f9-d277b64eeea5', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c616-7391-8c89-24d01e61c970', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c632-70ca-af2b-26e6783fa631', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c64e-73c8-98b3-25858005dee8', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c66a-71db-b9f5-891345cd5d3b', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c685-71de-9ee4-be7dc2c48b02', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c6a1-730b-8638-776453be8d66', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c6bd-726d-b2b6-e3d08840d098', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c6db-72ad-ae77-562e71a45fc0', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c6f8-7299-8385-abd2b0d3009e', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c6f8-7299-8385-abd2b0d3009e', '019f3c29-cc6b-70b0-b5f3-b0a2b8eb5788'),
('019f3c29-c6f8-7299-8385-abd2b0d3009e', '019f3c29-cee7-71a6-8e16-6cd4d9f537d3'),
('019f3c29-c714-72ac-91f3-145594fc8004', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c714-72ac-91f3-145594fc8004', '019f3c29-cc6b-70b0-b5f3-b0a2b8eb5788'),
('019f3c29-c737-71a1-9d4b-f398a889135c', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c737-71a1-9d4b-f398a889135c', '019f3c29-cc6b-70b0-b5f3-b0a2b8eb5788'),
('019f3c29-c75a-720e-93be-b53664262a4b', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c75a-720e-93be-b53664262a4b', '019f3c29-cc6b-70b0-b5f3-b0a2b8eb5788'),
('019f3c29-c777-73d3-89e4-20a836457812', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c777-73d3-89e4-20a836457812', '019f3c29-cc6b-70b0-b5f3-b0a2b8eb5788'),
('019f3c29-c793-7114-8040-b7a8331a545d', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c793-7114-8040-b7a8331a545d', '019f3c29-cc6b-70b0-b5f3-b0a2b8eb5788'),
('019f3c29-c7b0-7270-81cf-181cbb31da88', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c7b0-7270-81cf-181cbb31da88', '019f3c29-cc6b-70b0-b5f3-b0a2b8eb5788'),
('019f3c29-c7d0-7289-abeb-8d5e04d03f39', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c7d0-7289-abeb-8d5e04d03f39', '019f3c29-cee7-71a6-8e16-6cd4d9f537d3'),
('019f3c29-c7ef-71cf-b1c3-4834eaa7ef02', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c7ef-71cf-b1c3-4834eaa7ef02', '019f3c29-cc6b-70b0-b5f3-b0a2b8eb5788'),
('019f3c29-c80d-72a4-838d-8d160a8d56b2', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c80d-72a4-838d-8d160a8d56b2', '019f3c29-cc6b-70b0-b5f3-b0a2b8eb5788'),
('019f3c29-c80d-72a4-838d-8d160a8d56b2', '019f3c29-cee7-71a6-8e16-6cd4d9f537d3'),
('019f3c29-c82a-7114-8c48-b355b37a4854', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c82a-7114-8c48-b355b37a4854', '019f3c29-cee7-71a6-8e16-6cd4d9f537d3'),
('019f3c29-c847-73d6-a96e-9fc65d6079a8', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c847-73d6-a96e-9fc65d6079a8', '019f3c29-cee7-71a6-8e16-6cd4d9f537d3'),
('019f3c29-c863-70c3-a5a3-23aac82293b3', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c863-70c3-a5a3-23aac82293b3', '019f3c29-cee7-71a6-8e16-6cd4d9f537d3'),
('019f3c29-c884-720a-8159-5e239072caee', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c884-720a-8159-5e239072caee', '019f3c29-cc6b-70b0-b5f3-b0a2b8eb5788'),
('019f3c29-c8a0-713e-832b-75596fc20b8a', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c8a0-713e-832b-75596fc20b8a', '019f3c29-cc6b-70b0-b5f3-b0a2b8eb5788'),
('019f3c29-c8bd-7391-814d-8db147066dd8', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c8bd-7391-814d-8db147066dd8', '019f3c29-cee7-71a6-8e16-6cd4d9f537d3'),
('019f3c29-c8da-71d5-872a-1ee4f81b3aa8', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c8da-71d5-872a-1ee4f81b3aa8', '019f3c29-cc6b-70b0-b5f3-b0a2b8eb5788'),
('019f3c29-c8f7-7216-b679-d3886ac79aa8', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c8f7-7216-b679-d3886ac79aa8', '019f3c29-cc6b-70b0-b5f3-b0a2b8eb5788'),
('019f3c29-c913-7164-ba09-753594a3cc08', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c913-7164-ba09-753594a3cc08', '019f3c29-cc6b-70b0-b5f3-b0a2b8eb5788'),
('019f3c29-c930-7039-a591-5f3cc0cd4f59', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c930-7039-a591-5f3cc0cd4f59', '019f3c29-cc6b-70b0-b5f3-b0a2b8eb5788'),
('019f3c29-c94c-70ad-908b-1a15c3436989', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c94c-70ad-908b-1a15c3436989', '019f3c29-cc6b-70b0-b5f3-b0a2b8eb5788'),
('019f3c29-c94c-70ad-908b-1a15c3436989', '019f3c29-cee7-71a6-8e16-6cd4d9f537d3'),
('019f3c29-c969-70c2-88e4-3aa2f0c441b5', '019f3c29-c992-73be-b23b-25b0c16f4407'),
('019f3c29-c969-70c2-88e4-3aa2f0c441b5', '019f3c29-cc6b-70b0-b5f3-b0a2b8eb5788'),
('019f3c29-c969-70c2-88e4-3aa2f0c441b5', '019f3c29-cee7-71a6-8e16-6cd4d9f537d3');

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
('52OdfrWRCF502SnCQXeIERFhJk423muPLLhqA4cD', NULL, '103.112.245.9', 'Python/3.11 aiohttp/3.9.2', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSERIanlBamJ6c1lsa1M3emxqYWMxdHROUVlCalFwUUs5YmlydFM1VSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDU6Imh0dHBzOi8vZGlzcG9zaXNpLmVuZ2luZWVyaW5nLXVtc3VyYS5pZC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1783478626),
('kjqq2YB3Q82MMWeTAsk5OsJETRFVuUnbS19TKUz2', NULL, '103.112.245.9', 'Python/3.11 aiohttp/3.9.2', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidFpYOWpmdUJMUE9jTmpPZzdqSFhnZzdKa3lZcXZKR2hRN1g3bFMyQiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDU6Imh0dHBzOi8vZGlzcG9zaXNpLmVuZ2luZWVyaW5nLXVtc3VyYS5pZC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1783480425),
('pl5wZDlIGb9rIGbuaPgCWYFarvQzAK1QG44egX1B', '019f3c29-d401-730d-a58f-9fac0918ea2c', '110.137.100.73', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiZmRJZWJ6RU5XVXlxdDJXMVN4d210Vk9iRVVGU1V2azZWRnppSVBGQyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTE5OiJodHRwczovL2Rpc3Bvc2lzaS5lbmdpbmVlcmluZy11bXN1cmEuaWQvYmVuZGFoYXJhL3VzZXItYWNjb3VudC1iYWxhbmNlcy9jb2FzLzgwNDg5YWY5LWEyN2YtNDY5ZC1hYWJiLTE2NjgxYzVjZjkxNi91c2VycyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtzOjM2OiIwMTlmM2MyOS1kNDAxLTczMGQtYTU4Zi05ZmFjMDkxOGVhMmMiO30=', 1783484615),
('sA1CQ1BKN5ZG8poUJxlZihkWGUP709iBI1uL9oob', NULL, '103.112.245.9', 'Python/3.11 aiohttp/3.9.2', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibFhockgwRlQ0UEZOcENtZXd3anpXVnRZcU5jR3VSZGF2VFQ4THNwSSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDU6Imh0dHBzOi8vZGlzcG9zaXNpLmVuZ2luZWVyaW5nLXVtc3VyYS5pZC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1783484023),
('ukb9QyggqpmU9kMMzOSwW8aAoakZSSLcNcF7uOPo', NULL, '103.112.245.9', 'Python/3.11 aiohttp/3.9.2', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRFc2SDl2RkJlTVRaSnB4QlZsTng2VUVzR0IzMVNuQ1JDbWNwTXBqTyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDU6Imh0dHBzOi8vZGlzcG9zaXNpLmVuZ2luZWVyaW5nLXVtc3VyYS5pZC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1783482225);

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
('019f3c35-ba89-732a-bff8-3a8e7f80e1a2', '019f3c35-09b8-737c-8683-733385ec91c9', 'Desember 2022', 'Bulan Desember 2022', '2022-12-01', '2022-12-31', 1, '2026-07-07 12:11:57', '019f3c29-d401-730d-a58f-9fac0918ea2c', '2026-07-07 03:53:01', '2026-07-07 05:11:57'),
('019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', 'Januari 2023', 'Bulan januari 2023', '2023-01-01', '2023-01-31', 0, NULL, NULL, '2026-07-07 05:14:11', '2026-07-07 05:14:11');

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
('019f3c29-d287-707a-8a4d-25d249fe7e86', 'Super Admin', NULL, NULL, 'superadmin@example.com', NULL, '$2y$12$ib5zgHAqeBy9fH37xEiOqueTSJ5gMym.4mTgS51yWLR4UxvgtTly6', 1, NULL, '2026-07-07 03:40:01', '2026-07-07 03:40:01'),
('019f3c29-d401-730d-a58f-9fac0918ea2c', 'Bendahara', NULL, NULL, 'bendahara@example.com', NULL, '$2y$12$DpUZH4ggxR2qjdRul81VGe849aivObItPQmpOL5TwA.BJGgYJLsQO', 0, NULL, '2026-07-07 03:40:02', '2026-07-07 03:40:02'),
('019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'Pemegang Kas Operasional', NULL, NULL, 'pemegang-kas@example.com', NULL, '$2y$12$mgrRX6al5qZHKuzmgl5M3ej.SkjojhQs5FJMQ6T4E5DmUzT8p.QhW', 0, NULL, '2026-07-07 03:40:02', '2026-07-07 03:40:02');

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
('019f3c29-e16f-70c8-b201-e3b4038528ff', '019f3c29-d401-730d-a58f-9fac0918ea2c', '02e0f19e-fe7c-4af8-9840-eba30817c41e', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e17f-736b-b1f5-022df8c36a5d', '019f3c29-d401-730d-a58f-9fac0918ea2c', '03ea188f-4a5a-49a1-a360-afbcee575894', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e18d-711f-a392-9766fb3195fd', '019f3c29-d401-730d-a58f-9fac0918ea2c', '05b667e2-951b-4735-83e7-6761a059c2d4', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e19c-73fd-9020-014de8725903', '019f3c29-d401-730d-a58f-9fac0918ea2c', '060c7786-2d80-4af6-a7f3-4d8dba51c049', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e1ab-718c-8819-5c70087beb82', '019f3c29-d401-730d-a58f-9fac0918ea2c', '06165d42-2fb0-4393-9a8f-f445880be667', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e1b9-7022-8f9c-b8c46575ff6f', '019f3c29-d401-730d-a58f-9fac0918ea2c', '06d411e4-689d-4f6d-bb2e-c9f44aeab33d', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e1c8-730d-b02b-f75b474983e8', '019f3c29-d401-730d-a58f-9fac0918ea2c', '0b374ecb-94f5-41ba-9e48-36082946c81e', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e1d6-7352-ba47-d0ad331c121f', '019f3c29-d401-730d-a58f-9fac0918ea2c', '0ba8ade3-8dc6-4ffb-89c7-50e579be3146', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e1e4-71a0-9b4f-f522c9443a6b', '019f3c29-d401-730d-a58f-9fac0918ea2c', '0dcf66b6-8ba6-40b3-89e7-282aa84c03e5', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e1f3-73bf-875e-b657fdada347', '019f3c29-d401-730d-a58f-9fac0918ea2c', '10af2cdc-0754-4d24-871d-46ad9bdb8f98', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e202-71e1-b70c-428fa37f0256', '019f3c29-d401-730d-a58f-9fac0918ea2c', '11a7616a-06e7-4757-84c2-79d6f91406ef', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e20f-72e9-b801-3745aa2fbac8', '019f3c29-d401-730d-a58f-9fac0918ea2c', '132603d3-0f4b-4c28-8e39-e05a89642d98', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e21d-70c9-9c56-cde3f62429d7', '019f3c29-d401-730d-a58f-9fac0918ea2c', '1f3e9890-fa94-4611-9531-cbabb4f9091e', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e22a-7261-ac12-28eefe12f6fd', '019f3c29-d401-730d-a58f-9fac0918ea2c', '225f7e5c-8132-4aff-bccd-9c1e07ebc65f', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e238-7239-9394-7d8a32758a76', '019f3c29-d401-730d-a58f-9fac0918ea2c', '22863257-23b1-40b2-81b5-625a579e4887', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e245-70ad-8a91-63556e02981b', '019f3c29-d401-730d-a58f-9fac0918ea2c', '23ce33b2-eb43-4bad-aeff-715f9e4f8a06', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e253-721a-800c-8f76d0f1a174', '019f3c29-d401-730d-a58f-9fac0918ea2c', '258febc1-f6d2-49bd-be01-08741fe511da', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e260-73c6-bb03-bdc1441b7e80', '019f3c29-d401-730d-a58f-9fac0918ea2c', '2697d4da-bd60-4ada-9ab3-8f75a3dcc793', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e26f-706f-af91-21bc84678db8', '019f3c29-d401-730d-a58f-9fac0918ea2c', '27b3424e-5e94-48db-8d12-af1165d6ed2f', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e27d-732b-8b78-343b5c1d50a1', '019f3c29-d401-730d-a58f-9fac0918ea2c', '27ef2784-5982-421c-bb3f-96a51777fbf3', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e28a-73c9-a3af-9ef086f9e205', '019f3c29-d401-730d-a58f-9fac0918ea2c', '290bef48-1174-4bb0-8c01-0d5b17108128', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e299-7010-aab4-f73b91df8eff', '019f3c29-d401-730d-a58f-9fac0918ea2c', '29b45798-4894-4b34-8b98-6763e573bb7a', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e2a6-70f3-9b69-f117c0de92ce', '019f3c29-d401-730d-a58f-9fac0918ea2c', '2c677359-98b2-440d-ae53-dcae5095841e', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e2b4-718a-995c-8cbc1a4df552', '019f3c29-d401-730d-a58f-9fac0918ea2c', '2f1adb90-a4d5-4c63-8ed9-7f4109b1890d', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e2c9-70c8-8919-164228eda2a7', '019f3c29-d401-730d-a58f-9fac0918ea2c', '2fc91e28-cafa-42d5-a383-960bd2304d79', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e2d7-7202-b10b-14cd7f15b3b4', '019f3c29-d401-730d-a58f-9fac0918ea2c', '2ffe0b7f-2bc6-4dac-9940-e53393a90f58', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e2e5-71aa-8483-625463fbd763', '019f3c29-d401-730d-a58f-9fac0918ea2c', '34946f7c-6f05-4bb7-ba94-01afba90ff43', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e2f2-73aa-b96c-9f8aa8989330', '019f3c29-d401-730d-a58f-9fac0918ea2c', '36c76a75-5dd6-48bd-b474-bde2c2b9e7d3', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e2ff-701a-a8a9-1fe6ed7012f8', '019f3c29-d401-730d-a58f-9fac0918ea2c', '37aaef0a-ab7e-4bc1-8f6f-fb6028a3277e', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e30f-7105-840e-cc1998963b6e', '019f3c29-d401-730d-a58f-9fac0918ea2c', '3f354843-3d12-4886-ae4d-a0cf7ff5c6c4', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e31d-73f9-87e1-98b26ba0aaf2', '019f3c29-d401-730d-a58f-9fac0918ea2c', '3fab3482-9af2-4d47-92f0-b6a42980348c', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e334-7090-a2f8-b63624c10598', '019f3c29-d401-730d-a58f-9fac0918ea2c', '41dd99c8-6337-4697-ac01-ffb1bf79540b', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e343-71cb-a045-07def74601e0', '019f3c29-d401-730d-a58f-9fac0918ea2c', '41fbc782-5794-409d-8507-f99fed76fe8b', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e351-70f5-9998-5bf2806e648c', '019f3c29-d401-730d-a58f-9fac0918ea2c', '44fb2678-eb3c-4af8-88ea-e9654dcc88ac', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e35f-71ae-91e0-c9a505e77af4', '019f3c29-d401-730d-a58f-9fac0918ea2c', '46a3a069-49e2-403a-a208-ae7cf8219249', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e36e-7049-9f12-e74593b586dd', '019f3c29-d401-730d-a58f-9fac0918ea2c', '4755ebf2-c52b-4f64-8281-176d879ac1aa', '2026-07-07 03:40:05', '2026-07-07 03:40:05'),
('019f3c29-e37b-727a-bf76-9f78302dd253', '019f3c29-d401-730d-a58f-9fac0918ea2c', '48b61973-5d46-469e-9ae3-afd4a3be5fae', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e392-7094-8148-9e71a81bf3c0', '019f3c29-d401-730d-a58f-9fac0918ea2c', '4a6caa70-24ca-45b3-b752-57f72b56a930', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e3a1-7273-8bd7-a12ea560b513', '019f3c29-d401-730d-a58f-9fac0918ea2c', '4b7fc140-c63d-4001-8704-c0ece2a4ec7b', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e3af-70cd-b96e-f80f8e1aff6b', '019f3c29-d401-730d-a58f-9fac0918ea2c', '4cf55425-0f8b-4b44-ad53-26c1dab32558', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e3bd-7085-840d-1b7b1503b56d', '019f3c29-d401-730d-a58f-9fac0918ea2c', '4dde9b7f-95c6-47e7-ade5-9cb403950064', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e3ca-7275-9853-1b6ebdf89960', '019f3c29-d401-730d-a58f-9fac0918ea2c', '56962e72-737c-4932-a1c1-4d7cf41db900', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e3d8-732d-90f4-a419142a2d4e', '019f3c29-d401-730d-a58f-9fac0918ea2c', '58890adf-02ff-4976-9357-7840f15e5c8d', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e3e6-7106-aa5b-ac396caae586', '019f3c29-d401-730d-a58f-9fac0918ea2c', '591c8ff4-1887-4259-b966-890f724424e3', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e3f4-71b8-9e46-1368de3c94b6', '019f3c29-d401-730d-a58f-9fac0918ea2c', '5afb25f5-ea51-4978-8159-60aef27c29e0', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e402-7202-8fbc-efeb899e1af4', '019f3c29-d401-730d-a58f-9fac0918ea2c', '5b11c6ca-5d87-4837-ad30-e91953c5a1a9', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e411-714b-894b-056e2ec1a045', '019f3c29-d401-730d-a58f-9fac0918ea2c', '5c2b1cd4-d67d-4a13-8d27-ca888f5f02f2', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e41e-7015-98f3-dd40f044de9e', '019f3c29-d401-730d-a58f-9fac0918ea2c', '5e5b9787-1c85-40fb-a997-52b1bb7e7ed5', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e42c-7009-929b-76d16a5f372f', '019f3c29-d401-730d-a58f-9fac0918ea2c', '605dc218-d091-47b2-a7f2-0effb402d2d4', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e43b-7103-bcab-7c64cdbabae0', '019f3c29-d401-730d-a58f-9fac0918ea2c', '610faad3-6e8f-4791-8608-cb0eb19688be', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e44c-71f4-8d72-9983b31397b8', '019f3c29-d401-730d-a58f-9fac0918ea2c', '638a512b-cab3-4d52-b467-7193ccc1feb3', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e45b-729c-b940-0f938ef5bb2a', '019f3c29-d401-730d-a58f-9fac0918ea2c', '640af4d9-6891-4840-9a50-8c009ca3f486', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e469-7135-a3b2-6a32ab766fa0', '019f3c29-d401-730d-a58f-9fac0918ea2c', '6486b0ff-c08e-4b4a-b6bd-6cf40c1d93dd', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e478-702b-a06f-d22df98b5963', '019f3c29-d401-730d-a58f-9fac0918ea2c', '6865e20e-43b2-48ce-b3a3-653078468886', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e487-7191-95dd-b117cab390c7', '019f3c29-d401-730d-a58f-9fac0918ea2c', '69339cd7-dd8c-4966-bb0d-ad14dc3d9bd1', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e495-7359-9e95-1da0366439b8', '019f3c29-d401-730d-a58f-9fac0918ea2c', '6afbe99c-65df-4128-a16c-fa5827c8347f', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e4a3-7140-b034-ba79298053a5', '019f3c29-d401-730d-a58f-9fac0918ea2c', '6f9dd6c1-e799-4bef-8a44-04ce7e7a1dec', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e4b2-7274-bc8f-6232c95d1a82', '019f3c29-d401-730d-a58f-9fac0918ea2c', '700e4c22-26f3-43ce-8ef0-b32b8920e93c', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e4c1-726d-9b1c-be5497f4fc4b', '019f3c29-d401-730d-a58f-9fac0918ea2c', '724f6c78-1a44-4f74-bf40-fd9b43963ba3', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e4d0-7120-be11-969da8d6c9c6', '019f3c29-d401-730d-a58f-9fac0918ea2c', '76a20fad-6338-4545-9a9e-4acc355eeb3e', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e4de-714a-9d4a-65e0c1d37934', '019f3c29-d401-730d-a58f-9fac0918ea2c', '7b4c8d7b-ff7f-436d-b874-a6058efa0f36', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e4ed-7175-af32-515ae64b78cc', '019f3c29-d401-730d-a58f-9fac0918ea2c', '7e3a051c-a73b-485c-865c-f7259792967d', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e4fb-73ce-b042-bf63ad8820b2', '019f3c29-d401-730d-a58f-9fac0918ea2c', '7fecbf43-5f25-49e8-8068-a4aed1808cd4', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e50a-70f1-aba9-4671f2dd66df', '019f3c29-d401-730d-a58f-9fac0918ea2c', '80489af9-a27f-469d-aabb-16681c5cf916', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e518-736f-baaf-1fb18ef162a9', '019f3c29-d401-730d-a58f-9fac0918ea2c', '81f580a0-1436-4a81-84a3-93d197075930', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e525-7291-82eb-5411c72bcd85', '019f3c29-d401-730d-a58f-9fac0918ea2c', '852153e1-1905-487f-9176-56fac68a9968', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e534-7160-a2e4-3f7d39dce451', '019f3c29-d401-730d-a58f-9fac0918ea2c', '89b2bd63-45a5-4376-9301-75f7c5c6869f', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e542-7127-a617-8531789da5c7', '019f3c29-d401-730d-a58f-9fac0918ea2c', '8dcd1a44-abb4-4383-8182-51e4416392e8', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e550-731d-83dc-2303fdb35942', '019f3c29-d401-730d-a58f-9fac0918ea2c', '8e772f65-a3e0-4d09-8783-132811d324b5', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e55e-7323-b86c-bebe44aff771', '019f3c29-d401-730d-a58f-9fac0918ea2c', '8eafa0f0-e378-418c-a53a-73a879cb392f', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e56b-7291-a71b-e9536e8bf874', '019f3c29-d401-730d-a58f-9fac0918ea2c', '8f516b93-3983-41be-a7d9-37a2364355b3', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e579-7266-8c49-d13292c1582c', '019f3c29-d401-730d-a58f-9fac0918ea2c', '92aa553e-6ee4-48e9-a7f7-02acaba8ecd0', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e588-704f-81c4-212fc180426a', '019f3c29-d401-730d-a58f-9fac0918ea2c', '931fa6b3-6053-4b8e-8f45-5dc87115dcb6', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e595-72a3-abaf-0d1fbfdd63f8', '019f3c29-d401-730d-a58f-9fac0918ea2c', '98c63964-bd5e-4fe0-886b-ff6663c73fdc', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e5a4-718a-95e9-078263f7accc', '019f3c29-d401-730d-a58f-9fac0918ea2c', '99796640-5f95-4ad6-bf89-7121444ade40', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e5b2-705a-8124-c55a22eeaed7', '019f3c29-d401-730d-a58f-9fac0918ea2c', '9d1306f9-10c9-4820-bc3e-e2486c49e8cd', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e5bf-7125-a0af-8cba11148233', '019f3c29-d401-730d-a58f-9fac0918ea2c', '9f5ccef8-b43a-4686-9dc3-d6199a74ce89', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e5cd-7072-8cbb-0c5c91cb736d', '019f3c29-d401-730d-a58f-9fac0918ea2c', '9fa5994e-9de7-4284-af4f-df5f7490e4a6', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e5db-721c-babe-378a2dea6322', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'a32ae99f-0c4c-44e5-9282-6fc6f4cf51de', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e5e9-73a4-9f2b-b6bbb00fd1aa', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'a5e6167d-c666-42f0-bc88-b75ac70e6ab0', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e5f8-7387-8a0c-46f06f99e5be', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'ac1a013b-b327-4084-8d52-52440f6bcb54', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e606-715e-9d60-8b14c01306b3', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'ac8a1463-4a4c-4cb1-a0e4-b00c2d9cf522', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e615-71a4-948f-9f21309430e8', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'afd34085-9d09-4ff0-9d09-c07c85a6b595', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e624-7183-8255-12fc77cfbc00', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'b01e653a-9e3b-44d1-a81c-f981c7b2acbe', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e632-738f-8805-dcf4716272a6', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'b2046255-9dc2-406b-ae9a-fd47cf6bddb2', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e641-736d-b9a3-462ca9b52351', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'b27bdc66-661a-4dd0-9831-e779426c372a', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e64f-720e-a136-631fde827d6a', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'b472d3a2-353d-484e-accf-1c80167f6000', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e65d-725b-b0c0-9b411faf41e3', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'b840fcec-a9c1-4afc-9824-f6fca25211ba', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e66b-71b8-b9ad-9a881e7b1219', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'b89aeb06-4c14-44b2-9a3a-97f8619e47c8', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e678-72a4-81c5-fbc6f9e2d223', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'bb63ab0e-2314-4079-b255-915ed295b322', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e686-704a-bb02-f1a58e4c5aee', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'bbca9830-3900-41a5-a233-774c581874e8', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e694-70f1-a591-ea8630f8d07e', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'bbd6859d-aae9-435a-bf0a-7543c4fb6321', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e6a2-7372-9851-4aa14afe4f5b', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'bca4163c-d2f5-4b28-a022-83059cfecaa2', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e6b1-706b-82e5-61e3ddd95073', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'bed710fe-7648-4fe7-9b9b-b1f2f960cee7', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e6bf-73f2-9a98-20f5bb1fcc2a', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'c1211db4-92a4-4343-9bf6-10c9adeeb912', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e6cc-71d7-ae64-4ac7858bf0df', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'c2f2d0bb-303d-4913-8df0-c6030afe4501', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e6da-71af-bd2b-e6fc12b227e5', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e6e8-70a0-a5b1-5c59b3553be8', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'cbf1ae59-be94-468d-a0b1-14f125f5b831', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e6f5-7312-b54d-b5d36ad8b870', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'cc07e75b-1119-4e8f-b7d1-f782842d1770', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e703-7251-ab5d-71d349b2784a', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'cc841ad2-0e5b-43f7-909e-d31ce5563706', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e710-716c-9abf-b7590bb06c9c', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'cda7e544-e669-4f9c-9b6f-f6ba07500cef', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e71e-72ad-9832-a22caa609965', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'ce1441a5-5f7e-46d7-8cc7-3f9bae862ae3', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e72b-702d-9fd0-d29eef8c61bf', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'cfe855aa-e85d-40f2-96a4-e34d46c904f3', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e738-7353-87ae-85aeaf563f37', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'd40db36e-328b-43fd-ae0a-2fb09fcef5c2', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e745-734e-ab8b-ba8dca73b44a', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'd43c41c7-4cfa-42c7-81be-b99ca8e1621b', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e752-70d7-8e0a-47fba11871b6', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'd650d3c0-ca9f-4587-9a11-cdfefa1e3115', '2026-07-07 03:40:06', '2026-07-07 03:40:06'),
('019f3c29-e75f-7113-b727-cf15deffeab5', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'd7305d55-a17b-4f18-bb71-83e624522e8f', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e76d-71ce-abb1-296c9742fc02', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'd73463de-abb8-4e44-9f77-92d375acb1e8', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e77a-700a-86af-52c0eacec109', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'd7d9901c-9785-4410-aae6-2c4236b5648d', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e787-7351-acb0-727f40543dc8', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'd96a0838-d30f-4e12-93a5-f61ee741d39d', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e795-714b-ade8-defb666ad4da', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'd9c57730-6928-4e5d-ac29-bf2f6dd9895f', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e7a2-70ec-aa36-9968bd780124', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'db8f505b-44a6-45f5-8d10-f8d15bea1af4', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e7af-7130-963c-951f79ebf30e', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'dc16f8fe-a09e-4399-a227-7320a3f32feb', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e7bc-71d9-a5d9-ec34726de1b9', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'dd9958f5-23ee-467f-be58-8bd553eceeac', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e7ca-7367-a542-1bba4cb0bba3', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'dead6c90-51ca-4b56-b953-9ce8a362108f', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e7d7-7312-826c-c4637870f2b3', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'e2eda7c2-e10e-47e3-bb99-9a68bd2294cf', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e7e5-7237-a825-3ee942998b7d', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'e5032396-b524-43e4-aaf0-c8de44d4c99a', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e7f1-73b7-bc64-16086de2153e', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'e8d6d3cc-494f-463d-a264-763e3e72c155', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e7fe-73c5-90d1-a324eb71bb26', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'f0ab0d30-708d-4536-b5c6-448b058d7a75', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e80c-71fc-bdb0-1b5022c41801', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'f415012f-1f66-4b77-a725-6682e2ffd02b', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e81a-727d-9a4e-dd96a0203d24', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'f67c7605-fd55-4d04-8065-738b2feff09a', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e828-73f8-b91f-5328e4078871', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'f6c24672-0eeb-4f58-a71c-8f8bad115f5b', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e835-73e5-af9d-20b8420d57be', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'f8832dae-00e3-4d46-9e05-991b3e02f16a', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e843-71bb-9b6d-f060a199e572', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'fc646e17-8f59-466f-8bea-74a29c39bdad', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e850-7094-9b68-bbdd0f9108a5', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'fee7e8c7-a5e4-4a0f-bf77-62db604ee500', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e85d-7069-ba59-1243466ecc90', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'ff336d58-31ed-49b6-8df8-6ea403800108', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e86a-71b0-bb2c-684bb4298e8c', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '02e0f19e-fe7c-4af8-9840-eba30817c41e', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e877-71d1-921d-1969145319f5', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '03ea188f-4a5a-49a1-a360-afbcee575894', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e884-71b5-9851-7887133337aa', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '05b667e2-951b-4735-83e7-6761a059c2d4', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e891-716d-8d0a-6fd79d7089ce', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '060c7786-2d80-4af6-a7f3-4d8dba51c049', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e89f-702f-9c3b-573d41ee8b71', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '06165d42-2fb0-4393-9a8f-f445880be667', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e8b0-7190-abe8-7d386e2c6e01', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '06d411e4-689d-4f6d-bb2e-c9f44aeab33d', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e8bf-702e-bfeb-7596acc0c5a0', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '0b374ecb-94f5-41ba-9e48-36082946c81e', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e8cf-71ce-8045-2ab79d543b9a', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '0ba8ade3-8dc6-4ffb-89c7-50e579be3146', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e8dd-723e-a57b-232db5ed2259', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '0dcf66b6-8ba6-40b3-89e7-282aa84c03e5', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e8eb-7210-8c3a-5f3af9a2c87d', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '10af2cdc-0754-4d24-871d-46ad9bdb8f98', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e8f9-7034-a7e3-000f220bc732', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '11a7616a-06e7-4757-84c2-79d6f91406ef', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e908-7126-88d1-ee7dfae5045f', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '132603d3-0f4b-4c28-8e39-e05a89642d98', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e916-701f-a9cb-790637b34f58', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '1f3e9890-fa94-4611-9531-cbabb4f9091e', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e924-73d9-9fbb-6fb1f8879411', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '225f7e5c-8132-4aff-bccd-9c1e07ebc65f', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e932-72c3-be57-332499c71c8c', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '22863257-23b1-40b2-81b5-625a579e4887', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e942-7122-be6f-0ab31c9b0336', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '23ce33b2-eb43-4bad-aeff-715f9e4f8a06', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e950-717f-b213-6d95c86d81ee', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '258febc1-f6d2-49bd-be01-08741fe511da', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e95f-72d1-bcd6-a9d0e9caabfb', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2697d4da-bd60-4ada-9ab3-8f75a3dcc793', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e96e-7206-8fdd-7359158cf501', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '27b3424e-5e94-48db-8d12-af1165d6ed2f', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e97d-7080-aa93-829402033ac6', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '27ef2784-5982-421c-bb3f-96a51777fbf3', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e98b-7112-9814-8f1fa50e8d91', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '290bef48-1174-4bb0-8c01-0d5b17108128', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e99a-70a8-a9a5-6a8829e5be74', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '29b45798-4894-4b34-8b98-6763e573bb7a', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e9a9-7236-8401-b3e300c5d37f', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2c677359-98b2-440d-ae53-dcae5095841e', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e9b7-73d7-86c1-8f9083e8527a', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2f1adb90-a4d5-4c63-8ed9-7f4109b1890d', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e9c6-72f8-a085-9bdaed3db3eb', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2fc91e28-cafa-42d5-a383-960bd2304d79', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e9d8-736e-84f0-ec2a34ba899d', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2ffe0b7f-2bc6-4dac-9940-e53393a90f58', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e9e7-738d-976f-03d7b288e98a', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '34946f7c-6f05-4bb7-ba94-01afba90ff43', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-e9f5-7125-9f3b-03bd082bcdae', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '36c76a75-5dd6-48bd-b474-bde2c2b9e7d3', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-ea04-72aa-a32f-350c33889839', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '37aaef0a-ab7e-4bc1-8f6f-fb6028a3277e', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-ea12-71c5-a270-8d54b22b5900', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '3f354843-3d12-4886-ae4d-a0cf7ff5c6c4', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-ea21-70c1-a50f-558e364eb9aa', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '3fab3482-9af2-4d47-92f0-b6a42980348c', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-ea2f-71be-8b08-f2eadfd0a75c', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '41dd99c8-6337-4697-ac01-ffb1bf79540b', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-ea3e-7389-b943-8c4d319144ff', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '41fbc782-5794-409d-8507-f99fed76fe8b', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-ea4d-7171-9789-ef0bdbd4267c', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '44fb2678-eb3c-4af8-88ea-e9654dcc88ac', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-ea5b-70bb-abea-28efc83ebd7e', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '46a3a069-49e2-403a-a208-ae7cf8219249', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-ea69-7399-8165-bd8c00149089', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '4755ebf2-c52b-4f64-8281-176d879ac1aa', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-ea76-7353-abc0-897f7b8ce6ef', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '48b61973-5d46-469e-9ae3-afd4a3be5fae', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-ea84-712a-86c2-6c1117e7c448', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '4a6caa70-24ca-45b3-b752-57f72b56a930', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-ea92-725c-b8b9-d08f12b4d81a', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '4b7fc140-c63d-4001-8704-c0ece2a4ec7b', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-eaa0-7337-8b7f-ad99896a4e6f', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '4cf55425-0f8b-4b44-ad53-26c1dab32558', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-eaae-7310-ac10-14bc40a4b7b3', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '4dde9b7f-95c6-47e7-ade5-9cb403950064', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-eabc-7395-8229-f5f7d1455f22', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '56962e72-737c-4932-a1c1-4d7cf41db900', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-eaca-7127-93b2-7ab138f0d70e', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '58890adf-02ff-4976-9357-7840f15e5c8d', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-ead9-71cb-afc2-a91c71f04adf', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '591c8ff4-1887-4259-b966-890f724424e3', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-eae8-7304-9c9f-71d8e75636da', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '5afb25f5-ea51-4978-8159-60aef27c29e0', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-eaf5-7039-8b02-65d957f8696b', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '5b11c6ca-5d87-4837-ad30-e91953c5a1a9', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-eb03-7388-a1ec-c401627f6d6f', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '5c2b1cd4-d67d-4a13-8d27-ca888f5f02f2', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-eb10-73f2-a700-82740181dec4', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '5e5b9787-1c85-40fb-a997-52b1bb7e7ed5', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-eb1e-70e7-a8d2-2b08b1389511', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '605dc218-d091-47b2-a7f2-0effb402d2d4', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-eb2c-739f-82cd-cd1726732a8d', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '610faad3-6e8f-4791-8608-cb0eb19688be', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-eb39-72fa-b295-0094b0bc8ef1', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '638a512b-cab3-4d52-b467-7193ccc1feb3', '2026-07-07 03:40:07', '2026-07-07 03:40:07'),
('019f3c29-eb49-7079-88ec-b154b2d3e9e1', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '640af4d9-6891-4840-9a50-8c009ca3f486', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-eb5b-704f-b87c-6a5ab52217c7', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '6486b0ff-c08e-4b4a-b6bd-6cf40c1d93dd', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-eb71-70a0-aa82-78bff78b4ee5', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '6865e20e-43b2-48ce-b3a3-653078468886', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-eb83-73e9-8043-23c8978f9ed4', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '69339cd7-dd8c-4966-bb0d-ad14dc3d9bd1', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-eb97-7046-a49a-dfbdd1d3173c', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '6afbe99c-65df-4128-a16c-fa5827c8347f', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-eba9-719a-9cc5-c53a51514ead', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '6f9dd6c1-e799-4bef-8a44-04ce7e7a1dec', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ebba-71d9-bf59-1cc3d528c2ea', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '700e4c22-26f3-43ce-8ef0-b32b8920e93c', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ebce-7188-87db-68ad396b0da8', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '724f6c78-1a44-4f74-bf40-fd9b43963ba3', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ebe2-72ba-b5b3-98c6f626761c', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '76a20fad-6338-4545-9a9e-4acc355eeb3e', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ebf4-7210-a3fa-6a9d55243aca', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '7b4c8d7b-ff7f-436d-b874-a6058efa0f36', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ec07-7285-8b7e-45bd52cafe33', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '7e3a051c-a73b-485c-865c-f7259792967d', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ec18-709b-8736-687c5e2aeb62', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '7fecbf43-5f25-49e8-8068-a4aed1808cd4', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ec2c-7065-a924-bb27d8819490', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '80489af9-a27f-469d-aabb-16681c5cf916', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ec41-7045-9a59-c0ac26b0795d', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '81f580a0-1436-4a81-84a3-93d197075930', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ec55-7160-a115-384c02e3230a', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '852153e1-1905-487f-9176-56fac68a9968', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ec6b-71e5-b987-279a1521bab7', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '89b2bd63-45a5-4376-9301-75f7c5c6869f', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ec80-7221-ab84-8d425b6b381a', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '8dcd1a44-abb4-4383-8182-51e4416392e8', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ec95-7108-83c3-79281ac8a498', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '8e772f65-a3e0-4d09-8783-132811d324b5', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-eca9-72c1-8f4e-a5465a845cae', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '8eafa0f0-e378-418c-a53a-73a879cb392f', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ecbc-738b-b489-3ace07cdb9be', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '8f516b93-3983-41be-a7d9-37a2364355b3', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-eccf-715d-adca-8bc5d3422a1b', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '92aa553e-6ee4-48e9-a7f7-02acaba8ecd0', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ece1-721f-a26b-d4e950806bdd', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '931fa6b3-6053-4b8e-8f45-5dc87115dcb6', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ecf3-73c1-a9fb-4f778a0478eb', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '98c63964-bd5e-4fe0-886b-ff6663c73fdc', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ed08-722c-865f-f9adfb94e16f', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '99796640-5f95-4ad6-bf89-7121444ade40', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ed1a-711b-a662-70e5ca5c8fe2', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '9d1306f9-10c9-4820-bc3e-e2486c49e8cd', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ed2c-70a0-8c1e-e3d4783fe6b7', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '9f5ccef8-b43a-4686-9dc3-d6199a74ce89', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ed3d-7103-a97e-79d7ce8c872a', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '9fa5994e-9de7-4284-af4f-df5f7490e4a6', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ed4d-706c-8f90-ef26db8c946d', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'a32ae99f-0c4c-44e5-9282-6fc6f4cf51de', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ed63-70b0-ae97-5f898ae07cf9', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'a5e6167d-c666-42f0-bc88-b75ac70e6ab0', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ed73-7307-a338-89854e36f0fc', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'ac1a013b-b327-4084-8d52-52440f6bcb54', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ed84-73e6-8b8c-7c72a15c4754', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'ac8a1463-4a4c-4cb1-a0e4-b00c2d9cf522', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ed94-704c-8101-37741e68f59d', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'afd34085-9d09-4ff0-9d09-c07c85a6b595', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-eda6-701c-ac99-12830d4c947c', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'b01e653a-9e3b-44d1-a81c-f981c7b2acbe', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-edb6-73a4-a12d-d927922e777c', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'b2046255-9dc2-406b-ae9a-fd47cf6bddb2', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-edc5-7247-a4a8-f2c222584771', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'b27bdc66-661a-4dd0-9831-e779426c372a', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-edd5-70f8-9a25-f0918f5975d2', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'b472d3a2-353d-484e-accf-1c80167f6000', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ede4-73bd-9b52-3cd1f7838133', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'b840fcec-a9c1-4afc-9824-f6fca25211ba', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-edf4-72b9-86a9-b224858e4772', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'b89aeb06-4c14-44b2-9a3a-97f8619e47c8', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ee03-7084-a59c-9a9c09a9681b', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'bb63ab0e-2314-4079-b255-915ed295b322', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ee12-73fa-abee-652465d7eb8c', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'bbca9830-3900-41a5-a233-774c581874e8', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ee22-7061-b525-b7d5650c5c2a', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'bbd6859d-aae9-435a-bf0a-7543c4fb6321', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ee32-7387-a57e-f3030f6c8d63', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'bca4163c-d2f5-4b28-a022-83059cfecaa2', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ee41-72cc-adfb-5c563d179ad0', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'bed710fe-7648-4fe7-9b9b-b1f2f960cee7', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ee51-7362-95b2-ad9d7a98ceea', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'c1211db4-92a4-4343-9bf6-10c9adeeb912', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ee60-7260-b5ae-d3a095d39f05', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'c2f2d0bb-303d-4913-8df0-c6030afe4501', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ee70-7138-9201-b8274ae5fb3d', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ee7e-72f6-8510-b9fbd64a92f5', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'cbf1ae59-be94-468d-a0b1-14f125f5b831', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ee8d-7193-ae46-2975178603e9', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'cc07e75b-1119-4e8f-b7d1-f782842d1770', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ee9c-72fc-8396-f96134b0b5ad', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'cc841ad2-0e5b-43f7-909e-d31ce5563706', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-eeab-728e-8998-3c0e709bb558', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'cda7e544-e669-4f9c-9b6f-f6ba07500cef', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-eeba-7203-83c8-c62c59361f6c', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'ce1441a5-5f7e-46d7-8cc7-3f9bae862ae3', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-eec9-7035-9200-01035d6aec60', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'cfe855aa-e85d-40f2-96a4-e34d46c904f3', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-eedb-70d7-b04b-e3933a6c2701', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'd40db36e-328b-43fd-ae0a-2fb09fcef5c2', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-eeed-7125-96a4-eb3d2af8f540', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'd43c41c7-4cfa-42c7-81be-b99ca8e1621b', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-eefd-7160-8276-477f9faa6bac', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'd650d3c0-ca9f-4587-9a11-cdfefa1e3115', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ef0d-71df-b354-953308c06626', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'd7305d55-a17b-4f18-bb71-83e624522e8f', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ef1d-72e2-984f-2348fc440d23', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'd73463de-abb8-4e44-9f77-92d375acb1e8', '2026-07-07 03:40:08', '2026-07-07 03:40:08'),
('019f3c29-ef2d-7114-9646-ededf6b14735', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'd7d9901c-9785-4410-aae6-2c4236b5648d', '2026-07-07 03:40:09', '2026-07-07 03:40:09'),
('019f3c29-ef3d-728a-8357-874c226e4212', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'd96a0838-d30f-4e12-93a5-f61ee741d39d', '2026-07-07 03:40:09', '2026-07-07 03:40:09'),
('019f3c29-ef4d-73f6-a4a0-69509ebe2f7d', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'd9c57730-6928-4e5d-ac29-bf2f6dd9895f', '2026-07-07 03:40:09', '2026-07-07 03:40:09'),
('019f3c29-ef5c-71d8-969b-18d84c618c44', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'db8f505b-44a6-45f5-8d10-f8d15bea1af4', '2026-07-07 03:40:09', '2026-07-07 03:40:09'),
('019f3c29-ef6c-73c6-8e7d-c7d7896ee150', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'dc16f8fe-a09e-4399-a227-7320a3f32feb', '2026-07-07 03:40:09', '2026-07-07 03:40:09'),
('019f3c29-ef82-7345-9e74-a4d790be7c37', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'dd9958f5-23ee-467f-be58-8bd553eceeac', '2026-07-07 03:40:09', '2026-07-07 03:40:09'),
('019f3c29-ef91-708b-bd3f-59ca2eef9282', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'dead6c90-51ca-4b56-b953-9ce8a362108f', '2026-07-07 03:40:09', '2026-07-07 03:40:09'),
('019f3c29-efa0-705f-a302-e6d76d3b7df1', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'e2eda7c2-e10e-47e3-bb99-9a68bd2294cf', '2026-07-07 03:40:09', '2026-07-07 03:40:09'),
('019f3c29-efae-7215-b802-9b8c8c7cf3d2', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'e5032396-b524-43e4-aaf0-c8de44d4c99a', '2026-07-07 03:40:09', '2026-07-07 03:40:09'),
('019f3c29-efbd-714e-aaf1-865f47e6df68', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'e8d6d3cc-494f-463d-a264-763e3e72c155', '2026-07-07 03:40:09', '2026-07-07 03:40:09'),
('019f3c29-efcc-72d6-b094-48b5fa815ca8', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'f0ab0d30-708d-4536-b5c6-448b058d7a75', '2026-07-07 03:40:09', '2026-07-07 03:40:09'),
('019f3c29-efdb-738e-a442-c67763892425', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'f415012f-1f66-4b77-a725-6682e2ffd02b', '2026-07-07 03:40:09', '2026-07-07 03:40:09'),
('019f3c29-efeb-71a4-a70c-e16ac31b1da5', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'f67c7605-fd55-4d04-8065-738b2feff09a', '2026-07-07 03:40:09', '2026-07-07 03:40:09'),
('019f3c29-effa-7272-92c6-c01a638163fa', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'f6c24672-0eeb-4f58-a71c-8f8bad115f5b', '2026-07-07 03:40:09', '2026-07-07 03:40:09'),
('019f3c29-f008-70ad-ac35-bd663f7068a8', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'f8832dae-00e3-4d46-9e05-991b3e02f16a', '2026-07-07 03:40:09', '2026-07-07 03:40:09'),
('019f3c29-f017-73aa-916d-14bb868f4f6e', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'fc646e17-8f59-466f-8bea-74a29c39bdad', '2026-07-07 03:40:09', '2026-07-07 03:40:09'),
('019f3c29-f026-7170-a700-3c3b0143f4e2', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'fee7e8c7-a5e4-4a0f-bf77-62db604ee500', '2026-07-07 03:40:09', '2026-07-07 03:40:09'),
('019f3c29-f035-732a-ae59-34ae55015acd', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'ff336d58-31ed-49b6-8df8-6ea403800108', '2026-07-07 03:40:09', '2026-07-07 03:40:09');

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
  `used_balance` decimal(15,2) NOT NULL DEFAULT 0.00,
  `remaining_balance` decimal(15,2) NOT NULL DEFAULT 0.00,
  `allocated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

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
