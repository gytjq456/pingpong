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
	public String letterList(Model model, HttpServletRequest request) throws Exception {
		int rcpage = 1;
        try {
           rcpage = Integer.parseInt(request.getParameter("rcpage"));
        } catch (Exception e) {}
        
        int scpage = 1;
        try {
           scpage = Integer.parseInt(request.getParameter("scpage"));
        } catch (Exception e) {}
        
		MemberDTO mdto = (MemberDTO)session.getAttribute("loginInfo");
		String id = mdto.getId();
		
		Map<String, Object> rparam = new HashMap<>();
		Map<String, Object> sparam = new HashMap<>();
		
		rparam.put("tableName", "receive_letter");
		rparam.put("id", id);
		rparam.put("rcpage", rcpage);
		
		sparam.put("tableName", "send_letter");
		sparam.put("id", id);
		sparam.put("scpage", scpage);
		
		List<LetterDTO> rlist = lservice.receiveLetterList(rparam);
		List<LetterDTO> slist = lservice.sendLetterList(sparam);
		
		String rnavi = lservice.getPageNav(rcpage, scpage, "receive_letter", id);
		String snavi = lservice.getPageNav(scpage, rcpage, "send_letter", id);
		
		model.addAttribute("rlist", rlist);
		model.addAttribute("slist", slist);
		model.addAttribute("rnavi", rnavi);
		model.addAttribute("snavi", snavi);
		
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
	
	@ResponseBody
	@RequestMapping("deleteSelected")
	public boolean deleteSelected(int[] seqs, String tableName) throws Exception {
		Map<String, Object> param = new HashMap<>();
		List<Integer> list = new ArrayList<>();
		
		for (int i = 0; i < seqs.length; i++) {
			list.add(seqs[i]);
		}
		
		param.put("seqs", list);
		param.put("tableName", tableName);
		
		int result = lservice.deleteSelected(param);
		boolean resp = false;
		
		if (result > 0) {
			resp = true;
		}
		
		return resp;
	}
}
