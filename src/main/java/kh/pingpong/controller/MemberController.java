package kh.pingpong.controller;

import java.io.File;
import java.text.SimpleDateFormat;
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
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private MemberService mservice;
	
	public FileDTO fileOneInsert(MemberDTO mdto, FileDTO fdto, String realPath) throws Exception{
		
		MultipartFile profile = mdto.getProfile();
		
		System.out.println(realPath + " :: 리얼패스");
		File filePath = new File(realPath);
		
		//폴더 존재여부
		if(!filePath.exists()) {
			filePath.mkdirs(); //하위폴더를 만들려고 했는데 상위폴더가 없어! 그럼 자동으로 만들어줌			
		}
		
		//현재시간
		String write_date = new SimpleDateFormat("YYYY-MM-dd-ss").format(System.currentTimeMillis());
		
		/* 하드디스크 파일 업로드 */		
		fdto.setOriname(profile.getOriginalFilename());
		fdto.setSysname(write_date + "_" + profile.getOriginalFilename());
		fdto.setRealpath(realPath + fdto.getSysname());
		fdto.setCategory(fdto.getCategory());
		String systemFileName = write_date +"_"+fdto.getOriname(); 
		
		//파일을 저장하기 위한 파일 객체 생성
		File fileDownload = new File(realPath + "/" + systemFileName);		
		profile.transferTo(fileDownload); //파일 저장
		
		//MemberDTO
		mdto.setProfile(profile);
		
		return fdto;
	}	
	

	/* :: 회원 가입하기  :: */
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
		String realPath = session.getServletContext().getRealPath("upload/member/" + mdto.getId() + "/");
		fdto = this.fileOneInsert(mdto, fdto, realPath); 
		int result = mservice.memberInsert(mdto, fdto);		
		
		return "redirect:/member/memberComplete";
	}
	
	@RequestMapping("memberComplete")
	public String memberComplete() throws Exception{
		return "/member/memberComplete";
	}
	
	/*마이페이지*/
	@RequestMapping("myInfo")
	public String myInfo(Model model) throws Exception{
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		System.out.println(loginInfo.getId());
		MemberDTO mdto = mservice.memberSelect(loginInfo);
		model.addAttribute("mdto",mdto);
		return "/member/mypage";
	}
	
	/* 로그인 페이지로 이동 */
	@RequestMapping("login")	
	public String login() throws Exception{
		return "/member/login";
	}
	
	/* 로그인 - 아디 비번체크 + loginInfo */
	@RequestMapping("isIdPwSame")
	public String isIdPwSame(MemberDTO mdto) throws Exception{
		if(mservice.isIdPwSame(mdto)) {
			MemberDTO loginInfo = mservice.loginInfo(mdto);
			session.setAttribute("loginInfo",loginInfo);
			return "/index";
		}else {
			System.out.println("로그인 실패");
			return "/index";
		}
	}
	
	/* 로그아웃 */
	@RequestMapping("logout")	
	public String logout() throws Exception{
		session.invalidate();
		return "/member/login";
	}
	
	
	
	
	
	
	
	
	
	
	
}
