package kh.pingpong.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
import kh.pingpong.service.GroupService;

@Controller
@RequestMapping("/group/")
public class GroupController {
	@Autowired
	private GroupService gservice;
	
	@Autowired
	private HttpSession session;
	
	@RequestMapping("main")
	public String groupMain(String orderBy, HttpServletRequest request, Model model) throws Exception {
		int cpage = 1;
        try {
           cpage = Integer.parseInt(request.getParameter("cpage"));
        } catch (Exception e) {}
        
		List<GroupDTO> glist = gservice.selectList(cpage, orderBy);
		String navi = gservice.getPageNav(cpage, orderBy);
		
		model.addAttribute("glist", glist);
		model.addAttribute("navi", navi);
		
		return "/group/main";
	}
	
	@RequestMapping("write")
	public String groupWrite(Model model) {
		List<HobbyDTO> hblist = gservice.selectHobby();
		model.addAttribute("hblist", hblist);
		return "/group/write";
	}
	
	@RequestMapping("writeProc")
	public String groupWriteProc(GroupDTO gdto, Model model) {
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
	
	@RequestMapping("view")
	public String groupView(int seq, Model model) {
		GroupDTO gdto = gservice.selectBySeq(seq);
		
		Map<Object, Object> param = new HashMap<>();
		param.put("id", "test");
		param.put("parent_seq", seq);
		
		boolean checkLike = gservice.selectLike(param);
		
		model.addAttribute("gdto", gdto);
		model.addAttribute("checkLike", checkLike);
		return "/group/view";
	}
	
	@RequestMapping("delete")
	public String groupDelete(int seq) {
		gservice.delete(seq);
		return "redirect:/group/main";
	}
	
	@RequestMapping("update")
	public String groupUpdate(int seq, Model model) {
		List<HobbyDTO> hblist = gservice.selectHobby();
		GroupDTO gdto = gservice.selectBySeq(seq);
		model.addAttribute("hblist", hblist);
		model.addAttribute("gdto", gdto);
		return "/group/update";
	}
	
	@RequestMapping("updateProc")
	public String groupUpdateProc(GroupDTO gdto, Model model) {
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
		int result = gservice.insertLike(ldto);
		return result;
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
}
