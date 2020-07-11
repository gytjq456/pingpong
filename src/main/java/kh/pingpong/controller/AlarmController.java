package kh.pingpong.controller;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.pingpong.dto.MemberDTO;
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
		model.addAttribute("alarmCount", alarmCount);
		return "alarm";	
	}
	
	public int alarmInsert(Model model,MemberDTO mdto) throws Exception{
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		System.out.println("id :" +mdto.getId());
		int result = alservice.insertAlarm(mdto);
		return result;
	}
	
	public String alarmCount(Model model) throws Exception{
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		int alarmCount = alservice.getAlarmCount(loginInfo);
		model.addAttribute("alarmCount", alarmCount);
		return "header";	
	}
}
