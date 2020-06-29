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

import kh.pingpong.dto.FileDTO;
import kh.pingpong.dto.FilesDTO;
import kh.pingpong.dto.LessonDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.TutorAppDTO;
import kh.pingpong.dto.TutorDTO;
import kh.pingpong.service.TutorService;

@Controller
@RequestMapping("/tutor/")
public class TutorController {

	@Autowired
	private HttpSession session;
	
	@Autowired
	private TutorService tservice;

	@RequestMapping("tutorApp")
	public String tutorApp(Model model) {
		model.addAttribute("list", session.getAttribute("loginInfo"));
		return "tutor/tutorApp";
	}
	
	@RequestMapping("tutorAppSend")
	public String tutorAppSend(Model model, TutorAppDTO tadto, MultipartFile[] files) throws Exception{
		//----------------------파일업로드 
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

		model.addAttribute("list", session.getAttribute("loginInfo"));
		
		
		return "tutor/tutorApp";
	}
	
	@RequestMapping("tutorList")
	public String tutorList(HttpServletRequest request, Model model) throws Exception{
		model.addAttribute("list", session.getAttribute("loginInfo"));
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
		model.addAttribute("list", session.getAttribute("loginInfo"));
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
	
	@RequestMapping("lessonCancle")
	public String lessonCancle() throws Exception{
		return "tutor/lessonCancle";
	}
	
//	LessonDTO ldto = new LessonDTO();
//	MemberDTO mdto = (MemberDTO) session.getAttribute("loginInfo");
//	ldto.setName(mdto.getName());
//	ldto.setEmail(mdto.getEmail());
//	ldto.setPhone_country(mdto.getPhone_country());
//	ldto.setPhone(mdto.getPhone());
//	ldto.setProfile(mdto.getProfile());
}
