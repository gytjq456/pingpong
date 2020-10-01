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

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.scribejava.core.model.OAuth2AccessToken;

import kh.pingpong.controller.NaverLoginBO;

import kh.pingpong.admin.AdminService;
import kh.pingpong.config.Configuration;
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
	
	@Autowired
	private AdminService aservice;
	
	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;
	
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}

	/* 비밀번호 암호화 sha 512 */
	public String getSHA512(String input) {
		String toReturn = null;
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			digest.reset();
			digest.update(input.getBytes("utf8"));
			toReturn = String.format("%064x", new BigInteger(1, digest.digest()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return toReturn;
	}

	/* 이메일 발송 */
	public String sendEmail(String userMailSend, HttpServletResponse response) throws ServletException, IOException {
		
		// mail server 설정
		String userMail = userMailSend;
		String host = "smtp.naver.com";
		// 발송자 : 관리자 이메일
		String user = "gptjs1124@naver.com"; // 자신의 네이버 계정
		String password = "gpffh^5125";// 자신의 네이버 패스워드

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
		Configuration.emailKey = AuthenticationKey;
		//Configuration.emailKey = "Y12385**";

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
			msg.setSubject("Welecome to pingpong email.");
			// 메일 내용
			msg.setText("Put this code :" + temp);
			Transport.send(msg);

		} catch (Exception e) {
			e.printStackTrace();// TODO: handle exception
		}

		return AuthenticationKey;
	}

	/* 회원가입 jsp로 이동 */
	@RequestMapping("join")
	public String signup(Model model, String mail, String ck) throws Exception {
		if(ck.contentEquals(Configuration.emailKey)) {
			model.addAttribute("mail", mail);
	
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
		}else {
			return "/member/login";
		}
	}

	/* 이메일 jsp */
	@RequestMapping("joinMail")
	public String loginMail() throws Exception {
		return "/member/joinMail";
	}

	/* 이메일 인증 번호 */
	@ResponseBody
	@RequestMapping("joinSendMail")
	public String joinSendMail(String userMailSend, HttpServletResponse response) throws Exception {
		String result = this.sendEmail(userMailSend, response);
		System.out.println(result + " :: 인증번호");
		return result;
	}

	/* 회원가입 */
	@RequestMapping("joinProc")
	public String signupProc(MemberDTO mdto, FileDTO fdto) throws Exception {
		mdto.setPw(this.getSHA512(mdto.getPw()));
		// 회원 파일 하나 저장
		String realPath = session.getServletContext().getRealPath("upload/member/" + mdto.getId() + "/");
		fdto = fcon.fileOneInsert(mdto, fdto, realPath);
		mservice.memberInsert(mdto, fdto);

		return "redirect:/";
	}

	/* 회원가입 - 아이디 중복 */
	@ResponseBody
	@RequestMapping("duplcheckId")
	public String duplcheckId(MemberDTO mdto) throws Exception {
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

	/* 로그인 jsp */
	@RequestMapping("login")
	public String login(Model model) throws Exception {
		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		//https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
		//redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
		System.out.println("네이버:" + naverAuthUrl);
		//네이버
		model.addAttribute("url", naverAuthUrl);
		return "/member/login";
	}
	
	//네이버 로그인 성공시 callback호출 메소드
	@RequestMapping("callback")
	public String callback(Model model, @RequestParam String code, @RequestParam String state) throws IOException, ParseException {
		System.out.println("여기는 callback");
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		//1. 로그인 사용자 정보를 읽어온다.
		apiResult = naverLoginBO.getUserProfile(oauthToken); //String형식의 json데이터
		/** apiResult json 구조
		{"resultcode":"00",
		"message":"success",
		"response":{"id":"33666449","nickname":"shinn****","age":"20-29","gender":"M","email":"sh@naver.com","name":"\uc2e0\ubc94\ud638"}}
		**/
		System.out.println("apiResult 값 " + apiResult);
			
		//2. String형식인 apiResult를 json형태로 바꿈
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;
		System.out.println("jsonObj 값 " + jsonObj);
			
		//3. 데이터 파싱
		//Top레벨 단계 _response 파싱
		JSONObject response_obj = (JSONObject)jsonObj.get("response");
		System.out.println("response_obj 값 " + response_obj);
		System.out.println("아이디값 값 " + response_obj.get("id"));
			
		//response의 id값 파싱
		String id = (String)response_obj.get("id");
		String name = (String)response_obj.get("name");
		String age = (String)response_obj.get("age");
		String gender = (String)response_obj.get("gender");
		String email = (String)response_obj.get("email");
		
		
		//4.파싱 닉네임 세션으로 저장
		session.setAttribute("sessionId",id); //세션 생성
		model.addAttribute("result", apiResult);
		model.addAttribute("mem_type", "naver");
		model.addAttribute("id", id);
		model.addAttribute("name", name);
		model.addAttribute("age", age);
		model.addAttribute("gender", gender);
		model.addAttribute("email", email);
		
		return "/member/naverSingUp";
	}

	/* 로그인 - 아디 비번체크 + loginInfo */
	@ResponseBody
	@RequestMapping("isIdPwSame")
	public String isIdPwSame(MemberDTO mdto) throws Exception {
		mdto.setPw(this.getSHA512(mdto.getPw()));
		Boolean resultB = mservice.isIdPwSame(mdto);
		String result = "";
		if (resultB) {
			boolean isBlacklist = aservice.isBlacklist(mdto.getId());
			
			if (isBlacklist) {
				result = "black";
			} else {
				MemberDTO loginInfo = mservice.loginInfo(mdto);
				session.setAttribute("loginInfo", loginInfo);
				result = "true";
			}
		} else {
			result = "false";
		}
		return result;
	}
	
	/* 카카오 블랙리스트 확인 */
	@ResponseBody
	@RequestMapping("isBlackForKakao")
	public boolean isBlackForKakao(String id) throws Exception {
		return aservice.isBlacklist(id);
	}

	/* 로그아웃 */
	@RequestMapping("logout")
	public String logout() throws Exception {
		session.invalidate();
		return "/member/login";
	}

	/* 아이디 찾기 jsp로 이동 */
	@RequestMapping("idFind")
	public String idFind() throws Exception {
		return "/member/idFind";
	}

	/* 아이디 찾기 */
	@ResponseBody
	@RequestMapping("idFindProc")
	public String idFindProc(MemberDTO mdto) throws Exception {
		List<MemberDTO> mlist = mservice.idFindProc(mdto);
		return Integer.toString(mlist.size());
	}

	/* 아이디 결과 jsp */
	@RequestMapping("idResult")
	public String idResult(MemberDTO mdto, Model model) throws Exception {
		System.out.println(mdto.getEmail() + " ::이메일 나오는 것");
		List<MemberDTO> mlist = mservice.idFindProc(mdto);
		model.addAttribute("mlist", mlist);
		return "/member/idResult";
	}

	/* 비밀번호 찾기 jsp 이동 */
	@RequestMapping("pwFind")
	public String pwFind() throws Exception {
		return "/member/pwFind";
	}

	/* 비번 찾기 */
	@ResponseBody
	@RequestMapping("pwFindProc")
	public String pwFindProc(MemberDTO mdto) throws Exception {
		System.out.println(mdto.getName() + "   :: 이름");
		System.out.println(mdto.getEmail() + "   :: 이메일");
		System.out.println(mdto.getId() + "   :: 아이디");
		int result = mservice.pwFindProc(mdto);
		return Integer.toString(result);
	}

	/* 비번 수정 jsp */
	@RequestMapping("pwModify")
	public String pwModify(MemberDTO mdto, Model modle) throws Exception {
		modle.addAttribute("mdto", mdto);
		return "/member/pwModify";
	}

	/* 비번 수정 */
	@ResponseBody
	@RequestMapping("pwModifyProc")
	public String pwModifyProc(MemberDTO mdto) throws Exception {
		mdto.setPw(this.getSHA512(mdto.getPw()));
		int result = mservice.pwModifyProc(mdto);
		return Integer.toString(result);
	}

	/* 회원탈퇴 */
	@ResponseBody
	@RequestMapping("memWithdrawal")
	public String memWithdrawal() throws Exception {
		MemberDTO mdto = (MemberDTO) session.getAttribute("loginInfo");
		int result = mservice.memWithdrawal(mdto);
		session.invalidate();
		return Integer.toString(result);
	}

	/* 마이페이지 수정 jsp */
	@RequestMapping("myInfoModify")
	public String myInfoModify(MemberDTO mdto, Model model) throws Exception {
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
		
		model.addAttribute("mdto", mdto);
		
		return "/member/myInfoModify";
	}

	/* :::: 회원정보 수정 :::: */
	/* 전화번호 */
	@ResponseBody
	@RequestMapping("myInfoMoPhone")
	public String myInfoMoPhone(MemberDTO mdto) throws Exception {
		MemberDTO loginMdto = (MemberDTO) session.getAttribute("loginInfo");
		mdto.setId(loginMdto.getId());

		System.out.println(mdto.getPhone());
		System.out.println(mdto.getPhone_country());
		System.out.println(mdto.getId());

		int result = mservice.myInfoMoPhone(mdto);

		// 세션값 다시 불러오기
		MemberDTO loginInfo = mservice.loginInfo(mdto);
		session.setAttribute("loginInfo", loginInfo);

		return Integer.toString(result);
	}

	/* 주소 */
	@ResponseBody
	@RequestMapping("myInfoMoAddress")
	public String myInfoMoAddress(MemberDTO mdto) throws Exception {
		MemberDTO loginMdto = (MemberDTO) session.getAttribute("loginInfo");
		mdto.setId(loginMdto.getId());

		int result = mservice.myInfoMoAddress(mdto);

		// 세션값 다시 불러오기
		MemberDTO loginInfo = mservice.loginInfo(mdto);
		session.setAttribute("loginInfo", loginInfo);

		return Integer.toString(result);
	}

	/* 은행 */
	@ResponseBody
	@RequestMapping("myInfoMobank")
	public String myInfoMobank(MemberDTO mdto) throws Exception {
		MemberDTO loginMdto = (MemberDTO) session.getAttribute("loginInfo");
		mdto.setId(loginMdto.getId());

		int result = mservice.myInfoMobank(mdto);

		// 세션값 다시 불러오기
		MemberDTO loginInfo = mservice.loginInfo(mdto);
		session.setAttribute("loginInfo", loginInfo);

		return Integer.toString(result);
	}

	/* 프로필 */
	@ResponseBody
	@RequestMapping("myInfoProfile")
	public String myInfoProfile(MemberDTO mdto, FileDTO fdto) throws Exception {
		System.out.println(mdto.getProfile().getName());
		MemberDTO loginMdto = (MemberDTO) session.getAttribute("loginInfo");
		mdto.setId(loginMdto.getId());
		mdto.setSysname(loginMdto.getSysname());

		// 회원 파일 하나 저장
		String realPath = session.getServletContext().getRealPath("upload/member/" + mdto.getId() + "/");
		fdto = fcon.fileOneInsert(mdto, fdto, realPath);
		int result = mservice.myInfoProfile(mdto, fdto);

		// 세션값 다시 불러오기
		MemberDTO loginInfo = mservice.loginInfo(mdto);
		session.setAttribute("loginInfo", loginInfo);

		return Integer.toString(result);
	}

	/* 나라 */
	@ResponseBody
	@RequestMapping("myInfoCountry")
	public String myInfoCountry(MemberDTO mdto) throws Exception {
		MemberDTO loginMdto = (MemberDTO) session.getAttribute("loginInfo");
		mdto.setId(loginMdto.getId());

		int result = mservice.myInfoCountry(mdto);

		// 세션값 다시 불러오기
		MemberDTO loginInfo = mservice.loginInfo(mdto);
		session.setAttribute("loginInfo", loginInfo);

		return Integer.toString(result);
	}

	/* 구사 언어 */
	@ResponseBody
	@RequestMapping("myInfoLang_can")
	public String myInfoLang_can(@RequestParam(value = "langArrayA[]") List<String> lang_can, MemberDTO mdto)
			throws Exception {

		StringBuilder sb = new StringBuilder();
		int size = lang_can.size();
		System.out.println(size);

		int count = 0;
		for (String a : lang_can) {
			sb.append(a);
			if (count < lang_can.size() - 1) {
				sb.append(",");
			}
			count++;
		}

		MemberDTO loginMdto = (MemberDTO) session.getAttribute("loginInfo");
		mdto.setId(loginMdto.getId());
		mdto.setLang_can(sb.toString());

		int result = mservice.myInfoLang_can(mdto);

		// 세션값 다시 불러오기
		MemberDTO loginInfo = mservice.loginInfo(mdto);
		session.setAttribute("loginInfo", loginInfo);

		return Integer.toString(result);
	}

	/* 배우고 싶은 언어 */
	@ResponseBody
	@RequestMapping("myInfoLang_learn")
	public String myInfoLang_learn(@RequestParam(value = "langArrayA[]") List<String> lang_learn, MemberDTO mdto)
			throws Exception {

		StringBuilder sb = new StringBuilder();
		int size = lang_learn.size();
		System.out.println(size);

		int count = 0;
		for (String a : lang_learn) {
			sb.append(a);
			if (count < lang_learn.size() - 1) {
				sb.append(",");
			}
			count++;
		}

		MemberDTO loginMdto = (MemberDTO) session.getAttribute("loginInfo");
		mdto.setId(loginMdto.getId());
		mdto.setLang_learn(sb.toString());

		int result = mservice.myInfoLang_learn(mdto);

		// 세션값 다시 불러오기
		MemberDTO loginInfo = mservice.loginInfo(mdto);
		session.setAttribute("loginInfo", loginInfo);

		return Integer.toString(result);
	}

	/* 취미 */
	@ResponseBody
	@RequestMapping("myInfoHobby")
	public String myInfoHobby(@RequestParam(value = "hobbyArrayA[]") List<String> hobby, MemberDTO mdto)
			throws Exception {

		StringBuilder sb = new StringBuilder();
		int size = hobby.size();
		int count = 0;
		for (String a : hobby) {
			sb.append(a);
			if (count < size - 1) {
				sb.append(",");
			}
			count++;
		}

		MemberDTO loginMdto = (MemberDTO) session.getAttribute("loginInfo");
		mdto.setId(loginMdto.getId());
		mdto.setHobby(sb.toString());

		int result = mservice.myInfoHobby(mdto);

		// 세션값 다시 불러오기
		MemberDTO loginInfo = mservice.loginInfo(mdto);
		session.setAttribute("loginInfo", loginInfo);

		return Integer.toString(result);
	}

	/* introduce */
	@ResponseBody
	@RequestMapping("myInfoIntroduce")
	public String myInfoIntroduce(MemberDTO mdto) throws Exception {
		MemberDTO loginMdto = (MemberDTO) session.getAttribute("loginInfo");
		mdto.setId(loginMdto.getId());

		int result = mservice.myInfoIntroduce(mdto);

		// 세션값 다시 불러오기
		MemberDTO loginInfo = mservice.loginInfo(mdto);
		session.setAttribute("loginInfo", loginInfo);

		return Integer.toString(result);
	}

	/* sns jsp */
	@RequestMapping("snsSignUp")
	public String snsSignUp(String mem_type, String kakaoId, String kakaoNickname, String kakaoEmail, String kakaoProfile, String pw, Model model) throws Exception {
		System.out.println(kakaoProfile + "  profile");
		
		MemberDTO mdto = new MemberDTO();
		mdto.setId(kakaoId);
		mdto.setPw(pw);
		Boolean result = mservice.isIdPwSame(mdto);
		if (result) {
			System.out.println("로그인 되는 곳");
			MemberDTO loginInfo = mservice.loginInfo(mdto);
			session.setAttribute("loginInfo", loginInfo);
			return "redirect:/";
			
		} else {
			System.out.println("로그인 안되는 것");
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

			mdto.setMem_type(mem_type);
			mdto.setId(kakaoId);
			mdto.setName(kakaoNickname);
			mdto.setEmail(kakaoEmail);
			mdto.setPw(pw);
			mdto.setSysname(kakaoProfile);
			model.addAttribute("mdto", mdto);

			return "/member/snsSignUp";
		}

	}

	/* sns로그인 - 카카오 회원가입 */
	@RequestMapping("snsSingUpProc")
	public String snsNSingUpProc(MemberDTO mdto, FileDTO fdto) throws Exception {
		System.out.println(mdto.getProfile() + " 첨부파일로 들어갔을 때 히힛");
		System.out.println(mdto.getSysname() + " 카카오 프로필이 있는 경우 히힛");
		
		System.out.println("컨트롤러로 들어왔나?");
		if(mdto.getProfile() != null) {
			// 회원 파일 하나 저장
			String realPath = session.getServletContext().getRealPath("upload/member/" + mdto.getId() + "/");
			fdto = fcon.fileOneInsert(mdto, fdto, realPath);
		}
		
		mservice.memberInsertSns(mdto, fdto);
		return "redirect:/";
	}
	
	/* Naver login */
	/* sns jsp */
	@RequestMapping("snsNaverSignUp")
	public String snsNaverSignUp(String mem_type, String kakaoId, String kakaoNickname, String kakaoEmail, String kakaoProfile, String pw, Model model) throws Exception {
		System.out.println(kakaoProfile + "  profile");
		
		MemberDTO mdto = new MemberDTO();
		mdto.setId(kakaoId);
		mdto.setPw(pw);
		Boolean result = mservice.isIdPwSame(mdto);
		if (result) {
			System.out.println("로그인 되는 곳");
			MemberDTO loginInfo = mservice.loginInfo(mdto);
			session.setAttribute("loginInfo", loginInfo);
			return "redirect:/";
			
		} else {
			System.out.println("로그인 안되는 것");
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

			mdto.setMem_type(mem_type);
			mdto.setId(kakaoId);
			mdto.setName(kakaoNickname);
			mdto.setEmail(kakaoEmail);
			mdto.setPw(pw);
			mdto.setSysname(kakaoProfile);
			model.addAttribute("mdto", mdto);

			return "/member/snsSignUp";
		}

	}

	
	// 파트너 / 튜터 목록 가져오기 //
	@ResponseBody
	@RequestMapping("personList")
	public List<MemberDTO> personList(String type) throws Exception{
		List<MemberDTO> personList = mservice.personList(type);
		return personList;
	}
	

}
