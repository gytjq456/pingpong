package kh.pingpong.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;

import kh.pingpong.dto.DeleteApplyDTO;
import kh.pingpong.dto.GroupApplyDTO;
import kh.pingpong.dto.GroupDTO;
import kh.pingpong.dto.HobbyDTO;
import kh.pingpong.dto.LikeListDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.ReviewDTO;
import kh.pingpong.service.GroupService;

@Controller
@RequestMapping("/group/")
public class GroupController {
	@Autowired
	private GroupService gservice;
	
	@Autowired
	private HttpSession session;
	
	// header.jsp에서 그룹 찾기 탭 눌렀을 때 이동
	@RequestMapping("main")
	public String groupMain(String orderBy, HttpServletRequest request, Model model) throws Exception {
		int cpage = 1;
        try {
           cpage = Integer.parseInt(request.getParameter("cpage"));
        } catch (Exception e) {}
        
        List<HobbyDTO> hblist = gservice.selectHobby();
		List<GroupDTO> glist = gservice.selectList(cpage, orderBy);
		String navi = gservice.getPageNav(cpage, orderBy);
		
		model.addAttribute("hblist", hblist);
		model.addAttribute("glist", glist);
		model.addAttribute("navi", navi);
		model.addAttribute("orderBy", orderBy);
		
		return "/group/main";
	}
	
	// 글 쓰기 페이지 이동
	@RequestMapping("write")
	public String groupWrite(Model model) {
		List<HobbyDTO> hblist = gservice.selectHobby();
		model.addAttribute("hblist", hblist);
		return "/group/write";
	}
	
	@RequestMapping("writeProc")
	public String groupWriteProc(GroupDTO gdto, Model model) throws ParseException {
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		String id = loginInfo.getId();
		String name = loginInfo.getName();
		gdto.setWriter_id(id);
		gdto.setWriter_name(name);
		int seq = gservice.insertGroup(gdto);
		model.addAttribute("seq", seq);
		return "redirect:/group/view";
	}
	
	@RequestMapping("beforeView")
	public String groupBeforeView(int seq, Model model) {
		gservice.updateViewCount(seq);
		model.addAttribute("seq", seq);
		return "redirect:/group/view";
	}
	
	@Transactional("txManager")
	@RequestMapping("view")
	public String groupView(int seq, Model model) throws Exception{
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		String id = loginInfo.getId();
		
		GroupDTO gdto = gservice.selectBySeq(seq);
		
		Map<Object, Object> param = new HashMap<>();
		param.put("id", id);
		param.put("parent_seq", seq);
		
		boolean checkLike = gservice.selectLike(param);
		
		//리뷰 리스트 출력
		List<ReviewDTO> reviewList = gservice.reviewList(seq);
		
		model.addAttribute("gdto", gdto);
		model.addAttribute("checkLike", checkLike);
		model.addAttribute("reviewList", reviewList);
		return "/group/view";
	}
	
	@RequestMapping("delete")
	public String groupDelete(int seq) {
		gservice.delete(seq);
		return "redirect:/group/main";
	}
	
	@RequestMapping("update")
	public String groupUpdate(int seq, Model model) throws Exception{
		List<HobbyDTO> hblist = gservice.selectHobby();
		GroupDTO gdto = gservice.selectBySeq(seq);
		model.addAttribute("hblist", hblist);
		model.addAttribute("gdto", gdto);
		return "/group/update";
	}
	
	@RequestMapping("updateProc")
	public String groupUpdateProc(GroupDTO gdto, Model model) throws ParseException {
		gservice.update(gdto);
		model.addAttribute("seq", gdto.getSeq());
		return "redirect:/group/view";
	}
	
	@RequestMapping("applyForm/parent_seq/{parent_seq}")
	public String groupApplyForm(@PathVariable int parent_seq, Model model) {
		model.addAttribute("parent_seq", parent_seq);
		return "/group/apply";
	}
	
	@RequestMapping("apply")
	@ResponseBody
	public boolean groupApply(GroupApplyDTO gadto) {
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");

		gadto.setWriter(loginInfo.getId());
		gadto.setName(loginInfo.getName());
		gadto.setAge(loginInfo.getAge());
		gadto.setGender(loginInfo.getGender());
		gadto.setAddress(loginInfo.getAddress());
		gadto.setProfile(loginInfo.getSysname());
		gadto.setLang_can(loginInfo.getLang_can());
		gadto.setLang_learn(loginInfo.getLang_learn());
		
		int result = gservice.insertApp(gadto);
		boolean output = false;
		
		if (result > 0) {
			output = true;
		}
		
		return output;
	}
	
	@RequestMapping("outForm/parent_seq/{parent_seq}")
	public String groupOutForm(@PathVariable int parent_seq, Model model) {
		model.addAttribute("parent_seq", parent_seq);
		return "/group/out";
	}
	
	@RequestMapping("out")
	@ResponseBody
	public boolean groupApplyDelete(DeleteApplyDTO dadto) {
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		String id = loginInfo.getId();
		
		dadto.setId(id);
		int result = gservice.insertDeleteApply(dadto);
		boolean output = false;
		
		if (result > 0) {
			output = true;
		}
		
		return output;
	}
	
	@RequestMapping("like")
	@ResponseBody
	public int groupInsertLike(LikeListDTO ldto) {
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		String id = loginInfo.getId();
		
		ldto.setId(id);
		
		int result = gservice.insertLike(ldto);
		return result;
	}
	
	@RequestMapping("mainOption")
	public String mainOption(String orderBy, String ing, HttpServletRequest request, Model model) throws Exception {
		int cpage = 1;
        try {
           cpage = Integer.parseInt(request.getParameter("cpage"));
        } catch (Exception e) {}
        
        Map<String, Object> param = new HashMap<>();
        
        param.put("orderBy", orderBy);
        
        if (ing.contentEquals("done")) {
        	param.put("option", "proceeding");
        	param.put("optionValue", "N");
        } else {
        	param.put("option", ing);
        	param.put("optionValue", "Y");
        }
        
        List<HobbyDTO> hblist = gservice.selectHobby();
		List<GroupDTO> glist = gservice.selectListOption(cpage, param);
		String navi = gservice.getPageNav(cpage, orderBy);
		
		model.addAttribute("hblist", hblist);
		model.addAttribute("glist", glist);
		model.addAttribute("navi", navi);
		model.addAttribute("orderBy", orderBy);
		
		return "/group/main";
	}
	
	@RequestMapping("search")
	public String search(String orderBy, String searchType, String searchThing, String hobbyType, String period, HttpServletRequest request, Model model) throws Exception {
		int cpage = 1;
        try {
           cpage = Integer.parseInt(request.getParameter("cpage"));
        } catch (Exception e) {}
        
		Map<String, Object> search = new HashMap<>();
		
		if (!hobbyType.contentEquals("")) {
			search.put("hobby_type", hobbyType);
		}
		
		if (!searchThing.contentEquals("null")) {
			search.put("searchType", searchType);
			search.put("searchThing", searchThing);
		}
		
		if (!period.contentEquals("null")) {
			search.put("period", period);
		}
		
		search.put("orderBy", orderBy);
		
		List<HobbyDTO> hblist = gservice.selectHobby();
		List<GroupDTO> glist = gservice.search(cpage, search);
		String navi = gservice.getPageNav(cpage, orderBy);

		model.addAttribute("hblist", hblist);
		model.addAttribute("glist", glist);
		model.addAttribute("navi", navi);
		
		return "/group/main";
	}
	
	@RequestMapping("searchDate")
	public String searchDate(String orderBy, String dateStart, String dateEnd, HttpServletRequest request, Model model) throws Exception {
		int cpage = 1;
        try {
           cpage = Integer.parseInt(request.getParameter("cpage"));
        } catch (Exception e) {}
        
        Map<String, Object> dates = new HashMap<>();
        
        dates.put("orderBy", orderBy);
        dates.put("dateStart", dateStart);
        dates.put("dateEnd", dateEnd);
        
        List<HobbyDTO> hblist = gservice.selectHobby();
        List<GroupDTO> glist = gservice.searchDate(cpage, dates);
        String navi = gservice.getPageNav(cpage, orderBy);
        
        model.addAttribute("hblist", hblist);
        model.addAttribute("glist", glist);
        model.addAttribute("navi", navi);
        
        return "/group/main";
	}
	
	@RequestMapping(value="imgUpload", produces="application/json")
	@ResponseBody
	public JsonObject groupImgUpload(@RequestParam("file") MultipartFile multipartFile) {
		
		JsonObject jsonObject = new JsonObject();
		
		String fileRoot = "C:\\summernote_image\\";
		String originalFileName = multipartFile.getOriginalFilename();
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
		
		String savedFileName = UUID.randomUUID() + extension;
		
		File targetFile = new File(fileRoot + savedFileName);
		
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);
			jsonObject.addProperty("url", "/summernoteImage/" + savedFileName);
			jsonObject.addProperty("responseCode", "success");
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		
		return jsonObject;
	}
	
	// 리뷰 글쓰기 
	@ResponseBody
	@RequestMapping("reviewWrite")
	public String reviewWrite(ReviewDTO redto) throws Exception{
		int result = gservice.reviewWrite(redto);

		
		if(result > 0) { 
			 return String.valueOf(true); 
		}else { 
			return String.valueOf(false); 
		}
	}
}
