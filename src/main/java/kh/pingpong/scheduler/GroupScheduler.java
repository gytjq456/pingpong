package kh.pingpong.scheduler;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import kh.pingpong.service.GroupService;

@Component
public class GroupScheduler {
	@Autowired
	private GroupService gservice;
	
	@Scheduled(cron="0 0 0 * * * ")
	public void scheduleTest() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String today_date = format.format(date);
		gservice.updateIngDate(today_date);
	}
}
