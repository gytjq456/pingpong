package kh.pingpong.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kh.pingpong.dto.CommentDTO;
import kh.pingpong.dto.DiscussionDTO;
import kh.pingpong.dto.LanguageDTO;
import kh.pingpong.dto.LikeListDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.ReportListDTO;
import kh.pingpong.service.DiscussionService;
import kh.pingpong.service.PapagoService;


@Controller
@RequestMapping("/discussion/")
public class DiscussionController {

	@Autowired
	private DiscussionService disService;
	
	@Autowired
	private PapagoService papagoService;
	
	@Autowired
	private HttpSession session;

	// 글쓰기 페이지 
	@RequestMapping("write")
	public String write(Model model) throws Exception{
		List<LanguageDTO> langList = disService.langSelectlAll();
		model.addAttribute("langList", langList);
		return "board/discussion/write";
	}

	// 글쓰기 완료 처리 
	@RequestMapping("writeProc")
	public String writeProc(DiscussionDTO disDTO) throws Exception{
		disService.insert(disDTO);
		return "redirect:/discussion/list";
	}

	// 글 목록 페이지
	@RequestMapping("list")
	public String list(Model model, HttpServletRequest request) throws Exception{
		
		int cpage = 1;
        try {
           cpage = Integer.parseInt(request.getParameter("cpage"));
        } catch (Exception e) {}
        Map<String, Object> search = new HashMap<>();
        List<DiscussionDTO> list = disService.selectAll(cpage);
        
        String navi = disService.getPageNavi_discussion(cpage,search);
		model.addAttribute("navi", navi);
		model.addAttribute("list", list);
		return "board/discussion/list";
	}

	// 토론 작성자/제목 / 내용 검색
	@RequestMapping("kewordSch")
	public String kewordSch(String type, String keyword, HttpServletRequest request, Model model) throws Exception{
		int cpage = 1;
        try {
           cpage = Integer.parseInt(request.getParameter("cpage"));
        } catch (Exception e) {}		
        Map<String, Object> search = new HashMap<>();
		search.put("type", type);
		search.put("keyword", keyword);
		List<DiscussionDTO> list = disService.kewordSch(cpage,search);
		String navi = disService.getPageNavi_discussion(cpage,search);
		model.addAttribute("type",type);
		model.addAttribute("keyword",keyword);
		model.addAttribute("list",list);
		model.addAttribute("navi",navi);
		return "board/discussion/list";
	}
	
	
	// 글 보기 
	@Transactional("txManager")
	@RequestMapping("view")
	public String view(DiscussionDTO disDto, Model model, HttpServletRequest req, HttpServletResponse res) throws Exception{
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		//쿠키변수를 만들어서 값을 저장. 쿠키변수에 값이 있으면 조회수 증가 실행 하지 않음
		Boolean isGet=false;
		String seq = String.valueOf(disDto.getSeq());   
		Cookie[] cookies=req.getCookies();
		if(cookies!=null){   
			for(Cookie c: cookies){//    
				//num쿠키가 있는 경우
				if(c.getName().contentEquals("seq"+seq)){
					isGet=true; 
				}
			}		
		}
		// num쿠키가 없는 경우
		if(!isGet) {
			//bDao.updateReadCount(num);//조회수증가
			Cookie c1 = new Cookie("seq"+seq, "seq"+seq);
			c1.setMaxAge(1*24*60*60);//하루저장
			res.addCookie(c1);    
		}
		disDto = disService.selectOne(disDto.getSeq(),isGet);
		List<CommentDTO> commDto = disService.selectComment(disDto.getSeq());
		List<CommentDTO> bestCommDto = disService.bestComment(disDto.getSeq());
		List<DiscussionDTO> moreList = disService.moreList(disDto.getSeq());

		List<Boolean> checkLike = new ArrayList<>();
		List<Boolean> checkHate = new ArrayList<>();
		Boolean boardCheckLike = false;
		Map<Object, Object> param = new HashMap<>();
		for(CommentDTO checkLikeHate : commDto) {
			System.out.println(checkLikeHate.getSeq());
			param.put("id", loginInfo.getId());
			param.put("parent_seq", checkLikeHate.getSeq());
			param.put("category", "토론 댓글");
			checkLike.add(disService.selectLike(param));
			checkHate.add(disService.selecHate(param));
		}
		
		param.put("id", loginInfo.getId());
		param.put("parent_seq", disDto.getSeq());
		param.put("category", "토론 게시글");
		boardCheckLike = disService.selectLike(param);
		
		List<LanguageDTO> langList = disService.langSelectlAll();
		model.addAttribute("langList", langList);
		model.addAttribute("commentList", commDto);
		model.addAttribute("bestCommentList", bestCommDto);
		model.addAttribute("boardCheckLike", boardCheckLike);
		model.addAttribute("checkLike", checkLike);
		model.addAttribute("checkHate", checkHate);
		model.addAttribute("disDto", disDto);
		model.addAttribute("moreList", moreList);
		return "board/discussion/view";
	}

	// 글 삭제
	@ResponseBody
	@RequestMapping("delete")
	public String delete(DiscussionDTO disDto) throws Exception{
		int result = disService.delete(disDto.getSeq());
		if(result > 0) {
			return String.valueOf(true);
		}else {
			return String.valueOf(false);
		}
	}

	// 수정하기 페이지로 이동
	@Transactional("txManager")
	@RequestMapping("modify")
	public String modify(DiscussionDTO disDto, Model model) throws Exception{
		List<LanguageDTO> langList = disService.langSelectlAll();
		disDto = disService.selectOne(disDto.getSeq(), true);
		model.addAttribute("disDto", disDto);
		model.addAttribute("langList", langList);
		return "board/discussion/modify";
	}

	// 수정하기 처리
	@ResponseBody
	@RequestMapping("modifyProc")
	public String modifyProc(DiscussionDTO disDto) throws Exception{
		int result = disService.modify(disDto);
		if(result > 0) {
			return String.valueOf(true);
		}else {
			return String.valueOf(false);
		}
	}

	// 게시글 좋아요
	@ResponseBody
	@RequestMapping("like")
	public String like(LikeListDTO ldto) throws Exception{
		
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		Map<Object, Object> param = new HashMap<>();
		param.put("id", loginInfo.getId());
		param.put("parent_seq", ldto.getParent_seq());
		param.put("category", ldto.getCategory());
		int likeResult = 0;
		Boolean checkLike = disService.selectLike(param);
		System.out.println(checkLike);
		if(checkLike) {
			ldto.setId(loginInfo.getId());
			disService.likedelete(ldto.getParent_seq());
			disService.deletetLike(ldto);
			return String.valueOf("cancel");
		}
		
		if(!checkLike) {
			ldto.setId(loginInfo.getId());
			disService.like(ldto.getParent_seq());
			likeResult = disService.insertLike(ldto);
		}
		
		if(likeResult > 0) {
			return String.valueOf(true);
		}else {
			return String.valueOf(false);
		}
	}

	// 댓글 쓰기
	@ResponseBody
	@RequestMapping("commentProc")
	public String commentProc(CommentDTO commDTO, DiscussionDTO disDTO) throws Exception{
		int result = disService.commentInsert(commDTO);
		if(result > 0) {
			return String.valueOf(true);
		}else {
			return String.valueOf(false);
		}
	}




	// 댓글 좋아요
	@ResponseBody
	@RequestMapping(value="commentLike")
	public String commentLike(LikeListDTO ldto) throws Exception{
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		Map<Object, Object> param = new HashMap<>();
		param.put("id", loginInfo.getId());
		param.put("parent_seq", ldto.getParent_seq());
		param.put("category", ldto.getCategory());
		int likeResult = 0;
		Boolean checkLike = disService.selectLike(param);
		Boolean checkHate = disService.selecHate(param);
		if(checkLike) {
			System.out.println(checkLike);
			ldto.setId(loginInfo.getId());
			disService.commentLikeCancel(ldto.getParent_seq());
			disService.deletetLike(ldto);
			return String.valueOf("cancel");
		}
		
		
		if(!checkLike && !checkHate) {
			ldto.setId(loginInfo.getId());
			disService.commentLike(ldto.getParent_seq());
			likeResult = disService.insertLike(ldto);
		}
		
		if(likeResult > 0) {
			return String.valueOf(true);
		}else {
			return String.valueOf(false);
		}
		
	}

	// 댓글 싫어요
	@ResponseBody
	@RequestMapping("commentHate")
	public String commentHate(LikeListDTO ldto) throws Exception{
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		Map<Object, Object> param = new HashMap<>();
		param.put("id", loginInfo.getId());
		param.put("parent_seq", ldto.getParent_seq());
		param.put("category", ldto.getCategory());
		int likeResult = 0;
		
		Boolean checkHate = disService.selecHate(param);
		Boolean checkLike = disService.selectLike(param);
		System.out.println(checkLike);
		
		if(checkHate) {
			ldto.setId(loginInfo.getId());
			System.out.println(ldto.getId());
			System.out.println(ldto.getParent_seq());
			disService.commentHateCancel(ldto.getParent_seq());
			likeResult = disService.deletetHate(ldto);
			return String.valueOf("cancel");
		}
		
		if(!checkLike && !checkHate) {
			ldto.setId(loginInfo.getId());
			disService.commentHate(ldto.getParent_seq());
			likeResult = disService.insertHate(ldto);
		}
		
		if(likeResult > 0) {
			return String.valueOf(true);
		}else {
			return String.valueOf(false);
		}
	}

	
	//같은사람이 게시물 신고했는지 확인
		@RequestMapping("report")
		@ResponseBody
		public int report(Model model, ReportListDTO rldto) throws Exception {
			MemberDTO mdto = (MemberDTO)session.getAttribute("loginInfo");
			rldto.setReporter(mdto.getId());
			int result = disService.report(rldto);
			System.out.println("result =" +result);
			model.addAttribute("rldto",rldto);
			return result;
		}
		
		//신고 테이블에 저장
		@RequestMapping("reportProc")
		public String reportProc(Model model, ReportListDTO rldto) throws Exception{
			System.out.println("ldto = " + rldto.getCommSeq() );
			disService.reportProc(rldto);
			return "redirect:/discussion/view?seq="+rldto.getParent_seq();
		}

	//댓글 삭제
	@ResponseBody
	@RequestMapping("commentDelete")
	public String commentDelete(CommentDTO commDTO) throws Exception{
		int result = disService.commentDelete(commDTO);
		if(result > 0) {
			return String.valueOf(true);
		}else {
			return String.valueOf(false);
		}
	}

	@RequestMapping("align")
	public String align(String type, String keyword,HttpServletRequest req, Model model) throws Exception{
		String alignType = req.getParameter("align");
		int cpage = 1;
        try {
           cpage = Integer.parseInt(req.getParameter("cpage"));
        } catch (Exception e) {}	
        
		Map<String, Object> search = new HashMap<>();
		search.put("alignType" , alignType );
		search.put("type", type);
		search.put("keyword", keyword);
		List<DiscussionDTO> list = disService.searchAlign(alignType,search,cpage);
        String navi = disService.getPageNavi_discussion(cpage,search);
        
		model.addAttribute("navi", navi);		
		model.addAttribute("alignType", alignType);
		model.addAttribute("list", list);
		model.addAttribute("type", type);
		model.addAttribute("keyword", keyword);
		return "board/discussion/list";
	}
	
	
	// 파파고
	@ResponseBody
	@RequestMapping(value="papago", produces="application/json;charset=utf8", method=RequestMethod.POST)
	public String papago(HttpServletRequest request) throws Exception{
		String original_str = (String)request.getParameter("original_str");
		String original_lang = (String)request.getParameter("original_lang");
		String change_lang = (String)request.getParameter("change_lang");
		
		LanguageDTO lang = disService.langSelectlOne(original_lang);
		String[] resultString = papagoService.nmtReturnRseult(original_str, lang, change_lang);
		System.out.println(resultString);
		return new Gson().toJson(resultString);
	}
	

	
}
