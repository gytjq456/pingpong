package kh.pingpong.aspect;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;

import kh.pingpong.dto.ReviewDTO;
import kh.pingpong.service.GroupService;
import kh.pingpong.service.PartnerService;
import kh.pingpong.service.TutorService;

@Aspect
public class AlarmAdvisor {
	@Autowired
	private HttpSession session;
	@Autowired
	private PartnerService pservice;
	private GroupService gservice;
	private TutorService tservice;
	
	@After(value="execution(* kh.pingpong.controller.*(..))")
	public void afterAlarmLog(JoinPoint jp,ReviewDTO redto) throws Throwable{
		int result = pservice.reviewWrite(redto);
		result = gservice.reviewWrite(redto);
		
	
	}
	
}
