-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: cinesema
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `assentos`
--

DROP TABLE IF EXISTS `assentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assentos` (
  `id_assento` int NOT NULL AUTO_INCREMENT,
  `fileira` char(1) DEFAULT NULL,
  `cadeira` int DEFAULT NULL,
  `tipo_assento` varchar(30) DEFAULT NULL,
  `id_sala` int NOT NULL,
  PRIMARY KEY (`id_assento`),
  KEY `id_sala` (`id_sala`),
  CONSTRAINT `assentos_ibfk_1` FOREIGN KEY (`id_sala`) REFERENCES `salas` (`id_sala`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assentos`
--

LOCK TABLES `assentos` WRITE;
/*!40000 ALTER TABLE `assentos` DISABLE KEYS */;
INSERT INTO `assentos` VALUES (1,'A',1,'Comum',1),(2,'A',2,'Comum',1),(3,'B',1,'Preferencial',1),(4,'A',1,'3D',2),(5,'A',2,'3D',2),(6,'A',1,'IMAX',3),(7,'A',2,'IMAX',3),(8,'A',1,'VIP',4),(9,'A',2,'VIP',4),(10,'A',1,'Comum',5);
/*!40000 ALTER TABLE `assentos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-08  9:55:16
