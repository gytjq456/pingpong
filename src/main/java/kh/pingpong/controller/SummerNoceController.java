package kh.pingpong.controller;

import java.io.File;
import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonObject;

import kh.pingpong.dto.SummerNoteDTO;

@Controller
@RequestMapping("/summerNote")
public class SummerNoceController {
	
	
	@ResponseBody
	@RequestMapping("uploadSummernoteImageFile")
	public JsonObject uploadSummernoteImageFile(SummerNoteDTO sdto, HttpServletRequest req) throws Exception {
		JsonObject jsonObject = new JsonObject();
		String realPath = req.getSession().getServletContext().getRealPath("summernote_image");
		File file = new File(realPath);
		if(!file.exists()) {
			file.mkdir();
		}
		long time = System.currentTimeMillis();
		SimpleDateFormat sdf = new SimpleDateFormat("YYYYMMddhhmmss");
		String timeVal = sdf.format(new Date(time));
		String fileName = timeVal + "_" + sdto.getFile().getOriginalFilename();  
		File fileObj = new File(realPath + "/" + fileName);
		sdto.getFile().transferTo(fileObj);
		
		jsonObject.addProperty("url", "/summernoteImage/" + fileName);
		return jsonObject;
	}
	
}
