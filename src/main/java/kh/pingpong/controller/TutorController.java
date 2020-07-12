package kh.pingpong.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.multipart.MultipartFile;

import kh.pingpong.dto.DeleteApplyDTO;
import kh.pingpong.dto.FileDTO;
import kh.pingpong.dto.FilesDTO;
import kh.pingpong.dto.JjimDTO;
import kh.pingpong.dto.LanguageDTO;
import kh.pingpong.dto.LessonDTO;
import kh.pingpong.dto.LikeListDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.ReportListDTO;
import kh.pingpong.dto.ReviewDTO;
import kh.pingpong.dto.TuteeDTO;
import kh.pingpong.dto.TutorAppDTO;
import kh.pingpong.service.GroupService;
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
	
	@Autowired
	private GroupService gservice;
	
	//헤더에서 튜터신청하기 버튼눌렀을때 이미 튜터인지, 냈는지 판별
	@RequestMapping("tutorTrue")
	@ResponseBody
	public String tutorTrue(Model model) throws Exception{
		MemberDTO mdto = (MemberDTO)session.getAttribute("loginInfo");
		String id = mdto.getId();
		String result=null;

		int tutorCheck = tservice.tutorTrue(id);
		
		if(tutorCheck>0) {
			result = tservice.passWhether(id);
		}else {
			return "x";
		}
		return result;
	}
	
	//레슨 신청하기 버튼 눌렀을 때 
	@RequestMapping("lessonApp")
	public String lessonApp(Model model) throws Exception{
		//언어 
		List<LanguageDTO> lanList = mservice.lanList();
		model.addAttribute("lanList",lanList);
		model.addAttribute("loginInfo", session.getAttribute("loginInfo"));
		return "/tutor/lessonApp";
	}
	
	//레슨 신청서 제출
	@RequestMapping("lessonAppProc")
	public String lessonAppProc(Model model, LessonDTO ldto) throws Exception{
		MemberDTO mdto = (MemberDTO)session.getAttribute("loginInfo");
		
		System.out.println(mdto.getId()+":"+mdto.getName() +":"+mdto.getSysname());
		model.addAttribute("loginInfo", session.getAttribute("loginInfo"));
//		System.out.println(ldto.getCurriculum()+":" +ldto.getLanguage()+
//				":"+ldto.getStart_hour()+":"+ldto.getStart_minute()+":"+ldto.getMax_num());
		
		ldto.setId(mdto.getId());
		ldto.setName(mdto.getName());
		ldto.setEmail(mdto.getEmail());
		ldto.setPhone_country(mdto.getPhone_country());
		ldto.setPhone(mdto.getPhone());
		ldto.setSysname(mdto.getSysname());
//		System.out.println(ldto.getId()+":"+ldto.getEmail()+":"+ldto.getName()+
//				":"+ldto.getPhone_country()+":"+ldto.getPhone()+":"+ldto.getLocation());
		
		int result = tservice.lessonAppProc(ldto);
		
		return "redirect: /tutor/lessonList?orderBy=seq";
	}

	//헤더에서 튜터신청 버튼 누르기
	@RequestMapping("tutorApp")
	public String tutorApp(Model model) throws Exception{
		model.addAttribute("loginInfo", session.getAttribute("loginInfo"));
		return "/tutor/tutorApp";
	}
	
	//튜터 신청서 제출하기
	@RequestMapping("tutorAppSend")
	public String tutorAppSend(Model model, TutorAppDTO tadto, MultipartFile[] files) throws Exception{
		//System.out.println(tadto.getId());
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
		
		
		return "/tutor/tutorAppComplete";
	}
	
	//튜터 list
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
		return "/tutor/tutorList";
	}
	
	//강의 list
	@RequestMapping("lessonList")
	public String lessonList(String orderBy,String keywordSelect,HttpServletRequest request, Model model) throws Exception{
		model.addAttribute("loginInfo", session.getAttribute("loginInfo"));
		
		//언어 
		List<LanguageDTO> lanList = mservice.lanList();
		model.addAttribute("lanList",lanList);
		
		int cpage = 1;
        try {
           cpage = Integer.parseInt(request.getParameter("cpage"));
        } catch (Exception e) {}
        
        Map<String, String> param = new HashMap<>();
        param.put("orderBy", orderBy);
        
		String navi = tservice.getPageNavi_lesson(cpage, param);
		model.addAttribute("navi", navi);
		
		List<LessonDTO> lessonlist = tservice.lessonList(cpage, orderBy);
		System.out.println(lessonlist);
		model.addAttribute("lessonlist",lessonlist);
		model.addAttribute("orderBy",orderBy);
		model.addAttribute("keywordSelect", keywordSelect);
		return "/tutor/lessonList";
	}
	
	//모집중, 진행중, 마감 클릭했을때 리스트 새로 뽑기
	@RequestMapping("lessonListPeriod")
	public String lessonListPeriod(String period, String orderBy, String keywordSelect,String keyword, HttpServletRequest request, Model model) throws Exception{
		model.addAttribute("loginInfo", session.getAttribute("loginInfo"));

		//언어 
		List<LanguageDTO> lanList = mservice.lanList();
		model.addAttribute("lanList",lanList);
		
		Map<String,String> param = new HashMap<>();
		param.put("orderBy", orderBy);
		//param.put("topSearch", topSearch);
		param.put("keywordSelect", keywordSelect);
		param.put("keword", keyword);
		
		//ing 는 컬럼에 들어갈 값임
		if(period.contentEquals("applying")) {
			param.put("ing",period);
			param.put("ingVal", "Y");
		}else if(period.contentEquals("proceeding")) {
			param.put("ing",period);
			param.put("ingVal", "Y");
		}else if(period.contentEquals("done")) {
			param.put("ing", "applying='N' and proceeding");
			param.put("ingVal", "N");
		}

		int cpage = 1;
		try {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		} catch (Exception e) {}

		//네비에서 에러~~
		String navi = tservice.getPageNavi_lesson(cpage, param);
		model.addAttribute("navi", navi);

		List<LessonDTO> lessonlist = tservice.lessonListPeriod(cpage, param);
		System.out.println(lessonlist);
		model.addAttribute("lessonlist",lessonlist);
		model.addAttribute("orderBy",orderBy);
		model.addAttribute("keywordSelect",keywordSelect);
		model.addAttribute("keyword", keyword);
		//model.addAttribute("topSearch", topSearch);
		return "/tutor/lessonList";
	}
	

	//키워드로 검색해서 리스트 뽑기
	@RequestMapping("searchKeword")
	public String searchKeyord(String orderBy, String keyword, String keywordSelect,HttpServletRequest request, Model model) throws Exception{
		model.addAttribute("loginInfo", session.getAttribute("loginInfo"));

		//언어 
		List<LanguageDTO> lanList = mservice.lanList();
		model.addAttribute("lanList",lanList);
		
		Map<String,String> param = new HashMap<>();
		param.put("keywordSelect", keywordSelect);
		param.put("keyword", keyword);
		param.put("orderBy", orderBy);

		int cpage = 1;
		try {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		} catch (Exception e) {}

		String navi = tservice.getPageNavi_lesson(cpage, param);
		model.addAttribute("navi", navi);

		List<LessonDTO> lessonlist = tservice.search(cpage, param);
		System.out.println(lessonlist);
		model.addAttribute("lessonlist",lessonlist);
		model.addAttribute("orderBy",orderBy);
		model.addAttribute("keywordSelect", keywordSelect);
		model.addAttribute("keyword", keyword);
		return "/tutor/lessonList";
	}
	
	//달력으로 검색해서 리스트 뽑기
	@RequestMapping("searchDate")
	public String searchDate(String orderBy, String start_date, String end_date,HttpServletRequest request, Model model) throws Exception{
		model.addAttribute("loginInfo", session.getAttribute("loginInfo"));

		//언어 
		List<LanguageDTO> lanList = mservice.lanList();
		model.addAttribute("lanList",lanList);
		
		Map<String,String> param = new HashMap<>();
		param.put("start_date", start_date);
		param.put("end_date", end_date);
		param.put("orderBy", orderBy);

		int cpage = 1;
		try {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		} catch (Exception e) {}

		String navi = tservice.getPageNavi_lesson(cpage, param);
		model.addAttribute("navi", navi);

		List<LessonDTO> lessonlist = tservice.search(cpage, param);
		System.out.println(lessonlist);
		model.addAttribute("lessonlist",lessonlist);
		model.addAttribute("orderBy",orderBy);
		return "/tutor/lessonList";
	}
	
	//지도로 검색하기
	@RequestMapping("searchMap")
	public String searchMap(String location, String orderBy,HttpServletRequest request, Model model) throws Exception{
		model.addAttribute("loginInfo", session.getAttribute("loginInfo"));

		//언어 
		List<LanguageDTO> lanList = mservice.lanList();
		model.addAttribute("lanList",lanList);
		
		Map<String,String> param = new HashMap<>();
		param.put("location", location);
		param.put("orderBy", orderBy);

		int cpage = 1;
		try {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		} catch (Exception e) {}

		String navi = tservice.getPageNavi_lesson(cpage, param);
		model.addAttribute("navi", navi);

		List<LessonDTO> lessonlist = tservice.search(cpage, param);
		System.out.println(lessonlist);
		model.addAttribute("lessonlist",lessonlist);
		model.addAttribute("orderBy",orderBy);
		return "/tutor/lessonList";
	}
	
	//강의 view
	@RequestMapping("lessonView")
	public String lessonView(Model model, int seq) throws Exception{
		MemberDTO mdto = (MemberDTO)session.getAttribute("loginInfo");
		String id = mdto.getId();
		
		Map<Object, Object> param = new HashMap<>();
		param.put("id", id);
		param.put("parent_seq", seq);
		
		boolean checkLike = tservice.LikeIsTrue(param);
		boolean checkJjim = tservice.JjimIsTrue(param);
	
		LessonDTO ldto = tservice.lessonView(seq);
		tservice.updateViewCount(seq);
		
		//언어 
		List<LanguageDTO> lanList = mservice.lanList();
		//리뷰 리스트 출력
		List<ReviewDTO> reviewList = gservice.reviewList(seq);
		
		model.addAttribute("loginInfo", session.getAttribute("loginInfo"));
		model.addAttribute("lanList",lanList);
		model.addAttribute("ldto", ldto);
		model.addAttribute("seq", seq);
		model.addAttribute("checkLike", checkLike);
		model.addAttribute("checkJjim",checkJjim);
		model.addAttribute("reviewList", reviewList);
		return "/tutor/lessonView";
	}
	
	
	//좋아요 누르면 라이크테이블에 저장하기
	@RequestMapping("likeTrue")
	@ResponseBody
	public int likeTrue(LikeListDTO lldto) throws Exception{
		MemberDTO mdto = (MemberDTO)session.getAttribute("loginInfo");
		String id = mdto.getId();
		lldto.setId(id);
		int result = tservice.likeTrue(lldto);
		return result;
	}
	
	//찜 누르면 찜테이블에 저장하기
	@RequestMapping("insertJjim")
	@ResponseBody
	public int insertJjim(JjimDTO jdto) throws Exception{
		MemberDTO mdto = (MemberDTO)session.getAttribute("loginInfo");
		String id = mdto.getId();
		jdto.setId(id);
		int result = tservice.insertJjim(jdto);
		return result;
	}
	
	//찜 다시 누르면 찜테이블에서 삭제하기
	@RequestMapping("deleteJjim")
	@ResponseBody
	public int deleteJjim(JjimDTO jdto) throws Exception{
		MemberDTO mdto = (MemberDTO)session.getAttribute("loginInfo");
		String id = mdto.getId();
		jdto.setId(id);
		int result = tservice.deleteJjim(jdto);
		return result;
	}
	
	
	//강의 취소 누르면 강의취소신청서 테이블에 저장하기
	@RequestMapping("cancleProc")
	public String lessonCancleProc(DeleteApplyDTO dadto) throws Exception{
		System.out.println(dadto.getId()+ " : " + dadto.getSeq()+ " : " + dadto.getCategory()+ " : " + dadto.getContents()+ " : " + dadto.getParent_seq());
		tservice.lessonCancleProc(dadto);
		return "redirect: /tutor/lessonView?seq="+dadto.getParent_seq();
	}
	
	//강의 취소 이미 신청한 사람 있는지 없는지
	@RequestMapping("lessonCancle")
	@ResponseBody
	public int lessonCancle(Model model, int parent_seq, String category) throws Exception{
		MemberDTO mdto = (MemberDTO)session.getAttribute("loginInfo");
		String id = mdto.getId();
		System.out.println(parent_seq);
		Map<Object, Object> param = new HashMap<>();
		param.put("id", id);
		param.put("parent_seq", parent_seq);
		param.put("category", category);
		
		int result = tservice.lessonCancle(param);
		
		return result;
	}
	
	//강의 신청서 수정버튼
	@RequestMapping("lessonUpdate")
	public String lessonUpdate(Model model, int seq) throws Exception{
		LessonDTO ldto = tservice.lessonView(seq);
		model.addAttribute("seq", seq);
		model.addAttribute("ldto",ldto);
		return "/tutor/lessonUpdate";
	}
	
	//강의 신청서 수정
	@RequestMapping("lessonAppUpdateProc")
	public String lessonAppUpdateProc(LessonDTO ldto, Model model) throws Exception{
		MemberDTO mdto = (MemberDTO)session.getAttribute("loginInfo");
		
		System.out.println(ldto.getPrice());
		model.addAttribute("loginInfo", session.getAttribute("loginInfo"));
		String id = mdto.getId();
		Map<Object, Object> param = new HashMap<>();
		param.put("id", id);
		param.put("parent_seq", ldto.getSeq());
		
		boolean checkLike = tservice.LikeIsTrue(param);
		model.addAttribute(checkLike);
//		ldto.setId(mdto.getId());
//		ldto.setName(mdto.getName());
//		ldto.setEmail(mdto.getEmail());
//		ldto.setPhone_country(mdto.getPhone_country());
//		ldto.setPhone(mdto.getPhone());
//		ldto.setSysname(mdto.getSysname());

		tservice.lessonAppUpdateProc(ldto);
		model.addAttribute("ldto",ldto);
		
		return "/tutor/lessonView";
	}

	//같은사람이 게시물 신고했는지 확인
	@RequestMapping("report")
	@ResponseBody
	public int report(Model model, ReportListDTO rldto) throws Exception {
		MemberDTO mdto = (MemberDTO)session.getAttribute("loginInfo");
		rldto.setReporter(mdto.getId());
		
		int result = tservice.report(rldto);
		model.addAttribute("rldto",rldto);
		return result;
	}
	
	//신고 테이블에 저장
	@RequestMapping("reportProc")
	public String reportProc(Model model, ReportListDTO rldto) throws Exception{
		tservice.reportProc(rldto);
		return "redirect: /tutor/lessonView?seq="+rldto.getParent_seq();
	}
	
	//리뷰 갯수랑 평점 업데이트
	@RequestMapping("reviewUpdate")
	public String reviewUpdate(Model model, ReviewDTO rdto) throws Exception{
		System.out.println(rdto.getParent_seq() + rdto.getCategory());
		tservice.reviewUpdate(rdto);
		return "redirect: /tutor/lessonView?seq="+ rdto.getParent_seq();
	}


}
