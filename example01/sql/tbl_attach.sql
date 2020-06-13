CREATE TABLE `book_ex`.`tbl_attach` (
  `fullName` VARCHAR(150) NOT NULL,
  `bno` INT NULL,
  `regdate` TIMESTAMP NULL DEFAULT now(),
  PRIMARY KEY (`fullName`)
);

alter table tbl_attach add constraint fk_board_attach
foreign key (bno) references tbl_board (bno);