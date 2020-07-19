package kh.pingpong.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kh.pingpong.dto.FileDTO;
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
	public String listProc(HttpServletRequest request, Model model) throws Exception{
		int cpage =1;
		try {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}catch(Exception e) {
		}
		String navi = newservice.getPageNavi_news(cpage);
		model.addAttribute("navi",navi);
		
		List<NewsDTO> newsSelect = newservice.newsPage(cpage);
		model.addAttribute("newsSelect",newsSelect);		
		return "/news/list";
	}
	
	/* 뷰페이지 jsp */
	@RequestMapping("viewProc")
	public String viewProc(NewsDTO ndto, Model model) throws Exception{	
		//조회수 늘리기
		newservice.viewCount(ndto);
		
		ndto = newservice.newsViewOne(ndto);
		List <FileDTO> files = newservice.newsViewFile(ndto);
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
	public String writeProc(NewsDTO ndto, FilesDTO filesAll) throws Exception{
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		ndto.setWriter(loginInfo.getId());
		ndto.setLocation(ndto.getAddress() + " " + ndto.getDetailAddress() + " " + ndto.getExtraAddress());
		
		FileDTO ftndto = new FileDTO();
		// 썸네일 드라이브에 저장
		String realPath = session.getServletContext().getRealPath("upload/news/thumbnail/");
		ftndto = fcon.newsFileOneInsert(ndto, ftndto, realPath);		
		
		// 첨부파일 드라이브에 저장
		String realPath2 = session.getServletContext().getRealPath("upload/news/files/");
		List<FileDTO> filseA = fcon.newsFilesInsert(filesAll, realPath2);
		
		newservice.newsInsert(ndto, ftndto, filseA);
		
		return "redirect:/news/listProc";
	}
	
	/* 글 수정 jsp */
	@RequestMapping("modify")
	public String modify(NewsDTO ndto, Model model) throws Exception{
		ndto = newservice.newsViewOne(ndto);
		List <FileDTO> files = newservice.newsViewFile(ndto);
		model.addAttribute("ndto",ndto);
		model.addAttribute("files",files);
		return "/news/modify";
	}
	
	/* 글 수정 */
	@RequestMapping("modifyProc")
	public String modifyProc(NewsDTO ndto, FilesDTO filesAll, Model model) throws Exception{
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		ndto.setWriter(loginInfo.getId());
		
		//주소변경 시
		if(!ndto.getAddress().contentEquals("")) {
			ndto.setLocation(ndto.getAddress() + ndto.getDetailAddress() + ndto.getExtraAddress());
		}
		FileDTO ftndto = new FileDTO();
		
		System.out.println(filesAll.getFilesAll() + " 뉴스 컨트롤러 파일들 길이");
		
		// 썸네일 파일 하나 저장
		if(!ndto.getThumbnail().getOriginalFilename().contentEquals("")) {
			String realPath = session.getServletContext().getRealPath("upload/news/thumbnail/");
			ftndto = fcon.newsFileOneInsert(ndto, ftndto, realPath);
			newservice.modifyProc(ndto, ftndto);
			
		}else if(filesAll.getFilesAll() != null) {
		// 첨부파일 여러개
			String realPath2 = session.getServletContext().getRealPath("upload/news/files/");
			List<FileDTO> filseA = fcon.newsFilesInsert(filesAll, realPath2);
			newservice.modifyProcAll(ndto, filseA);
			
		}else {
			//수정할 때 프로필과 파일 없을 때
			System.out.println("프로필 수정 안했을 때!");
			newservice.modifyProc_news(ndto);
		}
				
		return "redirect:/news/listProc";
	}
	
	/* 글수정 첨부파일 하나 삭제 jsp 
	@ResponseBody
	@RequestMapping("dele_fileOne")
	public String dele_fileOne(NewsDTO ndto) throws Exception{
		int result = newservice.dele_fileOne(ndto);
		return String.valueOf(result);
	}*/
	
	/* 글 삭제 */
	@ResponseBody
	@RequestMapping("delete")
	public String delete(NewsDTO ndto) throws Exception{
		int result = newservice.delete(ndto);
		return String.valueOf(result);
	}
	
	/* 글 정렬 */
	@RequestMapping("schAlign")
	public String schAlign(HttpServletRequest request, String schAlign, Model model) throws Exception{
		System.out.println(schAlign + "  아쿠");
		int cpage =1;
		try {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}catch(Exception e) {
		}
		String navi = newservice.getPageNavi_news(cpage);
		model.addAttribute("navi",navi);
		model.addAttribute("schAlign", schAlign);
		
		List<NewsDTO> newsSelect = newservice.schAlign(schAlign, cpage);
		model.addAttribute("newsSelect",newsSelect);
		
		return "/news/list";
	}
	
}
