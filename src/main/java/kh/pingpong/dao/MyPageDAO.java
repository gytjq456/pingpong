package kh.pingpong.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.pingpong.config.Configuration;
import kh.pingpong.dto.GroupApplyDTO;
import kh.pingpong.dto.GroupDTO;
import kh.pingpong.dto.LessonDTO;
import kh.pingpong.dto.LikeListDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.PartnerDTO;

@Repository
public class MyPageDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis; 
	
	//그룹 관련
	public List<GroupDTO> selectGroupList(){
		return mybatis.selectList("Mypage.groupList");
	}
	public List<GroupDTO> selectByIdInGroup(Map<String, Object> param){
		return mybatis.selectList("Mypage.selectByIdInGroup", param);
	}
	public List<GroupApplyDTO> selectByIdInGroupMem(Map<String, Object> param){
		return mybatis.selectList("Mypage.selectByIdInGroup_app", param);
	}
	
	// 그룹 페이징
	public int selectCount(Map<String, Object> param) throws Exception {
		String tableName = param.get("tableName").toString();
		
		if (tableName.contentEquals("tutor")) {
			param.replace("tableName", "lesson");
		}
		
		return mybatis.selectOne("Mypage.selectCount", param);
	}
	
	//나의 강의목록
	public List<LessonDTO> selectLessonList(Map<String, Object> param){
		return mybatis.selectList("Mypage.lessonList", param);
	}
	

	public List<LessonDTO> selectTuteeList(Map<String, Object> param){
		return mybatis.selectList("Mypage.tuteeList", param);
	}
	
	
	public List<PartnerDTO> selectPartnerList(){
		return mybatis.selectList("Mypage.partnerList");
	}
	
	
	public List<LikeListDTO> selectLikeList(){
		return mybatis.selectList("Mypage.likeList");
	}
	
	//찜목록
	public List<PartnerDTO> selectPartnerJjim(Map<String, Object> param){
		return mybatis.selectList("Mypage.partnerJjim", param);
	}
	
	public List<GroupDTO> selectGroupJjim(Map<String, Object> param){
		return mybatis.selectList("Mypage.groupJjim", param);
	}
	
	public List<LessonDTO> selectLessonJjim(Map<String, Object> param){
		return mybatis.selectList("Mypage.lessonJjim", param);
	}
	
	// 찜 페이징
	public int jjimCount(Map<String, Object> param) {
		String tableName = param.get("tableName").toString();
		
		if (tableName.contentEquals("group")) {
			param.replace("tableName", "grouplist");
		}
		
		return mybatis.selectOne("Mypage.jjimCount", param);
	}
}
