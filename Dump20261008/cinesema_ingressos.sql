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
-- Table structure for table `ingressos`
--

DROP TABLE IF EXISTS `ingressos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingressos` (
  `id_ingresso` int NOT NULL AUTO_INCREMENT,
  `tipo_ingresso` varchar(30) DEFAULT NULL,
  `valor` decimal(8,2) DEFAULT NULL,
  `id_pedido` int NOT NULL,
  `id_sessao` int NOT NULL,
  `id_assento` int NOT NULL,
  PRIMARY KEY (`id_ingresso`),
  UNIQUE KEY `id_sessao` (`id_sessao`,`id_assento`),
  KEY `id_pedido` (`id_pedido`),
  KEY `id_assento` (`id_assento`),
  CONSTRAINT `ingressos_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`),
  CONSTRAINT `ingressos_ibfk_2` FOREIGN KEY (`id_sessao`) REFERENCES `sessoes` (`id_sessao`),
  CONSTRAINT `ingressos_ibfk_3` FOREIGN KEY (`id_assento`) REFERENCES `assentos` (`id_assento`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingressos`
--

LOCK TABLES `ingressos` WRITE;
/*!40000 ALTER TABLE `ingressos` DISABLE KEYS */;
INSERT INTO `ingressos` VALUES (1,'Inteira',30.00,1,1,1),(2,'Inteira',30.00,1,1,2),(3,'Inteira',40.00,2,2,4),(4,'Inteira',55.00,3,3,6),(5,'Meia',27.50,3,3,7),(6,'Meia',14.00,4,4,10),(7,'Inteira',60.00,5,5,8),(8,'Inteira',60.00,5,5,9),(9,'Inteira',28.00,6,6,3);
/*!40000 ALTER TABLE `ingressos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-08  9:55:18
