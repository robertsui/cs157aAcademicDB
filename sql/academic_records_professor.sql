-- MySQL dump 10.13  Distrib 8.0.12, for Win64 (x86_64)
--
-- Host: localhost    Database: academic_records
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
-- Table structure for table `professor`
--

DROP TABLE IF EXISTS `professor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `professor` (
  `firstName` varchar(30) NOT NULL,
  `lastName` varchar(30) NOT NULL,
  `dept` int(11) DEFAULT NULL,
  `title` varchar(30) DEFAULT NULL,
  `yearHired` int(11) DEFAULT NULL,
  `professorID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`professorID`),
  KEY `professor_ibfk_1` (`dept`),
  CONSTRAINT `professor_ibfk_1` FOREIGN KEY (`dept`) REFERENCES `department` (`deptID`)
) ENGINE=InnoDB AUTO_INCREMENT=504 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professor`
--

LOCK TABLES `professor` WRITE;
/*!40000 ALTER TABLE `professor` DISABLE KEYS */;
INSERT INTO `professor` VALUES ('Sebastian','Glockner',1000,'Professor',1995,100),('Catherine','Jones',1000,'Professor',2008,101),('Gerard','Fugate',1000,'Associate Professor',2010,102),('Sarah','Marrero',1000,'Assistant Professor',2002,103),('Joshua','Dodson',1000,'Lecturer',2013,104),('Tao','Chen',1000,'Lecturer',2010,105),('Wang','Liang',2000,'Professor',1998,200),('Annika','Nodland',2000,'Assistant Professor',2009,201),('Jacob','Tran',2000,'Lecturer',2016,202),('Tom','Luckett',2000,'Lecturer',2012,203),('Michael','Parrish',3000,'Associate Professor',2011,300),('Brian','Gutierrez',3000,'Professor',2007,301),('Francisca','Offermans',3000,'Professor',1996,302),('Adam','Hall',4000,'Lecturer',2016,400),('Lillian','Horton',4000,'Assistant Professor',2013,401),('Taysir','Sarkis',4000,'Lecturer',2014,402),('Lydia','Graham',5000,'Professor',2002,500),('Drew','King',5000,'Professor',2005,501),('Myla','Stevenson',5000,'Assistant Professor',2011,502),('Benjamin','Kreitmayer',5000,'Lecturer',2012,503);
/*!40000 ALTER TABLE `professor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-16 23:38:55
