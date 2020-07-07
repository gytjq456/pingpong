package kh.pingpong.scheduler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import kh.pingpong.dao.MemberDAO;

@Component
public class memberScheduler {
	
	@Autowired
	private MemberDAO mdao;
	
	@Scheduled(cron="0 0 1 1 * *")
	public void scheduleAgeUp() throws Exception{
		//1년에 한번 씩 나이 올라감
		mdao.scheduleAgeUp();
	}

}
