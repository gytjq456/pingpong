package kh.pingpong.controller;

import java.io.IOException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.util.List;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;
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

	/* 비밀번호 암호화 sha 512 */
	public String getSHA512(String input) {
		String toReturn = null;
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-512");
			// SHA-256는 MessageDigest digest = MessageDigest.getInstance("SHA-256");
			digest.reset();
			digest.update(input.getBytes("utf8"));
			toReturn = String.format("%0128x", new BigInteger(1, digest.digest()));
			// SHA-256는 toReturn = String.format("%064x", new BigInteger(1,
			// digest.digest()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return toReturn;
	}

	/* 이메일 발송*/
	public String sendEmail(String userMailSend, HttpServletResponse response) throws ServletException, IOException {		

			// mail server 설정
			String userMail = userMailSend;
			String host = "smtp.naver.com";
			//발송자 : 관리자 이메일
			String user = "gptjs1124@naver.com"; // 자신의 네이버 계정
			String password = "gpffh_5125";// 자신의 네이버 패스워드

			// 메일 받을 주소			
			String to_email = userMail;

			// SMTP 서버 정보를 설정한다.
			Properties props = new Properties();
			props.put("mail.smtp.host", host);
			props.put("mail.smtp.port", 465);
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.ssl.enable", "true");

			// 인증 번호 생성기
			StringBuffer temp = new StringBuffer();
			Random rnd = new Random();
			for (int i = 0; i < 10; i++) {
				int rIndex = rnd.nextInt(3);
				switch (rIndex) {
				case 0:
					// a-z
					temp.append((char) ((int) (rnd.nextInt(26)) + 97));
					break;
				case 1:
					// A-Z
					temp.append((char) ((int) (rnd.nextInt(26)) + 65));

					break;
				case 2:
					// 0-9
					temp.append((rnd.nextInt(10)));
					break;
				}
			}
			String AuthenticationKey = temp.toString();

			// session 생성
			Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(user, password);
				}
			});

			// email 전송
			
			try {
				MimeMessage msg = new MimeMessage(session);
				msg.setFrom(new InternetAddress(user, "pingpong"));
				msg.setFrom(new InternetAddress(user));
				msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to_email));

				// 메일 제목
				msg.setSubject("안녕하세요. pingpong 인증 메일입니다.");
				// 메일 내용
				msg.setText("인증 번호는 :" + temp);
				Transport.send(msg);
				
			} catch (Exception e) {
				e.printStackTrace();// TODO: handle exception
			}
			
			return AuthenticationKey;
		}

	/* 회원가입 jsp로 이동 */
	@RequestMapping("join")
	public String signup(Model model, String mail) throws Exception {
		model.addAttribute("mail",mail);
		
		// 은행
		List<BankDTO> bankList = mservice.bankList();
		model.addAttribute("bankList", bankList);

		// 나라
		List<CountryDTO> countryList = mservice.countryList();
		model.addAttribute("countryList", countryList);

		// 언어
		List<LanguageDTO> lanList = mservice.lanList();
		model.addAttribute("lanList", lanList);

		// 취미
		List<HobbyDTO> hobbyList = mservice.hobbyList();
		model.addAttribute("hobbyList", hobbyList);		
		return "member/join";
	}
	
	/* 이메일 jsp */
	@RequestMapping("joinMail")
	public String loginMail() throws Exception {
		return "/member/joinMail";
	}
	
	/* 이메일 인증 번호 */	
	@ResponseBody
	@RequestMapping("joinSendMail")
	public String joinSendMail(String userMailSend, HttpServletResponse response) throws Exception{
		String result = this.sendEmail(userMailSend, response);
		System.out.println(result +" :: 인증번호");
		return result;
	}

	/* 회원가입 */
	@RequestMapping("joinProc")
	public String signupProc(MemberDTO mdto, FileDTO fdto) throws Exception {
		mdto.setPw(this.getSHA512(mdto.getPw()));
		// 회원 파일 하나 저장
		String realPath = session.getServletContext().getRealPath("upload/member/" + mdto.getId() + "/");
		fdto = fcon.fileOneInsert(mdto, fdto, realPath);
		int result = mservice.memberInsert(mdto, fdto);

		return "redirect:/member/memberComplete";
	}

	/* 회원가입 - 아이디 중복 */
	@ResponseBody
	@RequestMapping("duplcheckId")
	public String duplcheckId(MemberDTO mdto) throws Exception {
		mdto.setPw(this.getSHA512(mdto.getPw()));
		Boolean result = mservice.duplcheckId(mdto);
		return Boolean.toString(result);
	}

	/* 마이페이지 jsp */
	@RequestMapping("memberComplete")
	public String memberComplete() throws Exception {
		return "/member/memberComplete";
	}

	/* 마이페이지 */
	@RequestMapping("myInfo")
	public String myInfo(Model model) throws Exception {
		MemberDTO loginInfo = (MemberDTO) session.getAttribute("loginInfo");
		MemberDTO mdto = mservice.memberSelect(loginInfo);
		model.addAttribute("mdto", mdto);
		return "/member/mypage";
	}

	/* 마이페이지 수정 jsp */
	@RequestMapping("myInfoModify")
	public String myInfoModify() throws Exception {
		return "/member/myInfoModify";
	}

	/* login jsp */
	@RequestMapping("login")
	public String login() throws Exception {
		return "/member/login";
	}

	/* 로그인 - 아디 비번체크 + loginInfo */
	@ResponseBody
	@RequestMapping("isIdPwSame")
	public String isIdPwSame(MemberDTO mdto) throws Exception{
		mdto.setPw(this.getSHA512(mdto.getPw()));
		Boolean result = mservice.isIdPwSame(mdto);
		System.out.println("잉?? :: " + result);
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
	public String logout() throws Exception {
		session.invalidate();
		return "/member/login";
	}

	/* 아이디 찾기 jsp로 이동*/
	@RequestMapping("idFind")
	public String idFind() throws Exception{		
		return "/member/idFind";
	}
	
	/* 아이디 찾기  */
	@ResponseBody
	@RequestMapping("idFindProc")
	public String idFindProc(MemberDTO mdto) throws Exception{
		List<MemberDTO> mlist = mservice.idFindProc(mdto);		
		return Integer.toString(mlist.size());
	}
	
	/* 아이디 결과 jsp */
	@RequestMapping("idResult")
	public String idResult(MemberDTO mdto, Model model) throws Exception{
		System.out.println(mdto.getEmail() + " ::이메일 나오는 것");
		List<MemberDTO> mlist = mservice.idFindProc(mdto);
		model.addAttribute("mlist",mlist);
		return "/member/idResult";
	}
	
	/* 비밀번호 찾기  jsp 이동*/
	@RequestMapping("pwFind")
	public String pwFind() throws Exception{
		return "/member/pwFind";
	}
	
	/* 비번 찾기  */	
	@ResponseBody
	@RequestMapping(value="pwFindProc")
	public String pwFindProc(MemberDTO mdto) throws Exception{
		System.out.println(mdto.getName() + "   :: 이름");
		System.out.println(mdto.getEmail() + "   :: 이메일");
		System.out.println(mdto.getId() + "   :: 아이디");
		int result = mservice.pwFindProc(mdto);		
		return Integer.toString(result);
	}
	
	/* 비번 수정 jsp */	
	@RequestMapping("pwModify")
	public String pwModify(MemberDTO mdto, Model modle) throws Exception{			
		modle.addAttribute("mdto",mdto);
		return "/member/pwModify";
	}
	
	/* 비번 수정  */	
	@ResponseBody
	@RequestMapping("pwModifyProc")
	public String pwModifyProc(MemberDTO mdto) throws Exception{
		mdto.setPw(this.getSHA512(mdto.getPw()));
		int result = mservice.pwModifyProc(mdto);	
		return Integer.toString(result);
	}
	
	/* 회원탈퇴 */
	@ResponseBody
	@RequestMapping("memWithdrawal")
	public String memWithdrawal(MemberDTO mdto) throws Exception{
		mdto = (MemberDTO)session.getAttribute("loginInfo");
		System.out.println(mdto.getSysname() + " :: 파일 이름 ");
		int result = mservice.memWithdrawal(mdto);
		session.invalidate();
		return Integer.toString(result);
	}
	
}















