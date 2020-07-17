package kh.pingpong.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import kh.pingpong.dto.TuteeDTO;
import kh.pingpong.service.GroupService;
import kh.pingpong.service.MyPageService;
import kh.pingpong.service.TutorService;

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
	
	@Autowired
	private TutorService tservice;
	
	//그룹 관련
	@RequestMapping("groupRecord")
	public String selectByIdInGroup(Model model, HttpServletRequest request) throws Exception{
		int lcpage = 1;
        try {
        	lcpage = Integer.parseInt(request.getParameter("lcpage"));
        } catch (Exception e) {}
        
        int mcpage = 1;
        try {
        	mcpage = Integer.parseInt(request.getParameter("mcpage"));
        } catch (Exception e) {}
        
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		String id = loginInfo.getId();
		
		Map<String, Object> lparam = new HashMap<>();
		Map<String, Object> mparam = new HashMap<>();
		
		lparam.put("columnName", "writer_id");
		lparam.put("columnValue", id);
		lparam.put("lcpage", lcpage);
		lparam.put("mcpage", mcpage);
		lparam.put("tableName", "grouplist");
		
		mparam.put("columnName", "id");
		mparam.put("columnValue", id);
		mparam.put("mcpage", mcpage);
		mparam.put("lcpage", lcpage);
		mparam.put("tableName", "groupmember");
		
		List<GroupDTO> gl_list = mpservice.selectByIdInGroup(lparam);
		
		List<Integer> seq = new ArrayList<>();
		
		for (int i = 0; i < gl_list.size(); i++) {
			seq.add(gl_list.get(i).getSeq());
		}
		
		List<GroupApplyDTO> gm_list = mpservice.selectByIdInGroupMem(mparam);
		List<GroupApplyDTO> gla_list = gservice.allAppList(seq);
		
		String lnavi = mpservice.getPageNav(lparam);
		String mnavi = mpservice.getPageNav(mparam);
		
		model.addAttribute("gl_list", gl_list); // 그룹 리더의 경우
		model.addAttribute("gm_list", gm_list); // 그룹 멤버의 경우
		model.addAttribute("gla_list", gla_list); // 그룹 리더인 경우
		model.addAttribute("lnavi", lnavi); // 그룹 리더인 경우
		model.addAttribute("mnavi", mnavi); // 그룹 멤버의 경우

		return "/mypage/groupRecord";
	}
	
	@RequestMapping("tutorRecord")
	public String tutorRecord(Model model, HttpServletRequest request) throws Exception{
		int cpage = 1;
        try {
        	cpage = Integer.parseInt(request.getParameter("cpage"));
        } catch (Exception e) {}
        
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		String id = loginInfo.getId();
		
		Map<String, Object> trparam = new HashMap<>();
		Map<String, Object> teparam = new HashMap<>();
		
		trparam.put("tableName", "tutor");
		trparam.put("cpage", cpage);
		trparam.put("columnName", "id");
		trparam.put("columnValue", id);
		
		teparam.put("tableName", "tutee");
		teparam.put("cpage", cpage);
		teparam.put("columnName", "id");
		teparam.put("columnValue", id);

		List<LessonDTO> trlist = mpservice.selectLessonList(trparam);
		List<LessonDTO> telist = mpservice.selectTuteeList(teparam); 

		String trnavi = mpservice.getPageNav(trparam);
		String tenavi = mpservice.getPageNav(teparam);
		
		model.addAttribute("trlist", trlist);
		model.addAttribute("telist", telist);
		model.addAttribute("trnavi", trnavi);
		model.addAttribute("tenavi", tenavi);

		return "/mypage/tutorRecord"; 
	}
	
	@RequestMapping("likeRecord")
	public String likeRecord(Model model, HttpServletRequest request) throws Exception{
		int pcpage = 1;
        try {
        	pcpage = Integer.parseInt(request.getParameter("pcpage"));
        } catch (Exception e) {}
        
        int gcpage = 1;
        try {
        	gcpage = Integer.parseInt(request.getParameter("gcpage"));
        } catch (Exception e) {}
        
        int lcpage = 1;
        try {
        	lcpage = Integer.parseInt(request.getParameter("lcpage"));
        } catch (Exception e) {}
        
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		String id = loginInfo.getId();
		
		Map<String, Object> pparam = new HashMap<>();
		Map<String, Object> gparam = new HashMap<>();
		Map<String, Object> lparam = new HashMap<>();
		
		pparam.put("id", id);
		pparam.put("pcpage", pcpage);
		pparam.put("gcpage", gcpage);
		pparam.put("lcpage", lcpage);
		pparam.put("tableName", "partner");
		
		gparam.put("id", id);
		gparam.put("pcpage", pcpage);
		gparam.put("gcpage", gcpage);
		gparam.put("lcpage", lcpage);
		gparam.put("tableName", "group");
		
		lparam.put("id", id);
		lparam.put("pcpage", pcpage);
		lparam.put("gcpage", gcpage);
		lparam.put("lcpage", lcpage);
		lparam.put("tableName", "lesson");
		
		List<PartnerDTO> plist = mpservice.selectPartnerJjim(pparam);
		List<GroupDTO> glist = mpservice.selectGroupJjim(gparam);
		List<LessonDTO> llist = mpservice.selectLessonJjim(lparam);
		
		String pnavi = mpservice.getPageNav(pparam);
		String gnavi = mpservice.getPageNav(gparam);
		String lnavi = mpservice.getPageNav(lparam);

		model.addAttribute("plist", plist);
		model.addAttribute("glist", glist);
		model.addAttribute("llist", llist);
		model.addAttribute("pnavi", pnavi);
		model.addAttribute("gnavi", gnavi);
		model.addAttribute("lnavi", lnavi);
		
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
