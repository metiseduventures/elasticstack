-- MySQL dump 10.17  Distrib 10.3.21-MariaDB, for Linux (x86_64)
--
-- Host: bigservicedb-stag1.cgit7qfnncrf.us-east-1.rds.amazonaws.com    Database: globalconfig
-- ------------------------------------------------------
-- Server version	5.7.26-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `youtube_videos_playlist_id`
--

DROP TABLE IF EXISTS `youtube_videos_playlist_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `youtube_videos_playlist_id` (
  `id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `youtube_videos_playlist_id`
--

LOCK TABLES `youtube_videos_playlist_id` WRITE;
/*!40000 ALTER TABLE `youtube_videos_playlist_id` DISABLE KEYS */;
INSERT INTO `youtube_videos_playlist_id` VALUES ('BANKING-AWARENESS'),('CHILD DEVELOPMENT & PEDAGOGY'),('CIVIL'),('COMPUTERS'),('CURRENT-AFFAIRS'),('ECONOMICS'),('ELECTRICAL'),('ELECTRONICS'),('ENGLISH'),('EXAM-ANALYSIS-AND-NOTIFICATION'),('GENERAL-AWARENESS'),('GENERAL-STUDIES'),('HINDI'),('HISTORY'),('MATHS'),('MECHANICAL'),('MISCELLANEOUS'),('QUANTITATIVE APTITUDE'),('REASONING'),('SCIENCE'),('SOCIAL SCIENCE'),('STATIC-AWARENESS'),('SUCCESS-STORIES');
/*!40000 ALTER TABLE `youtube_videos_playlist_id` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-18  0:01:20
