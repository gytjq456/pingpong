package kh.pingpong.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/developer/")
public class DeveloperController {

	@RequestMapping("list")
	public String list() throws Exception{
		System.out.println("====");
		return "developer/list";
	}
}
