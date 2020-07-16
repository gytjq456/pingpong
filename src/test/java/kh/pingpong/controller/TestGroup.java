package kh.pingpong.controller;

import java.util.HashMap;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultHandlers;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import kh.pingpong.dto.MemberDTO;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration // 웹을 흉내내는 환경 설정을 해주는 것
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
public class TestGroup {
	private static final Logger logger = LoggerFactory.getLogger(TestGroup.class);
	
	@Autowired
	private WebApplicationContext wac;
	
	private MockMvc mockMvc;
	
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(this.wac).build();
	}
	
	@Test
	public void testGroupInsert() {
		try {
			MemberDTO mdto = new MemberDTO();
			mdto.setId("sample02");
			Map<String, Object> sessionattr = new HashMap<String, Object>();
			sessionattr.put("loginInfo", mdto);
			
			mockMvc.perform(MockMvcRequestBuilders.post("/group/search").
					sessionAttrs(sessionattr).
					param("orderBy", "seq").param("ing", "all").
					param("keywordType", "title").param("keywordValue", "제목").
					param("hobbyType", "기타").param("period", "short_period")).
			andDo(MockMvcResultHandlers.print()).
			andExpect(MockMvcResultMatchers.status().isOk());
			logger.info("테스트 성공!");
		} catch (Exception e) {
			logger.error("테스트 실패: " + e.getMessage());
		}
	}
}
