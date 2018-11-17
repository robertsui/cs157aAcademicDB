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
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `course` (
  `courseID` int(11) NOT NULL AUTO_INCREMENT,
  `deptID` int(11) NOT NULL,
  `courseNo` varchar(4) NOT NULL,
  `courseName` varchar(50) NOT NULL,
  PRIMARY KEY (`courseID`),
  UNIQUE KEY `course_code` (`deptID`,`courseNo`),
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`deptID`) REFERENCES `department` (`deptid`)
) ENGINE=InnoDB AUTO_INCREMENT=50302 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (10460,1000,'046A','Introduction to Programming'),(10461,1000,'046B','Introduction to Data Structures'),(11460,1000,'146','Data Structures and Algorithms'),(11470,1000,'147','Computer Architecture'),(11490,1000,'149','Operating Systems'),(11570,1000,'157A','Introduction to Database Management Systems'),(20300,2000,'030','Calculus I'),(20310,2000,'031','Calculus II'),(20320,2000,'032','Calculus III'),(20420,2000,'042','Discrete Mathematics'),(30300,3000,'030','Principles of Biology I'),(30310,3000,'031','Principles of Biology II'),(40020,4000,'002A','Fundamentals of Physics I'),(40021,4000,'002B','Fundamentals of Physics II'),(40500,4000,'050','General Physics - Mechanics'),(50300,5000,'030A','Introductory Chemistry I'),(50301,5000,'030B','Introductory Chemistry II');
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-16 23:38:54
