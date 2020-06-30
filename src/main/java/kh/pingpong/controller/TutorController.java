package kh.pingpong.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import kh.pingpong.dto.DeleteApplyDTO;
import kh.pingpong.dto.FileDTO;
import kh.pingpong.dto.FilesDTO;
import kh.pingpong.dto.LanguageDTO;
import kh.pingpong.dto.LessonDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.TutorAppDTO;
import kh.pingpong.dto.TutorDTO;
import kh.pingpong.service.MemberService;
import kh.pingpong.service.TutorService;

@Controller
@RequestMapping("/tutor/")
public class TutorController {

	@Autowired
	private HttpSession session;
	
	@Autowired
	private TutorService tservice;
	
	@Autowired
	private MemberService mservice;
	
	@RequestMapping("lessonApp")
	public String lessonApp(Model model) throws Exception{
		//언어 
		List<LanguageDTO> lanList = mservice.lanList();
		model.addAttribute("lanList",lanList);
		return "tutor/lessonApp";
	}

	@RequestMapping("tutorApp")
	public String tutorApp(Model model) throws Exception{
		model.addAttribute("loginInfo", session.getAttribute("loginInfo"));
		return "tutor/tutorApp";
	}
	
	@RequestMapping("tutorAppSend")
	public String tutorAppSend(Model model, TutorAppDTO tadto, MultipartFile[] files) throws Exception{
		//----------------------파일 업로드 
		String filePath = session.getServletContext().getRealPath("upload/tutorLicense/");
		System.out.println(filePath);
		List<FileDTO> fileList = new ArrayList<>();
		File targetLoc;
		String systemFileName=null;
		
		System.out.println(files);
		if(files.length != 0) {
			for(MultipartFile file : files) {
				FileDTO fdto = new FileDTO();
				fdto.setOriname(file.getOriginalFilename());
				systemFileName=System.currentTimeMillis()+"_"+file.getOriginalFilename(); 
				fdto.setSysname(systemFileName);

				targetLoc = new File(filePath + "/" + systemFileName);
				file.transferTo(targetLoc);
				fileList.add(fdto);
			}
		}
		//----------------------------------
		tadto.setLicense(systemFileName);
		tservice.tutorAppSend(tadto,fileList, filePath);

		model.addAttribute("loginInfo", session.getAttribute("loginInfo"));
		
		
		return "tutor/tutorApp";
	}
	
	@RequestMapping("tutorList")
	public String tutorList(HttpServletRequest request, Model model) throws Exception{
		model.addAttribute("loginInfo", session.getAttribute("loginInfo"));
		int cpage = 1;
        try {
           cpage = Integer.parseInt(request.getParameter("cpage"));
        } catch (Exception e) {}
        
        String navi = tservice.getPageNavi_tutor(cpage);
		model.addAttribute("navi", navi);
        
		List<MemberDTO> tutorlist = tservice.tutorList(cpage);
		model.addAttribute("tutorlist",tutorlist);
		return "tutor/tutorList";
	}
	
	@RequestMapping("lessonList")
	public String lessonList(HttpServletRequest request, Model model) throws Exception{
		model.addAttribute("loginInfo", session.getAttribute("loginInfo"));
		
		//언어 
		List<LanguageDTO> lanList = mservice.lanList();
		model.addAttribute("lanList",lanList);
		
		int cpage = 1;
        try {
           cpage = Integer.parseInt(request.getParameter("cpage"));
        } catch (Exception e) {}
        
		String navi = tservice.getPageNavi_lesson(cpage);
		model.addAttribute("navi", navi);
		
		List<LessonDTO> lessonlist = tservice.lessonList(cpage);
		System.out.println(lessonlist);
		model.addAttribute("lessonlist",lessonlist);
		return "tutor/lessonList";
	}
	
	@RequestMapping("lessonView")
	public String lessonView(Model model, int seq) throws Exception{
		LessonDTO ldto = tservice.lessonView(seq);
		//언어 
		List<LanguageDTO> lanList = mservice.lanList();
		model.addAttribute("lanList",lanList);
		model.addAttribute("ldto", ldto);
		model.addAttribute("seq", seq);
		return "tutor/lessonView";
	}
	
	
	
	@RequestMapping("lessonCancle")
	public String lessonCancle(Model model) throws Exception{
		model.addAttribute("loginInfo", session.getAttribute("loginInfo"));
		
		return "tutor/lessonCancle";
	}
	
	@RequestMapping("cancleProc")
	public String lessonCancleProc(DeleteApplyDTO dadto) throws Exception{
		System.out.println(dadto.getId()+ " : " + dadto.getSeq()+ " : " + dadto.getCategory()+ " : " + dadto.getContents()+ " : " + dadto.getParent_seq());
		tservice.lessonCancleProc(dadto);
		return "redirect: lessonView";
	}

}
