package kh.pingpong.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import kh.pingpong.dto.FileDTO;
import kh.pingpong.dto.FilesDTO;
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
	
	@Autowired
	private FileController filecon;
	
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
		
		System.out.println(files);
		if(files.length != 0) {
			for(MultipartFile file : files) {
				FileDTO fdto = new FileDTO();
				fdto.setOriname(file.getOriginalFilename());
				String systemFileName=System.currentTimeMillis()+"_"+file.getOriginalFilename(); 
				fdto.setSysname(systemFileName);

				targetLoc = new File(filePath + "/" + systemFileName);
				file.transferTo(targetLoc);
				fileList.add(fdto);
			}
		}
		//----------------------------------
		
		tservice.tutorAppSend(tadto,fileList, filePath);

		model.addAttribute("list", session.getAttribute("loginInfo"));
		
		
		return "tutor/tutorApp";
	}
}
