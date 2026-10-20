-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 19 Okt 2026 pada 05.55
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
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `module` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `old_values` json DEFAULT NULL,
  `new_values` json DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `additional_data` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `manipulations` json NOT NULL,
  `custom_properties` json NOT NULL,
  `generated_conversions` json NOT NULL,
  `responsive_images` json NOT NULL,
  `order_column` int UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(25, '2026_08_30_162544_add_income_balance_to_user_account_balances_table', 1);

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
('01a1525d-4efd-70d6-8625-c9d2f8855b44', 'App\\Models\\User', '01a1525d-6225-70cd-ad6f-a9ad3ff95da8'),
('01a1525d-55cd-720f-9a8c-581d5e2b74eb', 'App\\Models\\User', '01a1525d-6541-71d8-a795-c2ec45ab6289'),
('01a1525d-5b20-7018-8871-fab0a5298acd', 'App\\Models\\User', '01a1525d-6541-71d8-a795-c2ec45ab6289'),
('01a1525d-5b20-7018-8871-fab0a5298acd', 'App\\Models\\User', '01a1525d-6864-72ea-ad31-f231a54b1b9e');

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
('01a1525d-6938-70aa-ab21-1653fea3792a', '2022', 'Fiscal year 2022', '2022-01-01', '2022-12-31', '2026-10-18 21:13:35', '2026-10-18 21:13:35'),
('01a1525d-6a17-70ce-862c-331933a6b4b0', '2023', 'Fiscal year 2023', '2023-01-01', '2023-12-31', '2026-10-18 21:13:36', '2026-10-18 21:13:36');

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
('01a1525d-4efd-70d6-8625-c9d2f8855b44', 'SUPER ADMIN', 'web', '2026-10-18 21:13:29', '2026-10-18 21:13:29'),
('01a1525d-55cd-720f-9a8c-581d5e2b74eb', 'BENDAHARA', 'web', '2026-10-18 21:13:30', '2026-10-18 21:13:30'),
('01a1525d-5b20-7018-8871-fab0a5298acd', 'ACCOUNTING USER', 'web', '2026-10-18 21:13:32', '2026-10-18 21:13:32');

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
('01a1525d-4481-7334-a768-415b31abb15e', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-44e2-72fa-84ad-df830f28faa1', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
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
('01a1525d-488c-72cd-8c12-add653d9a9a7', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-48e9-7025-9880-113d83e0c24a', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-493d-705d-b9a1-2a443ddebde6', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4989-70c7-9e56-6db37ae62def', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-49dd-73f3-8c5d-8315fb4dc7a4', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4a31-7245-82e9-751659963dc6', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4a7e-71b3-a72f-0af664510c67', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4ad4-72ae-b437-b417b395772d', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4b22-7258-bac9-4455bfc429ad', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4b6f-73a2-84a3-5e3fab7f326c', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4bd5-7046-b8cb-57c8149de27f', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4c27-72f1-b349-052d1a1771e0', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4c74-72ef-bfd5-88c33743766b', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4ccb-723f-a7fb-6a0a4b6eed7b', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4d22-731d-add3-ef1b8d24fe31', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4d69-733f-962f-a1de76f364b1', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4d9d-729f-900d-0ca9c8cde222', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4dda-732a-b6a1-7765923ba11b', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4e0f-73b8-98e6-844456e7ffa7', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4e4b-7153-9bb3-33a85d9841e9', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-4e82-73ec-b3a5-a81a160dad0a', '01a1525d-4efd-70d6-8625-c9d2f8855b44'),
('01a1525d-44e2-72fa-84ad-df830f28faa1', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-483b-716f-a8fc-70c6d055805f', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-488c-72cd-8c12-add653d9a9a7', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-48e9-7025-9880-113d83e0c24a', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-493d-705d-b9a1-2a443ddebde6', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-4989-70c7-9e56-6db37ae62def', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-49dd-73f3-8c5d-8315fb4dc7a4', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-4a31-7245-82e9-751659963dc6', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-4ad4-72ae-b437-b417b395772d', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-4b22-7258-bac9-4455bfc429ad', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-4c74-72ef-bfd5-88c33743766b', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-4ccb-723f-a7fb-6a0a4b6eed7b', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-4d69-733f-962f-a1de76f364b1', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-4d9d-729f-900d-0ca9c8cde222', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-4dda-732a-b6a1-7765923ba11b', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-4e0f-73b8-98e6-844456e7ffa7', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-4e4b-7153-9bb3-33a85d9841e9', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-4e82-73ec-b3a5-a81a160dad0a', '01a1525d-55cd-720f-9a8c-581d5e2b74eb'),
('01a1525d-483b-716f-a8fc-70c6d055805f', '01a1525d-5b20-7018-8871-fab0a5298acd'),
('01a1525d-4a7e-71b3-a72f-0af664510c67', '01a1525d-5b20-7018-8871-fab0a5298acd'),
('01a1525d-4b22-7258-bac9-4455bfc429ad', '01a1525d-5b20-7018-8871-fab0a5298acd'),
('01a1525d-4b6f-73a2-84a3-5e3fab7f326c', '01a1525d-5b20-7018-8871-fab0a5298acd'),
('01a1525d-4bd5-7046-b8cb-57c8149de27f', '01a1525d-5b20-7018-8871-fab0a5298acd'),
('01a1525d-4c27-72f1-b349-052d1a1771e0', '01a1525d-5b20-7018-8871-fab0a5298acd'),
('01a1525d-4d22-731d-add3-ef1b8d24fe31', '01a1525d-5b20-7018-8871-fab0a5298acd'),
('01a1525d-4e4b-7153-9bb3-33a85d9841e9', '01a1525d-5b20-7018-8871-fab0a5298acd'),
('01a1525d-4e82-73ec-b3a5-a81a160dad0a', '01a1525d-5b20-7018-8871-fab0a5298acd');

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
('7xapXA4iS9e1ZO6Ks1tnOthjOfd3lhRtDw4U75HF', '01a1525d-6541-71d8-a795-c2ec45ab6289', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:158.0) Gecko/20100101 Firefox/158.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiV21XOWhBMkpTYmlFeVF6UzRQOXVZajlWNnFXekZKVlM1T3pzY0dhYiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzk6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9iZW5kYWhhcmEvcGVyaW9kcyI7czo1OiJyb3V0ZSI7czoyMzoiYmVuZGFoYXJhLnBlcmlvZHMuaW5kZXgiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7czozNjoiMDFhMTUyNWQtNjU0MS03MWQ4LWE3OTUtYzJlYzQ1YWI2Mjg5Ijt9', 1792388778);

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
('01a1525d-69d6-7254-8a66-6c28c53928d8', '01a1525d-6938-70aa-ab21-1653fea3792a', 'Desember 2022', 'Bulan Desember 2022', '2022-12-01', '2022-12-31', 0, NULL, NULL, '2026-10-18 21:13:36', '2026-10-18 21:13:36'),
('01a1525d-6a46-7371-9dbf-1fc8564337e7', '01a1525d-6a17-70ce-862c-331933a6b4b0', 'Januari 2023', 'Bulan Januari 2023', '2023-01-01', '2023-01-31', 0, NULL, NULL, '2026-10-18 21:13:36', '2026-10-18 21:13:36');

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
('01a1525d-6225-70cd-ad6f-a9ad3ff95da8', 'Super Admin', NULL, NULL, 'superadmin@example.com', NULL, '$2y$12$u70avDub1.diYuFi/on.BevCwAECamoKPmYq0VzBEyyMdw67ppKi.', 1, NULL, '2026-10-18 21:13:34', '2026-10-18 21:13:34'),
('01a1525d-6541-71d8-a795-c2ec45ab6289', 'Bendahara', NULL, NULL, 'bendahara@example.com', NULL, '$2y$12$qkSos3xBU0AL.cRHdW4GjufGJPNn9v0bCgD9IJm5ijU0uyRnISEfG', 0, NULL, '2026-10-18 21:13:34', '2026-10-18 21:13:34'),
('01a1525d-6864-72ea-ad31-f231a54b1b9e', 'Pemegang Kas Operasional', NULL, NULL, 'pemegang-kas@example.com', NULL, '$2y$12$SuY0Ywnp/0lDbvHgGHvwce0OY9dA4F.uGvXHVzIlRuYRWDU54nPOW', 0, NULL, '2026-10-18 21:13:35', '2026-10-18 21:13:35');

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
  ADD CONSTRAINT `journals_period_id_foreign` FOREIGN KEY (`period_id`) REFERENCES `periods` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `journals_posted_by_foreign` FOREIGN KEY (`posted_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `journals_sub_period_id_foreign` FOREIGN KEY (`sub_period_id`) REFERENCES `sub_periods` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `journals_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE RESTRICT;

--
-- Ketidakleluasaan untuk tabel `journal_details`
--
ALTER TABLE `journal_details`
  ADD CONSTRAINT `journal_details_chart_of_account_id_foreign` FOREIGN KEY (`chart_of_account_id`) REFERENCES `chart_of_accounts` (`id`) ON DELETE RESTRICT,
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
  ADD CONSTRAINT `transactions_period_id_foreign` FOREIGN KEY (`period_id`) REFERENCES `periods` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `transactions_sub_period_id_foreign` FOREIGN KEY (`sub_period_id`) REFERENCES `sub_periods` (`id`) ON DELETE RESTRICT;

--
-- Ketidakleluasaan untuk tabel `transaction_lines`
--
ALTER TABLE `transaction_lines`
  ADD CONSTRAINT `transaction_lines_chart_of_account_id_foreign` FOREIGN KEY (`chart_of_account_id`) REFERENCES `chart_of_accounts` (`id`) ON DELETE RESTRICT,
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
