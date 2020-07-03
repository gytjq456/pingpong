package kh.pingpong.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.pingpong.dto.GroupApplyDTO;
import kh.pingpong.dto.GroupDTO;
import kh.pingpong.dto.GroupMemberDTO;
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
	
	//그룹 관련
//	@RequestMapping("groupRecord")
//	public String groupRecord(Model model) throws Exception{
//		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
//		List<GroupDTO> glist = mpservice.selectGroupList();
//		model.addAttribute("glist", glist);
//		return "/mypage/groupRecord";
//	}
	
	@RequestMapping("groupRecord")
	public String selectByIdInGroup(Model model, GroupMemberDTO gmdto, GroupDTO gdto) throws Exception{
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		System.out.println("현재 로그인한 회원 아이디 : " + loginInfo.getId());
		List<GroupDTO> gl_list = mpservice.selectByIdInGroup(loginInfo);
		List<GroupApplyDTO> gm_list = mpservice.selectByIdInGroupMem(loginInfo);
		
		if(gdto.getSeq() == gmdto.getParent_seq()) {
		}
		
		model.addAttribute("gl_list", gl_list); // 그룹 리더의 경우
		model.addAttribute("gm_list", gm_list); // 그룹 멤버의 경우
		return "/mypage/groupRecord";
	}
	
	//파트너 관련
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
	
	
	@RequestMapping("likeRecord")
	public String likeRecord(Model model) throws Exception{
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		List<LikeListDTO> llist = mpservice.selectLikeList();
		model.addAttribute("llist", llist);
		return "/mypage/likeRecord";
	}
}
