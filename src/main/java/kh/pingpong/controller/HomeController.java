package kh.pingpong.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.VisitorDTO;
import kh.pingpong.service.VisitorService;


@Controller
public class HomeController {
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private VisitorService vservice;
	
	
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
	
	
}
