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
-- Table structure for table `sessoes`
--

DROP TABLE IF EXISTS `sessoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessoes` (
  `id_sessao` int NOT NULL AUTO_INCREMENT,
  `data_hora_inicio` datetime DEFAULT NULL,
  `tipo_sessao` varchar(30) DEFAULT NULL,
  `idioma_exibicao` varchar(30) DEFAULT NULL,
  `formato_filme` varchar(20) DEFAULT NULL,
  `preco_base` decimal(10,2) DEFAULT NULL,
  `id_filme` int NOT NULL,
  `id_sala` int NOT NULL,
  PRIMARY KEY (`id_sessao`),
  KEY `id_filme` (`id_filme`),
  KEY `id_sala` (`id_sala`),
  CONSTRAINT `sessoes_ibfk_1` FOREIGN KEY (`id_filme`) REFERENCES `filmes` (`id_filme`),
  CONSTRAINT `sessoes_ibfk_2` FOREIGN KEY (`id_sala`) REFERENCES `salas` (`id_sala`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessoes`
--

LOCK TABLES `sessoes` WRITE;
/*!40000 ALTER TABLE `sessoes` DISABLE KEYS */;
INSERT INTO `sessoes` VALUES (1,'2026-10-10 19:00:00','Regular','Legendado','2D',30.00,1,1),(2,'2026-10-10 21:30:00','Regular','Dublado','3D',40.00,4,2),(3,'2026-10-11 20:00:00','Pré-estreia','Legendado','IMAX',55.00,3,3),(4,'2026-10-11 15:00:00','Regular','Dublado','2D',28.00,2,5),(5,'2026-10-12 18:00:00','Regular','Legendado','2D',60.00,1,4),(6,'2026-10-12 14:00:00','Regular','Dublado','2D',28.00,5,1);
/*!40000 ALTER TABLE `sessoes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-08  9:55:17
