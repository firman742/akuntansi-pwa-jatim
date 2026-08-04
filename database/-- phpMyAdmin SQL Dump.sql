-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 02 Agu 2026 pada 18.25
-- Versi server: 10.6.27-MariaDB-cll-lve-log
-- Versi PHP: 8.4.23

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
('019f3fef-8feb-7297-82a8-8184dc812262', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Selisih Lebih/Kurang (31300) pada sub periode Januari 2023 dengan jumlah 2,674,750,712.00', 'App\\Models\\OpeningBalance', '019f3fef-8fde-7233-9c46-b8b686a0f2a7', '[]', '{\"chart_of_account_id\":\"34946f7c-6f05-4bb7-ba94-01afba90ff43\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"balance_type\":\"CREDIT\",\"amount\":2674750712,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"is_correction\":false,\"id\":\"019f3fef-8fde-7233-9c46-b8b686a0f2a7\",\"updated_at\":\"2026-07-08T04:14:52.000000Z\",\"created_at\":\"2026-07-08T04:14:52.000000Z\",\"chart_of_account\":{\"id\":\"34946f7c-6f05-4bb7-ba94-01afba90ff43\",\"code\":\"31300\",\"name\":\"Selisih Lebih\\/Kurang\",\"parent_id\":\"99796640-5f95-4ad6-bf89-7121444ade40\",\"level\":\"2\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567892\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-07-07T10:40:03.000000Z\",\"updated_at\":\"2026-07-07T10:40:03.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"name\":\"Januari 2023\",\"description\":\"Bulan januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-07-07T12:14:11.000000Z\",\"updated_at\":\"2026-07-07T12:14:11.000000Z\"}}', '110.137.100.73', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"coa_balance\":{\"chart_of_account_id\":\"34946f7c-6f05-4bb7-ba94-01afba90ff43\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\",\"opening_balance\":2674750712,\"debit_total\":0,\"credit_total\":0,\"current_balance\":2674750712,\"last_transaction_at\":\"2026-07-08T04:14:52.000000Z\",\"id\":\"019f3fef-8fe3-72dd-88aa-7a76ecb0472a\",\"updated_at\":\"2026-07-08T04:14:52.000000Z\",\"created_at\":\"2026-07-08T04:14:52.000000Z\"}}', '2026-07-07 21:14:52', '2026-07-07 21:14:52'),
('019f400f-b2b9-719c-a7cc-1cd16a3d9f14', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f400f-b2a4-72cb-b56b-624366a67dd0', '[]', '{\"transaction_id\":\"019f400f-b2a4-72cb-b56b-624366a67dd0\",\"transaction_number\":\"TRX-INC-20260708044958\",\"transaction_date\":\"2026-07-08T00:00:00.000000Z\",\"total_amount\":1000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":1000000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":1000000,\"description\":\"Dana Bantuan Organisasi Lainnya Sumbangan Musywil Bagus Irawan\"}]}', '110.137.100.73', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-07 21:49:58', '2026-07-07 21:49:58'),
('019f400f-b2bc-70f8-9a14-4830e0022d13', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f4009-7e51-733a-b421-ef1a81a4d3b0', '{\"allocated_balance\":\"405484747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"405484747.00\"}', '{\"allocated_balance\":406484747,\"used_balance\":\"0.00\",\"remaining_balance\":406484747}', '110.137.100.73', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f400f-b2a4-72cb-b56b-624366a67dd0\",\"transaction_number\":\"TRX-INC-20260708044958\",\"income_amount\":1000000}', '2026-07-07 21:49:58', '2026-07-07 21:49:58'),
('019f4074-7d9c-7136-a75f-cc45989b7b80', '019f3c29-d287-707a-8a4d-25d249fe7e86', 'update', 'configuration', 'Configuration updated', NULL, NULL, '[]', '{\"app_name\":\"Keuangan PWA JATIM\",\"app_description\":\"Sistem Informasi Akuntansi untuk pengelolaan keuangan, jurnal, dan laporan secara terintegrasi.\",\"app_tagline\":\"Sistem Informasi Akuntansi untuk pengelolaan keuangan, jurnal, dan laporan secara terintegrasi.\",\"app_logo\":{}}', '110.137.100.73', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"app_logo\":{},\"app_background_login\":null}', '2026-07-07 23:40:03', '2026-07-07 23:40:03'),
('019f44c1-789d-73eb-b8b0-6078f06f924e', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'CHART_OF_ACCOUNT', 'COA Kas Baru berhasil dibuat.', 'App\\Models\\ChartOfAccount', '019f44c1-788f-7306-96fd-3413fca1f99f', '[]', '{\"code\":\"60000\",\"name\":\"Kas Baru\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"parent_id\":null,\"level\":1,\"order\":6,\"normal_balance\":\"DEBIT\",\"description\":\"Kas Baru testing\",\"is_active\":true,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"id\":\"019f44c1-788f-7306-96fd-3413fca1f99f\",\"updated_at\":\"2026-07-09T02:42:37.000000Z\",\"created_at\":\"2026-07-09T02:42:37.000000Z\"}', '114.8.230.243', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"parent_id\":null,\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"normal_balance\":\"DEBIT\",\"is_active\":\"1\"}', '2026-07-08 19:42:37', '2026-07-08 19:42:37'),
('019f44c2-6498-71a7-a799-45130b057695', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'created', 'CHART_OF_ACCOUNT', 'COA Sub Kas Baru 1 berhasil dibuat.', 'App\\Models\\ChartOfAccount', '019f44c2-6489-7189-9d2a-0c829b0e6c15', '[]', '{\"code\":\"60100\",\"name\":\"Sub Kas Baru 1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"parent_id\":\"019f44c1-788f-7306-96fd-3413fca1f99f\",\"level\":2,\"order\":1,\"normal_balance\":\"DEBIT\",\"description\":null,\"is_active\":true,\"created_by\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"id\":\"019f44c2-6489-7189-9d2a-0c829b0e6c15\",\"updated_at\":\"2026-07-09T02:43:38.000000Z\",\"created_at\":\"2026-07-09T02:43:38.000000Z\"}', '114.8.230.243', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"parent_id\":\"019f44c1-788f-7306-96fd-3413fca1f99f\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"normal_balance\":\"DEBIT\",\"is_active\":\"1\"}', '2026-07-08 19:43:38', '2026-07-08 19:43:38');
INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `module`, `description`, `subject_type`, `subject_id`, `old_values`, `new_values`, `ip_address`, `user_agent`, `additional_data`, `created_at`, `updated_at`) VALUES
('019f44c3-abb2-7357-9571-f6c88b105a75', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'sync', 'USER_ACCOUNT', 'Sinkronisasi akun untuk pengguna Bendahara', 'App\\Models\\User', '019f3c29-d401-730d-a58f-9fac0918ea2c', '{\"coa_ids\":[\"02e0f19e-fe7c-4af8-9840-eba30817c41e\",\"03ea188f-4a5a-49a1-a360-afbcee575894\",\"05b667e2-951b-4735-83e7-6761a059c2d4\",\"060c7786-2d80-4af6-a7f3-4d8dba51c049\",\"06165d42-2fb0-4393-9a8f-f445880be667\",\"06d411e4-689d-4f6d-bb2e-c9f44aeab33d\",\"0b374ecb-94f5-41ba-9e48-36082946c81e\",\"0ba8ade3-8dc6-4ffb-89c7-50e579be3146\",\"0dcf66b6-8ba6-40b3-89e7-282aa84c03e5\",\"10af2cdc-0754-4d24-871d-46ad9bdb8f98\",\"11a7616a-06e7-4757-84c2-79d6f91406ef\",\"132603d3-0f4b-4c28-8e39-e05a89642d98\",\"1f3e9890-fa94-4611-9531-cbabb4f9091e\",\"225f7e5c-8132-4aff-bccd-9c1e07ebc65f\",\"22863257-23b1-40b2-81b5-625a579e4887\",\"23ce33b2-eb43-4bad-aeff-715f9e4f8a06\",\"258febc1-f6d2-49bd-be01-08741fe511da\",\"2697d4da-bd60-4ada-9ab3-8f75a3dcc793\",\"27b3424e-5e94-48db-8d12-af1165d6ed2f\",\"27ef2784-5982-421c-bb3f-96a51777fbf3\",\"290bef48-1174-4bb0-8c01-0d5b17108128\",\"29b45798-4894-4b34-8b98-6763e573bb7a\",\"2c677359-98b2-440d-ae53-dcae5095841e\",\"2f1adb90-a4d5-4c63-8ed9-7f4109b1890d\",\"2fc91e28-cafa-42d5-a383-960bd2304d79\",\"2ffe0b7f-2bc6-4dac-9940-e53393a90f58\",\"34946f7c-6f05-4bb7-ba94-01afba90ff43\",\"36c76a75-5dd6-48bd-b474-bde2c2b9e7d3\",\"37aaef0a-ab7e-4bc1-8f6f-fb6028a3277e\",\"3f354843-3d12-4886-ae4d-a0cf7ff5c6c4\",\"3fab3482-9af2-4d47-92f0-b6a42980348c\",\"41dd99c8-6337-4697-ac01-ffb1bf79540b\",\"41fbc782-5794-409d-8507-f99fed76fe8b\",\"44fb2678-eb3c-4af8-88ea-e9654dcc88ac\",\"46a3a069-49e2-403a-a208-ae7cf8219249\",\"4755ebf2-c52b-4f64-8281-176d879ac1aa\",\"48b61973-5d46-469e-9ae3-afd4a3be5fae\",\"4a6caa70-24ca-45b3-b752-57f72b56a930\",\"4b7fc140-c63d-4001-8704-c0ece2a4ec7b\",\"4cf55425-0f8b-4b44-ad53-26c1dab32558\",\"4dde9b7f-95c6-47e7-ade5-9cb403950064\",\"56962e72-737c-4932-a1c1-4d7cf41db900\",\"58890adf-02ff-4976-9357-7840f15e5c8d\",\"591c8ff4-1887-4259-b966-890f724424e3\",\"5afb25f5-ea51-4978-8159-60aef27c29e0\",\"5b11c6ca-5d87-4837-ad30-e91953c5a1a9\",\"5c2b1cd4-d67d-4a13-8d27-ca888f5f02f2\",\"5e5b9787-1c85-40fb-a997-52b1bb7e7ed5\",\"605dc218-d091-47b2-a7f2-0effb402d2d4\",\"610faad3-6e8f-4791-8608-cb0eb19688be\",\"638a512b-cab3-4d52-b467-7193ccc1feb3\",\"640af4d9-6891-4840-9a50-8c009ca3f486\",\"6486b0ff-c08e-4b4a-b6bd-6cf40c1d93dd\",\"6865e20e-43b2-48ce-b3a3-653078468886\",\"69339cd7-dd8c-4966-bb0d-ad14dc3d9bd1\",\"6afbe99c-65df-4128-a16c-fa5827c8347f\",\"6f9dd6c1-e799-4bef-8a44-04ce7e7a1dec\",\"700e4c22-26f3-43ce-8ef0-b32b8920e93c\",\"724f6c78-1a44-4f74-bf40-fd9b43963ba3\",\"76a20fad-6338-4545-9a9e-4acc355eeb3e\",\"7b4c8d7b-ff7f-436d-b874-a6058efa0f36\",\"7e3a051c-a73b-485c-865c-f7259792967d\",\"7fecbf43-5f25-49e8-8068-a4aed1808cd4\",\"80489af9-a27f-469d-aabb-16681c5cf916\",\"81f580a0-1436-4a81-84a3-93d197075930\",\"852153e1-1905-487f-9176-56fac68a9968\",\"89b2bd63-45a5-4376-9301-75f7c5c6869f\",\"8dcd1a44-abb4-4383-8182-51e4416392e8\",\"8e772f65-a3e0-4d09-8783-132811d324b5\",\"8eafa0f0-e378-418c-a53a-73a879cb392f\",\"8f516b93-3983-41be-a7d9-37a2364355b3\",\"92aa553e-6ee4-48e9-a7f7-02acaba8ecd0\",\"931fa6b3-6053-4b8e-8f45-5dc87115dcb6\",\"98c63964-bd5e-4fe0-886b-ff6663c73fdc\",\"99796640-5f95-4ad6-bf89-7121444ade40\",\"9d1306f9-10c9-4820-bc3e-e2486c49e8cd\",\"9f5ccef8-b43a-4686-9dc3-d6199a74ce89\",\"9fa5994e-9de7-4284-af4f-df5f7490e4a6\",\"a32ae99f-0c4c-44e5-9282-6fc6f4cf51de\",\"a5e6167d-c666-42f0-bc88-b75ac70e6ab0\",\"ac1a013b-b327-4084-8d52-52440f6bcb54\",\"ac8a1463-4a4c-4cb1-a0e4-b00c2d9cf522\",\"afd34085-9d09-4ff0-9d09-c07c85a6b595\",\"b01e653a-9e3b-44d1-a81c-f981c7b2acbe\",\"b2046255-9dc2-406b-ae9a-fd47cf6bddb2\",\"b27bdc66-661a-4dd0-9831-e779426c372a\",\"b472d3a2-353d-484e-accf-1c80167f6000\",\"b840fcec-a9c1-4afc-9824-f6fca25211ba\",\"b89aeb06-4c14-44b2-9a3a-97f8619e47c8\",\"bb63ab0e-2314-4079-b255-915ed295b322\",\"bbca9830-3900-41a5-a233-774c581874e8\",\"bbd6859d-aae9-435a-bf0a-7543c4fb6321\",\"bca4163c-d2f5-4b28-a022-83059cfecaa2\",\"bed710fe-7648-4fe7-9b9b-b1f2f960cee7\",\"c1211db4-92a4-4343-9bf6-10c9adeeb912\",\"c2f2d0bb-303d-4913-8df0-c6030afe4501\",\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"cbf1ae59-be94-468d-a0b1-14f125f5b831\",\"cc07e75b-1119-4e8f-b7d1-f782842d1770\",\"cc841ad2-0e5b-43f7-909e-d31ce5563706\",\"cda7e544-e669-4f9c-9b6f-f6ba07500cef\",\"ce1441a5-5f7e-46d7-8cc7-3f9bae862ae3\",\"cfe855aa-e85d-40f2-96a4-e34d46c904f3\",\"d40db36e-328b-43fd-ae0a-2fb09fcef5c2\",\"d43c41c7-4cfa-42c7-81be-b99ca8e1621b\",\"d650d3c0-ca9f-4587-9a11-cdfefa1e3115\",\"d7305d55-a17b-4f18-bb71-83e624522e8f\",\"d73463de-abb8-4e44-9f77-92d375acb1e8\",\"d7d9901c-9785-4410-aae6-2c4236b5648d\",\"d96a0838-d30f-4e12-93a5-f61ee741d39d\",\"d9c57730-6928-4e5d-ac29-bf2f6dd9895f\",\"db8f505b-44a6-45f5-8d10-f8d15bea1af4\",\"dc16f8fe-a09e-4399-a227-7320a3f32feb\",\"dd9958f5-23ee-467f-be58-8bd553eceeac\",\"dead6c90-51ca-4b56-b953-9ce8a362108f\",\"e2eda7c2-e10e-47e3-bb99-9a68bd2294cf\",\"e5032396-b524-43e4-aaf0-c8de44d4c99a\",\"e8d6d3cc-494f-463d-a264-763e3e72c155\",\"f0ab0d30-708d-4536-b5c6-448b058d7a75\",\"f415012f-1f66-4b77-a725-6682e2ffd02b\",\"f67c7605-fd55-4d04-8065-738b2feff09a\",\"f6c24672-0eeb-4f58-a71c-8f8bad115f5b\",\"f8832dae-00e3-4d46-9e05-991b3e02f16a\",\"fc646e17-8f59-466f-8bea-74a29c39bdad\",\"fee7e8c7-a5e4-4a0f-bf77-62db604ee500\",\"ff336d58-31ed-49b6-8df8-6ea403800108\"]}', '{\"coa_ids\":[\"060c7786-2d80-4af6-a7f3-4d8dba51c049\",\"d9c57730-6928-4e5d-ac29-bf2f6dd9895f\",\"7e3a051c-a73b-485c-865c-f7259792967d\",\"fc646e17-8f59-466f-8bea-74a29c39bdad\",\"80489af9-a27f-469d-aabb-16681c5cf916\",\"ff336d58-31ed-49b6-8df8-6ea403800108\",\"fee7e8c7-a5e4-4a0f-bf77-62db604ee500\",\"700e4c22-26f3-43ce-8ef0-b32b8920e93c\",\"f67c7605-fd55-4d04-8065-738b2feff09a\",\"6865e20e-43b2-48ce-b3a3-653078468886\",\"27ef2784-5982-421c-bb3f-96a51777fbf3\",\"9f5ccef8-b43a-4686-9dc3-d6199a74ce89\",\"bbca9830-3900-41a5-a233-774c581874e8\",\"d96a0838-d30f-4e12-93a5-f61ee741d39d\",\"e8d6d3cc-494f-463d-a264-763e3e72c155\",\"cda7e544-e669-4f9c-9b6f-f6ba07500cef\",\"46a3a069-49e2-403a-a208-ae7cf8219249\",\"10af2cdc-0754-4d24-871d-46ad9bdb8f98\",\"41fbc782-5794-409d-8507-f99fed76fe8b\",\"225f7e5c-8132-4aff-bccd-9c1e07ebc65f\",\"44fb2678-eb3c-4af8-88ea-e9654dcc88ac\",\"258febc1-f6d2-49bd-be01-08741fe511da\",\"8f516b93-3983-41be-a7d9-37a2364355b3\",\"05b667e2-951b-4735-83e7-6761a059c2d4\",\"9fa5994e-9de7-4284-af4f-df5f7490e4a6\",\"89b2bd63-45a5-4376-9301-75f7c5c6869f\",\"d7305d55-a17b-4f18-bb71-83e624522e8f\",\"f6c24672-0eeb-4f58-a71c-8f8bad115f5b\",\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"56962e72-737c-4932-a1c1-4d7cf41db900\",\"0ba8ade3-8dc6-4ffb-89c7-50e579be3146\",\"06165d42-2fb0-4393-9a8f-f445880be667\",\"852153e1-1905-487f-9176-56fac68a9968\",\"41dd99c8-6337-4697-ac01-ffb1bf79540b\",\"cc841ad2-0e5b-43f7-909e-d31ce5563706\",\"bca4163c-d2f5-4b28-a022-83059cfecaa2\",\"638a512b-cab3-4d52-b467-7193ccc1feb3\",\"7b4c8d7b-ff7f-436d-b874-a6058efa0f36\",\"29b45798-4894-4b34-8b98-6763e573bb7a\",\"290bef48-1174-4bb0-8c01-0d5b17108128\",\"a5e6167d-c666-42f0-bc88-b75ac70e6ab0\",\"f0ab0d30-708d-4536-b5c6-448b058d7a75\",\"dd9958f5-23ee-467f-be58-8bd553eceeac\",\"1f3e9890-fa94-4611-9531-cbabb4f9091e\",\"58890adf-02ff-4976-9357-7840f15e5c8d\",\"b840fcec-a9c1-4afc-9824-f6fca25211ba\",\"06d411e4-689d-4f6d-bb2e-c9f44aeab33d\",\"2fc91e28-cafa-42d5-a383-960bd2304d79\",\"f415012f-1f66-4b77-a725-6682e2ffd02b\",\"3f354843-3d12-4886-ae4d-a0cf7ff5c6c4\",\"ce1441a5-5f7e-46d7-8cc7-3f9bae862ae3\",\"99796640-5f95-4ad6-bf89-7121444ade40\",\"3fab3482-9af2-4d47-92f0-b6a42980348c\",\"db8f505b-44a6-45f5-8d10-f8d15bea1af4\",\"34946f7c-6f05-4bb7-ba94-01afba90ff43\",\"931fa6b3-6053-4b8e-8f45-5dc87115dcb6\",\"d40db36e-328b-43fd-ae0a-2fb09fcef5c2\",\"27b3424e-5e94-48db-8d12-af1165d6ed2f\",\"6afbe99c-65df-4128-a16c-fa5827c8347f\",\"640af4d9-6891-4840-9a50-8c009ca3f486\",\"bbd6859d-aae9-435a-bf0a-7543c4fb6321\",\"ac1a013b-b327-4084-8d52-52440f6bcb54\",\"d7d9901c-9785-4410-aae6-2c4236b5648d\",\"4b7fc140-c63d-4001-8704-c0ece2a4ec7b\",\"5c2b1cd4-d67d-4a13-8d27-ca888f5f02f2\",\"2c677359-98b2-440d-ae53-dcae5095841e\",\"4cf55425-0f8b-4b44-ad53-26c1dab32558\",\"d43c41c7-4cfa-42c7-81be-b99ca8e1621b\",\"2f1adb90-a4d5-4c63-8ed9-7f4109b1890d\",\"dead6c90-51ca-4b56-b953-9ce8a362108f\",\"e2eda7c2-e10e-47e3-bb99-9a68bd2294cf\",\"8dcd1a44-abb4-4383-8182-51e4416392e8\",\"22863257-23b1-40b2-81b5-625a579e4887\",\"b27bdc66-661a-4dd0-9831-e779426c372a\",\"48b61973-5d46-469e-9ae3-afd4a3be5fae\",\"37aaef0a-ab7e-4bc1-8f6f-fb6028a3277e\",\"4a6caa70-24ca-45b3-b752-57f72b56a930\",\"8eafa0f0-e378-418c-a53a-73a879cb392f\",\"8e772f65-a3e0-4d09-8783-132811d324b5\",\"c1211db4-92a4-4343-9bf6-10c9adeeb912\",\"36c76a75-5dd6-48bd-b474-bde2c2b9e7d3\",\"605dc218-d091-47b2-a7f2-0effb402d2d4\",\"6486b0ff-c08e-4b4a-b6bd-6cf40c1d93dd\",\"03ea188f-4a5a-49a1-a360-afbcee575894\",\"a32ae99f-0c4c-44e5-9282-6fc6f4cf51de\",\"cbf1ae59-be94-468d-a0b1-14f125f5b831\",\"5afb25f5-ea51-4978-8159-60aef27c29e0\",\"610faad3-6e8f-4791-8608-cb0eb19688be\",\"69339cd7-dd8c-4966-bb0d-ad14dc3d9bd1\",\"b01e653a-9e3b-44d1-a81c-f981c7b2acbe\",\"2697d4da-bd60-4ada-9ab3-8f75a3dcc793\",\"02e0f19e-fe7c-4af8-9840-eba30817c41e\",\"98c63964-bd5e-4fe0-886b-ff6663c73fdc\",\"4dde9b7f-95c6-47e7-ade5-9cb403950064\",\"dc16f8fe-a09e-4399-a227-7320a3f32feb\",\"9d1306f9-10c9-4820-bc3e-e2486c49e8cd\",\"0dcf66b6-8ba6-40b3-89e7-282aa84c03e5\",\"e5032396-b524-43e4-aaf0-c8de44d4c99a\",\"b472d3a2-353d-484e-accf-1c80167f6000\",\"724f6c78-1a44-4f74-bf40-fd9b43963ba3\",\"d73463de-abb8-4e44-9f77-92d375acb1e8\",\"591c8ff4-1887-4259-b966-890f724424e3\",\"132603d3-0f4b-4c28-8e39-e05a89642d98\",\"cfe855aa-e85d-40f2-96a4-e34d46c904f3\",\"ac8a1463-4a4c-4cb1-a0e4-b00c2d9cf522\",\"4755ebf2-c52b-4f64-8281-176d879ac1aa\",\"bb63ab0e-2314-4079-b255-915ed295b322\",\"23ce33b2-eb43-4bad-aeff-715f9e4f8a06\",\"6f9dd6c1-e799-4bef-8a44-04ce7e7a1dec\",\"c2f2d0bb-303d-4913-8df0-c6030afe4501\",\"b89aeb06-4c14-44b2-9a3a-97f8619e47c8\",\"d650d3c0-ca9f-4587-9a11-cdfefa1e3115\",\"0b374ecb-94f5-41ba-9e48-36082946c81e\",\"5b11c6ca-5d87-4837-ad30-e91953c5a1a9\",\"81f580a0-1436-4a81-84a3-93d197075930\",\"cc07e75b-1119-4e8f-b7d1-f782842d1770\",\"b2046255-9dc2-406b-ae9a-fd47cf6bddb2\",\"2ffe0b7f-2bc6-4dac-9940-e53393a90f58\",\"afd34085-9d09-4ff0-9d09-c07c85a6b595\",\"5e5b9787-1c85-40fb-a997-52b1bb7e7ed5\",\"11a7616a-06e7-4757-84c2-79d6f91406ef\",\"76a20fad-6338-4545-9a9e-4acc355eeb3e\"]}', '114.8.230.243', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"user_id\":\"019f3c29-d401-730d-a58f-9fac0918ea2c\",\"added\":[],\"removed\":[\"7fecbf43-5f25-49e8-8068-a4aed1808cd4\",\"92aa553e-6ee4-48e9-a7f7-02acaba8ecd0\",\"bed710fe-7648-4fe7-9b9b-b1f2f960cee7\",\"f8832dae-00e3-4d46-9e05-991b3e02f16a\"]}', '2026-07-08 19:45:02', '2026-07-08 19:45:02'),
('019f5a5c-e6ea-7025-90bc-74c11ee3f806', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a5c-e6cf-70f7-b5af-941fad678ec1', '[]', '{\"transaction_id\":\"019f5a5c-e6cf-70f7-b5af-941fad678ec1\",\"transaction_number\":\"TRX-INC-20260713072425\",\"transaction_date\":\"2023-01-04T00:00:00.000000Z\",\"total_amount\":1000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":1000000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":1000000,\"description\":\"Dana Bantuan Organisasi Lainnya Sumbangan Musywil Bagus Irawan\"}]}', '114.8.231.24', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 00:24:25', '2026-07-13 00:24:25'),
('019f5a5c-e6ec-71f4-bf7d-02b81c59d011', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"405484747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"405484747.00\"}', '{\"allocated_balance\":406484747,\"used_balance\":\"0.00\",\"remaining_balance\":406484747}', '114.8.231.24', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a5c-e6cf-70f7-b5af-941fad678ec1\",\"transaction_number\":\"TRX-INC-20260713072425\",\"income_amount\":1000000}', '2026-07-13 00:24:25', '2026-07-13 00:24:25'),
('019f5a66-a436-707e-bc8d-3eb361a4fdd6', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a66-a420-702b-b44e-f71c9b8f50d0', '[]', '{\"transaction_id\":\"019f5a66-a420-702b-b44e-f71c9b8f50d0\",\"transaction_number\":\"TRX-INC-20260713073503\",\"transaction_date\":\"2023-01-04T00:00:00.000000Z\",\"total_amount\":25000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":25000000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":25000000,\"description\":\"Dana Bantuan Organisasi Lainnya Sumbangan Muswyil UMsurabaya\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 00:35:03', '2026-07-13 00:35:03'),
('019f5a66-a438-72a8-8b4e-0f7a48ecfe6d', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"406484747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"406484747.00\"}', '{\"allocated_balance\":431484747,\"used_balance\":\"0.00\",\"remaining_balance\":431484747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a66-a420-702b-b44e-f71c9b8f50d0\",\"transaction_number\":\"TRX-INC-20260713073503\",\"income_amount\":25000000}', '2026-07-13 00:35:03', '2026-07-13 00:35:03'),
('019f5a68-434b-73b6-bc8b-089c3d6de940', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a68-4333-727c-a353-a2d3cf713a52', '[]', '{\"transaction_id\":\"019f5a68-4333-727c-a353-a2d3cf713a52\",\"transaction_number\":\"TRX-INC-20260713073650\",\"transaction_date\":\"2023-01-04T00:00:00.000000Z\",\"total_amount\":300000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":300000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":300000,\"description\":\"Dana Bantuan Organisasi Lainnya pemasukan\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 00:36:50', '2026-07-13 00:36:50'),
('019f5a68-434f-73b6-b5a0-f4f6a93fb28e', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"431484747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"431484747.00\"}', '{\"allocated_balance\":431784747,\"used_balance\":\"0.00\",\"remaining_balance\":431784747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a68-4333-727c-a353-a2d3cf713a52\",\"transaction_number\":\"TRX-INC-20260713073650\",\"income_amount\":300000}', '2026-07-13 00:36:50', '2026-07-13 00:36:50'),
('019f5a6a-4584-7302-a606-8470101d02fc', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a6a-456e-7266-81df-df9034109647', '[]', '{\"transaction_id\":\"019f5a6a-456e-7266-81df-df9034109647\",\"transaction_number\":\"TRX-INC-20260713073901\",\"transaction_date\":\"2026-07-13T00:00:00.000000Z\",\"total_amount\":3000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":3000000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":3000000,\"description\":\"Dana Bantuan Organisasi Lainnya Sumbangan Musywil SMP M 2 Taman\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 00:39:01', '2026-07-13 00:39:01'),
('019f5a6a-4586-700b-ace5-cc2783f500aa', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"431784747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"431784747.00\"}', '{\"allocated_balance\":434784747,\"used_balance\":\"0.00\",\"remaining_balance\":434784747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a6a-456e-7266-81df-df9034109647\",\"transaction_number\":\"TRX-INC-20260713073901\",\"income_amount\":3000000}', '2026-07-13 00:39:01', '2026-07-13 00:39:01'),
('019f5a6a-487c-719c-af37-05cddfd757c1', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a6a-4863-7167-9344-ab80c6014ef8', '[]', '{\"transaction_id\":\"019f5a6a-4863-7167-9344-ab80c6014ef8\",\"transaction_number\":\"TRX-INC-20260713073902\",\"transaction_date\":\"2026-07-13T00:00:00.000000Z\",\"total_amount\":3000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":3000000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":3000000,\"description\":\"Dana Bantuan Organisasi Lainnya Sumbangan Musywil SMP M 2 Taman\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 00:39:02', '2026-07-13 00:39:02'),
('019f5a6a-487d-726c-9e36-4043b679db75', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"434784747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"434784747.00\"}', '{\"allocated_balance\":437784747,\"used_balance\":\"0.00\",\"remaining_balance\":437784747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a6a-4863-7167-9344-ab80c6014ef8\",\"transaction_number\":\"TRX-INC-20260713073902\",\"income_amount\":3000000}', '2026-07-13 00:39:02', '2026-07-13 00:39:02'),
('019f5a6e-559c-7302-b457-02c4a631f018', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a6e-5585-7026-a4a1-a0516e80837f', '[]', '{\"transaction_id\":\"019f5a6e-5585-7026-a4a1-a0516e80837f\",\"transaction_number\":\"TRX-INC-20260713074328\",\"transaction_date\":\"2023-01-05T00:00:00.000000Z\",\"total_amount\":7500000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":7500000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":7500000,\"description\":\"Dana Bantuan Organisasi Lainnya Sumbangan RSA Dahlan Kediri\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 00:43:28', '2026-07-13 00:43:28'),
('019f5a6e-559f-718f-9571-564fc9c2b55c', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"437784747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"437784747.00\"}', '{\"allocated_balance\":445284747,\"used_balance\":\"0.00\",\"remaining_balance\":445284747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a6e-5585-7026-a4a1-a0516e80837f\",\"transaction_number\":\"TRX-INC-20260713074328\",\"income_amount\":7500000}', '2026-07-13 00:43:28', '2026-07-13 00:43:28'),
('019f5a71-2d0f-73a1-bb90-44385d7a1468', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a71-2cf2-7333-ab04-1a2fdd0a8c46', '[]', '{\"transaction_id\":\"019f5a71-2cf2-7333-ab04-1a2fdd0a8c46\",\"transaction_number\":\"TRX-INC-20260713074634\",\"transaction_date\":\"2023-01-05T00:00:00.000000Z\",\"total_amount\":5000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":5000000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":5000000,\"description\":\"Dana Bantuan Organisasi Lainnya Sumbangan SMA M 2 Surabaya\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 00:46:34', '2026-07-13 00:46:34'),
('019f5a71-2d11-7185-a29e-ac01630a9420', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"445284747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"445284747.00\"}', '{\"allocated_balance\":450284747,\"used_balance\":\"0.00\",\"remaining_balance\":450284747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a71-2cf2-7333-ab04-1a2fdd0a8c46\",\"transaction_number\":\"TRX-INC-20260713074634\",\"income_amount\":5000000}', '2026-07-13 00:46:34', '2026-07-13 00:46:34'),
('019f5a73-af18-7233-8051-672601464d65', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a73-af00-70f5-bee5-36b93b290f3b', '[]', '{\"transaction_id\":\"019f5a73-af00-70f5-bee5-36b93b290f3b\",\"transaction_number\":\"TRX-INC-20260713074918\",\"transaction_date\":\"2023-01-05T00:00:00.000000Z\",\"total_amount\":10000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":10000000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":10000000,\"description\":\"Dana Bantuan Organisasi Lainnya Sumbangan RSI Aisyiyah Malang\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 00:49:18', '2026-07-13 00:49:18'),
('019f5a73-af1c-7151-afc9-9eb7f343750c', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"450284747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"450284747.00\"}', '{\"allocated_balance\":460284747,\"used_balance\":\"0.00\",\"remaining_balance\":460284747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a73-af00-70f5-bee5-36b93b290f3b\",\"transaction_number\":\"TRX-INC-20260713074918\",\"income_amount\":10000000}', '2026-07-13 00:49:18', '2026-07-13 00:49:18'),
('019f5a75-d0da-73ab-a94d-8e912e1f9ea1', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a75-d0bd-715b-847f-781d19ba464b', '[]', '{\"transaction_id\":\"019f5a75-d0bd-715b-847f-781d19ba464b\",\"transaction_number\":\"TRX-INC-20260713075138\",\"transaction_date\":\"2023-01-05T00:00:00.000000Z\",\"total_amount\":20000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":20000000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":20000000,\"description\":\"Dana Bantuan Organisasi Lainnya Sumbangan Musywil RSIA Nganjuk\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 00:51:38', '2026-07-13 00:51:38'),
('019f5a75-d0dc-7339-be40-2653e6b94f1e', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"460284747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"460284747.00\"}', '{\"allocated_balance\":480284747,\"used_balance\":\"0.00\",\"remaining_balance\":480284747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a75-d0bd-715b-847f-781d19ba464b\",\"transaction_number\":\"TRX-INC-20260713075138\",\"income_amount\":20000000}', '2026-07-13 00:51:38', '2026-07-13 00:51:38'),
('019f5a76-00e1-71c2-b539-4043b938426a', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a76-00c9-7150-9f9a-974c7e377421', '[]', '{\"transaction_id\":\"019f5a76-00c9-7150-9f9a-974c7e377421\",\"transaction_number\":\"TRX-INC-20260713075150\",\"transaction_date\":\"2023-01-05T00:00:00.000000Z\",\"total_amount\":20000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":20000000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":20000000,\"description\":\"Dana Bantuan Organisasi Lainnya Sumbangan Musywil RSIA Nganjuk\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 00:51:50', '2026-07-13 00:51:50'),
('019f5a76-00e3-7278-8df6-667b5954ec04', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"480284747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"480284747.00\"}', '{\"allocated_balance\":500284747,\"used_balance\":\"0.00\",\"remaining_balance\":500284747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a76-00c9-7150-9f9a-974c7e377421\",\"transaction_number\":\"TRX-INC-20260713075150\",\"income_amount\":20000000}', '2026-07-13 00:51:50', '2026-07-13 00:51:50'),
('019f5a78-97bb-70e2-8af3-5b2887f2a676', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a78-97a9-73e5-8b10-41ab0d291585', '[]', '{\"transaction_id\":\"019f5a78-97a9-73e5-8b10-41ab0d291585\",\"transaction_number\":\"TRX-INC-20260713075440\",\"transaction_date\":\"2023-01-05T00:00:00.000000Z\",\"total_amount\":5000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":5000000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":5000000,\"description\":\"Dana Bantuan Organisasi Lainnya Sumbangan Muswyil SMA M Sidoarjo\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 00:54:40', '2026-07-13 00:54:40'),
('019f5a78-97bd-73c9-acbe-2c79388c728c', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"500284747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"500284747.00\"}', '{\"allocated_balance\":505284747,\"used_balance\":\"0.00\",\"remaining_balance\":505284747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a78-97a9-73e5-8b10-41ab0d291585\",\"transaction_number\":\"TRX-INC-20260713075440\",\"income_amount\":5000000}', '2026-07-13 00:54:40', '2026-07-13 00:54:40'),
('019f5a7a-f379-70fb-97e8-0108c02f2115', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a7a-f366-7187-8974-143ae9e74c16', '[]', '{\"transaction_id\":\"019f5a7a-f366-7187-8974-143ae9e74c16\",\"transaction_number\":\"TRX-INC-20260713075714\",\"transaction_date\":\"2023-01-06T00:00:00.000000Z\",\"total_amount\":1500000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":1500000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":1500000,\"description\":\"Dana Bantuan Organisasi Lainnya Sumbangan Muswyil SDM 1 Sidoarjo\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 00:57:15', '2026-07-13 00:57:15'),
('019f5a7a-f37e-7234-a858-f5eebd7ae9ac', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"505284747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"505284747.00\"}', '{\"allocated_balance\":506784747,\"used_balance\":\"0.00\",\"remaining_balance\":506784747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a7a-f366-7187-8974-143ae9e74c16\",\"transaction_number\":\"TRX-INC-20260713075714\",\"income_amount\":1500000}', '2026-07-13 00:57:15', '2026-07-13 00:57:15'),
('019f5a7c-e09b-7251-b986-05df48447379', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a7c-e07d-72dd-99a3-6361ae7bad2b', '[]', '{\"transaction_id\":\"019f5a7c-e07d-72dd-99a3-6361ae7bad2b\",\"transaction_number\":\"TRX-INC-20260713075921\",\"transaction_date\":\"2023-01-06T00:00:00.000000Z\",\"total_amount\":3000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":3000000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":3000000,\"description\":\"Dana Bantuan Organisasi Lainnya Sumbangan Muswyil SMP M 1 Sidoarjo\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 00:59:21', '2026-07-13 00:59:21'),
('019f5a7c-e09d-7161-8e80-72f4ed790742', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"506784747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"506784747.00\"}', '{\"allocated_balance\":509784747,\"used_balance\":\"0.00\",\"remaining_balance\":509784747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a7c-e07d-72dd-99a3-6361ae7bad2b\",\"transaction_number\":\"TRX-INC-20260713075921\",\"income_amount\":3000000}', '2026-07-13 00:59:21', '2026-07-13 00:59:21'),
('019f5a7e-aee8-711e-95a4-0e4de9ce04b1', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a7e-aed9-7156-80eb-a011650c0f0a', '[]', '{\"transaction_id\":\"019f5a7e-aed9-7156-80eb-a011650c0f0a\",\"transaction_number\":\"TRX-INC-20260713080119\",\"transaction_date\":\"2023-01-06T00:00:00.000000Z\",\"total_amount\":2250000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":2250000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"89b2bd63-45a5-4376-9301-75f7c5c6869f\",\"position\":\"CREDIT\",\"amount\":2250000,\"description\":\"Dana Wajib Organisasi Pembayaran Simpanan Wajib Organisasi\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 01:01:19', '2026-07-13 01:01:19'),
('019f5a7e-aeea-7211-9aa1-4a46bc9b793d', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"509784747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"509784747.00\"}', '{\"allocated_balance\":512034747,\"used_balance\":\"0.00\",\"remaining_balance\":512034747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a7e-aed9-7156-80eb-a011650c0f0a\",\"transaction_number\":\"TRX-INC-20260713080119\",\"income_amount\":2250000}', '2026-07-13 01:01:19', '2026-07-13 01:01:19'),
('019f5a80-849c-71d1-a4b9-20a4255ef090', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a80-8486-705f-9dbc-29b804e92ecb', '[]', '{\"transaction_id\":\"019f5a80-8486-705f-9dbc-29b804e92ecb\",\"transaction_number\":\"TRX-INC-20260713080319\",\"transaction_date\":\"2023-01-06T00:00:00.000000Z\",\"total_amount\":5000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":5000000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":5000000,\"description\":\"Dana Bantuan Organisasi Lainnya Sumbangan Muswyil UMSIDA\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 01:03:19', '2026-07-13 01:03:19'),
('019f5a80-849e-7184-a95a-b92209accd1a', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"512034747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"512034747.00\"}', '{\"allocated_balance\":517034747,\"used_balance\":\"0.00\",\"remaining_balance\":517034747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a80-8486-705f-9dbc-29b804e92ecb\",\"transaction_number\":\"TRX-INC-20260713080319\",\"income_amount\":5000000}', '2026-07-13 01:03:19', '2026-07-13 01:03:19'),
('019f5a82-b384-734d-9cfa-4f453fd0ae57', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a82-b36f-73c8-a3b5-a083246f5e42', '[]', '{\"transaction_id\":\"019f5a82-b36f-73c8-a3b5-a083246f5e42\",\"transaction_number\":\"TRX-INC-20260713080542\",\"transaction_date\":\"2023-01-06T00:00:00.000000Z\",\"total_amount\":10000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":10000000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":10000000,\"description\":\"Dana Bantuan Organisasi Lainnya Sumbangan Muswyil RS Aisyiyah Bojonegoro\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 01:05:42', '2026-07-13 01:05:42'),
('019f5a82-b387-7311-aba0-d881dc49ede1', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"517034747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"517034747.00\"}', '{\"allocated_balance\":527034747,\"used_balance\":\"0.00\",\"remaining_balance\":527034747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a82-b36f-73c8-a3b5-a083246f5e42\",\"transaction_number\":\"TRX-INC-20260713080542\",\"income_amount\":10000000}', '2026-07-13 01:05:42', '2026-07-13 01:05:42'),
('019f5a84-c8a9-7265-a58e-069e08b14688', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a84-c894-70ab-9b90-003766a788fd', '[]', '{\"transaction_id\":\"019f5a84-c894-70ab-9b90-003766a788fd\",\"transaction_number\":\"TRX-INC-20260713080759\",\"transaction_date\":\"2023-01-06T00:00:00.000000Z\",\"total_amount\":5000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":5000000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":5000000,\"description\":\"Dana Bantuan Organisasi Lainnya Sumbangan Muswyil SMA M Gresik\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 01:07:59', '2026-07-13 01:07:59'),
('019f5a84-c8ac-711a-bd99-1480235ab675', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"527034747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"527034747.00\"}', '{\"allocated_balance\":532034747,\"used_balance\":\"0.00\",\"remaining_balance\":532034747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a84-c894-70ab-9b90-003766a788fd\",\"transaction_number\":\"TRX-INC-20260713080759\",\"income_amount\":5000000}', '2026-07-13 01:07:59', '2026-07-13 01:07:59'),
('019f5a86-5857-712e-8e23-1610f95c03d0', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a86-5841-73ac-af09-9ab660c71f6c', '[]', '{\"transaction_id\":\"019f5a86-5841-73ac-af09-9ab660c71f6c\",\"transaction_number\":\"TRX-INC-20260713080941\",\"transaction_date\":\"2023-01-07T00:00:00.000000Z\",\"total_amount\":5000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":5000000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":5000000,\"description\":\"Dana Bantuan Organisasi Lainnya Sumbangan Muswyil UMJ\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 01:09:41', '2026-07-13 01:09:41'),
('019f5a86-585a-700c-aa02-0c1e4e15833c', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"532034747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"532034747.00\"}', '{\"allocated_balance\":537034747,\"used_balance\":\"0.00\",\"remaining_balance\":537034747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a86-5841-73ac-af09-9ab660c71f6c\",\"transaction_number\":\"TRX-INC-20260713080941\",\"income_amount\":5000000}', '2026-07-13 01:09:41', '2026-07-13 01:09:41'),
('019f5a87-c7dc-7078-8da6-f0642b428329', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a87-c7c7-729a-b661-b5b23c77387d', '[]', '{\"transaction_id\":\"019f5a87-c7c7-729a-b661-b5b23c77387d\",\"transaction_number\":\"TRX-INC-20260713081115\",\"transaction_date\":\"2023-01-09T00:00:00.000000Z\",\"total_amount\":2500000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":2500000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":2500000,\"description\":\"Dana Bantuan Organisasi Lainnya Irvand Gustari\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 01:11:15', '2026-07-13 01:11:15'),
('019f5a87-c7de-70a3-8e6d-e3a2249fb170', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"537034747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"537034747.00\"}', '{\"allocated_balance\":539534747,\"used_balance\":\"0.00\",\"remaining_balance\":539534747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a87-c7c7-729a-b661-b5b23c77387d\",\"transaction_number\":\"TRX-INC-20260713081115\",\"income_amount\":2500000}', '2026-07-13 01:11:15', '2026-07-13 01:11:15'),
('019f5a89-7236-739c-ba43-66bc097c18bd', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a89-721d-7303-9700-2756e50125c3', '[]', '{\"transaction_id\":\"019f5a89-721d-7303-9700-2756e50125c3\",\"transaction_number\":\"TRX-INC-20260713081304\",\"transaction_date\":\"2023-01-09T00:00:00.000000Z\",\"total_amount\":10000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":10000000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":10000000,\"description\":\"Dana Bantuan Organisasi Lainnya Mumtaz (Aad)\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 01:13:04', '2026-07-13 01:13:04'),
('019f5a89-7238-70f9-b877-aabdc65562c2', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"539534747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"539534747.00\"}', '{\"allocated_balance\":549534747,\"used_balance\":\"0.00\",\"remaining_balance\":549534747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a89-721d-7303-9700-2756e50125c3\",\"transaction_number\":\"TRX-INC-20260713081304\",\"income_amount\":10000000}', '2026-07-13 01:13:04', '2026-07-13 01:13:04'),
('019f5a8a-a95e-7327-bdbf-4dd0e2010dc6', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a8a-a94a-72f8-adb5-fa9d20e16305', '[]', '{\"transaction_id\":\"019f5a8a-a94a-72f8-adb5-fa9d20e16305\",\"transaction_number\":\"TRX-INC-20260713081424\",\"transaction_date\":\"2023-01-09T00:00:00.000000Z\",\"total_amount\":5000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":5000000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":5000000,\"description\":\"Dana Bantuan Organisasi Lainnya UM Lamongan\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 01:14:24', '2026-07-13 01:14:24');
INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `module`, `description`, `subject_type`, `subject_id`, `old_values`, `new_values`, `ip_address`, `user_agent`, `additional_data`, `created_at`, `updated_at`) VALUES
('019f5a8a-a961-71b3-9f1b-3e74f257f272', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"549534747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"549534747.00\"}', '{\"allocated_balance\":554534747,\"used_balance\":\"0.00\",\"remaining_balance\":554534747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a8a-a94a-72f8-adb5-fa9d20e16305\",\"transaction_number\":\"TRX-INC-20260713081424\",\"income_amount\":5000000}', '2026-07-13 01:14:24', '2026-07-13 01:14:24'),
('019f5a8b-dfbd-70aa-aeaf-961bd3fe2d6b', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a8b-dfa3-72c7-bef4-a32e6f80c785', '[]', '{\"transaction_id\":\"019f5a8b-dfa3-72c7-bef4-a32e6f80c785\",\"transaction_number\":\"TRX-INC-20260713081544\",\"transaction_date\":\"2023-01-09T00:00:00.000000Z\",\"total_amount\":1000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":1000000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":1000000,\"description\":\"Dana Bantuan Organisasi Lainnya M Idaham\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 01:15:44', '2026-07-13 01:15:44'),
('019f5a8b-dfbf-71d4-9643-9fa53bdd5e7b', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"554534747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"554534747.00\"}', '{\"allocated_balance\":555534747,\"used_balance\":\"0.00\",\"remaining_balance\":555534747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a8b-dfa3-72c7-bef4-a32e6f80c785\",\"transaction_number\":\"TRX-INC-20260713081544\",\"income_amount\":1000000}', '2026-07-13 01:15:44', '2026-07-13 01:15:44'),
('019f5a8d-179c-718a-b4cf-f8c063a9e2d0', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a8d-1786-7231-9c82-9452d0a7f4da', '[]', '{\"transaction_id\":\"019f5a8d-1786-7231-9c82-9452d0a7f4da\",\"transaction_number\":\"TRX-INC-20260713081703\",\"transaction_date\":\"2023-01-09T00:00:00.000000Z\",\"total_amount\":3000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":3000000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":3000000,\"description\":\"Dana Bantuan Organisasi Lainnya SMPM 12 GKB\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 01:17:03', '2026-07-13 01:17:03'),
('019f5a8d-179f-732b-9bff-0e1ee16b12f0', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"555534747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"555534747.00\"}', '{\"allocated_balance\":558534747,\"used_balance\":\"0.00\",\"remaining_balance\":558534747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a8d-1786-7231-9c82-9452d0a7f4da\",\"transaction_number\":\"TRX-INC-20260713081703\",\"income_amount\":3000000}', '2026-07-13 01:17:03', '2026-07-13 01:17:03'),
('019f5a8e-a695-7327-b9fa-c37618db3724', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a8e-a67b-733b-a007-eec9a2e0e0be', '[]', '{\"transaction_id\":\"019f5a8e-a67b-733b-a007-eec9a2e0e0be\",\"transaction_number\":\"TRX-INC-20260713081846\",\"transaction_date\":\"2023-01-10T00:00:00.000000Z\",\"total_amount\":20000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":20000000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":20000000,\"description\":\"Dana Bantuan Organisasi Lainnya RSU Aisyiyah Ponorogo\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 01:18:46', '2026-07-13 01:18:46'),
('019f5a8e-a697-717f-9f0e-b8ddee4e75bd', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"558534747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"558534747.00\"}', '{\"allocated_balance\":578534747,\"used_balance\":\"0.00\",\"remaining_balance\":578534747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a8e-a67b-733b-a007-eec9a2e0e0be\",\"transaction_number\":\"TRX-INC-20260713081846\",\"income_amount\":20000000}', '2026-07-13 01:18:46', '2026-07-13 01:18:46'),
('019f5a90-363b-72dc-9c20-36a6ff57b27d', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a90-3620-7277-9739-30c7f4621dff', '[]', '{\"transaction_id\":\"019f5a90-3620-7277-9739-30c7f4621dff\",\"transaction_number\":\"TRX-INC-20260713082028\",\"transaction_date\":\"2023-01-11T00:00:00.000000Z\",\"total_amount\":250000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":250000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":250000,\"description\":\"Dana Bantuan Organisasi Lainnya Ati Fatur\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 01:20:28', '2026-07-13 01:20:28'),
('019f5a90-363e-708e-8874-aebd63cc89cd', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"578534747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"578534747.00\"}', '{\"allocated_balance\":578784747,\"used_balance\":\"0.00\",\"remaining_balance\":578784747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a90-3620-7277-9739-30c7f4621dff\",\"transaction_number\":\"TRX-INC-20260713082028\",\"income_amount\":250000}', '2026-07-13 01:20:28', '2026-07-13 01:20:28'),
('019f5a91-50d7-7015-a2a1-0d4e1bedbd4e', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a91-50c3-71ee-af81-e8000034b023', '[]', '{\"transaction_id\":\"019f5a91-50c3-71ee-af81-e8000034b023\",\"transaction_number\":\"TRX-INC-20260713082140\",\"transaction_date\":\"2023-01-12T00:00:00.000000Z\",\"total_amount\":700000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":700000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":700000,\"description\":\"Dana Bantuan Organisasi Lainnya Asrofi\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 01:21:40', '2026-07-13 01:21:40'),
('019f5a91-50d9-732d-86d2-f173b8fcf01a', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"578784747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"578784747.00\"}', '{\"allocated_balance\":579484747,\"used_balance\":\"0.00\",\"remaining_balance\":579484747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a91-50c3-71ee-af81-e8000034b023\",\"transaction_number\":\"TRX-INC-20260713082140\",\"income_amount\":700000}', '2026-07-13 01:21:40', '2026-07-13 01:21:40'),
('019f5a92-9edd-72a4-9631-0ac8f64df9a0', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a92-9ec5-70b2-823a-7a0950b70aed', '[]', '{\"transaction_id\":\"019f5a92-9ec5-70b2-823a-7a0950b70aed\",\"transaction_number\":\"TRX-INC-20260713082306\",\"transaction_date\":\"2023-01-12T00:00:00.000000Z\",\"total_amount\":10000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":10000000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":10000000,\"description\":\"Dana Bantuan Organisasi Lainnya Prof Zaenudin M\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 01:23:06', '2026-07-13 01:23:06'),
('019f5a92-9ee0-71cd-a3ff-758e55a7a48a', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"579484747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"579484747.00\"}', '{\"allocated_balance\":589484747,\"used_balance\":\"0.00\",\"remaining_balance\":589484747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a92-9ec5-70b2-823a-7a0950b70aed\",\"transaction_number\":\"TRX-INC-20260713082306\",\"income_amount\":10000000}', '2026-07-13 01:23:06', '2026-07-13 01:23:06'),
('019f5a94-33fb-736a-ab50-aa559ea0842d', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a94-33e1-735d-9737-eb8fe2ce5b8c', '[]', '{\"transaction_id\":\"019f5a94-33e1-735d-9737-eb8fe2ce5b8c\",\"transaction_number\":\"TRX-INC-20260713082449\",\"transaction_date\":\"2023-01-12T00:00:00.000000Z\",\"total_amount\":5000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":5000000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":5000000,\"description\":\"Dana Bantuan Organisasi Lainnya SMKM 7 Gondang\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 01:24:49', '2026-07-13 01:24:49'),
('019f5a94-33fe-70f2-b1b8-708e2c91b698', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"589484747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"589484747.00\"}', '{\"allocated_balance\":594484747,\"used_balance\":\"0.00\",\"remaining_balance\":594484747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a94-33e1-735d-9737-eb8fe2ce5b8c\",\"transaction_number\":\"TRX-INC-20260713082449\",\"income_amount\":5000000}', '2026-07-13 01:24:49', '2026-07-13 01:24:49'),
('019f5a95-6e83-70b5-969b-154ecb5b297f', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a95-6e70-739f-b7f5-810181098b19', '[]', '{\"transaction_id\":\"019f5a95-6e70-739f-b7f5-810181098b19\",\"transaction_number\":\"TRX-INC-20260713082610\",\"transaction_date\":\"2023-07-13T00:00:00.000000Z\",\"total_amount\":3000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":3000000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":3000000,\"description\":\"Dana Bantuan Organisasi Lainnya Pemasukan\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 01:26:10', '2026-07-13 01:26:10'),
('019f5a95-6e85-718f-8d11-02163a876e68', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"594484747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"594484747.00\"}', '{\"allocated_balance\":597484747,\"used_balance\":\"0.00\",\"remaining_balance\":597484747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a95-6e70-739f-b7f5-810181098b19\",\"transaction_number\":\"TRX-INC-20260713082610\",\"income_amount\":3000000}', '2026-07-13 01:26:10', '2026-07-13 01:26:10'),
('019f5a97-1cbd-73c3-a439-7af41433bfe1', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a97-1ca6-70d9-bbd4-0f7487c15989', '[]', '{\"transaction_id\":\"019f5a97-1ca6-70d9-bbd4-0f7487c15989\",\"transaction_number\":\"TRX-INC-20260713082800\",\"transaction_date\":\"2023-01-13T00:00:00.000000Z\",\"total_amount\":10000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":10000000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":10000000,\"description\":\"Dana Bantuan Organisasi Lainnya RSM Gresik\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 01:28:00', '2026-07-13 01:28:00'),
('019f5a97-1cbf-70fa-9f5d-95e05b91cf45', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"597484747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"597484747.00\"}', '{\"allocated_balance\":607484747,\"used_balance\":\"0.00\",\"remaining_balance\":607484747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a97-1ca6-70d9-bbd4-0f7487c15989\",\"transaction_number\":\"TRX-INC-20260713082800\",\"income_amount\":10000000}', '2026-07-13 01:28:00', '2026-07-13 01:28:00'),
('019f5a99-3eed-717e-a516-cafbdc4c5097', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a99-3ed5-7269-9c8e-e598ac057e15', '[]', '{\"transaction_id\":\"019f5a99-3ed5-7269-9c8e-e598ac057e15\",\"transaction_number\":\"TRX-INC-20260713083020\",\"transaction_date\":\"2023-01-13T00:00:00.000000Z\",\"total_amount\":2500000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":2500000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":2500000,\"description\":\"Dana Bantuan Organisasi Lainnya SD M 2 GKB\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 01:30:20', '2026-07-13 01:30:20'),
('019f5a99-3eef-708b-a53d-bb28cd6376ce', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"607484747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"607484747.00\"}', '{\"allocated_balance\":609984747,\"used_balance\":\"0.00\",\"remaining_balance\":609984747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a99-3ed5-7269-9c8e-e598ac057e15\",\"transaction_number\":\"TRX-INC-20260713083020\",\"income_amount\":2500000}', '2026-07-13 01:30:20', '2026-07-13 01:30:20'),
('019f5a9b-079a-71a5-b6e7-74567826611f', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a9b-0786-7153-9288-afc6489e2274', '[]', '{\"transaction_id\":\"019f5a9b-0786-7153-9288-afc6489e2274\",\"transaction_number\":\"TRX-INC-20260713083217\",\"transaction_date\":\"2023-01-13T00:00:00.000000Z\",\"total_amount\":250000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":250000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":250000,\"description\":\"Dana Bantuan Organisasi Lainnya Nur Hayati\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 01:32:17', '2026-07-13 01:32:17'),
('019f5a9b-079e-73c2-8b7b-18a50ae5eca7', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"609984747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"609984747.00\"}', '{\"allocated_balance\":610234747,\"used_balance\":\"0.00\",\"remaining_balance\":610234747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a9b-0786-7153-9288-afc6489e2274\",\"transaction_number\":\"TRX-INC-20260713083217\",\"income_amount\":250000}', '2026-07-13 01:32:17', '2026-07-13 01:32:17'),
('019f5a9c-8512-729a-9759-2540cff217a0', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a9c-84fd-728b-bdbc-50e47cd570b1', '[]', '{\"transaction_id\":\"019f5a9c-84fd-728b-bdbc-50e47cd570b1\",\"transaction_number\":\"TRX-INC-20260713083354\",\"transaction_date\":\"2023-01-13T00:00:00.000000Z\",\"total_amount\":1000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":1000000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":1000000,\"description\":\"Dana Bantuan Organisasi Lainnya dr Qonita\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 01:33:54', '2026-07-13 01:33:54'),
('019f5a9c-8514-70cd-8005-d0976cf1b81b', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"610234747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"610234747.00\"}', '{\"allocated_balance\":611234747,\"used_balance\":\"0.00\",\"remaining_balance\":611234747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a9c-84fd-728b-bdbc-50e47cd570b1\",\"transaction_number\":\"TRX-INC-20260713083354\",\"income_amount\":1000000}', '2026-07-13 01:33:54', '2026-07-13 01:33:54'),
('019f5a9e-47dd-73f8-a32b-503eee6f0fb2', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a9e-47c4-7221-99a6-aa739803bfa4', '[]', '{\"transaction_id\":\"019f5a9e-47c4-7221-99a6-aa739803bfa4\",\"transaction_number\":\"TRX-INC-20260713083550\",\"transaction_date\":\"2023-01-15T00:00:00.000000Z\",\"total_amount\":2500000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":2500000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":2500000,\"description\":\"Dana Bantuan Organisasi Lainnya SMAM 10 Gresik\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 01:35:50', '2026-07-13 01:35:50'),
('019f5a9e-47df-7266-b555-915e5f81551e', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"611234747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"611234747.00\"}', '{\"allocated_balance\":613734747,\"used_balance\":\"0.00\",\"remaining_balance\":613734747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a9e-47c4-7221-99a6-aa739803bfa4\",\"transaction_number\":\"TRX-INC-20260713083550\",\"income_amount\":2500000}', '2026-07-13 01:35:50', '2026-07-13 01:35:50'),
('019f5a9f-8591-72a2-9911-ffbadbc6f004', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5a9f-857c-722a-bd72-f219d87e400e', '[]', '{\"transaction_id\":\"019f5a9f-857c-722a-bd72-f219d87e400e\",\"transaction_number\":\"TRX-INC-20260713083711\",\"transaction_date\":\"2023-01-15T00:00:00.000000Z\",\"total_amount\":20000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":20000000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":20000000,\"description\":\"Dana Bantuan Organisasi Lainnya PAN Jatim\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 01:37:11', '2026-07-13 01:37:11'),
('019f5a9f-8592-7329-8025-eeeca355f171', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"613734747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"613734747.00\"}', '{\"allocated_balance\":633734747,\"used_balance\":\"0.00\",\"remaining_balance\":633734747}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5a9f-857c-722a-bd72-f219d87e400e\",\"transaction_number\":\"TRX-INC-20260713083711\",\"income_amount\":20000000}', '2026-07-13 01:37:11', '2026-07-13 01:37:11'),
('019f5aa1-f8b6-70d9-984b-da875623d89d', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5aa1-f89d-717f-bb68-50ec40a34070', '[]', '{\"transaction_id\":\"019f5aa1-f89d-717f-bb68-50ec40a34070\",\"transaction_number\":\"TRX-INC-20260713083952\",\"transaction_date\":\"2023-01-16T00:00:00.000000Z\",\"total_amount\":415107,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":415107,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"638a512b-cab3-4d52-b467-7193ccc1feb3\",\"position\":\"CREDIT\",\"amount\":415107,\"description\":\"Pendapatan Jasa Bank (Neto) Penerimaan bunga tabungan\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 01:39:52', '2026-07-13 01:39:52'),
('019f5aa1-f8b8-710a-bea8-284035463bd4', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"633734747.00\",\"used_balance\":\"0.00\",\"remaining_balance\":\"633734747.00\"}', '{\"allocated_balance\":634149854,\"used_balance\":\"0.00\",\"remaining_balance\":634149854}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5aa1-f89d-717f-bb68-50ec40a34070\",\"transaction_number\":\"TRX-INC-20260713083952\",\"income_amount\":415107}', '2026-07-13 01:39:52', '2026-07-13 01:39:52'),
('019f5aa4-9814-704c-91e1-bbe281745aa6', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna berkurang karena transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"used_balance\":\"0.00\",\"remaining_balance\":\"634149854.00\"}', '{\"used_balance\":83021,\"remaining_balance\":634066833}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5aa4-97fe-7392-a2c2-21f66636db48\",\"transaction_number\":\"TRX-EXP-20260713084244\",\"expense_amount\":83021}', '2026-07-13 01:42:44', '2026-07-13 01:42:44'),
('019f5aa4-9818-701f-9a35-b6b2d01c68a7', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '019f5aa4-97fe-7392-a2c2-21f66636db48', '[]', '{\"transaction_id\":\"019f5aa4-97fe-7392-a2c2-21f66636db48\",\"transaction_number\":\"TRX-EXP-20260713084244\",\"transaction_date\":\"2023-01-16T00:00:00.000000Z\",\"total_amount\":83021,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"2ffe0b7f-2bc6-4dac-9940-e53393a90f58\",\"position\":\"DEBIT\",\"amount\":83021,\"description\":\"Biaya Administrasi Bank Pengeluaran\"},{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"CREDIT\",\"amount\":83021,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Keluar\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 01:42:44', '2026-07-13 01:42:44'),
('019f5aa6-40e0-7071-83be-055d597124c3', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5aa6-40c4-738a-927c-1594c476378d', '[]', '{\"transaction_id\":\"019f5aa6-40c4-738a-927c-1594c476378d\",\"transaction_number\":\"TRX-INC-20260713084432\",\"transaction_date\":\"2023-01-18T00:00:00.000000Z\",\"total_amount\":10000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":10000000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":10000000,\"description\":\"Dana Bantuan Organisasi Lainnya RS Siti Khodijah\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 01:44:32', '2026-07-13 01:44:32'),
('019f5aa6-40e3-7113-836e-671b77dd9af0', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"634149854.00\",\"used_balance\":\"83021.00\",\"remaining_balance\":\"634066833.00\"}', '{\"allocated_balance\":644149854,\"used_balance\":\"83021.00\",\"remaining_balance\":644066833}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5aa6-40c4-738a-927c-1594c476378d\",\"transaction_number\":\"TRX-INC-20260713084432\",\"income_amount\":10000000}', '2026-07-13 01:44:32', '2026-07-13 01:44:32'),
('019f5aa7-9f83-732c-a17a-c0776da5d338', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5aa7-9f6e-705d-a50e-70ebf135c020', '[]', '{\"transaction_id\":\"019f5aa7-9f6e-705d-a50e-70ebf135c020\",\"transaction_number\":\"TRX-INC-20260713084602\",\"transaction_date\":\"2023-01-18T00:00:00.000000Z\",\"total_amount\":5000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":5000000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":5000000,\"description\":\"Dana Bantuan Organisasi Lainnya Parahita\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 01:46:02', '2026-07-13 01:46:02'),
('019f5aa7-9f85-7351-ac1f-5de6674ddb0b', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"644149854.00\",\"used_balance\":\"83021.00\",\"remaining_balance\":\"644066833.00\"}', '{\"allocated_balance\":649149854,\"used_balance\":\"83021.00\",\"remaining_balance\":649066833}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5aa7-9f6e-705d-a50e-70ebf135c020\",\"transaction_number\":\"TRX-INC-20260713084602\",\"income_amount\":5000000}', '2026-07-13 01:46:02', '2026-07-13 01:46:02'),
('019f5aa9-2c98-72e6-ab42-a6bc77d31fd4', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5aa9-2c86-72d5-921d-a7e641546777', '[]', '{\"transaction_id\":\"019f5aa9-2c86-72d5-921d-a7e641546777\",\"transaction_number\":\"TRX-INC-20260713084744\",\"transaction_date\":\"2023-01-18T00:00:00.000000Z\",\"total_amount\":5000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":5000000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":5000000,\"description\":\"Dana Bantuan Organisasi Lainnya Universitas Muhammadiyah Gresik\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 01:47:44', '2026-07-13 01:47:44'),
('019f5aa9-2c9a-7130-a4e8-178ed358b5a7', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"649149854.00\",\"used_balance\":\"83021.00\",\"remaining_balance\":\"649066833.00\"}', '{\"allocated_balance\":654149854,\"used_balance\":\"83021.00\",\"remaining_balance\":654066833}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5aa9-2c86-72d5-921d-a7e641546777\",\"transaction_number\":\"TRX-INC-20260713084744\",\"income_amount\":5000000}', '2026-07-13 01:47:44', '2026-07-13 01:47:44'),
('019f5aaa-43ab-706f-867a-64be243f5d2f', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5aaa-4391-705a-8b59-309a96cdb8f4', '[]', '{\"transaction_id\":\"019f5aaa-4391-705a-8b59-309a96cdb8f4\",\"transaction_number\":\"TRX-INC-20260713084855\",\"transaction_date\":\"2023-01-19T00:00:00.000000Z\",\"total_amount\":500000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":500000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":500000,\"description\":\"Dana Bantuan Organisasi Lainnya Muhajir\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 01:48:55', '2026-07-13 01:48:55'),
('019f5aaa-43ad-7037-bb57-7c1867694132', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"654149854.00\",\"used_balance\":\"83021.00\",\"remaining_balance\":\"654066833.00\"}', '{\"allocated_balance\":654649854,\"used_balance\":\"83021.00\",\"remaining_balance\":654566833}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5aaa-4391-705a-8b59-309a96cdb8f4\",\"transaction_number\":\"TRX-INC-20260713084855\",\"income_amount\":500000}', '2026-07-13 01:48:55', '2026-07-13 01:48:55'),
('019f5aab-5bf1-737a-9cf8-3cdbd217e5a7', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5aab-5bd5-7210-83b8-0d9609e53ce4', '[]', '{\"transaction_id\":\"019f5aab-5bd5-7210-83b8-0d9609e53ce4\",\"transaction_number\":\"TRX-INC-20260713085007\",\"transaction_date\":\"2023-01-20T00:00:00.000000Z\",\"total_amount\":10000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":10000000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":10000000,\"description\":\"Dana Bantuan Organisasi Lainnya Widati Muhajir\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 01:50:07', '2026-07-13 01:50:07'),
('019f5aab-5bf3-715e-aa0f-8324203987fb', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"654649854.00\",\"used_balance\":\"83021.00\",\"remaining_balance\":\"654566833.00\"}', '{\"allocated_balance\":664649854,\"used_balance\":\"83021.00\",\"remaining_balance\":664566833}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5aab-5bd5-7210-83b8-0d9609e53ce4\",\"transaction_number\":\"TRX-INC-20260713085007\",\"income_amount\":10000000}', '2026-07-13 01:50:07', '2026-07-13 01:50:07'),
('019f5aac-9e29-70a8-b88a-bd37fd159154', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5aac-9e17-7395-b4c8-e1a67e4f7eec', '[]', '{\"transaction_id\":\"019f5aac-9e17-7395-b4c8-e1a67e4f7eec\",\"transaction_number\":\"TRX-INC-20260713085129\",\"transaction_date\":\"2023-01-21T00:00:00.000000Z\",\"total_amount\":250000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":250000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":250000,\"description\":\"Dana Bantuan Organisasi Lainnya Pemasukan\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 01:51:29', '2026-07-13 01:51:29'),
('019f5aac-9e2b-7152-ae38-e816ea8d6421', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"664649854.00\",\"used_balance\":\"83021.00\",\"remaining_balance\":\"664566833.00\"}', '{\"allocated_balance\":664899854,\"used_balance\":\"83021.00\",\"remaining_balance\":664816833}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5aac-9e17-7395-b4c8-e1a67e4f7eec\",\"transaction_number\":\"TRX-INC-20260713085129\",\"income_amount\":250000}', '2026-07-13 01:51:29', '2026-07-13 01:51:29'),
('019f5aad-8f2e-7317-9d23-0d5a7679bd9b', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'CREATE', 'TRANSACTION_INCOME', 'Membuat transaksi penerimaan.', 'App\\Models\\Transaction', '019f5aad-8f19-713b-b842-b31e14f0d957', '[]', '{\"transaction_id\":\"019f5aad-8f19-713b-b842-b31e14f0d957\",\"transaction_number\":\"TRX-INC-20260713085231\",\"transaction_date\":\"2023-01-28T00:00:00.000000Z\",\"total_amount\":3000000,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"80489af9-a27f-469d-aabb-16681c5cf916\",\"position\":\"DEBIT\",\"amount\":3000000,\"description\":\"Kas di Bank Jatim Dr. Soetomo Kas Masuk\"},{\"coa_id\":\"c845664e-4939-4188-9b5a-177cd7bd5ed7\",\"position\":\"CREDIT\",\"amount\":3000000,\"description\":\"Dana Bantuan Organisasi Lainnya Pemasukan\"}]}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_type\":\"INCOME\",\"period_id\":\"019f3c7f-83a5-7303-bcaa-a3e095677c5f\",\"sub_period_id\":\"019f3c80-09e1-7238-ae7f-21c037b9f75d\"}', '2026-07-13 01:52:31', '2026-07-13 01:52:31'),
('019f5aad-8f30-73e9-a746-d9f935b35ae0', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna bertambah karena transaksi penerimaan.', 'App\\Models\\UserAccountBalance', '019f5a59-4dad-7307-b9ec-73b4c016737e', '{\"allocated_balance\":\"664899854.00\",\"used_balance\":\"83021.00\",\"remaining_balance\":\"664816833.00\"}', '{\"allocated_balance\":667899854,\"used_balance\":\"83021.00\",\"remaining_balance\":667816833}', '103.114.35.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '{\"transaction_id\":\"019f5aad-8f19-713b-b842-b31e14f0d957\",\"transaction_number\":\"TRX-INC-20260713085231\",\"income_amount\":3000000}', '2026-07-13 01:52:31', '2026-07-13 01:52:31'),
('019fc227-6c43-706c-a3bc-a6b274508104', '019f3c29-d287-707a-8a4d-25d249fe7e86', 'update', 'configuration', 'Configuration updated', NULL, NULL, '[]', '{\"app_name\":\"Keuangan PWA JATIM\",\"app_description\":\"Sistem Informasi Akuntansi untuk pengelolaan keuangan, jurnal, dan laporan secara terintegrasi.\",\"app_tagline\":\"Sistem Informasi Akuntansi untuk pengelolaan keuangan, jurnal, dan laporan secara terintegrasi.\",\"app_logo\":{}}', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '{\"app_logo\":{},\"app_background_login\":null}', '2026-08-02 04:06:31', '2026-08-02 04:06:31');

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
('019f44c1-788f-7306-96fd-3413fca1f99f', '60000', 'Kas Baru', NULL, '1', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'Kas Baru testing', 'DEBIT', 1, '019f3c29-d401-730d-a58f-9fac0918ea2c', '2026-07-08 19:42:37', '2026-07-08 19:42:37', NULL),
('019f44c2-6489-7189-9d2a-0c829b0e6c15', '60100', 'Sub Kas Baru 1', '019f44c1-788f-7306-96fd-3413fca1f99f', '2', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, '019f3c29-d401-730d-a58f-9fac0918ea2c', '2026-07-08 19:43:38', '2026-07-08 19:43:38', NULL),
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
('019f3c39-5ff3-72a1-a97e-4e0e40f66193', '80489af9-a27f-469d-aabb-16681c5cf916', '019f3c35-09b8-737c-8683-733385ec91c9', '019f3c35-ba89-732a-bff8-3a8e7f80e1a2', 1156982563.00, 0.00, 0.00, 346013069.00, '2026-07-07 03:57:00', NULL, '2026-07-07 03:57:00', '2026-07-13 00:20:29'),
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
('019f3c29-c4a9-7023-a558-9a46bf89b81c', 'APP_NAME', 'Keuangan PWA JATIM', 'string', 'Nama aplikasi yang akan ditampilkan di berbagai tempat seperti judul halaman.', 1, '2026-07-07 03:39:58', '2026-08-02 04:06:31'),
('019f3c29-c4c4-701d-a6ed-0dacd6991cc0', 'APP_DESCRIPTION', 'Sistem Informasi Akuntansi untuk pengelolaan keuangan, jurnal, dan laporan secara terintegrasi.', 'string', 'Deskripsi singkat tentang aplikasi yang dapat digunakan untuk SEO atau ditampilkan di halaman utama.', 1, '2026-07-07 03:39:58', '2026-08-02 04:06:31'),
('019f3c29-c4d8-7300-b156-64b457c77540', 'APP_TAGLINE', 'Sistem Informasi Akuntansi untuk pengelolaan keuangan, jurnal, dan laporan secara terintegrasi.', 'string', 'Tagline atau slogan yang menggambarkan nilai utama aplikasi.', 1, '2026-07-07 03:39:58', '2026-08-02 04:06:31'),
('019f3c29-c4ec-710c-80f2-a7a91e5c3581', 'APP_LOGO', 'https://disposisi.engineering-umsura.id/storage/configuration/019f3c29-c4ec-710c-80f2-a7a91e5c3581/2026/08/02/images-removebg-preview.png', 'image', 'Logo aplikasi yang akan ditampilkan di header atau halaman login.', 1, '2026-07-07 03:39:58', '2026-08-02 04:06:31'),
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

--
-- Dumping data untuk tabel `journals`
--

INSERT INTO `journals` (`id`, `journal_number`, `journal_date`, `description`, `total_debit`, `total_credit`, `posted_by`, `posted_at`, `period_id`, `sub_period_id`, `transaction_id`, `created_at`, `updated_at`) VALUES
('019f5a59-4db4-7377-b7c9-3d50d5efb9fa', 'JRN-20260713072029', '2026-07-13', 'Pembagian saldo ke pengguna', 405484747.00, 405484747.00, '019f3c29-d401-730d-a58f-9fac0918ea2c', '2026-07-13 07:20:29', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 00:20:29', '2026-07-13 00:20:29'),
('019f5a5c-e6e0-7182-8dcf-00075f85b424', 'JR-INC-20260713072425', '2023-01-04', 'Sumbangan Musywil Bagus Irawan', 1000000.00, 1000000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 07:24:25', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a5c-e6cf-70f7-b5af-941fad678ec1', '2026-07-13 00:24:25', '2026-07-13 00:24:25'),
('019f5a66-a42d-72da-9a39-380ba6ebd664', 'JR-INC-20260713073503', '2023-01-04', 'Sumbangan Muswyil UMsurabaya', 25000000.00, 25000000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 07:35:03', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a66-a420-702b-b44e-f71c9b8f50d0', '2026-07-13 00:35:03', '2026-07-13 00:35:03'),
('019f5a68-4342-7303-8fd2-5c70c4463119', 'JR-INC-20260713073650', '2023-01-04', 'pemasukan', 300000.00, 300000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 07:36:50', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a68-4333-727c-a353-a2d3cf713a52', '2026-07-13 00:36:50', '2026-07-13 00:36:50'),
('019f5a6a-457e-71e0-8c4d-0271a794dc76', 'JR-INC-20260713073901', '2023-01-05', 'Sumbangan Musywil SMP M 2 Taman', 3000000.00, 3000000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 07:39:01', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a6a-456e-7266-81df-df9034109647', '2026-07-13 00:39:01', '2026-07-13 00:39:01'),
('019f5a6e-5595-70c2-9a8b-0273a5e7bb60', 'JR-INC-20260713074328', '2023-01-05', 'Sumbangan RSA Dahlan Kediri', 7500000.00, 7500000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 07:43:28', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a6e-5585-7026-a4a1-a0516e80837f', '2026-07-13 00:43:28', '2026-07-13 00:43:28'),
('019f5a71-2d04-7377-974d-f914e7b25e27', 'JR-INC-20260713074634', '2023-01-05', 'Sumbangan SMA M 2 Surabaya', 5000000.00, 5000000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 07:46:34', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a71-2cf2-7333-ab04-1a2fdd0a8c46', '2026-07-13 00:46:34', '2026-07-13 00:46:34'),
('019f5a73-af0e-70e7-b65d-39c76bf29482', 'JR-INC-20260713074918', '2023-01-05', 'Sumbangan RSI Aisyiyah Malang', 10000000.00, 10000000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 07:49:18', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a73-af00-70f5-bee5-36b93b290f3b', '2026-07-13 00:49:18', '2026-07-13 00:49:18'),
('019f5a75-d0d4-71a1-ae42-63c0ea6db079', 'JR-INC-20260713075138', '2023-01-05', 'Sumbangan Musywil RSIA Nganjuk', 20000000.00, 20000000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 07:51:38', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a75-d0bd-715b-847f-781d19ba464b', '2026-07-13 00:51:38', '2026-07-13 00:51:38'),
('019f5a76-00d8-72f0-920a-41338455df26', 'JR-INC-20260713075150', '2023-01-05', 'Sumbangan Musywil RSIA Nganjuk', 20000000.00, 20000000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 07:51:50', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a76-00c9-7150-9f9a-974c7e377421', '2026-07-13 00:51:50', '2026-07-13 00:51:50'),
('019f5a78-97b5-70d2-b298-8a5c44ae771b', 'JR-INC-20260713075440', '2023-01-05', 'Sumbangan Muswyil SMA M Sidoarjo', 5000000.00, 5000000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 07:54:40', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a78-97a9-73e5-8b10-41ab0d291585', '2026-07-13 00:54:40', '2026-07-13 00:54:40'),
('019f5a7a-f371-70ec-ba15-54b090944e02', 'JR-INC-20260713075714', '2023-01-06', 'Sumbangan Muswyil SDM 1 Sidoarjo', 1500000.00, 1500000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 07:57:14', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a7a-f366-7187-8974-143ae9e74c16', '2026-07-13 00:57:14', '2026-07-13 00:57:14'),
('019f5a7c-e091-7255-b761-958ec18686aa', 'JR-INC-20260713075921', '2023-01-06', 'Sumbangan Muswyil SMP M 1 Sidoarjo', 3000000.00, 3000000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 07:59:21', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a7c-e07d-72dd-99a3-6361ae7bad2b', '2026-07-13 00:59:21', '2026-07-13 00:59:21'),
('019f5a7e-aee3-7037-986a-8570e8c3bf5c', 'JR-INC-20260713080119', '2023-01-06', 'Pembayaran Simpanan Wajib Organisasi', 2250000.00, 2250000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 08:01:19', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a7e-aed9-7156-80eb-a011650c0f0a', '2026-07-13 01:01:19', '2026-07-13 01:01:19'),
('019f5a80-8492-71b3-940e-aaf1aa46025e', 'JR-INC-20260713080319', '2023-01-06', 'Sumbangan Muswyil UMSIDA', 5000000.00, 5000000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 08:03:19', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a80-8486-705f-9dbc-29b804e92ecb', '2026-07-13 01:03:19', '2026-07-13 01:03:19'),
('019f5a82-b37a-7020-aaa7-680d38b9622b', 'JR-INC-20260713080542', '2023-01-06', 'Sumbangan Muswyil RS Aisyiyah Bojonegoro', 10000000.00, 10000000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 08:05:42', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a82-b36f-73c8-a3b5-a083246f5e42', '2026-07-13 01:05:42', '2026-07-13 01:05:42'),
('019f5a84-c8a2-71fe-aeca-7eba4c31b65b', 'JR-INC-20260713080759', '2023-01-06', 'Sumbangan Muswyil SMA M Gresik', 5000000.00, 5000000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 08:07:59', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a84-c894-70ab-9b90-003766a788fd', '2026-07-13 01:07:59', '2026-07-13 01:07:59'),
('019f5a86-584d-70ba-a70e-a348776c5f9c', 'JR-INC-20260713080941', '2023-01-07', 'Sumbangan Muswyil UMJ', 5000000.00, 5000000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 08:09:41', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a86-5841-73ac-af09-9ab660c71f6c', '2026-07-13 01:09:41', '2026-07-13 01:09:41'),
('019f5a87-c7d6-7072-a418-a23e6a7721da', 'JR-INC-20260713081115', '2023-01-09', 'Irvand Gustari', 2500000.00, 2500000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 08:11:15', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a87-c7c7-729a-b661-b5b23c77387d', '2026-07-13 01:11:15', '2026-07-13 01:11:15'),
('019f5a89-722b-7198-82d2-746e9346bc71', 'JR-INC-20260713081304', '2023-01-09', 'Mumtaz (Aad)', 10000000.00, 10000000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 08:13:04', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a89-721d-7303-9700-2756e50125c3', '2026-07-13 01:13:04', '2026-07-13 01:13:04'),
('019f5a8a-a958-71e5-8e48-22c2250fd722', 'JR-INC-20260713081424', '2023-01-09', 'UM Lamongan', 5000000.00, 5000000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 08:14:24', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a8a-a94a-72f8-adb5-fa9d20e16305', '2026-07-13 01:14:24', '2026-07-13 01:14:24'),
('019f5a8b-dfb6-73f5-868e-3bc17a97e785', 'JR-INC-20260713081544', '2023-01-09', 'M Idaham', 1000000.00, 1000000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 08:15:44', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a8b-dfa3-72c7-bef4-a32e6f80c785', '2026-07-13 01:15:44', '2026-07-13 01:15:44'),
('019f5a8d-1794-72e4-8e02-42a12a5e7fb2', 'JR-INC-20260713081703', '2023-01-09', 'SMPM 12 GKB', 3000000.00, 3000000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 08:17:03', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a8d-1786-7231-9c82-9452d0a7f4da', '2026-07-13 01:17:03', '2026-07-13 01:17:03'),
('019f5a8e-a689-7308-8be8-262f5c29ecca', 'JR-INC-20260713081846', '2023-01-10', 'RSU Aisyiyah Ponorogo', 20000000.00, 20000000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 08:18:46', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a8e-a67b-733b-a007-eec9a2e0e0be', '2026-07-13 01:18:46', '2026-07-13 01:18:46'),
('019f5a90-3632-72f9-a23f-0639bf3fdf5a', 'JR-INC-20260713082028', '2023-01-11', 'Ati Fatur', 250000.00, 250000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 08:20:28', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a90-3620-7277-9739-30c7f4621dff', '2026-07-13 01:20:28', '2026-07-13 01:20:28'),
('019f5a91-50d1-700e-88cf-5bf501392b82', 'JR-INC-20260713082140', '2023-01-12', 'Asrofi', 700000.00, 700000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 08:21:40', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a91-50c3-71ee-af81-e8000034b023', '2026-07-13 01:21:40', '2026-07-13 01:21:40'),
('019f5a92-9ed5-7292-9b7b-7465f3f1715e', 'JR-INC-20260713082306', '2023-01-12', 'Prof Zaenudin M', 10000000.00, 10000000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 08:23:06', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a92-9ec5-70b2-823a-7a0950b70aed', '2026-07-13 01:23:06', '2026-07-13 01:23:06'),
('019f5a94-33f1-7170-b50a-773a8814637a', 'JR-INC-20260713082449', '2023-01-12', 'SMKM 7 Gondang', 5000000.00, 5000000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 08:24:49', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a94-33e1-735d-9737-eb8fe2ce5b8c', '2026-07-13 01:24:49', '2026-07-13 01:24:49'),
('019f5a95-6e7c-725f-a10c-d427a38467d0', 'JR-INC-20260713082610', '2023-01-13', 'Pemasukan', 3000000.00, 3000000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 08:26:10', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a95-6e70-739f-b7f5-810181098b19', '2026-07-13 01:26:10', '2026-07-13 01:26:10'),
('019f5a97-1cb5-73ee-ac53-826527668dfe', 'JR-INC-20260713082800', '2023-01-13', 'RSM Gresik', 10000000.00, 10000000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 08:28:00', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a97-1ca6-70d9-bbd4-0f7487c15989', '2026-07-13 01:28:00', '2026-07-13 01:28:00'),
('019f5a99-3ee6-727f-aa51-525ffcbe02b0', 'JR-INC-20260713083020', '2023-01-13', 'SD M 2 GKB', 2500000.00, 2500000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 08:30:20', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a99-3ed5-7269-9c8e-e598ac057e15', '2026-07-13 01:30:20', '2026-07-13 01:30:20'),
('019f5a9b-0795-714d-8954-630acd35c46c', 'JR-INC-20260713083217', '2023-01-13', 'Nur Hayati', 250000.00, 250000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 08:32:17', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a9b-0786-7153-9288-afc6489e2274', '2026-07-13 01:32:17', '2026-07-13 01:32:17'),
('019f5a9c-8509-7111-a5af-8b629865fd9d', 'JR-INC-20260713083354', '2023-01-13', 'dr Qonita', 1000000.00, 1000000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 08:33:54', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a9c-84fd-728b-bdbc-50e47cd570b1', '2026-07-13 01:33:54', '2026-07-13 01:33:54'),
('019f5a9e-47d5-72d6-b722-4db5209ba781', 'JR-INC-20260713083550', '2023-01-15', 'SMAM 10 Gresik', 2500000.00, 2500000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 08:35:50', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a9e-47c4-7221-99a6-aa739803bfa4', '2026-07-13 01:35:50', '2026-07-13 01:35:50'),
('019f5a9f-8589-7291-bd98-0069acca537b', 'JR-INC-20260713083711', '2023-01-15', 'PAN Jatim', 20000000.00, 20000000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 08:37:11', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5a9f-857c-722a-bd72-f219d87e400e', '2026-07-13 01:37:11', '2026-07-13 01:37:11'),
('019f5aa1-f8af-718d-8493-7b2a452bc6c2', 'JR-INC-20260713083952', '2023-01-16', 'Penerimaan bunga tabungan', 415107.00, 415107.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 08:39:52', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5aa1-f89d-717f-bb68-50ec40a34070', '2026-07-13 01:39:52', '2026-07-13 01:39:52'),
('019f5aa4-980d-70cf-aba0-5ca189760bbb', 'JR-EXP-20260713084244', '2023-01-16', 'Pembayaran pajak tabungan', 83021.00, 83021.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 08:42:44', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5aa4-97fe-7392-a2c2-21f66636db48', '2026-07-13 01:42:44', '2026-07-13 01:42:44'),
('019f5aa6-40d1-713a-ba41-aff8aa413c86', 'JR-INC-20260713084432', '2023-01-18', 'RS Siti Khodijah', 10000000.00, 10000000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 08:44:32', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5aa6-40c4-738a-927c-1594c476378d', '2026-07-13 01:44:32', '2026-07-13 01:44:32'),
('019f5aa7-9f7d-71dd-acb2-b926a92fb44c', 'JR-INC-20260713084602', '2023-01-18', 'Parahita', 5000000.00, 5000000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 08:46:02', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5aa7-9f6e-705d-a50e-70ebf135c020', '2026-07-13 01:46:02', '2026-07-13 01:46:02'),
('019f5aa9-2c90-71dc-898a-629bfda15812', 'JR-INC-20260713084744', '2023-01-18', 'Universitas Muhammadiyah Gresik', 5000000.00, 5000000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 08:47:44', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5aa9-2c86-72d5-921d-a7e641546777', '2026-07-13 01:47:44', '2026-07-13 01:47:44'),
('019f5aaa-43a1-71ac-84a2-8a0e6d7bdd42', 'JR-INC-20260713084855', '2023-01-19', 'Muhajir', 500000.00, 500000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 08:48:55', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5aaa-4391-705a-8b59-309a96cdb8f4', '2026-07-13 01:48:55', '2026-07-13 01:48:55'),
('019f5aab-5be9-727c-be85-b01afaeec6e0', 'JR-INC-20260713085007', '2023-01-20', 'Widati Muhajir', 10000000.00, 10000000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 08:50:07', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5aab-5bd5-7210-83b8-0d9609e53ce4', '2026-07-13 01:50:07', '2026-07-13 01:50:07'),
('019f5aac-9e24-70d3-a8a2-e413893db22b', 'JR-INC-20260713085129', '2023-01-21', 'Pemasukan', 250000.00, 250000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 08:51:29', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5aac-9e17-7395-b4c8-e1a67e4f7eec', '2026-07-13 01:51:29', '2026-07-13 01:51:29'),
('019f5aad-8f25-7321-bfd0-a27a13704dcb', 'JR-INC-20260713085231', '2023-01-28', 'Pemasukan', 3000000.00, 3000000.00, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '2026-07-13 08:52:31', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f5aad-8f19-713b-b842-b31e14f0d957', '2026-07-13 01:52:31', '2026-07-13 01:52:31');

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
('019f5a59-4db6-73e6-b93a-a2208cd801b1', '019f5a59-4db4-7377-b7c9-3d50d5efb9fa', '80489af9-a27f-469d-aabb-16681c5cf916', 405484747.00, 0.00, 'Distribusi saldo ke user', '2026-07-13 00:20:29', '2026-07-13 00:20:29'),
('019f5a59-4db8-71f1-9cd7-ad1110d23b2c', '019f5a59-4db4-7377-b7c9-3d50d5efb9fa', '80489af9-a27f-469d-aabb-16681c5cf916', 0.00, 405484747.00, 'Pengurangan saldo akun', '2026-07-13 00:20:29', '2026-07-13 00:20:29'),
('019f5a5c-e6e3-7326-9ee8-f61913a0de4c', '019f5a5c-e6e0-7182-8dcf-00075f85b424', '80489af9-a27f-469d-aabb-16681c5cf916', 1000000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 00:24:25', '2026-07-13 00:24:25'),
('019f5a5c-e6e6-72da-9b25-040bf603bd94', '019f5a5c-e6e0-7182-8dcf-00075f85b424', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 1000000.00, 'Dana Bantuan Organisasi Lainnya Sumbangan Musywil Bagus Irawan', '2026-07-13 00:24:25', '2026-07-13 00:24:25'),
('019f5a66-a430-733c-b78d-8ac00d6472e6', '019f5a66-a42d-72da-9a39-380ba6ebd664', '80489af9-a27f-469d-aabb-16681c5cf916', 25000000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 00:35:03', '2026-07-13 00:35:03'),
('019f5a66-a432-727a-8137-009b03f5e6a3', '019f5a66-a42d-72da-9a39-380ba6ebd664', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 25000000.00, 'Dana Bantuan Organisasi Lainnya Sumbangan Muswyil UMsurabaya', '2026-07-13 00:35:03', '2026-07-13 00:35:03'),
('019f5a68-4345-736d-af38-084a8e7f9a32', '019f5a68-4342-7303-8fd2-5c70c4463119', '80489af9-a27f-469d-aabb-16681c5cf916', 300000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 00:36:50', '2026-07-13 00:36:50'),
('019f5a68-4349-7369-8d47-359eb5741fba', '019f5a68-4342-7303-8fd2-5c70c4463119', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 300000.00, 'Dana Bantuan Organisasi Lainnya pemasukan', '2026-07-13 00:36:50', '2026-07-13 00:36:50'),
('019f5a6a-4581-7173-a812-22812af225ac', '019f5a6a-457e-71e0-8c4d-0271a794dc76', '80489af9-a27f-469d-aabb-16681c5cf916', 3000000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 00:39:01', '2026-07-13 00:39:01'),
('019f5a6a-4582-7102-86c4-2f9a59dd0aa1', '019f5a6a-457e-71e0-8c4d-0271a794dc76', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 3000000.00, 'Dana Bantuan Organisasi Lainnya Sumbangan Musywil SMP M 2 Taman', '2026-07-13 00:39:01', '2026-07-13 00:39:01'),
('019f5a6e-5598-71f4-836a-d32bc044a9e2', '019f5a6e-5595-70c2-9a8b-0273a5e7bb60', '80489af9-a27f-469d-aabb-16681c5cf916', 7500000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 00:43:28', '2026-07-13 00:43:28'),
('019f5a6e-559a-706b-a32b-90f96850c3aa', '019f5a6e-5595-70c2-9a8b-0273a5e7bb60', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 7500000.00, 'Dana Bantuan Organisasi Lainnya Sumbangan RSA Dahlan Kediri', '2026-07-13 00:43:28', '2026-07-13 00:43:28'),
('019f5a71-2d08-72fb-b4e9-ddb92d6cc9c0', '019f5a71-2d04-7377-974d-f914e7b25e27', '80489af9-a27f-469d-aabb-16681c5cf916', 5000000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 00:46:34', '2026-07-13 00:46:34'),
('019f5a71-2d0c-7370-a80e-355af146e0c9', '019f5a71-2d04-7377-974d-f914e7b25e27', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 5000000.00, 'Dana Bantuan Organisasi Lainnya Sumbangan SMA M 2 Surabaya', '2026-07-13 00:46:34', '2026-07-13 00:46:34'),
('019f5a73-af11-7003-a1f6-f112340475b5', '019f5a73-af0e-70e7-b65d-39c76bf29482', '80489af9-a27f-469d-aabb-16681c5cf916', 10000000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 00:49:18', '2026-07-13 00:49:18'),
('019f5a73-af13-715e-bd27-ec39293bfdf7', '019f5a73-af0e-70e7-b65d-39c76bf29482', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 10000000.00, 'Dana Bantuan Organisasi Lainnya Sumbangan RSI Aisyiyah Malang', '2026-07-13 00:49:18', '2026-07-13 00:49:18'),
('019f5a75-d0d7-702c-ac26-cf9d64d0c681', '019f5a75-d0d4-71a1-ae42-63c0ea6db079', '80489af9-a27f-469d-aabb-16681c5cf916', 20000000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 00:51:38', '2026-07-13 00:51:38'),
('019f5a75-d0d8-7289-aa7c-34ad0df1f190', '019f5a75-d0d4-71a1-ae42-63c0ea6db079', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 20000000.00, 'Dana Bantuan Organisasi Lainnya Sumbangan Musywil RSIA Nganjuk', '2026-07-13 00:51:38', '2026-07-13 00:51:38'),
('019f5a76-00da-71bd-86d2-e4cbce536715', '019f5a76-00d8-72f0-920a-41338455df26', '80489af9-a27f-469d-aabb-16681c5cf916', 20000000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 00:51:50', '2026-07-13 00:51:50'),
('019f5a76-00df-7201-b84d-15d4aeb91992', '019f5a76-00d8-72f0-920a-41338455df26', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 20000000.00, 'Dana Bantuan Organisasi Lainnya Sumbangan Musywil RSIA Nganjuk', '2026-07-13 00:51:50', '2026-07-13 00:51:50'),
('019f5a78-97b8-73a7-9dc8-b415f5eaa685', '019f5a78-97b5-70d2-b298-8a5c44ae771b', '80489af9-a27f-469d-aabb-16681c5cf916', 5000000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 00:54:40', '2026-07-13 00:54:40'),
('019f5a78-97b9-72a5-bf07-7efb7a5e7945', '019f5a78-97b5-70d2-b298-8a5c44ae771b', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 5000000.00, 'Dana Bantuan Organisasi Lainnya Sumbangan Muswyil SMA M Sidoarjo', '2026-07-13 00:54:40', '2026-07-13 00:54:40'),
('019f5a7a-f374-72e2-a2a0-1679dfa7de2c', '019f5a7a-f371-70ec-ba15-54b090944e02', '80489af9-a27f-469d-aabb-16681c5cf916', 1500000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 00:57:14', '2026-07-13 00:57:14'),
('019f5a7a-f376-73b5-b187-26e2faa1e3ad', '019f5a7a-f371-70ec-ba15-54b090944e02', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 1500000.00, 'Dana Bantuan Organisasi Lainnya Sumbangan Muswyil SDM 1 Sidoarjo', '2026-07-13 00:57:14', '2026-07-13 00:57:14'),
('019f5a7c-e096-70ce-944f-e581fd804f46', '019f5a7c-e091-7255-b761-958ec18686aa', '80489af9-a27f-469d-aabb-16681c5cf916', 3000000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 00:59:21', '2026-07-13 00:59:21'),
('019f5a7c-e099-72ec-9715-4ca13e166ef9', '019f5a7c-e091-7255-b761-958ec18686aa', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 3000000.00, 'Dana Bantuan Organisasi Lainnya Sumbangan Muswyil SMP M 1 Sidoarjo', '2026-07-13 00:59:21', '2026-07-13 00:59:21'),
('019f5a7e-aee5-72b1-ab69-4c6291fb3731', '019f5a7e-aee3-7037-986a-8570e8c3bf5c', '80489af9-a27f-469d-aabb-16681c5cf916', 2250000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:01:19', '2026-07-13 01:01:19'),
('019f5a7e-aee6-70ba-985f-eb54dd687df6', '019f5a7e-aee3-7037-986a-8570e8c3bf5c', '89b2bd63-45a5-4376-9301-75f7c5c6869f', 0.00, 2250000.00, 'Dana Wajib Organisasi Pembayaran Simpanan Wajib Organisasi', '2026-07-13 01:01:19', '2026-07-13 01:01:19'),
('019f5a80-8495-7306-87f4-24663474774c', '019f5a80-8492-71b3-940e-aaf1aa46025e', '80489af9-a27f-469d-aabb-16681c5cf916', 5000000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:03:19', '2026-07-13 01:03:19'),
('019f5a80-8496-7333-9bb6-92ad224571f5', '019f5a80-8492-71b3-940e-aaf1aa46025e', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 5000000.00, 'Dana Bantuan Organisasi Lainnya Sumbangan Muswyil UMSIDA', '2026-07-13 01:03:19', '2026-07-13 01:03:19'),
('019f5a82-b37d-7327-ac8e-08507ae967a4', '019f5a82-b37a-7020-aaa7-680d38b9622b', '80489af9-a27f-469d-aabb-16681c5cf916', 10000000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:05:42', '2026-07-13 01:05:42'),
('019f5a82-b380-7285-b87a-edbe020035d3', '019f5a82-b37a-7020-aaa7-680d38b9622b', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 10000000.00, 'Dana Bantuan Organisasi Lainnya Sumbangan Muswyil RS Aisyiyah Bojonegoro', '2026-07-13 01:05:42', '2026-07-13 01:05:42'),
('019f5a84-c8a6-72d1-9c11-299d469be925', '019f5a84-c8a2-71fe-aeca-7eba4c31b65b', '80489af9-a27f-469d-aabb-16681c5cf916', 5000000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:07:59', '2026-07-13 01:07:59'),
('019f5a84-c8a7-738e-94c4-3a80be925c39', '019f5a84-c8a2-71fe-aeca-7eba4c31b65b', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 5000000.00, 'Dana Bantuan Organisasi Lainnya Sumbangan Muswyil SMA M Gresik', '2026-07-13 01:07:59', '2026-07-13 01:07:59'),
('019f5a86-584f-7192-8090-42b2e5e74978', '019f5a86-584d-70ba-a70e-a348776c5f9c', '80489af9-a27f-469d-aabb-16681c5cf916', 5000000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:09:41', '2026-07-13 01:09:41'),
('019f5a86-5851-724f-ac6a-bbffe00b5d02', '019f5a86-584d-70ba-a70e-a348776c5f9c', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 5000000.00, 'Dana Bantuan Organisasi Lainnya Sumbangan Muswyil UMJ', '2026-07-13 01:09:41', '2026-07-13 01:09:41'),
('019f5a87-c7d9-70b0-9dc8-6240943c4701', '019f5a87-c7d6-7072-a418-a23e6a7721da', '80489af9-a27f-469d-aabb-16681c5cf916', 2500000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:11:15', '2026-07-13 01:11:15'),
('019f5a87-c7da-72bb-9792-86b4962af780', '019f5a87-c7d6-7072-a418-a23e6a7721da', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 2500000.00, 'Dana Bantuan Organisasi Lainnya Irvand Gustari', '2026-07-13 01:11:15', '2026-07-13 01:11:15'),
('019f5a89-722f-7322-8655-10e4709776a0', '019f5a89-722b-7198-82d2-746e9346bc71', '80489af9-a27f-469d-aabb-16681c5cf916', 10000000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:13:04', '2026-07-13 01:13:04'),
('019f5a89-7232-70af-8050-560f448d5b64', '019f5a89-722b-7198-82d2-746e9346bc71', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 10000000.00, 'Dana Bantuan Organisasi Lainnya Mumtaz (Aad)', '2026-07-13 01:13:04', '2026-07-13 01:13:04'),
('019f5a8a-a95b-71d0-93f2-00504ac3e390', '019f5a8a-a958-71e5-8e48-22c2250fd722', '80489af9-a27f-469d-aabb-16681c5cf916', 5000000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:14:24', '2026-07-13 01:14:24'),
('019f5a8a-a95c-727e-a7ef-c5174a8bb93c', '019f5a8a-a958-71e5-8e48-22c2250fd722', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 5000000.00, 'Dana Bantuan Organisasi Lainnya UM Lamongan', '2026-07-13 01:14:24', '2026-07-13 01:14:24'),
('019f5a8b-dfb9-70f7-bec1-b2f127d5547f', '019f5a8b-dfb6-73f5-868e-3bc17a97e785', '80489af9-a27f-469d-aabb-16681c5cf916', 1000000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:15:44', '2026-07-13 01:15:44'),
('019f5a8b-dfba-7143-8de3-f1c726d03236', '019f5a8b-dfb6-73f5-868e-3bc17a97e785', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 1000000.00, 'Dana Bantuan Organisasi Lainnya M Idaham', '2026-07-13 01:15:44', '2026-07-13 01:15:44'),
('019f5a8d-1798-7202-9321-c5ac0ba4fe8a', '019f5a8d-1794-72e4-8e02-42a12a5e7fb2', '80489af9-a27f-469d-aabb-16681c5cf916', 3000000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:17:03', '2026-07-13 01:17:03'),
('019f5a8d-1799-73d5-b2a2-f4e767693a7e', '019f5a8d-1794-72e4-8e02-42a12a5e7fb2', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 3000000.00, 'Dana Bantuan Organisasi Lainnya SMPM 12 GKB', '2026-07-13 01:17:03', '2026-07-13 01:17:03'),
('019f5a8e-a68c-7034-8b66-6fa34844b553', '019f5a8e-a689-7308-8be8-262f5c29ecca', '80489af9-a27f-469d-aabb-16681c5cf916', 20000000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:18:46', '2026-07-13 01:18:46'),
('019f5a8e-a690-7120-b6c3-a2b06bf4eaaa', '019f5a8e-a689-7308-8be8-262f5c29ecca', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 20000000.00, 'Dana Bantuan Organisasi Lainnya RSU Aisyiyah Ponorogo', '2026-07-13 01:18:46', '2026-07-13 01:18:46'),
('019f5a90-3635-7152-9cbd-3ff0bd9648a1', '019f5a90-3632-72f9-a23f-0639bf3fdf5a', '80489af9-a27f-469d-aabb-16681c5cf916', 250000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:20:28', '2026-07-13 01:20:28'),
('019f5a90-3637-71e0-ac62-fd8fe1c59967', '019f5a90-3632-72f9-a23f-0639bf3fdf5a', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 250000.00, 'Dana Bantuan Organisasi Lainnya Ati Fatur', '2026-07-13 01:20:28', '2026-07-13 01:20:28'),
('019f5a91-50d4-7038-ba0a-df19cddec0cc', '019f5a91-50d1-700e-88cf-5bf501392b82', '80489af9-a27f-469d-aabb-16681c5cf916', 700000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:21:40', '2026-07-13 01:21:40'),
('019f5a91-50d5-7152-94df-034f55584c2c', '019f5a91-50d1-700e-88cf-5bf501392b82', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 700000.00, 'Dana Bantuan Organisasi Lainnya Asrofi', '2026-07-13 01:21:40', '2026-07-13 01:21:40'),
('019f5a92-9ed8-7307-8838-9b0737125233', '019f5a92-9ed5-7292-9b7b-7465f3f1715e', '80489af9-a27f-469d-aabb-16681c5cf916', 10000000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:23:06', '2026-07-13 01:23:06'),
('019f5a92-9eda-7180-82d2-66f6f492084c', '019f5a92-9ed5-7292-9b7b-7465f3f1715e', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 10000000.00, 'Dana Bantuan Organisasi Lainnya Prof Zaenudin M', '2026-07-13 01:23:06', '2026-07-13 01:23:06'),
('019f5a94-33f5-72a5-9941-d426695b1e22', '019f5a94-33f1-7170-b50a-773a8814637a', '80489af9-a27f-469d-aabb-16681c5cf916', 5000000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:24:49', '2026-07-13 01:24:49'),
('019f5a94-33f8-737b-8f5e-3e5a9e63ae5c', '019f5a94-33f1-7170-b50a-773a8814637a', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 5000000.00, 'Dana Bantuan Organisasi Lainnya SMKM 7 Gondang', '2026-07-13 01:24:49', '2026-07-13 01:24:49'),
('019f5a95-6e7f-727a-8e29-d94df2c31efb', '019f5a95-6e7c-725f-a10c-d427a38467d0', '80489af9-a27f-469d-aabb-16681c5cf916', 3000000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:26:10', '2026-07-13 01:26:10'),
('019f5a95-6e81-706b-ac63-8958f6413e2a', '019f5a95-6e7c-725f-a10c-d427a38467d0', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 3000000.00, 'Dana Bantuan Organisasi Lainnya Pemasukan', '2026-07-13 01:26:10', '2026-07-13 01:26:10'),
('019f5a97-1cb9-725f-a028-fb6702c31748', '019f5a97-1cb5-73ee-ac53-826527668dfe', '80489af9-a27f-469d-aabb-16681c5cf916', 10000000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:28:00', '2026-07-13 01:28:00'),
('019f5a97-1cba-7376-9668-d90c3342a536', '019f5a97-1cb5-73ee-ac53-826527668dfe', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 10000000.00, 'Dana Bantuan Organisasi Lainnya RSM Gresik', '2026-07-13 01:28:00', '2026-07-13 01:28:00'),
('019f5a99-3ee9-70c7-9823-60d3693a8f6d', '019f5a99-3ee6-727f-aa51-525ffcbe02b0', '80489af9-a27f-469d-aabb-16681c5cf916', 2500000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:30:20', '2026-07-13 01:30:20'),
('019f5a99-3eeb-722d-b157-de3368012a7e', '019f5a99-3ee6-727f-aa51-525ffcbe02b0', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 2500000.00, 'Dana Bantuan Organisasi Lainnya SD M 2 GKB', '2026-07-13 01:30:20', '2026-07-13 01:30:20'),
('019f5a9b-0797-721b-9093-b198dc0e61c6', '019f5a9b-0795-714d-8954-630acd35c46c', '80489af9-a27f-469d-aabb-16681c5cf916', 250000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:32:17', '2026-07-13 01:32:17'),
('019f5a9b-0798-7087-aa79-54726d96c3ae', '019f5a9b-0795-714d-8954-630acd35c46c', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 250000.00, 'Dana Bantuan Organisasi Lainnya Nur Hayati', '2026-07-13 01:32:17', '2026-07-13 01:32:17'),
('019f5a9c-850c-7271-8cc1-ec52f275a71d', '019f5a9c-8509-7111-a5af-8b629865fd9d', '80489af9-a27f-469d-aabb-16681c5cf916', 1000000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:33:54', '2026-07-13 01:33:54'),
('019f5a9c-8510-7219-aee2-4f19e80cb0ab', '019f5a9c-8509-7111-a5af-8b629865fd9d', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 1000000.00, 'Dana Bantuan Organisasi Lainnya dr Qonita', '2026-07-13 01:33:54', '2026-07-13 01:33:54'),
('019f5a9e-47d8-73f3-8521-0462b432fe4c', '019f5a9e-47d5-72d6-b722-4db5209ba781', '80489af9-a27f-469d-aabb-16681c5cf916', 2500000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:35:50', '2026-07-13 01:35:50'),
('019f5a9e-47da-7120-ad7f-98720cb8a737', '019f5a9e-47d5-72d6-b722-4db5209ba781', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 2500000.00, 'Dana Bantuan Organisasi Lainnya SMAM 10 Gresik', '2026-07-13 01:35:50', '2026-07-13 01:35:50'),
('019f5a9f-858d-73ad-b14d-e3245dc3ac9a', '019f5a9f-8589-7291-bd98-0069acca537b', '80489af9-a27f-469d-aabb-16681c5cf916', 20000000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:37:11', '2026-07-13 01:37:11'),
('019f5a9f-858f-70c7-a456-8a231d514a21', '019f5a9f-8589-7291-bd98-0069acca537b', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 20000000.00, 'Dana Bantuan Organisasi Lainnya PAN Jatim', '2026-07-13 01:37:11', '2026-07-13 01:37:11'),
('019f5aa1-f8b2-7009-bddb-8f893472d828', '019f5aa1-f8af-718d-8493-7b2a452bc6c2', '80489af9-a27f-469d-aabb-16681c5cf916', 415107.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:39:52', '2026-07-13 01:39:52'),
('019f5aa1-f8b4-725c-b344-25cffe1c0410', '019f5aa1-f8af-718d-8493-7b2a452bc6c2', '638a512b-cab3-4d52-b467-7193ccc1feb3', 0.00, 415107.00, 'Pendapatan Jasa Bank (Neto) Penerimaan bunga tabungan', '2026-07-13 01:39:52', '2026-07-13 01:39:52'),
('019f5aa4-980f-73ff-bc54-5f97f7b0658b', '019f5aa4-980d-70cf-aba0-5ca189760bbb', '2ffe0b7f-2bc6-4dac-9940-e53393a90f58', 83021.00, 0.00, 'Biaya Administrasi Bank Pengeluaran', '2026-07-13 01:42:44', '2026-07-13 01:42:44'),
('019f5aa4-9810-73c6-a9b9-2b5687e7216b', '019f5aa4-980d-70cf-aba0-5ca189760bbb', '80489af9-a27f-469d-aabb-16681c5cf916', 0.00, 83021.00, 'Kas di Bank Jatim Dr. Soetomo Kas Keluar', '2026-07-13 01:42:44', '2026-07-13 01:42:44'),
('019f5aa6-40d4-70ba-a2ce-7462eae4a637', '019f5aa6-40d1-713a-ba41-aff8aa413c86', '80489af9-a27f-469d-aabb-16681c5cf916', 10000000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:44:32', '2026-07-13 01:44:32'),
('019f5aa6-40dd-7089-a40a-16061febd23a', '019f5aa6-40d1-713a-ba41-aff8aa413c86', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 10000000.00, 'Dana Bantuan Organisasi Lainnya RS Siti Khodijah', '2026-07-13 01:44:32', '2026-07-13 01:44:32'),
('019f5aa7-9f80-71b7-8737-7368c3cc510f', '019f5aa7-9f7d-71dd-acb2-b926a92fb44c', '80489af9-a27f-469d-aabb-16681c5cf916', 5000000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:46:02', '2026-07-13 01:46:02'),
('019f5aa7-9f81-70b8-ae7f-a83c98371b62', '019f5aa7-9f7d-71dd-acb2-b926a92fb44c', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 5000000.00, 'Dana Bantuan Organisasi Lainnya Parahita', '2026-07-13 01:46:02', '2026-07-13 01:46:02'),
('019f5aa9-2c94-7254-811a-60e033e2534d', '019f5aa9-2c90-71dc-898a-629bfda15812', '80489af9-a27f-469d-aabb-16681c5cf916', 5000000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:47:44', '2026-07-13 01:47:44'),
('019f5aa9-2c95-7047-afa1-d5d621e2f690', '019f5aa9-2c90-71dc-898a-629bfda15812', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 5000000.00, 'Dana Bantuan Organisasi Lainnya Universitas Muhammadiyah Gresik', '2026-07-13 01:47:44', '2026-07-13 01:47:44'),
('019f5aaa-43a4-71f3-9cce-cd9545302041', '019f5aaa-43a1-71ac-84a2-8a0e6d7bdd42', '80489af9-a27f-469d-aabb-16681c5cf916', 500000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:48:55', '2026-07-13 01:48:55'),
('019f5aaa-43a8-7199-a6d5-e3fd4234ff6d', '019f5aaa-43a1-71ac-84a2-8a0e6d7bdd42', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 500000.00, 'Dana Bantuan Organisasi Lainnya Muhajir', '2026-07-13 01:48:55', '2026-07-13 01:48:55'),
('019f5aab-5beb-73d4-b6f2-b625567af51f', '019f5aab-5be9-727c-be85-b01afaeec6e0', '80489af9-a27f-469d-aabb-16681c5cf916', 10000000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:50:07', '2026-07-13 01:50:07'),
('019f5aab-5bed-7062-8e16-6c59676bf794', '019f5aab-5be9-727c-be85-b01afaeec6e0', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 10000000.00, 'Dana Bantuan Organisasi Lainnya Widati Muhajir', '2026-07-13 01:50:07', '2026-07-13 01:50:07'),
('019f5aac-9e26-7030-ba1c-de2ac6b3121b', '019f5aac-9e24-70d3-a8a2-e413893db22b', '80489af9-a27f-469d-aabb-16681c5cf916', 250000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:51:29', '2026-07-13 01:51:29'),
('019f5aac-9e27-7300-a3a1-479080a89577', '019f5aac-9e24-70d3-a8a2-e413893db22b', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 250000.00, 'Dana Bantuan Organisasi Lainnya Pemasukan', '2026-07-13 01:51:29', '2026-07-13 01:51:29'),
('019f5aad-8f28-700f-888c-80c728ef9fba', '019f5aad-8f25-7321-bfd0-a27a13704dcb', '80489af9-a27f-469d-aabb-16681c5cf916', 3000000.00, 0.00, 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:52:31', '2026-07-13 01:52:31'),
('019f5aad-8f2c-70e8-aef9-aa31aea5594b', '019f5aad-8f25-7321-bfd0-a27a13704dcb', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 0.00, 3000000.00, 'Dana Bantuan Organisasi Lainnya Pemasukan', '2026-07-13 01:52:31', '2026-07-13 01:52:31');

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

--
-- Dumping data untuk tabel `media`
--

INSERT INTO `media` (`id`, `model_type`, `model_id`, `uuid`, `collection_name`, `name`, `file_name`, `mime_type`, `disk`, `conversions_disk`, `size`, `manipulations`, `custom_properties`, `generated_conversions`, `responsive_images`, `order_column`, `created_at`, `updated_at`) VALUES
(2, 'App\\Models\\Configuration', '019f3c29-c4ec-710c-80f2-a7a91e5c3581', '837e5ea1-f36e-43a1-8213-0c483111f05b', 'configuration_app_logo', 'images-removebg-preview', 'images-removebg-preview.png', 'image/png', 'public', 'public', 113692, '[]', '[]', '[]', '[]', 1, '2026-08-02 04:06:31', '2026-08-02 04:06:31');

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
('3hGdX9v6UVJIMPU8datERqrFBIqyW5DeLPmUKUZQ', '019f3c29-d401-730d-a58f-9fac0918ea2c', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiNXRzaDhkdFBBM2RqWWJXN1NVdGpMZnZaNEFzdkp5U0NVZUJRYjZwSCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjU6Imh0dHBzOi8vZGlzcG9zaXNpLmVuZ2luZWVyaW5nLXVtc3VyYS5pZC9iZW5kYWhhcmEvcmVwb3J0cy9qb3VybmFsIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO3M6MzY6IjAxOWYzYzI5LWQ0MDEtNzMwZC1hNThmLTlmYWMwOTE4ZWEyYyI7fQ==', 1785669152),
('aksNg0RWiSt41ulmkAPC1c9EhdP05AgSN6vEIwed', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiR2I3R1FwTlFBRkZWY1hwSkpPS0tmUDVxWWx2bnVRMXJiQUZPaEN1biI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzI6Imh0dHBzOi8vZGlzcG9zaXNpLmVuZ2luZWVyaW5nLXVtc3VyYS5pZC91c2VyL3RyYW5zYWN0aW9ucy9pbmNvbWVzL2NyZWF0ZSI7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtzOjM2OiIwMTlmM2MyOS1kNWQwLTcxZjktYTNlNi0zZjA3OTU5MjdjZDUiO30=', 1785669194),
('HOBqni7g8yldp7mE3EKMI1Lt4ysytCKXNcHFPTBS', NULL, '103.112.245.9', 'Python/3.11 aiohttp/3.9.2', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN1FVaHoxNThsQnJOdUFPZkdRVzh2YXQ1NUhLYzRXa1RPVUswMklFSyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDU6Imh0dHBzOi8vZGlzcG9zaXNpLmVuZ2luZWVyaW5nLXVtc3VyYS5pZC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1785669666),
('nqObNy7J5pHByqwvTECakW2SJ0t6iJgBoMBvPcxF', NULL, '103.112.245.9', 'Python/3.11 aiohttp/3.9.2', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU2w5WG42WE1WenNidklWV1phczFtRWZNWEtESGdaRktlcUltRWZUciI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDU6Imh0dHBzOi8vZGlzcG9zaXNpLmVuZ2luZWVyaW5nLXVtc3VyYS5pZC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1785662466),
('oFTzUEaLsCy0UYrNrO9pX4LK9abjhGdcQqvaIPbY', NULL, '103.112.245.9', 'Python/3.11 aiohttp/3.9.2', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU0Nic2FIVmRFZmRKWGoyWUp6OWhPYnB5RGtZbTFCU1hJbXpONmRVOCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDU6Imh0dHBzOi8vZGlzcG9zaXNpLmVuZ2luZWVyaW5nLXVtc3VyYS5pZC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1785666063),
('S2ZgYBZl2H9dC3PuvRmcVJqdZjeupgqVP7mDOhrV', NULL, '103.112.245.9', 'Python/3.11 aiohttp/3.9.2', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSW8wdGNOT3JuYkV2UWU0Y2Y4M0Z5dmYycmY0YlRYYXo1bmdMQU5rMyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDU6Imh0dHBzOi8vZGlzcG9zaXNpLmVuZ2luZWVyaW5nLXVtc3VyYS5pZC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1785667861),
('SRDasYPY0jmoOnj3PR5oWJzkcEKug1yglgJUgpku', NULL, '103.112.245.9', 'Python/3.11 aiohttp/3.9.2', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNXVHMmdzOFBWeENxaThnRGQ5bEFxRGltd0dMTnB2YTJ0U0tvRmV4OSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDU6Imh0dHBzOi8vZGlzcG9zaXNpLmVuZ2luZWVyaW5nLXVtc3VyYS5pZC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1785664258),
('WrAGDCD5jFlPzQMYKwD32iuiFqU6Pij5dYybwFeS', NULL, '205.210.31.37', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidE9oa3BGVHNTN2R5MkI3cjNLUGtBYzNuTGJKTlk1bElMRkRabnVjUiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDM6Imh0dHBzOi8vd3d3LmRpc3Bvc2lzaS5lbmdpbmVlcmluZy11bXN1cmEuaWQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1785664142),
('WT4aw30pdzjj0pmSdQaDKzxfYfpwJkh5t4DvB1fP', NULL, '205.210.31.37', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRGRYajAwcDZLZmpsZ1M5c3VyQUUxYVdRVUE2SjEzMDJ2ZFc0SEV0bSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDk6Imh0dHBzOi8vd3d3LmRpc3Bvc2lzaS5lbmdpbmVlcmluZy11bXN1cmEuaWQvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1785664143);

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

--
-- Dumping data untuk tabel `transactions`
--

INSERT INTO `transactions` (`id`, `transaction_number`, `transaction_date`, `transaction_type`, `description`, `status`, `gross_amount`, `net_amount`, `referencree_number`, `receipt_path`, `created_by`, `period_id`, `sub_period_id`, `posted_at`, `created_at`, `updated_at`) VALUES
('019f5a5c-e6cf-70f7-b5af-941fad678ec1', 'TRX-INC-20260713072425', '2023-01-04', 'INCOME', 'Sumbangan Musywil Bagus Irawan', 'POSTED', 1000000.00, 1000000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 00:24:25', '2026-07-13 00:24:25'),
('019f5a66-a420-702b-b44e-f71c9b8f50d0', 'TRX-INC-20260713073503', '2023-01-04', 'INCOME', 'Sumbangan Muswyil UMsurabaya', 'POSTED', 25000000.00, 25000000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 00:35:03', '2026-07-13 00:35:03'),
('019f5a68-4333-727c-a353-a2d3cf713a52', 'TRX-INC-20260713073650', '2023-01-04', 'INCOME', 'pemasukan', 'POSTED', 300000.00, 300000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 00:36:50', '2026-07-13 00:36:50'),
('019f5a6a-456e-7266-81df-df9034109647', 'TRX-INC-20260713073901', '2023-01-05', 'INCOME', 'Sumbangan Musywil SMP M 2 Taman', 'POSTED', 3000000.00, 3000000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 00:39:01', '2026-07-13 00:39:01'),
('019f5a6e-5585-7026-a4a1-a0516e80837f', 'TRX-INC-20260713074328', '2023-01-05', 'INCOME', 'Sumbangan RSA Dahlan Kediri', 'POSTED', 7500000.00, 7500000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 00:43:28', '2026-07-13 00:43:28'),
('019f5a71-2cf2-7333-ab04-1a2fdd0a8c46', 'TRX-INC-20260713074634', '2023-01-05', 'INCOME', 'Sumbangan SMA M 2 Surabaya', 'POSTED', 5000000.00, 5000000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 00:46:34', '2026-07-13 00:46:34'),
('019f5a73-af00-70f5-bee5-36b93b290f3b', 'TRX-INC-20260713074918', '2023-01-05', 'INCOME', 'Sumbangan RSI Aisyiyah Malang', 'POSTED', 10000000.00, 10000000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 00:49:18', '2026-07-13 00:49:18'),
('019f5a75-d0bd-715b-847f-781d19ba464b', 'TRX-INC-20260713075138', '2023-01-05', 'INCOME', 'Sumbangan Musywil RSIA Nganjuk', 'POSTED', 20000000.00, 20000000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 00:51:38', '2026-07-13 00:51:38'),
('019f5a76-00c9-7150-9f9a-974c7e377421', 'TRX-INC-20260713075150', '2023-01-05', 'INCOME', 'Sumbangan Musywil RSIA Nganjuk', 'POSTED', 20000000.00, 20000000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 00:51:50', '2026-07-13 00:51:50'),
('019f5a78-97a9-73e5-8b10-41ab0d291585', 'TRX-INC-20260713075440', '2023-01-05', 'INCOME', 'Sumbangan Muswyil SMA M Sidoarjo', 'POSTED', 5000000.00, 5000000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 00:54:40', '2026-07-13 00:54:40'),
('019f5a7a-f366-7187-8974-143ae9e74c16', 'TRX-INC-20260713075714', '2023-01-06', 'INCOME', 'Sumbangan Muswyil SDM 1 Sidoarjo', 'POSTED', 1500000.00, 1500000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 00:57:14', '2026-07-13 00:57:14'),
('019f5a7c-e07d-72dd-99a3-6361ae7bad2b', 'TRX-INC-20260713075921', '2023-01-06', 'INCOME', 'Sumbangan Muswyil SMP M 1 Sidoarjo', 'POSTED', 3000000.00, 3000000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 00:59:21', '2026-07-13 00:59:21'),
('019f5a7e-aed9-7156-80eb-a011650c0f0a', 'TRX-INC-20260713080119', '2023-01-06', 'INCOME', 'Pembayaran Simpanan Wajib Organisasi', 'POSTED', 2250000.00, 2250000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 01:01:19', '2026-07-13 01:01:19'),
('019f5a80-8486-705f-9dbc-29b804e92ecb', 'TRX-INC-20260713080319', '2023-01-06', 'INCOME', 'Sumbangan Muswyil UMSIDA', 'POSTED', 5000000.00, 5000000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 01:03:19', '2026-07-13 01:03:19'),
('019f5a82-b36f-73c8-a3b5-a083246f5e42', 'TRX-INC-20260713080542', '2023-01-06', 'INCOME', 'Sumbangan Muswyil RS Aisyiyah Bojonegoro', 'POSTED', 10000000.00, 10000000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 01:05:42', '2026-07-13 01:05:42'),
('019f5a84-c894-70ab-9b90-003766a788fd', 'TRX-INC-20260713080759', '2023-01-06', 'INCOME', 'Sumbangan Muswyil SMA M Gresik', 'POSTED', 5000000.00, 5000000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 01:07:59', '2026-07-13 01:07:59'),
('019f5a86-5841-73ac-af09-9ab660c71f6c', 'TRX-INC-20260713080941', '2023-01-07', 'INCOME', 'Sumbangan Muswyil UMJ', 'POSTED', 5000000.00, 5000000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 01:09:41', '2026-07-13 01:09:41'),
('019f5a87-c7c7-729a-b661-b5b23c77387d', 'TRX-INC-20260713081115', '2023-01-09', 'INCOME', 'Irvand Gustari', 'POSTED', 2500000.00, 2500000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 01:11:15', '2026-07-13 01:11:15'),
('019f5a89-721d-7303-9700-2756e50125c3', 'TRX-INC-20260713081304', '2023-01-09', 'INCOME', 'Mumtaz (Aad)', 'POSTED', 10000000.00, 10000000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 01:13:04', '2026-07-13 01:13:04'),
('019f5a8a-a94a-72f8-adb5-fa9d20e16305', 'TRX-INC-20260713081424', '2023-01-09', 'INCOME', 'UM Lamongan', 'POSTED', 5000000.00, 5000000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 01:14:24', '2026-07-13 01:14:24'),
('019f5a8b-dfa3-72c7-bef4-a32e6f80c785', 'TRX-INC-20260713081544', '2023-01-09', 'INCOME', 'M Idaham', 'POSTED', 1000000.00, 1000000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 01:15:44', '2026-07-13 01:15:44'),
('019f5a8d-1786-7231-9c82-9452d0a7f4da', 'TRX-INC-20260713081703', '2023-01-09', 'INCOME', 'SMPM 12 GKB', 'POSTED', 3000000.00, 3000000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 01:17:03', '2026-07-13 01:17:03'),
('019f5a8e-a67b-733b-a007-eec9a2e0e0be', 'TRX-INC-20260713081846', '2023-01-10', 'INCOME', 'RSU Aisyiyah Ponorogo', 'POSTED', 20000000.00, 20000000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 01:18:46', '2026-07-13 01:18:46'),
('019f5a90-3620-7277-9739-30c7f4621dff', 'TRX-INC-20260713082028', '2023-01-11', 'INCOME', 'Ati Fatur', 'POSTED', 250000.00, 250000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 01:20:28', '2026-07-13 01:20:28'),
('019f5a91-50c3-71ee-af81-e8000034b023', 'TRX-INC-20260713082140', '2023-01-12', 'INCOME', 'Asrofi', 'POSTED', 700000.00, 700000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 01:21:40', '2026-07-13 01:21:40'),
('019f5a92-9ec5-70b2-823a-7a0950b70aed', 'TRX-INC-20260713082306', '2023-01-12', 'INCOME', 'Prof Zaenudin M', 'POSTED', 10000000.00, 10000000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 01:23:06', '2026-07-13 01:23:06'),
('019f5a94-33e1-735d-9737-eb8fe2ce5b8c', 'TRX-INC-20260713082449', '2023-01-12', 'INCOME', 'SMKM 7 Gondang', 'POSTED', 5000000.00, 5000000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 01:24:49', '2026-07-13 01:24:49'),
('019f5a95-6e70-739f-b7f5-810181098b19', 'TRX-INC-20260713082610', '2023-01-13', 'INCOME', 'Pemasukan', 'POSTED', 3000000.00, 3000000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 01:26:10', '2026-07-13 01:26:10'),
('019f5a97-1ca6-70d9-bbd4-0f7487c15989', 'TRX-INC-20260713082800', '2023-01-13', 'INCOME', 'RSM Gresik', 'POSTED', 10000000.00, 10000000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 01:28:00', '2026-07-13 01:28:00'),
('019f5a99-3ed5-7269-9c8e-e598ac057e15', 'TRX-INC-20260713083020', '2023-01-13', 'INCOME', 'SD M 2 GKB', 'POSTED', 2500000.00, 2500000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 01:30:20', '2026-07-13 01:30:20'),
('019f5a9b-0786-7153-9288-afc6489e2274', 'TRX-INC-20260713083217', '2023-01-13', 'INCOME', 'Nur Hayati', 'POSTED', 250000.00, 250000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 01:32:17', '2026-07-13 01:32:17'),
('019f5a9c-84fd-728b-bdbc-50e47cd570b1', 'TRX-INC-20260713083354', '2023-01-13', 'INCOME', 'dr Qonita', 'POSTED', 1000000.00, 1000000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 01:33:54', '2026-07-13 01:33:54'),
('019f5a9e-47c4-7221-99a6-aa739803bfa4', 'TRX-INC-20260713083550', '2023-01-15', 'INCOME', 'SMAM 10 Gresik', 'POSTED', 2500000.00, 2500000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 01:35:50', '2026-07-13 01:35:50'),
('019f5a9f-857c-722a-bd72-f219d87e400e', 'TRX-INC-20260713083711', '2023-01-15', 'INCOME', 'PAN Jatim', 'POSTED', 20000000.00, 20000000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 01:37:11', '2026-07-13 01:37:11'),
('019f5aa1-f89d-717f-bb68-50ec40a34070', 'TRX-INC-20260713083952', '2023-01-16', 'INCOME', 'Penerimaan bunga tabungan', 'POSTED', 415107.00, 415107.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 01:39:52', '2026-07-13 01:39:52'),
('019f5aa4-97fe-7392-a2c2-21f66636db48', 'TRX-EXP-20260713084244', '2023-01-16', 'EXPENSE', 'Pembayaran pajak tabungan', 'POSTED', 83021.00, 83021.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 01:42:44', '2026-07-13 01:42:44'),
('019f5aa6-40c4-738a-927c-1594c476378d', 'TRX-INC-20260713084432', '2023-01-18', 'INCOME', 'RS Siti Khodijah', 'POSTED', 10000000.00, 10000000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 01:44:32', '2026-07-13 01:44:32'),
('019f5aa7-9f6e-705d-a50e-70ebf135c020', 'TRX-INC-20260713084602', '2023-01-18', 'INCOME', 'Parahita', 'POSTED', 5000000.00, 5000000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 01:46:02', '2026-07-13 01:46:02'),
('019f5aa9-2c86-72d5-921d-a7e641546777', 'TRX-INC-20260713084744', '2023-01-18', 'INCOME', 'Universitas Muhammadiyah Gresik', 'POSTED', 5000000.00, 5000000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 01:47:44', '2026-07-13 01:47:44'),
('019f5aaa-4391-705a-8b59-309a96cdb8f4', 'TRX-INC-20260713084855', '2023-01-19', 'INCOME', 'Muhajir', 'POSTED', 500000.00, 500000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 01:48:55', '2026-07-13 01:48:55'),
('019f5aab-5bd5-7210-83b8-0d9609e53ce4', 'TRX-INC-20260713085007', '2023-01-20', 'INCOME', 'Widati Muhajir', 'POSTED', 10000000.00, 10000000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 01:50:07', '2026-07-13 01:50:07'),
('019f5aac-9e17-7395-b4c8-e1a67e4f7eec', 'TRX-INC-20260713085129', '2023-01-21', 'INCOME', 'Pemasukan', 'POSTED', 250000.00, 250000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 01:51:29', '2026-07-13 01:51:29'),
('019f5aad-8f19-713b-b842-b31e14f0d957', 'TRX-INC-20260713085231', '2023-01-28', 'INCOME', 'Pemasukan', 'POSTED', 3000000.00, 3000000.00, NULL, NULL, '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', NULL, '2026-07-13 01:52:31', '2026-07-13 01:52:31');

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
('019f5a5c-e6d6-73b0-aa3c-5cfba669cb53', '019f5a5c-e6cf-70f7-b5af-941fad678ec1', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 1000000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 00:24:25', '2026-07-13 00:24:25'),
('019f5a5c-e6d8-71a4-ac7d-140b025a01d8', '019f5a5c-e6cf-70f7-b5af-941fad678ec1', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 1000000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya Sumbangan Musywil Bagus Irawan', '2026-07-13 00:24:25', '2026-07-13 00:24:25'),
('019f5a66-a425-73fb-90a4-0c6d7f6b55e9', '019f5a66-a420-702b-b44e-f71c9b8f50d0', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 25000000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 00:35:03', '2026-07-13 00:35:03'),
('019f5a66-a427-721a-951c-18084d4c95a1', '019f5a66-a420-702b-b44e-f71c9b8f50d0', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 25000000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya Sumbangan Muswyil UMsurabaya', '2026-07-13 00:35:03', '2026-07-13 00:35:03'),
('019f5a68-4339-724f-8473-978c8f63363a', '019f5a68-4333-727c-a353-a2d3cf713a52', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 300000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 00:36:50', '2026-07-13 00:36:50'),
('019f5a68-433c-7189-a793-a3cef317bd6b', '019f5a68-4333-727c-a353-a2d3cf713a52', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 300000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya pemasukan', '2026-07-13 00:36:50', '2026-07-13 00:36:50'),
('019f5a6a-4575-7088-a645-384b3e5f4c05', '019f5a6a-456e-7266-81df-df9034109647', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 3000000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 00:39:01', '2026-07-13 00:39:01'),
('019f5a6a-4577-70b9-a5ec-0345f87d95a2', '019f5a6a-456e-7266-81df-df9034109647', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 3000000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya Sumbangan Musywil SMP M 2 Taman', '2026-07-13 00:39:01', '2026-07-13 00:39:01'),
('019f5a6e-558c-70f0-8442-c2945a987f8d', '019f5a6e-5585-7026-a4a1-a0516e80837f', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 7500000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 00:43:28', '2026-07-13 00:43:28'),
('019f5a6e-558d-70fe-bb34-d2372ee9431b', '019f5a6e-5585-7026-a4a1-a0516e80837f', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 7500000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya Sumbangan RSA Dahlan Kediri', '2026-07-13 00:43:28', '2026-07-13 00:43:28'),
('019f5a71-2cf8-725a-81eb-b4941e297f3e', '019f5a71-2cf2-7333-ab04-1a2fdd0a8c46', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 5000000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 00:46:34', '2026-07-13 00:46:34'),
('019f5a71-2cfa-7129-ad5c-60da64f65b87', '019f5a71-2cf2-7333-ab04-1a2fdd0a8c46', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 5000000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya Sumbangan SMA M 2 Surabaya', '2026-07-13 00:46:34', '2026-07-13 00:46:34'),
('019f5a73-af07-7390-a4c8-eca21ee34e93', '019f5a73-af00-70f5-bee5-36b93b290f3b', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 10000000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 00:49:18', '2026-07-13 00:49:18'),
('019f5a73-af0a-7077-b592-7a1046339efe', '019f5a73-af00-70f5-bee5-36b93b290f3b', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 10000000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya Sumbangan RSI Aisyiyah Malang', '2026-07-13 00:49:18', '2026-07-13 00:49:18'),
('019f5a75-d0c4-734a-8761-96f108ae3400', '019f5a75-d0bd-715b-847f-781d19ba464b', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 20000000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 00:51:38', '2026-07-13 00:51:38'),
('019f5a75-d0cb-7197-a160-90896af98833', '019f5a75-d0bd-715b-847f-781d19ba464b', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 20000000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya Sumbangan Musywil RSIA Nganjuk', '2026-07-13 00:51:38', '2026-07-13 00:51:38'),
('019f5a76-00d1-70b0-92cd-1e13ae93c3ac', '019f5a76-00c9-7150-9f9a-974c7e377421', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 20000000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 00:51:50', '2026-07-13 00:51:50'),
('019f5a76-00d3-702b-ab62-4465eedcf1fa', '019f5a76-00c9-7150-9f9a-974c7e377421', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 20000000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya Sumbangan Musywil RSIA Nganjuk', '2026-07-13 00:51:50', '2026-07-13 00:51:50'),
('019f5a78-97af-70fe-98c6-ce933b2b45d3', '019f5a78-97a9-73e5-8b10-41ab0d291585', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 5000000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 00:54:40', '2026-07-13 00:54:40'),
('019f5a78-97b1-711c-aadd-ab2dc293578b', '019f5a78-97a9-73e5-8b10-41ab0d291585', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 5000000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya Sumbangan Muswyil SMA M Sidoarjo', '2026-07-13 00:54:40', '2026-07-13 00:54:40'),
('019f5a7a-f36b-70f8-89fa-33195bc27ba4', '019f5a7a-f366-7187-8974-143ae9e74c16', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 1500000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 00:57:14', '2026-07-13 00:57:14'),
('019f5a7a-f36d-73c7-9011-efd564a8d967', '019f5a7a-f366-7187-8974-143ae9e74c16', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 1500000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya Sumbangan Muswyil SDM 1 Sidoarjo', '2026-07-13 00:57:14', '2026-07-13 00:57:14'),
('019f5a7c-e084-701b-8625-67a02d138dec', '019f5a7c-e07d-72dd-99a3-6361ae7bad2b', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 3000000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 00:59:21', '2026-07-13 00:59:21'),
('019f5a7c-e087-736f-88cc-3f3fea17b727', '019f5a7c-e07d-72dd-99a3-6361ae7bad2b', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 3000000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya Sumbangan Muswyil SMP M 1 Sidoarjo', '2026-07-13 00:59:21', '2026-07-13 00:59:21'),
('019f5a7e-aede-72c6-9616-84ac95023427', '019f5a7e-aed9-7156-80eb-a011650c0f0a', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 2250000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:01:19', '2026-07-13 01:01:19'),
('019f5a7e-aedf-73fb-8a18-04349c701837', '019f5a7e-aed9-7156-80eb-a011650c0f0a', '89b2bd63-45a5-4376-9301-75f7c5c6869f', 'CREDIT', 2250000.00, 'MAIN', 'Dana Wajib Organisasi Pembayaran Simpanan Wajib Organisasi', '2026-07-13 01:01:19', '2026-07-13 01:01:19'),
('019f5a80-848d-70b5-9529-773226cf3466', '019f5a80-8486-705f-9dbc-29b804e92ecb', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 5000000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:03:19', '2026-07-13 01:03:19'),
('019f5a80-848f-7030-9c1a-64c4f5a135ec', '019f5a80-8486-705f-9dbc-29b804e92ecb', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 5000000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya Sumbangan Muswyil UMSIDA', '2026-07-13 01:03:19', '2026-07-13 01:03:19'),
('019f5a82-b374-731d-8b85-a8211802911d', '019f5a82-b36f-73c8-a3b5-a083246f5e42', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 10000000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:05:42', '2026-07-13 01:05:42'),
('019f5a82-b376-7289-92fd-59adf20d56ce', '019f5a82-b36f-73c8-a3b5-a083246f5e42', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 10000000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya Sumbangan Muswyil RS Aisyiyah Bojonegoro', '2026-07-13 01:05:42', '2026-07-13 01:05:42'),
('019f5a84-c89b-72ac-925e-a0387856bd8a', '019f5a84-c894-70ab-9b90-003766a788fd', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 5000000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:07:59', '2026-07-13 01:07:59'),
('019f5a84-c89d-7094-b14a-6671f8af6d75', '019f5a84-c894-70ab-9b90-003766a788fd', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 5000000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya Sumbangan Muswyil SMA M Gresik', '2026-07-13 01:07:59', '2026-07-13 01:07:59'),
('019f5a86-5847-709e-9227-62e7985a57b7', '019f5a86-5841-73ac-af09-9ab660c71f6c', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 5000000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:09:41', '2026-07-13 01:09:41'),
('019f5a86-5849-735b-99dd-10eb11852c00', '019f5a86-5841-73ac-af09-9ab660c71f6c', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 5000000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya Sumbangan Muswyil UMJ', '2026-07-13 01:09:41', '2026-07-13 01:09:41'),
('019f5a87-c7cd-7105-8a07-28362bb49898', '019f5a87-c7c7-729a-b661-b5b23c77387d', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 2500000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:11:15', '2026-07-13 01:11:15'),
('019f5a87-c7cf-7187-a4a8-6ad53458f7ad', '019f5a87-c7c7-729a-b661-b5b23c77387d', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 2500000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya Irvand Gustari', '2026-07-13 01:11:15', '2026-07-13 01:11:15'),
('019f5a89-7224-73a9-af52-2aabbc79828d', '019f5a89-721d-7303-9700-2756e50125c3', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 10000000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:13:04', '2026-07-13 01:13:04'),
('019f5a89-7226-7271-a177-9d52b4e8a099', '019f5a89-721d-7303-9700-2756e50125c3', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 10000000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya Mumtaz (Aad)', '2026-07-13 01:13:04', '2026-07-13 01:13:04'),
('019f5a8a-a951-7228-8255-e4bc0d6acf30', '019f5a8a-a94a-72f8-adb5-fa9d20e16305', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 5000000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:14:24', '2026-07-13 01:14:24'),
('019f5a8a-a953-7327-b5d0-1eb1f3aac08e', '019f5a8a-a94a-72f8-adb5-fa9d20e16305', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 5000000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya UM Lamongan', '2026-07-13 01:14:24', '2026-07-13 01:14:24'),
('019f5a8b-dfab-705e-887e-69440010c96e', '019f5a8b-dfa3-72c7-bef4-a32e6f80c785', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 1000000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:15:44', '2026-07-13 01:15:44'),
('019f5a8b-dfaf-7203-83d4-3f9355bfea00', '019f5a8b-dfa3-72c7-bef4-a32e6f80c785', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 1000000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya M Idaham', '2026-07-13 01:15:44', '2026-07-13 01:15:44'),
('019f5a8d-178e-716f-a69d-3348ad9303e4', '019f5a8d-1786-7231-9c82-9452d0a7f4da', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 3000000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:17:03', '2026-07-13 01:17:03'),
('019f5a8d-1790-71b0-9b02-add19b96267a', '019f5a8d-1786-7231-9c82-9452d0a7f4da', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 3000000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya SMPM 12 GKB', '2026-07-13 01:17:03', '2026-07-13 01:17:03'),
('019f5a8e-a682-70aa-a2d4-607054c89887', '019f5a8e-a67b-733b-a007-eec9a2e0e0be', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 20000000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:18:46', '2026-07-13 01:18:46'),
('019f5a8e-a684-709f-b034-60981b61b61d', '019f5a8e-a67b-733b-a007-eec9a2e0e0be', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 20000000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya RSU Aisyiyah Ponorogo', '2026-07-13 01:18:46', '2026-07-13 01:18:46'),
('019f5a90-3627-7353-afcc-31b2a1cd5f03', '019f5a90-3620-7277-9739-30c7f4621dff', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 250000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:20:28', '2026-07-13 01:20:28'),
('019f5a90-3629-736c-afb7-06dc88484534', '019f5a90-3620-7277-9739-30c7f4621dff', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 250000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya Ati Fatur', '2026-07-13 01:20:28', '2026-07-13 01:20:28'),
('019f5a91-50ca-730d-810a-5664cdf37fa8', '019f5a91-50c3-71ee-af81-e8000034b023', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 700000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:21:40', '2026-07-13 01:21:40'),
('019f5a91-50cd-7157-b961-486ed87788bf', '019f5a91-50c3-71ee-af81-e8000034b023', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 700000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya Asrofi', '2026-07-13 01:21:40', '2026-07-13 01:21:40'),
('019f5a92-9ecd-7212-8290-9ac42c7ae60d', '019f5a92-9ec5-70b2-823a-7a0950b70aed', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 10000000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:23:06', '2026-07-13 01:23:06'),
('019f5a92-9ed0-7037-82e3-8c2d6510f1be', '019f5a92-9ec5-70b2-823a-7a0950b70aed', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 10000000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya Prof Zaenudin M', '2026-07-13 01:23:06', '2026-07-13 01:23:06'),
('019f5a94-33e7-71bd-ac0d-b00973e1e965', '019f5a94-33e1-735d-9737-eb8fe2ce5b8c', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 5000000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:24:49', '2026-07-13 01:24:49'),
('019f5a94-33e9-7314-9385-5c4938fe8de5', '019f5a94-33e1-735d-9737-eb8fe2ce5b8c', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 5000000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya SMKM 7 Gondang', '2026-07-13 01:24:49', '2026-07-13 01:24:49'),
('019f5a95-6e77-73ae-9084-c7ac8339e72d', '019f5a95-6e70-739f-b7f5-810181098b19', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 3000000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:26:10', '2026-07-13 01:26:10'),
('019f5a95-6e79-73e6-9365-b8a7952bb9d0', '019f5a95-6e70-739f-b7f5-810181098b19', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 3000000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya Pemasukan', '2026-07-13 01:26:10', '2026-07-13 01:26:10'),
('019f5a97-1cae-70ff-af6d-da0d8446a15f', '019f5a97-1ca6-70d9-bbd4-0f7487c15989', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 10000000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:28:00', '2026-07-13 01:28:00'),
('019f5a97-1cb0-71e2-9f64-3657bb7a0df1', '019f5a97-1ca6-70d9-bbd4-0f7487c15989', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 10000000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya RSM Gresik', '2026-07-13 01:28:00', '2026-07-13 01:28:00'),
('019f5a99-3eda-71cb-9643-03ad7c3932c3', '019f5a99-3ed5-7269-9c8e-e598ac057e15', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 2500000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:30:20', '2026-07-13 01:30:20'),
('019f5a99-3ee3-7378-bc99-9d3a69032d21', '019f5a99-3ed5-7269-9c8e-e598ac057e15', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 2500000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya SD M 2 GKB', '2026-07-13 01:30:20', '2026-07-13 01:30:20'),
('019f5a9b-078c-7168-a45e-b456b78c5261', '019f5a9b-0786-7153-9288-afc6489e2274', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 250000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:32:17', '2026-07-13 01:32:17'),
('019f5a9b-078e-7168-ac59-e6c1bf26982e', '019f5a9b-0786-7153-9288-afc6489e2274', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 250000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya Nur Hayati', '2026-07-13 01:32:17', '2026-07-13 01:32:17'),
('019f5a9c-8503-73b6-92d8-ae6a94f91594', '019f5a9c-84fd-728b-bdbc-50e47cd570b1', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 1000000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:33:54', '2026-07-13 01:33:54'),
('019f5a9c-8505-73ce-b2b4-0af21c91aa72', '019f5a9c-84fd-728b-bdbc-50e47cd570b1', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 1000000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya dr Qonita', '2026-07-13 01:33:54', '2026-07-13 01:33:54'),
('019f5a9e-47cd-700d-8d95-2938115f815d', '019f5a9e-47c4-7221-99a6-aa739803bfa4', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 2500000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:35:50', '2026-07-13 01:35:50'),
('019f5a9e-47cf-71d4-ade4-bee9ad610129', '019f5a9e-47c4-7221-99a6-aa739803bfa4', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 2500000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya SMAM 10 Gresik', '2026-07-13 01:35:50', '2026-07-13 01:35:50'),
('019f5a9f-8582-724e-9680-ee858b567eff', '019f5a9f-857c-722a-bd72-f219d87e400e', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 20000000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:37:11', '2026-07-13 01:37:11'),
('019f5a9f-8584-708d-ba11-8eb0cb2ce76a', '019f5a9f-857c-722a-bd72-f219d87e400e', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 20000000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya PAN Jatim', '2026-07-13 01:37:11', '2026-07-13 01:37:11'),
('019f5aa1-f8a4-723a-972e-362bc4f59ec5', '019f5aa1-f89d-717f-bb68-50ec40a34070', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 415107.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:39:52', '2026-07-13 01:39:52'),
('019f5aa1-f8a7-7302-8ee7-c6519393659a', '019f5aa1-f89d-717f-bb68-50ec40a34070', '638a512b-cab3-4d52-b467-7193ccc1feb3', 'CREDIT', 415107.00, 'MAIN', 'Pendapatan Jasa Bank (Neto) Penerimaan bunga tabungan', '2026-07-13 01:39:52', '2026-07-13 01:39:52'),
('019f5aa4-9804-73d2-a274-60e6387e8056', '019f5aa4-97fe-7392-a2c2-21f66636db48', '2ffe0b7f-2bc6-4dac-9940-e53393a90f58', 'DEBIT', 83021.00, 'MAIN', 'Biaya Administrasi Bank Pengeluaran', '2026-07-13 01:42:44', '2026-07-13 01:42:44'),
('019f5aa4-9805-7175-a54c-ff939c250950', '019f5aa4-97fe-7392-a2c2-21f66636db48', '80489af9-a27f-469d-aabb-16681c5cf916', 'CREDIT', 83021.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Keluar', '2026-07-13 01:42:44', '2026-07-13 01:42:44'),
('019f5aa6-40cb-736b-994a-22d0ed0cd824', '019f5aa6-40c4-738a-927c-1594c476378d', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 10000000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:44:32', '2026-07-13 01:44:32'),
('019f5aa6-40cd-72b2-be10-e3677f018a5d', '019f5aa6-40c4-738a-927c-1594c476378d', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 10000000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya RS Siti Khodijah', '2026-07-13 01:44:32', '2026-07-13 01:44:32'),
('019f5aa7-9f73-713f-9f88-710b320e2ce2', '019f5aa7-9f6e-705d-a50e-70ebf135c020', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 5000000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:46:02', '2026-07-13 01:46:02'),
('019f5aa7-9f75-716b-b1a4-4a341cceb1b2', '019f5aa7-9f6e-705d-a50e-70ebf135c020', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 5000000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya Parahita', '2026-07-13 01:46:02', '2026-07-13 01:46:02'),
('019f5aa9-2c8b-7326-8e2c-01cd045dc2d0', '019f5aa9-2c86-72d5-921d-a7e641546777', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 5000000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:47:44', '2026-07-13 01:47:44'),
('019f5aa9-2c8d-70c4-bf49-a8f9c7984c9f', '019f5aa9-2c86-72d5-921d-a7e641546777', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 5000000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya Universitas Muhammadiyah Gresik', '2026-07-13 01:47:44', '2026-07-13 01:47:44'),
('019f5aaa-4399-70f4-b133-4a1d41286547', '019f5aaa-4391-705a-8b59-309a96cdb8f4', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 500000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:48:55', '2026-07-13 01:48:55'),
('019f5aaa-439b-7381-ac9b-3ac5f95a2d9e', '019f5aaa-4391-705a-8b59-309a96cdb8f4', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 500000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya Muhajir', '2026-07-13 01:48:55', '2026-07-13 01:48:55'),
('019f5aab-5bdb-70be-9a0c-dd84162daeec', '019f5aab-5bd5-7210-83b8-0d9609e53ce4', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 10000000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:50:07', '2026-07-13 01:50:07'),
('019f5aab-5be2-7019-95fb-27b85f2257cd', '019f5aab-5bd5-7210-83b8-0d9609e53ce4', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 10000000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya Widati Muhajir', '2026-07-13 01:50:07', '2026-07-13 01:50:07'),
('019f5aac-9e1e-7035-a0d9-78a11f91ac48', '019f5aac-9e17-7395-b4c8-e1a67e4f7eec', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 250000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:51:29', '2026-07-13 01:51:29'),
('019f5aac-9e1f-7338-8b85-be05d68572dd', '019f5aac-9e17-7395-b4c8-e1a67e4f7eec', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 250000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya Pemasukan', '2026-07-13 01:51:29', '2026-07-13 01:51:29'),
('019f5aad-8f1f-7353-a65f-e9cd87dbb3a0', '019f5aad-8f19-713b-b842-b31e14f0d957', '80489af9-a27f-469d-aabb-16681c5cf916', 'DEBIT', 3000000.00, 'MAIN', 'Kas di Bank Jatim Dr. Soetomo Kas Masuk', '2026-07-13 01:52:31', '2026-07-13 01:52:31'),
('019f5aad-8f22-7277-8be0-a5c265176ad3', '019f5aad-8f19-713b-b842-b31e14f0d957', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', 'CREDIT', 3000000.00, 'MAIN', 'Dana Bantuan Organisasi Lainnya Pemasukan', '2026-07-13 01:52:31', '2026-07-13 01:52:31');

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
('00cde4e9-0b70-422a-9704-783e97687bb2', '019f3c29-d401-730d-a58f-9fac0918ea2c', '8f516b93-3983-41be-a7d9-37a2364355b3', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
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
('019f3c29-f035-732a-ae59-34ae55015acd', '019f3c29-d5d0-71f9-a3e6-3f0795927cd5', 'ff336d58-31ed-49b6-8df8-6ea403800108', '2026-07-07 03:40:09', '2026-07-07 03:40:09'),
('01a1b7eb-8e7b-4b73-b2f0-6d838298b0d5', '019f3c29-d401-730d-a58f-9fac0918ea2c', '36c76a75-5dd6-48bd-b474-bde2c2b9e7d3', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('03229f33-f17c-49ea-afdd-47e65ba4a6e5', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'dd9958f5-23ee-467f-be58-8bd553eceeac', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('042a6acd-9dd5-40ae-b55b-e4594bc2a32a', '019f3c29-d401-730d-a58f-9fac0918ea2c', '4b7fc140-c63d-4001-8704-c0ece2a4ec7b', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('04dbedfb-ef07-4263-8e96-7bcef6ff7b57', '019f3c29-d401-730d-a58f-9fac0918ea2c', '23ce33b2-eb43-4bad-aeff-715f9e4f8a06', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('079395e8-7845-4ff6-9f00-867bab7ad5f2', '019f3c29-d401-730d-a58f-9fac0918ea2c', '0ba8ade3-8dc6-4ffb-89c7-50e579be3146', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('0b625d0e-d149-4328-8359-962748f03ac8', '019f3c29-d401-730d-a58f-9fac0918ea2c', '06d411e4-689d-4f6d-bb2e-c9f44aeab33d', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('13bcaaff-687d-44ac-ae4f-381194f21c16', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'cc841ad2-0e5b-43f7-909e-d31ce5563706', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('13ce2853-ce86-4994-8f09-ed001a0a8a32', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'b472d3a2-353d-484e-accf-1c80167f6000', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('17718ecd-7b88-4d13-9eaa-12cd86ff93d6', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'd9c57730-6928-4e5d-ac29-bf2f6dd9895f', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('17c605ae-406d-4343-950a-f1cd49781542', '019f3c29-d401-730d-a58f-9fac0918ea2c', '638a512b-cab3-4d52-b467-7193ccc1feb3', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('19fb1781-95b8-432a-afa9-f6b78f204d87', '019f3c29-d401-730d-a58f-9fac0918ea2c', '2c677359-98b2-440d-ae53-dcae5095841e', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('1bf5424c-8bbe-480f-b4d0-44856e40242d', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'c2f2d0bb-303d-4913-8df0-c6030afe4501', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('1c5cb46d-10bc-47d4-a9b9-240bbc684e4d', '019f3c29-d401-730d-a58f-9fac0918ea2c', '03ea188f-4a5a-49a1-a360-afbcee575894', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('1c9fa727-a9cb-4ebc-bf3a-0d41cd6afd91', '019f3c29-d401-730d-a58f-9fac0918ea2c', '4cf55425-0f8b-4b44-ad53-26c1dab32558', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('1cf899b5-0476-4643-8cd2-f71e80bbc9cf', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'd7d9901c-9785-4410-aae6-2c4236b5648d', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('20431c18-2c51-4698-8cf2-9512f7f8fcd7', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'd96a0838-d30f-4e12-93a5-f61ee741d39d', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('220bf7bc-443e-4fa8-858e-063597609c1b', '019f3c29-d401-730d-a58f-9fac0918ea2c', '6afbe99c-65df-4128-a16c-fa5827c8347f', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('22ba2565-3fc1-4c37-96cf-02908ac07691', '019f3c29-d401-730d-a58f-9fac0918ea2c', '2ffe0b7f-2bc6-4dac-9940-e53393a90f58', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('24efa014-8db7-47e0-adee-99cef7e2d7e0', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'a5e6167d-c666-42f0-bc88-b75ac70e6ab0', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('25864587-50f2-455f-b94c-8cbf4efe788e', '019f3c29-d401-730d-a58f-9fac0918ea2c', '0dcf66b6-8ba6-40b3-89e7-282aa84c03e5', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('27131ca0-3886-417a-a0cd-28f66d3a321f', '019f3c29-d401-730d-a58f-9fac0918ea2c', '34946f7c-6f05-4bb7-ba94-01afba90ff43', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('29134165-7b5e-431d-a4e2-3f6e6a222863', '019f3c29-d401-730d-a58f-9fac0918ea2c', '81f580a0-1436-4a81-84a3-93d197075930', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('2a866fb6-3f25-44d9-a7b6-9e0e6ce0500c', '019f3c29-d401-730d-a58f-9fac0918ea2c', '11a7616a-06e7-4757-84c2-79d6f91406ef', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('2ef54f58-fa2d-45b1-8bf8-eaac8a8883f0', '019f3c29-d401-730d-a58f-9fac0918ea2c', '99796640-5f95-4ad6-bf89-7121444ade40', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('32de9901-a58d-454d-b98e-55b77bac8ff9', '019f3c29-d401-730d-a58f-9fac0918ea2c', '22863257-23b1-40b2-81b5-625a579e4887', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('3f3a2d48-782b-4a8a-9bdd-a13b16a04fdf', '019f3c29-d401-730d-a58f-9fac0918ea2c', '4a6caa70-24ca-45b3-b752-57f72b56a930', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('41b4b432-8cc2-4a20-b833-f9bbf0729740', '019f3c29-d401-730d-a58f-9fac0918ea2c', '7e3a051c-a73b-485c-865c-f7259792967d', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('41ddd99f-f046-4404-9559-ea6c309b61b0', '019f3c29-d401-730d-a58f-9fac0918ea2c', '605dc218-d091-47b2-a7f2-0effb402d2d4', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('49ea0d28-9a7a-4179-8a6d-4338126d0035', '019f3c29-d401-730d-a58f-9fac0918ea2c', '80489af9-a27f-469d-aabb-16681c5cf916', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('49f506f4-45af-4fcd-b462-c7cf15046f5e', '019f3c29-d401-730d-a58f-9fac0918ea2c', '37aaef0a-ab7e-4bc1-8f6f-fb6028a3277e', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('4ff4374d-9882-428d-8e1f-77cc29b9d5a6', '019f3c29-d401-730d-a58f-9fac0918ea2c', '9d1306f9-10c9-4820-bc3e-e2486c49e8cd', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('56495a11-08af-4098-bffe-8cecb01c9ae0', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'e8d6d3cc-494f-463d-a264-763e3e72c155', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('570049ed-2ee5-4ad7-bf3c-e0771e04ff43', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'd40db36e-328b-43fd-ae0a-2fb09fcef5c2', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('578c2294-0e33-4adc-b37d-e59bea73ad8e', '019f3c29-d401-730d-a58f-9fac0918ea2c', '46a3a069-49e2-403a-a208-ae7cf8219249', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('5a14af5e-efcc-407e-8ace-768cfd1afd4b', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'b89aeb06-4c14-44b2-9a3a-97f8619e47c8', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('5ec6ebef-2f27-489d-bb95-e006d43e4138', '019f3c29-d401-730d-a58f-9fac0918ea2c', '6486b0ff-c08e-4b4a-b6bd-6cf40c1d93dd', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('60d7660f-db3f-4074-b153-51fa18a4fc50', '019f3c29-d401-730d-a58f-9fac0918ea2c', '2697d4da-bd60-4ada-9ab3-8f75a3dcc793', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('61ca6c98-b6e5-4e81-9e59-4b16d1a679a8', '019f3c29-d401-730d-a58f-9fac0918ea2c', '5e5b9787-1c85-40fb-a997-52b1bb7e7ed5', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('61e19ad8-b194-4b25-9805-a06e9f8a6548', '019f3c29-d401-730d-a58f-9fac0918ea2c', '05b667e2-951b-4735-83e7-6761a059c2d4', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('627a1824-d480-475c-958a-56d991f09a90', '019f3c29-d401-730d-a58f-9fac0918ea2c', '58890adf-02ff-4976-9357-7840f15e5c8d', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('695ade26-0839-47cd-9e7d-578eb1c7be97', '019f3c29-d401-730d-a58f-9fac0918ea2c', '2fc91e28-cafa-42d5-a383-960bd2304d79', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('6a1b14b7-adc0-4a0f-bac7-dfbdc4dabb73', '019f3c29-d401-730d-a58f-9fac0918ea2c', '8e772f65-a3e0-4d09-8783-132811d324b5', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('6a9b3804-4e46-4990-a52e-1757a5948c7d', '019f3c29-d401-730d-a58f-9fac0918ea2c', '02e0f19e-fe7c-4af8-9840-eba30817c41e', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('6c93ff17-0ebe-4ff9-96f3-e47c2a5ab86c', '019f3c29-d401-730d-a58f-9fac0918ea2c', '41dd99c8-6337-4697-ac01-ffb1bf79540b', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('6d48c4df-b9a9-49ff-9dbd-a1f1a35e1449', '019f3c29-d401-730d-a58f-9fac0918ea2c', '44fb2678-eb3c-4af8-88ea-e9654dcc88ac', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('6e6f8f42-c44f-4190-88ae-c81aefe6dd65', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'cc07e75b-1119-4e8f-b7d1-f782842d1770', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('6ed8e4af-18b4-43f3-8e2c-f53e99345d21', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'afd34085-9d09-4ff0-9d09-c07c85a6b595', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('716a62f9-4406-470a-b9cc-3ab06cf93b80', '019f3c29-d401-730d-a58f-9fac0918ea2c', '225f7e5c-8132-4aff-bccd-9c1e07ebc65f', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('7330d58d-89d3-43b3-95a5-dd40fec7559c', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'e2eda7c2-e10e-47e3-bb99-9a68bd2294cf', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('73671bd2-6595-49b6-9980-170154e9fdfd', '019f3c29-d401-730d-a58f-9fac0918ea2c', '5b11c6ca-5d87-4837-ad30-e91953c5a1a9', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('74003b62-9684-4cc5-93de-531747122801', '019f3c29-d401-730d-a58f-9fac0918ea2c', '9f5ccef8-b43a-4686-9dc3-d6199a74ce89', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('76a92653-91c1-4e53-942e-9784d6d8d5d6', '019f3c29-d401-730d-a58f-9fac0918ea2c', '060c7786-2d80-4af6-a7f3-4d8dba51c049', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('7bf67df2-e0a6-4cac-9677-175470e9554b', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'd7305d55-a17b-4f18-bb71-83e624522e8f', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('7d36c0f8-53f3-4be9-9a9c-bf259f226ed4', '019f3c29-d401-730d-a58f-9fac0918ea2c', '640af4d9-6891-4840-9a50-8c009ca3f486', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('82a92b1c-01b3-4039-b1f4-35afb8da0148', '019f3c29-d401-730d-a58f-9fac0918ea2c', '06165d42-2fb0-4393-9a8f-f445880be667', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('835ee7d0-f37e-4908-974a-e96cc68cae8e', '019f3c29-d401-730d-a58f-9fac0918ea2c', '8eafa0f0-e378-418c-a53a-73a879cb392f', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('837ca27a-82b2-4a7c-a979-393bb55c6ec1', '019f3c29-d401-730d-a58f-9fac0918ea2c', '3fab3482-9af2-4d47-92f0-b6a42980348c', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('87a6e23e-d9c9-40ad-92bb-0c6a05d59e31', '019f3c29-d401-730d-a58f-9fac0918ea2c', '290bef48-1174-4bb0-8c01-0d5b17108128', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('928b15bb-9ad5-4930-8ed6-c61dc75fc25a', '019f3c29-d401-730d-a58f-9fac0918ea2c', '56962e72-737c-4932-a1c1-4d7cf41db900', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('92b9a32e-86d8-4d02-a32d-d2b053ac16a5', '019f3c29-d401-730d-a58f-9fac0918ea2c', '98c63964-bd5e-4fe0-886b-ff6663c73fdc', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('993532c5-addf-43c4-9646-a97377537134', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'd650d3c0-ca9f-4587-9a11-cdfefa1e3115', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('9b6a2c3d-00ff-4cbe-8d81-b1ba1254e41c', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'ac1a013b-b327-4084-8d52-52440f6bcb54', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('9e63fbb4-16cd-4fd8-add5-fe49508380b7', '019f3c29-d401-730d-a58f-9fac0918ea2c', '27b3424e-5e94-48db-8d12-af1165d6ed2f', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('9eabea0f-c267-42f9-9e1f-ec6db47453f2', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'ce1441a5-5f7e-46d7-8cc7-3f9bae862ae3', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('9ff680e2-22cf-4284-927b-56dae3534505', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'c845664e-4939-4188-9b5a-177cd7bd5ed7', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('a1af556e-dba1-4870-aa78-b84023b970ce', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'dc16f8fe-a09e-4399-a227-7320a3f32feb', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('a62ecaf0-e48b-4d13-b7fc-55b717402cdb', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'f6c24672-0eeb-4f58-a71c-8f8bad115f5b', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('a710bf57-5292-4a57-8cfe-4b6182df3d32', '019f3c29-d401-730d-a58f-9fac0918ea2c', '10af2cdc-0754-4d24-871d-46ad9bdb8f98', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('a99d5b15-9b12-469f-8809-c41d6e562d03', '019f3c29-d401-730d-a58f-9fac0918ea2c', '3f354843-3d12-4886-ae4d-a0cf7ff5c6c4', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('a9f96799-6088-40af-a405-869e77f0fef4', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'cbf1ae59-be94-468d-a0b1-14f125f5b831', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('abbfd9b9-4613-4071-8591-06a5622dce46', '019f3c29-d401-730d-a58f-9fac0918ea2c', '610faad3-6e8f-4791-8608-cb0eb19688be', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('ad7e1858-3eea-4261-8f94-4d4e59c02a58', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'bca4163c-d2f5-4b28-a022-83059cfecaa2', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('afd99d15-dc17-4479-947b-0d813e503115', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'ac8a1463-4a4c-4cb1-a0e4-b00c2d9cf522', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('b0c18fa5-bbd4-4115-8a49-32475cd08a62', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'ff336d58-31ed-49b6-8df8-6ea403800108', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('b23e0201-ef2a-4b93-ae25-0dffd8bf5708', '019f3c29-d401-730d-a58f-9fac0918ea2c', '0b374ecb-94f5-41ba-9e48-36082946c81e', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('b5c029f5-5e20-44ac-8636-d6c92a882fd8', '019f3c29-d401-730d-a58f-9fac0918ea2c', '2f1adb90-a4d5-4c63-8ed9-7f4109b1890d', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('b7a0d047-1c4f-4492-960a-e598f6a574ee', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'fee7e8c7-a5e4-4a0f-bf77-62db604ee500', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('b7f2fbc1-3ecd-41ee-a004-b9ed5f61f7ee', '019f3c29-d401-730d-a58f-9fac0918ea2c', '7b4c8d7b-ff7f-436d-b874-a6058efa0f36', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('b90accc3-010d-4eff-ae92-40a7e8534dae', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'cda7e544-e669-4f9c-9b6f-f6ba07500cef', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('ba3e0fff-3532-45d1-ab09-61478dc0aba5', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'b27bdc66-661a-4dd0-9831-e779426c372a', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('bb87c95b-8317-4039-a217-216f47b86619', '019f3c29-d401-730d-a58f-9fac0918ea2c', '9fa5994e-9de7-4284-af4f-df5f7490e4a6', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('bb9008d8-1113-44d0-9a8f-cc49eb1200c8', '019f3c29-d401-730d-a58f-9fac0918ea2c', '6865e20e-43b2-48ce-b3a3-653078468886', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('bcb3ae30-6445-4ee8-9522-6a6d3be433ec', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'd73463de-abb8-4e44-9f77-92d375acb1e8', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('be4caafc-e9d9-48c5-9ab1-abcf20ae9814', '019f3c29-d401-730d-a58f-9fac0918ea2c', '29b45798-4894-4b34-8b98-6763e573bb7a', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('c35f6b5d-287c-4747-90fb-e74c7dc43efc', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'e5032396-b524-43e4-aaf0-c8de44d4c99a', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('c3bf705b-92d7-40d9-bebb-b2bba62d42d2', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'cfe855aa-e85d-40f2-96a4-e34d46c904f3', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('c4d598a7-9cd6-4368-98fc-50048917360c', '019f3c29-d401-730d-a58f-9fac0918ea2c', '4755ebf2-c52b-4f64-8281-176d879ac1aa', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('c5294802-e9c7-4b19-8691-5b103a670e23', '019f3c29-d401-730d-a58f-9fac0918ea2c', '931fa6b3-6053-4b8e-8f45-5dc87115dcb6', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('c57f10f3-fb7d-4420-82ca-b1931a4ae638', '019f3c29-d401-730d-a58f-9fac0918ea2c', '4dde9b7f-95c6-47e7-ade5-9cb403950064', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('c86ca288-5439-4a54-b5a9-9d97a3717065', '019f3c29-d401-730d-a58f-9fac0918ea2c', '591c8ff4-1887-4259-b966-890f724424e3', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('c8f5fa0f-b4af-45d0-9718-1e0ed7d91bc3', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'dead6c90-51ca-4b56-b953-9ce8a362108f', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('c94272ee-70eb-40b5-97cb-2c61b78ff291', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'b01e653a-9e3b-44d1-a81c-f981c7b2acbe', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('cb0a8cdb-9e55-456d-b313-298f6026a357', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'bbca9830-3900-41a5-a233-774c581874e8', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('cb4035bf-1e86-4cb9-80db-a0391bf5b3e3', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'b840fcec-a9c1-4afc-9824-f6fca25211ba', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('cc9e3757-bfa9-4faf-8953-97bd5e684588', '019f3c29-d401-730d-a58f-9fac0918ea2c', '27ef2784-5982-421c-bb3f-96a51777fbf3', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('cfb3ecbc-5177-4411-a9cd-cf1f3f329870', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'f415012f-1f66-4b77-a725-6682e2ffd02b', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('d0f4b405-6b3f-439b-aa61-89c634d380cf', '019f3c29-d401-730d-a58f-9fac0918ea2c', '132603d3-0f4b-4c28-8e39-e05a89642d98', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('d345438d-f41c-49ae-ad76-6f5be114bdbe', '019f3c29-d401-730d-a58f-9fac0918ea2c', '76a20fad-6338-4545-9a9e-4acc355eeb3e', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('da3b6539-d24f-4429-a9ff-19556e05abe8', '019f3c29-d401-730d-a58f-9fac0918ea2c', '1f3e9890-fa94-4611-9531-cbabb4f9091e', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('dc4ff988-ab9c-4c0b-9b13-20cdca42417e', '019f3c29-d401-730d-a58f-9fac0918ea2c', '48b61973-5d46-469e-9ae3-afd4a3be5fae', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('de46c9b4-a4ab-4c67-b7ae-2a529d4a3e05', '019f3c29-d401-730d-a58f-9fac0918ea2c', '5afb25f5-ea51-4978-8159-60aef27c29e0', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('df0d85bb-75ef-43d5-93a9-97c85f62942c', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'db8f505b-44a6-45f5-8d10-f8d15bea1af4', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('df5c9c54-6770-4650-9a7a-0cc3426fcdaa', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'a32ae99f-0c4c-44e5-9282-6fc6f4cf51de', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('e094c40e-5b0d-473a-969d-2c0d2714bb65', '019f3c29-d401-730d-a58f-9fac0918ea2c', '6f9dd6c1-e799-4bef-8a44-04ce7e7a1dec', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('e2d36668-cbf9-4663-8cc6-0ece025e5a65', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'fc646e17-8f59-466f-8bea-74a29c39bdad', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('e395b493-19ae-4e46-a8fa-90bc2bf979a5', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'bbd6859d-aae9-435a-bf0a-7543c4fb6321', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('e43d2909-6ed8-41b4-a20a-3b7826fff336', '019f3c29-d401-730d-a58f-9fac0918ea2c', '852153e1-1905-487f-9176-56fac68a9968', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('e6c33299-3f95-4536-aff6-949ccc7a8c0b', '019f3c29-d401-730d-a58f-9fac0918ea2c', '700e4c22-26f3-43ce-8ef0-b32b8920e93c', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('e951150b-4ed6-4e0b-a651-c06556da558e', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'd43c41c7-4cfa-42c7-81be-b99ca8e1621b', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('eb5c9155-1425-4b3b-bcb2-387d3cb2e022', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'f67c7605-fd55-4d04-8065-738b2feff09a', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('ec955305-3cae-4be3-8707-b11c2dd558ba', '019f3c29-d401-730d-a58f-9fac0918ea2c', '89b2bd63-45a5-4376-9301-75f7c5c6869f', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('ef151c7a-04d8-4149-a318-2db7da40b4c0', '019f3c29-d401-730d-a58f-9fac0918ea2c', '258febc1-f6d2-49bd-be01-08741fe511da', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('f197b099-608b-46c9-ad22-843d165dbb96', '019f3c29-d401-730d-a58f-9fac0918ea2c', '69339cd7-dd8c-4966-bb0d-ad14dc3d9bd1', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('f36ca30f-7d56-4cb0-9140-243e52db9ad0', '019f3c29-d401-730d-a58f-9fac0918ea2c', '724f6c78-1a44-4f74-bf40-fd9b43963ba3', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('f3d021c1-30a5-4981-b7e8-bcc8cb884c72', '019f3c29-d401-730d-a58f-9fac0918ea2c', '8dcd1a44-abb4-4383-8182-51e4416392e8', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('f6fcdc0f-4047-4368-ba5a-172dd80e7e7e', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'c1211db4-92a4-4343-9bf6-10c9adeeb912', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('f801728c-0cf6-41d5-ac7f-56106dd77191', '019f3c29-d401-730d-a58f-9fac0918ea2c', '5c2b1cd4-d67d-4a13-8d27-ca888f5f02f2', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('f990cc32-4695-47a5-9a4e-85ff404609ed', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'bb63ab0e-2314-4079-b255-915ed295b322', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('f9e07b88-4ec4-44bb-9a50-bc869403e03e', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'b2046255-9dc2-406b-ae9a-fd47cf6bddb2', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('feff9794-165e-42fc-bfc2-c8752c5b2564', '019f3c29-d401-730d-a58f-9fac0918ea2c', 'f0ab0d30-708d-4536-b5c6-448b058d7a75', '2026-07-08 19:45:01', '2026-07-08 19:45:01'),
('ffe02dc2-2915-42b8-9a1d-306919f120e1', '019f3c29-d401-730d-a58f-9fac0918ea2c', '41fbc782-5794-409d-8507-f99fed76fe8b', '2026-07-08 19:45:01', '2026-07-08 19:45:01');

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
-- Dumping data untuk tabel `user_account_balances`
--

INSERT INTO `user_account_balances` (`id`, `user_account_id`, `coa_balance_id`, `period_id`, `sub_period_id`, `allocated_by`, `allocated_balance`, `used_balance`, `remaining_balance`, `allocated_at`, `deleted_at`, `created_at`, `updated_at`) VALUES
('019f5a59-4dad-7307-b9ec-73b4c016737e', '019f3c29-ec2c-7065-a924-bb27d8819490', '019f3c39-5ff3-72a1-a97e-4e0e40f66193', '019f3c7f-83a5-7303-bcaa-a3e095677c5f', '019f3c80-09e1-7238-ae7f-21c037b9f75d', '019f3c29-d401-730d-a58f-9fac0918ea2c', 667899854.00, 83021.00, 667816833.00, '2026-07-13 00:20:29', NULL, '2026-07-13 00:20:29', '2026-07-13 01:52:31');

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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