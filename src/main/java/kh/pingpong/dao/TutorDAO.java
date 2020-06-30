package kh.pingpong.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.pingpong.config.Configuration;
import kh.pingpong.dto.DeleteApplyDTO;
import kh.pingpong.dto.LessonDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.TutorAppDTO;

@Repository
public class TutorDAO {

	@Autowired
	private SqlSessionTemplate mybatis;
	
	
	public LessonDTO lessonView(int seq) throws Exception{
		return mybatis.selectOne("Tutor.lessonView", seq);
	}
	
	public int lessonCancleProc(DeleteApplyDTO dadto) throws Exception{
		return mybatis.insert("Tutor.lessonCancleProc", dadto);
	}
	
	
	//�뒠�꽣 �떊泥��꽌 insert
	public int insert(TutorAppDTO tadto) throws Exception{
		return mybatis.insert("Tutor.insert",tadto);
	}
	
	public int lessonAppProc(LessonDTO ldto) throws Exception{
		return mybatis.insert("Tutor.lessonAppProc", ldto);
	}
	
	public List<MemberDTO> tutorList(int cpage) throws Exception{
		int start = cpage*Configuration.RECORD_COUNT_PER_PAGE - (Configuration.RECORD_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.RECORD_COUNT_PER_PAGE - 1);
		
		Map<String, String> param = new HashMap<>();
		param.put("cpage", String.valueOf(cpage));
		param.put("start", String.valueOf(start));
		param.put("end", String.valueOf(end));
		
		return mybatis.selectList("Tutor.selectTutorList", param);
	}
	public int getArticleCount_tutor() throws SQLException, Exception {
		return mybatis.selectOne("Tutor.getArticleCount_tutor");
	}
	
	//--------------------------
	
	public List<LessonDTO> lessonList(int cpage) throws Exception{
		int start = cpage*Configuration.RECORD_COUNT_PER_PAGE - (Configuration.RECORD_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.RECORD_COUNT_PER_PAGE - 1);
		
		Map<String, String> param = new HashMap<>();
		param.put("cpage", String.valueOf(cpage));
		param.put("start", String.valueOf(start));
		param.put("end", String.valueOf(end));
		
		return mybatis.selectList("Tutor.selectLessonList", param);
	}
	
	public int getArticleCount_lesson() throws SQLException, Exception {
		return mybatis.selectOne("Tutor.getArticleCount_lesson");
	}
	

}
