package kh.pingpong.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kh.pingpong.dto.GroupDTO;
import kh.pingpong.dto.LessonDTO;
import kh.pingpong.dto.VisitorDTO;
import kh.pingpong.service.ClassService;
import kh.pingpong.service.VisitorService;


@Controller
public class HomeController {
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private VisitorService vservice;
	
	@Autowired
	private ClassService cService;
	
	@RequestMapping("/")
	public String home() {
		Date today = new Date();
		SimpleDateFormat dayString = new SimpleDateFormat("yyyy/MM/dd");
		String visit_date = dayString.format(today);
		
		VisitorDTO vdto = new VisitorDTO();
		
		vdto.setVisit_date(visit_date);
		
		if (!vservice.selectToday(visit_date)) {
			vservice.insertVisitor(vdto);
		}
		
		vservice.updateVisitCount(visit_date);
		
		return "index";
	}

	@ResponseBody
	@RequestMapping(value="/classDateSch", produces="application/json;charset=utf8")
	public String classDateSch(String day) throws Exception {
		List<GroupDTO> gList = cService.groupClassList(day);
		List<LessonDTO> LessonList = cService.lessonListClassList(day);
		Map<String, Object> listMap = new HashMap<>();
		listMap.put("gList", gList);
		listMap.put("LessonList", LessonList);
		Gson gson = new Gson();
		return gson.toJson(listMap); 
	}
}
