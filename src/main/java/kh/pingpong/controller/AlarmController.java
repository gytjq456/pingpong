package kh.pingpong.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.PartnerDTO;
import kh.pingpong.dto.ReviewDTO;
import kh.pingpong.service.AlarmService;

@Aspect
@Controller
@RequestMapping("/alarm/")
public class AlarmController {
	
	@Autowired
	AlarmService alservice;
	
	@Autowired
	private HttpSession session;
	

	@RequestMapping("alarm2")
	public String alarmList(Model model) throws Exception{
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		
		int alarmCount = alservice.getAlarmCount(loginInfo);
		System.out.println("alarmCount : " + alarmCount);
		if(alarmCount != 0) {
			model.addAttribute("alarmCount", alarmCount);
		}
		return "alarm";	
	}
	
	@RequestMapping("insertAlarm")
	public int insertAlarm(Model model,MemberDTO mdto,PartnerDTO pdto,ReviewDTO rvdto) throws Exception{
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		System.out.println("id :" +mdto.getId());
		Map<String,Object> insertA = new HashMap<>();
		insertA.put("mdto", mdto);
		insertA.put("pdto", pdto);
		insertA.put("rvdto",rvdto);
		int result = alservice.insertAlarm(insertA);
		return result;
	}
	
	public String alarmCount(Model model) throws Exception{
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		int alarmCount = alservice.getAlarmCount(loginInfo);
		model.addAttribute("alarmCount", alarmCount);
		return "header";	
	}
}
