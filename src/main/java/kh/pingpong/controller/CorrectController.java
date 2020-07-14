package kh.pingpong.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kh.pingpong.dto.CommentDTO;
import kh.pingpong.dto.Correct_CommentDTO;
import kh.pingpong.dto.CorrectDTO;
import kh.pingpong.dto.JjimDTO;
import kh.pingpong.dto.LikeListDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.ReportListDTO;
import kh.pingpong.service.CorrectService;

@Controller
@RequestMapping("/correct")
public class CorrectController {
	
	@Autowired
	private CorrectService cservice;
	
	@Autowired
	private HttpSession session;
	

	@RequestMapping("/correct_list")
	public String list(CorrectDTO dto, Model model, HttpServletRequest request) throws Exception{
		int cpage =1;
		try {
		cpage =Integer.parseInt(request.getParameter("cpage"));
		} catch (Exception e) {}
		boolean in = false;
		dto = cservice.viewcount(dto.getSeq(),in);
		List<CorrectDTO> list = cservice.selectAll(cpage);
		String navi = cservice.correct_paging(cpage);
		model.addAttribute("navi", navi);
		model.addAttribute("list", list);
		model.addAttribute("dto", dto);
		return "/correct/correct_list";
	}
	
	@RequestMapping("/correct_write")
	public String correct_write() {
		return "/correct/correct_write";
	}
	
	@RequestMapping("/correct_view")
	public String view(CorrectDTO dto, Correct_CommentDTO cdto, Model model, LikeListDTO ldto, JjimDTO jdto) throws Exception{
		MemberDTO mdto = (MemberDTO)session.getAttribute("loginInfo");
		String id = mdto.getId();
		
		ldto.setId(id);
		ldto.setParent_seq(dto.getSeq());
		
		boolean checkLike = cservice.LikeIsTrue(ldto);
		
		
		int likecount = cservice.likecount(ldto);
		
		dto = cservice.selectOne(dto.getSeq());
		List<Correct_CommentDTO> list_dto = cservice.selectcAll(dto.getSeq());
		List<Correct_CommentDTO> best_dto = cservice.bestcomm(dto.getSeq());
		
		model.addAttribute("dto", dto);
		model.addAttribute("best_dto", best_dto);
		model.addAttribute("list_dto", list_dto);
		model.addAttribute("checkLike", checkLike);
		model.addAttribute("likecount",likecount);
		return "/correct/correct_view";
	}
	@RequestMapping("/writeProc")
	public String writeProc(CorrectDTO dto) throws Exception{
		MemberDTO mdto = (MemberDTO)session.getAttribute("loginInfo");
		String id = mdto.getId();
		dto.setId(id);
		cservice.insert(dto);
		return "redirect:/correct/correct_list";	}
	
	
	
	@RequestMapping("/correct_modify")
	public String modify(CorrectDTO dto, Model model) throws Exception {
	dto = cservice.selectOne(dto.getSeq());
		model.addAttribute("dto",dto);
	return "/correct/correct_modify";
	}
	
	
	@RequestMapping("/modifyProc")
	public String modifyP(CorrectDTO dto, Model model) throws Exception {
		model.addAttribute("seq",dto.getSeq());
		cservice.modify(dto);
		return "redirect:/correct/correct_view";
	}
	
	
	
	@ResponseBody
	@RequestMapping("/commentProc")
	public String commentProc(CorrectDTO dto,Correct_CommentDTO cdto, Model model) throws Exception{
		MemberDTO mdto = (MemberDTO)session.getAttribute("loginInfo");
		String id = mdto.getId();
		cdto.setId(id);
		int result = cservice.commentInsert(cdto);
		model.addAttribute("parent_seq", cdto.getParent_seq());
		cservice.countrep(cdto);
		if(result > 0) {
			return String.valueOf(true);
		}else {
			return String.valueOf(false);
		}
	}
	
	@ResponseBody
	@RequestMapping("/like")
	public String like(CorrectDTO dto, LikeListDTO ldto, Model model) throws Exception {
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		String id = loginInfo.getId();
		
		ldto.setId(id);
		ldto.setParent_seq(dto.getSeq());
		model.addAttribute("ldto", ldto);
		int result = cservice.like(ldto);
		if(result > 0) {
			return String.valueOf(true);
		}else {
			return String.valueOf(false);
		}
	}
	
	@ResponseBody
	@RequestMapping("/likecancle")
	public String likecancle(CorrectDTO dto, LikeListDTO ldto, Model model) throws Exception {
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		String id = loginInfo.getId();
		
		ldto.setId(id);
		ldto.setParent_seq(dto.getSeq());
		model.addAttribute("ldto", ldto);
		int result = cservice.likecancle(ldto);
		if(result > 0) {
			return String.valueOf(true);
		}else {
			return String.valueOf(false);
		}
	}
	
	
	
	@ResponseBody
	@RequestMapping("/delete")
	public String delete(CorrectDTO dto) throws Exception {
		int result = cservice.delete(dto);
		if(result > 0) {
			return String.valueOf(true);
		}else {
			return String.valueOf(false);
		}
	}
	@ResponseBody
	@RequestMapping("/commentDelete")
	public String commentDelete(Correct_CommentDTO cdto) throws Exception{
		int result = cservice.commentDelete(cdto);
		if(result > 0) {
			return String.valueOf(true);
		}else {
			return String.valueOf(false);
		}
	}
	@RequestMapping("/report")
	@ResponseBody
	public int report(ReportListDTO rldto, Model model) {
		MemberDTO mdto = (MemberDTO)session.getAttribute("loginInfo");
		rldto.setReporter(mdto.getId());
		
		int result = cservice.selectReport(rldto);
		model.addAttribute("rldto", rldto);
		
		return result;
	}
	
	@RequestMapping("/reportProc")
	public String reportProc(ReportListDTO rldto, Model model) {
		cservice.insertReport(rldto);
		return "redirect:/correct/correct_view?seq=" + rldto.getParent_seq();
	}
	
	@RequestMapping("/comment_report")
	@ResponseBody
	public int report(Model model, ReportListDTO rldto) throws Exception {
		MemberDTO mdto = (MemberDTO)session.getAttribute("loginInfo");
		rldto.setReporter(mdto.getId());
		int result = cservice.comment_report(rldto);
		model.addAttribute("rldto",rldto);
		return result;
	}
	
	//신고 테이블에 저장
	@RequestMapping("/comment_reportProc")
	public String reportProc(Model model, ReportListDTO rldto) throws Exception{
		cservice.comment_reportProc(rldto);
		return "redirect:/correct/correct_view?seq="+rldto.getParent_seq();
	}
	
	
}
