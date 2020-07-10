package kh.pingpong.dao;

import java.util.List;
import java.util.Map;

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
		return mybatis.selectList("MainDB.groupClassList",day);
	}
	
	public List<LessonDTO> lessonClassList(String day) throws Exception{
		return mybatis.selectList("MainDB.lessonClassList",day);
	}
	
	
	// 메인페이지 지도에 표시될 그룹 리스트
	public List<Map<String,String>> groupList(String addr) throws Exception{
		return mybatis.selectList("MainDB.groupList",addr);
	}
	
	// 메인페이지 지도에 표시될 레슨 리스트
//	public List<LessonDTO> lessonList(String addr) throws Exception{
//		return mybatis.selectList("MainDB.lessonList",addr);
//	}

}
