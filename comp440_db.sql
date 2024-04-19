-- MySQL dump 10.13  Distrib 8.0.31, for macos12 (x86_64)
--
-- Host: 127.0.0.1    Database: review_movies
-- ------------------------------------------------------
-- Server version	8.0.31

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

DROP TABLE IF EXISTS genres;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE genres (
  genre_id int NOT NULL AUTO_INCREMENT,
  genre_description varchar(255) DEFAULT NULL,
  PRIMARY KEY (genre_id)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES genres WRITE;
/*!40000 ALTER TABLE genres DISABLE KEYS */;
INSERT INTO genres VALUES (1,'Action'),(2,'Comedy'),(3,'Drama'),(4,'Fantasy'),(5,'Horror'),(6,'Romance'),(7,'Science Fiction'),(8,'Documentary');
/*!40000 ALTER TABLE genres ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS location;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE location (
  location_id int NOT NULL AUTO_INCREMENT,
  location_name varchar(255) DEFAULT NULL,
  PRIMARY KEY (location_id)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES location WRITE;
/*!40000 ALTER TABLE location DISABLE KEYS */;
INSERT INTO location VALUES (1,'Home'),(2,'Movie Theatre'),(3,'Online');
/*!40000 ALTER TABLE location ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie_genres`
--

DROP TABLE IF EXISTS movie_genres;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE movie_genres (
  movie_id int NOT NULL,
  genre_id int NOT NULL,
  PRIMARY KEY (movie_id,genre_id),
  KEY genre_id (genre_id),
  CONSTRAINT movie_genres_ibfk_1 FOREIGN KEY (movie_id) REFERENCES movies (movie_id),
  CONSTRAINT movie_genres_ibfk_2 FOREIGN KEY (genre_id) REFERENCES genres (genre_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie_genres`
--

LOCK TABLES movie_genres WRITE;
/*!40000 ALTER TABLE movie_genres DISABLE KEYS */;
INSERT INTO movie_genres VALUES (3,1),(1,2),(2,2),(3,2),(1,3),(2,3),(2,4),(3,4),(1,5),(2,6);
/*!40000 ALTER TABLE movie_genres ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie_watchlists`
--

DROP TABLE IF EXISTS movie_watchlists;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE movie_watchlists (
  movie_id int NOT NULL,
  watchlist_id int NOT NULL,
  PRIMARY KEY (movie_id,watchlist_id),
  KEY watchlist_id (watchlist_id),
  CONSTRAINT movie_watchlists_ibfk_1 FOREIGN KEY (movie_id) REFERENCES movies (movie_id) ON DELETE CASCADE,
  CONSTRAINT movie_watchlists_ibfk_2 FOREIGN KEY (watchlist_id) REFERENCES watchlist (watchlist_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie_watchlists`
--

LOCK TABLES movie_watchlists WRITE;
/*!40000 ALTER TABLE movie_watchlists DISABLE KEYS */;
INSERT INTO movie_watchlists VALUES (3,1);
/*!40000 ALTER TABLE movie_watchlists ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movies`
--

DROP TABLE IF EXISTS movies;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE movies (
  movie_id int NOT NULL AUTO_INCREMENT,
  movie_title varchar(255) NOT NULL,
  movie_year int NOT NULL,
  status_id int DEFAULT NULL,
  location_id int DEFAULT NULL,
  PRIMARY KEY (movie_id),
  KEY status_id (status_id),
  KEY location_id (location_id),
  CONSTRAINT movies_ibfk_1 FOREIGN KEY (status_id) REFERENCES `status` (status_id),
  CONSTRAINT movies_ibfk_2 FOREIGN KEY (location_id) REFERENCES location (location_id) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movies`
--

LOCK TABLES movies WRITE;
/*!40000 ALTER TABLE movies DISABLE KEYS */;
INSERT INTO movies VALUES (1,'Beau is Afraid',2023,1,2),(2,'Poor Things',2023,1,NULL),(3,'Kung Fu Panda 4',2024,1,NULL);
/*!40000 ALTER TABLE movies ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS reviews;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE reviews (
  review_id int NOT NULL AUTO_INCREMENT,
  movie_id int NOT NULL,
  review_rating int NOT NULL,
  review_title varchar(255) NOT NULL,
  review_description text NOT NULL,
  review_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (review_id),
  KEY reviews_ibfk_1 (movie_id),
  CONSTRAINT reviews_ibfk_1 FOREIGN KEY (movie_id) REFERENCES movies (movie_id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES reviews WRITE;
/*!40000 ALTER TABLE reviews DISABLE KEYS */;
/*!40000 ALTER TABLE reviews ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS status;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status` (
  status_id int NOT NULL AUTO_INCREMENT,
  status_description varchar(255) DEFAULT NULL,
  PRIMARY KEY (status_id)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES status WRITE;
/*!40000 ALTER TABLE status DISABLE KEYS */;
INSERT INTO status VALUES (1,'Planning to Watch'),(2,'Watching'),(3,'Watched'),(4,'Reviewed');
/*!40000 ALTER TABLE status ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `watchlist`
--

DROP TABLE IF EXISTS watchlist;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE watchlist (
  watchlist_id int NOT NULL AUTO_INCREMENT,
  watchlist_name varchar(255) DEFAULT NULL,
  PRIMARY KEY (watchlist_id)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `watchlist`
--

LOCK TABLES watchlist WRITE;
/*!40000 ALTER TABLE watchlist DISABLE KEYS */;
INSERT INTO watchlist VALUES (1,'Animation & Cartoons');
/*!40000 ALTER TABLE watchlist ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-19 13:18:21
