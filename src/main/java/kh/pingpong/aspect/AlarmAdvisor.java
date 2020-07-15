package kh.pingpong.aspect;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;

import kh.pingpong.controller.AlarmController;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.service.AlarmService;

@Aspect
public class AlarmAdvisor {
	@Autowired
	private HttpSession session;

	@Autowired
	private AlarmController alc;
	
	
	
	@Autowired
	private AlarmService alservice;
	
	public Object alarmLog(ProceedingJoinPoint pjp) throws Throwable{
		
		System.out.println("-------------- ");
		Object returnValue = pjp.proceed();
		MemberDTO mdto = (MemberDTO) session.getAttribute("loginInfo");
		System.out.println("-------------- 종료  ");
		System.out.println(mdto.getId());
		//int result = alservice.insertAlarm(alc.insertA);
		System.out.println("---"+alc.insertA.get("mdto"));
		System.out.println("---"+alc.insertA.get("pdto"));
		System.out.println(alc.insertA);
		return returnValue;
	
	}
	
}
