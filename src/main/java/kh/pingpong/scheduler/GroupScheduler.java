package kh.pingpong.scheduler;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import kh.pingpong.service.GroupService;
import kh.pingpong.service.TutorService;

@Component
public class GroupScheduler {
	@Autowired
	private GroupService gservice;
	
	@Autowired
	private TutorService tservice;
	
	@Scheduled(cron="0 0 0 * * * ")
	public void scheduleTest() throws Exception {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String today_date = format.format(date);
		gservice.updateIngDate(today_date);
		tservice.updateIngDate(today_date);
	}
}
 