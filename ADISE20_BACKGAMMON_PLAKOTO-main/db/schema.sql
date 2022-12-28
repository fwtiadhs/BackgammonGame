-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 24, 2020 at 04:53 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `plakoto`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `clean_board` ()  BEGIN
	replace into board select * from board_empty;
  UPDATE `players` SET username=NULL, token=NULL;
UPDATE `game_status` SET `status`='not active', `p_turn`=NULL, `result`=NULL;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `move_piece` (IN `x1` TINYINT, IN `y1` TINYINT, IN `x2` TINYINT, IN `y2` TINYINT)  BEGIN
	declare p enum('P1','P2','P3','P4','P5','P6','P7','P8','P9','P10','P11','P12','P13','P14','P15'); 
    declare p_color enum('W','B');
	
	select  piece, piece_color into p, p_color FROM `board` WHERE X=x1 AND Y=y1;
	
	update board
	set piece=p, piece_color=p_color
	where x=x2 and y=y2;
 
	UPDATE board
	SET piece=null,piece_color=null
	WHERE X=x1 AND Y=y1;
    
   
    
	
	
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `move_piece1` (IN `x1` TINYINT, IN `y1` TINYINT, IN `x2` TINYINT, IN `y2` TINYINT)  BEGIN
	declare p enum('P1','P2','P3','P4','P5','P6','P7','P8','P9','P10','P11','P12','P13','P14','P15'); 
    declare p_color enum('W','B');
	
	select  piece, piece_color into p, p_color FROM `board` WHERE X=x1 AND Y=y1;
	
	update board
	set piece=p, piece_color=p_color
	where x=x2 and y=y2;
	
	UPDATE board
	SET piece=null,piece_color=null
	WHERE X=x1 AND Y=y1;
    
	UPDATE game_status SET p_turn=IF(p_color='W','B','W');
	
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `test_move` ()  BEGIN
SELECT * FROM
board B1 INNER JOIN board B2
WHERE B1.x=2 AND B1.y=2
AND (B2.`piece_color` IS NULL OR B2.`piece_color`<>B1.`piece_color`)
AND B1.x=B2.x AND B1.y<B2.y AND (B2.y-B1.y)<=2 ;
    END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `board`
--

CREATE TABLE `board` (
  `x` tinyint(1) NOT NULL,
  `y` tinyint(1) NOT NULL,
  `b_color` enum('B','W') DEFAULT NULL,
  `piece_color` enum('W','B') DEFAULT NULL,
  `piece` enum('P1','P2','P3','P4','P5','P6','P7','P8','P9','P10','P11','P12','P13','P14','P15') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `board`
--

INSERT INTO `board` (`x`, `y`, `b_color`, `piece_color`, `piece`) VALUES
(1, 1, 'B', 'B', 'P1'),
(1, 2, 'B', 'B', 'P2'),
(1, 3, 'B', 'B', 'P3'),
(1, 4, 'B', 'B', 'P4'),
(1, 5, 'B', 'B', 'P5'),
(1, 6, 'B', 'B', 'P6'),
(1, 7, 'B', 'B', 'P7'),
(1, 8, 'B', 'B', 'P8'),
(1, 9, 'B', 'B', 'P9'),
(1, 10, 'B', 'B', 'P10'),
(1, 11, 'B', 'B', 'P11'),
(1, 12, 'B', 'B', 'P12'),
(1, 13, 'B', 'B', 'P13'),
(1, 14, 'B', 'B', 'P14'),
(1, 15, 'B', 'B', 'P15'),
(1, 16, 'B', NULL, NULL),
(1, 17, NULL, NULL, NULL),
(1, 18, 'W', NULL, NULL),
(1, 19, 'W', NULL, NULL),
(1, 20, 'W', 'W', 'P2'),
(1, 21, 'W', 'W', 'P3'),
(1, 22, 'W', 'W', 'P4'),
(1, 23, 'W', 'W', 'P5'),
(1, 24, 'W', 'W', 'P6'),
(1, 25, 'W', 'W', 'P7'),
(1, 26, 'W', 'W', 'P8'),
(1, 27, 'W', 'W', 'P9'),
(1, 28, 'W', 'W', 'P10'),
(1, 29, 'W', 'W', 'P11'),
(1, 30, 'W', 'W', 'P12'),
(1, 31, 'W', 'W', 'P13'),
(1, 32, 'W', 'W', 'P14'),
(1, 33, 'W', 'W', 'P15'),
(2, 1, 'B', NULL, NULL),
(2, 2, 'B', NULL, NULL),
(2, 3, 'B', NULL, NULL),
(2, 4, 'B', NULL, NULL),
(2, 5, 'B', NULL, NULL),
(2, 6, 'B', NULL, NULL),
(2, 7, 'B', NULL, NULL),
(2, 8, 'B', NULL, NULL),
(2, 9, 'B', NULL, NULL),
(2, 10, 'B', NULL, NULL),
(2, 11, 'B', NULL, NULL),
(2, 12, 'B', NULL, NULL),
(2, 13, 'B', NULL, NULL),
(2, 14, 'B', NULL, NULL),
(2, 15, 'B', NULL, NULL),
(2, 16, 'B', NULL, NULL),
(2, 17, NULL, NULL, NULL),
(2, 18, 'W', NULL, NULL),
(2, 19, 'W', NULL, NULL),
(2, 20, 'W', NULL, NULL),
(2, 21, 'W', NULL, NULL),
(2, 22, 'W', NULL, NULL),
(2, 23, 'W', NULL, NULL),
(2, 24, 'W', NULL, NULL),
(2, 25, 'W', NULL, NULL),
(2, 26, 'W', NULL, NULL),
(2, 27, 'W', NULL, NULL),
(2, 28, 'W', NULL, NULL),
(2, 29, 'W', NULL, NULL),
(2, 30, 'W', NULL, NULL),
(2, 31, 'W', NULL, NULL),
(2, 32, 'W', NULL, NULL),
(2, 33, 'W', NULL, NULL),
(3, 1, 'B', NULL, NULL),
(3, 2, 'B', NULL, NULL),
(3, 3, 'B', NULL, NULL),
(3, 4, 'B', NULL, NULL),
(3, 5, 'B', NULL, NULL),
(3, 6, 'B', NULL, NULL),
(3, 7, 'B', NULL, NULL),
(3, 8, 'B', NULL, NULL),
(3, 9, 'B', NULL, NULL),
(3, 10, 'B', NULL, NULL),
(3, 11, 'B', NULL, NULL),
(3, 12, 'B', NULL, NULL),
(3, 13, 'B', NULL, NULL),
(3, 14, 'B', NULL, NULL),
(3, 15, 'B', NULL, NULL),
(3, 16, 'B', NULL, NULL),
(3, 17, NULL, NULL, NULL),
(3, 18, 'W', NULL, NULL),
(3, 19, 'W', NULL, NULL),
(3, 20, 'W', 'W', 'P1'),
(3, 21, 'W', NULL, NULL),
(3, 22, 'W', NULL, NULL),
(3, 23, 'W', NULL, NULL),
(3, 24, 'W', NULL, NULL),
(3, 25, 'W', NULL, NULL),
(3, 26, 'W', NULL, NULL),
(3, 27, 'W', NULL, NULL),
(3, 28, 'W', NULL, NULL),
(3, 29, 'W', NULL, NULL),
(3, 30, 'W', NULL, NULL),
(3, 31, 'W', NULL, NULL),
(3, 32, 'W', NULL, NULL),
(3, 33, 'W', NULL, NULL),
(4, 1, 'B', NULL, NULL),
(4, 2, 'B', NULL, NULL),
(4, 3, 'B', NULL, NULL),
(4, 4, 'B', NULL, NULL),
(4, 5, 'B', NULL, NULL),
(4, 6, 'B', NULL, NULL),
(4, 7, 'B', NULL, NULL),
(4, 8, 'B', NULL, NULL),
(4, 9, 'B', NULL, NULL),
(4, 10, 'B', NULL, NULL),
(4, 11, 'B', NULL, NULL),
(4, 12, 'B', NULL, NULL),
(4, 13, 'B', NULL, NULL),
(4, 14, 'B', NULL, NULL),
(4, 15, 'B', NULL, NULL),
(4, 16, 'B', NULL, NULL),
(4, 17, NULL, NULL, NULL),
(4, 18, 'W', NULL, NULL),
(4, 19, 'W', NULL, NULL),
(4, 20, 'W', NULL, NULL),
(4, 21, 'W', NULL, NULL),
(4, 22, 'W', NULL, NULL),
(4, 23, 'W', NULL, NULL),
(4, 24, 'W', NULL, NULL),
(4, 25, 'W', NULL, NULL),
(4, 26, 'W', NULL, NULL),
(4, 27, 'W', NULL, NULL),
(4, 28, 'W', NULL, NULL),
(4, 29, 'W', NULL, NULL),
(4, 30, 'W', NULL, NULL),
(4, 31, 'W', NULL, NULL),
(4, 32, 'W', NULL, NULL),
(4, 33, 'W', NULL, NULL),
(5, 1, 'B', NULL, NULL),
(5, 2, 'B', NULL, NULL),
(5, 3, 'B', NULL, NULL),
(5, 4, 'B', NULL, NULL),
(5, 5, 'B', NULL, NULL),
(5, 6, 'B', NULL, NULL),
(5, 7, 'B', NULL, NULL),
(5, 8, 'B', NULL, NULL),
(5, 9, 'B', NULL, NULL),
(5, 10, 'B', NULL, NULL),
(5, 11, 'B', NULL, NULL),
(5, 12, 'B', NULL, NULL),
(5, 13, 'B', NULL, NULL),
(5, 14, 'B', NULL, NULL),
(5, 15, 'B', NULL, NULL),
(5, 16, 'B', NULL, NULL),
(5, 17, NULL, NULL, NULL),
(5, 18, 'W', NULL, NULL),
(5, 19, 'W', NULL, NULL),
(5, 20, 'W', NULL, NULL),
(5, 21, 'W', NULL, NULL),
(5, 22, 'W', NULL, NULL),
(5, 23, 'W', NULL, NULL),
(5, 24, 'W', NULL, NULL),
(5, 25, 'W', NULL, NULL),
(5, 26, 'W', NULL, NULL),
(5, 27, 'W', NULL, NULL),
(5, 28, 'W', NULL, NULL),
(5, 29, 'W', NULL, NULL),
(5, 30, 'W', NULL, NULL),
(5, 31, 'W', NULL, NULL),
(5, 32, 'W', NULL, NULL),
(5, 33, 'W', NULL, NULL),
(6, 1, 'B', NULL, NULL),
(6, 2, 'B', NULL, NULL),
(6, 3, 'B', NULL, NULL),
(6, 4, 'B', NULL, NULL),
(6, 5, 'B', NULL, NULL),
(6, 6, 'B', NULL, NULL),
(6, 7, 'B', NULL, NULL),
(6, 8, 'B', NULL, NULL),
(6, 9, 'B', NULL, NULL),
(6, 10, 'B', NULL, NULL),
(6, 11, 'B', NULL, NULL),
(6, 12, 'B', NULL, NULL),
(6, 13, 'B', NULL, NULL),
(6, 14, 'B', NULL, NULL),
(6, 15, 'B', NULL, NULL),
(6, 16, 'B', NULL, NULL),
(6, 17, NULL, NULL, NULL),
(6, 18, 'W', NULL, NULL),
(6, 19, 'W', NULL, NULL),
(6, 20, 'W', NULL, NULL),
(6, 21, 'W', NULL, NULL),
(6, 22, 'W', NULL, NULL),
(6, 23, 'W', NULL, NULL),
(6, 24, 'W', NULL, NULL),
(6, 25, 'W', NULL, NULL),
(6, 26, 'W', NULL, NULL),
(6, 27, 'W', NULL, NULL),
(6, 28, 'W', NULL, NULL),
(6, 29, 'W', NULL, NULL),
(6, 30, 'W', NULL, NULL),
(6, 31, 'W', NULL, NULL),
(6, 32, 'W', NULL, NULL),
(6, 33, 'W', NULL, NULL),
(7, 1, 'B', NULL, NULL),
(7, 2, 'B', NULL, NULL),
(7, 3, 'B', NULL, NULL),
(7, 4, 'B', NULL, NULL),
(7, 5, 'B', NULL, NULL),
(7, 6, 'B', NULL, NULL),
(7, 7, 'B', NULL, NULL),
(7, 8, 'B', NULL, NULL),
(7, 9, 'B', NULL, NULL),
(7, 10, 'B', NULL, NULL),
(7, 11, 'B', NULL, NULL),
(7, 12, 'B', NULL, NULL),
(7, 13, 'B', NULL, NULL),
(7, 14, 'B', NULL, NULL),
(7, 15, 'B', NULL, NULL),
(7, 16, 'B', NULL, NULL),
(7, 17, NULL, NULL, NULL),
(7, 18, 'W', NULL, NULL),
(7, 19, 'W', NULL, NULL),
(7, 20, 'W', NULL, NULL),
(7, 21, 'W', NULL, NULL),
(7, 22, 'W', NULL, NULL),
(7, 23, 'W', NULL, NULL),
(7, 24, 'W', NULL, NULL),
(7, 25, 'W', NULL, NULL),
(7, 26, 'W', NULL, NULL),
(7, 27, 'W', NULL, NULL),
(7, 28, 'W', NULL, NULL),
(7, 29, 'W', NULL, NULL),
(7, 30, 'W', NULL, NULL),
(7, 31, 'W', NULL, NULL),
(7, 32, 'W', NULL, NULL),
(7, 33, 'W', NULL, NULL),
(8, 1, 'B', NULL, NULL),
(8, 2, 'B', NULL, NULL),
(8, 3, 'B', NULL, NULL),
(8, 4, 'B', NULL, NULL),
(8, 5, 'B', NULL, NULL),
(8, 6, 'B', NULL, NULL),
(8, 7, 'B', NULL, NULL),
(8, 8, 'B', NULL, NULL),
(8, 9, 'B', NULL, NULL),
(8, 10, 'B', NULL, NULL),
(8, 11, 'B', NULL, NULL),
(8, 12, 'B', NULL, NULL),
(8, 13, 'B', NULL, NULL),
(8, 14, 'B', NULL, NULL),
(8, 15, 'B', NULL, NULL),
(8, 16, 'B', NULL, NULL),
(8, 17, NULL, NULL, NULL),
(8, 18, 'W', NULL, NULL),
(8, 19, 'W', NULL, NULL),
(8, 20, 'W', NULL, NULL),
(8, 21, 'W', NULL, NULL),
(8, 22, 'W', NULL, NULL),
(8, 23, 'W', NULL, NULL),
(8, 24, 'W', NULL, NULL),
(8, 25, 'W', NULL, NULL),
(8, 26, 'W', NULL, NULL),
(8, 27, 'W', NULL, NULL),
(8, 28, 'W', NULL, NULL),
(8, 29, 'W', NULL, NULL),
(8, 30, 'W', NULL, NULL),
(8, 31, 'W', NULL, NULL),
(8, 32, 'W', NULL, NULL),
(8, 33, 'W', NULL, NULL),
(9, 1, 'B', NULL, NULL),
(9, 2, 'B', NULL, NULL),
(9, 3, 'B', NULL, NULL),
(9, 4, 'B', NULL, NULL),
(9, 5, 'B', NULL, NULL),
(9, 6, 'B', NULL, NULL),
(9, 7, 'B', NULL, NULL),
(9, 8, 'B', NULL, NULL),
(9, 9, 'B', NULL, NULL),
(9, 10, 'B', NULL, NULL),
(9, 11, 'B', NULL, NULL),
(9, 12, 'B', NULL, NULL),
(9, 13, 'B', NULL, NULL),
(9, 14, 'B', NULL, NULL),
(9, 15, 'B', NULL, NULL),
(9, 16, 'B', NULL, NULL),
(9, 17, NULL, NULL, NULL),
(9, 18, 'W', NULL, NULL),
(9, 19, 'W', NULL, NULL),
(9, 20, 'W', NULL, NULL),
(9, 21, 'W', NULL, NULL),
(9, 22, 'W', NULL, NULL),
(9, 23, 'W', NULL, NULL),
(9, 24, 'W', NULL, NULL),
(9, 25, 'W', NULL, NULL),
(9, 26, 'W', NULL, NULL),
(9, 27, 'W', NULL, NULL),
(9, 28, 'W', NULL, NULL),
(9, 29, 'W', NULL, NULL),
(9, 30, 'W', NULL, NULL),
(9, 31, 'W', NULL, NULL),
(9, 32, 'W', NULL, NULL),
(9, 33, 'W', NULL, NULL),
(10, 1, 'B', NULL, NULL),
(10, 2, 'B', NULL, NULL),
(10, 3, 'B', NULL, NULL),
(10, 4, 'B', NULL, NULL),
(10, 5, 'B', NULL, NULL),
(10, 6, 'B', NULL, NULL),
(10, 7, 'B', NULL, NULL),
(10, 8, 'B', NULL, NULL),
(10, 9, 'B', NULL, NULL),
(10, 10, 'B', NULL, NULL),
(10, 11, 'B', NULL, NULL),
(10, 12, 'B', NULL, NULL),
(10, 13, 'B', NULL, NULL),
(10, 14, 'B', NULL, NULL),
(10, 15, 'B', NULL, NULL),
(10, 16, 'B', NULL, NULL),
(10, 17, NULL, NULL, NULL),
(10, 18, 'W', NULL, NULL),
(10, 19, 'W', NULL, NULL),
(10, 20, 'W', NULL, NULL),
(10, 21, 'W', NULL, NULL),
(10, 22, 'W', NULL, NULL),
(10, 23, 'W', NULL, NULL),
(10, 24, 'W', NULL, NULL),
(10, 25, 'W', NULL, NULL),
(10, 26, 'W', NULL, NULL),
(10, 27, 'W', NULL, NULL),
(10, 28, 'W', NULL, NULL),
(10, 29, 'W', NULL, NULL),
(10, 30, 'W', NULL, NULL),
(10, 31, 'W', NULL, NULL),
(10, 32, 'W', NULL, NULL),
(10, 33, 'W', NULL, NULL),
(11, 1, 'B', NULL, NULL),
(11, 2, 'B', NULL, NULL),
(11, 3, 'B', NULL, NULL),
(11, 4, 'B', NULL, NULL),
(11, 5, 'B', NULL, NULL),
(11, 6, 'B', NULL, NULL),
(11, 7, 'B', NULL, NULL),
(11, 8, 'B', NULL, NULL),
(11, 9, 'B', NULL, NULL),
(11, 10, 'B', NULL, NULL),
(11, 11, 'B', NULL, NULL),
(11, 12, 'B', NULL, NULL),
(11, 13, 'B', NULL, NULL),
(11, 14, 'B', NULL, NULL),
(11, 15, 'B', NULL, NULL),
(11, 16, 'B', NULL, NULL),
(11, 17, NULL, NULL, NULL),
(11, 18, 'W', NULL, NULL),
(11, 19, 'W', NULL, NULL),
(11, 20, 'W', NULL, NULL),
(11, 21, 'W', NULL, NULL),
(11, 22, 'W', NULL, NULL),
(11, 23, 'W', NULL, NULL),
(11, 24, 'W', NULL, NULL),
(11, 25, 'W', NULL, NULL),
(11, 26, 'W', NULL, NULL),
(11, 27, 'W', NULL, NULL),
(11, 28, 'W', NULL, NULL),
(11, 29, 'W', NULL, NULL),
(11, 30, 'W', NULL, NULL),
(11, 31, 'W', NULL, NULL),
(11, 32, 'W', NULL, NULL),
(11, 33, 'W', NULL, NULL),
(12, 1, 'B', NULL, NULL),
(12, 2, 'B', NULL, NULL),
(12, 3, 'B', NULL, NULL),
(12, 4, 'B', NULL, NULL),
(12, 5, 'B', NULL, NULL),
(12, 6, 'B', NULL, NULL),
(12, 7, 'B', NULL, NULL),
(12, 8, 'B', NULL, NULL),
(12, 9, 'B', NULL, NULL),
(12, 10, 'B', NULL, NULL),
(12, 11, 'B', NULL, NULL),
(12, 12, 'B', NULL, NULL),
(12, 13, 'B', NULL, NULL),
(12, 14, 'B', NULL, NULL),
(12, 15, 'B', NULL, NULL),
(12, 16, 'B', NULL, NULL),
(12, 17, NULL, NULL, NULL),
(12, 18, 'W', NULL, NULL),
(12, 19, 'W', NULL, NULL),
(12, 20, 'W', NULL, NULL),
(12, 21, 'W', NULL, NULL),
(12, 22, 'W', NULL, NULL),
(12, 23, 'W', NULL, NULL),
(12, 24, 'W', NULL, NULL),
(12, 25, 'W', NULL, NULL),
(12, 26, 'W', NULL, NULL),
(12, 27, 'W', NULL, NULL),
(12, 28, 'W', NULL, NULL),
(12, 29, 'W', NULL, NULL),
(12, 30, 'W', NULL, NULL),
(12, 31, 'W', NULL, NULL),
(12, 32, 'W', NULL, NULL),
(12, 33, 'W', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `board_empty`
--

CREATE TABLE `board_empty` (
  `x` tinyint(1) NOT NULL,
  `y` tinyint(1) NOT NULL,
  `b_color` enum('B','W') DEFAULT NULL,
  `piece_color` enum('W','B') DEFAULT NULL,
  `piece` enum('P1','P2','P3','P4','P5','P6','P7','P8','P9','P10','P11','P12','P13','P14','P15') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `board_empty`
--

INSERT INTO `board_empty` (`x`, `y`, `b_color`, `piece_color`, `piece`) VALUES
(1, 1, 'B', 'B', 'P1'),
(1, 2, 'B', 'B', 'P2'),
(1, 3, 'B', 'B', 'P3'),
(1, 4, 'B', 'B', 'P4'),
(1, 5, 'B', 'B', 'P5'),
(1, 6, 'B', 'B', 'P6'),
(1, 7, 'B', 'B', 'P7'),
(1, 8, 'B', 'B', 'P8'),
(1, 9, 'B', 'B', 'P9'),
(1, 10, 'B', 'B', 'P10'),
(1, 11, 'B', 'B', 'P11'),
(1, 12, 'B', 'B', 'P12'),
(1, 13, 'B', 'B', 'P13'),
(1, 14, 'B', 'B', 'P14'),
(1, 15, 'B', 'B', 'P15'),
(1, 16, 'B', NULL, NULL),
(1, 17, NULL, NULL, NULL),
(1, 18, 'W', NULL, NULL),
(1, 19, 'W', 'W', 'P1'),
(1, 20, 'W', 'W', 'P2'),
(1, 21, 'W', 'W', 'P3'),
(1, 22, 'W', 'W', 'P4'),
(1, 23, 'W', 'W', 'P5'),
(1, 24, 'W', 'W', 'P6'),
(1, 25, 'W', 'W', 'P7'),
(1, 26, 'W', 'W', 'P8'),
(1, 27, 'W', 'W', 'P9'),
(1, 28, 'W', 'W', 'P10'),
(1, 29, 'W', 'W', 'P11'),
(1, 30, 'W', 'W', 'P12'),
(1, 31, 'W', 'W', 'P13'),
(1, 32, 'W', 'W', 'P14'),
(1, 33, 'W', 'W', 'P15'),
(2, 1, 'B', NULL, NULL),
(2, 2, 'B', NULL, NULL),
(2, 3, 'B', NULL, NULL),
(2, 4, 'B', NULL, NULL),
(2, 5, 'B', NULL, NULL),
(2, 6, 'B', NULL, NULL),
(2, 7, 'B', NULL, NULL),
(2, 8, 'B', NULL, NULL),
(2, 9, 'B', NULL, NULL),
(2, 10, 'B', NULL, NULL),
(2, 11, 'B', NULL, NULL),
(2, 12, 'B', NULL, NULL),
(2, 13, 'B', NULL, NULL),
(2, 14, 'B', NULL, NULL),
(2, 15, 'B', NULL, NULL),
(2, 16, 'B', NULL, NULL),
(2, 17, NULL, NULL, NULL),
(2, 18, 'W', NULL, NULL),
(2, 19, 'W', NULL, NULL),
(2, 20, 'W', NULL, NULL),
(2, 21, 'W', NULL, NULL),
(2, 22, 'W', NULL, NULL),
(2, 23, 'W', NULL, NULL),
(2, 24, 'W', NULL, NULL),
(2, 25, 'W', NULL, NULL),
(2, 26, 'W', NULL, NULL),
(2, 27, 'W', NULL, NULL),
(2, 28, 'W', NULL, NULL),
(2, 29, 'W', NULL, NULL),
(2, 30, 'W', NULL, NULL),
(2, 31, 'W', NULL, NULL),
(2, 32, 'W', NULL, NULL),
(2, 33, 'W', NULL, NULL),
(3, 1, 'B', NULL, NULL),
(3, 2, 'B', NULL, NULL),
(3, 3, 'B', NULL, NULL),
(3, 4, 'B', NULL, NULL),
(3, 5, 'B', NULL, NULL),
(3, 6, 'B', NULL, NULL),
(3, 7, 'B', NULL, NULL),
(3, 8, 'B', NULL, NULL),
(3, 9, 'B', NULL, NULL),
(3, 10, 'B', NULL, NULL),
(3, 11, 'B', NULL, NULL),
(3, 12, 'B', NULL, NULL),
(3, 13, 'B', NULL, NULL),
(3, 14, 'B', NULL, NULL),
(3, 15, 'B', NULL, NULL),
(3, 16, 'B', NULL, NULL),
(3, 17, NULL, NULL, NULL),
(3, 18, 'W', NULL, NULL),
(3, 19, 'W', NULL, NULL),
(3, 20, 'W', NULL, NULL),
(3, 21, 'W', NULL, NULL),
(3, 22, 'W', NULL, NULL),
(3, 23, 'W', NULL, NULL),
(3, 24, 'W', NULL, NULL),
(3, 25, 'W', NULL, NULL),
(3, 26, 'W', NULL, NULL),
(3, 27, 'W', NULL, NULL),
(3, 28, 'W', NULL, NULL),
(3, 29, 'W', NULL, NULL),
(3, 30, 'W', NULL, NULL),
(3, 31, 'W', NULL, NULL),
(3, 32, 'W', NULL, NULL),
(3, 33, 'W', NULL, NULL),
(4, 1, 'B', NULL, NULL),
(4, 2, 'B', NULL, NULL),
(4, 3, 'B', NULL, NULL),
(4, 4, 'B', NULL, NULL),
(4, 5, 'B', NULL, NULL),
(4, 6, 'B', NULL, NULL),
(4, 7, 'B', NULL, NULL),
(4, 8, 'B', NULL, NULL),
(4, 9, 'B', NULL, NULL),
(4, 10, 'B', NULL, NULL),
(4, 11, 'B', NULL, NULL),
(4, 12, 'B', NULL, NULL),
(4, 13, 'B', NULL, NULL),
(4, 14, 'B', NULL, NULL),
(4, 15, 'B', NULL, NULL),
(4, 16, 'B', NULL, NULL),
(4, 17, NULL, NULL, NULL),
(4, 18, 'W', NULL, NULL),
(4, 19, 'W', NULL, NULL),
(4, 20, 'W', NULL, NULL),
(4, 21, 'W', NULL, NULL),
(4, 22, 'W', NULL, NULL),
(4, 23, 'W', NULL, NULL),
(4, 24, 'W', NULL, NULL),
(4, 25, 'W', NULL, NULL),
(4, 26, 'W', NULL, NULL),
(4, 27, 'W', NULL, NULL),
(4, 28, 'W', NULL, NULL),
(4, 29, 'W', NULL, NULL),
(4, 30, 'W', NULL, NULL),
(4, 31, 'W', NULL, NULL),
(4, 32, 'W', NULL, NULL),
(4, 33, 'W', NULL, NULL),
(5, 1, 'B', NULL, NULL),
(5, 2, 'B', NULL, NULL),
(5, 3, 'B', NULL, NULL),
(5, 4, 'B', NULL, NULL),
(5, 5, 'B', NULL, NULL),
(5, 6, 'B', NULL, NULL),
(5, 7, 'B', NULL, NULL),
(5, 8, 'B', NULL, NULL),
(5, 9, 'B', NULL, NULL),
(5, 10, 'B', NULL, NULL),
(5, 11, 'B', NULL, NULL),
(5, 12, 'B', NULL, NULL),
(5, 13, 'B', NULL, NULL),
(5, 14, 'B', NULL, NULL),
(5, 15, 'B', NULL, NULL),
(5, 16, 'B', NULL, NULL),
(5, 17, NULL, NULL, NULL),
(5, 18, 'W', NULL, NULL),
(5, 19, 'W', NULL, NULL),
(5, 20, 'W', NULL, NULL),
(5, 21, 'W', NULL, NULL),
(5, 22, 'W', NULL, NULL),
(5, 23, 'W', NULL, NULL),
(5, 24, 'W', NULL, NULL),
(5, 25, 'W', NULL, NULL),
(5, 26, 'W', NULL, NULL),
(5, 27, 'W', NULL, NULL),
(5, 28, 'W', NULL, NULL),
(5, 29, 'W', NULL, NULL),
(5, 30, 'W', NULL, NULL),
(5, 31, 'W', NULL, NULL),
(5, 32, 'W', NULL, NULL),
(5, 33, 'W', NULL, NULL),
(6, 1, 'B', NULL, NULL),
(6, 2, 'B', NULL, NULL),
(6, 3, 'B', NULL, NULL),
(6, 4, 'B', NULL, NULL),
(6, 5, 'B', NULL, NULL),
(6, 6, 'B', NULL, NULL),
(6, 7, 'B', NULL, NULL),
(6, 8, 'B', NULL, NULL),
(6, 9, 'B', NULL, NULL),
(6, 10, 'B', NULL, NULL),
(6, 11, 'B', NULL, NULL),
(6, 12, 'B', NULL, NULL),
(6, 13, 'B', NULL, NULL),
(6, 14, 'B', NULL, NULL),
(6, 15, 'B', NULL, NULL),
(6, 16, 'B', NULL, NULL),
(6, 17, NULL, NULL, NULL),
(6, 18, 'W', NULL, NULL),
(6, 19, 'W', NULL, NULL),
(6, 20, 'W', NULL, NULL),
(6, 21, 'W', NULL, NULL),
(6, 22, 'W', NULL, NULL),
(6, 23, 'W', NULL, NULL),
(6, 24, 'W', NULL, NULL),
(6, 25, 'W', NULL, NULL),
(6, 26, 'W', NULL, NULL),
(6, 27, 'W', NULL, NULL),
(6, 28, 'W', NULL, NULL),
(6, 29, 'W', NULL, NULL),
(6, 30, 'W', NULL, NULL),
(6, 31, 'W', NULL, NULL),
(6, 32, 'W', NULL, NULL),
(6, 33, 'W', NULL, NULL),
(7, 1, 'B', NULL, NULL),
(7, 2, 'B', NULL, NULL),
(7, 3, 'B', NULL, NULL),
(7, 4, 'B', NULL, NULL),
(7, 5, 'B', NULL, NULL),
(7, 6, 'B', NULL, NULL),
(7, 7, 'B', NULL, NULL),
(7, 8, 'B', NULL, NULL),
(7, 9, 'B', NULL, NULL),
(7, 10, 'B', NULL, NULL),
(7, 11, 'B', NULL, NULL),
(7, 12, 'B', NULL, NULL),
(7, 13, 'B', NULL, NULL),
(7, 14, 'B', NULL, NULL),
(7, 15, 'B', NULL, NULL),
(7, 16, 'B', NULL, NULL),
(7, 17, NULL, NULL, NULL),
(7, 18, 'W', NULL, NULL),
(7, 19, 'W', NULL, NULL),
(7, 20, 'W', NULL, NULL),
(7, 21, 'W', NULL, NULL),
(7, 22, 'W', NULL, NULL),
(7, 23, 'W', NULL, NULL),
(7, 24, 'W', NULL, NULL),
(7, 25, 'W', NULL, NULL),
(7, 26, 'W', NULL, NULL),
(7, 27, 'W', NULL, NULL),
(7, 28, 'W', NULL, NULL),
(7, 29, 'W', NULL, NULL),
(7, 30, 'W', NULL, NULL),
(7, 31, 'W', NULL, NULL),
(7, 32, 'W', NULL, NULL),
(7, 33, 'W', NULL, NULL),
(8, 1, 'B', NULL, NULL),
(8, 2, 'B', NULL, NULL),
(8, 3, 'B', NULL, NULL),
(8, 4, 'B', NULL, NULL),
(8, 5, 'B', NULL, NULL),
(8, 6, 'B', NULL, NULL),
(8, 7, 'B', NULL, NULL),
(8, 8, 'B', NULL, NULL),
(8, 9, 'B', NULL, NULL),
(8, 10, 'B', NULL, NULL),
(8, 11, 'B', NULL, NULL),
(8, 12, 'B', NULL, NULL),
(8, 13, 'B', NULL, NULL),
(8, 14, 'B', NULL, NULL),
(8, 15, 'B', NULL, NULL),
(8, 16, 'B', NULL, NULL),
(8, 17, NULL, NULL, NULL),
(8, 18, 'W', NULL, NULL),
(8, 19, 'W', NULL, NULL),
(8, 20, 'W', NULL, NULL),
(8, 21, 'W', NULL, NULL),
(8, 22, 'W', NULL, NULL),
(8, 23, 'W', NULL, NULL),
(8, 24, 'W', NULL, NULL),
(8, 25, 'W', NULL, NULL),
(8, 26, 'W', NULL, NULL),
(8, 27, 'W', NULL, NULL),
(8, 28, 'W', NULL, NULL),
(8, 29, 'W', NULL, NULL),
(8, 30, 'W', NULL, NULL),
(8, 31, 'W', NULL, NULL),
(8, 32, 'W', NULL, NULL),
(8, 33, 'W', NULL, NULL),
(9, 1, 'B', NULL, NULL),
(9, 2, 'B', NULL, NULL),
(9, 3, 'B', NULL, NULL),
(9, 4, 'B', NULL, NULL),
(9, 5, 'B', NULL, NULL),
(9, 6, 'B', NULL, NULL),
(9, 7, 'B', NULL, NULL),
(9, 8, 'B', NULL, NULL),
(9, 9, 'B', NULL, NULL),
(9, 10, 'B', NULL, NULL),
(9, 11, 'B', NULL, NULL),
(9, 12, 'B', NULL, NULL),
(9, 13, 'B', NULL, NULL),
(9, 14, 'B', NULL, NULL),
(9, 15, 'B', NULL, NULL),
(9, 16, 'B', NULL, NULL),
(9, 17, NULL, NULL, NULL),
(9, 18, 'W', NULL, NULL),
(9, 19, 'W', NULL, NULL),
(9, 20, 'W', NULL, NULL),
(9, 21, 'W', NULL, NULL),
(9, 22, 'W', NULL, NULL),
(9, 23, 'W', NULL, NULL),
(9, 24, 'W', NULL, NULL),
(9, 25, 'W', NULL, NULL),
(9, 26, 'W', NULL, NULL),
(9, 27, 'W', NULL, NULL),
(9, 28, 'W', NULL, NULL),
(9, 29, 'W', NULL, NULL),
(9, 30, 'W', NULL, NULL),
(9, 31, 'W', NULL, NULL),
(9, 32, 'W', NULL, NULL),
(9, 33, 'W', NULL, NULL),
(10, 1, 'B', NULL, NULL),
(10, 2, 'B', NULL, NULL),
(10, 3, 'B', NULL, NULL),
(10, 4, 'B', NULL, NULL),
(10, 5, 'B', NULL, NULL),
(10, 6, 'B', NULL, NULL),
(10, 7, 'B', NULL, NULL),
(10, 8, 'B', NULL, NULL),
(10, 9, 'B', NULL, NULL),
(10, 10, 'B', NULL, NULL),
(10, 11, 'B', NULL, NULL),
(10, 12, 'B', NULL, NULL),
(10, 13, 'B', NULL, NULL),
(10, 14, 'B', NULL, NULL),
(10, 15, 'B', NULL, NULL),
(10, 16, 'B', NULL, NULL),
(10, 17, NULL, NULL, NULL),
(10, 18, 'W', NULL, NULL),
(10, 19, 'W', NULL, NULL),
(10, 20, 'W', NULL, NULL),
(10, 21, 'W', NULL, NULL),
(10, 22, 'W', NULL, NULL),
(10, 23, 'W', NULL, NULL),
(10, 24, 'W', NULL, NULL),
(10, 25, 'W', NULL, NULL),
(10, 26, 'W', NULL, NULL),
(10, 27, 'W', NULL, NULL),
(10, 28, 'W', NULL, NULL),
(10, 29, 'W', NULL, NULL),
(10, 30, 'W', NULL, NULL),
(10, 31, 'W', NULL, NULL),
(10, 32, 'W', NULL, NULL),
(10, 33, 'W', NULL, NULL),
(11, 1, 'B', NULL, NULL),
(11, 2, 'B', NULL, NULL),
(11, 3, 'B', NULL, NULL),
(11, 4, 'B', NULL, NULL),
(11, 5, 'B', NULL, NULL),
(11, 6, 'B', NULL, NULL),
(11, 7, 'B', NULL, NULL),
(11, 8, 'B', NULL, NULL),
(11, 9, 'B', NULL, NULL),
(11, 10, 'B', NULL, NULL),
(11, 11, 'B', NULL, NULL),
(11, 12, 'B', NULL, NULL),
(11, 13, 'B', NULL, NULL),
(11, 14, 'B', NULL, NULL),
(11, 15, 'B', NULL, NULL),
(11, 16, 'B', NULL, NULL),
(11, 17, NULL, NULL, NULL),
(11, 18, 'W', NULL, NULL),
(11, 19, 'W', NULL, NULL),
(11, 20, 'W', NULL, NULL),
(11, 21, 'W', NULL, NULL),
(11, 22, 'W', NULL, NULL),
(11, 23, 'W', NULL, NULL),
(11, 24, 'W', NULL, NULL),
(11, 25, 'W', NULL, NULL),
(11, 26, 'W', NULL, NULL),
(11, 27, 'W', NULL, NULL),
(11, 28, 'W', NULL, NULL),
(11, 29, 'W', NULL, NULL),
(11, 30, 'W', NULL, NULL),
(11, 31, 'W', NULL, NULL),
(11, 32, 'W', NULL, NULL),
(11, 33, 'W', NULL, NULL),
(12, 1, 'B', NULL, NULL),
(12, 2, 'B', NULL, NULL),
(12, 3, 'B', NULL, NULL),
(12, 4, 'B', NULL, NULL),
(12, 5, 'B', NULL, NULL),
(12, 6, 'B', NULL, NULL),
(12, 7, 'B', NULL, NULL),
(12, 8, 'B', NULL, NULL),
(12, 9, 'B', NULL, NULL),
(12, 10, 'B', NULL, NULL),
(12, 11, 'B', NULL, NULL),
(12, 12, 'B', NULL, NULL),
(12, 13, 'B', NULL, NULL),
(12, 14, 'B', NULL, NULL),
(12, 15, 'B', NULL, NULL),
(12, 16, 'B', NULL, NULL),
(12, 17, NULL, NULL, NULL),
(12, 18, 'W', NULL, NULL),
(12, 19, 'W', NULL, NULL),
(12, 20, 'W', NULL, NULL),
(12, 21, 'W', NULL, NULL),
(12, 22, 'W', NULL, NULL),
(12, 23, 'W', NULL, NULL),
(12, 24, 'W', NULL, NULL),
(12, 25, 'W', NULL, NULL),
(12, 26, 'W', NULL, NULL),
(12, 27, 'W', NULL, NULL),
(12, 28, 'W', NULL, NULL),
(12, 29, 'W', NULL, NULL),
(12, 30, 'W', NULL, NULL),
(12, 31, 'W', NULL, NULL),
(12, 32, 'W', NULL, NULL),
(12, 33, 'W', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `game_status`
--

CREATE TABLE `game_status` (
  `status` enum('not active','initialized','started','ended','aborded') NOT NULL DEFAULT 'not active',
  `p_turn` enum('W','B') DEFAULT NULL,
  `result` enum('B','W','D') DEFAULT NULL,
  `last_change` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `game_status`
--

INSERT INTO `game_status` (`status`, `p_turn`, `result`, `last_change`) VALUES
('aborded', NULL, 'B', '2020-12-24 15:52:13');

--
-- Triggers `game_status`
--
DELIMITER $$
CREATE TRIGGER `game_status_update` BEFORE UPDATE ON `game_status` FOR EACH ROW BEGIN
		set NEW.last_change = now();
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

CREATE TABLE `players` (
  `username` varchar(20) DEFAULT NULL,
  `piece_color` enum('B','W') NOT NULL,
  `token` varchar(100) DEFAULT NULL,
  `zari1` varchar(1) DEFAULT NULL,
  `zari2` varchar(1) DEFAULT NULL,
  `last_action` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `players`
--

INSERT INTO `players` (`username`, `piece_color`, `token`, `zari1`, `zari2`, `last_action`) VALUES
('asd', 'B', 'd81e9f2c2dcb0ddc6c3d29e4fd64e88b', NULL, NULL, NULL),
('asd', 'W', 'aef3804c479de117854125b1a5e60155', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `players_empty`
--

CREATE TABLE `players_empty` (
  `username` varchar(20) DEFAULT NULL,
  `piece_color` enum('B','W') NOT NULL,
  `token` varchar(100) DEFAULT NULL,
  `last_action` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `players_empty`
--

INSERT INTO `players_empty` (`username`, `piece_color`, `token`, `last_action`) VALUES
(NULL, 'B', '4ebf0993d4f009a2f694371a275fb015', NULL),
(NULL, 'W', '2cc18505938b5ff09a7050c12b96b4ad', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `board`
--
ALTER TABLE `board`
  ADD PRIMARY KEY (`x`,`y`);

--
-- Indexes for table `board_empty`
--
ALTER TABLE `board_empty`
  ADD PRIMARY KEY (`x`,`y`) USING BTREE;

--
-- Indexes for table `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`piece_color`);

--
-- Indexes for table `players_empty`
--
ALTER TABLE `players_empty`
  ADD PRIMARY KEY (`piece_color`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
