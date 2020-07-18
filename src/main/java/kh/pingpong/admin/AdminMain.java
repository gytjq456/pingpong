package kh.pingpong.admin;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.pingpong.dto.LanguageDTO;
import kh.pingpong.dto.LocationDTO;
import kh.pingpong.dto.VisitorDTO;
import kh.pingpong.service.VisitorService;

@Controller
@RequestMapping("/admin")
public class AdminMain {
	@Autowired
	private AdminService aservice;
	
	@Autowired
	private VisitorService vservice;
	
	@Autowired
	private HttpSession session;
	
	// 관리자 메인 페이지
	@RequestMapping("")
	public String index(Model model) {
		List<VisitorDTO> vlist = vservice.selectSevenDays();
		List<LanguageDTO> llist = aservice.selectFiveLang();
		List<LocationDTO> clist = aservice.selectFiveLoc();
		
		model.addAttribute("vlist", vlist);
		model.addAttribute("llist", llist);
		model.addAttribute("clist", clist);
		
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
}
