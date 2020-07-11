package kh.pingpong.scheduler;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import kh.pingpong.admin.AdminService;
import kh.pingpong.service.GroupService;
import kh.pingpong.service.TutorService;

@Component
public class GroupScheduler {
	@Autowired
	private GroupService gservice;
	
	@Autowired
	private TutorService tservice;
	
	@Autowired
	private AdminService aservice;
	
	@Scheduled(cron="0 0 0 * * * ")
	public void scheduleTest() throws Exception {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.DATE, 1);
		String today_plus = format.format(cal.getTime());
		String today_date = format.format(date);
		
		System.out.println(today_plus);
		System.out.println(today_date);
		
		Map<String, String> param = new HashMap<>();
		param.put("today_date", today_date);
		param.put("today_plus", today_plus);
		
		gservice.updateIngDate(today_date);
		tservice.updateIngDate(param);
		aservice.doneBlacklist(today_date);
	}
}
 