package kh.pingpong.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.pingpong.dto.LessonDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.TutorAppDTO;

@Repository
public class TutorDAO {

	@Autowired
	private SqlSessionTemplate mybatis;
	
	//튜터 신청서 insert
	public int insert(TutorAppDTO tadto) throws Exception{
		return mybatis.insert("Tutor.insert",tadto);
	}
	
	public List<MemberDTO> tutorList() throws Exception{
		return mybatis.selectList("Tutor.selectTutorList");
	}
	
	public List<LessonDTO> lessonList() throws Exception{
		return mybatis.selectList("Tutor.selectLessonList");
	}
}
