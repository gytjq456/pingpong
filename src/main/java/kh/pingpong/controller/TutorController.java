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
import kh.pingpong.dto.LanguageDTO;
import kh.pingpong.dto.LessonDTO;
import kh.pingpong.dto.LikeListDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.TutorAppDTO;
import kh.pingpong.dto.TutorDTO;
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
		
		return "redirect: /tutor/lessonList";
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
	public String lessonList(HttpServletRequest request, Model model) throws Exception{
		model.addAttribute("loginInfo", session.getAttribute("loginInfo"));
		
		//언어 
		List<LanguageDTO> lanList = mservice.lanList();
		model.addAttribute("lanList",lanList);
		
		int cpage = 1;
        try {
           cpage = Integer.parseInt(request.getParameter("cpage"));
        } catch (Exception e) {}
        
		String navi = tservice.getPageNavi_lesson(cpage);
		model.addAttribute("navi", navi);
		
		List<LessonDTO> lessonlist = tservice.lessonList(cpage);
		System.out.println(lessonlist);
		model.addAttribute("lessonlist",lessonlist);
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
		model.addAttribute(checkLike);
		
		LessonDTO ldto = tservice.lessonView(seq);
		tservice.updateViewCount(seq);
		
		//언어 
		List<LanguageDTO> lanList = mservice.lanList();
		
		model.addAttribute("loginInfo", session.getAttribute("loginInfo"));
		model.addAttribute("lanList",lanList);
		model.addAttribute("ldto", ldto);
		model.addAttribute("seq", seq);
		model.addAttribute("checkLike", checkLike);
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
	
	@RequestMapping("lessonUpdate")
	public String lessonUpdate(Model model, int seq) throws Exception{
		model.addAttribute(seq);
		return "/tutor/lessonUpdate";
	}


}
