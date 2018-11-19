-- MySQL dump 10.13  Distrib 8.0.12, for Win64 (x86_64)
--
-- Host: localhost    Database: academic_records
-- ------------------------------------------------------
-- Server version	8.0.12

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
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
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`deptID`) REFERENCES `department` (`deptID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (10460,1000,'046A','Introduction to Programming'),(10461,1000,'046B','Introduction to Data Structures'),(11460,1000,'146','Data Structures and Algorithms'),(11470,1000,'147','Computer Architecture'),(11490,1000,'149','Operating Systems'),(11570,1000,'157A','Introduction to Database Management Systems'),(20300,2000,'030','Calculus I'),(20310,2000,'031','Calculus II'),(20320,2000,'032','Calculus III'),(20420,2000,'042','Discrete Mathematics'),(30300,3000,'030','Principles of Biology I'),(30310,3000,'031','Principles of Biology II'),(40020,4000,'002A','Fundamentals of Physics I'),(40021,4000,'002B','Fundamentals of Physics II'),(40500,4000,'050','General Physics - Mechanics'),(50300,5000,'030A','Introductory Chemistry I'),(50301,5000,'030B','Introductory Chemistry II');
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `department` (
  `deptID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `abbreviation` varchar(5) NOT NULL,
  PRIMARY KEY (`deptID`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  UNIQUE KEY `abbreviation_UNIQUE` (`abbreviation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1000,'Computer Science','CS'),(2000,'Mathematics','MATH'),(3000,'Biology','BIOL'),(4000,'Physics','PHYS'),(5000,'Chemistry','CHEM');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrolledin`
--

DROP TABLE IF EXISTS `enrolledin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `enrolledin` (
  `sectionID` int(11) NOT NULL,
  `studentID` int(11) NOT NULL,
  PRIMARY KEY (`sectionID`,`studentID`),
  KEY `studentID` (`studentID`),
  CONSTRAINT `enrolledin_ibfk_1` FOREIGN KEY (`sectionID`) REFERENCES `section` (`sectionID`),
  CONSTRAINT `enrolledin_ibfk_2` FOREIGN KEY (`studentID`) REFERENCES `student` (`studentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrolledin`
--

LOCK TABLES `enrolledin` WRITE;
/*!40000 ALTER TABLE `enrolledin` DISABLE KEYS */;
INSERT INTO `enrolledin` VALUES (10000,100000),(10000,100001),(10001,100002),(10001,100003),(10002,100004),(10002,100005),(10003,100006),(10003,100007),(10004,100008),(10004,100009),(10005,100010),(10005,100011);
/*!40000 ALTER TABLE `enrolledin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grade`
--

DROP TABLE IF EXISTS `grade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `grade` (
  `sectionID` int(11) NOT NULL,
  `studentID` int(11) NOT NULL,
  `grade` varchar(2) NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`sectionID`,`studentID`),
  KEY `studentID` (`studentID`),
  CONSTRAINT `grade_ibfk_1` FOREIGN KEY (`sectionID`) REFERENCES `section` (`sectionID`),
  CONSTRAINT `grade_ibfk_2` FOREIGN KEY (`studentID`) REFERENCES `student` (`studentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grade`
--

LOCK TABLES `grade` WRITE;
/*!40000 ALTER TABLE `grade` DISABLE KEYS */;
INSERT INTO `grade` VALUES (10006,100005,'A-',NULL),(10007,100007,'C',NULL),(10008,100008,'B+',NULL),(10009,100017,'B',NULL),(10010,100007,'A',NULL),(10011,100017,'B',NULL);
/*!40000 ALTER TABLE `grade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gradearchive`
--

DROP TABLE IF EXISTS `gradearchive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `gradearchive` (
  `sectionID` int(11) NOT NULL,
  `studentID` int(11) NOT NULL,
  `grade` int(11) DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`sectionID`,`studentID`),
  KEY `studentID` (`studentID`),
  CONSTRAINT `gradearchive_ibfk_1` FOREIGN KEY (`sectionID`) REFERENCES `section` (`sectionID`),
  CONSTRAINT `gradearchive_ibfk_2` FOREIGN KEY (`studentID`) REFERENCES `student` (`studentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gradearchive`
--

LOCK TABLES `gradearchive` WRITE;
/*!40000 ALTER TABLE `gradearchive` DISABLE KEYS */;
/*!40000 ALTER TABLE `gradearchive` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Table structure for table `section`
--

DROP TABLE IF EXISTS `section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `section` (
  `sectionID` int(11) NOT NULL AUTO_INCREMENT,
  `courseID` int(8) NOT NULL,
  `term` varchar(4) NOT NULL,
  `capacity` int(11) DEFAULT NULL,
  `enrolled` int(11) DEFAULT NULL,
  `waitlist` int(3) DEFAULT '0',
  `date` varchar(4) DEFAULT NULL,
  `time` time DEFAULT NULL,
  `building` varchar(3) DEFAULT NULL,
  `roomNo` int(3) DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`sectionID`),
  KEY `section_ibfk_1` (`courseID`),
  CONSTRAINT `section_ibfk_1` FOREIGN KEY (`courseID`) REFERENCES `course` (`courseID`)
) ENGINE=InnoDB AUTO_INCREMENT=10012 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `section`
--

LOCK TABLES `section` WRITE;
/*!40000 ALTER TABLE `section` DISABLE KEYS */;
INSERT INTO `section` VALUES (10000,10460,'FA18',50,50,0,'MW','12:00:00','MQH',222,NULL),(10001,10461,'FA18',50,50,2,'TuTH','13:30:00','MQH',423,NULL),(10002,20300,'FA18',30,29,0,'MW','09:00:00','MAT',100,NULL),(10003,30300,'FA18',30,30,0,'MW','07:30:00','SCI',234,NULL),(10004,40021,'FA18',40,38,0,'TuTH','14:30:00','SCI',422,NULL),(10005,50300,'FA18',30,30,1,'TuTH','13:30:00','SCI',333,NULL),(10006,10460,'SP18',60,58,0,NULL,NULL,NULL,NULL,NULL),(10007,10461,'SP18',60,60,0,NULL,NULL,NULL,NULL,NULL),(10008,11460,'SP18',30,25,0,NULL,NULL,NULL,NULL,NULL),(10009,11470,'SP18',30,30,0,NULL,NULL,NULL,NULL,NULL),(10010,11490,'FA17',30,30,0,NULL,NULL,NULL,NULL,NULL),(10011,11570,'FA17',30,29,0,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sectionarchive`
--

DROP TABLE IF EXISTS `sectionarchive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sectionarchive` (
  `sectionID` int(11) NOT NULL,
  `courseID` int(8) NOT NULL,
  `term` varchar(4) NOT NULL,
  `capacity` int(11) DEFAULT NULL,
  `enrolled` int(11) DEFAULT NULL,
  `waitlist` int(3) DEFAULT NULL,
  `date` varchar(4) DEFAULT NULL,
  `time` time DEFAULT NULL,
  `building` varchar(3) DEFAULT NULL,
  `roomNo` int(3) DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`sectionID`),
  KEY `sectionarchive_ibfk_1` (`courseID`),
  CONSTRAINT `sectionarchive_ibfk_1` FOREIGN KEY (`courseID`) REFERENCES `course` (`courseID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sectionarchive`
--

LOCK TABLES `sectionarchive` WRITE;
/*!40000 ALTER TABLE `sectionarchive` DISABLE KEYS */;
/*!40000 ALTER TABLE `sectionarchive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `student` (
  `studentID` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(30) NOT NULL,
  `lastName` varchar(30) NOT NULL,
  `major` int(11) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  PRIMARY KEY (`studentID`),
  KEY `major` (`major`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`major`) REFERENCES `department` (`deptID`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=100018 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (100000,'Blake','Angwin',1000,2018,18),(100001,'Hayley','Winning',2000,2017,19),(100002,'Cheng','Tsui',3000,2016,20),(100003,'Marcel','Schmitz',4000,2015,21),(100004,'Kathrin','Busch',5000,2014,22),(100005,'Yule','Tai',1000,2014,23),(100006,'Hu','Chen',2000,2017,20),(100007,'Monica','Nguyen',1000,2016,20),(100008,'Suhaymah','Mansour',1000,2018,18),(100009,'Melvin','Middleton',3000,2017,19),(100010,'Christopher','Martin',5000,2018,18),(100011,'Sandra','Snow',4000,2015,21),(100012,'Eikou','Kitahara',5000,2016,20),(100013,'Jeremy','Todd',2000,2013,24),(100014,'Isabella','Silva',3000,2015,21),(100015,'Igor','Costa',4000,2016,20),(100016,'Tony','Tran',2000,2017,20),(100017,'Kevin','Kwon',1000,2015,22);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teaches`
--

DROP TABLE IF EXISTS `teaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `teaches` (
  `sectionID` int(11) NOT NULL,
  `professorID` int(11) NOT NULL,
  PRIMARY KEY (`sectionID`,`professorID`),
  KEY `professorID` (`professorID`),
  CONSTRAINT `teaches_ibfk_1` FOREIGN KEY (`sectionID`) REFERENCES `section` (`sectionID`),
  CONSTRAINT `teaches_ibfk_2` FOREIGN KEY (`professorID`) REFERENCES `professor` (`professorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teaches`
--

LOCK TABLES `teaches` WRITE;
/*!40000 ALTER TABLE `teaches` DISABLE KEYS */;
INSERT INTO `teaches` VALUES (10000,100),(10001,101),(10002,202),(10003,300),(10004,400),(10005,501);
/*!40000 ALTER TABLE `teaches` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-18 16:24:34
