package kh.pingpong.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
	public List<GroupDTO> selectByIdInGroup(MemberDTO loginInfo){
		return mybatis.selectList("Mypage.selectByIdInGroup",loginInfo);
	}
	public List<GroupApplyDTO> selectByIdInGroupMem(MemberDTO loginInfo){
		return mybatis.selectList("Mypage.selectByIdInGroup_app",loginInfo);
	}
	
	//나의 강의목록
//	public List<LessonDTO> selectTutorList(MemberDTO loginInfo){
//		return mybatis.selectList("Mypage.tutorList",loginInfo);
//	}
	

	public List<LessonDTO> selectTuteeList(MemberDTO loginInfo){
		return mybatis.selectList("Mypage.tuteeList",loginInfo);
	}
	
	
	public List<PartnerDTO> selectPartnerList(){
		return mybatis.selectList("Mypage.partnerList");
	}
	
	
	public List<LikeListDTO> selectLikeList(){
		return mybatis.selectList("Mypage.likeList");
	}
	
	//찜목록
	public List<PartnerDTO> selectPartnerJjim(MemberDTO loginInfo){
		return mybatis.selectList("Mypage.partnerJjim",loginInfo);
	}
	
	public List<GroupDTO> selectGroupJjim(MemberDTO loginInfo){
		return mybatis.selectList("Mypage.groupJjim",loginInfo);
	}
	
	public List<LessonDTO> selectTutorJjim(MemberDTO loginInfo){
		return mybatis.selectList("Mypage.tutorJjim",loginInfo);
	}
}
