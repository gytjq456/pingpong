package kh.pingpong.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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
	public String home(String day) {
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
	
	
	@RequestMapping("/")
	public String classSchedule() throws Exception {
		
		return "";
	}
	
	
	

	
	
}
