package kh.pingpong.admin;

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

import kh.pingpong.dto.CorrectDTO;
import kh.pingpong.dto.DeleteApplyDTO;
import kh.pingpong.dto.DiscussionDTO;
import kh.pingpong.dto.GroupDTO;
import kh.pingpong.dto.LessonDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.PartnerDTO;
import kh.pingpong.dto.ReportListDTO;
import kh.pingpong.dto.TuteeDTO;
import kh.pingpong.dto.TutorAppDTO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	private AdminService aservice;
	
	@Autowired
	private HttpSession session;
	
	// 관리자 메인 페이지
	@RequestMapping("")
	public String index() {
		return "/admin/index";
	}
	
	// 관리자 로그인
	@RequestMapping("login")
	public String login(String id, String pw) {
		if (id.contentEquals("tikitaka") && pw.contentEquals("tikitaka")) {
			session.setAttribute("adminLog", id);
		}
		return "redirect:/admin";
	}
	
	// 관리자 로그아웃
	@RequestMapping("logout")
	public String logout() {
		session.removeAttribute("adminLog");
		return "redirect:/admin";
	}
	
	// 회원 리스트
	@RequestMapping("/memberList")
	public String member(HttpServletRequest request, Model model) throws Exception {
		int cpage = 1;
        try {
           cpage = Integer.parseInt(request.getParameter("cpage"));
        } catch (Exception e) {}
        
		List<MemberDTO> mlist = aservice.memberList(cpage);
		Map<String, String> param = new HashMap<>();
		
		param.put("tableName", "member");
		param.put("pageName", "memberList");
		
		String navi = aservice.getPageNav(cpage, param);
		
		model.addAttribute("mlist", mlist);
		model.addAttribute("navi", navi);
		
		return "/admin/memberList";
	}
	
	// 회원 뷰
	@RequestMapping("/memberView")
	public String memberView(String id, Model model) {
		MemberDTO mdto = aservice.memberView(id);
		model.addAttribute("mdto", mdto);
		return "/admin/memberView";
	}
	
	// 파트너 리스트
	@RequestMapping("/partnerList")
	public String partner(HttpServletRequest request, Model model) throws Exception {
		int cpage = 1;
        try {
           cpage = Integer.parseInt(request.getParameter("cpage"));
        } catch (Exception e) {}
        
		List<PartnerDTO> plist = aservice.partnerList(cpage);
		Map<String, String> param = new HashMap<>();
		
		param.put("tableName", "partner");
		param.put("pageName", "partnerList");
		
		String navi = aservice.getPageNav(cpage, param);
		
		model.addAttribute("plist", plist);
		model.addAttribute("navi", navi);
		
		return "/admin/partnerList";
	}
	
	// 파트너 뷰
	@RequestMapping("/partnerView")
	public String partnerView(int seq, Model model) {
		PartnerDTO pdto = aservice.partnerView(seq);
		model.addAttribute("pdto", pdto);
		return "/admin/partnerView";
	}
	
	// 그룹 리스트
	@RequestMapping("/groupList")
	public String group(HttpServletRequest request, Model model) throws Exception {
		int cpage = 1;
        try {
           cpage = Integer.parseInt(request.getParameter("cpage"));
        } catch (Exception e) {}
        
		List<GroupDTO> glist = aservice.groupList(cpage);
		Map<String, String> param = new HashMap<>();

		param.put("tableName", "grouplist");
		param.put("pageName", "groupList");
		
		String navi = aservice.getPageNav(cpage, param);
		
		model.addAttribute("glist", glist);
		model.addAttribute("navi", navi);
		
		return "/admin/groupList";
	}
	
	// 그룹 뷰
	@RequestMapping("/groupView")
	public String groupView(int seq, Model model) {
		GroupDTO gdto = aservice.groupView(seq);
		model.addAttribute("gdto", gdto);
		return "/admin/groupView";
	}
	
	// 튜터 리스트
	@RequestMapping("/tutorList")
	public String tutorList(HttpServletRequest request, Model model) throws Exception {
		int cpage = 1;
        try {
           cpage = Integer.parseInt(request.getParameter("cpage"));
        } catch (Exception e) {}
        
		List<MemberDTO> trlist = aservice.tutorList(cpage);
		Map<String, String> param = new HashMap<>();
		
		param.put("tableName", "member");
		param.put("pageName", "tutorList");
		param.put("columnName", "grade");
		param.put("columnValue", "tutor");
		
		String navi = aservice.getPageNav(cpage, param);
		
		model.addAttribute("trlist", trlist);
		model.addAttribute("navi", navi);
		
		return "/admin/tutorList";
	}
	
	// 튜터 뷰
	@RequestMapping("/tutorView")
	public String tutorView(String id, Model model) {
		MemberDTO trdto = aservice.tutorView(id);
		model.addAttribute("trdto", trdto);
		return "/admin/tutorView";
	}
	
	// 튜터 신청 리스트
	@RequestMapping("/tutorAppList")
	public String tutorAppList(HttpServletRequest request, Model model) throws Exception {
		int cpage = 1;
        try {
           cpage = Integer.parseInt(request.getParameter("cpage"));
        } catch (Exception e) {}
        
		List<TutorAppDTO> talist = aservice.tutorAppList(cpage);
		Map<String, String> param = new HashMap<>();
		
		param.put("tableName", "tutor_app");
		param.put("pageName", "tutorAppList");
		
		String navi = aservice.getPageNav(cpage, param);
		
		model.addAttribute("talist", talist);
		model.addAttribute("navi", navi);
		
		return "/admin/tutorAppList";
	}
	
	// 튜터 신청 뷰
	@RequestMapping("/tutorAppView")
	public String tutorAppView(int seq, Model model) {
		TutorAppDTO tadto = aservice.tutorAppView(seq);
		model.addAttribute("tadto", tadto);
		return "/admin/tutorAppView";
	}
	
	// 튜터 신청 승인
	@RequestMapping("/tutorAppUpdate")
	public String tutorAppUpdate(int seq, String id, Model model) {
		aservice.updateTutorApp(seq, id);
		model.addAttribute("seq", seq);
		return "redirect:/admin/tutorAppView";
	}
	
	// 강의 리스트
	@RequestMapping("/lessonList")
	public String lessonList(HttpServletRequest request, Model model) throws Exception {
		int cpage = 1;
        try {
           cpage = Integer.parseInt(request.getParameter("cpage"));
        } catch (Exception e) {}
        
		List<LessonDTO> llist = aservice.lessonList(cpage);
		Map<String, String> param = new HashMap<>();
		
		param.put("tableName", "lesson");
		param.put("pageName", "lessonList");
		param.put("columnName", "pass");
		param.put("columnValue", "Y");
		
		String navi = aservice.getPageNav(cpage, param);
		
		model.addAttribute("llist", llist);
		model.addAttribute("navi", navi);
		
		return "/admin/lessonList";
	}
	
	// 강의 뷰
	@RequestMapping("/lessonView")
	public String lessonView(int seq, Model model) {
		LessonDTO ldto = aservice.lessonView(seq);
		model.addAttribute("ldto", ldto);
		return "/admin/lessonView";
	}
	
	// 강의 신청 리스트
	@RequestMapping("/lessonAppList")
	public String lessonAppList(HttpServletRequest request, Model model) throws Exception {
		int cpage = 1;
        try {
           cpage = Integer.parseInt(request.getParameter("cpage"));
        } catch (Exception e) {}
        
		List<LessonDTO> lalist = aservice.lessonAppList(cpage);
		Map<String, String> param = new HashMap<>();
		
		param.put("tableName", "lesson");
		param.put("pageName", "lessonAppList");
		param.put("columnName", "pass");
		param.put("columnValue", "N");
		
		String navi = aservice.getPageNav(cpage, param);
		
		model.addAttribute("lalist", lalist);
		model.addAttribute("navi", navi);
		
		return "/admin/lessonAppList";
	}
	
	// 강의 신청 뷰
	@RequestMapping("/lessonAppView")
	public String lessonAppView(int seq, Model model) {
		LessonDTO ladto = aservice.lessonAppView(seq);
		model.addAttribute("ladto", ladto);
		return "/admin/lessonAppView";
	}
	
	// 강의 신청 승인
	@RequestMapping("/lessonPass")
	public String lessonPass(int seq) {
		aservice.updateLessonPass(seq);
		return "redirect:/admin/lessonAppList";
	}
	
	// 강의 삭제 리스트
	@RequestMapping("/lessonDelList")
	public String lessonDelList(HttpServletRequest request, Model model) throws Exception {
		int cpage = 1;
        try {
           cpage = Integer.parseInt(request.getParameter("cpage"));
        } catch (Exception e) {}
        
		List<DeleteApplyDTO> ldlist = aservice.lessonDelList(cpage);
		Map<String, String> param = new HashMap<>();
		
		param.put("tableName", "delete_app");
		param.put("pageName", "lessonDelList");
		param.put("columnName", "category");
		param.put("columnValue", "강의");
		
		String navi = aservice.getPageNav(cpage, param);
		
		model.addAttribute("ldlist", ldlist);
		model.addAttribute("navi", navi);
		
		return "/admin/lessonDelList";
	}
	
	// 강의 삭제 뷰
	@RequestMapping("/lessonDelView")
	public String lessonDelView(int seq, Model model) {
		DeleteApplyDTO lddto = aservice.lessonDelView(seq);
		model.addAttribute("lddto", lddto);
		return "/admin/lessonDelView";
	}
	
	// 강의 삭제 승인
	@RequestMapping("/deleteAppLesson")
	public String deleteAppLesson(int seq) {
		aservice.deleteApplyLesson(seq);
		return "redirect:/admin/lessonDelList";
	}
	
	// 튜티 리스트
	@RequestMapping("/tuteeList")
	public String tuteeList(HttpServletRequest request, Model model) throws Exception {
		int cpage = 1;
        try {
           cpage = Integer.parseInt(request.getParameter("cpage"));
        } catch (Exception e) {}
        
		List<TuteeDTO> ttlist = aservice.tuteeList(cpage);
		Map<String, String> param = new HashMap<>();
		
		param.put("tableName", "tutee");
		param.put("pageName", "tuteeList");
		
		String navi = aservice.getPageNav(cpage, param);
		
		model.addAttribute("ttlist", ttlist);
		model.addAttribute("navi", navi);
		
		return "/admin/tuteeList";
	}
	
	// 튜티 뷰
	@RequestMapping("/tuteeView")
	public String tuteeView(int seq, Model model) {
		TuteeDTO ttdto = aservice.tuteeView(seq);
		model.addAttribute("ttdto", ttdto);
		return "/admin/tuteeView";
	}
	
	// 토론 리스트
	@RequestMapping("/discussionList")
	public String discussionList(HttpServletRequest request, Model model) throws Exception {
		int cpage = 1;
        try {
           cpage = Integer.parseInt(request.getParameter("cpage"));
        } catch (Exception e) {}
        
		List<DiscussionDTO> dlist = aservice.discussionList(cpage);
		Map<String, String> param = new HashMap<>();
		
		param.put("tableName", "discussion");
		param.put("pageName", "discussionList");
		
		String navi = aservice.getPageNav(cpage, param);
		
		model.addAttribute("dlist", dlist);
		model.addAttribute("navi", navi);
		
		return "/admin/discussionList";
	}
	
	// 토론 뷰
	@RequestMapping("/discussionView")
	public String discussionView(int seq, Model model) {
		DiscussionDTO ddto = aservice.discussionView(seq);
		model.addAttribute("ddto", ddto);
		return "/admin/discussionView";
	}
	
	// 첨삭 리스트
	@RequestMapping("/correctList")
	public String correctList(HttpServletRequest request, Model model) throws Exception {
		int cpage = 1;
        try {
           cpage = Integer.parseInt(request.getParameter("cpage"));
        } catch (Exception e) {}
        
		List<CorrectDTO> clist = aservice.correctList(cpage);
		Map<String, String> param = new HashMap<>();
		
		param.put("tableName", "correct");
		param.put("pageName", "correctList");
		
		String navi = aservice.getPageNav(cpage, param);
		
		model.addAttribute("clist", clist);
		model.addAttribute("navi", navi);
		
		return "/admin/correctList";
	}
	
	// 첨삭 뷰
	@RequestMapping("/correctView")
	public String correctView(int seq, Model model) {
		CorrectDTO cdto = aservice.correctView(seq);
		model.addAttribute("cdto", cdto);
		return "/admin/correctView";
	}
	
	// 신고 리스트
	@RequestMapping("/reportList")
	public String reportList(HttpServletRequest request, Model model) throws Exception {
		int cpage = 1;
        try {
           cpage = Integer.parseInt(request.getParameter("cpage"));
        } catch (Exception e) {}
        
		List<ReportListDTO> rlist = aservice.reportList(cpage);
		Map<String, String> param = new HashMap<>();
		
		param.put("tableName", "reportlist");
		param.put("pageName", "reportList");
		
		String navi = aservice.getPageNav(cpage, param);
		
		model.addAttribute("rlist", rlist);
		model.addAttribute("navi", navi);
		
		return "/admin/reportList";
	}
	
	// 신고 뷰
	@RequestMapping("/reportView")
	public String reportView(int seq, Model model) {
		ReportListDTO rdto = aservice.reportView(seq);
		model.addAttribute("rdto", rdto);
		return "/admin/reportView";
	}
	
	// 신고 승인
	@RequestMapping("/reportUpdate")
	public String reportUpdate(ReportListDTO rdto, Model model) {
		Map<String, Object> param = new HashMap<>();
		
		param.put("seq", rdto.getSeq());
		param.put("id", rdto.getId());
		
		if (rdto.getCategory().contentEquals("그룹")) {
			param.put("tableName", "grouplist");
			param.put("columnName", "seq");
			param.put("columnValue", rdto.getParent_seq());
		} else if (rdto.getCategory().contentEquals("토론")) {
			param.put("tableName", "discussion");
			param.put("columnName", "seq");
			param.put("columnValue", rdto.getParent_seq());
		} else if (rdto.getCategory().contentEquals("첨삭")) {
			param.put("tableName", "correct");
			param.put("columnName", "seq");
			param.put("columnValue", rdto.getParent_seq());
		}
		
		aservice.updateReportList(param);
		model.addAttribute("seq", rdto.getSeq());
		return "redirect:/admin/reportView";
	}
	
	// 아이디로 삭제
	@RequestMapping("/deleteById")
	public String deleteById(String id, String pageName) {
		Map<String, Object> param = new HashMap<>();
		
		param.put("columnName", "id");
		param.put("columnValue", id);
		
		if (pageName.contentEquals("memberList")) {
			param.put("tableName", "member");
			
			aservice.deleteOne(param);
		} else if(pageName.contentEquals("tutorList")) {
			aservice.deleteTutor(id);
		} else if(pageName.contentEquals("partnerList")) {
			param.put("tableName", "partner");
			
			aservice.deletePartner(param);
		}
		
		return "redirect:/admin/" + pageName;
	}
	
	// 시퀀스로 삭제
	@RequestMapping("/deleteBySeq")
	public String deleteBySeq(int seq, String pageName) {
		Map<String, Object> param = new HashMap<>();
		
		param.put("columnName", "seq");
		param.put("columnValue", seq);
		
		if (pageName.contentEquals("partnerList")) {
			param.put("tableName", "partner");
		} else if (pageName.contentEquals("groupList")) {
			param.put("tableName", "grouplist");
		} else if (pageName.contentEquals("tutorAppList")) {
			param.put("tableName", "tutor_app");
		} else if (pageName.contentEquals("lessonList")) {
			param.put("tableName", "lesson");
		} else if (pageName.contentEquals("lessonAppList")) {
			param.put("tableName", "lesson");
		} else if (pageName.contentEquals("lessonDelList")) {
			param.put("tableName", "delete_app");
		} else if (pageName.contentEquals("tuteeList")) {
			TuteeDTO tdto = aservice.tuteeView(seq);
			int parent_seq = tdto.getParent_seq();
			param.put("tableName", "tutee");
			param.put("parent_seq", parent_seq);
		} else if (pageName.contentEquals("discussionList")) {
			param.put("tableName", "discussion");
		} else if (pageName.contentEquals("correctList")) {
			param.put("tableName", "correct");
		} else if (pageName.contentEquals("reportList")) {
			param.put("tableName", "reportlist");
		}
		
		if (pageName.contentEquals("tuteeList")) {
			aservice.deleteTutee(param);
		} else {
			aservice.deleteOne(param);
		}
		
		return "redirect:/admin/" + pageName;
	}
	
	// 체크박스로 여러 개 삭제
	@RequestMapping("/deleteAll")
	public String deleteAll(String values, String pageName) {
		Map<String, Object> param = new HashMap<>();
		String[] valueList = values.split(",");

		param.put("valueList", valueList);
		
		if (pageName.contentEquals("correctList")) {
			param.put("tableName", "correct");
		} else if (pageName.contentEquals("discussionList")) {
			param.put("tableName", "discussion");
		} else if (pageName.contentEquals("groupList")) {
			param.put("tableName", "grouplist");
		} else if (pageName.contentEquals("lessonAppList")) {
			param.put("tableName", "lesson");
		} else if (pageName.contentEquals("lessonDelList")) {
			param.put("tableName", "delete_app");
		} else if (pageName.contentEquals("lessonList")) {
			param.put("tableName", "lesson");
		} else if (pageName.contentEquals("memberList")) {
			param.put("tableName", "member");
		} else if (pageName.contentEquals("partnerList")) {
			param.put("tableName", "partner");
		} else if (pageName.contentEquals("reportList")) {
			param.put("tableName", "reportlist");
		} else if (pageName.contentEquals("tuteeList")) {
			param.put("tableName", "tutee");
		} else if (pageName.contentEquals("tutorAppList")) {
			param.put("tableName", "tutor_app");
		} else if (pageName.contentEquals("tutorList")) {
			param.put("tableName", "member");
		}
		
		if (pageName.contentEquals("memberList") || pageName.contentEquals("tutorList")) {
			param.put("columnName", "id");
		} else {
			param.put("columnName", "seq");
		}
		
		aservice.deleteAll(param);
		
		return "redirect:/admin/" + pageName;
	}
	
	// 체크박스로 여러 튜터 삭제
	@RequestMapping("/deleteSelectedTutor")
	public String deleteSelectedTutor(String ids) {
		String[] idList = ids.split(",");
		List<String> list = new ArrayList<>();
		
		for (int i = 0; i < idList.length; i++) {
			list.add(idList[i]);
		}
		
		aservice.deleteSelectedTutor(list);
		
		return "redirect:/admin/tutorList";
	}
	
	// 체크박스로 여러 개 승인
	@RequestMapping("/acceptAll")
	public String acceptAll(String values, String pageName) {
		String[] seqList = values.split(",");
		List<String> list = new ArrayList<>();
		Map<String, Object> param = new HashMap<>();
		
		for (int i = 0; i < seqList.length; i++) {
			list.add(seqList[i]);
		}
		
		if (pageName.contentEquals("lessonAppList")) {
			param.put("tableName", "lesson");
		} else if (pageName.contentEquals("reportList")) {
			param.put("tableName", "reportlist");
		} else if (pageName.contentEquals("tutorAppList")) {
			param.put("tableName", "tutor_app");
		}
		
		param.put("valueList", list);
		
		aservice.acceptAll(param);
		
		return "redirect:/admin/" + pageName;
	}
	
	// 체크박스로 여러 강의 삭제 승인
	@RequestMapping("/acceptDeleteLessons")
	public String acceptDeleteLessons(String values) {
		String[] seqList = values.split(",");
		List<Integer> list = new ArrayList<>();
		
		for (int i = 0; i < seqList.length; i++) {
			list.add(Integer.parseInt(seqList[i]));
		}
		
		aservice.acceptDeleteLessons(list);
		
		return "redirect:/admin/lessonDelList";
	}
}
