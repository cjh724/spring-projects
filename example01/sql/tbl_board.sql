CREATE TABLE `book_ex`.`tbl_board` (
  `bno` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(200) NOT NULL,
  `content` TEXT NULL,
  `writer` VARCHAR(50) NOT NULL,
  `regdate` TIMESTAMP NOT NULL DEFAULT now(),
  `VIEWCNT` INT NULL DEFAULT 0,
  PRIMARY KEY (`bno`)
);

-- row 전체 수
select count(*)
from tbl_board;

-- 3페이지에 해당하는 데이터 : BoardDAOTest의 testListPage 메소드와 동일 결과
select *
from tbl_board
where bno > 0
order by bno desc
limit 20, 10;

-- 자가복사(self copy)
insert into tbl_board(title, content, writer)
(select title, content, writer from tbl_board);

-- 3페이지에 해당하는 데이터 20개 : BoardDAOTest의 testListCriteria 메소드와 동일 결과
select *
from tbl_board
where bno > 0
order by bno desc
limit 20, 20;
