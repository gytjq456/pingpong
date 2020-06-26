package kh.pingpong.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import kh.pingpong.dto.BankDTO;
import kh.pingpong.dto.CountryDTO;
import kh.pingpong.dto.FileDTO;
import kh.pingpong.dto.HobbyDTO;
import kh.pingpong.dto.LanguageDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.service.MemberService;

@Controller
@RequestMapping("/member/")
public class MemberController {
	
	@Autowired
	private FileController fcon;
	
	
	public FileDTO fileOneInsert(MemberDTO mdto, FileDTO fdto, String realPath) throws Exception{
		
		MultipartFile profile = mdto.getProfile();
		
		System.out.println(realPath + " :: 리얼패스");
		File filePath = new File(realPath);
		//폴더 존재여부
		if(!filePath.exists()) {
			filePath.mkdir(); //폴더 만들기
		}
		
		/* 파일 업로드 */		
		fdto.setOriname(profile.getOriginalFilename());
		fdto.setSysname(mdto.getId() + "_" + profile.getOriginalFilename());
		fdto.setCategory(fdto.getCategory());
		String systemFileName = mdto.getId() +"_"+fdto.getOriname(); 
		
		//파일을 저장하기 위한 파일 객체 생성
		File fileDownload = new File(realPath + "/" + systemFileName);		
		profile.transferTo(fileDownload); //파일 저장
		
		//MemberDTO
		mdto.setProfile(profile);
		
		return fdto;
	}
	
	
	
	@Autowired
	private MemberService mservice;
	
	@Autowired
	private HttpSession session;

	/* 회원 가입하기 */
	@RequestMapping("signup")
	public String signup(Model model) throws Exception{		
		//은행
		List<BankDTO> bankList = mservice.bankList();
		model.addAttribute("bankList",bankList);
		
		//나라
		List<CountryDTO> countryList = mservice.countryList();
		model.addAttribute("countryList",countryList);
		
		//언어 
		List<LanguageDTO> lanList = mservice.lanList();
		model.addAttribute("lanList",lanList);
		
		//취미
		List<HobbyDTO> hobbyList = mservice.hobbyList();
		model.addAttribute("hobbyList",hobbyList);
		return "member/signup";			
	}	
	
	@RequestMapping("signupProc")
	public String signupProc(MemberDTO mdto, FileDTO fdto) throws Exception{

		//회원 파일 하나 저장
		String realPath = session.getServletContext().getRealPath("upload/member/");
		fdto = this.fileOneInsert(mdto, fdto, realPath);
		int result = mservice.memberInsert(mdto, fdto);		
		
		return "redirect:/member/memberComplete";
	}
	
	@RequestMapping("memberComplete")
	public String memberComplete() throws Exception{
		return "/member/memberComplete";
	}
	
	
	
}
