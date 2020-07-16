package kh.pingpong.controller;

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
         mockMvc.perform(MockMvcRequestBuilders.post("/group/writeProc").
               param("title", "제목").param("writer_id", "sample01").
               param("writer_name", "샘플").param("hobby_type", "기타").
               param("apply_start", "2020-07-16").param("apply_end", "2021-07-15").
               param("start_date", "2020-07-16").param("end_date", "2021-07-15").
               param("max_num", "10").param("location", "서울특별시 중구").
               param("location_lat", "37.56386629845981").
               param("location_lng", "126.99617431003922").
               param("contents", "내용")).andDo(MockMvcResultHandlers.print()).
         andExpect(MockMvcResultMatchers.status().isOk());
         logger.info("테스트 성공!");
      } catch (Exception e) {
         logger.error("테스트 실패: " + e.getMessage());
      }
   }
}