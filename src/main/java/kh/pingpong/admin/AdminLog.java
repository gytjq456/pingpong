package kh.pingpong.admin;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.springframework.beans.factory.annotation.Autowired;

public class AdminLog {
	@Autowired
	private HttpSession session;
	
	public Object aroundAdminLog(ProceedingJoinPoint pjp) throws Throwable {
		if (session.getAttribute("adminLog") == null) {
			return "redirect:/admin";
		}
		
		Object returnValue = pjp.proceed();
		
		return returnValue;
	}
}
