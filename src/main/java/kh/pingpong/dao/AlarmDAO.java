package kh.pingpong.dao;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.pingpong.dto.MemberDTO;

@Repository
public class AlarmDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	@Autowired
	private HttpSession session;
	
	public int getAlarmCount(MemberDTO loginInfo) throws Exception{
		return mybatis.selectOne("Alarm.getAlarmCount",loginInfo);
	}
	
//	public int alarmInsert(Map<String, Object> insertA) throws Exception{
//		return mybatis.insert("Alarm.insertAlarm",insertA);
//	}
}
