package kh.pingpong.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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
		FileTnDTO ftndto = new FileTnDTO();
		
		System.out.println(ndto.getTitle() + ndto.getWriter() + ndto.getCategory() + ndto.getStart_date());
		System.out.println(ndto.getContents());
		System.out.println(fsdto.getFiles());
		
		// 썸네일 파일 하나 저장
		String realPath = session.getServletContext().getRealPath("upload/news/thumbnail/");
		ftndto = fcon.newsFileOneInsert(ndto, ftndto, realPath);		
		System.out.println(ftndto.getSysname());
		
		// 첨부파일 여러개
		String realPath2 = session.getServletContext().getRealPath("upload/news/files/");
		List<FileDTO> filseA = fcon.newsFileInsert(fsdto, realPath2);
		System.out.println(filseA.get(0).getSysname());
		
		//int result = newservice.newsInsert(ndto, ftndto, filseA);
		
		return "/news/list";
	}
	
	
	
}
