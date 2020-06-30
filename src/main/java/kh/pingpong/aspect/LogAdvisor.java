package kh.pingpong.aspect;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.springframework.beans.factory.annotation.Autowired;

public class LogAdvisor {
	@Autowired
	private HttpSession session;
	
	public Object aroundBoardLog(ProceedingJoinPoint pjp) throws Throwable {
		if (session.getAttribute("loginInfo") == null) {
			return "redirect:/member/login";
		}
		
		Object returnValue = pjp.proceed();
		
		return returnValue;
	}
}
