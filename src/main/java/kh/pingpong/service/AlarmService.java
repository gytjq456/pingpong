package kh.pingpong.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.pingpong.dao.AlarmDAO;

@Service
public class AlarmService {
	
	@Autowired
	AlarmDAO aldao;
	
	public int getAlarmCount(String alarm_receiver)throws Exception{
		return aldao.getAlarmCount(alarm_receiver);
	}
}
