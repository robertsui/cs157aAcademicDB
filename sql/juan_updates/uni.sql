SET sql_mode = '';

DROP DATABASE IF EXISTS University;
CREATE DATABASE University;
USE University;

DROP TABLE IF EXISTS Department;
	CREATE TABLE Department (
	deptID INT AUTO_INCREMENT,
	name VARCHAR(30),
	abbreviation VARCHAR(5),
	PRIMARY KEY(deptID)
);

DROP TABLE IF EXISTS Professor;
CREATE TABLE Professor (
	professorID INT AUTO_INCREMENT,
	firstName VARCHAR(30),
	lastName VARCHAR(30),
	dept INT,
	title VARCHAR(30),
	yearHired INT,
	PRIMARY KEY (professorID),
	FOREIGN KEY (dept) REFERENCES Department (deptID)
);

DROP TABLE IF EXISTS Course;
CREATE TABLE Course (
	courseID INT,
	deptID INT,
	courseNo VARCHAR(4),
	courseName VARCHAR(50),
	PRIMARY KEY (courseID),
	FOREIGN KEY (deptID) REFERENCES Department(deptID)
);

DROP TABLE IF EXISTS Section;
CREATE TABLE Section ( 
	sectionID INT AUTO_INCREMENT,
	courseID INT(8),
	term VARCHAR(4),
	capacity INT,
	enrolled INT,
	waitlist INT(3),
	date DATE,
	time TIME,
	building VARCHAR(3),
	roomNo INT(3),
	updatedAt DATETIME,
	PRIMARY KEY (sectionID),
	FOREIGN KEY(courseID) REFERENCES Course (courseID)
);

DROP TABLE IF EXISTS Student;
CREATE TABLE Student (
	studentID INT AUTO_INCREMENT,
	firstName VARCHAR(30),
	lastName VARCHAR(30),
	major INT,
	year INT,
	age INT,
	PRIMARY KEY (studentID),
	FOREIGN KEY (major) REFERENCES Department (deptID)
);

DROP TABLE IF EXISTS Grade;
CREATE TABLE Grade (
	sectionID INT,
	studentID INT,
	grade INT,
	updatedAt DATETIME,
	PRIMARY KEY (sectionID, studentID),
	FOREIGN KEY (sectionID) REFERENCES Section (sectionID),
	FOREIGN KEY (studentID) REFERENCES Student (studentID)
);

DROP TABLE IF EXISTS EnrolledIn;
CREATE TABLE EnrolledIn (
	sectionID INT,
	studentID INT,
	PRIMARY KEY(sectionID, studentID),
	FOREIGN KEY(sectionID) REFERENCES Section (sectionID),
	FOREIGN KEY(studentID) REFERENCES Student (studentID)
);

DROP TABLE IF EXISTS Teaches;
CREATE TABLE Teaches (
	sectionID INT,
	professorID INT,
	PRIMARY KEY(sectionID, professorID),
	FOREIGN KEY(sectionID) REFERENCES Section (sectionID),
	FOREIGN KEY(professorID) REFERENCES Professor (professorID)
);


LOAD DATA LOCAL INFILE '/~/departments.txt' INTO TABLE Department;
LOAD DATA LOCAL INFILE '/~/professors.txt' INTO TABLE Professor;
LOAD DATA LOCAL INFILE '/~/courses.txt' INTO TABLE Course;
LOAD DATA LOCAL INFILE '/~/sections.txt' INTO TABLE Section;
LOAD DATA LOCAL INFILE '/~/students.txt' INTO TABLE Student;
LOAD DATA LOCAL INFILE '/~/grades.txt' INTO TABLE Grade;
LOAD DATA LOCAL INFILE '/~/enrolledin.txt' INTO TABLE EnrolledIn;
LOAD DATA LOCAL INFILE '/~/teaches.txt' INTO TABLE Teaches;