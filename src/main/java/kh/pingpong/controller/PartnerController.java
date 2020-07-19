package kh.pingpong.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kh.pingpong.dto.HobbyDTO;
import kh.pingpong.dto.JjimDTO;
import kh.pingpong.dto.LanguageDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.PartnerDTO;
import kh.pingpong.dto.ReportListDTO;
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


	private boolean mail(HttpServletRequest request,HttpServletResponse response, String pemail) {
		Boolean result = false;
		
		String setfrom = request.getParameter("memail");
		String email = request.getParameter("email"); // 받는 사람 이메일
		String subject = request.getParameter("subject"); // 제목
		String contents = request.getParameter("contents"); // 내용
		
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message,
					true, "UTF-8");
			
			messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
			messageHelper.setTo(pemail); // 받는사람 이메일
			messageHelper.setSubject("[PINGPONG]"+setfrom + "님이 보낸 메일입니다."); // 메일제목은 생략이 가능하다
			messageHelper.setText(contents); // 메일 내용 
	
			mailSender.send(message);
			return true;
		} catch (Exception e) {
			System.out.println(e);
		}

		return result;
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
	@ResponseBody
	@RequestMapping("send")
	public String send(PartnerDTO pdto, MemberDTO mdto,  Model model, HttpServletRequest request, HttpServletResponse response) throws Exception{
		System.out.println("================== test ================");
		System.out.println(pdto.getEmail());
		boolean result = this.mail(request, response, pdto.getEmail());
		System.out.println("in send: " + result);	
		//return "redirect:/partner/partnerList";
		return String.valueOf(result);
	}

	//파트너 목록 페이지
	@RequestMapping("partnerList")
	public String partnerList(String align,HttpServletRequest request, Model model,Map<String,Object> search) throws Exception{
		int cpage = 1;
		try {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}catch(Exception e) {}
		//List<PartnerDTO> plist = pservice.partnerList(cpage);
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		List<HobbyDTO> hdto = pservice.selectHobby();
		List<LanguageDTO> ldto = pservice.selectLanguage();
		List<PartnerDTO> alist = pservice.searchAlign(cpage,align);
		String navi = pservice.getPageNavi(cpage,align,search);

		model.addAttribute("loginInfo", loginInfo);
		model.addAttribute("navi", navi);
		model.addAttribute("hdto", hdto);
		model.addAttribute("ldto", ldto);
		model.addAttribute("align", align);
		model.addAttribute("alist", alist);

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
		String id = loginInfo.getId();
		PartnerDTO pdto = pservice.selectBySeq(seq);

		Map<Object, Object> param = new HashMap<>();
		param.put("id", id);
		param.put("parent_seq", seq);

		JjimDTO jdto = new JjimDTO();
		jdto.setId(id);
		jdto.setParent_seq(seq);

		boolean checkJjim = pservice.selectJjim(jdto);
		System.out.println(checkJjim);
		model.addAttribute("checkJjim",checkJjim);
		model.addAttribute("pdto", pdto);
		System.out.println("리뷰 포="+ pdto.getReview_point());

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
		Map<String, Object> insertP = new HashMap<>();
		insertP.put("mdto", mdto);
		insertP.put("contact", contact);	
		pservice.partnerInsert(insertP,mdto);

		if (loginInfo.getId().contentEquals(mdto.getId()) ) {
			MemberDTO mbdto = pservice.selectMember(loginInfo.getId());
			session.setAttribute("loginInfo", mbdto);
		}		

		return "redirect:/partner/partnerList?align=recent";
	}

	//파트너 삭제
	@RequestMapping("deletePartner")
	public String deletePartner(Model model, String id) throws Exception{
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		pservice.deletePartner(loginInfo);
		//model.addAttribute(attributeName, attributeValue)

		if (loginInfo.getId().contentEquals(id) ) {
			MemberDTO mbdto = pservice.selectMember(loginInfo.getId());
			session.setAttribute("loginInfo", mbdto);
		}	
		return "redirect:/partner/partnerList?align=recent";
	}

	//상세 검색
	@RequestMapping("partnerSearch")
	public String search(String align,PartnerDTO pdto, HttpServletRequest request, Model model) throws Exception{
		int cpage = 1;
		try {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}catch(Exception e) {}

		Map<String, Object> search = new HashMap<>();	
		List<PartnerDTO> alist = pservice.search(cpage, search, pdto);
		String navi = pservice.getPageNavi(cpage,align,search);
		List<HobbyDTO> hdto = pservice.selectHobby();
		List<LanguageDTO> ldto = pservice.selectLanguage();
		//List<PartnerDTO> alist = pservice.searchAlign(align);
		model.addAttribute("alist", alist);
		//model.addAttribute("plist", plist);
		model.addAttribute("navi", navi);
		model.addAttribute("hdto", hdto);
		model.addAttribute("ldto", ldto);
		model.addAttribute("align", align);

		return "/partner/partnerList";
	}

	//파트너 신고
	@RequestMapping("report")
	@ResponseBody
	public int report(ReportListDTO rldto, Model model) {
		MemberDTO mdto = (MemberDTO)session.getAttribute("loginInfo");
		rldto.setReporter(mdto.getId());

		int result = pservice.selectReport(rldto);
		model.addAttribute("rldto", rldto);

		return result;
	}

	@RequestMapping("reportProc")
	public String reportProc(ReportListDTO rldto, Model model) {
		System.out.println("rldto =" + rldto.getSeq());
		pservice.insertReport(rldto);
		return "redirect:/partner/partnerView?seq=" + rldto.getParent_seq();
	}

	//리뷰 글쓰기
	@RequestMapping("reviewWrite")
	@ResponseBody
	public String reviewWrite(ReviewDTO redto,MemberDTO mdto) throws Exception{

		int result = gservice.reviewWrite(redto);
		session.setAttribute("loginInfo2", mdto);
		if(result>0) {
			return String.valueOf(true);
		}else {
			return String.valueOf(false);
		}
	}


	//찜하기
	@RequestMapping("jjim")
	@ResponseBody
	public int partnerInsertJjim(JjimDTO jdto) {
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		String id = loginInfo.getId();

		jdto.setId(id);

		int result = pservice.insertJjim(jdto);
		return result;
	}


	@RequestMapping("delJjim")
	@ResponseBody
	public int groupDeleteJjim(JjimDTO jdto) {
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		String id = loginInfo.getId();

		jdto.setId(id);

		int result = pservice.deleteJjim(jdto);
		return result;
	}

	//최신순, 평점순
	@RequestMapping("align")
	public String align(HttpServletRequest request, Model model, int cpage) throws Exception{
		String alignType = request.getParameter("align");
		List<PartnerDTO> alist = pservice.searchAlign(cpage,alignType);
		System.out.println(alignType);
		model.addAttribute("align", alignType);
		model.addAttribute("alist", alist);
		return "/partner/partnerList";
	}


}

