package kh.pingpong.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.pingpong.dto.GroupApplyDTO;
import kh.pingpong.dto.GroupDTO;
import kh.pingpong.dto.LessonDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.PartnerDTO;
import kh.pingpong.service.GroupService;
import kh.pingpong.service.MyPageService;

@Controller
@RequestMapping("/mypage/")
public class MypageController {
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private FileController fcon;
	
	@Autowired
	private MyPageService mpservice;
	
	@Autowired
	private GroupService gservice;
	
	//그룹 관련
	@RequestMapping("groupRecord")
	public String selectByIdInGroup(Model model) throws Exception{
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		System.out.println("현재 로그인한 회원 아이디 : " + loginInfo.getId());
		
		List<GroupDTO> gl_list = mpservice.selectByIdInGroup(loginInfo);
		
		List<Integer> seq = new ArrayList<>();
		
		for (int i = 0; i < gl_list.size(); i++) {
			seq.add(gl_list.get(i).getSeq());
		}
		
		List<GroupApplyDTO> gm_list = mpservice.selectByIdInGroupMem(loginInfo);
		List<GroupApplyDTO> gla_list = gservice.allAppList(seq);
		
		model.addAttribute("gl_list", gl_list); // 그룹 리더의 경우
		model.addAttribute("gm_list", gm_list); // 그룹 멤버의 경우
		model.addAttribute("gla_list", gla_list); // 그룹 리더인 경우

		return "/mypage/groupRecord";
	}
	
	@RequestMapping("tutorRecord")
	public String tutorRecord(Model model) throws Exception{
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		//List<LessonDTO> trlist = mpservice.selectTutorList(loginInfo);
		List<LessonDTO> telist = mpservice.selectTuteeList(loginInfo); 
		//model.addAttribute("trlist", trlist);
		model.addAttribute("telist", telist);

		return "/mypage/tutorRecord"; 
	}
	
	@RequestMapping("likeRecord")
	public String likeRecord(Model model) throws Exception{
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		List<PartnerDTO> plist = mpservice.selectPartnerJjim(loginInfo);
		List<GroupDTO> glist = mpservice.selectGroupJjim(loginInfo);
		List<LessonDTO> tlist = mpservice.selectTutorJjim(loginInfo);
		model.addAttribute("plist", plist);
		model.addAttribute("glist", glist);
		model.addAttribute("tlist", tlist);
		return "/mypage/likeRecord";
	}
	
	//파트너 관련
//	@RequestMapping("partnerRecord")
//	public String partnerRecord(Model model) throws Exception{
//		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
//		List<PartnerDTO> plist = mpservice.selectPartnerList();
//		model.addAttribute("plist", plist);
//		return "/mypage/partnerRecord";
//	}
	
}
