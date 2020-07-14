package kh.pingpong.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kh.pingpong.dto.LetterDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.service.LetterService;

@Controller
@RequestMapping("/letter/")
public class LetterController {
	@Autowired
	private LetterService lservice;
	
	@Autowired
	private HttpSession session;
	
	@ResponseBody
	@RequestMapping("send")
	public boolean send(LetterDTO ldto) throws Exception {
		MemberDTO mdto = (MemberDTO)session.getAttribute("loginInfo");
		String from_id = mdto.getId();
		String from_name = mdto.getName();
		
		ldto.setFrom_id(from_id);
		ldto.setFrom_name(from_name);
		
		int result = lservice.insertLetter(ldto);
		boolean resp = false;
		
		if (result > 0) {
			resp = true;
		}
		
		return resp;
	}
	
	@RequestMapping("letterList")
	public String letterList(Model model) throws Exception {
		MemberDTO mdto = (MemberDTO)session.getAttribute("loginInfo");
		String id = mdto.getId();
		
		List<LetterDTO> rlist = lservice.receiveLetterList(id);
		List<LetterDTO> slist = lservice.sendLetterList(id);
		
		model.addAttribute("rlist", rlist);
		model.addAttribute("slist", slist);
		
		return "/mypage/letter";
	}
	
	@RequestMapping("deleteReceiveLetter")
	public String deleteReceiveLetter(int seq) throws Exception {
		lservice.deleteReceiveLetter(seq);
		return "redirect:/letter/letterList";
	}
	
	@RequestMapping("deleteSendLetter")
	public String deleteSendLetter(int seq) throws Exception {
		lservice.deleteSendLetter(seq);
		return "redirect:/letter/letterList";
	}
	
	@ResponseBody
	@RequestMapping("updateRead")
	public boolean updateRead(int seq) throws Exception {
		int result = lservice.updateRead(seq);
		boolean resp = false;
		
		if (result > 0) {
			resp = true;
		}
		
		return resp;
	}
}
