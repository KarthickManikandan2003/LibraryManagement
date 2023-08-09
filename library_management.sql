-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Mar 03, 2023 at 07:32 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `library_management`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `back_up_cur` ()   BEGIN
      DECLARE done INT DEFAULT 0;
      DECLARE Book_name, Author, Category,BookID VARCHAR(20);
      DECLARE cur CURSOR FOR SELECT * FROM book;
      DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
      OPEN cur;
      label: LOOP
      FETCH cur INTO Book_name,Author,Category,BookID;
      IF done = 1 THEN LEAVE label;
      END IF;
      INSERT INTO backup VALUES(Book_name,Author,Category,BookID);
      END LOOP;
      CLOSE cur;
   END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `add_issued`
--

CREATE TABLE `add_issued` (
  `Name` varchar(25) NOT NULL,
  `SRN` varchar(25) NOT NULL,
  `BookID` varchar(30) NOT NULL,
  `Book` varchar(25) NOT NULL,
  `Author` varchar(25) NOT NULL,
  `Bookissue` varchar(30) NOT NULL,
  `Bookreturn` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `add_issued`
--

INSERT INTO `add_issued` (`Name`, `SRN`, `BookID`, `Book`, `Author`, `Bookissue`, `Bookreturn`) VALUES
('Amogh', 'PES2UG20CS001', '1', 'Machine Learning', 'Chris Sebastian', '2022-03-03', '2022-03-23'),
('John', 'PES2UG20CS010', '11', 'Zen publications', 'Karan Johar', '2022-09-16', '2022-09-27'),
('John ', 'PES2UG20CS010', '9', 'Mechanics', 'Raj Kiran', '2022-05-22', '2022-06-11'),
('Akshay ', 'PES2UG20CS032', '1', 'Machine learning', 'Chris Sebastian', '2022-08-20', '2022-09-20'),
('Ramesh', 'PES2UG20CS100', '1', 'Machine Learning', 'Chris Sebastian', '2022-04-28', '2022-05-29'),
('Ramesh', 'PES2UG20CS100', '2', 'Operating Systems', 'Rajiv Chopra', '2022-02-18', '2022-03-27'),
('Raj', 'PES2UG20CS222', '2', 'Operating Systems', 'Rajiv Chopra', '2022-06-10', '2022-08-16'),
('Raj', 'PES2UG20CS222', '4', 'Fundamentals of Mathemati', 'B S Grewal', '2022-10-19', '2022-11-22'),
('R Karthick Manikandan', 'PES2UG20CS516', '4', 'Fundamentals of Mathemati', 'B S Grewal', '2022-10-15', '2022-11-15'),
('Pranav', 'PES2UG20CS521', '6', 'Fundamentals of Mathemati', 'Rajiv Chopra', '2022-08-25', '2022-10-09'),
('Sohan', 'PES2UG20CS555', '5', 'Computer Networks', 'B S Grewal', '2022-06-09', '2022-06-28'),
('Suresh', 'PES2UG20CS645', '1', 'Machine Learning', 'Chris Sebastian', '2022-07-08', '2022-08-29'),
('Suresh', 'PES2UG20CS645', '8', 'Finance', 'Mishra Mehta', '2022-06-02', '2022-07-03'),
('Harsha', 'PES2UG20CS832', '1', 'Machine Learning', 'Chris Sebastian', '2022-02-02', '2022-04-10');

--
-- Triggers `add_issued`
--
DELIMITER $$
CREATE TRIGGER `before_insert_issued` BEFORE INSERT ON `add_issued` FOR EACH ROW BEGIN
DECLARE error_msg varchar(255);
DECLARE id_book varchar(30);
DECLARE max_no_of_books int;
set error_msg='Borrowed book exceeded more than 5';
set id_book=NEW.BookID;
SET max_no_of_books=(SELECT COUNT(*) FROM add_issued where BookID like id_book);
if max_no_of_books + 1 > 5 THEN
SIGNAL SQLSTATE '45000'
set MESSAGE_TEXT = error_msg;
end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `backup`
--

CREATE TABLE `backup` (
  `Book_name` varchar(20) NOT NULL,
  `Author` varchar(20) NOT NULL,
  `Category` varchar(20) NOT NULL,
  `BookID` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `backup`
--

INSERT INTO `backup` (`Book_name`, `Author`, `Category`, `BookID`) VALUES
('Machine Learning', 'Chris Sebastian', 'cse', '1'),
('Statics ', 'Mishra Mehta', 'phy', '10'),
('Operating Systems', 'Rajiv Chopra', 'cse', '2'),
('Computer Networks', 'Rajiv Chopra', 'cse', '3'),
('Fundamentals of Math', 'B S Grewal', 'mat', '4'),
('Computer Networks', 'B S Grewal', 'cse', '5'),
('Fundamentals of Math', 'Rajiv Chopra', 'mat', '6'),
('Electronic Component', 'Mishra Mehta', 'ece', '7'),
('Finance ', 'M N Sekar', 'com', '8'),
('Mechanics', 'Raj Kiran', 'mec', '9');

-- --------------------------------------------------------

--
-- Table structure for table `book`
--

CREATE TABLE `book` (
  `Book_name` varchar(30) NOT NULL,
  `Author` varchar(30) NOT NULL,
  `Category` varchar(30) NOT NULL,
  `BookID` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `book`
--

INSERT INTO `book` (`Book_name`, `Author`, `Category`, `BookID`) VALUES
('Machine Learning', 'Chris Sebastian', 'cse', '1'),
('Statics', 'Mehta Mohan', 'phy', '10'),
('Zen publitions', 'Karan Johar', 'ece', '11'),
('Operating Systems', 'Rajiv Chopra', 'cse', '2'),
('Computer Networks', 'Rajiv Chopra', 'cse', '3'),
('Fundamentals of Mathematics', 'B S Grewal', 'mat', '4'),
('Computer Networks', 'B S Grewal', 'cse', '5'),
('Fundamentals of Mathematics', 'Rajiv Chopra', 'mat', '6'),
('Electronic Components', 'Mishra Mehta', 'ece', '7'),
('Finance ', 'M N Sekar', 'com', '8'),
('Mechanics', 'Raj Kiran', 'mec', '9');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `Name` varchar(30) NOT NULL,
  `SRN` varchar(30) NOT NULL,
  `Sec` varchar(13) NOT NULL,
  `Age` int(11) NOT NULL,
  `DOB` varchar(35) NOT NULL,
  `Phone` bigint(20) NOT NULL,
  `Email` varchar(30) NOT NULL,
  `Address` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`Name`, `SRN`, `Sec`, `Age`, `DOB`, `Phone`, `Email`, `Address`) VALUES
('Amogh', 'PES2UG20CS001', 'H', 20, '2002-02-13', 9459951234, 'amogh@gmail.com', 'Jayanagar'),
('John', 'PES2UG20CS010', 'A', 21, '2001-02-21', 9587948667, 'john@gmail.com', 'BTM Layout'),
('Akshay', 'PES2UG20CS032', 'A', 21, '2001-02-13', 7238487211, 'akshay@gmail.com', 'Rajajinagar'),
('Ramith', 'PES2UG20CS100', 'H', 21, '2001-11-11', 9567948561, 'ramith@gmail.com', 'Malleshwaram'),
('Raj', 'PES2UG20CS222', 'D', 20, '2002-09-19', 8433123496, 'raj@gmail.com', 'Malleshwaram'),
('R Karthick Manikandan', 'PES2UG20CS516', 'H', 19, '2003-02-13', 7338009480, 'karthick@gmail.com', 'Mathikere'),
('Pranav', 'PES2UG20CS521', 'D', 21, '2001-04-04', 9386753126, 'pranav@gmail.com', 'Jayanagar'),
('Sohan', 'PES2UG20CS555', 'B', 19, '2003-11-12', 9658531245, 'sohan@gmail.com', 'HSR Layout'),
('Suresh', 'PES2UG20CS645', 'C', 19, '2003-02-02', 8774659671, 'suresh@gmail.com', 'Rajajinagar'),
('Harsha', 'PES2UG20CS832', 'E', 22, '2000-08-26', 9359339481, 'harsha@gmail.com', 'Mathikere');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `add_issued`
--
ALTER TABLE `add_issued`
  ADD PRIMARY KEY (`SRN`,`BookID`),
  ADD KEY `bookid_con` (`BookID`);

--
-- Indexes for table `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`BookID`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`SRN`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `add_issued`
--
ALTER TABLE `add_issued`
  ADD CONSTRAINT `add_issued_ibfk_1` FOREIGN KEY (`SRN`) REFERENCES `student` (`SRN`),
  ADD CONSTRAINT `bookid_con` FOREIGN KEY (`BookID`) REFERENCES `book` (`BookID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
