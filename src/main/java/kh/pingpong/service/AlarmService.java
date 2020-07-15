package kh.pingpong.service;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.pingpong.dao.AlarmDAO;
import kh.pingpong.dto.MemberDTO;

@Service
public class AlarmService {
	
	@Autowired
	AlarmDAO aldao;
	@Autowired
	private HttpSession session;
	
	
	public int getAlarmCount(MemberDTO loginInfo)throws Exception{
		return aldao.getAlarmCount(loginInfo);
	}
	
//	public int insertAlarm(Map<String, Object> insertA) throws Exception{	
//		return aldao.alarmInsert(insertA);
//	}
}
