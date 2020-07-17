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
public class delete {
	private static final Logger logger = LoggerFactory.getLogger(tutorApp.class);
	
	
	@Autowired
	private WebApplicationContext wac;		
	private MockMvc mockMvc;				
	
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
	  
	        mockMvc.perform((MockMvcRequestBuilders.post("/tutor/cancleProc").
	              sessionAttrs(sessionattr).
	              param("id","coskdms").
	              param("category","젠장")).
	              param("contents","sdfsdf@sdfsd")
	              ).andDo(MockMvcResultHandlers.print()).andExpect(MockMvcResultMatchers.status().is3xxRedirection());
	        logger.info("삭제 성공");
	     } catch (Exception e) {
	        // TODO: handle exception
	        logger.info(e.getMessage());
	     }
	  }

	
}
