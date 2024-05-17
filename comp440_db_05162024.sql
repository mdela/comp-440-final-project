-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: localhost    Database: comp440
-- ------------------------------------------------------
-- Server version	8.0.36-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genres` (
  `genre_id` int NOT NULL AUTO_INCREMENT,
  `genre_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`genre_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
INSERT INTO `genres` VALUES (1,'Action'),(2,'Comedy'),(3,'Drama'),(4,'Fantasy'),(5,'Horror'),(6,'Romance'),(7,'Science Fiction'),(8,'Documentary');
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location` (
  `location_id` int NOT NULL AUTO_INCREMENT,
  `location_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`location_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (1,'Home'),(2,'Movie Theatre'),(3,'Online');
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie_genres`
--

DROP TABLE IF EXISTS `movie_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie_genres` (
  `movie_id` int NOT NULL,
  `genre_id` int NOT NULL,
  PRIMARY KEY (`movie_id`,`genre_id`),
  KEY `genre_id` (`genre_id`),
  CONSTRAINT `movie_genres_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`movie_id`),
  CONSTRAINT `movie_genres_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`genre_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie_genres`
--

LOCK TABLES `movie_genres` WRITE;
/*!40000 ALTER TABLE `movie_genres` DISABLE KEYS */;
INSERT INTO `movie_genres` VALUES (3,1),(4,1),(5,1),(1,2),(2,2),(3,2),(8,2),(9,2),(1,3),(2,3),(5,3),(8,3),(2,4),(3,4),(6,4),(7,4),(1,5),(4,5),(2,6),(9,7);
/*!40000 ALTER TABLE `movie_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie_watchlists`
--

DROP TABLE IF EXISTS `movie_watchlists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie_watchlists` (
  `movie_id` int NOT NULL,
  `watchlist_id` int NOT NULL,
  PRIMARY KEY (`movie_id`,`watchlist_id`),
  KEY `watchlist_id` (`watchlist_id`),
  CONSTRAINT `movie_watchlists_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`movie_id`) ON DELETE CASCADE,
  CONSTRAINT `movie_watchlists_ibfk_2` FOREIGN KEY (`watchlist_id`) REFERENCES `watchlist` (`watchlist_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie_watchlists`
--

LOCK TABLES `movie_watchlists` WRITE;
/*!40000 ALTER TABLE `movie_watchlists` DISABLE KEYS */;
INSERT INTO `movie_watchlists` VALUES (3,3),(4,4),(5,4),(6,5),(7,5);
/*!40000 ALTER TABLE `movie_watchlists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movies`
--

DROP TABLE IF EXISTS `movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movies` (
  `movie_id` int NOT NULL AUTO_INCREMENT,
  `movie_title` varchar(255) NOT NULL,
  `movie_year` int NOT NULL,
  `status_id` int DEFAULT '1',
  `location_id` int DEFAULT NULL,
  PRIMARY KEY (`movie_id`),
  KEY `location_id` (`location_id`),
  KEY `movies_ibfk_1` (`status_id`),
  CONSTRAINT `movies_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `status` (`status_id`),
  CONSTRAINT `movies_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movies`
--

LOCK TABLES `movies` WRITE;
/*!40000 ALTER TABLE `movies` DISABLE KEYS */;
INSERT INTO `movies` VALUES (1,'Beau is Afraid',2023,4,1),(2,'Poor Things',2023,4,1),(3,'Kung Fu Panda 4',2024,4,2),(4,'The Descent',2006,4,1),(5,'Civil War',2024,4,2),(6,'The Lord of the Rings: The Fellowship of the Ring',2001,1,NULL),(7,'Harry Potter and the Sorcerer\'s Stone',2001,1,NULL),(8,'Network',1972,4,3),(9,'Toy Story',1995,4,1);
/*!40000 ALTER TABLE `movies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `review_id` int NOT NULL AUTO_INCREMENT,
  `movie_id` int NOT NULL,
  `review_rating` int NOT NULL,
  `review_title` varchar(255) NOT NULL,
  `review_description` text NOT NULL,
  `review_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`review_id`),
  KEY `reviews_ibfk_1` (`movie_id`),
  KEY `fk_user_id` (`user_id`),
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`movie_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (3,3,1,'Not Good','Pretty bad movie ngl shoulda stayed as a trilogy.','2024-04-19 17:33:48',2),(4,4,5,'Amazing','I think it encapsulates everything I love about horror movies, and it\'s extremely well-made.','2024-04-21 10:58:19',2),(5,5,1,'Misleading title','Was expecting Abraham Lincoln... smh','2024-05-06 00:00:58',1),(6,3,3,'False advertising but good','Was expecting 4 pandas, only got 1. Good movie though.','2024-05-06 00:15:49',3),(7,1,5,'I did not watch this movie','I don\'t know why I\'m here','2024-05-06 00:53:50',3),(8,1,5,'10 out of 10','Beau WAS afraid.','2024-05-06 22:40:12',4),(9,2,5,'Excellent','Phenomenal performances all around!','2024-05-06 22:41:22',4),(10,8,1,'I want to watch this','Is it okay to make a review for a movie I haven\'t seed?','2024-05-07 11:56:57',5),(11,9,5,'It was awesome','End of story','2024-05-07 21:30:11',5);
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status` (
  `status_id` int NOT NULL AUTO_INCREMENT,
  `status_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` VALUES (1,'Planning to Watch'),(2,'Watching'),(3,'Watched'),(4,'Reviewed');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'allie734','scrypt:32768:8:1$JVs7l4ZTYiO80zbZ$4fa45fcb5c367ab5481955928d0ca3fc20c3a0b61c51f0a9b56a443388ed0ad6c99b84e6d1db593836605410c37d1751c79aaf9e5a051d89f0d4ff04515d6cea'),(2,'allie841','scrypt:32768:8:1$O97daCdNStUuj5Fa$250b38d628e0203e4e98e03c156a1b0d1369eace150ce31945d990469ee2714729aa39b442ea3d7571ba8d80e07e43894aa8533dd125a661c8d1536e404c489b'),(3,'arnold1212','scrypt:32768:8:1$iurnfpIvGNUsSQMZ$58fb903ff92a3fb4ca7590f0cf8a2e6ac817906934f140a592c42762305e476cf3e7a94e5192355d71270d6711a3a08912039dfddee0847e472b1bca721a95d2'),(4,'allie1038','scrypt:32768:8:1$DEZS3SUZXCKByAbn$904f1c87aab60c12456bdf462e915539e4121fd76fbcfcdf9862b66b74ce8c4ba3766599269712e5dea0a587ab4f7a1f05d05380edcbc33f5b13e319bb16db04'),(5,'allie1155','scrypt:32768:8:1$nLM6BED8GfWsqsnw$099a748a724d52f53edb4008a189d89193c67e581f071fb564e4cf613b2d81d3c3961774832229f476c45b48e62a5e946502e8196384aaf86348c4c2f5c2863b'),(6,'allie931','scrypt:32768:8:1$RtLkEuvjNJS1hhYC$7e073ea757339bf70fdda153f5ebf0a7f418cdbe4788b2bff9420f87dc5228dd9f531971a0e1512958f6535d10939d70621365f3ce38edcef2fc237fedf8cf61');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `watchlist`
--

DROP TABLE IF EXISTS `watchlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `watchlist` (
  `watchlist_id` int NOT NULL AUTO_INCREMENT,
  `watchlist_name` varchar(255) DEFAULT NULL,
  `user_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`watchlist_id`),
  KEY `fk_watchlist_user_id` (`user_id`),
  CONSTRAINT `fk_watchlist_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `watchlist`
--

LOCK TABLES `watchlist` WRITE;
/*!40000 ALTER TABLE `watchlist` DISABLE KEYS */;
INSERT INTO `watchlist` VALUES (3,'My Cartoons Watchlist',NULL),(4,'My Friend\'s Horror Watchlist',NULL),(5,'Movies that came out in 2001 and also have wizards in them',1);
/*!40000 ALTER TABLE `watchlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-16 18:31:41
