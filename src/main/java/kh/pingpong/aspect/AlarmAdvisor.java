package kh.pingpong.aspect;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import kh.pingpong.dto.MemberDTO;
import kh.pingpong.service.AlarmService;
import kh.pingpong.service.GroupService;
import kh.pingpong.service.PartnerService;
import kh.pingpong.service.TutorService;

@Aspect
public class AlarmAdvisor {
	@Autowired
	private HttpSession session;

	
	@Autowired
	private AlarmService alservice;
	
	public Object alarmLog(ProceedingJoinPoint pjp) throws Throwable{
		
		System.out.println("-------------- ");
		Object returnValue = pjp.proceed();
		MemberDTO mdto = (MemberDTO) session.getAttribute("loginInfo");
		System.out.println("-------------- 종료  ");
		System.out.println(mdto.getId());
		//int result = alservice.insertAlarm(pjp.getArgs());
			
		return returnValue;
	
	}
	
}
