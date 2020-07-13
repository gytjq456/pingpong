package kh.pingpong.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.pingpong.notification.EchoHandler;
import kh.pingpong.service.AlarmService;

@Controller
@RequestMapping("/alarm")
public class AlarmController {
	
	@Autowired
	AlarmService aservice;
	
	@Autowired
	private HttpSession session;
	
	@Autowired 
	EchoHandler handler;
	
	@RequestMapping("alarmList")
	public String alarmList(Model model,String alarm_receiver) throws Exception{
		int alarmCount = aservice.getAlarmCount(alarm_receiver);
		System.out.println("alarmCount : " + alarmCount);
		model.addAttribute("alarmCount", alarmCount);
		return "/alarm/alarmlist";	
	}
}
