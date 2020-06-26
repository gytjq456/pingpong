package kh.pingpong.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/tutor/")
public class TutorController {

	
	@RequestMapping("tutorApp")
	public String tutorApp() {
		return "tutor/tutorApp";
	}
}
