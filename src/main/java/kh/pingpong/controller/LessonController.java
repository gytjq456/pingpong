package kh.pingpong.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/lesson/")
public class LessonController {

	@RequestMapping("lessonApp")
	public String lessonApp() {
		return "tutor/lessonApp";
	}
}
