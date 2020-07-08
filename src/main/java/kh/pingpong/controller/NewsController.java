package kh.pingpong.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.pingpong.dto.FileTnDTO;
import kh.pingpong.dto.FilesDTO;
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
	
	/* 글쓰기 jsp */
	@RequestMapping("write")
	public String write() {
		return "/news/write";
	}
	
	/* 글쓰기 */
	@RequestMapping("writeProc")
	public String writeProc(NewsDTO ndto, FilesDTO fsdto) throws Exception{
		FileTnDTO ftndto = new FileTnDTO();
		
		// 썸네일 파일 하나 저장
		String realPath = session.getServletContext().getRealPath("upload/news/thumbnail/");
		ftndto = fcon.newsFileOneInsert(ndto, ftndto, realPath);
		
		// 썸네일 파일 하나 저장
		String realPath2 = session.getServletContext().getRealPath("upload/news/files/");
		//fsdto = fcon.newsFileInsert(fsdto, realPath2); -> 여기서 부터 시작
		
		//mservice.memberInsert(mdto, fdto);
		
		return "/news/list";
	}
	
	
	
}
