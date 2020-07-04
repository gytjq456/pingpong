package kh.pingpong.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.pingpong.dao.MyPageDAO;
import kh.pingpong.dto.GroupApplyDTO;
import kh.pingpong.dto.GroupDTO;
import kh.pingpong.dto.LikeListDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.PartnerDTO;
import kh.pingpong.dto.TuteeDTO;
import kh.pingpong.dto.TutorDTO;

@Service
public class MyPageService {
//	@Autowired
//	private MemberDAO mdao;
//	
//	@Autowired
//	private PartnerDAO pdao;
//	
//	@Autowired
//	private TutorDAO tdao;
//	
//	@Autowired
//	private GroupDAO gdao;
	
	@Autowired
	private MyPageDAO mpdao;
	
	//그룹 관련
	public List<GroupDTO> selectGroupList(){
		return mpdao.selectGroupList();
	}
	
	public List<GroupDTO> selectByIdInGroup(MemberDTO loginInfo){
		return mpdao.selectByIdInGroup(loginInfo);
	}
	
	public List<GroupApplyDTO> selectByIdInGroupMem(MemberDTO loginInfo){
		return mpdao.selectByIdInGroupMem(loginInfo);
	}
	
	//튜터 / 튜티 관련
	public List<TutorDTO> selectTutorList(MemberDTO loginInfo){
		return mpdao.selectTutorList(loginInfo);
	}
	public List<TuteeDTO> selectTuteeList(){
		return mpdao.selectTuteeList();
	}
	//파트너 관련
	public List<PartnerDTO> selectPartnerList(){
		return mpdao.selectPartnerList();
	}
	
	//찜 관련
	public List<LikeListDTO> selectLikeList(){
		return mpdao.selectLikeList();
	}
	
}
