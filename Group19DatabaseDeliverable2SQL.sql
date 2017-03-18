-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 16, 2017 at 04:32 PM
-- Server version: 10.1.20-MariaDB
-- PHP Version: 5.6.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `group19`
--

-- --------------------------------------------------------

--
-- Table structure for table `bannedusers`
--

CREATE TABLE `bannedusers` (
  `Banned` tinyint(1) NOT NULL,
  `UserID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `claimedtasks`
--

CREATE TABLE `claimedtasks` (
  `TaskID` int(11) NOT NULL,
  `ClaimID` int(11) NOT NULL,
  `DateClaimed` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `flaggedtasks`
--

CREATE TABLE `flaggedtasks` (
  `FlagID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `TaskID` int(11) NOT NULL,
  `FlagReason` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

CREATE TABLE `status` (
  `StatusID` int(11) NOT NULL,
  `Status` varchar(20) CHARACTER SET utf8mb4 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `status`
--

INSERT INTO `status` (`StatusID`, `Status`) VALUES
(1, 'Pending'),
(2, 'Expired'),
(3, 'Claimed'),
(4, 'Cancelled'),
(5, 'Failed'),
(6, 'Submitted');

-- --------------------------------------------------------

--
-- Table structure for table `tagids`
--

CREATE TABLE `tagids` (
  `TagID` int(11) NOT NULL,
  `TaskID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tagnames`
--

CREATE TABLE `tagnames` (
  `TagName` varchar(20) NOT NULL,
  `TagID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `taskstable`
--

CREATE TABLE `taskstable` (
  `TaskID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `TaskTitle` tinytext NOT NULL,
  `TaskNoPages` int(11) NOT NULL,
  `TaskWordCount` int(11) NOT NULL,
  `TaskFileFormat` varchar(12) NOT NULL,
  `TaskDesc` text NOT NULL,
  `ClaimDeadline` date NOT NULL,
  `SubmissionDeadline` date NOT NULL,
  `TaskType` varchar(20) NOT NULL,
  `FlaggedTasks` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `taskstatus`
--

CREATE TABLE `taskstatus` (
  `StatusID` int(11) NOT NULL,
  `TaskID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `usertable`
--

CREATE TABLE `usertable` (
  `UserID` int(11) NOT NULL,
  `UserEmail` varchar(40) NOT NULL,
  `UserPassword` varchar(64) NOT NULL,
  `FirstName` varchar(30) NOT NULL,
  `LastName` varchar(30) NOT NULL,
  `UserDiscipline` text NOT NULL,
  `UserPoints` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bannedusers`
--
ALTER TABLE `bannedusers`
  ADD PRIMARY KEY (`UserID`),
  ADD KEY `UserID` (`UserID`);

--
-- Indexes for table `claimedtasks`
--
ALTER TABLE `claimedtasks`
  ADD PRIMARY KEY (`ClaimID`),
  ADD KEY `TaskID` (`TaskID`);

--
-- Indexes for table `flaggedtasks`
--
ALTER TABLE `flaggedtasks`
  ADD PRIMARY KEY (`FlagID`),
  ADD KEY `UserID` (`UserID`),
  ADD KEY `TaskID` (`TaskID`);

--
-- Indexes for table `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`StatusID`);

--
-- Indexes for table `tagids`
--
ALTER TABLE `tagids`
  ADD PRIMARY KEY (`TagID`),
  ADD KEY `TaskID` (`TaskID`);

--
-- Indexes for table `tagnames`
--
ALTER TABLE `tagnames`
  ADD PRIMARY KEY (`TagName`),
  ADD KEY `TagID` (`TagID`);

--
-- Indexes for table `taskstable`
--
ALTER TABLE `taskstable`
  ADD PRIMARY KEY (`TaskID`),
  ADD KEY `UserID` (`UserID`),
  ADD KEY `FlaggedTasks` (`FlaggedTasks`);

--
-- Indexes for table `taskstatus`
--
ALTER TABLE `taskstatus`
  ADD PRIMARY KEY (`StatusID`),
  ADD KEY `TaskID` (`TaskID`);

--
-- Indexes for table `usertable`
--
ALTER TABLE `usertable`
  ADD PRIMARY KEY (`UserID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `claimedtasks`
--
ALTER TABLE `claimedtasks`
  MODIFY `ClaimID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `taskstable`
--
ALTER TABLE `taskstable`
  MODIFY `TaskID` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `bannedusers`
--
ALTER TABLE `bannedusers`
  ADD CONSTRAINT `bannedusers_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `usertable` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `claimedtasks`
--
ALTER TABLE `claimedtasks`
  ADD CONSTRAINT `claimedtasks_ibfk_1` FOREIGN KEY (`TaskID`) REFERENCES `taskstable` (`TaskID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `flaggedtasks`
--
ALTER TABLE `flaggedtasks`
  ADD CONSTRAINT `flaggedtasks_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `usertable` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `flaggedtasks_ibfk_2` FOREIGN KEY (`TaskID`) REFERENCES `taskstable` (`TaskID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tagids`
--
ALTER TABLE `tagids`
  ADD CONSTRAINT `tagids_ibfk_1` FOREIGN KEY (`TaskID`) REFERENCES `taskstable` (`TaskID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tagnames`
--
ALTER TABLE `tagnames`
  ADD CONSTRAINT `tagnames_ibfk_1` FOREIGN KEY (`TagID`) REFERENCES `tagids` (`TagID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `taskstable`
--
ALTER TABLE `taskstable`
  ADD CONSTRAINT `taskstable_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `usertable` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `taskstable_ibfk_3` FOREIGN KEY (`TaskID`) REFERENCES `taskstatus` (`TaskID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `taskstatus`
--
ALTER TABLE `taskstatus`
  ADD CONSTRAINT `taskstatus_ibfk_1` FOREIGN KEY (`StatusID`) REFERENCES `status` (`StatusID`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
