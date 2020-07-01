package kh.pingpong.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	private HttpSession session;
	
	@Autowired
	private FileController fcon;
	
	@Autowired
	private MemberService mservice;
	

	/* 회원가입 jsp로 이동 */
	@RequestMapping("join")
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
		return "member/join";			
	}	
	
	/* 회원가입 */
	@RequestMapping("joinProc")
	public String signupProc(MemberDTO mdto, FileDTO fdto) throws Exception{
		
		//회원 파일 하나 저장
		String realPath = session.getServletContext().getRealPath("upload/member/" + mdto.getId() + "/");
		fdto = fcon.fileOneInsert(mdto, fdto, realPath);
		int result = mservice.memberInsert(mdto, fdto);		
		
		return "redirect:/member/memberComplete";
	}
	
	/* 회원가입 - 아이디 중복 */
	@ResponseBody
	@RequestMapping("duplcheckId")
	public String duplcheckId(MemberDTO mdto) throws Exception{	
		Boolean result = mservice.duplcheckId(mdto);
		return Boolean.toString(result);
	}
	
	/*마이페이지 jsp로 이동*/
	@RequestMapping("memberComplete")
	public String memberComplete() throws Exception{
		return "/member/memberComplete";
	}
	
	/*마이페이지*/
	@RequestMapping("myInfo")
	public String myInfo(Model model) throws Exception{
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		MemberDTO mdto = mservice.memberSelect(loginInfo);
		model.addAttribute("mdto",mdto);
		return "/member/mypage";
	}

	/*마이페이지 수정 jsp로 이동*/
	@RequestMapping("myInfoModify")
	public String myInfoModify() throws Exception{
		return "/member/myInfoModify";
	}
	
	/* login jsp로 이동 */
	@RequestMapping("login")	
	public String login() throws Exception{
		return "/member/login";
	}		
	
	/* 로그인 - 아디 비번체크 + loginInfo */
	@ResponseBody
	@RequestMapping("isIdPwSame")
	public String isIdPwSame(MemberDTO mdto) throws Exception{
		Boolean result = mservice.isIdPwSame(mdto);
		if(result) {
			MemberDTO loginInfo = mservice.loginInfo(mdto);		
			session.setAttribute("loginInfo",loginInfo);				
			return result.toString();
		}else {
			return result.toString();
		}
	}
	
	/* 로그아웃 */
	@RequestMapping("logout")	
	public String logout() throws Exception{
		session.invalidate();
		return "/member/login";
	}
	
	/* 아이디 찾기 jsp로 이동*/
	@RequestMapping("idFind")
	public String idFind() throws Exception{		
		return "";
	}
	
	/* 비밀번호 찾기 */
	@RequestMapping("pwFind")
	public String pwFind() throws Exception{
		return "";
	}
	
	/* 이메일 jsp로 이동 */
	@RequestMapping("joinMail")
	public String loginMail() throws Exception{
		return "/member/joinMail";
	}
	
}
