-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 06 nov. 2024 à 09:57
-- Version du serveur : 8.0.39
-- Version de PHP : 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `anas_thyp`
--

-- --------------------------------------------------------

--
-- Structure de la table `api_key`
--

DROP TABLE IF EXISTS `api_key`;
CREATE TABLE IF NOT EXISTS `api_key` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner_id` int NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `credential_hash` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_ip` varbinary(16) DEFAULT NULL COMMENT '(DC2Type:ip_address)',
  `last_accessed` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C912ED9D7E3C61F9` (`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `api_key`
--

INSERT INTO `api_key` (`id`, `owner_id`, `label`, `credential_hash`, `last_ip`, `last_accessed`, `created`) VALUES
('owCGNQO2JDe5fX2D0u3qNZfigoW5fU4H', 1, 'cabinet_medical', '$2y$10$3lFv85ika9lTqXxtfOdxreR.cDj0iOnX0zDktfC8NR4yTZDSdvosi', NULL, NULL, '2024-11-03 15:11:54');

-- --------------------------------------------------------

--
-- Structure de la table `asset`
--

DROP TABLE IF EXISTS `asset`;
CREATE TABLE IF NOT EXISTS `asset` (
  `id` int NOT NULL AUTO_INCREMENT,
  `owner_id` int DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `media_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `storage_id` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `extension` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alt_text` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_2AF5A5C5CC5DB90` (`storage_id`),
  KEY `IDX_2AF5A5C7E3C61F9` (`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `csvimport_entity`
--

DROP TABLE IF EXISTS `csvimport_entity`;
CREATE TABLE IF NOT EXISTS `csvimport_entity` (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_id` int NOT NULL,
  `entity_id` int NOT NULL,
  `resource_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_84D382F4BE04EA9` (`job_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `csvimport_entity`
--

INSERT INTO `csvimport_entity` (`id`, `job_id`, `entity_id`, `resource_type`) VALUES
(1, 71, 6, 'items'),
(2, 71, 7, 'items'),
(3, 71, 8, 'items'),
(4, 71, 9, 'items'),
(5, 71, 10, 'items'),
(6, 71, 11, 'items'),
(7, 71, 12, 'items'),
(8, 71, 13, 'items'),
(9, 71, 14, 'items'),
(10, 71, 15, 'items'),
(11, 71, 16, 'items'),
(12, 71, 17, 'items'),
(13, 71, 18, 'items'),
(14, 72, 19, 'items'),
(15, 72, 20, 'items'),
(16, 72, 21, 'items'),
(17, 72, 22, 'items'),
(18, 72, 23, 'items'),
(19, 72, 24, 'items'),
(20, 72, 25, 'items'),
(21, 72, 26, 'items'),
(22, 72, 27, 'items'),
(23, 72, 28, 'items'),
(24, 72, 29, 'items'),
(25, 72, 30, 'items'),
(26, 72, 31, 'items');

-- --------------------------------------------------------

--
-- Structure de la table `csvimport_import`
--

DROP TABLE IF EXISTS `csvimport_import`;
CREATE TABLE IF NOT EXISTS `csvimport_import` (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_id` int NOT NULL,
  `undo_job_id` int DEFAULT NULL,
  `comment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resource_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `has_err` tinyint(1) NOT NULL,
  `stats` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_17B50881BE04EA9` (`job_id`),
  UNIQUE KEY `UNIQ_17B508814C276F75` (`undo_job_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `csvimport_import`
--

INSERT INTO `csvimport_import` (`id`, `job_id`, `undo_job_id`, `comment`, `resource_type`, `has_err`, `stats`) VALUES
(1, 71, NULL, '', 'items', 0, '{\"added\":{\"items\":13}}'),
(2, 72, NULL, '', 'items', 0, '{\"added\":{\"items\":13}}');

-- --------------------------------------------------------

--
-- Structure de la table `fulltext_search`
--

DROP TABLE IF EXISTS `fulltext_search`;
CREATE TABLE IF NOT EXISTS `fulltext_search` (
  `id` int NOT NULL,
  `resource` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner_id` int DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL,
  `title` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `text` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`,`resource`),
  KEY `IDX_AA31FE4A7E3C61F9` (`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `fulltext_search`
--

INSERT INTO `fulltext_search` (`id`, `resource`, `owner_id`, `is_public`, `title`, `text`) VALUES
(19, 'items', 1, 1, NULL, '10/10/2024 10:12:37\nHomme\n24\nNon\nles deux\nNon\na.hef2000@gmail.Com'),
(20, 'items', 1, 1, NULL, '10/10/2024 10:13:00\nHomme\n24\nNon\nle régime\nNon\nanas.hefied7@gmail.com'),
(21, 'items', 1, 1, NULL, '12/10/2024 15:39:55\nHomme\n28\nNon\nle sport\nOui\nmassidireddy@gmail.com'),
(22, 'items', 1, 1, NULL, '13/10/2024 02:00:54\nHomme\n25\nOui\nles deux\nOui\nouksili.samy@yahoo.com'),
(23, 'items', 1, 1, NULL, '13/10/2024 15:43:10\nHomme\n22\nNon\nles deux\nNon\nAmjahidmohamedamin@gmail.com'),
(24, 'items', 1, 1, NULL, '13/10/2024 16:18:09\nHomme\n24\nNon\nle sport\nNon\nahmed45jab@gmail.com'),
(25, 'items', 1, 1, NULL, '13/10/2024 16:21:05\nHomme\n26\nNon\nle sport\nNon\nmokraniislam998@gmail.com'),
(26, 'items', 1, 1, NULL, '13/10/2024 20:44:09\nFemme\n28\nNon\nle régime\nNon\nmelissaorb02@gmail.com'),
(27, 'items', 1, 1, NULL, '13/10/2024 21:01:48\nHomme\n24\nNon\nle sport\nNon\nnathan.benais@gmail.com'),
(28, 'items', 1, 1, NULL, '13/10/2024 22:32:03\nFemme\n23\nNon\nle sport\nNon\nmoussaoui.rania755@gmail.com'),
(29, 'items', 1, 1, NULL, '14/10/2024 08:17:06\nHomme\n24\nNon\nles deux\nNon\nnoureddineaitkhouya@gmail.com'),
(30, 'items', 1, 1, NULL, '14/10/2024 08:37:56\nFemme\n23\nNon\nles deux\nNon\noumaimaelfazazi01@gmail.com'),
(31, 'items', 1, 1, NULL, 'yasmine.guemat97@gmail.com\nyasmine.guemat\nPatient\nFemme\n23\n1447789566633\n0655555555\nle sport\nNon\nNon\n08/11/2024\nyasmin123\n14/10/2024 09:23:18'),
(32, 'item_sets', 1, 1, NULL, 'a.hef2000@gmail.com\nanas_thyp\nAdmin\nAnas123'),
(33, 'item_sets', 1, 1, NULL, 'a.hef2000@gmail.com\nanas_thyp\n0670622027\nAdmin\nAnas123'),
(34, 'item_sets', 1, 1, NULL, 'a.hef1960@gmail.com\nAlihefied\nPatient\nHomme\n50\n100039935076827\n0612345678\nRégime\nNon\nNon\n07/11/2024\nAli123'),
(35, 'item_sets', 1, 1, NULL, 'Cabinet chez Docteur Hasan tazi\nstreet 12 paris\nORL'),
(36, 'item_sets', 1, 1, NULL, 'hasan.tazi@gmail.com\nHasan Tazi\nMédecin\nCabinet chez Docteur Hasan tazi\n\nORL\n0635487963\nhasan123'),
(37, 'item_sets', 1, 1, NULL, '07/11/2024\n\n0612345678\n0\n1009935076827');

-- --------------------------------------------------------

--
-- Structure de la table `item`
--

DROP TABLE IF EXISTS `item`;
CREATE TABLE IF NOT EXISTS `item` (
  `id` int NOT NULL,
  `primary_media_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_1F1B251ECBE0B084` (`primary_media_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `item`
--

INSERT INTO `item` (`id`, `primary_media_id`) VALUES
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
(31, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `item_item_set`
--

DROP TABLE IF EXISTS `item_item_set`;
CREATE TABLE IF NOT EXISTS `item_item_set` (
  `item_id` int NOT NULL,
  `item_set_id` int NOT NULL,
  PRIMARY KEY (`item_id`,`item_set_id`),
  KEY `IDX_6D0C9625126F525E` (`item_id`),
  KEY `IDX_6D0C9625960278D7` (`item_set_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `item_set`
--

DROP TABLE IF EXISTS `item_set`;
CREATE TABLE IF NOT EXISTS `item_set` (
  `id` int NOT NULL,
  `is_open` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `item_set`
--

INSERT INTO `item_set` (`id`, `is_open`) VALUES
(32, 0),
(33, 0),
(34, 0),
(35, 0),
(36, 0),
(37, 0);

-- --------------------------------------------------------

--
-- Structure de la table `item_site`
--

DROP TABLE IF EXISTS `item_site`;
CREATE TABLE IF NOT EXISTS `item_site` (
  `item_id` int NOT NULL,
  `site_id` int NOT NULL,
  PRIMARY KEY (`item_id`,`site_id`),
  KEY `IDX_A1734D1F126F525E` (`item_id`),
  KEY `IDX_A1734D1FF6BD1646` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `job`
--

DROP TABLE IF EXISTS `job`;
CREATE TABLE IF NOT EXISTS `job` (
  `id` int NOT NULL AUTO_INCREMENT,
  `owner_id` int DEFAULT NULL,
  `pid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `class` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `args` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '(DC2Type:json_array)',
  `log` longtext COLLATE utf8mb4_general_ci,
  `started` datetime NOT NULL,
  `ended` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_FBD8E0F87E3C61F9` (`owner_id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `job`
--

INSERT INTO `job` (`id`, `owner_id`, `pid`, `status`, `class`, `args`, `log`, `started`, `ended`) VALUES
(65, 1, NULL, 'starting', 'CSVImport\\Job\\Import', '{\"filename\":\"Questionnaires_Patient.csv\",\"filesize\":\"1089\",\"filepath\":\"C:\\\\Windows\\\\Temp\\\\omeA4C.tmp\",\"media_type\":\"text\\/csv\",\"resource_type\":\"items\",\"comment\":\"\",\"automap_check_names_alone\":true,\"column-property\":{\"0\":{\"dcterms:date\":7},\"1\":{\"foaf:gender\":125},\"2\":{\"foaf:age\":183},\"6\":{\"foaf:mbox\":123}},\"generic-data\":\"default\",\"media-source\":\"default\",\"resource-identifier-property\":\"\",\"o:resource_template\":{\"o:id\":2},\"o:resource_class\":{\"o:id\":94},\"o:owner\":{\"o:id\":1},\"o:is_public\":1,\"multivalue_separator\":\",\",\"global_language\":\"\",\"action\":\"create\",\"identifier_column\":0,\"identifier_property\":\"\",\"action_unidentified\":\"skip\",\"rows_by_batch\":20,\"column-multivalue\":[],\"delimiter\":\",\",\"enclosure\":\"\\\"\",\"escape\":\"\\\\\"}', NULL, '2024-10-25 20:34:40', NULL),
(66, 1, NULL, 'starting', 'CSVImport\\Job\\Import', '{\"filename\":\"Questionnaires_Patient.csv\",\"filesize\":\"1089\",\"filepath\":\"C:\\\\Windows\\\\Temp\\\\ome940A.tmp\",\"media_type\":\"text\\/csv\",\"resource_type\":\"items\",\"comment\":\"\",\"automap_check_names_alone\":true,\"column-property\":{\"0\":{\"dcterms:date\":7},\"1\":{\"foaf:gender\":125},\"6\":{\"foaf:mbox\":123}},\"generic-data\":\"default\",\"media-source\":\"default\",\"resource-identifier-property\":\"\",\"o:resource_template\":\"\",\"o:resource_class\":\"\",\"o:owner\":{\"o:id\":1},\"o:is_public\":1,\"multivalue_separator\":\",\",\"global_language\":\"\",\"action\":\"create\",\"identifier_column\":0,\"identifier_property\":\"\",\"action_unidentified\":\"skip\",\"rows_by_batch\":20,\"column-multivalue\":[],\"delimiter\":\",\",\"enclosure\":\"\\\"\",\"escape\":\"\\\\\"}', NULL, '2024-10-25 20:40:12', NULL),
(67, 1, NULL, 'starting', 'CSVImport\\Job\\Import', '{\"filename\":\"Questionnaires_Patient.csv\",\"filesize\":\"1089\",\"filepath\":\"C:\\\\Windows\\\\Temp\\\\ome5FD7.tmp\",\"media_type\":\"text\\/csv\",\"resource_type\":\"items\",\"comment\":\"\",\"automap_check_names_alone\":true,\"column-property\":{\"0\":{\"dcterms:date\":7,\"foaf:age\":183},\"1\":{\"foaf:gender\":125},\"2\":{\"foaf:age\":183},\"6\":{\"foaf:mbox\":123}},\"generic-data\":\"default\",\"media-source\":\"default\",\"resource-identifier-property\":\"\",\"o:resource_template\":{\"o:id\":2},\"o:resource_class\":{\"o:id\":94},\"o:owner\":{\"o:id\":1},\"o:is_public\":1,\"multivalue_separator\":\",\",\"global_language\":\"\",\"action\":\"create\",\"identifier_column\":0,\"identifier_property\":\"\",\"action_unidentified\":\"skip\",\"rows_by_batch\":20,\"column-multivalue\":[],\"delimiter\":\",\",\"enclosure\":\"\\\"\",\"escape\":\"\\\\\"}', NULL, '2024-10-25 20:41:28', NULL),
(68, 1, NULL, 'starting', 'CSVImport\\Job\\Import', '{\"filename\":\"Questionnaires_Patient.csv\",\"filesize\":\"1089\",\"filepath\":\"C:\\\\Windows\\\\Temp\\\\omeA76A.tmp\",\"media_type\":\"text\\/csv\",\"resource_type\":\"items\",\"comment\":\"\",\"automap_check_names_alone\":true,\"column-property\":[{\"dcterms:date\":7},{\"foaf:gender\":125}],\"generic-data\":\"default\",\"media-source\":\"default\",\"resource-identifier-property\":\"\",\"o:resource_template\":\"\",\"o:resource_class\":\"\",\"o:owner\":{\"o:id\":1},\"o:is_public\":1,\"multivalue_separator\":\",\",\"global_language\":\"\",\"action\":\"create\",\"identifier_column\":0,\"identifier_property\":\"\",\"action_unidentified\":\"skip\",\"rows_by_batch\":20,\"column-multivalue\":[],\"delimiter\":\",\",\"enclosure\":\"\\\"\",\"escape\":\"\\\\\"}', NULL, '2024-10-25 20:45:37', NULL),
(69, 1, NULL, 'starting', 'CSVImport\\Job\\Import', '{\"filename\":\"Questionnaires_Patient.csv\",\"filesize\":\"1089\",\"filepath\":\"C:\\\\Windows\\\\Temp\\\\ome5F04.tmp\",\"media_type\":\"text\\/csv\",\"resource_type\":\"items\",\"comment\":\"\",\"automap_check_names_alone\":true,\"column-property\":{\"0\":{\"dcterms:date\":7},\"1\":{\"foaf:gender\":125},\"2\":{\"foaf:age\":183},\"6\":{\"foaf:mbox\":123}},\"generic-data\":\"default\",\"media-source\":\"default\",\"resource-identifier-property\":\"\",\"o:resource_template\":{\"o:id\":2},\"o:resource_class\":{\"o:id\":94},\"o:owner\":{\"o:id\":1},\"o:is_public\":1,\"multivalue_separator\":\",\",\"global_language\":\"\",\"action\":\"create\",\"identifier_column\":0,\"identifier_property\":\"\",\"action_unidentified\":\"skip\",\"rows_by_batch\":20,\"column-multivalue\":[],\"delimiter\":\",\",\"enclosure\":\"\\\"\",\"escape\":\"\\\\\"}', NULL, '2024-10-25 20:46:55', NULL),
(70, 1, NULL, 'starting', 'CSVImport\\Job\\Import', '{\"filename\":\"Questionnaires_Patient.csv\",\"filesize\":\"1089\",\"filepath\":\"C:\\\\Windows\\\\Temp\\\\omeD913.tmp\",\"media_type\":\"text\\/csv\",\"resource_type\":\"items\",\"comment\":\"\",\"automap_check_names_alone\":true,\"column-property\":{\"1\":{\"etudiant_thyp:gender\":188}},\"generic-data\":\"default\",\"media-source\":\"default\",\"resource-identifier-property\":\"\",\"o:resource_template\":{\"o:id\":1},\"o:resource_class\":{\"o:id\":94},\"o:owner\":{\"o:id\":1},\"o:is_public\":1,\"multivalue_separator\":\",\",\"global_language\":\"\",\"action\":\"create\",\"identifier_column\":0,\"identifier_property\":\"\",\"action_unidentified\":\"skip\",\"rows_by_batch\":20,\"column-multivalue\":[],\"delimiter\":\",\",\"enclosure\":\"\\\"\",\"escape\":\"\\\\\"}', NULL, '2024-11-02 09:06:23', NULL),
(71, 1, NULL, 'completed', 'CSVImport\\Job\\Import', '{\"filename\":\"Questionnaires Thyp - R\\u00e9ponses au formulaire 1.csv\",\"filesize\":\"1089\",\"filepath\":\"C:\\\\Windows\\\\Temp\\\\ome3168.tmp\",\"media_type\":\"text\\/csv\",\"resource_type\":\"items\",\"comment\":\"\",\"automap_check_names_alone\":true,\"column-property\":[{\"dcterms:date\":7},{\"foaf:gender\":125}],\"generic-data\":\"default\",\"media-source\":\"default\",\"resource-identifier-property\":\"\",\"o:resource_template\":\"\",\"o:resource_class\":\"\",\"o:owner\":{\"o:id\":1},\"o:is_public\":1,\"multivalue_separator\":\",\",\"global_language\":\"\",\"action\":\"create\",\"identifier_column\":0,\"identifier_property\":\"\",\"action_unidentified\":\"skip\",\"rows_by_batch\":20,\"column-multivalue\":[],\"delimiter\":\",\",\"enclosure\":\"\\\"\",\"escape\":\"\\\\\"}', NULL, '2024-11-04 11:04:55', '2024-11-04 11:04:55'),
(72, 1, NULL, 'completed', 'CSVImport\\Job\\Import', '{\"filename\":\"QuestionnairesThyp.csv\",\"filesize\":\"1089\",\"filepath\":\"C:\\\\Windows\\\\Temp\\\\ome31E3.tmp\",\"media_type\":\"text\\/csv\",\"resource_type\":\"items\",\"comment\":\"\",\"automap_check_names_alone\":true,\"column-property\":[{\"cabinet_medical:timeSubmit\":191},{\"cabinet_medical:sexe\":192},{\"cabinet_medical:age\":193},{\"cabinet_medical:fume\":194},{\"cabinet_medical:sport\":195},{\"cabinet_medical:alcool\":196},{\"cabinet_medical:mail\":197}],\"generic-data\":\"default\",\"media-source\":\"default\",\"resource-identifier-property\":\"\",\"o:resource_template\":{\"o:id\":9},\"o:resource_class\":{\"o:id\":110},\"o:owner\":{\"o:id\":1},\"o:is_public\":1,\"multivalue_separator\":\",\",\"global_language\":\"\",\"action\":\"create\",\"identifier_column\":0,\"identifier_property\":\"\",\"action_unidentified\":\"skip\",\"rows_by_batch\":20,\"column-multivalue\":[],\"delimiter\":\",\",\"enclosure\":\"\\\"\",\"escape\":\"\\\\\"}', NULL, '2024-11-06 09:42:27', '2024-11-06 09:42:27');

-- --------------------------------------------------------

--
-- Structure de la table `media`
--

DROP TABLE IF EXISTS `media`;
CREATE TABLE IF NOT EXISTS `media` (
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
  `alt_text` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_6A2CA10C5CC5DB90` (`storage_id`),
  KEY `IDX_6A2CA10C126F525E` (`item_id`),
  KEY `item_position` (`item_id`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `migration`
--

DROP TABLE IF EXISTS `migration`;
CREATE TABLE IF NOT EXISTS `migration` (
  `version` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`version`)
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

DROP TABLE IF EXISTS `module`;
CREATE TABLE IF NOT EXISTS `module` (
  `id` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `module`
--

INSERT INTO `module` (`id`, `is_active`, `version`) VALUES
('CSVImport', 1, '2.6.2');

-- --------------------------------------------------------

--
-- Structure de la table `password_creation`
--

DROP TABLE IF EXISTS `password_creation`;
CREATE TABLE IF NOT EXISTS `password_creation` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `user_id` int NOT NULL,
  `created` datetime NOT NULL,
  `activate` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_C77917B4A76ED395` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `property`
--

DROP TABLE IF EXISTS `property`;
CREATE TABLE IF NOT EXISTS `property` (
  `id` int NOT NULL AUTO_INCREMENT,
  `owner_id` int DEFAULT NULL,
  `vocabulary_id` int NOT NULL,
  `local_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8BF21CDEAD0E05F6623C14D5` (`vocabulary_id`,`local_name`),
  KEY `IDX_8BF21CDE7E3C61F9` (`owner_id`),
  KEY `IDX_8BF21CDEAD0E05F6` (`vocabulary_id`)
) ENGINE=InnoDB AUTO_INCREMENT=211 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(186, 1, 6, 'code', 'Code EC', NULL),
(187, 1, 6, 'age', 'Age', NULL),
(188, 1, 6, 'gender', 'Gender', NULL),
(189, 1, 6, 'mail', 'Mail', NULL),
(190, 1, 6, 'birthday', 'Birthday', NULL),
(191, 1, 7, 'timeSubmit', 'Date de soumission', NULL),
(192, 1, 7, 'sexe', 'Sexe', NULL),
(193, 1, 7, 'age', 'Age', NULL),
(194, 1, 7, 'fume', 'Fume', NULL),
(195, 1, 7, 'sport', 'Sport', NULL),
(196, 1, 7, 'alcool', 'Consommation d\'Alcool', NULL),
(197, 1, 7, 'mail', 'Email', NULL),
(198, 1, 7, 'nom', 'Nom du Cabinet', NULL),
(199, 1, 7, 'adresse', 'Adresse', NULL),
(200, 1, 7, 'specialite', 'Spécialité Médicale', NULL),
(201, 1, 7, 'appointmentDate', 'Date du Rendez-vous', NULL),
(202, 1, 7, 'phone', 'Téléphone du Patient', NULL),
(203, 1, 7, 'isValidated', 'Validation du Rendez-vous', NULL),
(204, 1, 7, 'securiteSociale', 'Numéro de Sécurité Sociale', NULL),
(205, 1, 7, 'username', 'Nom d\'Utilisateur', NULL),
(206, 1, 7, 'password', 'Mot de Passe', NULL),
(207, 1, 7, 'role', 'Rôle', NULL),
(208, 1, 7, 'telephone', 'Numéro de Téléphone', NULL),
(209, 1, 7, 'specialisation', 'Spécialisation du Médecin', NULL),
(210, 1, 7, 'cabinetAssocie', 'Cabinet Associé', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `resource`
--

DROP TABLE IF EXISTS `resource`;
CREATE TABLE IF NOT EXISTS `resource` (
  `id` int NOT NULL AUTO_INCREMENT,
  `owner_id` int DEFAULT NULL,
  `resource_class_id` int DEFAULT NULL,
  `resource_template_id` int DEFAULT NULL,
  `thumbnail_id` int DEFAULT NULL,
  `title` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `is_public` tinyint(1) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  `resource_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_BC91F4167E3C61F9` (`owner_id`),
  KEY `IDX_BC91F416448CC1BD` (`resource_class_id`),
  KEY `IDX_BC91F41616131EA` (`resource_template_id`),
  KEY `IDX_BC91F416FDFF2E92` (`thumbnail_id`),
  KEY `title` (`title`(190)),
  KEY `is_public` (`is_public`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `resource`
--

INSERT INTO `resource` (`id`, `owner_id`, `resource_class_id`, `resource_template_id`, `thumbnail_id`, `title`, `is_public`, `created`, `modified`, `resource_type`) VALUES
(19, 1, 110, 9, NULL, NULL, 1, '2024-11-06 09:42:27', '2024-11-06 09:42:27', 'Omeka\\Entity\\Item'),
(20, 1, 110, 9, NULL, NULL, 1, '2024-11-06 09:42:27', '2024-11-06 09:42:27', 'Omeka\\Entity\\Item'),
(21, 1, 110, 9, NULL, NULL, 1, '2024-11-06 09:42:27', '2024-11-06 09:42:27', 'Omeka\\Entity\\Item'),
(22, 1, 110, 9, NULL, NULL, 1, '2024-11-06 09:42:27', '2024-11-06 09:42:27', 'Omeka\\Entity\\Item'),
(23, 1, 110, 9, NULL, NULL, 1, '2024-11-06 09:42:27', '2024-11-06 09:42:27', 'Omeka\\Entity\\Item'),
(24, 1, 110, 9, NULL, NULL, 1, '2024-11-06 09:42:27', '2024-11-06 09:42:27', 'Omeka\\Entity\\Item'),
(25, 1, 110, 9, NULL, NULL, 1, '2024-11-06 09:42:27', '2024-11-06 09:42:27', 'Omeka\\Entity\\Item'),
(26, 1, 110, 9, NULL, NULL, 1, '2024-11-06 09:42:27', '2024-11-06 09:42:27', 'Omeka\\Entity\\Item'),
(27, 1, 110, 9, NULL, NULL, 1, '2024-11-06 09:42:27', '2024-11-06 09:42:27', 'Omeka\\Entity\\Item'),
(28, 1, 110, 9, NULL, NULL, 1, '2024-11-06 09:42:27', '2024-11-06 09:42:27', 'Omeka\\Entity\\Item'),
(29, 1, 110, 9, NULL, NULL, 1, '2024-11-06 09:42:27', '2024-11-06 09:42:27', 'Omeka\\Entity\\Item'),
(30, 1, 110, 9, NULL, NULL, 1, '2024-11-06 09:42:27', '2024-11-06 09:42:27', 'Omeka\\Entity\\Item'),
(31, 1, 110, 9, NULL, NULL, 1, '2024-11-06 09:42:27', '2024-11-06 09:55:36', 'Omeka\\Entity\\Item'),
(32, 1, 113, 7, NULL, NULL, 1, '2024-11-06 09:46:54', '2024-11-06 09:46:54', 'Omeka\\Entity\\ItemSet'),
(33, 1, 114, 8, NULL, NULL, 1, '2024-11-06 09:47:49', '2024-11-06 09:47:49', 'Omeka\\Entity\\ItemSet'),
(34, 1, 110, 9, NULL, NULL, 1, '2024-11-06 09:49:29', '2024-11-06 09:49:29', 'Omeka\\Entity\\ItemSet'),
(35, 1, 111, 11, NULL, NULL, 1, '2024-11-06 09:50:15', '2024-11-06 09:50:15', 'Omeka\\Entity\\ItemSet'),
(36, 1, 115, 10, NULL, NULL, 1, '2024-11-06 09:51:39', '2024-11-06 09:51:39', 'Omeka\\Entity\\ItemSet'),
(37, 1, 112, 12, NULL, NULL, 1, '2024-11-06 09:52:43', '2024-11-06 09:54:23', 'Omeka\\Entity\\ItemSet');

-- --------------------------------------------------------

--
-- Structure de la table `resource_class`
--

DROP TABLE IF EXISTS `resource_class`;
CREATE TABLE IF NOT EXISTS `resource_class` (
  `id` int NOT NULL AUTO_INCREMENT,
  `owner_id` int DEFAULT NULL,
  `vocabulary_id` int NOT NULL,
  `local_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_C6F063ADAD0E05F6623C14D5` (`vocabulary_id`,`local_name`),
  KEY `IDX_C6F063AD7E3C61F9` (`owner_id`),
  KEY `IDX_C6F063ADAD0E05F6` (`vocabulary_id`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(108, 1, 6, 'Departement', 'Département', NULL),
(109, 1, 6, 'Etudiant', 'Étudiant', NULL),
(110, 1, 7, 'Patient', 'Patient', 'Représente un patient du cabinet médical'),
(111, 1, 7, 'Cabinet', 'Cabinet Médical', 'Représente un cabinet médical'),
(112, 1, 7, 'Appointment', 'Rendez-vous', 'Représente un rendez-vous médical'),
(113, 1, 7, 'User', 'Utilisateur', 'Représente un utilisateur dans le système (admin, médecin, patient)'),
(114, 1, 7, 'Admin', 'Administrateur', 'Représente un administrateur du système'),
(115, 1, 7, 'Medecin', 'Médecin', 'Représente un médecin dans le cabinet médical');

-- --------------------------------------------------------

--
-- Structure de la table `resource_template`
--

DROP TABLE IF EXISTS `resource_template`;
CREATE TABLE IF NOT EXISTS `resource_template` (
  `id` int NOT NULL AUTO_INCREMENT,
  `owner_id` int DEFAULT NULL,
  `resource_class_id` int DEFAULT NULL,
  `title_property_id` int DEFAULT NULL,
  `description_property_id` int DEFAULT NULL,
  `label` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_39ECD52EEA750E8` (`label`),
  KEY `IDX_39ECD52E7E3C61F9` (`owner_id`),
  KEY `IDX_39ECD52E448CC1BD` (`resource_class_id`),
  KEY `IDX_39ECD52E724734A3` (`title_property_id`),
  KEY `IDX_39ECD52EB84E0D1D` (`description_property_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `resource_template`
--

INSERT INTO `resource_template` (`id`, `owner_id`, `resource_class_id`, `title_property_id`, `description_property_id`, `label`) VALUES
(1, NULL, NULL, NULL, NULL, 'Base Resource'),
(7, 1, 113, NULL, NULL, 'User'),
(8, 1, 114, NULL, NULL, 'Admin'),
(9, 1, 110, NULL, NULL, 'Patient'),
(10, 1, 115, NULL, NULL, 'Medecin'),
(11, 1, 111, NULL, NULL, 'cabinet'),
(12, 1, 112, NULL, NULL, 'appointment');

-- --------------------------------------------------------

--
-- Structure de la table `resource_template_property`
--

DROP TABLE IF EXISTS `resource_template_property`;
CREATE TABLE IF NOT EXISTS `resource_template_property` (
  `id` int NOT NULL AUTO_INCREMENT,
  `resource_template_id` int NOT NULL,
  `property_id` int NOT NULL,
  `alternate_label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alternate_comment` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT NULL,
  `data_type` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json_array)',
  `is_required` tinyint(1) NOT NULL,
  `is_private` tinyint(1) NOT NULL,
  `default_lang` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_4689E2F116131EA549213EC` (`resource_template_id`,`property_id`),
  KEY `IDX_4689E2F116131EA` (`resource_template_id`),
  KEY `IDX_4689E2F1549213EC` (`property_id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(43, 7, 197, NULL, NULL, 1, NULL, 0, 0, NULL),
(44, 7, 205, NULL, NULL, 2, NULL, 0, 0, NULL),
(45, 7, 207, NULL, NULL, 3, NULL, 0, 0, NULL),
(46, 7, 206, NULL, NULL, 4, NULL, 0, 0, NULL),
(47, 8, 197, NULL, NULL, 1, NULL, 0, 0, NULL),
(48, 8, 205, NULL, NULL, 2, NULL, 0, 0, NULL),
(49, 8, 208, NULL, NULL, 3, NULL, 0, 0, NULL),
(50, 8, 207, NULL, NULL, 4, NULL, 0, 0, NULL),
(51, 8, 206, NULL, NULL, 5, NULL, 0, 0, NULL),
(52, 9, 197, NULL, NULL, 1, NULL, 0, 0, NULL),
(53, 9, 205, NULL, NULL, 2, NULL, 0, 0, NULL),
(54, 9, 207, NULL, NULL, 3, NULL, 0, 0, NULL),
(55, 9, 192, NULL, NULL, 4, NULL, 0, 0, NULL),
(56, 9, 193, NULL, NULL, 5, NULL, 0, 0, NULL),
(57, 9, 204, NULL, NULL, 6, NULL, 0, 0, NULL),
(58, 9, 202, NULL, NULL, 7, NULL, 0, 0, NULL),
(59, 9, 195, NULL, NULL, 8, NULL, 0, 0, NULL),
(60, 9, 196, NULL, NULL, 9, NULL, 0, 0, NULL),
(61, 9, 194, NULL, NULL, 10, NULL, 0, 0, NULL),
(62, 9, 201, NULL, NULL, 11, NULL, 0, 0, NULL),
(63, 9, 206, NULL, NULL, 12, NULL, 0, 0, NULL),
(64, 10, 197, NULL, NULL, 1, NULL, 0, 0, NULL),
(65, 10, 205, NULL, NULL, 2, NULL, 0, 0, NULL),
(66, 10, 207, NULL, NULL, 3, NULL, 0, 0, NULL),
(67, 10, 210, NULL, NULL, 4, NULL, 0, 0, NULL),
(68, 10, 209, NULL, NULL, 5, NULL, 0, 0, NULL),
(69, 10, 208, NULL, NULL, 6, NULL, 0, 0, NULL),
(70, 10, 206, NULL, NULL, 7, NULL, 0, 0, NULL),
(71, 11, 198, NULL, NULL, 1, NULL, 0, 0, NULL),
(72, 11, 199, NULL, NULL, 2, NULL, 0, 0, NULL),
(73, 11, 200, NULL, NULL, 3, NULL, 0, 0, NULL),
(74, 12, 201, NULL, NULL, 1, NULL, 0, 0, NULL),
(75, 12, 202, NULL, NULL, 2, NULL, 0, 0, NULL),
(76, 12, 203, NULL, NULL, 3, NULL, 0, 0, NULL),
(77, 12, 204, NULL, NULL, 4, NULL, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `session`
--

DROP TABLE IF EXISTS `session`;
CREATE TABLE IF NOT EXISTS `session` (
  `id` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` longblob NOT NULL,
  `modified` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `session`
--

INSERT INTO `session` (`id`, `data`, `modified`) VALUES
('15v7e850u3gl54cbh97m5bc4ej', 0x5f5f4c616d696e61737c613a333a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313732373638343433302e3333373739363b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a22656e733471716a393239617271686f70367376366c37686c7535223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313732373732373631373b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223132303262666330373162373934386132653735333534393363636266663537223b733a33323a223632346239663466653038363265363762663364383966316465303531656466223b7d733a343a2268617368223b733a36353a2236323462396634666530383632653637626633643839663164653035316564662d3132303262666330373162373934386132653735333534393363636266663537223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d72656469726563745f75726c7c4e3b, 1727684430),
('1bb3u1uhhshvpkf387qjbvcnon', 0x5f5f4c616d696e61737c613a333a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313733303034353337302e3731343333333b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a223468696c356e67686f6a303469733668663169726332726c3739223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303038383437363b7d7d72656469726563745f75726c7c733a33363a22687474703a2f2f6c6f63616c686f73742f53697465732f6f6d656b612d732f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226638626262666461373434646437393761313234373733663061343364353735223b733a33323a223530643963636563323537323433333061376439313234306637346162303231223b7d733a343a2268617368223b733a36353a2235306439636365633235373234333330613764393132343066373461623032312d6638626262666461373434646437393761313234373733663061343364353735223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1730045370),
('1d0njd02i2k9gkgauukmi4dgjm', 0x5f5f4c616d696e61737c613a343a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313732393238303036362e3138313238383b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a22307666616a6438306b6e646472696664306b3670636269696573223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313732393331343538373b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313732393332333233353b7d7d72656469726563745f75726c7c733a35303a22687474703a2f2f6c6f63616c686f73742f53697465732f6f6d656b612d732f61646d696e2f637376696d706f72742f6d6170223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223362396164326466646461376565386661326536333237663639306363326364223b733a33323a226563343836643662633863343763313131366261626538353530316363313463223b7d733a343a2268617368223b733a36353a2265633438366436626338633437633131313662616265383535303163633134632d3362396164326466646461376565386661326536333237663639306363326364223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a32383a7b733a33323a223630313230376634353265636530353937623835343530366232666532323366223b733a33323a223633393161656638393862653865656132366336363535343239313331333765223b733a33323a226638353535313665646465323762616564333537396431623935626463303764223b733a33323a226563663335333433613738623439383464313734363030303230623362396234223b733a33323a226662343262316136356530653731303738393363623661643134623038633133223b733a33323a223730356439386333373432383734323830393234383766363864653238303735223b733a33323a223930376664653863356262643637636162333664383832643730376631353533223b733a33323a226230633865373930346663343233323538383866383166613739343234346134223b733a33323a226231373331643636306561633266316237393339663961303230303662373434223b733a33323a226138373261633038313665356438303237376439383736343964323233616266223b733a33323a223938396265663530373234623039623138353538396135366137643137346637223b733a33323a223361333066323337366235653262356264653036623134376161656134643339223b733a33323a226335366163626463623432353530336265333532306638303036626636653965223b733a33323a223337326165613630636338633536333066643839613061643137316366636364223b733a33323a223231303034393438386530343865613636366631363931643463313931366131223b733a33323a223637373834636362393031633737306563366238363630656430623465383338223b733a33323a223062616364623830653064303665313831313034376637666266303038383664223b733a33323a226130353763366565333635653063656462663062633235336133383166386632223b733a33323a226234643561306438373935343933386565663537383731363231646330396434223b733a33323a226439383264333466393237633839323036633365653639623363303831666330223b733a33323a223532633732353861353537323661393039363861613064343462313637366663223b733a33323a223331326262373835333165303166616562653864363633356536626132623266223b733a33323a226161356366613564336432383935626135653737653563373839363732656366223b733a33323a223062316662306133633935353532323135326539356161623066393865303136223b733a33323a223134383239336237396163386437373464346231663461656636396361373734223b733a33323a223965326631326563636333646231343937616638323338623535316634333038223b733a33323a223231366666646431613234646433346636646466316462316664363730323231223b733a33323a226661656136316339376665363335313564326238343466343834353637383133223b733a33323a223039333761663139343633396135333537623536646632393931643865333061223b733a33323a223033363863613263323132636261396239663836646566666362633634373736223b733a33323a223631386632343239383663646166393165323939626630653433326466396531223b733a33323a226538333638393332663765653665653533633765616564333465353165643731223b733a33323a223032393562666636643231363766633836336631346263376635633265386464223b733a33323a226139383131323237346466303562333531366138303462306437346333663639223b733a33323a226634393639633261356630333938633666653432393863303032633338623961223b733a33323a223632613137656438623765613364613538633966306135333066353138626138223b733a33323a226262313761666637363036346138333966626161346261303238313931383338223b733a33323a226637336337663639626338383437316261346232346132643535353732373933223b733a33323a223061653536363739613736303831383037366232313161383766363536663061223b733a33323a223333666137633439366538643434613830323833326632356666306165383564223b733a33323a223362613734633336653433646539306631306465323664303061303364326664223b733a33323a223765323631323263623161663434623930346364663935383933656565656630223b733a33323a226331663434373463616561323261363037346466353032393166636666643839223b733a33323a223762396335306536303862616432316262616463363634636664343730353835223b733a33323a223431666235333237306535363865316362386635353038353039653231303363223b733a33323a223863363232363839373263356538333462313166323061346665626634633138223b733a33323a226434323764623037333635343331636566663432313634326134326439393161223b733a33323a223937393466373030666138633731396334366561636163326637366232653664223b733a33323a226662626636666436623933386532333330393632356330306431353136396666223b733a33323a223534373666306361623037303032366534313263636634636135333464353961223b733a33323a226630336366316333613639303137626236643766643036353535393438656566223b733a33323a223237636362623464323537623835376630353833383066386230666539366239223b733a33323a226537393033396433646133646664306432336533653063663133306263386230223b733a33323a223934376532356233303062353765386538623239313762663462663863386434223b733a33323a223265623934386333316134356533373430333834383039656130346131653961223b733a33323a223335636130326465663938353538653138653765323866393263663539663838223b7d733a343a2268617368223b733a36353a2233356361303264656639383535386531386537653238663932636635396638382d3265623934386333316134356533373430333834383039656130346131653961223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1729280066),
('2ish5eqnss0j9kuc24eacc2j87', 0x5f5f4c616d696e61737c613a343a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313733303533383338352e3539373438373b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a22636b3537396d396e73377673686f35696c7573396e626773306a223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303538313531393b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313733303538313534363b7d7d72656469726563745f75726c7c733a33363a22687474703a2f2f6c6f63616c686f73742f53697465732f6f6d656b612d732f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226634306265313638313831303539663162303235396364376139393965376562223b733a33323a223662633661613966333033333135326261323666666461363037636331613834223b7d733a343a2268617368223b733a36353a2236626336616139663330333331353262613236666664613630376363316138342d6634306265313638313831303539663162303235396364376139393965376562223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a323a7b733a33323a226531333862393832653536626464396164303635633061666461393766396430223b733a33323a223932386162316566383139353134653038663535323332363739306436383233223b733a33323a226162343132663431333132376430383733363361613761643233373063373235223b733a33323a223032336539326162666435643834363762303165363566303834356235616239223b7d733a343a2268617368223b733a36353a2230323365393261626664356438343637623031653635663038343562356162392d6162343132663431333132376430383733363361613761643233373063373235223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1730538385),
('2vqoiqu6hd5snopn26ui5i9i8m', 0x5f5f4c616d696e61737c613a363a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313733303838363939302e3130303230333b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a22666c3472703268307175706a7370666876736c316e3174696f76223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303932383333353b7d733a34343a224c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303933303136323b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313733303933303037343b7d733a35333a224c616d696e61735f56616c696461746f725f437372665f73616c745f7265736f7572636574656d706c617465666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303933303136313b7d7d72656469726563745f75726c7c733a33363a22687474703a2f2f6c6f63616c686f73742f53697465732f6f6d656b612d732f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226432653761663938666462653064326234616364663734323531386461343835223b733a33323a223935653434316434326437633637323730383065303736393962616534663438223b7d733a343a2268617368223b733a36353a2239356534343164343264376336373237303830653037363939626165346634382d6432653761663938666462653064326234616364663734323531386461343835223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a39303a7b733a33323a223863653262323665396633306133616632653564333435306334376537633262223b733a33323a223230343664323465333139653562373436383364646565346535633161656635223b733a33323a223337643435343238656433363037656131343966393836613766306536306436223b733a33323a223630623961313437646463383235333061393264633735326438303034623137223b733a33323a223335343833623333633437663231303735613165323534373939306262656337223b733a33323a226432653033343064653430356261343264613533366565396334636635373661223b733a33323a226362663536336462633334313264383435616530343166666334373138326336223b733a33323a223239643531376264343930313038343431656564643832343039636336343030223b733a33323a223336623932623239383332616665303931656439326530303932343938396436223b733a33323a223463313436306632393831356532643633613838353735653039363562323761223b733a33323a223165393938323036353235313635393938623064653637616239366531313365223b733a33323a223932653730366338366634303138393536326237396261643731653864666538223b733a33323a223337303064323638396439346332653634323733623364333637633134316363223b733a33323a223962396638326231316137383962306439643330373465333337303936643731223b733a33323a226664343265623265623864313038663361633337393732346530623036653436223b733a33323a226465663337353130616437333863336334376639343864636562616338376461223b733a33323a226336383838623665643534343735303236636435383562313436613564383638223b733a33323a223636306338616232636463316338353430323430626261366332306466343038223b733a33323a226265396261626162646330613736313566636632376265336638623262383162223b733a33323a223262666231323934316433373130393566653734373732333063383163353335223b733a33323a226535363735616336666264636630626261663861306233613730343936643134223b733a33323a226234356136633938646663303665326633396266623761346635396562393430223b733a33323a223539333064383933393363643266613638633861356337323934353937346233223b733a33323a223134333862623464313032323039306536336339646166383332343861313161223b733a33323a223431613136633436313237376663363637346130313565376136643361343165223b733a33323a226632373264623465616336386163666435663734356161376461363561373139223b733a33323a223837653138393136663135316331373466323538346331396366376664366539223b733a33323a226137373233663035616537633365333365613638363037323436613439346335223b733a33323a223539313663316137303032383839313330343433356263386262386264653063223b733a33323a223030646531303763613430323733616364623362316637333163343733336433223b733a33323a226666336336393838376265353263363266623831336634656532343164393132223b733a33323a223534646230386461626461353637323265376134663534336239313733383031223b733a33323a223533313930326661386563313937623631393230643166653366663739323266223b733a33323a223435333163616266323364373130653765366634613539333762366361373466223b733a33323a226364383233333461663865353164653435343166646564313434653537306164223b733a33323a223331306461396232343431316230326430646463353037376535303866356238223b733a33323a223363333333383337356461633637666137366534393531313662386262383138223b733a33323a223965353436663130323931626331366633636265623062323036343637633038223b733a33323a223435323762396161306465396265316165383732326330353234316163643433223b733a33323a223236376335616231303635363334333632373732643763383963363739626430223b733a33323a223465363564323634663036383236336466356539366361326662343330366139223b733a33323a223435313334626362613964343862666363396336616532326261316137333036223b733a33323a226233373930653364396165323930306538623562356664326364643162343162223b733a33323a223635313130333935336464653932316537376362376139363034623530333831223b733a33323a226464656237303363666165376234363661336162373965303563656633306365223b733a33323a223233306666663233323362653465353639643062666530313437363966663564223b733a33323a226633633166656638633539393532643766303566656265346461663030396539223b733a33323a226364623635376138303631333361343463366134633131626334626133326135223b733a33323a226266353933653462353932353136646235356433303863396538346539633264223b733a33323a223535393861346437306233333165613537356538313661336563313461353731223b733a33323a226537363734643537316163633334303666626430366265663037393361333163223b733a33323a223435373261646564626635653938336236663032353564313830313139366232223b733a33323a226537613266316436653262626336376330393464316534313238353638613536223b733a33323a223464306438376539386465393039323365643132303565313530366466326266223b733a33323a223631376439303461653261386131353163613532313538373935346466376534223b733a33323a226235373165666565626534626134616661313938386138333334333432643837223b733a33323a223538633762363063616662373265306538626137306666396662353433333663223b733a33323a223330613736623834373433313338373838643131396539303730316534373433223b733a33323a223938666533326531343836623136393334303938376332643466313038313934223b733a33323a226334623937363935633138303162626231393665303137396430363864666630223b733a33323a223461323735636635353465323230656432383764316633653230633736313830223b733a33323a226231336538653461363433663636343639383736663262306338616134383333223b733a33323a226462336436316163663934653337333465663933623535336436633632623963223b733a33323a226433373238613762333661383432623865323137396233376133336166653863223b733a33323a223764326134663430363061323136616263356366653530633430303534613339223b733a33323a226530626233653264356362633536353138636336393939336632363031383131223b733a33323a226539376163636235333437323633373936643963633666316434373761333338223b733a33323a223863616462623666356337616337613430316465636238393366366538633835223b733a33323a223937666263633036323238383461326631396239313137363164333530633637223b733a33323a226335356661383564653665363234333137643866323235613762333239393637223b733a33323a223361313864646461383462393163373234336639666464653963323330613830223b733a33323a223565363365656232336366663037353935376461376663313231353566343264223b733a33323a226366333630393030633161333432363263666132393238636236656337393566223b733a33323a226536343561646331396632376438316663306432646365326433346665356363223b733a33323a226330333335323634646531373232313231313337346135663039386536656630223b733a33323a223932356631313132383230323066346630303331383734333462303532366137223b733a33323a226263383165383666626331363939376666613736666539333531653163636133223b733a33323a223863613239656130626363346330633138373363636662666436636633323334223b733a33323a226662663163346165306361636534313637333564663438353633343064333562223b733a33323a226135633863333035313636383264323231393333393566366638666537666235223b733a33323a226333336130376166323531666435316366353636346437333232616563366131223b733a33323a223230666336646534613733363237343439663634383864636331636362643632223b733a33323a223863643263323937643936383936313765316236376164666439613435393339223b733a33323a226164613334616133613762336538666530383561653366363361653863363961223b733a33323a226165393864613531646334323633646532623338663730333430633364643331223b733a33323a226231613834393831666265343131373464366461366531323764316333336435223b733a33323a226239366132323633383965663536653462376237613130653632366438626335223b733a33323a223839393438613432353834313237623666303838383430366632303432333066223b733a33323a223866623763626266656330336232383861353333326461313932366266613233223b733a33323a223061356535363864326333313237393630356336396561653361333735323533223b733a33323a223366386465653361323762626538346566333132353133643037393335636230223b733a33323a223039643733343938376231333439663264613430653937333661656135376334223b733a33323a223463353033336665353433666434333064666333393766623164333535386339223b733a33323a223861626564356230343837656630626134373536636564636239346632663666223b733a33323a223465303165333333346636303430666137653963376231616334393834643932223b733a33323a226638663039343764356332633561343164646238303430656335363764383365223b733a33323a223536323164633239646232306433336262356533363164613432616338643662223b733a33323a223936646166323561623839346365373539633538616637376564383031623130223b733a33323a223734386164376665616261343334653339343739653034623863643239663934223b733a33323a223334616138303264303862303339313230376562653764386461663563303766223b733a33323a223035333338383462636230373331616265393764653165666537643232376264223b733a33323a223565346333646334373561643865643931333263343237346538303332363335223b733a33323a226439373734333838396133626234343434373535383337343266373364663036223b733a33323a223261383437326632333338646131366139623666343561343235326534303765223b733a33323a226533313064373133323533346265363833336465326536313234663663336666223b733a33323a223764356334326165323539653764613962613439373066653866653234613539223b733a33323a223565376337313161363033633062633265346434623238323266653537323665223b733a33323a226365666564613262306364313865303565313334353363363238346433386466223b733a33323a226461303531643462393535376438653632663262633965663638303665303538223b733a33323a226164336339653333633035383831656532636134373438333535346131356338223b733a33323a226263396433616562653038666131306265616532386235313465323837363833223b733a33323a226463356263616537633133303762323434363838666232356331373430313037223b733a33323a226165363235383135356366653030616533353562383932393462306161303832223b733a33323a223564623235626661303932373133616435376630336539383334626263376336223b733a33323a226661356637626539386464373730313362376536623366613738633535633537223b733a33323a223430383434613933343532633136343565663639633430333631316336393162223b733a33323a223632363036306538646436363466346162663261643966636366393734346534223b733a33323a226138326230666239323837306535613931646466396133393131386537666162223b733a33323a223230666537656162383731353932666263613731616234383333636639363264223b733a33323a223666356663653965373132393335633966316231396138353636643561666265223b733a33323a223937363065306537353065363164366639323232373032326361313138313239223b733a33323a223466373430316266313334323165316265366361356237336230666438653532223b733a33323a223966336564343339363535643234393137343265303732323865656636616439223b733a33323a226234396330303433643530363234363130323333353039656435303962313332223b733a33323a226666643533316630333566356565373336333434333165343864623866373330223b733a33323a226131333336326163343661633861623439333232323665323836323432613361223b733a33323a226364666636383764396338633238323434343766343866646538373662646535223b733a33323a223834346437393663343539393436346565323630343937343836316332353930223b733a33323a226561346335353661303065313138393866333935326166643262623865303561223b733a33323a223161363366326435653366353536633034663838636238323932656233383461223b733a33323a223433343363643662383763383832383639306331303364323964653832383131223b733a33323a223535313733653539376361373834323335653137656563623039626636366662223b733a33323a223531363462373439326161386362373538313837613763623865613963303831223b733a33323a223336346633326565373134393266393035316134333637396330386632663963223b733a33323a223631376163613833373661376333363338653062346164386335666365323936223b733a33323a223861653336343930313734636330616439333430313466376462313335333930223b733a33323a226433306532643732383736616536623366393730643261653930633435663039223b733a33323a223339346233663065316662353430383035316166626266666233636636633835223b733a33323a223762386639363539336663383532323036376538386134613861613932383939223b733a33323a226439343739366531393135343963663361383163303662333137633532313965223b733a33323a226431353835303538376664663139363465353539653837376630616462326465223b733a33323a226664376134646433363761356230383965333539613730306264316536356231223b733a33323a226239383262366464666633343835343834623932636566666230623331646438223b733a33323a226534666231366163666163363262646162623038663932653565663331333463223b733a33323a226166623039633432643337353135343061663363633161656631316162343132223b733a33323a226266343333373033653162666233306263373235643563333264663761386432223b733a33323a223838343961363734366637353735393465343730366562353434363035663265223b733a33323a226632373065653834313963646230663165316166653561623763616432653732223b733a33323a223733656134306533336133343966376332663632316232306232313865663562223b733a33323a223038626439343734343261313530333763396161623331306134343262313166223b733a33323a226464386537393634613564353033356530383739303838393963636165343761223b733a33323a223965333533373632623133343261313232613639663030623333653138626531223b733a33323a223934326565353661323637646433613461623761313730323933356565343132223b733a33323a223232613462303135616536623530613334316533643364363763333137663334223b733a33323a223938643831663762333264323165323663373965336131363364316263663762223b733a33323a226535643637636239666534393435363665623565633338303762386432346135223b733a33323a223264383130323839646534386636663136616466336633396533366463313631223b733a33323a226564383636653835633530353931326330653061366136323762616538383439223b733a33323a226237626366306564373336613333316533636130323933363533393237353932223b733a33323a226337343238306132653835346262613930343537333938616365306566613664223b733a33323a223636343534373731643266303063363963363263613635336133383939373265223b733a33323a223261313937336263373364376636303165633831383966323930383936623937223b733a33323a226536666335616236326232663839393934343065653264613438623136316665223b733a33323a223537633537366334616237363237663363643366336533306535613535343531223b733a33323a223534393335633363333866353363353332326333393333633931616430306464223b733a33323a223236616230366333353733393065646430386331616534323139666133346635223b733a33323a223636343863373766323339663664653462643731306161346361353339646463223b733a33323a223038356535306665386330316133313864373635363561353737363735363231223b733a33323a226564313634323131663930303365373033636366636332393961623338636335223b733a33323a223662343663643131666231626533313039663032323036646232333138343931223b733a33323a226139656664623438316131633830623736333566373531323966313661376136223b733a33323a226165326330643465356433346330623432393331666337353635613930633561223b733a33323a223138323530393935636431616365653435343166376337646462353531376536223b733a33323a226261323338313533663931323836353461386337326237393332656361333938223b733a33323a226631653164663738623565343561343934323664316234633535336432316335223b733a33323a223464626162366563303535623863656132633539643464623164303130313736223b733a33323a223938303563333232653832303933383633313938313961643263396531613663223b733a33323a223866643839393363343839663264313866383834366264373938333339333162223b733a33323a226432383031313162383538376139393664656439363363383030633063323430223b733a33323a223838623236316336333531333465626432666361353034643236323966613065223b7d733a343a2268617368223b733a36353a2238386232363163363335313334656264326663613530346432363239666130652d6432383031313162383538376139393664656439363363383030633063323430223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a31393a7b733a33323a223639303632383331383034613162613362313062306564653762323937336237223b733a33323a223530386466636331636338643235336436643566663635326434363565383366223b733a33323a223538386365643361656438353537346339666361663666656333333631663237223b733a33323a223432396630386133643462303830303063646634663463656237306165353063223b733a33323a223030663663643363323531396430616162633333626535363263653237333365223b733a33323a226463386338646532316661313532626463326635333165393036343634663535223b733a33323a226332373639373230303237396335393330336131383161343631613837383066223b733a33323a223432346165663961386332616262656532633632623931336566303964313637223b733a33323a226433316236376334343930623363326538326562356465636133653934613430223b733a33323a223631333735633436386166343135393333616639643731623436656161613966223b733a33323a223262363333303432346561363033663835633930623462353261353766306334223b733a33323a226462616662353430363362313930623139623931626334633466386638633038223b733a33323a223632623531303037653633353539373533383761633530306637363266656637223b733a33323a226630333233353665326664393632306461326264356165333233316239323832223b733a33323a226462656235373930306134353638626164616562643535613630393233663562223b733a33323a223862626161626235653333363130383239333539343263613862386563363761223b733a33323a223664373135316166373061393463316634666434313230373733323264623536223b733a33323a226431386462643934353666386264643165633134356332663231333132323630223b733a33323a226639626639373132653265373831643962383136383761656361646638313134223b733a33323a223635336563633066643632363738623134633665623366623536633364636233223b733a33323a223130333863653536373235383431383563326234306635333734353564353335223b733a33323a226633666266343239623235343766353530323236343734336665386237653732223b733a33323a226332303837303134303262646134653531316437393535323264303836333061223b733a33323a226238663737383965386533643037353233623037323938653138613563306339223b733a33323a226165326637656363333636313532643461363762313432626231643963313162223b733a33323a223931613266646563373633656533623732636666663164373766393637653566223b733a33323a223864316632303334666661306266383439646532326139386664333139396466223b733a33323a223463313039313434653465653639323539633831656536393063353963373532223b733a33323a223739643130663338366537306236323538653432373662323231656364636337223b733a33323a223434306234306562643633336631343731623836666335306334633762303632223b733a33323a226437323431633839633065326439343837643331383735636531613439316331223b733a33323a226562643937643166616337376364303633366666623733653637633431363435223b733a33323a223137363333653265356338326166343365666266653734336338616337626363223b733a33323a226532326239663733646533333433373538653361363534386335333736666638223b733a33323a226531353465383462363933386461356139616165313238363537313535373030223b733a33323a223731376139343837663935663862313632316532383366383936333931336436223b733a33323a223731653933376466636430393832343764623361366433303136386462373366223b733a33323a226637313435656233353765663463623335343831646262383136386130326234223b7d733a343a2268617368223b733a36353a2266373134356562333537656634636233353438316462623831363861303262342d3731653933376466636430393832343764623361366433303136386462373366223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f7265736f7572636574656d706c617465666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a393a7b733a33323a223966323233323765316133636231316536616238343639356330616633313839223b733a33323a226333383964333966313033616634313633363837373638336131363166656463223b733a33323a223964613564303836393464666661663236336535383431343634363064633465223b733a33323a223532386333643538353861343234666366316230643038656364323237303065223b733a33323a226162353730643737656162653330613566646430346238626465656639326464223b733a33323a223933663331303664653336323065393163393666373539666239393536333262223b733a33323a223963346231353965373235613665643330386231373765303461343366383336223b733a33323a226634393964353637326434643830383066613565643435346265393537386631223b733a33323a223632663431316339653139633237363462376665323139363464376535333138223b733a33323a226231356437396637363131326363313737663366363461663365376333616335223b733a33323a226232326165633363346234643864383563656463646138333238613466333233223b733a33323a226335656261343137666638653938336364323861363365373033363738373632223b733a33323a223037633465313562363865646564396534333962396561353737383365373065223b733a33323a223863353936396533646130346634333733343763616333356235373663396636223b733a33323a223438353232393235643032633365333835306439353662343562653136643466223b733a33323a223366323139336366313739386362323336636563366337323031346233333237223b733a33323a226432323162373636653536633666393765363565616438353261363434386466223b733a33323a223933643362396438346135313162383764613434356463326236386339336565223b7d733a343a2268617368223b733a36353a2239336433623964383461353131623837646134343564633262363863393365652d6432323162373636653536633666393765363565616438353261363434386466223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1730886990),
('3vgv0eknppkpv1tikgqdi9m7m6', 0x5f5f4c616d696e61737c613a343a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313732393234333839322e3035363938333b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a226a316672656472656a31626c6c366132646736656d7538626362223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313732393238353035363b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313732393238373038393b7d7d72656469726563745f75726c7c733a33363a22687474703a2f2f6c6f63616c686f73742f53697465732f6f6d656b612d732f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223132303433656163663066666665353032376166333863333733663438333363223b733a33323a223661666230623265333930363562356239613862353339613938326335353764223b7d733a343a2268617368223b733a36353a2236616662306232653339303635623562396138623533396139383263353537642d3132303433656163663066666665353032376166333863333733663438333363223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a383a226d65737361676573223b613a313a7b693a313b613a313a7b693a303b733a32333a225375636365737366756c6c79206c6f67676564206f7574223b7d7d7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223466356533393766313039636235306135313632646465623237316162656362223b733a33323a223134643130646663636561376439343530363838333735643730313562373339223b7d733a343a2268617368223b733a36353a2231346431306466636365613764393435303638383337356437303135623733392d3466356533393766313039636235306135313632646465623237316162656362223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1729243892);
INSERT INTO `session` (`id`, `data`, `modified`) VALUES
('4cov7nr7vbqd5kdjku2jvgarqu', 0x5f5f4c616d696e61737c613a353a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313733303032363531362e3131303431373b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a2274646f73347275716f6c6473686438636b71386b3573396e736a223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303036393635373b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313733303036393638333b7d733a34343a224c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303036393637383b7d7d72656469726563745f75726c7c733a35303a22687474703a2f2f6c6f63616c686f73742f53697465732f6f6d656b612d732f61646d696e2f637376696d706f72742f6d6170223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a323a7b733a33323a223166646233373065646239343234633165623661393463306333643764393332223b733a33323a223130343565623438316138316235646330626265373762366436633631356163223b733a33323a223037386164653964316433366639333731346462363139363736363865626232223b733a33323a223661663132393831373831613031396166623163623764313235383533323336223b7d733a343a2268617368223b733a36353a2236616631323938313738316130313961666231636237643132353835333233362d3037386164653964316433366639333731346462363139363736363865626232223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a383a226d65737361676573223b613a313a7b693a313b613a313a7b693a303b733a32333a225375636365737366756c6c79206c6f67676564206f7574223b7d7d7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a323a7b733a33323a223964386232336536636137333637383033306135376339613437663032623332223b733a33323a223035353730353064356662303362663932616436646436393636393534383933223b733a33323a223466373361343635633830623930353436343835393936636661633263366634223b733a33323a226639313564336162373834356436373434653166366630663034393339346362223b7d733a343a2268617368223b733a36353a2266393135643361623738343564363734346531663666306630343933393463622d3466373361343635633830623930353436343835393936636661633263366634223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a343a7b733a33323a223363646539376430366437356366636561346263353864303837363839633037223b733a33323a226232363263363231663362376462316563623330666562303738393763666364223b733a33323a226231373061383233633436653464343936653036623337363230383338343839223b733a33323a226661653862323733643961306637393033393632643639343837306666653630223b733a33323a226239376237326566363237373365666237623938333432343031653335663336223b733a33323a226236336433313437623034643565323430616563356433333565343062373033223b733a33323a223366326634656338326233663434653261316537613435316337666664306264223b733a33323a223135623831636138336139343066333164386461326264396333633338363932223b7d733a343a2268617368223b733a36353a2231356238316361383361393430663331643864613262643963336333383639322d3366326634656338326233663434653261316537613435316337666664306264223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1730026516),
('4e6mpc28v3sh3jh5qh57fkrvog', 0x5f5f4c616d696e61737c613a323a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313732393834323434302e3236333933383b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a223465366d7063323876337368336a683571683537666b72766f67223b7d7d, 1729842441),
('5809on4f68qr18oie03st9ibr5', 0x5f5f4c616d696e61737c613a333a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313733303635343238382e3232333839323b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a22353830396f6e34663638717231386f6965303373743969627235223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303639373438383b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226261633236303933613966346136643538393766653661666430613535303666223b733a33323a226666626265303638356364393338306436656265643766376161643738613464223b7d733a343a2268617368223b733a36353a2266666262653036383563643933383064366562656437663761616437386134642d6261633236303933613966346136643538393766653661666430613535303666223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1730654288),
('5jchu0658c4kk405nuc4o2653d', 0x5f5f4c616d696e61737c613a363a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313732393739393832372e3132383730343b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a22366a6c62707067376d6438756a6130346569626b6a31326d6762223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313732393833313338303b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313732393834323233353b7d733a35333a224c616d696e61735f56616c696461746f725f437372665f73616c745f7265736f7572636574656d706c617465666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313732393834323138353b7d733a34343a224c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313732393834323232393b7d7d72656469726563745f75726c7c733a33363a22687474703a2f2f6c6f63616c686f73742f53697465732f6f6d656b612d732f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223831613966323435626164313930303437326265323736626332643461636434223b733a33323a223532323364393862366334336133623361353665626665626264373564656165223b7d733a343a2268617368223b733a36353a2235323233643938623663343361336233613536656266656262643735646561652d3831613966323435626164313930303437326265323736626332643461636434223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a33393a7b733a33323a226261316534363964333838613765383835333636303366333934636263313333223b733a33323a226332363038626461663965363433643232346464353265613639363831366433223b733a33323a223639646334393937613834346534353364306638356166646131346633663832223b733a33323a226163653335346330616336333362306465383134663432363934626430626163223b733a33323a223035303537666262393565623138356439366164343237663663613166633836223b733a33323a223137393566316166643765316363636431353737643637373933316131343637223b733a33323a223138623261316466343539313734636337383762353231663362623537313634223b733a33323a226164633531646364663566366232376532613563356363643831383234666466223b733a33323a226130383266363031303965633065326161323862636265663935343533373030223b733a33323a223461656661303231373535386266333264333530386139313861386661383533223b733a33323a223363356537346563656164336238363237613538303765366434646466343630223b733a33323a226134633433373237346364383330636536626531663238333465333163646538223b733a33323a223164366364376164666130663536353135336138616135306336346535633034223b733a33323a223561633438663738656162346330336335646464393434316364323233373933223b733a33323a223133303261653863333061663034336463333365636237343865633330383666223b733a33323a226465346266373064383030356437396134633762363433356331376336313131223b733a33323a226338373963666461656466316566393832353230313032336231366339303336223b733a33323a223230343536353236336164613131333364643366333739343764336439323365223b733a33323a223132646336393437323463343330616135616163303361633035303963643836223b733a33323a223762663163313961653535366235343161633230343466396136363935613230223b733a33323a226164376161316636306237356164313138666233396434333033636266356562223b733a33323a226466616437623635623035386136353530656434323265313534613030396362223b733a33323a226532373538313533366465343864313635656262633635336464613530636233223b733a33323a223431383833633633326233316363333939626136323561366664643863396437223b733a33323a226539633833313233656535333531336330663336323635653230386335383032223b733a33323a223331663136323333663363303030343665383161643461333930356130383731223b733a33323a226462613435626662313635333866643061646363623431353262376562363239223b733a33323a223633643739363034303931303061646665613766643839663562306464633064223b733a33323a226638393266316339393465633735653330396363616462356235323933316364223b733a33323a226530373163353338613330343962613434623338363434396661393731303036223b733a33323a223137343538623761363037666632653638643338303430333432386539346331223b733a33323a223761356563363534313961363933396331643738633837653031366664663265223b733a33323a223936363635623461653934386230653534383533663063343866326336323636223b733a33323a223738636535653934633731316264333737343366653632373265316335623366223b733a33323a223331653766386539393034343036303638656332373130353661393434396566223b733a33323a223636303862356631366135623166383330653162383437623132343164373963223b733a33323a223737376434656535306236303861313435346437326265393638333732366232223b733a33323a226561626365373539373864366262666563303862323937613732376635323763223b733a33323a223632383131653733326138366132353330396436363036663833636462616439223b733a33323a223033386436313635383333333465353361653630356432313338383364656238223b733a33323a223766356431366531626436386233633832346334303037643566333232656232223b733a33323a223437326664336532393831323939623839316434653766646665366431356536223b733a33323a223361323163303062313861653364316336353864396331373064636463663561223b733a33323a226438373861656230643965626338396663343130353730633830393866323639223b733a33323a223463643934326466346535663266623562363835396365333262633962346463223b733a33323a223965653765363634636363353033663964333239613366363739666163663465223b733a33323a223965643865323833653732663138353165303362376337636661313264376337223b733a33323a223761396264643761343362383432323738326466633633356366316634373562223b733a33323a223032306436343763656537623733343138653435663164653065623866363133223b733a33323a223533303932636534353662633335376135626234633433663537303861373132223b733a33323a226562373538366133393562393662646561326132396261663336623965643037223b733a33323a223333353164653362333936613237303333663831376436306637383665383935223b733a33323a226365306533616333383937623438653534363162623930656437383361643539223b733a33323a223933333236376433376432653136633531303362386536323930636431303133223b733a33323a223866316638346132633335303864666366616335336234623262333637616134223b733a33323a226233323865346262626164633231343266396233626236313765376533653938223b733a33323a223639346330383161323564313930376265343666316533633238636432353832223b733a33323a226430346135623330363231323336666263636230633337643361393233393063223b733a33323a223561376162633066353536363934613738333137393766646665653336336432223b733a33323a223737623163623461323632333935623634316539633966356630323366373439223b733a33323a226232396263646462356163393735656331336437383331653666396131616538223b733a33323a226564363336616263333033643631323562303133393036386437333466396336223b733a33323a226164366463346531623432646633343337366362626135633835646163363730223b733a33323a226232613331633664316364653232376464353962643963626536386333373139223b733a33323a223532613535363538396536373530393663363430343633626166646632363739223b733a33323a223633303462393231616533393534373261386165386135633832396232303639223b733a33323a223932373232306166636531623666626632393733393535346533396137393162223b733a33323a226137306264633930363335346634333566633739336234376662613265643036223b733a33323a226338323634373662383763313337636262613165336235326132363966653937223b733a33323a226366316430666463643265363238306464643562383562626434333738346462223b733a33323a226335396238323935626536653038663839383761303932393236366138356632223b733a33323a226564396439646433333633386537333539313964633234613566333765383731223b733a33323a223534306363666238303133616433666162353565376633613136333835356564223b733a33323a223065623134666439313630393964366239333137663131323638613762313265223b733a33323a223039376633353638326135396431366434316564323266656134383938333666223b733a33323a223264346235323832363463313637663031633063643931633565373636663761223b733a33323a226132396434623961353862303163373765373639383839633837343537653063223b733a33323a223132393061353733663963616561653231303936626638333436303062366639223b7d733a343a2268617368223b733a36353a2231323930613537336639636165616532313039366266383334363030623666392d6132396434623961353862303163373765373639383839633837343537653063223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f7265736f7572636574656d706c617465666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a383a7b733a33323a226632643132393439333764666132326336373938336262386166386333633930223b733a33323a226361313239316139636365306163643563383163623264656537313934386139223b733a33323a223638366435633034346233313633316237346663313730633633376435663663223b733a33323a223365343261343164343930633634613164326336366132323033366137616238223b733a33323a226139633933643233613465333331643933663861373264363530363762393663223b733a33323a223832383763653165363136616334636637613436313562623065363839656631223b733a33323a223464663938663131643164343337626361303139343333383433366238613730223b733a33323a223565393265313566383066386665396236636632636136343132313161643064223b733a33323a226266323139623832666434303236646130366138623636303361373261616635223b733a33323a223834356462653430366261303739656339343336653132383830313262366631223b733a33323a226635333563363739666138653635363835643765373462383133623737666463223b733a33323a226164373532636435623863373535373737396433316635353634616364613861223b733a33323a226662393461323834386265313366383564383164316535343137386639383934223b733a33323a223661373733656362626433633464613333323330663465643738373836613839223b733a33323a223635366230333031333234333637353931363737396662663061386630653665223b733a33323a223063346564646564613730343830663065396330363739316635356635666161223b7d733a343a2268617368223b733a36353a2230633465646465646137303438306630653963303637393166353566356661612d3635366230333031333234333637353931363737396662663061386630653665223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a3132343a7b733a33323a223831643230353034313866343435663431313036653638363965623162646439223b733a33323a223131633564643161333661633761396265336634626262343364386531316439223b733a33323a226262326539343161366165376336323930343863306430353062663436343336223b733a33323a223339636331376565313832323635313962383564366430353164306335666335223b733a33323a226665663337666532616465383962643365353665326465623866333166316433223b733a33323a223566636537323364323836376663313037653035636531356664636664356234223b733a33323a223362323130636330663131356636376464626663393162353666656531336532223b733a33323a223361666639393834393739323833386663343938363766666638356531396638223b733a33323a223130323730613837393630363164376631666135636162343234323132323432223b733a33323a226536336166663164343561623964623938656165353461336134653461656461223b733a33323a226434306265346136313433393365333537303562336536333765396535346461223b733a33323a223439633837336338663761393631663731613838333531373663333638333963223b733a33323a223433616363346533323036643939636532616539633935306366336430643831223b733a33323a226666616563386337316661646634616132373363613666386536623234326665223b733a33323a223366383961343133633331306464636162333564393432326234323730646637223b733a33323a226462373230353537363039393234643261363866623732393766333331396364223b733a33323a226232333830346562613535323335316330653264303461353963396630643464223b733a33323a226136366461663363303339306439363334333837316137326135623433313639223b733a33323a223431623030663736336363373331363935633733353035623865313161633264223b733a33323a223236666236646234643434333835643832333032623735353864633733636136223b733a33323a226334396633613064376133626266383665396536323634306364653163636232223b733a33323a223736653437383930626137363939623266636565353435313464336439376462223b733a33323a226438633439383836346363313661653932616439363538643833666662343832223b733a33323a223538356434316131313036393036636237373838623032303433393733623061223b733a33323a226631303032373333393166373430666565313733613039356364666230306266223b733a33323a226638393065366564303730646534386535666666303833623635326139613835223b733a33323a223136663333323433313438373637363838666665363065653634323963626664223b733a33323a226666316138613436306434376538393631393930633230306431353435613434223b733a33323a223437643835656237356338313439643430343036393536323731646463303465223b733a33323a223036356635303731313735383338393639663461643563363334633436303534223b733a33323a223862366239373533666333343162333963373735633262313565393730316333223b733a33323a223762643165303134633861633333373437356666626662636236646136633639223b733a33323a226335656161663533353861313838613562393037613237343635303662663733223b733a33323a226565643033386466663234336431343439353134376166643664373665356232223b733a33323a223239613238383633636133623336343030353530393932396330616562393838223b733a33323a223361663262373538313666613337613964386632383833666235633962646634223b733a33323a226239613063346465363661623164323766313635383531366562363462646531223b733a33323a226165636464366263306336336332323564396234336565336566313830643232223b733a33323a226662303839363466666132303937633465653465343265383464393961326362223b733a33323a223261323539343563663438313736316562633963366430633439313965333562223b733a33323a223266663236393238656465323237633232373736363633666334343066643436223b733a33323a223731356462386636636330346162393663366361303733383939623035616364223b733a33323a226132306363643439313262366435333137366338386132616465623230343861223b733a33323a223161623835376237343363333539316335366665633937303636393833636430223b733a33323a223864356331396665623739653764393263383934323937316365326131333161223b733a33323a226561383565653566326362346438643861636463623035613032616130323938223b733a33323a223833356564336638313865386566356362613364633134373564316434656136223b733a33323a223833333263336361306130353733386637336333623431656538633764363133223b733a33323a223139303034336237393033366333313234636638636664613430646439343966223b733a33323a223132663830396330663962323230376133623039636535366266383362346237223b733a33323a223535343838353938366634663939323330373361633164623663636666336339223b733a33323a226530623136613062633763343635373739646234373062313033306131646635223b733a33323a223335623130663437623739313032386561303063333637313834396131353535223b733a33323a226136643561346538353734333564656435373566633437306561653165306337223b733a33323a223361666331373564666339303335643330353361643834656631393638646234223b733a33323a226161303861623331393237333462373831623263633261356664666632346564223b733a33323a223038353032376134336433613839383237356431333631613536323038383735223b733a33323a226439333062373039313833373039313337396137326634646533376562643763223b733a33323a223963356239303236393862636630616639663939346339343639306230383464223b733a33323a223238643566396438373435396631396332663538613766646238633931656332223b733a33323a226335663663373665383737303035373966363938376335666138653837656133223b733a33323a226333663136393130393636633766333464303130393132363236623339393438223b733a33323a226637303732626133633731363830633164306238626132306462623063373231223b733a33323a226464376166306565363533356363396437646138333665373136623166383963223b733a33323a223737663266343363643734646262663438393237373337656165376463383866223b733a33323a223461353035623235303263626533353535656136333765643533623736333062223b733a33323a223939383337613464636662616631313434666466386366393061396632383632223b733a33323a223830373063623930616636336363623431383666653137376164366462386238223b733a33323a226431393031343935353831383061336536363764313738376337336131383164223b733a33323a226132616135633836663334393333353630346632653339363563346237383636223b733a33323a223836353038353164346338373561633832643835626561323036313737333539223b733a33323a226232613236616530313934323734663035613231306563343237666661343335223b733a33323a223666626163643634366136333864313236346537356366353266656539623766223b733a33323a226438333239653232336464303065626637316562306438656366636633376163223b733a33323a223562373533393063356132326130663065653265343263323366646439656632223b733a33323a226264383035303166383962636534373536353333626236366633363430336637223b733a33323a226534636234396262313063646237393762633431306135353463613861333465223b733a33323a223766313334393536303861396364666137316563373030623363623136323263223b733a33323a226662636535313035643831663465633064613637613933333361626536383632223b733a33323a226332313565646630636337643437373639303933316438326633613764376634223b733a33323a223434393831616265643031643664383161646162393838316632356235613935223b733a33323a223232346532363730313833646664376363313066393236346134646133303032223b733a33323a226138393966323237633734653635363333386230306330393237303832333362223b733a33323a223636316436303463396665623232356265323764376137326466336366373737223b733a33323a223034333335336266393238383336353839306534633034623764333361643634223b733a33323a223738396339313662326634376530633461646530356239663639383761633061223b733a33323a223237326336663465393832353838316231613563346530393933323764336663223b733a33323a223030366561373434666330323262366263373331393533613436636562346162223b733a33323a226666613261303032313563666134346262373965393331323431666365613065223b733a33323a223037636266373837666235346265393937373462373063353062356639326165223b733a33323a223931313130326631326338393838363838313864366334396466346437626361223b733a33323a226230323366386632643331323465333535623866623363313733613762373035223b733a33323a223565333636396135626637363663343135373664313161656133663134326561223b733a33323a223265343030323334303135656163323964626266383434653533326362386130223b733a33323a226436663662303665366531356530373435623364363664343161323838363562223b733a33323a226334333332373664383365366232313530313430396139633135646264623735223b733a33323a223134613466336637643735613235386433643530643361346536396361356633223b733a33323a223535373165323031663835333833646339376463646362396439353337396139223b733a33323a223261363530653565373966353761623130623964613132653363323335356365223b733a33323a226238346533633436616565323936343863373538383831316261636235326264223b733a33323a223662303961616364323936363533303530653030363935356364313564363634223b733a33323a226239353637653361366339636436386337666531316462376137353636336332223b733a33323a223161363066356639373836373963356530343437313633393236306264393033223b733a33323a223363303638616533623132343163336132666664643536363534313363363639223b733a33323a226237383731363530643339613566636138626230333463396630646237376166223b733a33323a223463313230353338366161313138326537353163306235353065363230323465223b733a33323a223864316266626236386232343233313733653366333337646133663265333038223b733a33323a226531386135396234396662396363643637353261323133353161666635306166223b733a33323a223033326463356333366439303531383335333538656361313566626161306163223b733a33323a223264666463326564323133613035323337306630393038393438326339396361223b733a33323a226134626366383966306537346337363738353737393638616231373530353566223b733a33323a223134646563633037343732343434383934373564343438663335663733383836223b733a33323a223836613436616463303263633064663337393538396664353061356431333566223b733a33323a226162333538333737373161643666616564623937353138303165396563636666223b733a33323a223331386538643639396134623164326161323530663335626337623136373232223b733a33323a223931626361303934633135353932393261616431366166316463306165613665223b733a33323a226531343739636130663331326435656564653363326465613036306630656262223b733a33323a226631316262326566306430633939386365386332393362356631323536393765223b733a33323a223336303638623866333839636630396537646531663564333930366531613732223b733a33323a223566656362333036623136633166333362306335373536663135626163313864223b733a33323a226237343231356439643866343362646162333062346166313965356166613966223b733a33323a223163366639613366396534353634633333323436613462666536636139303664223b733a33323a223734666435366365333737666262633734316437666261376561303239306132223b733a33323a226539623763346430636137303536363538636362616438363363646366613734223b733a33323a223636393061633538363735303966366535393032653831353533313166663862223b733a33323a226161343435343262313534313931396566343635623931323961623563393031223b733a33323a223133623232636635363930653731626365376632366535663266313166623833223b733a33323a226132343536316464646562376530653063623639363865653938366566396464223b733a33323a226631326536356666383439373338646662373837383531366565396633346364223b733a33323a223235316565623965336664343364326234333364383364643563383862356563223b733a33323a226461653662643536633537333133643637316564383236353232663766383661223b733a33323a223264636265326531376330383066643630356139336435373030303038396161223b733a33323a223736343266326436623666376331653264333131306437363335303364623535223b733a33323a223930303334316466323163663034653364326637366537313963336562653963223b733a33323a226634363566663962343761313133313361663730393564663431663339336561223b733a33323a226539326331393061646532316235666163396132616237386530373338663038223b733a33323a226135386635616536666433613339623664616430633463363139366632373339223b733a33323a223466626638326338633031663266323233356231623938363761383562303132223b733a33323a223061643636386665393037633461313435633335383538613732643961636662223b733a33323a226338643065393937663939373931383231383132396662383862613263336465223b733a33323a223561666436363837646536323637376566353963663737396537343561336161223b733a33323a226536306130356663663534343966643736613732666532626361623535336639223b733a33323a223666336636306262383661613563363936396363326464393535373064653132223b733a33323a223639303435636139343166303461613033633337313762303131326131343164223b733a33323a223638396234363663663862343335633366613361323431323532633232663432223b733a33323a223661303933366532343630346638386566346239336231633665316532336536223b733a33323a223138383037636131643637366338346666663364396535336534343466613965223b733a33323a223130363138303438633766636665623363663931633231653035396238636430223b733a33323a223134306333613732636661333830306139653136646239346632626261363036223b733a33323a226664393935663733366561303830363936376436373033636530393333633432223b733a33323a223330633935663036333236353537623632666133626462666530363739363430223b733a33323a223332356232343362383536666566333235626461363533383831663262333330223b733a33323a223033373262646563626466333730643136363433376331623562303536376534223b733a33323a226335363764353733393866326333653836643231306330656637386434633465223b733a33323a223032366162313739306633333135363439333532343663316131663132353066223b733a33323a226331656239626262346538363335316164393830316333653264633264633932223b733a33323a223762313864333663316231666633656264623130616362383437313663323237223b733a33323a226164623064633330316661616566666639616366646634343465323665323864223b733a33323a226235336530653663306438626230373963613533346261663765366538316261223b733a33323a223461636637386434323064303764363236366136303532663165313239656438223b733a33323a223665376435323638646664613231303138326139626131613665393463623030223b733a33323a223932366137376134363662616532316331323235313661383635396133663437223b733a33323a223837663434323030653864626330303235313663333734333032396130393837223b733a33323a223164393964616565356331616565333463633466613466396535396465363266223b733a33323a226365383236633865613266653839396133353034646532346530303231656264223b733a33323a223263333463313139386539626530633630336132626163366537326130306662223b733a33323a223236646438663230656664616563323438363330316631303236366364373730223b733a33323a223062353831643332656332346430643934383534343737636163373234393438223b733a33323a223534636161613362363339353565626263613536383234386438393962623264223b733a33323a223064343766303831663564343636623763373930636564366662616337613863223b733a33323a223037636132616333363666613231623966333637396265663237396239643438223b733a33323a223264653566353961373733626430663163383561633638393537353462336132223b733a33323a223338366436626134663638333839623037613131623762363664663461376238223b733a33323a223939323665323664666165383639313831353133653830336664333563313032223b733a33323a226338626266316166633035326336633431623463383531383139356666633639223b733a33323a223234346336383139626130643063346165373231333065633233646263306564223b733a33323a223134363762313130653033363961623862396261303636376461313765356238223b733a33323a226536666563643466383833623435333362346134633336633965373533386332223b733a33323a226161616438303163643062373762313561633336666439633634303736663663223b733a33323a226563623835623231303133613537383165306365383835633562363837363733223b733a33323a223866303231336263376661346336376534376135326236646530663932626536223b733a33323a226361646334353937626163626665306131336439333730366130373734643738223b733a33323a226461666234656361383262356536393331616133633134613065353837663161223b733a33323a223063653834643633366265633165316331363331313063363264633762663861223b733a33323a226162643362646131623966366161613832383565646164363738333538326439223b733a33323a223233353362373731346165366233623236346638383139386337356137393730223b733a33323a226235353336643335646163363839363637663231633937653330386139303630223b733a33323a226361313762383566653433336332373432653638613034313934373135623333223b733a33323a223639336634656537643334383335363037653033653763643734646332303639223b733a33323a223162386433653633346638323836646438366664343532316466353633346530223b733a33323a223736303138333632323531636531303338646462333262373536343435363431223b733a33323a226230383332343465363035383934303666656562333863363935323236623438223b733a33323a223366396530653835623934383265623937356537383532353261656337356262223b733a33323a223536666634316331353263323530353139386664666165343831616238633839223b733a33323a223436386265613133313032356330316563373636633162343337653335366161223b733a33323a223662643531663436613330323836636366383165396432313966343466333136223b733a33323a223431393635653334383666333263396362316635633135333531623233653236223b733a33323a226434303333343566623438616663313666383065373065666430666330323564223b733a33323a223763623634363234633338636237636638316131366338303239313064363961223b733a33323a226232623330366537313336643933343134386266313736613462373561666132223b733a33323a226530663936636438393966333166303964316665333763333561376436316263223b733a33323a223632616533306463346162323366333266333335373039306439343264333039223b733a33323a226130326464643563643530633532353565313366353861303266303733643837223b733a33323a226538646539373637613037656531303963613364316439626239333065323466223b733a33323a226430393361663338633831336435353264306632663965373534303033643332223b733a33323a226235653462386231323130653633613532343132393561393930376262313533223b733a33323a226664656131646230633664383961386634373766333163393133306535373764223b733a33323a223033336638343230363236636566613761363634353130666131663335643831223b733a33323a226234323231363135393436356365333261383335363133326338633939623466223b733a33323a223737363664386538643334343961323335616364316533353938633736313562223b733a33323a226436383139343563383839663661333061343933386463623661396639386265223b733a33323a223632373938306366373765626162333265663332303839643133393861383061223b733a33323a223634376636313064383033343039643263323164613533653662333231616238223b733a33323a223563626361633632626535303362396664623137316539653834666630346433223b733a33323a223261623836383430306139366331663535316638656662373837343233626635223b733a33323a223734366664636136313632633763663531613231656263353065636538343661223b733a33323a226138366234333663633966353464313133393734363263663262383338643766223b733a33323a223764363165633936346565346435646164353066333830623862343762636535223b733a33323a226663623563656538653436366133653530653130663661386262343465363136223b733a33323a223266336566616462313331656661383139323761663736616433346437396134223b733a33323a223865336639653039633163653863366130623366333332653230636334623433223b733a33323a223062303164346533366463326130616562666634356137303434356164336465223b733a33323a226234396533306461306335363138636232656366633936616565396665316339223b733a33323a223761653137333230613862663261663239333835383938386136323335323236223b733a33323a223766616161633463346539383336326439373535623434313731626238376339223b733a33323a223033663830396362323234613032643066663833366434376639323336363866223b733a33323a226430656161393136353233663039633538333664313163313062333662333032223b733a33323a223437626662653637373235373461376331396361323064333232663039613636223b733a33323a226434303139383039643361636562343737643936333831386633393464613363223b733a33323a223337393266303836356136356538383164303964656333316365336663383463223b733a33323a223130316135663931636234373538343637363761383838633434636361326162223b733a33323a223637653535653430396338313761333234313138333035373834306437323432223b733a33323a223464373139336530343933653035353135623366643363326636313565613962223b733a33323a223533616462383637303636663438653361396434373665353639306365663437223b733a33323a223166633437636564383566393166666336313662363961323439356130373832223b733a33323a226331303037616538383131633832376461386339636531623566336661363666223b733a33323a226335653438663637323937626166353161666263366639626332353665333464223b733a33323a223531623935623166643034383537643434373462363761633539643233343266223b733a33323a226461643562613239353535633333623633643135393861323862386166636330223b733a33323a223636373362663838623137316230616331663732626261643564616661343835223b733a33323a223234373232333231373864363130626234633864616261396264636665646233223b733a33323a223861666636393762643639646530356138613839663162643232643264316663223b733a33323a226336613730363262316337616432643734343535306333373937623366383934223b733a33323a226639313332666363353666313136616230356564333064396262306239313730223b733a33323a226535333431303066613137356130323335353735313135366335616463636336223b733a33323a223134623031323634663732616261373037383961333861363464313433393737223b733a33323a223361373038613631323262343137346137373231323937366466393166663933223b733a33323a226231393539656132326239393862643763663835393631396338396235363864223b7d733a343a2268617368223b733a36353a2262313935396561323262393938626437636638353936313963383962353638642d3361373038613631323262343137346137373231323937366466393166663933223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1729799827),
('5p4qmt4apo2qvipkettvupst37', 0x5f5f4c616d696e61737c613a343a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313732393234373538332e3839323631383b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a22627161623363393465656c6265726a347374633865616e6a7639223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313732393238373039323b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313732393239303735333b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223237663432613564346436386361643331646638343434633664646430316537223b733a33323a223062346435306131393762646431386530313535383137343062626134613165223b7d733a343a2268617368223b733a36353a2230623464353061313937626464313865303135353831373430626261346131652d3237663432613564346436386361643331646638343434633664646430316537223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d72656469726563745f75726c7c4e3b4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a32313a7b733a33323a223036363632373534343833353635383930616638353930613261663761636536223b733a33323a223561356538616466643364373630643665316362306436363465633534366638223b733a33323a226630323466363538333834303662616666303733333530376133653435393965223b733a33323a223863303037393362623031333938383861663936353635643765336165623465223b733a33323a226665306365613064313230653733363862386131383362363063623164333730223b733a33323a223034623030323331383832373833333764363531613432313630326334316534223b733a33323a223335373563396463316133363037383766656339393365666161393964653635223b733a33323a223061363463316164393161303036623363333363373537663031366434663136223b733a33323a223335616535373438313236393131393462323064316236386532333761376137223b733a33323a223834306134393061646131336134333333336136386430393730343331653437223b733a33323a223439636239666230616439646136316166326632626339646163316664393430223b733a33323a226162373333613037616338333261653233656635313730663936343636613032223b733a33323a223735383439616134623262323163333266616666353263393065363265313935223b733a33323a226261616565643865306430343235316236663331333539373366306163383233223b733a33323a226536306335373931366634353238393636623161383566666533663238393063223b733a33323a226439303865653434353563323565376362616133646361326130306464326665223b733a33323a223236373532346637396433313661643034636634656466366264313136363230223b733a33323a223561343138363833303233313464363061396136616266333336383737636462223b733a33323a226237653262373235306338363437313432663363623132663830383332636333223b733a33323a226131366533376465336238353638663662653135313330383164373537366163223b733a33323a223866336536383862653231323630316464323033643164333265626231363733223b733a33323a223965326562386632326433363264383335323661336133646561333134376565223b733a33323a223333383635373262616466343639343030666566366430643336633538633330223b733a33323a223839316431373064316136656166653632353766333536326338373262653836223b733a33323a223463343935656564323765346130363362663862316531356366656664363738223b733a33323a223261376462613138383165643364366263363333353131386336633762353239223b733a33323a223865353637363732636465343666333166323432356638313331316239386132223b733a33323a223831616534616436396262373438376539346237313831623630316466323432223b733a33323a223165366362613466333431366262306432343534323632623764333236356538223b733a33323a223638386133356362653632663861656630343536643535396232636563613762223b733a33323a223964356666383237663937613534643761306561353032333230326461616565223b733a33323a226239366566323639333434303463653432393364303733333535316464653738223b733a33323a223466336139393166346266363066653364356635343132626138323962393136223b733a33323a226363626435303332363636333438306666356233313237643061613533323736223b733a33323a226330396635396537353137333963343466623830633731623565623961303266223b733a33323a223435346634633864343734313631633330633766663161653034376337613664223b733a33323a223335353836626330376363393566643932363461663062366532616364393134223b733a33323a223035623835323065616163613363326233616631623437393731353432396432223b733a33323a223861356235366632336636633061323932396330383138633337623339343965223b733a33323a223563383430353938333564376662303736326639616139623139636430383130223b733a33323a226135393762333565346137346165383733346530303035643536373431656366223b733a33323a226235336334633531396230313561656631313536343063633937373765393336223b7d733a343a2268617368223b733a36353a2262353363346335313962303135616566313135363430636339373737653933362d6135393762333565346137346165383733346530303035643536373431656366223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1729247583);
INSERT INTO `session` (`id`, `data`, `modified`) VALUES
('6p7bmula3f119mml3ji57gbg69', 0x5f5f4c616d696e61737c613a343a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313732393234303638332e3731393639323b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a2271626932356739643339387439366e3676716470707338393374223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313732393237373131363b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313732393238323339363b7d7d72656469726563745f75726c7c733a35303a22687474703a2f2f6c6f63616c686f73742f53697465732f6f6d656b612d732f61646d696e2f637376696d706f72742f6d6170223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223962343437376632323036333461303337646133306231313534343563336530223b733a33323a223134353166343762376665646539636261336264356532636332666631343935223b7d733a343a2268617368223b733a36353a2231343531663437623766656465396362613362643565326363326666313439352d3962343437376632323036333461303337646133306231313534343563336530223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a33353a7b733a33323a223066653761313632313563303365353139343161333161313935303239363238223b733a33323a223534316334653164373433643137383531653263363761316361633734323764223b733a33323a223866316264663466353463373066356264353164386132323237646461333033223b733a33323a223932343930366636373735646166353134366636616361313964393430643336223b733a33323a223239633736646332326538653265356463326666636236373733653337666434223b733a33323a223435303531336631326662326261363339643536663865653233653433656263223b733a33323a226632326139366565636337376432323661343730616661633139313432396565223b733a33323a223766306562626663343033623034666665363537373337313163376634366662223b733a33323a226636346463316665323637333861383636313131373762653363396235353835223b733a33323a223263306431306339663731326539326236316362376134376532333738366461223b733a33323a223062323762663465393038636334313036353666383136633932366262383536223b733a33323a226135333266303366323330346231326331383736346532346430323137663732223b733a33323a226138376365366666643865343734386533626238616139616433373263663631223b733a33323a223234383736356463373361653264396231633564343961643938326533666338223b733a33323a223564366632633037363138303163313766653435306565336538653666666466223b733a33323a223338373333666231333762656366643636373236366530613539316337383735223b733a33323a226333616130313236656133636262633266393164376136303936636539313963223b733a33323a223232666230383864316263613266366364663933323032316362646265336239223b733a33323a223731306363353431336266323333356432616364353738356363303662646436223b733a33323a223132633135316664303262633237336637653261616435623239633337303134223b733a33323a226335393561373230366466373361353563663239653733383664366639663661223b733a33323a226365316666356237386331333536346338366432353732653536623233646466223b733a33323a226234363030323534383063333464663432616264346133623965356430333037223b733a33323a223334633331383535623666336162653933343163396361663864623363656364223b733a33323a226230383465336631343231393963303435356530373663646432666435643131223b733a33323a223836643866613438356663306232636532316235636536633335373039386630223b733a33323a226161373931313630653532613562636664323633633230323431336364343363223b733a33323a226365646433626539646361623161333334633335316337363964373330633637223b733a33323a223261363932366637393730623061343030656232393433323866303632633738223b733a33323a226434636164633662653139383661373438616362343533656139323935376463223b733a33323a223262333538323862616338646166353364653763386536303036313565663033223b733a33323a226138626632343039633732316437396633333339363833373865626334626131223b733a33323a226265656433373336663362366362306466313262376661373763373431386538223b733a33323a226331396165656466346335636563653030363236363834373733613664323561223b733a33323a226539613634303265656564663233353838363764303233626564623466366332223b733a33323a223831343865643466613139613266363835623035653531636237633461616532223b733a33323a226164336130623364636566313530396536646532333963366663653837313362223b733a33323a223330616631336630313165363561633437623537646235313435613832626230223b733a33323a226632653838663433333739323034316530393065393434666265393265376165223b733a33323a226261613135626239303163626233306533323162383438306564623963623933223b733a33323a226464313764636664383933636231623634313961366365656432313336346330223b733a33323a226561383034356661633630653632303464636166653861666336646561336364223b733a33323a223565653030363139636461656335343763376265616161633132316566346332223b733a33323a223333363035616561363366646139626234636364376264666435366664663230223b733a33323a226663313132613665343037363033663836613038636663346234616230616334223b733a33323a223235326364346539663335653561366565393939636631373338313238653961223b733a33323a223133343035373361393038356238333337323062303736363962333236366661223b733a33323a226436313838666164373930656531346530653834316331343762303363663734223b733a33323a223134386263373935383665663631646463626663303665636463626665616231223b733a33323a223331363638613035343131313661613065643364646638363233666337633637223b733a33323a223466386330333164636431346236333234303935383562313235613133643133223b733a33323a223662383766313565373263306261646437383238653937306665373066316262223b733a33323a223965373130636162373335366435393162633538613266396236333963326563223b733a33323a226331386630663430383833383932343033376531656266653836316433303265223b733a33323a226262656539303334333863316466363935343931316265366163346634303761223b733a33323a223663303166323733623639343736663130386431373535306137666331303932223b733a33323a223534303266373764366438643335313864666332666339343437626133663230223b733a33323a223931613062373562396366646363366132633134333938373334633361306663223b733a33323a226435373464346631313732303064343732663463386639393033306363623537223b733a33323a223963343461343366623165656136323232653234663061653039363831613038223b733a33323a226461303865316666336264303163376438303432323735316331633139333332223b733a33323a223137336332386565396136313534396336343436613461353535356631623866223b733a33323a223366396564396133653939306562663462316263306438633261643634396330223b733a33323a223336326262643435633230343939616134336233666263616661376632343433223b733a33323a223864373036646438336136306637346339373638333966643332623131326530223b733a33323a226430333261633331653161623631633666396434633635376637636537646161223b733a33323a223834613438313333643164616130643232616463376333353239663364363361223b733a33323a223762326263646134323631643339393964393931623338356464636432383964223b733a33323a223566333661643431333133323338316632643936363861336138316231646361223b733a33323a226238326634653938663562306534363737633332663465323162326465653434223b7d733a343a2268617368223b733a36353a2262383266346539386635623065343637376333326634653231623264656534342d3566333661643431333133323338316632643936363861336138316231646361223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1729240683),
('9a18bsfdd0v5g3jd8nk7lfrp7g', 0x5f5f4c616d696e61737c613a343a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313732393538313535362e3032303935343b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a22666d6b6b7330716538736d6c6d6c6a3568677676746f3865736d223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313732393632343635323b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313732393632343639343b7d7d72656469726563745f75726c7c733a33363a22687474703a2f2f6c6f63616c686f73742f53697465732f6f6d656b612d732f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226337626332643937363162643032636564373536346363323432396632333135223b733a33323a223332303134613236653261373364373464363734373633356362386331626462223b7d733a343a2268617368223b733a36353a2233323031346132366532613733643734643637343736333563623863316264622d6337626332643937363162643032636564373536346363323432396632333135223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a323a7b733a33323a223036336434626164623931363563626133313833343037633834323663343530223b733a33323a223134616431386439306234303362363530656432376331336438613630386431223b733a33323a226533313937373737393434303363356231313937623830366639393930353665223b733a33323a226466636633313539656465336436343038326236373562346137646630356265223b7d733a343a2268617368223b733a36353a2264666366333135396564653364363430383262363735623461376466303562652d6533313937373737393434303363356231313937623830366639393930353665223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1729581556),
('9g0tep4otuep3s7hl1he44h680', 0x5f5f4c616d696e61737c613a333a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313733303635363138352e3938373136313b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a2233307032677576633575726f716a6f69626976766a7037676575223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303639393338363b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a353a7b733a33323a226632383936386363363531356466323237383831383064646232636637316665223b733a33323a226564326236646532623134633539326330313033326661623133323263646638223b733a33323a226562616531383833333235366532363138643030303138356663363236366664223b733a33323a223531396162306538656533326238633731383664646162616463316534303333223b733a33323a223635303937636533666262363765383030373462613934323861373136353631223b733a33323a223762333831643361386339383264313833663237373265643861303661383865223b733a33323a223337316532346664663538663966366537333737663236663431366536313236223b733a33323a226132376631326135613634643064353366303165373561303237636639636631223b733a33323a226265323836393631373638646561656266366661653461383765306361373062223b733a33323a226130613931633633336131396265616461646430356466646430343039626337223b7d733a343a2268617368223b733a36353a2261306139316336333361313962656164616464303564666464303430396263372d6265323836393631373638646561656266366661653461383765306361373062223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1730656186),
('9upp8v898d2sul3ua40vlgv7qd', 0x5f5f4c616d696e61737c613a343a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313732393834323631382e3930333137313b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a226c686262726c32727675626a687070686c35306a316a706a7072223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313732393838353634333b7d733a34343a224c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313732393838353830363b7d7d72656469726563745f75726c7c733a33363a22687474703a2f2f6c6f63616c686f73742f53697465732f6f6d656b612d732f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223238393663323932323862633437616665623365396530356165616335373330223b733a33323a226538303865386461373133343166653062363865633039376332326662653230223b7d733a343a2268617368223b733a36353a2265383038653864613731333431666530623638656330393763323266626532302d3238393663323932323862633437616665623365396530356165616335373330223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a363a7b733a33323a223638363439326463326363633233663062626137353232323233313332346361223b733a33323a223361633834653039623136663839663438353462663565623137343931663164223b733a33323a226631353330366133636239353765663531393665633630636266653133333432223b733a33323a226665306362316666663164373836333439313966633833643530396135623030223b733a33323a223338343261383866303134373038333931343937333334343131643036653262223b733a33323a223634383432353734353366633737626262373734646338353834363066353262223b733a33323a223337383539306335376136376565316238373531396434646439636563363664223b733a33323a226436313664646462613736643332306164346164316665613065336231393766223b733a33323a223834383630323739653035383333646530643464333635646230346332313936223b733a33323a223231383332326266653434316334386533383063373531396331633930303061223b733a33323a223165623961373661633534626630316337396564316663353266396336646133223b733a33323a223961613364656137383030313738633336373464653264373538343865613837223b7d733a343a2268617368223b733a36353a2239616133646561373830303137386333363734646532643735383438656138372d3165623961373661633534626630316337396564316663353266396336646133223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1729842619),
('aou53m7ca0h9pcop19n1v0qqtr', 0x5f5f4c616d696e61737c613a343a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313733303635343032392e3032303434383b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a2238326e6b707666623732337570376a666c6b6f6d356462656d67223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303638393834363b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313733303638393931343b7d7d72656469726563745f75726c7c733a33363a22687474703a2f2f6c6f63616c686f73742f53697465732f6f6d656b612d732f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223361613631613064323361373630646339626634396462613466613033326361223b733a33323a223261343535313836613535326666636531623531313236363431613464353662223b7d733a343a2268617368223b733a36353a2232613435353138366135353266666365316235313132363634316134643536622d3361613631613064323361373630646339626634396462613466613033326361223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a383a226d65737361676573223b613a313a7b693a313b613a313a7b693a303b733a32333a225375636365737366756c6c79206c6f67676564206f7574223b7d7d7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a323a7b733a33323a226336623537386262353064653035346432353562316639623931353036393065223b733a33323a223537336330363861626530306231383832633661303038626131636437323135223b733a33323a223235653964353163613533353832323037313230656364323266643238653139223b733a33323a226566363233383135386435386132343734383532306332396230343435376232223b7d733a343a2268617368223b733a36353a2265663632333831353864353861323437343835323063323962303434353762322d3235653964353163613533353832323037313230656364323266643238653139223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1730654029),
('cnlsdoak5nlohhfnl78kgj1667', 0x5f5f4c616d696e61737c613a343a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313732383833383933392e3235373830343b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a226570336c3335726a6f6b633137696f6a306e6737336770303831223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313732383837313233323b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313732383838323133393b7d7d72656469726563745f75726c7c733a33363a22687474703a2f2f6c6f63616c686f73742f53697465732f6f6d656b612d732f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a343a7b733a33323a226266656265663534353466323962656332346238666665646138633034373761223b733a33323a226261336639303761303533663833323036623564316439666564393439656463223b733a33323a223938356665636464663530343564326165303635383839313565323765396330223b733a33323a226534303964363138333238613364326562353330396566623963663139633536223b733a33323a223632636534663661363566396632356661653736323964303236373434393666223b733a33323a223063366639326339633564333737343137653766643835393137626337343930223b733a33323a226533373532313233643933636135333561656430306365343761363239303866223b733a33323a223634376137656135356639383833633063343962623362363065333036383434223b7d733a343a2268617368223b733a36353a2236343761376561353566393838336330633439626233623630653330363834342d6533373532313233643933636135333561656430306365343761363239303866223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a31353a7b733a33323a223836336364313364653430376235306431653334343930646362333934353266223b733a33323a223131643938653733646134666433653939363038373535636364396636613363223b733a33323a223066346661323961653862643762363639643063393132313239646363663438223b733a33323a226566653133383039663337616461333833323535393638333166663537643763223b733a33323a223734366465363039623262643966313636663832653863323966393664613136223b733a33323a226136333134373931356338303232346364366364646439666339303063376664223b733a33323a223965363830393435666530326664653032313564616461666663646637643337223b733a33323a223761306530316330633731626465303366373536326432363164326131323564223b733a33323a226464336337646430663334663235333835353264623861316633303137363630223b733a33323a226437353662626563656235313734656434643537626633376232663237373334223b733a33323a226635663438353538353233393361363234353135656237393835393838336336223b733a33323a223538653265396438646431386339343566636435636263653163663734393430223b733a33323a223630623439376535363635303262646261316365326161653139333162616534223b733a33323a223737396134613662306134336264646532353137373466643134386338616266223b733a33323a223764326263643736633566333238626362333731656636623466393363643133223b733a33323a223332656364623836396239343734303364326136323735396631633334633733223b733a33323a223238643431333965356634373338303931623861656139316634396433636331223b733a33323a223637613864353637323830636563356535366166383237383230663332366138223b733a33323a223039313736396363646436363061386238643465663537653361613533303735223b733a33323a223531363638366333653333636665643361383565303565343830303831366430223b733a33323a226131363065396665356439653839323563656131643063326133666333343933223b733a33323a226635376365383437373435666632393763396265383130376139383137613134223b733a33323a223034323934313831336637346637393332313566356561666138303864653431223b733a33323a226466636163653633623031373036653934373336306633613264376333353831223b733a33323a223231323661333961653938306666333762313837396439333930333462346131223b733a33323a223937336564623830373963323531356564306136356232353263636466393834223b733a33323a226232383331653936323664333164396639303135363965313565613166336231223b733a33323a223431373132346530366266343531636163366231623336333834623039356262223b733a33323a223030663537346131313237393466323266623064363064383730613238323631223b733a33323a223437313064393266396263353061303234623931613236656539316363323630223b7d733a343a2268617368223b733a36353a2234373130643932663962633530613032346239316132366565393163633236302d3030663537346131313237393466323266623064363064383730613238323631223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1728838939),
('eigbbg6cc949ovr09mq0v2m810', 0x5f5f4c616d696e61737c613a343a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313732393234313436322e3837323538343b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a2271656739696a356a7375336266303875756875346773356a6a6a223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313732393238343531353b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313732393238343536343b7d7d72656469726563745f75726c7c733a33363a22687474703a2f2f6c6f63616c686f73742f53697465732f6f6d656b612d732f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223366663535653836336337643361616137396438663932353636623730363733223b733a33323a223561303238623839333334386166666435303437616433663534313532616532223b7d733a343a2268617368223b733a36353a2235613032386238393333343861666664353034376164336635343135326165322d3366663535653836336337643361616137396438663932353636623730363733223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a323a7b733a33323a223336373165653733386233316230623035333334623666393632333266396138223b733a33323a226132643032636233316338383932666437346635313664666266363334336533223b733a33323a226265623534326634353437376336656464336138663062396663656463633732223b733a33323a223935313437363237346562633132356635666465626261623834306535323331223b7d733a343a2268617368223b733a36353a2239353134373632373465626331323566356664656262616238343065353233312d6265623534326634353437376336656464336138663062396663656463633732223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1729241462),
('f18h6mmmoflrmbnn1k6ka2oit1', 0x5f5f4c616d696e61737c613a333a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313733303635343130352e3934383230313b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a2273736932656f616331613770376d6b6a6b70316a356f616c6b37223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303639373232393b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223335333935643439356238373437346639316130653234313533363333646530223b733a33323a226562613837636465636338663961633335373731393237313661613161323832223b7d733a343a2268617368223b733a36353a2265626138376364656363386639616333353737313932373136616131613238322d3335333935643439356238373437346639316130653234313533363333646530223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a383a226d65737361676573223b613a313a7b693a313b613a313a7b693a303b733a32333a225375636365737366756c6c79206c6f67676564206f7574223b7d7d7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d72656469726563745f75726c7c4e3b, 1730654105),
('f5i0ea2d1ocg98bhev9po5vgga', 0x5f5f4c616d696e61737c613a353a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313733303034363137362e3633333632383b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a22676a653461326963696b7573733465696c36336f336e6e343631223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303038383839363b7d733a34343a224c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303038393334303b7d733a35333a224c616d696e61735f56616c696461746f725f437372665f73616c745f7265736f7572636574656d706c617465666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303038383932313b7d7d72656469726563745f75726c7c733a33363a22687474703a2f2f6c6f63616c686f73742f53697465732f6f6d656b612d732f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223631663230396432336334626230396139373530626562666661633832363539223b733a33323a226336656538643232393563383534353334646266653032366634353664326564223b7d733a343a2268617368223b733a36353a2263366565386432323935633835343533346462666530323666343536643265642d3631663230396432336334626230396139373530626562666661633832363539223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a363a7b733a33323a223138313562383738376536353063343537663832323934623463373335353039223b733a33323a226635656533343535616131663630323938396235373065343335393164393431223b733a33323a223437383533333664396333323464616165336238373636623965633838393333223b733a33323a226230353839623464336131353564303030383132386136623765306333346432223b733a33323a223566656665636636623439353334356534653264336466366636346537393961223b733a33323a223663346433303438393565656333303835383165353234393861626261333033223b733a33323a226639653265666364343534653361383861313932373133313138656335653862223b733a33323a223831653733316635356166316565626665346235633630326134313461316432223b733a33323a226561386264373132626531396432343664626165373836633534373137326262223b733a33323a223933373934646563666431323932656563323638626565633163306361323132223b733a33323a223930643462346566623039393530326237656230336563336339313332633639223b733a33323a223739643235616231356230663137393133626638346331323031653666356639223b7d733a343a2268617368223b733a36353a2237396432356162313562306631373931336266383463313230316536663566392d3930643462346566623039393530326237656230336563336339313332633639223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f7265736f7572636574656d706c617465666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226436303537383835643734633931343464366565663664373562663961613633223b733a33323a223762336465633939313532386632613438646465653333626131656530656361223b7d733a343a2268617368223b733a36353a2237623364656339393135323866326134386464656533336261316565306563612d6436303537383835643734633931343464366565663664373562663961613633223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1730046176),
('gadehclhkcn46isfgr1tan0hsr', 0x5f5f4c616d696e61737c613a343a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313733303635343238382e3133363833343b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a226e36393361756373616a6c746a30323336306d37676d35656e37223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303639373436353b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313733303639373437313b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a323a7b733a33323a226334623937373436316132303632376336363666653163353963393235353666223b733a33323a226237393939616438386638363038626661326666326333396136326161353764223b733a33323a223331666164383664633432333038626464373834613739616534366262366338223b733a33323a226566353664663733356364643133623534333336303363353564363135366639223b7d733a343a2268617368223b733a36353a2265663536646637333563646431336235343333363033633535643631353666392d3331666164383664633432333038626464373834613739616534366262366338223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a383a226d65737361676573223b613a313a7b693a313b613a313a7b693a303b733a32333a225375636365737366756c6c79206c6f67676564206f7574223b7d7d7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d72656469726563745f75726c7c4e3b4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223666653866393630326435346235643566666461623165303039326461383932223b733a33323a223732343665333739313838653734396166323761613661636463383139306563223b7d733a343a2268617368223b733a36353a2237323436653337393138386537343961663237616136616364633831393065632d3666653866393630326435346235643566666461623165303039326461383932223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1730654288),
('garol9s5jdsi9nsqstprvc9a17', 0x5f5f4c616d696e61737c613a343a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313733303731303932372e30313035333b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a2267377439756637696e73346c736c306d31347068306f35707035223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303735343035393b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313733303735343130333b7d7d72656469726563745f75726c7c733a33363a22687474703a2f2f6c6f63616c686f73742f53697465732f6f6d656b612d732f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223632343266656535666337323930633437393663323232656530353935303330223b733a33323a226562636534643533343766613430373061386436386634333465396238386136223b7d733a343a2268617368223b733a36353a2265626365346435333437666134303730613864363866343334653962383861362d3632343266656535666337323930633437393663323232656530353935303330223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223261633433623837393764636162303630306162663331353132333161353236223b733a33323a226132333538633062636239326639316664343738303338313464626465636633223b7d733a343a2268617368223b733a36353a2261323335386330626362393266393166643437383033383134646264656366332d3261633433623837393764636162303630306162663331353132333161353236223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1730710927);
INSERT INTO `session` (`id`, `data`, `modified`) VALUES
('go43hah8amr4igslmg7n3lf06f', 0x5f5f4c616d696e61737c613a363a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313732393838393231382e3038363138373b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a2261746e35757032703932626273396464627166357537686d6372223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313732393932383531303b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313732393933323335363b7d733a35333a224c616d696e61735f56616c696461746f725f437372665f73616c745f7265736f7572636574656d706c617465666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313732393932393830373b7d733a34343a224c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313732393932393039303b7d7d72656469726563745f75726c7c733a33363a22687474703a2f2f6c6f63616c686f73742f53697465732f6f6d656b612d732f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223663333334616636326661393437636364633265386362613566306433663337223b733a33323a223239616335656436323833613438326462323137323430353835653233383864223b7d733a343a2268617368223b733a36353a2232396163356564363238336134383264623231373234303538356532333838642d3663333334616636326661393437636364633265386362613566306433663337223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a33363a7b733a33323a226534366431616463663637623436373563396630393537346137343036393435223b733a33323a226134306266656635363930393266636535633030353836353866616535306666223b733a33323a223133643832353265353036393265363361643264366336626162333830306135223b733a33323a226235363630366638303930303633656364633633393632643635643664653833223b733a33323a223734356637313265656639313539303533623466366261336536393036366364223b733a33323a223163303734313639336562643638396662616531316336353632326266306632223b733a33323a226365633035343539633738653430653833376532323564626339653839373335223b733a33323a223935396538323533656533333739653034373738393035663733663266336564223b733a33323a223230383464623630393638323266656632633931613839663163643835366263223b733a33323a226466613930363361616132616233623062336334313738643335313032613434223b733a33323a226236373930323266393361613332343233303931383532343930653262343065223b733a33323a223538393933626465346531353462653033343936326334386530613234616639223b733a33323a223332656464613464613033656438386261643538653965386663653331633937223b733a33323a223734646463626263613263653338633065346362613637353035313136646239223b733a33323a223935343261356664336665313233373136636662366137633066316131303033223b733a33323a223665303336396561666262333238383366633933653261643131616164613737223b733a33323a223434393861343930306564643630343334383662353233373632613433353732223b733a33323a226534356462323166633939636237333038623638643336666663366262316439223b733a33323a223764636262303064383738613334333363376532306236353432396261653737223b733a33323a226433376139363034313863316163636632303864386434623738633439373064223b733a33323a223864386462386466643139623766396637623665346235396331643864323666223b733a33323a223165346638366165656333653864363062623437343362363066396339323465223b733a33323a223932613738663434653866363030336661376130653962613664663437396133223b733a33323a223865303762663939636361646565366432393566306564633065323133626535223b733a33323a223063393565626664356434643234373430306435313066663335346138346436223b733a33323a223133663035313939313737623837363366613738656130396666363363313435223b733a33323a223632373666613932383934643461666538626562656337636134363865396338223b733a33323a223133333066353062633935643066326434616230363762386164326163663765223b733a33323a226430663237316335616161663238363738353435656231383061333037333539223b733a33323a226165346263323932623332343063363332343866376261653332646263366166223b733a33323a223031383234633435366236383738633637663238646132656639393338383738223b733a33323a223435303761393262393563363537346166613131366463613431356362363464223b733a33323a223931353864303035346136646136383636613138386565636232346565373534223b733a33323a223562393839303231653166633365336666646339383164653665663234383164223b733a33323a226239663037643866353539336565616262646135363731613136313864373966223b733a33323a223339383136323036343733356563396337363936626263653133623237313134223b733a33323a226663393334623963346336346136303932393833666530323733363532313237223b733a33323a226136373666643131363231643661656165666262376262363336306639643831223b733a33323a223461636661383132333739336137303330666333336430666539396536383639223b733a33323a226332373434663738313034666339663961333233633962663863643733306531223b733a33323a223066313038373962666332636430346164616463323166613936633737613738223b733a33323a226563386265663234303635393061633062343062636137313233393365326561223b733a33323a223062393730343264356132346464313761333836363934633361373336613334223b733a33323a223763353965376231623734356631396130643862383331313534653438646337223b733a33323a223564333764356431386133363165396263316261623939633536313337656233223b733a33323a223432656537356338616236366463666431303936356135343231633138353961223b733a33323a223330636466393934633330653466373663633831613737663433623331346133223b733a33323a223637356538636164613962633138633039306361626633323731306539303536223b733a33323a223461653032656365623565646361653534313135336532616336323465343030223b733a33323a223762646232393261666232363137373963373637363039333062643932346465223b733a33323a223464376563383536636265646137623161373739366234353338336239663032223b733a33323a223531376331333235306664393966333231393535313937356331346434633966223b733a33323a223834383138373133336538393436616134383366623736343633303232363939223b733a33323a223534646530326266653761386465343931336237383865613932626135663331223b733a33323a223063613830623031366266363564333964646264316137636237333164333364223b733a33323a223030336164336265353130386136663462366131383164653731633266373139223b733a33323a226538313638343530646537303763613237373235303239636332613236643732223b733a33323a226631323134313533393366626465663865326536303663316133613231663363223b733a33323a223630333135383035363837393238383039303166313764343434613635633363223b733a33323a226133373331313363363334366234613864353138663335336434326230383163223b733a33323a223564386130656239643735616665663432306133616638613862393936333831223b733a33323a223665376261303563316130373166346236626365646635363730316439393732223b733a33323a226161343861366636353139643064393736653862393834653163663334343065223b733a33323a223633353332353837353130653236393461373065373435333435316461616331223b733a33323a223764326561316363306433633466306336616635396465366333373661376433223b733a33323a226463343539663539633630616232613334313237333130623464633037303561223b733a33323a223837393130323330333665653939336137613931623735313062306662666665223b733a33323a223961343531396663386236313365613166323831396234383132346361313931223b733a33323a223063393864353935326336626363663365353463623161386433663836646232223b733a33323a223634346261313431613863356535323262303939366433396164636133313730223b733a33323a226336656337393338663765616331336564363566356566316635376662363463223b733a33323a223036646666633739363465663137383363656331663962333261646162353238223b7d733a343a2268617368223b733a36353a2230366466666337393634656631373833636563316639623332616461623532382d6336656337393338663765616331336564363566356566316635376662363463223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f7265736f7572636574656d706c617465666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a323a7b733a33323a223365346633363930643364643732376633323965663934613236353361346238223b733a33323a226230613633383961363164356530623032313262336462373633656137396439223b733a33323a223232326364643237626236396364623230643466376236353466633666306562223b733a33323a223538313365303331653066323930623465306537653238363837666134623134223b7d733a343a2268617368223b733a36353a2235383133653033316530663239306234653065376532383638376661346231342d3232326364643237626236396364623230643466376236353466633666306562223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a31323a7b733a33323a223031366663346562626265643934613363653531336337643366613233356564223b733a33323a226434356134336538643934393961666335616539313061306661373665663661223b733a33323a223138366437663131626565616438306363363761313265303037376362303930223b733a33323a223434356535623639636431363466623164313936373937313734643537633162223b733a33323a226164373338303936333735363436633338666436376162643634666563613238223b733a33323a223231346361326535356163313861653561633237393663346138343332313336223b733a33323a226364656533336361643061313736373437623939396339333565376236373535223b733a33323a223537383133643663646230386435633863376163356564343965633833373730223b733a33323a223735623162643363313431363933383331313365383466303737643036323138223b733a33323a226639643230363363383835636137393639313539666437633862613961383639223b733a33323a226631356565663534343130656336366137316430323331636364666339373039223b733a33323a223236636161386664626463333665323634656436343361653331643730396137223b733a33323a226134303535396437613265353863393234383431363333343166346135353461223b733a33323a226161633861666634323833343436363739303736663864666131386265346337223b733a33323a226165386336393831343633396139643966616339363938633862376365663061223b733a33323a226236393064316631393036376163383130393235636138643764643938656165223b733a33323a223437663364663163313766363431383737653964613330313833303534656564223b733a33323a223633326561356431363463623033323131366430643438656637366431643335223b733a33323a223437383333613130393033356635313964343635313463326466363232393138223b733a33323a226366646230316135623335333239653035346334303236343133623834323165223b733a33323a223766353264336265633431623030383336333130326533656536313365303165223b733a33323a223961646335333563336637326233653866643765363565326264623239623835223b733a33323a223662303763613263353038326564336365653833363636343239353433356566223b733a33323a223562363434623464333530396634666365633836633964656133333663376130223b7d733a343a2268617368223b733a36353a2235623634346234643335303966346663656338366339646561333336633761302d3662303763613263353038326564336365653833363636343239353433356566223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1729889218),
('i5umphl2b9hngljbmq3a2atsjg', 0x5f5f4c616d696e61737c613a333a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313733303635373437392e33303135393b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a22756f71306167623336337575626c6e3162336b3039746c336130223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303730303637323b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226333663533386231336433366664353664626133626266363830656136333165223b733a33323a223939313136373763353531346261353133383463323536343239643434363532223b7d733a343a2268617368223b733a36353a2239393131363737633535313462613531333834633235363432396434343635322d6333663533386231336433366664353664626133626266363830656136333165223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a383a226d65737361676573223b613a313a7b693a313b613a313a7b693a303b733a32333a225375636365737366756c6c79206c6f67676564206f7574223b7d7d7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d72656469726563745f75726c7c4e3b, 1730657479),
('k02iheg7em2e3m8nb2d1tda393', 0x5f5f4c616d696e61737c613a343a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313733303635363030322e3938393634383b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a2275736c366a61746d76616b6c73657664756e3934706937713834223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303639393138383b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313733303639393139313b7d7d72656469726563745f75726c7c733a34383a22687474703a2f2f6c6f63616c686f73742f53697465732f6f6d656b612d732f61646d696e2f757365722f312f65646974223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223231663535613632633133373466653332663336663665616335333264643464223b733a33323a223537626436376561653563613033316563656639303764636339376332393538223b7d733a343a2268617368223b733a36353a2235376264363765616535636130333165636566393037646363393763323935382d3231663535613632633133373466653332663336663665616335333264643464223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a383a226d65737361676573223b613a313a7b693a313b613a313a7b693a303b733a32333a225375636365737366756c6c79206c6f67676564206f7574223b7d7d7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223335393439396163623866656230643937383232663037313935326233636632223b733a33323a223766383066313436323361373336373134383337303539396234343638353234223b7d733a343a2268617368223b733a36353a2237663830663134363233613733363731343833373035393962343436383532342d3335393439396163623866656230643937383232663037313935326233636632223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1730656002),
('k386tqu517dd2u89aste8hr1bk', 0x5f5f4c616d696e61737c613a333a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313733303635363230382e3734363637363b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a22703033737271693765706f697061316c7035696a687361746162223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303639393339343b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a333a7b733a33323a226437636230646263316263303666633161633335666633323665303664363439223b733a33323a223131633061663238613836363437643632656335616164623962326364346631223b733a33323a226466363064663930666337643231386439333539653065323261653965393239223b733a33323a223639643263633832643238386561366231346363656135383066316132306532223b733a33323a226334333766356435633432346538376165396638636534316461666663653134223b733a33323a223133396538386636656435366438346234333830333966333239356532333466223b7d733a343a2268617368223b733a36353a2231333965383866366564353664383462343338303339663332393565323334662d6334333766356435633432346538376165396638636534316461666663653134223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a383a226d65737361676573223b613a313a7b693a313b613a313a7b693a303b733a32333a225375636365737366756c6c79206c6f67676564206f7574223b7d7d7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d72656469726563745f75726c7c4e3b, 1730656208),
('ljuircc17tj2a0p95jlmvr5gug', 0x5f5f4c616d696e61737c613a333a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313733303635383430382e3836313439333b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a2238756c766466646c71666b756339646336736a746b6a33686176223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303730313532363b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a323a7b733a33323a223334303738376136326665656363353034386361316139646234326263626361223b733a33323a223764636633383637303336633139363636363765663835306636663465366631223b733a33323a226430303065646363306366386336656230633762326665373162316666393734223b733a33323a223365656662656636613332313166373763386463616562636234626537343533223b7d733a343a2268617368223b733a36353a2233656566626566366133323131663737633864636165626362346265373435332d6430303065646363306366386336656230633762326665373162316666393734223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d72656469726563745f75726c7c4e3b, 1730658408),
('lqh2ku9cvdrv15i0u5nl630oh3', 0x5f5f4c616d696e61737c613a333a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313733303635373437322e3832383234363b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a22396a736176736f323168706e756f756b70673172343033676a75223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303639393432393b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a343a7b733a33323a226365376238333662393735373231633938393138383064303630316661386333223b733a33323a226561333636373635666362393761653062343133363566323139643436336632223b733a33323a226137346262613438623164313037636534643636643066356463326365346535223b733a33323a223566303539323439383038303761613865356264316661663661383233386339223b733a33323a223732663338376435333532636435333463646361353333343661663439343334223b733a33323a226235613131633436363464653366306663343333356633303631363737383236223b733a33323a223133356531636563326336613438373066373266646634613662613739373739223b733a33323a223736656261643139613733393262386230386636393863303064326564343663223b7d733a343a2268617368223b733a36353a2237366562616431396137333932623862303866363938633030643265643436632d3133356531636563326336613438373066373266646634613662613739373739223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a383a226d65737361676573223b613a313a7b693a313b613a313a7b693a303b733a32333a225375636365737366756c6c79206c6f67676564206f7574223b7d7d7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d72656469726563745f75726c7c4e3b, 1730657472),
('mjm8p33gjm1f9mmc3122or6p32', 0x5f5f4c616d696e61737c613a353a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313732393439373332342e3131383939373b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a2262697062666d69397367696d6739653362303130696962736337223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313732393533393937323b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313732393534303039363b7d733a34343a224c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313732393534303039303b7d7d72656469726563745f75726c7c733a33363a22687474703a2f2f6c6f63616c686f73742f53697465732f6f6d656b612d732f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223830313133393362333431323964306634356138316534616533613064633061223b733a33323a226363386335663966396537356230666263666462383838373163383638356462223b7d733a343a2268617368223b733a36353a2263633863356639663965373562306662636664623838383731633836383564622d3830313133393362333431323964306634356138316534616533613064633061223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a343a7b733a33323a226463616561303931326331363565663530613835353532346364643233643266223b733a33323a223537333332303563386363343437316666336561616534373938663936363633223b733a33323a223363643535653535393832353935326230313936303435313037336235376137223b733a33323a223731396530303936666165373733646362353465326463343834373732343866223b733a33323a226431353734386637646431316364323835336630393564313132363031313461223b733a33323a223161333433306437356232663238346435633732303666656637633766373561223b733a33323a223333353866313531353632353230636234653363346366303837353864613439223b733a33323a226262613262643762616265653833646335333236343234353432633963333438223b7d733a343a2268617368223b733a36353a2262626132626437626162656538336463353332363432343534326339633334382d3333353866313531353632353230636234653363346366303837353864613439223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a323a7b733a33323a223733326530366462656363386462336437323462323434636631393363623764223b733a33323a223562613031346330343231373061636562636436373735633336373064383061223b733a33323a223239613334613864633034656566643165656463356631323765643063663238223b733a33323a226134633361626531616436643831646334613462313961336465346166356539223b7d733a343a2268617368223b733a36353a2261346333616265316164366438316463346134623139613364653461663565392d3239613334613864633034656566643165656463356631323765643063663238223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1729497324),
('n2nri1735572b8h5m8dk17klic', 0x5f5f4c616d696e61737c613a343a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313733303731383333312e3232333731373b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a2273336c6162706d376f686a61336c38746664753137686f696f35223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303736313431383b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313733303736313435383b7d7d72656469726563745f75726c7c733a33363a22687474703a2f2f6c6f63616c686f73742f53697465732f6f6d656b612d732f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226339616138363064396664623838383139316633613263316537643531346130223b733a33323a223534633939363634626635303665653038353663333361383539613131633931223b7d733a343a2268617368223b733a36353a2235346339393636346266353036656530383536633333613835396131316339312d6339616138363064396664623838383139316633613263316537643531346130223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a323a7b733a33323a223832336239613039646237313633336461646137366262333338626533303663223b733a33323a223833386138323865613534333235353535626132396236306361653932373139223b733a33323a223162623165316564373232393164346166623432656633383437626531333761223b733a33323a226666383239646365306331333265313165373062666630316634386162363130223b7d733a343a2268617368223b733a36353a2266663832396463653063313332653131653730626666303166343861623631302d3162623165316564373232393164346166623432656633383437626531333761223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1730718331);
INSERT INTO `session` (`id`, `data`, `modified`) VALUES
('pedctbiqru68ha0ifq86vkfvsi', 0x5f5f4c616d696e61737c613a363a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313732383930303830392e3834313135373b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a22753939646f686f3964766b63706569726d756665386871637433223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313732383933323430323b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313732383934333938313b7d733a35333a224c616d696e61735f56616c696461746f725f437372665f73616c745f7265736f7572636574656d706c617465666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313732383934333535383b7d733a34343a224c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313732383933383836313b7d7d72656469726563745f75726c7c733a33363a22687474703a2f2f6c6f63616c686f73742f53697465732f6f6d656b612d732f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223635653066663139323765653133333938393137313736393537343761623936223b733a33323a226534643036316165316538616661363738383531363439386337323830663632223b7d733a343a2268617368223b733a36353a2265346430363161653165386166613637383835313634393863373238306636322d3635653066663139323765653133333938393137313736393537343761623936223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a39333a7b733a33323a223636333830616236626462336132356333633431663263363466386630316236223b733a33323a223964363361383636316433373334343266316134656262353437346133643436223b733a33323a223932643038653237616562336335396332623861393232393131646437333766223b733a33323a223532393431363164613464396134326639663163613463323533663063303564223b733a33323a223135316266323236663864663865333138316262623232396162393465353666223b733a33323a223534336238353130346266346464633862323332396161646639333739636533223b733a33323a223066643663666133323936356232323437333064366465383534376433643362223b733a33323a223438303633636264386462633230316663323763366462353766643535363336223b733a33323a226236356162656361373064656436656666396162323939616439373364643433223b733a33323a226462323365386263336565633065623638366337633166303936623266666663223b733a33323a223739633263336361363434616232303063623632376662313966613763633665223b733a33323a226130353661343432323934386664633433613135313930386235626130363338223b733a33323a226336666365396334386136396636623365306366666234306233303336623930223b733a33323a223163356361656631613337343633666633353066643235376465353136646431223b733a33323a223830313639393834376662633463626135613737336166623038616533303862223b733a33323a226230393831633362336166346563613764353564333762363563663565643930223b733a33323a226638346464643531316136393936316565396131396532613564656265383966223b733a33323a226135393666613238363033366235373462356336646665396433336136326435223b733a33323a226137643835653462386637306537633365306336663537336533343531336262223b733a33323a226636616234306461326230323031326334383033643935323163373337633866223b733a33323a226338336366633438643436633061623365393564396437353765396233393963223b733a33323a226539313963626361333638386237396437396165363434623966643963303932223b733a33323a226466633261393431643839656538383335626432336265396661643161663232223b733a33323a223236363932663439346565643539616233376464303632646535623466343734223b733a33323a223339646239376166303034376339323131366131646135386364396231313239223b733a33323a223936646138613238353662393166346338343338346562303662306233366131223b733a33323a223165373862616131393330336635383864323738626233383461633630666361223b733a33323a223635646464303163336332623664383964316439363837336165376236383033223b733a33323a226465396564363134656539653964623336636233323963666166326532323162223b733a33323a223132666437613032376638366436396339643135623537666631333166636439223b733a33323a223763666364663965313565383562323762343030656632313761316430646635223b733a33323a223034643237646135643735656364663837663531653537333538386539663664223b733a33323a223063333230393039653838613033373435626635396430323333653339396433223b733a33323a223932356433353131303832353466633830366331366338623466343935643331223b733a33323a226432373735396463366166323038336130643562306639643161623630303033223b733a33323a223736393539303333613630383839616636316530376138383434396138636435223b733a33323a223233373733363734323165326538656235666566613138303437373864326633223b733a33323a223262356630373830613861663761313935333766663362653532616233663831223b733a33323a226638643034613863373166643539373361353864646661343563343833373866223b733a33323a223461326638313837613238326538353463343836323937643531643536303238223b733a33323a226463663063623837333165646339643463393766636665663961313139303266223b733a33323a223434613664343831616566343633396239353630653766633435653038626638223b733a33323a226233393934613365396231666339356132616632396461376232663532316631223b733a33323a223537346538363033376265343365626533326265366635376334643365656539223b733a33323a223335333238613836313737643436626330666236653661643564343030383734223b733a33323a223538623432616633643438656433353466373364393737363934643063653462223b733a33323a226332326238303166386362646434386261626135306331343031303562333330223b733a33323a223434616662373333383962396636666334323066356566613762373664666665223b733a33323a226638343735666431643333376232306136326136653739653939656238363530223b733a33323a226463613065636439396664623738353938636366373566336636313635376463223b733a33323a223064646363333432613333653334326566393236636130613165623966326138223b733a33323a223438303635646330313962323234643337646663636165363766613032653838223b733a33323a226461646365383031386132376638373164393538383264353264613863386330223b733a33323a223139313463383562393934336565313631383762373831633063343161323630223b733a33323a223537316330643066636366303939303634653433326134303933373163336534223b733a33323a226130333662316338393565613637393561336162363033386238353534653361223b733a33323a223836633666306461386663643235336263613838623437613366633331396166223b733a33323a226536623436386539616331386261343463313666363433663631333263333136223b733a33323a223636363137636536643434303662633234613061306636663236626239356634223b733a33323a223665323134333066386131656639613765303666613566613263613764623266223b733a33323a223465376263333564313633383736653762633238386430313335633765373037223b733a33323a223332666438353530303235396636363561303933356535633863666261313337223b733a33323a223565656563613064623835616431636265346164373263396636313761656232223b733a33323a223535363430333438626264323266336563323435366335303339656136366663223b733a33323a223466303561653238396136323665336161316633636439336161653537386164223b733a33323a223637353561643733613864386564386234383631636366626430366366643861223b733a33323a223631643065313463346361333132363739633261366130393964313264336364223b733a33323a226366643662366232346464326338363435636462323837396339663465626238223b733a33323a226136313139393231313937363963613763613137373337613238396463393465223b733a33323a223132363134363734366338313932626436636633643465346434613234346536223b733a33323a226134383133323764366230613964333239343031333030633630663761336630223b733a33323a223230373233356132323535613665396534396564356435663339386130353262223b733a33323a223463316538616663363939643932653437663166663732316533646539386534223b733a33323a223866393737646261613734613630643730613034326662636165326335633137223b733a33323a226135356231366533616366623565333839356661396564613338663730393335223b733a33323a223764396562306637313439643034383238373466656338386632613663666630223b733a33323a226232626331373363373231393532626636323237626137656536366261366630223b733a33323a226332363634316633383766373537336238303333383838316166336438653436223b733a33323a223961653964303863656335323531323062366364623662636161343233313866223b733a33323a226635646337326536353661346237393530326261383730333839363934626263223b733a33323a226436303766616163616131636362336339326131303865363136653466356465223b733a33323a223739313634653134626463316231326663666138376233363331313732376466223b733a33323a226362636665316431353532633131666339346365393236336364373166373132223b733a33323a223637326538336439653965343632306332623462626231373638653832376364223b733a33323a223737643163666430383661333830663639616233353234623434326136343939223b733a33323a226664313665353031613836633031323364303762303463663039653534313438223b733a33323a226533613731316137653532616439663631393438326334643438646237616630223b733a33323a223532333364363633613632333437613263346565653533386536363132633233223b733a33323a223030313134363766343432626432326362646266386531366334636136333162223b733a33323a226533376361333263363838346539643032373361313736623362353332353563223b733a33323a226234353530383830313761353931333065396164656337623636356535306164223b733a33323a226365333937383463373963633131303864383835333361303632333961623234223b733a33323a223262623335303838616264623238646462646361396131306662386433626132223b733a33323a223464303839383137643566636264363830393837326162366666323866393230223b733a33323a226164636566383164346132313964646639626433363235326438346139663964223b733a33323a223435636236393430663762313735623465303831613631616330373138396338223b733a33323a223039313264373732383333363239396134333932343531656135643062333832223b733a33323a226166633733336532666366303933313032363436333361363165353033383836223b733a33323a226236363666376564323864396137323238306335373064363064613538353432223b733a33323a223631396664323961653565333039666237613231343238303735666236333435223b733a33323a223632633830303164316437336565623261393939653633663130333262383433223b733a33323a223336633832663866633863653030323662666230643135393936356332326663223b733a33323a223635323566396334396263616565366437613633633661326433326639323730223b733a33323a223266643834306435366361316439616366353631333734343439643866323632223b733a33323a223962633430313530643838346565326633613935613065306162333235656665223b733a33323a226331616133303838306630663830386134623338643635326430383935383865223b733a33323a226235396635623231303363333939363837303566343131396132353136393663223b733a33323a226664343831386230313839366261633734303366333863353833313764636631223b733a33323a226664396638636533636639333664613366313132393534386334656634356330223b733a33323a223732616330383136383533316561346238376537373337383465353336333536223b733a33323a223931393233333631336536663734393535613966373033616363376564343965223b733a33323a223234393933363330316365306138646465303362393331643564306365643462223b733a33323a223434633036306166386661353239613935623561386433633961343338353263223b733a33323a223239636432613833333333306233373437313736323931643532613539366237223b733a33323a226134633438326663666263363165316234336137383965323832333833396135223b733a33323a223966316664356163363939396162663962373637326130386636303137613239223b733a33323a226535643035643136393738316138386665333164623266393435663635643531223b733a33323a226564346265643132346432653466376364346537383034613534326434653463223b733a33323a223037396561306162323430343538323865626637626331353538326164333736223b733a33323a223866383639343766623064343530666263623535383766623766356165656366223b733a33323a223937613939613537323238643836323863313735333664626239393062313364223b733a33323a223739613661383935306564663730646331396664613634656464663331343639223b733a33323a226334656230623762326562663534386332363863636139363263313863373430223b733a33323a223261633333663763393339626538333365663963623062333365656130643264223b733a33323a223963613936386461636363643563333238326464376435616131656562323963223b733a33323a223661623430653134386235636237666437633162636462656637626237663633223b733a33323a223533333163343961323739316339326237356135643932393862663031646330223b733a33323a226335323934633030326362373261373430376363323432653739653662343766223b733a33323a226538306635386532643136373837346638333539396263393763393439343563223b733a33323a223731656631313666373637353062643736393762363532383663346366636662223b733a33323a223230346666663233656365613061613465663639313735623538316365316531223b733a33323a223965643433313235303439373632623932643932663838646362373362373464223b733a33323a226562383830396465346437393338363263366635386563643731656665616634223b733a33323a226536623636643165646236623135313363343663663836333665396533386464223b733a33323a223261346237313037343534353237393934643734306232313536313562633736223b733a33323a223234643932633562393138656164363863643734396234366261353662623431223b733a33323a226535663434366162636439313932643032326536363463383632636531383735223b733a33323a226637623538623632306261393731316366623135623833373262616536663466223b733a33323a223138666166366439653165663336363133613137363763643864643162613335223b733a33323a226130316364656535393231313161613161333633353539373034626461356332223b733a33323a223330336265616233303162383631383637326235623461366232653730613261223b733a33323a223763353332346331643933363632363538633933316531366631353334346433223b733a33323a226166616537346636373835643431363266383130343039613930306465666638223b733a33323a226532633537643563653031333039346438396336323636636561303165383130223b733a33323a226632616134353830623634316331656236386663333038643630636634336633223b733a33323a226135393463376539643161623538326161363933323361373930396232386464223b733a33323a223631323565333736646365613963313138366136326335356235653332646232223b733a33323a223736623736303264306666383863356231646561323966376634373764316537223b733a33323a226639376364623363356334303739383562356436666364316366643031626463223b733a33323a223132346236383666323631666265393530363537353531343632306261383332223b733a33323a223361633865373564646536353934313065656537303731613435356631386539223b733a33323a226433336562613537636262353931623063343733356437646263636133366532223b733a33323a223266366435303236373333376236626534306266313631356663313638376161223b733a33323a226331336162396165616565356135653661353530353831356230626464323133223b733a33323a223566356263633335386635616132376338623230326235333339653432316536223b733a33323a223766633131663364343339663230633638383863396632656630646236393030223b733a33323a226331663236613264343433303664633062313966373030356130373233386139223b733a33323a223235303261623238323763336232636136316335363736333735363464346337223b733a33323a223738323137666535616134306264633038383333623061643066616665353134223b733a33323a223361383430636134346132376431656365623662623663656464323431396439223b733a33323a226235333131613964323834653162386238333437623239646630643966343263223b733a33323a226366383132623332653463356264366564336238326162353961333033373961223b733a33323a226364623731666537633932656361633263653665653635663566646164623332223b733a33323a223133366264303736626138333233663033633037326139346331646164633463223b733a33323a226163346665653230323432666262323339363037643231373163613634633266223b733a33323a226131623839633330373761306465376235666432663230373466376161656633223b733a33323a223966383939323035323930643431613636336264633365643161323436663337223b733a33323a223862373332383332306230626437663164376261353962616234643162383934223b733a33323a223539343564613461386135646138343263383934633630346334306266373032223b733a33323a223363666632363835353339356539323161366430386139613063333061336633223b733a33323a226461393830656364336438653231656130313132316539663461626232376432223b733a33323a223738626163663034396466343631363432616364356562373635306636386539223b733a33323a223836643334363030613532306265346230666237303762653464346562386465223b733a33323a226139386631303966373633346263643233333139663663666464623066663366223b733a33323a223962393364353865333838316534333134303861613562656263613566313738223b733a33323a223736616437643965613665346433313033653037393835613136303535356465223b733a33323a226435663962336439613964383961643335363937643861616530653339646664223b733a33323a223766663538356165396639636362343331396536383466653831383732316133223b733a33323a226431333865353266623331383638656363366632396133656631633264316432223b733a33323a223663353838663064633834653938383739663934343139663439626133663333223b733a33323a223437366462393733303236353461393131336164376636616232313639303363223b733a33323a223062323733306531386630623063383362306562616236303665656630303834223b733a33323a223231623332303536323566383532653139393462326661323666313635363638223b733a33323a223132633939666238376631363837363363343636303836616632343762656364223b733a33323a223966306231363532386564353361663937643032613739323966643239663237223b733a33323a226130373762643932353965306562643936656235656261356161386361376535223b7d733a343a2268617368223b733a36353a2261303737626439323539653065626439366562356562613561613863613765352d3966306231363532386564353361663937643032613739323966643239663237223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f7265736f7572636574656d706c617465666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a363a7b733a33323a223537643466373562373935373963666133333934393066613030393935323631223b733a33323a223637393337303664623935316461386231653764626336376438643235366333223b733a33323a223331316564303938663932613030363261653738393761633562303033386363223b733a33323a223030633662333362386163663130653235613236633138663337336265306331223b733a33323a226138373165623033646133636639623266353732333566326533656333616431223b733a33323a226439303963666266653238643263386531376466663138383130303066313139223b733a33323a223732393231666136353736376436326362326664393537623465303130353366223b733a33323a223365313937363931643032366433616163376335616264663537663837663433223b733a33323a226236393036323333646131663461353230346134373730313238343833333364223b733a33323a226634626230643833366535333965316433656562623432313135356132336334223b733a33323a223936353763666535343333353361313962633130633961333561643830306438223b733a33323a226235383261343831363465653833643164343034343935646134313462366464223b7d733a343a2268617368223b733a36353a2262353832613438313634656538336431643430343439356461343134623664642d3936353763666535343333353361313962633130633961333561643830306438223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a31313a7b733a33323a223532663761386336353863363666653664333836376562353432366531303262223b733a33323a223532653239393961633738373866663431663832623931393563623265623437223b733a33323a226564626134383933333064393361386230643634323832663638383832326535223b733a33323a223063666338316538353165643935613163303332323861663532346362306332223b733a33323a223738393965303136636630663935643435303131313166386635373436363433223b733a33323a223764653431336135373861666363623366323035666539343063303735613135223b733a33323a223162343039363635316138333538386666343332323231323230643739303365223b733a33323a223362336466653065643763396335623363326434356366306264326165313762223b733a33323a223261653066663931653331666564383936613237313366643938396334643639223b733a33323a223435333837306437323337623439363738336635366362303662636131633865223b733a33323a223061326163623763646430363163313330643231636438623962663264656330223b733a33323a226666343531306438363131306435343931393632643766626332323636343230223b733a33323a223530336664303465346138386462373935623734333534626639353465633364223b733a33323a223439633861643735616431393062653131353533306538383163653164363933223b733a33323a226131336233653833653362313935383135336630633034306631383833393464223b733a33323a226134333236663332373334326565383836396536633136353565633163313735223b733a33323a223332363538353963363831346161323766636566383434313733383232623061223b733a33323a223365336335386666633937356166653438663133663066316333366566333232223b733a33323a223035373765306331396163626535353264326261356538323532393632333433223b733a33323a223030613638336132626435653531323433343337373862376438633537643438223b733a33323a223732663634373165303134633231383633366636643434646365373833656139223b733a33323a226465643565313538303762346531316532363362393162633863343963313035223b7d733a343a2268617368223b733a36353a2264656435653135383037623465313165323633623931626338633439633130352d3732663634373165303134633231383633366636643434646365373833656139223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1728900810),
('q5n3uhiu81iv0hl0ktbp3q6pkk', 0x5f5f4c616d696e61737c613a343a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313732393632343631312e3738333331353b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a2234647135326a6e313034386f696d323973706a73637073743835223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313732393636363136393b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313732393636373738323b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223832393964653535316131623766363765323234393732613739346636373765223b733a33323a226365623031383061356464656362333332663261613164663334663030363736223b7d733a343a2268617368223b733a36353a2263656230313830613564646563623333326632616131646633346630303637362d3832393964653535316131623766363765323234393732613739346636373765223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d72656469726563745f75726c7c4e3b4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a343a7b733a33323a223266393232613762343264356633613461383166666532633530336433386161223b733a33323a223761353238343835623362353065323761396665316436353962666464633232223b733a33323a226261373163623033323633333465323365663632376138646338653936356535223b733a33323a226130636632653535643539663531656164666133383036623161656137393632223b733a33323a226331626631616633633034626266646166346164613561363930383632623131223b733a33323a223465323738663461333431666139666665323462316333643835343761616630223b733a33323a223433376366333233626630663233663039616333666665396365383531396437223b733a33323a223331313663306635326661616639656635363533323031623564373830303431223b7d733a343a2268617368223b733a36353a2233313136633066353266616166396566353635333230316235643738303034312d3433376366333233626630663233663039616333666665396365383531396437223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1729624612),
('qu7273nm9bufk6qd7abo7s5eal', 0x5f5f4c616d696e61737c613a333a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313732393932383934302e3330373435373b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a22766f33763130397233357272696e683934343472357132743065223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313732393937323133323b7d7d72656469726563745f75726c7c733a33363a22687474703a2f2f6c6f63616c686f73742f53697465732f6f6d656b612d732f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223363326434343738376631343131656331646532613834653832336239353137223b733a33323a223535333538373132353039613066316564353930613031656430636464373564223b7d733a343a2268617368223b733a36353a2235353335383731323530396130663165643539306130316564306364643735642d3363326434343738376631343131656331646532613834653832336239353137223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1729928940),
('s5hv4o4fcc8bfmt65c29akmiln', 0x5f5f4c616d696e61737c613a353a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313732383536333436342e3037313935343b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a22666a6e6a686e75667331627036396e6c69336a63756d63363533223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313732383630323834393b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313732383630363636343b7d733a34343a224c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313732383630333537383b7d7d72656469726563745f75726c7c733a33363a22687474703a2f2f6c6f63616c686f73742f53697465732f6f6d656b612d732f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226364616665626436663464306561623161613365656332363235353562336461223b733a33323a223033376131323461636431666166363935656433626433663832623264323335223b7d733a343a2268617368223b733a36353a2230333761313234616364316661663639356564336264336638326232643233352d6364616665626436663464306561623161613365656332363235353562336461223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a33373a7b733a33323a223632346635656334313963653830366664623532646266356639303965356536223b733a33323a223733383136383466303938353233323337313238653762616231336233633563223b733a33323a226435366561313763636431303661313632313934393061373863386161643931223b733a33323a226464306263646236613931343862353037363933623637373536326663373061223b733a33323a223064316665303831363566396465306236386232373632646165366364313064223b733a33323a223166643365626639326466396665646239643634373837613730633135346130223b733a33323a226366323133643139396335653430356533383266366231623137613562326430223b733a33323a223739653230643662363233663363666465323132393038306662666333623630223b733a33323a223466623765343335396165353634306266643531356539336533643039373430223b733a33323a226134303830633938636233646634323666393663363035363930643131643966223b733a33323a226564333130663763396164643931313063646432396462393536306539303530223b733a33323a226539633034393435333263656237373931366365336264383030313565343365223b733a33323a226135366264336464313038386537363163303066643438313166653361623130223b733a33323a223936343939373331613532363937373232313462383462396132633534326337223b733a33323a226435386338356635383735386335633931643561306437353863333666353962223b733a33323a223566626138646636333961346663303561303262363363643837633261613564223b733a33323a223336376134363035643937396438316338383635663262633564393666336634223b733a33323a223032333233323261303830353531663432383061316239323563313930383935223b733a33323a226434326166633530346462346439643561346635626561363739316637613937223b733a33323a223362316662366438313563396436633834333065373666376230646665303562223b733a33323a223936393866306439303638623764343866396366646535346666333466616266223b733a33323a223835323561356337633666653134316539363266343163373332363139383134223b733a33323a223766343262323061363963653837376163383239386434343266383534666636223b733a33323a223632646262356132386337393239346462663261336635633037663830613265223b733a33323a226133613634313136363563353536363663643664303632353063633732343030223b733a33323a226435386233616632343266313962346337373138313932323233653866656532223b733a33323a226365386434303635373437333839626536656561633533366632396134346431223b733a33323a223766346665333834353736326130396538376331376265633031333761656361223b733a33323a223332303037663631636164663934383333666435636537386637366536633434223b733a33323a226565323066313937306335376561643961326161623035396432326531616163223b733a33323a226439616161333735623936633962376633646638316262363635653464356465223b733a33323a223739343736383738346165646430303365366238373230383836656234623038223b733a33323a226165363365366335323937626534326533333966393536376465303366356135223b733a33323a223437313066386265616138383665643861356132346634383735336364326264223b733a33323a223233346662666137316234643436616530396364643233623231663064343132223b733a33323a223937396130656439306537376237373730306136353462393564366538316138223b733a33323a223939613133396133616532343235363138396237313562333536343830386132223b733a33323a226462613937636463363461663136386139326261336461656437363831616339223b733a33323a226636366237656130653536313334666432383263323234386533343965343737223b733a33323a226239623463313663386465383734336166646437663734353762376236353339223b733a33323a223162336330363533663263626639373031653763633263303930303035366362223b733a33323a226131396634356233633632303462383633666662386638656132373735393737223b733a33323a223138643763623239633937656239623866323366613232336633306564613566223b733a33323a226237613465643533323336636130313966346666333832383338383838353332223b733a33323a226136633564616661623831356162653266363635306466303163386534633137223b733a33323a223264626661396466306261396539346430343163313163333962623865366563223b733a33323a223138363832633338386631363132356164336165626365643531633936663933223b733a33323a226663376132313833663132373538366537616436393162636637623335643638223b733a33323a223064636430326661323930383331313561633564303536613761383539616664223b733a33323a226635653631326465653736376231663937333634303965623962656662613635223b733a33323a226237383465636662373365363938396462613139313162376534356462613538223b733a33323a223538636432336361663530356534333337346233663462323530663763333262223b733a33323a223363393238343166616130323130353330343832353930336631313038373434223b733a33323a223139393939393437336461396565313931663462303463363861313661616136223b733a33323a223131653532653137623866666430643164383530653465393734336530393236223b733a33323a226664376636306337663137363835636132326330323065336564306532323664223b733a33323a223735643436363363366532633439373339623465623931653061633038303330223b733a33323a226234656437366236643761383565316233663665656662643263643066336261223b733a33323a223732643935326334323334323863353362643966383835613331323036643733223b733a33323a223237303638336634366461383932616264333464353736323539653962333563223b733a33323a223730343765633539373635633933613561616631383132373361313836623939223b733a33323a223262316463333737656537373337323264366533626166393838366338616532223b733a33323a223962343866396630323063383231326331653436326233633266316131303166223b733a33323a223766333163313637623663353939366435386465336133323137336161313439223b733a33323a223433373737666263303863363734346661393633363665373632653862313865223b733a33323a223536353265623232343065633638626130663239333333326462393961346464223b733a33323a226435643662633666393536626266373839353966336437303231616433356565223b733a33323a223439323230373032616136643536363837396337353638346632653464383765223b733a33323a223261613838323333386138393239373261323561396336393330303762343139223b733a33323a223236643032313530616534393135303365616563383662326466616365623838223b733a33323a223831613437636164376430363137383366353364643961303435633764653639223b733a33323a223063343731393034396465643238363535353766653463373665626439383166223b733a33323a223662663735396366646364656461663338666231336233333665346236623262223b733a33323a223666303732316130623763663566663932396634653262306566393764623736223b7d733a343a2268617368223b733a36353a2236663037323161306237636635666639323966346532623065663937646237362d3662663735396366646364656461663338666231336233333665346236623262223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a323a7b733a33323a223566656466383531626233663935383433373938343735343937353131396339223b733a33323a226537623835363736303139353864663235313465383030376462366237363434223b733a33323a226139633865613933636439386132663730623538363137366432393737623463223b733a33323a226535643432396335663034653161333565376239323563643461373465613736223b7d733a343a2268617368223b733a36353a2265356434323963356630346531613335653762393235636434613734656137362d6139633865613933636439386132663730623538363137366432393737623463223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1728563464),
('ta86ep20fp70kggogk9atddj2o', 0x5f5f4c616d696e61737c613a343a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313732393534353831302e313739333b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a226a7065326273756e366569313330706e69373137696b36693475223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313732393538353833343b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313732393538383933313b7d7d72656469726563745f75726c7c733a33363a22687474703a2f2f6c6f63616c686f73742f53697465732f6f6d656b612d732f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223733626634376463376163323835623335336138353461306663653233316433223b733a33323a223861383335373536626561653437393631663938623265613863393562326163223b7d733a343a2268617368223b733a36353a2238613833353735366265616534373936316639386232656138633935623261632d3733626634376463376163323835623335336138353461306663653233316433223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a31313a7b733a33323a223665383262346432613066323233313738393632336233393562333866376364223b733a33323a223233366334316135303337613734303661663865343639376338353936393134223b733a33323a226662373561646137376166306233626235373966376539363337373837646431223b733a33323a223137303363366335626632633737383130646163313965323465643566323764223b733a33323a223734643035666238643361393137323930613662303338653031386632626630223b733a33323a223764353166386365383036306166343131626166306332356136386265663035223b733a33323a223965643836623166336165313738396433323361356132373461306139303962223b733a33323a226664366466306337626333353336346339653066323664363563323530323836223b733a33323a226461616464316234636362393863383766363934343433393162363165613936223b733a33323a226265633961663061373935323166393436333833643036613637343535653238223b733a33323a223338376561636663376238383432646262333365303139306265653361353532223b733a33323a223635316338303131353536323534393138633230616364653765636163636539223b733a33323a223334323934623633353133346432303735343438653238613037373131643138223b733a33323a226531333133653039396532373139623037656162363566616163326337643562223b733a33323a226363323564356461613564316131373939323930663638373636623761333161223b733a33323a223066643233306430313562316261323434313733616461323533373362376564223b733a33323a223437363365336161623266303734326634663935346534633565383233323965223b733a33323a226365306232663564313536633834363037333930373063616538666163613564223b733a33323a223466353230396436333533356361643963393834643763396638333363343763223b733a33323a226665633132356538393639353763613134303838373239306536306130326138223b733a33323a226463613039383862333437306634393366313736303362326134326564356561223b733a33323a223864333062663735306132336666313339343863666436383364663835376530223b7d733a343a2268617368223b733a36353a2238643330626637353061323366663133393438636664363833646638353765302d6463613039383862333437306634393366313736303362326134326564356561223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1729545810);
INSERT INTO `session` (`id`, `data`, `modified`) VALUES
('ubqnktd7kfo06fd6u7v35h5ou2', 0x5f5f4c616d696e61737c613a353a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313732383930353732302e3038343533393b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a226a7530753570696335636436337631696a73363634306f723075223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313732383934343239363b7d733a34343a224c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313732383934343330373b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313732383934383838393b7d7d72656469726563745f75726c7c733a33363a22687474703a2f2f6c6f63616c686f73742f53697465732f6f6d656b612d732f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226133643031353735303633333962343434646264653961306130363738323134223b733a33323a226563623239656266373434383234616439376165373863653665383166643963223b7d733a343a2268617368223b733a36353a2265636232396562663734343832346164393761653738636536653831666439632d6133643031353735303633333962343434646264653961306130363738323134223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a323a7b733a33323a223565373438326234333337363733613266663639636237386132653935393461223b733a33323a226338353762653631636266333365653735666130306664656135646635383665223b733a33323a223839323333666264353937376435383366653263656564663430333130623737223b733a33323a223036336131653831343830393664356131646234383762626165373931383862223b7d733a343a2268617368223b733a36353a2230363361316538313438303936643561316462343837626261653739313838622d3839323333666264353937376435383366653263656564663430333130623737223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a34343a7b733a33323a223266363062373731663861313538316530646563346337373939383061316635223b733a33323a223332336630333837333039613231623265393436653732336334343535666266223b733a33323a226639333139663661316633366531353634396237633537656638343033656433223b733a33323a223566323431336162383961613232316432383864643934333036366639323031223b733a33323a226633353865346463653932616537653535613035326338326462323434653739223b733a33323a223032636565333132343030666666633263393630333539633236373639623766223b733a33323a226437306434646664323831616639666136353430396364306239653566363134223b733a33323a226437333935313763336463653034366366623537646463643132346339383933223b733a33323a226665663832383664323631323366386561303934393363383562613336353332223b733a33323a223463343632376237633765333262666666626665323134323966643837393439223b733a33323a226639623765626535313130633830313962306662643236326433613463663033223b733a33323a226164343037346331353562633461343863633464666633336135336331376535223b733a33323a223030623933303965366164353539346637383639343031353934353063376131223b733a33323a226162373030313539626563366235376664633337383838356535396236343936223b733a33323a226264396630393565373837386461383134393666613830666364333239666565223b733a33323a223961616533313237613439353531623332366338653931316132636533353832223b733a33323a226161643039613436663139363365383630373962356365646430646631616562223b733a33323a223061313338383135623536363164303130313531616461376363373230653766223b733a33323a226433663230343234653238646533613438346466376263313331326265336464223b733a33323a226330666439396130326465656639376535653862316166363966616262363739223b733a33323a226265393938643663633763623563303635336430386161323066313763383739223b733a33323a226135346336303337623233643136363234626634313563663064333563646561223b733a33323a223564633731646330393733633130633637396438313137393066666432386536223b733a33323a223033623265663334373235363763323562333833306439306135643231646663223b733a33323a226363643134313935306463613132653831373930623536373539336532643639223b733a33323a226235356334353636353263383963373630393763626466363264633231323339223b733a33323a223963323862323063323661333963626333313537613033363732393330303465223b733a33323a226135333563333934323462663365633332303362336139623361623164653438223b733a33323a223338613533613030356436326136383732666662393032393333663064613437223b733a33323a226135393065323038303430353563373932653330316538633536613635366561223b733a33323a223738613439616562656633353239353365356133633839383730323130376138223b733a33323a223331306630616466353835343537656537376666333437663735336361303934223b733a33323a226333336430366230633432643738363936666339343161656466336534386662223b733a33323a226530383539363234363838306531323766313765313031623932346636303331223b733a33323a223263633633663835393638666465623331653137643063306566623032386635223b733a33323a223166653564646532346434393835343265656465303830386239643537386136223b733a33323a223434353665633331376238663736646134626536393338326465613535616231223b733a33323a223064313633323736383663306661363462343466623564633433353434363732223b733a33323a223430336162643637396130356563333639623931636339313062633238646230223b733a33323a226639396231666463616438643536393663656461393266396535363234343561223b733a33323a223931383632666531323534653263393231653138363131613566316430346536223b733a33323a223763343464623263653033623561643662653730663862643337613336363436223b733a33323a223961323263343965663936393139613464356463626566653864323463616639223b733a33323a223566343939303037666361353736663039393463646663393464363864626631223b733a33323a226336383661363764373064343462633364663665356533653762643366326465223b733a33323a223135326465373438613866633435316265373062383862613564633233393339223b733a33323a223230656330636332396664666562616139383265343439333961343966353230223b733a33323a226136356461316537656561643238356565366439393531356438666338663131223b733a33323a223637326465363237626638336335393165313439663463663766366565646465223b733a33323a223936393831303366393062626662346262663438393763633262653233376534223b733a33323a223261373533313263356364633831373639646333643866383562613031633663223b733a33323a223162356362633531353638626666643631646134373134326437383634346663223b733a33323a223234343531633630326431663032303832626230383532323036653230626234223b733a33323a223762313131303132386132613865363339313336656137633133623462636438223b733a33323a223765643336383038613333656537663065333735363038346130386536653237223b733a33323a223531653762613966386430333966373537336462373564613061383465303233223b733a33323a223264376666666435653066353036666566633365353139396531393764613430223b733a33323a223039636339336265316363323639663337356465326262313838313762363938223b733a33323a226232376634336234623238313664653963643266303431643932336365393961223b733a33323a226132373761306464336435373139383764663537313830666231313265653966223b733a33323a223963313831323666313339323365633562343138336661643134336166306566223b733a33323a223334373532363733396631383539336263326438633162316265323936633031223b733a33323a226366656161366663316663663836386538323537383963303338656635306363223b733a33323a223161393838633361616238333638343536636166386335633362396465636533223b733a33323a223434636332376138366238323639356666316537613831653637396662346261223b733a33323a223465303261323237636663396533653132303235623939373665373833373638223b733a33323a223138623337636166623634373561366564663162383164396331376133633262223b733a33323a223931313232393561363033306466626437383635376162333765636161636361223b733a33323a226361323238666261313464373637646232363765326532396632636562353630223b733a33323a223838613138646136366464396239373836386530663932313066656530613866223b733a33323a226232333266646231326366666163346335633432343065643163383532633538223b733a33323a226334353261363365333761383532313261626561396636323061663766623664223b733a33323a223266303966396138616136623236366337323432373631346333373037633462223b733a33323a226536333731393236316330363437323265363236613732356136376333666630223b733a33323a223339346235343562666536663431313462383933653766326639336334356466223b733a33323a226333636536316137343366306538303536336561376664623061306632343762223b733a33323a226562363962386363636461326366356132663232633338396436396161396135223b733a33323a223439616134653464323965393662653239373132316662643562393733306361223b733a33323a226133633466633861396538323763653666303231303764663037386639626533223b733a33323a223432656632323465333561333264383065383864353231623238636666383565223b733a33323a226138626564356630656133326561333735323835393261373332313966633564223b733a33323a223035643632393635643939363837623831343165383161366134393731333735223b733a33323a226432633736343432373165323137616131373765366538613836343961366566223b733a33323a226435393635366332306662383361373938646239613661383331316237313363223b733a33323a223331336232653834343732656263366666346634373064633234356466626537223b733a33323a226165633338383233366537393034383436316662363362333432613763373735223b733a33323a223432373563353161626265316138613537663363326363656562353036363065223b733a33323a223062316533313136376636666232666364316136333030663034623434613037223b7d733a343a2268617368223b733a36353a2230623165333131363766366662326663643161363330306630346234346130372d3432373563353161626265316138613537663363326363656562353036363065223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1728905721),
('ut3bst48vu9ad52k8bscfvfdg4', 0x5f5f4c616d696e61737c613a333a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313733303032363531362e32313739373b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a227574336273743438767539616435326b38627363667666646734223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313733303036393731363b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223034323032653164633939356365333630376436616439393035356465316231223b733a33323a226230336137366534353061303063323263623539343966323932626165336637223b7d733a343a2268617368223b733a36353a2262303361373665343530613030633232636235393439663239326261653366372d3034323032653164633939356365333630376436616439393035356465316231223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1730026516);

-- --------------------------------------------------------

--
-- Structure de la table `setting`
--

DROP TABLE IF EXISTS `setting`;
CREATE TABLE IF NOT EXISTS `setting` (
  `id` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `setting`
--

INSERT INTO `setting` (`id`, `value`) VALUES
('administrator_email', '\"a.hef2000@gmail.com\"'),
('extension_whitelist', '[\"aac\",\"aif\",\"aiff\",\"asf\",\"asx\",\"avi\",\"bmp\",\"c\",\"cc\",\"class\",\"css\",\"divx\",\"doc\",\"docx\",\"exe\",\"gif\",\"gz\",\"gzip\",\"h\",\"ico\",\"j2k\",\"jp2\",\"jpe\",\"jpeg\",\"jpg\",\"m4a\",\"m4v\",\"mdb\",\"mid\",\"midi\",\"mov\",\"mp2\",\"mp3\",\"mp4\",\"mpa\",\"mpe\",\"mpeg\",\"mpg\",\"mpp\",\"odb\",\"odc\",\"odf\",\"odg\",\"odp\",\"ods\",\"odt\",\"ogg\",\"opus\",\"pdf\",\"png\",\"pot\",\"pps\",\"ppt\",\"pptx\",\"qt\",\"ra\",\"ram\",\"rtf\",\"rtx\",\"swf\",\"tar\",\"tif\",\"tiff\",\"txt\",\"wav\",\"wax\",\"webm\",\"webp\",\"wma\",\"wmv\",\"wmx\",\"wri\",\"xla\",\"xls\",\"xlsx\",\"xlt\",\"xlw\",\"zip\"]'),
('installation_title', '\"Anas_M2Thyp\"'),
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

DROP TABLE IF EXISTS `site`;
CREATE TABLE IF NOT EXISTS `site` (
  `id` int NOT NULL AUTO_INCREMENT,
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
  `assign_new_items` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_694309E4989D9B62` (`slug`),
  UNIQUE KEY `UNIQ_694309E4571EDDA` (`homepage_id`),
  KEY `IDX_694309E4FDFF2E92` (`thumbnail_id`),
  KEY `IDX_694309E47E3C61F9` (`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `site_block_attachment`
--

DROP TABLE IF EXISTS `site_block_attachment`;
CREATE TABLE IF NOT EXISTS `site_block_attachment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `block_id` int NOT NULL,
  `item_id` int DEFAULT NULL,
  `media_id` int DEFAULT NULL,
  `caption` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_236473FEE9ED820C` (`block_id`),
  KEY `IDX_236473FE126F525E` (`item_id`),
  KEY `IDX_236473FEEA9FDD75` (`media_id`),
  KEY `block_position` (`block_id`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `site_item_set`
--

DROP TABLE IF EXISTS `site_item_set`;
CREATE TABLE IF NOT EXISTS `site_item_set` (
  `id` int NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL,
  `item_set_id` int NOT NULL,
  `position` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_D4CE134F6BD1646960278D7` (`site_id`,`item_set_id`),
  KEY `IDX_D4CE134F6BD1646` (`site_id`),
  KEY `IDX_D4CE134960278D7` (`item_set_id`),
  KEY `position` (`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `site_page`
--

DROP TABLE IF EXISTS `site_page`;
CREATE TABLE IF NOT EXISTS `site_page` (
  `id` int NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL,
  `slug` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_public` tinyint(1) NOT NULL,
  `layout` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `layout_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json)',
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_2F900BD9F6BD1646989D9B62` (`site_id`,`slug`),
  KEY `is_public` (`is_public`),
  KEY `IDX_2F900BD9F6BD1646` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `site_page_block`
--

DROP TABLE IF EXISTS `site_page_block`;
CREATE TABLE IF NOT EXISTS `site_page_block` (
  `id` int NOT NULL AUTO_INCREMENT,
  `page_id` int NOT NULL,
  `layout` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)',
  `layout_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json)',
  `position` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C593E731C4663E4` (`page_id`),
  KEY `page_position` (`page_id`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `site_permission`
--

DROP TABLE IF EXISTS `site_permission`;
CREATE TABLE IF NOT EXISTS `site_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL,
  `user_id` int NOT NULL,
  `role` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_C0401D6FF6BD1646A76ED395` (`site_id`,`user_id`),
  KEY `IDX_C0401D6FF6BD1646` (`site_id`),
  KEY `IDX_C0401D6FA76ED395` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `site_setting`
--

DROP TABLE IF EXISTS `site_setting`;
CREATE TABLE IF NOT EXISTS `site_setting` (
  `id` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `site_id` int NOT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)',
  PRIMARY KEY (`id`,`site_id`),
  KEY `IDX_64D05A53F6BD1646` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  `password_hash` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `email`, `name`, `created`, `modified`, `password_hash`, `role`, `is_active`) VALUES
(1, 'a.hef2000@gmail.com', 'anas_thyp', '2024-09-30 08:20:16', '2024-09-30 08:20:16', '$2y$10$gLlacKBkJ9PMrQ50/O8sWuixE/rXqMYmO2anEctVhaOB9UnytboZK', 'global_admin', 1);

-- --------------------------------------------------------

--
-- Structure de la table `user_setting`
--

DROP TABLE IF EXISTS `user_setting`;
CREATE TABLE IF NOT EXISTS `user_setting` (
  `id` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int NOT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)',
  PRIMARY KEY (`id`,`user_id`),
  KEY `IDX_C779A692A76ED395` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `user_setting`
--

INSERT INTO `user_setting` (`id`, `user_id`, `value`) VALUES
('browse_defaults_admin_item_sets', 1, '{\"sort_by\":\"created\",\"sort_order\":\"desc\"}'),
('browse_defaults_admin_items', 1, '{\"sort_by\":\"created\",\"sort_order\":\"desc\"}'),
('browse_defaults_admin_media', 1, '{\"sort_by\":\"created\",\"sort_order\":\"desc\"}'),
('browse_defaults_admin_sites', 1, '{\"sort_by\":\"title\",\"sort_order\":\"asc\"}'),
('columns_admin_item_sets', 1, '[{\"type\":\"resource_class\",\"default\":null,\"header\":null},{\"type\":\"owner\",\"default\":null,\"header\":null},{\"type\":\"created\",\"default\":null,\"header\":null}]'),
('columns_admin_items', 1, '[{\"type\":\"resource_class\",\"default\":null,\"header\":null},{\"type\":\"owner\",\"default\":null,\"header\":null},{\"type\":\"created\",\"default\":null,\"header\":null}]'),
('columns_admin_media', 1, '[{\"type\":\"resource_class\",\"default\":null,\"header\":null},{\"type\":\"owner\",\"default\":null,\"header\":null},{\"type\":\"created\",\"default\":null,\"header\":null}]'),
('columns_admin_sites', 1, '[{\"type\":\"slug\",\"default\":null,\"header\":null},{\"type\":\"owner\",\"default\":null,\"header\":null},{\"type\":\"created\",\"default\":null,\"header\":null}]'),
('csv_import_automap_check_names_alone', 1, 'true'),
('csv_import_delimiter', 1, '\",\"'),
('csv_import_enclosure', 1, '\"\\\"\"'),
('csv_import_global_language', 1, '\"\"'),
('csv_import_identifier_property', 1, '\"\"'),
('csv_import_multivalue_separator', 1, '\",\"'),
('csv_import_rows_by_batch', 1, '20'),
('default_resource_template', 1, '\"\"'),
('locale', 1, '\"\"');

-- --------------------------------------------------------

--
-- Structure de la table `value`
--

DROP TABLE IF EXISTS `value`;
CREATE TABLE IF NOT EXISTS `value` (
  `id` int NOT NULL AUTO_INCREMENT,
  `resource_id` int NOT NULL,
  `property_id` int NOT NULL,
  `value_resource_id` int DEFAULT NULL,
  `value_annotation_id` int DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `lang` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `uri` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `is_public` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_1D7758349B66727E` (`value_annotation_id`),
  KEY `IDX_1D77583489329D25` (`resource_id`),
  KEY `IDX_1D775834549213EC` (`property_id`),
  KEY `IDX_1D7758344BC72506` (`value_resource_id`),
  KEY `value` (`value`(190)),
  KEY `uri` (`uri`(190)),
  KEY `is_public` (`is_public`)
) ENGINE=InnoDB AUTO_INCREMENT=190 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `value`
--

INSERT INTO `value` (`id`, `resource_id`, `property_id`, `value_resource_id`, `value_annotation_id`, `type`, `lang`, `value`, `uri`, `is_public`) VALUES
(55, 19, 191, NULL, NULL, 'literal', NULL, '10/10/2024 10:12:37', NULL, 1),
(56, 19, 192, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(57, 19, 193, NULL, NULL, 'literal', NULL, '24', NULL, 1),
(58, 19, 194, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(59, 19, 195, NULL, NULL, 'literal', NULL, 'les deux', NULL, 1),
(60, 19, 196, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(61, 19, 197, NULL, NULL, 'literal', NULL, 'a.hef2000@gmail.Com', NULL, 1),
(62, 20, 191, NULL, NULL, 'literal', NULL, '10/10/2024 10:13:00', NULL, 1),
(63, 20, 192, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(64, 20, 193, NULL, NULL, 'literal', NULL, '24', NULL, 1),
(65, 20, 194, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(66, 20, 195, NULL, NULL, 'literal', NULL, 'le régime', NULL, 1),
(67, 20, 196, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(68, 20, 197, NULL, NULL, 'literal', NULL, 'anas.hefied7@gmail.com', NULL, 1),
(69, 21, 191, NULL, NULL, 'literal', NULL, '12/10/2024 15:39:55', NULL, 1),
(70, 21, 192, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(71, 21, 193, NULL, NULL, 'literal', NULL, '28', NULL, 1),
(72, 21, 194, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(73, 21, 195, NULL, NULL, 'literal', NULL, 'le sport', NULL, 1),
(74, 21, 196, NULL, NULL, 'literal', NULL, 'Oui', NULL, 1),
(75, 21, 197, NULL, NULL, 'literal', NULL, 'massidireddy@gmail.com', NULL, 1),
(76, 22, 191, NULL, NULL, 'literal', NULL, '13/10/2024 02:00:54', NULL, 1),
(77, 22, 192, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(78, 22, 193, NULL, NULL, 'literal', NULL, '25', NULL, 1),
(79, 22, 194, NULL, NULL, 'literal', NULL, 'Oui', NULL, 1),
(80, 22, 195, NULL, NULL, 'literal', NULL, 'les deux', NULL, 1),
(81, 22, 196, NULL, NULL, 'literal', NULL, 'Oui', NULL, 1),
(82, 22, 197, NULL, NULL, 'literal', NULL, 'ouksili.samy@yahoo.com', NULL, 1),
(83, 23, 191, NULL, NULL, 'literal', NULL, '13/10/2024 15:43:10', NULL, 1),
(84, 23, 192, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(85, 23, 193, NULL, NULL, 'literal', NULL, '22', NULL, 1),
(86, 23, 194, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(87, 23, 195, NULL, NULL, 'literal', NULL, 'les deux', NULL, 1),
(88, 23, 196, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(89, 23, 197, NULL, NULL, 'literal', NULL, 'Amjahidmohamedamin@gmail.com', NULL, 1),
(90, 24, 191, NULL, NULL, 'literal', NULL, '13/10/2024 16:18:09', NULL, 1),
(91, 24, 192, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(92, 24, 193, NULL, NULL, 'literal', NULL, '24', NULL, 1),
(93, 24, 194, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(94, 24, 195, NULL, NULL, 'literal', NULL, 'le sport', NULL, 1),
(95, 24, 196, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(96, 24, 197, NULL, NULL, 'literal', NULL, 'ahmed45jab@gmail.com', NULL, 1),
(97, 25, 191, NULL, NULL, 'literal', NULL, '13/10/2024 16:21:05', NULL, 1),
(98, 25, 192, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(99, 25, 193, NULL, NULL, 'literal', NULL, '26', NULL, 1),
(100, 25, 194, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(101, 25, 195, NULL, NULL, 'literal', NULL, 'le sport', NULL, 1),
(102, 25, 196, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(103, 25, 197, NULL, NULL, 'literal', NULL, 'mokraniislam998@gmail.com', NULL, 1),
(104, 26, 191, NULL, NULL, 'literal', NULL, '13/10/2024 20:44:09', NULL, 1),
(105, 26, 192, NULL, NULL, 'literal', NULL, 'Femme', NULL, 1),
(106, 26, 193, NULL, NULL, 'literal', NULL, '28', NULL, 1),
(107, 26, 194, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(108, 26, 195, NULL, NULL, 'literal', NULL, 'le régime', NULL, 1),
(109, 26, 196, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(110, 26, 197, NULL, NULL, 'literal', NULL, 'melissaorb02@gmail.com', NULL, 1),
(111, 27, 191, NULL, NULL, 'literal', NULL, '13/10/2024 21:01:48', NULL, 1),
(112, 27, 192, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(113, 27, 193, NULL, NULL, 'literal', NULL, '24', NULL, 1),
(114, 27, 194, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(115, 27, 195, NULL, NULL, 'literal', NULL, 'le sport', NULL, 1),
(116, 27, 196, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(117, 27, 197, NULL, NULL, 'literal', NULL, 'nathan.benais@gmail.com', NULL, 1),
(118, 28, 191, NULL, NULL, 'literal', NULL, '13/10/2024 22:32:03', NULL, 1),
(119, 28, 192, NULL, NULL, 'literal', NULL, 'Femme', NULL, 1),
(120, 28, 193, NULL, NULL, 'literal', NULL, '23', NULL, 1),
(121, 28, 194, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(122, 28, 195, NULL, NULL, 'literal', NULL, 'le sport', NULL, 1),
(123, 28, 196, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(124, 28, 197, NULL, NULL, 'literal', NULL, 'moussaoui.rania755@gmail.com', NULL, 1),
(125, 29, 191, NULL, NULL, 'literal', NULL, '14/10/2024 08:17:06', NULL, 1),
(126, 29, 192, NULL, NULL, 'literal', NULL, 'Homme', NULL, 1),
(127, 29, 193, NULL, NULL, 'literal', NULL, '24', NULL, 1),
(128, 29, 194, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(129, 29, 195, NULL, NULL, 'literal', NULL, 'les deux', NULL, 1),
(130, 29, 196, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(131, 29, 197, NULL, NULL, 'literal', NULL, 'noureddineaitkhouya@gmail.com', NULL, 1),
(132, 30, 191, NULL, NULL, 'literal', NULL, '14/10/2024 08:37:56', NULL, 1),
(133, 30, 192, NULL, NULL, 'literal', NULL, 'Femme', NULL, 1),
(134, 30, 193, NULL, NULL, 'literal', NULL, '23', NULL, 1),
(135, 30, 194, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(136, 30, 195, NULL, NULL, 'literal', NULL, 'les deux', NULL, 1),
(137, 30, 196, NULL, NULL, 'literal', NULL, 'Non', NULL, 1),
(138, 30, 197, NULL, NULL, 'literal', NULL, 'oumaimaelfazazi01@gmail.com', NULL, 1),
(139, 31, 197, NULL, NULL, 'literal', '', 'yasmine.guemat97@gmail.com', NULL, 1),
(140, 31, 205, NULL, NULL, 'literal', '', 'yasmine.guemat', NULL, 1),
(141, 31, 207, NULL, NULL, 'literal', '', 'Patient', NULL, 1),
(142, 31, 192, NULL, NULL, 'literal', '', 'Femme', NULL, 1),
(143, 31, 193, NULL, NULL, 'literal', '', '23', NULL, 1),
(144, 31, 204, NULL, NULL, 'literal', '', '1447789566633', NULL, 1),
(145, 31, 202, NULL, NULL, 'literal', '', '0655555555', NULL, 1),
(146, 32, 197, NULL, NULL, 'literal', '', 'a.hef2000@gmail.com', NULL, 1),
(147, 32, 205, NULL, NULL, 'literal', '', 'anas_thyp', NULL, 1),
(148, 32, 207, NULL, NULL, 'literal', '', 'Admin', NULL, 1),
(149, 32, 206, NULL, NULL, 'literal', '', 'Anas123', NULL, 1),
(150, 33, 197, NULL, NULL, 'literal', '', 'a.hef2000@gmail.com', NULL, 1),
(151, 33, 205, NULL, NULL, 'literal', '', 'anas_thyp', NULL, 1),
(152, 33, 208, NULL, NULL, 'literal', '', '0670622027', NULL, 1),
(153, 33, 207, NULL, NULL, 'literal', '', 'Admin', NULL, 1),
(154, 33, 206, NULL, NULL, 'literal', '', 'Anas123', NULL, 1),
(155, 34, 197, NULL, NULL, 'literal', '', 'a.hef1960@gmail.com', NULL, 1),
(156, 34, 205, NULL, NULL, 'literal', '', 'Alihefied', NULL, 1),
(157, 34, 207, NULL, NULL, 'literal', '', 'Patient', NULL, 1),
(158, 34, 192, NULL, NULL, 'literal', '', 'Homme', NULL, 1),
(159, 34, 193, NULL, NULL, 'literal', '', '50', NULL, 1),
(160, 34, 204, NULL, NULL, 'literal', '', '100039935076827', NULL, 1),
(161, 34, 202, NULL, NULL, 'literal', '', '0612345678', NULL, 1),
(162, 34, 195, NULL, NULL, 'literal', '', 'Régime', NULL, 1),
(163, 34, 196, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(164, 34, 194, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(165, 34, 201, NULL, NULL, 'literal', '', '07/11/2024', NULL, 1),
(166, 34, 206, NULL, NULL, 'literal', '', 'Ali123', NULL, 1),
(167, 35, 198, NULL, NULL, 'literal', '', 'Cabinet chez Docteur Hasan tazi', NULL, 1),
(168, 35, 199, NULL, NULL, 'literal', '', 'street 12 paris', NULL, 1),
(169, 35, 200, NULL, NULL, 'literal', '', 'ORL', NULL, 1),
(170, 36, 197, NULL, NULL, 'literal', '', 'hasan.tazi@gmail.com', NULL, 1),
(171, 36, 205, NULL, NULL, 'literal', '', 'Hasan Tazi', NULL, 1),
(172, 36, 207, NULL, NULL, 'literal', '', 'Médecin', NULL, 1),
(173, 36, 210, NULL, NULL, 'literal', '', 'Cabinet chez Docteur Hasan tazi', NULL, 1),
(174, 36, 210, 35, NULL, 'resource', NULL, NULL, NULL, 1),
(175, 36, 209, NULL, NULL, 'literal', '', 'ORL', NULL, 1),
(176, 36, 208, NULL, NULL, 'literal', '', '0635487963', NULL, 1),
(177, 36, 206, NULL, NULL, 'literal', '', 'hasan123', NULL, 1),
(178, 37, 201, NULL, NULL, 'literal', '', '07/11/2024', NULL, 1),
(179, 37, 201, 34, NULL, 'resource', NULL, NULL, NULL, 1),
(180, 37, 202, NULL, NULL, 'literal', '', '0612345678', NULL, 1),
(181, 37, 203, NULL, NULL, 'literal', '', '0', NULL, 1),
(183, 37, 204, NULL, NULL, 'literal', '', '1009935076827', NULL, 1),
(184, 31, 195, NULL, NULL, 'literal', '', 'le sport', NULL, 1),
(185, 31, 196, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(186, 31, 194, NULL, NULL, 'literal', '', 'Non', NULL, 1),
(187, 31, 201, NULL, NULL, 'literal', '', '08/11/2024', NULL, 1),
(188, 31, 206, NULL, NULL, 'literal', '', 'yasmin123', NULL, 1),
(189, 31, 191, NULL, NULL, 'literal', '', '14/10/2024 09:23:18', NULL, 1);

-- --------------------------------------------------------

--
-- Structure de la table `value_annotation`
--

DROP TABLE IF EXISTS `value_annotation`;
CREATE TABLE IF NOT EXISTS `value_annotation` (
  `id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `vocabulary`
--

DROP TABLE IF EXISTS `vocabulary`;
CREATE TABLE IF NOT EXISTS `vocabulary` (
  `id` int NOT NULL AUTO_INCREMENT,
  `owner_id` int DEFAULT NULL,
  `namespace_uri` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `prefix` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_9099C97B9B267FDF` (`namespace_uri`),
  UNIQUE KEY `UNIQ_9099C97B93B1868E` (`prefix`),
  KEY `IDX_9099C97B7E3C61F9` (`owner_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `vocabulary`
--

INSERT INTO `vocabulary` (`id`, `owner_id`, `namespace_uri`, `prefix`, `label`, `comment`) VALUES
(1, NULL, 'http://purl.org/dc/terms/', 'dcterms', 'Dublin Core', 'Basic resource metadata (DCMI Metadata Terms)'),
(2, NULL, 'http://purl.org/dc/dcmitype/', 'dctype', 'Dublin Core Type', 'Basic resource types (DCMI Type Vocabulary)'),
(3, NULL, 'http://purl.org/ontology/bibo/', 'bibo', 'Bibliographic Ontology', 'Bibliographic metadata (BIBO)'),
(4, NULL, 'http://xmlns.com/foaf/0.1/', 'foaf', 'Friend of a Friend', 'Relationships between people and organizations (FOAF)'),
(6, 1, 'https://jardindesconnaissances.univ-paris8.fr/onto/etudiant_thyp#', 'etudiant_thyp', 'vocab_etudiant_thyp', ''),
(7, 1, 'https://jardindesconnaissances.univ-paris8.fr/onto/cabinet_medical#', 'cabinet_medical', 'cabinet_medical', '');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `fulltext_search`
--
ALTER TABLE `fulltext_search` ADD FULLTEXT KEY `IDX_AA31FE4A2B36786B3B8BA7C7` (`title`,`text`);

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
-- Contraintes pour la table `csvimport_import`
--
ALTER TABLE `csvimport_import`
  ADD CONSTRAINT `FK_17B508814C276F75` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`);

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
