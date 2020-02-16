package org.zerock.web;

import javax.inject.*;

import org.junit.*;
import org.junit.runner.*;
import org.springframework.test.context.*;
import org.springframework.test.context.junit4.*;
import org.zerock.domain.*;
import org.zerock.persistence.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/root-context.xml" })
public class MemberDAOTest {
	@Inject
	private MemberDAO dao;

	@Test
	public void testTime() throws Exception {
		System.out.println(dao.getTime());
	}

	@Test
	public void testInsertMember() throws Exception {
		MemberVO vo = new MemberVO();
		vo.setUserid("user00");
		vo.setUserpw("user00");
		vo.setUsername("USER00");
		vo.setEmail("user00@aaa.com");
		
		dao.insertMember(vo);
	}
}
