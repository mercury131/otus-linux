-- MySQL dump 10.13  Distrib 8.0.19, for Linux (x86_64)
--
-- Host: localhost    Database: 
-- ------------------------------------------------------
-- Server version	8.0.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!50606 SET @OLD_INNODB_STATS_AUTO_RECALC=@@INNODB_STATS_AUTO_RECALC */;
/*!50606 SET GLOBAL INNODB_STATS_AUTO_RECALC=OFF */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '85d107b8-5f9b-11ea-80dd-080027ae509e:1-42';

--
-- Current Database: `bet`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `bet` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `bet`;

--
-- Table structure for table `bookmaker`
--

DROP TABLE IF EXISTS `bookmaker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookmaker` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bookmaker_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bookmaker_bookmaker_name` (`bookmaker_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookmaker`
--

LOCK TABLES `bookmaker` WRITE;
/*!40000 ALTER TABLE `bookmaker` DISABLE KEYS */;
INSERT INTO `bookmaker` VALUES (4,'betway'),(5,'bwin'),(6,'ladbrokes'),(3,'unibet');
/*!40000 ALTER TABLE `bookmaker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `competition`
--

DROP TABLE IF EXISTS `competition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `competition` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bookmaker_competition` bigint NOT NULL,
  `bookmaker_id` int NOT NULL,
  `competition_date` date DEFAULT NULL,
  `competition_name` varchar(255) DEFAULT NULL,
  `match_date` date DEFAULT NULL,
  `teamhome` varchar(255) DEFAULT NULL,
  `teamaway` varchar(255) DEFAULT NULL,
  `sortname` varchar(255) DEFAULT NULL,
  `live` tinyint DEFAULT NULL,
  `liveurl` varchar(1000) DEFAULT NULL,
  `liveurlpar` varchar(100) DEFAULT NULL,
  `active` tinyint(1) DEFAULT '0',
  `_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `competition_bookmaker_id` (`bookmaker_id`),
  KEY `bookmaker_event_id_idx` (`bookmaker_competition`),
  KEY `active_idx` (`active`),
  CONSTRAINT `competition_ibfk_1` FOREIGN KEY (`bookmaker_id`) REFERENCES `bookmaker` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33909 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `competition`
--

LOCK TABLES `competition` WRITE;
/*!40000 ALTER TABLE `competition` DISABLE KEYS */;
INSERT INTO `competition` VALUES (33574,1004143702,3,NULL,'Bachinger, Matthias - Basso, Andrea','2017-08-08','Bachinger, Matthias','Basso, Andrea','Andrea,Bachinger,Basso,Matthias',1,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004143702.json',NULL,1,'2017-08-08 17:53:18'),(33575,1004142311,3,NULL,'Sanchez, Maria - Swan, Katie','2017-08-08','Sanchez, Maria','Swan, Katie','Katie,Maria,Sanchez,Swan',1,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142311.json',NULL,1,'2017-08-08 17:53:18'),(33576,1004140662,3,NULL,'Martin Santana, Carlota - Klein, Vivien','2017-08-08','Martin Santana, Carlota','Klein, Vivien','Carlota,Klein,Martin,Santana,Vivien',1,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004140662.json',NULL,1,'2017-08-08 17:53:18'),(33577,1004142316,3,NULL,'Yurovsky, Ronit - Whoriskey, Caitlin','2017-08-08','Yurovsky, Ronit','Whoriskey, Caitlin','Caitlin,Ronit,Whoriskey,Yurovsky',1,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142316.json',NULL,1,'2017-08-08 17:53:18'),(33578,1004142565,3,NULL,'Rodriguez Taverna, Santiago Fa - Rodriguez-Pace, Ricardo','2017-08-08','Rodriguez Taverna, Santiago Fa','Rodriguez-Pace, Ricardo','Fa,Pace,Ricardo,Rodriguez,Rodriguez,Santiago,Taverna',1,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142565.json',NULL,1,'2017-08-08 17:53:18'),(33579,1004142559,3,NULL,'Silverman, Cameron - Hiltzik, Aron','2017-08-08','Silverman, Cameron','Hiltzik, Aron','Aron,Cameron,Hiltzik,Silverman',1,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142559.json',NULL,1,'2017-08-08 17:53:18'),(33580,1004141543,3,NULL,'Karlovskiy, Evgeny - Kavcic, Blaz','2017-08-08','Karlovskiy, Evgeny','Kavcic, Blaz','Blaz,Evgeny,Karlovskiy,Kavcic',1,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004141543.json',NULL,1,'2017-08-08 17:53:18'),(33581,1004142315,3,NULL,'Carle, Maria Lourdes - Mueller, Alexandra','2017-08-08','Carle, Maria Lourdes','Mueller, Alexandra','Alexandra,Carle,Lourdes,Maria,Mueller',1,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142315.json',NULL,1,'2017-08-08 17:53:18'),(33582,1004136628,3,NULL,'Tiafoe, Frances - Lorenzi, Paolo','2017-08-08','Tiafoe, Frances','Lorenzi, Paolo','Frances,Lorenzi,Paolo,Tiafoe',1,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004136628.json',NULL,1,'2017-08-08 17:53:18'),(33583,1004136632,3,NULL,'Hyeon Chung - Lopez, Feliciano','2017-08-08','Hyeon Chung','Lopez, Feliciano','Chung,Feliciano,Hyeon,Lopez',1,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004136632.json',NULL,1,'2017-08-08 17:53:18'),(33584,1004141836,3,NULL,'Georges, M/Marcinkevica, D - Hurst, E/Miyazaki, Y L','2017-08-08','Georges, M/Marcinkevica, D','Hurst, E/Miyazaki, Y L','Georges,Hurst,Marcinkevica,Miyazaki',1,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004141836.json',NULL,1,'2017-08-08 17:53:18'),(33585,1004141542,3,NULL,'Ortega-Olmedo, Roberto - Celebic, Ljubomir','2017-08-08','Ortega-Olmedo, Roberto','Celebic, Ljubomir','Celebic,Ljubomir,Olmedo,Ortega,Roberto',1,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004141542.json',NULL,1,'2017-08-08 17:53:18'),(33586,1004142310,3,NULL,'Bektas, Emina - Tere-Apisah, Abigail','2017-08-08','Bektas, Emina','Tere-Apisah, Abigail','Abigail,Apisah,Bektas,Emina,Tere',1,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142310.json',NULL,1,'2017-08-08 17:53:18'),(33587,1004144068,3,NULL,'Escobedo, Ernesto - Basilashvili, Nikoloz','2017-08-08','Escobedo, Ernesto','Basilashvili, Nikoloz','Basilashvili,Ernesto,Escobedo,Nikoloz',1,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004144068.json',NULL,1,'2017-08-08 17:53:18'),(33588,1004140294,3,NULL,'Bouchard, Eugenie - Vekic, Donna','2017-08-08','Bouchard, Eugenie','Vekic, Donna','Bouchard,Donna,Eugenie,Vekic',1,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004140294.json',NULL,1,'2017-08-08 17:53:18'),(33589,1004141845,3,NULL,'Elia, A/Smilansky, I - Kirci, K/Turker, M N','2017-08-08','Elia, A/Smilansky, I','Kirci, K/Turker, M N','Elia,Kirci,Smilansky,Turker',1,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004141845.json',NULL,1,'2017-08-08 17:53:18'),(33590,1004138586,3,NULL,'Jarry, Nicolas - Arguello, Facundo','2017-08-08','Jarry, Nicolas','Arguello, Facundo','Arguello,Facundo,Jarry,Nicolas',1,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004138586.json',NULL,1,'2017-08-08 17:53:18'),(33591,1004138590,3,NULL,'Galan, Daniel Elahi - Santos, Nicolas','2017-08-08','Galan, Daniel Elahi','Santos, Nicolas','Daniel,Elahi,Galan,Nicolas,Santos',1,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004138590.json',NULL,1,'2017-08-08 17:53:18'),(33592,1004136650,3,NULL,'Makarova, Ekaterina - Shuai Peng','2017-08-08','Makarova, Ekaterina','Shuai Peng','Ekaterina,Makarova,Peng,Shuai',1,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004136650.json',NULL,1,'2017-08-08 17:53:18'),(33593,1004138569,3,NULL,'Boh, Grega - Zemlja, Grega','2017-08-08','Boh, Grega','Zemlja, Grega','Boh,Grega,Grega,Zemlja',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004138569.json',NULL,0,'2017-08-08 17:53:11'),(33594,1004140307,3,NULL,'Millot, Vincent - Querrey, Sam','2017-08-08','Millot, Vincent','Querrey, Sam','Millot,Querrey,Sam,Vincent',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004140307.json',NULL,0,'2017-08-08 17:53:11'),(33595,1004138713,3,NULL,'Novikov, Dennis - Sakharov, Gleb','2017-08-08','Novikov, Dennis','Sakharov, Gleb','Dennis,Gleb,Novikov,Sakharov',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004138713.json',NULL,0,'2017-08-08 17:53:11'),(33596,1004136642,3,NULL,'Vandeweghe, Coco - Radwanska, Agnieszka','2017-08-08','Vandeweghe, Coco','Radwanska, Agnieszka','Agnieszka,Coco,Radwanska,Vandeweghe',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004136642.json',NULL,0,'2017-08-08 17:53:11'),(33597,1004136800,3,NULL,'Sugita, Yuichi - Goffin, David','2017-08-08','Sugita, Yuichi','Goffin, David','David,Goffin,Sugita,Yuichi',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004136800.json',NULL,0,'2017-08-08 17:53:11'),(33598,1004138720,3,NULL,'Laaksonen, Henri - Ramanathan, Ramkumar','2017-08-08','Laaksonen, Henri','Ramanathan, Ramkumar','Henri,Laaksonen,Ramanathan,Ramkumar',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004138720.json',NULL,0,'2017-08-08 17:53:12'),(33599,1004140051,3,NULL,'Hibino, N/Rosolska, A - Groenefeld, A-L/Peschke, K','2017-08-08','Hibino, N/Rosolska, A','Groenefeld, A-L/Peschke, K','Groenefeld,Hibino,Peschke,Rosolska',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004140051.json',NULL,0,'2017-08-08 17:53:12'),(33600,1004140466,3,NULL,'Sandgren, Tennys - Nielsen, Frederik','2017-08-08','Sandgren, Tennys','Nielsen, Frederik','Frederik,Nielsen,Sandgren,Tennys',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004140466.json',NULL,0,'2017-08-08 17:53:12'),(33601,1004136656,3,NULL,'Cornet, Alizé - Pavlyuchenkova, Anastasia','2017-08-08','Cornet, Alizé','Pavlyuchenkova, Anastasia','Alizé,Anastasia,Cornet,Pavlyuchenkova',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004136656.json',NULL,0,'2017-08-08 17:53:12'),(33602,1004136768,3,NULL,'Khachanov, Karen - Carreno Busta, Pablo','2017-08-08','Khachanov, Karen','Carreno Busta, Pablo','Busta,Carreno,Karen,Khachanov,Pablo',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004136768.json',NULL,0,'2017-08-08 17:53:12'),(33603,1004139408,3,NULL,'Dutra Silva, Rogerio - Shapovalov, Denis','2017-08-08','Dutra Silva, Rogerio','Shapovalov, Denis','Denis,Dutra,Rogerio,Shapovalov,Silva',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004139408.json',NULL,0,'2017-08-08 17:53:12'),(33604,1004140301,3,NULL,'Estrella Burgos, Victor - Lama, Gonzalo','2017-08-08','Estrella Burgos, Victor','Lama, Gonzalo','Burgos,Estrella,Gonzalo,Lama,Victor',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004140301.json',NULL,0,'2017-08-08 17:53:12'),(33605,1004139310,3,NULL,'Harrison, R/Venus, M - Del Potro, J M/Dimitrov, G','2017-08-08','Harrison, R/Venus, M','Del Potro, J M/Dimitrov, G','Del,Dimitrov,Harrison,Potro,Venus',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004139310.json',NULL,0,'2017-08-08 17:53:12'),(33606,1004140193,3,NULL,'Goerges, J/Savchuk, O - Barty, A/Dellacqua, C','2017-08-08','Goerges, J/Savchuk, O','Barty, A/Dellacqua, C','Barty,Dellacqua,Goerges,Savchuk',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004140193.json',NULL,0,'2017-08-08 17:53:12'),(33607,1004138718,3,NULL,'Gabashvili, Teymuraz - Kukushkin, Mikhail','2017-08-08','Gabashvili, Teymuraz','Kukushkin, Mikhail','Gabashvili,Kukushkin,Mikhail,Teymuraz',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004138718.json',NULL,0,'2017-08-08 17:53:13'),(33608,1004138722,3,NULL,'Krueger, Mitchell - Bublik, Alexander','2017-08-08','Krueger, Mitchell','Bublik, Alexander','Alexander,Bublik,Krueger,Mitchell',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004138722.json',NULL,0,'2017-08-08 17:53:13'),(33609,1004138597,3,NULL,'Nestor, D/Pospisil, V - Bautista Agut, R/Ferrer, D','2017-08-08','Nestor, D/Pospisil, V','Bautista Agut, R/Ferrer, D','Agut,Bautista,Ferrer,Nestor,Pospisil',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004138597.json',NULL,0,'2017-08-08 17:53:13'),(33610,1004138596,3,NULL,'Lopez, F/Lopez, M - Pouille, L/Tsonga, J','2017-08-08','Lopez, F/Lopez, M','Pouille, L/Tsonga, J','Lopez,Lopez,Pouille,Tsonga',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004138596.json',NULL,0,'2017-08-08 17:53:13'),(33611,1004138724,3,NULL,'Norrie, Cameron - Jung, Jason','2017-08-08','Norrie, Cameron','Jung, Jason','Cameron,Jason,Jung,Norrie',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004138724.json',NULL,0,'2017-08-08 17:53:13'),(33612,1004140056,3,NULL,'Hradecka, L/Siniakova, K - Chia-Jung Chuang/Voracova, R','2017-08-08','Hradecka, L/Siniakova, K','Chia-Jung Chuang/Voracova, R','Chia,Chuang,Hradecka,Jung,Siniakova,Voracova',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004140056.json',NULL,0,'2017-08-08 17:53:13'),(33613,1004140310,3,NULL,'Sela, Dudi - Anderson, Kevin','2017-08-08','Sela, Dudi','Anderson, Kevin','Anderson,Dudi,Kevin,Sela',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004140310.json',NULL,0,'2017-08-08 17:53:13'),(33614,1004138591,3,NULL,'Johnson, S/Querrey, S - Lorenzi, P/Ramos-Vinolas, A','2017-08-08','Johnson, S/Querrey, S','Lorenzi, P/Ramos-Vinolas, A','Johnson,Lorenzi,Querrey,Ramos,Vinolas',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004138591.json',NULL,0,'2017-08-08 17:53:13'),(33615,1004144074,3,NULL,'Davis, L/Riske, A - Robillard-Millette, C/Zhao, C','2017-08-08','Davis, L/Riske, A','Robillard-Millette, C/Zhao, C','Davis,Millette,Riske,Robillard,Zhao',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004144074.json',NULL,0,'2017-08-08 17:53:13'),(33616,1004138715,3,NULL,'Sarmiento, Raymond - Rubin, Noah','2017-08-08','Sarmiento, Raymond','Rubin, Noah','Noah,Raymond,Rubin,Sarmiento',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004138715.json',NULL,0,'2017-08-08 17:53:14'),(33617,1004138589,3,NULL,'Gonzalez, S/Young, D - Rojer, J-J/Tecau, H','2017-08-08','Gonzalez, S/Young, D','Rojer, J-J/Tecau, H','Gonzalez,Rojer,Tecau,Young',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004138589.json',NULL,0,'2017-08-08 17:53:14'),(33618,1004138717,3,NULL,'Lamble, John - De Loore, Joris','2017-08-08','Lamble, John','De Loore, Joris','De,John,Joris,Lamble,Loore',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004138717.json',NULL,0,'2017-08-08 17:53:14'),(33619,1004138721,3,NULL,'Kravchuk, Konstantin - Fritz, Taylor','2017-08-08','Kravchuk, Konstantin','Fritz, Taylor','Fritz,Konstantin,Kravchuk,Taylor',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004138721.json',NULL,0,'2017-08-08 17:53:14'),(33620,1004139311,3,NULL,'Cabal, J/Carreno Busta, P - Mektic, N/Qureshi, A','2017-08-08','Cabal, J/Carreno Busta, P','Mektic, N/Qureshi, A','Busta,Cabal,Carreno,Mektic,Qureshi',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004139311.json',NULL,0,'2017-08-08 17:53:14'),(33621,1004142033,3,NULL,'Kasatkina, Daria - Svitolina, Elina','2017-08-09','Kasatkina, Daria','Svitolina, Elina','Daria,Elina,Kasatkina,Svitolina',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142033.json',NULL,0,'2017-08-08 17:53:14'),(33622,1004138587,3,NULL,'Gomez, Emilio - Souza, Joao Olavo','2017-08-09','Gomez, Emilio','Souza, Joao Olavo','Emilio,Gomez,Joao,Olavo,Souza',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004138587.json',NULL,0,'2017-08-08 17:53:14'),(33623,1004141998,3,NULL,'Gavrilova, Daria - Strycova, Barbora','2017-08-09','Gavrilova, Daria','Strycova, Barbora','Barbora,Daria,Gavrilova,Strycova',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004141998.json',NULL,0,'2017-08-08 17:53:14'),(33624,1004142227,3,NULL,'Paire, Benoit - Donaldson, Jared','2017-08-09','Paire, Benoit','Donaldson, Jared','Benoit,Donaldson,Jared,Paire',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142227.json',NULL,0,'2017-08-08 17:53:14'),(33625,1004140311,3,NULL,'Herbert, Pierre-Hugues - Sock, Jack','2017-08-09','Herbert, Pierre-Hugues','Sock, Jack','Herbert,Hugues,Jack,Pierre,Sock',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004140311.json',NULL,0,'2017-08-08 17:53:15'),(33626,1004136652,3,NULL,'Andreescu, Bianca Vanessa - Babos, Timea','2017-08-09','Andreescu, Bianca Vanessa','Babos, Timea','Andreescu,Babos,Bianca,Timea,Vanessa',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004136652.json',NULL,0,'2017-08-08 17:53:15'),(33627,1004138714,3,NULL,'Millman, John - McDonald, Mackenzie','2017-08-09','Millman, John','McDonald, Mackenzie','John,Mackenzie,McDonald,Millman',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004138714.json',NULL,0,'2017-08-08 17:53:15'),(33628,1004138594,3,NULL,'Martin, F/Roger-Vasselin, E - Dancevic, F/Shamasdin, A','2017-08-09','Martin, F/Roger-Vasselin, E','Dancevic, F/Shamasdin, A','Dancevic,Martin,Roger,Shamasdin,Vasselin',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004138594.json',NULL,0,'2017-08-08 17:53:15'),(33629,1004142309,3,NULL,'Thiem, Dominic - Schwartzman, Diego Sebastian','2017-08-09','Thiem, Dominic','Schwartzman, Diego Sebastian','Diego,Dominic,Schwartzman,Sebastian,Thiem',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142309.json',NULL,0,'2017-08-08 17:53:15'),(33630,1004140467,3,NULL,'Falla, Alejandro - Gonzalez, Alejandro','2017-08-09','Falla, Alejandro','Gonzalez, Alejandro','Alejandro,Alejandro,Falla,Gonzalez',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004140467.json',NULL,0,'2017-08-08 17:53:15'),(33631,1004142091,3,NULL,'Wozniacki, Caroline - Alexandrova, Ekaterina','2017-08-09','Wozniacki, Caroline','Alexandrova, Ekaterina','Alexandrova,Caroline,Ekaterina,Wozniacki',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142091.json',NULL,0,'2017-08-08 17:53:15'),(33632,1004138723,3,NULL,'Ruud, Casper - Halys, Quentin','2017-08-09','Ruud, Casper','Halys, Quentin','Casper,Halys,Quentin,Ruud',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004138723.json',NULL,0,'2017-08-08 17:53:15'),(33633,1004142748,3,NULL,'Kecmanovic, Miomir - Yen-Hsun Lu','2017-08-09','Kecmanovic, Miomir','Yen-Hsun Lu','Hsun,Kecmanovic,Lu,Miomir,Yen',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142748.json',NULL,0,'2017-08-08 17:53:15'),(33634,1004142466,3,NULL,'Kelly, Dayne - Milojevic, Nikola','2017-08-09','Kelly, Dayne','Milojevic, Nikola','Dayne,Kelly,Milojevic,Nikola',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142466.json',NULL,0,'2017-08-08 17:53:15'),(33635,1004142501,3,NULL,'Soon Woo Kwon - Kudryavtsev, Alexander','2017-08-09','Soon Woo Kwon','Kudryavtsev, Alexander','Alexander,Kudryavtsev,Kwon,Soon,Woo',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142501.json',NULL,0,'2017-08-08 17:53:16'),(33636,1004142528,3,NULL,'Di Wu - Soeda, Go','2017-08-09','Di Wu','Soeda, Go','Di,Go,Soeda,Wu',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142528.json',NULL,0,'2017-08-08 17:53:16'),(33637,1004142702,3,NULL,'Vardhan, Vishnu - Berankis, Ricardas','2017-08-09','Vardhan, Vishnu','Berankis, Ricardas','Berankis,Ricardas,Vardhan,Vishnu',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142702.json',NULL,0,'2017-08-08 17:53:16'),(33638,1004142485,3,NULL,'Donskoy, Evgeny - Sekiguchi, Shuichi','2017-08-09','Donskoy, Evgeny','Sekiguchi, Shuichi','Donskoy,Evgeny,Sekiguchi,Shuichi',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142485.json',NULL,0,'2017-08-08 17:53:16'),(33639,1004140516,3,NULL,'Duck-hee Lee - Cheong-Eui Kim','2017-08-09','Duck-hee Lee','Cheong-Eui Kim','Cheong,Duck,Eui,Kim,Lee,hee',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004140516.json',NULL,0,'2017-08-08 17:53:16'),(33640,1004142041,3,NULL,'Muguruza, Garbiñe - Flipkens, Kirsten','2017-08-09','Muguruza, Garbiñe','Flipkens, Kirsten','Flipkens,Garbiñe,Kirsten,Muguruza',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142041.json',NULL,0,'2017-08-08 17:53:16'),(33641,1004142285,3,NULL,'Yung-Jan Chan/Hingis, M - Klepac, A/Martinez Sanchez, M','2017-08-09','Yung-Jan Chan/Hingis, M','Klepac, A/Martinez Sanchez, M','Chan,Hingis,Jan,Klepac,Martinez,Sanchez,Yung',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142285.json',NULL,0,'2017-08-08 17:53:16'),(33642,1004142284,3,NULL,'Safarova, L/Strycova, B - Krejcikova, B/Niculescu, M','2017-08-09','Safarova, L/Strycova, B','Krejcikova, B/Niculescu, M','Krejcikova,Niculescu,Safarova,Strycova',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142284.json',NULL,0,'2017-08-08 17:53:16'),(33643,1004142493,3,NULL,'Williams, Venus - Siniakova, Katerina','2017-08-09','Williams, Venus','Siniakova, Katerina','Katerina,Siniakova,Venus,Williams',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142493.json',NULL,0,'2017-08-08 17:53:16'),(33644,1004142218,3,NULL,'Sevastova, Anastasija - Osaka, Naomi','2017-08-09','Sevastova, Anastasija','Osaka, Naomi','Anastasija,Naomi,Osaka,Sevastova',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142218.json',NULL,0,'2017-08-08 17:53:16'),(33645,1004140046,3,NULL,'Andreescu, B/Branstine, C - Mladenovic, K/Pavlyuchenkova, A','2017-08-09','Andreescu, B/Branstine, C','Mladenovic, K/Pavlyuchenkova, A','Andreescu,Branstine,Mladenovic,Pavlyuchenkova',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004140046.json',NULL,0,'2017-08-08 17:53:16'),(33646,1004140197,3,NULL,'Spears, A/Srebotnik, K - Kichenok, L/Melichar, N','2017-08-09','Spears, A/Srebotnik, K','Kichenok, L/Melichar, N','Kichenok,Melichar,Spears,Srebotnik',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004140197.json',NULL,0,'2017-08-08 17:53:16'),(33647,1004142374,3,NULL,'Kvitova, Petra - Stephens, Sloane','2017-08-09','Kvitova, Petra','Stephens, Sloane','Kvitova,Petra,Sloane,Stephens',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142374.json',NULL,0,'2017-08-08 17:53:17'),(33648,1004142502,3,NULL,'Safarova, Lucie - Cibulkova, Dominika','2017-08-09','Safarova, Lucie','Cibulkova, Dominika','Cibulkova,Dominika,Lucie,Safarova',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142502.json',NULL,0,'2017-08-08 17:53:17'),(33649,1004142289,3,NULL,'Elias, Gastão - Londero, Juan Ignacio','2017-08-09','Elias, Gastão','Londero, Juan Ignacio','Elias,Gastão,Ignacio,Juan,Londero',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142289.json',NULL,0,'2017-08-08 17:53:17'),(33650,1004142162,3,NULL,'Hernandez-Fernandez, Jose - King, Evan','2017-08-09','Hernandez-Fernandez, Jose','King, Evan','Evan,Fernandez,Hernandez,Jose,King',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142162.json',NULL,0,'2017-08-08 17:53:17'),(33651,1004142163,3,NULL,'Zverev, Mischa - Dimitrov, Grigor','2017-08-09','Zverev, Mischa','Dimitrov, Grigor','Dimitrov,Grigor,Mischa,Zverev',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142163.json',NULL,0,'2017-08-08 17:53:17'),(33652,1004142449,3,NULL,'Raonic, Milos - Mannarino, Adrian','2017-08-09','Raonic, Milos','Mannarino, Adrian','Adrian,Mannarino,Milos,Raonic',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142449.json',NULL,0,'2017-08-08 17:53:17'),(33653,1004142450,3,NULL,'Gasquet, Richard  - Zverev, Alexander','2017-08-09','Gasquet, Richard ','Zverev, Alexander','Alexander,Gasquet,Richard,Zverev',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142450.json',NULL,0,'2017-08-08 17:53:17'),(33654,1004142308,3,NULL,'Khachanov, K/Thiem, D - Bopanna, R/Dodig, I','2017-08-09','Khachanov, K/Thiem, D','Bopanna, R/Dodig, I','Bopanna,Dodig,Khachanov,Thiem',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142308.json',NULL,0,'2017-08-08 17:53:17'),(33655,1004142228,3,NULL,'Monfils, Gael - Nishikori, Kei','2017-08-09','Monfils, Gael','Nishikori, Kei','Gael,Kei,Monfils,Nishikori',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142228.json',NULL,0,'2017-08-08 17:53:18'),(33656,1004142486,3,NULL,'Bautista-Agut, Roberto - Harrison, Ryan','2017-08-09','Bautista-Agut, Roberto','Harrison, Ryan','Agut,Bautista,Harrison,Roberto,Ryan',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142486.json',NULL,0,'2017-08-08 17:53:18'),(33657,1004142467,3,NULL,'Federer, Roger - Polansky, Peter','2017-08-09','Federer, Roger','Polansky, Peter','Federer,Peter,Polansky,Roger',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142467.json',NULL,0,'2017-08-08 17:53:18'),(33658,1004142312,3,NULL,'Santillan, Akira - King, Darian','2017-08-09','Santillan, Akira','King, Darian','Akira,Darian,King,Santillan',0,'https://e4-api.kambi.com/offering/api/v2/ub/betoffer/live/event/1004142312.json',NULL,0,'2017-08-08 17:53:18'),(33659,6688491,6,NULL,'Rodriguez-Pace, Ricardo - Rodriguez Taverna, Santiago FA','2017-08-08','Rodriguez-Pace, Ricardo','Rodriguez Taverna, Santiago FA','FA,Pace,Ricardo,Rodriguez,Rodriguez,Santiago,Taverna',1,'/en/e/6688491/Rodriguez-Pace%2C-Ricardo-vs-Rodriguez-Taverna%2C-Santiago-FA',NULL,1,'2017-08-08 18:00:12'),(33660,6688521,6,NULL,'Swan, Katie - Maria Sanchez','2017-08-08','Swan, Katie','Maria Sanchez','Katie,Maria,Sanchez,Swan',1,'/en/e/6688521/Swan%2C-Katie-vs-Maria-Sanchez',NULL,1,'2017-08-08 18:00:12'),(33661,6680850,6,NULL,'Kruijer, Nina - Oana Georgeta Simion','2017-08-08','Kruijer, Nina','Oana Georgeta Simion','Georgeta,Kruijer,Nina,Oana,Simion',1,'/en/e/6680850/Kruijer%2C-Nina-vs-Oana-Georgeta-Simion',NULL,1,'2017-08-08 18:58:48'),(33662,6688488,6,NULL,'Hiltzik, Aron - Silverman, Cameron','2017-08-08','Hiltzik, Aron','Silverman, Cameron','Aron,Cameron,Hiltzik,Silverman',1,'/en/e/6688488/Hiltzik%2C-Aron-vs-Silverman%2C-Cameron',NULL,1,'2017-08-08 18:00:13'),(33663,6664363,6,NULL,'Feliciano Lopez - Hyeon Chung','2017-08-08','Feliciano Lopez','Hyeon Chung','Chung,Feliciano,Hyeon,Lopez',1,'/en/e/6664363/Feliciano-Lopez-vs-Hyeon-Chung',NULL,1,'2017-08-08 18:00:13'),(33664,6688519,6,NULL,'Alexandra Mueller - Carle, Maria Lourdes','2017-08-08','Alexandra Mueller','Carle, Maria Lourdes','Alexandra,Carle,Lourdes,Maria,Mueller',1,'/en/e/6688519/Alexandra-Mueller-vs-Carle%2C-Maria-Lourdes',NULL,1,'2017-08-08 18:00:13'),(33665,6664357,6,NULL,'Paolo Lorenzi - Francis Tiafoe','2017-08-08','Paolo Lorenzi','Francis Tiafoe','Francis,Lorenzi,Paolo,Tiafoe',1,'/en/e/6664357/Paolo-Lorenzi-vs-Francis-Tiafoe',NULL,1,'2017-08-08 18:00:13'),(33666,6690013,6,NULL,'Basilashvili, Nikoloz - Escobedo, Ernesto','2017-08-08','Basilashvili, Nikoloz','Escobedo, Ernesto','Basilashvili,Ernesto,Escobedo,Nikoloz',1,'/en/e/6690013/Nikoloz-Basilashvili-v-Ernesto-Escobedo',NULL,1,'2017-08-08 18:00:13'),(33667,6682714,6,NULL,'Ljubomir Celebic - Roberto Ortega-Olmedo','2017-08-08','Ljubomir Celebic','Roberto Ortega-Olmedo','Celebic,Ljubomir,Olmedo,Ortega,Roberto',1,'/en/e/6682714/Ljubomir-Celebic-vs-Roberto-Ortega-Olmedo',NULL,1,'2017-08-08 18:00:14'),(33668,6688520,6,NULL,'Tere-Apisah, Abigail - Emina Bektas','2017-08-08','Tere-Apisah, Abigail','Emina Bektas','Abigail,Apisah,Bektas,Emina,Tere',1,'/en/e/6688520/Tere-Apisah%2C-Abigail-vs-Emina-Bektas',NULL,1,'2017-08-08 18:00:14'),(33669,6677634,6,NULL,'Donna Vekic - Eugenie Bouchard','2017-08-08','Donna Vekic','Eugenie Bouchard','Bouchard,Donna,Eugenie,Vekic',1,'/en/e/6677634/Donna-Vekic-vs-Eugenie-Bouchard',NULL,1,'2017-08-08 18:00:14'),(33670,6670899,6,NULL,'Nicolas Santos - Daniel Elahi Galan','2017-08-08','Nicolas Santos','Daniel Elahi Galan','Daniel,Elahi,Galan,Nicolas,Santos',1,'/en/e/6670899/Nicolas-Santos-vs-Daniel-Elahi-Galan',NULL,1,'2017-08-08 18:58:48'),(33671,6664629,6,NULL,'Shuai Peng - Ekaterina Makarova','2017-08-08','Shuai Peng','Ekaterina Makarova','Ekaterina,Makarova,Peng,Shuai',1,'/en/e/6664629/Shuai-Peng-vs-Ekaterina-Makarova',NULL,1,'2017-08-08 18:00:14'),(33672,6682029,6,NULL,'Hans Podlipnik-Castillo/Andrei Vasilevski - Jozef Kovalik/Stefanos Tsitsipas','2017-08-08','Hans Podlipnik-Castillo/Andrei Vasilevski','Jozef Kovalik/Stefanos Tsitsipas','Andrei,Castillo,Hans,Jozef,Kovalik,Podlipnik,Stefanos,Tsitsipas,Vasilevski',1,'/en/e/6682029/Hans-Podlipnik-Castillo%2FAndrei-Vasilevski-%280%29-0-0-%280%29-Jozef-Kovalik%2FStefanos-Tsitsipas',NULL,1,'2017-08-08 18:00:14'),(33673,6683431,6,NULL,'Juan Ignacio Londero/Jorge Montero - Jose Hernandez-Fernandez/Juan Pablo Varillas Patino-Samudio','2017-08-08','Juan Ignacio Londero/Jorge Montero','Jose Hernandez-Fernandez/Juan Pablo Varillas Patino-Samudio','Fernandez,Hernandez,Ignacio,Jorge,Jose,Juan,Juan,Londero,Montero,Pablo,Patino,Samudio,Varillas',1,'/en/e/6683431/Juan-Ignacio-Londero%2FJorge-Montero-v-Jose-Hernandez-Fernandez%2FJuan-Pablo-Varillas-Patino-Samudio',NULL,1,'2017-08-08 18:58:48'),(33674,6670898,6,NULL,'Facundo Arguello - Nicolas Jarry','2017-08-08','Facundo Arguello','Nicolas Jarry','Arguello,Facundo,Jarry,Nicolas',1,'/en/e/6670898/Facundo-Arguello-vs-Nicolas-Jarry',NULL,1,'2017-08-08 18:58:48'),(33675,6684025,6,NULL,'Marie Temin - Ganna Poznikhirenko','2017-08-09','Marie Temin','Ganna Poznikhirenko','Ganna,Marie,Poznikhirenko,Temin',0,'/en/e/6684025/Marie-Temin-vs-Ganna-Poznikhirenko',NULL,0,'2017-08-08 18:00:15'),(33676,6683203,6,NULL,'Raina, Ankita - Deborah Kerfs','2017-08-09','Raina, Ankita','Deborah Kerfs','Ankita,Deborah,Kerfs,Raina',0,'/en/e/6683203/Raina%2C-Ankita-vs-Deborah-Kerfs',NULL,0,'2017-08-08 18:00:15'),(33677,6684206,6,NULL,'Morgina, Anna - Wallace, Isabelle','2017-08-09','Morgina, Anna','Wallace, Isabelle','Anna,Isabelle,Morgina,Wallace',0,'/en/e/6684206/Morgina%2C-Anna-vs-Wallace%2C-Isabelle',NULL,0,'2017-08-08 18:00:15'),(33678,6669302,6,NULL,'Grega Zemlja - Grega Boh','2017-08-08','Grega Zemlja','Grega Boh','Boh,Grega,Grega,Zemlja',1,'/en/e/6669302/Grega-Zemlja-vs-Grega-Boh',NULL,1,'2017-08-08 18:58:48'),(33679,6671059,6,NULL,'Ramkumar Ramanathan - Henri Laaksonen','2017-08-08','Ramkumar Ramanathan','Henri Laaksonen','Henri,Laaksonen,Ramanathan,Ramkumar',1,'/en/e/6671059/Ramkumar-Ramanathan-vs-Henri-Laaksonen',NULL,1,'2017-08-08 18:58:48'),(33680,6671061,6,NULL,'Gleb Sakharov - Dennis Novikov','2017-08-08','Gleb Sakharov','Dennis Novikov','Dennis,Gleb,Novikov,Sakharov',1,'/en/e/6671061/Gleb-Sakharov-vs-Dennis-Novikov',NULL,1,'2017-08-08 18:58:48'),(33681,6678369,6,NULL,'Frederik Nielsen - Tennys Sandgren','2017-08-08','Frederik Nielsen','Tennys Sandgren','Frederik,Nielsen,Sandgren,Tennys',1,'/en/e/6678369/Frederik-Nielsen-vs-Tennys-Sandgren',NULL,1,'2017-08-08 18:58:48'),(33682,6688192,6,NULL,'Sabina Sharipova - Lapko, Vera','2017-08-08','Sabina Sharipova','Lapko, Vera','Lapko,Sabina,Sharipova,Vera',1,'/en/e/6688192/Sabina-Sharipova-vs-Lapko%2C-Vera',NULL,1,'2017-08-08 18:58:48'),(33683,6688230,6,NULL,'Stefanie Voegele - Mestach, AN Sophie','2017-08-08','Stefanie Voegele','Mestach, AN Sophie','AN,Mestach,Sophie,Stefanie,Voegele',1,'/en/e/6688230/Stefanie-Voegele-vs-Mestach%2C-AN-Sophie',NULL,1,'2017-08-08 18:58:48'),(33684,6688489,6,NULL,'Callahan, Hunter - Johnson, Eric','2017-08-08','Callahan, Hunter','Johnson, Eric','Callahan,Eric,Hunter,Johnson',1,'/en/e/6688489/Callahan%2C-Hunter-vs-Johnson%2C-Eric',NULL,1,'2017-08-08 18:58:48'),(33685,6664381,6,NULL,'David Goffin - Yuichi Sugita','2017-08-08','David Goffin','Yuichi Sugita','David,Goffin,Sugita,Yuichi',1,'/en/e/6664381/David-Goffin-vs-Yuichi-Sugita',NULL,1,'2017-08-08 18:58:49'),(33686,6688396,6,NULL,'Anna-Karolina Schmiedlova - Jennifer Elie','2017-08-08','Anna-Karolina Schmiedlova','Jennifer Elie','Anna,Elie,Jennifer,Karolina,Schmiedlova',1,'/en/e/6688396/Anna-Karolina-Schmiedlova-vs-Jennifer-Elie',NULL,1,'2017-08-08 18:58:48'),(33687,6664362,6,NULL,'Pablo Carreno Busta - Karen Khachanov','2017-08-08','Pablo Carreno Busta','Karen Khachanov','Busta,Carreno,Karen,Khachanov,Pablo',1,'/en/e/6664362/Pablo-Carreno-Busta-vs-Karen-Khachanov',NULL,1,'2017-08-08 18:58:49'),(33688,6669786,6,NULL,'Denis Shapovalov - Rogerio Dutra Silva','2017-08-08','Denis Shapovalov','Rogerio Dutra Silva','Denis,Dutra,Rogerio,Shapovalov,Silva',1,'/en/e/6669786/Denis-Shapovalov-vs-Rogerio-Dutra-Silva',NULL,1,'2017-08-08 18:58:48'),(33689,6670731,6,NULL,'Juan Martin Del Potro / Grigor Dimitrov - Ryan Harrison / Michael Venus','2017-08-08','Juan Martin Del Potro / Grigor Dimitrov','Ryan Harrison / Michael Venus','Del,Dimitrov,Grigor,Harrison,Juan,Martin,Michael,Potro,Ryan,Venus',0,'/en/e/6670731/Juan-Martin-Del-Potro-%2F-Grigor-Dimitrov-vs-Ryan-Harrison-%2F-Michael-Venus',NULL,0,'2017-08-08 18:00:15'),(33690,6681732,6,NULL,'Sam Querrey - Vincent Millot','2017-08-08','Sam Querrey','Vincent Millot','Millot,Querrey,Sam,Vincent',1,'/en/e/6681732/Sam-Querrey-vs-Vincent-Millot',NULL,1,'2017-08-08 18:58:48'),(33691,6675833,6,NULL,'Ilya Ivashka / Aldin Setkic - Albano Olivetti / Igor Zelenay','2017-08-08','Ilya Ivashka / Aldin Setkic','Albano Olivetti / Igor Zelenay','Albano,Aldin,Igor,Ilya,Ivashka,Olivetti,Setkic,Zelenay',0,'/en/e/6675833/Ilya-Ivashka-%2F-Aldin-Setkic-vs-Albano-Olivetti-%2F-Igor-Zelenay',NULL,0,'2017-08-08 18:00:16'),(33692,6676993,6,NULL,'Ashleigh Barty / Casey Dellacqua - Julia Goerges / Olga Savchuk','2017-08-08','Ashleigh Barty / Casey Dellacqua','Julia Goerges / Olga Savchuk','Ashleigh,Barty,Casey,Dellacqua,Goerges,Julia,Olga,Savchuk',0,'/en/e/6676993/Ashleigh-Barty-%2F-Casey-Dellacqua-vs-Julia-Goerges-%2F-Olga-Savchuk',NULL,0,'2017-08-08 18:00:16'),(33693,6664636,6,NULL,'Agnieszka Radwanska - CoCo Vandeweghe','2017-08-08','Agnieszka Radwanska','CoCo Vandeweghe','Agnieszka,CoCo,Radwanska,Vandeweghe',0,'/en/e/6664636/Agnieszka-Radwanska-vs-CoCo-Vandeweghe',NULL,0,'2017-08-08 18:58:49'),(33694,6677745,6,NULL,'Gonzalo Lama - Victor Estrella Burgos','2017-08-08','Gonzalo Lama','Victor Estrella Burgos','Burgos,Estrella,Gonzalo,Lama,Victor',0,'/en/e/6677745/Gonzalo-Lama-vs-Victor-Estrella-Burgos',NULL,0,'2017-08-08 18:58:49'),(33695,6664633,6,NULL,'Anastasia Pavlyuchenkova - AlizÉ Cornet','2017-08-08','Anastasia Pavlyuchenkova','AlizÉ Cornet','AlizÉ,Anastasia,Cornet,Pavlyuchenkova',0,'/en/e/6664633/Anastasia-Pavlyuchenkova-vs-Aliz%C3%89-Cornet',NULL,0,'2017-08-08 18:58:49'),(33696,6675840,6,NULL,'Ilija Bozoljac / Filip Krajinovic - David Lucas Ambrozic / Tilen Zitnik','2017-08-08','Ilija Bozoljac / Filip Krajinovic','David Lucas Ambrozic / Tilen Zitnik','Ambrozic,Bozoljac,David,Filip,Ilija,Krajinovic,Lucas,Tilen,Zitnik',0,'/en/e/6675840/Ilija-Bozoljac-%2F-Filip-Krajinovic-vs-David-Lucas-Ambrozic-%2F-Tilen-Zitnik',NULL,0,'2017-08-08 18:58:49'),(33697,6671052,6,NULL,'Mikhail Kukushkin - Teymuraz Gabashvili','2017-08-08','Mikhail Kukushkin','Teymuraz Gabashvili','Gabashvili,Kukushkin,Mikhail,Teymuraz',0,'/en/e/6671052/Mikhail-Kukushkin-vs-Teymuraz-Gabashvili',NULL,0,'2017-08-08 18:58:49'),(33698,6671055,6,NULL,'Alexander Bublik - Mitchell Krueger','2017-08-08','Alexander Bublik','Mitchell Krueger','Alexander,Bublik,Krueger,Mitchell',0,'/en/e/6671055/Alexander-Bublik-vs-Mitchell-Krueger',NULL,0,'2017-08-08 18:58:49'),(33699,6671057,6,NULL,'Jason Jung - Cameron Norrie','2017-08-08','Jason Jung','Cameron Norrie','Cameron,Jason,Jung,Norrie',0,'/en/e/6671057/Jason-Jung-vs-Cameron-Norrie',NULL,0,'2017-08-08 18:58:49'),(33700,6676987,6,NULL,'Chia-Jung Chuang / Renata Voracova - Lucie Hradecka / Katerina Siniakova','2017-08-08','Chia-Jung Chuang / Renata Voracova','Lucie Hradecka / Katerina Siniakova','Chia,Chuang,Hradecka,Jung,Katerina,Lucie,Renata,Siniakova,Voracova',0,'/en/e/6676987/Chia-Jung-Chuang-%2F-Renata-Voracova-vs-Lucie-Hradecka-%2F-Katerina-Siniakova',NULL,0,'2017-08-08 18:58:49'),(33701,6677419,6,NULL,'Kevin Anderson - Dudi Sela','2017-08-08','Kevin Anderson','Dudi Sela','Anderson,Dudi,Kevin,Sela',0,'/en/e/6677419/Kevin-Anderson-vs-Dudi-Sela',NULL,0,'2017-08-08 18:58:49'),(33702,6670725,6,NULL,'Roberto Bautista Agut / David Ferrer - Daniel Nestor / Vasek Pospisil','2017-08-08','Roberto Bautista Agut / David Ferrer','Daniel Nestor / Vasek Pospisil','Agut,Bautista,Daniel,David,Ferrer,Nestor,Pospisil,Roberto,Vasek',0,'/en/e/6670725/Roberto-Bautista-Agut-%2F-David-Ferrer-vs-Daniel-Nestor-%2F-Vasek-Pospisil',NULL,0,'2017-08-08 18:58:49'),(33703,6670727,6,NULL,'Paolo Lorenzi / Albert Ramos-Vinolas - Steve Johnson / Sam Querrey','2017-08-08','Paolo Lorenzi / Albert Ramos-Vinolas','Steve Johnson / Sam Querrey','Albert,Johnson,Lorenzi,Paolo,Querrey,Ramos,Sam,Steve,Vinolas',0,'/en/e/6670727/Paolo-Lorenzi-%2F-Albert-Ramos-Vinolas-vs-Steve-Johnson-%2F-Sam-Querrey',NULL,0,'2017-08-08 18:00:16'),(33704,6670729,6,NULL,'Lucas Pouille / Jo-Wilfried Tsonga - Feliciano Lopez / Marc Lopez','2017-08-08','Lucas Pouille / Jo-Wilfried Tsonga','Feliciano Lopez / Marc Lopez','Feliciano,Jo,Lopez,Lopez,Lucas,Marc,Pouille,Tsonga,Wilfried',0,'/en/e/6670729/Lucas-Pouille-%2F-Jo-Wilfried-Tsonga-vs-Feliciano-Lopez-%2F-Marc-Lopez',NULL,0,'2017-08-08 18:58:50'),(33705,6677266,6,NULL,'Sergio Galdos / Nicolas Jarry - Fernando Romboli / Eduardo Russi Assumpcao','2017-08-08','Sergio Galdos / Nicolas Jarry','Fernando Romboli / Eduardo Russi Assumpcao','Assumpcao,Eduardo,Fernando,Galdos,Jarry,Nicolas,Romboli,Russi,Sergio',0,'/en/e/6677266/Sergio-Galdos-%2F-Nicolas-Jarry-vs-Fernando-Romboli-%2F-Eduardo-Russi-Assumpcao',NULL,0,'2017-08-08 18:58:49'),(33706,6683710,6,NULL,'Elina Svitolina - Daria Kasatkina','2017-08-08','Elina Svitolina','Daria Kasatkina','Daria,Elina,Kasatkina,Svitolina',0,'/en/e/6683710/Elina-Svitolina-vs-Daria-Kasatkina',NULL,0,'2017-08-08 18:58:50'),(33707,6670896,6,NULL,'Joao Souza - Emilio Gomez','2017-08-09','Joao Souza','Emilio Gomez','Emilio,Gomez,Joao,Souza',0,'/en/e/6670896/Joao-Souza-vs-Emilio-Gomez',NULL,0,'2017-08-08 18:58:50'),(33708,6671047,6,NULL,'Joris De Loore - John Lamble','2017-08-08','Joris De Loore','John Lamble','De,John,Joris,Lamble,Loore',0,'/en/e/6671047/Joris-De-Loore-vs-John-Lamble',NULL,0,'2017-08-08 18:00:17'),(33709,6671050,6,NULL,'Noah Rubin - Raymond Sarmiento','2017-08-08','Noah Rubin','Raymond Sarmiento','Noah,Raymond,Rubin,Sarmiento',0,'/en/e/6671050/Noah-Rubin-vs-Raymond-Sarmiento',NULL,0,'2017-08-08 18:00:17'),(33710,6671058,6,NULL,'Taylor Harry Fritz - Konstantin Kravchuk','2017-08-08','Taylor Harry Fritz','Konstantin Kravchuk','Fritz,Harry,Konstantin,Kravchuk,Taylor',0,'/en/e/6671058/Taylor-Harry-Fritz-vs-Konstantin-Kravchuk',NULL,0,'2017-08-08 18:00:17'),(33711,6670724,6,NULL,'Nikola Mektic / Aisam-Ul-Haq Qureshi - Juan Sebastian Cabal / Pablo Carreno Busta','2017-08-09','Nikola Mektic / Aisam-Ul-Haq Qureshi','Juan Sebastian Cabal / Pablo Carreno Busta','Aisam,Busta,Cabal,Carreno,Haq,Juan,Mektic,Nikola,Pablo,Qureshi,Sebastian,Ul',0,'/en/e/6670724/Nikola-Mektic-%2F-Aisam-Ul-Haq-Qureshi-vs-Juan-Sebastian-Cabal-%2F-Pablo-Carreno-Busta',NULL,0,'2017-08-08 18:58:50'),(33712,6670730,6,NULL,'Jean-Julien Rojer / Horia Tecau - Santiago Gonzalez / Donald Young','2017-08-08','Jean-Julien Rojer / Horia Tecau','Santiago Gonzalez / Donald Young','Donald,Gonzalez,Horia,Jean,Julien,Rojer,Santiago,Tecau,Young',0,'/en/e/6670730/Jean-Julien-Rojer-%2F-Horia-Tecau-vs-Santiago-Gonzalez-%2F-Donald-Young',NULL,0,'2017-08-08 18:00:17'),(33713,6677420,6,NULL,'Jack Sock - Pierre-Hugues Herbert','2017-08-09','Jack Sock','Pierre-Hugues Herbert','Herbert,Hugues,Jack,Pierre,Sock',0,'/en/e/6677420/Jack-Sock-vs-Pierre-Hugues-Herbert',NULL,0,'2017-08-08 18:58:50'),(33714,6684204,6,NULL,'Jared Donaldson - Benoit Paire','2017-08-09','Jared Donaldson','Benoit Paire','Benoit,Donaldson,Jared,Paire',0,'/en/e/6684204/Jared-Donaldson-vs-Benoit-Paire',NULL,0,'2017-08-08 18:58:50'),(33715,6664638,6,NULL,'Timea Babos - Bianca Andreescu','2017-08-09','Timea Babos','Bianca Andreescu','Andreescu,Babos,Bianca,Timea',0,'/en/e/6664638/Timea-Babos-vs-Bianca-Andreescu',NULL,0,'2017-08-08 18:58:50'),(33716,6677552,6,NULL,'Alexander Bublik / Bradley Mousley - Ruan Roelofse / Christopher Rungkat','2017-08-09','Alexander Bublik / Bradley Mousley','Ruan Roelofse / Christopher Rungkat','Alexander,Bradley,Bublik,Christopher,Mousley,Roelofse,Ruan,Rungkat',0,'/en/e/6677552/Alexander-Bublik-%2F-Bradley-Mousley-vs-Ruan-Roelofse-%2F-Christopher-Rungkat',NULL,0,'2017-08-08 18:58:50'),(33717,6683652,6,NULL,'Barbora Zahlavova Strycova - Daria Gavrilova','2017-08-09','Barbora Zahlavova Strycova','Daria Gavrilova','Barbora,Daria,Gavrilova,Strycova,Zahlavova',0,'/en/e/6683652/Barbora-Zahlavova-Strycova-vs-Daria-Gavrilova',NULL,0,'2017-08-08 18:58:51'),(33718,6670890,6,NULL,'Alejandro Gonzalez - Alejandro Falla','2017-08-09','Alejandro Gonzalez','Alejandro Falla','Alejandro,Alejandro,Falla,Gonzalez',0,'/en/e/6670890/Alejandro-Gonzalez-vs-Alejandro-Falla',NULL,0,'2017-08-08 18:58:51'),(33719,6671056,6,NULL,'Mackenzie McDonald - John Millman','2017-08-09','Mackenzie McDonald','John Millman','John,Mackenzie,McDonald,Millman',0,'/en/e/6671056/Mackenzie-McDonald-vs-John-Millman',NULL,0,'2017-08-08 18:58:51'),(33720,6670728,6,NULL,'Frank Dancevic / Adil Shamasdin - Fabrice Martin / Edouard Roger-Vasselin','2017-08-09','Frank Dancevic / Adil Shamasdin','Fabrice Martin / Edouard Roger-Vasselin','Adil,Dancevic,Edouard,Fabrice,Frank,Martin,Roger,Shamasdin,Vasselin',0,'/en/e/6670728/Frank-Dancevic-%2F-Adil-Shamasdin-vs-Fabrice-Martin-%2F-Edouard-Roger-Vasselin',NULL,0,'2017-08-08 18:58:51'),(33721,6684458,6,NULL,'Diego Schwartzman - Dominic Thiem','2017-08-09','Diego Schwartzman','Dominic Thiem','Diego,Dominic,Schwartzman,Thiem',0,'/en/e/6684458/Diego-Schwartzman-vs-Dominic-Thiem',NULL,0,'2017-08-08 18:58:51'),(33722,6671060,6,NULL,'Quentin Halys - Casper Ruud','2017-08-09','Quentin Halys','Casper Ruud','Casper,Halys,Quentin,Ruud',0,'/en/e/6671060/Quentin-Halys-vs-Casper-Ruud',NULL,0,'2017-08-08 18:58:51'),(33723,6683737,6,NULL,'Ekaterina Alexandrova - Caroline Wozniacki','2017-08-09','Ekaterina Alexandrova','Caroline Wozniacki','Alexandrova,Caroline,Ekaterina,Wozniacki',0,'/en/e/6683737/Ekaterina-Alexandrova-vs-Caroline-Wozniacki',NULL,0,'2017-08-08 18:58:51'),(33724,6685602,6,NULL,'Nikola Milojevic - Dayne Kelly','2017-08-09','Nikola Milojevic','Dayne Kelly','Dayne,Kelly,Milojevic,Nikola',0,'/en/e/6685602/Nikola-Milojevic-vs-Dayne-Kelly',NULL,0,'2017-08-08 18:58:51'),(33725,6686083,6,NULL,'Yen-Hsun Lu - Miomir Kecmanovic','2017-08-09','Yen-Hsun Lu','Miomir Kecmanovic','Hsun,Kecmanovic,Lu,Miomir,Yen',0,'/en/e/6686083/Yen-Hsun-Lu-vs-Miomir-Kecmanovic',NULL,0,'2017-08-08 18:58:51'),(33726,6686854,6,NULL,'Alexander Kudryavtsev - Soon Woo Kwon','2017-08-09','Alexander Kudryavtsev','Soon Woo Kwon','Alexander,Kudryavtsev,Kwon,Soon,Woo',0,'/en/e/6686854/Alexander-Kudryavtsev-vs-Soon-Woo-Kwon',NULL,0,'2017-08-08 18:58:51'),(33727,6685953,6,NULL,'Wishaya Trongcharoenchaikul - Grills, Jacob','2017-08-09','Wishaya Trongcharoenchaikul','Grills, Jacob','Grills,Jacob,Trongcharoenchaikul,Wishaya',0,'/en/e/6685953/Wishaya-Trongcharoenchaikul-vs-Grills%2C-Jacob',NULL,0,'2017-08-08 18:58:51'),(33728,6689569,6,NULL,'Lertpitaksinchai, Nicha - Tatachar Venugopal, Dhruthi','2017-08-09','Lertpitaksinchai, Nicha','Tatachar Venugopal, Dhruthi','Dhruthi,Lertpitaksinchai,Nicha,Tatachar,Venugopal',0,'/en/e/6689569/Lertpitaksinchai%2C-Nicha-vs-Tatachar-Venugopal%2C-Dhruthi',NULL,0,'2017-08-08 18:58:51'),(33729,6689573,6,NULL,'Tomic, Sara - Ji-Hee Choi','2017-08-09','Tomic, Sara','Ji-Hee Choi','Choi,Hee,Ji,Sara,Tomic',0,'/en/e/6689573/Tomic%2C-Sara-vs-Ji-Hee-Choi',NULL,0,'2017-08-08 18:58:51'),(33730,6689575,6,NULL,'Jandakate, Chompoothip - Lee, Pei-Chi','2017-08-09','Jandakate, Chompoothip','Lee, Pei-Chi','Chi,Chompoothip,Jandakate,Lee,Pei',0,'/en/e/6689575/Jandakate%2C-Chompoothip-vs-Lee%2C-Pei-Chi',NULL,0,'2017-08-08 18:58:51'),(33731,6689576,6,NULL,'Alcantara, Francis Casey - Katayama, Sho','2017-08-09','Alcantara, Francis Casey','Katayama, Sho','Alcantara,Casey,Francis,Katayama,Sho',0,'/en/e/6689576/Alcantara%2C-Francis-Casey-vs-Katayama%2C-Sho',NULL,0,'2017-08-08 18:58:51'),(33732,6689577,6,NULL,'Bava, Haadin - Pruchya Isarow','2017-08-09','Bava, Haadin','Pruchya Isarow','Bava,Haadin,Isarow,Pruchya',0,'/en/e/6689577/Bava%2C-Haadin-vs-Pruchya-Isarow',NULL,0,'2017-08-08 18:58:51'),(33733,6686082,6,NULL,'Shuichi Sekiguchi - Evgeny Donskoy','2017-08-09','Shuichi Sekiguchi','Evgeny Donskoy','Donskoy,Evgeny,Sekiguchi,Shuichi',0,'/en/e/6686082/Shuichi-Sekiguchi-vs-Evgeny-Donskoy',NULL,0,'2017-08-08 18:58:52'),(33734,6687099,6,NULL,'Go Soeda - Di Wu','2017-08-09','Go Soeda','Di Wu','Di,Go,Soeda,Wu',0,'/en/e/6687099/Go-Soeda-vs-Di-Wu',NULL,0,'2017-08-08 18:58:52'),(33735,6688319,6,NULL,'Ricardas Berankis - Vishnu Vardhan','2017-08-09','Ricardas Berankis','Vishnu Vardhan','Berankis,Ricardas,Vardhan,Vishnu',0,'/en/e/6688319/Ricardas-Berankis-vs-Vishnu-Vardhan',NULL,0,'2017-08-08 18:58:52'),(33736,6689570,6,NULL,'Alisa Kleybanova - Okamura, Kyoka','2017-08-09','Alisa Kleybanova','Okamura, Kyoka','Alisa,Kleybanova,Kyoka,Okamura',0,'/en/e/6689570/Alisa-Kleybanova-vs-Okamura%2C-Kyoka',NULL,0,'2017-08-08 18:58:52'),(33737,6689571,6,NULL,'Kamila Kerimbayeva - Romeo, Caroline','2017-08-09','Kamila Kerimbayeva','Romeo, Caroline','Caroline,Kamila,Kerimbayeva,Romeo',0,'/en/e/6689571/Kamila-Kerimbayeva-vs-Romeo%2C-Caroline',NULL,0,'2017-08-08 18:58:52'),(33738,6689579,6,NULL,'Moritani, Soichiro - Sami Reinwein','2017-08-09','Moritani, Soichiro','Sami Reinwein','Moritani,Reinwein,Sami,Soichiro',0,'/en/e/6689579/Moritani%2C-Soichiro-vs-Sami-Reinwein',NULL,0,'2017-08-08 18:58:52'),(33739,6689580,6,NULL,'Frigerio, Lorenzo - Schneider, Ronnie','2017-08-09','Frigerio, Lorenzo','Schneider, Ronnie','Frigerio,Lorenzo,Ronnie,Schneider',0,'/en/e/6689580/Frigerio%2C-Lorenzo-vs-Schneider%2C-Ronnie',NULL,0,'2017-08-08 18:58:52'),(33740,6689581,6,NULL,'Lee, Kuan-Yi - YU, Cheng-Yu','2017-08-09','Lee, Kuan-Yi','YU, Cheng-Yu','Cheng,Kuan,Lee,YU,Yi,Yu',0,'/en/e/6689581/Lee%2C-Kuan-Yi-vs-YU%2C-Cheng-Yu',NULL,0,'2017-08-08 18:58:52'),(33741,6689582,6,NULL,'LY, Nam Hoang - Singh, Karunuday','2017-08-09','LY, Nam Hoang','Singh, Karunuday','Hoang,Karunuday,LY,Nam,Singh',0,'/en/e/6689582/LY%2C-Nam-Hoang-vs-Singh%2C-Karunuday',NULL,0,'2017-08-08 18:58:52'),(33742,6685976,6,NULL,'Ninomiya, Makoto - Palkina, Ksenia','2017-08-09','Ninomiya, Makoto','Palkina, Ksenia','Ksenia,Makoto,Ninomiya,Palkina',0,'/en/e/6685976/Ninomiya%2C-Makoto-vs-Palkina%2C-Ksenia',NULL,0,'2017-08-08 18:58:52'),(33743,6689572,6,NULL,'Hua-Chen Lee - Yuan, Yue','2017-08-09','Hua-Chen Lee','Yuan, Yue','Chen,Hua,Lee,Yuan,Yue',0,'/en/e/6689572/Hua-Chen-Lee-vs-Yuan%2C-Yue',NULL,0,'2017-08-08 18:58:52'),(33744,6689574,6,NULL,'Marker, Lauren - Cheapchandej, Patcharin','2017-08-09','Marker, Lauren','Cheapchandej, Patcharin','Cheapchandej,Lauren,Marker,Patcharin',0,'/en/e/6689574/Marker%2C-Lauren-vs-Cheapchandej%2C-Patcharin',NULL,0,'2017-08-08 18:58:52'),(33745,6689578,6,NULL,'Congcar, Congsup - LO, Chien Hsun','2017-08-09','Congcar, Congsup','LO, Chien Hsun','Chien,Congcar,Congsup,Hsun,LO',0,'/en/e/6689578/Congcar%2C-Congsup-vs-LO%2C-Chien-Hsun',NULL,0,'2017-08-08 18:58:52'),(33746,6680110,6,NULL,'Cheong-Eui Kim - Duckhee Lee','2017-08-09','Cheong-Eui Kim','Duckhee Lee','Cheong,Duckhee,Eui,Kim,Lee',0,'/en/e/6680110/Cheong-Eui-Kim-vs-Duckhee-Lee',NULL,0,'2017-08-08 18:58:52'),(33747,6687294,6,NULL,'Kento Takeuchi - Dzmitry Zhyrmont','2017-08-09','Kento Takeuchi','Dzmitry Zhyrmont','Dzmitry,Kento,Takeuchi,Zhyrmont',0,'/en/e/6687294/Kento-Takeuchi-vs-Dzmitry-Zhyrmont',NULL,0,'2017-08-08 18:58:53'),(33748,6688002,6,NULL,'Tamara Curovic - Bulgaru, Miriam Bianca','2017-08-09','Tamara Curovic','Bulgaru, Miriam Bianca','Bianca,Bulgaru,Curovic,Miriam,Tamara',0,'/en/e/6688002/Tamara-Curovic-vs-Bulgaru%2C-Miriam-Bianca',NULL,0,'2017-08-08 18:58:53'),(33749,6688068,6,NULL,'Toma, Maria - Ene, Cristina','2017-08-09','Toma, Maria','Ene, Cristina','Cristina,Ene,Maria,Toma',0,'/en/e/6688068/Toma%2C-Maria-vs-Ene%2C-Cristina',NULL,0,'2017-08-08 18:58:53'),(33750,6688016,6,NULL,'Pogrebnyak, Valeriya - Ilona Kremen','2017-08-09','Pogrebnyak, Valeriya','Ilona Kremen','Ilona,Kremen,Pogrebnyak,Valeriya',0,'/en/e/6688016/Pogrebnyak%2C-Valeriya-vs-Ilona-Kremen',NULL,0,'2017-08-08 18:58:53'),(33751,6688028,6,NULL,'Ekaterina Yashina - Ukolova, Anna','2017-08-09','Ekaterina Yashina','Ukolova, Anna','Anna,Ekaterina,Ukolova,Yashina',0,'/en/e/6688028/Ekaterina-Yashina-vs-Ukolova%2C-Anna',NULL,0,'2017-08-08 18:58:53'),(33752,6688052,6,NULL,'Sarkisova, Karine - Vostrikova, Aleksandra','2017-08-09','Sarkisova, Karine','Vostrikova, Aleksandra','Aleksandra,Karine,Sarkisova,Vostrikova',0,'/en/e/6688052/Sarkisova%2C-Karine-vs-Vostrikova%2C-Aleksandra',NULL,0,'2017-08-08 18:58:53'),(33753,6690077,6,NULL,'Julia Stamatova - Takamura, Satsuki','2017-08-09','Julia Stamatova','Takamura, Satsuki','Julia,Satsuki,Stamatova,Takamura',0,'/en/e/6690077/Julia-Stamatova-vs-Takamura%2C-Satsuki',NULL,0,'2017-08-08 18:58:53'),(33754,6690079,6,NULL,'Martinich, Ivania - Zovincova, Vendula','2017-08-09','Martinich, Ivania','Zovincova, Vendula','Ivania,Martinich,Vendula,Zovincova',0,'/en/e/6690079/Martinich%2C-Ivania-vs-Zovincova%2C-Vendula',NULL,0,'2017-08-08 18:58:53'),(33755,6684123,6,NULL,'Molcan, Alex - Rodionov, Jurij','2017-08-09','Molcan, Alex','Rodionov, Jurij','Alex,Jurij,Molcan,Rodionov',0,'/en/e/6684123/Molcan%2C-Alex-vs-Rodionov%2C-Jurij',NULL,0,'2017-08-08 18:58:53'),(33756,6685962,6,NULL,'Benedetti, Giuliano - Aksu, Cengiz','2017-08-09','Benedetti, Giuliano','Aksu, Cengiz','Aksu,Benedetti,Cengiz,Giuliano',0,'/en/e/6685962/Benedetti%2C-Giuliano-vs-Aksu%2C-Cengiz',NULL,0,'2017-08-08 18:58:52'),(33757,6685966,6,NULL,'Orlov, Vladyslav - Eros Siringo','2017-08-09','Orlov, Vladyslav','Eros Siringo','Eros,Orlov,Siringo,Vladyslav',0,'/en/e/6685966/Orlov%2C-Vladyslav-vs-Eros-Siringo',NULL,0,'2017-08-08 18:58:55'),(33758,6685968,6,NULL,'Bogajo Fernandez, Fernando - Nikola Cacic','2017-08-09','Bogajo Fernandez, Fernando','Nikola Cacic','Bogajo,Cacic,Fernandez,Fernando,Nikola',0,'/en/e/6685968/Bogajo-Fernandez%2C-Fernando-vs-Nikola-Cacic',NULL,0,'2017-08-08 18:58:52'),(33759,6685972,6,NULL,'Tsung-Hua Yang - Roberto, Riccardo','2017-08-09','Tsung-Hua Yang','Roberto, Riccardo','Hua,Riccardo,Roberto,Tsung,Yang',0,'/en/e/6685972/Tsung-Hua-Yang-vs-Roberto%2C-Riccardo',NULL,0,'2017-08-08 18:58:55'),(33760,6685974,6,NULL,'Krivokuca, Neven - Tagashira, Kento','2017-08-09','Krivokuca, Neven','Tagashira, Kento','Kento,Krivokuca,Neven,Tagashira',0,'/en/e/6685974/Krivokuca%2C-Neven-vs-Tagashira%2C-Kento',NULL,0,'2017-08-08 18:58:54'),(33761,6687902,6,NULL,'Kitagawa, Rio - Yoruk, Ilay','2017-08-09','Kitagawa, Rio','Yoruk, Ilay','Ilay,Kitagawa,Rio,Yoruk',0,'/en/e/6687902/Kitagawa%2C-Rio-vs-Yoruk%2C-Ilay',NULL,0,'2017-08-08 18:58:53'),(33762,6689983,6,NULL,'Sproch, Dominik - Bojanovic, Darko','2017-08-09','Sproch, Dominik','Bojanovic, Darko','Bojanovic,Darko,Dominik,Sproch',0,'/en/e/6689983/Sproch%2C-Dominik-vs-Bojanovic%2C-Darko',NULL,0,'2017-08-08 18:58:53'),(33763,6684120,6,NULL,'Onishi, Ken - Kalenichenko, Danylo','2017-08-09','Onishi, Ken','Kalenichenko, Danylo','Danylo,Kalenichenko,Ken,Onishi',0,'/en/e/6684120/Onishi%2C-Ken-vs-Kalenichenko%2C-Danylo',NULL,0,'2017-08-08 18:58:53'),(33764,6684125,6,NULL,'Liska, Tomas - Zukas, Matias','2017-08-09','Liska, Tomas','Zukas, Matias','Liska,Matias,Tomas,Zukas',0,'/en/e/6684125/Liska%2C-Tomas-vs-Zukas%2C-Matias',NULL,0,'2017-08-08 18:58:53'),(33765,6687895,6,NULL,'Cengiz, Berfu - Vasilisa Aponasenko','2017-08-09','Cengiz, Berfu','Vasilisa Aponasenko','Aponasenko,Berfu,Cengiz,Vasilisa',0,'/en/e/6687895/Cengiz%2C-Berfu-vs-Vasilisa-Aponasenko',NULL,0,'2017-08-08 18:58:53'),(33766,6687904,6,NULL,'Solovyeva, Daria - Lampla, Louise','2017-08-09','Solovyeva, Daria','Lampla, Louise','Daria,Lampla,Louise,Solovyeva',0,'/en/e/6687904/Solovyeva%2C-Daria-vs-Lampla%2C-Louise',NULL,0,'2017-08-08 18:58:53'),(33767,6687905,6,NULL,'Kerstin Peckl - Kan, Victoria','2017-08-09','Kerstin Peckl','Kan, Victoria','Kan,Kerstin,Peckl,Victoria',0,'/en/e/6687905/Kerstin-Peckl-vs-Kan%2C-Victoria',NULL,0,'2017-08-08 18:58:54'),(33768,6689587,6,NULL,'Marko, Michal - Poljak, David','2017-08-09','Marko, Michal','Poljak, David','David,Marko,Michal,Poljak',0,'/en/e/6689587/Marko%2C-Michal-vs-Poljak%2C-David',NULL,0,'2017-08-08 18:58:54'),(33769,6688020,6,NULL,'Ayzatulina, Ulyana - Kruzhkova, Daria','2017-08-09','Ayzatulina, Ulyana','Kruzhkova, Daria','Ayzatulina,Daria,Kruzhkova,Ulyana',0,'/en/e/6688020/Ayzatulina%2C-Ulyana-vs-Kruzhkova%2C-Daria',NULL,0,'2017-08-08 18:58:54'),(33770,6688076,6,NULL,'Yulia Kulikova - Gasanova, Anastasia','2017-08-09','Yulia Kulikova','Gasanova, Anastasia','Anastasia,Gasanova,Kulikova,Yulia',0,'/en/e/6688076/Yulia-Kulikova-vs-Gasanova%2C-Anastasia',NULL,0,'2017-08-08 18:58:54'),(33771,6687899,6,NULL,'OZ, Ipek - Bahodyrova, Laylo','2017-08-09','OZ, Ipek','Bahodyrova, Laylo','Bahodyrova,Ipek,Laylo,OZ',0,'/en/e/6687899/OZ%2C-Ipek-vs-Bahodyrova%2C-Laylo',NULL,0,'2017-08-08 18:58:54'),(33772,6687900,6,NULL,'Cemre Anil - Bovy, Margaux','2017-08-09','Cemre Anil','Bovy, Margaux','Anil,Bovy,Cemre,Margaux',0,'/en/e/6687900/Cemre-Anil-vs-Bovy%2C-Margaux',NULL,0,'2017-08-08 18:58:54'),(33773,6687909,6,NULL,'Umarova, Komola - Bursa, Anastasia','2017-08-09','Umarova, Komola','Bursa, Anastasia','Anastasia,Bursa,Komola,Umarova',0,'/en/e/6687909/Umarova%2C-Komola-vs-Bursa%2C-Anastasia',NULL,0,'2017-08-08 18:58:54'),(33774,6689586,6,NULL,'Duda, Filip - Nejedly, Pavel','2017-08-09','Duda, Filip','Nejedly, Pavel','Duda,Filip,Nejedly,Pavel',0,'/en/e/6689586/Duda%2C-Filip-vs-Nejedly%2C-Pavel',NULL,0,'2017-08-08 18:58:54'),(33775,6689588,6,NULL,'Klein, Lukas - Sachko, Vitaliy','2017-08-09','Klein, Lukas','Sachko, Vitaliy','Klein,Lukas,Sachko,Vitaliy',0,'/en/e/6689588/Klein%2C-Lukas-vs-Sachko%2C-Vitaliy',NULL,0,'2017-08-08 18:58:54'),(33776,6688054,6,NULL,'Ghioroaie, Ylona-Georgiana - Kiszner Luca, Anamaria','2017-08-09','Ghioroaie, Ylona-Georgiana','Kiszner Luca, Anamaria','Anamaria,Georgiana,Ghioroaie,Kiszner,Luca,Ylona',0,'/en/e/6688054/Ghioroaie%2C-Ylona-Georgiana-vs-Kiszner-Luca%2C-Anamaria',NULL,0,'2017-08-08 18:58:54'),(33777,6689583,6,NULL,'Brna, David Damian - Prihodko, Oleg','2017-08-09','Brna, David Damian','Prihodko, Oleg','Brna,Damian,David,Oleg,Prihodko',0,'/en/e/6689583/Brna%2C-David-Damian-vs-Prihodko%2C-Oleg',NULL,0,'2017-08-08 18:58:54'),(33778,6690078,6,NULL,'Mihalikova, Tereza - Stoilkovska, Magdalena','2017-08-09','Mihalikova, Tereza','Stoilkovska, Magdalena','Magdalena,Mihalikova,Stoilkovska,Tereza',0,'/en/e/6690078/Mihalikova%2C-Tereza-vs-Stoilkovska%2C-Magdalena',NULL,0,'2017-08-08 18:58:55'),(33779,6690080,6,NULL,'Elena Bogdan - Novotna, Natalie','2017-08-09','Elena Bogdan','Novotna, Natalie','Bogdan,Elena,Natalie,Novotna',0,'/en/e/6690080/Elena-Bogdan-vs-Novotna%2C-Natalie',NULL,0,'2017-08-08 18:58:55'),(33780,6676984,6,NULL,'Lyudmyla Kichenok / Nicole Melichar - Abigail Spears / Katarina Srebotnik','2017-08-09','Lyudmyla Kichenok / Nicole Melichar','Abigail Spears / Katarina Srebotnik','Abigail,Katarina,Kichenok,Lyudmyla,Melichar,Nicole,Spears,Srebotnik',0,'/en/e/6676984/Lyudmyla-Kichenok-%2F-Nicole-Melichar-vs-Abigail-Spears-%2F-Katarina-Srebotnik',NULL,0,'2017-08-08 18:58:55'),(33781,6676992,6,NULL,'Kristina Mladenovic / Anastasia Pavlyuchenkova - Bianca Andreescu / Carson Branstine','2017-08-09','Kristina Mladenovic / Anastasia Pavlyuchenkova','Bianca Andreescu / Carson Branstine','Anastasia,Andreescu,Bianca,Branstine,Carson,Kristina,Mladenovic,Pavlyuchenkova',0,'/en/e/6676992/Kristina-Mladenovic-%2F-Anastasia-Pavlyuchenkova-vs-Bianca-Andreescu-%2F-Carson-Branstine',NULL,0,'2017-08-08 18:58:55'),(33782,6683715,6,NULL,'Kirsten Flipkens - Garbiñe Muguruza','2017-08-09','Kirsten Flipkens','Garbiñe Muguruza','Flipkens,Garbiñe,Kirsten,Muguruza',0,'/en/e/6683715/Kirsten-Flipkens-vs-Garbi%C3%B1e-Muguruza',NULL,0,'2017-08-08 18:58:55'),(33783,6684117,6,NULL,'Evan King - Jose Hernandez','2017-08-09','Evan King','Jose Hernandez','Evan,Hernandez,Jose,King',0,'/en/e/6684117/Evan-King-vs-Jose-Hernandez',NULL,0,'2017-08-08 18:58:55'),(33784,6684127,6,NULL,'Grigor Dimitrov - Mischa Zverev','2017-08-09','Grigor Dimitrov','Mischa Zverev','Dimitrov,Grigor,Mischa,Zverev',0,'/en/e/6684127/Grigor-Dimitrov-vs-Mischa-Zverev',NULL,0,'2017-08-08 18:58:55'),(33785,6684195,6,NULL,'Naomi Osaka - Anastasija Sevastova','2017-08-09','Naomi Osaka','Anastasija Sevastova','Anastasija,Naomi,Osaka,Sevastova',0,'/en/e/6684195/Naomi-Osaka-vs-Anastasija-Sevastova',NULL,0,'2017-08-08 18:58:55'),(33786,6684205,6,NULL,'Kei Nishikori - Gael Monfils','2017-08-09','Kei Nishikori','Gael Monfils','Gael,Kei,Monfils,Nishikori',0,'/en/e/6684205/Kei-Nishikori-vs-Gael-Monfils',NULL,0,'2017-08-08 18:58:56'),(33787,6684391,6,NULL,'Andreja Klepac / MarÃ­a JosÃ© MartÃ­nez SÃ¡nchez - Yung-Jan Chan / Martina Hingis','2017-08-09','Andreja Klepac / MarÃ­a JosÃ© MartÃ­nez SÃ¡nchez','Yung-Jan Chan / Martina Hingis','Andreja,Chan,Hingis,Jan,JosÃ,Klepac,Martina,MartÃ,MarÃ,SÃ,Yung,nchez,nez',0,'/en/e/6684391/Andreja-Klepac-%2F-Mar%C3%83%C2%ADa-Jos%C3%83%C2%A9-Mart%C3%83%C2%ADnez-S%C3%83%C2%A1nchez-vs-Yung-Jan-Chan-%2F-Martina-Hingis',NULL,0,'2017-08-08 18:58:56'),(33788,6684407,6,NULL,'Juan Ignacio Londero - Gastao Elias','2017-08-09','Juan Ignacio Londero','Gastao Elias','Elias,Gastao,Ignacio,Juan,Londero',0,'/en/e/6684407/Juan-Ignacio-Londero-vs-Gastao-Elias',NULL,0,'2017-08-08 18:58:56'),(33789,6684408,6,NULL,'Nadiia Kichenok / Anastasia Rodionova - Raquel Atawo / Daria Gavrilova','2017-08-09','Nadiia Kichenok / Anastasia Rodionova','Raquel Atawo / Daria Gavrilova','Anastasia,Atawo,Daria,Gavrilova,Kichenok,Nadiia,Raquel,Rodionova',0,'/en/e/6684408/Nadiia-Kichenok-%2F-Anastasia-Rodionova-vs-Raquel-Atawo-%2F-Daria-Gavrilova',NULL,0,'2017-08-08 18:58:56'),(33790,6684409,6,NULL,'Barbora Krejcikova / Monica Niculescu - Lucie Safarova / Barbora Strycova','2017-08-09','Barbora Krejcikova / Monica Niculescu','Lucie Safarova / Barbora Strycova','Barbora,Barbora,Krejcikova,Lucie,Monica,Niculescu,Safarova,Strycova',0,'/en/e/6684409/Barbora-Krejcikova-%2F-Monica-Niculescu-vs-Lucie-Safarova-%2F-Barbora-Strycova',NULL,0,'2017-08-08 18:58:56'),(33791,6684490,6,NULL,'Sloane Stephens - Petra Kvitova','2017-08-09','Sloane Stephens','Petra Kvitova','Kvitova,Petra,Sloane,Stephens',0,'/en/e/6684490/Sloane-Stephens-vs-Petra-Kvitova',NULL,0,'2017-08-08 18:58:56'),(33792,6684725,6,NULL,'Adrian Mannarino - Milos Raonic','2017-08-09','Adrian Mannarino','Milos Raonic','Adrian,Mannarino,Milos,Raonic',0,'/en/e/6684725/Adrian-Mannarino-vs-Milos-Raonic',NULL,0,'2017-08-08 18:58:56'),(33793,6684891,6,NULL,'Alexander Zverev - Richard Gasquet','2017-08-09','Alexander Zverev','Richard Gasquet','Alexander,Gasquet,Richard,Zverev',0,'/en/e/6684891/Alexander-Zverev-vs-Richard-Gasquet',NULL,0,'2017-08-08 18:58:56'),(33794,6685603,6,NULL,'Peter Polansky - Roger Federer','2017-08-09','Peter Polansky','Roger Federer','Federer,Peter,Polansky,Roger',0,'/en/e/6685603/Peter-Polansky-vs-Roger-Federer',NULL,0,'2017-08-08 18:58:56'),(33795,6686091,6,NULL,'Ryan Harrison - Roberto Bautista Agut','2017-08-09','Ryan Harrison','Roberto Bautista Agut','Agut,Bautista,Harrison,Roberto,Ryan',0,'/en/e/6686091/Ryan-Harrison-vs-Roberto-Bautista-Agut',NULL,0,'2017-08-08 18:58:56'),(33796,6686286,6,NULL,'Katerina Siniakova - Venus Williams','2017-08-09','Katerina Siniakova','Venus Williams','Katerina,Siniakova,Venus,Williams',0,'/en/e/6686286/Katerina-Siniakova-vs-Venus-Williams',NULL,0,'2017-08-08 18:58:56'),(33797,6686856,6,NULL,'Dominika Cibulkova - Lucie Safarova','2017-08-09','Dominika Cibulkova','Lucie Safarova','Cibulkova,Dominika,Lucie,Safarova',0,'/en/e/6686856/Dominika-Cibulkova-vs-Lucie-Safarova',NULL,0,'2017-08-08 18:58:56'),(33798,6688060,6,NULL,'Ruse, Elena Gabriela - Horackova, Gabriela','2017-08-09','Ruse, Elena Gabriela','Horackova, Gabriela','Elena,Gabriela,Gabriela,Horackova,Ruse',0,'/en/e/6688060/Ruse%2C-Elena-Gabriela-vs-Horackova%2C-Gabriela',NULL,0,'2017-08-08 18:58:56'),(33799,6684489,6,NULL,'Darian King - Akira Santillan','2017-08-09','Darian King','Akira Santillan','Akira,Darian,King,Santillan',0,'/en/e/6684489/Darian-King-vs-Akira-Santillan',NULL,0,'2017-08-08 18:58:56'),(33800,6683441,6,NULL,'Anna-Lena Groenefeld/Kveta Peschke - Nao Hibino/Alicja Rosolska','2017-08-08','Anna-Lena Groenefeld/Kveta Peschke','Nao Hibino/Alicja Rosolska','Alicja,Anna,Groenefeld,Hibino,Kveta,Lena,Nao,Peschke,Rosolska',1,'/en/e/6683441/Anna-Lena-Groenefeld%2FKveta-Peschke-v-Nao-Hibino%2FAlicja-Rosolska',NULL,1,'2017-08-08 18:58:48'),(33801,6682028,6,NULL,'Ilya Ivashka/Aldin Setkic - Albano Olivetti/Igor Zelenay','2017-08-08','Ilya Ivashka/Aldin Setkic','Albano Olivetti/Igor Zelenay','Albano,Aldin,Igor,Ilya,Ivashka,Olivetti,Setkic,Zelenay',1,'/en/e/6682028/Ilya-Ivashka%2FAldin-Setkic-%280%29-0-0-%280%29-Albano-Olivetti%2FIgor-Zelenay',NULL,1,'2017-08-08 18:58:48'),(33802,6683430,6,NULL,'Juan Martin Del Potro/Grigor Dimitrov - Ryan Harrison/Michael Venus','2017-08-08','Juan Martin Del Potro/Grigor Dimitrov','Ryan Harrison/Michael Venus','Del,Dimitrov,Grigor,Harrison,Juan,Martin,Michael,Potro,Ryan,Venus',1,'/en/e/6683430/Juan-Martin-Del-Potro%2FGrigor-Dimitrov-v-Ryan-Harrison%2FMichael-Venus',NULL,1,'2017-08-08 18:58:48'),(33803,6689993,6,NULL,'Magdalena Rybarikova - Simona Halep','2017-08-09','Magdalena Rybarikova','Simona Halep','Halep,Magdalena,Rybarikova,Simona',0,'/en/e/6689993/Magdalena-Rybarikova-vs-Simona-Halep',NULL,0,'2017-08-08 18:58:56'),(33804,6690125,6,NULL,'Rafael Nadal - Borna Coric','2017-08-09','Rafael Nadal','Borna Coric','Borna,Coric,Nadal,Rafael',0,'/en/e/6690125/Rafael-Nadal-vs-Borna-Coric',NULL,0,'2017-08-08 18:58:56'),(33805,1648793,4,'2017-11-07','Jana Cepelova - Tamara Korpatsch','2017-11-07','Jana Cepelova','Tamara Korpatsch','Cepelova,Jana,Korpatsch,Tamara',0,'https://sports.betway.be/en/sports/evt/1648793',NULL,0,'2017-11-06 22:55:36'),(33806,1652389,4,'2017-11-07','Richel Hogenkamp - Sabine Lisicki','2017-11-07','Richel Hogenkamp','Sabine Lisicki','Hogenkamp,Lisicki,Richel,Sabine',0,'https://sports.betway.be/en/sports/evt/1652389',NULL,0,'2017-11-06 22:55:36'),(33807,1648794,4,'2017-11-07','Alize Cornet - Danka Kovinic','2017-11-07','Alize Cornet','Danka Kovinic','Alize,Cornet,Danka,Kovinic',0,'https://sports.betway.be/en/sports/evt/1648794',NULL,0,'2017-11-06 22:55:36'),(33808,1652391,4,'2017-11-07','Daniela Seguel - Olga Danilovic','2017-11-07','Daniela Seguel','Olga Danilovic','Daniela,Danilovic,Olga,Seguel',0,'https://sports.betway.be/en/sports/evt/1652391',NULL,0,'2017-11-06 22:55:36'),(33809,1648800,4,'2017-11-07','Bernarda Pera - Ekaterina Alexandrova','2017-11-07','Bernarda Pera','Ekaterina Alexandrova','Alexandrova,Bernarda,Ekaterina,Pera',0,'https://sports.betway.be/en/sports/evt/1648800',NULL,0,'2017-11-06 22:55:36'),(33810,1653239,4,'2017-11-08','Elena Gabriela Ruse - Monica Niculescu','2017-11-08','Elena Gabriela Ruse','Monica Niculescu','Elena,Gabriela,Monica,Niculescu,Ruse',0,'https://sports.betway.be/en/sports/evt/1653239',NULL,0,'2017-11-06 22:55:36'),(33811,1648799,4,'2017-11-08','Chloe Paquet - Jessika Ponchet','2017-11-08','Chloe Paquet','Jessika Ponchet','Chloe,Jessika,Paquet,Ponchet',0,'https://sports.betway.be/en/sports/evt/1648799',NULL,0,'2017-11-06 22:55:36'),(33812,1648801,4,'2017-11-08','Conny Perrin - Jana Fett','2017-11-08','Conny Perrin','Jana Fett','Conny,Fett,Jana,Perrin',0,'https://sports.betway.be/en/sports/evt/1648801',NULL,0,'2017-11-06 22:55:36'),(33813,1648803,4,'2017-11-08','Maryna Zanevska - Kaia Kanepi','2017-11-08','Maryna Zanevska','Kaia Kanepi','Kaia,Kanepi,Maryna,Zanevska',0,'https://sports.betway.be/en/sports/evt/1648803',NULL,0,'2017-11-06 22:55:36'),(33814,1652390,4,'2017-11-08','Pauline Parmentier - Olga Saez Larra','2017-11-08','Pauline Parmentier','Olga Saez Larra','Larra,Olga,Parmentier,Pauline,Saez',0,'https://sports.betway.be/en/sports/evt/1652390',NULL,0,'2017-11-06 22:55:37'),(33815,1648798,4,'2017-11-08','Polina Monova - Alexandra Cadantu','2017-11-08','Polina Monova','Alexandra Cadantu','Alexandra,Cadantu,Monova,Polina',0,'https://sports.betway.be/en/sports/evt/1648798',NULL,0,'2017-11-06 22:55:37'),(33816,1652688,4,'2017-11-08','Andrey Rublev - Gianluigi Quinzi','2017-11-08','Andrey Rublev','Gianluigi Quinzi','Andrey,Gianluigi,Quinzi,Rublev',1,'https://sports.betway.be/en/sports/evt/1652688',NULL,1,'2017-11-07 21:16:04'),(33817,1648718,4,'2017-11-08','Facundo Bagnis - Guido Andreozzi','2017-11-08','Facundo Bagnis','Guido Andreozzi','Andreozzi,Bagnis,Facundo,Guido',1,'https://sports.betway.be/en/sports/evt/1648718',NULL,1,'2017-11-07 21:16:04'),(33818,1648721,4,'2017-11-08','Martin Cuevas - Carlos Berlocq','2017-11-08','Martin Cuevas','Carlos Berlocq','Berlocq,Carlos,Cuevas,Martin',1,'https://sports.betway.be/en/sports/evt/1648721',NULL,1,'2017-11-07 21:16:04'),(33819,1657000,4,'2017-11-08','R Roelofse / J Salisbury - H Hach Verdugo / D Novikov','2017-11-08','R Roelofse / J Salisbury','H Hach Verdugo / D Novikov','Hach,Novikov,Roelofse,Salisbury,Verdugo',1,'https://sports.betway.be/en/sports/evt/1657000',NULL,1,'2017-11-07 21:16:04'),(33820,1656999,4,'2017-11-08','N Lammons / A Lawson - T Fritz / J Hiltzik','2017-11-08','N Lammons / A Lawson','T Fritz / J Hiltzik','Fritz,Hiltzik,Lammons,Lawson',1,'https://sports.betway.be/en/sports/evt/1656999',NULL,1,'2017-11-07 21:16:04'),(33821,6631396,5,'2017-11-07','Elitsa Kostova (BUL) - Nicole Gibbs (USA)','2017-11-07','Elitsa Kostova (BUL)','Nicole Gibbs (USA)','Elitsa,Gibbs,Kostova,Nicole',1,'https://livebetting.bwin.be/en/live/secure/api/betoffer/event','{\"id\": 6631396, \"full\": \"true\"}',1,'2017-11-07 21:16:15'),(33822,6631397,5,'2017-11-07','Kayla Day (USA) - Victoria Rodriguez (MEX)','2017-11-07','Kayla Day (USA)','Victoria Rodriguez (MEX)','Day,Kayla,Rodriguez,Victoria',1,'https://livebetting.bwin.be/en/live/secure/api/betoffer/event','{\"id\": 6631397, \"full\": \"true\"}',1,'2017-11-07 21:16:15'),(33823,6631399,5,'2017-11-07','Maria Mateas (USA) - Anna Karolina Schmiedlova (SVK)','2017-11-07','Maria Mateas (USA)','Anna Karolina Schmiedlova (SVK)','Anna,Karolina,Maria,Mateas,Schmiedlova',1,'https://livebetting.bwin.be/en/live/secure/api/betoffer/event','{\"id\": 6631399, \"full\": \"true\"}',1,'2017-11-07 21:16:15'),(33824,6631481,5,'2017-11-07','F. Ribeiro Frattini/I. Yatsuk - V. Kirkov/P. Kypson','2017-11-07','F. Ribeiro Frattini/I. Yatsuk','V. Kirkov/P. Kypson','Frattini,Kirkov,Kypson,Ribeiro,Yatsuk',1,'https://livebetting.bwin.be/en/live/secure/api/betoffer/event','{\"id\": 6631481, \"full\": \"true\"}',1,'2017-11-07 21:16:15'),(33825,6631482,5,'2017-11-07','C. Silverman/I. Strode - F. Ornago/M. Zukas','2017-11-07','C. Silverman/I. Strode','F. Ornago/M. Zukas','Ornago,Silverman,Strode,Zukas',1,'https://livebetting.bwin.be/en/live/secure/api/betoffer/event','{\"id\": 6631482, \"full\": \"true\"}',1,'2017-11-07 21:16:15'),(33826,6631483,5,'2017-11-07','A. Drysdale/W. Spencer - J. M. Benitez Chavarriaga/J. Lenz','2017-11-07','A. Drysdale/W. Spencer','J. M. Benitez Chavarriaga/J. Lenz','Benitez,Chavarriaga,Drysdale,Lenz,Spencer',1,'https://livebetting.bwin.be/en/live/secure/api/betoffer/event','{\"id\": 6631483, \"full\": \"true\"}',1,'2017-11-07 21:16:15'),(33827,6631616,5,'2017-11-07','R. Roelofse/J. Salisbury - H. Hach Verdugo/D. Novikov','2017-11-07','R. Roelofse/J. Salisbury','H. Hach Verdugo/D. Novikov','Hach,Novikov,Roelofse,Salisbury,Verdugo',1,'https://livebetting.bwin.be/en/live/secure/api/betoffer/event','{\"id\": 6631616, \"full\": \"true\"}',1,'2017-11-07 21:16:15'),(33828,6631617,5,'2017-11-07','N. Lammons/A. Lawson - T. Fritz/J. Hiltzik','2017-11-07','N. Lammons/A. Lawson','T. Fritz/J. Hiltzik','Fritz,Hiltzik,Lammons,Lawson',1,'https://livebetting.bwin.be/en/live/secure/api/betoffer/event','{\"id\": 6631617, \"full\": \"true\"}',1,'2017-11-07 21:16:15'),(33829,6632108,5,'2017-11-07','Juan Ignacio Ameal (ARG) - Tomas Lipovsek Puches (ARG)','2017-11-07','Juan Ignacio Ameal (ARG)','Tomas Lipovsek Puches (ARG)','Ameal,Ignacio,Juan,Lipovsek,Puches,Tomas',1,'https://livebetting.bwin.be/en/live/secure/api/betoffer/event','{\"id\": 6632108, \"full\": \"true\"}',1,'2017-11-07 21:16:15'),(33830,6632112,5,'2017-11-07','Mateo Nicolas Martinez (ARG) - Eduardo Agustin Torre (ARG)','2017-11-07','Mateo Nicolas Martinez (ARG)','Eduardo Agustin Torre (ARG)','Agustin,Eduardo,Martinez,Mateo,Nicolas,Torre',1,'https://livebetting.bwin.be/en/live/secure/api/betoffer/event','{\"id\": 6632112, \"full\": \"true\"}',1,'2017-11-07 21:16:15'),(33831,6622587,5,'2017-11-07','Facundo Bagnis (ARG) - Guido Andreozzi (ARG)','2017-11-07','Facundo Bagnis (ARG)','Guido Andreozzi (ARG)','Andreozzi,Bagnis,Facundo,Guido',1,'https://livebetting.bwin.be/en/live/secure/api/betoffer/event','{\"id\": 6622587, \"full\": \"true\"}',1,'2017-11-07 21:16:15'),(33832,6622588,5,'2017-11-07','Martin Cuevas (URU) - Carlos Berlocq (ARG)','2017-11-07','Martin Cuevas (URU)','Carlos Berlocq (ARG)','Berlocq,Carlos,Cuevas,Martin',1,'https://livebetting.bwin.be/en/live/secure/api/betoffer/event','{\"id\": 6622588, \"full\": \"true\"}',1,'2017-11-07 21:16:15'),(33833,7311664,6,'2017-11-10','John-Patrick Smith - Edward Corrie','2017-11-10','John-Patrick Smith','Edward Corrie','Corrie,Edward,John,Patrick,Smith',1,'/en/e/7311664/John-Patrick-Smith-vs-Edward-Corrie',NULL,1,'2017-11-09 22:23:38'),(33834,7307479,6,'2017-11-10','Ajla Tomljanovic - Nicole Gibbs','2017-11-10','Ajla Tomljanovic','Nicole Gibbs','Ajla,Gibbs,Nicole,Tomljanovic',1,'/en/e/7307479/Ajla-Tomljanovic-vs-Nicole-Gibbs',NULL,1,'2017-11-09 22:23:38'),(33835,7304857,6,'2017-11-10','Blaz Rola - Rogerio Dutra Silva','2017-11-10','Blaz Rola','Rogerio Dutra Silva','Blaz,Dutra,Rogerio,Rola,Silva',1,'/en/e/7304857/Blaz-Rola-vs-Rogerio-Dutra-Silva',NULL,1,'2017-11-09 22:23:38'),(33836,7291973,6,'2017-11-10','Karen Khachanov - Borna Coric','2017-11-10','Karen Khachanov','Borna Coric','Borna,Coric,Karen,Khachanov',1,'/en/e/7291973/Karen-Khachanov-vs-Borna-Coric',NULL,1,'2017-11-09 22:23:38'),(33837,7313607,6,'2017-11-10','Carla Lucero - Nefedova, Anastasia Evgenyevna','2017-11-10','Carla Lucero','Nefedova, Anastasia Evgenyevna','Anastasia,Carla,Evgenyevna,Lucero,Nefedova',1,'/en/e/7313607/Carla-Lucero-vs-Nefedova%2C-Anastasia-Evgenyevna',NULL,1,'2017-11-09 22:23:38'),(33838,7313623,6,'2017-11-10','Augustin Velotti - Mateo Nicolas Martinez','2017-11-10','Augustin Velotti','Mateo Nicolas Martinez','Augustin,Martinez,Mateo,Nicolas,Velotti',1,'/en/e/7313623/Augustin-Velotti-vs-Mateo-Nicolas-Martinez',NULL,1,'2017-11-09 22:23:38'),(33839,7311498,6,'2017-11-09','Leander Paes / Purav Raja - Liam Broady / Marcus Willis','2017-11-09','Leander Paes / Purav Raja','Liam Broady / Marcus Willis','Broady,Leander,Liam,Marcus,Paes,Purav,Raja,Willis',0,'/en/e/7311498/Leander-Paes-%2F-Purav-Raja-vs-Liam-Broady-%2F-Marcus-Willis',NULL,0,'2017-11-09 22:23:38'),(33840,7315878,6,'2017-11-09','Timo Stodder / Preston Touliatos - Jarryd Chaplin / Mitchell Krueger','2017-11-09','Timo Stodder / Preston Touliatos','Jarryd Chaplin / Mitchell Krueger','Chaplin,Jarryd,Krueger,Mitchell,Preston,Stodder,Timo,Touliatos',0,'/en/e/7315878/Timo-Stodder-%2F-Preston-Touliatos-vs-Jarryd-Chaplin-%2F-Mitchell-Krueger',NULL,0,'2017-11-09 22:23:38'),(33841,7305376,6,'2017-11-10','Pablo Cuevas - Jose Hernandez','2017-11-10','Pablo Cuevas','Jose Hernandez','Cuevas,Hernandez,Jose,Pablo',0,'/en/e/7305376/Pablo-Cuevas-vs-Jose-Hernandez',NULL,0,'2017-11-09 22:23:38'),(33842,7313618,6,'2017-11-10','Arina Rodionova - Tere-Apisah, Abigail','2017-11-10','Arina Rodionova','Tere-Apisah, Abigail','Abigail,Apisah,Arina,Rodionova,Tere',0,'/en/e/7313618/Arina-Rodionova-vs-Tere-Apisah%2C-Abigail',NULL,0,'2017-11-09 22:23:38'),(33843,7313620,6,'2017-11-10','Mai Minokoshi - Tomic, Sara','2017-11-10','Mai Minokoshi','Tomic, Sara','Mai,Minokoshi,Sara,Tomic',0,'/en/e/7313620/Mai-Minokoshi-vs-Tomic%2C-Sara',NULL,0,'2017-11-09 22:23:38'),(33844,7304748,6,'2017-11-10','Noah Rubin - Taylor Harry Fritz','2017-11-10','Noah Rubin','Taylor Harry Fritz','Fritz,Harry,Noah,Rubin,Taylor',0,'/en/e/7304748/Noah-Rubin-vs-Taylor-Harry-Fritz',NULL,0,'2017-11-09 22:23:38'),(33845,7305328,6,'2017-11-10','Dominik Koepfer / Mats Moraing - James Cerretani / John-Patrick Smith','2017-11-10','Dominik Koepfer / Mats Moraing','James Cerretani / John-Patrick Smith','Cerretani,Dominik,James,John,Koepfer,Mats,Moraing,Patrick,Smith',0,'/en/e/7305328/Dominik-Koepfer-%2F-Mats-Moraing-vs-James-Cerretani-%2F-John-Patrick-Smith',NULL,0,'2017-11-09 22:23:39'),(33846,7313610,6,'2017-11-10','Tammi Patterson - Olivia Rogowska','2017-11-10','Tammi Patterson','Olivia Rogowska','Olivia,Patterson,Rogowska,Tammi',0,'/en/e/7313610/Tammi-Patterson-vs-Olivia-Rogowska',NULL,0,'2017-11-09 22:23:39'),(33847,7313611,6,'2017-11-10','Wallace, Isabelle - Zidansek, Tamara','2017-11-10','Wallace, Isabelle','Zidansek, Tamara','Isabelle,Tamara,Wallace,Zidansek',0,'/en/e/7313611/Wallace%2C-Isabelle-vs-Zidansek%2C-Tamara',NULL,0,'2017-11-09 22:23:39'),(33848,7314581,6,'2017-11-10','Galfi, Dalma - Cheong, Naomi','2017-11-10','Galfi, Dalma','Cheong, Naomi','Cheong,Dalma,Galfi,Naomi',0,'/en/e/7314581/Galfi%2C-Dalma-vs-Cheong%2C-Naomi',NULL,0,'2017-11-09 22:23:39'),(33849,7314582,6,'2017-11-10','Shuai Zhang - Su Jeong Jang','2017-11-10','Shuai Zhang','Su Jeong Jang','Jang,Jeong,Shuai,Su,Zhang',0,'/en/e/7314582/Shuai-Zhang-vs-Su-Jeong-Jang',NULL,0,'2017-11-09 22:23:39'),(33850,7307488,6,'2017-11-10','Ellis, Blake - LY, Nam Hoang','2017-11-10','Ellis, Blake','LY, Nam Hoang','Blake,Ellis,Hoang,LY,Nam',0,'/en/e/7307488/Ellis%2C-Blake-vs-LY%2C-Nam-Hoang',NULL,0,'2017-11-09 22:23:39'),(33851,7312869,6,'2017-11-10','Go Soeda - Stephane Robert','2017-11-10','Go Soeda','Stephane Robert','Go,Robert,Soeda,Stephane',0,'/en/e/7312869/Go-Soeda-vs-Stephane-Robert',NULL,0,'2017-11-09 22:23:39'),(33852,7313621,6,'2017-11-10','Ti Chen - Duldaev, Daniyar','2017-11-10','Ti Chen','Duldaev, Daniyar','Chen,Daniyar,Duldaev,Ti',0,'/en/e/7313621/Ti-Chen-vs-Duldaev%2C-Daniyar',NULL,0,'2017-11-09 22:23:39'),(33853,7313910,6,'2017-11-10','Akira Santillan - Alex Bolt','2017-11-10','Akira Santillan','Alex Bolt','Akira,Alex,Bolt,Santillan',0,'/en/e/7313910/Akira-Santillan-vs-Alex-Bolt',NULL,0,'2017-11-09 22:23:39'),(33854,7315944,6,'2017-11-10','WU, Tung-Lin - Mladenov, Vasil','2017-11-10','WU, Tung-Lin','Mladenov, Vasil','Lin,Mladenov,Tung,Vasil,WU',0,'/en/e/7315944/WU%2C-Tung-Lin-vs-Mladenov%2C-Vasil',NULL,0,'2017-11-09 22:23:39'),(33855,7315948,6,'2017-11-10','Zhang, Yuxuan - Dunne, Katy','2017-11-10','Zhang, Yuxuan','Dunne, Katy','Dunne,Katy,Yuxuan,Zhang',0,'/en/e/7315948/Zhang%2C-Yuxuan-vs-Dunne%2C-Katy',NULL,0,'2017-11-09 22:23:39'),(33856,7315949,6,'2017-11-10','Carol Zhao - Sun, XU Liu','2017-11-10','Carol Zhao','Sun, XU Liu','Carol,Liu,Sun,XU,Zhao',0,'/en/e/7315949/Carol-Zhao-vs-Sun%2C-XU-Liu',NULL,0,'2017-11-09 22:23:39'),(33857,7315951,6,'2017-11-10','Junri Namigata - Mihaela Buzarnescu','2017-11-10','Junri Namigata','Mihaela Buzarnescu','Buzarnescu,Junri,Mihaela,Namigata',0,'/en/e/7315951/Junri-Namigata-vs-Mihaela-Buzarnescu',NULL,0,'2017-11-09 22:23:39'),(33858,7315953,6,'2017-11-10','Kurumi Nara - Brescia, Georgia','2017-11-10','Kurumi Nara','Brescia, Georgia','Brescia,Georgia,Kurumi,Nara',0,'/en/e/7315953/Kurumi-Nara-vs-Brescia%2C-Georgia',NULL,0,'2017-11-09 22:23:39'),(33859,7314717,6,'2017-11-10','Liu, Fangzhou - Jing Jing Lu','2017-11-10','Liu, Fangzhou','Jing Jing Lu','Fangzhou,Jing,Jing,Liu,Lu',0,'/en/e/7314717/Liu%2C-Fangzhou-vs-Jing-Jing-Lu',NULL,0,'2017-11-09 22:23:39'),(33860,7315945,6,'2017-11-10','Noguchi, Rio - Couacaud, Enzo','2017-11-10','Noguchi, Rio','Couacaud, Enzo','Couacaud,Enzo,Noguchi,Rio',0,'/en/e/7315945/Noguchi%2C-Rio-vs-Couacaud%2C-Enzo',NULL,0,'2017-11-09 22:23:39'),(33861,7315950,6,'2017-11-10','Lin Zhu - Shuko Aoyama','2017-11-10','Lin Zhu','Shuko Aoyama','Aoyama,Lin,Shuko,Zhu',0,'/en/e/7315950/Lin-Zhu-vs-Shuko-Aoyama',NULL,0,'2017-11-09 22:23:40'),(33862,7313637,6,'2017-11-10','Calvin Hemery - John Millman','2017-11-10','Calvin Hemery','John Millman','Calvin,Hemery,John,Millman',0,'/en/e/7313637/Calvin-Hemery-vs-John-Millman',NULL,0,'2017-11-09 22:23:40'),(33863,7315257,6,'2017-11-10','Yosuke Watanuki - Soon Woo Kwon','2017-11-10','Yosuke Watanuki','Soon Woo Kwon','Kwon,Soon,Watanuki,Woo,Yosuke',0,'/en/e/7315257/Yosuke-Watanuki-vs-Soon-Woo-Kwon',NULL,0,'2017-11-09 22:23:40'),(33864,7309230,6,'2017-11-10','Jeevan Nedunchezhiyan / Christopher Rungkat - Alex Bolt / Bradley Mousley','2017-11-10','Jeevan Nedunchezhiyan / Christopher Rungkat','Alex Bolt / Bradley Mousley','Alex,Bolt,Bradley,Christopher,Jeevan,Mousley,Nedunchezhiyan,Rungkat',0,'/en/e/7309230/Jeevan-Nedunchezhiyan-%2F-Christopher-Rungkat-vs-Alex-Bolt-%2F-Bradley-Mousley',NULL,0,'2017-11-09 22:23:40'),(33865,7315637,6,'2017-11-10','Ben Mclachlan / Yasutaka Uchiyama - Sanchai Ratiwatana / Sonchat Ratiwatana','2017-11-10','Ben Mclachlan / Yasutaka Uchiyama','Sanchai Ratiwatana / Sonchat Ratiwatana','Ben,Mclachlan,Ratiwatana,Ratiwatana,Sanchai,Sonchat,Uchiyama,Yasutaka',0,'/en/e/7315637/Ben-Mclachlan-%2F-Yasutaka-Uchiyama-vs-Sanchai-Ratiwatana-%2F-Sonchat-Ratiwatana',NULL,0,'2017-11-09 22:23:40'),(33866,7315946,6,'2017-11-10','Thamchaiwat, Bunyawi - Thandi, Karman Kaur','2017-11-10','Thamchaiwat, Bunyawi','Thandi, Karman Kaur','Bunyawi,Karman,Kaur,Thamchaiwat,Thandi',0,'/en/e/7315946/Thamchaiwat%2C-Bunyawi-vs-Thandi%2C-Karman-Kaur',NULL,0,'2017-11-09 22:23:40'),(33867,7315947,6,'2017-11-10','Desai, Zeel - Cristian, Jaqueline Adina','2017-11-10','Desai, Zeel','Cristian, Jaqueline Adina','Adina,Cristian,Desai,Jaqueline,Zeel',0,'/en/e/7315947/Desai%2C-Zeel-vs-Cristian%2C-Jaqueline-Adina',NULL,0,'2017-11-09 22:23:40'),(33868,7309626,6,'2017-11-10','Altmaier, Daniel - Filippo Leonardi','2017-11-10','Altmaier, Daniel','Filippo Leonardi','Altmaier,Daniel,Filippo,Leonardi',0,'/en/e/7309626/Altmaier%2C-Daniel-vs-Filippo-Leonardi',NULL,0,'2017-11-09 22:23:40'),(33869,7315942,6,'2017-11-10','Scott Griekspoor - Maximilian Neuchrist','2017-11-10','Scott Griekspoor','Maximilian Neuchrist','Griekspoor,Maximilian,Neuchrist,Scott',0,'/en/e/7315942/Scott-Griekspoor-vs-Maximilian-Neuchrist',NULL,0,'2017-11-09 22:23:40'),(33870,7315943,6,'2017-11-10','Vanneste, Jeroen - Mitjana, Leny','2017-11-10','Vanneste, Jeroen','Mitjana, Leny','Jeroen,Leny,Mitjana,Vanneste',0,'/en/e/7315943/Vanneste%2C-Jeroen-vs-Mitjana%2C-Leny',NULL,0,'2017-11-09 22:23:40'),(33871,7309624,6,'2017-11-10','Lozan, Cristian - Vidal Azorin, Jose Fco','2017-11-10','Lozan, Cristian','Vidal Azorin, Jose Fco','Azorin,Cristian,Fco,Jose,Lozan,Vidal',0,'/en/e/7309624/Lozan%2C-Cristian-vs-Vidal-Azorin%2C-Jose-Fco',NULL,0,'2017-11-09 22:23:40'),(33872,7315969,6,'2017-11-10','Ying-Ying Duan - Ana Bogdan','2017-11-10','Ying-Ying Duan','Ana Bogdan','Ana,Bogdan,Duan,Ying,Ying',0,'/en/e/7315969/Ying-Ying-Duan-vs-Ana-Bogdan',NULL,0,'2017-11-09 22:23:40'),(33873,7316442,6,'2017-11-10','Luksika Kumkhum - Viktorija Golubic','2017-11-10','Luksika Kumkhum','Viktorija Golubic','Golubic,Kumkhum,Luksika,Viktorija',0,'/en/e/7316442/Luksika-Kumkhum-vs-Viktorija-Golubic',NULL,0,'2017-11-09 22:23:40'),(33874,7315952,6,'2017-11-10','Carolina Meligeni Rodrigues Alves - Meliss, Verena','2017-11-10','Carolina Meligeni Rodrigues Alves','Meliss, Verena','Alves,Carolina,Meligeni,Meliss,Rodrigues,Verena',0,'/en/e/7315952/Carolina-Meligeni-Rodrigues-Alves-vs-Meliss%2C-Verena',NULL,0,'2017-11-09 22:23:40'),(33875,7316532,6,'2017-11-10','Mate Delic - Peter Torebko','2017-11-10','Mate Delic','Peter Torebko','Delic,Mate,Peter,Torebko',0,'/en/e/7316532/Mate-Delic-vs-Peter-Torebko',NULL,0,'2017-11-09 22:23:40'),(33876,7316533,6,'2017-11-10','Wong, Hong Kit - Seyboth Wild, Thiago','2017-11-10','Wong, Hong Kit','Seyboth Wild, Thiago','Hong,Kit,Seyboth,Thiago,Wild,Wong',0,'/en/e/7316533/Wong%2C-Hong-Kit-vs-Seyboth-Wild%2C-Thiago',NULL,0,'2017-11-09 22:23:40'),(33877,7316534,6,'2017-11-10','Diego Hidalgo - Bonadio, Riccardo','2017-11-10','Diego Hidalgo','Bonadio, Riccardo','Bonadio,Diego,Hidalgo,Riccardo',0,'/en/e/7316534/Diego-Hidalgo-vs-Bonadio%2C-Riccardo',NULL,0,'2017-11-09 22:23:40'),(33878,7316542,6,'2017-11-10','Matviyenko, Lisa - Craciun, Georgia Andreea','2017-11-10','Matviyenko, Lisa','Craciun, Georgia Andreea','Andreea,Craciun,Georgia,Lisa,Matviyenko',0,'/en/e/7316542/Matviyenko%2C-Lisa-vs-Craciun%2C-Georgia-Andreea',NULL,0,'2017-11-09 22:23:40'),(33879,7316543,6,'2017-11-10','Paigina, Marta - Nazarkina, Daria','2017-11-10','Paigina, Marta','Nazarkina, Daria','Daria,Marta,Nazarkina,Paigina',0,'/en/e/7316543/Paigina%2C-Marta-vs-Nazarkina%2C-Daria',NULL,0,'2017-11-09 22:23:40'),(33880,7311080,6,'2017-11-10','Chloe Paquet / Pauline Parmentier - Michaella Krajicek / Alla Kudryavtseva','2017-11-10','Chloe Paquet / Pauline Parmentier','Michaella Krajicek / Alla Kudryavtseva','Alla,Chloe,Krajicek,Kudryavtseva,Michaella,Paquet,Parmentier,Pauline',0,'/en/e/7311080/Chloe-Paquet-%2F-Pauline-Parmentier-vs-Michaella-Krajicek-%2F-Alla-Kudryavtseva',NULL,0,'2017-11-09 22:23:41'),(33881,7316540,6,'2017-11-10','Galoppini, Davide - Chepelev, Andrey','2017-11-10','Galoppini, Davide','Chepelev, Andrey','Andrey,Chepelev,Davide,Galoppini',0,'/en/e/7316540/Galoppini%2C-Davide-vs-Chepelev%2C-Andrey',NULL,0,'2017-11-09 22:23:41'),(33882,7316628,6,'2017-11-10','Dia Evtimova - Nicoleta-Catalina Dascalu','2017-11-10','Dia Evtimova','Nicoleta-Catalina Dascalu','Catalina,Dascalu,Dia,Evtimova,Nicoleta',0,'/en/e/7316628/Dia-Evtimova-vs-Nicoleta-Catalina-Dascalu',NULL,0,'2017-11-09 22:23:41'),(33883,7315924,6,'2017-11-10','Belinda Bencic - Vitalia Diatchenko','2017-11-10','Belinda Bencic','Vitalia Diatchenko','Belinda,Bencic,Diatchenko,Vitalia',0,'/en/e/7315924/Belinda-Bencic-vs-Vitalia-Diatchenko',NULL,0,'2017-11-09 22:23:41'),(33884,7316384,6,'2017-11-10','Antonia Lottner - Ekaterina Alexandrova','2017-11-10','Antonia Lottner','Ekaterina Alexandrova','Alexandrova,Antonia,Ekaterina,Lottner',0,'/en/e/7316384/Antonia-Lottner-vs-Ekaterina-Alexandrova',NULL,0,'2017-11-09 22:23:41'),(33885,7316537,6,'2017-11-10','Irina Maria Bara - Kan, Victoria','2017-11-10','Irina Maria Bara','Kan, Victoria','Bara,Irina,Kan,Maria,Victoria',0,'/en/e/7316537/Irina-Maria-Bara-vs-Kan%2C-Victoria',NULL,0,'2017-11-09 22:23:41'),(33886,7317486,6,'2017-11-10','Cristina Adamescu - Federica Arcidiacono','2017-11-10','Cristina Adamescu','Federica Arcidiacono','Adamescu,Arcidiacono,Cristina,Federica',0,'/en/e/7317486/Cristina-Adamescu-vs-Federica-Arcidiacono',NULL,0,'2017-11-09 22:23:41'),(33887,7316032,6,'2017-11-10','Jurgen Zopp - Andreas Seppi','2017-11-10','Jurgen Zopp','Andreas Seppi','Andreas,Jurgen,Seppi,Zopp',0,'/en/e/7316032/Jurgen-Zopp-vs-Andreas-Seppi',NULL,0,'2017-11-09 22:23:41'),(33888,7310990,6,'2017-11-10','Luca Vanni - Alexey Vatutin','2017-11-10','Luca Vanni','Alexey Vatutin','Alexey,Luca,Vanni,Vatutin',0,'/en/e/7310990/Luca-Vanni-vs-Alexey-Vatutin',NULL,0,'2017-11-09 22:23:41'),(33889,7317138,6,'2017-11-10','Sabine Lisicki - Conny Perrin','2017-11-10','Sabine Lisicki','Conny Perrin','Conny,Lisicki,Perrin,Sabine',0,'/en/e/7317138/Sabine-Lisicki-vs-Conny-Perrin',NULL,0,'2017-11-09 22:23:41'),(33890,7309964,6,'2017-11-10','Luksika Kumkhum / Nudnida Luangnam - Monique Adamczak / Naomi Broady','2017-11-10','Luksika Kumkhum / Nudnida Luangnam','Monique Adamczak / Naomi Broady','Adamczak,Broady,Kumkhum,Luangnam,Luksika,Monique,Naomi,Nudnida',0,'/en/e/7309964/Luksika-Kumkhum-%2F-Nudnida-Luangnam-vs-Monique-Adamczak-%2F-Naomi-Broady',NULL,0,'2017-11-09 22:23:41'),(33891,7317223,6,'2017-11-10','Veronika Kudermetova / Ipek Soylu - Ying-Ying Duan / Yafan Wang','2017-11-10','Veronika Kudermetova / Ipek Soylu','Ying-Ying Duan / Yafan Wang','Duan,Ipek,Kudermetova,Soylu,Veronika,Wang,Yafan,Ying,Ying',0,'/en/e/7317223/Veronika-Kudermetova-%2F-Ipek-Soylu-vs-Ying-Ying-Duan-%2F-Yafan-Wang',NULL,0,'2017-11-09 22:23:41'),(33892,7311006,6,'2017-11-10','Nicolas Kicker - Marcelo Arevalo','2017-11-10','Nicolas Kicker','Marcelo Arevalo','Arevalo,Kicker,Marcelo,Nicolas',0,'/en/e/7311006/Nicolas-Kicker-vs-Marcelo-Arevalo',NULL,0,'2017-11-09 22:23:41'),(33893,7311059,6,'2017-11-10','Mikhail Kukushkin - Jerzy Janowicz','2017-11-10','Mikhail Kukushkin','Jerzy Janowicz','Janowicz,Jerzy,Kukushkin,Mikhail',0,'/en/e/7311059/Mikhail-Kukushkin-vs-Jerzy-Janowicz',NULL,0,'2017-11-09 22:23:41'),(33894,7311416,6,'2017-11-10','Gastao Elias - Guido Pella','2017-11-10','Gastao Elias','Guido Pella','Elias,Gastao,Guido,Pella',0,'/en/e/7311416/Gastao-Elias-vs-Guido-Pella',NULL,0,'2017-11-09 22:23:41'),(33895,7311081,6,'2017-11-10','Yannick Maden - Peter Gojowczyk','2017-11-10','Yannick Maden','Peter Gojowczyk','Gojowczyk,Maden,Peter,Yannick',0,'/en/e/7311081/Yannick-Maden-vs-Peter-Gojowczyk',NULL,0,'2017-11-09 22:23:41'),(33896,7317288,6,'2017-11-10','Anna Blinkova - Monica Niculescu','2017-11-10','Anna Blinkova','Monica Niculescu','Anna,Blinkova,Monica,Niculescu',0,'/en/e/7317288/Anna-Blinkova-vs-Monica-Niculescu',NULL,0,'2017-11-09 22:23:42'),(33897,7317602,6,'2017-11-10','Pauline Parmentier - Kaia Kanepi','2017-11-10','Pauline Parmentier','Kaia Kanepi','Kaia,Kanepi,Parmentier,Pauline',0,'/en/e/7317602/Pauline-Parmentier-vs-Kaia-Kanepi',NULL,0,'2017-11-09 22:23:42'),(33898,7316592,6,'2017-11-10','Elias Ymer - Constant Lestienne','2017-11-10','Elias Ymer','Constant Lestienne','Constant,Elias,Lestienne,Ymer',0,'/en/e/7316592/Elias-Ymer-vs-Constant-Lestienne',NULL,0,'2017-11-09 22:23:42'),(33899,7304682,6,'2017-11-10','Valeria Savinykh / Maryna Zanevska - Alexandra Cadantu / Monica Niculescu','2017-11-10','Valeria Savinykh / Maryna Zanevska','Alexandra Cadantu / Monica Niculescu','Alexandra,Cadantu,Maryna,Monica,Niculescu,Savinykh,Valeria,Zanevska',0,'/en/e/7304682/Valeria-Savinykh-%2F-Maryna-Zanevska-vs-Alexandra-Cadantu-%2F-Monica-Niculescu',NULL,0,'2017-11-09 22:23:42'),(33900,7309613,6,'2017-11-12','Henri Kontinen / John Peers - Ryan Harrison / Michael Venus','2017-11-12','Henri Kontinen / John Peers','Ryan Harrison / Michael Venus','Harrison,Henri,John,Kontinen,Michael,Peers,Ryan,Venus',0,'/en/e/7309613/Henri-Kontinen-%2F-John-Peers-vs-Ryan-Harrison-%2F-Michael-Venus',NULL,0,'2017-11-09 22:23:42'),(33901,7309590,6,'2017-11-12','Roger Federer - Jack Sock','2017-11-12','Roger Federer','Jack Sock','Federer,Jack,Roger,Sock',0,'/en/e/7309590/Roger-Federer-vs-Jack-Sock',NULL,0,'2017-11-09 22:23:42'),(33902,7316645,6,'2017-11-12','A - T','2017-11-12','A','T','',0,'/en/e/7316645/ATP-Tour-Finals-Special',NULL,0,'2017-11-09 22:23:42'),(33903,7309621,6,'2017-11-12','Jean-Julien Rojer / Horia Tecau - Pierre-Hugues Herbert / Nicolas Mahut','2017-11-12','Jean-Julien Rojer / Horia Tecau','Pierre-Hugues Herbert / Nicolas Mahut','Herbert,Horia,Hugues,Jean,Julien,Mahut,Nicolas,Pierre,Rojer,Tecau',0,'/en/e/7309621/Jean-Julien-Rojer-%2F-Horia-Tecau-vs-Pierre-Hugues-Herbert-%2F-Nicolas-Mahut',NULL,0,'2017-11-09 22:23:42'),(33904,7309586,6,'2017-11-12','Alexander Zverev - Marin Cilic','2017-11-12','Alexander Zverev','Marin Cilic','Alexander,Cilic,Marin,Zverev',0,'/en/e/7309586/Alexander-Zverev-vs-Marin-Cilic',NULL,0,'2017-11-09 22:23:42'),(33905,7309622,6,'2017-11-13','Jamie Murray / Bruno Soares - Bob Bryan / Mike Bryan','2017-11-13','Jamie Murray / Bruno Soares','Bob Bryan / Mike Bryan','Bob,Bruno,Bryan,Bryan,Jamie,Mike,Murray,Soares',0,'/en/e/7309622/Jamie-Murray-%2F-Bruno-Soares-vs-Bob-Bryan-%2F-Mike-Bryan',NULL,0,'2017-11-09 22:23:42'),(33906,7309594,6,'2017-11-13','Dominic Thiem - Grigor Dimitrov','2017-11-13','Dominic Thiem','Grigor Dimitrov','Dimitrov,Dominic,Grigor,Thiem',0,'/en/e/7309594/Dominic-Thiem-vs-Grigor-Dimitrov',NULL,0,'2017-11-09 22:23:42'),(33907,7309619,6,'2017-11-13','Lukasz Kubot / Marcelo Melo - Ivan Dodig / Marcel Granollers','2017-11-13','Lukasz Kubot / Marcelo Melo','Ivan Dodig / Marcel Granollers','Dodig,Granollers,Ivan,Kubot,Lukasz,Marcel,Marcelo,Melo',0,'/en/e/7309619/Lukasz-Kubot-%2F-Marcelo-Melo-vs-Ivan-Dodig-%2F-Marcel-Granollers',NULL,0,'2017-11-09 22:23:42'),(33908,7309588,6,'2017-11-13','Rafael Nadal - David Goffin','2017-11-13','Rafael Nadal','David Goffin','David,Goffin,Nadal,Rafael',0,'/en/e/7309588/Rafael-Nadal-vs-David-Goffin',NULL,0,'2017-11-09 22:23:42');
/*!40000 ALTER TABLE `competition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events_on_demand`
--

DROP TABLE IF EXISTS `events_on_demand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events_on_demand` (
  `betway_event_id` int DEFAULT NULL,
  `unibet_event_id` int DEFAULT NULL,
  `bwin_event_id` int DEFAULT NULL,
  `live` tinyint DEFAULT NULL,
  `active` tinyint DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `sortname` varchar(255) DEFAULT NULL,
  `ladbrokes_event_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `betway_event_id_UNIQUE` (`betway_event_id`),
  UNIQUE KEY `unibet_event_id_UNIQUE` (`unibet_event_id`),
  UNIQUE KEY `bwin_event_id_UNIQUE` (`bwin_event_id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events_on_demand`
--

LOCK TABLES `events_on_demand` WRITE;
/*!40000 ALTER TABLE `events_on_demand` DISABLE KEYS */;
INSERT INTO `events_on_demand` VALUES (NULL,1004136628,NULL,NULL,NULL,1,'Frances,Lorenzi,Paolo,Tiafoe',NULL),(NULL,1004136632,NULL,NULL,NULL,2,'Chung,Feliciano,Hyeon,Lopez',6664363),(NULL,1004144068,NULL,NULL,NULL,3,'Basilashvili,Ernesto,Escobedo,Nikoloz',6690013),(NULL,1004140294,NULL,NULL,NULL,4,'Bouchard,Donna,Eugenie,Vekic',6677634),(NULL,1004136650,NULL,NULL,NULL,5,'Ekaterina,Makarova,Peng,Shuai',6664629),(NULL,1004140307,NULL,NULL,NULL,6,'Millot,Querrey,Sam,Vincent',6681732),(NULL,1004138713,NULL,NULL,NULL,7,'Dennis,Gleb,Novikov,Sakharov',6671061),(NULL,1004136642,NULL,NULL,NULL,8,'Agnieszka,Coco,Radwanska,Vandeweghe',6664636),(NULL,1004136800,NULL,NULL,NULL,9,'David,Goffin,Sugita,Yuichi',6664381),(NULL,1004138720,NULL,NULL,NULL,10,'Henri,Laaksonen,Ramanathan,Ramkumar',6671059),(NULL,1004140051,NULL,NULL,NULL,11,'Groenefeld,Hibino,Peschke,Rosolska',NULL),(NULL,1004140466,NULL,NULL,NULL,12,'Frederik,Nielsen,Sandgren,Tennys',6678369),(NULL,1004136656,NULL,NULL,NULL,13,'Alizé,Anastasia,Cornet,Pavlyuchenkova',6664633),(NULL,1004136768,NULL,NULL,NULL,14,'Busta,Carreno,Karen,Khachanov,Pablo',6664362),(NULL,1004139408,NULL,NULL,NULL,15,'Denis,Dutra,Rogerio,Shapovalov,Silva',6669786),(NULL,1004139310,NULL,NULL,NULL,16,'Del,Dimitrov,Harrison,Potro,Venus',NULL),(NULL,1004140193,NULL,NULL,NULL,17,'Barty,Dellacqua,Goerges,Savchuk',NULL),(NULL,1004138718,NULL,NULL,NULL,18,'Gabashvili,Kukushkin,Mikhail,Teymuraz',6671052),(NULL,1004138722,NULL,NULL,NULL,19,'Alexander,Bublik,Krueger,Mitchell',6671055),(NULL,1004138597,NULL,NULL,NULL,20,'Agut,Bautista,Ferrer,Nestor,Pospisil',NULL),(NULL,1004138596,NULL,NULL,NULL,21,'Lopez,Lopez,Pouille,Tsonga',NULL),(NULL,1004138724,NULL,NULL,NULL,22,'Cameron,Jason,Jung,Norrie',6671057),(NULL,1004140056,NULL,NULL,NULL,23,'Chia,Chuang,Hradecka,Jung,Siniakova,Voracova',NULL),(NULL,1004140310,NULL,NULL,NULL,24,'Anderson,Dudi,Kevin,Sela',6677419),(NULL,1004138591,NULL,NULL,NULL,25,'Johnson,Lorenzi,Querrey,Ramos,Vinolas',NULL),(NULL,1004144074,NULL,NULL,NULL,26,'Davis,Millette,Riske,Robillard,Zhao',NULL),(NULL,1004138715,NULL,NULL,NULL,27,'Noah,Raymond,Rubin,Sarmiento',6671050),(NULL,1004138589,NULL,NULL,NULL,28,'Gonzalez,Rojer,Tecau,Young',NULL),(NULL,1004138717,NULL,NULL,NULL,29,'De,John,Joris,Lamble,Loore',6671047),(NULL,1004138721,NULL,NULL,NULL,30,'Fritz,Konstantin,Kravchuk,Taylor',NULL),(NULL,1004139311,NULL,NULL,NULL,31,'Busta,Cabal,Carreno,Mektic,Qureshi',NULL),(NULL,1004142033,NULL,NULL,NULL,32,'Daria,Elina,Kasatkina,Svitolina',6683710),(NULL,1004141998,NULL,NULL,NULL,33,'Barbora,Daria,Gavrilova,Strycova',NULL),(NULL,1004142227,NULL,NULL,NULL,34,'Benoit,Donaldson,Jared,Paire',NULL),(NULL,1004140311,NULL,NULL,NULL,35,'Herbert,Hugues,Jack,Pierre,Sock',NULL),(NULL,1004136652,NULL,NULL,NULL,36,'Andreescu,Babos,Bianca,Timea,Vanessa',NULL),(NULL,1004138714,NULL,NULL,NULL,37,'John,Mackenzie,McDonald,Millman',NULL),(NULL,1004138594,NULL,NULL,NULL,38,'Dancevic,Martin,Roger,Shamasdin,Vasselin',NULL),(NULL,1004142309,NULL,NULL,NULL,39,'Diego,Dominic,Schwartzman,Sebastian,Thiem',NULL),(NULL,1004142091,NULL,NULL,NULL,40,'Alexandrova,Caroline,Ekaterina,Wozniacki',NULL),(NULL,1004138723,NULL,NULL,NULL,41,'Casper,Halys,Quentin,Ruud',NULL),(NULL,1004142041,NULL,NULL,NULL,42,'Flipkens,Garbiñe,Kirsten,Muguruza',NULL),(NULL,1004142285,NULL,NULL,NULL,43,'Chan,Hingis,Jan,Klepac,Martinez,Sanchez,Yung',NULL),(NULL,1004142284,NULL,NULL,NULL,44,'Krejcikova,Niculescu,Safarova,Strycova',NULL),(NULL,1004142493,NULL,NULL,NULL,45,'Katerina,Siniakova,Venus,Williams',NULL),(NULL,1004142218,NULL,NULL,NULL,46,'Anastasija,Naomi,Osaka,Sevastova',NULL),(NULL,1004140046,NULL,NULL,NULL,47,'Andreescu,Branstine,Mladenovic,Pavlyuchenkova',NULL),(NULL,1004140197,NULL,NULL,NULL,48,'Kichenok,Melichar,Spears,Srebotnik',NULL),(NULL,1004142374,NULL,NULL,NULL,49,'Kvitova,Petra,Sloane,Stephens',NULL),(NULL,1004142502,NULL,NULL,NULL,50,'Cibulkova,Dominika,Lucie,Safarova',NULL),(NULL,1004142163,NULL,NULL,NULL,51,'Dimitrov,Grigor,Mischa,Zverev',NULL),(NULL,1004142449,NULL,NULL,NULL,52,'Adrian,Mannarino,Milos,Raonic',NULL),(NULL,1004142450,NULL,NULL,NULL,53,'Alexander,Gasquet,Richard,Zverev',NULL),(NULL,1004142308,NULL,NULL,NULL,54,'Bopanna,Dodig,Khachanov,Thiem',NULL),(NULL,1004142228,NULL,NULL,NULL,55,'Gael,Kei,Monfils,Nishikori',NULL),(NULL,1004142486,NULL,NULL,NULL,56,'Agut,Bautista,Harrison,Roberto,Ryan',NULL),(NULL,1004142467,NULL,NULL,NULL,57,'Federer,Peter,Polansky,Roger',NULL),(NULL,1004142312,NULL,NULL,NULL,58,'Akira,Darian,King,Santillan',NULL);
/*!40000 ALTER TABLE `events_on_demand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market`
--

DROP TABLE IF EXISTS `market`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `market` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bookmaker_market` bigint NOT NULL,
  `competition_id` int NOT NULL,
  `market_name` varchar(255) DEFAULT NULL,
  `live` tinyint DEFAULT '0',
  `prematch` tinyint DEFAULT '0',
  `closed` datetime DEFAULT NULL,
  `market_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `market_competition_id` (`competition_id`),
  KEY `bookmaker_market_id` (`bookmaker_market`),
  CONSTRAINT `market_ibfk_1` FOREIGN KEY (`competition_id`) REFERENCES `competition` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1460422 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market`
--

LOCK TABLES `market` WRITE;
/*!40000 ALTER TABLE `market` DISABLE KEYS */;
INSERT INTO `market` VALUES (1460415,35972836,33661,'Match Betting',1,0,NULL,'2017-08-08 22:09:36'),(1460416,36162829,33661,'Set 2 - Game 9 Winner',1,0,NULL,'2017-08-08 22:09:36'),(1460417,36163320,33661,'Set 2 - Game 10 Winner',1,0,NULL,'2017-08-08 22:09:36'),(1460418,35972877,33661,'Set Betting',1,0,NULL,'2017-08-08 22:09:36'),(1460419,35972858,33661,'Set 2 Result',1,0,NULL,'2017-08-08 22:09:36'),(1460420,35972852,33661,'Set 2 Game 10 Deuce',1,0,NULL,'2017-08-08 22:09:36'),(1460421,35972861,33661,'Set 2 Game 9 Deuce',1,0,NULL,'2017-08-08 22:09:36');
/*!40000 ALTER TABLE `market` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `odds`
--

DROP TABLE IF EXISTS `odds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `odds` (
  `id` int NOT NULL AUTO_INCREMENT,
  `odds` decimal(10,5) DEFAULT NULL,
  `odds_timestamp` datetime NOT NULL,
  `outcome_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `odds_outcome_id` (`outcome_id`),
  KEY `time_idx` (`odds_timestamp`),
  CONSTRAINT `odds_ibfk_1` FOREIGN KEY (`outcome_id`) REFERENCES `outcome` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=357 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `odds`
--

LOCK TABLES `odds` WRITE;
/*!40000 ALTER TABLE `odds` DISABLE KEYS */;
INSERT INTO `odds` VALUES (12,2.20000,'2017-08-08 22:09:36',3996900),(13,1.61500,'2017-08-08 22:09:36',3996901),(14,2.25000,'2017-08-08 22:09:37',3996902),(15,1.57100,'2017-08-08 22:09:37',3996903),(16,1.61500,'2017-08-08 22:09:37',3996904),(17,2.20000,'2017-08-08 22:09:37',3996905),(18,6.00000,'2017-08-08 22:09:37',3996906),(19,2.20000,'2017-08-08 22:09:37',3996907),(20,2.10000,'2017-08-08 22:09:37',3996908),(21,1.12500,'2017-08-08 22:09:37',3996909),(22,6.00000,'2017-08-08 22:09:37',3996910),(23,0.00000,'2017-08-08 22:09:37',3996911),(24,0.00000,'2017-08-08 22:09:37',3996912),(25,3.00000,'2017-08-08 22:09:37',3996913),(26,1.36300,'2017-08-08 22:09:37',3996914),(27,2.20000,'2017-08-08 22:09:38',3996900),(28,1.61500,'2017-08-08 22:09:38',3996901),(29,2.25000,'2017-08-08 22:09:38',3996902),(30,1.57100,'2017-08-08 22:09:38',3996903),(31,1.61500,'2017-08-08 22:09:38',3996904),(32,2.20000,'2017-08-08 22:09:38',3996905),(33,6.00000,'2017-08-08 22:09:38',3996906),(34,2.20000,'2017-08-08 22:09:38',3996907),(35,2.10000,'2017-08-08 22:09:38',3996908),(36,1.12500,'2017-08-08 22:09:38',3996909),(37,6.00000,'2017-08-08 22:09:38',3996910),(38,0.00000,'2017-08-08 22:09:38',3996911),(39,0.00000,'2017-08-08 22:09:38',3996912),(40,3.00000,'2017-08-08 22:09:38',3996913),(41,1.36300,'2017-08-08 22:09:38',3996914),(42,2.20000,'2017-08-08 22:09:41',3996900),(43,1.61500,'2017-08-08 22:09:41',3996901),(44,2.25000,'2017-08-08 22:09:41',3996902),(45,1.57100,'2017-08-08 22:09:41',3996903),(46,1.61500,'2017-08-08 22:09:41',3996904),(47,2.20000,'2017-08-08 22:09:41',3996905),(48,6.00000,'2017-08-08 22:09:41',3996906),(49,2.20000,'2017-08-08 22:09:41',3996907),(50,2.10000,'2017-08-08 22:09:41',3996908),(51,1.12500,'2017-08-08 22:09:41',3996909),(52,6.00000,'2017-08-08 22:09:41',3996910),(53,0.00000,'2017-08-08 22:09:41',3996911),(54,0.00000,'2017-08-08 22:09:41',3996912),(55,3.00000,'2017-08-08 22:09:41',3996913),(56,1.36300,'2017-08-08 22:09:41',3996914),(57,2.20000,'2017-08-08 22:09:42',3996900),(58,1.61500,'2017-08-08 22:09:42',3996901),(59,2.25000,'2017-08-08 22:09:42',3996902),(60,1.57100,'2017-08-08 22:09:42',3996903),(61,1.61500,'2017-08-08 22:09:42',3996904),(62,2.20000,'2017-08-08 22:09:42',3996905),(63,6.00000,'2017-08-08 22:09:42',3996906),(64,2.20000,'2017-08-08 22:09:42',3996907),(65,2.10000,'2017-08-08 22:09:42',3996908),(66,1.12500,'2017-08-08 22:09:42',3996909),(67,6.00000,'2017-08-08 22:09:42',3996910),(68,0.00000,'2017-08-08 22:09:42',3996911),(69,0.00000,'2017-08-08 22:09:42',3996912),(70,3.00000,'2017-08-08 22:09:42',3996913),(71,1.36300,'2017-08-08 22:09:42',3996914),(72,2.20000,'2017-08-08 22:09:45',3996900),(73,1.61500,'2017-08-08 22:09:45',3996901),(74,2.25000,'2017-08-08 22:09:45',3996902),(75,1.57100,'2017-08-08 22:09:45',3996903),(76,1.61500,'2017-08-08 22:09:45',3996904),(77,2.20000,'2017-08-08 22:09:45',3996905),(78,6.00000,'2017-08-08 22:09:45',3996906),(79,2.20000,'2017-08-08 22:09:45',3996907),(80,2.10000,'2017-08-08 22:09:45',3996908),(81,1.12500,'2017-08-08 22:09:45',3996909),(82,6.00000,'2017-08-08 22:09:45',3996910),(83,0.00000,'2017-08-08 22:09:45',3996911),(84,0.00000,'2017-08-08 22:09:45',3996912),(85,3.00000,'2017-08-08 22:09:45',3996913),(86,1.36300,'2017-08-08 22:09:45',3996914),(87,2.20000,'2017-08-08 22:09:48',3996900),(88,1.61500,'2017-08-08 22:09:48',3996901),(89,2.25000,'2017-08-08 22:09:48',3996902),(90,1.57100,'2017-08-08 22:09:48',3996903),(91,1.61500,'2017-08-08 22:09:48',3996904),(92,2.20000,'2017-08-08 22:09:48',3996905),(93,6.00000,'2017-08-08 22:09:48',3996906),(94,2.20000,'2017-08-08 22:09:48',3996907),(95,2.10000,'2017-08-08 22:09:48',3996908),(96,1.12500,'2017-08-08 22:09:48',3996909),(97,6.00000,'2017-08-08 22:09:48',3996910),(98,0.00000,'2017-08-08 22:09:48',3996911),(99,0.00000,'2017-08-08 22:09:48',3996912),(100,3.00000,'2017-08-08 22:09:48',3996913),(101,1.36300,'2017-08-08 22:09:48',3996914),(102,2.20000,'2017-08-08 22:09:52',3996900),(103,1.61500,'2017-08-08 22:09:52',3996901),(104,2.25000,'2017-08-08 22:09:52',3996902),(105,1.57100,'2017-08-08 22:09:52',3996903),(106,1.61500,'2017-08-08 22:09:52',3996904),(107,2.20000,'2017-08-08 22:09:52',3996905),(108,6.00000,'2017-08-08 22:09:52',3996906),(109,2.20000,'2017-08-08 22:09:52',3996907),(110,2.10000,'2017-08-08 22:09:52',3996908),(111,1.12500,'2017-08-08 22:09:52',3996909),(112,6.00000,'2017-08-08 22:09:52',3996910),(113,0.00000,'2017-08-08 22:09:52',3996911),(114,0.00000,'2017-08-08 22:09:52',3996912),(115,3.00000,'2017-08-08 22:09:52',3996913),(116,1.36300,'2017-08-08 22:09:52',3996914),(117,2.20000,'2017-08-08 22:09:53',3996900),(118,1.61500,'2017-08-08 22:09:53',3996901),(119,2.25000,'2017-08-08 22:09:53',3996902),(120,1.57100,'2017-08-08 22:09:53',3996903),(121,1.61500,'2017-08-08 22:09:53',3996904),(122,2.20000,'2017-08-08 22:09:53',3996905),(123,6.00000,'2017-08-08 22:09:53',3996906),(124,2.20000,'2017-08-08 22:09:53',3996907),(125,2.10000,'2017-08-08 22:09:53',3996908),(126,1.12500,'2017-08-08 22:09:53',3996909),(127,6.00000,'2017-08-08 22:09:53',3996910),(128,0.00000,'2017-08-08 22:09:53',3996911),(129,0.00000,'2017-08-08 22:09:53',3996912),(130,3.00000,'2017-08-08 22:09:53',3996913),(131,1.36300,'2017-08-08 22:09:53',3996914),(132,2.20000,'2017-08-08 22:10:06',3996900),(133,1.61500,'2017-08-08 22:10:06',3996901),(134,2.25000,'2017-08-08 22:10:06',3996902),(135,1.57100,'2017-08-08 22:10:06',3996903),(136,1.61500,'2017-08-08 22:10:06',3996904),(137,2.20000,'2017-08-08 22:10:06',3996905),(138,6.00000,'2017-08-08 22:10:06',3996906),(139,2.20000,'2017-08-08 22:10:06',3996907),(140,2.10000,'2017-08-08 22:10:06',3996908),(141,1.12500,'2017-08-08 22:10:06',3996909),(142,6.00000,'2017-08-08 22:10:06',3996910),(143,0.00000,'2017-08-08 22:10:06',3996911),(144,0.00000,'2017-08-08 22:10:06',3996912),(145,3.00000,'2017-08-08 22:10:06',3996913),(146,1.36300,'2017-08-08 22:10:06',3996914),(147,2.20000,'2017-08-08 22:10:08',3996900),(148,1.61500,'2017-08-08 22:10:08',3996901),(149,2.25000,'2017-08-08 22:10:08',3996902),(150,1.57100,'2017-08-08 22:10:08',3996903),(151,1.61500,'2017-08-08 22:10:08',3996904),(152,2.20000,'2017-08-08 22:10:08',3996905),(153,6.00000,'2017-08-08 22:10:08',3996906),(154,2.20000,'2017-08-08 22:10:08',3996907),(155,2.10000,'2017-08-08 22:10:09',3996908),(156,1.12500,'2017-08-08 22:10:09',3996909),(157,6.00000,'2017-08-08 22:10:09',3996910),(158,0.00000,'2017-08-08 22:10:09',3996911),(159,0.00000,'2017-08-08 22:10:09',3996912),(160,3.00000,'2017-08-08 22:10:09',3996913),(161,1.36300,'2017-08-08 22:10:09',3996914),(162,2.20000,'2017-08-08 22:10:10',3996900),(163,1.61500,'2017-08-08 22:10:10',3996901),(164,2.25000,'2017-08-08 22:10:10',3996902),(165,1.57100,'2017-08-08 22:10:10',3996903),(166,1.61500,'2017-08-08 22:10:10',3996904),(167,2.20000,'2017-08-08 22:10:10',3996905),(168,6.00000,'2017-08-08 22:10:10',3996906),(169,2.20000,'2017-08-08 22:10:10',3996907),(170,2.10000,'2017-08-08 22:10:10',3996908),(171,1.12500,'2017-08-08 22:10:10',3996909),(172,6.00000,'2017-08-08 22:10:10',3996910),(173,0.00000,'2017-08-08 22:10:10',3996911),(174,0.00000,'2017-08-08 22:10:10',3996912),(175,3.00000,'2017-08-08 22:10:10',3996913),(176,1.36300,'2017-08-08 22:10:10',3996914),(177,2.20000,'2017-08-08 22:10:13',3996900),(178,1.61500,'2017-08-08 22:10:13',3996901),(179,2.25000,'2017-08-08 22:10:13',3996902),(180,1.57100,'2017-08-08 22:10:13',3996903),(181,1.61500,'2017-08-08 22:10:13',3996904),(182,2.20000,'2017-08-08 22:10:13',3996905),(183,6.00000,'2017-08-08 22:10:13',3996906),(184,2.20000,'2017-08-08 22:10:13',3996907),(185,2.10000,'2017-08-08 22:10:13',3996908),(186,1.12500,'2017-08-08 22:10:13',3996909),(187,6.00000,'2017-08-08 22:10:13',3996910),(188,0.00000,'2017-08-08 22:10:13',3996911),(189,0.00000,'2017-08-08 22:10:13',3996912),(190,3.00000,'2017-08-08 22:10:13',3996913),(191,1.36300,'2017-08-08 22:10:13',3996914),(192,2.20000,'2017-08-08 22:10:16',3996900),(193,1.61500,'2017-08-08 22:10:16',3996901),(194,2.25000,'2017-08-08 22:10:16',3996902),(195,1.57100,'2017-08-08 22:10:16',3996903),(196,1.61500,'2017-08-08 22:10:16',3996904),(197,2.20000,'2017-08-08 22:10:16',3996905),(198,6.00000,'2017-08-08 22:10:16',3996906),(199,2.20000,'2017-08-08 22:10:16',3996907),(200,2.10000,'2017-08-08 22:10:16',3996908),(201,1.12500,'2017-08-08 22:10:16',3996909),(202,6.00000,'2017-08-08 22:10:16',3996910),(203,0.00000,'2017-08-08 22:10:16',3996911),(204,0.00000,'2017-08-08 22:10:16',3996912),(205,3.00000,'2017-08-08 22:10:16',3996913),(206,1.36300,'2017-08-08 22:10:16',3996914),(207,2.20000,'2017-08-08 22:10:18',3996900),(208,1.61500,'2017-08-08 22:10:18',3996901),(209,2.25000,'2017-08-08 22:10:18',3996902),(210,1.57100,'2017-08-08 22:10:19',3996903),(211,1.61500,'2017-08-08 22:10:19',3996904),(212,2.20000,'2017-08-08 22:10:19',3996905),(213,6.00000,'2017-08-08 22:10:19',3996906),(214,2.20000,'2017-08-08 22:10:19',3996907),(215,2.10000,'2017-08-08 22:10:19',3996908),(216,1.12500,'2017-08-08 22:10:19',3996909),(217,6.00000,'2017-08-08 22:10:19',3996910),(218,0.00000,'2017-08-08 22:10:19',3996911),(219,0.00000,'2017-08-08 22:10:19',3996912),(220,3.00000,'2017-08-08 22:10:19',3996913),(221,1.36300,'2017-08-08 22:10:19',3996914),(222,2.20000,'2017-08-08 22:10:21',3996900),(223,1.61500,'2017-08-08 22:10:21',3996901),(224,2.25000,'2017-08-08 22:10:21',3996902),(225,1.57100,'2017-08-08 22:10:22',3996903),(226,1.61500,'2017-08-08 22:10:22',3996904),(227,2.20000,'2017-08-08 22:10:22',3996905),(228,6.00000,'2017-08-08 22:10:22',3996906),(229,2.20000,'2017-08-08 22:10:22',3996907),(230,2.10000,'2017-08-08 22:10:22',3996908),(231,1.12500,'2017-08-08 22:10:22',3996909),(232,6.00000,'2017-08-08 22:10:22',3996910),(233,0.00000,'2017-08-08 22:10:22',3996911),(234,0.00000,'2017-08-08 22:10:22',3996912),(235,3.00000,'2017-08-08 22:10:22',3996913),(236,1.36300,'2017-08-08 22:10:22',3996914),(237,2.20000,'2017-08-08 22:10:24',3996900),(238,1.61500,'2017-08-08 22:10:24',3996901),(239,2.25000,'2017-08-08 22:10:24',3996902),(240,1.57100,'2017-08-08 22:10:24',3996903),(241,1.61500,'2017-08-08 22:10:24',3996904),(242,2.20000,'2017-08-08 22:10:24',3996905),(243,6.00000,'2017-08-08 22:10:24',3996906),(244,2.20000,'2017-08-08 22:10:24',3996907),(245,2.10000,'2017-08-08 22:10:24',3996908),(246,1.12500,'2017-08-08 22:10:24',3996909),(247,6.00000,'2017-08-08 22:10:24',3996910),(248,0.00000,'2017-08-08 22:10:24',3996911),(249,0.00000,'2017-08-08 22:10:24',3996912),(250,3.00000,'2017-08-08 22:10:24',3996913),(251,1.36300,'2017-08-08 22:10:24',3996914),(252,2.20000,'2017-08-08 22:10:26',3996900),(253,1.61500,'2017-08-08 22:10:26',3996901),(254,2.25000,'2017-08-08 22:10:26',3996902),(255,1.57100,'2017-08-08 22:10:26',3996903),(256,1.61500,'2017-08-08 22:10:26',3996904),(257,2.20000,'2017-08-08 22:10:26',3996905),(258,6.00000,'2017-08-08 22:10:26',3996906),(259,2.20000,'2017-08-08 22:10:26',3996907),(260,2.10000,'2017-08-08 22:10:26',3996908),(261,1.12500,'2017-08-08 22:10:26',3996909),(262,6.00000,'2017-08-08 22:10:26',3996910),(263,0.00000,'2017-08-08 22:10:26',3996911),(264,0.00000,'2017-08-08 22:10:26',3996912),(265,3.00000,'2017-08-08 22:10:26',3996913),(266,1.36300,'2017-08-08 22:10:26',3996914),(267,2.20000,'2017-08-08 22:10:29',3996900),(268,1.61500,'2017-08-08 22:10:29',3996901),(269,2.25000,'2017-08-08 22:10:29',3996902),(270,1.57100,'2017-08-08 22:10:29',3996903),(271,1.61500,'2017-08-08 22:10:29',3996904),(272,2.20000,'2017-08-08 22:10:29',3996905),(273,6.00000,'2017-08-08 22:10:29',3996906),(274,2.20000,'2017-08-08 22:10:29',3996907),(275,2.10000,'2017-08-08 22:10:29',3996908),(276,1.12500,'2017-08-08 22:10:29',3996909),(277,6.00000,'2017-08-08 22:10:29',3996910),(278,0.00000,'2017-08-08 22:10:29',3996911),(279,0.00000,'2017-08-08 22:10:29',3996912),(280,3.00000,'2017-08-08 22:10:29',3996913),(281,1.36300,'2017-08-08 22:10:29',3996914),(282,2.20000,'2017-08-08 22:10:30',3996900),(283,1.61500,'2017-08-08 22:10:30',3996901),(284,2.25000,'2017-08-08 22:10:30',3996902),(285,1.57100,'2017-08-08 22:10:30',3996903),(286,1.61500,'2017-08-08 22:10:30',3996904),(287,2.20000,'2017-08-08 22:10:30',3996905),(288,6.00000,'2017-08-08 22:10:30',3996906),(289,2.20000,'2017-08-08 22:10:30',3996907),(290,2.10000,'2017-08-08 22:10:30',3996908),(291,1.12500,'2017-08-08 22:10:30',3996909),(292,6.00000,'2017-08-08 22:10:30',3996910),(293,0.00000,'2017-08-08 22:10:30',3996911),(294,0.00000,'2017-08-08 22:10:30',3996912),(295,3.00000,'2017-08-08 22:10:30',3996913),(296,1.36300,'2017-08-08 22:10:30',3996914),(297,2.20000,'2017-08-08 22:10:32',3996900),(298,1.61500,'2017-08-08 22:10:32',3996901),(299,2.25000,'2017-08-08 22:10:32',3996902),(300,1.57100,'2017-08-08 22:10:32',3996903),(301,1.61500,'2017-08-08 22:10:33',3996904),(302,2.20000,'2017-08-08 22:10:33',3996905),(303,6.00000,'2017-08-08 22:10:33',3996906),(304,2.20000,'2017-08-08 22:10:33',3996907),(305,2.10000,'2017-08-08 22:10:33',3996908),(306,1.12500,'2017-08-08 22:10:33',3996909),(307,6.00000,'2017-08-08 22:10:33',3996910),(308,0.00000,'2017-08-08 22:10:33',3996911),(309,0.00000,'2017-08-08 22:10:33',3996912),(310,3.00000,'2017-08-08 22:10:33',3996913),(311,1.36300,'2017-08-08 22:10:33',3996914),(312,2.20000,'2017-08-08 22:10:35',3996900),(313,1.61500,'2017-08-08 22:10:35',3996901),(314,2.25000,'2017-08-08 22:10:35',3996902),(315,1.57100,'2017-08-08 22:10:35',3996903),(316,1.61500,'2017-08-08 22:10:35',3996904),(317,2.20000,'2017-08-08 22:10:35',3996905),(318,6.00000,'2017-08-08 22:10:35',3996906),(319,2.20000,'2017-08-08 22:10:35',3996907),(320,2.10000,'2017-08-08 22:10:35',3996908),(321,1.12500,'2017-08-08 22:10:35',3996909),(322,6.00000,'2017-08-08 22:10:35',3996910),(323,0.00000,'2017-08-08 22:10:35',3996911),(324,0.00000,'2017-08-08 22:10:35',3996912),(325,3.00000,'2017-08-08 22:10:35',3996913),(326,1.36300,'2017-08-08 22:10:35',3996914),(327,2.20000,'2017-08-08 22:10:37',3996900),(328,1.61500,'2017-08-08 22:10:37',3996901),(329,2.25000,'2017-08-08 22:10:37',3996902),(330,1.57100,'2017-08-08 22:10:37',3996903),(331,1.61500,'2017-08-08 22:10:37',3996904),(332,2.20000,'2017-08-08 22:10:37',3996905),(333,6.00000,'2017-08-08 22:10:37',3996906),(334,2.20000,'2017-08-08 22:10:37',3996907),(335,2.10000,'2017-08-08 22:10:37',3996908),(336,1.12500,'2017-08-08 22:10:37',3996909),(337,6.00000,'2017-08-08 22:10:37',3996910),(338,0.00000,'2017-08-08 22:10:37',3996911),(339,0.00000,'2017-08-08 22:10:37',3996912),(340,3.00000,'2017-08-08 22:10:37',3996913),(341,1.36300,'2017-08-08 22:10:37',3996914),(342,2.20000,'2017-08-08 22:10:40',3996900),(343,1.61500,'2017-08-08 22:10:40',3996901),(344,2.25000,'2017-08-08 22:10:40',3996902),(345,1.57100,'2017-08-08 22:10:40',3996903),(346,1.61500,'2017-08-08 22:10:40',3996904),(347,2.20000,'2017-08-08 22:10:40',3996905),(348,6.00000,'2017-08-08 22:10:40',3996906),(349,2.20000,'2017-08-08 22:10:40',3996907),(350,2.10000,'2017-08-08 22:10:40',3996908),(351,1.12500,'2017-08-08 22:10:40',3996909),(352,6.00000,'2017-08-08 22:10:40',3996910),(353,0.00000,'2017-08-08 22:10:40',3996911),(354,0.00000,'2017-08-08 22:10:40',3996912),(355,3.00000,'2017-08-08 22:10:40',3996913),(356,1.36300,'2017-08-08 22:10:40',3996914);
/*!40000 ALTER TABLE `odds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `outcome`
--

DROP TABLE IF EXISTS `outcome`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `outcome` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bookmaker_outcome` bigint NOT NULL,
  `last_odds` decimal(10,5) DEFAULT NULL,
  `market_id` int NOT NULL,
  `outcome_name` varchar(255) DEFAULT NULL,
  `_update_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `outcome_market_id` (`market_id`),
  KEY `bookmaker_outcome_idx` (`bookmaker_outcome`),
  CONSTRAINT `outcome_ibfk_1` FOREIGN KEY (`market_id`) REFERENCES `market` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3996915 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `outcome`
--

LOCK TABLES `outcome` WRITE;
/*!40000 ALTER TABLE `outcome` DISABLE KEYS */;
INSERT INTO `outcome` VALUES (3996900,176883753,2.20000,1460415,'Kruijer, Nina','2017-08-08 19:10:40'),(3996901,176883752,1.61500,1460415,'Oana Georgeta Simion','2017-08-08 19:10:40'),(3996902,177515028,2.25000,1460416,'Kruijer, Nina','2017-08-08 19:10:40'),(3996903,177515029,1.57100,1460416,'Oana Georgeta Simion','2017-08-08 19:10:40'),(3996904,177516169,1.61500,1460417,'Kruijer, Nina','2017-08-08 19:10:40'),(3996905,177516168,2.20000,1460417,'Oana Georgeta Simion','2017-08-08 19:10:40'),(3996906,176883836,6.00000,1460418,NULL,'2017-08-08 19:10:40'),(3996907,176883839,2.20000,1460418,NULL,'2017-08-08 19:10:40'),(3996908,176883837,2.10000,1460418,NULL,'2017-08-08 19:10:40'),(3996909,176883799,1.12500,1460419,'Kruijer, Nina','2017-08-08 19:10:40'),(3996910,176883798,6.00000,1460419,'Oana Georgeta Simion','2017-08-08 19:10:40'),(3996911,176883786,0.00000,1460420,'Yes','2017-08-08 19:10:40'),(3996912,176883787,0.00000,1460420,'No','2017-08-08 19:10:40'),(3996913,176883805,3.00000,1460421,'Yes','2017-08-08 19:10:40'),(3996914,176883804,1.36300,1460421,'No','2017-08-08 19:10:40');
/*!40000 ALTER TABLE `outcome` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_same_event`
--

DROP TABLE IF EXISTS `v_same_event`;
/*!50001 DROP VIEW IF EXISTS `v_same_event`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_same_event` AS SELECT 
 1 AS `sortname`,
 1 AS `cnt`,
 1 AS `bk1`,
 1 AS `bk2`,
 1 AS `bk3`,
 1 AS `bk1_event`,
 1 AS `bk2_event`,
 1 AS `bk3_event`,
 1 AS `match_date`,
 1 AS `last_updated`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'bet'
--

--
-- Dumping routines for database 'bet'
--

--
-- Current Database: `mysql`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `mysql` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `mysql`;

--
-- Table structure for table `columns_priv`
--

DROP TABLE IF EXISTS `columns_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `columns_priv` (
  `Host` char(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `Db` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `User` char(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Table_name` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Column_name` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Column_priv` set('Select','Insert','Update','References') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`Host`,`Db`,`User`,`Table_name`,`Column_name`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Column privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `columns_priv`
--

LOCK TABLES `columns_priv` WRITE;
/*!40000 ALTER TABLE `columns_priv` DISABLE KEYS */;
/*!40000 ALTER TABLE `columns_priv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `component`
--

DROP TABLE IF EXISTS `component`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `component` (
  `component_id` int unsigned NOT NULL AUTO_INCREMENT,
  `component_group_id` int unsigned NOT NULL,
  `component_urn` text NOT NULL,
  PRIMARY KEY (`component_id`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Components';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `component`
--

LOCK TABLES `component` WRITE;
/*!40000 ALTER TABLE `component` DISABLE KEYS */;
INSERT INTO `component` VALUES (1,1,'file://component_validate_password');
/*!40000 ALTER TABLE `component` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `db`
--

DROP TABLE IF EXISTS `db`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `db` (
  `Host` char(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `Db` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `User` char(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Select_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Insert_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Update_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Delete_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Create_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Drop_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Grant_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `References_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Index_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Alter_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Create_tmp_table_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Lock_tables_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Create_view_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Show_view_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Create_routine_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Alter_routine_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Execute_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Event_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Trigger_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  PRIMARY KEY (`Host`,`Db`,`User`),
  KEY `User` (`User`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Database privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `db`
--

LOCK TABLES `db` WRITE;
/*!40000 ALTER TABLE `db` DISABLE KEYS */;
INSERT INTO `db` VALUES ('localhost','performance_schema','mysql.session','Y','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N'),('localhost','sys','mysql.sys','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','Y');
/*!40000 ALTER TABLE `db` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `default_roles`
--

DROP TABLE IF EXISTS `default_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `default_roles` (
  `HOST` char(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `USER` char(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `DEFAULT_ROLE_HOST` char(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '%',
  `DEFAULT_ROLE_USER` char(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`HOST`,`USER`,`DEFAULT_ROLE_HOST`,`DEFAULT_ROLE_USER`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Default roles';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `default_roles`
--

LOCK TABLES `default_roles` WRITE;
/*!40000 ALTER TABLE `default_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `default_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine_cost`
--

DROP TABLE IF EXISTS `engine_cost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `engine_cost` (
  `engine_name` varchar(64) NOT NULL,
  `device_type` int NOT NULL,
  `cost_name` varchar(64) NOT NULL,
  `cost_value` float DEFAULT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `comment` varchar(1024) DEFAULT NULL,
  `default_value` float GENERATED ALWAYS AS ((case `cost_name` when _utf8mb3'io_block_read_cost' then 1.0 when _utf8mb3'memory_block_read_cost' then 0.25 else NULL end)) VIRTUAL,
  PRIMARY KEY (`cost_name`,`engine_name`,`device_type`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine_cost`
--

LOCK TABLES `engine_cost` WRITE;
/*!40000 ALTER TABLE `engine_cost` DISABLE KEYS */;
INSERT INTO `engine_cost` (`engine_name`, `device_type`, `cost_name`, `cost_value`, `last_update`, `comment`) VALUES ('default',0,'io_block_read_cost',NULL,'2020-03-06 11:13:39',NULL),('default',0,'memory_block_read_cost',NULL,'2020-03-06 11:13:39',NULL);
/*!40000 ALTER TABLE `engine_cost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `func`
--

DROP TABLE IF EXISTS `func`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `func` (
  `name` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ret` tinyint NOT NULL DEFAULT '0',
  `dl` char(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `type` enum('function','aggregate') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`name`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='User defined functions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `func`
--

LOCK TABLES `func` WRITE;
/*!40000 ALTER TABLE `func` DISABLE KEYS */;
/*!40000 ALTER TABLE `func` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `global_grants`
--

DROP TABLE IF EXISTS `global_grants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `global_grants` (
  `USER` char(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `HOST` char(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `PRIV` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `WITH_GRANT_OPTION` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  PRIMARY KEY (`USER`,`HOST`,`PRIV`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Extended global grants';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `global_grants`
--

LOCK TABLES `global_grants` WRITE;
/*!40000 ALTER TABLE `global_grants` DISABLE KEYS */;
INSERT INTO `global_grants` VALUES ('mysql.session','localhost','BACKUP_ADMIN','N'),('mysql.session','localhost','CLONE_ADMIN','N'),('mysql.session','localhost','CONNECTION_ADMIN','N'),('mysql.session','localhost','PERSIST_RO_VARIABLES_ADMIN','N'),('mysql.session','localhost','SESSION_VARIABLES_ADMIN','N'),('mysql.session','localhost','SYSTEM_USER','N'),('mysql.session','localhost','SYSTEM_VARIABLES_ADMIN','N'),('root','localhost','APPLICATION_PASSWORD_ADMIN','Y'),('root','localhost','AUDIT_ADMIN','Y'),('root','localhost','BACKUP_ADMIN','Y'),('root','localhost','BINLOG_ADMIN','Y'),('root','localhost','BINLOG_ENCRYPTION_ADMIN','Y'),('root','localhost','CLONE_ADMIN','Y'),('root','localhost','CONNECTION_ADMIN','Y'),('root','localhost','ENCRYPTION_KEY_ADMIN','Y'),('root','localhost','GROUP_REPLICATION_ADMIN','Y'),('root','localhost','INNODB_REDO_LOG_ARCHIVE','Y'),('root','localhost','PERSIST_RO_VARIABLES_ADMIN','Y'),('root','localhost','REPLICATION_APPLIER','Y'),('root','localhost','REPLICATION_SLAVE_ADMIN','Y'),('root','localhost','RESOURCE_GROUP_ADMIN','Y'),('root','localhost','RESOURCE_GROUP_USER','Y'),('root','localhost','ROLE_ADMIN','Y'),('root','localhost','SERVICE_CONNECTION_ADMIN','Y'),('root','localhost','SESSION_VARIABLES_ADMIN','Y'),('root','localhost','SET_USER_ID','Y'),('root','localhost','SYSTEM_USER','Y'),('root','localhost','SYSTEM_VARIABLES_ADMIN','Y'),('root','localhost','TABLE_ENCRYPTION_ADMIN','Y'),('root','localhost','XA_RECOVER_ADMIN','Y');
/*!40000 ALTER TABLE `global_grants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gtid_executed`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `gtid_executed` (
  `source_uuid` char(36) NOT NULL COMMENT 'uuid of the source where the transaction was originally executed.',
  `interval_start` bigint NOT NULL COMMENT 'First number of interval.',
  `interval_end` bigint NOT NULL COMMENT 'Last number of interval.',
  PRIMARY KEY (`source_uuid`,`interval_start`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `help_category`
--

DROP TABLE IF EXISTS `help_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `help_category` (
  `help_category_id` smallint unsigned NOT NULL,
  `name` char(64) NOT NULL,
  `parent_category_id` smallint unsigned DEFAULT NULL,
  `url` text NOT NULL,
  PRIMARY KEY (`help_category_id`),
  UNIQUE KEY `name` (`name`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='help categories';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `help_category`
--

LOCK TABLES `help_category` WRITE;
/*!40000 ALTER TABLE `help_category` DISABLE KEYS */;
INSERT INTO `help_category` VALUES (0,'Contents',0,''),(1,'Help Metadata',0,''),(2,'Data Types',0,''),(3,'Administration',0,''),(4,'Language Structure',0,''),(5,'Geographic Features',0,''),(6,'MBR',5,''),(7,'WKT',5,''),(8,'Functions',0,''),(9,'Comparison Operators',8,''),(10,'Logical Operators',8,''),(11,'Control Flow Functions',8,''),(12,'String Functions',8,''),(13,'Numeric Functions',8,''),(14,'Date and Time Functions',8,''),(15,'Bit Functions',8,''),(16,'Encryption Functions',8,''),(17,'Locking Functions',8,''),(18,'Information Functions',8,''),(19,'Spatial Functions',8,''),(20,'WKT Functions',19,''),(21,'WKB Functions',19,''),(22,'Geometry Constructors',19,''),(23,'Geometry Property Functions',19,''),(24,'Point Property Functions',19,''),(25,'LineString Property Functions',19,''),(26,'Polygon Property Functions',19,''),(27,'GeometryCollection Property Functions',19,''),(28,'Geometry Relation Functions',19,''),(29,'MBR Functions',19,''),(30,'GROUP BY Functions and Modifiers',8,''),(31,'Performance Schema Functions',8,''),(32,'Miscellaneous Functions',8,''),(33,'Data Definition',0,''),(34,'Data Manipulation',0,''),(35,'Transactions',0,''),(36,'Compound Statements',0,''),(37,'Account Management',0,''),(38,'Table Maintenance',0,''),(39,'User-Defined Functions',0,''),(40,'Components',0,''),(41,'Plugins',0,''),(42,'Utility',0,''),(43,'Storage Engines',0,'');
/*!40000 ALTER TABLE `help_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `help_keyword`
--

DROP TABLE IF EXISTS `help_keyword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `help_keyword` (
  `help_keyword_id` int unsigned NOT NULL,
  `name` char(64) NOT NULL,
  PRIMARY KEY (`help_keyword_id`),
  UNIQUE KEY `name` (`name`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='help keywords';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `help_keyword`
--

LOCK TABLES `help_keyword` WRITE;
/*!40000 ALTER TABLE `help_keyword` DISABLE KEYS */;
INSERT INTO `help_keyword` VALUES (225,'(JSON'),(226,'->'),(228,'->>'),(46,'<>'),(628,'ACCOUNT'),(422,'ACTION'),(40,'ADD'),(653,'ADMIN'),(108,'AES_DECRYPT'),(109,'AES_ENCRYPT'),(341,'AFTER'),(95,'AGAINST'),(675,'AGGREGATE'),(342,'ALGORITHM'),(488,'ALL'),(41,'ALTER'),(343,'ANALYZE'),(47,'AND'),(311,'ANY_VALUE'),(423,'ARCHIVE'),(102,'ARRAY'),(489,'AS'),(259,'ASC'),(404,'AT'),(513,'AUTOCOMMIT'),(447,'AUTOEXTEND_SIZE'),(344,'AUTO_INCREMENT'),(345,'AVG_ROW_LENGTH'),(527,'BACKUP'),(541,'BEFORE'),(514,'BEGIN'),(48,'BETWEEN'),(72,'BIGINT'),(104,'BINARY'),(704,'BINLOG'),(312,'BIN_TO_UUID'),(8,'BOOL'),(9,'BOOLEAN'),(62,'BOTH'),(408,'BTREE'),(260,'BY'),(33,'BYTE'),(712,'CACHE'),(455,'CALL'),(283,'CAN_ACCESS_COLUMN'),(284,'CAN_ACCESS_DATABASE'),(285,'CAN_ACCESS_TABLE'),(286,'CAN_ACCESS_VIEW'),(424,'CASCADE'),(53,'CASE'),(608,'CATALOG_NAME'),(75,'CEIL'),(76,'CEILING'),(515,'CHAIN'),(346,'CHANGE'),(547,'CHANNEL'),(34,'CHAR'),(30,'CHARACTER'),(687,'CHARSET'),(347,'CHECK'),(348,'CHECKSUM'),(629,'CIPHER'),(609,'CLASS_ORIGIN'),(654,'CLIENT'),(683,'CLONE'),(461,'CLOSE'),(349,'COALESCE'),(707,'CODE'),(316,'COLLATE'),(689,'COLLATION'),(350,'COLUMN'),(351,'COLUMNS'),(610,'COLUMN_NAME'),(321,'COMMENT'),(516,'COMMIT'),(530,'COMMITTED'),(425,'COMPACT'),(322,'COMPLETION'),(679,'COMPONENT'),(426,'COMPRESSED'),(352,'COMPRESSION'),(475,'CONCURRENT'),(605,'CONDITION'),(353,'CONNECTION'),(517,'CONSISTENT'),(354,'CONSTRAINT'),(611,'CONSTRAINT_CATALOG'),(612,'CONSTRAINT_NAME'),(613,'CONSTRAINT_SCHEMA'),(606,'CONTINUE'),(103,'CONVERT'),(258,'COUNT'),(42,'CREATE'),(256,'CREATE_DH_PARAMETERS'),(506,'CROSS'),(427,'CSV'),(268,'CUME_DIST'),(630,'CURRENT'),(116,'CURRENT_ROLE'),(323,'CURRENT_USER'),(603,'CURSOR'),(614,'CURSOR_NAME'),(355,'DATA'),(317,'DATABASE'),(690,'DATABASES'),(397,'DATAFILE'),(27,'DATE'),(105,'DATETIME'),(79,'DATE_ADD'),(80,'DATE_SUB'),(81,'DAY'),(82,'DAY_HOUR'),(83,'DAY_MINUTE'),(84,'DAY_SECOND'),(593,'DEALLOCATE'),(19,'DEC'),(22,'DECIMAL'),(594,'DECLARE'),(2,'DEFAULT'),(584,'DEFAULT_AUTH'),(324,'DEFINER'),(415,'DEFINITION'),(468,'DELAYED'),(356,'DELAY_KEY_WRITE'),(428,'DELETE'),(269,'DENSE_RANK'),(261,'DESC'),(724,'DESCRIBE'),(416,'DESCRIPTION'),(615,'DIAGNOSTICS'),(357,'DIRECTORY'),(325,'DISABLE'),(358,'DISCARD'),(257,'DISTINCT'),(490,'DISTINCTROW'),(326,'DO'),(359,'DROP'),(505,'DUAL'),(491,'DUMPFILE'),(469,'DUPLICATE'),(429,'DYNAMIC'),(54,'ELSE'),(595,'ELSEIF'),(327,'ENABLE'),(476,'ENCLOSED'),(318,'ENCRYPTION'),(55,'END'),(405,'ENDS'),(360,'ENGINE'),(691,'ENGINES'),(713,'ERROR'),(692,'ERRORS'),(66,'ESCAPE'),(477,'ESCAPED'),(328,'EVENT'),(705,'EVENTS'),(406,'EVERY'),(666,'EXCEPT'),(361,'EXCHANGE'),(592,'EXECUTE'),(403,'EXISTS'),(607,'EXIT'),(96,'EXPANSION'),(631,'EXPIRE'),(725,'EXPLAIN'),(714,'EXPORT'),(673,'EXTENDED'),(448,'EXTENT_SIZE'),(227,'EXTRACTION)'),(632,'FAILED_LOGIN_ATTEMPTS'),(6,'FALSE'),(671,'FAST'),(430,'FEDERATED'),(604,'FETCH'),(478,'FIELDS'),(655,'FILE'),(449,'FILE_BLOCK_SIZE'),(574,'FILTER'),(362,'FIRST'),(270,'FIRST_VALUE'),(20,'FIXED'),(23,'FLOAT4'),(24,'FLOAT8'),(73,'FLOOR'),(715,'FLUSH'),(492,'FOR'),(507,'FORCE'),(363,'FOREIGN'),(726,'FORMAT'),(279,'FORMAT_BYTES'),(280,'FORMAT_PICO_TIME'),(63,'FROM'),(431,'FULL'),(364,'FULLTEXT'),(334,'FUNCTION'),(716,'GENERAL'),(149,'GEOMCOLLECTION'),(150,'GEOMETRYCOLLECTION'),(616,'GET'),(287,'GET_DD_COLUMN_PRIVILEGES'),(288,'GET_DD_CREATE_OPTIONS'),(289,'GET_DD_INDEX_SUB_PART_LENGTH'),(531,'GLOBAL'),(656,'GRANT'),(693,'GRANTS'),(336,'GROUP'),(313,'GROUPING'),(462,'HANDLER'),(493,'HAVING'),(432,'HEAP'),(5,'HELP'),(0,'HELP_DATE'),(1,'HELP_VERSION'),(470,'HIGH_PRIORITY'),(633,'HISTORY'),(409,'HOST'),(694,'HOSTS'),(85,'HOUR'),(86,'HOUR_MINUTE'),(87,'HOUR_SECOND'),(117,'ICU_VERSION'),(486,'IDENTIFIED'),(58,'IF'),(471,'IGNORE'),(548,'IGNORE_SERVER_IDS'),(365,'IMPORT'),(97,'IN'),(43,'INDEX'),(695,'INDEXES'),(479,'INFILE'),(398,'INITIAL_SIZE'),(229,'INLINE'),(508,'INNER'),(433,'INNODB'),(59,'INSERT'),(366,'INSERT_METHOD'),(680,'INSTALL'),(335,'INSTANCE'),(10,'INT1'),(13,'INT2'),(14,'INT3'),(16,'INT4'),(18,'INT8'),(17,'INTEGER'),(290,'INTERNAL_AUTO_INCREMENT'),(291,'INTERNAL_AVG_ROW_LENGTH'),(293,'INTERNAL_CHECKSUM'),(292,'INTERNAL_CHECK_TIME'),(294,'INTERNAL_DATA_FREE'),(295,'INTERNAL_DATA_LENGTH'),(296,'INTERNAL_DD_CHAR_LENGTH'),(297,'INTERNAL_GET_COMMENT_OR_ERROR'),(298,'INTERNAL_GET_ENABLED_ROLE_JSON'),(299,'INTERNAL_GET_HOSTNAME'),(300,'INTERNAL_GET_USERNAME'),(301,'INTERNAL_GET_VIEW_WARNING_OR_ERROR'),(302,'INTERNAL_INDEX_COLUMN_CARDINALITY'),(303,'INTERNAL_INDEX_LENGTH'),(304,'INTERNAL_IS_ENABLED_ROLE'),(305,'INTERNAL_IS_MANDATORY_ROLE'),(306,'INTERNAL_KEYS_DISABLED'),(307,'INTERNAL_MAX_DATA_LENGTH'),(308,'INTERNAL_TABLE_ROWS'),(309,'INTERNAL_UPDATE_TIME'),(88,'INTERVAL'),(472,'INTO'),(367,'INVISIBLE'),(585,'IO_THREAD'),(49,'IS'),(532,'ISOLATION'),(634,'ISSUER'),(314,'IS_UUID'),(310,'IS_VISIBLE_DD_OBJECT'),(596,'ITERATE'),(494,'JOIN'),(106,'JSON'),(219,'JSON_ARRAY'),(264,'JSON_ARRAYAGG'),(236,'JSON_ARRAY_APPEND'),(237,'JSON_ARRAY_INSERT'),(222,'JSON_CONTAINS'),(223,'JSON_CONTAINS_PATH'),(246,'JSON_DEPTH'),(224,'JSON_EXTRACT'),(238,'JSON_INSERT'),(231,'JSON_KEYS'),(247,'JSON_LENGTH'),(239,'JSON_MERGE'),(240,'JSON_MERGE_PATCH'),(241,'JSON_MERGE_PRESERVE'),(220,'JSON_OBJECT'),(265,'JSON_OBJECTAGG'),(232,'JSON_OVERLAPS'),(253,'JSON_PRETTY'),(221,'JSON_QUOTE'),(242,'JSON_REMOVE'),(243,'JSON_REPLACE'),(251,'JSON_SCHEMA_VALID'),(252,'JSON_SCHEMA_VALIDATION_REPORT'),(233,'JSON_SEARCH'),(244,'JSON_SET'),(254,'JSON_STORAGE_FREE'),(255,'JSON_STORAGE_SIZE'),(250,'JSON_TABLE'),(248,'JSON_TYPE'),(245,'JSON_UNQUOTE'),(249,'JSON_VALID'),(44,'KEY'),(368,'KEYS'),(369,'KEY_BLOCK_SIZE'),(721,'KILL'),(271,'LAG'),(463,'LAST'),(272,'LAST_VALUE'),(273,'LEAD'),(64,'LEADING'),(597,'LEAVE'),(722,'LEAVES'),(509,'LEFT'),(533,'LEVEL'),(60,'LIKE'),(456,'LIMIT'),(480,'LINES'),(151,'LINESTRING'),(481,'LOAD'),(482,'LOCAL'),(370,'LOCK'),(337,'LOGFILE'),(542,'LOGS'),(38,'LONG'),(39,'LONGBINARY'),(598,'LOOP'),(457,'LOW_PRIORITY'),(543,'MASTER'),(549,'MASTER_AUTO_POSITION'),(550,'MASTER_BIND'),(551,'MASTER_COMPRESSION_ALGORITHMS'),(552,'MASTER_CONNECT_RETRY'),(553,'MASTER_HEARTBEAT_PERIOD'),(554,'MASTER_HOST'),(555,'MASTER_LOG_FILE'),(556,'MASTER_LOG_POS'),(557,'MASTER_PASSWORD'),(558,'MASTER_PORT'),(559,'MASTER_RETRY_COUNT'),(560,'MASTER_SSL'),(561,'MASTER_SSL_CA'),(562,'MASTER_SSL_CERT'),(563,'MASTER_SSL_CIPHER'),(564,'MASTER_SSL_CRL'),(565,'MASTER_SSL_CRLPATH'),(566,'MASTER_SSL_KEY'),(567,'MASTER_SSL_VERIFY_SERVER_CERT'),(568,'MASTER_TLS_VERSION'),(569,'MASTER_USER'),(570,'MASTER_ZSTD_COMPRESSION_LEVEL'),(98,'MATCH'),(635,'MAX_CONNECTIONS_PER_HOUR'),(636,'MAX_QUERIES_PER_HOUR'),(371,'MAX_ROWS'),(450,'MAX_SIZE'),(637,'MAX_UPDATES_PER_HOUR'),(638,'MAX_USER_CONNECTIONS'),(202,'MBRCONTAINS'),(203,'MBRDISJOINT'),(204,'MBRINTERSECTS'),(205,'MBROVERLAPS'),(206,'MBRTOUCHES'),(207,'MBRWITHIN'),(672,'MEDIUM'),(234,'MEMBER'),(495,'MEMORY'),(434,'MERGE'),(617,'MESSAGE_TEXT'),(15,'MIDDLEINT'),(89,'MINUTE'),(90,'MINUTE_SECOND'),(372,'MIN_ROWS'),(74,'MOD'),(99,'MODE'),(373,'MODIFY'),(91,'MONTH'),(435,'MRG_MYISAM'),(152,'MULTILINESTRING'),(153,'MULTIPOINT'),(154,'MULTIPOLYGON'),(696,'MUTEX'),(436,'MYISAM'),(618,'MYSQL_ERRNO'),(417,'NAME'),(688,'NAMES'),(31,'NATIONAL'),(510,'NATURAL'),(32,'NCHAR'),(437,'NDB'),(438,'NDBCLUSTER'),(639,'NEVER'),(464,'NEXT'),(439,'NO'),(451,'NODEGROUP'),(640,'NONE'),(50,'NOT'),(670,'NO_WRITE_TO_BINLOG'),(274,'NTH_VALUE'),(275,'NTILE'),(51,'NULL'),(619,'NUMBER'),(21,'NUMERIC'),(35,'NVARCHAR'),(235,'OF'),(496,'OFFSET'),(641,'OLD'),(329,'ON'),(518,'ONLY'),(465,'OPEN'),(374,'OPTIMIZE'),(717,'OPTIMIZER_COSTS'),(657,'OPTION'),(642,'OPTIONAL'),(483,'OPTIONALLY'),(339,'OPTIONS'),(52,'OR'),(262,'ORDER'),(418,'ORGANIZATION'),(511,'OUTER'),(497,'OUTFILE'),(410,'OWNER'),(375,'PACK_KEYS'),(376,'PARSER'),(440,'PARTIAL'),(377,'PARTITION'),(378,'PARTITIONING'),(379,'PASSWORD'),(643,'PASSWORD_LOCK_TIME'),(230,'PATH)'),(276,'PERCENT_RANK'),(684,'PERSIST'),(685,'PERSIST_ONLY'),(681,'PLUGIN'),(708,'PLUGINS'),(586,'PLUGIN_DIR'),(155,'POINT'),(156,'POLYGON'),(411,'PORT'),(77,'POW'),(78,'POWER'),(25,'PRECISION'),(538,'PREPARE'),(330,'PRESERVE'),(466,'PREV'),(380,'PRIMARY'),(658,'PRIVILEGES'),(571,'PRIVILEGE_CHECKS_USER'),(338,'PROCEDURE'),(659,'PROCESS'),(697,'PROCESSLIST'),(709,'PROFILE'),(710,'PROFILES'),(664,'PROXY'),(281,'PS_CURRENT_THREAD_ID'),(282,'PS_THREAD_ID'),(544,'PURGE'),(100,'QUERY'),(458,'QUICK'),(644,'RANDOM'),(110,'RANDOM_BYTES'),(277,'RANK'),(467,'READ'),(26,'REAL'),(381,'REBUILD'),(539,'RECOVER'),(441,'REDUNDANT'),(419,'REFERENCE'),(442,'REFERENCES'),(68,'REGEXP_INSTR'),(69,'REGEXP_LIKE'),(70,'REGEXP_REPLACE'),(71,'REGEXP_SUBSTR'),(718,'RELAY'),(711,'RELAYLOG'),(572,'RELAY_LOG_FILE'),(573,'RELAY_LOG_POS'),(519,'RELEASE'),(660,'RELOAD'),(382,'REMOVE'),(331,'RENAME'),(383,'REORGANIZE'),(384,'REPAIR'),(599,'REPEAT'),(534,'REPEATABLE'),(420,'REPLACE'),(575,'REPLICATE_DO_DB'),(576,'REPLICATE_DO_TABLE'),(577,'REPLICATE_IGNORE_DB'),(578,'REPLICATE_IGNORE_TABLE'),(579,'REPLICATE_REWRITE_DB'),(580,'REPLICATE_WILD_DO_TABLE'),(581,'REPLICATE_WILD_IGNORE_TABLE'),(582,'REPLICATION'),(645,'REQUIRE'),(545,'RESET'),(625,'RESIGNAL'),(667,'RESOURCE'),(723,'RESTART'),(445,'RESTRICT'),(646,'RETAIN'),(601,'RETURN'),(620,'RETURNED_SQLSTATE'),(676,'RETURNS'),(647,'REUSE'),(665,'REVOKE'),(512,'RIGHT'),(67,'RLIKE'),(648,'ROLE'),(118,'ROLES_GRAPHML'),(520,'ROLLBACK'),(487,'ROWS'),(621,'ROW_COUNT'),(385,'ROW_FORMAT'),(278,'ROW_NUMBER'),(526,'SAVEPOINT'),(332,'SCHEDULE'),(319,'SCHEMA'),(698,'SCHEMAS'),(622,'SCHEMA_NAME'),(92,'SECOND'),(473,'SELECT'),(263,'SEPARATOR'),(3,'SERIAL'),(535,'SERIALIZABLE'),(340,'SERVER'),(536,'SESSION'),(320,'SET'),(111,'SHA'),(112,'SHA1'),(113,'SHA2'),(498,'SHARE'),(699,'SHOW'),(661,'SHUTDOWN'),(627,'SIGNAL'),(107,'SIGNED'),(333,'SLAVE'),(719,'SLOW'),(521,'SNAPSHOT'),(412,'SOCKET'),(677,'SONAME'),(61,'SOUNDS'),(386,'SPATIAL'),(626,'SQLSTATE'),(587,'SQL_AFTER_GTIDS'),(588,'SQL_AFTER_MTS_GAPS'),(589,'SQL_BEFORE_GTIDS'),(499,'SQL_BIG_RESULT'),(500,'SQL_BUFFER_RESULT'),(501,'SQL_CALC_FOUND_ROWS'),(546,'SQL_LOG_BIN'),(502,'SQL_NO_CACHE'),(583,'SQL_SLAVE_SKIP_COUNTER'),(503,'SQL_SMALL_RESULT'),(590,'SQL_THREAD'),(649,'SSL'),(522,'START'),(484,'STARTING'),(407,'STARTS'),(114,'STATEMENT_DIGEST'),(115,'STATEMENT_DIGEST_TEXT'),(387,'STATS_AUTO_RECALC'),(388,'STATS_PERSISTENT'),(389,'STATS_SAMPLE_PAGES'),(700,'STATUS'),(266,'STD'),(267,'STDDEV'),(591,'STOP'),(706,'STORAGE'),(443,'STORED'),(504,'STRAIGHT_JOIN'),(678,'STRING'),(177,'ST_AREA'),(157,'ST_ASBINARY'),(212,'ST_ASGEOJSON'),(159,'ST_ASTEXT'),(158,'ST_ASWKB'),(160,'ST_ASWKT'),(185,'ST_BUFFER'),(186,'ST_BUFFER_STRATEGY'),(178,'ST_CENTROID'),(193,'ST_CONTAINS'),(187,'ST_CONVEXHULL'),(194,'ST_CROSSES'),(188,'ST_DIFFERENCE'),(162,'ST_DIMENSION'),(195,'ST_DISJOINT'),(196,'ST_DISTANCE'),(214,'ST_DISTANCE_SPHERE'),(172,'ST_ENDPOINT'),(163,'ST_ENVELOPE'),(197,'ST_EQUALS'),(179,'ST_EXTERIORRING'),(208,'ST_GEOHASH'),(119,'ST_GEOMCOLLFROMTEXT'),(134,'ST_GEOMCOLLFROMWKB'),(120,'ST_GEOMETRYCOLLECTIONFROMTEXT'),(135,'ST_GEOMETRYCOLLECTIONFROMWKB'),(121,'ST_GEOMETRYFROMTEXT'),(136,'ST_GEOMETRYFROMWKB'),(183,'ST_GEOMETRYN'),(164,'ST_GEOMETRYTYPE'),(213,'ST_GEOMFROMGEOJSON'),(122,'ST_GEOMFROMTEXT'),(137,'ST_GEOMFROMWKB'),(180,'ST_INTERIORRINGN'),(189,'ST_INTERSECTION'),(198,'ST_INTERSECTS'),(173,'ST_ISCLOSED'),(165,'ST_ISEMPTY'),(166,'ST_ISSIMPLE'),(215,'ST_ISVALID'),(209,'ST_LATFROMGEOHASH'),(168,'ST_LATITUDE'),(123,'ST_LINEFROMTEXT'),(138,'ST_LINEFROMWKB'),(124,'ST_LINESTRINGFROMTEXT'),(139,'ST_LINESTRINGFROMWKB'),(210,'ST_LONGFROMGEOHASH'),(169,'ST_LONGITUDE'),(216,'ST_MAKEENVELOPE'),(125,'ST_MLINEFROMTEXT'),(140,'ST_MLINEFROMWKB'),(127,'ST_MPOINTFROMTEXT'),(142,'ST_MPOINTFROMWKB'),(129,'ST_MPOLYFROMTEXT'),(144,'ST_MPOLYFROMWKB'),(126,'ST_MULTILINESTRINGFROMTEXT'),(141,'ST_MULTILINESTRINGFROMWKB'),(128,'ST_MULTIPOINTFROMTEXT'),(143,'ST_MULTIPOINTFROMWKB'),(130,'ST_MULTIPOLYGONFROMTEXT'),(145,'ST_MULTIPOLYGONFROMWKB'),(184,'ST_NUMGEOMETRIES'),(181,'ST_NUMINTERIORRING'),(182,'ST_NUMINTERIORRINGS'),(174,'ST_NUMPOINTS'),(199,'ST_OVERLAPS'),(211,'ST_POINTFROMGEOHASH'),(131,'ST_POINTFROMTEXT'),(146,'ST_POINTFROMWKB'),(175,'ST_POINTN'),(132,'ST_POLYFROMTEXT'),(147,'ST_POLYFROMWKB'),(133,'ST_POLYGONFROMTEXT'),(148,'ST_POLYGONFROMWKB'),(217,'ST_SIMPLIFY'),(167,'ST_SRID'),(176,'ST_STARTPOINT'),(161,'ST_SWAPXY'),(190,'ST_SYMDIFFERENCE'),(200,'ST_TOUCHES'),(191,'ST_TRANSFORM'),(192,'ST_UNION'),(218,'ST_VALIDATE'),(201,'ST_WITHIN'),(170,'ST_X'),(171,'ST_Y'),(623,'SUBCLASS_ORIGIN'),(650,'SUBJECT'),(662,'SUPER'),(421,'SYSTEM'),(45,'TABLE'),(529,'TABLES'),(390,'TABLESPACE'),(624,'TABLE_NAME'),(454,'TEMPORARY'),(485,'TERMINATED'),(56,'THEN'),(668,'THREAD_PRIORITY'),(29,'TIME'),(28,'TIMESTAMP'),(399,'TO'),(727,'TRADITIONAL'),(65,'TRAILING'),(523,'TRANSACTION'),(728,'TREE'),(453,'TRIGGER'),(701,'TRIGGERS'),(7,'TRUE'),(391,'TRUNCATE'),(392,'TYPE'),(651,'UNBOUNDED'),(537,'UNCOMMITTED'),(400,'UNDO'),(682,'UNINSTALL'),(393,'UNION'),(394,'UNIQUE'),(528,'UNLOCK'),(11,'UNSIGNED'),(600,'UNTIL'),(446,'UPDATE'),(395,'UPGRADE'),(663,'USAGE'),(452,'USE'),(413,'USER'),(720,'USER_RESOURCES'),(674,'USE_FRM'),(459,'USING'),(315,'UUID_TO_BIN'),(4,'VALUE'),(474,'VALUES'),(36,'VARCHARACTER'),(686,'VARIABLE'),(702,'VARIABLES'),(37,'VARYING'),(669,'VCPU'),(402,'VIEW'),(444,'VIRTUAL'),(396,'VISIBLE'),(401,'WAIT'),(703,'WARNINGS'),(57,'WHEN'),(460,'WHERE'),(602,'WHILE'),(101,'WITH'),(524,'WORK'),(414,'WRAPPER'),(525,'WRITE'),(652,'X509'),(540,'XA'),(93,'YEAR'),(94,'YEAR_MONTH'),(12,'ZEROFILL');
/*!40000 ALTER TABLE `help_keyword` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `help_relation`
--

DROP TABLE IF EXISTS `help_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `help_relation` (
  `help_topic_id` int unsigned NOT NULL,
  `help_keyword_id` int unsigned NOT NULL,
  PRIMARY KEY (`help_keyword_id`,`help_topic_id`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='keyword-topic relation';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `help_relation`
--

LOCK TABLES `help_relation` WRITE;
/*!40000 ALTER TABLE `help_relation` DISABLE KEYS */;
INSERT INTO `help_relation` VALUES (0,0),(1,1),(2,2),(499,2),(500,2),(507,2),(510,2),(511,2),(519,2),(520,2),(543,2),(548,2),(581,2),(599,2),(601,2),(607,2),(609,2),(2,3),(519,3),(2,4),(543,4),(548,4),(597,4),(598,4),(3,5),(687,5),(4,6),(5,6),(4,7),(5,7),(7,8),(8,8),(7,9),(231,9),(7,10),(7,11),(11,11),(13,11),(14,11),(16,11),(17,11),(234,11),(7,12),(11,12),(13,12),(14,12),(16,12),(17,12),(9,13),(10,14),(10,15),(11,16),(11,17),(234,17),(619,17),(13,18),(14,19),(14,20),(519,20),(14,21),(15,22),(234,22),(619,22),(16,23),(17,24),(17,25),(17,26),(619,26),(19,27),(179,27),(181,27),(234,27),(21,28),(215,28),(22,29),(213,29),(234,29),(24,30),(26,30),(499,30),(500,30),(507,30),(510,30),(511,30),(519,30),(546,30),(547,30),(549,30),(627,30),(628,30),(630,30),(634,30),(24,31),(26,31),(24,32),(25,33),(25,34),(234,34),(26,35),(26,36),(26,37),(35,38),(35,39),(44,40),(507,40),(508,40),(521,40),(44,41),(499,41),(500,41),(501,41),(502,41),(503,41),(504,41),(505,41),(506,41),(507,41),(508,41),(509,41),(599,41),(604,41),(610,41),(44,42),(510,42),(511,42),(512,42),(513,42),(514,42),(515,42),(516,42),(517,42),(518,42),(519,42),(521,42),(522,42),(523,42),(600,42),(601,42),(611,42),(619,42),(630,42),(638,42),(639,42),(640,42),(641,42),(642,42),(643,42),(645,42),(44,43),(507,43),(513,43),(519,43),(527,43),(551,43),(630,43),(656,43),(676,43),(679,43),(44,44),(507,44),(519,44),(520,44),(543,44),(44,45),(507,45),(519,45),(532,45),(536,45),(537,45),(542,45),(614,45),(615,45),(616,45),(617,45),(618,45),(630,45),(643,45),(670,45),(47,46),(52,47),(66,47),(52,48),(59,49),(60,49),(61,49),(62,49),(60,50),(62,50),(65,50),(510,50),(511,50),(512,50),(518,50),(600,50),(601,50),(61,51),(62,51),(520,51),(67,52),(518,52),(71,53),(582,53),(71,54),(582,54),(71,55),(564,55),(579,55),(582,55),(583,55),(586,55),(587,55),(589,55),(71,56),(582,56),(583,56),(71,57),(582,57),(72,58),(510,58),(511,58),(512,58),(518,58),(524,58),(525,58),(526,58),(530,58),(531,58),(532,58),(535,58),(583,58),(599,58),(600,58),(601,58),(602,58),(603,58),(681,58),(90,59),(543,59),(544,59),(545,59),(114,60),(630,60),(636,60),(637,60),(114,61),(120,62),(120,63),(539,63),(542,63),(549,63),(630,63),(633,63),(636,63),(637,63),(656,63),(666,63),(120,64),(120,65),(125,66),(129,67),(130,68),(131,69),(132,70),(133,71),(139,72),(139,73),(140,74),(159,74),(146,75),(147,76),(161,77),(162,78),(181,79),(181,80),(181,81),(599,81),(601,81),(181,82),(181,83),(181,84),(181,85),(181,86),(181,87),(181,88),(512,88),(599,88),(601,88),(181,89),(181,90),(181,91),(181,92),(181,93),(181,94),(231,95),(231,96),(231,97),(549,97),(633,97),(636,97),(637,97),(656,97),(666,97),(231,98),(231,99),(549,99),(231,100),(678,100),(231,101),(507,101),(513,101),(519,101),(599,101),(601,101),(604,101),(677,101),(233,102),(233,103),(234,103),(234,104),(565,104),(566,104),(631,104),(632,104),(677,104),(234,105),(234,106),(684,106),(685,106),(686,106),(234,107),(244,108),(245,109),(254,110),(255,111),(255,112),(256,113),(257,114),(258,115),(272,116),(276,117),(278,118),(285,119),(285,120),(286,121),(286,122),(287,123),(287,124),(288,125),(288,126),(289,127),(289,128),(290,129),(290,130),(291,131),(292,132),(292,133),(293,134),(293,135),(294,136),(294,137),(295,138),(295,139),(296,140),(296,141),(297,142),(297,143),(298,144),(298,145),(299,146),(300,147),(300,148),(301,149),(302,150),(303,151),(304,152),(305,153),(306,154),(307,155),(308,156),(309,157),(309,158),(310,159),(310,160),(311,161),(312,162),(313,163),(314,164),(315,165),(316,166),(317,167),(318,168),(319,169),(320,170),(321,171),(322,172),(323,173),(325,174),(326,175),(327,176),(328,177),(329,178),(330,179),(331,180),(332,181),(332,182),(333,183),(334,184),(335,185),(336,186),(337,187),(338,188),(339,189),(340,190),(341,191),(342,192),(343,193),(344,194),(345,195),(346,196),(347,197),(348,198),(349,199),(350,200),(351,201),(352,202),(355,203),(357,204),(358,205),(359,206),(360,207),(361,208),(362,209),(363,210),(364,211),(365,212),(366,213),(367,214),(368,215),(369,216),(370,217),(371,218),(372,219),(373,220),(374,221),(375,222),(376,223),(377,224),(378,225),(379,225),(378,226),(378,227),(379,228),(379,229),(379,230),(380,231),(381,232),(382,233),(383,234),(383,235),(384,236),(385,237),(386,238),(387,239),(388,240),(389,241),(390,242),(391,243),(392,244),(393,245),(394,246),(395,247),(396,248),(397,249),(398,250),(399,251),(400,252),(401,253),(402,254),(403,255),(415,256),(417,257),(422,257),(423,257),(426,257),(427,257),(432,257),(549,257),(552,257),(422,258),(651,258),(674,258),(423,259),(549,259),(423,260),(507,260),(519,260),(539,260),(546,260),(547,260),(549,260),(553,260),(599,260),(601,260),(423,261),(549,261),(684,261),(685,261),(686,261),(423,262),(507,262),(539,262),(549,262),(553,262),(423,263),(424,264),(425,265),(428,266),(429,267),(436,268),(437,269),(438,270),(439,271),(440,272),(441,273),(442,274),(443,275),(444,276),(445,277),(446,278),(447,279),(448,280),(449,281),(450,282),(451,283),(452,284),(453,285),(454,286),(455,287),(456,288),(457,289),(458,290),(459,291),(460,292),(461,293),(462,294),(463,295),(464,296),(465,297),(466,298),(467,299),(468,300),(469,301),(470,302),(471,303),(472,304),(473,305),(474,306),(475,307),(476,308),(477,309),(478,310),(479,311),(480,312),(482,313),(491,314),(497,315),(499,316),(500,316),(507,316),(510,316),(511,316),(519,316),(499,317),(500,317),(510,317),(511,317),(517,317),(524,317),(525,317),(630,317),(638,317),(639,317),(499,318),(500,318),(507,318),(510,318),(511,318),(519,318),(499,319),(500,319),(510,319),(511,319),(524,319),(525,319),(630,319),(638,319),(639,319),(499,320),(500,320),(507,320),(510,320),(511,320),(519,320),(520,320),(543,320),(546,320),(547,320),(548,320),(549,320),(553,320),(554,320),(555,320),(556,320),(557,320),(568,320),(572,320),(597,320),(598,320),(607,320),(608,320),(609,320),(613,320),(626,320),(627,320),(628,320),(629,320),(630,320),(634,320),(501,321),(507,321),(512,321),(513,321),(519,321),(521,321),(501,322),(512,322),(501,323),(512,323),(501,324),(512,324),(501,325),(507,325),(512,325),(610,325),(611,325),(501,326),(512,326),(540,326),(589,326),(501,327),(507,327),(512,327),(610,327),(611,327),(501,328),(512,328),(526,328),(640,328),(501,329),(512,329),(520,329),(551,329),(501,330),(512,330),(501,331),(507,331),(508,331),(536,331),(605,331),(501,332),(512,332),(501,333),(512,333),(571,333),(573,333),(574,333),(667,333),(668,333),(680,333),(502,334),(515,334),(516,334),(528,334),(529,334),(619,334),(620,334),(630,334),(641,334),(653,334),(654,334),(503,335),(561,335),(504,336),(514,336),(521,336),(549,336),(610,336),(611,336),(612,336),(613,336),(504,337),(514,337),(521,337),(505,338),(515,338),(516,338),(528,338),(529,338),(630,338),(642,338),(661,338),(662,338),(506,339),(517,339),(506,340),(517,340),(530,340),(507,341),(507,342),(507,343),(614,343),(684,343),(685,343),(686,343),(507,344),(507,345),(519,345),(507,346),(569,346),(570,346),(507,347),(519,347),(615,347),(507,348),(519,348),(616,348),(507,349),(507,350),(507,351),(519,351),(546,351),(630,351),(636,351),(637,351),(507,352),(519,352),(507,353),(519,353),(678,353),(684,353),(685,353),(686,353),(507,354),(519,354),(507,355),(517,355),(519,355),(546,355),(507,356),(519,356),(507,357),(519,357),(507,358),(599,358),(507,359),(508,359),(524,359),(525,359),(526,359),(527,359),(528,359),(529,359),(530,359),(531,359),(532,359),(533,359),(534,359),(535,359),(577,359),(578,359),(602,359),(603,359),(612,359),(620,359),(507,360),(508,360),(519,360),(521,360),(533,360),(630,360),(649,360),(677,360),(507,361),(507,362),(519,362),(541,362),(507,363),(517,363),(519,363),(520,363),(507,364),(513,364),(519,364),(507,365),(542,365),(546,365),(507,366),(519,366),(507,367),(513,367),(519,367),(507,368),(630,368),(656,368),(507,369),(519,369),(507,370),(549,370),(561,370),(562,370),(599,370),(601,370),(677,370),(507,371),(519,371),(507,372),(519,372),(507,373),(507,374),(617,374),(507,375),(519,375),(507,376),(513,376),(519,376),(507,377),(519,377),(539,377),(543,377),(546,377),(548,377),(549,377),(551,377),(676,377),(679,377),(507,378),(507,379),(517,379),(573,379),(599,379),(601,379),(608,379),(507,380),(507,381),(507,382),(507,383),(507,384),(618,384),(507,385),(519,385),(507,386),(513,386),(518,386),(531,386),(507,387),(519,387),(507,388),(519,388),(507,389),(519,389),(507,390),(508,390),(521,390),(533,390),(507,391),(537,391),(507,392),(611,392),(507,393),(552,393),(507,394),(507,395),(615,395),(507,396),(513,396),(519,396),(508,397),(521,397),(508,398),(521,398),(508,399),(558,399),(559,399),(560,399),(565,399),(566,399),(569,399),(608,399),(508,400),(521,400),(533,400),(595,400),(508,401),(521,401),(509,402),(523,402),(535,402),(510,403),(511,403),(512,403),(518,403),(524,403),(525,403),(526,403),(530,403),(531,403),(532,403),(535,403),(599,403),(600,403),(601,403),(602,403),(603,403),(681,403),(512,404),(512,405),(512,406),(512,407),(513,408),(517,409),(517,410),(517,411),(517,412),(517,413),(573,413),(599,413),(601,413),(603,413),(605,413),(611,413),(645,413),(517,414),(518,415),(518,416),(518,417),(518,418),(518,419),(531,419),(518,420),(546,420),(547,420),(548,420),(599,420),(608,420),(518,421),(531,421),(611,421),(519,422),(520,422),(519,423),(519,424),(520,424),(532,424),(535,424),(519,425),(519,426),(519,427),(546,427),(519,428),(520,428),(539,428),(519,429),(519,430),(519,431),(630,431),(636,431),(637,431),(663,431),(671,431),(519,432),(519,433),(630,433),(519,434),(519,435),(519,436),(519,437),(519,438),(519,439),(520,439),(519,440),(519,441),(519,442),(520,442),(604,442),(519,443),(519,444),(520,445),(532,445),(535,445),(520,446),(543,446),(549,446),(553,446),(521,447),(521,448),(521,449),(521,450),(521,451),(521,452),(551,452),(688,452),(522,453),(534,453),(630,453),(532,454),(538,455),(539,456),(541,456),(549,456),(553,456),(633,456),(666,456),(539,457),(543,457),(546,457),(547,457),(548,457),(553,457),(562,457),(539,458),(615,458),(618,458),(539,459),(551,459),(576,459),(655,459),(539,460),(541,460),(553,460),(636,460),(637,460),(656,460),(541,461),(590,461),(541,462),(595,462),(541,463),(541,464),(541,465),(593,465),(630,465),(658,465),(541,466),(541,467),(554,467),(555,467),(556,467),(557,467),(562,467),(563,467),(564,467),(677,467),(543,468),(545,468),(548,468),(543,469),(543,470),(549,470),(543,471),(546,471),(547,471),(549,471),(551,471),(553,471),(679,471),(543,472),(548,472),(549,472),(679,472),(543,473),(544,473),(548,473),(549,473),(684,473),(685,473),(686,473),(543,474),(548,474),(546,475),(547,475),(546,476),(546,477),(546,478),(630,478),(636,478),(637,478),(546,479),(547,479),(546,480),(547,480),(546,481),(679,481),(546,482),(547,482),(562,482),(614,482),(617,482),(618,482),(677,482),(546,483),(546,484),(546,485),(547,486),(599,486),(601,486),(547,487),(549,488),(552,488),(571,488),(599,488),(604,488),(606,488),(607,488),(609,488),(676,488),(679,488),(549,489),(551,489),(562,489),(599,489),(601,489),(604,489),(549,490),(549,491),(549,492),(569,492),(571,492),(573,492),(574,492),(591,492),(594,492),(595,492),(608,492),(613,492),(630,492),(666,492),(668,492),(677,492),(684,492),(685,492),(686,492),(549,493),(549,494),(551,494),(549,495),(549,496),(549,497),(549,498),(549,499),(549,500),(549,501),(549,502),(549,503),(549,504),(551,504),(550,505),(551,506),(551,507),(610,507),(612,507),(551,508),(551,509),(551,510),(551,511),(551,512),(554,513),(555,513),(556,513),(557,513),(554,514),(555,514),(556,514),(557,514),(564,514),(579,514),(554,515),(555,515),(556,515),(557,515),(554,516),(555,516),(556,516),(557,516),(564,516),(554,517),(555,517),(556,517),(557,517),(564,517),(554,518),(555,518),(556,518),(557,518),(563,518),(564,518),(554,519),(555,519),(556,519),(557,519),(558,519),(559,519),(560,519),(564,519),(554,520),(555,520),(556,520),(557,520),(558,520),(559,520),(560,520),(564,520),(554,521),(555,521),(556,521),(557,521),(564,521),(554,522),(555,522),(556,522),(557,522),(564,522),(573,522),(554,523),(555,523),(556,523),(557,523),(563,523),(554,524),(555,524),(556,524),(557,524),(554,525),(555,525),(556,525),(557,525),(562,525),(563,525),(564,525),(558,526),(559,526),(560,526),(561,527),(561,528),(562,528),(599,528),(601,528),(562,529),(630,529),(658,529),(671,529),(677,529),(563,530),(563,531),(572,531),(626,531),(669,531),(673,531),(563,532),(563,533),(563,534),(563,535),(563,536),(626,536),(669,536),(673,536),(563,537),(564,538),(575,538),(577,538),(578,538),(564,539),(564,540),(565,541),(566,541),(565,542),(566,542),(630,542),(631,542),(632,542),(677,542),(565,543),(566,543),(567,543),(569,543),(631,543),(632,543),(657,543),(680,543),(565,544),(566,544),(567,545),(571,545),(680,545),(681,545),(568,546),(569,547),(571,547),(573,547),(574,547),(666,547),(668,547),(677,547),(569,548),(569,549),(569,550),(569,551),(569,552),(569,553),(569,554),(569,555),(569,556),(569,557),(569,558),(569,559),(569,560),(569,561),(569,562),(569,563),(569,564),(569,565),(569,566),(569,567),(569,568),(569,569),(569,570),(569,571),(569,572),(569,573),(570,574),(570,575),(570,576),(570,577),(570,578),(570,579),(570,580),(570,581),(570,582),(604,582),(572,583),(573,584),(573,585),(574,585),(573,586),(573,587),(573,588),(573,589),(573,590),(574,590),(574,591),(576,592),(604,592),(577,593),(578,593),(581,594),(591,594),(594,594),(595,594),(583,595),(584,596),(585,597),(586,598),(587,599),(587,600),(588,601),(589,602),(591,603),(592,604),(594,605),(595,606),(595,607),(596,608),(597,608),(598,608),(596,609),(597,609),(598,609),(596,610),(597,610),(598,610),(596,611),(597,611),(598,611),(596,612),(597,612),(598,612),(596,613),(597,613),(598,613),(596,614),(597,614),(598,614),(596,615),(596,616),(596,617),(597,617),(598,617),(596,618),(597,618),(598,618),(596,619),(596,620),(596,621),(596,622),(597,622),(598,622),(596,623),(597,623),(598,623),(596,624),(597,624),(598,624),(597,625),(597,626),(598,626),(598,627),(599,628),(601,628),(599,629),(601,629),(599,630),(601,630),(608,630),(599,631),(601,631),(599,632),(601,632),(599,633),(601,633),(599,634),(601,634),(599,635),(601,635),(599,636),(601,636),(599,637),(601,637),(599,638),(601,638),(599,639),(601,639),(599,640),(604,640),(607,640),(609,640),(599,641),(599,642),(601,642),(599,643),(601,643),(599,644),(601,644),(608,644),(599,645),(601,645),(599,646),(608,646),(599,647),(601,647),(599,648),(600,648),(601,648),(602,648),(604,648),(607,648),(609,648),(599,649),(601,649),(599,650),(601,650),(599,651),(601,651),(599,652),(601,652),(604,653),(604,654),(604,655),(604,656),(606,656),(604,657),(606,657),(604,658),(606,658),(660,658),(677,658),(604,659),(604,660),(604,661),(683,661),(604,662),(604,663),(606,664),(606,665),(609,666),(610,667),(611,667),(612,667),(613,667),(610,668),(611,668),(610,669),(611,669),(614,670),(617,670),(618,670),(677,670),(615,671),(615,672),(618,673),(636,673),(637,673),(656,673),(671,673),(618,674),(619,675),(619,676),(619,677),(619,678),(621,679),(623,679),(621,680),(622,680),(622,681),(624,681),(630,681),(623,682),(624,682),(625,683),(626,684),(681,684),(626,685),(626,686),(627,687),(628,687),(629,688),(630,689),(635,689),(630,690),(647,690),(648,690),(630,691),(650,691),(630,692),(651,692),(630,693),(655,693),(630,694),(667,694),(677,694),(630,695),(630,696),(649,696),(630,697),(663,697),(630,698),(647,698),(648,698),(630,699),(631,699),(632,699),(633,699),(634,699),(635,699),(636,699),(637,699),(638,699),(639,699),(640,699),(641,699),(642,699),(643,699),(645,699),(647,699),(648,699),(649,699),(650,699),(651,699),(652,699),(653,699),(654,699),(655,699),(656,699),(657,699),(658,699),(659,699),(660,699),(661,699),(662,699),(663,699),(664,699),(665,699),(666,699),(667,699),(668,699),(669,699),(670,699),(671,699),(672,699),(673,699),(674,699),(630,700),(649,700),(654,700),(657,700),(662,700),(668,700),(669,700),(670,700),(677,700),(630,701),(672,701),(630,702),(673,702),(630,703),(674,703),(633,704),(675,704),(633,705),(652,705),(666,705),(650,706),(653,707),(661,707),(659,708),(664,709),(665,710),(666,711),(676,712),(679,712),(677,713),(677,714),(677,715),(677,716),(677,717),(677,718),(677,719),(677,720),(678,721),(679,722),(682,723),(684,724),(685,724),(686,724),(684,725),(685,725),(686,725),(684,726),(685,726),(686,726),(684,727),(685,727),(686,727),(684,728),(685,728),(686,728);
/*!40000 ALTER TABLE `help_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `help_topic`
--

DROP TABLE IF EXISTS `help_topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `help_topic` (
  `help_topic_id` int unsigned NOT NULL,
  `name` char(64) NOT NULL,
  `help_category_id` smallint unsigned NOT NULL,
  `description` text NOT NULL,
  `example` text NOT NULL,
  `url` text NOT NULL,
  PRIMARY KEY (`help_topic_id`),
  UNIQUE KEY `name` (`name`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='help topics';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `help_topic`
--

LOCK TABLES `help_topic` WRITE;
/*!40000 ALTER TABLE `help_topic` DISABLE KEYS */;
/*!40000 ALTER TABLE `help_topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `innodb_index_stats`
--

/*!40000 ALTER TABLE `innodb_index_stats` DISABLE KEYS */;
INSERT  IGNORE INTO `innodb_index_stats` VALUES ('bet','bookmaker','PRIMARY','2020-03-06 11:14:47','n_diff_pfx01',4,1,'id'),('bet','bookmaker','PRIMARY','2020-03-06 11:14:47','n_leaf_pages',1,NULL,'Number of leaf pages in the index'),('bet','bookmaker','PRIMARY','2020-03-06 11:14:47','size',1,NULL,'Number of pages in the index'),('bet','bookmaker','bookmaker_bookmaker_name','2020-03-06 11:14:47','n_diff_pfx01',4,1,'bookmaker_name'),('bet','bookmaker','bookmaker_bookmaker_name','2020-03-06 11:14:47','n_leaf_pages',1,NULL,'Number of leaf pages in the index'),('bet','bookmaker','bookmaker_bookmaker_name','2020-03-06 11:14:47','size',1,NULL,'Number of pages in the index'),('bet','competition','PRIMARY','2020-03-06 11:14:50','n_diff_pfx01',335,6,'id'),('bet','competition','PRIMARY','2020-03-06 11:14:50','n_leaf_pages',6,NULL,'Number of leaf pages in the index'),('bet','competition','PRIMARY','2020-03-06 11:14:50','size',7,NULL,'Number of pages in the index'),('bet','competition','active_idx','2020-03-06 11:14:50','n_diff_pfx01',2,1,'active'),('bet','competition','active_idx','2020-03-06 11:14:50','n_diff_pfx02',335,1,'active,id'),('bet','competition','active_idx','2020-03-06 11:14:50','n_leaf_pages',1,NULL,'Number of leaf pages in the index'),('bet','competition','active_idx','2020-03-06 11:14:50','size',1,NULL,'Number of pages in the index'),('bet','competition','bookmaker_event_id_idx','2020-03-06 11:14:50','n_diff_pfx01',335,1,'bookmaker_competition'),('bet','competition','bookmaker_event_id_idx','2020-03-06 11:14:50','n_diff_pfx02',335,1,'bookmaker_competition,id'),('bet','competition','bookmaker_event_id_idx','2020-03-06 11:14:50','n_leaf_pages',1,NULL,'Number of leaf pages in the index'),('bet','competition','bookmaker_event_id_idx','2020-03-06 11:14:50','size',1,NULL,'Number of pages in the index'),('bet','competition','competition_bookmaker_id','2020-03-06 11:14:50','n_diff_pfx01',4,1,'bookmaker_id'),('bet','competition','competition_bookmaker_id','2020-03-06 11:14:50','n_diff_pfx02',335,1,'bookmaker_id,id'),('bet','competition','competition_bookmaker_id','2020-03-06 11:14:50','n_leaf_pages',1,NULL,'Number of leaf pages in the index'),('bet','competition','competition_bookmaker_id','2020-03-06 11:14:50','size',1,NULL,'Number of pages in the index'),('bet','events_on_demand','PRIMARY','2020-03-06 11:14:53','n_diff_pfx01',58,1,'id'),('bet','events_on_demand','PRIMARY','2020-03-06 11:14:53','n_leaf_pages',1,NULL,'Number of leaf pages in the index'),('bet','events_on_demand','PRIMARY','2020-03-06 11:14:53','size',1,NULL,'Number of pages in the index'),('bet','events_on_demand','betway_event_id_UNIQUE','2020-03-06 11:14:53','n_diff_pfx01',1,1,'betway_event_id'),('bet','events_on_demand','betway_event_id_UNIQUE','2020-03-06 11:14:53','n_leaf_pages',1,NULL,'Number of leaf pages in the index'),('bet','events_on_demand','betway_event_id_UNIQUE','2020-03-06 11:14:53','size',1,NULL,'Number of pages in the index'),('bet','events_on_demand','bwin_event_id_UNIQUE','2020-03-06 11:14:53','n_diff_pfx01',1,1,'bwin_event_id'),('bet','events_on_demand','bwin_event_id_UNIQUE','2020-03-06 11:14:53','n_leaf_pages',1,NULL,'Number of leaf pages in the index'),('bet','events_on_demand','bwin_event_id_UNIQUE','2020-03-06 11:14:53','size',1,NULL,'Number of pages in the index'),('bet','events_on_demand','unibet_event_id_UNIQUE','2020-03-06 11:14:53','n_diff_pfx01',58,1,'unibet_event_id'),('bet','events_on_demand','unibet_event_id_UNIQUE','2020-03-06 11:14:53','n_leaf_pages',1,NULL,'Number of leaf pages in the index'),('bet','events_on_demand','unibet_event_id_UNIQUE','2020-03-06 11:14:53','size',1,NULL,'Number of pages in the index'),('bet','market','PRIMARY','2020-03-06 11:14:54','n_diff_pfx01',7,1,'id'),('bet','market','PRIMARY','2020-03-06 11:14:54','n_leaf_pages',1,NULL,'Number of leaf pages in the index'),('bet','market','PRIMARY','2020-03-06 11:14:54','size',1,NULL,'Number of pages in the index'),('bet','market','bookmaker_market_id','2020-03-06 11:14:54','n_diff_pfx01',7,1,'bookmaker_market'),('bet','market','bookmaker_market_id','2020-03-06 11:14:54','n_diff_pfx02',7,1,'bookmaker_market,id'),('bet','market','bookmaker_market_id','2020-03-06 11:14:54','n_leaf_pages',1,NULL,'Number of leaf pages in the index'),('bet','market','bookmaker_market_id','2020-03-06 11:14:54','size',1,NULL,'Number of pages in the index'),('bet','market','market_competition_id','2020-03-06 11:14:54','n_diff_pfx01',1,1,'competition_id'),('bet','market','market_competition_id','2020-03-06 11:14:54','n_diff_pfx02',7,1,'competition_id,id'),('bet','market','market_competition_id','2020-03-06 11:14:54','n_leaf_pages',1,NULL,'Number of leaf pages in the index'),('bet','market','market_competition_id','2020-03-06 11:14:54','size',1,NULL,'Number of pages in the index'),('bet','odds','PRIMARY','2020-03-06 11:14:52','n_diff_pfx01',0,1,'id'),('bet','odds','PRIMARY','2020-03-06 11:14:52','n_leaf_pages',1,NULL,'Number of leaf pages in the index'),('bet','odds','PRIMARY','2020-03-06 11:14:52','size',1,NULL,'Number of pages in the index'),('bet','odds','odds_outcome_id','2020-03-06 11:14:52','n_diff_pfx01',0,1,'outcome_id'),('bet','odds','odds_outcome_id','2020-03-06 11:14:52','n_diff_pfx02',0,1,'outcome_id,id'),('bet','odds','odds_outcome_id','2020-03-06 11:14:52','n_leaf_pages',1,NULL,'Number of leaf pages in the index'),('bet','odds','odds_outcome_id','2020-03-06 11:14:52','size',1,NULL,'Number of pages in the index'),('bet','odds','time_idx','2020-03-06 11:14:52','n_diff_pfx01',0,1,'odds_timestamp'),('bet','odds','time_idx','2020-03-06 11:14:52','n_diff_pfx02',0,1,'odds_timestamp,id'),('bet','odds','time_idx','2020-03-06 11:14:52','n_leaf_pages',1,NULL,'Number of leaf pages in the index'),('bet','odds','time_idx','2020-03-06 11:14:52','size',1,NULL,'Number of pages in the index'),('bet','outcome','PRIMARY','2020-03-06 11:14:54','n_diff_pfx01',0,1,'id'),('bet','outcome','PRIMARY','2020-03-06 11:14:54','n_leaf_pages',1,NULL,'Number of leaf pages in the index'),('bet','outcome','PRIMARY','2020-03-06 11:14:54','size',1,NULL,'Number of pages in the index'),('bet','outcome','bookmaker_outcome_idx','2020-03-06 11:14:54','n_diff_pfx01',0,1,'bookmaker_outcome'),('bet','outcome','bookmaker_outcome_idx','2020-03-06 11:14:54','n_diff_pfx02',0,1,'bookmaker_outcome,id'),('bet','outcome','bookmaker_outcome_idx','2020-03-06 11:14:54','n_leaf_pages',1,NULL,'Number of leaf pages in the index'),('bet','outcome','bookmaker_outcome_idx','2020-03-06 11:14:54','size',1,NULL,'Number of pages in the index'),('bet','outcome','outcome_market_id','2020-03-06 11:14:54','n_diff_pfx01',0,1,'market_id'),('bet','outcome','outcome_market_id','2020-03-06 11:14:54','n_diff_pfx02',0,1,'market_id,id'),('bet','outcome','outcome_market_id','2020-03-06 11:14:54','n_leaf_pages',1,NULL,'Number of leaf pages in the index'),('bet','outcome','outcome_market_id','2020-03-06 11:14:54','size',1,NULL,'Number of pages in the index'),('mysql','component','PRIMARY','2020-03-06 11:13:38','n_diff_pfx01',0,1,'component_id'),('mysql','component','PRIMARY','2020-03-06 11:13:38','n_leaf_pages',1,NULL,'Number of leaf pages in the index'),('mysql','component','PRIMARY','2020-03-06 11:13:38','size',1,NULL,'Number of pages in the index'),('mysql','gtid_executed','PRIMARY','2020-03-06 11:14:45','n_diff_pfx01',1,1,'source_uuid'),('mysql','gtid_executed','PRIMARY','2020-03-06 11:14:45','n_diff_pfx02',2,1,'source_uuid,interval_start'),('mysql','gtid_executed','PRIMARY','2020-03-06 11:14:45','n_leaf_pages',1,NULL,'Number of leaf pages in the index'),('mysql','gtid_executed','PRIMARY','2020-03-06 11:14:45','size',1,NULL,'Number of pages in the index'),('sys','sys_config','PRIMARY','2020-03-06 11:13:48','n_diff_pfx01',6,1,'variable'),('sys','sys_config','PRIMARY','2020-03-06 11:13:48','n_leaf_pages',1,NULL,'Number of leaf pages in the index'),('sys','sys_config','PRIMARY','2020-03-06 11:13:48','size',1,NULL,'Number of pages in the index');
/*!40000 ALTER TABLE `innodb_index_stats` ENABLE KEYS */;

--
-- Dumping data for table `innodb_table_stats`
--

/*!40000 ALTER TABLE `innodb_table_stats` DISABLE KEYS */;
INSERT  IGNORE INTO `innodb_table_stats` VALUES ('bet','bookmaker','2020-03-06 11:14:47',4,1,1),('bet','competition','2020-03-06 11:14:50',335,7,3),('bet','events_on_demand','2020-03-06 11:14:53',58,1,3),('bet','market','2020-03-06 11:14:54',7,1,2),('bet','odds','2020-03-06 11:14:52',0,1,2),('bet','outcome','2020-03-06 11:14:54',0,1,2),('mysql','component','2020-03-06 11:13:38',0,1,0),('mysql','gtid_executed','2020-03-06 11:14:45',2,1,0),('sys','sys_config','2020-03-06 11:13:48',6,1,0);
/*!40000 ALTER TABLE `innodb_table_stats` ENABLE KEYS */;

--
-- Table structure for table `password_history`
--

DROP TABLE IF EXISTS `password_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_history` (
  `Host` char(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `User` char(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Password_timestamp` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `Password` text COLLATE utf8_bin,
  PRIMARY KEY (`Host`,`User`,`Password_timestamp` DESC)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Password history for user accounts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_history`
--

LOCK TABLES `password_history` WRITE;
/*!40000 ALTER TABLE `password_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plugin`
--

DROP TABLE IF EXISTS `plugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plugin` (
  `name` varchar(64) NOT NULL DEFAULT '',
  `dl` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`name`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='MySQL plugins';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plugin`
--

LOCK TABLES `plugin` WRITE;
/*!40000 ALTER TABLE `plugin` DISABLE KEYS */;
/*!40000 ALTER TABLE `plugin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `procs_priv`
--

DROP TABLE IF EXISTS `procs_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `procs_priv` (
  `Host` char(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `Db` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `User` char(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Routine_name` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `Routine_type` enum('FUNCTION','PROCEDURE') COLLATE utf8_bin NOT NULL,
  `Grantor` varchar(288) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Proc_priv` set('Execute','Alter Routine','Grant') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Host`,`Db`,`User`,`Routine_name`,`Routine_type`),
  KEY `Grantor` (`Grantor`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Procedure privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `procs_priv`
--

LOCK TABLES `procs_priv` WRITE;
/*!40000 ALTER TABLE `procs_priv` DISABLE KEYS */;
/*!40000 ALTER TABLE `procs_priv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proxies_priv`
--

DROP TABLE IF EXISTS `proxies_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proxies_priv` (
  `Host` char(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `User` char(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Proxied_host` char(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `Proxied_user` char(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `With_grant` tinyint(1) NOT NULL DEFAULT '0',
  `Grantor` varchar(288) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Host`,`User`,`Proxied_host`,`Proxied_user`),
  KEY `Grantor` (`Grantor`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='User proxy privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxies_priv`
--

LOCK TABLES `proxies_priv` WRITE;
/*!40000 ALTER TABLE `proxies_priv` DISABLE KEYS */;
INSERT INTO `proxies_priv` VALUES ('localhost','root','','',1,'boot@','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `proxies_priv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_edges`
--

DROP TABLE IF EXISTS `role_edges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_edges` (
  `FROM_HOST` char(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `FROM_USER` char(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `TO_HOST` char(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `TO_USER` char(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `WITH_ADMIN_OPTION` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  PRIMARY KEY (`FROM_HOST`,`FROM_USER`,`TO_HOST`,`TO_USER`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Role hierarchy and role grants';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_edges`
--

LOCK TABLES `role_edges` WRITE;
/*!40000 ALTER TABLE `role_edges` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_edges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server_cost`
--

DROP TABLE IF EXISTS `server_cost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `server_cost` (
  `cost_name` varchar(64) NOT NULL,
  `cost_value` float DEFAULT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `comment` varchar(1024) DEFAULT NULL,
  `default_value` float GENERATED ALWAYS AS ((case `cost_name` when _utf8mb3'disk_temptable_create_cost' then 20.0 when _utf8mb3'disk_temptable_row_cost' then 0.5 when _utf8mb3'key_compare_cost' then 0.05 when _utf8mb3'memory_temptable_create_cost' then 1.0 when _utf8mb3'memory_temptable_row_cost' then 0.1 when _utf8mb3'row_evaluate_cost' then 0.1 else NULL end)) VIRTUAL,
  PRIMARY KEY (`cost_name`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server_cost`
--

LOCK TABLES `server_cost` WRITE;
/*!40000 ALTER TABLE `server_cost` DISABLE KEYS */;
INSERT INTO `server_cost` (`cost_name`, `cost_value`, `last_update`, `comment`) VALUES ('disk_temptable_create_cost',NULL,'2020-03-06 11:13:39',NULL),('disk_temptable_row_cost',NULL,'2020-03-06 11:13:39',NULL),('key_compare_cost',NULL,'2020-03-06 11:13:39',NULL),('memory_temptable_create_cost',NULL,'2020-03-06 11:13:39',NULL),('memory_temptable_row_cost',NULL,'2020-03-06 11:13:39',NULL),('row_evaluate_cost',NULL,'2020-03-06 11:13:39',NULL);
/*!40000 ALTER TABLE `server_cost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servers`
--

DROP TABLE IF EXISTS `servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servers` (
  `Server_name` char(64) NOT NULL DEFAULT '',
  `Host` char(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `Db` char(64) NOT NULL DEFAULT '',
  `Username` char(64) NOT NULL DEFAULT '',
  `Password` char(64) NOT NULL DEFAULT '',
  `Port` int NOT NULL DEFAULT '0',
  `Socket` char(64) NOT NULL DEFAULT '',
  `Wrapper` char(64) NOT NULL DEFAULT '',
  `Owner` char(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`Server_name`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='MySQL Foreign Servers table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servers`
--

LOCK TABLES `servers` WRITE;
/*!40000 ALTER TABLE `servers` DISABLE KEYS */;
/*!40000 ALTER TABLE `servers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slave_master_info`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `slave_master_info` (
  `Number_of_lines` int unsigned NOT NULL COMMENT 'Number of lines in the file.',
  `Master_log_name` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The name of the master binary log currently being read from the master.',
  `Master_log_pos` bigint unsigned NOT NULL COMMENT 'The master log position of the last read event.',
  `Host` char(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL COMMENT 'The host name of the master.',
  `User_name` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The user name used to connect to the master.',
  `User_password` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The password used to connect to the master.',
  `Port` int unsigned NOT NULL COMMENT 'The network port used to connect to the master.',
  `Connect_retry` int unsigned NOT NULL COMMENT 'The period (in seconds) that the slave will wait before trying to reconnect to the master.',
  `Enabled_ssl` tinyint(1) NOT NULL COMMENT 'Indicates whether the server supports SSL connections.',
  `Ssl_ca` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The file used for the Certificate Authority (CA) certificate.',
  `Ssl_capath` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The path to the Certificate Authority (CA) certificates.',
  `Ssl_cert` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The name of the SSL certificate file.',
  `Ssl_cipher` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The name of the cipher in use for the SSL connection.',
  `Ssl_key` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The name of the SSL key file.',
  `Ssl_verify_server_cert` tinyint(1) NOT NULL COMMENT 'Whether to verify the server certificate.',
  `Heartbeat` float NOT NULL,
  `Bind` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'Displays which interface is employed when connecting to the MySQL server',
  `Ignored_server_ids` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The number of server IDs to be ignored, followed by the actual server IDs',
  `Uuid` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The master server uuid.',
  `Retry_count` bigint unsigned NOT NULL COMMENT 'Number of reconnect attempts, to the master, before giving up.',
  `Ssl_crl` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The file used for the Certificate Revocation List (CRL)',
  `Ssl_crlpath` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The path used for Certificate Revocation List (CRL) files',
  `Enabled_auto_position` tinyint(1) NOT NULL COMMENT 'Indicates whether GTIDs will be used to retrieve events from the master.',
  `Channel_name` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'The channel on which the slave is connected to a source. Used in Multisource Replication',
  `Tls_version` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'Tls version',
  `Public_key_path` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The file containing public key of master server.',
  `Get_public_key` tinyint(1) NOT NULL COMMENT 'Preference to get public key from master.',
  `Network_namespace` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'Network namespace used for communication with the master server.',
  `Master_compression_algorithm` char(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'Compression algorithm supported for data transfer between master and slave.',
  `Master_zstd_compression_level` int unsigned NOT NULL COMMENT 'Compression level associated with zstd compression algorithm.',
  `Tls_ciphersuites` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'Ciphersuites used for TLS 1.3 communication with the master server.',
  PRIMARY KEY (`Channel_name`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Master Information';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `slave_relay_log_info`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `slave_relay_log_info` (
  `Number_of_lines` int unsigned NOT NULL COMMENT 'Number of lines in the file or rows in the table. Used to version table definitions.',
  `Relay_log_name` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The name of the current relay log file.',
  `Relay_log_pos` bigint unsigned DEFAULT NULL COMMENT 'The relay log position of the last executed event.',
  `Master_log_name` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'The name of the master binary log file from which the events in the relay log file were read.',
  `Master_log_pos` bigint unsigned DEFAULT NULL COMMENT 'The master log position of the last executed event.',
  `Sql_delay` int DEFAULT NULL COMMENT 'The number of seconds that the slave must lag behind the master.',
  `Number_of_workers` int unsigned DEFAULT NULL,
  `Id` int unsigned DEFAULT NULL COMMENT 'Internal Id that uniquely identifies this record.',
  `Channel_name` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'The channel on which the slave is connected to a source. Used in Multisource Replication',
  `Privilege_checks_username` char(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'Username part of PRIVILEGE_CHECKS_USER.',
  `Privilege_checks_hostname` char(255) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL COMMENT 'Hostname part of PRIVILEGE_CHECKS_USER.',
  `Require_row_format` tinyint(1) NOT NULL COMMENT 'Indicates whether the channel shall only accept row based events.',
  PRIMARY KEY (`Channel_name`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Relay Log Information';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `slave_worker_info`
--

DROP TABLE IF EXISTS `slave_worker_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `slave_worker_info` (
  `Id` int unsigned NOT NULL,
  `Relay_log_name` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Relay_log_pos` bigint unsigned NOT NULL,
  `Master_log_name` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Master_log_pos` bigint unsigned NOT NULL,
  `Checkpoint_relay_log_name` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Checkpoint_relay_log_pos` bigint unsigned NOT NULL,
  `Checkpoint_master_log_name` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Checkpoint_master_log_pos` bigint unsigned NOT NULL,
  `Checkpoint_seqno` int unsigned NOT NULL,
  `Checkpoint_group_size` int unsigned NOT NULL,
  `Checkpoint_group_bitmap` blob NOT NULL,
  `Channel_name` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'The channel on which the slave is connected to a source. Used in Multisource Replication',
  PRIMARY KEY (`Channel_name`,`Id`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Worker Information';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slave_worker_info`
--

LOCK TABLES `slave_worker_info` WRITE;
/*!40000 ALTER TABLE `slave_worker_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `slave_worker_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tables_priv`
--

DROP TABLE IF EXISTS `tables_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tables_priv` (
  `Host` char(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `Db` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `User` char(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Table_name` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Grantor` varchar(288) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Table_priv` set('Select','Insert','Update','Delete','Create','Drop','Grant','References','Index','Alter','Create View','Show view','Trigger') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `Column_priv` set('Select','Insert','Update','References') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`Host`,`Db`,`User`,`Table_name`),
  KEY `Grantor` (`Grantor`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Table privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tables_priv`
--

LOCK TABLES `tables_priv` WRITE;
/*!40000 ALTER TABLE `tables_priv` DISABLE KEYS */;
INSERT INTO `tables_priv` VALUES ('localhost','mysql','mysql.session','user','boot@','0000-00-00 00:00:00','Select',''),('localhost','sys','mysql.sys','sys_config','root@localhost','2020-03-06 11:13:47','Select','');
/*!40000 ALTER TABLE `tables_priv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_zone`
--

DROP TABLE IF EXISTS `time_zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `time_zone` (
  `Time_zone_id` int unsigned NOT NULL AUTO_INCREMENT,
  `Use_leap_seconds` enum('Y','N') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  PRIMARY KEY (`Time_zone_id`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Time zones';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_zone`
--

LOCK TABLES `time_zone` WRITE;
/*!40000 ALTER TABLE `time_zone` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_zone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_zone_leap_second`
--

DROP TABLE IF EXISTS `time_zone_leap_second`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `time_zone_leap_second` (
  `Transition_time` bigint NOT NULL,
  `Correction` int NOT NULL,
  PRIMARY KEY (`Transition_time`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Leap seconds information for time zones';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_zone_leap_second`
--

LOCK TABLES `time_zone_leap_second` WRITE;
/*!40000 ALTER TABLE `time_zone_leap_second` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_zone_leap_second` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_zone_name`
--

DROP TABLE IF EXISTS `time_zone_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `time_zone_name` (
  `Name` char(64) NOT NULL,
  `Time_zone_id` int unsigned NOT NULL,
  PRIMARY KEY (`Name`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Time zone names';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_zone_name`
--

LOCK TABLES `time_zone_name` WRITE;
/*!40000 ALTER TABLE `time_zone_name` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_zone_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_zone_transition`
--

DROP TABLE IF EXISTS `time_zone_transition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `time_zone_transition` (
  `Time_zone_id` int unsigned NOT NULL,
  `Transition_time` bigint NOT NULL,
  `Transition_type_id` int unsigned NOT NULL,
  PRIMARY KEY (`Time_zone_id`,`Transition_time`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Time zone transitions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_zone_transition`
--

LOCK TABLES `time_zone_transition` WRITE;
/*!40000 ALTER TABLE `time_zone_transition` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_zone_transition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_zone_transition_type`
--

DROP TABLE IF EXISTS `time_zone_transition_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `time_zone_transition_type` (
  `Time_zone_id` int unsigned NOT NULL,
  `Transition_type_id` int unsigned NOT NULL,
  `Offset` int NOT NULL DEFAULT '0',
  `Is_DST` tinyint unsigned NOT NULL DEFAULT '0',
  `Abbreviation` char(8) NOT NULL DEFAULT '',
  PRIMARY KEY (`Time_zone_id`,`Transition_type_id`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Time zone transition types';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_zone_transition_type`
--

LOCK TABLES `time_zone_transition_type` WRITE;
/*!40000 ALTER TABLE `time_zone_transition_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_zone_transition_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `Host` char(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
  `User` char(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Select_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Insert_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Update_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Delete_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Create_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Drop_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Reload_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Shutdown_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Process_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `File_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Grant_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `References_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Index_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Alter_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Show_db_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Super_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Create_tmp_table_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Lock_tables_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Execute_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Repl_slave_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Repl_client_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Create_view_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Show_view_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Create_routine_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Alter_routine_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Create_user_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Event_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Trigger_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Create_tablespace_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `ssl_type` enum('','ANY','X509','SPECIFIED') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `ssl_cipher` blob NOT NULL,
  `x509_issuer` blob NOT NULL,
  `x509_subject` blob NOT NULL,
  `max_questions` int unsigned NOT NULL DEFAULT '0',
  `max_updates` int unsigned NOT NULL DEFAULT '0',
  `max_connections` int unsigned NOT NULL DEFAULT '0',
  `max_user_connections` int unsigned NOT NULL DEFAULT '0',
  `plugin` char(64) COLLATE utf8_bin NOT NULL DEFAULT 'caching_sha2_password',
  `authentication_string` text COLLATE utf8_bin,
  `password_expired` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `password_last_changed` timestamp NULL DEFAULT NULL,
  `password_lifetime` smallint unsigned DEFAULT NULL,
  `account_locked` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Create_role_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Drop_role_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Password_reuse_history` smallint unsigned DEFAULT NULL,
  `Password_reuse_time` smallint unsigned DEFAULT NULL,
  `Password_require_current` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `User_attributes` json DEFAULT NULL,
  PRIMARY KEY (`Host`,`User`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='Users and global privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('%','repl_user','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','Y','N','N','N','N','N','N','Y','N','N','','','','',0,0,0,0,'mysql_native_password','*150FFF8907B428FF911495B0A36441D81DF3AF61','N','2020-03-06 11:14:55',NULL,'N','N','N',NULL,NULL,NULL,NULL),('localhost','mysql.infoschema','Y','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','','','','',0,0,0,0,'caching_sha2_password','$A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED','N','2020-03-06 11:13:47',NULL,'Y','N','N',NULL,NULL,NULL,NULL),('localhost','mysql.session','N','N','N','N','N','N','N','Y','N','N','N','N','N','N','N','Y','N','N','N','N','N','N','N','N','N','N','N','N','N','','','','',0,0,0,0,'caching_sha2_password','$A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED','N','2020-03-06 11:13:46',NULL,'Y','N','N',NULL,NULL,NULL,NULL),('localhost','mysql.sys','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','','','','',0,0,0,0,'caching_sha2_password','$A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED','N','2020-03-06 11:13:47',NULL,'Y','N','N',NULL,NULL,NULL,NULL),('localhost','root','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','','','','',0,0,0,0,'caching_sha2_password','$A$005$@J\n`/!;6r\r7;S\\h034G4ggx9g2wdupU20Xh2NpTMqbUtVATtPt5vcMOt3','N','2020-03-06 11:14:45',NULL,'N','Y','Y',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'mysql'
--

--
-- Dumping routines for database 'mysql'
--

--
-- Table structure for table `general_log`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `general_log` (
  `event_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `user_host` mediumtext NOT NULL,
  `thread_id` bigint unsigned NOT NULL,
  `server_id` int unsigned NOT NULL,
  `command_type` varchar(64) NOT NULL,
  `argument` mediumblob NOT NULL
) ENGINE=CSV DEFAULT CHARSET=utf8 COMMENT='General log';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `slow_log`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `slow_log` (
  `start_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `user_host` mediumtext NOT NULL,
  `query_time` time(6) NOT NULL,
  `lock_time` time(6) NOT NULL,
  `rows_sent` int NOT NULL,
  `rows_examined` int NOT NULL,
  `db` varchar(512) NOT NULL,
  `last_insert_id` int NOT NULL,
  `insert_id` int NOT NULL,
  `server_id` int unsigned NOT NULL,
  `sql_text` mediumblob NOT NULL,
  `thread_id` bigint unsigned NOT NULL
) ENGINE=CSV DEFAULT CHARSET=utf8 COMMENT='Slow log';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Current Database: `bet`
--

USE `bet`;

--
-- Final view structure for view `v_same_event`
--

/*!50001 DROP VIEW IF EXISTS `v_same_event`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`betscraper`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_same_event` AS select `c`.`sortname` AS `sortname`,count(1) AS `cnt`,max(if((`c`.`bookmaker_id` = 3),`c`.`id`,0)) AS `bk1`,max(if((`c`.`bookmaker_id` = 4),`c`.`id`,0)) AS `bk2`,max(if((`c`.`bookmaker_id` = 5),`c`.`id`,0)) AS `bk3`,max(if((`c`.`bookmaker_id` = 3),`c`.`bookmaker_competition`,0)) AS `bk1_event`,max(if((`c`.`bookmaker_id` = 4),`c`.`bookmaker_competition`,0)) AS `bk2_event`,max(if((`c`.`bookmaker_id` = 5),`c`.`bookmaker_competition`,0)) AS `bk3_event`,`c`.`match_date` AS `match_date`,max(`c`.`_updated`) AS `last_updated` from `competition` `c` group by `c`.`sortname`,`c`.`match_date` having (`cnt` > 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Current Database: `mysql`
--

USE `mysql`;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!50606 SET GLOBAL INNODB_STATS_AUTO_RECALC=@OLD_INNODB_STATS_AUTO_RECALC */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-07  0:14:57