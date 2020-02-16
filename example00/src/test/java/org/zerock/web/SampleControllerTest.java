package org.zerock.web;

import javax.inject.*;

import org.junit.*;
import org.junit.runner.*;
import org.slf4j.*;
import org.springframework.test.context.*;
import org.springframework.test.context.junit4.*;
import org.springframework.test.context.web.*;
import org.springframework.test.web.servlet.*;
import org.springframework.test.web.servlet.request.*;
import org.springframework.test.web.servlet.setup.*;
import org.springframework.web.context.*;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class SampleControllerTest {
	private static final Logger logger = LoggerFactory.getLogger(SampleControllerTest.class);
	
	@Inject
	private WebApplicationContext wac;
	private MockMvc mockMvc;
	
	@Before
	public void setup() {		// Test 메소드 실행 전에 MockMvc 객체 생성
		this.mockMvc = MockMvcBuilders.webAppContextSetup(this.wac).build();
		logger.info("setup..............");
	}
	
	@Test
	public void testDoA() throws Exception {		// HTTP method(get, post) 사용
		mockMvc.perform(MockMvcRequestBuilders.get("/doA"));
	}
}
