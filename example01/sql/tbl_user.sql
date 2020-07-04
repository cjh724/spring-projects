CREATE TABLE `book_ex`.`tbl_user` (
	`uid` VARCHAR(50) NOT NULL,
    `upw` VARCHAR(50) NOT NULL,
    `uname` VARCHAR(100) NOT NULL,
    `upoint` INT NOT NULL DEFAULT 0,
    PRIMARY KEY (`uid`)
);

alter table tbl_user
add column sessionkey varchar(50) not null default 'none';

alter table tbl_user
add column sessionlimit timestamp;