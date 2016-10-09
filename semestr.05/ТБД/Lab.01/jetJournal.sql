SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `attendance`
-- ----------------------------
DROP TABLE IF EXISTS `attendance`;
CREATE TABLE `attendance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `mark` int(10) DEFAULT NULL,
  `presence` tinyint(1) NOT NULL,
  `reason` enum('ill','conference','other') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `attendance_student_id_fk` (`student_id`),
  KEY `attendance_class_id_fk` (`class_id`),
  CONSTRAINT `attendance_class_id_fk` FOREIGN KEY (`class_id`) REFERENCES `class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `attendance_student_id_fk` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `cathedra`
-- ----------------------------
DROP TABLE IF EXISTS `cathedra`;
CREATE TABLE `cathedra` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `institute_id` int(11) NOT NULL,
  `site` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cathedra_institute_id_fk` (`institute_id`),
  CONSTRAINT `cathedra_institute_id_fk` FOREIGN KEY (`institute_id`) REFERENCES `institute` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `cathedra_teacher`
-- ----------------------------
DROP TABLE IF EXISTS `cathedra_teacher`;
CREATE TABLE `cathedra_teacher` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cathedra_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cathedra_teacher_cathedra_id_teacher_id_uindex` (`cathedra_id`,`teacher_id`),
  KEY `cathedra_teacher_teacher_id_fk` (`teacher_id`),
  CONSTRAINT `cathedra_teacher_cathedra_id_fk` FOREIGN KEY (`cathedra_id`) REFERENCES `cathedra` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cathedra_teacher_teacher_id_fk` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `certificate`
-- ----------------------------
DROP TABLE IF EXISTS `certificate`;
CREATE TABLE `certificate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `date_from` date NOT NULL,
  `date_to` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `certificate_student_id_fk` (`student_id`),
  CONSTRAINT `certificate_student_id_fk` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `class`
-- ----------------------------
DROP TABLE IF EXISTS `class`;
CREATE TABLE `class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discipline_id` int(11) NOT NULL,
  `teacher_id` int(11) DEFAULT NULL,
  `group_id` int(11) NOT NULL,
  `date` datetime DEFAULT NULL,
  `type` enum('lection','laboratory','practice','seminar','course') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `class_discipline_id_fk` (`discipline_id`),
  KEY `class_teacher_id_fk` (`teacher_id`),
  KEY `class_group_id_fk` (`group_id`),
  CONSTRAINT `class_discipline_id_fk` FOREIGN KEY (`discipline_id`) REFERENCES `discipline` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `class_group_id_fk` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `class_teacher_id_fk` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `discipline`
-- ----------------------------
DROP TABLE IF EXISTS `discipline`;
CREATE TABLE `discipline` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `discipline_teacher`
-- ----------------------------
DROP TABLE IF EXISTS `discipline_teacher`;
CREATE TABLE `discipline_teacher` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discipline_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `discipline_teacher_discipline_id_teacher_id_uindex` (`discipline_id`,`teacher_id`),
  KEY `discipline_teacher_teacher_id_fk` (`teacher_id`),
  CONSTRAINT `discipline_teacher_discipline_id_fk` FOREIGN KEY (`discipline_id`) REFERENCES `discipline` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `discipline_teacher_teacher_id_fk` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `group`
-- ----------------------------
DROP TABLE IF EXISTS `group`;
CREATE TABLE `group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `course` int(2) DEFAULT NULL,
  `cathedra_id` int(11) DEFAULT NULL,
  `steward_id` int(11) DEFAULT NULL,
  `super_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `group_cathedra_id_fk` (`cathedra_id`),
  KEY `group_student_id_fk` (`steward_id`),
  KEY `group_group_id_fk` (`super_id`),
  CONSTRAINT `group_cathedra_id_fk` FOREIGN KEY (`cathedra_id`) REFERENCES `cathedra` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `group_group_id_fk` FOREIGN KEY (`super_id`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `group_student_id_fk` FOREIGN KEY (`steward_id`) REFERENCES `student` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `group_student`
-- ----------------------------
DROP TABLE IF EXISTS `group_student`;
CREATE TABLE `group_student` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_student_group_id_student_id_uindex` (`group_id`,`student_id`),
  KEY `group_student_student_id_fk` (`student_id`),
  CONSTRAINT `group_student_group_id_fk` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `group_student_student_id_fk` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `institute`
-- ----------------------------
DROP TABLE IF EXISTS `institute`;
CREATE TABLE `institute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `university_id` int(11) NOT NULL,
  `site` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `institute_university_id_fk` (`university_id`),
  CONSTRAINT `institute_university_id_fk` FOREIGN KEY (`university_id`) REFERENCES `university` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `student`
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `teacher`
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `university`
-- ----------------------------
DROP TABLE IF EXISTS `university`;
CREATE TABLE `university` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `site` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `university_name_uindex` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;
