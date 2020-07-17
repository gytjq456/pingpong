package kh.team.controller;

import java.io.File;
import java.io.FileInputStream;
import java.util.HashMap;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMultipartHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultHandlers;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import kh.pingpong.dto.MemberDTO;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration //웹을 흉내내는 환경설정을 해주는 애
@ContextConfiguration(locations= {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",		
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"	
})		
public class report {
	//import org.slf4j.Logger;
	//TestClient메서드  이름 맞춰준거 
	private static final Logger logger = LoggerFactory.getLogger(tutorApp.class);
	
	
	@Autowired
	private WebApplicationContext wac;		// 웬 환경 구성 역할의 인스턴스 / 톰캣이 실행된듯한 환경을 주는 것
	private MockMvc mockMvc;				// 테스트기능을 가지고 있는애 
	
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(this.wac).build();
	}

	  @Test
	  public void testMessageInsert() {
	     try {
	        MemberDTO mdto = new MemberDTO();
	        mdto.setId("coskdms");
	        mdto.setName("채나은");
	        HashMap<String, Object> sessionattr = new HashMap<String, Object>();
	        sessionattr.put("loginInfo", mdto);   
	  
	        mockMvc.perform((MockMvcRequestBuilders.multipart("/tutor/report").
	              sessionAttrs(sessionattr).
	              param("id","coskdms").
	              param("reason","젠장")).
	              param("reporter","sdfsdf@sdfsd").
	              param("category","wdwd")
	              ).andDo(MockMvcResultHandlers.print()).andExpect(MockMvcResultMatchers.status().isOk());
	        logger.info("신고 성공");
	     } catch (Exception e) {
	        // TODO: handle exception
	        logger.info(e.getMessage());
	     }
	  }

	
}
