package org.zerock.test;

import java.util.*;

import javax.inject.*;

import org.junit.*;
import org.junit.runner.*;
import org.slf4j.*;
import org.springframework.test.context.*;
import org.springframework.test.context.junit4.*;
import org.springframework.web.util.*;
import org.zerock.domain.*;
import org.zerock.persistence.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class BoardDAOTest {
	private static final Logger logger = LoggerFactory.getLogger(BoardDAOTest.class);
	
	@Inject
	private BoardDAO dao;
	
	@Test
	public void testCreate() throws Exception {
		BoardVO board = new BoardVO();
		board.setTitle("새로운 제목을 넣습니다.");
		board.setContent("새로운 내용을 넣습니다.");
		board.setWriter("user00");
		dao.create(board);
	}
	
	@Test
	public void testRead() throws Exception {
		// logger.info(dao.read(1).toString());
		dao.listAll();
	}
	
	@Test
	public void testDelete() throws Exception {
		dao.delete(1);
	}
	
	@Test
	public void testListPage() throws Exception {
		int page = 3;
		
		List<BoardVO> list = dao.listPage(page);
		
		for(BoardVO boardVO : list) {
			logger.info(boardVO.getBno() + " : " + boardVO.getTitle());
		}
	}
	
	@Test
	public void testListCriteria() throws Exception {
		Criteria cri = new Criteria();
		cri.setPage(2);
		cri.setPerPageNum(20);
		
		List<BoardVO> list = dao.listCriteria(cri);
		
		for(BoardVO boardVO : list) {
			logger.info(boardVO.getBno() + " : " + boardVO.getTitle());
		}
	}
	
	@Test
	public void testURI() throws Exception {
		UriComponents uriComponents = UriComponentsBuilder.newInstance()
										.path("/board/read")
										.queryParam("bno", 12)
										.queryParam("perPageNum", 20)
										.build();
		
		logger.info("/board/read?bno=12&perPageNum=20");
		logger.info(uriComponents.toString());
	}
	
	@Test
	public void testURI2() throws Exception {
		UriComponents uriComponents = UriComponentsBuilder.newInstance()
										.path("/{module}/{page}")
										.queryParam("bno", 12)
										.queryParam("perPageNum", 20)
										.build()
										.expand("board", "read")
										.encode();
		
		logger.info("/board/read?bno=12&perPageNum=20");
		logger.info(uriComponents.toString());
	}
}
