CREATE DATABASE  IF NOT EXISTS `food` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;
USE `food`;
-- MySQL dump 10.13  Distrib 8.0.12, for Win64 (x86_64)
--
-- Host: localhost    Database: food
-- ------------------------------------------------------
-- Server version	8.0.12

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ingredients`
--

DROP TABLE IF EXISTS `ingredients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ingredients` (
  `nutrientID` int(11) DEFAULT NULL,
  `recipeID` int(11) DEFAULT NULL,
  `foodQty` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredients`
--

LOCK TABLES `ingredients` WRITE;
/*!40000 ALTER TABLE `ingredients` DISABLE KEYS */;
INSERT INTO `ingredients` VALUES (1,1,6.9),(2,1,5.8),(3,1,234),(4,1,150),(5,1,5),(6,1,9),(7,1,226),(8,1,6350.293180000001),(9,1,0),(10,1,4),(11,2,180.72820992187502),(12,2,198.44666187500002),(13,2,11.5),(14,2,2.2),(15,2,2.6),(16,2,6),(17,2,453.59237),(18,2,396.89332375000004),(19,2,150),(20,2,113.5),(21,2,127.5728540625),(22,2,6),(23,2,170.09713875),(24,2,45);
/*!40000 ALTER TABLE `ingredients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nutrients`
--

DROP TABLE IF EXISTS `nutrients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `nutrients` (
  `nutrientID` int(11) NOT NULL AUTO_INCREMENT,
  `foodName` varchar(75) NOT NULL,
  `calories` double DEFAULT NULL,
  `fat` double DEFAULT NULL,
  `carbs` double DEFAULT NULL,
  `fiber` double DEFAULT NULL,
  `protein` double DEFAULT NULL,
  `UPC` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`nutrientID`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nutrients`
--

LOCK TABLES `nutrients` WRITE;
/*!40000 ALTER TABLE `nutrients` DISABLE KEYS */;
INSERT INTO `nutrients` VALUES (1,'Spices, pepper, black',251,3.26,63.95,25.3,10.39,'NULL'),(2,'Spices, fennel seed',345,14.87,52.29,39.8,15.8,'NULL'),(3,'Fennel, bulb, raw',31,0.2,7.3,3.1,1.24,'NULL'),(4,'Onions, raw',40,0.1,9.34,1.7,1.1,'NULL'),(5,'Spices, coriander seed',298,17.77,54.99,41.9,12.37,'NULL'),(6,'Garlic, raw',149,0.5,33.06,2.1,6.36,'NULL'),(7,'Alcoholic beverage, wine, table, red',85,0,2.61,0,0.07,'NULL'),(8,'Ham, sliced, regular (approximately 11% fat)',163,8.6,3.83,1.3,16.6,'NULL'),(9,'Water, tap, drinking',0,0,0,0,0,'NULL'),(10,'Spices, anise seed',337,15.9,50.02,14.6,17.6,'NULL'),(11,'Wheat flour, white, all-purpose, enriched, unbleached',364,0.98,76.31,2.7,10.33,'NULL'),(12,'Sugars, granulated',387,0,99.98,0,0,'NULL'),(13,'Leavening agents, baking powder, double-acting, straight phosphate',51,0,24.1,0.2,0.1,'NULL'),(14,'Spices, nutmeg, ground',525,36.31,49.29,20.8,5.84,'NULL'),(15,'Spices, cinnamon, ground',247,1.24,80.59,53.1,3.99,'NULL'),(16,'Salt, table',0,0,0,0,0,'NULL'),(17,'Figs, raw',74,0.3,19.18,2.9,0.75,'NULL'),(18,'Milk, whole, 3.25% milkfat, with added vitamin D',61,3.25,4.8,0,3.15,'NULL'),(19,'Egg, whole, raw, fresh',143,9.51,0.72,0,12.56,'NULL'),(20,'Butter, without salt',717,81.11,0.06,0,0.85,'NULL'),(21,'Crackers, standard snack-type, regular',510,26.43,61.3,2.3,6.64,'NULL'),(22,'Lemon peel, raw',47,0.3,16,10.6,1.5,'NULL'),(23,'Sugars, powdered',389,0,99.77,0,0,'NULL'),(24,'Cream, fluid, heavy whipping',345,37,2.79,0,2.05,'NULL');
/*!40000 ALTER TABLE `nutrients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipes`
--

DROP TABLE IF EXISTS `recipes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `recipes` (
  `recipeID` int(11) NOT NULL AUTO_INCREMENT,
  `recipeName` varchar(50) NOT NULL,
  `servings` varchar(50) NOT NULL,
  `diet` varchar(50) NOT NULL,
  PRIMARY KEY (`recipeID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipes`
--

LOCK TABLES `recipes` WRITE;
/*!40000 ALTER TABLE `recipes` DISABLE KEYS */;
INSERT INTO `recipes` VALUES (1,'Aromatic Christmas Ham','10.0','Low-Carb'),(2,'Graham Cracker Figgy Pudding Recipe','12.0','NULL');
/*!40000 ALTER TABLE `recipes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shopping`
--

DROP TABLE IF EXISTS `shopping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `shopping` (
  `UPC` varchar(12) NOT NULL,
  `size` double DEFAULT NULL,
  `price` double DEFAULT NULL,
  PRIMARY KEY (`UPC`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shopping`
--

LOCK TABLES `shopping` WRITE;
/*!40000 ALTER TABLE `shopping` DISABLE KEYS */;
/*!40000 ALTER TABLE `shopping` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-12-12 22:45:38
