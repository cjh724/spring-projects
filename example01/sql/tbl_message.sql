CREATE TABLE `book_ex`.`tbl_message` (
	`mid` INT NOT NULL AUTO_INCREMENT,
    `targetid` VARCHAR(50) NOT NULL,
    `sender` VARCHAR(50) NOT NULL,
    `message` TEXT NOT NULL,
    `opendate` TIMESTAMP NULL,
    `senddate` TIMESTAMP NOT NULL DEFAULT now(),
    PRIMARY KEY (`mid`)
);
  
alter table tbl_message add constraint fk_usertarget foreign key (targetid) references tbl_user(uid);
alter table tbl_message add constraint fk_usersender foreign key (targetid) references tbl_user(uid);