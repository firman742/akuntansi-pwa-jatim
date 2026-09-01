-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 30 Agu 2026 pada 17.07
-- Versi server: 8.0.30
-- Versi PHP: 8.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Database: `office_accounting`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `account_topups`
--

CREATE TABLE `account_topups` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `chart_of_account_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `period_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_period_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` double NOT NULL,
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `account_types`
--

CREATE TABLE `account_types` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `account_types`
--

INSERT INTO `account_types` (`id`, `name`, `description`, `is_active`, `created_at`, `updated_at`) VALUES
('a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'ASET', 'Sumber daya ekonomi yang dimiliki perusahaan (kas, piutang, persediaan, tanah, gedung).', 1, '2026-08-18 22:50:30', '2026-08-18 22:50:30'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567891', 'KEWAJIBAN', 'Kewajiban atau hutang perusahaan kepada pihak lain (utang usaha, utang bank, obligasi).', 1, '2026-08-18 22:50:30', '2026-08-18 22:50:30'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567892', 'EKUITAS', 'Kepemilikan pemilik dalam perusahaan setelah dikurangi kewajiban (modal saham, laba ditahan).', 1, '2026-08-18 22:50:30', '2026-08-18 22:50:30'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567893', 'PENDAPATAN', 'account type representing the inflow of economic benefits from business activities.', 1, '2026-08-18 22:50:30', '2026-08-18 22:50:30'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567894', 'BEBAN', 'account type representing the outflow of economic benefits incurred in the process of generating revenue.', 1, '2026-08-18 22:50:30', '2026-08-18 22:50:30');

-- --------------------------------------------------------

--
-- Struktur dari tabel `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `module` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `old_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `new_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `additional_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ;

--
-- Dumping data untuk tabel `activity_logs`
--

INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `module`, `description`, `subject_type`, `subject_id`, `old_values`, `new_values`, `ip_address`, `user_agent`, `additional_data`, `created_at`, `updated_at`) VALUES
('01a018c0-a4a4-70ca-b06b-88efc809adfd', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas (11100) pada sub periode Desember 2022 dengan jumlah 194,604,157.00', 'App\\Models\\OpeningBalance', '01a018c0-a493-72b6-bc85-fdc005402033', '[]', '{\"chart_of_account_id\":\"08e15b4f-473b-4440-a706-d4c5a27a063b\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"sub_period_id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"balance_type\":\"DEBIT\",\"amount\":194604157,\"created_by\":\"01a01892-30ab-7337-8cb2-5ce8dac14b8a\",\"is_correction\":false,\"id\":\"01a018c0-a493-72b6-bc85-fdc005402033\",\"updated_at\":\"2026-08-19T06:41:13.000000Z\",\"created_at\":\"2026-08-19T06:41:13.000000Z\",\"chart_of_account\":{\"id\":\"08e15b4f-473b-4440-a706-d4c5a27a063b\",\"code\":\"11100\",\"name\":\"Kas\",\"parent_id\":\"358657c6-fe73-408d-8349-8bc351f14284\",\"level\":\"2\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-08-19T05:50:31.000000Z\",\"updated_at\":\"2026-08-19T05:50:31.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-08-19T05:50:30.000000Z\",\"updated_at\":\"2026-08-19T05:50:30.000000Z\"}}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"coa_balance\":{\"chart_of_account_id\":\"08e15b4f-473b-4440-a706-d4c5a27a063b\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"sub_period_id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"opening_balance\":194604157,\"debit_total\":0,\"credit_total\":0,\"current_balance\":194604157,\"last_transaction_at\":\"2026-08-19T06:41:13.000000Z\",\"id\":\"01a018c0-a49a-70a6-908a-7a23b5db0a15\",\"updated_at\":\"2026-08-19T06:41:13.000000Z\",\"created_at\":\"2026-08-19T06:41:13.000000Z\"}}', '2026-08-18 23:41:13', '2026-08-18 23:41:13'),
('01a018c1-3233-7241-9324-7e68182252f6', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas Ditangan (11110) pada sub periode Desember 2022 dengan jumlah 4,983,047.00', 'App\\Models\\OpeningBalance', '01a018c1-3223-73ea-ba03-0c04339bbc12', '[]', '{\"chart_of_account_id\":\"428e0a5c-05eb-4705-b2a6-4333f44318c2\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"sub_period_id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"balance_type\":\"DEBIT\",\"amount\":4983047,\"created_by\":\"01a01892-30ab-7337-8cb2-5ce8dac14b8a\",\"is_correction\":false,\"id\":\"01a018c1-3223-73ea-ba03-0c04339bbc12\",\"updated_at\":\"2026-08-19T06:41:49.000000Z\",\"created_at\":\"2026-08-19T06:41:49.000000Z\",\"chart_of_account\":{\"id\":\"428e0a5c-05eb-4705-b2a6-4333f44318c2\",\"code\":\"11110\",\"name\":\"Kas Ditangan\",\"parent_id\":\"08e15b4f-473b-4440-a706-d4c5a27a063b\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-08-19T05:50:31.000000Z\",\"updated_at\":\"2026-08-19T05:50:31.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-08-19T05:50:30.000000Z\",\"updated_at\":\"2026-08-19T05:50:30.000000Z\"}}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"coa_balance\":{\"chart_of_account_id\":\"428e0a5c-05eb-4705-b2a6-4333f44318c2\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"sub_period_id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"opening_balance\":4983047,\"debit_total\":0,\"credit_total\":0,\"current_balance\":4983047,\"last_transaction_at\":\"2026-08-19T06:41:49.000000Z\",\"id\":\"01a018c1-322a-70be-9a5f-bf4f8bf766e5\",\"updated_at\":\"2026-08-19T06:41:49.000000Z\",\"created_at\":\"2026-08-19T06:41:49.000000Z\"}}', '2026-08-18 23:41:49', '2026-08-18 23:41:49'),
('01a018c1-a64f-72b9-9d20-e32915e3d43b', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas di Bank Jatim (11120) pada sub periode Desember 2022 dengan jumlah 405,484,747.00', 'App\\Models\\OpeningBalance', '01a018c1-a641-72fb-97de-e810ffc1b3b0', '[]', '{\"chart_of_account_id\":\"42ca2ce5-a3e0-4900-a0d8-6d741e9e0c68\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"sub_period_id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"balance_type\":\"DEBIT\",\"amount\":405484747,\"created_by\":\"01a01892-30ab-7337-8cb2-5ce8dac14b8a\",\"is_correction\":false,\"id\":\"01a018c1-a641-72fb-97de-e810ffc1b3b0\",\"updated_at\":\"2026-08-19T06:42:19.000000Z\",\"created_at\":\"2026-08-19T06:42:19.000000Z\",\"chart_of_account\":{\"id\":\"42ca2ce5-a3e0-4900-a0d8-6d741e9e0c68\",\"code\":\"11120\",\"name\":\"Kas di Bank Jatim\",\"parent_id\":\"08e15b4f-473b-4440-a706-d4c5a27a063b\",\"level\":\"3\",\"order\":\"2\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-08-19T05:50:31.000000Z\",\"updated_at\":\"2026-08-19T05:50:31.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-08-19T05:50:30.000000Z\",\"updated_at\":\"2026-08-19T05:50:30.000000Z\"}}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"coa_balance\":{\"chart_of_account_id\":\"42ca2ce5-a3e0-4900-a0d8-6d741e9e0c68\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"sub_period_id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"opening_balance\":405484747,\"debit_total\":0,\"credit_total\":0,\"current_balance\":405484747,\"last_transaction_at\":\"2026-08-19T06:42:19.000000Z\",\"id\":\"01a018c1-a647-73a5-b6dc-3062282dd820\",\"updated_at\":\"2026-08-19T06:42:19.000000Z\",\"created_at\":\"2026-08-19T06:42:19.000000Z\"}}', '2026-08-18 23:42:19', '2026-08-18 23:42:19'),
('01a018c2-2194-726b-a427-454dc5cf92b8', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas di Bank Jatim Dr. Soetomo (11130) pada sub periode Desember 2022 dengan jumlah 1,156,982,563.00', 'App\\Models\\OpeningBalance', '01a018c2-2187-73ba-91ed-753b8eb340a3', '[]', '{\"chart_of_account_id\":\"4ec4e235-c953-4aa3-b0bd-3e4a6fa61998\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"sub_period_id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"balance_type\":\"DEBIT\",\"amount\":1156982563,\"created_by\":\"01a01892-30ab-7337-8cb2-5ce8dac14b8a\",\"is_correction\":false,\"id\":\"01a018c2-2187-73ba-91ed-753b8eb340a3\",\"updated_at\":\"2026-08-19T06:42:50.000000Z\",\"created_at\":\"2026-08-19T06:42:50.000000Z\",\"chart_of_account\":{\"id\":\"4ec4e235-c953-4aa3-b0bd-3e4a6fa61998\",\"code\":\"11130\",\"name\":\"Kas di Bank Jatim Dr. Soetomo\",\"parent_id\":\"08e15b4f-473b-4440-a706-d4c5a27a063b\",\"level\":\"3\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-08-19T05:50:31.000000Z\",\"updated_at\":\"2026-08-19T05:50:31.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-08-19T05:50:30.000000Z\",\"updated_at\":\"2026-08-19T05:50:30.000000Z\"}}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"coa_balance\":{\"chart_of_account_id\":\"4ec4e235-c953-4aa3-b0bd-3e4a6fa61998\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"sub_period_id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"opening_balance\":1156982563,\"debit_total\":0,\"credit_total\":0,\"current_balance\":1156982563,\"last_transaction_at\":\"2026-08-19T06:42:50.000000Z\",\"id\":\"01a018c2-218d-733a-a32d-0cf69d319f58\",\"updated_at\":\"2026-08-19T06:42:50.000000Z\",\"created_at\":\"2026-08-19T06:42:50.000000Z\"}}', '2026-08-18 23:42:50', '2026-08-18 23:42:50'),
('01a018c2-959d-702f-b9c9-035be77cad09', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas di Bank Bukopin Syariah (11140) pada sub periode Desember 2022 dengan jumlah 377,940,865.00', 'App\\Models\\OpeningBalance', '01a018c2-958b-7005-b119-831b0d8ef620', '[]', '{\"chart_of_account_id\":\"2a983594-0762-4d4b-94fe-31dae7c954aa\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"sub_period_id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"balance_type\":\"DEBIT\",\"amount\":377940865,\"created_by\":\"01a01892-30ab-7337-8cb2-5ce8dac14b8a\",\"is_correction\":false,\"id\":\"01a018c2-958b-7005-b119-831b0d8ef620\",\"updated_at\":\"2026-08-19T06:43:20.000000Z\",\"created_at\":\"2026-08-19T06:43:20.000000Z\",\"chart_of_account\":{\"id\":\"2a983594-0762-4d4b-94fe-31dae7c954aa\",\"code\":\"11140\",\"name\":\"Kas di Bank Bukopin Syariah\",\"parent_id\":\"08e15b4f-473b-4440-a706-d4c5a27a063b\",\"level\":\"3\",\"order\":\"4\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-08-19T05:50:31.000000Z\",\"updated_at\":\"2026-08-19T05:50:31.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-08-19T05:50:30.000000Z\",\"updated_at\":\"2026-08-19T05:50:30.000000Z\"}}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"coa_balance\":{\"chart_of_account_id\":\"2a983594-0762-4d4b-94fe-31dae7c954aa\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"sub_period_id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"opening_balance\":377940865,\"debit_total\":0,\"credit_total\":0,\"current_balance\":377940865,\"last_transaction_at\":\"2026-08-19T06:43:20.000000Z\",\"id\":\"01a018c2-9593-73f0-bf27-5294a36142de\",\"updated_at\":\"2026-08-19T06:43:20.000000Z\",\"created_at\":\"2026-08-19T06:43:20.000000Z\"}}', '2026-08-18 23:43:20', '2026-08-18 23:43:20'),
('01a018c3-0a3a-7136-9f2a-90d02dde82fe', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Piutang Karyawan (11300) pada sub periode Desember 2022 dengan jumlah 1,800,000.00', 'App\\Models\\OpeningBalance', '01a018c3-0a2a-709e-9543-64f1c3f171d6', '[]', '{\"chart_of_account_id\":\"07c833c4-2d25-46eb-919e-1daa18d37932\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"sub_period_id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"balance_type\":\"DEBIT\",\"amount\":1800000,\"created_by\":\"01a01892-30ab-7337-8cb2-5ce8dac14b8a\",\"is_correction\":false,\"id\":\"01a018c3-0a2a-709e-9543-64f1c3f171d6\",\"updated_at\":\"2026-08-19T06:43:50.000000Z\",\"created_at\":\"2026-08-19T06:43:50.000000Z\",\"chart_of_account\":{\"id\":\"07c833c4-2d25-46eb-919e-1daa18d37932\",\"code\":\"11300\",\"name\":\"Piutang Karyawan\",\"parent_id\":\"358657c6-fe73-408d-8349-8bc351f14284\",\"level\":\"2\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-08-19T05:50:31.000000Z\",\"updated_at\":\"2026-08-19T05:50:31.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-08-19T05:50:30.000000Z\",\"updated_at\":\"2026-08-19T05:50:30.000000Z\"}}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"coa_balance\":{\"chart_of_account_id\":\"07c833c4-2d25-46eb-919e-1daa18d37932\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"sub_period_id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"opening_balance\":1800000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":1800000,\"last_transaction_at\":\"2026-08-19T06:43:50.000000Z\",\"id\":\"01a018c3-0a31-726c-8263-f3d392c2980c\",\"updated_at\":\"2026-08-19T06:43:50.000000Z\",\"created_at\":\"2026-08-19T06:43:50.000000Z\"}}', '2026-08-18 23:43:50', '2026-08-18 23:43:50'),
('01a018c3-7175-723f-b384-235bb54da939', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Piutang Lainnya (11400) pada sub periode Desember 2022 dengan jumlah 921,735,276.00', 'App\\Models\\OpeningBalance', '01a018c3-716a-72ca-a9dc-1ad6a87fe2b8', '[]', '{\"chart_of_account_id\":\"497ec733-26b1-41de-be5e-7ca327307bbb\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"sub_period_id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"balance_type\":\"DEBIT\",\"amount\":921735276,\"created_by\":\"01a01892-30ab-7337-8cb2-5ce8dac14b8a\",\"is_correction\":false,\"id\":\"01a018c3-716a-72ca-a9dc-1ad6a87fe2b8\",\"updated_at\":\"2026-08-19T06:44:16.000000Z\",\"created_at\":\"2026-08-19T06:44:16.000000Z\",\"chart_of_account\":{\"id\":\"497ec733-26b1-41de-be5e-7ca327307bbb\",\"code\":\"11400\",\"name\":\"Piutang Lainnya\",\"parent_id\":\"358657c6-fe73-408d-8349-8bc351f14284\",\"level\":\"2\",\"order\":\"4\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-08-19T05:50:31.000000Z\",\"updated_at\":\"2026-08-19T05:50:31.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-08-19T05:50:30.000000Z\",\"updated_at\":\"2026-08-19T05:50:30.000000Z\"}}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"coa_balance\":{\"chart_of_account_id\":\"497ec733-26b1-41de-be5e-7ca327307bbb\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"sub_period_id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"opening_balance\":921735276,\"debit_total\":0,\"credit_total\":0,\"current_balance\":921735276,\"last_transaction_at\":\"2026-08-19T06:44:16.000000Z\",\"id\":\"01a018c3-716f-7057-bd53-92514ac78e9c\",\"updated_at\":\"2026-08-19T06:44:16.000000Z\",\"created_at\":\"2026-08-19T06:44:16.000000Z\"}}', '2026-08-18 23:44:16', '2026-08-18 23:44:16'),
('01a018c4-1c58-73c2-9d7c-57c2ee542e0d', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kendaraan (12300) pada sub periode Desember 2022 dengan jumlah 460,769,432.00', 'App\\Models\\OpeningBalance', '01a018c4-1c49-70f7-a0b8-d11c57f968bb', '[]', '{\"chart_of_account_id\":\"be57ddf7-3177-4d16-bb22-db567be94f18\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"sub_period_id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"balance_type\":\"DEBIT\",\"amount\":460769432,\"created_by\":\"01a01892-30ab-7337-8cb2-5ce8dac14b8a\",\"is_correction\":false,\"id\":\"01a018c4-1c49-70f7-a0b8-d11c57f968bb\",\"updated_at\":\"2026-08-19T06:45:00.000000Z\",\"created_at\":\"2026-08-19T06:45:00.000000Z\",\"chart_of_account\":{\"id\":\"be57ddf7-3177-4d16-bb22-db567be94f18\",\"code\":\"12300\",\"name\":\"Kendaraan\",\"parent_id\":\"cbb43cce-4240-4816-878b-589ed0dc3077\",\"level\":\"2\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-08-19T05:50:31.000000Z\",\"updated_at\":\"2026-08-19T05:50:31.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-08-19T05:50:30.000000Z\",\"updated_at\":\"2026-08-19T05:50:30.000000Z\"}}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"coa_balance\":{\"chart_of_account_id\":\"be57ddf7-3177-4d16-bb22-db567be94f18\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"sub_period_id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"opening_balance\":460769432,\"debit_total\":0,\"credit_total\":0,\"current_balance\":460769432,\"last_transaction_at\":\"2026-08-19T06:45:00.000000Z\",\"id\":\"01a018c4-1c50-72d2-a007-dde091c87bad\",\"updated_at\":\"2026-08-19T06:45:00.000000Z\",\"created_at\":\"2026-08-19T06:45:00.000000Z\"}}', '2026-08-18 23:45:00', '2026-08-18 23:45:00'),
('01a018c4-9c1f-71fa-83c2-1eebf4868d51', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Akumulasi Depresiasi Kendaraan (12310) pada sub periode Desember 2022 dengan jumlah 144,000,000.00', 'App\\Models\\OpeningBalance', '01a018c4-9c12-7290-b84b-d2fe3ec21c45', '[]', '{\"chart_of_account_id\":\"fbbbf9d7-a082-4cb6-8384-2e9c709f7d69\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"sub_period_id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"balance_type\":\"CREDIT\",\"amount\":144000000,\"created_by\":\"01a01892-30ab-7337-8cb2-5ce8dac14b8a\",\"is_correction\":false,\"id\":\"01a018c4-9c12-7290-b84b-d2fe3ec21c45\",\"updated_at\":\"2026-08-19T06:45:33.000000Z\",\"created_at\":\"2026-08-19T06:45:33.000000Z\",\"chart_of_account\":{\"id\":\"fbbbf9d7-a082-4cb6-8384-2e9c709f7d69\",\"code\":\"12310\",\"name\":\"Akumulasi Depresiasi Kendaraan\",\"parent_id\":\"be57ddf7-3177-4d16-bb22-db567be94f18\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-08-19T05:50:31.000000Z\",\"updated_at\":\"2026-08-19T05:50:31.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-08-19T05:50:30.000000Z\",\"updated_at\":\"2026-08-19T05:50:30.000000Z\"}}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"coa_balance\":{\"chart_of_account_id\":\"fbbbf9d7-a082-4cb6-8384-2e9c709f7d69\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"sub_period_id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"opening_balance\":144000000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":144000000,\"last_transaction_at\":\"2026-08-19T06:45:33.000000Z\",\"id\":\"01a018c4-9c18-7352-8557-408a66ffa6e0\",\"updated_at\":\"2026-08-19T06:45:33.000000Z\",\"created_at\":\"2026-08-19T06:45:33.000000Z\"}}', '2026-08-18 23:45:33', '2026-08-18 23:45:33'),
('01a018c5-0491-703f-b8b1-15e965b239b5', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Meubel (12400) pada sub periode Desember 2022 dengan jumlah 15,500,000.00', 'App\\Models\\OpeningBalance', '01a018c5-0480-71da-a118-b528f4a9ac56', '[]', '{\"chart_of_account_id\":\"48fb488e-f265-467a-afb7-a12aded626aa\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"sub_period_id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"balance_type\":\"DEBIT\",\"amount\":15500000,\"created_by\":\"01a01892-30ab-7337-8cb2-5ce8dac14b8a\",\"is_correction\":false,\"id\":\"01a018c5-0480-71da-a118-b528f4a9ac56\",\"updated_at\":\"2026-08-19T06:46:00.000000Z\",\"created_at\":\"2026-08-19T06:46:00.000000Z\",\"chart_of_account\":{\"id\":\"48fb488e-f265-467a-afb7-a12aded626aa\",\"code\":\"12400\",\"name\":\"Meubel\",\"parent_id\":\"cbb43cce-4240-4816-878b-589ed0dc3077\",\"level\":\"2\",\"order\":\"4\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-08-19T05:50:31.000000Z\",\"updated_at\":\"2026-08-19T05:50:31.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-08-19T05:50:30.000000Z\",\"updated_at\":\"2026-08-19T05:50:30.000000Z\"}}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"coa_balance\":{\"chart_of_account_id\":\"48fb488e-f265-467a-afb7-a12aded626aa\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"sub_period_id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"opening_balance\":15500000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":15500000,\"last_transaction_at\":\"2026-08-19T06:46:00.000000Z\",\"id\":\"01a018c5-0487-7060-bc9c-56c0ad65d184\",\"updated_at\":\"2026-08-19T06:46:00.000000Z\",\"created_at\":\"2026-08-19T06:46:00.000000Z\"}}', '2026-08-18 23:46:00', '2026-08-18 23:46:00'),
('01a018c5-7627-73b8-84ec-05ea354d3e66', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Akumulasi Depresiasi Meubel (12410) pada sub periode Desember 2022 dengan jumlah 13,376,668.00', 'App\\Models\\OpeningBalance', '01a018c5-7615-71fe-820c-17462291f080', '[]', '{\"chart_of_account_id\":\"c5b99c5f-5885-4ef9-bae3-ab1811e502af\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"sub_period_id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"balance_type\":\"CREDIT\",\"amount\":13376668,\"created_by\":\"01a01892-30ab-7337-8cb2-5ce8dac14b8a\",\"is_correction\":false,\"id\":\"01a018c5-7615-71fe-820c-17462291f080\",\"updated_at\":\"2026-08-19T06:46:29.000000Z\",\"created_at\":\"2026-08-19T06:46:29.000000Z\",\"chart_of_account\":{\"id\":\"c5b99c5f-5885-4ef9-bae3-ab1811e502af\",\"code\":\"12410\",\"name\":\"Akumulasi Depresiasi Meubel\",\"parent_id\":\"48fb488e-f265-467a-afb7-a12aded626aa\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-08-19T05:50:31.000000Z\",\"updated_at\":\"2026-08-19T05:50:31.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-08-19T05:50:30.000000Z\",\"updated_at\":\"2026-08-19T05:50:30.000000Z\"}}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"coa_balance\":{\"chart_of_account_id\":\"c5b99c5f-5885-4ef9-bae3-ab1811e502af\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"sub_period_id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"opening_balance\":13376668,\"debit_total\":0,\"credit_total\":0,\"current_balance\":13376668,\"last_transaction_at\":\"2026-08-19T06:46:29.000000Z\",\"id\":\"01a018c5-761a-720e-94f6-fbfffe6838ff\",\"updated_at\":\"2026-08-19T06:46:29.000000Z\",\"created_at\":\"2026-08-19T06:46:29.000000Z\"}}', '2026-08-18 23:46:29', '2026-08-18 23:46:29'),
('01a018c5-e236-73ed-93f1-6555bddbd7ba', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Peralatan Kantor (12500) pada sub periode Desember 2022 dengan jumlah 46,059,000.00', 'App\\Models\\OpeningBalance', '01a018c5-e225-71bf-9278-e1c648351e70', '[]', '{\"chart_of_account_id\":\"9e17057b-c02b-411a-a70b-161c809a7814\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"sub_period_id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"balance_type\":\"DEBIT\",\"amount\":46059000,\"created_by\":\"01a01892-30ab-7337-8cb2-5ce8dac14b8a\",\"is_correction\":false,\"id\":\"01a018c5-e225-71bf-9278-e1c648351e70\",\"updated_at\":\"2026-08-19T06:46:56.000000Z\",\"created_at\":\"2026-08-19T06:46:56.000000Z\",\"chart_of_account\":{\"id\":\"9e17057b-c02b-411a-a70b-161c809a7814\",\"code\":\"12500\",\"name\":\"Peralatan Kantor\",\"parent_id\":\"cbb43cce-4240-4816-878b-589ed0dc3077\",\"level\":\"2\",\"order\":\"5\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-08-19T05:50:32.000000Z\",\"updated_at\":\"2026-08-19T05:50:32.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-08-19T05:50:30.000000Z\",\"updated_at\":\"2026-08-19T05:50:30.000000Z\"}}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"coa_balance\":{\"chart_of_account_id\":\"9e17057b-c02b-411a-a70b-161c809a7814\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"sub_period_id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"opening_balance\":46059000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":46059000,\"last_transaction_at\":\"2026-08-19T06:46:56.000000Z\",\"id\":\"01a018c5-e22c-73c2-ba1e-57e61b8842ea\",\"updated_at\":\"2026-08-19T06:46:56.000000Z\",\"created_at\":\"2026-08-19T06:46:56.000000Z\"}}', '2026-08-18 23:46:56', '2026-08-18 23:46:56'),
('01a018c6-507f-71a1-9161-1c98509573c0', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Akumulasi Depresiasi Peralatan Kantor (12510) pada sub periode Desember 2022 dengan jumlah 25,236,667.00', 'App\\Models\\OpeningBalance', '01a018c6-5073-7027-85f8-681d60077b76', '[]', '{\"chart_of_account_id\":\"2f7209ea-c61c-44ac-a2fb-2fe4f4ad5942\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"sub_period_id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"balance_type\":\"CREDIT\",\"amount\":25236667,\"created_by\":\"01a01892-30ab-7337-8cb2-5ce8dac14b8a\",\"is_correction\":false,\"id\":\"01a018c6-5073-7027-85f8-681d60077b76\",\"updated_at\":\"2026-08-19T06:47:25.000000Z\",\"created_at\":\"2026-08-19T06:47:25.000000Z\",\"chart_of_account\":{\"id\":\"2f7209ea-c61c-44ac-a2fb-2fe4f4ad5942\",\"code\":\"12510\",\"name\":\"Akumulasi Depresiasi Peralatan Kantor\",\"parent_id\":\"9e17057b-c02b-411a-a70b-161c809a7814\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-08-19T05:50:32.000000Z\",\"updated_at\":\"2026-08-19T05:50:32.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-08-19T05:50:30.000000Z\",\"updated_at\":\"2026-08-19T05:50:30.000000Z\"}}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"coa_balance\":{\"chart_of_account_id\":\"2f7209ea-c61c-44ac-a2fb-2fe4f4ad5942\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"sub_period_id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"opening_balance\":25236667,\"debit_total\":0,\"credit_total\":0,\"current_balance\":25236667,\"last_transaction_at\":\"2026-08-19T06:47:25.000000Z\",\"id\":\"01a018c6-5079-70e8-be60-9463bd479b90\",\"updated_at\":\"2026-08-19T06:47:25.000000Z\",\"created_at\":\"2026-08-19T06:47:25.000000Z\"}}', '2026-08-18 23:47:25', '2026-08-18 23:47:25'),
('01a018c6-c5bb-72f3-9bb1-8a5e3a544ca5', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Modal Tetap (31100) pada sub periode Desember 2022 dengan jumlah 339,715,097.00', 'App\\Models\\OpeningBalance', '01a018c6-c5a5-72e1-86e7-36f7818e2c05', '[]', '{\"chart_of_account_id\":\"60f843d0-b7d3-4d98-9899-dd5c42b867c3\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"sub_period_id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"balance_type\":\"CREDIT\",\"amount\":339715097,\"created_by\":\"01a01892-30ab-7337-8cb2-5ce8dac14b8a\",\"is_correction\":false,\"id\":\"01a018c6-c5a5-72e1-86e7-36f7818e2c05\",\"updated_at\":\"2026-08-19T06:47:55.000000Z\",\"created_at\":\"2026-08-19T06:47:55.000000Z\",\"chart_of_account\":{\"id\":\"60f843d0-b7d3-4d98-9899-dd5c42b867c3\",\"code\":\"31100\",\"name\":\"Modal Tetap\",\"parent_id\":\"e65b1569-6e31-4cf3-8af2-2a9eb9764ffc\",\"level\":\"2\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567892\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-08-19T05:50:32.000000Z\",\"updated_at\":\"2026-08-19T05:50:32.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-08-19T05:50:30.000000Z\",\"updated_at\":\"2026-08-19T05:50:30.000000Z\"}}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"coa_balance\":{\"chart_of_account_id\":\"60f843d0-b7d3-4d98-9899-dd5c42b867c3\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"sub_period_id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"opening_balance\":339715097,\"debit_total\":0,\"credit_total\":0,\"current_balance\":339715097,\"last_transaction_at\":\"2026-08-19T06:47:55.000000Z\",\"id\":\"01a018c6-c5ab-707e-8485-dc2bf19fc88a\",\"updated_at\":\"2026-08-19T06:47:55.000000Z\",\"created_at\":\"2026-08-19T06:47:55.000000Z\"}}', '2026-08-18 23:47:55', '2026-08-18 23:47:55'),
('01a018c7-338f-73e6-af4a-a697e8a2ef64', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Modal Lancar (31200) pada sub periode Desember 2022 dengan jumlah 368,679,944.00', 'App\\Models\\OpeningBalance', '01a018c7-337c-7205-ab40-89b56e993833', '[]', '{\"chart_of_account_id\":\"e6a020c7-916e-47b9-9242-e1cfc39fc42e\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"sub_period_id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"balance_type\":\"CREDIT\",\"amount\":368679944,\"created_by\":\"01a01892-30ab-7337-8cb2-5ce8dac14b8a\",\"is_correction\":false,\"id\":\"01a018c7-337c-7205-ab40-89b56e993833\",\"updated_at\":\"2026-08-19T06:48:23.000000Z\",\"created_at\":\"2026-08-19T06:48:23.000000Z\",\"chart_of_account\":{\"id\":\"e6a020c7-916e-47b9-9242-e1cfc39fc42e\",\"code\":\"31200\",\"name\":\"Modal Lancar\",\"parent_id\":\"e65b1569-6e31-4cf3-8af2-2a9eb9764ffc\",\"level\":\"2\",\"order\":\"2\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567892\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-08-19T05:50:32.000000Z\",\"updated_at\":\"2026-08-19T05:50:32.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-08-19T05:50:30.000000Z\",\"updated_at\":\"2026-08-19T05:50:30.000000Z\"}}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"coa_balance\":{\"chart_of_account_id\":\"e6a020c7-916e-47b9-9242-e1cfc39fc42e\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"sub_period_id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"opening_balance\":368679944,\"debit_total\":0,\"credit_total\":0,\"current_balance\":368679944,\"last_transaction_at\":\"2026-08-19T06:48:23.000000Z\",\"id\":\"01a018c7-3384-7000-a3f3-f0ba7fda75a4\",\"updated_at\":\"2026-08-19T06:48:23.000000Z\",\"created_at\":\"2026-08-19T06:48:23.000000Z\"}}', '2026-08-18 23:48:23', '2026-08-18 23:48:23'),
('01a018cb-147e-7219-b83c-e56c3330f80e', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Selisih Lebih/Kurang (31300) pada sub periode Desember 2022 dengan jumlah 2,694,850,711.00', 'App\\Models\\OpeningBalance', '01a018cb-146b-71ea-aa78-ac42522d4487', '[]', '{\"chart_of_account_id\":\"9b702b8d-0aee-4a5d-a7a6-14c86f698c9d\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"sub_period_id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"balance_type\":\"CREDIT\",\"amount\":2694850711,\"created_by\":\"01a01892-30ab-7337-8cb2-5ce8dac14b8a\",\"is_correction\":false,\"id\":\"01a018cb-146b-71ea-aa78-ac42522d4487\",\"updated_at\":\"2026-08-19T06:52:37.000000Z\",\"created_at\":\"2026-08-19T06:52:37.000000Z\",\"chart_of_account\":{\"id\":\"9b702b8d-0aee-4a5d-a7a6-14c86f698c9d\",\"code\":\"31300\",\"name\":\"Selisih Lebih\\/Kurang\",\"parent_id\":\"e65b1569-6e31-4cf3-8af2-2a9eb9764ffc\",\"level\":\"2\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567892\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-08-19T05:50:32.000000Z\",\"updated_at\":\"2026-08-19T05:50:32.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"name\":\"Desember 2022\",\"description\":\"Bulan Desember 2022\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-08-19T05:50:30.000000Z\",\"updated_at\":\"2026-08-19T05:50:30.000000Z\"}}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"coa_balance\":{\"chart_of_account_id\":\"9b702b8d-0aee-4a5d-a7a6-14c86f698c9d\",\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"sub_period_id\":\"01a01892-3570-7042-bf44-b27971411a65\",\"opening_balance\":2694850711,\"debit_total\":0,\"credit_total\":0,\"current_balance\":2694850711,\"last_transaction_at\":\"2026-08-19T06:52:37.000000Z\",\"id\":\"01a018cb-1473-71b6-9e4c-56484133d239\",\"updated_at\":\"2026-08-19T06:52:37.000000Z\",\"created_at\":\"2026-08-19T06:52:37.000000Z\"}}', '2026-08-18 23:52:37', '2026-08-18 23:52:37'),
('01a018cc-8bd0-7122-81f4-dcbb2bdb4b01', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'closed', 'SUB_PERIOD', 'Sub periode Desember 2022 berhasil ditutup.', 'App\\Models\\SubPeriod', '01a01892-3570-7042-bf44-b27971411a65', '{\"is_closed\":false}', '{\"is_closed\":true}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"period_id\":\"01a01892-3475-73b3-b03a-e629fe98ebd5\",\"start_date\":\"2022-12-01T00:00:00.000000Z\",\"end_date\":\"2022-12-31T00:00:00.000000Z\",\"is_active\":null}', '2026-08-18 23:54:13', '2026-08-18 23:54:13'),
('01a018cd-4f9a-706b-bb20-7443d60a1236', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas (11100) pada sub periode Januari 2023 dengan jumlah 194,604,157.00', 'App\\Models\\OpeningBalance', '01a018cd-4f84-71b8-8f82-79d180fc6b7e', '[]', '{\"chart_of_account_id\":\"08e15b4f-473b-4440-a706-d4c5a27a063b\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"balance_type\":\"DEBIT\",\"amount\":194604157,\"created_by\":\"01a01892-30ab-7337-8cb2-5ce8dac14b8a\",\"is_correction\":false,\"id\":\"01a018cd-4f84-71b8-8f82-79d180fc6b7e\",\"updated_at\":\"2026-08-19T06:55:03.000000Z\",\"created_at\":\"2026-08-19T06:55:03.000000Z\",\"chart_of_account\":{\"id\":\"08e15b4f-473b-4440-a706-d4c5a27a063b\",\"code\":\"11100\",\"name\":\"Kas\",\"parent_id\":\"358657c6-fe73-408d-8349-8bc351f14284\",\"level\":\"2\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-08-19T05:50:31.000000Z\",\"updated_at\":\"2026-08-19T05:50:31.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-08-19T05:50:30.000000Z\",\"updated_at\":\"2026-08-19T05:50:30.000000Z\"}}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"coa_balance\":{\"chart_of_account_id\":\"08e15b4f-473b-4440-a706-d4c5a27a063b\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"opening_balance\":194604157,\"debit_total\":0,\"credit_total\":0,\"current_balance\":194604157,\"last_transaction_at\":\"2026-08-19T06:55:03.000000Z\",\"id\":\"01a018cd-4f8a-700a-b7a5-533ab2268aa3\",\"updated_at\":\"2026-08-19T06:55:03.000000Z\",\"created_at\":\"2026-08-19T06:55:03.000000Z\"}}', '2026-08-18 23:55:03', '2026-08-18 23:55:03'),
('01a018cd-90ea-73bc-bbe1-a6d2ff8f396e', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas Ditangan (11110) pada sub periode Januari 2023 dengan jumlah 4,983,047.00', 'App\\Models\\OpeningBalance', '01a018cd-90da-71f0-b36e-0b6a56158dc5', '[]', '{\"chart_of_account_id\":\"428e0a5c-05eb-4705-b2a6-4333f44318c2\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"balance_type\":\"DEBIT\",\"amount\":4983047,\"created_by\":\"01a01892-30ab-7337-8cb2-5ce8dac14b8a\",\"is_correction\":false,\"id\":\"01a018cd-90da-71f0-b36e-0b6a56158dc5\",\"updated_at\":\"2026-08-19T06:55:20.000000Z\",\"created_at\":\"2026-08-19T06:55:20.000000Z\",\"chart_of_account\":{\"id\":\"428e0a5c-05eb-4705-b2a6-4333f44318c2\",\"code\":\"11110\",\"name\":\"Kas Ditangan\",\"parent_id\":\"08e15b4f-473b-4440-a706-d4c5a27a063b\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-08-19T05:50:31.000000Z\",\"updated_at\":\"2026-08-19T05:50:31.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-08-19T05:50:30.000000Z\",\"updated_at\":\"2026-08-19T05:50:30.000000Z\"}}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"coa_balance\":{\"chart_of_account_id\":\"428e0a5c-05eb-4705-b2a6-4333f44318c2\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"opening_balance\":4983047,\"debit_total\":0,\"credit_total\":0,\"current_balance\":4983047,\"last_transaction_at\":\"2026-08-19T06:55:20.000000Z\",\"id\":\"01a018cd-90e2-7311-98fc-499c09d7ab2a\",\"updated_at\":\"2026-08-19T06:55:20.000000Z\",\"created_at\":\"2026-08-19T06:55:20.000000Z\"}}', '2026-08-18 23:55:20', '2026-08-18 23:55:20'),
('01a018cd-e3cd-7334-b6f1-908297794bfd', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas di Bank Jatim (11120) pada sub periode Januari 2023 dengan jumlah 405,484,747.00', 'App\\Models\\OpeningBalance', '01a018cd-e3c2-718d-9a4f-f36e3469a078', '[]', '{\"chart_of_account_id\":\"42ca2ce5-a3e0-4900-a0d8-6d741e9e0c68\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"balance_type\":\"DEBIT\",\"amount\":405484747,\"created_by\":\"01a01892-30ab-7337-8cb2-5ce8dac14b8a\",\"is_correction\":false,\"id\":\"01a018cd-e3c2-718d-9a4f-f36e3469a078\",\"updated_at\":\"2026-08-19T06:55:41.000000Z\",\"created_at\":\"2026-08-19T06:55:41.000000Z\",\"chart_of_account\":{\"id\":\"42ca2ce5-a3e0-4900-a0d8-6d741e9e0c68\",\"code\":\"11120\",\"name\":\"Kas di Bank Jatim\",\"parent_id\":\"08e15b4f-473b-4440-a706-d4c5a27a063b\",\"level\":\"3\",\"order\":\"2\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-08-19T05:50:31.000000Z\",\"updated_at\":\"2026-08-19T05:50:31.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-08-19T05:50:30.000000Z\",\"updated_at\":\"2026-08-19T05:50:30.000000Z\"}}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"coa_balance\":{\"chart_of_account_id\":\"42ca2ce5-a3e0-4900-a0d8-6d741e9e0c68\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"opening_balance\":405484747,\"debit_total\":0,\"credit_total\":0,\"current_balance\":405484747,\"last_transaction_at\":\"2026-08-19T06:55:41.000000Z\",\"id\":\"01a018cd-e3c7-7258-94b9-40b7523267dd\",\"updated_at\":\"2026-08-19T06:55:41.000000Z\",\"created_at\":\"2026-08-19T06:55:41.000000Z\"}}', '2026-08-18 23:55:41', '2026-08-18 23:55:41'),
('01a018ce-2857-71c2-b26f-d46bd93b8a04', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas di Bank Jatim Dr. Soetomo (11130) pada sub periode Januari 2023 dengan jumlah 1,156,982,563.00', 'App\\Models\\OpeningBalance', '01a018ce-284a-705d-8cbc-19f0c7d905d2', '[]', '{\"chart_of_account_id\":\"4ec4e235-c953-4aa3-b0bd-3e4a6fa61998\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"balance_type\":\"DEBIT\",\"amount\":1156982563,\"created_by\":\"01a01892-30ab-7337-8cb2-5ce8dac14b8a\",\"is_correction\":false,\"id\":\"01a018ce-284a-705d-8cbc-19f0c7d905d2\",\"updated_at\":\"2026-08-19T06:55:59.000000Z\",\"created_at\":\"2026-08-19T06:55:59.000000Z\",\"chart_of_account\":{\"id\":\"4ec4e235-c953-4aa3-b0bd-3e4a6fa61998\",\"code\":\"11130\",\"name\":\"Kas di Bank Jatim Dr. Soetomo\",\"parent_id\":\"08e15b4f-473b-4440-a706-d4c5a27a063b\",\"level\":\"3\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-08-19T05:50:31.000000Z\",\"updated_at\":\"2026-08-19T05:50:31.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-08-19T05:50:30.000000Z\",\"updated_at\":\"2026-08-19T05:50:30.000000Z\"}}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"coa_balance\":{\"chart_of_account_id\":\"4ec4e235-c953-4aa3-b0bd-3e4a6fa61998\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"opening_balance\":1156982563,\"debit_total\":0,\"credit_total\":0,\"current_balance\":1156982563,\"last_transaction_at\":\"2026-08-19T06:55:59.000000Z\",\"id\":\"01a018ce-2850-7262-83b0-68f510a8339b\",\"updated_at\":\"2026-08-19T06:55:59.000000Z\",\"created_at\":\"2026-08-19T06:55:59.000000Z\"}}', '2026-08-18 23:55:59', '2026-08-18 23:55:59'),
('01a018ce-5f46-7033-a1a5-bc0c74266dd4', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kas di Bank Bukopin Syariah (11140) pada sub periode Januari 2023 dengan jumlah 377,940,865.00', 'App\\Models\\OpeningBalance', '01a018ce-5f35-7261-8223-da57b3cce974', '[]', '{\"chart_of_account_id\":\"2a983594-0762-4d4b-94fe-31dae7c954aa\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"balance_type\":\"DEBIT\",\"amount\":377940865,\"created_by\":\"01a01892-30ab-7337-8cb2-5ce8dac14b8a\",\"is_correction\":false,\"id\":\"01a018ce-5f35-7261-8223-da57b3cce974\",\"updated_at\":\"2026-08-19T06:56:13.000000Z\",\"created_at\":\"2026-08-19T06:56:13.000000Z\",\"chart_of_account\":{\"id\":\"2a983594-0762-4d4b-94fe-31dae7c954aa\",\"code\":\"11140\",\"name\":\"Kas di Bank Bukopin Syariah\",\"parent_id\":\"08e15b4f-473b-4440-a706-d4c5a27a063b\",\"level\":\"3\",\"order\":\"4\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-08-19T05:50:31.000000Z\",\"updated_at\":\"2026-08-19T05:50:31.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-08-19T05:50:30.000000Z\",\"updated_at\":\"2026-08-19T05:50:30.000000Z\"}}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"coa_balance\":{\"chart_of_account_id\":\"2a983594-0762-4d4b-94fe-31dae7c954aa\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"opening_balance\":377940865,\"debit_total\":0,\"credit_total\":0,\"current_balance\":377940865,\"last_transaction_at\":\"2026-08-19T06:56:13.000000Z\",\"id\":\"01a018ce-5f3b-73f6-9ef5-bd090d919196\",\"updated_at\":\"2026-08-19T06:56:13.000000Z\",\"created_at\":\"2026-08-19T06:56:13.000000Z\"}}', '2026-08-18 23:56:13', '2026-08-18 23:56:13');
INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `module`, `description`, `subject_type`, `subject_id`, `old_values`, `new_values`, `ip_address`, `user_agent`, `additional_data`, `created_at`, `updated_at`) VALUES
('01a018ce-9953-727f-87b8-56aed5930d00', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Piutang Karyawan (11300) pada sub periode Januari 2023 dengan jumlah 1,800,000.00', 'App\\Models\\OpeningBalance', '01a018ce-9946-7135-8c40-c0156301072c', '[]', '{\"chart_of_account_id\":\"07c833c4-2d25-46eb-919e-1daa18d37932\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"balance_type\":\"DEBIT\",\"amount\":1800000,\"created_by\":\"01a01892-30ab-7337-8cb2-5ce8dac14b8a\",\"is_correction\":false,\"id\":\"01a018ce-9946-7135-8c40-c0156301072c\",\"updated_at\":\"2026-08-19T06:56:27.000000Z\",\"created_at\":\"2026-08-19T06:56:27.000000Z\",\"chart_of_account\":{\"id\":\"07c833c4-2d25-46eb-919e-1daa18d37932\",\"code\":\"11300\",\"name\":\"Piutang Karyawan\",\"parent_id\":\"358657c6-fe73-408d-8349-8bc351f14284\",\"level\":\"2\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-08-19T05:50:31.000000Z\",\"updated_at\":\"2026-08-19T05:50:31.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-08-19T05:50:30.000000Z\",\"updated_at\":\"2026-08-19T05:50:30.000000Z\"}}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"coa_balance\":{\"chart_of_account_id\":\"07c833c4-2d25-46eb-919e-1daa18d37932\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"opening_balance\":1800000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":1800000,\"last_transaction_at\":\"2026-08-19T06:56:27.000000Z\",\"id\":\"01a018ce-994c-7234-b943-23667964f982\",\"updated_at\":\"2026-08-19T06:56:27.000000Z\",\"created_at\":\"2026-08-19T06:56:27.000000Z\"}}', '2026-08-18 23:56:27', '2026-08-18 23:56:27'),
('01a018ce-d698-73d9-988b-0e9363a19415', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Piutang Lainnya (11400) pada sub periode Januari 2023 dengan jumlah 921,735,276.00', 'App\\Models\\OpeningBalance', '01a018ce-d68a-7163-b92e-f1546183398f', '[]', '{\"chart_of_account_id\":\"497ec733-26b1-41de-be5e-7ca327307bbb\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"balance_type\":\"DEBIT\",\"amount\":921735276,\"created_by\":\"01a01892-30ab-7337-8cb2-5ce8dac14b8a\",\"is_correction\":false,\"id\":\"01a018ce-d68a-7163-b92e-f1546183398f\",\"updated_at\":\"2026-08-19T06:56:43.000000Z\",\"created_at\":\"2026-08-19T06:56:43.000000Z\",\"chart_of_account\":{\"id\":\"497ec733-26b1-41de-be5e-7ca327307bbb\",\"code\":\"11400\",\"name\":\"Piutang Lainnya\",\"parent_id\":\"358657c6-fe73-408d-8349-8bc351f14284\",\"level\":\"2\",\"order\":\"4\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-08-19T05:50:31.000000Z\",\"updated_at\":\"2026-08-19T05:50:31.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-08-19T05:50:30.000000Z\",\"updated_at\":\"2026-08-19T05:50:30.000000Z\"}}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"coa_balance\":{\"chart_of_account_id\":\"497ec733-26b1-41de-be5e-7ca327307bbb\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"opening_balance\":921735276,\"debit_total\":0,\"credit_total\":0,\"current_balance\":921735276,\"last_transaction_at\":\"2026-08-19T06:56:43.000000Z\",\"id\":\"01a018ce-d691-72b0-aae7-d0c62e4e2c10\",\"updated_at\":\"2026-08-19T06:56:43.000000Z\",\"created_at\":\"2026-08-19T06:56:43.000000Z\"}}', '2026-08-18 23:56:43', '2026-08-18 23:56:43'),
('01a018cf-2b5e-737d-9039-caab2f0b62e1', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Kendaraan (12300) pada sub periode Januari 2023 dengan jumlah 460,769,432.00', 'App\\Models\\OpeningBalance', '01a018cf-2b50-7227-839b-38109838ff6f', '[]', '{\"chart_of_account_id\":\"be57ddf7-3177-4d16-bb22-db567be94f18\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"balance_type\":\"DEBIT\",\"amount\":460769432,\"created_by\":\"01a01892-30ab-7337-8cb2-5ce8dac14b8a\",\"is_correction\":false,\"id\":\"01a018cf-2b50-7227-839b-38109838ff6f\",\"updated_at\":\"2026-08-19T06:57:05.000000Z\",\"created_at\":\"2026-08-19T06:57:05.000000Z\",\"chart_of_account\":{\"id\":\"be57ddf7-3177-4d16-bb22-db567be94f18\",\"code\":\"12300\",\"name\":\"Kendaraan\",\"parent_id\":\"cbb43cce-4240-4816-878b-589ed0dc3077\",\"level\":\"2\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-08-19T05:50:31.000000Z\",\"updated_at\":\"2026-08-19T05:50:31.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-08-19T05:50:30.000000Z\",\"updated_at\":\"2026-08-19T05:50:30.000000Z\"}}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"coa_balance\":{\"chart_of_account_id\":\"be57ddf7-3177-4d16-bb22-db567be94f18\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"opening_balance\":460769432,\"debit_total\":0,\"credit_total\":0,\"current_balance\":460769432,\"last_transaction_at\":\"2026-08-19T06:57:05.000000Z\",\"id\":\"01a018cf-2b56-7251-aa1c-b0027f2dda45\",\"updated_at\":\"2026-08-19T06:57:05.000000Z\",\"created_at\":\"2026-08-19T06:57:05.000000Z\"}}', '2026-08-18 23:57:05', '2026-08-18 23:57:05'),
('01a018cf-75c5-705b-bd0b-45be1afda414', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Akumulasi Depresiasi Kendaraan (12310) pada sub periode Januari 2023 dengan jumlah 144,000,000.00', 'App\\Models\\OpeningBalance', '01a018cf-75b8-71e5-bd72-c11d0cf37bbb', '[]', '{\"chart_of_account_id\":\"fbbbf9d7-a082-4cb6-8384-2e9c709f7d69\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"balance_type\":\"CREDIT\",\"amount\":144000000,\"created_by\":\"01a01892-30ab-7337-8cb2-5ce8dac14b8a\",\"is_correction\":false,\"id\":\"01a018cf-75b8-71e5-bd72-c11d0cf37bbb\",\"updated_at\":\"2026-08-19T06:57:24.000000Z\",\"created_at\":\"2026-08-19T06:57:24.000000Z\",\"chart_of_account\":{\"id\":\"fbbbf9d7-a082-4cb6-8384-2e9c709f7d69\",\"code\":\"12310\",\"name\":\"Akumulasi Depresiasi Kendaraan\",\"parent_id\":\"be57ddf7-3177-4d16-bb22-db567be94f18\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-08-19T05:50:31.000000Z\",\"updated_at\":\"2026-08-19T05:50:31.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-08-19T05:50:30.000000Z\",\"updated_at\":\"2026-08-19T05:50:30.000000Z\"}}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"coa_balance\":{\"chart_of_account_id\":\"fbbbf9d7-a082-4cb6-8384-2e9c709f7d69\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"opening_balance\":144000000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":144000000,\"last_transaction_at\":\"2026-08-19T06:57:24.000000Z\",\"id\":\"01a018cf-75be-73f9-8968-5124d45b3b96\",\"updated_at\":\"2026-08-19T06:57:24.000000Z\",\"created_at\":\"2026-08-19T06:57:24.000000Z\"}}', '2026-08-18 23:57:24', '2026-08-18 23:57:24'),
('01a018cf-bdb5-73d4-b62f-44ce18a5a9af', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Meubel (12400) pada sub periode Januari 2023 dengan jumlah 15,500,000.00', 'App\\Models\\OpeningBalance', '01a018cf-bda8-72dc-b9af-e3c38fc8f98d', '[]', '{\"chart_of_account_id\":\"48fb488e-f265-467a-afb7-a12aded626aa\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"balance_type\":\"DEBIT\",\"amount\":15500000,\"created_by\":\"01a01892-30ab-7337-8cb2-5ce8dac14b8a\",\"is_correction\":false,\"id\":\"01a018cf-bda8-72dc-b9af-e3c38fc8f98d\",\"updated_at\":\"2026-08-19T06:57:42.000000Z\",\"created_at\":\"2026-08-19T06:57:42.000000Z\",\"chart_of_account\":{\"id\":\"48fb488e-f265-467a-afb7-a12aded626aa\",\"code\":\"12400\",\"name\":\"Meubel\",\"parent_id\":\"cbb43cce-4240-4816-878b-589ed0dc3077\",\"level\":\"2\",\"order\":\"4\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-08-19T05:50:31.000000Z\",\"updated_at\":\"2026-08-19T05:50:31.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-08-19T05:50:30.000000Z\",\"updated_at\":\"2026-08-19T05:50:30.000000Z\"}}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"coa_balance\":{\"chart_of_account_id\":\"48fb488e-f265-467a-afb7-a12aded626aa\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"opening_balance\":15500000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":15500000,\"last_transaction_at\":\"2026-08-19T06:57:42.000000Z\",\"id\":\"01a018cf-bdae-70d3-b33f-98a6617c3571\",\"updated_at\":\"2026-08-19T06:57:42.000000Z\",\"created_at\":\"2026-08-19T06:57:42.000000Z\"}}', '2026-08-18 23:57:42', '2026-08-18 23:57:42'),
('01a018d0-0ad8-72fe-9f97-d6b729d333ab', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Akumulasi Depresiasi Meubel (12410) pada sub periode Januari 2023 dengan jumlah 13,376,668.00', 'App\\Models\\OpeningBalance', '01a018d0-0ac9-7290-a6c6-070db43d204c', '[]', '{\"chart_of_account_id\":\"c5b99c5f-5885-4ef9-bae3-ab1811e502af\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"balance_type\":\"CREDIT\",\"amount\":13376668,\"created_by\":\"01a01892-30ab-7337-8cb2-5ce8dac14b8a\",\"is_correction\":false,\"id\":\"01a018d0-0ac9-7290-a6c6-070db43d204c\",\"updated_at\":\"2026-08-19T06:58:02.000000Z\",\"created_at\":\"2026-08-19T06:58:02.000000Z\",\"chart_of_account\":{\"id\":\"c5b99c5f-5885-4ef9-bae3-ab1811e502af\",\"code\":\"12410\",\"name\":\"Akumulasi Depresiasi Meubel\",\"parent_id\":\"48fb488e-f265-467a-afb7-a12aded626aa\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-08-19T05:50:31.000000Z\",\"updated_at\":\"2026-08-19T05:50:31.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-08-19T05:50:30.000000Z\",\"updated_at\":\"2026-08-19T05:50:30.000000Z\"}}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"coa_balance\":{\"chart_of_account_id\":\"c5b99c5f-5885-4ef9-bae3-ab1811e502af\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"opening_balance\":13376668,\"debit_total\":0,\"credit_total\":0,\"current_balance\":13376668,\"last_transaction_at\":\"2026-08-19T06:58:02.000000Z\",\"id\":\"01a018d0-0ad0-7015-bbfb-c2ab9be6d65a\",\"updated_at\":\"2026-08-19T06:58:02.000000Z\",\"created_at\":\"2026-08-19T06:58:02.000000Z\"}}', '2026-08-18 23:58:02', '2026-08-18 23:58:02'),
('01a018d2-bae9-72fa-8ee0-da2ada62b750', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Peralatan Kantor (12500) pada sub periode Januari 2023 dengan jumlah 46,059,000.00', 'App\\Models\\OpeningBalance', '01a018d2-bad7-71f2-95ce-3be1500dfd9a', '[]', '{\"chart_of_account_id\":\"9e17057b-c02b-411a-a70b-161c809a7814\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"balance_type\":\"DEBIT\",\"amount\":46059000,\"created_by\":\"01a01892-30ab-7337-8cb2-5ce8dac14b8a\",\"is_correction\":false,\"id\":\"01a018d2-bad7-71f2-95ce-3be1500dfd9a\",\"updated_at\":\"2026-08-19T07:00:58.000000Z\",\"created_at\":\"2026-08-19T07:00:58.000000Z\",\"chart_of_account\":{\"id\":\"9e17057b-c02b-411a-a70b-161c809a7814\",\"code\":\"12500\",\"name\":\"Peralatan Kantor\",\"parent_id\":\"cbb43cce-4240-4816-878b-589ed0dc3077\",\"level\":\"2\",\"order\":\"5\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"DEBIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-08-19T05:50:32.000000Z\",\"updated_at\":\"2026-08-19T05:50:32.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-08-19T05:50:30.000000Z\",\"updated_at\":\"2026-08-19T05:50:30.000000Z\"}}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"coa_balance\":{\"chart_of_account_id\":\"9e17057b-c02b-411a-a70b-161c809a7814\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"opening_balance\":46059000,\"debit_total\":0,\"credit_total\":0,\"current_balance\":46059000,\"last_transaction_at\":\"2026-08-19T07:00:58.000000Z\",\"id\":\"01a018d2-bae0-7156-baca-3a7590d49374\",\"updated_at\":\"2026-08-19T07:00:58.000000Z\",\"created_at\":\"2026-08-19T07:00:58.000000Z\"}}', '2026-08-19 00:00:58', '2026-08-19 00:00:58'),
('01a018d2-fb2b-7063-be91-b7636c6d83bf', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Akumulasi Depresiasi Peralatan Kantor (12510) pada sub periode Januari 2023 dengan jumlah 25,236,667.00', 'App\\Models\\OpeningBalance', '01a018d2-fb17-700e-8273-d1c657e38616', '[]', '{\"chart_of_account_id\":\"2f7209ea-c61c-44ac-a2fb-2fe4f4ad5942\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"balance_type\":\"CREDIT\",\"amount\":25236667,\"created_by\":\"01a01892-30ab-7337-8cb2-5ce8dac14b8a\",\"is_correction\":false,\"id\":\"01a018d2-fb17-700e-8273-d1c657e38616\",\"updated_at\":\"2026-08-19T07:01:15.000000Z\",\"created_at\":\"2026-08-19T07:01:15.000000Z\",\"chart_of_account\":{\"id\":\"2f7209ea-c61c-44ac-a2fb-2fe4f4ad5942\",\"code\":\"12510\",\"name\":\"Akumulasi Depresiasi Peralatan Kantor\",\"parent_id\":\"9e17057b-c02b-411a-a70b-161c809a7814\",\"level\":\"3\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567890\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-08-19T05:50:32.000000Z\",\"updated_at\":\"2026-08-19T05:50:32.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-08-19T05:50:30.000000Z\",\"updated_at\":\"2026-08-19T05:50:30.000000Z\"}}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"coa_balance\":{\"chart_of_account_id\":\"2f7209ea-c61c-44ac-a2fb-2fe4f4ad5942\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"opening_balance\":25236667,\"debit_total\":0,\"credit_total\":0,\"current_balance\":25236667,\"last_transaction_at\":\"2026-08-19T07:01:15.000000Z\",\"id\":\"01a018d2-fb1d-71e8-8940-ec8a7999a4bb\",\"updated_at\":\"2026-08-19T07:01:15.000000Z\",\"created_at\":\"2026-08-19T07:01:15.000000Z\"}}', '2026-08-19 00:01:15', '2026-08-19 00:01:15'),
('01a018d3-6d79-703b-a4c2-49df83089cdf', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Modal Tetap (31100) pada sub periode Januari 2023 dengan jumlah 339,715,097.00', 'App\\Models\\OpeningBalance', '01a018d3-6d6d-7173-8e2d-0045a4275c43', '[]', '{\"chart_of_account_id\":\"60f843d0-b7d3-4d98-9899-dd5c42b867c3\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"balance_type\":\"CREDIT\",\"amount\":339715097,\"created_by\":\"01a01892-30ab-7337-8cb2-5ce8dac14b8a\",\"is_correction\":false,\"id\":\"01a018d3-6d6d-7173-8e2d-0045a4275c43\",\"updated_at\":\"2026-08-19T07:01:44.000000Z\",\"created_at\":\"2026-08-19T07:01:44.000000Z\",\"chart_of_account\":{\"id\":\"60f843d0-b7d3-4d98-9899-dd5c42b867c3\",\"code\":\"31100\",\"name\":\"Modal Tetap\",\"parent_id\":\"e65b1569-6e31-4cf3-8af2-2a9eb9764ffc\",\"level\":\"2\",\"order\":\"1\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567892\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-08-19T05:50:32.000000Z\",\"updated_at\":\"2026-08-19T05:50:32.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-08-19T05:50:30.000000Z\",\"updated_at\":\"2026-08-19T05:50:30.000000Z\"}}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"coa_balance\":{\"chart_of_account_id\":\"60f843d0-b7d3-4d98-9899-dd5c42b867c3\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"opening_balance\":339715097,\"debit_total\":0,\"credit_total\":0,\"current_balance\":339715097,\"last_transaction_at\":\"2026-08-19T07:01:44.000000Z\",\"id\":\"01a018d3-6d73-7225-ab2c-7efdd403f17d\",\"updated_at\":\"2026-08-19T07:01:44.000000Z\",\"created_at\":\"2026-08-19T07:01:44.000000Z\"}}', '2026-08-19 00:01:44', '2026-08-19 00:01:44'),
('01a018d3-cb33-7108-9aa4-fb162e8a21a6', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Modal Lancar (31200) pada sub periode Januari 2023 dengan jumlah 368,679,944.00', 'App\\Models\\OpeningBalance', '01a018d3-cb25-709e-ac28-9ab0b4b3efad', '[]', '{\"chart_of_account_id\":\"e6a020c7-916e-47b9-9242-e1cfc39fc42e\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"balance_type\":\"CREDIT\",\"amount\":368679944,\"created_by\":\"01a01892-30ab-7337-8cb2-5ce8dac14b8a\",\"is_correction\":false,\"id\":\"01a018d3-cb25-709e-ac28-9ab0b4b3efad\",\"updated_at\":\"2026-08-19T07:02:08.000000Z\",\"created_at\":\"2026-08-19T07:02:08.000000Z\",\"chart_of_account\":{\"id\":\"e6a020c7-916e-47b9-9242-e1cfc39fc42e\",\"code\":\"31200\",\"name\":\"Modal Lancar\",\"parent_id\":\"e65b1569-6e31-4cf3-8af2-2a9eb9764ffc\",\"level\":\"2\",\"order\":\"2\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567892\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-08-19T05:50:32.000000Z\",\"updated_at\":\"2026-08-19T05:50:32.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-08-19T05:50:30.000000Z\",\"updated_at\":\"2026-08-19T05:50:30.000000Z\"}}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"coa_balance\":{\"chart_of_account_id\":\"e6a020c7-916e-47b9-9242-e1cfc39fc42e\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"opening_balance\":368679944,\"debit_total\":0,\"credit_total\":0,\"current_balance\":368679944,\"last_transaction_at\":\"2026-08-19T07:02:08.000000Z\",\"id\":\"01a018d3-cb2b-71ab-bc50-3f220e907e01\",\"updated_at\":\"2026-08-19T07:02:08.000000Z\",\"created_at\":\"2026-08-19T07:02:08.000000Z\"}}', '2026-08-19 00:02:08', '2026-08-19 00:02:08'),
('01a018d4-018d-70d3-bbcb-76f9b0821bac', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'created', 'OPENING_BALANCE', 'Membuat opening balance untuk akun Selisih Lebih/Kurang (31300) pada sub periode Januari 2023 dengan jumlah 2,694,850,711.00', 'App\\Models\\OpeningBalance', '01a018d4-0181-715f-a9e1-82c5f9189faa', '[]', '{\"chart_of_account_id\":\"9b702b8d-0aee-4a5d-a7a6-14c86f698c9d\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"balance_type\":\"CREDIT\",\"amount\":2694850711,\"created_by\":\"01a01892-30ab-7337-8cb2-5ce8dac14b8a\",\"is_correction\":false,\"id\":\"01a018d4-0181-715f-a9e1-82c5f9189faa\",\"updated_at\":\"2026-08-19T07:02:22.000000Z\",\"created_at\":\"2026-08-19T07:02:22.000000Z\",\"chart_of_account\":{\"id\":\"9b702b8d-0aee-4a5d-a7a6-14c86f698c9d\",\"code\":\"31300\",\"name\":\"Selisih Lebih\\/Kurang\",\"parent_id\":\"e65b1569-6e31-4cf3-8af2-2a9eb9764ffc\",\"level\":\"2\",\"order\":\"3\",\"account_type_id\":\"a1b2c3d4-e5f6-7890-abcd-ef1234567892\",\"description\":null,\"normal_balance\":\"CREDIT\",\"is_active\":true,\"created_by\":null,\"created_at\":\"2026-08-19T05:50:32.000000Z\",\"updated_at\":\"2026-08-19T05:50:32.000000Z\",\"deleted_at\":null},\"sub_period\":{\"id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"name\":\"Januari 2023\",\"description\":\"Bulan Januari 2023\",\"start_date\":\"2023-01-01T00:00:00.000000Z\",\"end_date\":\"2023-01-31T00:00:00.000000Z\",\"is_closed\":false,\"closed_at\":null,\"closed_by\":null,\"created_at\":\"2026-08-19T05:50:30.000000Z\",\"updated_at\":\"2026-08-19T05:50:30.000000Z\"}}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"coa_balance\":{\"chart_of_account_id\":\"9b702b8d-0aee-4a5d-a7a6-14c86f698c9d\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\",\"opening_balance\":2694850711,\"debit_total\":0,\"credit_total\":0,\"current_balance\":2694850711,\"last_transaction_at\":\"2026-08-19T07:02:22.000000Z\",\"id\":\"01a018d4-0187-7268-a5a9-481908f2211b\",\"updated_at\":\"2026-08-19T07:02:22.000000Z\",\"created_at\":\"2026-08-19T07:02:22.000000Z\"}}', '2026-08-19 00:02:22', '2026-08-19 00:02:22'),
('01a018ea-2725-7115-8081-aaf896c19a1a', '01a01892-33c9-721a-a9c3-32de766115f7', 'UPDATE', 'USER_ACCOUNT_BALANCE', 'Saldo pengguna berkurang karena transaksi pengeluaran.', 'App\\Models\\UserAccountBalance', '01a018e8-e8b4-71fa-b0fb-c75408c0348a', '{\"used_balance\":\"0.00\",\"remaining_balance\":\"4983047.00\"}', '{\"used_balance\":402500,\"remaining_balance\":4580547}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"transaction_id\":\"01a018ea-270f-729b-bf6d-1e3abb3d62ec\",\"transaction_number\":\"TRX-EXP-20260819072633\",\"expense_amount\":402500}', '2026-08-19 00:26:33', '2026-08-19 00:26:33'),
('01a018ea-2728-70e7-abc8-6ddc432bce75', '01a01892-33c9-721a-a9c3-32de766115f7', 'CREATE', 'TRANSACTION_EXPENSE', 'Membuat transaksi pengeluaran.', 'App\\Models\\Transaction', '01a018ea-270f-729b-bf6d-1e3abb3d62ec', '[]', '{\"transaction_id\":\"01a018ea-270f-729b-bf6d-1e3abb3d62ec\",\"transaction_number\":\"TRX-EXP-20260819072633\",\"transaction_date\":\"2023-01-01T00:00:00.000000Z\",\"total_amount\":402500,\"status\":\"POSTED\",\"lines\":[{\"coa_id\":\"1f4aee8e-7929-4596-afab-9275a64353bc\",\"position\":\"DEBIT\",\"amount\":402500,\"description\":\"Biaya Parkir Pengeluaran\"},{\"coa_id\":\"428e0a5c-05eb-4705-b2a6-4333f44318c2\",\"position\":\"CREDIT\",\"amount\":402500,\"description\":\"Kas Ditangan Kas Keluar\"}]}', '114.8.227.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:153.0) Gecko/20100101 Firefox/153.0', '{\"transaction_type\":\"EXPENSE\",\"period_id\":\"01a01892-358d-7241-9d2f-3e8b59a7ef11\",\"sub_period_id\":\"01a01892-35ae-7116-95b4-4cabe8ce6031\"}', '2026-08-19 00:26:33', '2026-08-19 00:26:33');

-- --------------------------------------------------------

--
-- Struktur dari tabel `balance_requests`
--

CREATE TABLE `balance_requests` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `requester_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `approver_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_account_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `source_coa_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `period_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_period_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `status` enum('pending','approved','rejected','canceled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `purpose` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `approved_at` timestamp NULL DEFAULT NULL,
  `approval_notes` text COLLATE utf8mb4_unicode_ci,
  `rejected_at` timestamp NULL DEFAULT NULL,
  `rejection_reason` text COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `budget_allocations`
--

CREATE TABLE `budget_allocations` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `from_chart_of_account_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `to_chart_of_account_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `period_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_period_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(15,2) NOT NULL,
  `allocation_type` enum('manual','auto') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'auto',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `chart_of_accounts`
--

CREATE TABLE `chart_of_accounts` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `level` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_type_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `normal_balance` enum('DEBIT','CREDIT') COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `chart_of_accounts`
--

INSERT INTO `chart_of_accounts` (`id`, `code`, `name`, `parent_id`, `level`, `order`, `account_type_id`, `description`, `normal_balance`, `is_active`, `created_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
('01a6ceac-9323-4e5b-81eb-5904785cb371', '52012', 'Biaya BBM', '0d292bff-c890-4ec0-b139-cf21b197590c', '3', '12', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:34', '2026-08-18 22:50:34', NULL),
('01e17af4-b5e1-45a7-8a8e-3e46a346689c', '57204', 'Biaya Program Ekonomi dan Ketenagakerjaan', '7d9cf22a-4943-474a-929a-3bb5a38cc8ad', '4', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:35', '2026-08-18 22:50:35', NULL),
('01fe1230-5091-4c93-8592-9d12d816c873', '44003', 'Pendapatan Sewa ATC', '0b7edae5-2603-4fca-b0b4-021958ce2007', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:33', '2026-08-18 22:50:33', NULL),
('02ab1587-1178-4318-a11a-75602883cb8e', '50000', 'Beban Operasional', NULL, '1', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:33', '2026-08-18 22:50:33', NULL),
('0426f16a-9263-41bf-84be-fdba26415ae9', '54300', 'Biaya Sidang Tanwir', 'e19a840d-61dd-4181-9b47-0a57c51a1821', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:35', '2026-08-18 22:50:35', NULL),
('04412dba-f0b0-4cf0-a936-22384d4f09de', '22400', 'Hutang PPh Final', '37c8c7c4-950a-46a2-9463-0c7a3a7cbd7b', '2', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567891', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:32', '2026-08-18 22:50:32', NULL),
('0506ee3f-8db9-4fb7-b2a9-5517c6872f4b', '52700', 'Biaya Pemeliharaan Kendaraan', '0d292bff-c890-4ec0-b139-cf21b197590c', '3', '7', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:34', '2026-08-18 22:50:34', NULL),
('0530a8fd-428a-4157-913f-73c048b384ec', '57700', 'Biaya Pembangunan ATC', 'cf6abddb-c37d-4d09-81e1-d7e1b228c295', '3', '7', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:36', '2026-08-18 22:50:36', NULL),
('07c833c4-2d25-46eb-919e-1daa18d37932', '11300', 'Piutang Karyawan', '358657c6-fe73-408d-8349-8bc351f14284', '2', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:31', '2026-08-18 22:50:31', NULL),
('08e15b4f-473b-4440-a706-d4c5a27a063b', '11100', 'Kas', '358657c6-fe73-408d-8349-8bc351f14284', '2', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:31', '2026-08-18 22:50:31', NULL),
('09047564-c6b0-43ee-9325-1a60f8bc8210', '52015', 'Biaya Administrasi Kantor Lainnya', '0d292bff-c890-4ec0-b139-cf21b197590c', '3', '15', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:34', '2026-08-18 22:50:34', NULL),
('0aac9b12-2986-4461-b203-775f40299bdf', '22200', 'Hutang PPh 21', '37c8c7c4-950a-46a2-9463-0c7a3a7cbd7b', '2', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567891', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:32', '2026-08-18 22:50:32', NULL),
('0b7edae5-2603-4fca-b0b4-021958ce2007', '44000', 'Pendapatan Kerjasama', 'ee37a3ca-1bf9-4893-a8d9-b2e09ca9bd56', '2', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:33', '2026-08-18 22:50:33', NULL),
('0d292bff-c890-4ec0-b139-cf21b197590c', '52000', 'Biaya Tata Usaha Administrasi Kantor', '02ab1587-1178-4318-a11a-75602883cb8e', '2', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:34', '2026-08-18 22:50:34', NULL),
('0f33f8c0-5dd6-49ea-bd65-a156fe582482', '52600', 'Biaya Pemeliharaan Gedung', '0d292bff-c890-4ec0-b139-cf21b197590c', '3', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:34', '2026-08-18 22:50:34', NULL),
('0f35d3fb-1d8e-4c26-b389-3529db99acf4', '51000', 'Biaya Personalia', '02ab1587-1178-4318-a11a-75602883cb8e', '2', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:33', '2026-08-18 22:50:33', NULL),
('1813e7c7-6603-4b01-9503-0fd3ab29c265', '42400', 'Kontribusi Media', '736666f9-64f2-44c2-807e-029286aea71e', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:33', '2026-08-18 22:50:33', NULL),
('1ceb41e2-0b92-495f-97a8-429fdf2c0817', '51002', 'Honorarium/Kontrak', '0f35d3fb-1d8e-4c26-b389-3529db99acf4', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:33', '2026-08-18 22:50:33', NULL),
('1f4aee8e-7929-4596-afab-9275a64353bc', '52013', 'Biaya Parkir', '0d292bff-c890-4ec0-b139-cf21b197590c', '3', '13', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:34', '2026-08-18 22:50:34', NULL),
('21106003-e3e0-46a2-a93f-4c6aefe848a2', '41400', 'Muhammadiyah', '549eacd3-d424-455c-bbad-3017fbc3dee1', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:32', '2026-08-18 22:50:32', NULL),
('2a983594-0762-4d4b-94fe-31dae7c954aa', '11140', 'Kas di Bank Bukopin Syariah', '08e15b4f-473b-4440-a706-d4c5a27a063b', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:31', '2026-08-18 22:50:31', NULL),
('2d73c3d7-f395-482d-a56d-544ec82850b7', '58100', 'Tunjangan Hari Raya', '4120d48b-9edd-4c50-a3fa-61479eefd67c', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:36', '2026-08-18 22:50:36', NULL),
('2f7209ea-c61c-44ac-a2fb-2fe4f4ad5942', '12510', 'Akumulasi Depresiasi Peralatan Kantor', '9e17057b-c02b-411a-a70b-161c809a7814', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:32', '2026-08-18 22:50:32', NULL),
('322e4838-588b-4746-93cd-45a6216e1859', '11810', 'PPN Masukan', '7982e02f-5bea-46dd-989d-5d043d4c9ac8', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:31', '2026-08-18 22:50:31', NULL),
('335426e6-9a75-4044-bcdc-c9341953d07d', '57100', 'Biaya Pelaksanaan Program', 'cf6abddb-c37d-4d09-81e1-d7e1b228c295', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:35', '2026-08-18 22:50:35', NULL),
('358657c6-fe73-408d-8349-8bc351f14284', '11000', 'Aset Lancar', NULL, '1', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:30', '2026-08-18 22:50:30', NULL),
('37c8c7c4-950a-46a2-9463-0c7a3a7cbd7b', '22000', 'Hutang Pajak', NULL, '1', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567891', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:32', '2026-08-18 22:50:32', NULL),
('3d80de27-170d-4c9c-972c-db16527a3254', '12100', 'Tanah', 'cbb43cce-4240-4816-878b-589ed0dc3077', '2', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:31', '2026-08-18 22:50:31', NULL),
('3fc473e1-13f0-47ea-9596-1a0a24130463', '52200', 'Biaya Listrik, Telepon, Air, & Internet', '0d292bff-c890-4ec0-b139-cf21b197590c', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:34', '2026-08-18 22:50:34', NULL),
('4120d48b-9edd-4c50-a3fa-61479eefd67c', '58000', 'Biaya Kesejahteraan', '02ab1587-1178-4318-a11a-75602883cb8e', '2', '8', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:36', '2026-08-18 22:50:36', NULL),
('413d1cc6-3b86-44fb-9184-a1f16f3f3656', '57800', 'Biaya Operasional Inklusi', 'cf6abddb-c37d-4d09-81e1-d7e1b228c295', '3', '8', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:36', '2026-08-18 22:50:36', NULL),
('428e0a5c-05eb-4705-b2a6-4333f44318c2', '11110', 'Kas Ditangan', '08e15b4f-473b-4440-a706-d4c5a27a063b', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:31', '2026-08-18 22:50:31', NULL),
('42ca2ce5-a3e0-4900-a0d8-6d741e9e0c68', '11120', 'Kas di Bank Jatim', '08e15b4f-473b-4440-a706-d4c5a27a063b', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:31', '2026-08-18 22:50:31', NULL),
('43825298-9466-4975-b2f5-9c8c04015647', '22100', 'Hutang PPN', '37c8c7c4-950a-46a2-9463-0c7a3a7cbd7b', '2', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567891', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:32', '2026-08-18 22:50:32', NULL),
('4446aab5-0d01-49f7-bf73-79880109da89', '11700', 'Kos Wonorejo', '358657c6-fe73-408d-8349-8bc351f14284', '2', '7', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:31', '2026-08-18 22:50:31', NULL),
('47e1b824-ae48-4d38-a262-2f09ed748d8c', '57208', 'Biaya Program Lembaga Budaya Seni dan Olah Raga', '7d9cf22a-4943-474a-929a-3bb5a38cc8ad', '4', '8', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:35', '2026-08-18 22:50:35', NULL),
('48802d54-e75c-4fc3-b4ed-4edeb9e1c16e', '54200', 'Biaya Sidang Muswil/Muspimwil/Konsolidasi & Pembinaan AMM', 'e19a840d-61dd-4181-9b47-0a57c51a1821', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:35', '2026-08-18 22:50:35', NULL),
('48fb488e-f265-467a-afb7-a12aded626aa', '12400', 'Meubel', 'cbb43cce-4240-4816-878b-589ed0dc3077', '2', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:31', '2026-08-18 22:50:31', NULL),
('497ec733-26b1-41de-be5e-7ca327307bbb', '11400', 'Piutang Lainnya', '358657c6-fe73-408d-8349-8bc351f14284', '2', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:31', '2026-08-18 22:50:31', NULL),
('4ec4e235-c953-4aa3-b0bd-3e4a6fa61998', '11130', 'Kas di Bank Jatim Dr. Soetomo', '08e15b4f-473b-4440-a706-d4c5a27a063b', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:31', '2026-08-18 22:50:31', NULL),
('4eccd469-b5e3-49a4-a5c8-e38935bb4aaa', '59000', 'Biaya Administrasi Bank', '02ab1587-1178-4318-a11a-75602883cb8e', '2', '9', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:36', '2026-08-18 22:50:36', NULL),
('52678ecc-fa79-4b5e-8f1c-3115ad12dbab', '21000', 'Hutang Pihak Lain', NULL, '1', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567891', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:32', '2026-08-18 22:50:32', NULL),
('549eacd3-d424-455c-bbad-3017fbc3dee1', '41000', 'Pendapatan Organisasi', 'ee37a3ca-1bf9-4893-a8d9-b2e09ca9bd56', '2', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:32', '2026-08-18 22:50:32', NULL),
('57a3cf82-241c-4785-a173-d6c35b8d8b0b', '53100', 'Depresiasi Gedung', 'c37423f6-c3c3-46ef-9d0b-be58f8023e0d', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:34', '2026-08-18 22:50:34', NULL),
('5cf4c998-2379-441b-8022-39fa011da378', '52011', 'Biaya Kerumahtanggaan', '0d292bff-c890-4ec0-b139-cf21b197590c', '3', '11', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:34', '2026-08-18 22:50:34', NULL),
('60f843d0-b7d3-4d98-9899-dd5c42b867c3', '31100', 'Modal Tetap', 'e65b1569-6e31-4cf3-8af2-2a9eb9764ffc', '2', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567892', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:32', '2026-08-18 22:50:32', NULL),
('6471a78b-6866-4c5f-914b-05f5943de13f', '57400', 'Biaya Diskusi dan Kajian', 'cf6abddb-c37d-4d09-81e1-d7e1b228c295', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:36', '2026-08-18 22:50:36', NULL),
('71abdc28-98f2-4686-a01d-d57269ca3f5e', '41200', 'Dana Wajib Organisasi', '549eacd3-d424-455c-bbad-3017fbc3dee1', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:32', '2026-08-18 22:50:32', NULL),
('736666f9-64f2-44c2-807e-029286aea71e', '42000', 'Kontribusi Amal Usaha', 'ee37a3ca-1bf9-4893-a8d9-b2e09ca9bd56', '2', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:33', '2026-08-18 22:50:33', NULL),
('74164ad2-dc66-4637-9787-8ea9fb7d2786', '59300', 'Biaya Materai', '4eccd469-b5e3-49a4-a5c8-e38935bb4aaa', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:36', '2026-08-18 22:50:36', NULL),
('7982e02f-5bea-46dd-989d-5d043d4c9ac8', '11800', 'Pajak Dibayar Dimuka', '358657c6-fe73-408d-8349-8bc351f14284', '2', '8', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:31', '2026-08-18 22:50:31', NULL),
('79ab97bb-c369-43fd-a3e7-7653379f4ca3', '53400', 'Depresiasi Peralatan Kantor', 'c37423f6-c3c3-46ef-9d0b-be58f8023e0d', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:34', '2026-08-18 22:50:34', NULL),
('7c39b310-92b3-47fa-bb22-472ed7a3f61f', '42500', 'Kontribusi Lainnya', '736666f9-64f2-44c2-807e-029286aea71e', '3', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:33', '2026-08-18 22:50:33', NULL),
('7ca2b5d4-da4f-4e48-adf6-44a2ddff4639', '54100', 'Biaya Sidang Rutin, Pleno dll', 'e19a840d-61dd-4181-9b47-0a57c51a1821', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:35', '2026-08-18 22:50:35', NULL),
('7d88cba0-d0e8-4209-96d4-1d38e9384a0f', '44002', 'Kerjasama Eksternal', '0b7edae5-2603-4fca-b0b4-021958ce2007', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:33', '2026-08-18 22:50:33', NULL),
('7d9cf22a-4943-474a-929a-3bb5a38cc8ad', '57200', 'Biaya Pelaksanaan Program Majelis & Lembaga', 'cf6abddb-c37d-4d09-81e1-d7e1b228c295', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:35', '2026-08-18 22:50:35', NULL),
('8608167b-6832-4961-8ebc-cbec2b0ac8f6', '53200', 'Depresiasi Kendaraan', 'c37423f6-c3c3-46ef-9d0b-be58f8023e0d', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:34', '2026-08-18 22:50:34', NULL),
('866c1c5e-69ce-484e-a2c5-7bd92a30d1e4', '59100', 'Biaya Pajak Bank', '4eccd469-b5e3-49a4-a5c8-e38935bb4aaa', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:36', '2026-08-18 22:50:36', NULL),
('86e9d092-0ade-4937-957a-694ea7a3b3c9', '57500', 'Biaya Pelaksanaan Program Kerjasama', 'cf6abddb-c37d-4d09-81e1-d7e1b228c295', '3', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:36', '2026-08-18 22:50:36', NULL),
('89ce14b6-887a-400a-8e26-45556ae7dcb9', '55400', 'Perdiem Pengiriman Utusan', 'de8a8b26-903f-4883-8614-2c83ecbe26d0', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:35', '2026-08-18 22:50:35', NULL),
('8c8f3239-c155-4331-80b8-93049b9b6572', '52500', 'Biaya Pengiriman', '0d292bff-c890-4ec0-b139-cf21b197590c', '3', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:34', '2026-08-18 22:50:34', NULL),
('8fe72dd8-27ab-4832-acf1-c93416d508c6', '52014', 'Biaya Komunikasi', '0d292bff-c890-4ec0-b139-cf21b197590c', '3', '14', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:34', '2026-08-18 22:50:34', NULL),
('91eb0cc0-ef76-4958-9e2e-2b39ea5a2e10', '43100', 'Pendapatan Bunga Bank', 'dfee0d86-5bea-419d-ad5a-bbecb729390b', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:33', '2026-08-18 22:50:33', NULL),
('9342d566-780a-4e18-af89-53526ba9c4d5', '11820', 'PPh Dibayar Dimuka', '7982e02f-5bea-46dd-989d-5d043d4c9ac8', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:31', '2026-08-18 22:50:31', NULL),
('9485e07f-9a69-4358-bf92-3db47566634e', '56000', 'Biaya Pengembangan SDM', '02ab1587-1178-4318-a11a-75602883cb8e', '2', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:35', '2026-08-18 22:50:35', NULL),
('97c9a8ae-4591-4d13-af7c-816bd3933278', '59200', 'Biaya Bunga Bank', '4eccd469-b5e3-49a4-a5c8-e38935bb4aaa', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:36', '2026-08-18 22:50:36', NULL),
('98b1126e-e4d4-4ef6-baf1-5a9476ee96b1', '53300', 'Depresiasi Meubel', 'c37423f6-c3c3-46ef-9d0b-be58f8023e0d', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:34', '2026-08-18 22:50:34', NULL),
('9a673591-b201-41c1-9b3f-8e094d3f2708', '51005', 'Tunjangan', '0f35d3fb-1d8e-4c26-b389-3529db99acf4', '3', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:34', '2026-08-18 22:50:34', NULL),
('9b702b8d-0aee-4a5d-a7a6-14c86f698c9d', '31300', 'Selisih Lebih/Kurang', 'e65b1569-6e31-4cf3-8af2-2a9eb9764ffc', '2', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567892', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:32', '2026-08-18 22:50:32', NULL),
('9d444492-1a3b-478c-a3e2-8cdfd9ea13f0', '44001', 'Kerjasama Internal', '0b7edae5-2603-4fca-b0b4-021958ce2007', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:33', '2026-08-18 22:50:33', NULL),
('9e17057b-c02b-411a-a70b-161c809a7814', '12500', 'Peralatan Kantor', 'cbb43cce-4240-4816-878b-589ed0dc3077', '2', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:32', '2026-08-18 22:50:32', NULL),
('a999a49a-aced-46f1-9919-c763527b35cb', '12600', 'Investasi Jangka Panjang', 'cbb43cce-4240-4816-878b-589ed0dc3077', '2', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:32', '2026-08-18 22:50:32', NULL),
('acef7df7-0747-4fea-a62b-994741b214a4', '57203', 'Biaya Program Majelis Kesehatan', '7d9cf22a-4943-474a-929a-3bb5a38cc8ad', '4', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:35', '2026-08-18 22:50:35', NULL),
('af74906a-54f3-457c-aef4-653ea224d82f', '58200', 'Dana Sehat Muhammadiyah', '4120d48b-9edd-4c50-a3fa-61479eefd67c', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:36', '2026-08-18 22:50:36', NULL),
('b12c01c4-7a23-4354-bb59-6245f0411fce', '44004', 'Pendapatan Pembangunan ATC', '0b7edae5-2603-4fca-b0b4-021958ce2007', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:33', '2026-08-18 22:50:33', NULL),
('b24b3143-ae78-43d0-9fc5-8ed975177c00', '52900', 'Biaya Pemeliharaan Meubel', '0d292bff-c890-4ec0-b139-cf21b197590c', '3', '9', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:34', '2026-08-18 22:50:34', NULL),
('b6ad160b-67be-4b70-9715-d9d454d28b87', '51004', 'Uang Makan Karyawan & Staf', '0f35d3fb-1d8e-4c26-b389-3529db99acf4', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:33', '2026-08-18 22:50:33', NULL),
('b84a4e4a-de13-421b-8a18-2ef75e319e9f', '57210', 'Biaya Program Lingkungan Hidup dan Penanggulangan Bencana', '7d9cf22a-4943-474a-929a-3bb5a38cc8ad', '4', '10', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:36', '2026-08-18 22:50:36', NULL),
('b87a0e99-f1eb-47d9-a336-8f7248f6a07d', '52100', 'Biaya Kertas & ATK', '0d292bff-c890-4ec0-b139-cf21b197590c', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:34', '2026-08-18 22:50:34', NULL),
('bc84941c-dca5-483d-af26-f3254854ffaa', '41300', 'Zakat Infaq Shadaqoh Organisasi', '549eacd3-d424-455c-bbad-3017fbc3dee1', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:32', '2026-08-18 22:50:32', NULL),
('be57ddf7-3177-4d16-bb22-db567be94f18', '12300', 'Kendaraan', 'cbb43cce-4240-4816-878b-589ed0dc3077', '2', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:31', '2026-08-18 22:50:31', NULL),
('c37423f6-c3c3-46ef-9d0b-be58f8023e0d', '53000', 'Biaya Depresiasi Aset Tetap', '02ab1587-1178-4318-a11a-75602883cb8e', '2', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:34', '2026-08-18 22:50:34', NULL),
('c4af4f99-70dd-489a-a8e9-eff69a44a6aa', '57202', 'Biaya Program Pendidikan Anak Usia Dini, Dasar dan Menengah', '7d9cf22a-4943-474a-929a-3bb5a38cc8ad', '4', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:35', '2026-08-18 22:50:35', NULL),
('c5673400-d772-475d-8c68-d5998a0169bb', '55300', 'Biaya Akomodasi', 'de8a8b26-903f-4883-8614-2c83ecbe26d0', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:35', '2026-08-18 22:50:35', NULL),
('c5b99c5f-5885-4ef9-bae3-ab1811e502af', '12410', 'Akumulasi Depresiasi Meubel', '48fb488e-f265-467a-afb7-a12aded626aa', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:31', '2026-08-18 22:50:31', NULL),
('c5f9d6cb-10ca-4370-a314-68bfb0e298c4', '57600', 'Biaya operasional ATC', 'cf6abddb-c37d-4d09-81e1-d7e1b228c295', '3', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:36', '2026-08-18 22:50:36', NULL),
('c668d8cc-2178-49df-90f0-f56826239046', '52800', 'Biaya Asuransi kendaraan', '0d292bff-c890-4ec0-b139-cf21b197590c', '3', '8', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:34', '2026-08-18 22:50:34', NULL),
('c80409d4-830c-4ce7-a5c4-b83e8926e973', '42100', 'Kontribusi Bidang Pendidikan', '736666f9-64f2-44c2-807e-029286aea71e', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:33', '2026-08-18 22:50:33', NULL),
('c82ea824-81ca-4c12-ac14-c068c0ab5d9b', '41600', 'Simpanan Wajib Peserta', '549eacd3-d424-455c-bbad-3017fbc3dee1', '3', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:33', '2026-08-18 22:50:33', NULL),
('c87fb4be-060a-407a-872c-b616be2efaa2', '57201', 'Biaya Program Majelis Tablig dan Ketarjihan', '7d9cf22a-4943-474a-929a-3bb5a38cc8ad', '4', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:35', '2026-08-18 22:50:35', NULL),
('cb69c482-8711-4de6-94ca-e600b799ce23', '51003', 'Insentif Lembur Karyawan & Staf', '0f35d3fb-1d8e-4c26-b389-3529db99acf4', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:33', '2026-08-18 22:50:33', NULL),
('cbb1aca6-0387-43c1-a405-56ec63f1c6ae', '57205', 'Biaya Program Pimbinaan Kader', '7d9cf22a-4943-474a-929a-3bb5a38cc8ad', '4', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:35', '2026-08-18 22:50:35', NULL),
('cbb43cce-4240-4816-878b-589ed0dc3077', '12000', 'Aset Tidak Lancar', NULL, '1', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:31', '2026-08-18 22:50:31', NULL),
('cdec27f0-78ef-4fc2-9a96-bc945f117791', '54400', 'Biaya Sidang Muktamar', 'e19a840d-61dd-4181-9b47-0a57c51a1821', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:35', '2026-08-18 22:50:35', NULL),
('cf6abddb-c37d-4d09-81e1-d7e1b228c295', '57000', 'Biaya Program Organisasi', '02ab1587-1178-4318-a11a-75602883cb8e', '2', '7', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:35', '2026-08-18 22:50:35', NULL),
('d12af9b7-18fa-4a91-a81e-1de189c7a09b', '42200', 'Kontribusi Bidang Kesehatan', '736666f9-64f2-44c2-807e-029286aea71e', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:33', '2026-08-18 22:50:33', NULL),
('d1907d49-c67d-4999-a52e-22d97f18fad8', '41100', 'Iuran Anggota', '549eacd3-d424-455c-bbad-3017fbc3dee1', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:32', '2026-08-18 22:50:32', NULL),
('d2690199-e933-4880-af1b-06ba9e4c6b18', '11500', 'Penyertaan Modal Bueka Assakinah', '358657c6-fe73-408d-8349-8bc351f14284', '2', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:31', '2026-08-18 22:50:31', NULL),
('d52fe69c-0b3b-406f-8cdc-1812ca512215', '11600', 'Tabungan Bueka Assakinah', '358657c6-fe73-408d-8349-8bc351f14284', '2', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:31', '2026-08-18 22:50:31', NULL),
('d6e9f819-a18e-4b49-9c10-10dfe6cd6a8c', '55200', 'Biaya Transport Lokal', 'de8a8b26-903f-4883-8614-2c83ecbe26d0', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:35', '2026-08-18 22:50:35', NULL),
('d89f9a7e-e0eb-46f3-bfbc-70ca499da04a', '59999', 'Biaya Sosial & Lainnya', '02ab1587-1178-4318-a11a-75602883cb8e', '2', '10', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:36', '2026-08-18 22:50:36', NULL),
('d90b19b1-3c9c-420e-a079-c10e535bba48', '12210', 'Akumulasi Depresiasi Gedung', 'd94af1de-9674-413c-9baf-5a576e5ce8de', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:31', '2026-08-18 22:50:31', NULL),
('d91ad3f1-fb77-46a3-b2d3-be14bf2ff54c', '43200', 'Pendapatan Deposito', 'dfee0d86-5bea-419d-ad5a-bbecb729390b', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:33', '2026-08-18 22:50:33', NULL),
('d94978bc-67db-4300-96ff-8b967e5ce310', '57209', 'Biaya Program Penelitian dan Pengembangan Aisyiyah', '7d9cf22a-4943-474a-929a-3bb5a38cc8ad', '4', '9', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:35', '2026-08-18 22:50:35', NULL),
('d94af1de-9674-413c-9baf-5a576e5ce8de', '12200', 'Gedung', 'cbb43cce-4240-4816-878b-589ed0dc3077', '2', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:31', '2026-08-18 22:50:31', NULL),
('da37758a-5eeb-4c7a-b8c3-e4367b1a2afb', '52400', 'Biaya Cetak-Cetak', '0d292bff-c890-4ec0-b139-cf21b197590c', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:34', '2026-08-18 22:50:34', NULL),
('daa8f720-1d51-409c-b7b3-94263106e07a', '51001', 'Biaya Gaji Karyawan & Staf', '0f35d3fb-1d8e-4c26-b389-3529db99acf4', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:33', '2026-08-18 22:50:33', NULL),
('db66ea52-c674-4391-8ee9-fba767760767', '57300', 'Biaya kehumasan', 'cf6abddb-c37d-4d09-81e1-d7e1b228c295', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:36', '2026-08-18 22:50:36', NULL),
('dbd1086c-0b8e-470b-a22d-9d0c79043f71', '11200', 'Kas Bon', '358657c6-fe73-408d-8349-8bc351f14284', '2', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:31', '2026-08-18 22:50:31', NULL),
('de8a8b26-903f-4883-8614-2c83ecbe26d0', '55000', 'Biaya Perjalanan Dinas', '02ab1587-1178-4318-a11a-75602883cb8e', '2', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:35', '2026-08-18 22:50:35', NULL),
('dfee0d86-5bea-419d-ad5a-bbecb729390b', '43000', 'Pendapatan Jasa Bank (Neto)', 'ee37a3ca-1bf9-4893-a8d9-b2e09ca9bd56', '2', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:33', '2026-08-18 22:50:33', NULL),
('e19a840d-61dd-4181-9b47-0a57c51a1821', '54000', 'Biaya Persidangan', '02ab1587-1178-4318-a11a-75602883cb8e', '2', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:34', '2026-08-18 22:50:34', NULL),
('e65b1569-6e31-4cf3-8af2-2a9eb9764ffc', '31000', 'Aset Bersih', NULL, '1', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567892', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:32', '2026-08-18 22:50:32', NULL),
('e6a020c7-916e-47b9-9242-e1cfc39fc42e', '31200', 'Modal Lancar', 'e65b1569-6e31-4cf3-8af2-2a9eb9764ffc', '2', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567892', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:32', '2026-08-18 22:50:32', NULL),
('e75bab17-8991-4660-af18-ebf9b11fc095', '22300', 'Hutang PPh 23', '37c8c7c4-950a-46a2-9463-0c7a3a7cbd7b', '2', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567891', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:32', '2026-08-18 22:50:32', NULL),
('e7c0fdee-1b90-4710-8c9b-863311d32483', '57206', 'Biaya Program Kesejahteraan Sosial', '7d9cf22a-4943-474a-929a-3bb5a38cc8ad', '4', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:35', '2026-08-18 22:50:35', NULL),
('eaf09243-7f2c-41fd-91e3-6bef669cb324', '57207', 'Biaya Program Majelis Hukum dan HAM', '7d9cf22a-4943-474a-929a-3bb5a38cc8ad', '4', '7', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:35', '2026-08-18 22:50:35', NULL),
('ee37a3ca-1bf9-4893-a8d9-b2e09ca9bd56', '40000', 'Pendapatan', NULL, '1', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:32', '2026-08-18 22:50:32', NULL),
('f2163dd2-fecf-4229-a070-b6a7442b0a76', '41500', 'Dana Bantuan Organisasi Lainnya', '549eacd3-d424-455c-bbad-3017fbc3dee1', '3', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:32', '2026-08-18 22:50:32', NULL),
('f5ccdc40-707b-4fd7-9497-c521948ca5c2', '52010', 'Biaya Pemeliharaan Peralatan Kantor', '0d292bff-c890-4ec0-b139-cf21b197590c', '3', '10', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:34', '2026-08-18 22:50:34', NULL),
('f82ac0a5-b12a-4ab7-a4da-736b28e72e73', '58300', 'Hadiah', '4120d48b-9edd-4c50-a3fa-61479eefd67c', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:36', '2026-08-18 22:50:36', NULL),
('f925f86d-1abc-45e8-bfdf-307da2bdcd07', '44005', 'Pendapatan Inklusi', '0b7edae5-2603-4fca-b0b4-021958ce2007', '3', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:33', '2026-08-18 22:50:33', NULL),
('fb153c81-faad-4e93-9dab-88b252bdcb0f', '42300', 'Kontribusi Bidang Ekonomi', '736666f9-64f2-44c2-807e-029286aea71e', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-08-18 22:50:33', '2026-08-18 22:50:33', NULL),
('fba8d3b2-2881-4843-b623-d6d41f77c06f', '52300', 'Biaya surat kabar & langganan Media', '0d292bff-c890-4ec0-b139-cf21b197590c', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:34', '2026-08-18 22:50:34', NULL),
('fbbbf9d7-a082-4cb6-8384-2e9c709f7d69', '12310', 'Akumulasi Depresiasi Kendaraan', 'be57ddf7-3177-4d16-bb22-db567be94f18', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:31', '2026-08-18 22:50:31', NULL),
('febca83f-c650-4c54-a6cf-0d06a9301c08', '55100', 'Biaya Tiket', 'de8a8b26-903f-4883-8614-2c83ecbe26d0', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-08-18 22:50:35', '2026-08-18 22:50:35', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `closing_balances`
--

CREATE TABLE `closing_balances` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `period_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_period_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `chart_of_account_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `balance_type` enum('DEBIT','CREDIT') COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `closing_balances`
--

INSERT INTO `closing_balances` (`id`, `period_id`, `sub_period_id`, `chart_of_account_id`, `created_by`, `balance_type`, `amount`, `created_at`, `updated_at`) VALUES
('01a018cc-8ba9-727a-8499-2ec09347e396', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', '08e15b4f-473b-4440-a706-d4c5a27a063b', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'DEBIT', 194604157.00, '2026-08-18 23:54:13', '2026-08-18 23:54:13'),
('01a018cc-8baf-72e0-84e3-7094d689e8c3', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', '428e0a5c-05eb-4705-b2a6-4333f44318c2', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'DEBIT', 4983047.00, '2026-08-18 23:54:13', '2026-08-18 23:54:13'),
('01a018cc-8bb4-704a-b385-92a22643b760', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', '42ca2ce5-a3e0-4900-a0d8-6d741e9e0c68', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'DEBIT', 405484747.00, '2026-08-18 23:54:13', '2026-08-18 23:54:13'),
('01a018cc-8bb6-73a6-b523-acf2dc0701b1', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', '4ec4e235-c953-4aa3-b0bd-3e4a6fa61998', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'DEBIT', 1156982563.00, '2026-08-18 23:54:13', '2026-08-18 23:54:13'),
('01a018cc-8bb8-73fb-bb81-a8fe81b3bb59', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', '2a983594-0762-4d4b-94fe-31dae7c954aa', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'DEBIT', 377940865.00, '2026-08-18 23:54:13', '2026-08-18 23:54:13'),
('01a018cc-8bb9-7191-a6c8-45828d1d430b', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', '07c833c4-2d25-46eb-919e-1daa18d37932', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'DEBIT', 1800000.00, '2026-08-18 23:54:13', '2026-08-18 23:54:13'),
('01a018cc-8bbb-714c-abcd-ec8033b08b11', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', '497ec733-26b1-41de-be5e-7ca327307bbb', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'DEBIT', 921735276.00, '2026-08-18 23:54:13', '2026-08-18 23:54:13'),
('01a018cc-8bbc-739c-909e-ed7e45de6543', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', 'be57ddf7-3177-4d16-bb22-db567be94f18', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'DEBIT', 460769432.00, '2026-08-18 23:54:13', '2026-08-18 23:54:13'),
('01a018cc-8bbe-71c9-bbbb-242512487c58', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', 'fbbbf9d7-a082-4cb6-8384-2e9c709f7d69', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'CREDIT', 144000000.00, '2026-08-18 23:54:13', '2026-08-18 23:54:13'),
('01a018cc-8bbf-72e5-8433-1e01634dc423', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', '48fb488e-f265-467a-afb7-a12aded626aa', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'DEBIT', 15500000.00, '2026-08-18 23:54:13', '2026-08-18 23:54:13'),
('01a018cc-8bc1-70b0-9d44-42a018da67f9', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', 'c5b99c5f-5885-4ef9-bae3-ab1811e502af', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'CREDIT', 13376668.00, '2026-08-18 23:54:13', '2026-08-18 23:54:13'),
('01a018cc-8bc2-7031-8a78-f0f043aad52c', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', '9e17057b-c02b-411a-a70b-161c809a7814', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'DEBIT', 46059000.00, '2026-08-18 23:54:13', '2026-08-18 23:54:13'),
('01a018cc-8bc5-7031-9119-47e4cd93e16d', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', '2f7209ea-c61c-44ac-a2fb-2fe4f4ad5942', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'CREDIT', 25236667.00, '2026-08-18 23:54:13', '2026-08-18 23:54:13'),
('01a018cc-8bc7-73c1-93ac-ff59321495e9', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', '60f843d0-b7d3-4d98-9899-dd5c42b867c3', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'CREDIT', 339715097.00, '2026-08-18 23:54:13', '2026-08-18 23:54:13'),
('01a018cc-8bc8-709f-967d-6f1d5489e539', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', 'e6a020c7-916e-47b9-9242-e1cfc39fc42e', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'CREDIT', 368679944.00, '2026-08-18 23:54:13', '2026-08-18 23:54:13'),
('01a018cc-8bca-7019-8854-8f23dfa1dd31', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', '9b702b8d-0aee-4a5d-a7a6-14c86f698c9d', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'CREDIT', 2694850711.00, '2026-08-18 23:54:13', '2026-08-18 23:54:13');

-- --------------------------------------------------------

--
-- Struktur dari tabel `coa_balances`
--

CREATE TABLE `coa_balances` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `chart_of_account_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `period_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_period_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
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
('01a018c0-a49a-70a6-908a-7a23b5db0a15', '08e15b4f-473b-4440-a706-d4c5a27a063b', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', 194604157.00, 0.00, 0.00, 194604157.00, '2026-08-18 23:41:13', NULL, '2026-08-18 23:41:13', '2026-08-18 23:41:13'),
('01a018c1-322a-70be-9a5f-bf4f8bf766e5', '428e0a5c-05eb-4705-b2a6-4333f44318c2', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', 4983047.00, 0.00, 0.00, 0.00, '2026-08-18 23:41:49', NULL, '2026-08-18 23:41:49', '2026-08-19 00:25:12'),
('01a018c1-a647-73a5-b6dc-3062282dd820', '42ca2ce5-a3e0-4900-a0d8-6d741e9e0c68', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', 405484747.00, 0.00, 0.00, 405484747.00, '2026-08-18 23:42:19', NULL, '2026-08-18 23:42:19', '2026-08-18 23:42:19'),
('01a018c2-218d-733a-a32d-0cf69d319f58', '4ec4e235-c953-4aa3-b0bd-3e4a6fa61998', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', 1156982563.00, 0.00, 0.00, 1156982563.00, '2026-08-18 23:42:50', NULL, '2026-08-18 23:42:50', '2026-08-18 23:42:50'),
('01a018c2-9593-73f0-bf27-5294a36142de', '2a983594-0762-4d4b-94fe-31dae7c954aa', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', 377940865.00, 0.00, 0.00, 377940865.00, '2026-08-18 23:43:20', NULL, '2026-08-18 23:43:20', '2026-08-18 23:43:20'),
('01a018c3-0a31-726c-8263-f3d392c2980c', '07c833c4-2d25-46eb-919e-1daa18d37932', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', 1800000.00, 0.00, 0.00, 1800000.00, '2026-08-18 23:43:50', NULL, '2026-08-18 23:43:50', '2026-08-18 23:43:50'),
('01a018c3-716f-7057-bd53-92514ac78e9c', '497ec733-26b1-41de-be5e-7ca327307bbb', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', 921735276.00, 0.00, 0.00, 921735276.00, '2026-08-18 23:44:16', NULL, '2026-08-18 23:44:16', '2026-08-18 23:44:16'),
('01a018c4-1c50-72d2-a007-dde091c87bad', 'be57ddf7-3177-4d16-bb22-db567be94f18', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', 460769432.00, 0.00, 0.00, 460769432.00, '2026-08-18 23:45:00', NULL, '2026-08-18 23:45:00', '2026-08-18 23:45:00'),
('01a018c4-9c18-7352-8557-408a66ffa6e0', 'fbbbf9d7-a082-4cb6-8384-2e9c709f7d69', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', 144000000.00, 0.00, 0.00, 144000000.00, '2026-08-18 23:45:33', NULL, '2026-08-18 23:45:33', '2026-08-18 23:45:33'),
('01a018c5-0487-7060-bc9c-56c0ad65d184', '48fb488e-f265-467a-afb7-a12aded626aa', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', 15500000.00, 0.00, 0.00, 15500000.00, '2026-08-18 23:46:00', NULL, '2026-08-18 23:46:00', '2026-08-18 23:46:00'),
('01a018c5-761a-720e-94f6-fbfffe6838ff', 'c5b99c5f-5885-4ef9-bae3-ab1811e502af', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', 13376668.00, 0.00, 0.00, 13376668.00, '2026-08-18 23:46:29', NULL, '2026-08-18 23:46:29', '2026-08-18 23:46:29'),
('01a018c5-e22c-73c2-ba1e-57e61b8842ea', '9e17057b-c02b-411a-a70b-161c809a7814', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', 46059000.00, 0.00, 0.00, 46059000.00, '2026-08-18 23:46:56', NULL, '2026-08-18 23:46:56', '2026-08-18 23:46:56'),
('01a018c6-5079-70e8-be60-9463bd479b90', '2f7209ea-c61c-44ac-a2fb-2fe4f4ad5942', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', 25236667.00, 0.00, 0.00, 25236667.00, '2026-08-18 23:47:25', NULL, '2026-08-18 23:47:25', '2026-08-18 23:47:25'),
('01a018c6-c5ab-707e-8485-dc2bf19fc88a', '60f843d0-b7d3-4d98-9899-dd5c42b867c3', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', 339715097.00, 0.00, 0.00, 339715097.00, '2026-08-18 23:47:55', NULL, '2026-08-18 23:47:55', '2026-08-18 23:47:55'),
('01a018c7-3384-7000-a3f3-f0ba7fda75a4', 'e6a020c7-916e-47b9-9242-e1cfc39fc42e', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', 368679944.00, 0.00, 0.00, 368679944.00, '2026-08-18 23:48:23', NULL, '2026-08-18 23:48:23', '2026-08-18 23:48:23'),
('01a018cb-1473-71b6-9e4c-56484133d239', '9b702b8d-0aee-4a5d-a7a6-14c86f698c9d', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', 2694850711.00, 0.00, 0.00, 2694850711.00, '2026-08-18 23:52:37', NULL, '2026-08-18 23:52:37', '2026-08-18 23:52:37'),
('01a018cd-4f8a-700a-b7a5-533ab2268aa3', '08e15b4f-473b-4440-a706-d4c5a27a063b', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', 194604157.00, 0.00, 0.00, 194604157.00, '2026-08-18 23:55:03', NULL, '2026-08-18 23:55:03', '2026-08-18 23:55:03'),
('01a018cd-90e2-7311-98fc-499c09d7ab2a', '428e0a5c-05eb-4705-b2a6-4333f44318c2', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', 4983047.00, 0.00, 0.00, 4983047.00, '2026-08-18 23:55:20', NULL, '2026-08-18 23:55:20', '2026-08-18 23:55:20'),
('01a018cd-e3c7-7258-94b9-40b7523267dd', '42ca2ce5-a3e0-4900-a0d8-6d741e9e0c68', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', 405484747.00, 0.00, 0.00, 405484747.00, '2026-08-18 23:55:41', NULL, '2026-08-18 23:55:41', '2026-08-18 23:55:41'),
('01a018ce-2850-7262-83b0-68f510a8339b', '4ec4e235-c953-4aa3-b0bd-3e4a6fa61998', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', 1156982563.00, 0.00, 0.00, 1156982563.00, '2026-08-18 23:55:59', NULL, '2026-08-18 23:55:59', '2026-08-18 23:55:59'),
('01a018ce-5f3b-73f6-9ef5-bd090d919196', '2a983594-0762-4d4b-94fe-31dae7c954aa', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', 377940865.00, 0.00, 0.00, 377940865.00, '2026-08-18 23:56:13', NULL, '2026-08-18 23:56:13', '2026-08-18 23:56:13'),
('01a018ce-994c-7234-b943-23667964f982', '07c833c4-2d25-46eb-919e-1daa18d37932', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', 1800000.00, 0.00, 0.00, 1800000.00, '2026-08-18 23:56:27', NULL, '2026-08-18 23:56:27', '2026-08-18 23:56:27'),
('01a018ce-d691-72b0-aae7-d0c62e4e2c10', '497ec733-26b1-41de-be5e-7ca327307bbb', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', 921735276.00, 0.00, 0.00, 921735276.00, '2026-08-18 23:56:43', NULL, '2026-08-18 23:56:43', '2026-08-18 23:56:43'),
('01a018cf-2b56-7251-aa1c-b0027f2dda45', 'be57ddf7-3177-4d16-bb22-db567be94f18', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', 460769432.00, 0.00, 0.00, 460769432.00, '2026-08-18 23:57:05', NULL, '2026-08-18 23:57:05', '2026-08-18 23:57:05'),
('01a018cf-75be-73f9-8968-5124d45b3b96', 'fbbbf9d7-a082-4cb6-8384-2e9c709f7d69', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', 144000000.00, 0.00, 0.00, 144000000.00, '2026-08-18 23:57:24', NULL, '2026-08-18 23:57:24', '2026-08-18 23:57:24'),
('01a018cf-bdae-70d3-b33f-98a6617c3571', '48fb488e-f265-467a-afb7-a12aded626aa', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', 15500000.00, 0.00, 0.00, 15500000.00, '2026-08-18 23:57:42', NULL, '2026-08-18 23:57:42', '2026-08-18 23:57:42'),
('01a018d0-0ad0-7015-bbfb-c2ab9be6d65a', 'c5b99c5f-5885-4ef9-bae3-ab1811e502af', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', 13376668.00, 0.00, 0.00, 13376668.00, '2026-08-18 23:58:02', NULL, '2026-08-18 23:58:02', '2026-08-18 23:58:02'),
('01a018d2-bae0-7156-baca-3a7590d49374', '9e17057b-c02b-411a-a70b-161c809a7814', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', 46059000.00, 0.00, 0.00, 46059000.00, '2026-08-19 00:00:58', NULL, '2026-08-19 00:00:58', '2026-08-19 00:00:58'),
('01a018d2-fb1d-71e8-8940-ec8a7999a4bb', '2f7209ea-c61c-44ac-a2fb-2fe4f4ad5942', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', 25236667.00, 0.00, 0.00, 25236667.00, '2026-08-19 00:01:15', NULL, '2026-08-19 00:01:15', '2026-08-19 00:01:15'),
('01a018d3-6d73-7225-ab2c-7efdd403f17d', '60f843d0-b7d3-4d98-9899-dd5c42b867c3', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', 339715097.00, 0.00, 0.00, 339715097.00, '2026-08-19 00:01:44', NULL, '2026-08-19 00:01:44', '2026-08-19 00:01:44'),
('01a018d3-cb2b-71ab-bc50-3f220e907e01', 'e6a020c7-916e-47b9-9242-e1cfc39fc42e', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', 368679944.00, 0.00, 0.00, 368679944.00, '2026-08-19 00:02:08', NULL, '2026-08-19 00:02:08', '2026-08-19 00:02:08'),
('01a018d4-0187-7268-a5a9-481908f2211b', '9b702b8d-0aee-4a5d-a7a6-14c86f698c9d', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', 2694850711.00, 0.00, 0.00, 2694850711.00, '2026-08-19 00:02:22', NULL, '2026-08-19 00:02:22', '2026-08-19 00:02:22');

-- --------------------------------------------------------

--
-- Struktur dari tabel `coa_requests`
--

CREATE TABLE `coa_requests` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `requester_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `approver_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_coa_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_type_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_period_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `proposed_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `proposed_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `normal_balance` enum('DEBIT','CREDIT') COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('pending','approved','rejected','canceled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `description` text COLLATE utf8mb4_unicode_ci,
  `approved_at` timestamp NULL DEFAULT NULL,
  `approval_notes` text COLLATE utf8mb4_unicode_ci,
  `rejected_at` timestamp NULL DEFAULT NULL,
  `rejection_reason` text COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `configurations`
--

CREATE TABLE `configurations` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `type` enum('string','integer','boolean','array','json','image') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'string',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `configurations`
--

INSERT INTO `configurations` (`id`, `key`, `value`, `type`, `description`, `is_active`, `created_at`, `updated_at`) VALUES
('01a01892-0968-7009-9eb6-0eb7d02474dc', 'APP_NAME', 'My Laravel App', 'string', 'Nama aplikasi yang akan ditampilkan di berbagai tempat seperti judul halaman.', 1, '2026-08-18 22:50:19', '2026-08-18 22:50:19'),
('01a01892-0a92-72db-b731-c1c2e93edf56', 'APP_DESCRIPTION', 'Sistem Informasi Akuntansi untuk pengelolaan keuangan, jurnal, dan laporan secara terintegrasi.', 'string', 'Deskripsi singkat tentang aplikasi yang dapat digunakan untuk SEO atau ditampilkan di halaman utama.', 1, '2026-08-18 22:50:19', '2026-08-18 22:50:19'),
('01a01892-0aaf-7171-a0b5-eca28708d6fd', 'APP_TAGLINE', 'Sistem Informasi Akuntansi untuk pengelolaan keuangan, jurnal, dan laporan secara terintegrasi.', 'string', 'Tagline atau slogan yang menggambarkan nilai utama aplikasi.', 1, '2026-08-18 22:50:19', '2026-08-18 22:50:19'),
('01a01892-0acb-715e-aaf5-6b22a8c6d145', 'APP_LOGO', NULL, 'image', 'Logo aplikasi yang akan ditampilkan di header atau halaman login.', 1, '2026-08-18 22:50:19', '2026-08-18 22:50:19'),
('01a01892-0ae6-71ac-a9ad-c91af511db4f', 'APP_BACKGROUND_LOGIN', NULL, 'image', 'Gambar latar belakang untuk halaman login aplikasi.', 1, '2026-08-18 22:50:19', '2026-08-18 22:50:19');

-- --------------------------------------------------------

--
-- Struktur dari tabel `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `journals`
--

CREATE TABLE `journals` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `journal_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `journal_date` date NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `total_debit` decimal(15,2) NOT NULL,
  `total_credit` decimal(15,2) NOT NULL,
  `posted_by` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `posted_at` datetime DEFAULT NULL,
  `period_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_period_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `journals`
--

INSERT INTO `journals` (`id`, `journal_number`, `journal_date`, `description`, `total_debit`, `total_credit`, `posted_by`, `posted_at`, `period_id`, `sub_period_id`, `transaction_id`, `created_at`, `updated_at`) VALUES
('01a018e8-e8b9-7172-88d7-9def55aa8f3c', 'JRN-20260819072512', '2026-08-19', 'Pembagian saldo ke pengguna', 4983047.00, 4983047.00, '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '2026-08-19 07:25:12', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', NULL, '2026-08-19 00:25:12', '2026-08-19 00:25:12'),
('01a018ea-271c-70b8-8dc8-99e3814f49b3', 'JR-EXP-20260819072633', '2023-01-01', 'Transfer Parkir + Biaya', 402500.00, 402500.00, '01a01892-33c9-721a-a9c3-32de766115f7', '2026-08-19 07:26:33', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', '01a018ea-270f-729b-bf6d-1e3abb3d62ec', '2026-08-19 00:26:33', '2026-08-19 00:26:33');

-- --------------------------------------------------------

--
-- Struktur dari tabel `journal_details`
--

CREATE TABLE `journal_details` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `journal_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `chart_of_account_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `debit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `credit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `journal_details`
--

INSERT INTO `journal_details` (`id`, `journal_id`, `chart_of_account_id`, `debit`, `credit`, `description`, `created_at`, `updated_at`) VALUES
('01a018e8-e8bc-71d4-a33d-0c05797ff508', '01a018e8-e8b9-7172-88d7-9def55aa8f3c', '428e0a5c-05eb-4705-b2a6-4333f44318c2', 4983047.00, 0.00, 'Distribusi saldo ke user', '2026-08-19 00:25:12', '2026-08-19 00:25:12'),
('01a018e8-e8bd-7174-a183-dbc78ec3f673', '01a018e8-e8b9-7172-88d7-9def55aa8f3c', '428e0a5c-05eb-4705-b2a6-4333f44318c2', 0.00, 4983047.00, 'Pengurangan saldo akun', '2026-08-19 00:25:12', '2026-08-19 00:25:12'),
('01a018ea-271f-71d0-b1b0-ca23efe5414b', '01a018ea-271c-70b8-8dc8-99e3814f49b3', '1f4aee8e-7929-4596-afab-9275a64353bc', 402500.00, 0.00, 'Biaya Parkir Pengeluaran', '2026-08-19 00:26:33', '2026-08-19 00:26:33'),
('01a018ea-2722-7298-87a0-3ac681360d6d', '01a018ea-271c-70b8-8dc8-99e3814f49b3', '428e0a5c-05eb-4705-b2a6-4333f44318c2', 0.00, 402500.00, 'Kas Ditangan Kas Keluar', '2026-08-19 00:26:33', '2026-08-19 00:26:33');

-- --------------------------------------------------------

--
-- Struktur dari tabel `media`
--

CREATE TABLE `media` (
  `id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `collection_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mime_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disk` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `conversions_disk` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` bigint UNSIGNED NOT NULL,
  `manipulations` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `custom_properties` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `generated_conversions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `responsive_images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `order_column` int UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
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
(25, '2026_08_30_162544_add_income_balance_to_user_account_balances_table', 2);

-- --------------------------------------------------------

--
-- Struktur dari tabel `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
('01a01892-1593-712f-9034-f9606f7fa6e6', 'App\\Models\\User', '01a01892-2d8a-7167-9948-d09930cc5511'),
('01a01892-1ba9-706a-9d0a-5d3e82acdbe3', 'App\\Models\\User', '01a01892-30ab-7337-8cb2-5ce8dac14b8a'),
('01a01892-22b5-7024-90c3-7fc631576c62', 'App\\Models\\User', '01a01892-30ab-7337-8cb2-5ce8dac14b8a'),
('01a01892-22b5-7024-90c3-7fc631576c62', 'App\\Models\\User', '01a01892-33c9-721a-a9c3-32de766115f7');

-- --------------------------------------------------------

--
-- Struktur dari tabel `opening_balances`
--

CREATE TABLE `opening_balances` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `chart_of_account_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `period_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_period_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `balance_type` enum('DEBIT','CREDIT') COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `is_correction` tinyint(1) NOT NULL DEFAULT '0',
  `correction_reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `opening_balances`
--

INSERT INTO `opening_balances` (`id`, `chart_of_account_id`, `period_id`, `sub_period_id`, `created_by`, `balance_type`, `amount`, `is_correction`, `correction_reason`, `created_at`, `updated_at`) VALUES
('01a018c0-a493-72b6-bc85-fdc005402033', '08e15b4f-473b-4440-a706-d4c5a27a063b', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'DEBIT', 194604157.00, 0, NULL, '2026-08-18 23:41:13', '2026-08-18 23:41:13'),
('01a018c1-3223-73ea-ba03-0c04339bbc12', '428e0a5c-05eb-4705-b2a6-4333f44318c2', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'DEBIT', 4983047.00, 0, NULL, '2026-08-18 23:41:49', '2026-08-18 23:41:49'),
('01a018c1-a641-72fb-97de-e810ffc1b3b0', '42ca2ce5-a3e0-4900-a0d8-6d741e9e0c68', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'DEBIT', 405484747.00, 0, NULL, '2026-08-18 23:42:19', '2026-08-18 23:42:19'),
('01a018c2-2187-73ba-91ed-753b8eb340a3', '4ec4e235-c953-4aa3-b0bd-3e4a6fa61998', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'DEBIT', 1156982563.00, 0, NULL, '2026-08-18 23:42:50', '2026-08-18 23:42:50'),
('01a018c2-958b-7005-b119-831b0d8ef620', '2a983594-0762-4d4b-94fe-31dae7c954aa', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'DEBIT', 377940865.00, 0, NULL, '2026-08-18 23:43:20', '2026-08-18 23:43:20'),
('01a018c3-0a2a-709e-9543-64f1c3f171d6', '07c833c4-2d25-46eb-919e-1daa18d37932', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'DEBIT', 1800000.00, 0, NULL, '2026-08-18 23:43:50', '2026-08-18 23:43:50'),
('01a018c3-716a-72ca-a9dc-1ad6a87fe2b8', '497ec733-26b1-41de-be5e-7ca327307bbb', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'DEBIT', 921735276.00, 0, NULL, '2026-08-18 23:44:16', '2026-08-18 23:44:16'),
('01a018c4-1c49-70f7-a0b8-d11c57f968bb', 'be57ddf7-3177-4d16-bb22-db567be94f18', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'DEBIT', 460769432.00, 0, NULL, '2026-08-18 23:45:00', '2026-08-18 23:45:00'),
('01a018c4-9c12-7290-b84b-d2fe3ec21c45', 'fbbbf9d7-a082-4cb6-8384-2e9c709f7d69', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'CREDIT', 144000000.00, 0, NULL, '2026-08-18 23:45:33', '2026-08-18 23:45:33'),
('01a018c5-0480-71da-a118-b528f4a9ac56', '48fb488e-f265-467a-afb7-a12aded626aa', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'DEBIT', 15500000.00, 0, NULL, '2026-08-18 23:46:00', '2026-08-18 23:46:00'),
('01a018c5-7615-71fe-820c-17462291f080', 'c5b99c5f-5885-4ef9-bae3-ab1811e502af', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'CREDIT', 13376668.00, 0, NULL, '2026-08-18 23:46:29', '2026-08-18 23:46:29'),
('01a018c5-e225-71bf-9278-e1c648351e70', '9e17057b-c02b-411a-a70b-161c809a7814', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'DEBIT', 46059000.00, 0, NULL, '2026-08-18 23:46:56', '2026-08-18 23:46:56'),
('01a018c6-5073-7027-85f8-681d60077b76', '2f7209ea-c61c-44ac-a2fb-2fe4f4ad5942', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'CREDIT', 25236667.00, 0, NULL, '2026-08-18 23:47:25', '2026-08-18 23:47:25'),
('01a018c6-c5a5-72e1-86e7-36f7818e2c05', '60f843d0-b7d3-4d98-9899-dd5c42b867c3', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'CREDIT', 339715097.00, 0, NULL, '2026-08-18 23:47:55', '2026-08-18 23:47:55'),
('01a018c7-337c-7205-ab40-89b56e993833', 'e6a020c7-916e-47b9-9242-e1cfc39fc42e', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'CREDIT', 368679944.00, 0, NULL, '2026-08-18 23:48:23', '2026-08-18 23:48:23'),
('01a018cb-146b-71ea-aa78-ac42522d4487', '9b702b8d-0aee-4a5d-a7a6-14c86f698c9d', '01a01892-3475-73b3-b03a-e629fe98ebd5', '01a01892-3570-7042-bf44-b27971411a65', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'CREDIT', 2694850711.00, 0, NULL, '2026-08-18 23:52:37', '2026-08-18 23:52:37'),
('01a018cd-4f84-71b8-8f82-79d180fc6b7e', '08e15b4f-473b-4440-a706-d4c5a27a063b', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'DEBIT', 194604157.00, 0, NULL, '2026-08-18 23:55:03', '2026-08-18 23:55:03'),
('01a018cd-90da-71f0-b36e-0b6a56158dc5', '428e0a5c-05eb-4705-b2a6-4333f44318c2', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'DEBIT', 4983047.00, 0, NULL, '2026-08-18 23:55:20', '2026-08-18 23:55:20'),
('01a018cd-e3c2-718d-9a4f-f36e3469a078', '42ca2ce5-a3e0-4900-a0d8-6d741e9e0c68', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'DEBIT', 405484747.00, 0, NULL, '2026-08-18 23:55:41', '2026-08-18 23:55:41'),
('01a018ce-284a-705d-8cbc-19f0c7d905d2', '4ec4e235-c953-4aa3-b0bd-3e4a6fa61998', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'DEBIT', 1156982563.00, 0, NULL, '2026-08-18 23:55:59', '2026-08-18 23:55:59'),
('01a018ce-5f35-7261-8223-da57b3cce974', '2a983594-0762-4d4b-94fe-31dae7c954aa', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'DEBIT', 377940865.00, 0, NULL, '2026-08-18 23:56:13', '2026-08-18 23:56:13'),
('01a018ce-9946-7135-8c40-c0156301072c', '07c833c4-2d25-46eb-919e-1daa18d37932', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'DEBIT', 1800000.00, 0, NULL, '2026-08-18 23:56:27', '2026-08-18 23:56:27'),
('01a018ce-d68a-7163-b92e-f1546183398f', '497ec733-26b1-41de-be5e-7ca327307bbb', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'DEBIT', 921735276.00, 0, NULL, '2026-08-18 23:56:43', '2026-08-18 23:56:43'),
('01a018cf-2b50-7227-839b-38109838ff6f', 'be57ddf7-3177-4d16-bb22-db567be94f18', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'DEBIT', 460769432.00, 0, NULL, '2026-08-18 23:57:05', '2026-08-18 23:57:05'),
('01a018cf-75b8-71e5-bd72-c11d0cf37bbb', 'fbbbf9d7-a082-4cb6-8384-2e9c709f7d69', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'CREDIT', 144000000.00, 0, NULL, '2026-08-18 23:57:24', '2026-08-18 23:57:24'),
('01a018cf-bda8-72dc-b9af-e3c38fc8f98d', '48fb488e-f265-467a-afb7-a12aded626aa', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'DEBIT', 15500000.00, 0, NULL, '2026-08-18 23:57:42', '2026-08-18 23:57:42'),
('01a018d0-0ac9-7290-a6c6-070db43d204c', 'c5b99c5f-5885-4ef9-bae3-ab1811e502af', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'CREDIT', 13376668.00, 0, NULL, '2026-08-18 23:58:02', '2026-08-18 23:58:02'),
('01a018d2-bad7-71f2-95ce-3be1500dfd9a', '9e17057b-c02b-411a-a70b-161c809a7814', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'DEBIT', 46059000.00, 0, NULL, '2026-08-19 00:00:58', '2026-08-19 00:00:58'),
('01a018d2-fb17-700e-8273-d1c657e38616', '2f7209ea-c61c-44ac-a2fb-2fe4f4ad5942', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'CREDIT', 25236667.00, 0, NULL, '2026-08-19 00:01:15', '2026-08-19 00:01:15'),
('01a018d3-6d6d-7173-8e2d-0045a4275c43', '60f843d0-b7d3-4d98-9899-dd5c42b867c3', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'CREDIT', 339715097.00, 0, NULL, '2026-08-19 00:01:44', '2026-08-19 00:01:44'),
('01a018d3-cb25-709e-ac28-9ab0b4b3efad', 'e6a020c7-916e-47b9-9242-e1cfc39fc42e', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'CREDIT', 368679944.00, 0, NULL, '2026-08-19 00:02:08', '2026-08-19 00:02:08'),
('01a018d4-0181-715f-a9e1-82c5f9189faa', '9b702b8d-0aee-4a5d-a7a6-14c86f698c9d', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'CREDIT', 2694850711.00, 0, NULL, '2026-08-19 00:02:22', '2026-08-19 00:02:22');

-- --------------------------------------------------------

--
-- Struktur dari tabel `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `periods`
--

CREATE TABLE `periods` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `periods`
--

INSERT INTO `periods` (`id`, `name`, `description`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES
('01a01892-3475-73b3-b03a-e629fe98ebd5', '2022', 'Fiscal year 2022', '2022-01-01', '2022-12-31', '2026-08-18 22:50:30', '2026-08-18 22:50:30'),
('01a01892-358d-7241-9d2f-3e8b59a7ef11', '2023', 'Fiscal year 2023', '2023-01-01', '2023-12-31', '2026-08-18 22:50:30', '2026-08-18 22:50:30');

-- --------------------------------------------------------

--
-- Struktur dari tabel `permissions`
--

CREATE TABLE `permissions` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `group` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `group`, `description`, `is_default`, `created_at`, `updated_at`) VALUES
('01a01892-0ce7-73de-aeb3-761072cbf400', 'view dashboard superadmin', 'web', 'Dashboard', 'Akses dashboard superadmin', 1, '2026-08-18 22:50:19', '2026-08-18 22:50:19'),
('01a01892-0d36-72d0-aa24-3bd38a527b0d', 'view dashboard bendahara', 'web', 'Dashboard', 'Akses dashboard bendahara', 1, '2026-08-18 22:50:19', '2026-08-18 22:50:19'),
('01a01892-0d88-714d-9f33-0fb936bfbdf8', 'user view', 'web', 'User Management', 'Melihat data user', 1, '2026-08-18 22:50:20', '2026-08-18 22:50:20'),
('01a01892-0dda-73db-a009-8fd3a17222f1', 'user create', 'web', 'User Management', 'Membuat user baru', 1, '2026-08-18 22:50:20', '2026-08-18 22:50:20'),
('01a01892-0e25-70c0-8250-a8c1dcbabebc', 'user update', 'web', 'User Management', 'Mengubah data user', 1, '2026-08-18 22:50:20', '2026-08-18 22:50:20'),
('01a01892-0e80-7065-9371-379b7eb6bcbc', 'user delete', 'web', 'User Management', 'Menghapus user', 1, '2026-08-18 22:50:20', '2026-08-18 22:50:20'),
('01a01892-0edb-700a-93c6-53b2f219f03b', 'role view', 'web', 'Role & Permission', 'Melihat role', 1, '2026-08-18 22:50:20', '2026-08-18 22:50:20'),
('01a01892-0f06-71ca-8cd5-17dca7c70672', 'role create', 'web', 'Role & Permission', 'Membuat role', 1, '2026-08-18 22:50:20', '2026-08-18 22:50:20'),
('01a01892-0f28-7399-b3a0-ed2e9f9d8d46', 'role update', 'web', 'Role & Permission', 'Mengubah role', 1, '2026-08-18 22:50:20', '2026-08-18 22:50:20'),
('01a01892-0f48-7219-afcd-37981fdc18dc', 'role delete', 'web', 'Role & Permission', 'Menghapus role', 1, '2026-08-18 22:50:20', '2026-08-18 22:50:20'),
('01a01892-0f67-7150-b8b3-4ff408838a62', 'permission view', 'web', 'Role & Permission', 'Melihat permission', 1, '2026-08-18 22:50:20', '2026-08-18 22:50:20'),
('01a01892-0f86-72b3-87ea-c6dbc6183077', 'permission create', 'web', 'Role & Permission', 'Membuat permission', 1, '2026-08-18 22:50:20', '2026-08-18 22:50:20'),
('01a01892-0fa6-7354-950b-4b51e9b481b4', 'permission update', 'web', 'Role & Permission', 'Mengubah permission', 1, '2026-08-18 22:50:20', '2026-08-18 22:50:20'),
('01a01892-0fc4-7345-930a-000820bcc8c9', 'permission delete', 'web', 'Role & Permission', 'Menghapus permission', 1, '2026-08-18 22:50:20', '2026-08-18 22:50:20'),
('01a01892-0fed-711c-94df-29ae2aab3927', 'coa view', 'web', 'Master COA', 'Melihat chart of account', 1, '2026-08-18 22:50:20', '2026-08-18 22:50:20'),
('01a01892-1018-7091-91ed-7c980c7a810f', 'coa create', 'web', 'Master COA', 'Membuat akun COA', 1, '2026-08-18 22:50:20', '2026-08-18 22:50:20'),
('01a01892-1047-7393-b0b6-ae61c0748245', 'coa update', 'web', 'Master COA', 'Mengubah akun COA', 1, '2026-08-18 22:50:20', '2026-08-18 22:50:20'),
('01a01892-1073-71d7-8cae-0b041ccfb92c', 'coa delete', 'web', 'Master COA', 'Menghapus akun COA', 1, '2026-08-18 22:50:20', '2026-08-18 22:50:20'),
('01a01892-10a2-73e3-8d35-14c19641a615', 'coa import', 'web', 'Master COA', 'Import akun COA', 0, '2026-08-18 22:50:20', '2026-08-18 22:50:20'),
('01a01892-10cf-7285-8fdd-bb49937289f5', 'coa assign user', 'web', 'Master COA', 'Menambahkan user ke COA', 0, '2026-08-18 22:50:20', '2026-08-18 22:50:20'),
('01a01892-10fc-702c-ad73-ddb0cb89d28e', 'coa remove user', 'web', 'Master COA', 'Menghapus user dari COA', 0, '2026-08-18 22:50:20', '2026-08-18 22:50:20'),
('01a01892-1129-712c-b5aa-0d943fb1ef27', 'coa request create', 'web', 'Master COA', 'Request pembuatan akun COA', 0, '2026-08-18 22:50:20', '2026-08-18 22:50:20'),
('01a01892-1160-71bf-84b2-2ef51a921ea8', 'journal post', 'web', 'Transactions', 'Posting jurnal umum', 1, '2026-08-18 22:50:21', '2026-08-18 22:50:21'),
('01a01892-11ad-72fd-9a1e-e07a31fc8180', 'journal view', 'web', 'Transactions', 'Melihat jurnal umum', 1, '2026-08-18 22:50:21', '2026-08-18 22:50:21'),
('01a01892-11f9-73c6-8e7c-fea59287beda', 'transaction income create', 'web', 'Transactions', 'Input transaksi pemasukan', 1, '2026-08-18 22:50:21', '2026-08-18 22:50:21'),
('01a01892-1246-72d9-9e79-847d431f4f3a', 'transaction expense create', 'web', 'Transactions', 'Input transaksi pengeluaran', 1, '2026-08-18 22:50:21', '2026-08-18 22:50:21'),
('01a01892-129c-7170-aec2-81e5cdcafc16', 'transaction import', 'web', 'Transactions', 'Import transaksi', 0, '2026-08-18 22:50:21', '2026-08-18 22:50:21'),
('01a01892-12f5-7283-902b-1bafa890a71c', 'ledger create', 'web', 'Ledger', 'Generate buku besar', 1, '2026-08-18 22:50:21', '2026-08-18 22:50:21'),
('01a01892-1344-738b-824b-344dc220f7bb', 'ledger view', 'web', 'Ledger', 'Melihat buku besar', 1, '2026-08-18 22:50:21', '2026-08-18 22:50:21'),
('01a01892-138c-7314-8825-3ee4ad9a024e', 'ledger view by account', 'web', 'Ledger', 'Melihat buku besar per akun', 1, '2026-08-18 22:50:21', '2026-08-18 22:50:21'),
('01a01892-13d6-7357-969e-a028e829569d', 'report general journal view', 'web', 'Reports', 'Melihat laporan jurnal umum', 1, '2026-08-18 22:50:21', '2026-08-18 22:50:21'),
('01a01892-1414-70a9-a511-7938a91d41f9', 'report general journal export', 'web', 'Reports', 'Export laporan jurnal umum', 0, '2026-08-18 22:50:21', '2026-08-18 22:50:21'),
('01a01892-143c-712f-9afe-6976528a1014', 'report trial balance view', 'web', 'Reports', 'Melihat neraca saldo', 1, '2026-08-18 22:50:21', '2026-08-18 22:50:21'),
('01a01892-1464-7333-bf84-69000e53384f', 'report trial balance export', 'web', 'Reports', 'Export neraca saldo', 0, '2026-08-18 22:50:21', '2026-08-18 22:50:21'),
('01a01892-1490-70dd-b839-3d22609c95b3', 'report ledger view', 'web', 'Reports', 'Melihat laporan buku besar', 1, '2026-08-18 22:50:21', '2026-08-18 22:50:21'),
('01a01892-14c1-71e4-9a75-8e91326dc2c8', 'report ledger export', 'web', 'Reports', 'Export laporan buku besar', 0, '2026-08-18 22:50:21', '2026-08-18 22:50:21');

-- --------------------------------------------------------

--
-- Struktur dari tabel `roles`
--

CREATE TABLE `roles` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
('01a01892-1593-712f-9034-f9606f7fa6e6', 'SUPER ADMIN', 'web', '2026-08-18 22:50:22', '2026-08-18 22:50:22'),
('01a01892-1ba9-706a-9d0a-5d3e82acdbe3', 'BENDAHARA', 'web', '2026-08-18 22:50:23', '2026-08-18 22:50:23'),
('01a01892-22b5-7024-90c3-7fc631576c62', 'ACCOUNTING USER', 'web', '2026-08-18 22:50:25', '2026-08-18 22:50:25');

-- --------------------------------------------------------

--
-- Struktur dari tabel `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
('01a01892-0ce7-73de-aeb3-761072cbf400', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-0d36-72d0-aa24-3bd38a527b0d', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-0d88-714d-9f33-0fb936bfbdf8', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-0dda-73db-a009-8fd3a17222f1', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-0e25-70c0-8250-a8c1dcbabebc', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-0e80-7065-9371-379b7eb6bcbc', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-0edb-700a-93c6-53b2f219f03b', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-0f06-71ca-8cd5-17dca7c70672', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-0f28-7399-b3a0-ed2e9f9d8d46', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-0f48-7219-afcd-37981fdc18dc', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-0f67-7150-b8b3-4ff408838a62', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-0f86-72b3-87ea-c6dbc6183077', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-0fa6-7354-950b-4b51e9b481b4', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-0fc4-7345-930a-000820bcc8c9', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-0fed-711c-94df-29ae2aab3927', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-1018-7091-91ed-7c980c7a810f', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-1047-7393-b0b6-ae61c0748245', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-1073-71d7-8cae-0b041ccfb92c', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-10a2-73e3-8d35-14c19641a615', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-10cf-7285-8fdd-bb49937289f5', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-10fc-702c-ad73-ddb0cb89d28e', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-1129-712c-b5aa-0d943fb1ef27', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-1160-71bf-84b2-2ef51a921ea8', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-11ad-72fd-9a1e-e07a31fc8180', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-11f9-73c6-8e7c-fea59287beda', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-1246-72d9-9e79-847d431f4f3a', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-129c-7170-aec2-81e5cdcafc16', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-12f5-7283-902b-1bafa890a71c', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-1344-738b-824b-344dc220f7bb', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-138c-7314-8825-3ee4ad9a024e', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-13d6-7357-969e-a028e829569d', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-1414-70a9-a511-7938a91d41f9', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-143c-712f-9afe-6976528a1014', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-1464-7333-bf84-69000e53384f', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-1490-70dd-b839-3d22609c95b3', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-14c1-71e4-9a75-8e91326dc2c8', '01a01892-1593-712f-9034-f9606f7fa6e6'),
('01a01892-0d36-72d0-aa24-3bd38a527b0d', '01a01892-1ba9-706a-9d0a-5d3e82acdbe3'),
('01a01892-0fed-711c-94df-29ae2aab3927', '01a01892-1ba9-706a-9d0a-5d3e82acdbe3'),
('01a01892-1018-7091-91ed-7c980c7a810f', '01a01892-1ba9-706a-9d0a-5d3e82acdbe3'),
('01a01892-1047-7393-b0b6-ae61c0748245', '01a01892-1ba9-706a-9d0a-5d3e82acdbe3'),
('01a01892-1073-71d7-8cae-0b041ccfb92c', '01a01892-1ba9-706a-9d0a-5d3e82acdbe3'),
('01a01892-10a2-73e3-8d35-14c19641a615', '01a01892-1ba9-706a-9d0a-5d3e82acdbe3'),
('01a01892-10cf-7285-8fdd-bb49937289f5', '01a01892-1ba9-706a-9d0a-5d3e82acdbe3'),
('01a01892-10fc-702c-ad73-ddb0cb89d28e', '01a01892-1ba9-706a-9d0a-5d3e82acdbe3'),
('01a01892-1160-71bf-84b2-2ef51a921ea8', '01a01892-1ba9-706a-9d0a-5d3e82acdbe3'),
('01a01892-11ad-72fd-9a1e-e07a31fc8180', '01a01892-1ba9-706a-9d0a-5d3e82acdbe3'),
('01a01892-12f5-7283-902b-1bafa890a71c', '01a01892-1ba9-706a-9d0a-5d3e82acdbe3'),
('01a01892-1344-738b-824b-344dc220f7bb', '01a01892-1ba9-706a-9d0a-5d3e82acdbe3'),
('01a01892-13d6-7357-969e-a028e829569d', '01a01892-1ba9-706a-9d0a-5d3e82acdbe3'),
('01a01892-1414-70a9-a511-7938a91d41f9', '01a01892-1ba9-706a-9d0a-5d3e82acdbe3'),
('01a01892-143c-712f-9afe-6976528a1014', '01a01892-1ba9-706a-9d0a-5d3e82acdbe3'),
('01a01892-1464-7333-bf84-69000e53384f', '01a01892-1ba9-706a-9d0a-5d3e82acdbe3'),
('01a01892-1490-70dd-b839-3d22609c95b3', '01a01892-1ba9-706a-9d0a-5d3e82acdbe3'),
('01a01892-14c1-71e4-9a75-8e91326dc2c8', '01a01892-1ba9-706a-9d0a-5d3e82acdbe3'),
('01a01892-0fed-711c-94df-29ae2aab3927', '01a01892-22b5-7024-90c3-7fc631576c62'),
('01a01892-1129-712c-b5aa-0d943fb1ef27', '01a01892-22b5-7024-90c3-7fc631576c62'),
('01a01892-11ad-72fd-9a1e-e07a31fc8180', '01a01892-22b5-7024-90c3-7fc631576c62'),
('01a01892-11f9-73c6-8e7c-fea59287beda', '01a01892-22b5-7024-90c3-7fc631576c62'),
('01a01892-1246-72d9-9e79-847d431f4f3a', '01a01892-22b5-7024-90c3-7fc631576c62'),
('01a01892-129c-7170-aec2-81e5cdcafc16', '01a01892-22b5-7024-90c3-7fc631576c62'),
('01a01892-138c-7314-8825-3ee4ad9a024e', '01a01892-22b5-7024-90c3-7fc631576c62'),
('01a01892-1490-70dd-b839-3d22609c95b3', '01a01892-22b5-7024-90c3-7fc631576c62'),
('01a01892-14c1-71e4-9a75-8e91326dc2c8', '01a01892-22b5-7024-90c3-7fc631576c62');

-- --------------------------------------------------------

--
-- Struktur dari tabel `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('1twMM3kKiR1pCWtY2gvUpw9kcTDiXR1NbH5WdsEk', NULL, '103.112.245.9', 'Python/3.11 aiohttp/3.9.2', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOWczZzYyUUxoajVtZlZlU3ZtajhRZElFUE1QdWh4Q1d3bTM0eVU1TiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDU6Imh0dHBzOi8vZGlzcG9zaXNpLmVuZ2luZWVyaW5nLXVtc3VyYS5pZC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1788107177),
('3iuY6Rgv3aRj0tFIpVTUMX0CpIzYsdLRvQ8TCvJb', NULL, '103.112.245.9', 'Python/3.11 aiohttp/3.9.2', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUDQ3eXIyUW8wT1VzYjR0WmFzYzNZT0UxVFdRTWJXQkJEeVE1QjN0QSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDU6Imh0dHBzOi8vZGlzcG9zaXNpLmVuZ2luZWVyaW5nLXVtc3VyYS5pZC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1788103574),
('9c6m0RIeNUmUBZeivdFhbvhXYLKiMqgrZ3KayD36', NULL, '103.112.245.9', 'Python/3.11 aiohttp/3.9.2', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNE1oRTZ4dFF2T2xRZTJOSjAxZjNrS1VCWFRGME9zMW8xNDFMdkQ5aSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDU6Imh0dHBzOi8vZGlzcG9zaXNpLmVuZ2luZWVyaW5nLXVtc3VyYS5pZC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1788099975),
('E2JW19ao2Kndx2Ry3HpLoX78IQLy1R2yFAYr6xDk', NULL, '103.112.245.9', 'Python/3.11 aiohttp/3.9.2', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUGMyQW9Da3RpbzRQeWxiZmFUYmtXOHlLWk9HSDhKdHVCUjFnendXaSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDU6Imh0dHBzOi8vZGlzcG9zaXNpLmVuZ2luZWVyaW5nLXVtc3VyYS5pZC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1788108977),
('e8TlPKtIPUFTkcmFxB6uLDkudBGJF398TfvAGtmL', NULL, '103.112.245.9', 'Python/3.11 aiohttp/3.9.2', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieWZ3Q3Y2Vzk1b2VYRTM4WU91SzNoQnN1NzNqbVhzQ2JjS1h6aEtUeSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDU6Imh0dHBzOi8vZGlzcG9zaXNpLmVuZ2luZWVyaW5nLXVtc3VyYS5pZC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1788094580),
('G6bAB9SsgZTQtPNGdmSbX4w7cNkUkGeLRuq4madl', NULL, '103.112.245.9', 'Python/3.11 aiohttp/3.9.2', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMVk5U1ppNTdjUThpbVRSMjY2MUplRXRKZ1RTU0U5YkFQVmw3cXJxZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDU6Imh0dHBzOi8vZGlzcG9zaXNpLmVuZ2luZWVyaW5nLXVtc3VyYS5pZC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1788096375),
('jKfe6cLOfFpaX5UbI94LnDVoZkeu3jpGxtD4H4jr', NULL, '3.85.196.206', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:139.0) Gecko/20100101 Firefox/139.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRmhtOXI1OXJlbVpmZlN1RlU0allWSjBzUXJEVVlmOE9DclJISEVtOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vZGlzcG9zaXNpLmVuZ2luZWVyaW5nLXVtc3VyYS5pZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1788108091),
('kVso4Ql2GwuWZ62wQsg5zKyHhmTnnTRo2AXXtlEY', '01a01892-33c9-721a-a9c3-32de766115f7', '157.15.62.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:154.0) Gecko/20100101 Firefox/154.0', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiY3UwR1JSUm5qMDVwTHZVcEFEcU9oUWZSNlA3WGJZR0RSWU5TcHVESSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo3MzoiaHR0cHM6Ly9kaXNwb3Npc2kuZW5naW5lZXJpbmctdW1zdXJhLmlkL3VzZXIvdHJhbnNhY3Rpb25zL2V4cGVuc2VzL2NyZWF0ZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjY2OiJodHRwczovL2Rpc3Bvc2lzaS5lbmdpbmVlcmluZy11bXN1cmEuaWQvdXNlci91c2VyLWFjY291bnQtYmFsYW5jZXMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7czozNjoiMDFhMDE4OTItMzNjOS03MjFhLWE5YzMtMzJkZTc2NjExNWY3Ijt9', 1788103431),
('mriB7smhCrknrFlZlIPkcgCqtZ8tdOFnh6CUJcC5', NULL, '103.112.245.9', 'Python/3.11 aiohttp/3.9.2', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiR05ZTWhKSEpYbExERDlUcjl1bm1Vb2s1ZW95aVVxVWdqcGp5VDR6eiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDU6Imh0dHBzOi8vZGlzcG9zaXNpLmVuZ2luZWVyaW5nLXVtc3VyYS5pZC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1788098178),
('myTfB1mGJ6nHsci3n9ORQbJG9U0Mulva4IwdZdUw', NULL, '103.112.245.9', 'Python/3.11 aiohttp/3.9.2', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidmtYZUdOY3UyM2pLTWJsQ3hXV05RT1lVZzRvRnlFempBQ05JTkpZdyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDU6Imh0dHBzOi8vZGlzcG9zaXNpLmVuZ2luZWVyaW5nLXVtc3VyYS5pZC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1788105379),
('RXjGIDfInbGkpiW0r2iwnsDij38mX20Lnd6J7Afq', NULL, '3.85.196.206', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:139.0) Gecko/20100101 Firefox/139.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaVg3NTh1Wm1iRHJGaFdMVkY0UEJFMXNwOHBMb1VNRE1WZUNNd3RkMiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDU6Imh0dHBzOi8vZGlzcG9zaXNpLmVuZ2luZWVyaW5nLXVtc3VyYS5pZC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1788108091),
('sQRNRPVStVMTrSxBHj6ZbzM7NrSdhJOybCrrrajU', NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:154.0) Gecko/20100101 Firefox/154.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT1J0bWFWZ2VQeXVqZ2ZKQWQ5eWZuQ0xBS0Z6Z2NpV0NQbXVsUFMzRSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9sb2dpbiI7fX0=', 1788109606),
('T3prluvoop4PZ5oetCH7ydZb5mxEv08bHgirUIQU', NULL, '3.85.196.206', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibDdOa0JXcHFsandvaUNBSnN2SGVtWXdPdGd5bjNSUXBsRVBueDRtRiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDk6Imh0dHBzOi8vd3d3LmRpc3Bvc2lzaS5lbmdpbmVlcmluZy11bXN1cmEuaWQvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1788108091),
('Yuuh4PMu97sv5jCsjo3cpGEoljJcYuavhArKbAha', NULL, '3.85.196.206', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN0Fsdm1NNzhYSUV1aWJpVVJsNDdNTHJucVJydDhvaVV4ZWdzUll6QyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDM6Imh0dHBzOi8vd3d3LmRpc3Bvc2lzaS5lbmdpbmVlcmluZy11bXN1cmEuaWQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1788108090),
('zC20mKyjW7PJW9xbCb1k5miWWlkShevA1wUQwG13', NULL, '103.112.245.9', 'Python/3.11 aiohttp/3.9.2', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicEpWTmZ0VVRxQnJ3cjZNWTV0cWJuUTVDcWdwZ0diUXN5TW0wd1R2aiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDU6Imh0dHBzOi8vZGlzcG9zaXNpLmVuZ2luZWVyaW5nLXVtc3VyYS5pZC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1788101774);

-- --------------------------------------------------------

--
-- Struktur dari tabel `sub_periods`
--

CREATE TABLE `sub_periods` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `period_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `is_closed` tinyint(1) NOT NULL DEFAULT '0',
  `closed_at` datetime DEFAULT NULL,
  `closed_by` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `sub_periods`
--

INSERT INTO `sub_periods` (`id`, `period_id`, `name`, `description`, `start_date`, `end_date`, `is_closed`, `closed_at`, `closed_by`, `created_at`, `updated_at`) VALUES
('01a01892-3570-7042-bf44-b27971411a65', '01a01892-3475-73b3-b03a-e629fe98ebd5', 'Desember 2022', 'Bulan Desember 2022', '2022-12-01', '2022-12-31', 1, '2026-08-19 06:54:13', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '2026-08-18 22:50:30', '2026-08-18 23:54:13'),
('01a01892-35ae-7116-95b4-4cabe8ce6031', '01a01892-358d-7241-9d2f-3e8b59a7ef11', 'Januari 2023', 'Bulan Januari 2023', '2023-01-01', '2023-01-31', 0, NULL, NULL, '2026-08-18 22:50:30', '2026-08-18 22:50:30');

-- --------------------------------------------------------

--
-- Struktur dari tabel `transactions`
--

CREATE TABLE `transactions` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_date` date NOT NULL,
  `transaction_type` enum('INCOME','EXPENSE','TRANSFER') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'INCOME',
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` enum('DRAFT','POSTED','REVERSED') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DRAFT',
  `gross_amount` decimal(18,2) NOT NULL,
  `net_amount` decimal(18,2) NOT NULL,
  `referencree_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `period_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_period_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `posted_at` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `transactions`
--

INSERT INTO `transactions` (`id`, `transaction_number`, `transaction_date`, `transaction_type`, `description`, `status`, `gross_amount`, `net_amount`, `referencree_number`, `receipt_path`, `created_by`, `period_id`, `sub_period_id`, `posted_at`, `created_at`, `updated_at`) VALUES
('01a018ea-270f-729b-bf6d-1e3abb3d62ec', 'TRX-EXP-20260819072633', '2023-01-01', 'EXPENSE', 'Transfer Parkir + Biaya', 'POSTED', 402500.00, 402500.00, NULL, NULL, '01a01892-33c9-721a-a9c3-32de766115f7', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', NULL, '2026-08-19 00:26:33', '2026-08-19 00:26:33');

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaction_lines`
--

CREATE TABLE `transaction_lines` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `chart_of_account_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` enum('DEBIT','CREDIT') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DEBIT',
  `amount` decimal(18,2) NOT NULL,
  `meta_type` enum('MAIN','TAX','INTEREST') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'MAIN',
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `transaction_lines`
--

INSERT INTO `transaction_lines` (`id`, `transaction_id`, `chart_of_account_id`, `position`, `amount`, `meta_type`, `description`, `created_at`, `updated_at`) VALUES
('01a018ea-2714-73e0-9391-f5b5db498e3f', '01a018ea-270f-729b-bf6d-1e3abb3d62ec', '1f4aee8e-7929-4596-afab-9275a64353bc', 'DEBIT', 402500.00, 'MAIN', 'Biaya Parkir Pengeluaran', '2026-08-19 00:26:33', '2026-08-19 00:26:33'),
('01a018ea-2715-7026-a3a5-71299bca331c', '01a018ea-270f-729b-bf6d-1e3abb3d62ec', '428e0a5c-05eb-4705-b2a6-4333f44318c2', 'CREDIT', 402500.00, 'MAIN', 'Kas Ditangan Kas Keluar', '2026-08-19 00:26:33', '2026-08-19 00:26:33');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_telp` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_superadmin` tinyint(1) NOT NULL DEFAULT '0',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `name`, `no_telp`, `address`, `email`, `email_verified_at`, `password`, `is_superadmin`, `remember_token`, `created_at`, `updated_at`) VALUES
('01a01892-2d8a-7167-9948-d09930cc5511', 'Super Admin', NULL, NULL, 'superadmin@example.com', NULL, '$2y$12$5gqQzchATNeU0Z1Aee7g6OHoW/KCV8ZVGZz4f9fB0B4/p.Oa7EcN.', 1, NULL, '2026-08-18 22:50:28', '2026-08-18 22:50:28'),
('01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'Bendahara', NULL, NULL, 'bendahara@example.com', NULL, '$2y$12$LU45qba03VT5zNI1F7oX8.14sRjoXNN2Nmy.L89ljZcE3hh7rC6Ey', 0, NULL, '2026-08-18 22:50:29', '2026-08-18 22:50:29'),
('01a01892-33c9-721a-a9c3-32de766115f7', 'Pemegang Kas Operasional', NULL, NULL, 'pemegang-kas@example.com', NULL, '$2y$12$7f0dIrwQn5kit6vRuyqZ1eo.idrA0wzixewDSuuerZmmsUJrsb7SW', 0, NULL, '2026-08-18 22:50:29', '2026-08-18 22:50:29');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_accounts`
--

CREATE TABLE `user_accounts` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `coa_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `user_accounts`
--

INSERT INTO `user_accounts` (`id`, `user_id`, `coa_id`, `created_at`, `updated_at`) VALUES
('01a01892-50a4-7391-b012-3a77a8de3d75', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '01a6ceac-9323-4e5b-81eb-5904785cb371', '2026-08-18 22:50:37', '2026-08-18 22:50:37'),
('01a01892-50c0-70e6-97ad-b800a7d7d4ab', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '01e17af4-b5e1-45a7-8a8e-3e46a346689c', '2026-08-18 22:50:37', '2026-08-18 22:50:37'),
('01a01892-50dc-7137-8a29-7a8e3daa31b6', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '01fe1230-5091-4c93-8592-9d12d816c873', '2026-08-18 22:50:37', '2026-08-18 22:50:37'),
('01a01892-50f9-72d4-b1f2-b7a8686135c1', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '02ab1587-1178-4318-a11a-75602883cb8e', '2026-08-18 22:50:37', '2026-08-18 22:50:37'),
('01a01892-5115-733e-bdf2-ccc0f393ccf2', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '0426f16a-9263-41bf-84be-fdba26415ae9', '2026-08-18 22:50:37', '2026-08-18 22:50:37'),
('01a01892-5131-7368-ab42-cbc8ddb9cda7', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '04412dba-f0b0-4cf0-a936-22384d4f09de', '2026-08-18 22:50:37', '2026-08-18 22:50:37'),
('01a01892-5150-71b9-9009-cd33f625d335', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '0506ee3f-8db9-4fb7-b2a9-5517c6872f4b', '2026-08-18 22:50:37', '2026-08-18 22:50:37'),
('01a01892-5171-7333-afd8-e9a399fba5c9', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '0530a8fd-428a-4157-913f-73c048b384ec', '2026-08-18 22:50:37', '2026-08-18 22:50:37'),
('01a01892-5194-7208-a6ca-117519820d39', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '07c833c4-2d25-46eb-919e-1daa18d37932', '2026-08-18 22:50:37', '2026-08-18 22:50:37'),
('01a01892-51ba-7197-b210-3164e7f26404', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '08e15b4f-473b-4440-a706-d4c5a27a063b', '2026-08-18 22:50:37', '2026-08-18 22:50:37'),
('01a01892-51da-73f1-a97d-8a607987fedf', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '09047564-c6b0-43ee-9325-1a60f8bc8210', '2026-08-18 22:50:37', '2026-08-18 22:50:37'),
('01a01892-51fa-7217-9020-37c1815727da', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '0aac9b12-2986-4461-b203-775f40299bdf', '2026-08-18 22:50:37', '2026-08-18 22:50:37'),
('01a01892-5218-71d1-92b1-46c115140089', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '0b7edae5-2603-4fca-b0b4-021958ce2007', '2026-08-18 22:50:37', '2026-08-18 22:50:37'),
('01a01892-5236-71bc-83df-fa60e9fc1e6b', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '0d292bff-c890-4ec0-b139-cf21b197590c', '2026-08-18 22:50:37', '2026-08-18 22:50:37'),
('01a01892-5254-7143-9ee2-5969006f25cb', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '0f33f8c0-5dd6-49ea-bd65-a156fe582482', '2026-08-18 22:50:37', '2026-08-18 22:50:37'),
('01a01892-5273-7370-b5da-fe66a227aa4b', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '0f35d3fb-1d8e-4c26-b389-3529db99acf4', '2026-08-18 22:50:37', '2026-08-18 22:50:37'),
('01a01892-5290-72ce-aecf-da48ae61ed98', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '1813e7c7-6603-4b01-9503-0fd3ab29c265', '2026-08-18 22:50:37', '2026-08-18 22:50:37'),
('01a01892-52b3-7360-b712-451ad49aeb7b', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '1ceb41e2-0b92-495f-97a8-429fdf2c0817', '2026-08-18 22:50:37', '2026-08-18 22:50:37'),
('01a01892-52d4-7356-87db-8aec3c723b9d', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '1f4aee8e-7929-4596-afab-9275a64353bc', '2026-08-18 22:50:37', '2026-08-18 22:50:37'),
('01a01892-52f3-70e4-aced-01d8990932e3', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '21106003-e3e0-46a2-a93f-4c6aefe848a2', '2026-08-18 22:50:37', '2026-08-18 22:50:37'),
('01a01892-5311-73b7-a1fb-fbab7eebb4ca', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '2a983594-0762-4d4b-94fe-31dae7c954aa', '2026-08-18 22:50:37', '2026-08-18 22:50:37'),
('01a01892-532f-7205-bad9-78d577cf42e4', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '2d73c3d7-f395-482d-a56d-544ec82850b7', '2026-08-18 22:50:37', '2026-08-18 22:50:37'),
('01a01892-534e-72e7-85ee-f41b12b1fe94', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '2f7209ea-c61c-44ac-a2fb-2fe4f4ad5942', '2026-08-18 22:50:37', '2026-08-18 22:50:37'),
('01a01892-536b-73de-b9a5-381369269dad', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '322e4838-588b-4746-93cd-45a6216e1859', '2026-08-18 22:50:37', '2026-08-18 22:50:37'),
('01a01892-5389-710a-8626-24555bd16c2f', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '335426e6-9a75-4044-bcdc-c9341953d07d', '2026-08-18 22:50:37', '2026-08-18 22:50:37'),
('01a01892-53a9-7097-898e-7506fca297ec', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '358657c6-fe73-408d-8349-8bc351f14284', '2026-08-18 22:50:37', '2026-08-18 22:50:37'),
('01a01892-53d8-731f-9542-729334872fa9', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '37c8c7c4-950a-46a2-9463-0c7a3a7cbd7b', '2026-08-18 22:50:38', '2026-08-18 22:50:38'),
('01a01892-5406-7160-a3dc-393a1d1991e1', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '3d80de27-170d-4c9c-972c-db16527a3254', '2026-08-18 22:50:38', '2026-08-18 22:50:38'),
('01a01892-542f-73ed-bf2d-06c6516b0307', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '3fc473e1-13f0-47ea-9596-1a0a24130463', '2026-08-18 22:50:38', '2026-08-18 22:50:38'),
('01a01892-545c-71f0-9dad-da79cef44df4', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '4120d48b-9edd-4c50-a3fa-61479eefd67c', '2026-08-18 22:50:38', '2026-08-18 22:50:38'),
('01a01892-548a-70dc-a70b-cb3d318fcb31', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '413d1cc6-3b86-44fb-9184-a1f16f3f3656', '2026-08-18 22:50:38', '2026-08-18 22:50:38'),
('01a01892-54b2-70cc-8c74-328f227a8d49', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '428e0a5c-05eb-4705-b2a6-4333f44318c2', '2026-08-18 22:50:38', '2026-08-18 22:50:38'),
('01a01892-54de-7263-9ff2-c7d36ba3898f', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '42ca2ce5-a3e0-4900-a0d8-6d741e9e0c68', '2026-08-18 22:50:38', '2026-08-18 22:50:38'),
('01a01892-5507-705c-ad2e-62c66181bfb8', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '43825298-9466-4975-b2f5-9c8c04015647', '2026-08-18 22:50:38', '2026-08-18 22:50:38'),
('01a01892-5533-7310-a1d0-df029cb11f21', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '4446aab5-0d01-49f7-bf73-79880109da89', '2026-08-18 22:50:38', '2026-08-18 22:50:38'),
('01a01892-5564-727f-83f0-2cb51dcf0e2e', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '47e1b824-ae48-4d38-a262-2f09ed748d8c', '2026-08-18 22:50:38', '2026-08-18 22:50:38'),
('01a01892-558b-70eb-8a64-d155b5aa121f', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '48802d54-e75c-4fc3-b4ed-4edeb9e1c16e', '2026-08-18 22:50:38', '2026-08-18 22:50:38'),
('01a01892-55a1-7005-bab9-96a2e586faf3', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '48fb488e-f265-467a-afb7-a12aded626aa', '2026-08-18 22:50:38', '2026-08-18 22:50:38'),
('01a01892-55b5-73c4-9077-e0239905b15a', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '497ec733-26b1-41de-be5e-7ca327307bbb', '2026-08-18 22:50:38', '2026-08-18 22:50:38'),
('01a01892-55c6-729c-9690-59d83bc5bb9f', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '4ec4e235-c953-4aa3-b0bd-3e4a6fa61998', '2026-08-18 22:50:38', '2026-08-18 22:50:38'),
('01a01892-55dc-7256-8df0-9e4035869384', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '4eccd469-b5e3-49a4-a5c8-e38935bb4aaa', '2026-08-18 22:50:38', '2026-08-18 22:50:38'),
('01a01892-55ee-73b4-a5d1-8c1bb4f1cda7', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '52678ecc-fa79-4b5e-8f1c-3115ad12dbab', '2026-08-18 22:50:38', '2026-08-18 22:50:38'),
('01a01892-5600-701b-ba67-9574f26393b7', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '549eacd3-d424-455c-bbad-3017fbc3dee1', '2026-08-18 22:50:38', '2026-08-18 22:50:38'),
('01a01892-5616-702b-ad30-8fba2d31c37d', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '57a3cf82-241c-4785-a173-d6c35b8d8b0b', '2026-08-18 22:50:38', '2026-08-18 22:50:38'),
('01a01892-564a-72bc-be42-3af9fbf1df66', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '5cf4c998-2379-441b-8022-39fa011da378', '2026-08-18 22:50:38', '2026-08-18 22:50:38'),
('01a01892-5674-72ab-8ccd-85ee4d92d365', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '60f843d0-b7d3-4d98-9899-dd5c42b867c3', '2026-08-18 22:50:38', '2026-08-18 22:50:38'),
('01a01892-568a-7005-886e-e29902856968', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '6471a78b-6866-4c5f-914b-05f5943de13f', '2026-08-18 22:50:38', '2026-08-18 22:50:38'),
('01a01892-569e-7043-b53d-a9a30952bba1', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '71abdc28-98f2-4686-a01d-d57269ca3f5e', '2026-08-18 22:50:38', '2026-08-18 22:50:38'),
('01a01892-56b4-7248-bf89-f0f86b0fd9fb', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '736666f9-64f2-44c2-807e-029286aea71e', '2026-08-18 22:50:38', '2026-08-18 22:50:38'),
('01a01892-56c9-7083-b07c-30766cea5af8', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '74164ad2-dc66-4637-9787-8ea9fb7d2786', '2026-08-18 22:50:38', '2026-08-18 22:50:38'),
('01a01892-56d9-73a8-9704-e6bcc4fc7e0c', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '7982e02f-5bea-46dd-989d-5d043d4c9ac8', '2026-08-18 22:50:38', '2026-08-18 22:50:38'),
('01a01892-56ec-7270-b4ba-25de040e3c6c', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '79ab97bb-c369-43fd-a3e7-7653379f4ca3', '2026-08-18 22:50:38', '2026-08-18 22:50:38'),
('01a01892-5704-7314-b195-e11a8ea15c63', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '7c39b310-92b3-47fa-bb22-472ed7a3f61f', '2026-08-18 22:50:38', '2026-08-18 22:50:38'),
('01a01892-571d-7151-b7eb-3bdb94d3b977', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '7ca2b5d4-da4f-4e48-adf6-44a2ddff4639', '2026-08-18 22:50:38', '2026-08-18 22:50:38'),
('01a01892-5735-7138-9a93-053189f68b82', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '7d88cba0-d0e8-4209-96d4-1d38e9384a0f', '2026-08-18 22:50:38', '2026-08-18 22:50:38'),
('01a01892-574d-706e-86fc-e6746a977cbc', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '7d9cf22a-4943-474a-929a-3bb5a38cc8ad', '2026-08-18 22:50:38', '2026-08-18 22:50:38'),
('01a01892-5768-71b0-9901-2f88af20b07e', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '8608167b-6832-4961-8ebc-cbec2b0ac8f6', '2026-08-18 22:50:38', '2026-08-18 22:50:38'),
('01a01892-5789-70b0-9354-628ecf181f50', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '866c1c5e-69ce-484e-a2c5-7bd92a30d1e4', '2026-08-18 22:50:38', '2026-08-18 22:50:38'),
('01a01892-57aa-7060-9afb-344f531a2529', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '86e9d092-0ade-4937-957a-694ea7a3b3c9', '2026-08-18 22:50:39', '2026-08-18 22:50:39'),
('01a01892-57c9-70dc-a605-54f3adcd4629', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '89ce14b6-887a-400a-8e26-45556ae7dcb9', '2026-08-18 22:50:39', '2026-08-18 22:50:39'),
('01a01892-57e7-7152-8195-a471728df830', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '8c8f3239-c155-4331-80b8-93049b9b6572', '2026-08-18 22:50:39', '2026-08-18 22:50:39'),
('01a01892-5807-70d1-9f51-0c77f2c49625', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '8fe72dd8-27ab-4832-acf1-c93416d508c6', '2026-08-18 22:50:39', '2026-08-18 22:50:39'),
('01a01892-5827-7105-bdeb-d16518576d1b', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '91eb0cc0-ef76-4958-9e2e-2b39ea5a2e10', '2026-08-18 22:50:39', '2026-08-18 22:50:39'),
('01a01892-5846-703b-addd-0c205ec354a4', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '9342d566-780a-4e18-af89-53526ba9c4d5', '2026-08-18 22:50:39', '2026-08-18 22:50:39'),
('01a01892-5865-71ec-9ed1-0c14e8530cd9', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '9485e07f-9a69-4358-bf92-3db47566634e', '2026-08-18 22:50:39', '2026-08-18 22:50:39'),
('01a01892-5885-712c-874e-40004e2305ea', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '97c9a8ae-4591-4d13-af7c-816bd3933278', '2026-08-18 22:50:39', '2026-08-18 22:50:39'),
('01a01892-58a8-7252-a9ed-afae73f3a379', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '98b1126e-e4d4-4ef6-baf1-5a9476ee96b1', '2026-08-18 22:50:39', '2026-08-18 22:50:39'),
('01a01892-58c8-7386-917a-69f5b3ed5eb7', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '9a673591-b201-41c1-9b3f-8e094d3f2708', '2026-08-18 22:50:39', '2026-08-18 22:50:39'),
('01a01892-58e6-73c7-b305-797a5fa376ff', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '9b702b8d-0aee-4a5d-a7a6-14c86f698c9d', '2026-08-18 22:50:39', '2026-08-18 22:50:39'),
('01a01892-5908-73fc-b9b0-5787ef5af951', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '9d444492-1a3b-478c-a3e2-8cdfd9ea13f0', '2026-08-18 22:50:39', '2026-08-18 22:50:39'),
('01a01892-592a-72ba-9558-ac26bc090797', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', '9e17057b-c02b-411a-a70b-161c809a7814', '2026-08-18 22:50:39', '2026-08-18 22:50:39'),
('01a01892-594d-72a2-ac50-59099d9ff113', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'a999a49a-aced-46f1-9919-c763527b35cb', '2026-08-18 22:50:39', '2026-08-18 22:50:39'),
('01a01892-596c-70ca-9fd9-bf5f3cb2fad1', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'acef7df7-0747-4fea-a62b-994741b214a4', '2026-08-18 22:50:39', '2026-08-18 22:50:39'),
('01a01892-5993-71f6-8f9f-917e321f379e', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'af74906a-54f3-457c-aef4-653ea224d82f', '2026-08-18 22:50:39', '2026-08-18 22:50:39'),
('01a01892-59b5-7202-99f5-ba55491f7f8d', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'b12c01c4-7a23-4354-bb59-6245f0411fce', '2026-08-18 22:50:39', '2026-08-18 22:50:39'),
('01a01892-59d8-714e-b279-63123cf5f7ba', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'b24b3143-ae78-43d0-9fc5-8ed975177c00', '2026-08-18 22:50:39', '2026-08-18 22:50:39'),
('01a01892-59f7-7392-9442-882d2e418d85', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'b6ad160b-67be-4b70-9715-d9d454d28b87', '2026-08-18 22:50:39', '2026-08-18 22:50:39'),
('01a01892-5a16-731c-b319-26a2c31e27de', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'b84a4e4a-de13-421b-8a18-2ef75e319e9f', '2026-08-18 22:50:39', '2026-08-18 22:50:39'),
('01a01892-5a34-7343-9e5a-b2a78a3d6359', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'b87a0e99-f1eb-47d9-a336-8f7248f6a07d', '2026-08-18 22:50:39', '2026-08-18 22:50:39'),
('01a01892-5a53-7258-aa75-d1d602ab4466', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'bc84941c-dca5-483d-af26-f3254854ffaa', '2026-08-18 22:50:39', '2026-08-18 22:50:39'),
('01a01892-5a73-729c-b9fd-417026db1117', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'be57ddf7-3177-4d16-bb22-db567be94f18', '2026-08-18 22:50:39', '2026-08-18 22:50:39'),
('01a01892-5a92-711c-8f2c-322398fa01a2', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'c37423f6-c3c3-46ef-9d0b-be58f8023e0d', '2026-08-18 22:50:39', '2026-08-18 22:50:39'),
('01a01892-5ab1-735a-ba70-a60ede75a5c0', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'c4af4f99-70dd-489a-a8e9-eff69a44a6aa', '2026-08-18 22:50:39', '2026-08-18 22:50:39'),
('01a01892-5acf-7258-9d13-e72bc4e77aaf', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'c5673400-d772-475d-8c68-d5998a0169bb', '2026-08-18 22:50:39', '2026-08-18 22:50:39'),
('01a01892-5aef-70b8-8169-cd9ad9e2ba90', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'c5b99c5f-5885-4ef9-bae3-ab1811e502af', '2026-08-18 22:50:39', '2026-08-18 22:50:39'),
('01a01892-5b0e-711c-bf14-57be55e25233', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'c5f9d6cb-10ca-4370-a314-68bfb0e298c4', '2026-08-18 22:50:39', '2026-08-18 22:50:39'),
('01a01892-5b35-723f-8ccf-764a4ec426d4', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'c668d8cc-2178-49df-90f0-f56826239046', '2026-08-18 22:50:39', '2026-08-18 22:50:39'),
('01a01892-5b64-70cc-8591-993bf3a133fd', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'c80409d4-830c-4ce7-a5c4-b83e8926e973', '2026-08-18 22:50:39', '2026-08-18 22:50:39'),
('01a01892-5b91-70d9-b9e1-b49155d6d625', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'c82ea824-81ca-4c12-ac14-c068c0ab5d9b', '2026-08-18 22:50:40', '2026-08-18 22:50:40'),
('01a01892-5bbd-72f6-9106-5f86f5fd4db5', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'c87fb4be-060a-407a-872c-b616be2efaa2', '2026-08-18 22:50:40', '2026-08-18 22:50:40'),
('01a01892-5be9-7172-b138-c8e10b591c67', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'cb69c482-8711-4de6-94ca-e600b799ce23', '2026-08-18 22:50:40', '2026-08-18 22:50:40'),
('01a01892-5c13-734c-9371-fc3a01085ead', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'cbb1aca6-0387-43c1-a405-56ec63f1c6ae', '2026-08-18 22:50:40', '2026-08-18 22:50:40'),
('01a01892-5c3c-707f-943a-8707d15694bf', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'cbb43cce-4240-4816-878b-589ed0dc3077', '2026-08-18 22:50:40', '2026-08-18 22:50:40'),
('01a01892-5c65-7107-b6b9-2cb1b096056d', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'cdec27f0-78ef-4fc2-9a96-bc945f117791', '2026-08-18 22:50:40', '2026-08-18 22:50:40'),
('01a01892-5c90-73d5-90a1-8f5b588d82c7', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'cf6abddb-c37d-4d09-81e1-d7e1b228c295', '2026-08-18 22:50:40', '2026-08-18 22:50:40'),
('01a01892-5cbd-71de-82eb-00b9331494fe', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'd12af9b7-18fa-4a91-a81e-1de189c7a09b', '2026-08-18 22:50:40', '2026-08-18 22:50:40'),
('01a01892-5ce7-71c4-8493-b4158b418d52', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'd1907d49-c67d-4999-a52e-22d97f18fad8', '2026-08-18 22:50:40', '2026-08-18 22:50:40'),
('01a01892-5d15-72b9-ac36-2576e7ccf91e', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'd2690199-e933-4880-af1b-06ba9e4c6b18', '2026-08-18 22:50:40', '2026-08-18 22:50:40'),
('01a01892-5d43-7120-b0b1-fe488d7d7b54', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'd52fe69c-0b3b-406f-8cdc-1812ca512215', '2026-08-18 22:50:40', '2026-08-18 22:50:40'),
('01a01892-5d6e-72a3-b2a1-c8414320d5ec', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'd6e9f819-a18e-4b49-9c10-10dfe6cd6a8c', '2026-08-18 22:50:40', '2026-08-18 22:50:40'),
('01a01892-5da9-71d9-87ff-f853a2baeea7', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'd89f9a7e-e0eb-46f3-bfbc-70ca499da04a', '2026-08-18 22:50:40', '2026-08-18 22:50:40'),
('01a01892-5dd9-7176-9880-0cba97336f16', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'd90b19b1-3c9c-420e-a079-c10e535bba48', '2026-08-18 22:50:40', '2026-08-18 22:50:40'),
('01a01892-5df9-734b-9d34-baf8189ce901', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'd91ad3f1-fb77-46a3-b2d3-be14bf2ff54c', '2026-08-18 22:50:40', '2026-08-18 22:50:40'),
('01a01892-5e16-73de-99a0-ac2880c8098c', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'd94978bc-67db-4300-96ff-8b967e5ce310', '2026-08-18 22:50:40', '2026-08-18 22:50:40'),
('01a01892-5e32-73bd-98cd-2905baf604ce', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'd94af1de-9674-413c-9baf-5a576e5ce8de', '2026-08-18 22:50:40', '2026-08-18 22:50:40'),
('01a01892-5e4f-73c1-8240-32337dc8cc16', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'da37758a-5eeb-4c7a-b8c3-e4367b1a2afb', '2026-08-18 22:50:40', '2026-08-18 22:50:40'),
('01a01892-5e6b-7361-a97b-4b015bea336f', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'daa8f720-1d51-409c-b7b3-94263106e07a', '2026-08-18 22:50:40', '2026-08-18 22:50:40'),
('01a01892-5e8b-704b-862b-2ca2c17bd8a9', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'db66ea52-c674-4391-8ee9-fba767760767', '2026-08-18 22:50:40', '2026-08-18 22:50:40'),
('01a01892-5eb2-730b-826d-4240bf153edd', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'dbd1086c-0b8e-470b-a22d-9d0c79043f71', '2026-08-18 22:50:40', '2026-08-18 22:50:40'),
('01a01892-5edd-7043-a10b-0d94424309a9', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'de8a8b26-903f-4883-8614-2c83ecbe26d0', '2026-08-18 22:50:40', '2026-08-18 22:50:40'),
('01a01892-5f06-72f8-b831-fb765cbf2ca9', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'dfee0d86-5bea-419d-ad5a-bbecb729390b', '2026-08-18 22:50:40', '2026-08-18 22:50:40'),
('01a01892-5f30-715e-b389-225ca2ad3c4f', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'e19a840d-61dd-4181-9b47-0a57c51a1821', '2026-08-18 22:50:40', '2026-08-18 22:50:40'),
('01a01892-5f57-73ab-b6be-3fff9d39757f', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'e65b1569-6e31-4cf3-8af2-2a9eb9764ffc', '2026-08-18 22:50:40', '2026-08-18 22:50:40'),
('01a01892-5f7f-713d-92a4-86410a815610', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'e6a020c7-916e-47b9-9242-e1cfc39fc42e', '2026-08-18 22:50:41', '2026-08-18 22:50:41'),
('01a01892-5fa6-708e-ae49-1712f08980d9', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'e75bab17-8991-4660-af18-ebf9b11fc095', '2026-08-18 22:50:41', '2026-08-18 22:50:41'),
('01a01892-5fcf-7173-94e8-2024e2c206d6', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'e7c0fdee-1b90-4710-8c9b-863311d32483', '2026-08-18 22:50:41', '2026-08-18 22:50:41'),
('01a01892-5ff5-727f-bc44-d826c92c3c50', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'eaf09243-7f2c-41fd-91e3-6bef669cb324', '2026-08-18 22:50:41', '2026-08-18 22:50:41'),
('01a01892-601c-7297-902b-7e4d6849b662', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'ee37a3ca-1bf9-4893-a8d9-b2e09ca9bd56', '2026-08-18 22:50:41', '2026-08-18 22:50:41'),
('01a01892-6041-73c1-a46a-f26a86fdaa80', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'f2163dd2-fecf-4229-a070-b6a7442b0a76', '2026-08-18 22:50:41', '2026-08-18 22:50:41'),
('01a01892-6068-71eb-a169-4423749148b1', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'f5ccdc40-707b-4fd7-9497-c521948ca5c2', '2026-08-18 22:50:41', '2026-08-18 22:50:41'),
('01a01892-6090-729b-afc0-ea59cab53ad0', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'f82ac0a5-b12a-4ab7-a4da-736b28e72e73', '2026-08-18 22:50:41', '2026-08-18 22:50:41'),
('01a01892-60b7-72dc-8fb0-1fd4dc471d08', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'f925f86d-1abc-45e8-bfdf-307da2bdcd07', '2026-08-18 22:50:41', '2026-08-18 22:50:41'),
('01a01892-60df-7034-8173-b99a8f406d44', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'fb153c81-faad-4e93-9dab-88b252bdcb0f', '2026-08-18 22:50:41', '2026-08-18 22:50:41'),
('01a01892-6106-719f-9989-97447084ebe6', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'fba8d3b2-2881-4843-b623-d6d41f77c06f', '2026-08-18 22:50:41', '2026-08-18 22:50:41'),
('01a01892-6130-7009-9091-cade73d9ade4', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'fbbbf9d7-a082-4cb6-8384-2e9c709f7d69', '2026-08-18 22:50:41', '2026-08-18 22:50:41'),
('01a01892-615e-70d4-ae2f-7654610368fe', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 'febca83f-c650-4c54-a6cf-0d06a9301c08', '2026-08-18 22:50:41', '2026-08-18 22:50:41'),
('01a01892-618b-7058-8f8b-1ace2af7e933', '01a01892-33c9-721a-a9c3-32de766115f7', '01a6ceac-9323-4e5b-81eb-5904785cb371', '2026-08-18 22:50:41', '2026-08-18 22:50:41'),
('01a01892-61a8-72ee-ad1e-fc96d035bce7', '01a01892-33c9-721a-a9c3-32de766115f7', '01e17af4-b5e1-45a7-8a8e-3e46a346689c', '2026-08-18 22:50:41', '2026-08-18 22:50:41'),
('01a01892-61c4-7230-a421-88b01839bf2e', '01a01892-33c9-721a-a9c3-32de766115f7', '01fe1230-5091-4c93-8592-9d12d816c873', '2026-08-18 22:50:41', '2026-08-18 22:50:41'),
('01a01892-61dd-739f-affa-f55eac1590d9', '01a01892-33c9-721a-a9c3-32de766115f7', '02ab1587-1178-4318-a11a-75602883cb8e', '2026-08-18 22:50:41', '2026-08-18 22:50:41'),
('01a01892-61f7-718c-9ec1-e7738084db2d', '01a01892-33c9-721a-a9c3-32de766115f7', '0426f16a-9263-41bf-84be-fdba26415ae9', '2026-08-18 22:50:41', '2026-08-18 22:50:41'),
('01a01892-6212-733e-8c1c-d2added7cc94', '01a01892-33c9-721a-a9c3-32de766115f7', '04412dba-f0b0-4cf0-a936-22384d4f09de', '2026-08-18 22:50:41', '2026-08-18 22:50:41'),
('01a01892-622b-71b0-a57c-418e7f51d111', '01a01892-33c9-721a-a9c3-32de766115f7', '0506ee3f-8db9-4fb7-b2a9-5517c6872f4b', '2026-08-18 22:50:41', '2026-08-18 22:50:41'),
('01a01892-6244-7055-8b70-757b8af21d7c', '01a01892-33c9-721a-a9c3-32de766115f7', '0530a8fd-428a-4157-913f-73c048b384ec', '2026-08-18 22:50:41', '2026-08-18 22:50:41'),
('01a01892-625d-7389-a020-27ef9484509f', '01a01892-33c9-721a-a9c3-32de766115f7', '07c833c4-2d25-46eb-919e-1daa18d37932', '2026-08-18 22:50:41', '2026-08-18 22:50:41'),
('01a01892-6276-7178-9553-a85ed8dd9eb6', '01a01892-33c9-721a-a9c3-32de766115f7', '08e15b4f-473b-4440-a706-d4c5a27a063b', '2026-08-18 22:50:41', '2026-08-18 22:50:41'),
('01a01892-6290-734a-ab46-fa2bbe57ae52', '01a01892-33c9-721a-a9c3-32de766115f7', '09047564-c6b0-43ee-9325-1a60f8bc8210', '2026-08-18 22:50:41', '2026-08-18 22:50:41'),
('01a01892-62a9-71b2-ab56-286e818158a0', '01a01892-33c9-721a-a9c3-32de766115f7', '0aac9b12-2986-4461-b203-775f40299bdf', '2026-08-18 22:50:41', '2026-08-18 22:50:41'),
('01a01892-62c2-70a4-9d47-50e7dab6f674', '01a01892-33c9-721a-a9c3-32de766115f7', '0b7edae5-2603-4fca-b0b4-021958ce2007', '2026-08-18 22:50:41', '2026-08-18 22:50:41'),
('01a01892-62ea-71ab-8291-028bf72d6696', '01a01892-33c9-721a-a9c3-32de766115f7', '0d292bff-c890-4ec0-b139-cf21b197590c', '2026-08-18 22:50:41', '2026-08-18 22:50:41'),
('01a01892-6314-72db-ba31-c381d733b5ec', '01a01892-33c9-721a-a9c3-32de766115f7', '0f33f8c0-5dd6-49ea-bd65-a156fe582482', '2026-08-18 22:50:41', '2026-08-18 22:50:41'),
('01a01892-633e-73c2-8163-6de76cfbe5ac', '01a01892-33c9-721a-a9c3-32de766115f7', '0f35d3fb-1d8e-4c26-b389-3529db99acf4', '2026-08-18 22:50:41', '2026-08-18 22:50:41'),
('01a01892-6369-72ae-948a-e29101a28a38', '01a01892-33c9-721a-a9c3-32de766115f7', '1813e7c7-6603-4b01-9503-0fd3ab29c265', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-6396-724a-bd61-c5e144b89687', '01a01892-33c9-721a-a9c3-32de766115f7', '1ceb41e2-0b92-495f-97a8-429fdf2c0817', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-63c3-73ce-b62a-1698199469a5', '01a01892-33c9-721a-a9c3-32de766115f7', '1f4aee8e-7929-4596-afab-9275a64353bc', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-63ed-71c5-8dd0-362733392c31', '01a01892-33c9-721a-a9c3-32de766115f7', '21106003-e3e0-46a2-a93f-4c6aefe848a2', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-6423-7299-9ff7-aeaeb1456c9d', '01a01892-33c9-721a-a9c3-32de766115f7', '2a983594-0762-4d4b-94fe-31dae7c954aa', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-644f-72d6-b6ca-d317b90150aa', '01a01892-33c9-721a-a9c3-32de766115f7', '2d73c3d7-f395-482d-a56d-544ec82850b7', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-647b-737f-bc61-dee0779455fa', '01a01892-33c9-721a-a9c3-32de766115f7', '2f7209ea-c61c-44ac-a2fb-2fe4f4ad5942', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-64a5-72c2-ab07-2cee1b98ff87', '01a01892-33c9-721a-a9c3-32de766115f7', '322e4838-588b-4746-93cd-45a6216e1859', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-64d7-7156-aa59-bb49e3bb395c', '01a01892-33c9-721a-a9c3-32de766115f7', '335426e6-9a75-4044-bcdc-c9341953d07d', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-6508-707d-922c-f14a8dea13c6', '01a01892-33c9-721a-a9c3-32de766115f7', '358657c6-fe73-408d-8349-8bc351f14284', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-6537-712f-ae6f-828cec59f68a', '01a01892-33c9-721a-a9c3-32de766115f7', '37c8c7c4-950a-46a2-9463-0c7a3a7cbd7b', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-656b-714d-a63a-78e3671c9138', '01a01892-33c9-721a-a9c3-32de766115f7', '3d80de27-170d-4c9c-972c-db16527a3254', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-6584-739d-977d-7d59b865a750', '01a01892-33c9-721a-a9c3-32de766115f7', '3fc473e1-13f0-47ea-9596-1a0a24130463', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-6599-719a-b4db-fa973db1894d', '01a01892-33c9-721a-a9c3-32de766115f7', '4120d48b-9edd-4c50-a3fa-61479eefd67c', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-65a9-7350-a43f-28b4b718fa6c', '01a01892-33c9-721a-a9c3-32de766115f7', '413d1cc6-3b86-44fb-9184-a1f16f3f3656', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-65bb-70a3-83e4-7e825dfd4a1a', '01a01892-33c9-721a-a9c3-32de766115f7', '428e0a5c-05eb-4705-b2a6-4333f44318c2', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-65cf-7253-b75d-966ad3ae3c15', '01a01892-33c9-721a-a9c3-32de766115f7', '42ca2ce5-a3e0-4900-a0d8-6d741e9e0c68', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-65e4-73a3-8df5-002f6c5028d7', '01a01892-33c9-721a-a9c3-32de766115f7', '43825298-9466-4975-b2f5-9c8c04015647', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-65f9-7045-a9a4-a078c6c56213', '01a01892-33c9-721a-a9c3-32de766115f7', '4446aab5-0d01-49f7-bf73-79880109da89', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-6610-713b-a95c-b1e92d42f08d', '01a01892-33c9-721a-a9c3-32de766115f7', '47e1b824-ae48-4d38-a262-2f09ed748d8c', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-6629-70fb-8420-38c82c39577e', '01a01892-33c9-721a-a9c3-32de766115f7', '48802d54-e75c-4fc3-b4ed-4edeb9e1c16e', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-6641-70be-b471-b254f596715a', '01a01892-33c9-721a-a9c3-32de766115f7', '48fb488e-f265-467a-afb7-a12aded626aa', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-6657-71eb-b128-431e2085c545', '01a01892-33c9-721a-a9c3-32de766115f7', '497ec733-26b1-41de-be5e-7ca327307bbb', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-666c-7326-af25-a407b8e3a711', '01a01892-33c9-721a-a9c3-32de766115f7', '4ec4e235-c953-4aa3-b0bd-3e4a6fa61998', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-6684-71d2-8f0d-ae59bb025783', '01a01892-33c9-721a-a9c3-32de766115f7', '4eccd469-b5e3-49a4-a5c8-e38935bb4aaa', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-669b-7132-86ef-f9c1d6b45cbe', '01a01892-33c9-721a-a9c3-32de766115f7', '52678ecc-fa79-4b5e-8f1c-3115ad12dbab', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-66b0-7098-b9b4-efeca2b86c17', '01a01892-33c9-721a-a9c3-32de766115f7', '549eacd3-d424-455c-bbad-3017fbc3dee1', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-66c7-71e8-a5fe-202a4654ad97', '01a01892-33c9-721a-a9c3-32de766115f7', '57a3cf82-241c-4785-a173-d6c35b8d8b0b', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-66dc-71fa-a5fc-dc9aed4dc692', '01a01892-33c9-721a-a9c3-32de766115f7', '5cf4c998-2379-441b-8022-39fa011da378', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-66f2-7016-9c89-037853365f3f', '01a01892-33c9-721a-a9c3-32de766115f7', '60f843d0-b7d3-4d98-9899-dd5c42b867c3', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-6707-738e-915b-e92a865e0412', '01a01892-33c9-721a-a9c3-32de766115f7', '6471a78b-6866-4c5f-914b-05f5943de13f', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-671a-733d-b5af-1a5d2f231b4f', '01a01892-33c9-721a-a9c3-32de766115f7', '71abdc28-98f2-4686-a01d-d57269ca3f5e', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-6730-737e-9717-7f5fde6273ec', '01a01892-33c9-721a-a9c3-32de766115f7', '736666f9-64f2-44c2-807e-029286aea71e', '2026-08-18 22:50:42', '2026-08-18 22:50:42'),
('01a01892-6749-738a-a861-495550b911bb', '01a01892-33c9-721a-a9c3-32de766115f7', '74164ad2-dc66-4637-9787-8ea9fb7d2786', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-675d-71e7-8807-f34edd124383', '01a01892-33c9-721a-a9c3-32de766115f7', '7982e02f-5bea-46dd-989d-5d043d4c9ac8', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-6770-72ee-b26b-9fac60e9a74a', '01a01892-33c9-721a-a9c3-32de766115f7', '79ab97bb-c369-43fd-a3e7-7653379f4ca3', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-6787-7301-9b92-90721cea15fb', '01a01892-33c9-721a-a9c3-32de766115f7', '7c39b310-92b3-47fa-bb22-472ed7a3f61f', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-67a0-731e-84bf-b926abe3dcc2', '01a01892-33c9-721a-a9c3-32de766115f7', '7ca2b5d4-da4f-4e48-adf6-44a2ddff4639', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-67b9-7001-b67d-e9cfe986681b', '01a01892-33c9-721a-a9c3-32de766115f7', '7d88cba0-d0e8-4209-96d4-1d38e9384a0f', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-67d4-700a-8390-c9c39c259ed3', '01a01892-33c9-721a-a9c3-32de766115f7', '7d9cf22a-4943-474a-929a-3bb5a38cc8ad', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-67ed-72bb-b900-d698fd77b7a9', '01a01892-33c9-721a-a9c3-32de766115f7', '8608167b-6832-4961-8ebc-cbec2b0ac8f6', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-6809-7090-ab82-cdde7caf7f42', '01a01892-33c9-721a-a9c3-32de766115f7', '866c1c5e-69ce-484e-a2c5-7bd92a30d1e4', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-6824-73ab-91e9-bef8d3470606', '01a01892-33c9-721a-a9c3-32de766115f7', '86e9d092-0ade-4937-957a-694ea7a3b3c9', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-6842-7000-a59e-a45d435c7369', '01a01892-33c9-721a-a9c3-32de766115f7', '89ce14b6-887a-400a-8e26-45556ae7dcb9', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-685e-71c9-82dc-6a2db1d36cb6', '01a01892-33c9-721a-a9c3-32de766115f7', '8c8f3239-c155-4331-80b8-93049b9b6572', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-687c-7107-a6d2-1f62ccde535a', '01a01892-33c9-721a-a9c3-32de766115f7', '8fe72dd8-27ab-4832-acf1-c93416d508c6', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-6899-721f-9b5e-e42e19e22fa7', '01a01892-33c9-721a-a9c3-32de766115f7', '91eb0cc0-ef76-4958-9e2e-2b39ea5a2e10', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-68b6-7263-a6e8-07f0b5423114', '01a01892-33c9-721a-a9c3-32de766115f7', '9342d566-780a-4e18-af89-53526ba9c4d5', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-68d2-7041-b095-2b9e17954ce1', '01a01892-33c9-721a-a9c3-32de766115f7', '9485e07f-9a69-4358-bf92-3db47566634e', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-68f0-7198-850f-25d35dc69464', '01a01892-33c9-721a-a9c3-32de766115f7', '97c9a8ae-4591-4d13-af7c-816bd3933278', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-690e-7034-8ee1-c545cec79842', '01a01892-33c9-721a-a9c3-32de766115f7', '98b1126e-e4d4-4ef6-baf1-5a9476ee96b1', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-692f-71b3-8e1e-e72558244860', '01a01892-33c9-721a-a9c3-32de766115f7', '9a673591-b201-41c1-9b3f-8e094d3f2708', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-694a-7159-b16a-e64a2e186120', '01a01892-33c9-721a-a9c3-32de766115f7', '9b702b8d-0aee-4a5d-a7a6-14c86f698c9d', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-695e-72c7-a8fb-4e5d6380317e', '01a01892-33c9-721a-a9c3-32de766115f7', '9d444492-1a3b-478c-a3e2-8cdfd9ea13f0', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-6971-70ee-af95-f988fa05f64c', '01a01892-33c9-721a-a9c3-32de766115f7', '9e17057b-c02b-411a-a70b-161c809a7814', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-6989-7140-b026-f8de443f8ff9', '01a01892-33c9-721a-a9c3-32de766115f7', 'a999a49a-aced-46f1-9919-c763527b35cb', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-699d-72e6-973b-41154dcf4e22', '01a01892-33c9-721a-a9c3-32de766115f7', 'acef7df7-0747-4fea-a62b-994741b214a4', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-69b0-7031-835e-4ccf56410a09', '01a01892-33c9-721a-a9c3-32de766115f7', 'af74906a-54f3-457c-aef4-653ea224d82f', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-69c5-7164-9f0f-c973589fd0ec', '01a01892-33c9-721a-a9c3-32de766115f7', 'b12c01c4-7a23-4354-bb59-6245f0411fce', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-69d9-7375-b35d-c9c2996594c6', '01a01892-33c9-721a-a9c3-32de766115f7', 'b24b3143-ae78-43d0-9fc5-8ed975177c00', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-69ed-71f1-a845-c0a3d54ee5f9', '01a01892-33c9-721a-a9c3-32de766115f7', 'b6ad160b-67be-4b70-9715-d9d454d28b87', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-6a05-717f-b9d1-d4e218399624', '01a01892-33c9-721a-a9c3-32de766115f7', 'b84a4e4a-de13-421b-8a18-2ef75e319e9f', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-6a21-72eb-af62-d63e3c1cb5f7', '01a01892-33c9-721a-a9c3-32de766115f7', 'b87a0e99-f1eb-47d9-a336-8f7248f6a07d', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-6a3e-7385-94eb-1e9b3a811b65', '01a01892-33c9-721a-a9c3-32de766115f7', 'bc84941c-dca5-483d-af26-f3254854ffaa', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-6a52-705d-9fae-6312504851a5', '01a01892-33c9-721a-a9c3-32de766115f7', 'be57ddf7-3177-4d16-bb22-db567be94f18', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-6a6a-727d-a98d-d4b488542c2a', '01a01892-33c9-721a-a9c3-32de766115f7', 'c37423f6-c3c3-46ef-9d0b-be58f8023e0d', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-6a7b-7350-b239-c07514bd4a2e', '01a01892-33c9-721a-a9c3-32de766115f7', 'c4af4f99-70dd-489a-a8e9-eff69a44a6aa', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-6a8b-70dd-8ef7-d7ad35de4137', '01a01892-33c9-721a-a9c3-32de766115f7', 'c5673400-d772-475d-8c68-d5998a0169bb', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-6a9d-72c9-9328-c4aa16e7ac39', '01a01892-33c9-721a-a9c3-32de766115f7', 'c5b99c5f-5885-4ef9-bae3-ab1811e502af', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-6aaf-71bd-ab09-3794e869389f', '01a01892-33c9-721a-a9c3-32de766115f7', 'c5f9d6cb-10ca-4370-a314-68bfb0e298c4', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-6ac7-73d6-af7a-5da37c7411e6', '01a01892-33c9-721a-a9c3-32de766115f7', 'c668d8cc-2178-49df-90f0-f56826239046', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-6ada-739f-b3b8-d8e4d5779057', '01a01892-33c9-721a-a9c3-32de766115f7', 'c80409d4-830c-4ce7-a5c4-b83e8926e973', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-6aee-7194-9754-fc17351f567a', '01a01892-33c9-721a-a9c3-32de766115f7', 'c82ea824-81ca-4c12-ac14-c068c0ab5d9b', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-6b06-703d-af55-2aaae3faaafd', '01a01892-33c9-721a-a9c3-32de766115f7', 'c87fb4be-060a-407a-872c-b616be2efaa2', '2026-08-18 22:50:43', '2026-08-18 22:50:43'),
('01a01892-6b23-72bb-9b07-333baacfba32', '01a01892-33c9-721a-a9c3-32de766115f7', 'cb69c482-8711-4de6-94ca-e600b799ce23', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6b3f-70a4-b95a-0b9581f334d2', '01a01892-33c9-721a-a9c3-32de766115f7', 'cbb1aca6-0387-43c1-a405-56ec63f1c6ae', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6b58-70cf-8017-aa91a35cbe3b', '01a01892-33c9-721a-a9c3-32de766115f7', 'cbb43cce-4240-4816-878b-589ed0dc3077', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6b74-733c-bd76-5688d921eafa', '01a01892-33c9-721a-a9c3-32de766115f7', 'cdec27f0-78ef-4fc2-9a96-bc945f117791', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6b8e-71eb-9f6c-59b63e63c352', '01a01892-33c9-721a-a9c3-32de766115f7', 'cf6abddb-c37d-4d09-81e1-d7e1b228c295', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6ba6-7389-995d-309eaf628d16', '01a01892-33c9-721a-a9c3-32de766115f7', 'd12af9b7-18fa-4a91-a81e-1de189c7a09b', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6bc5-70ea-a378-2d2233526f49', '01a01892-33c9-721a-a9c3-32de766115f7', 'd1907d49-c67d-4999-a52e-22d97f18fad8', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6bde-7195-a770-d1f0bd33cd2c', '01a01892-33c9-721a-a9c3-32de766115f7', 'd2690199-e933-4880-af1b-06ba9e4c6b18', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6bf7-71f9-92f1-9733fb9d5609', '01a01892-33c9-721a-a9c3-32de766115f7', 'd52fe69c-0b3b-406f-8cdc-1812ca512215', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6c0f-720d-a70e-09756bd5eea1', '01a01892-33c9-721a-a9c3-32de766115f7', 'd6e9f819-a18e-4b49-9c10-10dfe6cd6a8c', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6c27-72be-84a1-aa8cdc917467', '01a01892-33c9-721a-a9c3-32de766115f7', 'd89f9a7e-e0eb-46f3-bfbc-70ca499da04a', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6c41-7334-aafa-1f83898be852', '01a01892-33c9-721a-a9c3-32de766115f7', 'd90b19b1-3c9c-420e-a079-c10e535bba48', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6c5b-736f-81da-8c1bf048ea25', '01a01892-33c9-721a-a9c3-32de766115f7', 'd91ad3f1-fb77-46a3-b2d3-be14bf2ff54c', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6c75-7360-80e5-423ad41d3fd9', '01a01892-33c9-721a-a9c3-32de766115f7', 'd94978bc-67db-4300-96ff-8b967e5ce310', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6c90-737a-bcbf-a73ee5b4b7ce', '01a01892-33c9-721a-a9c3-32de766115f7', 'd94af1de-9674-413c-9baf-5a576e5ce8de', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6ca9-70ec-8b7f-82ec4cc8d9b7', '01a01892-33c9-721a-a9c3-32de766115f7', 'da37758a-5eeb-4c7a-b8c3-e4367b1a2afb', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6cc1-713a-9e3f-a6304eb6c059', '01a01892-33c9-721a-a9c3-32de766115f7', 'daa8f720-1d51-409c-b7b3-94263106e07a', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6cda-7076-a2a9-ca319c8038a8', '01a01892-33c9-721a-a9c3-32de766115f7', 'db66ea52-c674-4391-8ee9-fba767760767', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6cf8-704a-8723-c0991073e71b', '01a01892-33c9-721a-a9c3-32de766115f7', 'dbd1086c-0b8e-470b-a22d-9d0c79043f71', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6d17-7343-bc00-8cb9e5ed89ae', '01a01892-33c9-721a-a9c3-32de766115f7', 'de8a8b26-903f-4883-8614-2c83ecbe26d0', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6d34-713a-a43f-86933af9bd5c', '01a01892-33c9-721a-a9c3-32de766115f7', 'dfee0d86-5bea-419d-ad5a-bbecb729390b', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6d50-7163-bc1c-99f691fab454', '01a01892-33c9-721a-a9c3-32de766115f7', 'e19a840d-61dd-4181-9b47-0a57c51a1821', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6d6b-7245-9d01-33fcb910d25a', '01a01892-33c9-721a-a9c3-32de766115f7', 'e65b1569-6e31-4cf3-8af2-2a9eb9764ffc', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6d89-730f-bd73-71ed52e1d60d', '01a01892-33c9-721a-a9c3-32de766115f7', 'e6a020c7-916e-47b9-9242-e1cfc39fc42e', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6da5-72dd-b0e4-b75af8182c3f', '01a01892-33c9-721a-a9c3-32de766115f7', 'e75bab17-8991-4660-af18-ebf9b11fc095', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6dc2-7057-bab9-f3e0f49f495f', '01a01892-33c9-721a-a9c3-32de766115f7', 'e7c0fdee-1b90-4710-8c9b-863311d32483', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6dd9-714b-89c5-76dd7b6532ac', '01a01892-33c9-721a-a9c3-32de766115f7', 'eaf09243-7f2c-41fd-91e3-6bef669cb324', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6df4-7289-947b-d4e288b88006', '01a01892-33c9-721a-a9c3-32de766115f7', 'ee37a3ca-1bf9-4893-a8d9-b2e09ca9bd56', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6e0c-7132-b082-56766bae5957', '01a01892-33c9-721a-a9c3-32de766115f7', 'f2163dd2-fecf-4229-a070-b6a7442b0a76', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6e24-70e2-b235-86683bb8fc67', '01a01892-33c9-721a-a9c3-32de766115f7', 'f5ccdc40-707b-4fd7-9497-c521948ca5c2', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6e3e-70ab-9bd4-69cc1042d631', '01a01892-33c9-721a-a9c3-32de766115f7', 'f82ac0a5-b12a-4ab7-a4da-736b28e72e73', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6e5c-72cb-b4fc-28926b2eb37d', '01a01892-33c9-721a-a9c3-32de766115f7', 'f925f86d-1abc-45e8-bfdf-307da2bdcd07', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6e75-73f3-b8ae-913277f1d4f6', '01a01892-33c9-721a-a9c3-32de766115f7', 'fb153c81-faad-4e93-9dab-88b252bdcb0f', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6e8e-7377-8dd2-3d262e53bbba', '01a01892-33c9-721a-a9c3-32de766115f7', 'fba8d3b2-2881-4843-b623-d6d41f77c06f', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6ea7-7319-833c-a5192e821e34', '01a01892-33c9-721a-a9c3-32de766115f7', 'fbbbf9d7-a082-4cb6-8384-2e9c709f7d69', '2026-08-18 22:50:44', '2026-08-18 22:50:44'),
('01a01892-6ec3-71b6-b87a-188a93d3d0ee', '01a01892-33c9-721a-a9c3-32de766115f7', 'febca83f-c650-4c54-a6cf-0d06a9301c08', '2026-08-18 22:50:44', '2026-08-18 22:50:44');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_account_balances`
--

CREATE TABLE `user_account_balances` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_account_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `coa_balance_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `period_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_period_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `allocated_by` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `allocated_balance` decimal(15,2) NOT NULL DEFAULT '0.00',
  `income_balance` decimal(15,2) NOT NULL DEFAULT '0.00',
  `used_balance` decimal(15,2) NOT NULL DEFAULT '0.00',
  `remaining_balance` decimal(15,2) NOT NULL DEFAULT '0.00',
  `allocated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `user_account_balances`
--

INSERT INTO `user_account_balances` (`id`, `user_account_id`, `coa_balance_id`, `period_id`, `sub_period_id`, `allocated_by`, `allocated_balance`, `income_balance`, `used_balance`, `remaining_balance`, `allocated_at`, `deleted_at`, `created_at`, `updated_at`) VALUES
('01a018e8-e8b4-71fa-b0fb-c75408c0348a', '01a01892-65bb-70a3-83e4-7e825dfd4a1a', '01a018c1-322a-70be-9a5f-bf4f8bf766e5', '01a01892-358d-7241-9d2f-3e8b59a7ef11', '01a01892-35ae-7116-95b4-4cabe8ce6031', '01a01892-30ab-7337-8cb2-5ce8dac14b8a', 4983047.00, 0.00, 402500.00, 4580547.00, '2026-08-19 00:25:12', NULL, '2026-08-19 00:25:12', '2026-08-19 00:26:33');

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `media`
--
ALTER TABLE `media`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

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
