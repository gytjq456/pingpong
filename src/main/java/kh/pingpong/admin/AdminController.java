package kh.pingpong.admin;

import java.util.List;

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
	public String member(Model model) {
		List<MemberDTO> mlist = aservice.memberList();
		model.addAttribute("mlist", mlist);
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
	public String partner(Model model) {
		List<PartnerDTO> plist = aservice.partnerList();
		model.addAttribute("plist", plist);
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
	public String group(Model model) {
		List<GroupDTO> glist = aservice.groupList();
		model.addAttribute("glist", glist);
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
	public String tutorList(Model model) {
		List<MemberDTO> trlist = aservice.tutorList();
		model.addAttribute("trlist", trlist);
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
	public String tutorAppList(Model model) {
		List<TutorAppDTO> talist = aservice.tutorAppList();
		model.addAttribute("talist", talist);
		return "/admin/tutorAppList";
	}
	
	// 튜터 신청 뷰
	@RequestMapping("/tutorAppView")
	public String tutorAppView(int seq, Model model) {
		TutorAppDTO tadto = aservice.tutorAppView(seq);
		model.addAttribute("tadto", tadto);
		return "/admin/tutorAppView";
	}
	
	// 강의 리스트
	@RequestMapping("/lessonList")
	public String lessonList(Model model) {
		List<LessonDTO> llist = aservice.lessonList();
		model.addAttribute("llist", llist);
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
	public String lessonAppList(Model model) {
		List<LessonDTO> lalist = aservice.lessonAppList();
		model.addAttribute("lalist", lalist);
		return "/admin/lessonAppList";
	}
	
	// 강의 신청 뷰
	@RequestMapping("/lessonAppView")
	public String lessonAppView(int seq, Model model) {
		LessonDTO ladto = aservice.lessonAppView(seq);
		model.addAttribute("ladto", ladto);
		return "/admin/lessonAppView";
	}
	
	// 강의 삭제 리스트
	@RequestMapping("/lessonDelList")
	public String lessonDelList(Model model) {
		List<DeleteApplyDTO> ldlist = aservice.lessonDelList();
		model.addAttribute("ldlist", ldlist);
		return "/admin/lessonDelList";
	}
	
	// 강의 삭제 뷰
	@RequestMapping("/lessonDelView")
	public String lessonDelView(int seq, Model model) {
		DeleteApplyDTO lddto = aservice.lessonDelView(seq);
		model.addAttribute("lddto", lddto);
		return "/admin/lessonDelView";
	}
	
	// 튜티 리스트
	@RequestMapping("/tuteeList")
	public String tuteeList(Model model) {
		List<TuteeDTO> ttlist = aservice.tuteeList();
		model.addAttribute("ttlist", ttlist);
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
	public String discussionList(Model model) {
		List<DiscussionDTO> dlist = aservice.discussionList();
		model.addAttribute("dlist", dlist);
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
	public String correctList(Model model) {
		List<CorrectDTO> clist = aservice.correctList();
		model.addAttribute("clist", clist);
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
	public String reportList(Model model) {
		List<ReportListDTO> rlist = aservice.reportList();
		model.addAttribute("rlist", rlist);
		return "/admin/reportList";
	}
	
	// 신고 뷰
	@RequestMapping("/reportView")
	public String reportView(int seq, Model model) {
		ReportListDTO rdto = aservice.reportView(seq);
		model.addAttribute("rdto", rdto);
		return "/admin/reportView";
	}
}
