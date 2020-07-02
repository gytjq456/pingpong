package kh.pingpong.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.pingpong.dao.MyPageDAO;
import kh.pingpong.dto.GroupDTO;
import kh.pingpong.dto.LikeListDTO;
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
	
	public List<GroupDTO> selectGroupList(){
		return mpdao.selectGroupList();
	}
	public List<TutorDTO> selectTutorList(){
		return mpdao.selectTutorList();
	}
	public List<TuteeDTO> selectTuteeList(){
		return mpdao.selectTuteeList();
	}
	public List<PartnerDTO> selectPartnerList(){
		return mpdao.selectPartnerList();
	}
	public List<LikeListDTO> selectLikeList(){
		return mpdao.selectLikeList();
	}
	
}
