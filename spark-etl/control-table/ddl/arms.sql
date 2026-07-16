-- MySQL dump 10.13  Distrib 9.7.1, for macos26.4 (arm64)
--
-- Host: 127.0.0.1    Database: arms
-- ------------------------------------------------------
-- Server version	8.4.8

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accreditations`
--

DROP TABLE IF EXISTS `accreditations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accreditations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` bigint unsigned NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `accreditations_user_id_foreign` (`user_id`),
  CONSTRAINT `accreditations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acknowledgements`
--

DROP TABLE IF EXISTS `acknowledgements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acknowledgements` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `company_id` bigint unsigned NOT NULL,
  `acknowledged` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acknowledgements_company_id_foreign` (`company_id`),
  CONSTRAINT `acknowledgements_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `company_profiles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ad_details`
--

DROP TABLE IF EXISTS `ad_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ad_details` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `application_id` bigint unsigned NOT NULL,
  `ad_category` enum('local','foreign') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ad_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `language` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `duration` int DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `station` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `format` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resolution` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_specs` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ad_details_application_id_foreign` (`application_id`),
  CONSTRAINT `ad_details_application_id_foreign` FOREIGN KEY (`application_id`) REFERENCES `material_applications` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ad_package_cancellation_files`
--

DROP TABLE IF EXISTS `ad_package_cancellation_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ad_package_cancellation_files` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cancellation_id` bigint unsigned NOT NULL,
  `uploaded_by` bigint unsigned DEFAULT NULL,
  `file_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `original_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mime_type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` bigint unsigned DEFAULT NULL,
  `meta` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ad_package_cancellation_files_cancellation_id_index` (`cancellation_id`),
  KEY `ad_package_cancellation_files_uploaded_by_index` (`uploaded_by`),
  KEY `ad_package_cancellation_files_file_type_index` (`file_type`),
  CONSTRAINT `ad_package_cancellation_files_cancellation_id_foreign` FOREIGN KEY (`cancellation_id`) REFERENCES `ad_package_cancellations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ad_package_cancellation_files_uploaded_by_foreign` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ad_package_cancellation_logs`
--

DROP TABLE IF EXISTS `ad_package_cancellation_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ad_package_cancellation_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cancellation_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `action` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ad_package_cancellation_logs_cancellation_id_index` (`cancellation_id`),
  KEY `ad_package_cancellation_logs_user_id_index` (`user_id`),
  KEY `ad_package_cancellation_logs_action_index` (`action`),
  CONSTRAINT `ad_package_cancellation_logs_cancellation_id_foreign` FOREIGN KEY (`cancellation_id`) REFERENCES `ad_package_cancellations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ad_package_cancellation_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ad_package_cancellations`
--

DROP TABLE IF EXISTS `ad_package_cancellations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ad_package_cancellations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ad_package_id` bigint unsigned NOT NULL,
  `client_id` bigint unsigned NOT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Semak',
  `client_cancellation_reason` text COLLATE utf8mb4_unicode_ci,
  `client_submitted_at` datetime DEFAULT NULL,
  `preparer_reviewed_at` datetime DEFAULT NULL,
  `approver_comment` text COLLATE utf8mb4_unicode_ci,
  `approver_document_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `approver_first_reviewed_at` datetime DEFAULT NULL,
  `bpp_review_comment` text COLLATE utf8mb4_unicode_ci,
  `bpp_reviewed_at` datetime DEFAULT NULL,
  `approver_decision` tinyint DEFAULT NULL COMMENT '0 = Rejected, 1 = Approved',
  `approver_decision_reason` text COLLATE utf8mb4_unicode_ci,
  `approver_decided_at` datetime DEFAULT NULL,
  `refund_method` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_refund_comment` text COLLATE utf8mb4_unicode_ci,
  `client_refund_submitted_at` datetime DEFAULT NULL,
  `final_approver_comment` text COLLATE utf8mb4_unicode_ci,
  `client_status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `approver_status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bpp_status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deposit_letter_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider_status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `preparer_id` bigint unsigned DEFAULT NULL,
  `approver_id` bigint unsigned DEFAULT NULL,
  `bpp_id` bigint unsigned DEFAULT NULL,
  `resolved_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ad_package_cancellations_preparer_id_foreign` (`preparer_id`),
  KEY `ad_package_cancellations_approver_id_foreign` (`approver_id`),
  KEY `ad_package_cancellations_bpp_id_foreign` (`bpp_id`),
  KEY `ad_package_cancellations_ad_package_id_index` (`ad_package_id`),
  KEY `ad_package_cancellations_client_id_index` (`client_id`),
  CONSTRAINT `ad_package_cancellations_ad_package_id_foreign` FOREIGN KEY (`ad_package_id`) REFERENCES `ad_packages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ad_package_cancellations_approver_id_foreign` FOREIGN KEY (`approver_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ad_package_cancellations_bpp_id_foreign` FOREIGN KEY (`bpp_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ad_package_cancellations_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ad_package_cancellations_preparer_id_foreign` FOREIGN KEY (`preparer_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ad_package_documents`
--

DROP TABLE IF EXISTS `ad_package_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ad_package_documents` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ad_package_id` bigint unsigned NOT NULL,
  `document_type` enum('package','package_document','claim_letter','demand_letter','signed_package','payment_proof') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'package',
  `document_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_package_signed_check` (`ad_package_id`,`document_type`,`document_name`(50)),
  CONSTRAINT `ad_package_documents_ad_package_id_foreign` FOREIGN KEY (`ad_package_id`) REFERENCES `ad_packages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ad_package_items`
--

DROP TABLE IF EXISTS `ad_package_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ad_package_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ad_package_id` bigint unsigned NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ad_package_items_ad_package_id_foreign` (`ad_package_id`),
  CONSTRAINT `ad_package_items_ad_package_id_foreign` FOREIGN KEY (`ad_package_id`) REFERENCES `ad_packages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ad_package_payments`
--

DROP TABLE IF EXISTS `ad_package_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ad_package_payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ad_package_id` bigint unsigned NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `payment_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `status` enum('Pending','Completed','Refunded') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ad_package_payments_ad_package_id_foreign` (`ad_package_id`),
  CONSTRAINT `ad_package_payments_ad_package_id_foreign` FOREIGN KEY (`ad_package_id`) REFERENCES `ad_packages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ad_package_receipts`
--

DROP TABLE IF EXISTS `ad_package_receipts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ad_package_receipts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ad_package_id` bigint unsigned DEFAULT NULL,
  `ad_package_payment_id` bigint unsigned NOT NULL,
  `receipt_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `receipt_date` date NOT NULL,
  `file_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_receipts` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt_balance` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ad_package_receipts_receipt_no_unique` (`receipt_no`),
  KEY `ad_package_receipts_ad_package_payment_id_foreign` (`ad_package_payment_id`),
  KEY `ad_package_receipts_ad_package_id_foreign` (`ad_package_id`),
  CONSTRAINT `ad_package_receipts_ad_package_id_foreign` FOREIGN KEY (`ad_package_id`) REFERENCES `ad_packages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ad_package_receipts_ad_package_payment_id_foreign` FOREIGN KEY (`ad_package_payment_id`) REFERENCES `ad_package_payments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ad_package_refund`
--

DROP TABLE IF EXISTS `ad_package_refund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ad_package_refund` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ad_package_id` bigint unsigned NOT NULL,
  `ad_package_payment_id` bigint unsigned DEFAULT NULL,
  `receipt_id` bigint unsigned DEFAULT NULL,
  `client_id` bigint unsigned NOT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Semak',
  `adjustment_no` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deposit_refund_letter_no` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `approver_comment` text COLLATE utf8mb4_unicode_ci,
  `approver_document_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `approver_first_reviewed_at` datetime DEFAULT NULL,
  `bpp_review_comment` text COLLATE utf8mb4_unicode_ci,
  `bpp_reviewed_at` datetime DEFAULT NULL,
  `approver_decision` tinyint DEFAULT NULL COMMENT '0 = Rejected, 1 = Approved',
  `approver_decision_reason` text COLLATE utf8mb4_unicode_ci,
  `approver_decided_at` datetime DEFAULT NULL,
  `adjustment_amount_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_refund_return_amount` decimal(15,2) DEFAULT NULL,
  `return_note` text COLLATE utf8mb4_unicode_ci,
  `adjustment_note` text COLLATE utf8mb4_unicode_ci,
  `refund_receipt_letter_location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `preparer_reviewed_at` datetime DEFAULT NULL,
  `refund_method` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_refund_comment` text COLLATE utf8mb4_unicode_ci,
  `client_refund_submitted_at` datetime DEFAULT NULL,
  `final_approver_comment` text COLLATE utf8mb4_unicode_ci,
  `latest_balance_amount` decimal(15,2) DEFAULT NULL,
  `client_status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `approver_status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bpp_status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `agency_status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider_status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `preparer_id` bigint unsigned DEFAULT NULL,
  `approver_id` bigint unsigned DEFAULT NULL,
  `bpp_id` bigint unsigned DEFAULT NULL,
  `agency_id` bigint unsigned DEFAULT NULL,
  `provider_id` bigint unsigned DEFAULT NULL,
  `resolved_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `client_doc_1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_doc_2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_doc_3` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_doc_4` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider_adjustment_note` text COLLATE utf8mb4_unicode_ci,
  `provider_processed_at` timestamp NULL DEFAULT NULL,
  `credit_adjustment_letter_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ad_package_refund_preparer_id_foreign` (`preparer_id`),
  KEY `ad_package_refund_approver_id_foreign` (`approver_id`),
  KEY `ad_package_refund_bpp_id_foreign` (`bpp_id`),
  KEY `ad_package_refund_ad_package_id_index` (`ad_package_id`),
  KEY `ad_package_refund_client_id_index` (`client_id`),
  KEY `ad_package_refund_receipt_id_index` (`receipt_id`),
  KEY `ad_package_refund_ad_package_payment_id_index` (`ad_package_payment_id`),
  KEY `ad_package_refund_agency_id_index` (`agency_id`),
  KEY `ad_package_refund_provider_id_index` (`provider_id`),
  CONSTRAINT `ad_package_refund_ad_package_id_foreign` FOREIGN KEY (`ad_package_id`) REFERENCES `ad_packages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ad_package_refund_ad_package_payment_id_foreign` FOREIGN KEY (`ad_package_payment_id`) REFERENCES `ad_package_payments` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ad_package_refund_agency_id_foreign` FOREIGN KEY (`agency_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ad_package_refund_approver_id_foreign` FOREIGN KEY (`approver_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ad_package_refund_bpp_id_foreign` FOREIGN KEY (`bpp_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ad_package_refund_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ad_package_refund_preparer_id_foreign` FOREIGN KEY (`preparer_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ad_package_refund_provider_id_foreign` FOREIGN KEY (`provider_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ad_package_refund_receipt_id_foreign` FOREIGN KEY (`receipt_id`) REFERENCES `ad_package_receipts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ad_package_refund_files`
--

DROP TABLE IF EXISTS `ad_package_refund_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ad_package_refund_files` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `refund_id` bigint unsigned NOT NULL,
  `uploaded_by` bigint unsigned DEFAULT NULL,
  `file_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `original_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mime_type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` bigint unsigned DEFAULT NULL,
  `meta` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ad_package_refund_files_refund_id_index` (`refund_id`),
  KEY `ad_package_refund_files_uploaded_by_index` (`uploaded_by`),
  KEY `ad_package_refund_files_file_type_index` (`file_type`),
  CONSTRAINT `ad_package_refund_files_refund_id_foreign` FOREIGN KEY (`refund_id`) REFERENCES `ad_package_refund` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ad_package_refund_files_uploaded_by_foreign` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ad_package_refund_logs`
--

DROP TABLE IF EXISTS `ad_package_refund_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ad_package_refund_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `refund_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `action` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ad_package_refund_logs_refund_id_index` (`refund_id`),
  KEY `ad_package_refund_logs_user_id_index` (`user_id`),
  KEY `ad_package_refund_logs_action_index` (`action`),
  CONSTRAINT `ad_package_refund_logs_refund_id_foreign` FOREIGN KEY (`refund_id`) REFERENCES `ad_package_refund` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ad_package_refund_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ad_package_refund_payment`
--

DROP TABLE IF EXISTS `ad_package_refund_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ad_package_refund_payment` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ad_package_payment_id` bigint unsigned NOT NULL,
  `ad_package_refund_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `refund_payment_unique` (`ad_package_payment_id`,`ad_package_refund_id`),
  KEY `ad_package_refund_payment_ad_package_payment_id_index` (`ad_package_payment_id`),
  KEY `ad_package_refund_payment_ad_package_refund_id_index` (`ad_package_refund_id`),
  CONSTRAINT `ad_package_refund_payment_ad_package_payment_id_foreign` FOREIGN KEY (`ad_package_payment_id`) REFERENCES `ad_package_payments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ad_package_refund_payment_ad_package_refund_id_foreign` FOREIGN KEY (`ad_package_refund_id`) REFERENCES `ad_package_refund` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ad_packages`
--

DROP TABLE IF EXISTS `ad_packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ad_packages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `contract_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contract_start_date` date DEFAULT NULL,
  `contract_end_date` date DEFAULT NULL,
  `client_id` bigint unsigned NOT NULL,
  `media_id` bigint unsigned NOT NULL,
  `material_application_id` bigint unsigned DEFAULT NULL,
  `total_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `item_description` text COLLATE utf8mb4_unicode_ci,
  `item_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `rounding_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `status` enum('Semua','Semak','Dalam_Semakan','Kemaskini','Kuiri','Ditolak','Telah_Bayar') COLLATE utf8mb4_unicode_ci DEFAULT 'Semak',
  `refund_status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `refund_at` timestamp NULL DEFAULT NULL,
  `cancellation_status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cancelled_at` timestamp NULL DEFAULT NULL,
  `remark` text COLLATE utf8mb4_unicode_ci,
  `client_acknowledgment` enum('approved','rejected') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_acknowledgment_date` timestamp NULL DEFAULT NULL,
  `receipt_date` date DEFAULT NULL,
  `receipt_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_proof_verified_at` timestamp NULL DEFAULT NULL,
  `payment_proof_verified_by` bigint unsigned DEFAULT NULL,
  `advertising_package_document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `claim` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `proof_of_charge` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `preparer_id` bigint unsigned DEFAULT NULL,
  `pic_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pic_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ad_packages_contract_no_unique` (`contract_no`),
  KEY `ad_packages_client_id_foreign` (`client_id`),
  KEY `ad_packages_preparer_id_foreign` (`preparer_id`),
  KEY `ad_packages_media_id_foreign` (`media_id`),
  KEY `ad_packages_material_application_id_foreign` (`material_application_id`),
  KEY `ad_packages_payment_proof_verified_by_foreign` (`payment_proof_verified_by`),
  CONSTRAINT `ad_packages_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ad_packages_material_application_id_foreign` FOREIGN KEY (`material_application_id`) REFERENCES `material_applications` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ad_packages_media_id_foreign` FOREIGN KEY (`media_id`) REFERENCES `media_type` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `ad_packages_payment_proof_verified_by_foreign` FOREIGN KEY (`payment_proof_verified_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ad_packages_preparer_id_foreign` FOREIGN KEY (`preparer_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `agency_profiles`
--

DROP TABLE IF EXISTS `agency_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agency_profiles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `company_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pic_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ssm_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_pendaftaran_perniagaan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ssm_document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_expiration_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `alamat` text COLLATE utf8mb4_unicode_ci,
  `poskod` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `negeri` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `agency_profiles_ssm_no_unique` (`ssm_no`),
  UNIQUE KEY `agency_profiles_no_pendaftaran_perniagaan_unique` (`no_pendaftaran_perniagaan`),
  KEY `agency_profiles_user_id_foreign` (`user_id`),
  CONSTRAINT `agency_profiles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `applications`
--

DROP TABLE IF EXISTS `applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `applications` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `agency_id` bigint unsigned DEFAULT NULL,
  `company_id` bigint unsigned DEFAULT NULL,
  `approver_id` bigint unsigned DEFAULT NULL,
  `application_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `process` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_applying` date DEFAULT NULL,
  `data` json DEFAULT NULL,
  `query_reason` json DEFAULT NULL,
  `rejection_reason` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_applications_company_id` (`company_id`),
  KEY `idx_applications_status` (`status`),
  KEY `idx_applications_date_of_applying` (`date_of_applying`),
  KEY `idx_applications_application_type` (`application_type`),
  KEY `idx_applications_status_date` (`status`,`date_of_applying`),
  KEY `applications_approver_id_foreign` (`approver_id`),
  KEY `applications_agency_id_foreign` (`agency_id`),
  CONSTRAINT `applications_agency_id_foreign` FOREIGN KEY (`agency_id`) REFERENCES `agency_profiles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `applications_approver_id_foreign` FOREIGN KEY (`approver_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bank_guarantees`
--

DROP TABLE IF EXISTS `bank_guarantees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bank_guarantees` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `application_id` bigint unsigned NOT NULL,
  `agency_id` bigint unsigned DEFAULT NULL,
  `company_id` bigint unsigned DEFAULT NULL,
  `amount` decimal(15,2) NOT NULL,
  `bank_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiry_date` date NOT NULL,
  `reference_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'inserted',
  `company_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `certificate_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `certificate_location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `agency_letter_location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `issued_date` date DEFAULT NULL,
  `initial_date` date DEFAULT NULL,
  `deadline_date` date DEFAULT NULL,
  `guarantee_doc_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guarantee_doc_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guarantee_doc_location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stamp_certificate_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stamp_certificate_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stamp_certificate_location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `query_reason` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bank_guarantees_reference_no_unique` (`reference_no`),
  UNIQUE KEY `bank_guarantees_company_code_unique` (`company_code`),
  UNIQUE KEY `bank_guarantees_certificate_code_unique` (`certificate_code`),
  UNIQUE KEY `bank_guarantees_certificate_location_unique` (`certificate_location`),
  KEY `bank_guarantees_company_id_foreign` (`company_id`),
  KEY `bank_guarantees_application_id_foreign` (`application_id`),
  KEY `bank_guarantees_agency_id_foreign` (`agency_id`),
  CONSTRAINT `bank_guarantees_agency_id_foreign` FOREIGN KEY (`agency_id`) REFERENCES `agency_profiles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bank_guarantees_application_id_foreign` FOREIGN KEY (`application_id`) REFERENCES `applications` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `banks`
--

DROP TABLE IF EXISTS `banks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `banks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `bank_txt_code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bank_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bank_initials` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `legacy_id` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billboard_applications`
--

DROP TABLE IF EXISTS `billboard_applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billboard_applications` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `application_id` bigint unsigned NOT NULL,
  `campaign_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `location_preference` text COLLATE utf8mb4_unicode_ci,
  `size_category` enum('small','medium','large','extra_large') COLLATE utf8mb4_unicode_ci NOT NULL,
  `dimensions` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `preferred_start_date` date NOT NULL,
  `preferred_end_date` date NOT NULL,
  `design_concept` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `message_content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `requires_lighting` tinyint(1) NOT NULL DEFAULT '0',
  `special_requirements` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `billboard_applications_application_id_foreign` (`application_id`),
  CONSTRAINT `billboard_applications_application_id_foreign` FOREIGN KEY (`application_id`) REFERENCES `material_applications` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `agency_id` bigint unsigned DEFAULT NULL,
  `company_id` bigint unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `annual_budget` decimal(15,2) NOT NULL,
  `spent_budget` decimal(15,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `application_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `clients_company_id_foreign` (`company_id`),
  KEY `clients_agency_id_foreign` (`agency_id`),
  CONSTRAINT `clients_agency_id_foreign` FOREIGN KEY (`agency_id`) REFERENCES `agency_profiles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `company_profile_information`
--

DROP TABLE IF EXISTS `company_profile_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company_profile_information` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `agency_id` bigint unsigned DEFAULT NULL,
  `company_id` bigint unsigned DEFAULT NULL,
  `registration_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mof_start_date` date DEFAULT NULL,
  `mof_end_date` date DEFAULT NULL,
  `cp_registration_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `iso_certificate_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `iso_start_date` date DEFAULT NULL,
  `iso_end_date` date DEFAULT NULL,
  `company_established_date` date DEFAULT NULL,
  `authorized_capital` decimal(15,2) DEFAULT NULL,
  `issued_capital` decimal(15,2) DEFAULT NULL,
  `office_address` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `application_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `company_profile_information_company_id_foreign` (`company_id`),
  KEY `company_profile_information_agency_id_foreign` (`agency_id`),
  CONSTRAINT `company_profile_information_agency_id_foreign` FOREIGN KEY (`agency_id`) REFERENCES `agency_profiles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `company_profiles`
--

DROP TABLE IF EXISTS `company_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company_profiles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `company_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pic_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ssm_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_pendaftaran_perniagaan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ssm_document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `compney_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type_of_application` enum('new','reform') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_applying` date DEFAULT NULL,
  `business_expiration_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `alamat` text COLLATE utf8mb4_unicode_ci,
  `poskod` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `negeri` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `company_profiles_ssm_no_unique` (`ssm_no`),
  UNIQUE KEY `company_profiles_compney_code_unique` (`compney_code`),
  UNIQUE KEY `company_profiles_no_pendaftaran_perniagaan_unique` (`no_pendaftaran_perniagaan`),
  KEY `company_profiles_user_id_foreign` (`user_id`),
  CONSTRAINT `company_profiles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contract_items`
--

DROP TABLE IF EXISTS `contract_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contract_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `contract_id` bigint unsigned NOT NULL,
  `contract_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seconds` int NOT NULL DEFAULT '0',
  `amount` decimal(12,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `contract_items_contract_id_foreign` (`contract_id`),
  CONSTRAINT `contract_items_contract_id_foreign` FOREIGN KEY (`contract_id`) REFERENCES `contracts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contracts`
--

DROP TABLE IF EXISTS `contracts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contracts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `package_id` bigint unsigned NOT NULL,
  `client` bigint unsigned NOT NULL,
  `contract_start_date` date NOT NULL,
  `contract_end_date` date NOT NULL,
  `contract_amount` decimal(12,2) NOT NULL,
  `latest_broadcast_month` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `monthly_amount` decimal(12,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `contracts_package_id_foreign` (`package_id`),
  CONSTRAINT `contracts_package_id_foreign` FOREIGN KEY (`package_id`) REFERENCES `packages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `credit_note_documents`
--

DROP TABLE IF EXISTS `credit_note_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credit_note_documents` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `credit_note_id` bigint unsigned NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mime_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_size` bigint NOT NULL,
  `document_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'credit_note',
  `uploaded_by` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `credit_note_documents_uploaded_by_foreign` (`uploaded_by`),
  KEY `credit_note_documents_credit_note_id_index` (`credit_note_id`),
  CONSTRAINT `credit_note_documents_credit_note_id_foreign` FOREIGN KEY (`credit_note_id`) REFERENCES `credit_notes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `credit_note_documents_uploaded_by_foreign` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `credit_notes`
--

DROP TABLE IF EXISTS `credit_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credit_notes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `credit_note_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_id` bigint unsigned NOT NULL,
  `client_id` bigint unsigned DEFAULT NULL,
  `package_id` bigint unsigned DEFAULT NULL,
  `reason` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `original_amount` decimal(15,2) NOT NULL COMMENT 'Invoice amount before credit adjustment',
  `credit_amount` decimal(15,2) NOT NULL COMMENT 'Amount being credited back',
  `adjusted_amount` decimal(15,2) NOT NULL COMMENT 'New invoice amount after credit (original - credit)',
  `recalculated_penalty` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Whether penalty was recalculated after this credit',
  `status` enum('pending','approved','rejected','draft','kuiri','kemaskini','diluluskan','ditolak','cancelled','baharu','completed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `workflow_stage` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'customer_request',
  `rtm_reviewed_at` timestamp NULL DEFAULT NULL,
  `rtm_review_notes` text COLLATE utf8mb4_unicode_ci,
  `media_booking_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `preparer_processed_at` timestamp NULL DEFAULT NULL,
  `processing_notes` text COLLATE utf8mb4_unicode_ci,
  `credit_note_date` date DEFAULT NULL,
  `approved_by` bigint unsigned DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `document_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `processed_by` bigint unsigned DEFAULT NULL,
  `amount_adjustment` decimal(15,2) DEFAULT NULL,
  `adjustment_reason` text COLLATE utf8mb4_unicode_ci,
  `approval_notes` text COLLATE utf8mb4_unicode_ci,
  `payment_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_amount` decimal(15,2) DEFAULT NULL,
  `payment_reference` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_notes` text COLLATE utf8mb4_unicode_ci,
  `payment_completed_at` timestamp NULL DEFAULT NULL,
  `receipt_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt_generated_at` timestamp NULL DEFAULT NULL,
  `receipt_notes` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `credit_notes_credit_note_no_unique` (`credit_note_no`),
  KEY `credit_notes_invoice_id_foreign` (`invoice_id`),
  KEY `credit_notes_package_id_foreign` (`package_id`),
  KEY `credit_notes_approved_by_foreign` (`approved_by`),
  KEY `credit_notes_created_by_foreign` (`created_by`),
  KEY `credit_notes_client_id_status_index` (`client_id`,`status`),
  KEY `credit_notes_credit_note_date_index` (`credit_note_date`),
  KEY `credit_notes_status_index` (`status`),
  KEY `credit_notes_processed_by_foreign` (`processed_by`),
  CONSTRAINT `credit_notes_approved_by_foreign` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `credit_notes_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `credit_notes_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `credit_notes_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE,
  CONSTRAINT `credit_notes_package_id_foreign` FOREIGN KEY (`package_id`) REFERENCES `ad_packages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `credit_notes_processed_by_foreign` FOREIGN KEY (`processed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `debit_note_documents`
--

DROP TABLE IF EXISTS `debit_note_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `debit_note_documents` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `debit_note_id` bigint unsigned NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mime_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_size` bigint NOT NULL,
  `document_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'debit_note',
  `uploaded_by` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `debit_note_documents_uploaded_by_foreign` (`uploaded_by`),
  KEY `debit_note_documents_debit_note_id_index` (`debit_note_id`),
  CONSTRAINT `debit_note_documents_debit_note_id_foreign` FOREIGN KEY (`debit_note_id`) REFERENCES `debit_notes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `debit_note_documents_uploaded_by_foreign` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `debit_notes`
--

DROP TABLE IF EXISTS `debit_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `debit_notes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `debit_note_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_id` bigint unsigned NOT NULL,
  `client_id` bigint unsigned DEFAULT NULL,
  `package_id` bigint unsigned DEFAULT NULL,
  `reason` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `original_amount` decimal(15,2) NOT NULL COMMENT 'Invoice amount before debit adjustment',
  `debit_amount` decimal(15,2) NOT NULL COMMENT 'Additional amount being charged',
  `adjusted_amount` decimal(15,2) NOT NULL COMMENT 'New invoice amount after debit (original + debit)',
  `recalculated_penalty` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Whether penalty was recalculated after this debit',
  `status` enum('pending','approved','rejected','draft','kuiri','kemaskini','diluluskan','ditolak','cancelled','baharu','completed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `workflow_stage` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'customer_request',
  `rtm_reviewed_at` timestamp NULL DEFAULT NULL,
  `rtm_review_notes` text COLLATE utf8mb4_unicode_ci,
  `media_booking_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `preparer_processed_at` timestamp NULL DEFAULT NULL,
  `processing_notes` text COLLATE utf8mb4_unicode_ci,
  `debit_note_date` date DEFAULT NULL,
  `approved_by` bigint unsigned DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `document_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `processed_by` bigint unsigned DEFAULT NULL,
  `amount_adjustment` decimal(15,2) DEFAULT NULL,
  `adjustment_reason` text COLLATE utf8mb4_unicode_ci,
  `approval_notes` text COLLATE utf8mb4_unicode_ci,
  `payment_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_amount` decimal(15,2) DEFAULT NULL,
  `payment_reference` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_notes` text COLLATE utf8mb4_unicode_ci,
  `payment_completed_at` timestamp NULL DEFAULT NULL,
  `receipt_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt_generated_at` timestamp NULL DEFAULT NULL,
  `receipt_notes` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `debit_notes_debit_note_no_unique` (`debit_note_no`),
  KEY `debit_notes_invoice_id_foreign` (`invoice_id`),
  KEY `debit_notes_package_id_foreign` (`package_id`),
  KEY `debit_notes_approved_by_foreign` (`approved_by`),
  KEY `debit_notes_created_by_foreign` (`created_by`),
  KEY `debit_notes_client_id_status_index` (`client_id`,`status`),
  KEY `debit_notes_debit_note_date_index` (`debit_note_date`),
  KEY `debit_notes_status_index` (`status`),
  KEY `debit_notes_processed_by_foreign` (`processed_by`),
  CONSTRAINT `debit_notes_approved_by_foreign` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `debit_notes_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `debit_notes_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `debit_notes_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE,
  CONSTRAINT `debit_notes_package_id_foreign` FOREIGN KEY (`package_id`) REFERENCES `ad_packages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `debit_notes_processed_by_foreign` FOREIGN KEY (`processed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `digital_media_applications`
--

DROP TABLE IF EXISTS `digital_media_applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `digital_media_applications` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `application_id` bigint unsigned NOT NULL,
  `campaign_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `platforms` json NOT NULL,
  `content_type` enum('banner','video','interactive','animation') COLLATE utf8mb4_unicode_ci NOT NULL,
  `dimensions` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_size_mb` int DEFAULT NULL,
  `preferred_start_date` date NOT NULL,
  `preferred_end_date` date NOT NULL,
  `target_audience` text COLLATE utf8mb4_unicode_ci,
  `content_description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `call_to_action` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `technical_requirements` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `digital_media_applications_application_id_foreign` (`application_id`),
  CONSTRAINT `digital_media_applications_application_id_foreign` FOREIGN KEY (`application_id`) REFERENCES `material_applications` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `directors`
--

DROP TABLE IF EXISTS `directors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `directors` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `agency_id` bigint unsigned DEFAULT NULL,
  `company_id` bigint unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `nationality` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ic_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `application_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `directors_company_id_foreign` (`company_id`),
  KEY `directors_agency_id_foreign` (`agency_id`),
  CONSTRAINT `directors_agency_id_foreign` FOREIGN KEY (`agency_id`) REFERENCES `agency_profiles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documents` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `agency_id` bigint unsigned DEFAULT NULL,
  `company_id` bigint unsigned DEFAULT NULL,
  `application_id` bigint unsigned NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `ssm_location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ssm_original_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `registered_account_cert_location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `registered_account_cert_original_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `business_address_info_location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `business_address_info_original_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `director_info_location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `director_info_original_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shareholder_info_location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shareholder_info_original_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_act_location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_act_original_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sst_approval_letter_location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sst_approval_letter_original_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `appointment_letter_location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `appointment_letter_original_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `owner_info_location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner_info_original_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `business_info_location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `business_info_original_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `business_registration_certificate_form_d_location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `business_registration_certificate_form_d_original_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documents_company_id_foreign` (`company_id`),
  KEY `documents_application_id_foreign` (`application_id`),
  KEY `documents_agency_id_foreign` (`agency_id`),
  CONSTRAINT `documents_agency_id_foreign` FOREIGN KEY (`agency_id`) REFERENCES `agency_profiles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `documents_application_id_foreign` FOREIGN KEY (`application_id`) REFERENCES `applications` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `government_profiles`
--

DROP TABLE IF EXISTS `government_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `government_profiles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `agency_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pic_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ptj_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ptj_document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `department` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `alamat` text COLLATE utf8mb4_unicode_ci,
  `poskod` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `negeri` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `government_profiles_ptj_no_unique` (`ptj_no`),
  KEY `government_profiles_user_id_foreign` (`user_id`),
  CONSTRAINT `government_profiles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `individual_profiles`
--

DROP TABLE IF EXISTS `individual_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `individual_profiles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `ic_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `full_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `identity_document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `alamat` text COLLATE utf8mb4_unicode_ci,
  `poskod` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `negeri` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `individual_profiles_ic_no_unique` (`ic_no`),
  KEY `individual_profiles_user_id_foreign` (`user_id`),
  CONSTRAINT `individual_profiles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoice_contracts`
--

DROP TABLE IF EXISTS `invoice_contracts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice_contracts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `invoice_id` bigint unsigned NOT NULL,
  `ad_package_id` bigint unsigned NOT NULL,
  `contract_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Contract number (INV-{package_id}-{YYYYMM})',
  `zone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Zone A (Default)' COMMENT 'Broadcast zone (WORKAROUND: Default until scheduler integrated)',
  `time_slot` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '30 seconds' COMMENT 'Broadcast time slot (WORKAROUND: Default until scheduler integrated)',
  `amount` decimal(15,2) NOT NULL COMMENT 'Amount for this contract/schedule entry',
  `billing_month` date NOT NULL COMMENT 'Which month this contract is billing for',
  `start_date` date NOT NULL COMMENT 'Contract start date (month start)',
  `end_date` date NOT NULL COMMENT 'Contract end date (month end)',
  `status` enum('active','inactive','expired') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active' COMMENT 'Contract status',
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoice_contracts_ad_package_id_foreign` (`ad_package_id`),
  KEY `invoice_contracts_created_by_foreign` (`created_by`),
  KEY `invoice_contracts_invoice_id_status_index` (`invoice_id`,`status`),
  KEY `invoice_contracts_billing_month_ad_package_id_index` (`billing_month`,`ad_package_id`),
  KEY `invoice_contracts_status_index` (`status`),
  CONSTRAINT `invoice_contracts_ad_package_id_foreign` FOREIGN KEY (`ad_package_id`) REFERENCES `ad_packages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `invoice_contracts_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `invoice_contracts_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoice_payments`
--

DROP TABLE IF EXISTS `invoice_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice_payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `invoice_id` bigint unsigned NOT NULL,
  `payment_method` enum('cash','bank_transfer','credit_card','online_payment') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'bank_transfer',
  `payment_reference` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(15,2) NOT NULL,
  `payment_date` timestamp NOT NULL,
  `status` enum('pending','completed','failed','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `amendment_type` enum('credit','debit') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amendment_amount` decimal(15,2) DEFAULT NULL,
  `amendment_reason` text COLLATE utf8mb4_unicode_ci,
  `request_type` enum('amount_change','duration_change') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ulasan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `workflow_stage` enum('customer_request','preparer_processing','approver_approval','completed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'customer_request',
  `gateway_response` json DEFAULT NULL,
  `receipt_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoice_payments_created_by_foreign` (`created_by`),
  KEY `invoice_payments_invoice_id_status_index` (`invoice_id`,`status`),
  KEY `invoice_payments_payment_date_index` (`payment_date`),
  KEY `invoice_payments_status_index` (`status`),
  CONSTRAINT `invoice_payments_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `invoice_payments_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoices` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `invoice_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `billing_month` date NOT NULL COMMENT 'Which month this invoice is billing for (YYYY-MM-01)',
  `package_id` bigint unsigned DEFAULT NULL,
  `proforma_invoice_id` bigint unsigned DEFAULT NULL,
  `client_id` bigint unsigned DEFAULT NULL,
  `media_type_id` bigint unsigned DEFAULT NULL,
  `channel` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contract_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bulan_siaran` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jumlah_invois` decimal(15,2) NOT NULL DEFAULT '0.00',
  `tunggakan` decimal(15,2) NOT NULL DEFAULT '0.00',
  `status` enum('pending','pending_payment','approved','paid','overdue','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `invoice_date` date DEFAULT NULL,
  `due_date` date NOT NULL,
  `total_amount` decimal(15,2) NOT NULL,
  `base_amount` decimal(15,2) DEFAULT NULL,
  `commission_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `commission_rate` decimal(5,2) DEFAULT NULL,
  `include_commission` tinyint(1) NOT NULL DEFAULT '0',
  `commission_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `sst_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `sst_rate` decimal(5,2) DEFAULT NULL,
  `include_sst` tinyint(1) NOT NULL DEFAULT '0',
  `sst_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `rounding` decimal(15,2) NOT NULL DEFAULT '0.00',
  `subtotal` decimal(15,2) DEFAULT NULL,
  `paid_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `outstanding_amount` decimal(15,2) NOT NULL,
  `pdf_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `generated_at` timestamp NULL DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `approved_by` bigint unsigned DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `paid_at` timestamp NULL DEFAULT NULL COMMENT 'When payment was received (null if unpaid)',
  `cancelled_at` timestamp NULL DEFAULT NULL COMMENT 'When invoice was cancelled',
  `cancelled_by` bigint unsigned DEFAULT NULL,
  `cancellation_reason` text COLLATE utf8mb4_unicode_ci COMMENT 'Reason for cancellation',
  `receipt_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `invoices_invoice_no_unique` (`invoice_no`),
  KEY `invoices_package_id_foreign` (`package_id`),
  KEY `invoices_media_type_id_foreign` (`media_type_id`),
  KEY `invoices_created_by_foreign` (`created_by`),
  KEY `invoices_approved_by_foreign` (`approved_by`),
  KEY `invoices_client_id_status_index` (`client_id`,`status`),
  KEY `invoices_invoice_date_due_date_index` (`invoice_date`,`due_date`),
  KEY `invoices_status_index` (`status`),
  KEY `invoices_proforma_invoice_id_foreign` (`proforma_invoice_id`),
  KEY `invoices_billing_month_status_index` (`billing_month`,`status`),
  KEY `invoices_client_billing_month_index` (`client_id`,`billing_month`),
  KEY `invoices_billing_month_index` (`billing_month`),
  KEY `invoices_cancelled_by_foreign` (`cancelled_by`),
  CONSTRAINT `invoices_approved_by_foreign` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `invoices_cancelled_by_foreign` FOREIGN KEY (`cancelled_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `invoices_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `invoices_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `invoices_media_type_id_foreign` FOREIGN KEY (`media_type_id`) REFERENCES `media_type` (`id`) ON DELETE CASCADE,
  CONSTRAINT `invoices_package_id_foreign` FOREIGN KEY (`package_id`) REFERENCES `ad_packages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `invoices_proforma_invoice_id_foreign` FOREIGN KEY (`proforma_invoice_id`) REFERENCES `proforma_invoice` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ipayments`
--

DROP TABLE IF EXISTS `ipayments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ipayments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ad_package_id` bigint unsigned NOT NULL,
  `nombor_rujukan_message` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_rujukan_1` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `nombor_rujukan_resit` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombor_rujukan_transaksi_ipayment` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombor_rujukan_transaksi_rma_1` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_rujukan_maklumat_terimaan` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `saluran_pembayaran` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kod_gerbang_pembayaran` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amaun_resit` decimal(13,2) DEFAULT NULL,
  `jenis_proses_resit` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tarikh_dan_masa_resit` datetime DEFAULT NULL,
  `sebab_batal_resit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kategori_batal_resit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tarikh_dan_masa_batal_resit` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ipayments_ad_package_id_foreign` (`ad_package_id`),
  CONSTRAINT `ipayments_ad_package_id_foreign` FOREIGN KEY (`ad_package_id`) REFERENCES `ad_packages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `managing_directors`
--

DROP TABLE IF EXISTS `managing_directors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `managing_directors` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `agency_id` bigint unsigned DEFAULT NULL,
  `company_id` bigint unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `nationality` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ic_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `application_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `managing_directors_company_id_foreign` (`company_id`),
  KEY `managing_directors_agency_id_foreign` (`agency_id`),
  CONSTRAINT `managing_directors_agency_id_foreign` FOREIGN KEY (`agency_id`) REFERENCES `agency_profiles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `material_applications`
--

DROP TABLE IF EXISTS `material_applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `material_applications` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `source_application_id` bigint unsigned DEFAULT NULL,
  `application_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_kp` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_id` bigint unsigned DEFAULT NULL,
  `package_id` bigint unsigned DEFAULT NULL,
  `client_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `register_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `register_contact` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `register_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `media_type` enum('tv','radio','billboard','digital') COLLATE utf8mb4_unicode_ci NOT NULL,
  `application_type` enum('script_review','ready_materials') COLLATE utf8mb4_unicode_ci NOT NULL,
  `application_date` date DEFAULT NULL,
  `ad_category` enum('local','foreign') COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subtitle` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `language` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `duration` int DEFAULT NULL COMMENT 'Duration in seconds',
  `release_date` date DEFAULT NULL,
  `station` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ad_type` enum('interview','rerayap','video_clip','live_read_promo','jingle','other') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ad_type_other` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_ready_material` tinyint(1) NOT NULL DEFAULT '0',
  `format_mp4` tinyint(1) NOT NULL DEFAULT '0',
  `format_mpeg` tinyint(1) NOT NULL DEFAULT '0',
  `format_mov` tinyint(1) NOT NULL DEFAULT '0',
  `format_others` tinyint(1) NOT NULL DEFAULT '0',
  `status` enum('draft','hantar','semak','kuiri','kuiri_penyedia','kuiri_pelulus','kemaskini','kemaskini_kuiri','tidak_diluluskan','lulus','ready_to_broadcast') COLLATE utf8mb4_unicode_ci DEFAULT 'draft',
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `reviewed_by` bigint unsigned DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `material_applications_client_id_foreign` (`client_id`),
  KEY `material_applications_reviewed_by_foreign` (`reviewed_by`),
  KEY `material_applications_package_id_foreign` (`package_id`),
  KEY `material_applications_source_application_id_foreign` (`source_application_id`),
  CONSTRAINT `material_applications_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `material_applications_package_id_foreign` FOREIGN KEY (`package_id`) REFERENCES `ad_packages` (`id`) ON DELETE SET NULL,
  CONSTRAINT `material_applications_reviewed_by_foreign` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `material_applications_source_application_id_foreign` FOREIGN KEY (`source_application_id`) REFERENCES `material_applications` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `material_documents`
--

DROP TABLE IF EXISTS `material_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `material_documents` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `application_id` bigint unsigned NOT NULL,
  `category` enum('script','regulatory','ready_material','other') COLLATE utf8mb4_unicode_ci NOT NULL,
  `document_type` enum('story_outline','storyboard','FINAS','LPF','KKLIU','JAKIM','NOT_MAL','MQA','FoodQuality','LaborAct','ConsumerProtection','DBP','PesticideBoard','OtherActs','MP4','MOV','MPEG','MP3') COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_size` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mime_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `material_documents_application_id_foreign` (`application_id`),
  CONSTRAINT `material_documents_application_id_foreign` FOREIGN KEY (`application_id`) REFERENCES `material_applications` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `material_reviews`
--

DROP TABLE IF EXISTS `material_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `material_reviews` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `application_id` bigint unsigned NOT NULL,
  `reviewer_id` bigint unsigned NOT NULL,
  `review_type` enum('provider','approver','admin') COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('draft','hantar','submitted','semak','kuiri','kuiri_penyedia','kuiri_pelulus','kemaskini','kemaskini_kuiri','tidak_diluluskan','lulus','ready_to_broadcast') COLLATE utf8mb4_unicode_ci DEFAULT 'semak',
  `comments` text COLLATE utf8mb4_unicode_ci,
  `checklist` json DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `material_reviews_application_id_foreign` (`application_id`),
  KEY `material_reviews_reviewer_id_foreign` (`reviewer_id`),
  CONSTRAINT `material_reviews_application_id_foreign` FOREIGN KEY (`application_id`) REFERENCES `material_applications` (`id`) ON DELETE CASCADE,
  CONSTRAINT `material_reviews_reviewer_id_foreign` FOREIGN KEY (`reviewer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `collection_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mime_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disk` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `conversions_disk` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` bigint unsigned NOT NULL,
  `manipulations` json NOT NULL,
  `custom_properties` json NOT NULL,
  `generated_conversions` json NOT NULL,
  `responsive_images` json NOT NULL,
  `order_column` int unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `media_uuid_unique` (`uuid`),
  KEY `media_model_type_model_id_index` (`model_type`,`model_id`),
  KEY `media_order_column_index` (`order_column`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `media_type`
--

DROP TABLE IF EXISTS `media_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media_type` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=212 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint unsigned NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `packages`
--

DROP TABLE IF EXISTS `packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `packages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `agency` bigint unsigned NOT NULL,
  `media_type` bigint unsigned NOT NULL,
  `channel` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `packages_media_type_foreign` (`media_type`),
  CONSTRAINT `packages_media_type_foreign` FOREIGN KEY (`media_type`) REFERENCES `media_type` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `penalty`
--

DROP TABLE IF EXISTS `penalty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `penalty` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `invoice_id` bigint unsigned DEFAULT NULL,
  `agency` bigint unsigned DEFAULT NULL,
  `penalty_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `penalty_date` date NOT NULL,
  `penalty_due_date` date DEFAULT NULL COMMENT 'Date penalty payment is due (penalty_date + 17 days)',
  `invoice_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_date` date DEFAULT NULL,
  `amount` decimal(12,2) DEFAULT NULL,
  `days_overdue` int DEFAULT NULL COMMENT 'Number of days invoice is overdue',
  `penalty_rate` decimal(5,2) DEFAULT NULL COMMENT 'Penalty rate as percentage (e.g., 2.00 for 2%)',
  `base_amount` decimal(15,2) DEFAULT NULL COMMENT 'Invoice amount being penalized',
  `penalty_amount` decimal(15,2) DEFAULT NULL COMMENT 'Calculated penalty amount',
  `type_of_penalty` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_letter_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `surat_peringatan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'SP1, SP2, SP3',
  `sp1_date` date DEFAULT NULL COMMENT 'Date SP1 (Surat Peringatan 1) sent',
  `sp1_no` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sp2_date` date DEFAULT NULL COMMENT 'Date SP2 (Surat Peringatan 2) sent',
  `sp2_no` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sp3_date` date DEFAULT NULL COMMENT 'Date SP3 (Surat Peringatan 3) sent',
  `sp3_no` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `outstanding_amount` decimal(15,2) DEFAULT NULL,
  `total_amount` decimal(12,2) DEFAULT NULL COMMENT 'Outstanding amount + penalty amount',
  `is_paid` tinyint NOT NULL DEFAULT '0',
  `status` enum('pending','waived','charged','paid') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'charged' COMMENT 'Penalty status',
  `waived_by` bigint unsigned DEFAULT NULL,
  `waived_reason` text COLLATE utf8mb4_unicode_ci COMMENT 'Reason for waiver',
  `waived_at` timestamp NULL DEFAULT NULL COMMENT 'When penalty was waived',
  `submitted_by` bigint unsigned DEFAULT NULL COMMENT 'User who submitted penalty for approval',
  `submitted_at` timestamp NULL DEFAULT NULL COMMENT 'When penalty was submitted for approval',
  `approved_by` bigint unsigned DEFAULT NULL COMMENT 'User who approved the penalty',
  `approved_at` timestamp NULL DEFAULT NULL COMMENT 'When penalty was approved',
  `workflow_status` enum('draft','submitted','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft' COMMENT 'Current workflow status',
  `approval_notes` text COLLATE utf8mb4_unicode_ci COMMENT 'Notes from approver',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `penalty_waived_by_foreign` (`waived_by`),
  KEY `penalty_invoice_id_status_index` (`invoice_id`,`status`),
  KEY `penalty_status_index` (`status`),
  CONSTRAINT `penalty_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE,
  CONSTRAINT `penalty_waived_by_foreign` FOREIGN KEY (`waived_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `penalty_invoice_information`
--

DROP TABLE IF EXISTS `penalty_invoice_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `penalty_invoice_information` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `penalty` bigint unsigned NOT NULL,
  `contract` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `personnel_summary`
--

DROP TABLE IF EXISTS `personnel_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personnel_summary` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `agency_id` bigint unsigned DEFAULT NULL,
  `company_id` bigint unsigned DEFAULT NULL,
  `category` enum('management','executive','jr_executive','clerical','low_staff') COLLATE utf8mb4_unicode_ci NOT NULL,
  `citizen` int DEFAULT NULL,
  `foreigner` int DEFAULT NULL,
  `bumiputera` int DEFAULT NULL,
  `non_bumiputera` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `application_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `personnel_summary_company_id_foreign` (`company_id`),
  KEY `personnel_summary_agency_id_foreign` (`agency_id`),
  CONSTRAINT `personnel_summary_agency_id_foreign` FOREIGN KEY (`agency_id`) REFERENCES `agency_profiles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `proforma_invoice`
--

DROP TABLE IF EXISTS `proforma_invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proforma_invoice` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `package_id` bigint unsigned DEFAULT NULL COMMENT 'Links proforma to advertisement package',
  `invoice_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `billing_month` date DEFAULT NULL COMMENT 'Which month this proforma is for (always NEXT month from request date)',
  `total_amount` decimal(15,2) DEFAULT NULL COMMENT 'Total amount from package',
  `status` enum('draft','submitted','under_review','reviewed','approved','pending','rejected','generated') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `media_type_id` bigint unsigned DEFAULT NULL,
  `channel` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `agency_id` bigint unsigned DEFAULT NULL,
  `ssm_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receiptDate` date DEFAULT NULL,
  `statusId` bigint unsigned DEFAULT NULL,
  `statusDesc` text COLLATE utf8mb4_unicode_ci,
  `generated_at` timestamp NULL DEFAULT NULL,
  `submitted_at` timestamp NULL DEFAULT NULL,
  `submitted_by` bigint unsigned DEFAULT NULL,
  `gross_amount` decimal(10,2) DEFAULT NULL,
  `commission` decimal(10,2) DEFAULT NULL,
  `sst` decimal(10,2) DEFAULT NULL,
  `final_amount` decimal(10,2) DEFAULT NULL,
  `commission_rate` decimal(5,2) DEFAULT NULL,
  `sst_rate` decimal(5,2) DEFAULT NULL,
  `include_commission` tinyint(1) NOT NULL DEFAULT '1',
  `include_sst` tinyint(1) NOT NULL DEFAULT '0',
  `pdf_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comments` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `proforma_invoice_invoice_no_unique` (`invoice_no`),
  UNIQUE KEY `proforma_agency_month_channel_unique` (`agency_id`,`billing_month`,`channel`),
  KEY `proforma_invoice_media_type_id_foreign` (`media_type_id`),
  KEY `proforma_invoice_billing_month_index` (`billing_month`),
  KEY `proforma_invoice_package_id_foreign` (`package_id`),
  KEY `proforma_invoice_submitted_by_foreign` (`submitted_by`),
  CONSTRAINT `proforma_invoice_agency_id_foreign` FOREIGN KEY (`agency_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `proforma_invoice_media_type_id_foreign` FOREIGN KEY (`media_type_id`) REFERENCES `media_type` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `proforma_invoice_package_id_foreign` FOREIGN KEY (`package_id`) REFERENCES `ad_packages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `proforma_invoice_submitted_by_foreign` FOREIGN KEY (`submitted_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `proforma_invoice_contract_items`
--

DROP TABLE IF EXISTS `proforma_invoice_contract_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proforma_invoice_contract_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `contract_id` bigint unsigned NOT NULL,
  `item_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `quantity` int NOT NULL,
  `unit_price` decimal(15,2) NOT NULL,
  `total_price` decimal(15,2) NOT NULL,
  `item_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'service',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `proforma_invoice_contract_items_contract_id_index` (`contract_id`),
  CONSTRAINT `proforma_invoice_contract_items_contract_id_foreign` FOREIGN KEY (`contract_id`) REFERENCES `proforma_invoice_contracts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `proforma_invoice_contracts`
--

DROP TABLE IF EXISTS `proforma_invoice_contracts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proforma_invoice_contracts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ad_package_id` bigint unsigned DEFAULT NULL,
  `proforma_invoice_id` bigint unsigned DEFAULT NULL,
  `client_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contract_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `channel` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `booking_date` date DEFAULT NULL,
  `zone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time_slot` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(15,2) DEFAULT NULL,
  `total_amount` decimal(15,2) DEFAULT NULL,
  `billing_month` date DEFAULT NULL,
  `monthly_amount` decimal(15,2) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `contract_start_date` date DEFAULT NULL,
  `contract_end_date` date DEFAULT NULL,
  `contract_duration` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('active','inactive','expired') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `proforma_invoice_contracts_created_by_foreign` (`created_by`),
  KEY `proforma_invoice_contracts_proforma_invoice_id_status_index` (`proforma_invoice_id`,`status`),
  KEY `proforma_invoice_contracts_start_date_end_date_index` (`start_date`,`end_date`),
  KEY `proforma_invoice_contracts_status_index` (`status`),
  KEY `proforma_invoice_contracts_ad_package_id_foreign` (`ad_package_id`),
  CONSTRAINT `proforma_invoice_contracts_ad_package_id_foreign` FOREIGN KEY (`ad_package_id`) REFERENCES `ad_packages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `proforma_invoice_contracts_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `proforma_invoice_contracts_proforma_invoice_id_foreign` FOREIGN KEY (`proforma_invoice_id`) REFERENCES `proforma_invoice` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `radio_applications`
--

DROP TABLE IF EXISTS `radio_applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `radio_applications` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `application_id` bigint unsigned NOT NULL,
  `program_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `duration_seconds` int NOT NULL,
  `time_slot` enum('morning','afternoon','evening','night') COLLATE utf8mb4_unicode_ci NOT NULL,
  `preferred_start_date` date NOT NULL,
  `preferred_end_date` date NOT NULL,
  `target_audience` text COLLATE utf8mb4_unicode_ci,
  `script_content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `voice_talent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `background_music` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `language` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'malay',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `radio_applications_application_id_foreign` (`application_id`),
  CONSTRAINT `radio_applications_application_id_foreign` FOREIGN KEY (`application_id`) REFERENCES `material_applications` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `receipts`
--

DROP TABLE IF EXISTS `receipts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receipts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `receipt_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Receipt number (RCP-YYYY-####)',
  `submission_batch_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Groups receipts submitted together (BATCH-YYYYMMDD-HHMMSS-RANDOM)',
  `invoice_id` bigint unsigned NOT NULL,
  `ad_package_id` bigint unsigned NOT NULL,
  `amount` decimal(15,2) NOT NULL COMMENT 'Payment amount received',
  `payment_method` enum('FPX','Credit Card','Bank Transfer','Cheque','Cash') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'How payment was made',
  `payment_date` date NOT NULL COMMENT 'When payment was received',
  `transaction_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Bank/gateway transaction reference',
  `status` enum('pending','submitted','under_review','approved','rejected','completed','failed','refunded') COLLATE utf8mb4_unicode_ci DEFAULT 'pending' COMMENT 'Payment status',
  `payment_proof_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Path to payment proof (bank slip, etc)',
  `supporting_document_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Path to supporting documents (optional)',
  `pdf_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pdf_generated_at` timestamp NULL DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci COMMENT 'Additional notes or remarks',
  `created_by` bigint unsigned DEFAULT NULL,
  `reviewed_by` bigint unsigned DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL COMMENT 'When provider reviewed this payment',
  `rejection_reason` text COLLATE utf8mb4_unicode_ci COMMENT 'Reason for rejection if payment was rejected',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `receipts_receipt_no_unique` (`receipt_no`),
  KEY `receipts_created_by_foreign` (`created_by`),
  KEY `receipts_invoice_id_status_index` (`invoice_id`,`status`),
  KEY `receipts_payment_date_index` (`payment_date`),
  KEY `receipts_ad_package_id_payment_date_index` (`ad_package_id`,`payment_date`),
  KEY `receipts_submission_batch_id_index` (`submission_batch_id`),
  KEY `receipts_reviewed_by_reviewed_at_index` (`reviewed_by`,`reviewed_at`),
  KEY `receipts_status_created_at_index` (`status`,`created_at`),
  CONSTRAINT `receipts_ad_package_id_foreign` FOREIGN KEY (`ad_package_id`) REFERENCES `ad_packages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `receipts_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `receipts_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE,
  CONSTRAINT `receipts_reviewed_by_foreign` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reminders`
--

DROP TABLE IF EXISTS `reminders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reminders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `invoice_id` bigint unsigned DEFAULT NULL,
  `sp_level` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Surat Peringatan level: SP1, SP2, SP3',
  `sp_due_date` date DEFAULT NULL COMMENT 'Due date for this SP reminder',
  `related_type` enum('invoice','penalty') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'invoice' COMMENT 'invoice = reminder for invoice payment, penalty = reminder for penalty payment',
  `reminder_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sent_via` enum('email','sms','system','all') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'email' COMMENT 'How reminder was sent',
  `status` enum('draft','pending_approval','approved','sent','pending','delivered','failed','bounced') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `penalty_id` bigint unsigned DEFAULT NULL,
  `reminder_number` int NOT NULL COMMENT '1, 2, or 3',
  `template_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `generated_by` bigint unsigned DEFAULT NULL,
  `approved_by` bigint unsigned DEFAULT NULL,
  `sent_by` bigint unsigned DEFAULT NULL,
  `custom_message` text COLLATE utf8mb4_unicode_ci,
  `approval_notes` text COLLATE utf8mb4_unicode_ci,
  `recipient_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recipient_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Phone number for SMS reminders',
  `generated_at` timestamp NULL DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `sent_at` timestamp NULL DEFAULT NULL,
  `file_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reminders_generated_by_foreign` (`generated_by`),
  KEY `reminders_approved_by_foreign` (`approved_by`),
  KEY `reminders_sent_by_foreign` (`sent_by`),
  KEY `reminders_penalty_id_reminder_number_index` (`penalty_id`,`reminder_number`),
  KEY `reminders_generated_at_index` (`generated_at`),
  KEY `reminders_invoice_id_reminder_type_index` (`invoice_id`,`reminder_type`),
  KEY `reminders_status_sent_at_index` (`status`,`sent_at`),
  KEY `reminders_sp_lookup_index` (`sp_level`,`related_type`,`status`),
  CONSTRAINT `reminders_approved_by_foreign` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `reminders_generated_by_foreign` FOREIGN KEY (`generated_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reminders_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reminders_sent_by_foreign` FOREIGN KEY (`sent_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `secretaries`
--

DROP TABLE IF EXISTS `secretaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `secretaries` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `agency_id` bigint unsigned DEFAULT NULL,
  `company_id` bigint unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `nationality` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ic_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `application_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `secretaries_company_id_foreign` (`company_id`),
  KEY `secretaries_agency_id_foreign` (`agency_id`),
  CONSTRAINT `secretaries_agency_id_foreign` FOREIGN KEY (`agency_id`) REFERENCES `agency_profiles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shareholders`
--

DROP TABLE IF EXISTS `shareholders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shareholders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `agency_id` bigint unsigned DEFAULT NULL,
  `company_id` bigint unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nationality` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_share` decimal(15,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `application_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `shareholders_company_id_foreign` (`company_id`),
  KEY `shareholders_agency_id_foreign` (`agency_id`),
  CONSTRAINT `shareholders_agency_id_foreign` FOREIGN KEY (`agency_id`) REFERENCES `agency_profiles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `telescope_entries`
--

DROP TABLE IF EXISTS `telescope_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `telescope_entries` (
  `sequence` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `family_hash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `should_display_on_index` tinyint(1) NOT NULL DEFAULT '1',
  `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`sequence`),
  UNIQUE KEY `telescope_entries_uuid_unique` (`uuid`),
  KEY `telescope_entries_batch_id_index` (`batch_id`),
  KEY `telescope_entries_family_hash_index` (`family_hash`),
  KEY `telescope_entries_created_at_index` (`created_at`),
  KEY `telescope_entries_type_should_display_on_index_index` (`type`,`should_display_on_index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `telescope_entries_tags`
--

DROP TABLE IF EXISTS `telescope_entries_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `telescope_entries_tags` (
  `entry_uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tag` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`entry_uuid`,`tag`),
  KEY `telescope_entries_tags_tag_index` (`tag`),
  CONSTRAINT `telescope_entries_tags_entry_uuid_foreign` FOREIGN KEY (`entry_uuid`) REFERENCES `telescope_entries` (`uuid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `telescope_monitoring`
--

DROP TABLE IF EXISTS `telescope_monitoring`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `telescope_monitoring` (
  `tag` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tv_applications`
--

DROP TABLE IF EXISTS `tv_applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tv_applications` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `application_id` bigint unsigned NOT NULL,
  `program_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `duration_seconds` int NOT NULL,
  `time_slot` enum('prime','morning','afternoon','evening','late_night') COLLATE utf8mb4_unicode_ci NOT NULL,
  `preferred_start_date` date NOT NULL,
  `preferred_end_date` date NOT NULL,
  `target_audience` text COLLATE utf8mb4_unicode_ci,
  `content_summary` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `has_subtitles` tinyint(1) NOT NULL DEFAULT '0',
  `language` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'malay',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tv_applications_application_id_foreign` (`application_id`),
  CONSTRAINT `tv_applications_application_id_foreign` FOREIGN KEY (`application_id`) REFERENCES `material_applications` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_ad_packages`
--

DROP TABLE IF EXISTS `user_ad_packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_ad_packages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `ad_package_id` bigint unsigned NOT NULL,
  `reason` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checked` enum('agree','disagree') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_ad_packages_user_id_ad_package_id_unique` (`user_id`,`ad_package_id`),
  KEY `user_ad_packages_ad_package_id_foreign` (`ad_package_id`),
  CONSTRAINT `user_ad_packages_ad_package_id_foreign` FOREIGN KEY (`ad_package_id`) REFERENCES `ad_packages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_ad_packages_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_package_receipts`
--

DROP TABLE IF EXISTS `user_package_receipts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_package_receipts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `ad_package_receipt_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_package_receipts_user_id_ad_package_receipt_id_unique` (`user_id`,`ad_package_receipt_id`),
  KEY `user_package_receipts_ad_package_receipt_id_foreign` (`ad_package_receipt_id`),
  CONSTRAINT `user_package_receipts_ad_package_receipt_id_foreign` FOREIGN KEY (`ad_package_receipt_id`) REFERENCES `ad_package_receipts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_package_receipts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `profile_id` bigint unsigned DEFAULT NULL,
  `profile_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `terms_accepted` tinyint(1) NOT NULL DEFAULT '0',
  `terms_accepted_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `legacy_id` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_unique` (`username`),
  KEY `users_email_index` (`email`),
  KEY `users_profile_type_profile_id_index` (`profile_type`,`profile_id`),
  KEY `users_username_index` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'arms'
--
--
-- WARNING: can't read the INFORMATION_SCHEMA.libraries table. It's most probably an old server 8.4.8.
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-16 17:28:19
