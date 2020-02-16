CREATE TABLE `book_ex`.`tbl_board` (
  `bno` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(200) NOT NULL,
  `content` TEXT NULL,
  `writer` VARCHAR(50) NOT NULL,
  `regdate` TIMESTAMP NOT NULL DEFAULT now(),
  `VIEWCNT` INT NULL DEFAULT 0,
  PRIMARY KEY (`bno`));