package kh.pingpong.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.pingpong.dto.NotificationDTO;
import kh.pingpong.notification.EchoHandler;
import kh.pingpong.service.NotificationService;

@Controller
@RequestMapping("/notification")
public class NotificationController {
	
	@Autowired
	NotificationService nservice;
	
	@Autowired
	private HttpSession session;
	
	@Autowired 
	EchoHandler handler;
	
	public String alarmList(NotificationDTO ndto) throws Exception{
		
		return null;	
	}
}
