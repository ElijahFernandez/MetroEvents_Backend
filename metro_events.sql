-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 31, 2024 at 05:59 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `metro_events`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `email`, `password`, `first_name`, `last_name`) VALUES
(1, 'shane@gmail.com', 'qwerty', 'Shane', 'Dela Torre');

-- --------------------------------------------------------

--
-- Table structure for table `approved_requests`
--

CREATE TABLE `approved_requests` (
  `registration_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  `registration_status` enum('pending','approved','disapproved') DEFAULT 'pending',
  `registration_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `approved_requests`
--

INSERT INTO `approved_requests` (`registration_id`, `user_id`, `event_id`, `registration_status`, `registration_date`) VALUES
(2, 4, 23, 'approved', '2024-03-30 03:22:07'),
(5, 3, 32, 'approved', '2024-03-30 03:25:32'),
(6, 6, 24, 'approved', '2024-03-30 23:18:14'),
(7, 6, 21, 'approved', '2024-03-30 23:22:51'),
(8, 6, 22, 'approved', '2024-03-30 23:27:15'),
(9, 6, 23, 'approved', '2024-03-30 23:27:49'),
(10, 6, 21, 'approved', '2024-03-30 23:30:12'),
(11, 6, 21, 'approved', '2024-03-30 23:33:13'),
(12, 6, 22, 'approved', '2024-03-30 23:34:40'),
(13, 6, 23, 'approved', '2024-03-30 23:37:35'),
(14, 6, 22, 'approved', '2024-03-30 23:40:56'),
(19, 7, 22, 'approved', '2024-03-31 02:15:09');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `event_id` int(11) NOT NULL,
  `organizer_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`event_id`, `organizer_id`, `title`, `start_date`, `end_date`, `description`) VALUES
(21, 4, 'Tech Summit 2024', '2024-03-29', NULL, 'Join us for the annual Tech Summit where industry leaders discuss the latest trends and innovations in technology.'),
(22, 4, 'HackathonX', '2024-03-29', NULL, 'A 24-hour hackathon for developers to showcase their skills and build innovative projects.'),
(23, 4, 'Web Development Workshop', '2024-03-29', NULL, 'Learn the fundamentals of web development from industry experts.'),
(24, 4, 'Cybersecurity Conference', '2024-03-29', NULL, 'An informative conference on cybersecurity threats and solutions.'),
(25, 4, 'AI & Machine Learning Seminar', '2024-03-29', NULL, 'Discover the latest advancements in artificial intelligence and machine learning.'),
(26, 4, 'Tech Startup Pitch Event', '2024-03-29', NULL, 'Entrepreneurs present their innovative tech startup ideas to investors and industry professionals.'),
(27, 4, 'JavaScript Frameworks Workshop', '2024-03-29', NULL, 'Deep dive into popular JavaScript frameworks like React, Angular, and Vue.'),
(28, 4, 'DevOps Conference', '2024-03-29', NULL, 'Explore the principles and practices of DevOps for efficient software development and deployment.'),
(29, 4, 'Cloud Computing Summit', '2024-03-29', NULL, 'Learn about cloud computing technologies and their impact on businesses.'),
(30, 4, 'Data Science Webinar', '2024-03-29', NULL, 'Introduction to data science concepts and tools for beginners.'),
(31, 4, 'Shane\'s smoothie', '2024-03-30', '2024-04-16', 'dasfsdf'),
(32, 3, 'Shane\'s Sweet 16', '2024-03-30', '2024-04-01', 'ABUGABUGABUGA');

-- --------------------------------------------------------

--
-- Table structure for table `event_registration`
--

CREATE TABLE `event_registration` (
  `registration_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  `registration_status` enum('pending','approved','disapproved') DEFAULT 'pending',
  `registration_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `event_registration`
--

INSERT INTO `event_registration` (`registration_id`, `user_id`, `event_id`, `registration_status`, `registration_date`) VALUES
(15, 6, 21, 'pending', '2024-03-30 15:40:43'),
(16, 6, 23, 'pending', '2024-03-30 15:40:45');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notification_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `organizer_id` int(11) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  `notification_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `message` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`notification_id`, `user_id`, `organizer_id`, `event_id`, `notification_date`, `message`) VALUES
(1, 6, NULL, 24, '2024-03-30 23:18:14', 'Your request for the event has been approved.'),
(2, 6, NULL, 21, '2024-03-30 23:23:54', 'Your request for the event has been approved.'),
(6, 6, NULL, 22, '2024-03-30 23:27:27', 'Your request for the event has been approved.'),
(7, 6, NULL, 23, '2024-03-30 23:27:49', 'Your request for the event has been approved.'),
(15, 6, NULL, 22, '2024-03-30 23:34:40', 'Your request for the event has been approved.'),
(21, 6, NULL, 22, '2024-03-30 23:40:56', 'Your request for the event has been approved.'),
(22, 7, NULL, 22, '2024-03-31 02:15:09', 'Your request for the event has been approved.');

-- --------------------------------------------------------

--
-- Table structure for table `organizer`
--

CREATE TABLE `organizer` (
  `organizer_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `organizer`
--

INSERT INTO `organizer` (`organizer_id`, `user_id`) VALUES
(5, 4);

-- --------------------------------------------------------

--
-- Table structure for table `organizer_request`
--

CREATE TABLE `organizer_request` (
  `request_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `request_status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `email`, `password`, `first_name`, `last_name`) VALUES
(2, 'joseelijah.fernandez@gmail.com', 'qwerty', 'Jose Elijah', 'Fernandez'),
(3, 'sheer@gmail.com', 'qwerty', 'Sheer', 'Piodos'),
(4, 'meach@gmail.com', 'qwerty', 'Meachelle', 'Abella'),
(6, 'elijah@gmail.com', 'qwerty', 'Elijah', 'Fernandez'),
(7, 'pepe@gmail.com', 'qwerty', 'Pepe', 'Laviste');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`event_id`),
  ADD KEY `organizer_id` (`organizer_id`);

--
-- Indexes for table `event_registration`
--
ALTER TABLE `event_registration`
  ADD PRIMARY KEY (`registration_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `event_id` (`event_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `organizer_id` (`organizer_id`),
  ADD KEY `event_id` (`event_id`);

--
-- Indexes for table `organizer`
--
ALTER TABLE `organizer`
  ADD PRIMARY KEY (`organizer_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `organizer_request`
--
ALTER TABLE `organizer_request`
  ADD PRIMARY KEY (`request_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `event_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `event_registration`
--
ALTER TABLE `event_registration`
  MODIFY `registration_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `organizer`
--
ALTER TABLE `organizer`
  MODIFY `organizer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `organizer_request`
--
ALTER TABLE `organizer_request`
  MODIFY `request_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `events_ibfk_1` FOREIGN KEY (`organizer_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `event_registration`
--
ALTER TABLE `event_registration`
  ADD CONSTRAINT `event_registration_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `event_registration_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`);

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `notifications_ibfk_2` FOREIGN KEY (`organizer_id`) REFERENCES `organizer` (`organizer_id`),
  ADD CONSTRAINT `notifications_ibfk_3` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`);

--
-- Constraints for table `organizer`
--
ALTER TABLE `organizer`
  ADD CONSTRAINT `organizer_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `organizer_request`
--
ALTER TABLE `organizer_request`
  ADD CONSTRAINT `organizer_request_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
