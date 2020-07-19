package kh.pingpong.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/guide/")
public class GuideController {

	
	@RequestMapping("info")
	public String info() throws Exception{
		return "guide/info";
	}
	
}
