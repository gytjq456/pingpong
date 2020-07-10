package kh.pingpong.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.pingpong.dto.GroupDTO;
import kh.pingpong.dto.LessonDTO;

@Repository
public class MainClassDAO {
	
	@Autowired
	private SqlSession mybatis;
	
	
	public List<GroupDTO> groupClassList(String day) throws Exception{
		return mybatis.selectList("MainDB.groupList",day);
	}
	
	public List<LessonDTO> lessonListClassList(String day) throws Exception{
		return mybatis.selectList("MainDB.lessonListClassList",day);
	}

}
