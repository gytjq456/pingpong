package kh.pingpong.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AlarmDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public int getAlarmCount(String alarm_receiver) throws Exception{
		return mybatis.selectOne("Alarm.getAlarmCount",alarm_receiver);
	}
}
