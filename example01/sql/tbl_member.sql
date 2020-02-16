CREATE TABLE `book_ex`.`tbl_member` (
  `userid` VARCHAR(50) NOT NULL,
  `userpw` VARCHAR(50) NOT NULL,
  `username` VARCHAR(50) NOT NULL,
  `email` VARCHAR(100) NULL,
  `regdate` TIMESTAMP NULL DEFAULT now(),
  `updatedate` TIMESTAMP NULL DEFAULT now(),
  PRIMARY KEY (`userid`));