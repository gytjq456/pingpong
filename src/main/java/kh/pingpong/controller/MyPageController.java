package kh.pingpong.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.pingpong.dto.GroupDTO;
import kh.pingpong.dto.LikeListDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.PartnerDTO;
import kh.pingpong.dto.TuteeDTO;
import kh.pingpong.dto.TutorDTO;
import kh.pingpong.service.MyPageService;

@Controller
@RequestMapping("/mypage/")
public class MyPageController {
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private FileController fcon;
	
//	@Autowired
//	private MemberService mservice;
//	
//	@Autowired
//	private PartnerService pservice;
//	
//	@Autowired
//	private GroupService gservice;
//	
//	@Autowired
//	private TutorService tservice;
	
	@Autowired
	private MyPageService mpservice;
	
	@RequestMapping("partnerRecord")
	public String partnerRecord(Model model) throws Exception{
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		List<PartnerDTO> plist = mpservice.selectPartnerList();
		model.addAttribute("plist", plist);
		return "/mypage/partnerRecord";
	}
	@RequestMapping("tutorRecord")
	public String tutorRecord(Model model) throws Exception{
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		List<TutorDTO> trlist = mpservice.selectTutorList();
		List<TuteeDTO> telist = mpservice.selectTuteeList(); 
		model.addAttribute("trlist", trlist);
		model.addAttribute("telist", telist);
		return "/mypage/tutorRecord"; 
	}
	
	@RequestMapping("groupRecord")
	public String groupRecord(Model model) throws Exception{
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		List<GroupDTO> glist = mpservice.selectGroupList();
		model.addAttribute("glist", glist);
		return "/mypage/groupRecord";
	}
	@RequestMapping("likeRecord")
	public String likeRecord(Model model) throws Exception{
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		List<LikeListDTO> llist = mpservice.selectLikeList();
		model.addAttribute("llist", llist);
		return "/mypage/likeRecord";
	}
}
