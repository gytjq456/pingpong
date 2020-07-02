package kh.pingpong.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.pingpong.dto.GroupDTO;
import kh.pingpong.dto.LikeListDTO;
import kh.pingpong.dto.PartnerDTO;
import kh.pingpong.dto.TuteeDTO;
import kh.pingpong.dto.TutorDTO;

@Repository
public class MyPageDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis; 
	
	public List<GroupDTO> selectGroupList(){
		return mybatis.selectList("Mypage.groupList");
	}
	
	public List<TutorDTO> selectTutorList(){
		return mybatis.selectList("Mypage.tutorList");
	}
	
	public List<TuteeDTO> selectTuteeList(){
		return mybatis.selectList("Mypage.tuteeList");
	}
	
	public List<PartnerDTO> selectPartnerList(){
		return mybatis.selectList("Mypage.partnerList");
	}
	
	public List<LikeListDTO> selectLikeList(){
		return mybatis.selectList("Mypage.likeList");
	}
}
