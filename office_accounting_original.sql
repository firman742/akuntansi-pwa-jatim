-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 26 Okt 2026 pada 15.51
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
('a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'ASET', 'Sumber daya ekonomi yang dimiliki perusahaan (kas, piutang, persediaan, tanah, gedung).', 1, '2026-10-26 08:49:39', '2026-10-26 08:49:39'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567891', 'KEWAJIBAN', 'Kewajiban atau hutang perusahaan kepada pihak lain (utang usaha, utang bank, obligasi).', 1, '2026-10-26 08:49:39', '2026-10-26 08:49:39'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567892', 'EKUITAS', 'Kepemilikan pemilik dalam perusahaan setelah dikurangi kewajiban (modal saham, laba ditahan).', 1, '2026-10-26 08:49:39', '2026-10-26 08:49:39'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567893', 'PENDAPATAN', 'account type representing the inflow of economic benefits from business activities.', 1, '2026-10-26 08:49:39', '2026-10-26 08:49:39'),
('a1b2c3d4-e5f6-7890-abcd-ef1234567894', 'BEBAN', 'account type representing the outflow of economic benefits incurred in the process of generating revenue.', 1, '2026-10-26 08:49:39', '2026-10-26 08:49:39');

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
('00fe8206-5de4-4464-bb78-fed9abaf240b', '22200', 'Hutang PPh 21', '17f94eb1-ae8f-4a53-a743-3534a4f27999', '2', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567891', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('060c946d-b92f-44b1-bc97-16af33559a05', '52500', 'Biaya Pengiriman', '243571d1-2611-414f-80e0-c78ce123c542', '3', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('075a4c29-6243-4713-ae36-8cdee8251117', '11820', 'PPh Dibayar Dimuka', 'bbcd6dfa-cf72-4fab-a268-5b2b5a89b58a', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('09791c21-6a67-4ad6-b647-10c0b7eaa88b', '12310', 'Akumulasi Depresiasi Kendaraan', 'ba089f97-612f-4983-9d60-931cd7543cb1', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('0a8374c0-7d1b-4ce5-9060-1a46dd0cc26e', '44000', 'Pendapatan Kerjasama', 'c8d90511-c635-4ad1-ad49-bcff8ffee93f', '2', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('0e4de3d6-7871-4ab8-a2cb-78d9d153f520', '54000', 'Biaya Persidangan', 'c8a2daf5-b32f-4802-acc2-745b8d92b5fe', '2', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('0e8661ab-6429-4353-8a0c-9eabe2aac5ae', '44003', 'Pendapatan Sewa ATC', '0a8374c0-7d1b-4ce5-9060-1a46dd0cc26e', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('118ce695-e480-40d5-8b13-dc660d96cc1b', '51005', 'Tunjangan', '888ac1c4-09bc-40c5-88aa-957f7d712787', '3', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('11d00f5f-a65c-4942-955f-2ab0d95f16a6', '52010', 'Biaya Pemeliharaan Peralatan Kantor', '243571d1-2611-414f-80e0-c78ce123c542', '3', '10', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('17f94eb1-ae8f-4a53-a743-3534a4f27999', '22000', 'Hutang Pajak', NULL, '1', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567891', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('190cba7d-ac10-4ed0-a9d6-69d6a086a4bc', '54100', 'Biaya Sidang Rutin, Pleno dll', '0e4de3d6-7871-4ab8-a2cb-78d9d153f520', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('1e76f3bd-7454-4bfe-adc9-8b93d91b99f2', '55000', 'Biaya Perjalanan Dinas', 'c8a2daf5-b32f-4802-acc2-745b8d92b5fe', '2', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('21da6646-c5f1-4c79-988c-a38ab1c923c3', '12000', 'Aset Tidak Lancar', NULL, '1', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('227ca186-b767-4ff7-bd10-51e9dcf4ab44', '11120', 'Kas di Bank Jatim', 'ef186510-a205-4f01-a15f-6727dc453c29', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:39', '2026-10-26 08:49:39', NULL),
('2302a5c7-6353-4855-b784-26b301a63f69', '44005', 'Pendapatan Inklusi', '0a8374c0-7d1b-4ce5-9060-1a46dd0cc26e', '3', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('243571d1-2611-414f-80e0-c78ce123c542', '52000', 'Biaya Tata Usaha Administrasi Kantor', 'c8a2daf5-b32f-4802-acc2-745b8d92b5fe', '2', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('2653d42e-2dbb-45ba-a52c-1720ca1a2299', '52015', 'Biaya Administrasi Kantor Lainnya', '243571d1-2611-414f-80e0-c78ce123c542', '3', '15', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('267cffdc-1ad1-4790-bfb0-2a6d5bc93930', '57208', 'Biaya Program Lembaga Budaya Seni dan Olah Raga', '5a727eb0-c46e-4576-b4f1-1cfe1f10dcda', '4', '8', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('28d2c84c-292e-498f-8da2-804717f6f5cd', '44001', 'Kerjasama Internal', '0a8374c0-7d1b-4ce5-9060-1a46dd0cc26e', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('296875d4-7cc4-42ac-98c8-98a80f91e252', '57203', 'Biaya Program Majelis Kesehatan', '5a727eb0-c46e-4576-b4f1-1cfe1f10dcda', '4', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('2bfc1b8d-d1cf-4661-8cd2-ee285bf21071', '52100', 'Biaya Kertas & ATK', '243571d1-2611-414f-80e0-c78ce123c542', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('2d7e08b1-3dfc-4b09-8bee-7791a41b7b5d', '59999', 'Biaya Sosial & Lainnya', 'c8a2daf5-b32f-4802-acc2-745b8d92b5fe', '2', '10', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:43', '2026-10-26 08:49:43', NULL),
('2f1d50b8-40a2-4cec-80d5-df6aa30f0916', '11500', 'Penyertaan Modal Bueka Assakinah', '87cf7317-479a-4a53-9bcc-ea3f882a5599', '2', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:39', '2026-10-26 08:49:39', NULL),
('382612a5-7721-45ea-9497-4552940625e3', '12510', 'Akumulasi Depresiasi Peralatan Kantor', '8858d276-827d-4a61-b448-7a0d993072fd', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('39ac1529-309d-4a2a-b8b3-7880bf49f79b', '42500', 'Kontribusi Lainnya', 'b1d08bfe-85a5-4fdc-9775-158bc0ae5d47', '3', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('3a41d0e9-17f3-4ca0-bf4e-df4a690533ef', '11400', 'Piutang Lainnya', '87cf7317-479a-4a53-9bcc-ea3f882a5599', '2', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:39', '2026-10-26 08:49:39', NULL),
('3ccbf362-36a9-4bb4-a699-a6d59ce6724c', '11810', 'PPN Masukan', 'bbcd6dfa-cf72-4fab-a268-5b2b5a89b58a', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('3ce3dff5-7454-4c42-9a20-4db27588cd53', '57210', 'Biaya Program Lingkungan Hidup dan Penanggulangan Bencana', '5a727eb0-c46e-4576-b4f1-1cfe1f10dcda', '4', '10', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('4105f060-3f48-4f5c-a43c-dbb1b6f8b079', '44004', 'Pendapatan Pembangunan ATC', '0a8374c0-7d1b-4ce5-9060-1a46dd0cc26e', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('43411e9f-1f07-433a-b4ce-a5f8ba79cea1', '43200', 'Pendapatan Deposito', 'c204ba58-c205-40e1-ae23-851e3ba09007', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('4a6cd387-3ef7-47d7-8266-f5dd0914bfb7', '55100', 'Biaya Tiket', '1e76f3bd-7454-4bfe-adc9-8b93d91b99f2', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('4acc23ea-0470-471d-8be0-f493ca9a77ae', '42400', 'Kontribusi Media', 'b1d08bfe-85a5-4fdc-9775-158bc0ae5d47', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('4d84eb39-be38-4430-a17e-ab79a369df0f', '12210', 'Akumulasi Depresiasi Gedung', '8cd50032-a781-487d-aafb-3f21273545f5', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('4e786981-39ee-4eab-89c8-a9274109c95d', '52012', 'Biaya BBM', '243571d1-2611-414f-80e0-c78ce123c542', '3', '12', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('518704ab-47cf-4315-a739-f5e343a5cf3d', '11110', 'Kas Ditangan', 'ef186510-a205-4f01-a15f-6727dc453c29', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:39', '2026-10-26 08:49:39', NULL),
('52b384d0-c5a2-4a7b-a1db-b4d77c3909c2', '31100', 'Modal Tetap', 'f3b90c16-1dfa-457a-bf5f-4c9848d3af25', '2', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567892', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('537360d6-ce3a-4a3c-8ee2-12136c4449c9', '11140', 'Kas di Bank Bukopin Syariah', 'ef186510-a205-4f01-a15f-6727dc453c29', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:39', '2026-10-26 08:49:39', NULL),
('5491948d-680f-4956-9f36-0eded0de55ea', '59200', 'Biaya Bunga Bank', '5c8ad9a2-ea11-4f7f-be35-cd84747e6636', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:43', '2026-10-26 08:49:43', NULL),
('5546a565-7dc8-40d8-b127-49db911b342d', '41300', 'Zakat Infaq Shadaqoh Organisasi', 'c67f4eef-1d03-4ea5-bf62-81d1482114d2', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('576c5c92-1183-40a9-99f7-123675b1afcf', '52013', 'Biaya Parkir', '243571d1-2611-414f-80e0-c78ce123c542', '3', '13', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('582f672f-a2c6-4c01-b727-0a0d99dd7842', '59100', 'Biaya Pajak Bank', '5c8ad9a2-ea11-4f7f-be35-cd84747e6636', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:43', '2026-10-26 08:49:43', NULL),
('59022a3a-6ae8-462b-a555-621b74ed7b4d', '22100', 'Hutang PPN', '17f94eb1-ae8f-4a53-a743-3534a4f27999', '2', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567891', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('5a0b491f-76cc-4f6c-bba0-398c05dbba55', '55200', 'Biaya Transport Lokal', '1e76f3bd-7454-4bfe-adc9-8b93d91b99f2', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('5a727eb0-c46e-4576-b4f1-1cfe1f10dcda', '57200', 'Biaya Pelaksanaan Program Majelis & Lembaga', 'e26fb7d7-9833-4852-abc8-17a29f5c394c', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('5c7be6d6-96f5-4b45-8bae-d4da3fda1860', '41100', 'Iuran Anggota', 'c67f4eef-1d03-4ea5-bf62-81d1482114d2', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('5c8ad9a2-ea11-4f7f-be35-cd84747e6636', '59000', 'Biaya Administrasi Bank', 'c8a2daf5-b32f-4802-acc2-745b8d92b5fe', '2', '9', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:43', '2026-10-26 08:49:43', NULL),
('5e3fa800-65c8-4332-b8f9-b5816af352e1', '43100', 'Pendapatan Bunga Bank', 'c204ba58-c205-40e1-ae23-851e3ba09007', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('6397a108-e2a0-4016-ba7d-a974e80f329c', '57700', 'Biaya Pembangunan ATC', 'e26fb7d7-9833-4852-abc8-17a29f5c394c', '3', '7', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('6f33064a-d39c-4cbd-8275-3218b594eb13', '22300', 'Hutang PPh 23', '17f94eb1-ae8f-4a53-a743-3534a4f27999', '2', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567891', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('6f5a0830-1fd5-4a4b-b43d-39f7ac5ade44', '11200', 'Kas Bon', '87cf7317-479a-4a53-9bcc-ea3f882a5599', '2', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:39', '2026-10-26 08:49:39', NULL),
('70130f83-fb4c-4a3b-9ec7-310a5e77d77c', '11300', 'Piutang Karyawan', '87cf7317-479a-4a53-9bcc-ea3f882a5599', '2', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:39', '2026-10-26 08:49:39', NULL),
('72fcf4af-1f84-418e-8696-5eec4fa7a2c1', '42300', 'Kontribusi Bidang Ekonomi', 'b1d08bfe-85a5-4fdc-9775-158bc0ae5d47', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('73da2879-9781-4b50-a9a4-a40187489f6c', '44002', 'Kerjasama Eksternal', '0a8374c0-7d1b-4ce5-9060-1a46dd0cc26e', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('779e801f-478a-480e-80ec-970fdbeee55e', '58200', 'Dana Sehat Muhammadiyah', 'c6875d95-4073-4bdb-b4e7-2c8f99bc1a02', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:43', '2026-10-26 08:49:43', NULL),
('7fa4f69a-037e-4329-8a14-c917a8731a16', '12410', 'Akumulasi Depresiasi Meubel', 'eb2f0e66-9974-4af8-9d89-292efcb7fda5', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('8221386d-cd9f-4801-9404-61b09739fe7e', '21000', 'Hutang Pihak Lain', NULL, '1', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567891', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('85e9abe8-a5d6-47b2-ac9b-f33398f00b4d', '52014', 'Biaya Komunikasi', '243571d1-2611-414f-80e0-c78ce123c542', '3', '14', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('87cf7317-479a-4a53-9bcc-ea3f882a5599', '11000', 'Aset Lancar', NULL, '1', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:39', '2026-10-26 08:49:39', NULL),
('8858d276-827d-4a61-b448-7a0d993072fd', '12500', 'Peralatan Kantor', '21da6646-c5f1-4c79-988c-a38ab1c923c3', '2', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('888ac1c4-09bc-40c5-88aa-957f7d712787', '51000', 'Biaya Personalia', 'c8a2daf5-b32f-4802-acc2-745b8d92b5fe', '2', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('8a469fcd-df62-4293-abff-74894c69d82d', '57300', 'Biaya kehumasan', 'e26fb7d7-9833-4852-abc8-17a29f5c394c', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('8a5db526-884c-4bc9-b6e3-1c858e48304e', '53200', 'Depresiasi Kendaraan', 'c0f253ee-bdd5-44ae-b1f1-f18531b896a4', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('8c9361c4-5f24-4060-a5d0-b52d792660ec', '31200', 'Modal Lancar', 'f3b90c16-1dfa-457a-bf5f-4c9848d3af25', '2', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567892', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('8cd50032-a781-487d-aafb-3f21273545f5', '12200', 'Gedung', '21da6646-c5f1-4c79-988c-a38ab1c923c3', '2', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('92947efa-ec89-4603-8996-fca687c3f859', '41400', 'Muhammadiyah', 'c67f4eef-1d03-4ea5-bf62-81d1482114d2', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('9b655e80-669c-4fc5-91f2-49695c3e7a31', '58100', 'Tunjangan Hari Raya', 'c6875d95-4073-4bdb-b4e7-2c8f99bc1a02', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:43', '2026-10-26 08:49:43', NULL),
('9c58d8d4-7b71-4e6d-932a-d8b4ffee6efc', '54400', 'Biaya Sidang Muktamar', '0e4de3d6-7871-4ab8-a2cb-78d9d153f520', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('9d4d2219-1e14-450b-8536-a57518f3d206', '51002', 'Honorarium/Kontrak', '888ac1c4-09bc-40c5-88aa-957f7d712787', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('a0d4fbf4-c863-4099-88d3-4352ca940537', '53100', 'Depresiasi Gedung', 'c0f253ee-bdd5-44ae-b1f1-f18531b896a4', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('a1d4e8e1-4883-4496-9070-dc2bd789e7c6', '31300', 'Selisih Lebih/Kurang', 'f3b90c16-1dfa-457a-bf5f-4c9848d3af25', '2', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567892', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('a55143c3-4b6a-4218-83be-5c8963c15052', '11700', 'Kos Wonorejo', '87cf7317-479a-4a53-9bcc-ea3f882a5599', '2', '7', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('a57a27ec-2ea0-4f18-b357-7a564795acc9', '22400', 'Hutang PPh Final', '17f94eb1-ae8f-4a53-a743-3534a4f27999', '2', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567891', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('a593b53c-6280-4e26-beba-63d72a9d791a', '57400', 'Biaya Diskusi dan Kajian', 'e26fb7d7-9833-4852-abc8-17a29f5c394c', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('a5f17f0d-1ad6-405d-9154-d21cb28fd78a', '51001', 'Biaya Gaji Karyawan & Staf', '888ac1c4-09bc-40c5-88aa-957f7d712787', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('a66c8e9d-9ec1-4cb8-bc14-c8caa8057a68', '12600', 'Investasi Jangka Panjang', '21da6646-c5f1-4c79-988c-a38ab1c923c3', '2', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('a8ce5ac4-c2e6-4b38-b680-01260bbee21e', '41500', 'Dana Bantuan Organisasi Lainnya', 'c67f4eef-1d03-4ea5-bf62-81d1482114d2', '3', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('a8e717ce-4a8c-488f-a626-fb7b7514ff0a', '42100', 'Kontribusi Bidang Pendidikan', 'b1d08bfe-85a5-4fdc-9775-158bc0ae5d47', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('a979cdeb-4818-4a5a-9705-c6386b166377', '52900', 'Biaya Pemeliharaan Meubel', '243571d1-2611-414f-80e0-c78ce123c542', '3', '9', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('b0e97569-56d9-4d7d-ab1f-222b14860415', '57204', 'Biaya Program Ekonomi dan Ketenagakerjaan', '5a727eb0-c46e-4576-b4f1-1cfe1f10dcda', '4', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('b151e6cb-ce28-4246-8bd5-123a2ca0d732', '55300', 'Biaya Akomodasi', '1e76f3bd-7454-4bfe-adc9-8b93d91b99f2', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('b18adc1b-368b-49c9-acf1-b0acf608a58a', '57209', 'Biaya Program Penelitian dan Pengembangan Aisyiyah', '5a727eb0-c46e-4576-b4f1-1cfe1f10dcda', '4', '9', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('b1d08bfe-85a5-4fdc-9775-158bc0ae5d47', '42000', 'Kontribusi Amal Usaha', 'c8d90511-c635-4ad1-ad49-bcff8ffee93f', '2', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('b2c28f62-296c-420b-8d83-89f0b4b391d5', '54300', 'Biaya Sidang Tanwir', '0e4de3d6-7871-4ab8-a2cb-78d9d153f520', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('b357c858-9d40-4e5e-9a23-83d9cb7b3464', '57600', 'Biaya operasional ATC', 'e26fb7d7-9833-4852-abc8-17a29f5c394c', '3', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('b690a6ad-2e68-4bc5-9e8b-b9f6cdab3177', '54200', 'Biaya Sidang Muswil/Muspimwil/Konsolidasi & Pembinaan AMM', '0e4de3d6-7871-4ab8-a2cb-78d9d153f520', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('b7215705-3121-44fa-bfcb-96676de37761', '57205', 'Biaya Program Pimbinaan Kader', '5a727eb0-c46e-4576-b4f1-1cfe1f10dcda', '4', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('b8d3eca6-a9cb-4b9e-81a7-662865a51e1b', '53300', 'Depresiasi Meubel', 'c0f253ee-bdd5-44ae-b1f1-f18531b896a4', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('ba089f97-612f-4983-9d60-931cd7543cb1', '12300', 'Kendaraan', '21da6646-c5f1-4c79-988c-a38ab1c923c3', '2', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('bbcd6dfa-cf72-4fab-a268-5b2b5a89b58a', '11800', 'Pajak Dibayar Dimuka', '87cf7317-479a-4a53-9bcc-ea3f882a5599', '2', '8', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('bc1b0528-5e52-4cd5-9534-8f97cee2ba59', '52400', 'Biaya Cetak-Cetak', '243571d1-2611-414f-80e0-c78ce123c542', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('beb6b15b-4598-4f4c-8fe6-04bb0122cbb4', '11600', 'Tabungan Bueka Assakinah', '87cf7317-479a-4a53-9bcc-ea3f882a5599', '2', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('c0f253ee-bdd5-44ae-b1f1-f18531b896a4', '53000', 'Biaya Depresiasi Aset Tetap', 'c8a2daf5-b32f-4802-acc2-745b8d92b5fe', '2', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('c204ba58-c205-40e1-ae23-851e3ba09007', '43000', 'Pendapatan Jasa Bank (Neto)', 'c8d90511-c635-4ad1-ad49-bcff8ffee93f', '2', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('c28a7f10-f2dd-456f-b1f8-072e30066f9e', '52700', 'Biaya Pemeliharaan Kendaraan', '243571d1-2611-414f-80e0-c78ce123c542', '3', '7', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('c52e7c4f-1662-4a8d-88de-8e5a908ceb64', '57206', 'Biaya Program Kesejahteraan Sosial', '5a727eb0-c46e-4576-b4f1-1cfe1f10dcda', '4', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('c67f4eef-1d03-4ea5-bf62-81d1482114d2', '41000', 'Pendapatan Organisasi', 'c8d90511-c635-4ad1-ad49-bcff8ffee93f', '2', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('c6875d95-4073-4bdb-b4e7-2c8f99bc1a02', '58000', 'Biaya Kesejahteraan', 'c8a2daf5-b32f-4802-acc2-745b8d92b5fe', '2', '8', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:43', '2026-10-26 08:49:43', NULL),
('c8a2daf5-b32f-4802-acc2-745b8d92b5fe', '50000', 'Beban Operasional', NULL, '1', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('c8d90511-c635-4ad1-ad49-bcff8ffee93f', '40000', 'Pendapatan', NULL, '1', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('c9c85fd6-264e-4abe-9bff-56e58f94ffe9', '56000', 'Biaya Pengembangan SDM', 'c8a2daf5-b32f-4802-acc2-745b8d92b5fe', '2', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('cc1d52d3-00dd-456c-8c37-df57a3b32390', '52200', 'Biaya Listrik, Telepon, Air, & Internet', '243571d1-2611-414f-80e0-c78ce123c542', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('d0f59aba-e381-483c-8b2d-cb1c7105212a', '57201', 'Biaya Program Majelis Tablig dan Ketarjihan', '5a727eb0-c46e-4576-b4f1-1cfe1f10dcda', '4', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('d1daf181-917a-4d18-aadf-424bf4567e9b', '57500', 'Biaya Pelaksanaan Program Kerjasama', 'e26fb7d7-9833-4852-abc8-17a29f5c394c', '3', '5', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('d492e381-fde3-4b05-b5db-2052991b4b14', '52600', 'Biaya Pemeliharaan Gedung', '243571d1-2611-414f-80e0-c78ce123c542', '3', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('d53b8dbe-ff2e-49a7-af5b-07e637b7d5a8', '42200', 'Kontribusi Bidang Kesehatan', 'b1d08bfe-85a5-4fdc-9775-158bc0ae5d47', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('d67ba097-7304-4f50-88ac-09d7861be068', '52300', 'Biaya surat kabar & langganan Media', '243571d1-2611-414f-80e0-c78ce123c542', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('d7d1b910-283c-44f7-8c77-a239525d6e76', '41600', 'Simpanan Wajib Peserta', 'c67f4eef-1d03-4ea5-bf62-81d1482114d2', '3', '6', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('d8421532-26f6-496d-9fa7-7e7b651c7f00', '41200', 'Dana Wajib Organisasi', 'c67f4eef-1d03-4ea5-bf62-81d1482114d2', '3', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567893', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('d8f4adfa-92dd-45bc-8351-e31ab7fc31a6', '51004', 'Uang Makan Karyawan & Staf', '888ac1c4-09bc-40c5-88aa-957f7d712787', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('d98f903d-31ed-4641-ab25-f8e6ca3a28bd', '57207', 'Biaya Program Majelis Hukum dan HAM', '5a727eb0-c46e-4576-b4f1-1cfe1f10dcda', '4', '7', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('db39ba3a-7633-4395-aae9-6266af17a70a', '52800', 'Biaya Asuransi kendaraan', '243571d1-2611-414f-80e0-c78ce123c542', '3', '8', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('dcd694f6-adde-466b-830f-0b845f821235', '59300', 'Biaya Materai', '5c8ad9a2-ea11-4f7f-be35-cd84747e6636', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:43', '2026-10-26 08:49:43', NULL),
('dce7bb80-5f22-4790-ae2c-d8de0e5a2111', '52011', 'Biaya Kerumahtanggaan', '243571d1-2611-414f-80e0-c78ce123c542', '3', '11', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('e26fb7d7-9833-4852-abc8-17a29f5c394c', '57000', 'Biaya Program Organisasi', 'c8a2daf5-b32f-4802-acc2-745b8d92b5fe', '2', '7', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('e47f43ee-cab8-453b-9b2e-055063fc19cc', '12100', 'Tanah', '21da6646-c5f1-4c79-988c-a38ab1c923c3', '2', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('e5575c00-dc67-4f46-83be-3663e70e8e2d', '53400', 'Depresiasi Peralatan Kantor', 'c0f253ee-bdd5-44ae-b1f1-f18531b896a4', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('ea66d41d-bca2-4f8c-8de8-e12dd1ea7d86', '57800', 'Biaya Operasional Inklusi', 'e26fb7d7-9833-4852-abc8-17a29f5c394c', '3', '8', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:43', '2026-10-26 08:49:43', NULL),
('eb1165a5-d589-4bd1-91f0-62f83fbe59b3', '58300', 'Hadiah', 'c6875d95-4073-4bdb-b4e7-2c8f99bc1a02', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:43', '2026-10-26 08:49:43', NULL),
('eb2f0e66-9974-4af8-9d89-292efcb7fda5', '12400', 'Meubel', '21da6646-c5f1-4c79-988c-a38ab1c923c3', '2', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('ec8321b0-b035-4ebf-9e4f-2b02be268ebc', '11130', 'Kas di Bank Jatim Dr. Soetomo', 'ef186510-a205-4f01-a15f-6727dc453c29', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:39', '2026-10-26 08:49:39', NULL),
('ede5f559-c814-4468-91a2-8fff2e1e023f', '57202', 'Biaya Program Pendidikan Anak Usia Dini, Dasar dan Menengah', '5a727eb0-c46e-4576-b4f1-1cfe1f10dcda', '4', '2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('ef186510-a205-4f01-a15f-6727dc453c29', '11100', 'Kas', '87cf7317-479a-4a53-9bcc-ea3f882a5599', '2', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', NULL, 'DEBIT', 1, NULL, '2026-10-26 08:49:39', '2026-10-26 08:49:39', NULL),
('f12f69db-121e-4c4f-9f2c-efb3c95a2aad', '51003', 'Insentif Lembur Karyawan & Staf', '888ac1c4-09bc-40c5-88aa-957f7d712787', '3', '3', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:41', '2026-10-26 08:49:41', NULL),
('f3b90c16-1dfa-457a-bf5f-4c9848d3af25', '31000', 'Aset Bersih', NULL, '1', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567892', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:40', '2026-10-26 08:49:40', NULL),
('fba683c0-92b9-4b48-93d3-0f012c3a5e74', '55400', 'Perdiem Pengiriman Utusan', '1e76f3bd-7454-4bfe-adc9-8b93d91b99f2', '3', '4', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL),
('fcc90cce-c7be-4056-9cce-0fcbe23f47cb', '57100', 'Biaya Pelaksanaan Program', 'e26fb7d7-9833-4852-abc8-17a29f5c394c', '3', '1', 'a1b2c3d4-e5f6-7890-abcd-ef1234567894', NULL, 'CREDIT', 1, NULL, '2026-10-26 08:49:42', '2026-10-26 08:49:42', NULL);

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
('01a178e7-0e2a-718b-9baa-e74a5afccf1e', 'APP_NAME', 'My Laravel App', 'string', 'Nama aplikasi yang akan ditampilkan di berbagai tempat seperti judul halaman.', 1, '2026-10-26 08:49:30', '2026-10-26 08:49:30'),
('01a178e7-0f0c-72b2-adec-c39cdfa259d9', 'APP_DESCRIPTION', 'Sistem Informasi Akuntansi untuk pengelolaan keuangan, jurnal, dan laporan secara terintegrasi.', 'string', 'Deskripsi singkat tentang aplikasi yang dapat digunakan untuk SEO atau ditampilkan di halaman utama.', 1, '2026-10-26 08:49:31', '2026-10-26 08:49:31'),
('01a178e7-0f25-7049-a6a7-3e3f9ba9eafc', 'APP_TAGLINE', 'Sistem Informasi Akuntansi untuk pengelolaan keuangan, jurnal, dan laporan secara terintegrasi.', 'string', 'Tagline atau slogan yang menggambarkan nilai utama aplikasi.', 1, '2026-10-26 08:49:31', '2026-10-26 08:49:31'),
('01a178e7-0f45-731d-b877-8283c66a7534', 'APP_LOGO', NULL, 'image', 'Logo aplikasi yang akan ditampilkan di header atau halaman login.', 1, '2026-10-26 08:49:31', '2026-10-26 08:49:31'),
('01a178e7-0f60-7085-a281-f9ae8de911fc', 'APP_BACKGROUND_LOGIN', NULL, 'image', 'Gambar latar belakang untuk halaman login aplikasi.', 1, '2026-10-26 08:49:31', '2026-10-26 08:49:31');

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
('01a178e7-179c-733c-9c6f-f42c2add9e54', 'App\\Models\\User', '01a178e7-2929-7095-9125-2d1b6d38f03d'),
('01a178e7-1c84-71c2-a6ab-1e0a1e7ef023', 'App\\Models\\User', '01a178e7-2b56-7014-a410-d83dde9db2a9'),
('01a178e7-2068-73ea-ab61-cc683e7d19d2', 'App\\Models\\User', '01a178e7-2b56-7014-a410-d83dde9db2a9'),
('01a178e7-2068-73ea-ab61-cc683e7d19d2', 'App\\Models\\User', '01a178e7-2d77-731a-bae5-57307b7db827');

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
('01a178e7-2e44-7053-916c-185e4778c5fd', '2022', 'Fiscal year 2022', '2022-01-01', '2022-12-31', '2026-10-26 08:49:39', '2026-10-26 08:49:39'),
('01a178e7-2f04-7036-8a64-5ae3fda5165b', '2023', 'Fiscal year 2023', '2023-01-01', '2023-12-31', '2026-10-26 08:49:39', '2026-10-26 08:49:39');

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
('01a178e7-11c4-7146-96c6-f5c2b82b76b5', 'view dashboard superadmin', 'web', 'Dashboard', 'Akses dashboard superadmin', 1, '2026-10-26 08:49:31', '2026-10-26 08:49:31'),
('01a178e7-11ea-7014-838d-946214291a11', 'view dashboard bendahara', 'web', 'Dashboard', 'Akses dashboard bendahara', 1, '2026-10-26 08:49:31', '2026-10-26 08:49:31'),
('01a178e7-1211-700f-aad4-8e17d91c62be', 'user view', 'web', 'User Management', 'Melihat data user', 1, '2026-10-26 08:49:31', '2026-10-26 08:49:31'),
('01a178e7-1238-71e9-b21a-62a6bbe31b26', 'user create', 'web', 'User Management', 'Membuat user baru', 1, '2026-10-26 08:49:31', '2026-10-26 08:49:31'),
('01a178e7-125d-70e9-942f-74cb9e540cc2', 'user update', 'web', 'User Management', 'Mengubah data user', 1, '2026-10-26 08:49:31', '2026-10-26 08:49:31'),
('01a178e7-1282-73f9-a861-09012ebd28f1', 'user delete', 'web', 'User Management', 'Menghapus user', 1, '2026-10-26 08:49:31', '2026-10-26 08:49:31'),
('01a178e7-12a8-712a-b7f6-f967e73e33be', 'role view', 'web', 'Role & Permission', 'Melihat role', 1, '2026-10-26 08:49:31', '2026-10-26 08:49:31'),
('01a178e7-12ce-711a-b44f-535853bad44f', 'role create', 'web', 'Role & Permission', 'Membuat role', 1, '2026-10-26 08:49:31', '2026-10-26 08:49:31'),
('01a178e7-12f6-7312-8811-b59f9f9d6ae6', 'role update', 'web', 'Role & Permission', 'Mengubah role', 1, '2026-10-26 08:49:32', '2026-10-26 08:49:32'),
('01a178e7-1321-7200-82c4-299432f7378e', 'role delete', 'web', 'Role & Permission', 'Menghapus role', 1, '2026-10-26 08:49:32', '2026-10-26 08:49:32'),
('01a178e7-1346-737e-ab86-50e62db8e094', 'permission view', 'web', 'Role & Permission', 'Melihat permission', 1, '2026-10-26 08:49:32', '2026-10-26 08:49:32'),
('01a178e7-136c-717d-a0b1-7bbb77e1dace', 'permission create', 'web', 'Role & Permission', 'Membuat permission', 1, '2026-10-26 08:49:32', '2026-10-26 08:49:32'),
('01a178e7-139a-7137-b61f-e8dae7b4e49a', 'permission update', 'web', 'Role & Permission', 'Mengubah permission', 1, '2026-10-26 08:49:32', '2026-10-26 08:49:32'),
('01a178e7-13c0-7340-80df-547f88b2960f', 'permission delete', 'web', 'Role & Permission', 'Menghapus permission', 1, '2026-10-26 08:49:32', '2026-10-26 08:49:32'),
('01a178e7-13e6-73c2-b6f8-2cc065a5f41d', 'coa view', 'web', 'Master COA', 'Melihat chart of account', 1, '2026-10-26 08:49:32', '2026-10-26 08:49:32'),
('01a178e7-140b-700c-9ddc-12a8da52ffad', 'coa create', 'web', 'Master COA', 'Membuat akun COA', 1, '2026-10-26 08:49:32', '2026-10-26 08:49:32'),
('01a178e7-1430-71b5-a68f-deabede7b0e7', 'coa update', 'web', 'Master COA', 'Mengubah akun COA', 1, '2026-10-26 08:49:32', '2026-10-26 08:49:32'),
('01a178e7-145b-73ef-aa6e-015fb5bf2fe9', 'coa delete', 'web', 'Master COA', 'Menghapus akun COA', 1, '2026-10-26 08:49:32', '2026-10-26 08:49:32'),
('01a178e7-1484-73e3-8840-5fba53747e66', 'coa import', 'web', 'Master COA', 'Import akun COA', 0, '2026-10-26 08:49:32', '2026-10-26 08:49:32'),
('01a178e7-14aa-737c-ab8f-685d52cce676', 'coa assign user', 'web', 'Master COA', 'Menambahkan user ke COA', 0, '2026-10-26 08:49:32', '2026-10-26 08:49:32'),
('01a178e7-14d0-7160-81f6-a9a02e2d5340', 'coa remove user', 'web', 'Master COA', 'Menghapus user dari COA', 0, '2026-10-26 08:49:32', '2026-10-26 08:49:32'),
('01a178e7-14f5-7304-a047-9e14e1360831', 'coa request create', 'web', 'Master COA', 'Request pembuatan akun COA', 0, '2026-10-26 08:49:32', '2026-10-26 08:49:32'),
('01a178e7-151b-717b-8fcf-c8a8a826dd40', 'journal post', 'web', 'Transactions', 'Posting jurnal umum', 1, '2026-10-26 08:49:32', '2026-10-26 08:49:32'),
('01a178e7-1543-707c-b7b9-5dd51443b578', 'journal view', 'web', 'Transactions', 'Melihat jurnal umum', 1, '2026-10-26 08:49:32', '2026-10-26 08:49:32'),
('01a178e7-1568-701b-a2ab-952771119f98', 'transaction income create', 'web', 'Transactions', 'Input transaksi pemasukan', 1, '2026-10-26 08:49:32', '2026-10-26 08:49:32'),
('01a178e7-158d-72ce-90d0-98afe2a478f1', 'transaction expense create', 'web', 'Transactions', 'Input transaksi pengeluaran', 1, '2026-10-26 08:49:32', '2026-10-26 08:49:32'),
('01a178e7-15b1-702a-96dd-1fab4e080697', 'transaction import', 'web', 'Transactions', 'Import transaksi', 0, '2026-10-26 08:49:32', '2026-10-26 08:49:32'),
('01a178e7-15d6-739f-949c-eaaa299b7133', 'ledger create', 'web', 'Ledger', 'Generate buku besar', 1, '2026-10-26 08:49:32', '2026-10-26 08:49:32'),
('01a178e7-15fc-738d-9223-eeba85682419', 'ledger view', 'web', 'Ledger', 'Melihat buku besar', 1, '2026-10-26 08:49:32', '2026-10-26 08:49:32'),
('01a178e7-1621-7006-8871-c5df1c38be73', 'ledger view by account', 'web', 'Ledger', 'Melihat buku besar per akun', 1, '2026-10-26 08:49:32', '2026-10-26 08:49:32'),
('01a178e7-1647-7020-a2af-56528a6967a8', 'report general journal view', 'web', 'Reports', 'Melihat laporan jurnal umum', 1, '2026-10-26 08:49:32', '2026-10-26 08:49:32'),
('01a178e7-1675-7103-a076-687a789ab6ae', 'report general journal export', 'web', 'Reports', 'Export laporan jurnal umum', 0, '2026-10-26 08:49:32', '2026-10-26 08:49:32'),
('01a178e7-16a0-716e-b695-0fc70cdc015f', 'report trial balance view', 'web', 'Reports', 'Melihat neraca saldo', 1, '2026-10-26 08:49:32', '2026-10-26 08:49:32'),
('01a178e7-16c8-7369-80a8-94fddcfa6827', 'report trial balance export', 'web', 'Reports', 'Export neraca saldo', 0, '2026-10-26 08:49:33', '2026-10-26 08:49:33'),
('01a178e7-16ec-7107-8605-f3f4c5365420', 'report ledger view', 'web', 'Reports', 'Melihat laporan buku besar', 1, '2026-10-26 08:49:33', '2026-10-26 08:49:33'),
('01a178e7-1710-7012-a41d-8af90fca4a40', 'report ledger export', 'web', 'Reports', 'Export laporan buku besar', 0, '2026-10-26 08:49:33', '2026-10-26 08:49:33');

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
('01a178e7-179c-733c-9c6f-f42c2add9e54', 'SUPER ADMIN', 'web', '2026-10-26 08:49:33', '2026-10-26 08:49:33'),
('01a178e7-1c84-71c2-a6ab-1e0a1e7ef023', 'BENDAHARA', 'web', '2026-10-26 08:49:34', '2026-10-26 08:49:34'),
('01a178e7-2068-73ea-ab61-cc683e7d19d2', 'ACCOUNTING USER', 'web', '2026-10-26 08:49:35', '2026-10-26 08:49:35');

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
('01a178e7-11c4-7146-96c6-f5c2b82b76b5', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-11ea-7014-838d-946214291a11', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-1211-700f-aad4-8e17d91c62be', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-1238-71e9-b21a-62a6bbe31b26', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-125d-70e9-942f-74cb9e540cc2', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-1282-73f9-a861-09012ebd28f1', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-12a8-712a-b7f6-f967e73e33be', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-12ce-711a-b44f-535853bad44f', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-12f6-7312-8811-b59f9f9d6ae6', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-1321-7200-82c4-299432f7378e', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-1346-737e-ab86-50e62db8e094', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-136c-717d-a0b1-7bbb77e1dace', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-139a-7137-b61f-e8dae7b4e49a', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-13c0-7340-80df-547f88b2960f', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-13e6-73c2-b6f8-2cc065a5f41d', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-140b-700c-9ddc-12a8da52ffad', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-1430-71b5-a68f-deabede7b0e7', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-145b-73ef-aa6e-015fb5bf2fe9', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-1484-73e3-8840-5fba53747e66', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-14aa-737c-ab8f-685d52cce676', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-14d0-7160-81f6-a9a02e2d5340', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-14f5-7304-a047-9e14e1360831', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-151b-717b-8fcf-c8a8a826dd40', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-1543-707c-b7b9-5dd51443b578', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-1568-701b-a2ab-952771119f98', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-158d-72ce-90d0-98afe2a478f1', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-15b1-702a-96dd-1fab4e080697', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-15d6-739f-949c-eaaa299b7133', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-15fc-738d-9223-eeba85682419', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-1621-7006-8871-c5df1c38be73', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-1647-7020-a2af-56528a6967a8', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-1675-7103-a076-687a789ab6ae', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-16a0-716e-b695-0fc70cdc015f', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-16c8-7369-80a8-94fddcfa6827', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-16ec-7107-8605-f3f4c5365420', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-1710-7012-a41d-8af90fca4a40', '01a178e7-179c-733c-9c6f-f42c2add9e54'),
('01a178e7-11ea-7014-838d-946214291a11', '01a178e7-1c84-71c2-a6ab-1e0a1e7ef023'),
('01a178e7-13e6-73c2-b6f8-2cc065a5f41d', '01a178e7-1c84-71c2-a6ab-1e0a1e7ef023'),
('01a178e7-140b-700c-9ddc-12a8da52ffad', '01a178e7-1c84-71c2-a6ab-1e0a1e7ef023'),
('01a178e7-1430-71b5-a68f-deabede7b0e7', '01a178e7-1c84-71c2-a6ab-1e0a1e7ef023'),
('01a178e7-145b-73ef-aa6e-015fb5bf2fe9', '01a178e7-1c84-71c2-a6ab-1e0a1e7ef023'),
('01a178e7-1484-73e3-8840-5fba53747e66', '01a178e7-1c84-71c2-a6ab-1e0a1e7ef023'),
('01a178e7-14aa-737c-ab8f-685d52cce676', '01a178e7-1c84-71c2-a6ab-1e0a1e7ef023'),
('01a178e7-14d0-7160-81f6-a9a02e2d5340', '01a178e7-1c84-71c2-a6ab-1e0a1e7ef023'),
('01a178e7-151b-717b-8fcf-c8a8a826dd40', '01a178e7-1c84-71c2-a6ab-1e0a1e7ef023'),
('01a178e7-1543-707c-b7b9-5dd51443b578', '01a178e7-1c84-71c2-a6ab-1e0a1e7ef023'),
('01a178e7-15d6-739f-949c-eaaa299b7133', '01a178e7-1c84-71c2-a6ab-1e0a1e7ef023'),
('01a178e7-15fc-738d-9223-eeba85682419', '01a178e7-1c84-71c2-a6ab-1e0a1e7ef023'),
('01a178e7-1647-7020-a2af-56528a6967a8', '01a178e7-1c84-71c2-a6ab-1e0a1e7ef023'),
('01a178e7-1675-7103-a076-687a789ab6ae', '01a178e7-1c84-71c2-a6ab-1e0a1e7ef023'),
('01a178e7-16a0-716e-b695-0fc70cdc015f', '01a178e7-1c84-71c2-a6ab-1e0a1e7ef023'),
('01a178e7-16c8-7369-80a8-94fddcfa6827', '01a178e7-1c84-71c2-a6ab-1e0a1e7ef023'),
('01a178e7-16ec-7107-8605-f3f4c5365420', '01a178e7-1c84-71c2-a6ab-1e0a1e7ef023'),
('01a178e7-1710-7012-a41d-8af90fca4a40', '01a178e7-1c84-71c2-a6ab-1e0a1e7ef023'),
('01a178e7-13e6-73c2-b6f8-2cc065a5f41d', '01a178e7-2068-73ea-ab61-cc683e7d19d2'),
('01a178e7-14f5-7304-a047-9e14e1360831', '01a178e7-2068-73ea-ab61-cc683e7d19d2'),
('01a178e7-1543-707c-b7b9-5dd51443b578', '01a178e7-2068-73ea-ab61-cc683e7d19d2'),
('01a178e7-1568-701b-a2ab-952771119f98', '01a178e7-2068-73ea-ab61-cc683e7d19d2'),
('01a178e7-158d-72ce-90d0-98afe2a478f1', '01a178e7-2068-73ea-ab61-cc683e7d19d2'),
('01a178e7-15b1-702a-96dd-1fab4e080697', '01a178e7-2068-73ea-ab61-cc683e7d19d2'),
('01a178e7-1621-7006-8871-c5df1c38be73', '01a178e7-2068-73ea-ab61-cc683e7d19d2'),
('01a178e7-16ec-7107-8605-f3f4c5365420', '01a178e7-2068-73ea-ab61-cc683e7d19d2'),
('01a178e7-1710-7012-a41d-8af90fca4a40', '01a178e7-2068-73ea-ab61-cc683e7d19d2');

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
('01a178e7-2ef0-7022-a602-3488fd646122', '01a178e7-2e44-7053-916c-185e4778c5fd', 'Desember 2022', 'Bulan Desember 2022', '2022-12-01', '2022-12-31', 0, NULL, NULL, '2026-10-26 08:49:39', '2026-10-26 08:49:39'),
('01a178e7-2f18-72f8-884c-c074413bf4c5', '01a178e7-2f04-7036-8a64-5ae3fda5165b', 'Januari 2023', 'Bulan Januari 2023', '2023-01-01', '2023-01-31', 0, NULL, NULL, '2026-10-26 08:49:39', '2026-10-26 08:49:39');

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
('01a178e7-2929-7095-9125-2d1b6d38f03d', 'Super Admin', NULL, NULL, 'superadmin@example.com', NULL, '$2y$12$xwCq75sRhNy24l5wj1Tm7uHZVNH33rb7vwhvJsVe/1LBp8avWCeFO', 1, NULL, '2026-10-26 08:49:37', '2026-10-26 08:49:37'),
('01a178e7-2b56-7014-a410-d83dde9db2a9', 'Bendahara', NULL, NULL, 'bendahara@example.com', NULL, '$2y$12$Dq9QA5LwbMWAUMfXLlrPveYGqDA4vvSeIHDiOiiTrGxXRgQce0Sq.', 0, NULL, '2026-10-26 08:49:38', '2026-10-26 08:49:38'),
('01a178e7-2d77-731a-bae5-57307b7db827', 'Pemegang Kas Operasional', NULL, NULL, 'pemegang-kas@example.com', NULL, '$2y$12$T69ptCkqCX0Z/XkYzkG5cuK6nYxl8mcTYJB9OruekqIKQfCyDrb5m', 0, NULL, '2026-10-26 08:49:38', '2026-10-26 08:49:38');

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
('01a178e7-4019-7389-99ca-5c4ea4f99f68', '01a178e7-2b56-7014-a410-d83dde9db2a9', '00fe8206-5de4-4464-bb78-fed9abaf240b', '2026-10-26 08:49:43', '2026-10-26 08:49:43'),
('01a178e7-4032-721b-83ca-7e024a95b14b', '01a178e7-2b56-7014-a410-d83dde9db2a9', '060c946d-b92f-44b1-bc97-16af33559a05', '2026-10-26 08:49:43', '2026-10-26 08:49:43'),
('01a178e7-4048-7011-8a26-9facffae5194', '01a178e7-2b56-7014-a410-d83dde9db2a9', '075a4c29-6243-4713-ae36-8cdee8251117', '2026-10-26 08:49:43', '2026-10-26 08:49:43'),
('01a178e7-405c-718a-b529-e3be90e71a94', '01a178e7-2b56-7014-a410-d83dde9db2a9', '09791c21-6a67-4ad6-b647-10c0b7eaa88b', '2026-10-26 08:49:43', '2026-10-26 08:49:43'),
('01a178e7-4070-70ad-a927-107929949143', '01a178e7-2b56-7014-a410-d83dde9db2a9', '0a8374c0-7d1b-4ce5-9060-1a46dd0cc26e', '2026-10-26 08:49:43', '2026-10-26 08:49:43'),
('01a178e7-4084-70a3-9e56-991987d48838', '01a178e7-2b56-7014-a410-d83dde9db2a9', '0e4de3d6-7871-4ab8-a2cb-78d9d153f520', '2026-10-26 08:49:43', '2026-10-26 08:49:43'),
('01a178e7-4098-70ad-9809-b1a7534c9014', '01a178e7-2b56-7014-a410-d83dde9db2a9', '0e8661ab-6429-4353-8a0c-9eabe2aac5ae', '2026-10-26 08:49:43', '2026-10-26 08:49:43'),
('01a178e7-40ab-7192-8e3f-9306a6813d8d', '01a178e7-2b56-7014-a410-d83dde9db2a9', '118ce695-e480-40d5-8b13-dc660d96cc1b', '2026-10-26 08:49:43', '2026-10-26 08:49:43'),
('01a178e7-40be-7315-b47b-9ffdd58ea6c5', '01a178e7-2b56-7014-a410-d83dde9db2a9', '11d00f5f-a65c-4942-955f-2ab0d95f16a6', '2026-10-26 08:49:43', '2026-10-26 08:49:43'),
('01a178e7-40d2-7002-aa4a-0534cb0ae042', '01a178e7-2b56-7014-a410-d83dde9db2a9', '17f94eb1-ae8f-4a53-a743-3534a4f27999', '2026-10-26 08:49:43', '2026-10-26 08:49:43'),
('01a178e7-40e6-7154-9255-33d635cf712e', '01a178e7-2b56-7014-a410-d83dde9db2a9', '190cba7d-ac10-4ed0-a9d6-69d6a086a4bc', '2026-10-26 08:49:43', '2026-10-26 08:49:43'),
('01a178e7-40fa-708d-adb7-d2d694bccb10', '01a178e7-2b56-7014-a410-d83dde9db2a9', '1e76f3bd-7454-4bfe-adc9-8b93d91b99f2', '2026-10-26 08:49:43', '2026-10-26 08:49:43'),
('01a178e7-410e-7367-99ee-be36b091a229', '01a178e7-2b56-7014-a410-d83dde9db2a9', '21da6646-c5f1-4c79-988c-a38ab1c923c3', '2026-10-26 08:49:43', '2026-10-26 08:49:43'),
('01a178e7-4121-7388-a81b-9a8e8b201bb1', '01a178e7-2b56-7014-a410-d83dde9db2a9', '227ca186-b767-4ff7-bd10-51e9dcf4ab44', '2026-10-26 08:49:43', '2026-10-26 08:49:43'),
('01a178e7-4135-7089-b878-139a045c0357', '01a178e7-2b56-7014-a410-d83dde9db2a9', '2302a5c7-6353-4855-b784-26b301a63f69', '2026-10-26 08:49:43', '2026-10-26 08:49:43'),
('01a178e7-4149-72aa-b465-02513d9e8a8a', '01a178e7-2b56-7014-a410-d83dde9db2a9', '243571d1-2611-414f-80e0-c78ce123c542', '2026-10-26 08:49:43', '2026-10-26 08:49:43'),
('01a178e7-415d-706a-9f84-b19e7a3d9c30', '01a178e7-2b56-7014-a410-d83dde9db2a9', '2653d42e-2dbb-45ba-a52c-1720ca1a2299', '2026-10-26 08:49:43', '2026-10-26 08:49:43'),
('01a178e7-4175-7037-950c-bef7200906df', '01a178e7-2b56-7014-a410-d83dde9db2a9', '267cffdc-1ad1-4790-bfb0-2a6d5bc93930', '2026-10-26 08:49:43', '2026-10-26 08:49:43'),
('01a178e7-4188-70d2-bf44-6928db35fb3c', '01a178e7-2b56-7014-a410-d83dde9db2a9', '28d2c84c-292e-498f-8da2-804717f6f5cd', '2026-10-26 08:49:43', '2026-10-26 08:49:43'),
('01a178e7-419c-7166-836a-45f8bb415da2', '01a178e7-2b56-7014-a410-d83dde9db2a9', '296875d4-7cc4-42ac-98c8-98a80f91e252', '2026-10-26 08:49:43', '2026-10-26 08:49:43'),
('01a178e7-41af-7131-b3dc-9f80016977db', '01a178e7-2b56-7014-a410-d83dde9db2a9', '2bfc1b8d-d1cf-4661-8cd2-ee285bf21071', '2026-10-26 08:49:43', '2026-10-26 08:49:43'),
('01a178e7-41c4-7306-ae6f-69dde32d1090', '01a178e7-2b56-7014-a410-d83dde9db2a9', '2d7e08b1-3dfc-4b09-8bee-7791a41b7b5d', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-41d7-72a8-80a4-20f7f621044c', '01a178e7-2b56-7014-a410-d83dde9db2a9', '2f1d50b8-40a2-4cec-80d5-df6aa30f0916', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-41eb-7339-820e-54ecbde19a54', '01a178e7-2b56-7014-a410-d83dde9db2a9', '382612a5-7721-45ea-9497-4552940625e3', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-41ff-7248-ad57-860fac8477b5', '01a178e7-2b56-7014-a410-d83dde9db2a9', '39ac1529-309d-4a2a-b8b3-7880bf49f79b', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-4213-7176-aaf8-9aadfc46ef66', '01a178e7-2b56-7014-a410-d83dde9db2a9', '3a41d0e9-17f3-4ca0-bf4e-df4a690533ef', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-4227-73bd-91a0-bb32aa1f9ddd', '01a178e7-2b56-7014-a410-d83dde9db2a9', '3ccbf362-36a9-4bb4-a699-a6d59ce6724c', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-423e-73a7-b830-9b415b1ae2d2', '01a178e7-2b56-7014-a410-d83dde9db2a9', '3ce3dff5-7454-4c42-9a20-4db27588cd53', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-4252-72b1-83ff-fc7ba3838210', '01a178e7-2b56-7014-a410-d83dde9db2a9', '4105f060-3f48-4f5c-a43c-dbb1b6f8b079', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-4266-730a-b41f-63260b53a08c', '01a178e7-2b56-7014-a410-d83dde9db2a9', '43411e9f-1f07-433a-b4ce-a5f8ba79cea1', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-427a-703a-92a7-c8a3cf55b01b', '01a178e7-2b56-7014-a410-d83dde9db2a9', '4a6cd387-3ef7-47d7-8266-f5dd0914bfb7', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-428f-7215-a122-781af571f66b', '01a178e7-2b56-7014-a410-d83dde9db2a9', '4acc23ea-0470-471d-8be0-f493ca9a77ae', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-42a3-703a-8f89-c058adb73771', '01a178e7-2b56-7014-a410-d83dde9db2a9', '4d84eb39-be38-4430-a17e-ab79a369df0f', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-42b8-7273-93b3-264002477db4', '01a178e7-2b56-7014-a410-d83dde9db2a9', '4e786981-39ee-4eab-89c8-a9274109c95d', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-42cc-71e0-aca8-1c7d198ffbc8', '01a178e7-2b56-7014-a410-d83dde9db2a9', '518704ab-47cf-4315-a739-f5e343a5cf3d', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-42e2-71e6-a145-686b81d553f7', '01a178e7-2b56-7014-a410-d83dde9db2a9', '52b384d0-c5a2-4a7b-a1db-b4d77c3909c2', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-42fd-7072-b69d-58902d2db60c', '01a178e7-2b56-7014-a410-d83dde9db2a9', '537360d6-ce3a-4a3c-8ee2-12136c4449c9', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-4313-7384-9fe9-bb05abd822b2', '01a178e7-2b56-7014-a410-d83dde9db2a9', '5491948d-680f-4956-9f36-0eded0de55ea', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-4329-7017-bfa1-ee7955304d87', '01a178e7-2b56-7014-a410-d83dde9db2a9', '5546a565-7dc8-40d8-b127-49db911b342d', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-433e-71b8-9a33-9c6a79440696', '01a178e7-2b56-7014-a410-d83dde9db2a9', '576c5c92-1183-40a9-99f7-123675b1afcf', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-4353-7289-b890-8f0bbc8e60f4', '01a178e7-2b56-7014-a410-d83dde9db2a9', '582f672f-a2c6-4c01-b727-0a0d99dd7842', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-4369-71a0-b7dc-bed6840ca879', '01a178e7-2b56-7014-a410-d83dde9db2a9', '59022a3a-6ae8-462b-a555-621b74ed7b4d', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-437e-7005-be12-57e576f958b7', '01a178e7-2b56-7014-a410-d83dde9db2a9', '5a0b491f-76cc-4f6c-bba0-398c05dbba55', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-4399-728e-9f6f-e9e406543bdd', '01a178e7-2b56-7014-a410-d83dde9db2a9', '5a727eb0-c46e-4576-b4f1-1cfe1f10dcda', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-43ae-70a4-92b8-2558d043e4dd', '01a178e7-2b56-7014-a410-d83dde9db2a9', '5c7be6d6-96f5-4b45-8bae-d4da3fda1860', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-43c2-73be-9bf7-06954fdc4210', '01a178e7-2b56-7014-a410-d83dde9db2a9', '5c8ad9a2-ea11-4f7f-be35-cd84747e6636', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-43d9-717c-bdb1-49aa7df18f26', '01a178e7-2b56-7014-a410-d83dde9db2a9', '5e3fa800-65c8-4332-b8f9-b5816af352e1', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-43ee-71e9-88da-d6b449f05e1c', '01a178e7-2b56-7014-a410-d83dde9db2a9', '6397a108-e2a0-4016-ba7d-a974e80f329c', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-4403-7391-8a0f-6d99f64a96af', '01a178e7-2b56-7014-a410-d83dde9db2a9', '6f33064a-d39c-4cbd-8275-3218b594eb13', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-4418-7072-8805-81ef4e809532', '01a178e7-2b56-7014-a410-d83dde9db2a9', '6f5a0830-1fd5-4a4b-b43d-39f7ac5ade44', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-442e-716d-b548-b9c24f0f59ec', '01a178e7-2b56-7014-a410-d83dde9db2a9', '70130f83-fb4c-4a3b-9ec7-310a5e77d77c', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-4443-70c7-9cbb-bb9de18c213a', '01a178e7-2b56-7014-a410-d83dde9db2a9', '72fcf4af-1f84-418e-8696-5eec4fa7a2c1', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-4458-73fd-8180-02a0ef7ac2d2', '01a178e7-2b56-7014-a410-d83dde9db2a9', '73da2879-9781-4b50-a9a4-a40187489f6c', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-446c-710a-9ca3-a7839c2ebc02', '01a178e7-2b56-7014-a410-d83dde9db2a9', '779e801f-478a-480e-80ec-970fdbeee55e', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-4481-73c1-9b25-a7ce24769f03', '01a178e7-2b56-7014-a410-d83dde9db2a9', '7fa4f69a-037e-4329-8a14-c917a8731a16', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-4496-7239-bd68-fb9e818db849', '01a178e7-2b56-7014-a410-d83dde9db2a9', '8221386d-cd9f-4801-9404-61b09739fe7e', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-44aa-7075-bb90-a043f0d2bca5', '01a178e7-2b56-7014-a410-d83dde9db2a9', '85e9abe8-a5d6-47b2-ac9b-f33398f00b4d', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-44c0-73ea-a3ee-64be57793f3f', '01a178e7-2b56-7014-a410-d83dde9db2a9', '87cf7317-479a-4a53-9bcc-ea3f882a5599', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-44d5-7267-925f-3d321a89ddcb', '01a178e7-2b56-7014-a410-d83dde9db2a9', '8858d276-827d-4a61-b448-7a0d993072fd', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-44e9-70e1-8de7-7c0c5e9b7178', '01a178e7-2b56-7014-a410-d83dde9db2a9', '888ac1c4-09bc-40c5-88aa-957f7d712787', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-44fe-7246-b9f2-2d8c10e1719d', '01a178e7-2b56-7014-a410-d83dde9db2a9', '8a469fcd-df62-4293-abff-74894c69d82d', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-4514-73fb-b1ed-03bfac27f63d', '01a178e7-2b56-7014-a410-d83dde9db2a9', '8a5db526-884c-4bc9-b6e3-1c858e48304e', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-4529-73f3-b991-f60564a3b72b', '01a178e7-2b56-7014-a410-d83dde9db2a9', '8c9361c4-5f24-4060-a5d0-b52d792660ec', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-453d-7322-a4df-2e408f85a6eb', '01a178e7-2b56-7014-a410-d83dde9db2a9', '8cd50032-a781-487d-aafb-3f21273545f5', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-4552-7068-a5e9-d8b55cd2fa00', '01a178e7-2b56-7014-a410-d83dde9db2a9', '92947efa-ec89-4603-8996-fca687c3f859', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-4565-731a-bd93-d3293e5944ea', '01a178e7-2b56-7014-a410-d83dde9db2a9', '9b655e80-669c-4fc5-91f2-49695c3e7a31', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-457a-703e-b85d-6fd0b36c97bf', '01a178e7-2b56-7014-a410-d83dde9db2a9', '9c58d8d4-7b71-4e6d-932a-d8b4ffee6efc', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-458d-72fd-a5a9-3ca7d45ea7a8', '01a178e7-2b56-7014-a410-d83dde9db2a9', '9d4d2219-1e14-450b-8536-a57518f3d206', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-45a2-7095-8fcb-31e4638196e2', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'a0d4fbf4-c863-4099-88d3-4352ca940537', '2026-10-26 08:49:44', '2026-10-26 08:49:44'),
('01a178e7-45b5-70e8-aef5-6f5fa364ac1d', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'a1d4e8e1-4883-4496-9070-dc2bd789e7c6', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-45c8-7054-9303-708ed38769d6', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'a55143c3-4b6a-4218-83be-5c8963c15052', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-45df-7213-a18c-5f2b7721204b', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'a57a27ec-2ea0-4f18-b357-7a564795acc9', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-45f5-71e4-8e9f-f0ef62aeaac5', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'a593b53c-6280-4e26-beba-63d72a9d791a', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-4609-724b-b12f-af38eff4b2b4', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'a5f17f0d-1ad6-405d-9154-d21cb28fd78a', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-461d-7315-bbe6-e71d6ea264cf', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'a66c8e9d-9ec1-4cb8-bc14-c8caa8057a68', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-4630-720f-975d-7bb6dde98780', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'a8ce5ac4-c2e6-4b38-b680-01260bbee21e', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-4644-701e-9ff6-34778eb9e74f', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'a8e717ce-4a8c-488f-a626-fb7b7514ff0a', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-4657-734e-b3f4-1effc3d5f87f', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'a979cdeb-4818-4a5a-9705-c6386b166377', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-466f-701d-8f54-3536f79b68cf', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'b0e97569-56d9-4d7d-ab1f-222b14860415', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-4682-737a-9547-fce50dd4aa94', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'b151e6cb-ce28-4246-8bd5-123a2ca0d732', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-4695-7340-92b0-163de8062db8', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'b18adc1b-368b-49c9-acf1-b0acf608a58a', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-46a9-7237-a10d-5dba9662d65a', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'b1d08bfe-85a5-4fdc-9775-158bc0ae5d47', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-46bc-71a0-9a00-55d951d9d6c2', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'b2c28f62-296c-420b-8d83-89f0b4b391d5', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-46d0-7154-8677-8e1582882643', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'b357c858-9d40-4e5e-9a23-83d9cb7b3464', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-46e5-704b-93ee-290c311385fd', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'b690a6ad-2e68-4bc5-9e8b-b9f6cdab3177', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-46f9-7117-92fd-5185cdfafb0d', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'b7215705-3121-44fa-bfcb-96676de37761', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-470e-732f-be5c-fb4c3cdbc79e', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'b8d3eca6-a9cb-4b9e-81a7-662865a51e1b', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-4721-716c-b8d8-18fc2dfccf8e', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'ba089f97-612f-4983-9d60-931cd7543cb1', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-4736-72a9-81bb-841b4af7b6da', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'bbcd6dfa-cf72-4fab-a268-5b2b5a89b58a', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-474b-72aa-8be9-c5e0bbbdd3c6', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'bc1b0528-5e52-4cd5-9534-8f97cee2ba59', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-475f-73b9-8f54-fd83287782ab', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'beb6b15b-4598-4f4c-8fe6-04bb0122cbb4', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-4774-7275-840e-3c50d02d75f0', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'c0f253ee-bdd5-44ae-b1f1-f18531b896a4', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-4789-72a2-ad39-580c127cb2f3', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'c204ba58-c205-40e1-ae23-851e3ba09007', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-479d-700f-887d-b588f195afdc', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'c28a7f10-f2dd-456f-b1f8-072e30066f9e', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-47b2-702b-875e-6bb64a5e6f1b', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'c52e7c4f-1662-4a8d-88de-8e5a908ceb64', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-47c6-718a-8126-5be145b416df', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'c67f4eef-1d03-4ea5-bf62-81d1482114d2', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-47db-729c-a490-4fde399ef353', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'c6875d95-4073-4bdb-b4e7-2c8f99bc1a02', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-47f2-70b9-b8ed-8f0f7bb271a5', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'c8a2daf5-b32f-4802-acc2-745b8d92b5fe', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-480a-7159-bb7f-0529506eeb70', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'c8d90511-c635-4ad1-ad49-bcff8ffee93f', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-481f-7064-8086-6058a6090d66', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'c9c85fd6-264e-4abe-9bff-56e58f94ffe9', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-4834-7312-a562-ef584698ca42', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'cc1d52d3-00dd-456c-8c37-df57a3b32390', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-484a-7361-83f6-cedcfd548c28', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'd0f59aba-e381-483c-8b2d-cb1c7105212a', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-485f-726e-aad4-7cb44104c97a', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'd1daf181-917a-4d18-aadf-424bf4567e9b', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-4874-71d4-a18c-3931b1173119', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'd492e381-fde3-4b05-b5db-2052991b4b14', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-488f-7392-8b3c-56a34cf11bdb', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'd53b8dbe-ff2e-49a7-af5b-07e637b7d5a8', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-48a4-711f-9141-f57fcd089618', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'd67ba097-7304-4f50-88ac-09d7861be068', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-48b8-70f4-9dbe-d847ca4c8bca', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'd7d1b910-283c-44f7-8c77-a239525d6e76', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-48ce-71f1-824e-673bbca6963e', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'd8421532-26f6-496d-9fa7-7e7b651c7f00', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-48e3-7135-929c-50af1c61dee7', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'd8f4adfa-92dd-45bc-8351-e31ab7fc31a6', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-48f7-70ce-8d4a-194c8ad11f86', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'd98f903d-31ed-4641-ab25-f8e6ca3a28bd', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-4929-712b-99b9-fee874b0ac3a', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'db39ba3a-7633-4395-aae9-6266af17a70a', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-493e-722a-a884-a8dec521e8c7', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'dcd694f6-adde-466b-830f-0b845f821235', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-4953-7230-86a4-c1ed4df568fd', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'dce7bb80-5f22-4790-ae2c-d8de0e5a2111', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-4969-7013-9a20-71366a934c60', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'e26fb7d7-9833-4852-abc8-17a29f5c394c', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-497d-703d-ab64-6376d5d0349a', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'e47f43ee-cab8-453b-9b2e-055063fc19cc', '2026-10-26 08:49:45', '2026-10-26 08:49:45'),
('01a178e7-4996-7028-929f-b2d9107e4370', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'e5575c00-dc67-4f46-83be-3663e70e8e2d', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-49ab-7263-8955-7a7512d26ae0', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'ea66d41d-bca2-4f8c-8de8-e12dd1ea7d86', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-49bf-72b4-b9df-1b7a9f02a536', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'eb1165a5-d589-4bd1-91f0-62f83fbe59b3', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-49d4-714c-99b0-48e9ad8d0cce', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'eb2f0e66-9974-4af8-9d89-292efcb7fda5', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-49e8-73cf-a80d-3efd5571ac89', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'ec8321b0-b035-4ebf-9e4f-2b02be268ebc', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-49fd-70ee-ac2c-183b305c3a4e', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'ede5f559-c814-4468-91a2-8fff2e1e023f', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4a12-7082-b205-9647b5d710ab', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'ef186510-a205-4f01-a15f-6727dc453c29', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4a27-7078-a41e-823c65a1e001', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'f12f69db-121e-4c4f-9f2c-efb3c95a2aad', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4a3c-7327-b0ff-93e20096898a', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'f3b90c16-1dfa-457a-bf5f-4c9848d3af25', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4a51-73b3-8d74-c5e691010ac9', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'fba683c0-92b9-4b48-93d3-0f012c3a5e74', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4a66-73d6-b4bd-da2ab4b514f1', '01a178e7-2b56-7014-a410-d83dde9db2a9', 'fcc90cce-c7be-4056-9cce-0fcbe23f47cb', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4a7e-714e-9b8d-98b45b62fd91', '01a178e7-2d77-731a-bae5-57307b7db827', '00fe8206-5de4-4464-bb78-fed9abaf240b', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4a94-7141-aa8f-9ff2f3d61cfb', '01a178e7-2d77-731a-bae5-57307b7db827', '060c946d-b92f-44b1-bc97-16af33559a05', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4aa9-7153-9662-c5db4439b9c1', '01a178e7-2d77-731a-bae5-57307b7db827', '075a4c29-6243-4713-ae36-8cdee8251117', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4abe-73b2-bc98-448071299210', '01a178e7-2d77-731a-bae5-57307b7db827', '09791c21-6a67-4ad6-b647-10c0b7eaa88b', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4ad5-71f9-90e6-b5a8f158e918', '01a178e7-2d77-731a-bae5-57307b7db827', '0a8374c0-7d1b-4ce5-9060-1a46dd0cc26e', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4aeb-7312-9fbc-51e7eea63999', '01a178e7-2d77-731a-bae5-57307b7db827', '0e4de3d6-7871-4ab8-a2cb-78d9d153f520', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4b00-7141-a91d-0a825746ac86', '01a178e7-2d77-731a-bae5-57307b7db827', '0e8661ab-6429-4353-8a0c-9eabe2aac5ae', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4b17-7380-ac50-399ebc5f4cce', '01a178e7-2d77-731a-bae5-57307b7db827', '118ce695-e480-40d5-8b13-dc660d96cc1b', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4b2d-70ea-8222-426731bca3ee', '01a178e7-2d77-731a-bae5-57307b7db827', '11d00f5f-a65c-4942-955f-2ab0d95f16a6', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4b41-7017-b9f8-f6ebc189a6f3', '01a178e7-2d77-731a-bae5-57307b7db827', '17f94eb1-ae8f-4a53-a743-3534a4f27999', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4b56-727e-a38f-abed3e80eb9f', '01a178e7-2d77-731a-bae5-57307b7db827', '190cba7d-ac10-4ed0-a9d6-69d6a086a4bc', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4b6b-737f-a888-c563ee01cf46', '01a178e7-2d77-731a-bae5-57307b7db827', '1e76f3bd-7454-4bfe-adc9-8b93d91b99f2', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4b7f-7292-ad5d-adbae1d779c3', '01a178e7-2d77-731a-bae5-57307b7db827', '21da6646-c5f1-4c79-988c-a38ab1c923c3', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4b94-7076-afe2-491e9321cde7', '01a178e7-2d77-731a-bae5-57307b7db827', '227ca186-b767-4ff7-bd10-51e9dcf4ab44', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4ba9-7064-ab5a-161b47e273f3', '01a178e7-2d77-731a-bae5-57307b7db827', '2302a5c7-6353-4855-b784-26b301a63f69', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4bbe-73dd-97ff-0f19e57a8a21', '01a178e7-2d77-731a-bae5-57307b7db827', '243571d1-2611-414f-80e0-c78ce123c542', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4bd3-7373-a3e6-d8076a623a94', '01a178e7-2d77-731a-bae5-57307b7db827', '2653d42e-2dbb-45ba-a52c-1720ca1a2299', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4be8-701b-b2cf-2078d653d992', '01a178e7-2d77-731a-bae5-57307b7db827', '267cffdc-1ad1-4790-bfb0-2a6d5bc93930', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4bfd-7380-8f35-d4ed98bd43bb', '01a178e7-2d77-731a-bae5-57307b7db827', '28d2c84c-292e-498f-8da2-804717f6f5cd', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4c12-710c-a4d8-1eaef3c573d1', '01a178e7-2d77-731a-bae5-57307b7db827', '296875d4-7cc4-42ac-98c8-98a80f91e252', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4c27-72d5-a556-1f53721a9957', '01a178e7-2d77-731a-bae5-57307b7db827', '2bfc1b8d-d1cf-4661-8cd2-ee285bf21071', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4c3c-712b-89a1-69905a7d71ff', '01a178e7-2d77-731a-bae5-57307b7db827', '2d7e08b1-3dfc-4b09-8bee-7791a41b7b5d', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4c51-7108-b426-b5721a4a9da4', '01a178e7-2d77-731a-bae5-57307b7db827', '2f1d50b8-40a2-4cec-80d5-df6aa30f0916', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4c65-72ed-bd3a-eca40284b0a1', '01a178e7-2d77-731a-bae5-57307b7db827', '382612a5-7721-45ea-9497-4552940625e3', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4c7a-7235-b9a3-37d2c3a7b9b1', '01a178e7-2d77-731a-bae5-57307b7db827', '39ac1529-309d-4a2a-b8b3-7880bf49f79b', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4c8f-72cb-be5c-d9baa47cb452', '01a178e7-2d77-731a-bae5-57307b7db827', '3a41d0e9-17f3-4ca0-bf4e-df4a690533ef', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4ca7-703e-a5b1-379578d21180', '01a178e7-2d77-731a-bae5-57307b7db827', '3ccbf362-36a9-4bb4-a699-a6d59ce6724c', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4cbd-7254-9382-bc819d9d48bb', '01a178e7-2d77-731a-bae5-57307b7db827', '3ce3dff5-7454-4c42-9a20-4db27588cd53', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4cd5-705b-866d-835c1e461de4', '01a178e7-2d77-731a-bae5-57307b7db827', '4105f060-3f48-4f5c-a43c-dbb1b6f8b079', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4cea-7156-bf78-616a69cc2012', '01a178e7-2d77-731a-bae5-57307b7db827', '43411e9f-1f07-433a-b4ce-a5f8ba79cea1', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4cff-7003-84fa-1f1c2fcec24c', '01a178e7-2d77-731a-bae5-57307b7db827', '4a6cd387-3ef7-47d7-8266-f5dd0914bfb7', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4d13-70a2-bd12-1c5f450622dc', '01a178e7-2d77-731a-bae5-57307b7db827', '4acc23ea-0470-471d-8be0-f493ca9a77ae', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4d28-73c9-94dd-a52b99d1f74a', '01a178e7-2d77-731a-bae5-57307b7db827', '4d84eb39-be38-4430-a17e-ab79a369df0f', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4d3d-7114-8c2e-5119649a6c98', '01a178e7-2d77-731a-bae5-57307b7db827', '4e786981-39ee-4eab-89c8-a9274109c95d', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4d51-7107-a5f9-1f30fd3087c2', '01a178e7-2d77-731a-bae5-57307b7db827', '518704ab-47cf-4315-a739-f5e343a5cf3d', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4d66-7087-b07a-1d278a459aea', '01a178e7-2d77-731a-bae5-57307b7db827', '52b384d0-c5a2-4a7b-a1db-b4d77c3909c2', '2026-10-26 08:49:46', '2026-10-26 08:49:46'),
('01a178e7-4d7b-7128-9f0f-ca6d6d6cfcc6', '01a178e7-2d77-731a-bae5-57307b7db827', '537360d6-ce3a-4a3c-8ee2-12136c4449c9', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-4d90-728e-9dbf-70616f60d832', '01a178e7-2d77-731a-bae5-57307b7db827', '5491948d-680f-4956-9f36-0eded0de55ea', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-4da9-7342-9c62-0010409ddeba', '01a178e7-2d77-731a-bae5-57307b7db827', '5546a565-7dc8-40d8-b127-49db911b342d', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-4dbf-72e3-9565-5f2f15d5ef5a', '01a178e7-2d77-731a-bae5-57307b7db827', '576c5c92-1183-40a9-99f7-123675b1afcf', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-4dd9-72b9-b332-ed445223d9c7', '01a178e7-2d77-731a-bae5-57307b7db827', '582f672f-a2c6-4c01-b727-0a0d99dd7842', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-4df3-7243-96ad-5e3fac358bf4', '01a178e7-2d77-731a-bae5-57307b7db827', '59022a3a-6ae8-462b-a555-621b74ed7b4d', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-4e08-7229-a5d2-d6f10ac323d1', '01a178e7-2d77-731a-bae5-57307b7db827', '5a0b491f-76cc-4f6c-bba0-398c05dbba55', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-4e1d-72b0-b5b4-cf110151b50a', '01a178e7-2d77-731a-bae5-57307b7db827', '5a727eb0-c46e-4576-b4f1-1cfe1f10dcda', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-4e34-7294-8266-6ba6606421c7', '01a178e7-2d77-731a-bae5-57307b7db827', '5c7be6d6-96f5-4b45-8bae-d4da3fda1860', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-4e4c-713c-a086-8cb89a8b51c4', '01a178e7-2d77-731a-bae5-57307b7db827', '5c8ad9a2-ea11-4f7f-be35-cd84747e6636', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-4e67-71e9-a654-aeedd5eb782d', '01a178e7-2d77-731a-bae5-57307b7db827', '5e3fa800-65c8-4332-b8f9-b5816af352e1', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-4e81-71b8-bc7b-fc8082974b76', '01a178e7-2d77-731a-bae5-57307b7db827', '6397a108-e2a0-4016-ba7d-a974e80f329c', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-4e97-7128-97c0-541f19a8b487', '01a178e7-2d77-731a-bae5-57307b7db827', '6f33064a-d39c-4cbd-8275-3218b594eb13', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-4eb0-71f0-b19b-418c0a29d0be', '01a178e7-2d77-731a-bae5-57307b7db827', '6f5a0830-1fd5-4a4b-b43d-39f7ac5ade44', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-4ec9-71f7-b90e-2695c46dcfb8', '01a178e7-2d77-731a-bae5-57307b7db827', '70130f83-fb4c-4a3b-9ec7-310a5e77d77c', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-4ee6-718f-9494-1966d5c643e1', '01a178e7-2d77-731a-bae5-57307b7db827', '72fcf4af-1f84-418e-8696-5eec4fa7a2c1', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-4eff-7064-bc8e-18e0819310cd', '01a178e7-2d77-731a-bae5-57307b7db827', '73da2879-9781-4b50-a9a4-a40187489f6c', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-4f19-7018-9a3e-b6f41e8a8fcc', '01a178e7-2d77-731a-bae5-57307b7db827', '779e801f-478a-480e-80ec-970fdbeee55e', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-4f30-718a-9ca6-2f26b399e1f2', '01a178e7-2d77-731a-bae5-57307b7db827', '7fa4f69a-037e-4329-8a14-c917a8731a16', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-4f47-71ec-82e8-69929b84478c', '01a178e7-2d77-731a-bae5-57307b7db827', '8221386d-cd9f-4801-9404-61b09739fe7e', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-4f5e-708d-a1e3-f18e56c0812c', '01a178e7-2d77-731a-bae5-57307b7db827', '85e9abe8-a5d6-47b2-ac9b-f33398f00b4d', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-4f76-73aa-8244-17eb71b0594b', '01a178e7-2d77-731a-bae5-57307b7db827', '87cf7317-479a-4a53-9bcc-ea3f882a5599', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-4f8d-72f5-a7c8-84c95669060e', '01a178e7-2d77-731a-bae5-57307b7db827', '8858d276-827d-4a61-b448-7a0d993072fd', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-4fa4-7050-ad6c-45bfbb86eafa', '01a178e7-2d77-731a-bae5-57307b7db827', '888ac1c4-09bc-40c5-88aa-957f7d712787', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-4fbc-70b4-94d3-af18de2965fd', '01a178e7-2d77-731a-bae5-57307b7db827', '8a469fcd-df62-4293-abff-74894c69d82d', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-4fd3-73a6-a64c-88c1a4e7558a', '01a178e7-2d77-731a-bae5-57307b7db827', '8a5db526-884c-4bc9-b6e3-1c858e48304e', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-4fea-72fc-9e0f-989626e7677c', '01a178e7-2d77-731a-bae5-57307b7db827', '8c9361c4-5f24-4060-a5d0-b52d792660ec', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-5003-71f4-86b0-65cd8458aded', '01a178e7-2d77-731a-bae5-57307b7db827', '8cd50032-a781-487d-aafb-3f21273545f5', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-501c-70bd-84c1-3cdb751ae7d9', '01a178e7-2d77-731a-bae5-57307b7db827', '92947efa-ec89-4603-8996-fca687c3f859', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-5035-7343-94b8-4226d7f07900', '01a178e7-2d77-731a-bae5-57307b7db827', '9b655e80-669c-4fc5-91f2-49695c3e7a31', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-504e-718c-8903-cf6173d2c9ca', '01a178e7-2d77-731a-bae5-57307b7db827', '9c58d8d4-7b71-4e6d-932a-d8b4ffee6efc', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-5065-7293-b204-65eb95fc4e73', '01a178e7-2d77-731a-bae5-57307b7db827', '9d4d2219-1e14-450b-8536-a57518f3d206', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-507f-7202-a5cd-5c91bbba3bcf', '01a178e7-2d77-731a-bae5-57307b7db827', 'a0d4fbf4-c863-4099-88d3-4352ca940537', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-5099-7192-b386-9d61f63dcfee', '01a178e7-2d77-731a-bae5-57307b7db827', 'a1d4e8e1-4883-4496-9070-dc2bd789e7c6', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-50b2-7064-8417-de07ba4bb38f', '01a178e7-2d77-731a-bae5-57307b7db827', 'a55143c3-4b6a-4218-83be-5c8963c15052', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-50ca-7004-9b24-5614160a2cf5', '01a178e7-2d77-731a-bae5-57307b7db827', 'a57a27ec-2ea0-4f18-b357-7a564795acc9', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-50e1-71ec-a2fb-acd3443837c6', '01a178e7-2d77-731a-bae5-57307b7db827', 'a593b53c-6280-4e26-beba-63d72a9d791a', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-50fb-7263-a2b9-ee4947463a9d', '01a178e7-2d77-731a-bae5-57307b7db827', 'a5f17f0d-1ad6-405d-9154-d21cb28fd78a', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-5115-723f-afc0-80b5d7e5951d', '01a178e7-2d77-731a-bae5-57307b7db827', 'a66c8e9d-9ec1-4cb8-bc14-c8caa8057a68', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-512d-7246-9ba5-875d3b5abe0f', '01a178e7-2d77-731a-bae5-57307b7db827', 'a8ce5ac4-c2e6-4b38-b680-01260bbee21e', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-5146-7035-8e19-bcf1bb76ca42', '01a178e7-2d77-731a-bae5-57307b7db827', 'a8e717ce-4a8c-488f-a626-fb7b7514ff0a', '2026-10-26 08:49:47', '2026-10-26 08:49:47'),
('01a178e7-515f-700c-a214-0ec27a33a18b', '01a178e7-2d77-731a-bae5-57307b7db827', 'a979cdeb-4818-4a5a-9705-c6386b166377', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-517b-73c3-afa4-ecfd1aa2bd92', '01a178e7-2d77-731a-bae5-57307b7db827', 'b0e97569-56d9-4d7d-ab1f-222b14860415', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-5197-7348-b81d-dfea14c552d2', '01a178e7-2d77-731a-bae5-57307b7db827', 'b151e6cb-ce28-4246-8bd5-123a2ca0d732', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-51b2-73bc-a082-18b8862819b5', '01a178e7-2d77-731a-bae5-57307b7db827', 'b18adc1b-368b-49c9-acf1-b0acf608a58a', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-51ca-70b1-8825-6f26ee7db742', '01a178e7-2d77-731a-bae5-57307b7db827', 'b1d08bfe-85a5-4fdc-9775-158bc0ae5d47', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-51e3-70ba-9df2-737c6baad3d6', '01a178e7-2d77-731a-bae5-57307b7db827', 'b2c28f62-296c-420b-8d83-89f0b4b391d5', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-51fb-72b1-a1f6-08a287396955', '01a178e7-2d77-731a-bae5-57307b7db827', 'b357c858-9d40-4e5e-9a23-83d9cb7b3464', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-5214-71c9-9bf7-921860ef9517', '01a178e7-2d77-731a-bae5-57307b7db827', 'b690a6ad-2e68-4bc5-9e8b-b9f6cdab3177', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-522c-73ce-a99d-aa1310d35266', '01a178e7-2d77-731a-bae5-57307b7db827', 'b7215705-3121-44fa-bfcb-96676de37761', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-5246-7334-a7e7-e880ba78a1ed', '01a178e7-2d77-731a-bae5-57307b7db827', 'b8d3eca6-a9cb-4b9e-81a7-662865a51e1b', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-525f-711a-afc0-4782b1f7e523', '01a178e7-2d77-731a-bae5-57307b7db827', 'ba089f97-612f-4983-9d60-931cd7543cb1', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-5279-7048-8d60-adc9644ca64e', '01a178e7-2d77-731a-bae5-57307b7db827', 'bbcd6dfa-cf72-4fab-a268-5b2b5a89b58a', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-5293-705a-a427-8d218dc8eba6', '01a178e7-2d77-731a-bae5-57307b7db827', 'bc1b0528-5e52-4cd5-9534-8f97cee2ba59', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-52ae-735d-92f8-66973911435f', '01a178e7-2d77-731a-bae5-57307b7db827', 'beb6b15b-4598-4f4c-8fe6-04bb0122cbb4', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-52cf-73a7-be2c-29251a7c875b', '01a178e7-2d77-731a-bae5-57307b7db827', 'c0f253ee-bdd5-44ae-b1f1-f18531b896a4', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-52e8-7198-a792-b6fb4ad23d27', '01a178e7-2d77-731a-bae5-57307b7db827', 'c204ba58-c205-40e1-ae23-851e3ba09007', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-5302-712b-85ae-f82c8c92eb20', '01a178e7-2d77-731a-bae5-57307b7db827', 'c28a7f10-f2dd-456f-b1f8-072e30066f9e', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-531b-70bb-852c-28fafd048c2d', '01a178e7-2d77-731a-bae5-57307b7db827', 'c52e7c4f-1662-4a8d-88de-8e5a908ceb64', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-5333-7180-bf0f-bc29dc8baf49', '01a178e7-2d77-731a-bae5-57307b7db827', 'c67f4eef-1d03-4ea5-bf62-81d1482114d2', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-534b-7090-abbb-5f135b3829e6', '01a178e7-2d77-731a-bae5-57307b7db827', 'c6875d95-4073-4bdb-b4e7-2c8f99bc1a02', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-5362-7158-993e-6e53a245d640', '01a178e7-2d77-731a-bae5-57307b7db827', 'c8a2daf5-b32f-4802-acc2-745b8d92b5fe', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-537a-7337-81e4-21e77408fb98', '01a178e7-2d77-731a-bae5-57307b7db827', 'c8d90511-c635-4ad1-ad49-bcff8ffee93f', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-5392-707c-b999-db3239d306bd', '01a178e7-2d77-731a-bae5-57307b7db827', 'c9c85fd6-264e-4abe-9bff-56e58f94ffe9', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-53a9-7119-935d-bad09c5a6599', '01a178e7-2d77-731a-bae5-57307b7db827', 'cc1d52d3-00dd-456c-8c37-df57a3b32390', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-53c1-7065-bdd3-aa1e764b6975', '01a178e7-2d77-731a-bae5-57307b7db827', 'd0f59aba-e381-483c-8b2d-cb1c7105212a', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-53d8-7388-b655-d8e37b825f8c', '01a178e7-2d77-731a-bae5-57307b7db827', 'd1daf181-917a-4d18-aadf-424bf4567e9b', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-53ef-7127-8d47-f89a77b2701c', '01a178e7-2d77-731a-bae5-57307b7db827', 'd492e381-fde3-4b05-b5db-2052991b4b14', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-5408-734d-8a59-04fc36b072b5', '01a178e7-2d77-731a-bae5-57307b7db827', 'd53b8dbe-ff2e-49a7-af5b-07e637b7d5a8', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-541f-7069-ade9-b753c3f98aaa', '01a178e7-2d77-731a-bae5-57307b7db827', 'd67ba097-7304-4f50-88ac-09d7861be068', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-5437-70fd-9201-49eaa1e38ced', '01a178e7-2d77-731a-bae5-57307b7db827', 'd7d1b910-283c-44f7-8c77-a239525d6e76', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-544d-7286-b7aa-1da3b2ecb16b', '01a178e7-2d77-731a-bae5-57307b7db827', 'd8421532-26f6-496d-9fa7-7e7b651c7f00', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-5467-708e-ad2e-9c8a58dcf1e3', '01a178e7-2d77-731a-bae5-57307b7db827', 'd8f4adfa-92dd-45bc-8351-e31ab7fc31a6', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-547f-7026-8f05-922460fff25a', '01a178e7-2d77-731a-bae5-57307b7db827', 'd98f903d-31ed-4641-ab25-f8e6ca3a28bd', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-5496-7379-a746-1bda16fa6ddd', '01a178e7-2d77-731a-bae5-57307b7db827', 'db39ba3a-7633-4395-aae9-6266af17a70a', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-54ac-73a4-b3e1-c9618f054913', '01a178e7-2d77-731a-bae5-57307b7db827', 'dcd694f6-adde-466b-830f-0b845f821235', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-54c1-73de-90ad-9a7a7d0d64a9', '01a178e7-2d77-731a-bae5-57307b7db827', 'dce7bb80-5f22-4790-ae2c-d8de0e5a2111', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-54d7-736a-827e-d081693112b0', '01a178e7-2d77-731a-bae5-57307b7db827', 'e26fb7d7-9833-4852-abc8-17a29f5c394c', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-54ed-72db-a1bd-f06b86ba1df3', '01a178e7-2d77-731a-bae5-57307b7db827', 'e47f43ee-cab8-453b-9b2e-055063fc19cc', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-5503-7170-83b6-c9b249159ccb', '01a178e7-2d77-731a-bae5-57307b7db827', 'e5575c00-dc67-4f46-83be-3663e70e8e2d', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-5518-725d-8240-5f68b68e94ca', '01a178e7-2d77-731a-bae5-57307b7db827', 'ea66d41d-bca2-4f8c-8de8-e12dd1ea7d86', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-552f-70f2-9abe-4c540247b269', '01a178e7-2d77-731a-bae5-57307b7db827', 'eb1165a5-d589-4bd1-91f0-62f83fbe59b3', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-5544-72a3-b407-61991e868615', '01a178e7-2d77-731a-bae5-57307b7db827', 'eb2f0e66-9974-4af8-9d89-292efcb7fda5', '2026-10-26 08:49:48', '2026-10-26 08:49:48'),
('01a178e7-555b-71f6-9921-bcd00c6c5112', '01a178e7-2d77-731a-bae5-57307b7db827', 'ec8321b0-b035-4ebf-9e4f-2b02be268ebc', '2026-10-26 08:49:49', '2026-10-26 08:49:49'),
('01a178e7-5571-73b1-8127-911ef01ea9d9', '01a178e7-2d77-731a-bae5-57307b7db827', 'ede5f559-c814-4468-91a2-8fff2e1e023f', '2026-10-26 08:49:49', '2026-10-26 08:49:49'),
('01a178e7-5587-7035-95fd-ed1db3eefa59', '01a178e7-2d77-731a-bae5-57307b7db827', 'ef186510-a205-4f01-a15f-6727dc453c29', '2026-10-26 08:49:49', '2026-10-26 08:49:49'),
('01a178e7-559c-730d-8ea1-e649cbce9f7b', '01a178e7-2d77-731a-bae5-57307b7db827', 'f12f69db-121e-4c4f-9f2c-efb3c95a2aad', '2026-10-26 08:49:49', '2026-10-26 08:49:49'),
('01a178e7-55b6-71f8-bb51-5739ec0a4936', '01a178e7-2d77-731a-bae5-57307b7db827', 'f3b90c16-1dfa-457a-bf5f-4c9848d3af25', '2026-10-26 08:49:49', '2026-10-26 08:49:49'),
('01a178e7-55cd-705f-b4fe-ac61ce2b75a8', '01a178e7-2d77-731a-bae5-57307b7db827', 'fba683c0-92b9-4b48-93d3-0f012c3a5e74', '2026-10-26 08:49:49', '2026-10-26 08:49:49'),
('01a178e7-55e1-733a-a52a-f365a35a4ca3', '01a178e7-2d77-731a-bae5-57307b7db827', 'fcc90cce-c7be-4056-9cce-0fcbe23f47cb', '2026-10-26 08:49:49', '2026-10-26 08:49:49');

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
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

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
COMMIT;
