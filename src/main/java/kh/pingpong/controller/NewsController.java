package kh.pingpong.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kh.pingpong.dto.FileDTO;
import kh.pingpong.dto.FileTnDTO;
import kh.pingpong.dto.FilesDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.NewsDTO;
import kh.pingpong.service.NewsService;

@Controller
@RequestMapping("/news/")
public class NewsController {
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private FileController fcon;
	
	@Autowired
	private NewsService newservice;
	
	/* 리스트 jsp */
	@RequestMapping("list")
	public String list() {
		return "/news/list";
	}
	
	/* 리스트 */
	@RequestMapping("listProc")
	public String listProc(Model model) throws Exception{
		List<NewsDTO> newsSelect = newservice.newsSelect();
		model.addAttribute("newsSelect",newsSelect);
		return "/news/list";
	}
	
	/* 뷰페이지 jsp */
	@RequestMapping("viewProc")
	public String viewProc(NewsDTO ndto, Model model) throws Exception{		
		ndto = newservice.newsViewOne(ndto);
		List <FileTnDTO> files = newservice.newsViewFile(ndto);
		model.addAttribute("ndto",ndto);
		model.addAttribute("files",files);
		return "/news/view";
	}
	
	/* 글쓰기 jsp */
	@RequestMapping("write")
	public String write() {
		return "/news/write";
	}
	
	/* 글쓰기 */
	@RequestMapping("writeProc")
	public String writeProc(NewsDTO ndto, FilesDTO fsdto) throws Exception{
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		ndto.setWriter(loginInfo.getId());
		ndto.setLocation(ndto.getAddress() + ndto.getDetailAddress() + ndto.getExtraAddress());
		
		FileTnDTO ftndto = new FileTnDTO();
		
		// 썸네일 파일 하나 저장
		String realPath = session.getServletContext().getRealPath("upload/news/thumbnail/");
		ftndto = fcon.newsFileOneInsert(ndto, ftndto, realPath);		
		
		// 첨부파일 여러개
		String realPath2 = session.getServletContext().getRealPath("upload/news/files/");
		List<FileDTO> filseA = fcon.newsFileInsert(fsdto, realPath2);
		
		int result = newservice.newsInsert(ndto, ftndto, filseA);
		
		
		return "redirect:/news/listProc";
	}
	
	/* 글 수정 jsp */
	@RequestMapping("modify")
	public String modify(NewsDTO ndto, Model model) throws Exception{
		ndto = newservice.newsViewOne(ndto);
		List <FileTnDTO> files = newservice.newsViewFile(ndto);
		model.addAttribute("ndto",ndto);
		model.addAttribute("files",files);
		return "/news/modify";
	}
	
	/* 글수정 파일 하나 삭제 jsp */
	@ResponseBody
	@RequestMapping("dele_fileOne")
	public String dele_fileOne(NewsDTO ndto) throws Exception{
		System.out.println("파일 컨트롤러   "+ ndto.getCategory() + " :: " + ndto.getSeq());
		int result = newservice.dele_fileOne(ndto);
		return String.valueOf(result);
	}
	
	/* 글 삭제 */
	@ResponseBody
	@RequestMapping("delete")
	public String delete(NewsDTO ndto) throws Exception{
		int result = newservice.delete(ndto);
		return String.valueOf(result);
	}
	
}
