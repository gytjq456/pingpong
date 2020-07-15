package kh.pingpong.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.Message.RecipientType;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kh.pingpong.dto.HobbyDTO;
import kh.pingpong.dto.LanguageDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.PartnerDTO;
import kh.pingpong.dto.ReviewDTO;
import kh.pingpong.service.GroupService;
import kh.pingpong.service.MemberService;
import kh.pingpong.service.PartnerService;

@Controller
@RequestMapping("/partner/")
public class PartnerController {

	@Autowired
	private PartnerService pservice;

	@Autowired
	private MemberService mservice;

	@Autowired
	private GroupService gservice;

	@Autowired
	private HttpSession session;

	@Autowired
	JavaMailSender mailSender;

	// 메일 
	private Boolean mail(HttpServletRequest request, HttpServletResponse response, String pemail, String memail, String emailPassword) {
		Boolean result = false;
		String uri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String cmd = uri.substring(contextPath.length());

		//mail server 설정
		//String userMail = request.getParameter("mailId");
		String host = "smtp.naver.com";
		String user = memail; //자신의 네이버 계정
		String password = emailPassword;// 자신의 패스워드
		System.out.println("host : " + host);
		System.out.println("user : " + user);
		System.out.println("password : " + password);

		//메일 받을 주소
		String to_email = pemail;
		
		//SMTP 서버 정보를 설정한다.
		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", 465);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");


		//session 생성
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});

		//email 전송
		try {
			MimeMessage msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(user, "tt"));
			msg.setFrom(new InternetAddress(user));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to_email));

			//메일 제목
			msg.setSubject(memail+"님이 보낸 메일입니다.");
			//메일 내용
			Transport.send(msg);
			System.out.println("메시지를 성공적으로 보냈습니다.");   
			return !result;
		}catch (Exception e) {
			return result;
		}
	}

	//이메일 작성(일단 여기까지는 넘어감)
	@RequestMapping("selectPartnerEmail")
	public String selectPartnerEmail(int seq, Model model) throws Exception{
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		PartnerDTO pdto = pservice.selectBySeq(seq);
		model.addAttribute("pdto", pdto);
		model.addAttribute("loginInfo", loginInfo);
		return "email/write";
	}
	//이메일 보내기
	@RequestMapping("send")
	public String send(@ModelAttribute PartnerDTO pdto, MemberDTO mdto,  Model model, HttpServletRequest request, HttpServletResponse response) throws Exception{
		System.out.println(pdto.getEmail());
		Boolean result = this.mail(request, response, pdto.getEmail(), mdto.getMemail(), mdto.getEmailPassword());
		System.out.println(result);	
		return "redirect:/partner/partnerList";
	}

	//파트너 목록 페이지
	@RequestMapping("partnerList")
	public String partnerList(HttpServletRequest request, Model model) throws Exception{
		int cpage = 1;
		try {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}catch(Exception e) {}

		List<PartnerDTO> plist = pservice.partnerList(cpage);
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		String navi = pservice.getPageNavi(cpage);
		List<HobbyDTO> hdto = pservice.selectHobby();
		List<LanguageDTO> ldto = pservice.selectLanguage();
		model.addAttribute("loginInfo", loginInfo);
		model.addAttribute("plist", plist);
		model.addAttribute("navi", navi);
		model.addAttribute("hdto", hdto);
		model.addAttribute("ldto", ldto);

		return "partner/partnerList";
	}

	//파트너 상세 뷰페이지
	@ResponseBody
	@RequestMapping("chatPartner")
	public List<PartnerDTO> chatPartner(HttpServletRequest request, Model model) throws Exception{
		List<PartnerDTO> plist = pservice.partnerListAll();
		return plist;
	}

	@Transactional("txManager")
	@RequestMapping("partnerView")
	public String partnerView(int seq, Model model) throws Exception{
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		//String id = loginInfo.getId();
		PartnerDTO pdto = pservice.selectBySeq(seq);
		model.addAttribute("pdto", pdto);

		//리뷰 리스트 출력
		List<ReviewDTO> reviewList = gservice.reviewList(seq);

		model.addAttribute("reviewList", reviewList);
		return "partner/partnerView";
	}

	//멤버 선택 
	@RequestMapping("selectMember")
	public String selectMember(MemberDTO mdto, Model model, HttpServletRequest request) throws Exception{
		//String id = "ddong";
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		mdto = mservice.memberSelect(loginInfo);
		return "partner/partnerList";
	}

	//파트너 등록
	@RequestMapping("insertPartner")
	public String insertPartner(MemberDTO mdto, String contact, Model model) throws Exception{
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		mdto = pservice.selectMember(loginInfo.getId());
		mdto = mservice.memberSelect(loginInfo);
		pservice.updateMemberGrade(mdto);
		Map<String, Object> insertP = new HashMap<>();
		insertP.put("mdto", mdto);
		insertP.put("contact", contact);	
		pservice.partnerInsert(insertP);
		return "redirect:/partner/partnerList";
	}

	//파트너 삭제
	@RequestMapping("deletePartner")
	public String deletePartner(Model model) throws Exception{
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		//PartnerDTO pdto = pservice.selectBySeq(seq)
		pservice.deletePartner(loginInfo);
		//model.addAttribute(attributeName, attributeValue)
		return "redirect:/partner/partnerList";
	}

	//상세 검색
	@RequestMapping("partnerSearch")
	public String search(String orderBy,PartnerDTO pdto, HttpServletRequest request, Model model) throws Exception{
		int cpage = 1;
		try {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}catch(Exception e) {}

		Map<String, Object> search = new HashMap<>();	
		List<PartnerDTO> plist = pservice.search(cpage, search, pdto/* , orderBy */);
		String navi = pservice.getPageNavi(cpage);
		List<HobbyDTO> hdto = pservice.selectHobby();
		List<LanguageDTO> ldto = pservice.selectLanguage();

		model.addAttribute("plist", plist);
		model.addAttribute("navi", navi);
		model.addAttribute("hdto", hdto);
		model.addAttribute("ldto", ldto);
		//model.addAttribute("orderBy",orderBy);

		return "/partner/partnerList";
	}

	//리뷰 글쓰기
	@ResponseBody
	@RequestMapping("reviewWrite")
	public String reviewWrite(ReviewDTO redto) throws Exception{
		int result = gservice.reviewWrite(redto);

		if(result>0) {
			return String.valueOf(true);
		}else {
			return String.valueOf(false);
		}
	}



	//	<aop:config>
	//	<aop:pointcut expression="execution(* kh.pingpong.controller.GroupController.*(..))" id="group"/>
	//	<aop:pointcut expression="execution(* kh.pingpong.controller.PartnerController.*(..))" id="partner"/>
	//	<aop:aspect id="logPrint" ref="logaop">
	//		<aop:around pointcut-ref="group" method="aroundBoardLog"/>
	//		<aop:around pointcut-ref="partner" method="aroundBoardLog"/>
	//	</aop:aspect>
	//	</aop:config>

}

