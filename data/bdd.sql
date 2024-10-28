-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : lun. 28 oct. 2024 à 09:55
-- Version du serveur : 8.0.39-0ubuntu0.24.04.2
-- Version de PHP : 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `omeka_s`
--

-- --------------------------------------------------------

--
-- Structure de la table `api_key`
--

CREATE TABLE `api_key` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner_id` int NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `credential_hash` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_ip` varbinary(16) DEFAULT NULL COMMENT '(DC2Type:ip_address)',
  `last_accessed` datetime DEFAULT NULL,
  `created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `asset`
--

CREATE TABLE `asset` (
  `id` int NOT NULL,
  `owner_id` int DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `media_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `storage_id` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `extension` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alt_text` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `csvimport_entity`
--

CREATE TABLE `csvimport_entity` (
  `id` int NOT NULL,
  `job_id` int NOT NULL,
  `entity_id` int NOT NULL,
  `resource_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `csvimport_entity`
--

INSERT INTO `csvimport_entity` (`id`, `job_id`, `entity_id`, `resource_type`) VALUES
(19, 3, 19, 'items'),
(20, 3, 20, 'items'),
(21, 3, 21, 'items'),
(22, 3, 22, 'items'),
(23, 3, 23, 'items'),
(24, 3, 24, 'items'),
(25, 3, 25, 'items'),
(26, 3, 26, 'items'),
(27, 3, 27, 'items'),
(28, 3, 28, 'items'),
(29, 3, 29, 'items'),
(30, 3, 30, 'items'),
(31, 3, 31, 'items'),
(32, 4, 37, 'items'),
(33, 4, 38, 'items'),
(34, 4, 39, 'items'),
(35, 4, 40, 'items'),
(36, 4, 41, 'items'),
(37, 4, 42, 'items'),
(38, 4, 43, 'items'),
(39, 4, 44, 'items'),
(40, 4, 45, 'items'),
(41, 4, 46, 'items'),
(42, 4, 47, 'items'),
(43, 4, 48, 'items'),
(44, 4, 49, 'items'),
(45, 5, 58, 'items'),
(46, 5, 59, 'items'),
(47, 5, 60, 'items'),
(48, 5, 61, 'items'),
(49, 5, 62, 'items'),
(50, 5, 63, 'items'),
(51, 5, 64, 'items'),
(52, 5, 65, 'items'),
(53, 5, 66, 'items'),
(54, 5, 67, 'items'),
(55, 5, 68, 'items'),
(56, 5, 69, 'items'),
(57, 5, 70, 'items'),
(58, 6, 71, 'items'),
(59, 6, 72, 'items'),
(60, 6, 73, 'items'),
(61, 6, 74, 'items'),
(62, 6, 75, 'items'),
(63, 6, 76, 'items'),
(64, 6, 77, 'items'),
(65, 6, 78, 'items'),
(66, 6, 79, 'items'),
(67, 6, 80, 'items'),
(68, 6, 81, 'items'),
(69, 6, 82, 'items'),
(70, 6, 83, 'items');

-- --------------------------------------------------------

--
-- Structure de la table `csvimport_import`
--

CREATE TABLE `csvimport_import` (
  `id` int NOT NULL,
  `job_id` int NOT NULL,
  `undo_job_id` int DEFAULT NULL,
  `comment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resource_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `has_err` tinyint(1) NOT NULL,
  `stats` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `csvimport_import`
--

INSERT INTO `csvimport_import` (`id`, `job_id`, `undo_job_id`, `comment`, `resource_type`, `has_err`, `stats`) VALUES
(3, 3, NULL, '', 'items', 0, '{\"added\":{\"items\":13}}'),
(4, 4, NULL, '', 'items', 0, '{\"added\":{\"items\":13}}'),
(5, 5, NULL, '', 'items', 0, '{\"added\":{\"items\":13}}'),
(6, 6, NULL, '', 'items', 0, '{\"added\":{\"items\":13}}');

-- --------------------------------------------------------

--
-- Structure de la table `fulltext_search`
--

CREATE TABLE `fulltext_search` (
  `id` int NOT NULL,
  `resource` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner_id` int DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL,
  `title` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `text` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `fulltext_search`
--

INSERT INTO `fulltext_search` (`id`, `resource`, `owner_id`, `is_public`, `title`, `text`) VALUES
(1, 'items', 1, 1, NULL, '10/10/2024 10:12:37\nHomme\n24\na.hef2000@gmail.Com'),
(2, 'items', 1, 1, NULL, '10/10/2024 10:13:00\nHomme\n24\nanas.hefied7@gmail.com'),
(3, 'items', 1, 1, NULL, '12/10/2024 15:39:55\nHomme\n28\nmassidireddy@gmail.com'),
(4, 'items', 1, 1, NULL, '13/10/2024 02:00:54\nHomme\n25\nouksili.samy@yahoo.com'),
(5, 'items', 1, 1, NULL, '13/10/2024 15:43:10\nHomme\n22\nAmjahidmohamedamin@gmail.com'),
(6, 'items', 1, 1, NULL, '10/10/2024 10:12:37\nHomme\n24\na.hef2000@gmail.Com'),
(7, 'items', 1, 1, NULL, '10/10/2024 10:13:00\nHomme\n24\nanas.hefied7@gmail.com'),
(8, 'items', 1, 1, NULL, '12/10/2024 15:39:55\nHomme\n28\nmassidireddy@gmail.com'),
(9, 'items', 1, 1, NULL, '13/10/2024 02:00:54\nHomme\n25\nouksili.samy@yahoo.com'),
(10, 'items', 1, 1, NULL, '13/10/2024 15:43:10\nHomme\n22\nAmjahidmohamedamin@gmail.com'),
(11, 'items', 1, 1, NULL, '13/10/2024 16:18:09\nHomme\n24\nahmed45jab@gmail.com'),
(12, 'items', 1, 1, NULL, '13/10/2024 16:21:05\nHomme\n26\nmokraniislam998@gmail.com'),
(13, 'items', 1, 1, NULL, '13/10/2024 20:44:09\nFemme\n28\nmelissaorb02@gmail.com'),
(14, 'items', 1, 1, NULL, '13/10/2024 21:01:48\nHomme\n24\nnathan.benais@gmail.com'),
(15, 'items', 1, 1, NULL, '13/10/2024 22:32:03\nFemme\n23\nmoussaoui.rania755@gmail.com'),
(16, 'items', 1, 1, NULL, '14/10/2024 08:17:06\nHomme\n24\nnoureddineaitkhouya@gmail.com'),
(17, 'items', 1, 1, NULL, '14/10/2024 08:37:56\nFemme\n23\noumaimaelfazazi01@gmail.com'),
(18, 'items', 1, 1, NULL, '14/10/2024 09:23:18\nFemme\n23\nyasmine.guemat97@gmail.com'),
(19, 'items', 1, 1, NULL, '10/10/2024 10:12:37\nHomme\n24\na.hef2000@gmail.Com'),
(20, 'items', 1, 1, NULL, '10/10/2024 10:13:00\nHomme\n24\nanas.hefied7@gmail.com'),
(21, 'items', 1, 1, NULL, '12/10/2024 15:39:55\nHomme\n28\nmassidireddy@gmail.com'),
(22, 'items', 1, 1, NULL, '13/10/2024 02:00:54\nHomme\n25\nouksili.samy@yahoo.com'),
(23, 'items', 1, 1, NULL, '13/10/2024 15:43:10\nHomme\n22\nAmjahidmohamedamin@gmail.com'),
(24, 'items', 1, 1, NULL, '13/10/2024 16:18:09\nHomme\n24\nahmed45jab@gmail.com'),
(25, 'items', 1, 1, NULL, '13/10/2024 16:21:05\nHomme\n26\nmokraniislam998@gmail.com'),
(26, 'items', 1, 1, NULL, '13/10/2024 20:44:09\nFemme\n28\nmelissaorb02@gmail.com'),
(27, 'items', 1, 1, NULL, '13/10/2024 21:01:48\nHomme\n24\nnathan.benais@gmail.com'),
(28, 'items', 1, 1, NULL, '13/10/2024 22:32:03\nFemme\n23\nmoussaoui.rania755@gmail.com'),
(29, 'items', 1, 1, NULL, '14/10/2024 08:17:06\nHomme\n24\nnoureddineaitkhouya@gmail.com'),
(30, 'items', 1, 1, NULL, '14/10/2024 08:37:56\nFemme\n23\noumaimaelfazazi01@gmail.com'),
(35, 'items', 1, 1, 'Patient4', 'Patient4\nPatient1\n13/10/2024 16:18:09\nahmed45jab@gmail.com\nPatient2\n24\nHomme\nPatient2\nNon\nle Sport\nNon'),
(36, 'items', 1, 1, 'Patient5', 'Patient5\nPatient1\n28/10/2024 12:00:00\n a.hef1961@gmail.com\nPatient1\n60\nFemme\nNon\naucun de ces options\nNon'),
(37, 'items', 1, 1, NULL, '10/10/2024 10:12:37\nHomme\n24\nNon\nles deux\nNon\na.hef2000@gmail.Com'),
(38, 'items', 1, 1, NULL, '10/10/2024 10:13:00\nHomme\n24\nNon\nle régime\nNon\nanas.hefied7@gmail.com'),
(39, 'items', 1, 1, NULL, '12/10/2024 15:39:55\nHomme\n28\nNon\nle sport\nOui\nmassidireddy@gmail.com'),
(40, 'items', 1, 1, NULL, '13/10/2024 02:00:54\nHomme\n25\nOui\nles deux\nOui\nouksili.samy@yahoo.com'),
(41, 'items', 1, 1, NULL, '13/10/2024 15:43:10\nHomme\n22\nNon\nles deux\nNon\nAmjahidmohamedamin@gmail.com'),
(42, 'items', 1, 1, NULL, '13/10/2024 16:18:09\nHomme\n24\nNon\nle sport\nNon\nahmed45jab@gmail.com'),
(43, 'items', 1, 1, NULL, '13/10/2024 16:21:05\nHomme\n26\nNon\nle sport\nNon\nmokraniislam998@gmail.com'),
(44, 'items', 1, 1, NULL, '13/10/2024 20:44:09\nFemme\n28\nNon\nle régime\nNon\nmelissaorb02@gmail.com'),
(45, 'items', 1, 1, NULL, '13/10/2024 21:01:48\nHomme\n24\nNon\nle sport\nNon\nnathan.benais@gmail.com'),
(46, 'items', 1, 1, NULL, '13/10/2024 22:32:03\nFemme\n23\nNon\nle sport\nNon\nmoussaoui.rania755@gmail.com'),
(47, 'items', 1, 1, NULL, '14/10/2024 08:17:06\nHomme\n24\nNon\nles deux\nNon\nnoureddineaitkhouya@gmail.com'),
(48, 'items', 1, 1, NULL, '14/10/2024 08:37:56\nFemme\n23\nNon\nles deux\nNon\noumaimaelfazazi01@gmail.com'),
(49, 'items', 1, 1, NULL, '14/10/2024 09:23:18\nFemme\n23\nNon\nle sport\nNon\nyasmine.guemat97@gmail.com'),
(50, 'item_sets', 1, 1, 'Rdv', 'Rdv\n30/10/2024\n0666666666\n1\n100039935076726'),
(51, 'item_sets', 1, 1, 'Admin', 'Admin\nAnas\na.hef2000@gmail.com\n0612345678\nAdmin'),
(52, 'item_sets', 1, 1, 'Patient', 'Patient\n15/11/2024\nHomme\n24\nnon\nNon\naucun de ces options\na.hef1960@gmail.com\n18/11/2024\nAli\n0666666666\nPatient\n100039935076726\nA123'),
(53, 'item_sets', 1, 1, 'Médecin', 'Médecin\nHasan Tazi\nhasan.tazi@gmail.com\nORL\n0612345678\nCabinet chez hasan tazi'),
(54, 'item_sets', 1, 1, 'User', 'User\nhasan.tazi@gmail.com\nHasan tazi\nA12345\nMédecin\nORL\n0612345678\nCabinet chez Dr hasan tazi'),
(55, 'item_sets', 1, 1, 'cabinet', 'cabinet\nCabinet chez Dr Hasan tazi\nA19 street 5\nORL'),
(56, 'items', 1, 1, 'User2', 'User2\na.hef147@gmail.com\nUser\nAli2\nUser\nAli123456\nPatient'),
(57, 'items', 1, 1, 'User3', 'User3\nMédecin\ndriss-raiss@gmail.com\nMédecin\ndriss raiss\nMédecin\ndriss123\nMédecin\nUser'),
(58, 'items', 1, 1, NULL, '10/10/2024 10:12:37\nHomme\n24\nNon\nles deux\nNon\na.hef2000@gmail.Com'),
(59, 'items', 1, 1, 'user25', 'user25\nHomme\n24\nNon\nNon\nle régime\nanas.hefied7@gmail.com\n10/10/2024 10:13:00'),
(60, 'items', 1, 1, 'user24', 'user24\nHomme\n28\nNon\nOui\nle sport\nmassidireddy@gmail.com\n12/10/2024 15:39:55'),
(61, 'items', 1, 1, 'user23', 'user23\nHomme\n25\nOui\nOui\nles deux\nouksili.samy@yahoo.com\n13/10/2024 02:00:54'),
(62, 'items', 1, 1, 'user22', 'user22\nHomme\n22\nNon\nNon\nles deux\nAmjahidmohamedamin@gmail.com\n13/10/2024 15:43:10'),
(63, 'items', 1, 1, 'user21', 'user21\nHomme\n24\nNon\nNon\nle sport\nahmed45jab@gmail.com\n13/10/2024 16:18:09'),
(64, 'items', 1, 1, 'user20', 'user20\nHomme\n26\nNon\nNon\nle sport\nmokraniislam998@gmail.com\n13/10/2024 16:21:05'),
(65, 'items', 1, 1, 'user19', 'user19\nFemme\n28\nNon\nNon\nle régime\nmelissaorb02@gmail.com\n13/10/2024 20:44:09'),
(66, 'items', 1, 1, 'user18', 'user18\nHomme\n24\nNon\nNon\nle sport\nnathan.benais@gmail.com\n13/10/2024 21:01:48'),
(67, 'items', 1, 1, 'user17', 'user17\nFemme\n23\nNon\nNon\nle sport\nmoussaoui.rania755@gmail.com\n13/10/2024 22:32:03'),
(68, 'items', 1, 1, 'user16', 'user16\nHomme\n24\nNon\nNon\nles deux\nnoureddineaitkhouya@gmail.com\n14/10/2024 08:17:06'),
(69, 'items', 1, 1, 'user15', 'user15\nFemme\n23\nNon\nNon\nles deux\noumaimaelfazazi01@gmail.com\n14/10/2024 08:37:56'),
(70, 'items', 1, 1, 'user14', 'user14\nFemme\n23\nNon\nNon\nle sport\nyasmine.guemat97@gmail.com\n14/10/2024 09:23:18'),
(71, 'items', 1, 1, 'user13', 'user13\na.hef2000@gmail.Com\n10/10/2024 10:12:37\nHomme\n24\nNon\nles deux\nNon'),
(72, 'items', 1, 1, 'user12', 'user12\nanas.hefied7@gmail.com\n10/10/2024 10:13:00\nHomme\n24\nNon\nle régime\nNon'),
(73, 'items', 1, 1, 'user11', 'user11\nmassidireddy@gmail.com\n12/10/2024 15:39:55\nHomme\n28\nNon\nle sport\nOui'),
(74, 'items', 1, 1, 'user10', 'user10\nouksili.samy@yahoo.com\n13/10/2024 02:00:54\nHomme\n25\nOui\nles deux\nOui'),
(75, 'items', 1, 1, 'user9', 'user9\nAmjahidmohamedamin@gmail.com\n13/10/2024 15:43:10\nHomme\n22\nNon\nles deux\nNon'),
(76, 'items', 1, 1, 'user8', 'user8\nahmed45jab@gmail.com\n13/10/2024 16:18:09\nHomme\n24\nNon\nle sport\nNon'),
(77, 'items', 1, 1, 'user7', 'user7\nmokraniislam998@gmail.com\n13/10/2024 16:21:05\nHomme\n26\nNon\nle sport\nNon'),
(78, 'items', 1, 1, 'user6', 'user6\nmelissaorb02@gmail.com\n13/10/2024 20:44:09\nFemme\n28\nNon\nle régime\nNon'),
(79, 'items', 1, 1, 'user5', 'user5\nnathan.benais@gmail.com\n13/10/2024 21:01:48\nHomme\n24\nNon\nle sport\nNon'),
(80, 'items', 1, 1, 'user4', 'user4\nmoussaoui.rania755@gmail.com\n13/10/2024 22:32:03\nFemme\n23\nNon\nle sport\nNon'),
(81, 'items', 1, 1, 'user3', 'user3\nnoureddineaitkhouya@gmail.com\n14/10/2024 08:17:06\nHomme\n24\nNon\nles deux\nNon'),
(82, 'items', 1, 1, 'user2', 'user2\noumaimaelfazazi01@gmail.com\n14/10/2024 08:37:56\nFemme\n23\nNon\nles deux\nNon'),
(83, 'items', 1, 1, 'user1', 'user1\nyasmine.guemat97@gmail.com\n14/10/2024 09:23:18\nFemme\n23\nNon\nle sport\nNon');

-- --------------------------------------------------------

--
-- Structure de la table `item`
--

CREATE TABLE `item` (
  `id` int NOT NULL,
  `primary_media_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `item`
--

INSERT INTO `item` (`id`, `primary_media_id`) VALUES
(1, NULL),
(2, NULL),
(3, NULL),
(4, NULL),
(5, NULL),
(6, NULL),
(7, NULL),
(8, NULL),
(9, NULL),
(10, NULL),
(11, NULL),
(12, NULL),
(13, NULL),
(14, NULL),
(15, NULL),
(16, NULL),
(17, NULL),
(18, NULL),
(19, NULL),
(20, NULL),
(21, NULL),
(22, NULL),
(23, NULL),
(24, NULL),
(25, NULL),
(26, NULL),
(27, NULL),
(28, NULL),
(29, NULL),
(30, NULL),
(35, NULL),
(36, NULL),
(37, NULL),
(38, NULL),
(39, NULL),
(40, NULL),
(41, NULL),
(42, NULL),
(43, NULL),
(44, NULL),
(45, NULL),
(46, NULL),
(47, NULL),
(48, NULL),
(49, NULL),
(56, NULL),
(57, NULL),
(58, NULL),
(59, NULL),
(60, NULL),
(61, NULL),
(62, NULL),
(63, NULL),
(64, NULL),
(65, NULL),
(66, NULL),
(67, NULL),
(68, NULL),
(69, NULL),
(70, NULL),
(71, NULL),
(72, NULL),
(73, NULL),
(74, NULL),
(75, NULL),
(76, NULL),
(77, NULL),
(78, NULL),
(79, NULL),
(80, NULL),
(81, NULL),
(82, NULL),
(83, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `item_item_set`
--

CREATE TABLE `item_item_set` (
  `item_id` int NOT NULL,
  `item_set_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `item_item_set`
--

INSERT INTO `item_item_set` (`item_id`, `item_set_id`) VALUES
(58, 52),
(59, 52),
(60, 52),
(61, 52),
(62, 52),
(63, 52),
(64, 52),
(65, 52),
(66, 52),
(67, 52),
(68, 52),
(69, 52),
(70, 52),
(71, 54),
(72, 54),
(73, 54),
(74, 54),
(75, 54),
(76, 54),
(77, 54),
(78, 54),
(79, 54),
(80, 54),
(81, 54),
(82, 54),
(83, 54);

-- --------------------------------------------------------

--
-- Structure de la table `item_set`
--

CREATE TABLE `item_set` (
  `id` int NOT NULL,
  `is_open` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `item_set`
--

INSERT INTO `item_set` (`id`, `is_open`) VALUES
(50, 0),
(51, 0),
(52, 0),
(53, 0),
(54, 0),
(55, 0);

-- --------------------------------------------------------

--
-- Structure de la table `item_site`
--

CREATE TABLE `item_site` (
  `item_id` int NOT NULL,
  `site_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `job`
--

CREATE TABLE `job` (
  `id` int NOT NULL,
  `owner_id` int DEFAULT NULL,
  `pid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `class` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `args` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json_array)',
  `log` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `started` datetime NOT NULL,
  `ended` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `job`
--

INSERT INTO `job` (`id`, `owner_id`, `pid`, `status`, `class`, `args`, `log`, `started`, `ended`) VALUES
(3, 1, '5008', 'completed', 'CSVImport\\Job\\Import', '{\"filename\":\"Questionnaires_Patient.csv\",\"filesize\":\"1089\",\"filepath\":\"\\/tmp\\/omekaF1JfON\",\"media_type\":\"text\\/csv\",\"resource_type\":\"items\",\"comment\":\"\",\"automap_check_names_alone\":false,\"column-property\":{\"0\":{\"dcterms:date\":7},\"1\":{\"foaf:gender\":125},\"2\":{\"foaf:age\":183},\"6\":{\"foaf:mbox\":123}},\"generic-data\":\"default\",\"media-source\":\"default\",\"resource-identifier-property\":\"\",\"o:resource_template\":{\"o:id\":2},\"o:resource_class\":{\"o:id\":94},\"o:owner\":{\"o:id\":1},\"o:is_public\":1,\"multivalue_separator\":\",\",\"global_language\":\"\",\"action\":\"create\",\"identifier_column\":0,\"identifier_property\":\"\",\"action_unidentified\":\"skip\",\"rows_by_batch\":20,\"column-multivalue\":[],\"delimiter\":\",\",\"enclosure\":\"\\\"\",\"escape\":\"\\\\\"}', NULL, '2024-10-26 08:55:25', '2024-10-26 08:55:25'),
(4, 1, '9413', 'completed', 'CSVImport\\Job\\Import', '{\"filename\":\"Questionnaires_Patient.csv\",\"filesize\":\"1089\",\"filepath\":\"\\/tmp\\/omekabbtsO1\",\"media_type\":\"text\\/csv\",\"resource_type\":\"items\",\"comment\":\"\",\"automap_check_names_alone\":false,\"column-property\":[{\"etudiant_thyp:timeSubmit\":185},{\"etudiant_thyp:sexe\":186},{\"etudiant_thyp:age\":187},{\"etudiant_thyp:fume\":188},{\"etudiant_thyp:sport\":189},{\"etudiant_thyp:alcool\":190},{\"etudiant_thyp:mail\":191}],\"generic-data\":\"default\",\"media-source\":\"default\",\"resource-identifier-property\":\"\",\"o:resource_template\":{\"o:id\":2},\"o:resource_class\":{\"o:id\":94},\"o:owner\":{\"o:id\":1},\"o:is_public\":1,\"multivalue_separator\":\",\",\"global_language\":\"\",\"action\":\"create\",\"identifier_column\":0,\"identifier_property\":\"\",\"action_unidentified\":\"skip\",\"rows_by_batch\":20,\"column-multivalue\":[],\"delimiter\":\",\",\"enclosure\":\"\\\"\",\"escape\":\"\\\\\"}', NULL, '2024-10-27 10:24:09', '2024-10-27 10:24:09'),
(5, 1, '1875', 'completed', 'CSVImport\\Job\\Import', '{\"filename\":\"Questionnaires_Patient.csv\",\"filesize\":\"1089\",\"filepath\":\"\\/tmp\\/omekabf7fpm\",\"media_type\":\"text\\/csv\",\"resource_type\":\"items\",\"comment\":\"\",\"automap_check_names_alone\":false,\"column-property\":[{\"cabinet_Management:timeSubmit\":247},{\"cabinet_Management:sexe\":248},{\"cabinet_Management:age\":249},{\"cabinet_Management:fume\":250},{\"cabinet_Management:sport\":251},{\"cabinet_Management:alcool\":252},{\"cabinet_Management:mail\":253}],\"generic-data\":\"default\",\"media-source\":\"default\",\"resource-identifier-property\":\"\",\"o:resource_template\":{\"o:id\":4},\"o:resource_class\":{\"o:id\":126},\"o:owner\":{\"o:id\":1},\"o:is_public\":1,\"o:item_set\":[\"52\"],\"multivalue_separator\":\",\",\"global_language\":\"\",\"action\":\"create\",\"identifier_column\":0,\"identifier_property\":\"\",\"action_unidentified\":\"skip\",\"rows_by_batch\":20,\"column-multivalue\":[],\"delimiter\":\",\",\"enclosure\":\"\\\"\",\"escape\":\"\\\\\"}', NULL, '2024-10-27 19:35:00', '2024-10-27 19:35:01'),
(6, 1, '1921', 'completed', 'CSVImport\\Job\\Import', '{\"filename\":\"Questionnaires_Patient.csv\",\"filesize\":\"1089\",\"filepath\":\"\\/tmp\\/omekahK8QDf\",\"media_type\":\"text\\/csv\",\"resource_type\":\"items\",\"comment\":\"\",\"automap_check_names_alone\":false,\"column-property\":[{\"cabinet_Management:timeSubmit\":247},{\"cabinet_Management:sexe\":248},{\"cabinet_Management:age\":249},{\"cabinet_Management:fume\":250},{\"cabinet_Management:sport\":251},{\"cabinet_Management:alcool\":252},{\"cabinet_Management:mail\":253}],\"generic-data\":\"default\",\"media-source\":\"default\",\"resource-identifier-property\":\"\",\"o:resource_template\":{\"o:id\":6},\"o:resource_class\":{\"o:id\":126},\"o:owner\":{\"o:id\":1},\"o:is_public\":1,\"o:item_set\":[\"54\"],\"multivalue_separator\":\",\",\"global_language\":\"\",\"action\":\"create\",\"identifier_column\":0,\"identifier_property\":\"\",\"action_unidentified\":\"skip\",\"rows_by_batch\":20,\"column-multivalue\":[],\"delimiter\":\",\",\"enclosure\":\"\\\"\",\"escape\":\"\\\\\"}', NULL, '2024-10-27 19:36:56', '2024-10-27 19:36:56');

-- --------------------------------------------------------

--
-- Structure de la table `media`
--

CREATE TABLE `media` (
  `id` int NOT NULL,
  `item_id` int NOT NULL,
  `ingester` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `renderer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json_array)',
  `source` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `media_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `storage_id` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `extension` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sha256` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` bigint DEFAULT NULL,
  `has_original` tinyint(1) NOT NULL,
  `has_thumbnails` tinyint(1) NOT NULL,
  `position` int DEFAULT NULL,
  `lang` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alt_text` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `migration`
--

CREATE TABLE `migration` (
  `version` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `migration`
--

INSERT INTO `migration` (`version`) VALUES
('20171128053327'),
('20180412035023'),
('20180919072656'),
('20180924033501'),
('20181002015551'),
('20181004043735'),
('20181106060421'),
('20190307043537'),
('20190319020708'),
('20190412090532'),
('20190423040354'),
('20190423071228'),
('20190514061351'),
('20190515055359'),
('20190729023728'),
('20190809092609'),
('20190815062003'),
('20200224022356'),
('20200226064602'),
('20200325091157'),
('20200326091310'),
('20200803000000'),
('20200831000000'),
('20210205101827'),
('20210225095734'),
('20210810083804'),
('20220718090449'),
('20220824103916'),
('20230124033031'),
('20230410074846'),
('20230523085358'),
('20230601060113'),
('20230713101012'),
('20231016000000'),
('20240103030617');

-- --------------------------------------------------------

--
-- Structure de la table `module`
--

CREATE TABLE `module` (
  `id` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `module`
--

INSERT INTO `module` (`id`, `is_active`, `version`) VALUES
('CSVImport', 1, '2.6.1');

-- --------------------------------------------------------

--
-- Structure de la table `password_creation`
--

CREATE TABLE `password_creation` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `user_id` int NOT NULL,
  `created` datetime NOT NULL,
  `activate` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `property`
--

CREATE TABLE `property` (
  `id` int NOT NULL,
  `owner_id` int DEFAULT NULL,
  `vocabulary_id` int NOT NULL,
  `local_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `property`
--

INSERT INTO `property` (`id`, `owner_id`, `vocabulary_id`, `local_name`, `label`, `comment`) VALUES
(1, NULL, 1, 'title', 'Title', 'A name given to the resource.'),
(2, NULL, 1, 'creator', 'Creator', 'An entity primarily responsible for making the resource.'),
(3, NULL, 1, 'subject', 'Subject', 'The topic of the resource.'),
(4, NULL, 1, 'description', 'Description', 'An account of the resource.'),
(5, NULL, 1, 'publisher', 'Publisher', 'An entity responsible for making the resource available.'),
(6, NULL, 1, 'contributor', 'Contributor', 'An entity responsible for making contributions to the resource.'),
(7, NULL, 1, 'date', 'Date', 'A point or period of time associated with an event in the lifecycle of the resource.'),
(8, NULL, 1, 'type', 'Type', 'The nature or genre of the resource.'),
(9, NULL, 1, 'format', 'Format', 'The file format, physical medium, or dimensions of the resource.'),
(10, NULL, 1, 'identifier', 'Identifier', 'An unambiguous reference to the resource within a given context.'),
(11, NULL, 1, 'source', 'Source', 'A related resource from which the described resource is derived.'),
(12, NULL, 1, 'language', 'Language', 'A language of the resource.'),
(13, NULL, 1, 'relation', 'Relation', 'A related resource.'),
(14, NULL, 1, 'coverage', 'Coverage', 'The spatial or temporal topic of the resource, the spatial applicability of the resource, or the jurisdiction under which the resource is relevant.'),
(15, NULL, 1, 'rights', 'Rights', 'Information about rights held in and over the resource.'),
(16, NULL, 1, 'audience', 'Audience', 'A class of entity for whom the resource is intended or useful.'),
(17, NULL, 1, 'alternative', 'Alternative Title', 'An alternative name for the resource.'),
(18, NULL, 1, 'tableOfContents', 'Table Of Contents', 'A list of subunits of the resource.'),
(19, NULL, 1, 'abstract', 'Abstract', 'A summary of the resource.'),
(20, NULL, 1, 'created', 'Date Created', 'Date of creation of the resource.'),
(21, NULL, 1, 'valid', 'Date Valid', 'Date (often a range) of validity of a resource.'),
(22, NULL, 1, 'available', 'Date Available', 'Date (often a range) that the resource became or will become available.'),
(23, NULL, 1, 'issued', 'Date Issued', 'Date of formal issuance (e.g., publication) of the resource.'),
(24, NULL, 1, 'modified', 'Date Modified', 'Date on which the resource was changed.'),
(25, NULL, 1, 'extent', 'Extent', 'The size or duration of the resource.'),
(26, NULL, 1, 'medium', 'Medium', 'The material or physical carrier of the resource.'),
(27, NULL, 1, 'isVersionOf', 'Is Version Of', 'A related resource of which the described resource is a version, edition, or adaptation.'),
(28, NULL, 1, 'hasVersion', 'Has Version', 'A related resource that is a version, edition, or adaptation of the described resource.'),
(29, NULL, 1, 'isReplacedBy', 'Is Replaced By', 'A related resource that supplants, displaces, or supersedes the described resource.'),
(30, NULL, 1, 'replaces', 'Replaces', 'A related resource that is supplanted, displaced, or superseded by the described resource.'),
(31, NULL, 1, 'isRequiredBy', 'Is Required By', 'A related resource that requires the described resource to support its function, delivery, or coherence.'),
(32, NULL, 1, 'requires', 'Requires', 'A related resource that is required by the described resource to support its function, delivery, or coherence.'),
(33, NULL, 1, 'isPartOf', 'Is Part Of', 'A related resource in which the described resource is physically or logically included.'),
(34, NULL, 1, 'hasPart', 'Has Part', 'A related resource that is included either physically or logically in the described resource.'),
(35, NULL, 1, 'isReferencedBy', 'Is Referenced By', 'A related resource that references, cites, or otherwise points to the described resource.'),
(36, NULL, 1, 'references', 'References', 'A related resource that is referenced, cited, or otherwise pointed to by the described resource.'),
(37, NULL, 1, 'isFormatOf', 'Is Format Of', 'A related resource that is substantially the same as the described resource, but in another format.'),
(38, NULL, 1, 'hasFormat', 'Has Format', 'A related resource that is substantially the same as the pre-existing described resource, but in another format.'),
(39, NULL, 1, 'conformsTo', 'Conforms To', 'An established standard to which the described resource conforms.'),
(40, NULL, 1, 'spatial', 'Spatial Coverage', 'Spatial characteristics of the resource.'),
(41, NULL, 1, 'temporal', 'Temporal Coverage', 'Temporal characteristics of the resource.'),
(42, NULL, 1, 'mediator', 'Mediator', 'An entity that mediates access to the resource and for whom the resource is intended or useful.'),
(43, NULL, 1, 'dateAccepted', 'Date Accepted', 'Date of acceptance of the resource.'),
(44, NULL, 1, 'dateCopyrighted', 'Date Copyrighted', 'Date of copyright.'),
(45, NULL, 1, 'dateSubmitted', 'Date Submitted', 'Date of submission of the resource.'),
(46, NULL, 1, 'educationLevel', 'Audience Education Level', 'A class of entity, defined in terms of progression through an educational or training context, for which the described resource is intended.'),
(47, NULL, 1, 'accessRights', 'Access Rights', 'Information about who can access the resource or an indication of its security status.'),
(48, NULL, 1, 'bibliographicCitation', 'Bibliographic Citation', 'A bibliographic reference for the resource.'),
(49, NULL, 1, 'license', 'License', 'A legal document giving official permission to do something with the resource.'),
(50, NULL, 1, 'rightsHolder', 'Rights Holder', 'A person or organization owning or managing rights over the resource.'),
(51, NULL, 1, 'provenance', 'Provenance', 'A statement of any changes in ownership and custody of the resource since its creation that are significant for its authenticity, integrity, and interpretation.'),
(52, NULL, 1, 'instructionalMethod', 'Instructional Method', 'A process, used to engender knowledge, attitudes and skills, that the described resource is designed to support.'),
(53, NULL, 1, 'accrualMethod', 'Accrual Method', 'The method by which items are added to a collection.'),
(54, NULL, 1, 'accrualPeriodicity', 'Accrual Periodicity', 'The frequency with which items are added to a collection.'),
(55, NULL, 1, 'accrualPolicy', 'Accrual Policy', 'The policy governing the addition of items to a collection.'),
(56, NULL, 3, 'affirmedBy', 'affirmedBy', 'A legal decision that affirms a ruling.'),
(57, NULL, 3, 'annotates', 'annotates', 'Critical or explanatory note for a Document.'),
(58, NULL, 3, 'authorList', 'list of authors', 'An ordered list of authors. Normally, this list is seen as a priority list that order authors by importance.'),
(59, NULL, 3, 'citedBy', 'cited by', 'Relates a document to another document that cites the\nfirst document.'),
(60, NULL, 3, 'cites', 'cites', 'Relates a document to another document that is cited\nby the first document as reference, comment, review, quotation or for\nanother purpose.'),
(61, NULL, 3, 'contributorList', 'list of contributors', 'An ordered list of contributors. Normally, this list is seen as a priority list that order contributors by importance.'),
(62, NULL, 3, 'court', 'court', 'A court associated with a legal document; for example, that which issues a decision.'),
(63, NULL, 3, 'degree', 'degree', 'The thesis degree.'),
(64, NULL, 3, 'director', 'director', 'A Film director.'),
(65, NULL, 3, 'distributor', 'distributor', 'Distributor of a document or a collection of documents.'),
(66, NULL, 3, 'editor', 'editor', 'A person having managerial and sometimes policy-making responsibility for the editorial part of a publishing firm or of a newspaper, magazine, or other publication.'),
(67, NULL, 3, 'editorList', 'list of editors', 'An ordered list of editors. Normally, this list is seen as a priority list that order editors by importance.'),
(68, NULL, 3, 'interviewee', 'interviewee', 'An agent that is interviewed by another agent.'),
(69, NULL, 3, 'interviewer', 'interviewer', 'An agent that interview another agent.'),
(70, NULL, 3, 'issuer', 'issuer', 'An entity responsible for issuing often informally published documents such as press releases, reports, etc.'),
(71, NULL, 3, 'organizer', 'organizer', 'The organizer of an event; includes conference organizers, but also government agencies or other bodies that are responsible for conducting hearings.'),
(72, NULL, 3, 'owner', 'owner', 'Owner of a document or a collection of documents.'),
(73, NULL, 3, 'performer', 'performer', NULL),
(74, NULL, 3, 'presentedAt', 'presented at', 'Relates a document to an event; for example, a paper to a conference.'),
(75, NULL, 3, 'presents', 'presents', 'Relates an event to associated documents; for example, conference to a paper.'),
(76, NULL, 3, 'producer', 'producer', 'Producer of a document or a collection of documents.'),
(77, NULL, 3, 'recipient', 'recipient', 'An agent that receives a communication document.'),
(78, NULL, 3, 'reproducedIn', 'reproducedIn', 'The resource in which another resource is reproduced.'),
(79, NULL, 3, 'reversedBy', 'reversedBy', 'A legal decision that reverses a ruling.'),
(80, NULL, 3, 'reviewOf', 'review of', 'Relates a review document to a reviewed thing (resource, item, etc.).'),
(81, NULL, 3, 'status', 'status', 'The publication status of (typically academic) content.'),
(82, NULL, 3, 'subsequentLegalDecision', 'subsequentLegalDecision', 'A legal decision on appeal that takes action on a case (affirming it, reversing it, etc.).'),
(83, NULL, 3, 'transcriptOf', 'transcript of', 'Relates a document to some transcribed original.'),
(84, NULL, 3, 'translationOf', 'translation of', 'Relates a translated document to the original document.'),
(85, NULL, 3, 'translator', 'translator', 'A person who translates written document from one language to another.'),
(86, NULL, 3, 'abstract', 'abstract', 'A summary of the resource.'),
(87, NULL, 3, 'argued', 'date argued', 'The date on which a legal case is argued before a court. Date is of format xsd:date'),
(88, NULL, 3, 'asin', 'asin', NULL),
(89, NULL, 3, 'chapter', 'chapter', 'An chapter number'),
(90, NULL, 3, 'coden', 'coden', NULL),
(91, NULL, 3, 'content', 'content', 'This property is for a plain-text rendering of the content of a Document. While the plain-text content of an entire document could be described by this property.'),
(92, NULL, 3, 'doi', 'doi', NULL),
(93, NULL, 3, 'eanucc13', 'eanucc13', NULL),
(94, NULL, 3, 'edition', 'edition', 'The name defining a special edition of a document. Normally its a literal value composed of a version number and words.'),
(95, NULL, 3, 'eissn', 'eissn', NULL),
(96, NULL, 3, 'gtin14', 'gtin14', NULL),
(97, NULL, 3, 'handle', 'handle', NULL),
(98, NULL, 3, 'identifier', 'identifier', NULL),
(99, NULL, 3, 'isbn', 'isbn', NULL),
(100, NULL, 3, 'isbn10', 'isbn10', NULL),
(101, NULL, 3, 'isbn13', 'isbn13', NULL),
(102, NULL, 3, 'issn', 'issn', NULL),
(103, NULL, 3, 'issue', 'issue', 'An issue number'),
(104, NULL, 3, 'lccn', 'lccn', NULL),
(105, NULL, 3, 'locator', 'locator', 'A description (often numeric) that locates an item within a containing document or collection.'),
(106, NULL, 3, 'numPages', 'number of pages', 'The number of pages contained in a document'),
(107, NULL, 3, 'numVolumes', 'number of volumes', 'The number of volumes contained in a collection of documents (usually a series, periodical, etc.).'),
(108, NULL, 3, 'number', 'number', 'A generic item or document number. Not to be confused with issue number.'),
(109, NULL, 3, 'oclcnum', 'oclcnum', NULL),
(110, NULL, 3, 'pageEnd', 'page end', 'Ending page number within a continuous page range.'),
(111, NULL, 3, 'pageStart', 'page start', 'Starting page number within a continuous page range.'),
(112, NULL, 3, 'pages', 'pages', 'A string of non-contiguous page spans that locate a Document within a Collection. Example: 23-25, 34, 54-56. For continuous page ranges, use the pageStart and pageEnd properties.'),
(113, NULL, 3, 'pmid', 'pmid', NULL),
(114, NULL, 3, 'prefixName', 'prefix name', 'The prefix of a name'),
(115, NULL, 3, 'section', 'section', 'A section number'),
(116, NULL, 3, 'shortDescription', 'shortDescription', NULL),
(117, NULL, 3, 'shortTitle', 'short title', 'The abbreviation of a title.'),
(118, NULL, 3, 'sici', 'sici', NULL),
(119, NULL, 3, 'suffixName', 'suffix name', 'The suffix of a name'),
(120, NULL, 3, 'upc', 'upc', NULL),
(121, NULL, 3, 'uri', 'uri', 'Universal Resource Identifier of a document'),
(122, NULL, 3, 'volume', 'volume', 'A volume number'),
(123, NULL, 4, 'mbox', 'personal mailbox', 'A  personal mailbox, ie. an Internet mailbox associated with exactly one owner, the first owner of this mailbox. This is a \'static inverse functional property\', in that  there is (across time and change) at most one individual that ever has any particular value for foaf:mbox.'),
(124, NULL, 4, 'mbox_sha1sum', 'sha1sum of a personal mailbox URI name', 'The sha1sum of the URI of an Internet mailbox associated with exactly one owner, the  first owner of the mailbox.'),
(125, NULL, 4, 'gender', 'gender', 'The gender of this Agent (typically but not necessarily \'male\' or \'female\').'),
(126, NULL, 4, 'geekcode', 'geekcode', 'A textual geekcode for this person, see http://www.geekcode.com/geek.html'),
(127, NULL, 4, 'dnaChecksum', 'DNA checksum', 'A checksum for the DNA of some thing. Joke.'),
(128, NULL, 4, 'sha1', 'sha1sum (hex)', 'A sha1sum hash, in hex.'),
(129, NULL, 4, 'based_near', 'based near', 'A location that something is based near, for some broadly human notion of near.'),
(130, NULL, 4, 'title', 'title', 'Title (Mr, Mrs, Ms, Dr. etc)'),
(131, NULL, 4, 'nick', 'nickname', 'A short informal nickname characterising an agent (includes login identifiers, IRC and other chat nicknames).'),
(132, NULL, 4, 'jabberID', 'jabber ID', 'A jabber ID for something.'),
(133, NULL, 4, 'aimChatID', 'AIM chat ID', 'An AIM chat ID'),
(134, NULL, 4, 'skypeID', 'Skype ID', 'A Skype ID'),
(135, NULL, 4, 'icqChatID', 'ICQ chat ID', 'An ICQ chat ID'),
(136, NULL, 4, 'yahooChatID', 'Yahoo chat ID', 'A Yahoo chat ID'),
(137, NULL, 4, 'msnChatID', 'MSN chat ID', 'An MSN chat ID'),
(138, NULL, 4, 'name', 'name', 'A name for some thing.'),
(139, NULL, 4, 'firstName', 'firstName', 'The first name of a person.'),
(140, NULL, 4, 'lastName', 'lastName', 'The last name of a person.'),
(141, NULL, 4, 'givenName', 'Given name', 'The given name of some person.'),
(142, NULL, 4, 'givenname', 'Given name', 'The given name of some person.'),
(143, NULL, 4, 'surname', 'Surname', 'The surname of some person.'),
(144, NULL, 4, 'family_name', 'family_name', 'The family name of some person.'),
(145, NULL, 4, 'familyName', 'familyName', 'The family name of some person.'),
(146, NULL, 4, 'phone', 'phone', 'A phone,  specified using fully qualified tel: URI scheme (refs: http://www.w3.org/Addressing/schemes.html#tel).'),
(147, NULL, 4, 'homepage', 'homepage', 'A homepage for some thing.'),
(148, NULL, 4, 'weblog', 'weblog', 'A weblog of some thing (whether person, group, company etc.).'),
(149, NULL, 4, 'openid', 'openid', 'An OpenID for an Agent.'),
(150, NULL, 4, 'tipjar', 'tipjar', 'A tipjar document for this agent, describing means for payment and reward.'),
(151, NULL, 4, 'plan', 'plan', 'A .plan comment, in the tradition of finger and \'.plan\' files.'),
(152, NULL, 4, 'made', 'made', 'Something that was made by this agent.'),
(153, NULL, 4, 'maker', 'maker', 'An agent that  made this thing.'),
(154, NULL, 4, 'img', 'image', 'An image that can be used to represent some thing (ie. those depictions which are particularly representative of something, eg. one\'s photo on a homepage).'),
(155, NULL, 4, 'depiction', 'depiction', 'A depiction of some thing.'),
(156, NULL, 4, 'depicts', 'depicts', 'A thing depicted in this representation.'),
(157, NULL, 4, 'thumbnail', 'thumbnail', 'A derived thumbnail image.'),
(158, NULL, 4, 'myersBriggs', 'myersBriggs', 'A Myers Briggs (MBTI) personality classification.'),
(159, NULL, 4, 'workplaceHomepage', 'workplace homepage', 'A workplace homepage of some person; the homepage of an organization they work for.'),
(160, NULL, 4, 'workInfoHomepage', 'work info homepage', 'A work info homepage of some person; a page about their work for some organization.'),
(161, NULL, 4, 'schoolHomepage', 'schoolHomepage', 'A homepage of a school attended by the person.'),
(162, NULL, 4, 'knows', 'knows', 'A person known by this person (indicating some level of reciprocated interaction between the parties).'),
(163, NULL, 4, 'interest', 'interest', 'A page about a topic of interest to this person.'),
(164, NULL, 4, 'topic_interest', 'topic_interest', 'A thing of interest to this person.'),
(165, NULL, 4, 'publications', 'publications', 'A link to the publications of this person.'),
(166, NULL, 4, 'currentProject', 'current project', 'A current project this person works on.'),
(167, NULL, 4, 'pastProject', 'past project', 'A project this person has previously worked on.'),
(168, NULL, 4, 'fundedBy', 'funded by', 'An organization funding a project or person.'),
(169, NULL, 4, 'logo', 'logo', 'A logo representing some thing.'),
(170, NULL, 4, 'topic', 'topic', 'A topic of some page or document.'),
(171, NULL, 4, 'primaryTopic', 'primary topic', 'The primary topic of some page or document.'),
(172, NULL, 4, 'focus', 'focus', 'The underlying or \'focal\' entity associated with some SKOS-described concept.'),
(173, NULL, 4, 'isPrimaryTopicOf', 'is primary topic of', 'A document that this thing is the primary topic of.'),
(174, NULL, 4, 'page', 'page', 'A page or document about this thing.'),
(175, NULL, 4, 'theme', 'theme', 'A theme.'),
(176, NULL, 4, 'account', 'account', 'Indicates an account held by this agent.'),
(177, NULL, 4, 'holdsAccount', 'account', 'Indicates an account held by this agent.'),
(178, NULL, 4, 'accountServiceHomepage', 'account service homepage', 'Indicates a homepage of the service provide for this online account.'),
(179, NULL, 4, 'accountName', 'account name', 'Indicates the name (identifier) associated with this online account.'),
(180, NULL, 4, 'member', 'member', 'Indicates a member of a Group'),
(181, NULL, 4, 'membershipClass', 'membershipClass', 'Indicates the class of individuals that are a member of a Group'),
(182, NULL, 4, 'birthday', 'birthday', 'The birthday of this Agent, represented in mm-dd string form, eg. \'12-31\'.'),
(183, NULL, 4, 'age', 'age', 'The age in years of some agent.'),
(184, NULL, 4, 'status', 'status', 'A string expressing what the user is happy for the general public (normally) to know about their current activity.'),
(185, 1, 5, 'timeSubmit', 'Time submit', NULL),
(186, 1, 5, 'sexe', 'Sexe', NULL),
(187, 1, 5, 'age', 'Age', NULL),
(188, 1, 5, 'fume', 'Fume', NULL),
(189, 1, 5, 'sport', 'Sport', NULL),
(190, 1, 5, 'alcool', 'Alcool', NULL),
(191, 1, 5, 'mail', 'Email', NULL),
(247, 1, 9, 'timeSubmit', 'Date de soumission', NULL),
(248, 1, 9, 'sexe', 'Sexe', NULL),
(249, 1, 9, 'age', 'Age', NULL),
(250, 1, 9, 'fume', 'Fume', NULL),
(251, 1, 9, 'sport', 'Sport', NULL),
(252, 1, 9, 'alcool', 'Consommation d\'Alcool', NULL),
(253, 1, 9, 'mail', 'Email', NULL),
(254, 1, 9, 'nom', 'Nom du Cabinet', NULL),
(255, 1, 9, 'adresse', 'Adresse', NULL),
(256, 1, 9, 'specialite', 'Spécialité Médicale', NULL),
(257, 1, 9, 'appointmentDate', 'Date du Rendez-vous', NULL),
(258, 1, 9, 'phone', 'Téléphone du Patient', NULL),
(259, 1, 9, 'isValidated', 'Validation du Rendez-vous', NULL),
(260, 1, 9, 'securiteSociale', 'Numéro de Sécurité Sociale', NULL),
(261, 1, 9, 'username', 'Nom d\'Utilisateur', NULL),
(262, 1, 9, 'password', 'Mot de Passe', NULL),
(263, 1, 9, 'role', 'Rôle', NULL),
(264, 1, 9, 'telephone', 'Numéro de Téléphone', NULL),
(265, 1, 9, 'specialisation', 'Spécialisation du Médecin', NULL),
(266, 1, 9, 'cabinetAssocie', 'Cabinet Associé', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `resource`
--

CREATE TABLE `resource` (
  `id` int NOT NULL,
  `owner_id` int DEFAULT NULL,
  `resource_class_id` int DEFAULT NULL,
  `resource_template_id` int DEFAULT NULL,
  `thumbnail_id` int DEFAULT NULL,
  `title` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `is_public` tinyint(1) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  `resource_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `resource`
--

INSERT INTO `resource` (`id`, `owner_id`, `resource_class_id`, `resource_template_id`, `thumbnail_id`, `title`, `is_public`, `created`, `modified`, `resource_type`) VALUES
(1, 1, 94, 1, NULL, NULL, 1, '2024-10-26 08:39:03', '2024-10-26 08:39:03', 'Omeka\\Entity\\Item'),
(2, 1, 94, 1, NULL, NULL, 1, '2024-10-26 08:39:03', '2024-10-26 08:39:03', 'Omeka\\Entity\\Item'),
(3, 1, 94, 1, NULL, NULL, 1, '2024-10-26 08:39:03', '2024-10-26 08:39:03', 'Omeka\\Entity\\Item'),
(4, 1, 94, 1, NULL, NULL, 1, '2024-10-26 08:39:03', '2024-10-26 08:39:03', 'Omeka\\Entity\\Item'),
(5, 1, 94, 1, NULL, NULL, 1, '2024-10-26 08:39:03', '2024-10-26 08:39:03', 'Omeka\\Entity\\Item'),
(6, 1, 94, 1, NULL, NULL, 1, '2024-10-26 08:47:50', '2024-10-26 08:47:50', 'Omeka\\Entity\\Item'),
(7, 1, 94, 1, NULL, NULL, 1, '2024-10-26 08:47:50', '2024-10-26 08:47:50', 'Omeka\\Entity\\Item'),
(8, 1, 94, 1, NULL, NULL, 1, '2024-10-26 08:47:50', '2024-10-26 08:47:50', 'Omeka\\Entity\\Item'),
(9, 1, 94, 1, NULL, NULL, 1, '2024-10-26 08:47:50', '2024-10-26 08:47:50', 'Omeka\\Entity\\Item'),
(10, 1, 94, 1, NULL, NULL, 1, '2024-10-26 08:47:50', '2024-10-26 08:47:50', 'Omeka\\Entity\\Item'),
(11, 1, 94, 1, NULL, NULL, 1, '2024-10-26 08:47:50', '2024-10-26 08:47:50', 'Omeka\\Entity\\Item'),
(12, 1, 94, 1, NULL, NULL, 1, '2024-10-26 08:47:50', '2024-10-26 08:47:50', 'Omeka\\Entity\\Item'),
(13, 1, 94, 1, NULL, NULL, 1, '2024-10-26 08:47:50', '2024-10-26 08:47:50', 'Omeka\\Entity\\Item'),
(14, 1, 94, 1, NULL, NULL, 1, '2024-10-26 08:47:50', '2024-10-26 08:47:50', 'Omeka\\Entity\\Item'),
(15, 1, 94, 1, NULL, NULL, 1, '2024-10-26 08:47:50', '2024-10-26 08:47:50', 'Omeka\\Entity\\Item'),
(16, 1, 94, 1, NULL, NULL, 1, '2024-10-26 08:47:50', '2024-10-26 08:47:50', 'Omeka\\Entity\\Item'),
(17, 1, 94, 1, NULL, NULL, 1, '2024-10-26 08:47:50', '2024-10-26 08:47:50', 'Omeka\\Entity\\Item'),
(18, 1, 94, 1, NULL, NULL, 1, '2024-10-26 08:47:50', '2024-10-26 08:47:50', 'Omeka\\Entity\\Item'),
(19, 1, 94, 2, NULL, NULL, 1, '2024-10-26 08:55:25', '2024-10-26 08:55:25', 'Omeka\\Entity\\Item'),
(20, 1, 94, 2, NULL, NULL, 1, '2024-10-26 08:55:25', '2024-10-26 08:55:25', 'Omeka\\Entity\\Item'),
(21, 1, 94, 2, NULL, NULL, 1, '2024-10-26 08:55:25', '2024-10-26 08:55:25', 'Omeka\\Entity\\Item'),
(22, 1, 94, 2, NULL, NULL, 1, '2024-10-26 08:55:25', '2024-10-26 08:55:25', 'Omeka\\Entity\\Item'),
(23, 1, 94, 2, NULL, NULL, 1, '2024-10-26 08:55:25', '2024-10-26 08:55:25', 'Omeka\\Entity\\Item'),
(24, 1, 94, 2, NULL, NULL, 1, '2024-10-26 08:55:25', '2024-10-26 08:55:25', 'Omeka\\Entity\\Item'),
(25, 1, 94, 2, NULL, NULL, 1, '2024-10-26 08:55:25', '2024-10-26 08:55:25', 'Omeka\\Entity\\Item'),
(26, 1, 94, 2, NULL, NULL, 1, '2024-10-26 08:55:25', '2024-10-26 08:55:25', 'Omeka\\Entity\\Item'),
(27, 1, 94, 2, NULL, NULL, 1, '2024-10-26 08:55:25', '2024-10-26 08:55:25', 'Omeka\\Entity\\Item'),
(28, 1, 94, 2, NULL, NULL, 1, '2024-10-26 08:55:25', '2024-10-26 08:55:25', 'Omeka\\Entity\\Item'),
(29, 1, 94, 2, NULL, NULL, 1, '2024-10-26 08:55:25', '2024-10-26 08:55:25', 'Omeka\\Entity\\Item'),
(30, 1, 94, 2, NULL, NULL, 1, '2024-10-26 08:55:25', '2024-10-26 08:55:25', 'Omeka\\Entity\\Item'),
(35, 1, 94, 2, NULL, 'Patient4', 1, '2024-10-27 10:14:27', '2024-10-27 10:14:27', 'Omeka\\Entity\\Item'),
(36, 1, 94, 2, NULL, 'Patient5', 1, '2024-10-27 10:17:49', '2024-10-27 10:18:25', 'Omeka\\Entity\\Item'),
(37, 1, 94, 2, NULL, NULL, 1, '2024-10-27 10:24:09', '2024-10-27 10:24:09', 'Omeka\\Entity\\Item'),
(38, 1, 94, 2, NULL, NULL, 1, '2024-10-27 10:24:09', '2024-10-27 10:24:09', 'Omeka\\Entity\\Item'),
(39, 1, 94, 2, NULL, NULL, 1, '2024-10-27 10:24:09', '2024-10-27 10:24:09', 'Omeka\\Entity\\Item'),
(40, 1, 94, 2, NULL, NULL, 1, '2024-10-27 10:24:09', '2024-10-27 10:24:09', 'Omeka\\Entity\\Item'),
(41, 1, 94, 2, NULL, NULL, 1, '2024-10-27 10:24:09', '2024-10-27 10:24:09', 'Omeka\\Entity\\Item'),
(42, 1, 94, 2, NULL, NULL, 1, '2024-10-27 10:24:09', '2024-10-27 10:24:09', 'Omeka\\Entity\\Item'),
(43, 1, 94, 2, NULL, NULL, 1, '2024-10-27 10:24:09', '2024-10-27 10:24:09', 'Omeka\\Entity\\Item'),
(44, 1, 94, 2, NULL, NULL, 1, '2024-10-27 10:24:09', '2024-10-27 10:24:09', 'Omeka\\Entity\\Item'),
(45, 1, 94, 2, NULL, NULL, 1, '2024-10-27 10:24:09', '2024-10-27 10:24:09', 'Omeka\\Entity\\Item'),
(46, 1, 94, 2, NULL, NULL, 1, '2024-10-27 10:24:09', '2024-10-27 10:24:09', 'Omeka\\Entity\\Item'),
(47, 1, 94, 2, NULL, NULL, 1, '2024-10-27 10:24:09', '2024-10-27 10:24:09', 'Omeka\\Entity\\Item'),
(48, 1, 94, 2, NULL, NULL, 1, '2024-10-27 10:24:09', '2024-10-27 10:24:09', 'Omeka\\Entity\\Item'),
(49, 1, 94, 2, NULL, NULL, 1, '2024-10-27 10:24:09', '2024-10-27 10:24:09', 'Omeka\\Entity\\Item'),
(50, 1, 125, 7, NULL, 'Rdv', 1, '2024-10-27 17:50:25', '2024-10-27 18:03:18', 'Omeka\\Entity\\ItemSet'),
(51, 1, 127, 8, NULL, 'Admin', 1, '2024-10-27 17:51:59', '2024-10-27 18:03:09', 'Omeka\\Entity\\ItemSet'),
(52, 1, 123, 4, NULL, 'Patient', 1, '2024-10-27 17:54:15', '2024-10-27 18:03:00', 'Omeka\\Entity\\ItemSet'),
(53, 1, 128, 9, NULL, 'Médecin', 1, '2024-10-27 17:56:31', '2024-10-27 18:02:47', 'Omeka\\Entity\\ItemSet'),
(54, 1, 126, 6, NULL, 'User', 1, '2024-10-27 17:58:24', '2024-10-27 18:02:39', 'Omeka\\Entity\\ItemSet'),
(55, 1, 124, 5, NULL, 'cabinet', 1, '2024-10-27 18:00:27', '2024-10-27 18:02:30', 'Omeka\\Entity\\ItemSet'),
(56, 1, 126, 6, NULL, 'User2', 1, '2024-10-27 18:04:16', '2024-10-27 18:06:12', 'Omeka\\Entity\\Item'),
(57, 1, 126, 6, NULL, 'User3', 1, '2024-10-27 18:07:49', '2024-10-27 18:07:49', 'Omeka\\Entity\\Item'),
(58, 1, 126, 4, NULL, NULL, 1, '2024-10-27 19:35:00', '2024-10-27 19:35:00', 'Omeka\\Entity\\Item'),
(59, 1, 126, 4, NULL, 'user25', 1, '2024-10-27 19:35:00', '2024-10-27 19:48:26', 'Omeka\\Entity\\Item'),
(60, 1, 126, 4, NULL, 'user24', 1, '2024-10-27 19:35:00', '2024-10-27 19:48:16', 'Omeka\\Entity\\Item'),
(61, 1, 126, 4, NULL, 'user23', 1, '2024-10-27 19:35:00', '2024-10-27 19:48:06', 'Omeka\\Entity\\Item'),
(62, 1, 126, 4, NULL, 'user22', 1, '2024-10-27 19:35:00', '2024-10-27 19:47:52', 'Omeka\\Entity\\Item'),
(63, 1, 126, 4, NULL, 'user21', 1, '2024-10-27 19:35:00', '2024-10-27 19:47:41', 'Omeka\\Entity\\Item'),
(64, 1, 126, 4, NULL, 'user20', 1, '2024-10-27 19:35:00', '2024-10-27 19:47:28', 'Omeka\\Entity\\Item'),
(65, 1, 126, 4, NULL, 'user19', 1, '2024-10-27 19:35:00', '2024-10-27 19:47:02', 'Omeka\\Entity\\Item'),
(66, 1, 126, 4, NULL, 'user18', 1, '2024-10-27 19:35:00', '2024-10-27 19:46:46', 'Omeka\\Entity\\Item'),
(67, 1, 126, 4, NULL, 'user17', 1, '2024-10-27 19:35:00', '2024-10-27 19:46:35', 'Omeka\\Entity\\Item'),
(68, 1, 126, 4, NULL, 'user16', 1, '2024-10-27 19:35:00', '2024-10-27 19:46:23', 'Omeka\\Entity\\Item'),
(69, 1, 126, 4, NULL, 'user15', 1, '2024-10-27 19:35:00', '2024-10-27 19:46:07', 'Omeka\\Entity\\Item'),
(70, 1, 126, 4, NULL, 'user14', 1, '2024-10-27 19:35:00', '2024-10-27 19:45:54', 'Omeka\\Entity\\Item'),
(71, 1, 126, 6, NULL, 'user13', 1, '2024-10-27 19:36:56', '2024-10-27 19:45:35', 'Omeka\\Entity\\Item'),
(72, 1, 126, 6, NULL, 'user12', 1, '2024-10-27 19:36:56', '2024-10-27 19:45:19', 'Omeka\\Entity\\Item'),
(73, 1, 126, 6, NULL, 'user11', 1, '2024-10-27 19:36:56', '2024-10-27 19:45:03', 'Omeka\\Entity\\Item'),
(74, 1, 126, 6, NULL, 'user10', 1, '2024-10-27 19:36:56', '2024-10-27 19:44:09', 'Omeka\\Entity\\Item'),
(75, 1, 126, 6, NULL, 'user9', 1, '2024-10-27 19:36:56', '2024-10-27 19:43:54', 'Omeka\\Entity\\Item'),
(76, 1, 126, 6, NULL, 'user8', 1, '2024-10-27 19:36:56', '2024-10-27 19:43:31', 'Omeka\\Entity\\Item'),
(77, 1, 126, 6, NULL, 'user7', 1, '2024-10-27 19:36:56', '2024-10-27 19:40:20', 'Omeka\\Entity\\Item'),
(78, 1, 126, 6, NULL, 'user6', 1, '2024-10-27 19:36:56', '2024-10-27 19:40:01', 'Omeka\\Entity\\Item'),
(79, 1, 126, 6, NULL, 'user5', 1, '2024-10-27 19:36:56', '2024-10-27 19:39:42', 'Omeka\\Entity\\Item'),
(80, 1, 126, 6, NULL, 'user4', 1, '2024-10-27 19:36:56', '2024-10-27 19:39:25', 'Omeka\\Entity\\Item'),
(81, 1, 126, 6, NULL, 'user3', 1, '2024-10-27 19:36:56', '2024-10-27 19:39:13', 'Omeka\\Entity\\Item'),
(82, 1, 126, 6, NULL, 'user2', 1, '2024-10-27 19:36:56', '2024-10-27 19:38:52', 'Omeka\\Entity\\Item'),
(83, 1, 126, 6, NULL, 'user1', 1, '2024-10-27 19:36:56', '2024-10-27 19:38:28', 'Omeka\\Entity\\Item');

-- --------------------------------------------------------

--
-- Structure de la table `resource_class`
--

CREATE TABLE `resource_class` (
  `id` int NOT NULL,
  `owner_id` int DEFAULT NULL,
  `vocabulary_id` int NOT NULL,
  `local_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `resource_class`
--

INSERT INTO `resource_class` (`id`, `owner_id`, `vocabulary_id`, `local_name`, `label`, `comment`) VALUES
(1, NULL, 1, 'Agent', 'Agent', 'A resource that acts or has the power to act.'),
(2, NULL, 1, 'AgentClass', 'Agent Class', 'A group of agents.'),
(3, NULL, 1, 'BibliographicResource', 'Bibliographic Resource', 'A book, article, or other documentary resource.'),
(4, NULL, 1, 'FileFormat', 'File Format', 'A digital resource format.'),
(5, NULL, 1, 'Frequency', 'Frequency', 'A rate at which something recurs.'),
(6, NULL, 1, 'Jurisdiction', 'Jurisdiction', 'The extent or range of judicial, law enforcement, or other authority.'),
(7, NULL, 1, 'LicenseDocument', 'License Document', 'A legal document giving official permission to do something with a Resource.'),
(8, NULL, 1, 'LinguisticSystem', 'Linguistic System', 'A system of signs, symbols, sounds, gestures, or rules used in communication.'),
(9, NULL, 1, 'Location', 'Location', 'A spatial region or named place.'),
(10, NULL, 1, 'LocationPeriodOrJurisdiction', 'Location, Period, or Jurisdiction', 'A location, period of time, or jurisdiction.'),
(11, NULL, 1, 'MediaType', 'Media Type', 'A file format or physical medium.'),
(12, NULL, 1, 'MediaTypeOrExtent', 'Media Type or Extent', 'A media type or extent.'),
(13, NULL, 1, 'MethodOfInstruction', 'Method of Instruction', 'A process that is used to engender knowledge, attitudes, and skills.'),
(14, NULL, 1, 'MethodOfAccrual', 'Method of Accrual', 'A method by which resources are added to a collection.'),
(15, NULL, 1, 'PeriodOfTime', 'Period of Time', 'An interval of time that is named or defined by its start and end dates.'),
(16, NULL, 1, 'PhysicalMedium', 'Physical Medium', 'A physical material or carrier.'),
(17, NULL, 1, 'PhysicalResource', 'Physical Resource', 'A material thing.'),
(18, NULL, 1, 'Policy', 'Policy', 'A plan or course of action by an authority, intended to influence and determine decisions, actions, and other matters.'),
(19, NULL, 1, 'ProvenanceStatement', 'Provenance Statement', 'A statement of any changes in ownership and custody of a resource since its creation that are significant for its authenticity, integrity, and interpretation.'),
(20, NULL, 1, 'RightsStatement', 'Rights Statement', 'A statement about the intellectual property rights (IPR) held in or over a Resource, a legal document giving official permission to do something with a resource, or a statement about access rights.'),
(21, NULL, 1, 'SizeOrDuration', 'Size or Duration', 'A dimension or extent, or a time taken to play or execute.'),
(22, NULL, 1, 'Standard', 'Standard', 'A basis for comparison; a reference point against which other things can be evaluated.'),
(23, NULL, 2, 'Collection', 'Collection', 'An aggregation of resources.'),
(24, NULL, 2, 'Dataset', 'Dataset', 'Data encoded in a defined structure.'),
(25, NULL, 2, 'Event', 'Event', 'A non-persistent, time-based occurrence.'),
(26, NULL, 2, 'Image', 'Image', 'A visual representation other than text.'),
(27, NULL, 2, 'InteractiveResource', 'Interactive Resource', 'A resource requiring interaction from the user to be understood, executed, or experienced.'),
(28, NULL, 2, 'Service', 'Service', 'A system that provides one or more functions.'),
(29, NULL, 2, 'Software', 'Software', 'A computer program in source or compiled form.'),
(30, NULL, 2, 'Sound', 'Sound', 'A resource primarily intended to be heard.'),
(31, NULL, 2, 'Text', 'Text', 'A resource consisting primarily of words for reading.'),
(32, NULL, 2, 'PhysicalObject', 'Physical Object', 'An inanimate, three-dimensional object or substance.'),
(33, NULL, 2, 'StillImage', 'Still Image', 'A static visual representation.'),
(34, NULL, 2, 'MovingImage', 'Moving Image', 'A series of visual representations imparting an impression of motion when shown in succession.'),
(35, NULL, 3, 'AcademicArticle', 'Academic Article', 'A scholarly academic article, typically published in a journal.'),
(36, NULL, 3, 'Article', 'Article', 'A written composition in prose, usually nonfiction, on a specific topic, forming an independent part of a book or other publication, as a newspaper or magazine.'),
(37, NULL, 3, 'AudioDocument', 'audio document', 'An audio document; aka record.'),
(38, NULL, 3, 'AudioVisualDocument', 'audio-visual document', 'An audio-visual document; film, video, and so forth.'),
(39, NULL, 3, 'Bill', 'Bill', 'Draft legislation presented for discussion to a legal body.'),
(40, NULL, 3, 'Book', 'Book', 'A written or printed work of fiction or nonfiction, usually on sheets of paper fastened or bound together within covers.'),
(41, NULL, 3, 'BookSection', 'Book Section', 'A section of a book.'),
(42, NULL, 3, 'Brief', 'Brief', 'A written argument submitted to a court.'),
(43, NULL, 3, 'Chapter', 'Chapter', 'A chapter of a book.'),
(44, NULL, 3, 'Code', 'Code', 'A collection of statutes.'),
(45, NULL, 3, 'CollectedDocument', 'Collected Document', 'A document that simultaneously contains other documents.'),
(46, NULL, 3, 'Collection', 'Collection', 'A collection of Documents or Collections'),
(47, NULL, 3, 'Conference', 'Conference', 'A meeting for consultation or discussion.'),
(48, NULL, 3, 'CourtReporter', 'Court Reporter', 'A collection of legal cases.'),
(49, NULL, 3, 'Document', 'Document', 'A document (noun) is a bounded physical representation of body of information designed with the capacity (and usually intent) to communicate. A document may manifest symbolic, diagrammatic or sensory-representational information.'),
(50, NULL, 3, 'DocumentPart', 'document part', 'a distinct part of a larger document or collected document.'),
(51, NULL, 3, 'DocumentStatus', 'Document Status', 'The status of the publication of a document.'),
(52, NULL, 3, 'EditedBook', 'Edited Book', 'An edited book.'),
(53, NULL, 3, 'Email', 'EMail', 'A written communication addressed to a person or organization and transmitted electronically.'),
(54, NULL, 3, 'Event', 'Event', NULL),
(55, NULL, 3, 'Excerpt', 'Excerpt', 'A passage selected from a larger work.'),
(56, NULL, 3, 'Film', 'Film', 'aka movie.'),
(57, NULL, 3, 'Hearing', 'Hearing', 'An instance or a session in which testimony and arguments are presented, esp. before an official, as a judge in a lawsuit.'),
(58, NULL, 3, 'Image', 'Image', 'A document that presents visual or diagrammatic information.'),
(59, NULL, 3, 'Interview', 'Interview', 'A formalized discussion between two or more people.'),
(60, NULL, 3, 'Issue', 'Issue', 'something that is printed or published and distributed, esp. a given number of a periodical'),
(61, NULL, 3, 'Journal', 'Journal', 'A periodical of scholarly journal Articles.'),
(62, NULL, 3, 'LegalCaseDocument', 'Legal Case Document', 'A document accompanying a legal case.'),
(63, NULL, 3, 'LegalDecision', 'Decision', 'A document containing an authoritative determination (as a decree or judgment) made after consideration of facts or law.'),
(64, NULL, 3, 'LegalDocument', 'Legal Document', 'A legal document; for example, a court decision, a brief, and so forth.'),
(65, NULL, 3, 'Legislation', 'Legislation', 'A legal document proposing or enacting a law or a group of laws.'),
(66, NULL, 3, 'Letter', 'Letter', 'A written or printed communication addressed to a person or organization and usually transmitted by mail.'),
(67, NULL, 3, 'Magazine', 'Magazine', 'A periodical of magazine Articles. A magazine is a publication that is issued periodically, usually bound in a paper cover, and typically contains essays, stories, poems, etc., by many writers, and often photographs and drawings, frequently specializing in a particular subject or area, as hobbies, news, or sports.'),
(68, NULL, 3, 'Manual', 'Manual', 'A small reference book, especially one giving instructions.'),
(69, NULL, 3, 'Manuscript', 'Manuscript', 'An unpublished Document, which may also be submitted to a publisher for publication.'),
(70, NULL, 3, 'Map', 'Map', 'A graphical depiction of geographic features.'),
(71, NULL, 3, 'MultiVolumeBook', 'Multivolume Book', 'A loose, thematic, collection of Documents, often Books.'),
(72, NULL, 3, 'Newspaper', 'Newspaper', 'A periodical of documents, usually issued daily or weekly, containing current news, editorials, feature articles, and usually advertising.'),
(73, NULL, 3, 'Note', 'Note', 'Notes or annotations about a resource.'),
(74, NULL, 3, 'Patent', 'Patent', 'A document describing the exclusive right granted by a government to an inventor to manufacture, use, or sell an invention for a certain number of years.'),
(75, NULL, 3, 'Performance', 'Performance', 'A public performance.'),
(76, NULL, 3, 'Periodical', 'Periodical', 'A group of related documents issued at regular intervals.'),
(77, NULL, 3, 'PersonalCommunication', 'Personal Communication', 'A communication between an agent and one or more specific recipients.'),
(78, NULL, 3, 'PersonalCommunicationDocument', 'Personal Communication Document', 'A personal communication manifested in some document.'),
(79, NULL, 3, 'Proceedings', 'Proceedings', 'A compilation of documents published from an event, such as a conference.'),
(80, NULL, 3, 'Quote', 'Quote', 'An excerpted collection of words.'),
(81, NULL, 3, 'ReferenceSource', 'Reference Source', 'A document that presents authoritative reference information, such as a dictionary or encylopedia .'),
(82, NULL, 3, 'Report', 'Report', 'A document describing an account or statement describing in detail an event, situation, or the like, usually as the result of observation, inquiry, etc..'),
(83, NULL, 3, 'Series', 'Series', 'A loose, thematic, collection of Documents, often Books.'),
(84, NULL, 3, 'Slide', 'Slide', 'A slide in a slideshow'),
(85, NULL, 3, 'Slideshow', 'Slideshow', 'A presentation of a series of slides, usually presented in front of an audience with written text and images.'),
(86, NULL, 3, 'Standard', 'Standard', 'A document describing a standard'),
(87, NULL, 3, 'Statute', 'Statute', 'A bill enacted into law.'),
(88, NULL, 3, 'Thesis', 'Thesis', 'A document created to summarize research findings associated with the completion of an academic degree.'),
(89, NULL, 3, 'ThesisDegree', 'Thesis degree', 'The academic degree of a Thesis'),
(90, NULL, 3, 'Webpage', 'Webpage', 'A web page is an online document available (at least initially) on the world wide web. A web page is written first and foremost to appear on the web, as distinct from other online resources such as books, manuscripts or audio documents which use the web primarily as a distribution mechanism alongside other more traditional methods such as print.'),
(91, NULL, 3, 'Website', 'Website', 'A group of Webpages accessible on the Web.'),
(92, NULL, 3, 'Workshop', 'Workshop', 'A seminar, discussion group, or the like, that emphasizes zxchange of ideas and the demonstration and application of techniques, skills, etc.'),
(93, NULL, 4, 'LabelProperty', 'Label Property', 'A foaf:LabelProperty is any RDF property with texual values that serve as labels.'),
(94, NULL, 4, 'Person', 'Person', 'A person.'),
(95, NULL, 4, 'Document', 'Document', 'A document.'),
(96, NULL, 4, 'Organization', 'Organization', 'An organization.'),
(97, NULL, 4, 'Group', 'Group', 'A class of Agents.'),
(98, NULL, 4, 'Agent', 'Agent', 'An agent (eg. person, group, software or physical artifact).'),
(99, NULL, 4, 'Project', 'Project', 'A project (a collective endeavour of some kind).'),
(100, NULL, 4, 'Image', 'Image', 'An image.'),
(101, NULL, 4, 'PersonalProfileDocument', 'PersonalProfileDocument', 'A personal profile RDF document.'),
(102, NULL, 4, 'OnlineAccount', 'Online Account', 'An online account.'),
(103, NULL, 4, 'OnlineGamingAccount', 'Online Gaming Account', 'An online gaming account.'),
(104, NULL, 4, 'OnlineEcommerceAccount', 'Online E-commerce Account', 'An online e-commerce account.'),
(105, NULL, 4, 'OnlineChatAccount', 'Online Chat Account', 'An online chat account.'),
(106, 1, 5, 'Patient', 'Patient', NULL),
(123, 1, 9, 'Patient', 'Patient', 'Représente un patient du cabinet médical'),
(124, 1, 9, 'Cabinet', 'Cabinet Médical', 'Représente un cabinet médical'),
(125, 1, 9, 'Appointment', 'Rendez-vous', 'Représente un rendez-vous médical'),
(126, 1, 9, 'User', 'Utilisateur', 'Représente un utilisateur dans le système (admin, médecin, patient)'),
(127, 1, 9, 'Admin', 'Administrateur', 'Représente un administrateur du système'),
(128, 1, 9, 'Medecin', 'Médecin', 'Représente un médecin dans le cabinet médical');

-- --------------------------------------------------------

--
-- Structure de la table `resource_template`
--

CREATE TABLE `resource_template` (
  `id` int NOT NULL,
  `owner_id` int DEFAULT NULL,
  `resource_class_id` int DEFAULT NULL,
  `title_property_id` int DEFAULT NULL,
  `description_property_id` int DEFAULT NULL,
  `label` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `resource_template`
--

INSERT INTO `resource_template` (`id`, `owner_id`, `resource_class_id`, `title_property_id`, `description_property_id`, `label`) VALUES
(1, NULL, NULL, NULL, NULL, 'Base Resource'),
(2, 1, 94, NULL, NULL, 'Etudiant'),
(4, 1, 123, NULL, NULL, 'Patient'),
(5, 1, 124, NULL, NULL, 'cabinet'),
(6, 1, 126, NULL, NULL, 'User'),
(7, 1, 125, NULL, NULL, 'appointment'),
(8, 1, 127, NULL, NULL, 'Admin'),
(9, 1, 126, NULL, NULL, 'Médecin');

-- --------------------------------------------------------

--
-- Structure de la table `resource_template_property`
--

CREATE TABLE `resource_template_property` (
  `id` int NOT NULL,
  `resource_template_id` int NOT NULL,
  `property_id` int NOT NULL,
  `alternate_label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alternate_comment` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT NULL,
  `data_type` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json_array)',
  `is_required` tinyint(1) NOT NULL,
  `is_private` tinyint(1) NOT NULL,
  `default_lang` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `resource_template_property`
--

INSERT INTO `resource_template_property` (`id`, `resource_template_id`, `property_id`, `alternate_label`, `alternate_comment`, `position`, `data_type`, `is_required`, `is_private`, `default_lang`) VALUES
(1, 1, 1, NULL, NULL, 1, NULL, 0, 0, NULL),
(2, 1, 15, NULL, NULL, 2, NULL, 0, 0, NULL),
(3, 1, 8, NULL, NULL, 3, NULL, 0, 0, NULL),
(4, 1, 2, NULL, NULL, 4, NULL, 0, 0, NULL),
(5, 1, 7, NULL, NULL, 5, NULL, 0, 0, NULL),
(6, 1, 4, NULL, NULL, 6, NULL, 0, 0, NULL),
(7, 1, 9, NULL, NULL, 7, NULL, 0, 0, NULL),
(8, 1, 12, NULL, NULL, 8, NULL, 0, 0, NULL),
(9, 1, 40, 'Place', NULL, 9, NULL, 0, 0, NULL),
(10, 1, 5, NULL, NULL, 10, NULL, 0, 0, NULL),
(11, 1, 17, NULL, NULL, 11, NULL, 0, 0, NULL),
(12, 1, 6, NULL, NULL, 12, NULL, 0, 0, NULL),
(13, 1, 25, NULL, NULL, 13, NULL, 0, 0, NULL),
(14, 1, 10, NULL, NULL, 14, NULL, 0, 0, NULL),
(15, 1, 13, NULL, NULL, 15, NULL, 0, 0, NULL),
(16, 1, 29, NULL, NULL, 16, NULL, 0, 0, NULL),
(17, 1, 30, NULL, NULL, 17, NULL, 0, 0, NULL),
(18, 1, 50, NULL, NULL, 18, NULL, 0, 0, NULL),
(19, 1, 3, NULL, NULL, 19, NULL, 0, 0, NULL),
(20, 1, 41, NULL, NULL, 20, NULL, 0, 0, NULL),
(21, 2, 1, NULL, NULL, 1, NULL, 0, 0, NULL),
(23, 2, 185, NULL, NULL, 2, NULL, 0, 0, NULL),
(24, 2, 191, NULL, NULL, 3, NULL, 0, 0, NULL),
(25, 2, 187, NULL, NULL, 4, NULL, 0, 0, NULL),
(26, 2, 186, NULL, NULL, 5, NULL, 0, 0, NULL),
(27, 2, 188, NULL, NULL, 6, NULL, 0, 0, NULL),
(28, 2, 189, NULL, NULL, 7, NULL, 0, 0, NULL),
(29, 2, 190, NULL, NULL, 8, NULL, 0, 0, NULL),
(37, 4, 1, NULL, NULL, 1, NULL, 0, 0, NULL),
(49, 5, 1, NULL, NULL, 1, NULL, 0, 0, NULL),
(53, 6, 1, NULL, NULL, 1, NULL, 0, 0, NULL),
(58, 7, 1, NULL, NULL, 1, NULL, 0, 0, NULL),
(63, 8, 1, NULL, NULL, 1, NULL, 0, 0, NULL),
(68, 9, 1, NULL, NULL, 1, NULL, 0, 0, NULL),
(73, 9, 261, NULL, NULL, 2, NULL, 0, 0, NULL),
(74, 9, 253, NULL, NULL, 3, NULL, 0, 0, NULL),
(75, 9, 265, NULL, NULL, 4, NULL, 0, 0, NULL),
(76, 9, 264, NULL, NULL, 5, NULL, 0, 0, NULL),
(77, 9, 266, NULL, NULL, 6, NULL, 0, 0, NULL),
(78, 6, 253, NULL, NULL, 2, NULL, 0, 0, NULL),
(79, 6, 261, NULL, NULL, 3, NULL, 0, 0, NULL),
(80, 6, 262, NULL, NULL, 4, NULL, 0, 0, NULL),
(81, 6, 263, NULL, NULL, 5, NULL, 0, 0, NULL),
(82, 4, 185, NULL, NULL, 2, NULL, 0, 0, NULL),
(83, 4, 248, NULL, NULL, 3, NULL, 0, 0, NULL),
(84, 4, 249, NULL, NULL, 4, NULL, 0, 0, NULL),
(85, 4, 250, NULL, NULL, 5, NULL, 0, 0, NULL),
(86, 4, 252, NULL, NULL, 6, NULL, 0, 0, NULL),
(87, 4, 251, NULL, NULL, 7, NULL, 0, 0, NULL),
(88, 4, 253, NULL, NULL, 8, NULL, 0, 0, NULL),
(89, 4, 257, NULL, NULL, 9, NULL, 0, 0, NULL),
(90, 4, 261, NULL, NULL, 10, NULL, 0, 0, NULL),
(91, 4, 258, NULL, NULL, 11, NULL, 0, 0, NULL),
(92, 4, 263, NULL, NULL, 12, NULL, 0, 0, NULL),
(93, 4, 260, NULL, NULL, 13, NULL, 0, 0, NULL),
(94, 4, 262, NULL, NULL, 14, NULL, 0, 0, NULL),
(95, 5, 254, NULL, NULL, 2, NULL, 0, 0, NULL),
(96, 5, 255, NULL, NULL, 3, NULL, 0, 0, NULL),
(97, 5, 256, NULL, NULL, 4, NULL, 0, 0, NULL),
(98, 7, 257, NULL, NULL, 2, NULL, 0, 0, NULL),
(99, 7, 258, NULL, NULL, 3, NULL, 0, 0, NULL),
(100, 7, 259, NULL, NULL, 4, NULL, 0, 0, NULL),
(101, 7, 260, NULL, NULL, 5, NULL, 0, 0, NULL),
(102, 8, 261, NULL, NULL, 2, NULL, 0, 0, NULL),
(103, 8, 253, NULL, NULL, 3, NULL, 0, 0, NULL),
(104, 8, 264, NULL, NULL, 4, NULL, 0, 0, NULL),
(105, 8, 263, NULL, NULL, 5, NULL, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `session`
--

CREATE TABLE `session` (
  `id` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` longblob NOT NULL,
  `modified` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `session`
--

INSERT INTO `session` (`id`, `data`, `modified`) VALUES
('3ua8t9njn7r3uhm620otopqkp9', 0x5f5f4c616d696e61737c613a353a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313733303035383835382e3836383730393b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a223065326d35666161666d37396f3462746a356b32667430626f68223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303130303730383b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313733303130323033333b7d733a34343a224c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303130323035383b7d7d72656469726563745f75726c7c733a32373a22687474703a2f2f6c6f63616c686f73743a383038302f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223364316635376364663336313933623430643466633735653532383732613330223b733a33323a226638663932636434363465336133653638313963396537336636383361653836223b7d733a343a2268617368223b733a36353a2266386639326364343634653361336536383139633965373366363833616538362d3364316635376364663336313933623430643466633735653532383732613330223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a35353a7b733a33323a223536306565323661616534633961666531653033393538633261373566346130223b733a33323a226236343661663064383562656139313039663131323765636363353463393565223b733a33323a223135613830666663386564613561383766343232313565383363353962646637223b733a33323a223765373661333664353666346361393439656339373166343165346566646339223b733a33323a223561376265316230326533333262303735336134393261346565323432323237223b733a33323a223036623630376566383533626363326636393330386261613564396466336536223b733a33323a223931396665613235663433633533343235666434313361346231646536333235223b733a33323a223362663866306439323661373937373834336461326163323134313964353333223b733a33323a223437313764316366623038636461373362333533646436336366303039343164223b733a33323a223361303062323266643938363534393230633033663665366238623734346136223b733a33323a223464646162376234633865396437616539636230356235383266353138393233223b733a33323a226631626432383131316338646630613062636438313131366334306235623830223b733a33323a223236323031643334336161386530396464306464363239303864383961663034223b733a33323a223830666661376539346638386232363362333166633630386238313431633665223b733a33323a223039306536626130373735656364353339396131376133633532353831306234223b733a33323a223261623539393064393330373738616637333263366565613033363862633664223b733a33323a223366376565366234653264636333303864323561623538653932396530623064223b733a33323a223138623665393564356362393134613439396266336637353233333266626133223b733a33323a226561653438393537623364306437363731363131366136613032623061313238223b733a33323a226537643731376235353962656561383963303266396639343538666439653764223b733a33323a226462613466613031663835313931636662623461326531386361386237653331223b733a33323a223535323966663563393862383065653132623231666239343437386634613736223b733a33323a226335346137376330343564623761353637383761643239393435326631666436223b733a33323a223762383338343361323737616465626564656366306330613431353432353636223b733a33323a226235316232333535646466363133313435336533336162346131623766653230223b733a33323a223665303964643935316630313961633930326633653233656332613038366531223b733a33323a226338633837373736386637396562326333373464636665666165323864336462223b733a33323a223563643762313334646237656334316534623232633866303739353531633632223b733a33323a223761643431393832333563333766343939656631623036376165396539656534223b733a33323a223764343339336233343938643666616537393338646366316232343438366339223b733a33323a223834396563663137383836643464393838303038393132633931343038303463223b733a33323a223531306662383833303434353637653032656564336339366530343564643562223b733a33323a223633323835356536396631633130353136653630636237376362633131373765223b733a33323a223436333037306164646334636639353439633938653131626264363638653562223b733a33323a226663383931306636346431356565393363383462313061336231646238346335223b733a33323a223862613162363236396466386663663063386133353765613434393732373461223b733a33323a223333616666326339336139393537313365393262326366306131303465393934223b733a33323a223634393965623163633636656532393338383530346435306239653439396337223b733a33323a223464386231616562363730666534656633363032376265363430626238643934223b733a33323a223437393162386363303065313834333238306263396535346538306661356539223b733a33323a226666376263626432363166656435643332353966616231626239383166353132223b733a33323a223464356364336338303461636161313036356264336139343733353330386366223b733a33323a226437313362366566363030386463353336393037613838666337376237666163223b733a33323a223534333164383863323435393536303964353534393461633535613536323262223b733a33323a226366363938643461393636626533363262393562383633323066376537656466223b733a33323a223466306339623132316231303833643262396438643931333332333739643261223b733a33323a223362653934633731336262323763653033316331643737383364353662356630223b733a33323a226632663830323661633734333733376432336539353035663033656334393961223b733a33323a226338623061396138613265383439353634653835383263623163653635646138223b733a33323a226561353331333438313739663964313161383665343930666435326234363633223b733a33323a226365393636366335323335663634323765303639356439613966643739626239223b733a33323a226261343766323036653631613336626538303032323666343361666265303833223b733a33323a226333613363393162633963346534656335383665383461613664383164623439223b733a33323a226230396638623235326238363632653365653734333234633130383864303632223b733a33323a226137343363393661383130323533333462613366343531623034393134643137223b733a33323a223563363234333530653836663131323031373431623765393231633530393239223b733a33323a223334363034623731643430666466393030336633363430656532666430346135223b733a33323a226237623962666239316230366466373735636237386334336337376366383038223b733a33323a223366356632646466333766343830666131336638353032643664346562323837223b733a33323a226265333865333333326361336330386561613466373535356439396132653637223b733a33323a223538613737623666656530303463336436316135363930363237646630353665223b733a33323a226166656162343563343234313265353964353839313264633165303464666531223b733a33323a223362666330623662623963353332373339396537666237653230313263663132223b733a33323a223838663939633034343962356532363231643334393234386631313834623532223b733a33323a223238666439663430313639326631666231303030323532323438376132626464223b733a33323a226438396165656237393461613663313133383362343535303631393062666638223b733a33323a226331306336643032393133383464376262646261313539373333363932626165223b733a33323a226134333233653066386639393634356632393262623634653334623265313836223b733a33323a226137383738343765613864313031396263303162623038316137626265333066223b733a33323a223830626363356339633163353765376336363436636136633830646565663864223b733a33323a223664383735626166303766633830303330666465636533613538346233356166223b733a33323a223439383265383936646333336236353936363039346230653965333461626138223b733a33323a223362623638353864356266656132333739303562383762666235396635626466223b733a33323a223338633539356538316538373133383630373533623562653734616438336339223b733a33323a223731313064613465323434306462616139343062373166633734303932623331223b733a33323a226339396638346237646663366134383930323266636230333834663461303036223b733a33323a226561373534386237343834343833303664396662663136656438663765316465223b733a33323a223865376330346663666136356234356465663762623238313333656464313434223b733a33323a223966333530316336306432333835363165333535326364373032643637383765223b733a33323a223336306663646433323337643566663839396265396130633537366637653666223b733a33323a223266393538653366316363303634636162316466636365653735646334393164223b733a33323a223035633665316563623539343731353939613139333233346639313666393662223b733a33323a226537323262623836343638313634623231303466633235336235636264303962223b733a33323a223136366331363563306664326532346631336131333738616166653330376665223b733a33323a226435363137656235643033386538616538643030623232316531653533303938223b733a33323a223965386231626538336130303761626438313035656439313335336132353635223b733a33323a223239313465303739393637633735386263326131386230343037643434633734223b733a33323a223134613832613662313965313964383236363465363962326165313337656430223b733a33323a226130613862316532343339663530356664616534303231373164306338633038223b733a33323a223632313265663237343838613831643730376437313338366664323261383466223b733a33323a223537663262663036623463323135666535616663396433323434363765316230223b733a33323a223064633331346462653166376233323636656565393633323332333930366364223b733a33323a223036343164646236373234373362313963343766633131376661323235623137223b733a33323a223762656563633137313361623163333030386565363836343132323434366336223b733a33323a226439643937613731656239656363646536646437383332626432356136623161223b733a33323a223331623736663932316564373863653261313061303632633336646632336431223b733a33323a223437643330353334646437643335646666653233316361306662633466363438223b733a33323a223862353236366235623463663736396234313030353762343837393330376231223b733a33323a223837313562376562353038633661636435323063306132343336633433303730223b733a33323a226666613939343233363136613033613336373035396337613531613931633031223b733a33323a223536323963613238653564376631623938313762346232333735336136343834223b733a33323a223035613436633638643832333538653730646131326532313531373537333235223b733a33323a226562363766326435353932633635656230333937336465353630313862376664223b733a33323a223032303231386431373832363938366231386139353931613539613331303162223b733a33323a226235643533626662616466333362306365383839666137646130383461393033223b733a33323a223362303534353631623536313366313765343938333439306235396239316131223b733a33323a223334356262633738613364306238613636376139616631623330393735323139223b733a33323a223839366636313634666635386162636632653132616337386130316565666637223b733a33323a223633396666316435353566346136383831633534353738313164343366643366223b733a33323a226365346364333238393938326162373365356634363232316634346233336566223b7d733a343a2268617368223b733a36353a2263653463643332383939383261623733653566343632323166343462333365662d3633396666316435353566346136383831633534353738313164343366643366223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a3132313a7b733a33323a226563343235376566343839353630386461613539336463336661666463346235223b733a33323a223334626631336534323234646435356138393238343564396235633837396331223b733a33323a223136393161636461666564633761353038376165366538616263633337303836223b733a33323a223339366134633533343862366335653233346139366435303931343666333164223b733a33323a223337326162663832313664383561303236346234383738363235316539643463223b733a33323a223136363766393364356136376262663038376636353362633764623463623137223b733a33323a223532366563653231373738376438303964633634313135316438666561303335223b733a33323a223266653736343366633965353734313639396262316463313931373435643638223b733a33323a226435613166333462613430646636373866643935626466643336626137353039223b733a33323a223832383434663066626165623665323932356536316635336632636165663538223b733a33323a226534396464653063383630613366646233353634656164313033396162306664223b733a33323a223064353563396161663632373539373533376661646232633565373330636162223b733a33323a226564353364363864373234646432616664623063316362303364646638643430223b733a33323a223238376530323934646364366133376262343461613531353034356237333162223b733a33323a226136313762626563623533316139623730666631666636666536633536646633223b733a33323a226138383137666131663236373662663636336161323833306333333432356633223b733a33323a223738333634336633616230353330353637303231313036393239383738333862223b733a33323a223165363733343633306336653361323339656662653430316533666166313634223b733a33323a223733613135636164396362333065383861353735656339323062306565666236223b733a33323a223136306236393761613632613861653837613736333238636432363237313565223b733a33323a223133303332333634306364343732633362346466366665616434356139616637223b733a33323a223566336335303936313135633364343866613762396538353365623663363839223b733a33323a226133613636343033383934316365343438393734633666643930393666623564223b733a33323a226238353765633235636165333032366430643065343563303635396333376236223b733a33323a223333393665613638393462373532363263336634633337663664663537343463223b733a33323a223833393136653065356233353933313739633961616438336135336635323864223b733a33323a223061646365323334313932326535393064633762306639656537363464643131223b733a33323a226531663363383163396537393366623732613133643636643136663966383461223b733a33323a223466626366333634313032343939643532363139613661373037323562366433223b733a33323a223866623534613761613239376166343335626634646361363631333462363332223b733a33323a226331343935346237663365343832383032613333356138303830376639646364223b733a33323a226666653663376366373261343563326666373633306361396564303665316631223b733a33323a223737626235343030646237303062323265613533616238643263663564656130223b733a33323a223662313465306131323736396433323661356162646630666137333132343762223b733a33323a223438366564363065323962306538396434386164343333633736653838633164223b733a33323a226234303035303537333634386435613730366437353234363463623938633866223b733a33323a223265616331653865613461323562376365313063623361363239616638316539223b733a33323a226361376535306431363337323561366231626636303431393161656361366530223b733a33323a223864663835343263356438643835333932613131373037653031656137383862223b733a33323a226435653861643963653866646161316331646432666139636233383461636439223b733a33323a223962313964363134376531666436356233323133643939613239316334343563223b733a33323a223437346139346539313265656661643732396436616235373032623333656237223b733a33323a223262313131333561623062653431636161303132396662353438393034313362223b733a33323a223065653061643637373333643436313733653365363936656631653861366362223b733a33323a223162373661653235653564613035306535353664356134383961393738663932223b733a33323a223738646538336262316533653462623930333266666232376431383762666539223b733a33323a226463393838613931343735626630326639396462336138326134646531653165223b733a33323a226563306361393239396366656130333630346464626332306361653966383265223b733a33323a223235366632316539636162376139333838356261373435666136646365363532223b733a33323a223632373636666365373266626666363233343761616664343663393238613266223b733a33323a223031663066333730633537353133306439336535303735306663386130643530223b733a33323a223831373438313830343166383663616164656633613666386432343530626238223b733a33323a223537326436313231643834373161643166353238643935323231373261396333223b733a33323a226337336236383630636231626563656239663939343239366130366166313932223b733a33323a223733636634656533663737363739393136353762663931656638626230656534223b733a33323a223339373236333633363338323733663739313663343731333634613963326361223b733a33323a226233333335383835633431343031396633353430366661663561313732303561223b733a33323a223437626438646433373636626235353631386631303332303965393361356130223b733a33323a223139633166376231613364623739613633373735626331343564643831323961223b733a33323a226632656637373533343634366434383134393664373938353032646135366466223b733a33323a226162653565613831343432373138616635366130363737623130646363643965223b733a33323a223866363435323538326136376665316339613962346462313834633239623339223b733a33323a226137366366343864333834313832346236656434373661633366303131656161223b733a33323a223130653338656462363435646232303732356631366664363165393230356132223b733a33323a223364643738363839333765666661663866656238653331306135383965343461223b733a33323a223535383164643965613035643631326364353362313831353063636334636536223b733a33323a223430366638663332613663326433646530303538383664363536323032333338223b733a33323a223137343164306237646662386466616466666363373539333363363031633066223b733a33323a226237323139363335376232666662663438373336633035386565303730333163223b733a33323a223735313666623635376638653239626237393331663861633734333961313632223b733a33323a223138653039383065373431306336333539373564653637313063323138633630223b733a33323a223965646230393434316437613363666437396163313962343139303532623334223b733a33323a226334346664386131626365313365393762323966383266343564373262353966223b733a33323a226134646431613133393266626130363039386562323834666132373035663532223b733a33323a223337373063353233303461643534653638663037653636633236353638396539223b733a33323a223161313032313463616535663561383837383466353262643862366138313964223b733a33323a226166623264393262613636306338353938633866363837383164366336303864223b733a33323a223333653834346361313633343038313762353634383465636430366565316661223b733a33323a226561653436633139643038343437316131323437663864383438326364376435223b733a33323a226661633635646236653931303531613662366532643532376434373765336336223b733a33323a226566363334383039613866663633363233646264653137663466306263393765223b733a33323a226130336664323430616334616536393738646631313332643335376630376264223b733a33323a223065623236396430653736373139316334663134366439323330656134656130223b733a33323a223337663434376261313765343963616434613335666334613966336235393739223b733a33323a226435386165613730653063666233303464336364393263653138613333616665223b733a33323a223766363566636536346565633533383833393431386665313666323939626337223b733a33323a223862306266646239336163383431383462333837376235653937653161323661223b733a33323a223062356533626165366333646164653061613734636363393365336330306363223b733a33323a223334666166373534633631373931616234643937353431333739646633373365223b733a33323a223732353638396565653666363131343663616333323665333563336331646231223b733a33323a223132316331336264653838646435363461616162343834613161336364666435223b733a33323a226262663530343766623236393838346661343239363966663032336261323764223b733a33323a226266366432363763666533646166646132366536613763376239633761636234223b733a33323a226333333834666132386261623135316536393033386564616138323164383732223b733a33323a223533636664663864326636303538373563646337633538623961656534623031223b733a33323a226639383837653063383733646536333064326639383336343361623663623832223b733a33323a226164646530333036346166643166343034373466616135326339386435656266223b733a33323a226630346537333431613461313466666137623130376366396331303463653565223b733a33323a226133636133616139663030626136353330616632613233666235356565323462223b733a33323a223236323636333735393436643762376339336231653765663061613738323439223b733a33323a223162663832343436333163303564643933316436316332346538306663303738223b733a33323a223238343535393031393133383430303239646434363463613430666363363031223b733a33323a226433353164613239323539346364643233613033633630646435373464623461223b733a33323a223533336139303138326534663539373763613065656233363036396138643763223b733a33323a223530613437636631343666333634353434656432303938353638653139336335223b733a33323a226239383361633433356263313238613538383830333062316639343735396636223b733a33323a223963613363633230396134343464326432646637363864613337303536346633223b733a33323a226664363966316632636163626564336533326136353665326236636534353036223b733a33323a226463353465663534613765393837313966663866383362393631633933303831223b733a33323a226462643965643532643235386630666635393466393636383932353262343266223b733a33323a223665373065616165316233343236353065373036353632666665353562303836223b733a33323a226237306331623034343262373138313130623230323937313233626630343832223b733a33323a226561616466336161363563343231306166373534643333613033353663343538223b733a33323a223666646334336161633061633338343764343935653634373866323661663832223b733a33323a223133666130613835383331396263373231663036333137363663646462626433223b733a33323a223763373437313337353439663061663031666264646665613131373764383538223b733a33323a223963306262613465343863336337633137343466633663333164646439316361223b733a33323a223630303639623065366462313338393863363133393062623638643435393730223b733a33323a226131313837623434383762373033636430613266663761636232666330323737223b733a33323a223761333764393334653239373639613736316432323333613138656330663736223b733a33323a223737353133663165653435333061336536346431303862616335313664616239223b733a33323a226262663665346133323864656664313366353663313035326338323239626638223b733a33323a223831653063373834636638623739373366623135386135336335323132373539223b733a33323a223732396331373835343165626233313462326365313166373863336339393639223b733a33323a226439333337386230393963656434656564383635373133353064613365393965223b733a33323a223533626533363433373166316335326231343035313862623561373164356366223b733a33323a223233313861313033326464393331396664636465313637316431653933346462223b733a33323a223262653965393536306165303866616331366661653139376465626430663534223b733a33323a223738396236346632623665633031336431326433373666633839313734343434223b733a33323a226439613661393931356237383761316435636665373233323163313365383436223b733a33323a223463346438386138356239346362353937623162396230393431323133303037223b733a33323a226638303930643537613066356363313562373935396238376533393234356532223b733a33323a223738653736353735373863383036346666656533373833383634396661623366223b733a33323a226630363562326464353562633736653565653665643632636561363133313963223b733a33323a223764396665333035396134323164396161333538663936643762646639353932223b733a33323a223463376264623738386164313964623463323938393736636435356630303263223b733a33323a226139633632613437303839386334616531653961653661356134616165626431223b733a33323a223930633639623331626637656235656139653435356533313962316638396139223b733a33323a226537303461636465613631353037656434366363343436646663623464306433223b733a33323a226633396635623735333738653730346631376462353434376639386432636431223b733a33323a226463613439376336353763323562333837316637613933613266323638343538223b733a33323a226234646635336239313935633835623635636465653163383439366438623035223b733a33323a223938663563333264303564393931383135393337626164353961373833623230223b733a33323a223464326531386135656135663039376430326361623763323936373731343538223b733a33323a223066353436396662653231393861353232663530316538623365646139306463223b733a33323a226663366464663839643434646662346236646261353734396232656637623334223b733a33323a223734383431306238376665393563373037636232373935666430643938613838223b733a33323a226132616666373264633236383163313939383239356239636163626634343132223b733a33323a223861386233353638363231613465636338653435663339396339656431383133223b733a33323a223736326133386231353839316664646461366563626564613439393364613333223b733a33323a226536656264333235333230653433343439396563313761633530366236326338223b733a33323a223637646137636235393831646534623537353665636565346561313637666135223b733a33323a226537663361313030376134323330646530373762613835653764646637356362223b733a33323a226539363538363134623661303836663537346161623834373330656631643139223b733a33323a226266386230303736363637653966613436326132313334316564353736643766223b733a33323a223861333462393836353739653765353730323231326630666335343433343736223b733a33323a223136613731353566336162373238303961336437343236346266653234313366223b733a33323a223863663838303563643538333061366164323466643237373330653966346135223b733a33323a226465643937653933663064643138386635636162616339633531623761376264223b733a33323a226462313534626430366463643534616232633630613062623932633031626239223b733a33323a223830636462336537306261373061653165316430303866316636623030613334223b733a33323a223530326532346430373233613431303661613630343738376433663231303239223b733a33323a226237666639626231653138316263666431363134623839316132323536323635223b733a33323a226366616431656662653538346139353561623433313332366437316565633363223b733a33323a226363353733396135376639333565633233383163313838376163303164353232223b733a33323a226138336339396562393762326463616664383164343333636531656131323535223b733a33323a226662303363323633356136653031646330303937636137626665633032353833223b733a33323a226637383364383932363731353230393736366666343465656532313639306135223b733a33323a223637396633666537303362346665343936653734396632636437663963353565223b733a33323a223838393561626666646438636536626636613161316663333735396564333363223b733a33323a226635303331383166373037656234396534353062336636643563346161623632223b733a33323a223431343763373230333666343164343763313261346633303966363231613164223b733a33323a223035376361366438633261316236623534393831323363623938396239373739223b733a33323a223037623838613238313933306331616537353565623737613364383032633337223b733a33323a226138653763623332633761333439316661613161353834383461643865613831223b733a33323a223135353536386366333562623561653164333161653763323963666663326661223b733a33323a223163653065633937306562623236353862306262666663373733666136363864223b733a33323a226438386166383864346462653136303032636233313433663534313630316261223b733a33323a223230323062366231643032396561373536316539353463666431613835303366223b733a33323a226132316166346133636265383061303832333564306461316436636464396334223b733a33323a226339343731663333316264303633316134613162353438636336333932373535223b733a33323a226432386263653833356430306162303737323634626432663238626138666463223b733a33323a223936316330363438633331616361373238663861303335316364373362653164223b733a33323a223832306662626364366236366436346237653632313331663163653639326330223b733a33323a226130613435366637346363666565373737646666333264373661656138626339223b733a33323a226235326133393062636237656436393537373561376166613664343062666233223b733a33323a226361623662343864643032383836333832373136613431306162373431343839223b733a33323a226638343465666335346633393465373138333763653662393237396635313133223b733a33323a226330363433313136303533313366396636616138333238356166376163336239223b733a33323a226665303664656530346134613362643737643366643466363762613935306139223b733a33323a223935353664633264366333323139363237326432356632666130343337616261223b733a33323a226438633438646437653864623232646233633431663464653765353634303464223b733a33323a223531363733326630353865623532663863323565613661303933383734376361223b733a33323a226165396139346435363234653431353230303031383366383961613134373965223b733a33323a226364623039393532623234353565643762643331643335643230646634613132223b733a33323a223465653033643034646164303135333232306266666536363933633733353365223b733a33323a223061303165356434333537336532383731666165613737353333616361633262223b733a33323a226234333834376330393762333963623261343434663066353237373134393637223b733a33323a223431663063626231656666663434643438356533623033306664643561626365223b733a33323a223739383865383134376565366262346539373135666665313733376431366662223b733a33323a226362656138363036336436346336373633613738333765376139353737346638223b733a33323a226132663466353139346533376237666162303030353137636538393939373936223b733a33323a226663373635623262393466643730626337336262343836303864326332616461223b733a33323a226436643731373837386365363333343235653134323566306265373139363030223b733a33323a223533633939626239396334323939373039306336633337356537306462306165223b733a33323a226633333638633433393762396362663933323465633530356266613831633163223b733a33323a223432353436373532636165393537363233633066393662333361326163323164223b733a33323a223734636563316435326431363463333837336633306438346639666566373564223b733a33323a223231643434353661633165303265626137303132336632383639363731636237223b733a33323a223963633964313633616264396638373539316433303336373138656530366538223b733a33323a223832383163616666386233316534643335363436616538613038383339656666223b733a33323a223338613136383437353634613036623437363965623633653661616233323036223b733a33323a223236623834313433363832393461366137313933326130303762313964656136223b733a33323a226630396137333261653133363863323163343535353162643439326266383939223b733a33323a223435356339386439356638323835613166653030376636353933383535383134223b733a33323a223437656364383131313863363532343565666434353034643436613334316436223b733a33323a226632343963633761393235336561373665313464363939393634383134343461223b733a33323a223330346435326466336337386632656135303432386663333031396532363561223b733a33323a226235343533393436303765383332383637653139303036353161623363373364223b733a33323a226533386463666530363631373065366362653535383734316234386265333537223b733a33323a226163303832313463303836303864326364373633643737386235633165363562223b733a33323a223266313831333738343237323930333336313739633963393635653961386530223b733a33323a223339353561643365323031336139626163326439386132646162343037663464223b733a33323a226130653631373865303436656664363365656361643432373332326462323437223b733a33323a223962383366316362336164643139636463633631333530363236333261323163223b733a33323a223537303463353664393835613231653032386161333733333062626462343237223b733a33323a223665386136333963303434396566343632623362373538393131383964336132223b733a33323a226464663739633834346261646639356339326438313266303632343161306362223b733a33323a226561326166643061663433393531393936303562376565613465303466633564223b733a33323a226561393130323233666334613233623438653032653539613832373363363361223b733a33323a226231663365373735376562663332353166613265623832343434373530303331223b733a33323a223838343264386635363161636566633032396164353938633130626332333733223b733a33323a223339656531656565383237356336656134313363393665613430366265663934223b733a33323a226662353137363934303032313538653034386236373865323931316362383264223b733a33323a223366656333633663656361316230646638313031656437633339643066353264223b733a33323a223164373362663931623632316133666262376536656235643864383462356366223b733a33323a226561663038353036646562353961356664316133393965376165383465653862223b733a33323a226435363566326163643530623766303936633066356432633765303735633939223b733a33323a223437633331333031393630353534386531653564306361346331376538373464223b733a33323a223464303062383234383632663033636535356239633536613338623531666238223b733a33323a223566643564623238343162393137386635633835653566363466373634383635223b733a33323a226131353533646535353861626663613837373632303666396335646432633136223b7d733a343a2268617368223b733a36353a2261313535336465353538616266636138373736323036663963356464326331362d3566643564623238343162393137386635633835653566363466373634383635223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1730058858),
('8d9t3db5jmu1aebcti72gvau0t', 0x5f5f4c616d696e61737c613a343a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313733303130393237362e3530373337383b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a2275376e706531366f3738396e656330326d74686b70346c663034223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303134373139393b7d733a34343a224c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303135323437303b7d7d72656469726563745f75726c7c733a32373a22687474703a2f2f6c6f63616c686f73743a383038302f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223362366535333432633764623365343838653933663433383031616163376535223b733a33323a223830663135626538393263656335306336396464313461363162616633623830223b7d733a343a2268617368223b733a36353a2238306631356265383932636563353063363964643134613631626166336238302d3362366535333432633764623365343838653933663433383031616163376535223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a343a7b733a33323a223065306461323736353361653034626332346465323534303731613062393630223b733a33323a223030653635663139386432303430323630643536363162633934383832306634223b733a33323a223433343535623937323331373962383663376361393566666662626633626564223b733a33323a223163366138336166633464326630373733393139643762393637633261633432223b733a33323a223135333133633534613737626630653932396331656261396262636637363432223b733a33323a223561393736663637643533323662353132353834386662343532343538376434223b733a33323a226436653134383933626233313739663562346530656262623366663636633437223b733a33323a223464353734666139363164303464646632313533356631396634613236623063223b7d733a343a2268617368223b733a36353a2234643537346661393631643034646466323135333566313966346132366230632d6436653134383933626233313739663562346530656262623366663636633437223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1730109276);
INSERT INTO `session` (`id`, `data`, `modified`) VALUES
('fp7l6utojm29ljcghns06ru7rd', 0x5f5f4c616d696e61737c613a373a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313733303035323933332e3331373636363b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a226261636c3834353630636e327572636c736a393465676c693436223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303038393933323b7d733a35333a224c616d696e61735f56616c696461746f725f437372665f73616c745f7265736f7572636574656d706c617465666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303039353334303b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313733303039353637343b7d733a34343a224c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303039353637393b7d733a35333a224c616d696e61735f56616c696461746f725f437372665f73616c745f766f636162756c617279757064617465666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303039333838373b7d7d72656469726563745f75726c7c733a32373a22687474703a2f2f6c6f63616c686f73743a383038302f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223438393637376633326165613836313333626132313262323931653763326561223b733a33323a223461393839623766663237613333336237656335393731313965386461613235223b7d733a343a2268617368223b733a36353a2234613938396237666632376133333362376563353937313139653864616132352d3438393637376633326165613836313333626132313262323931653763326561223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f7265736f7572636574656d706c617465666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a33373a7b733a33323a223365366535326365373130656461393032633363396636346331616630323236223b733a33323a223433383133323734336635326633346435396562353934613038383138326333223b733a33323a223533313662363836336432323338343039383133643463623665626265626239223b733a33323a226463613063656561633361653035343063333761336161633262613038326465223b733a33323a226262646465316131646562316664393737346431306164646331386332323035223b733a33323a226463626438666465366632373265373063623936636362623761643736393763223b733a33323a226330336332353835363861363766313435306365633962633137376264313838223b733a33323a223666623831386336613631316366363837306133343361613837303861373538223b733a33323a226162656435383136353539623661623061376131623464633963643563376536223b733a33323a226235346534333966376633376432343964333733383037356662653139623062223b733a33323a223139383732383761383136623934633265376562626333303765373030396261223b733a33323a226432323766353463306338386230303364353566613562303665356339336135223b733a33323a223539663535303932326134663165373363333836626361373533386135613262223b733a33323a226461633536373931663234653736383238623964306364626265623462643864223b733a33323a226563386534613866383131643966323432396336643136623761306161316138223b733a33323a223938613861313464343837616634623739306436656365623135343066386136223b733a33323a223363623363373765663739646238366339393562313463376331613130626165223b733a33323a223732386265383765633339343639666535643235663630323939663838663839223b733a33323a223931643364383833333230633639653538373336623235386435396562386330223b733a33323a226134336161303565316330623132393834646264356433316639383731356231223b733a33323a223731376139303266333438353835326535393236366564646632313338616464223b733a33323a226465616235333632313761613232396635663366636636623734323335353866223b733a33323a226539616261653037643230323165373865376565386237366239616534653437223b733a33323a226634376665356637616138646533323161343231356665316133323339313266223b733a33323a223230663562316437343664366165373932633430303963336133613666373366223b733a33323a226136666366646566613536336531326236643836383930376562353564623837223b733a33323a226533616134326433376165663439323061346432646164323966313966616363223b733a33323a226130386234656666393465623338623737316463393964396632343033323331223b733a33323a223561393966343966353139333133313633386662383062643662386331663064223b733a33323a223565363336383738313036653236363634313262353938373861306266333434223b733a33323a223737643037633366376230663830393839623739323263353262656430396464223b733a33323a223531366238313964383432373930663038333065613832323539626662336639223b733a33323a226136376330383831633130666465613438373333653865653766306635393861223b733a33323a223261643234333734616531323433326562363866643339613466306162326466223b733a33323a226535366134633430346664373038366537663930666539393130646635623164223b733a33323a223363333666616630613733376338313330373765373637306366393033393231223b733a33323a223936636633383565356133383165356233643430656661646534626534393134223b733a33323a223133646165613765383133333430303462623761643237393562323438376662223b733a33323a226633616266643061313639363236396437346234323266383136616563386234223b733a33323a226263663534636131656164346436646663353132393235346439386433366162223b733a33323a226635316234386565396136616231386662373734343035613839643735373934223b733a33323a226335653433303061643834633130623736363065623830343735356464653161223b733a33323a223562653038333565636131633039306334646433356632613034393065326232223b733a33323a226562323934613137376335646263333438353865316134643265666130396331223b733a33323a226338626266343432346434626239666664393763633535393233623739653965223b733a33323a223561633534303432343939343464626431396166316637376465376636656634223b733a33323a226230363137643533313262653538613330383365326531346234666362656538223b733a33323a223232616534323930633662323662623266383832306333633835616430333238223b733a33323a223231363863663435316534336534386537363131363735343639333832646563223b733a33323a223461373433376234633436386132373264303037393961336566383332633139223b733a33323a226662616465373566623731333364666335316566343639353839303837336331223b733a33323a226436343739323265383435613639333563363836663866326136653134373735223b733a33323a226265353637623034313435353932656564666539343731393863343030386666223b733a33323a223863666565653431373230656332626261363532636363376336316237666161223b733a33323a226662643138363465393665306638663238383235656238633233663532613530223b733a33323a226337633437356630316238653831643637356335626161343463303166383438223b733a33323a226139376561306362643864393834353339393834313538326362656663643633223b733a33323a223939656634353534323930373136383634643834636564363533356264396133223b733a33323a226361623261303162386539396534633335323930396333656635323337623666223b733a33323a223261623663666634623938313135393637626533653635646365666437646164223b733a33323a223164393737626139346330356363343734623336393536666164386463643364223b733a33323a223162626330326638363535343261366663383337623262356638613466333163223b733a33323a226566636365383933353733653361333266386531333831336337613330383961223b733a33323a223935656662633165356465396431393264336663613565313532313664323639223b733a33323a223737633264666632396330396565383165326561376535303834343063373639223b733a33323a226666383433306365333031336332656463626666333330613263313039613631223b733a33323a223661633838356666316330333036393361313638336330303131313636623934223b733a33323a226563636336626331313131303538323438346266393135323735656335383535223b733a33323a223730326431613635376363346463313030653966333237326435303763306566223b733a33323a226131383464353334666232396334386538383863363332633035316663363831223b733a33323a226531313439636230316334663461633564626439356235656235636661326530223b733a33323a223732653733363937613364616262616266346434333434666436613965313631223b733a33323a226437616466633636626636333238643935376165663661326335313630373136223b733a33323a223831356434343166663366633839666135303531663333313731303431376162223b7d733a343a2268617368223b733a36353a2238313564343431666633666338396661353035316633333137313034313761622d6437616466633636626636333238643935376165663661326335313630373136223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a35333a7b733a33323a223735373061633362313065336130646563363764396530363231353237376433223b733a33323a223134336539373234646236333036306333323432616130343962633232653037223b733a33323a223261643864373361313164313037323139633931636461373038663737393136223b733a33323a223937306663666161343661346637343831623062303961343230326338373130223b733a33323a226338366464323835646232376230653062303330306439383536396664656565223b733a33323a226539613261386631653866653331383637636263386434373338356533323030223b733a33323a223839386436393135303164356561313632336665363764653664346332356461223b733a33323a223536613239383561373164356362646166616162323239343163613561383961223b733a33323a223063613930646336623431646236313164323936356165653366336236383734223b733a33323a226237336165386336306530393466363036353363343666343661393961346533223b733a33323a223736323538656466323332383864383066356565613533333564353735313362223b733a33323a223839393661646235376237323133393466653262383230386432376365366663223b733a33323a226235383439643739336130613333616532643034336264343238303166383434223b733a33323a223234373133653862393737633231373563356662383133363132363036393665223b733a33323a223164366337383638663138306639633261643538343833366639646463386334223b733a33323a226238306535633931363837323437336433633066363930646331303665316636223b733a33323a226436366633303035303239356331646535326666356530323433376561393664223b733a33323a223636386166613766316162666131323533623138656239396438623666656263223b733a33323a223662323837306637653864623831636533653832656539346339653064626236223b733a33323a223139323737316636613266653238353231636435643938336632666666333932223b733a33323a223033663637303637303364303836613163306537313334313261613239333639223b733a33323a226534663137343666393931326466396132613439373034386535636432656532223b733a33323a226161386631373662646335376430373439666636623365323734326431376165223b733a33323a223234626533396336373962376331616566373437663963393139373832323933223b733a33323a226565363536323135363538386565646563626636653336363662373038636561223b733a33323a223565323033373439313039353337313539386130366539346563346434653038223b733a33323a223961346338386666643438356539656236346234386139323566646564346530223b733a33323a226639366532393366376436376436396261373162353034323663623630386336223b733a33323a223733333239366163626562633632326261306366333766653862653036383036223b733a33323a223237613663666266666239393331356662643463363965643166633138613132223b733a33323a223636353431633461333966653865646165343733646130393734396135663563223b733a33323a223864383236663963306166353863353531316430326563396339643930653734223b733a33323a223766623536613861306164656638653339393537643730376335623830653564223b733a33323a223037383062623634323934326336633064386261363765663466663232653061223b733a33323a223161363565393230363439306463383032616436376630316132336166353463223b733a33323a223564316461373066353434396437346466616365663863393265636566373264223b733a33323a226164353633363038313231353563373331373737663132386230366464396632223b733a33323a223262333037623037306430663465356431666133613466623232316462613665223b733a33323a226234346639306233326335386334636262636333303437346432386165363864223b733a33323a223666633266303363356131626438663836653837666563383934353739393762223b733a33323a223230303866666335656161383663613732633236626338626136366438653863223b733a33323a223433363039303262623231353936373965323330333039356663626361383931223b733a33323a223263336237623362653534376434323434313431366239646465336161623130223b733a33323a226537353633653530646331363163333566343365653766396430386232653137223b733a33323a223831366332623464646236323766346264623631316231643333613237356139223b733a33323a223662633962656334393937393963386663313065316432613563666535383265223b733a33323a223237373233643232653130376466346131636531363436393165326439386332223b733a33323a223462313834336336346439346132616437346664323364646161666533363961223b733a33323a223432626661373230353433616438363766316338376363613935303730383236223b733a33323a223064386162323237616638666164336637393835396463633339653239333161223b733a33323a223035333435333661346638386634326538613232343566646435626534633431223b733a33323a223739646438633632343365643336656665373534363139363530313539346462223b733a33323a226335306633353036383537326636386635346639386663356635303265663936223b733a33323a223531323938343339653163643735633865653338616237616464643761326230223b733a33323a226330303766313038626135373939633232656437643237653334633830666364223b733a33323a223133626334656166643066303235353834313930636265313361303934393736223b733a33323a223864336265643064613438323938336637616238633830666335383562383830223b733a33323a223762363533343531316334373262633837356462353636373461353834363234223b733a33323a223135313765323963363561313833396662313530306464326131653033343762223b733a33323a223339363131373665663037616563393434626435333563373932326436313561223b733a33323a223963343637376236393538386162653862303237633166623231616238373632223b733a33323a223033373039316330353536613836353363326461636365366364653236346132223b733a33323a223338303865623031643631393532343632613261616430393930653863343331223b733a33323a226531313762626330313930393866616266343739613064336434303438623431223b733a33323a226363346439356162373834343230636665376665333530373530356330636638223b733a33323a226230613135633432623465613130383562643433346432326636383564316563223b733a33323a223166346136346263353161386135366237383766623862396532653063653464223b733a33323a223737316266353638316661353833623461346131616238323736393437633731223b733a33323a223931666532616232383262343162663061363462383363356562623537333632223b733a33323a223863623436363663353632643036303838396330303861666238636138613235223b733a33323a223862626639363663333339363334616133663734613266386564663638323032223b733a33323a223938303535376633316264333838353837306136373439646635376337636364223b733a33323a223235613863356530643334623439653730313635633736653233393235613034223b733a33323a223634313562643136373931396461353235393862363930393434393938383331223b733a33323a223865336434616436323163353266663133366232316465316237613237656662223b733a33323a223466373663656336646431363436383832633936656131333166336363613961223b733a33323a226633316530356237653238356464383163343039313266323939333333613838223b733a33323a226637643533303237623563343963623030306332316133313162323633666630223b733a33323a223866383435336231376539383835616466643162646266323436333634646566223b733a33323a226130623966643238643334393636613730653163653031626562383933383965223b733a33323a223864653261373363336538313332333939336166613832303037323738643134223b733a33323a226461623061326434373739656632376164393365626636306264343633656437223b733a33323a226236353636613833326365633038636232356537363462343036323561353937223b733a33323a226230613064626634316335363165333430383934623435643964353364373662223b733a33323a223136363639633935653431633431646435356365333838666562636236616339223b733a33323a226336633366386262633362303732356630653163383662353561653737366263223b733a33323a223365613432336662623462646232623538353734333739656564316434353963223b733a33323a223732616139656639656437393234386166623035386362643131653163613462223b733a33323a226139396163373561346564646635333466336336343463646337633933613838223b733a33323a223533383332323665386266613735303137336165396463613763386630643931223b733a33323a223730353637656632393435336435356463646662373031623339373535363164223b733a33323a226265653734393065343230626139623839363363383932653734613035333436223b733a33323a226439366431373733323038633737633337616638343865363236313330666563223b733a33323a223964343631313065363630346137643730386161333036643834306432623565223b733a33323a226364393233343462326536656234616631333038366466343964393334643162223b733a33323a226665626363636638326132303461643063333131393139343934663035346437223b733a33323a223635393162306564346366396264666334623433623965633931616137363961223b733a33323a223932383165366132393364623663353739393532333834313239323764633764223b733a33323a223830346438666430616535663765383466383362653631346339636563363065223b733a33323a226662313839643830653337366138653261333666333063383339363331303463223b733a33323a223565343462633265316265363866656135313762666265386137633837356361223b733a33323a223230316433656337353631653661303830656239343161666262333539326363223b733a33323a223266333538303934393137636461343135613463303133306336316135303239223b733a33323a223237303236663034303039386531663635313063656335393364343730616434223b733a33323a223763636236356639313330336166303664313266363631636530343563316438223b733a33323a226462356266326432373233386561323963343038323535393064373035336266223b7d733a343a2268617368223b733a36353a2264623562663264323732333865613239633430383235353930643730353362662d3763636236356639313330336166303664313266363631636530343563316438223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a3132393a7b733a33323a223362366637303165343131393231303661316464616264396437313930323964223b733a33323a226535306263636530363231616539393965316432353463383664616332376266223b733a33323a226537323364373462376462363064656463356236323163373563346263623132223b733a33323a223638373866333163656335333061383439326433626463626639373839306232223b733a33323a223636666333633135333539313534663264376164323834663464656462666432223b733a33323a223063613064636163343836663631346439633166343738323735353965663163223b733a33323a223130386562633634313738303136366239666437643834623464376161633832223b733a33323a223538623931306338633235333639323838346430376232306134653065393762223b733a33323a223365613963373131373563373363633063356438343138313833643963366630223b733a33323a226366666634646233366365326536363964663535313534663063326365303930223b733a33323a226663323661616138656632306634326139326463393164393362373333303236223b733a33323a226564343934386236303233393662353933363366663265353931306432383438223b733a33323a223437386332333034633463616335643061613437376237393734633666323138223b733a33323a223031366238383933643237666365616231663832616365353764303035373464223b733a33323a226264336636363739313233393237353034656165633831336231356234386633223b733a33323a223434336135626234646336333131616265303666666366663061383333343634223b733a33323a223238363930313837656565346332616535616265376361633364626361373639223b733a33323a223439336462306663633139626132653830333661303462373364383034303035223b733a33323a223765313037373634623239383135613733366439383636336635626137353265223b733a33323a223262663134333530346262386334343833336633616165636663363031396638223b733a33323a223532366635386662343434383862663966396534613030663437373831353261223b733a33323a226539383936613436646666623765376331656462346437643666653239303134223b733a33323a223737333561643362346335383333643838666133616138336262356263366133223b733a33323a223464366661633731663864363865643736303563656534333137353831643630223b733a33323a223637396533343331353333396162346262643763373566666535646638373838223b733a33323a223231343639326363323234383535326232633866303763336139386431623938223b733a33323a223530343735333863656630396462663731393533633364376437303931346161223b733a33323a226331313238316361643231313162343231613830363437373038613935316637223b733a33323a223762366366626463326264353232626532636138663235353334393561656439223b733a33323a223536656166373732666561366162353735376437303933636339666430333038223b733a33323a223834356663333665386132666137366236633236323435633465613336323537223b733a33323a226534626232386632313931366635366336326437633737306164386465333463223b733a33323a226631336161646436333438336131333039393133623734393438613863656663223b733a33323a226334623730313738393739613730333966383738356634333235643731393433223b733a33323a226566643266303137373932376533626438613565616238396463363531396266223b733a33323a223762643435666238326436306262313334356463613763653331653237386638223b733a33323a223935393062353739346438383331363966343032623534623234346263613534223b733a33323a226132346632313933613931353864323337663837663965663664336436653333223b733a33323a226136323630326366386431626463633032303838363666303565653931386666223b733a33323a223965636336343634333262373439383738353836636562306163653632633838223b733a33323a223237613662363739343362616636626231663332333932646131643835663563223b733a33323a226164666632653531666237383833323937613464373064343939363665613336223b733a33323a226566343830333530366464366538386438363134303839303931663661643839223b733a33323a223936343533613065656438303833623937323539323031353164613764316336223b733a33323a226139643639633661376233353633313462626465663062663138646632633564223b733a33323a223736656566386566363239663561383763643731313638613033636162386231223b733a33323a223637346533656232323638373364336539356439303339623535623437313562223b733a33323a223634653762326463643832346634636361616239633634393538363737623265223b733a33323a223231396566323532616236373737386362343433663038333364356564633438223b733a33323a223132353765373035356431383333643861386333396336346663333039303130223b733a33323a226339663939373533363733316439373266373063653936636566663666343862223b733a33323a223538663439303538366466666336323338666332326164626466363134363734223b733a33323a223933636339386336616437653431323762333864393266336131323966663837223b733a33323a223234653831636332386332633730363766333064383635333030666162346537223b733a33323a223261336461306637663063616338323766303664373736396364663538366632223b733a33323a226363333362343237383765643335343631353630336666316263383039343762223b733a33323a223461306532313730383930623662663463653164323138626131333230323136223b733a33323a226532633034356166646331623739653532633636636133633738366661323837223b733a33323a226638663361386564333735313431313735303638626235343735626635323732223b733a33323a226633656234656337303463633562343331363565656131386138363863653963223b733a33323a226665646135303565366361656262313932323638366234363463613663313861223b733a33323a226637313761386362333966623737666431373932666266653236383061346632223b733a33323a223465656636633230323566343664656538396466353733646164323262323433223b733a33323a223565396336613966323237643836643537363365366662653035623466343639223b733a33323a226666613738363035316539373239396265373463313663333130623931376331223b733a33323a226537376161666536613963633834363761653762316266376365613034306464223b733a33323a223665336436353638333366623933373131613266336461323365336461386137223b733a33323a223239363533393935353437633831396436303832336338333737626161303061223b733a33323a226136373138613863313031616266343530376563323164303138376432333738223b733a33323a223161336133633938313339616131323130373936396434383139353336376236223b733a33323a226131313161376131356464613364376134633930303264353437373138653139223b733a33323a226166666239626430316462366364333261643633373431396234633335363232223b733a33323a226138623762613364303034386138663239373765393330663738643436616361223b733a33323a223166646637346437663139376339656466376563353638663765316561313834223b733a33323a223732616264363231316239633935346262383635643438326336393062353838223b733a33323a223239633965313739326265653337323464313938643264373864323966316236223b733a33323a223839326233303463653233386463373465376461316261393838663736666230223b733a33323a223037626530326530363431643237663434393036626332643332396139636639223b733a33323a223665383465393666633535643735306363643364383835363666353937623165223b733a33323a226561613935633832616630623033633234643739353738336336373939383166223b733a33323a226564643933613765373665646531306364326432313830303531343934626437223b733a33323a223732363565373034616361633539386238616330626131336361633133383532223b733a33323a223837656161613032623536613338346133656438646163313435643061396661223b733a33323a226461383339363965386461356362623530613037313939376163613337303764223b733a33323a226662663865386664333264653630613863323162396631393334623163393639223b733a33323a223039346638306530343064313863306461396534373166616431333538373039223b733a33323a223532323336623138353636633664633764306463373330616561383964356439223b733a33323a223333353530343939653434383366336338343638613034343736653932393537223b733a33323a223930333530633261623838613362396131343239333032323836336162613631223b733a33323a223130613730366338633138363537396633386433366162346632646364303532223b733a33323a226434373236376639346237656465613736363462336466306437326134626364223b733a33323a223861373031363066353763646330386563363230343138376338656436323036223b733a33323a223437313161306437363139393735343530303165303063336662326363313234223b733a33323a223166333936613766393637663163643033346432326363366532313932363034223b733a33323a223231653365636137646163313437646665303137633833373438306264656366223b733a33323a223762373336313065346563353634653564303462343535336433373234616131223b733a33323a223234333961663439386135376637653861636338353732303132393963653131223b733a33323a223263373838396138333838313762656432393131616466653436313363333534223b733a33323a226364333431373763333034653039323132643633356464383663343035326636223b733a33323a226439646537386539303039363232313865656661386637323665326566613165223b733a33323a226663333832613765386663303131336363623530353863386439393733323931223b733a33323a223462323831666535623937633366616337623435613739343065666337656262223b733a33323a226130336134386463653665336637366630633139343731383332636134376434223b733a33323a226534393364333139363736626238633232346461616466636366306139663863223b733a33323a223433613065306466623666343738393065623464373230653835363161353039223b733a33323a223933333735633839613766666563353762303139343439316231633537666161223b733a33323a223465316539663033306534343736353635626232313965356562643964356534223b733a33323a226636326563386335343936623261356434316339366130643963346139323237223b733a33323a223366623861363632356436626164336138656233636333303035376266623332223b733a33323a226663663335646539333963656330636135656630653832613265653836373238223b733a33323a223561343362343939346261656438393734623130353230393530376435396466223b733a33323a226439396335386563323039643566643737613134393932386631663533376332223b733a33323a223963326136326666366634396566333962303366363138396536613762363134223b733a33323a223136633933633763653536373431363739663766323262383532393664343537223b733a33323a223330396336356532396231353536326438343834343139376163383831353365223b733a33323a223038653261313335363664363263373130616134353161363762303961396233223b733a33323a226134313631353534616462643030393263666539306534633838616236646632223b733a33323a223862353362666338646663366435363232326134666466353237646264326538223b733a33323a223232393337383462633866303561653765646132393339316130643637623735223b733a33323a226262653763316231343764636136613261623932666637383934386166623535223b733a33323a223632376363613164333833306264376433363830323961326164626235396634223b733a33323a223734303766353231333335613230613964616134636362343734356133353063223b733a33323a223331383566383030386234336564636136666134663263373863633332643161223b733a33323a223032313635353566346234653230363538326538656430623563343637356437223b733a33323a223530323430393238393161313338323364643437326464626466663063613230223b733a33323a223432323230663963383561356636396562303637303033396561326137333939223b733a33323a226233616565633864613465356438363263346237313864623532393334633435223b733a33323a223464303661393663393162666230653466323032313661343232663364636462223b733a33323a226132323633613139373263643130333362376331656566383330303234356563223b733a33323a223663646538333138623530643536363263653063313230366538656266623861223b733a33323a226231643435356431656431313163346634373831663438323939323065323263223b733a33323a226166303831623736643961663530663932303064643364303037653637623339223b733a33323a226432303232643035353037666534613138386335383461343363353163303734223b733a33323a223463663235376635326166656639366465626234626337356562643266643532223b733a33323a223231643533316439666365613931326663633765353034386136363063323034223b733a33323a223762313564333335353138393465376364373862346161633734613366316635223b733a33323a223930366665326336313737626165306333653631363165303933653035623665223b733a33323a223430373637306666373338373734326238613431373665653836396630383630223b733a33323a226234623731646134393035373161313235363136366165396635343161663733223b733a33323a226664653861353133376564393062366261383864363164383834343538613466223b733a33323a226332383534356438613135366633643137326639323466346565363730633533223b733a33323a223964306132316539396232386334313936663438333137636533643861383462223b733a33323a226333376165356334633466333565383331643262373233633135396561666439223b733a33323a226432396635376136653135653735636334303234653261396461333238626231223b733a33323a223764356336316130386230633833363164353139366333613535643562383834223b733a33323a226461343062333837616338343461613266316439626537363435653430303537223b733a33323a223839626636396464393634336134323638303434373830373733643737663337223b733a33323a223664663766313236316264383465333734303263653636383431363939646164223b733a33323a223939643039383066656234353137316333643537356362666666383030346264223b733a33323a223031313964343330323135386530616563656261376462373665303462383732223b733a33323a223731343436343733363265393034363036656637666438366636626432373062223b733a33323a223037366663346362613035303865393732333661313234613130353662653335223b733a33323a226462656666306463303731346635373862376537666234306134613964356438223b733a33323a226636346439313131373533363730316136333231363531623030646633336634223b733a33323a223533666262663562633466643034663839383937636630323565343130646134223b733a33323a223261376338633765306536363066663565663338656334353665353936336538223b733a33323a223565316239653534393736636463626632323965333262303366626665386361223b733a33323a223034666166663964613066633232313066356132326562376662393530626232223b733a33323a223861396133646561383434363666333033663131336430353830316335626663223b733a33323a226463306434386533323638373932343464613234323031366136363439666130223b733a33323a226135613231626133363634623037313263303165356161306364373130376265223b733a33323a226262306366303464343737303234616136303036363466343635346233353337223b733a33323a223732383332636265633761353531663432663766323339643965356436303265223b733a33323a223764343262646131646134613063626332633435643663626235653661346131223b733a33323a223165623236313636326131386333623366353165613334343433383439363438223b733a33323a226234303739633564393638313966323263396131666636313063393737356631223b733a33323a226661616236656565363439653265353039393261323965353036613161393635223b733a33323a223061313732623965356433393339393734393163316461663935663134633530223b733a33323a223365613435613231656261353037646439623765373366383436333436376230223b733a33323a226237333062326534366133613462353032356363303338613138366462316238223b733a33323a226537336534336138386563623965363563303131363165646530663531363765223b733a33323a223436643031613538656631333862323633366165313530386164376236613332223b733a33323a223230373636636464363838323637353363616363643131303239633466363531223b733a33323a223337663863343364323538383361653239346662363930623631363530636266223b733a33323a226339646239373264643835646536346230343838376537643334326230313066223b733a33323a223139316230336239313262383363656137333137663062363134326436363536223b733a33323a226339306438613735353531376235616466326333653133626339666362373563223b733a33323a226239646231623135323833656163653439653031346164333333666131316135223b733a33323a223438613463646330353735363063383331376265666232323465333431323332223b733a33323a223939373935653734353332616632643530633136313836376632336631656362223b733a33323a223034303864343663316362356665396538643363613230663061333037373565223b733a33323a226137636266633835653063343065613833396639663434623033323939363630223b733a33323a226562303565336637386331666430643764313138313535353766656538373232223b733a33323a226535383831313238663363356236373564366139353238663465386333303362223b733a33323a226261363134323661306635633539636134336666346662363436383833616631223b733a33323a226139366132383061663831376336323036643031663761623935303861623930223b733a33323a223332323833393565333136346131663537333461363536383865633463356233223b733a33323a223434343239396664626564616366393339633834306366313437303764643337223b733a33323a223230343333363863323733643461393633326637646639303738646363363163223b733a33323a226535653333643738343237666133623037323261386436646262393439306537223b733a33323a226436376231653833613335336634303230326465373138363162393264653538223b733a33323a226463306434323935336532306438313734666330383238336466333665653932223b733a33323a223161373265613563623239616134643738643430356636373862616438616361223b733a33323a223232663538396434343462396261656566373266633130623032346565336666223b733a33323a226366666236363932313735316461383235373038663765633761323733306265223b733a33323a223232346138653634663038643664396436313864623835363630613937346562223b733a33323a223364326131616132363563633539333131316464393535636134366666356463223b733a33323a223063373263393461353835313161306336393566383765663035363236343866223b733a33323a223036303563636461346633643537333539626361623239643535363233623862223b733a33323a223039383664613234613765386131343735363838323063313664643031623636223b733a33323a223835383431333339633262633036373637356632613334656532303330633164223b733a33323a226435393032656566376233666166626433393132636432663966613562663837223b733a33323a223566303962313434643739376337623031666135323330386566376630343339223b733a33323a226365313235616264636632366638313563623431336235663964613431616139223b733a33323a223235323039343164373966613434333136373162643139363135666164303831223b733a33323a223538303064646639656534633463663333643530333533383166343339633430223b733a33323a223039386161346263393465343133333562353830346264356133333661633365223b733a33323a223064366539653736373435333536666465343266303633373864623466616132223b733a33323a223432383933613563373730323166366662313530313235666461343532616435223b733a33323a223466393264663632306233653862653465373534313063323336333233353235223b733a33323a223331353539333737383331323566396235303030663633323765336339333964223b733a33323a226439333034316237363163356562396134396334633439623961353666333566223b733a33323a223133646237306330316237363765363330313339386461323331643233386165223b733a33323a226339356630333031393866363963323731343632316566666337633864363565223b733a33323a226639373231353461323537313135336461333737396432343634306233383739223b733a33323a223662653263643831333635313835346232623564663363396133656538376437223b733a33323a223666363333363465366663356635353832633162663139386338343464346265223b733a33323a226661616662383164303339313835346639613761393639363038633662613030223b733a33323a223864623934636166646539346637393761393437396534643665663065356134223b733a33323a223534623865363830363237633036613964313164363733633066373463626632223b733a33323a223135313132623238663066346161643337363834613561323262386432623735223b733a33323a226534313862616630303062313162613433383038376166613532643336623835223b733a33323a223239653761633330393066353563366434666430323935313162393331346264223b733a33323a223838313664646230323061633535316139653664663935336135316365323061223b733a33323a223135373932363837643362336166323662323135633066373537666165356430223b733a33323a223065663562613738336261626363663163666632316333373366656535663835223b733a33323a223463633130616436353530636465326139633364643337393039633662323238223b733a33323a223262623439343561343039633032663832616461316539303133323234393038223b733a33323a226533333733336639396663353735366538643365626631343864323638386166223b733a33323a223132323836633233333032363731313731663335303134326230303034633261223b733a33323a226137386434393638633835356431643839383532656136653564653362383932223b733a33323a223434343932323839306161303262373638313831383765616338646665353636223b733a33323a223966366435313935643132346237366364653737643838303733373838316662223b733a33323a226535613934326163353162333430613339383461613934393764643934363464223b733a33323a223530656564363739323333613035363331353866626464313937663434663363223b733a33323a226337653436393833316139326639353961383664373733313464303338363566223b733a33323a223862363435393466613261623337353531393937336164303562383130373036223b733a33323a226262626339363534643231633931656265356661396330613535386437346465223b733a33323a223631303866353334306538383339346531383035356363613864316163633365223b733a33323a223036623131616664383337376263333637396630373065363562386338636433223b733a33323a223038306163346234333062376465633064643164353639376131356539316435223b733a33323a226536353064333231303338396433323932323362623233616166333033663736223b733a33323a226531663936313562636365343436333566323733393661316437356130383661223b733a33323a223234666234636237623437363061656532366139333361623861373665326135223b733a33323a223031636334386436613861613366393961326162386364333933353436623165223b733a33323a223264613362636338626430373261373062633164663131363266383465383230223b733a33323a223861633665326362343063646630613066323332303934303331333162356539223b733a33323a223233363165316466363764393736343266343063303761623466386133376135223b733a33323a226130396531623836643165663933623035353466303436373564353733343037223b733a33323a223038393964316366303566656232623838323736333135613362626164653736223b733a33323a223165333238393765656464643439393434326639636665323137396333336236223b733a33323a226536333130646661663064366231343138376630333733393434663035633633223b733a33323a223537333231343035633838613363393332663065633861646435646333353633223b733a33323a223139396465303735353536623534636666373363323437306162636130376439223b733a33323a223861636562333234336162323464353064323532323139663135346430373030223b733a33323a226134343838623038363030363861323134393238303233613738313335326266223b733a33323a223566366535303339636137333634336134666238396639343236616533313664223b733a33323a223234303562386363366463343764393866383934336362326637623337343238223b7d733a343a2268617368223b733a36353a2232343035623863633664633437643938663839343363623266376233373432382d3566366535303339636137333634336134666238396639343236616533313664223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f766f636162756c617279757064617465666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a373a7b733a33323a226236623939613533626134393037396236346562373937376235343131356461223b733a33323a223265363331613934333466333337626665643966306566663938333639366263223b733a33323a226363333134383534316465356538393361366361643636323538663238623161223b733a33323a226333333537313837653232613531613631333936383965613033383031393165223b733a33323a223762373065306362353863653034663365336537383931656363323536333162223b733a33323a223030663366366134643661396438643866616134623664653435626131323133223b733a33323a223533616563333661653466313538623530666363373661396232396338303636223b733a33323a223964323632653532353265646663393963643336316533363939306661353161223b733a33323a226663306630336530356465343039383937373934666564383536666537363133223b733a33323a223065616666386164316439366131306137613737333334663632303666653664223b733a33323a226532383938336535623532623132343735393964313538363236343634393932223b733a33323a223037643135343463613364323664316436376138323935613861303031336436223b733a33323a226534356635663533383439383062626238316339353834316266316231313630223b733a33323a223332616166613630633430646135663033336633396539303537303031383538223b7d733a343a2268617368223b733a36353a2233326161666136306334306461356630333366333965393035373030313835382d6534356635663533383439383062626238316339353834316266316231313630223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1730052933);
INSERT INTO `session` (`id`, `data`, `modified`) VALUES
('nq5i203uf7vrnv16e6s7k2i8pk', 0x5f5f4c616d696e61737c613a363a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313733303032343839312e32333439373b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a226766657238736d716c6b39766d62376266637633373469326b74223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303036343434313b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313733303036373735343b7d733a35333a224c616d696e61735f56616c696461746f725f437372665f73616c745f7265736f7572636574656d706c617465666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303036363336313b7d733a34343a224c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303036373732363b7d7d72656469726563745f75726c7c733a32373a22687474703a2f2f6c6f63616c686f73743a383038302f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223564613661333961363835323431313062373933383066303562633262353836223b733a33323a226238626432646130656266333032663638343633353936373364396334643139223b7d733a343a2268617368223b733a36353a2262386264326461306562663330326636383436333539363733643963346431392d3564613661333961363835323431313062373933383066303562633262353836223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a32303a7b733a33323a223031313039646364356335336262386439626363316565663534353030366530223b733a33323a226430326231663135373261393065313635386430303463303636653931336462223b733a33323a223137663737323535333135623535643363626235303565613731363165393730223b733a33323a226137366365656233666134613866646136396564363037313330383838333736223b733a33323a226364353238313766323661303964353165633964613639383134323964383437223b733a33323a223936626535343932613162653733323933653063316635373233383339313961223b733a33323a226661653662343662373236313536623635316539346237643739376235613037223b733a33323a223935393931656137616664636237396561326364363432333131633939323733223b733a33323a223834616435636531373934336430396162666139366630626562663135333536223b733a33323a223763643937663166666335643362363561653662303837343764376537343638223b733a33323a223933323964343162346463376134633331653334666662633033656333386539223b733a33323a223237646363323531393135353534393532303335636164613938336163653065223b733a33323a223132313436633464303136373234343633393164313661653733343230653432223b733a33323a223164626161653764626430303165363933386437636638393232376431393232223b733a33323a223534646463393866633730363033316261313763323334633365656233353437223b733a33323a223431666366623262653636623033623864313361333230666631306566623232223b733a33323a223562373636613633353164353662646266623032613364313862346263663435223b733a33323a226433663933363433396436643430653835643134653039386163353031356664223b733a33323a223262313438623236363037373536643531633632366232363635343538646666223b733a33323a223735366364383864393739373338626235356431643366613835623566663134223b733a33323a223262343037346664333764323930316136323665343733343531623732393439223b733a33323a226163626562376139356133343434616434633363653434396334643036663335223b733a33323a226365336331316138303333353134323036303337623836333564663832363838223b733a33323a226437653431323633613238353362366634656136336432373231643462626461223b733a33323a226436326439323332653836626461323661363265313639666165613631376538223b733a33323a226666393831626665386438326561623738333531356562313363393463633231223b733a33323a223830353664316332363062396362346262343162313234323834383032363535223b733a33323a223761313731623233636638393565623233356463313635666638636438643364223b733a33323a226239636562353635623039366565313330336464303835613361303933383961223b733a33323a226566333135326466303366633132656332326532316230316138633838613661223b733a33323a226134376136633662306130623138343736636538396439666336663039643437223b733a33323a223666633833323638323038646164643536646433323665396539303834316466223b733a33323a223033346162313162643739393831316631613362316230383132366166306437223b733a33323a226363376237346666316334656436306530376532646265656435633934323362223b733a33323a223635396239663035396530336165333561386263643262616165613336656466223b733a33323a223466653964333938623839346339633366393064333731313432383033373265223b733a33323a226666616133643765326633303865376338353661613832623065323932353564223b733a33323a223539303135333961636536333138306564353861306639396432363032373262223b733a33323a226536623532303261383832326565353962323732623065663535343661383633223b733a33323a223633666166616364646131306263623931663938316466373837643062336438223b7d733a343a2268617368223b733a36353a2236336661666163646461313062636239316639383164663738376430623364382d6536623532303261383832326565353962323732623065663535343661383633223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f7265736f7572636574656d706c617465666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a323a7b733a33323a223037666465643034306338626137353039623362336361313261383530343839223b733a33323a223731613962626633333439613561306339336433643835376139633234656533223b733a33323a223263656231316665653666396639353833366462623434663035333333343533223b733a33323a223933313331343463363265366133663262653530636362323038626439373937223b7d733a343a2268617368223b733a36353a2239333133313434633632653661336632626535306363623230386264393739372d3263656231316665653666396639353833366462623434663035333333343533223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a32383a7b733a33323a223262396364336266666234373962346135613766323632373562613337393262223b733a33323a223662623434323337393138616639373963323335326232663933313166353664223b733a33323a223762366564393135656535386432653936376534666364646666363834323733223b733a33323a226261613463353139656237393561396532623932636437326464376435303839223b733a33323a223362656634663039613539633930633735323064393830323864663831653963223b733a33323a223131336661616631396530313531366630386633626563386633333264356163223b733a33323a223036396138656433326632616438326430373261366665326338613437653764223b733a33323a223363366136343730326433623538346136313032616264336237316564386431223b733a33323a223933386664333937346136393138663138636239396533623761613161613334223b733a33323a223934363132383962343364323162393965623433373263623566303432363438223b733a33323a223237386464316235313130313238346464623937643365623966643937303164223b733a33323a226562336530313061643731623334326564626136666631386333666133303565223b733a33323a223734396131376664343031333535363766616133396462626534656131663364223b733a33323a226230346530386232363965346633346333316261303935616265346631366364223b733a33323a226234306266303965646432376437666465316633333734316432633761303334223b733a33323a223361326637346264343464643933613063343638316166636139323333643363223b733a33323a226564633037636630363031346633303837343435316463306436666162386439223b733a33323a223735326266666536633236646634656633353165623362303966643033613635223b733a33323a223961373136373239623563373636326561366464623433323464303463326161223b733a33323a226235626431636664666566653365646366626433393764653132643035303134223b733a33323a226237653134656362323033613166333931306263633935376437643664663838223b733a33323a226165616361313631306434623938373262396633313961383135643061343334223b733a33323a223138346466323866623630643838653964626238393731396237386132646161223b733a33323a223866633438636630356337666263336130613233353639626565316163383261223b733a33323a223963363061353363313661366564343963336561626136656364646162623132223b733a33323a226238373937613838663631366131393264643730663166393938643761393365223b733a33323a226636356334663138363164346663623139643732313065326638353466373939223b733a33323a223033323265316636313063333663336363356134373365653035396132656334223b733a33323a223766383331373833376430386338333663353430643432613339636163326237223b733a33323a223139353030313361326665323765303832353461643463353261376234323935223b733a33323a223462303238303366663763616538626330303831356431396634366265363933223b733a33323a223334313634633362383034663532393863376639336435633665646234303964223b733a33323a226163313361633065396330336463396564356433396232313436323362633036223b733a33323a223032363636303131666331366664323630303431643864323832313562636364223b733a33323a223536623731386136363739346137616665646435656163636634613737643734223b733a33323a226234313035373733353638623539396163626637343562663766396432376261223b733a33323a226532326262636634346165643235383334323761393939353735333832376164223b733a33323a226462333161396136653863393536346665343830653737323565643566626236223b733a33323a226539633264613132383263313663343265396234643938613765343733383933223b733a33323a226261323565386462643433643063386363353432613339653431343532363137223b733a33323a226331396165613266653661353165373161626137653830626536336363336632223b733a33323a223033633166383065613237396265346636643638343064636631343263626434223b733a33323a223264636463323765353133393135303763386162303631636334643061326461223b733a33323a226138313163363135303938366631633931663530386462353432656264386562223b733a33323a226138313266653433313766626633346262653763636334306337623438646463223b733a33323a223932626361353834613563663139613135326533666264313931393637353033223b733a33323a223962373137623933613965306362383139376462376631383861613361373435223b733a33323a223164363264316633333234356362373630336437336231333566373430373365223b733a33323a223037356464343031373037623031373231643063613535333564303934376661223b733a33323a223536303235356132663664303138306562373435353164626434343533663933223b733a33323a223636613262663565323864373662386563373666396263396138663735393839223b733a33323a226565376333666566303966656539656366366235643432633838323963383638223b733a33323a226533626436383032653333323339326635646239353063656365343334383434223b733a33323a226433636365336330656662613636333230323466643762636337613564373361223b733a33323a226362663564333438336439653861363761313365343963663133653863623963223b733a33323a223964646362336634366565353835623537353866356439323030383266346636223b7d733a343a2268617368223b733a36353a2239646463623366343665653538356235373538663564393230303832663466362d6362663564333438336439653861363761313365343963663133653863623963223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1730024891),
('o6jd6so9u0mca5gpuscvvknt9p', 0x5f5f4c616d696e61737c613a353a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313732393933333230352e38383938363b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a226e6a32666f616c386c7632396d6c6b71646d7234643764613664223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313732393937343735323b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313732393937363032323b7d733a35333a224c616d696e61735f56616c696461746f725f437372665f73616c745f7265736f7572636574656d706c617465666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313732393937353939303b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223665616161616363383766646134363236346335376233396661353637643462223b733a33323a223263363961643138313036383638393130386466626439633963396339313962223b7d733a343a2268617368223b733a36353a2232633639616431383130363836383931303864666264396339633963393139622d3665616161616363383766646134363236346335376233396661353637643462223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d72656469726563745f75726c7c4e3b4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a393a7b733a33323a223961663232376234333131396166316462343732646631366632666438336562223b733a33323a226639623762383431643937633337333435663539363633306562653262323939223b733a33323a226635393161313862316534616631653866613838366130623732356565393133223b733a33323a223662366634316232383230653631346233613165633736643464386462353038223b733a33323a223835353832363430333938626261656431323937303061323231326364633262223b733a33323a226462613434653336346338663933373265633332383164393830383831366434223b733a33323a223836326439353365386261646331333331386436363463356565653835386364223b733a33323a223030613830336535633738356637323366363635343363366365336664386238223b733a33323a226538333538643735316135646338626662323932353063663937666530326139223b733a33323a223864303364363436623266323365616230323538386335343165323161336233223b733a33323a223666656266353832646661303630366466323736353236323062316666353436223b733a33323a226334373034333639626536383462396663303837373333633732373366623262223b733a33323a223737656663333234663961346664333137623336323730336236313364613261223b733a33323a226162303030613932303136353462356566633239613630623134646166326666223b733a33323a223436383365353335323630393063383032616365656465313266323461663334223b733a33323a226663623365353261373833373266333831343535313066626337376134653138223b733a33323a223536646438646562643838383633623531353030393630666439343636383466223b733a33323a223862376339346362336661653230643939643262323962613633306531633762223b7d733a343a2268617368223b733a36353a2238623763393463623366616532306439396432623239626136333065316337622d3536646438646562643838383633623531353030393630666439343636383466223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f7265736f7572636574656d706c617465666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223066376563646135343132373331333634666437653430303739306163623433223b733a33323a223662346565303461316264633537663639623764326535353938643836326233223b7d733a343a2268617368223b733a36353a2236623465653034613162646335376636396237643265353539386438363262332d3066376563646135343132373331333634666437653430303739306163623433223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1729933205);

-- --------------------------------------------------------

--
-- Structure de la table `setting`
--

CREATE TABLE `setting` (
  `id` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `setting`
--

INSERT INTO `setting` (`id`, `value`) VALUES
('administrator_email', '\"a.hef2000@gmail.com\"'),
('extension_whitelist', '[\"aac\",\"aif\",\"aiff\",\"asf\",\"asx\",\"avi\",\"bmp\",\"c\",\"cc\",\"class\",\"css\",\"divx\",\"doc\",\"docx\",\"exe\",\"gif\",\"gz\",\"gzip\",\"h\",\"ico\",\"j2k\",\"jp2\",\"jpe\",\"jpeg\",\"jpg\",\"m4a\",\"m4v\",\"mdb\",\"mid\",\"midi\",\"mov\",\"mp2\",\"mp3\",\"mp4\",\"mpa\",\"mpe\",\"mpeg\",\"mpg\",\"mpp\",\"odb\",\"odc\",\"odf\",\"odg\",\"odp\",\"ods\",\"odt\",\"ogg\",\"opus\",\"pdf\",\"png\",\"pot\",\"pps\",\"ppt\",\"pptx\",\"qt\",\"ra\",\"ram\",\"rtf\",\"rtx\",\"swf\",\"tar\",\"tif\",\"tiff\",\"txt\",\"wav\",\"wax\",\"webm\",\"webp\",\"wma\",\"wmv\",\"wmx\",\"wri\",\"xla\",\"xls\",\"xlsx\",\"xlt\",\"xlw\",\"zip\"]'),
('installation_title', '\"omeka_s Anas\"'),
('locale', '\"\"'),
('media_type_whitelist', '[\"application\\/msword\",\"application\\/ogg\",\"application\\/pdf\",\"application\\/rtf\",\"application\\/vnd.ms-access\",\"application\\/vnd.ms-excel\",\"application\\/vnd.ms-powerpoint\",\"application\\/vnd.ms-project\",\"application\\/vnd.ms-write\",\"application\\/vnd.oasis.opendocument.chart\",\"application\\/vnd.oasis.opendocument.database\",\"application\\/vnd.oasis.opendocument.formula\",\"application\\/vnd.oasis.opendocument.graphics\",\"application\\/vnd.oasis.opendocument.presentation\",\"application\\/vnd.oasis.opendocument.spreadsheet\",\"application\\/vnd.oasis.opendocument.text\",\"application\\/vnd.openxmlformats-officedocument.wordprocessingml.document\",\"application\\/vnd.openxmlformats-officedocument.presentationml.presentation\",\"application\\/vnd.openxmlformats-officedocument.spreadsheetml.sheet\",\"application\\/x-gzip\",\"application\\/x-ms-wmp\",\"application\\/x-msdownload\",\"application\\/x-shockwave-flash\",\"application\\/x-tar\",\"application\\/zip\",\"audio\\/midi\",\"audio\\/mp4\",\"audio\\/mpeg\",\"audio\\/ogg\",\"audio\\/x-aac\",\"audio\\/x-aiff\",\"audio\\/x-ms-wma\",\"audio\\/x-ms-wax\",\"audio\\/x-realaudio\",\"audio\\/x-wav\",\"image\\/bmp\",\"image\\/gif\",\"image\\/jp2\",\"image\\/jpeg\",\"image\\/pjpeg\",\"image\\/png\",\"image\\/tiff\",\"image\\/webp\",\"image\\/x-icon\",\"text\\/css\",\"text\\/plain\",\"text\\/richtext\",\"video\\/divx\",\"video\\/mp4\",\"video\\/mpeg\",\"video\\/ogg\",\"video\\/quicktime\",\"video\\/webm\",\"video\\/x-ms-asf,\",\"video\\/x-msvideo\",\"video\\/x-ms-wmv\"]'),
('pagination_per_page', '25'),
('time_zone', '\"UTC\"'),
('use_htmlpurifier', '\"1\"'),
('version', '\"4.1.1\"'),
('version_notifications', '\"1\"');

-- --------------------------------------------------------

--
-- Structure de la table `site`
--

CREATE TABLE `site` (
  `id` int NOT NULL,
  `thumbnail_id` int DEFAULT NULL,
  `homepage_id` int DEFAULT NULL,
  `owner_id` int DEFAULT NULL,
  `slug` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `theme` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `summary` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `navigation` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)',
  `item_pool` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)',
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL,
  `assign_new_items` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `site_block_attachment`
--

CREATE TABLE `site_block_attachment` (
  `id` int NOT NULL,
  `block_id` int NOT NULL,
  `item_id` int DEFAULT NULL,
  `media_id` int DEFAULT NULL,
  `caption` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `site_item_set`
--

CREATE TABLE `site_item_set` (
  `id` int NOT NULL,
  `site_id` int NOT NULL,
  `item_set_id` int NOT NULL,
  `position` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `site_page`
--

CREATE TABLE `site_page` (
  `id` int NOT NULL,
  `site_id` int NOT NULL,
  `slug` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_public` tinyint(1) NOT NULL,
  `layout` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `layout_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json)',
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `site_page_block`
--

CREATE TABLE `site_page_block` (
  `id` int NOT NULL,
  `page_id` int NOT NULL,
  `layout` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)',
  `layout_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json)',
  `position` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `site_permission`
--

CREATE TABLE `site_permission` (
  `id` int NOT NULL,
  `site_id` int NOT NULL,
  `user_id` int NOT NULL,
  `role` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `site_setting`
--

CREATE TABLE `site_setting` (
  `id` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `site_id` int NOT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `id` int NOT NULL,
  `email` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  `password_hash` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `email`, `name`, `created`, `modified`, `password_hash`, `role`, `is_active`) VALUES
(1, 'a.hef2000@gmail.com', 'omeka_user', '2024-10-26 08:32:31', '2024-10-26 08:32:32', '$2y$10$qOvG/QwpwRqeCSeJjtyKB.8U6lgzYsyzWVCNt.NEUBtFfLTamKgaW', 'global_admin', 1);

-- --------------------------------------------------------

--
-- Structure de la table `user_setting`
--

CREATE TABLE `user_setting` (
  `id` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int NOT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `user_setting`
--

INSERT INTO `user_setting` (`id`, `user_id`, `value`) VALUES
('csv_import_automap_check_names_alone', 1, 'false'),
('csv_import_delimiter', 1, '\",\"'),
('csv_import_enclosure', 1, '\"\\\"\"'),
('csv_import_global_language', 1, '\"\"'),
('csv_import_identifier_property', 1, '\"\"'),
('csv_import_multivalue_separator', 1, '\",\"'),
('csv_import_rows_by_batch', 1, '20');

-- --------------------------------------------------------

--
-- Structure de la table `value`
--

CREATE TABLE `value` (
  `id` int NOT NULL,
  `resource_id` int NOT NULL,
  `property_id` int NOT NULL,
  `value_resource_id` int DEFAULT NULL,
  `value_annotation_id` int DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `lang` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `uri` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `is_public` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `value`
--

INSERT INTO `value` (`id`, `resource_id`, `property_id`, `value_resource_id`, `value_annotation_id`, `type`, `lang`, `value`, `uri`, `is_public`) VALUES
(1, 1, 7, NULL, NULL, 'literal', NULL, '10/10/2024 10:12:37', NULL, 1),
(2, 1, 125, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(3, 1, 183, NULL, NULL, 'literal', NULL, '24', NULL, 1),
(4, 1, 123, NULL, NULL, 'literal', NULL, 'a.hef2000@gmail.Com', NULL, 1),
(5, 2, 7, NULL, NULL, 'literal', NULL, '10/10/2024 10:13:00', NULL, 1),
(6, 2, 125, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(7, 2, 183, NULL, NULL, 'literal', NULL, '24', NULL, 1),
(8, 2, 123, NULL, NULL, 'literal', NULL, 'anas.hefied7@gmail.com', NULL, 1),
(9, 3, 7, NULL, NULL, 'literal', NULL, '12/10/2024 15:39:55', NULL, 1),
(10, 3, 125, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(11, 3, 183, NULL, NULL, 'literal', NULL, '28', NULL, 1),
(12, 3, 123, NULL, NULL, 'literal', NULL, 'massidireddy@gmail.com', NULL, 1),
(13, 4, 7, NULL, NULL, 'literal', NULL, '13/10/2024 02:00:54', NULL, 1),
(14, 4, 125, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(15, 4, 183, NULL, NULL, 'literal', NULL, '25', NULL, 1),
(16, 4, 123, NULL, NULL, 'literal', NULL, 'ouksili.samy@yahoo.com', NULL, 1),
(17, 5, 7, NULL, NULL, 'literal', NULL, '13/10/2024 15:43:10', NULL, 1),
(18, 5, 125, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(19, 5, 183, NULL, NULL, 'literal', NULL, '22', NULL, 1),
(20, 5, 123, NULL, NULL, 'literal', NULL, 'Amjahidmohamedamin@gmail.com', NULL, 1),
(21, 6, 7, NULL, NULL, 'literal', NULL, '10/10/2024 10:12:37', NULL, 1),
(22, 6, 125, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(23, 6, 183, NULL, NULL, 'literal', NULL, '24', NULL, 1),
(24, 6, 123, NULL, NULL, 'literal', NULL, 'a.hef2000@gmail.Com', NULL, 1),
(25, 7, 7, NULL, NULL, 'literal', NULL, '10/10/2024 10:13:00', NULL, 1),
(26, 7, 125, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(27, 7, 183, NULL, NULL, 'literal', NULL, '24', NULL, 1),
(28, 7, 123, NULL, NULL, 'literal', NULL, 'anas.hefied7@gmail.com', NULL, 1),
(29, 8, 7, NULL, NULL, 'literal', NULL, '12/10/2024 15:39:55', NULL, 1),
(30, 8, 125, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(31, 8, 183, NULL, NULL, 'literal', NULL, '28', NULL, 1),
(32, 8, 123, NULL, NULL, 'literal', NULL, 'massidireddy@gmail.com', NULL, 1),
(33, 9, 7, NULL, NULL, 'literal', NULL, '13/10/2024 02:00:54', NULL, 1),
(34, 9, 125, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(35, 9, 183, NULL, NULL, 'literal', NULL, '25', NULL, 1),
(36, 9, 123, NULL, NULL, 'literal', NULL, 'ouksili.samy@yahoo.com', NULL, 1),
(37, 10, 7, NULL, NULL, 'literal', NULL, '13/10/2024 15:43:10', NULL, 1),
(38, 10, 125, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(39, 10, 183, NULL, NULL, 'literal', NULL, '22', NULL, 1),
(40, 10, 123, NULL, NULL, 'literal', NULL, 'Amjahidmohamedamin@gmail.com', NULL, 1),
(41, 11, 7, NULL, NULL, 'literal', NULL, '13/10/2024 16:18:09', NULL, 1),
(42, 11, 125, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(43, 11, 183, NULL, NULL, 'literal', NULL, '24', NULL, 1),
(44, 11, 123, NULL, NULL, 'literal', NULL, 'ahmed45jab@gmail.com', NULL, 1),
(45, 12, 7, NULL, NULL, 'literal', NULL, '13/10/2024 16:21:05', NULL, 1),
(46, 12, 125, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(47, 12, 183, NULL, NULL, 'literal', NULL, '26', NULL, 1),
(48, 12, 123, NULL, NULL, 'literal', NULL, 'mokraniislam998@gmail.com', NULL, 1),
(49, 13, 7, NULL, NULL, 'literal', NULL, '13/10/2024 20:44:09', NULL, 1),
(50, 13, 125, NULL, NULL, 'literal', NULL, 'Femme', NULL, 1),
(51, 13, 183, NULL, NULL, 'literal', NULL, '28', NULL, 1),
(52, 13, 123, NULL, NULL, 'literal', NULL, 'melissaorb02@gmail.com', NULL, 1),
(53, 14, 7, NULL, NULL, 'literal', NULL, '13/10/2024 21:01:48', NULL, 1),
(54, 14, 125, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(55, 14, 183, NULL, NULL, 'literal', NULL, '24', NULL, 1),
(56, 14, 123, NULL, NULL, 'literal', NULL, 'nathan.benais@gmail.com', NULL, 1),
(57, 15, 7, NULL, NULL, 'literal', NULL, '13/10/2024 22:32:03', NULL, 1),
(58, 15, 125, NULL, NULL, 'literal', NULL, 'Femme', NULL, 1),
(59, 15, 183, NULL, NULL, 'literal', NULL, '23', NULL, 1),
(60, 15, 123, NULL, NULL, 'literal', NULL, 'moussaoui.rania755@gmail.com', NULL, 1),
(61, 16, 7, NULL, NULL, 'literal', NULL, '14/10/2024 08:17:06', NULL, 1),
(62, 16, 125, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(63, 16, 183, NULL, NULL, 'literal', NULL, '24', NULL, 1),
(64, 16, 123, NULL, NULL, 'literal', NULL, 'noureddineaitkhouya@gmail.com', NULL, 1),
(65, 17, 7, NULL, NULL, 'literal', NULL, '14/10/2024 08:37:56', NULL, 1),
(66, 17, 125, NULL, NULL, 'literal', NULL, 'Femme', NULL, 1),
(67, 17, 183, NULL, NULL, 'literal', NULL, '23', NULL, 1),
(68, 17, 123, NULL, NULL, 'literal', NULL, 'oumaimaelfazazi01@gmail.com', NULL, 1),
(69, 18, 7, NULL, NULL, 'literal', NULL, '14/10/2024 09:23:18', NULL, 1),
(70, 18, 125, NULL, NULL, 'literal', NULL, 'Femme', NULL, 1),
(71, 18, 183, NULL, NULL, 'literal', NULL, '23', NULL, 1),
(72, 18, 123, NULL, NULL, 'literal', NULL, 'yasmine.guemat97@gmail.com', NULL, 1),
(73, 19, 7, NULL, NULL, 'literal', NULL, '10/10/2024 10:12:37', NULL, 1),
(74, 19, 125, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(75, 19, 183, NULL, NULL, 'literal', NULL, '24', NULL, 1),
(76, 19, 123, NULL, NULL, 'literal', NULL, 'a.hef2000@gmail.Com', NULL, 1),
(77, 20, 7, NULL, NULL, 'literal', NULL, '10/10/2024 10:13:00', NULL, 1),
(78, 20, 125, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(79, 20, 183, NULL, NULL, 'literal', NULL, '24', NULL, 1),
(80, 20, 123, NULL, NULL, 'literal', NULL, 'anas.hefied7@gmail.com', NULL, 1),
(81, 21, 7, NULL, NULL, 'literal', NULL, '12/10/2024 15:39:55', NULL, 1),
(82, 21, 125, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(83, 21, 183, NULL, NULL, 'literal', NULL, '28', NULL, 1),
(84, 21, 123, NULL, NULL, 'literal', NULL, 'massidireddy@gmail.com', NULL, 1),
(85, 22, 7, NULL, NULL, 'literal', NULL, '13/10/2024 02:00:54', NULL, 1),
(86, 22, 125, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(87, 22, 183, NULL, NULL, 'literal', NULL, '25', NULL, 1),
(88, 22, 123, NULL, NULL, 'literal', NULL, 'ouksili.samy@yahoo.com', NULL, 1),
(89, 23, 7, NULL, NULL, 'literal', NULL, '13/10/2024 15:43:10', NULL, 1),
(90, 23, 125, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(91, 23, 183, NULL, NULL, 'literal', NULL, '22', NULL, 1),
(92, 23, 123, NULL, NULL, 'literal', NULL, 'Amjahidmohamedamin@gmail.com', NULL, 1),
(93, 24, 7, NULL, NULL, 'literal', NULL, '13/10/2024 16:18:09', NULL, 1),
(94, 24, 125, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(95, 24, 183, NULL, NULL, 'literal', NULL, '24', NULL, 1),
(96, 24, 123, NULL, NULL, 'literal', NULL, 'ahmed45jab@gmail.com', NULL, 1),
(97, 25, 7, NULL, NULL, 'literal', NULL, '13/10/2024 16:21:05', NULL, 1),
(98, 25, 125, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(99, 25, 183, NULL, NULL, 'literal', NULL, '26', NULL, 1),
(100, 25, 123, NULL, NULL, 'literal', NULL, 'mokraniislam998@gmail.com', NULL, 1),
(101, 26, 7, NULL, NULL, 'literal', NULL, '13/10/2024 20:44:09', NULL, 1),
(102, 26, 125, NULL, NULL, 'literal', NULL, 'Femme', NULL, 1),
(103, 26, 183, NULL, NULL, 'literal', NULL, '28', NULL, 1),
(104, 26, 123, NULL, NULL, 'literal', NULL, 'melissaorb02@gmail.com', NULL, 1),
(105, 27, 7, NULL, NULL, 'literal', NULL, '13/10/2024 21:01:48', NULL, 1),
(106, 27, 125, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(107, 27, 183, NULL, NULL, 'literal', NULL, '24', NULL, 1),
(108, 27, 123, NULL, NULL, 'literal', NULL, 'nathan.benais@gmail.com', NULL, 1),
(109, 28, 7, NULL, NULL, 'literal', NULL, '13/10/2024 22:32:03', NULL, 1),
(110, 28, 125, NULL, NULL, 'literal', NULL, 'Femme', NULL, 1),
(111, 28, 183, NULL, NULL, 'literal', NULL, '23', NULL, 1),
(112, 28, 123, NULL, NULL, 'literal', NULL, 'moussaoui.rania755@gmail.com', NULL, 1),
(113, 29, 7, NULL, NULL, 'literal', NULL, '14/10/2024 08:17:06', NULL, 1),
(114, 29, 125, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(115, 29, 183, NULL, NULL, 'literal', NULL, '24', NULL, 1),
(116, 29, 123, NULL, NULL, 'literal', NULL, 'noureddineaitkhouya@gmail.com', NULL, 1),
(117, 30, 7, NULL, NULL, 'literal', NULL, '14/10/2024 08:37:56', NULL, 1),
(118, 30, 125, NULL, NULL, 'literal', NULL, 'Femme', NULL, 1),
(119, 30, 183, NULL, NULL, 'literal', NULL, '23', NULL, 1),
(120, 30, 123, NULL, NULL, 'literal', NULL, 'oumaimaelfazazi01@gmail.com', NULL, 1),
(148, 35, 1, NULL, NULL, 'literal', '', 'Patient4', NULL, 1),
(150, 35, 185, NULL, NULL, 'literal', '', '13/10/2024 16:18:09', NULL, 1),
(151, 35, 191, NULL, NULL, 'literal', '', 'ahmed45jab@gmail.com', NULL, 1),
(153, 35, 187, NULL, NULL, 'literal', '', '24', NULL, 1),
(154, 35, 186, NULL, NULL, 'literal', '', 'Homme', NULL, 1),
(156, 35, 188, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(157, 35, 189, NULL, NULL, 'literal', '', 'le Sport', NULL, 1),
(158, 35, 190, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(159, 36, 1, NULL, NULL, 'literal', '', 'Patient5', NULL, 1),
(161, 36, 185, NULL, NULL, 'literal', '', '28/10/2024 12:00:00', NULL, 1),
(162, 36, 191, NULL, NULL, 'literal', '', ' a.hef1961@gmail.com', NULL, 1),
(164, 36, 187, NULL, NULL, 'literal', '', '60', NULL, 1),
(165, 36, 186, NULL, NULL, 'literal', '', 'Femme', NULL, 1),
(166, 36, 188, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(167, 36, 189, NULL, NULL, 'literal', '', 'aucun de ces options', NULL, 1),
(168, 36, 190, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(169, 37, 185, NULL, NULL, 'literal', NULL, '10/10/2024 10:12:37', NULL, 1),
(170, 37, 186, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(171, 37, 187, NULL, NULL, 'literal', NULL, '24', NULL, 1),
(172, 37, 188, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(173, 37, 189, NULL, NULL, 'literal', NULL, 'les deux', NULL, 1),
(174, 37, 190, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(175, 37, 191, NULL, NULL, 'literal', NULL, 'a.hef2000@gmail.Com', NULL, 1),
(176, 38, 185, NULL, NULL, 'literal', NULL, '10/10/2024 10:13:00', NULL, 1),
(177, 38, 186, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(178, 38, 187, NULL, NULL, 'literal', NULL, '24', NULL, 1),
(179, 38, 188, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(180, 38, 189, NULL, NULL, 'literal', NULL, 'le régime', NULL, 1),
(181, 38, 190, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(182, 38, 191, NULL, NULL, 'literal', NULL, 'anas.hefied7@gmail.com', NULL, 1),
(183, 39, 185, NULL, NULL, 'literal', NULL, '12/10/2024 15:39:55', NULL, 1),
(184, 39, 186, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(185, 39, 187, NULL, NULL, 'literal', NULL, '28', NULL, 1),
(186, 39, 188, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(187, 39, 189, NULL, NULL, 'literal', NULL, 'le sport', NULL, 1),
(188, 39, 190, NULL, NULL, 'literal', NULL, 'Oui', NULL, 1),
(189, 39, 191, NULL, NULL, 'literal', NULL, 'massidireddy@gmail.com', NULL, 1),
(190, 40, 185, NULL, NULL, 'literal', NULL, '13/10/2024 02:00:54', NULL, 1),
(191, 40, 186, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(192, 40, 187, NULL, NULL, 'literal', NULL, '25', NULL, 1),
(193, 40, 188, NULL, NULL, 'literal', NULL, 'Oui', NULL, 1),
(194, 40, 189, NULL, NULL, 'literal', NULL, 'les deux', NULL, 1),
(195, 40, 190, NULL, NULL, 'literal', NULL, 'Oui', NULL, 1),
(196, 40, 191, NULL, NULL, 'literal', NULL, 'ouksili.samy@yahoo.com', NULL, 1),
(197, 41, 185, NULL, NULL, 'literal', NULL, '13/10/2024 15:43:10', NULL, 1),
(198, 41, 186, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(199, 41, 187, NULL, NULL, 'literal', NULL, '22', NULL, 1),
(200, 41, 188, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(201, 41, 189, NULL, NULL, 'literal', NULL, 'les deux', NULL, 1),
(202, 41, 190, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(203, 41, 191, NULL, NULL, 'literal', NULL, 'Amjahidmohamedamin@gmail.com', NULL, 1),
(204, 42, 185, NULL, NULL, 'literal', NULL, '13/10/2024 16:18:09', NULL, 1),
(205, 42, 186, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(206, 42, 187, NULL, NULL, 'literal', NULL, '24', NULL, 1),
(207, 42, 188, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(208, 42, 189, NULL, NULL, 'literal', NULL, 'le sport', NULL, 1),
(209, 42, 190, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(210, 42, 191, NULL, NULL, 'literal', NULL, 'ahmed45jab@gmail.com', NULL, 1),
(211, 43, 185, NULL, NULL, 'literal', NULL, '13/10/2024 16:21:05', NULL, 1),
(212, 43, 186, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(213, 43, 187, NULL, NULL, 'literal', NULL, '26', NULL, 1),
(214, 43, 188, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(215, 43, 189, NULL, NULL, 'literal', NULL, 'le sport', NULL, 1),
(216, 43, 190, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(217, 43, 191, NULL, NULL, 'literal', NULL, 'mokraniislam998@gmail.com', NULL, 1),
(218, 44, 185, NULL, NULL, 'literal', NULL, '13/10/2024 20:44:09', NULL, 1),
(219, 44, 186, NULL, NULL, 'literal', NULL, 'Femme', NULL, 1),
(220, 44, 187, NULL, NULL, 'literal', NULL, '28', NULL, 1),
(221, 44, 188, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(222, 44, 189, NULL, NULL, 'literal', NULL, 'le régime', NULL, 1),
(223, 44, 190, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(224, 44, 191, NULL, NULL, 'literal', NULL, 'melissaorb02@gmail.com', NULL, 1),
(225, 45, 185, NULL, NULL, 'literal', NULL, '13/10/2024 21:01:48', NULL, 1),
(226, 45, 186, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(227, 45, 187, NULL, NULL, 'literal', NULL, '24', NULL, 1),
(228, 45, 188, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(229, 45, 189, NULL, NULL, 'literal', NULL, 'le sport', NULL, 1),
(230, 45, 190, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(231, 45, 191, NULL, NULL, 'literal', NULL, 'nathan.benais@gmail.com', NULL, 1),
(232, 46, 185, NULL, NULL, 'literal', NULL, '13/10/2024 22:32:03', NULL, 1),
(233, 46, 186, NULL, NULL, 'literal', NULL, 'Femme', NULL, 1),
(234, 46, 187, NULL, NULL, 'literal', NULL, '23', NULL, 1),
(235, 46, 188, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(236, 46, 189, NULL, NULL, 'literal', NULL, 'le sport', NULL, 1),
(237, 46, 190, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(238, 46, 191, NULL, NULL, 'literal', NULL, 'moussaoui.rania755@gmail.com', NULL, 1),
(239, 47, 185, NULL, NULL, 'literal', NULL, '14/10/2024 08:17:06', NULL, 1),
(240, 47, 186, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(241, 47, 187, NULL, NULL, 'literal', NULL, '24', NULL, 1),
(242, 47, 188, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(243, 47, 189, NULL, NULL, 'literal', NULL, 'les deux', NULL, 1),
(244, 47, 190, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(245, 47, 191, NULL, NULL, 'literal', NULL, 'noureddineaitkhouya@gmail.com', NULL, 1),
(246, 48, 185, NULL, NULL, 'literal', NULL, '14/10/2024 08:37:56', NULL, 1),
(247, 48, 186, NULL, NULL, 'literal', NULL, 'Femme', NULL, 1),
(248, 48, 187, NULL, NULL, 'literal', NULL, '23', NULL, 1),
(249, 48, 188, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(250, 48, 189, NULL, NULL, 'literal', NULL, 'les deux', NULL, 1),
(251, 48, 190, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(252, 48, 191, NULL, NULL, 'literal', NULL, 'oumaimaelfazazi01@gmail.com', NULL, 1),
(253, 49, 185, NULL, NULL, 'literal', NULL, '14/10/2024 09:23:18', NULL, 1),
(254, 49, 186, NULL, NULL, 'literal', NULL, 'Femme', NULL, 1),
(255, 49, 187, NULL, NULL, 'literal', NULL, '23', NULL, 1),
(256, 49, 188, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(257, 49, 189, NULL, NULL, 'literal', NULL, 'le sport', NULL, 1),
(258, 49, 190, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(259, 49, 191, NULL, NULL, 'literal', NULL, 'yasmine.guemat97@gmail.com', NULL, 1),
(260, 50, 1, NULL, NULL, 'literal', '', 'Rdv', NULL, 1),
(261, 50, 257, NULL, NULL, 'literal', '', '30/10/2024', NULL, 1),
(262, 50, 258, NULL, NULL, 'literal', '', '0666666666', NULL, 1),
(263, 50, 259, NULL, NULL, 'literal', '', '1', NULL, 1),
(264, 51, 1, NULL, NULL, 'literal', '', 'Admin', NULL, 1),
(265, 51, 261, NULL, NULL, 'literal', '', 'Anas', NULL, 1),
(266, 51, 253, NULL, NULL, 'literal', '', 'a.hef2000@gmail.com', NULL, 1),
(267, 51, 264, NULL, NULL, 'literal', '', '0612345678', NULL, 1),
(268, 52, 1, NULL, NULL, 'literal', '', 'Patient', NULL, 1),
(269, 52, 185, NULL, NULL, 'literal', '', '15/11/2024', NULL, 1),
(270, 52, 248, NULL, NULL, 'literal', '', 'Homme', NULL, 1),
(271, 52, 249, NULL, NULL, 'literal', '', '24', NULL, 1),
(272, 52, 250, NULL, NULL, 'literal', '', 'non', NULL, 1),
(273, 52, 252, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(274, 52, 251, NULL, NULL, 'literal', '', 'aucun de ces options', NULL, 1),
(275, 52, 253, NULL, NULL, 'literal', '', 'a.hef1960@gmail.com', NULL, 1),
(276, 52, 257, NULL, NULL, 'literal', '', '18/11/2024', NULL, 1),
(277, 52, 261, NULL, NULL, 'literal', '', 'Ali', NULL, 1),
(278, 52, 258, NULL, NULL, 'literal', '', '0666666666', NULL, 1),
(279, 53, 1, NULL, NULL, 'literal', '', 'Médecin', NULL, 1),
(280, 53, 261, NULL, NULL, 'literal', '', 'Hasan Tazi', NULL, 1),
(281, 53, 253, NULL, NULL, 'literal', '', 'hasan.tazi@gmail.com', NULL, 1),
(282, 53, 265, NULL, NULL, 'literal', '', 'ORL', NULL, 1),
(283, 53, 264, NULL, NULL, 'literal', '', '0612345678', NULL, 1),
(284, 52, 263, NULL, NULL, 'literal', '', 'Patient', NULL, 1),
(285, 52, 260, NULL, NULL, 'literal', '', '100039935076726', NULL, 1),
(286, 54, 1, NULL, NULL, 'literal', '', 'User', NULL, 1),
(287, 54, 253, NULL, NULL, 'literal', '', 'hasan.tazi@gmail.com', NULL, 1),
(288, 54, 261, NULL, NULL, 'literal', '', 'Hasan tazi', NULL, 1),
(289, 54, 262, NULL, NULL, 'literal', '', 'A12345', NULL, 1),
(290, 54, 263, NULL, NULL, 'literal', '', 'Médecin', NULL, 1),
(291, 54, 265, NULL, NULL, 'literal', '', 'ORL', NULL, 1),
(292, 54, 264, NULL, NULL, 'literal', '', '0612345678', NULL, 1),
(293, 55, 1, NULL, NULL, 'literal', '', 'cabinet', NULL, 1),
(294, 55, 254, NULL, NULL, 'literal', '', 'Cabinet chez Dr Hasan tazi', NULL, 1),
(295, 55, 255, NULL, NULL, 'literal', '', 'A19 street 5', NULL, 1),
(296, 55, 256, NULL, NULL, 'literal', '', 'ORL', NULL, 1),
(297, 54, 266, NULL, NULL, 'literal', '', 'Cabinet chez Dr hasan tazi', NULL, 1),
(298, 53, 266, NULL, NULL, 'literal', '', 'Cabinet chez hasan tazi', NULL, 1),
(299, 52, 262, NULL, NULL, 'literal', '', 'A123', NULL, 1),
(300, 51, 263, NULL, NULL, 'literal', '', 'Admin', NULL, 1),
(301, 50, 260, NULL, NULL, 'literal', '', '100039935076726', NULL, 1),
(302, 56, 1, NULL, NULL, 'literal', '', 'User2', NULL, 1),
(303, 56, 253, NULL, NULL, 'literal', '', 'a.hef147@gmail.com', NULL, 1),
(304, 56, 253, 54, NULL, 'resource', NULL, NULL, NULL, 1),
(305, 56, 261, NULL, NULL, 'literal', '', 'Ali2', NULL, 1),
(306, 56, 261, 54, NULL, 'resource', NULL, NULL, NULL, 1),
(307, 56, 262, NULL, NULL, 'literal', '', 'Ali123456', NULL, 1),
(308, 56, 263, NULL, NULL, 'literal', '', 'Patient', NULL, 1),
(309, 57, 1, NULL, NULL, 'literal', '', 'User3', NULL, 1),
(310, 57, 1, 53, NULL, 'resource', NULL, NULL, NULL, 1),
(311, 57, 253, NULL, NULL, 'literal', '', 'driss-raiss@gmail.com', NULL, 1),
(312, 57, 253, 53, NULL, 'resource', NULL, NULL, NULL, 1),
(313, 57, 261, NULL, NULL, 'literal', '', 'driss raiss', NULL, 1),
(314, 57, 261, 53, NULL, 'resource', NULL, NULL, NULL, 1),
(315, 57, 262, NULL, NULL, 'literal', '', 'driss123', NULL, 1),
(316, 57, 263, NULL, NULL, 'literal', '', 'Médecin', NULL, 1),
(317, 57, 263, 54, NULL, 'resource', NULL, NULL, NULL, 1),
(318, 58, 247, NULL, NULL, 'literal', NULL, '10/10/2024 10:12:37', NULL, 1),
(319, 58, 248, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(320, 58, 249, NULL, NULL, 'literal', NULL, '24', NULL, 1),
(321, 58, 250, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(322, 58, 251, NULL, NULL, 'literal', NULL, 'les deux', NULL, 1),
(323, 58, 252, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(324, 58, 253, NULL, NULL, 'literal', NULL, 'a.hef2000@gmail.Com', NULL, 1),
(325, 59, 1, NULL, NULL, 'literal', '', 'user25', NULL, 1),
(326, 59, 248, NULL, NULL, 'literal', '', 'Homme', NULL, 1),
(327, 59, 249, NULL, NULL, 'literal', '', '24', NULL, 1),
(328, 59, 250, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(329, 59, 252, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(330, 59, 251, NULL, NULL, 'literal', '', 'le régime', NULL, 1),
(331, 59, 253, NULL, NULL, 'literal', '', 'anas.hefied7@gmail.com', NULL, 1),
(332, 60, 1, NULL, NULL, 'literal', '', 'user24', NULL, 1),
(333, 60, 248, NULL, NULL, 'literal', '', 'Homme', NULL, 1),
(334, 60, 249, NULL, NULL, 'literal', '', '28', NULL, 1),
(335, 60, 250, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(336, 60, 252, NULL, NULL, 'literal', '', 'Oui', NULL, 1),
(337, 60, 251, NULL, NULL, 'literal', '', 'le sport', NULL, 1),
(338, 60, 253, NULL, NULL, 'literal', '', 'massidireddy@gmail.com', NULL, 1),
(339, 61, 1, NULL, NULL, 'literal', '', 'user23', NULL, 1),
(340, 61, 248, NULL, NULL, 'literal', '', 'Homme', NULL, 1),
(341, 61, 249, NULL, NULL, 'literal', '', '25', NULL, 1),
(342, 61, 250, NULL, NULL, 'literal', '', 'Oui', NULL, 1),
(343, 61, 252, NULL, NULL, 'literal', '', 'Oui', NULL, 1),
(344, 61, 251, NULL, NULL, 'literal', '', 'les deux', NULL, 1),
(345, 61, 253, NULL, NULL, 'literal', '', 'ouksili.samy@yahoo.com', NULL, 1),
(346, 62, 1, NULL, NULL, 'literal', '', 'user22', NULL, 1),
(347, 62, 248, NULL, NULL, 'literal', '', 'Homme', NULL, 1),
(348, 62, 249, NULL, NULL, 'literal', '', '22', NULL, 1),
(349, 62, 250, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(350, 62, 252, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(351, 62, 251, NULL, NULL, 'literal', '', 'les deux', NULL, 1),
(352, 62, 253, NULL, NULL, 'literal', '', 'Amjahidmohamedamin@gmail.com', NULL, 1),
(353, 63, 1, NULL, NULL, 'literal', '', 'user21', NULL, 1),
(354, 63, 248, NULL, NULL, 'literal', '', 'Homme', NULL, 1),
(355, 63, 249, NULL, NULL, 'literal', '', '24', NULL, 1),
(356, 63, 250, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(357, 63, 252, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(358, 63, 251, NULL, NULL, 'literal', '', 'le sport', NULL, 1),
(359, 63, 253, NULL, NULL, 'literal', '', 'ahmed45jab@gmail.com', NULL, 1),
(360, 64, 1, NULL, NULL, 'literal', '', 'user20', NULL, 1),
(361, 64, 248, NULL, NULL, 'literal', '', 'Homme', NULL, 1),
(362, 64, 249, NULL, NULL, 'literal', '', '26', NULL, 1),
(363, 64, 250, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(364, 64, 252, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(365, 64, 251, NULL, NULL, 'literal', '', 'le sport', NULL, 1),
(366, 64, 253, NULL, NULL, 'literal', '', 'mokraniislam998@gmail.com', NULL, 1),
(367, 65, 1, NULL, NULL, 'literal', '', 'user19', NULL, 1),
(368, 65, 248, NULL, NULL, 'literal', '', 'Femme', NULL, 1),
(369, 65, 249, NULL, NULL, 'literal', '', '28', NULL, 1),
(370, 65, 250, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(371, 65, 252, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(372, 65, 251, NULL, NULL, 'literal', '', 'le régime', NULL, 1),
(373, 65, 253, NULL, NULL, 'literal', '', 'melissaorb02@gmail.com', NULL, 1),
(374, 66, 1, NULL, NULL, 'literal', '', 'user18', NULL, 1),
(375, 66, 248, NULL, NULL, 'literal', '', 'Homme', NULL, 1),
(376, 66, 249, NULL, NULL, 'literal', '', '24', NULL, 1),
(377, 66, 250, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(378, 66, 252, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(379, 66, 251, NULL, NULL, 'literal', '', 'le sport', NULL, 1),
(380, 66, 253, NULL, NULL, 'literal', '', 'nathan.benais@gmail.com', NULL, 1),
(381, 67, 1, NULL, NULL, 'literal', '', 'user17', NULL, 1),
(382, 67, 248, NULL, NULL, 'literal', '', 'Femme', NULL, 1),
(383, 67, 249, NULL, NULL, 'literal', '', '23', NULL, 1),
(384, 67, 250, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(385, 67, 252, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(386, 67, 251, NULL, NULL, 'literal', '', 'le sport', NULL, 1),
(387, 67, 253, NULL, NULL, 'literal', '', 'moussaoui.rania755@gmail.com', NULL, 1),
(388, 68, 1, NULL, NULL, 'literal', '', 'user16', NULL, 1),
(389, 68, 248, NULL, NULL, 'literal', '', 'Homme', NULL, 1),
(390, 68, 249, NULL, NULL, 'literal', '', '24', NULL, 1),
(391, 68, 250, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(392, 68, 252, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(393, 68, 251, NULL, NULL, 'literal', '', 'les deux', NULL, 1),
(394, 68, 253, NULL, NULL, 'literal', '', 'noureddineaitkhouya@gmail.com', NULL, 1),
(395, 69, 1, NULL, NULL, 'literal', '', 'user15', NULL, 1),
(396, 69, 248, NULL, NULL, 'literal', '', 'Femme', NULL, 1),
(397, 69, 249, NULL, NULL, 'literal', '', '23', NULL, 1),
(398, 69, 250, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(399, 69, 252, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(400, 69, 251, NULL, NULL, 'literal', '', 'les deux', NULL, 1),
(401, 69, 253, NULL, NULL, 'literal', '', 'oumaimaelfazazi01@gmail.com', NULL, 1),
(402, 70, 1, NULL, NULL, 'literal', '', 'user14', NULL, 1),
(403, 70, 248, NULL, NULL, 'literal', '', 'Femme', NULL, 1),
(404, 70, 249, NULL, NULL, 'literal', '', '23', NULL, 1),
(405, 70, 250, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(406, 70, 252, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(407, 70, 251, NULL, NULL, 'literal', '', 'le sport', NULL, 1),
(408, 70, 253, NULL, NULL, 'literal', '', 'yasmine.guemat97@gmail.com', NULL, 1),
(409, 71, 1, NULL, NULL, 'literal', '', 'user13', NULL, 1),
(410, 71, 253, NULL, NULL, 'literal', '', 'a.hef2000@gmail.Com', NULL, 1),
(411, 71, 247, NULL, NULL, 'literal', '', '10/10/2024 10:12:37', NULL, 1),
(412, 71, 248, NULL, NULL, 'literal', '', 'Homme', NULL, 1),
(413, 71, 249, NULL, NULL, 'literal', '', '24', NULL, 1),
(414, 71, 250, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(415, 71, 251, NULL, NULL, 'literal', '', 'les deux', NULL, 1),
(416, 72, 1, NULL, NULL, 'literal', '', 'user12', NULL, 1),
(417, 72, 253, NULL, NULL, 'literal', '', 'anas.hefied7@gmail.com', NULL, 1),
(418, 72, 247, NULL, NULL, 'literal', '', '10/10/2024 10:13:00', NULL, 1),
(419, 72, 248, NULL, NULL, 'literal', '', 'Homme', NULL, 1),
(420, 72, 249, NULL, NULL, 'literal', '', '24', NULL, 1),
(421, 72, 250, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(422, 72, 251, NULL, NULL, 'literal', '', 'le régime', NULL, 1),
(423, 73, 1, NULL, NULL, 'literal', '', 'user11', NULL, 1),
(424, 73, 253, NULL, NULL, 'literal', '', 'massidireddy@gmail.com', NULL, 1),
(425, 73, 247, NULL, NULL, 'literal', '', '12/10/2024 15:39:55', NULL, 1),
(426, 73, 248, NULL, NULL, 'literal', '', 'Homme', NULL, 1),
(427, 73, 249, NULL, NULL, 'literal', '', '28', NULL, 1),
(428, 73, 250, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(429, 73, 251, NULL, NULL, 'literal', '', 'le sport', NULL, 1),
(430, 74, 1, NULL, NULL, 'literal', '', 'user10', NULL, 1),
(431, 74, 253, NULL, NULL, 'literal', '', 'ouksili.samy@yahoo.com', NULL, 1),
(432, 74, 247, NULL, NULL, 'literal', '', '13/10/2024 02:00:54', NULL, 1),
(433, 74, 248, NULL, NULL, 'literal', '', 'Homme', NULL, 1),
(434, 74, 249, NULL, NULL, 'literal', '', '25', NULL, 1),
(435, 74, 250, NULL, NULL, 'literal', '', 'Oui', NULL, 1),
(436, 74, 251, NULL, NULL, 'literal', '', 'les deux', NULL, 1),
(437, 75, 1, NULL, NULL, 'literal', '', 'user9', NULL, 1),
(438, 75, 253, NULL, NULL, 'literal', '', 'Amjahidmohamedamin@gmail.com', NULL, 1),
(439, 75, 247, NULL, NULL, 'literal', '', '13/10/2024 15:43:10', NULL, 1),
(440, 75, 248, NULL, NULL, 'literal', '', 'Homme', NULL, 1),
(441, 75, 249, NULL, NULL, 'literal', '', '22', NULL, 1),
(442, 75, 250, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(443, 75, 251, NULL, NULL, 'literal', '', 'les deux', NULL, 1),
(444, 76, 1, NULL, NULL, 'literal', '', 'user8', NULL, 1),
(445, 76, 253, NULL, NULL, 'literal', '', 'ahmed45jab@gmail.com', NULL, 1),
(446, 76, 247, NULL, NULL, 'literal', '', '13/10/2024 16:18:09', NULL, 1),
(447, 76, 248, NULL, NULL, 'literal', '', 'Homme', NULL, 1),
(448, 76, 249, NULL, NULL, 'literal', '', '24', NULL, 1),
(449, 76, 250, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(450, 76, 251, NULL, NULL, 'literal', '', 'le sport', NULL, 1),
(451, 77, 1, NULL, NULL, 'literal', '', 'user7', NULL, 1),
(452, 77, 253, NULL, NULL, 'literal', '', 'mokraniislam998@gmail.com', NULL, 1),
(453, 77, 247, NULL, NULL, 'literal', '', '13/10/2024 16:21:05', NULL, 1),
(454, 77, 248, NULL, NULL, 'literal', '', 'Homme', NULL, 1),
(455, 77, 249, NULL, NULL, 'literal', '', '26', NULL, 1),
(456, 77, 250, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(457, 77, 251, NULL, NULL, 'literal', '', 'le sport', NULL, 1),
(458, 78, 1, NULL, NULL, 'literal', '', 'user6', NULL, 1),
(459, 78, 253, NULL, NULL, 'literal', '', 'melissaorb02@gmail.com', NULL, 1),
(460, 78, 247, NULL, NULL, 'literal', '', '13/10/2024 20:44:09', NULL, 1),
(461, 78, 248, NULL, NULL, 'literal', '', 'Femme', NULL, 1),
(462, 78, 249, NULL, NULL, 'literal', '', '28', NULL, 1),
(463, 78, 250, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(464, 78, 251, NULL, NULL, 'literal', '', 'le régime', NULL, 1),
(465, 79, 1, NULL, NULL, 'literal', '', 'user5', NULL, 1),
(466, 79, 253, NULL, NULL, 'literal', '', 'nathan.benais@gmail.com', NULL, 1),
(467, 79, 247, NULL, NULL, 'literal', '', '13/10/2024 21:01:48', NULL, 1),
(468, 79, 248, NULL, NULL, 'literal', '', 'Homme', NULL, 1),
(469, 79, 249, NULL, NULL, 'literal', '', '24', NULL, 1),
(470, 79, 250, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(471, 79, 251, NULL, NULL, 'literal', '', 'le sport', NULL, 1),
(472, 80, 1, NULL, NULL, 'literal', '', 'user4', NULL, 1),
(473, 80, 253, NULL, NULL, 'literal', '', 'moussaoui.rania755@gmail.com', NULL, 1),
(474, 80, 247, NULL, NULL, 'literal', '', '13/10/2024 22:32:03', NULL, 1),
(475, 80, 248, NULL, NULL, 'literal', '', 'Femme', NULL, 1),
(476, 80, 249, NULL, NULL, 'literal', '', '23', NULL, 1),
(477, 80, 250, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(478, 80, 251, NULL, NULL, 'literal', '', 'le sport', NULL, 1),
(479, 81, 1, NULL, NULL, 'literal', '', 'user3', NULL, 1),
(480, 81, 253, NULL, NULL, 'literal', '', 'noureddineaitkhouya@gmail.com', NULL, 1),
(481, 81, 247, NULL, NULL, 'literal', '', '14/10/2024 08:17:06', NULL, 1),
(482, 81, 248, NULL, NULL, 'literal', '', 'Homme', NULL, 1),
(483, 81, 249, NULL, NULL, 'literal', '', '24', NULL, 1),
(484, 81, 250, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(485, 81, 251, NULL, NULL, 'literal', '', 'les deux', NULL, 1),
(486, 82, 1, NULL, NULL, 'literal', '', 'user2', NULL, 1),
(487, 82, 253, NULL, NULL, 'literal', '', 'oumaimaelfazazi01@gmail.com', NULL, 1),
(488, 82, 247, NULL, NULL, 'literal', '', '14/10/2024 08:37:56', NULL, 1),
(489, 82, 248, NULL, NULL, 'literal', '', 'Femme', NULL, 1),
(490, 82, 249, NULL, NULL, 'literal', '', '23', NULL, 1),
(491, 82, 250, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(492, 82, 251, NULL, NULL, 'literal', '', 'les deux', NULL, 1),
(493, 83, 1, NULL, NULL, 'literal', '', 'user1', NULL, 1),
(494, 83, 253, NULL, NULL, 'literal', '', 'yasmine.guemat97@gmail.com', NULL, 1),
(495, 83, 247, NULL, NULL, 'literal', '', '14/10/2024 09:23:18', NULL, 1),
(496, 83, 248, NULL, NULL, 'literal', '', 'Femme', NULL, 1),
(497, 83, 249, NULL, NULL, 'literal', '', '23', NULL, 1),
(498, 83, 250, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(499, 83, 251, NULL, NULL, 'literal', '', 'le sport', NULL, 1),
(500, 83, 252, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(501, 82, 252, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(502, 81, 252, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(503, 80, 252, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(504, 79, 252, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(505, 78, 252, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(506, 77, 252, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(507, 76, 252, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(508, 75, 252, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(509, 74, 252, NULL, NULL, 'literal', '', 'Oui', NULL, 1),
(510, 73, 252, NULL, NULL, 'literal', '', 'Oui', NULL, 1),
(511, 72, 252, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(512, 71, 252, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(513, 70, 247, NULL, NULL, 'literal', '', '14/10/2024 09:23:18', NULL, 1),
(514, 69, 247, NULL, NULL, 'literal', '', '14/10/2024 08:37:56', NULL, 1),
(515, 68, 247, NULL, NULL, 'literal', '', '14/10/2024 08:17:06', NULL, 1),
(516, 67, 247, NULL, NULL, 'literal', '', '13/10/2024 22:32:03', NULL, 1),
(517, 66, 247, NULL, NULL, 'literal', '', '13/10/2024 21:01:48', NULL, 1),
(518, 65, 247, NULL, NULL, 'literal', '', '13/10/2024 20:44:09', NULL, 1),
(519, 64, 247, NULL, NULL, 'literal', '', '13/10/2024 16:21:05', NULL, 1),
(520, 63, 247, NULL, NULL, 'literal', '', '13/10/2024 16:18:09', NULL, 1),
(521, 62, 247, NULL, NULL, 'literal', '', '13/10/2024 15:43:10', NULL, 1),
(522, 61, 247, NULL, NULL, 'literal', '', '13/10/2024 02:00:54', NULL, 1),
(523, 60, 247, NULL, NULL, 'literal', '', '12/10/2024 15:39:55', NULL, 1),
(524, 59, 247, NULL, NULL, 'literal', '', '10/10/2024 10:13:00', NULL, 1);

-- --------------------------------------------------------

--
-- Structure de la table `value_annotation`
--

CREATE TABLE `value_annotation` (
  `id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `vocabulary`
--

CREATE TABLE `vocabulary` (
  `id` int NOT NULL,
  `owner_id` int DEFAULT NULL,
  `namespace_uri` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `prefix` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `vocabulary`
--

INSERT INTO `vocabulary` (`id`, `owner_id`, `namespace_uri`, `prefix`, `label`, `comment`) VALUES
(1, NULL, 'http://purl.org/dc/terms/', 'dcterms', 'Dublin Core', 'Basic resource metadata (DCMI Metadata Terms)'),
(2, NULL, 'http://purl.org/dc/dcmitype/', 'dctype', 'Dublin Core Type', 'Basic resource types (DCMI Type Vocabulary)'),
(3, NULL, 'http://purl.org/ontology/bibo/', 'bibo', 'Bibliographic Ontology', 'Bibliographic metadata (BIBO)'),
(4, NULL, 'http://xmlns.com/foaf/0.1/', 'foaf', 'Friend of a Friend', 'Relationships between people and organizations (FOAF)'),
(5, 1, 'https://jardindesconnaissances.univ-paris8.fr/onto/etudiant_thyp#', 'etudiant_thyp', 'vocab', ''),
(9, 1, 'https://jardindesconnaissances.univ-paris8.fr/onto/etudiant_thyp_cabinet_Management#', 'cabinet_Management', 'vocab-cabinet_Management', '');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `api_key`
--
ALTER TABLE `api_key`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_C912ED9D7E3C61F9` (`owner_id`);

--
-- Index pour la table `asset`
--
ALTER TABLE `asset`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_2AF5A5C5CC5DB90` (`storage_id`),
  ADD KEY `IDX_2AF5A5C7E3C61F9` (`owner_id`);

--
-- Index pour la table `csvimport_entity`
--
ALTER TABLE `csvimport_entity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_84D382F4BE04EA9` (`job_id`);

--
-- Index pour la table `csvimport_import`
--
ALTER TABLE `csvimport_import`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_17B50881BE04EA9` (`job_id`),
  ADD UNIQUE KEY `UNIQ_17B508814C276F75` (`undo_job_id`);

--
-- Index pour la table `fulltext_search`
--
ALTER TABLE `fulltext_search`
  ADD PRIMARY KEY (`id`,`resource`),
  ADD KEY `IDX_AA31FE4A7E3C61F9` (`owner_id`);
ALTER TABLE `fulltext_search` ADD FULLTEXT KEY `IDX_AA31FE4A2B36786B3B8BA7C7` (`title`,`text`);

--
-- Index pour la table `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_1F1B251ECBE0B084` (`primary_media_id`);

--
-- Index pour la table `item_item_set`
--
ALTER TABLE `item_item_set`
  ADD PRIMARY KEY (`item_id`,`item_set_id`),
  ADD KEY `IDX_6D0C9625126F525E` (`item_id`),
  ADD KEY `IDX_6D0C9625960278D7` (`item_set_id`);

--
-- Index pour la table `item_set`
--
ALTER TABLE `item_set`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `item_site`
--
ALTER TABLE `item_site`
  ADD PRIMARY KEY (`item_id`,`site_id`),
  ADD KEY `IDX_A1734D1F126F525E` (`item_id`),
  ADD KEY `IDX_A1734D1FF6BD1646` (`site_id`);

--
-- Index pour la table `job`
--
ALTER TABLE `job`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_FBD8E0F87E3C61F9` (`owner_id`);

--
-- Index pour la table `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_6A2CA10C5CC5DB90` (`storage_id`),
  ADD KEY `IDX_6A2CA10C126F525E` (`item_id`),
  ADD KEY `item_position` (`item_id`,`position`);

--
-- Index pour la table `migration`
--
ALTER TABLE `migration`
  ADD PRIMARY KEY (`version`);

--
-- Index pour la table `module`
--
ALTER TABLE `module`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `password_creation`
--
ALTER TABLE `password_creation`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_C77917B4A76ED395` (`user_id`);

--
-- Index pour la table `property`
--
ALTER TABLE `property`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8BF21CDEAD0E05F6623C14D5` (`vocabulary_id`,`local_name`),
  ADD KEY `IDX_8BF21CDE7E3C61F9` (`owner_id`),
  ADD KEY `IDX_8BF21CDEAD0E05F6` (`vocabulary_id`);

--
-- Index pour la table `resource`
--
ALTER TABLE `resource`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_BC91F4167E3C61F9` (`owner_id`),
  ADD KEY `IDX_BC91F416448CC1BD` (`resource_class_id`),
  ADD KEY `IDX_BC91F41616131EA` (`resource_template_id`),
  ADD KEY `IDX_BC91F416FDFF2E92` (`thumbnail_id`),
  ADD KEY `title` (`title`(190)),
  ADD KEY `is_public` (`is_public`);

--
-- Index pour la table `resource_class`
--
ALTER TABLE `resource_class`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_C6F063ADAD0E05F6623C14D5` (`vocabulary_id`,`local_name`),
  ADD KEY `IDX_C6F063AD7E3C61F9` (`owner_id`),
  ADD KEY `IDX_C6F063ADAD0E05F6` (`vocabulary_id`);

--
-- Index pour la table `resource_template`
--
ALTER TABLE `resource_template`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_39ECD52EEA750E8` (`label`),
  ADD KEY `IDX_39ECD52E7E3C61F9` (`owner_id`),
  ADD KEY `IDX_39ECD52E448CC1BD` (`resource_class_id`),
  ADD KEY `IDX_39ECD52E724734A3` (`title_property_id`),
  ADD KEY `IDX_39ECD52EB84E0D1D` (`description_property_id`);

--
-- Index pour la table `resource_template_property`
--
ALTER TABLE `resource_template_property`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_4689E2F116131EA549213EC` (`resource_template_id`,`property_id`),
  ADD KEY `IDX_4689E2F116131EA` (`resource_template_id`),
  ADD KEY `IDX_4689E2F1549213EC` (`property_id`);

--
-- Index pour la table `session`
--
ALTER TABLE `session`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `setting`
--
ALTER TABLE `setting`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `site`
--
ALTER TABLE `site`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_694309E4989D9B62` (`slug`),
  ADD UNIQUE KEY `UNIQ_694309E4571EDDA` (`homepage_id`),
  ADD KEY `IDX_694309E4FDFF2E92` (`thumbnail_id`),
  ADD KEY `IDX_694309E47E3C61F9` (`owner_id`);

--
-- Index pour la table `site_block_attachment`
--
ALTER TABLE `site_block_attachment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_236473FEE9ED820C` (`block_id`),
  ADD KEY `IDX_236473FE126F525E` (`item_id`),
  ADD KEY `IDX_236473FEEA9FDD75` (`media_id`),
  ADD KEY `block_position` (`block_id`,`position`);

--
-- Index pour la table `site_item_set`
--
ALTER TABLE `site_item_set`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_D4CE134F6BD1646960278D7` (`site_id`,`item_set_id`),
  ADD KEY `IDX_D4CE134F6BD1646` (`site_id`),
  ADD KEY `IDX_D4CE134960278D7` (`item_set_id`),
  ADD KEY `position` (`position`);

--
-- Index pour la table `site_page`
--
ALTER TABLE `site_page`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_2F900BD9F6BD1646989D9B62` (`site_id`,`slug`),
  ADD KEY `is_public` (`is_public`),
  ADD KEY `IDX_2F900BD9F6BD1646` (`site_id`);

--
-- Index pour la table `site_page_block`
--
ALTER TABLE `site_page_block`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_C593E731C4663E4` (`page_id`),
  ADD KEY `page_position` (`page_id`,`position`);

--
-- Index pour la table `site_permission`
--
ALTER TABLE `site_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_C0401D6FF6BD1646A76ED395` (`site_id`,`user_id`),
  ADD KEY `IDX_C0401D6FF6BD1646` (`site_id`),
  ADD KEY `IDX_C0401D6FA76ED395` (`user_id`);

--
-- Index pour la table `site_setting`
--
ALTER TABLE `site_setting`
  ADD PRIMARY KEY (`id`,`site_id`),
  ADD KEY `IDX_64D05A53F6BD1646` (`site_id`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`);

--
-- Index pour la table `user_setting`
--
ALTER TABLE `user_setting`
  ADD PRIMARY KEY (`id`,`user_id`),
  ADD KEY `IDX_C779A692A76ED395` (`user_id`);

--
-- Index pour la table `value`
--
ALTER TABLE `value`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_1D7758349B66727E` (`value_annotation_id`),
  ADD KEY `IDX_1D77583489329D25` (`resource_id`),
  ADD KEY `IDX_1D775834549213EC` (`property_id`),
  ADD KEY `IDX_1D7758344BC72506` (`value_resource_id`),
  ADD KEY `value` (`value`(190)),
  ADD KEY `uri` (`uri`(190)),
  ADD KEY `is_public` (`is_public`);

--
-- Index pour la table `value_annotation`
--
ALTER TABLE `value_annotation`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `vocabulary`
--
ALTER TABLE `vocabulary`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_9099C97B9B267FDF` (`namespace_uri`),
  ADD UNIQUE KEY `UNIQ_9099C97B93B1868E` (`prefix`),
  ADD KEY `IDX_9099C97B7E3C61F9` (`owner_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `asset`
--
ALTER TABLE `asset`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `csvimport_entity`
--
ALTER TABLE `csvimport_entity`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT pour la table `csvimport_import`
--
ALTER TABLE `csvimport_import`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `job`
--
ALTER TABLE `job`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `property`
--
ALTER TABLE `property`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=267;

--
-- AUTO_INCREMENT pour la table `resource`
--
ALTER TABLE `resource`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=84;

--
-- AUTO_INCREMENT pour la table `resource_class`
--
ALTER TABLE `resource_class`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=129;

--
-- AUTO_INCREMENT pour la table `resource_template`
--
ALTER TABLE `resource_template`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `resource_template_property`
--
ALTER TABLE `resource_template_property`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT pour la table `site`
--
ALTER TABLE `site`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `site_block_attachment`
--
ALTER TABLE `site_block_attachment`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `site_item_set`
--
ALTER TABLE `site_item_set`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `site_page`
--
ALTER TABLE `site_page`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `site_page_block`
--
ALTER TABLE `site_page_block`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `site_permission`
--
ALTER TABLE `site_permission`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `value`
--
ALTER TABLE `value`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=525;

--
-- AUTO_INCREMENT pour la table `vocabulary`
--
ALTER TABLE `vocabulary`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `api_key`
--
ALTER TABLE `api_key`
  ADD CONSTRAINT `FK_C912ED9D7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `asset`
--
ALTER TABLE `asset`
  ADD CONSTRAINT `FK_2AF5A5C7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `csvimport_entity`
--
ALTER TABLE `csvimport_entity`
  ADD CONSTRAINT `FK_84D382F4BE04EA9` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`);

--
-- Contraintes pour la table `csvimport_import`
--
ALTER TABLE `csvimport_import`
  ADD CONSTRAINT `FK_17B508814C276F75` FOREIGN KEY (`undo_job_id`) REFERENCES `job` (`id`),
  ADD CONSTRAINT `FK_17B50881BE04EA9` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`);

--
-- Contraintes pour la table `fulltext_search`
--
ALTER TABLE `fulltext_search`
  ADD CONSTRAINT `FK_AA31FE4A7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `item`
--
ALTER TABLE `item`
  ADD CONSTRAINT `FK_1F1B251EBF396750` FOREIGN KEY (`id`) REFERENCES `resource` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_1F1B251ECBE0B084` FOREIGN KEY (`primary_media_id`) REFERENCES `media` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `item_item_set`
--
ALTER TABLE `item_item_set`
  ADD CONSTRAINT `FK_6D0C9625126F525E` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_6D0C9625960278D7` FOREIGN KEY (`item_set_id`) REFERENCES `item_set` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `item_set`
--
ALTER TABLE `item_set`
  ADD CONSTRAINT `FK_1015EEEBF396750` FOREIGN KEY (`id`) REFERENCES `resource` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `item_site`
--
ALTER TABLE `item_site`
  ADD CONSTRAINT `FK_A1734D1F126F525E` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_A1734D1FF6BD1646` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `job`
--
ALTER TABLE `job`
  ADD CONSTRAINT `FK_FBD8E0F87E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `media`
--
ALTER TABLE `media`
  ADD CONSTRAINT `FK_6A2CA10C126F525E` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`),
  ADD CONSTRAINT `FK_6A2CA10CBF396750` FOREIGN KEY (`id`) REFERENCES `resource` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `password_creation`
--
ALTER TABLE `password_creation`
  ADD CONSTRAINT `FK_C77917B4A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `property`
--
ALTER TABLE `property`
  ADD CONSTRAINT `FK_8BF21CDE7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_8BF21CDEAD0E05F6` FOREIGN KEY (`vocabulary_id`) REFERENCES `vocabulary` (`id`);

--
-- Contraintes pour la table `resource`
--
ALTER TABLE `resource`
  ADD CONSTRAINT `FK_BC91F41616131EA` FOREIGN KEY (`resource_template_id`) REFERENCES `resource_template` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_BC91F416448CC1BD` FOREIGN KEY (`resource_class_id`) REFERENCES `resource_class` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_BC91F4167E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_BC91F416FDFF2E92` FOREIGN KEY (`thumbnail_id`) REFERENCES `asset` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `resource_class`
--
ALTER TABLE `resource_class`
  ADD CONSTRAINT `FK_C6F063AD7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_C6F063ADAD0E05F6` FOREIGN KEY (`vocabulary_id`) REFERENCES `vocabulary` (`id`);

--
-- Contraintes pour la table `resource_template`
--
ALTER TABLE `resource_template`
  ADD CONSTRAINT `FK_39ECD52E448CC1BD` FOREIGN KEY (`resource_class_id`) REFERENCES `resource_class` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_39ECD52E724734A3` FOREIGN KEY (`title_property_id`) REFERENCES `property` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_39ECD52E7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_39ECD52EB84E0D1D` FOREIGN KEY (`description_property_id`) REFERENCES `property` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `resource_template_property`
--
ALTER TABLE `resource_template_property`
  ADD CONSTRAINT `FK_4689E2F116131EA` FOREIGN KEY (`resource_template_id`) REFERENCES `resource_template` (`id`),
  ADD CONSTRAINT `FK_4689E2F1549213EC` FOREIGN KEY (`property_id`) REFERENCES `property` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `site`
--
ALTER TABLE `site`
  ADD CONSTRAINT `FK_694309E4571EDDA` FOREIGN KEY (`homepage_id`) REFERENCES `site_page` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_694309E47E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_694309E4FDFF2E92` FOREIGN KEY (`thumbnail_id`) REFERENCES `asset` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `site_block_attachment`
--
ALTER TABLE `site_block_attachment`
  ADD CONSTRAINT `FK_236473FE126F525E` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_236473FEE9ED820C` FOREIGN KEY (`block_id`) REFERENCES `site_page_block` (`id`),
  ADD CONSTRAINT `FK_236473FEEA9FDD75` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `site_item_set`
--
ALTER TABLE `site_item_set`
  ADD CONSTRAINT `FK_D4CE134960278D7` FOREIGN KEY (`item_set_id`) REFERENCES `item_set` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_D4CE134F6BD1646` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `site_page`
--
ALTER TABLE `site_page`
  ADD CONSTRAINT `FK_2F900BD9F6BD1646` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`);

--
-- Contraintes pour la table `site_page_block`
--
ALTER TABLE `site_page_block`
  ADD CONSTRAINT `FK_C593E731C4663E4` FOREIGN KEY (`page_id`) REFERENCES `site_page` (`id`);

--
-- Contraintes pour la table `site_permission`
--
ALTER TABLE `site_permission`
  ADD CONSTRAINT `FK_C0401D6FA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_C0401D6FF6BD1646` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `site_setting`
--
ALTER TABLE `site_setting`
  ADD CONSTRAINT `FK_64D05A53F6BD1646` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `user_setting`
--
ALTER TABLE `user_setting`
  ADD CONSTRAINT `FK_C779A692A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `value`
--
ALTER TABLE `value`
  ADD CONSTRAINT `FK_1D7758344BC72506` FOREIGN KEY (`value_resource_id`) REFERENCES `resource` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_1D775834549213EC` FOREIGN KEY (`property_id`) REFERENCES `property` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_1D77583489329D25` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`),
  ADD CONSTRAINT `FK_1D7758349B66727E` FOREIGN KEY (`value_annotation_id`) REFERENCES `value_annotation` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `value_annotation`
--
ALTER TABLE `value_annotation`
  ADD CONSTRAINT `FK_C03BA4EBF396750` FOREIGN KEY (`id`) REFERENCES `resource` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `vocabulary`
--
ALTER TABLE `vocabulary`
  ADD CONSTRAINT `FK_9099C97B7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
