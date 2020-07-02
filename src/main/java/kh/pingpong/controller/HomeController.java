package kh.pingpong.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kh.pingpong.dto.MemberDTO;

@Controller
public class HomeController {
	
	@Autowired
	private HttpSession session;
	
	@RequestMapping("/")
	public String home() {
		return "index";
	}
	

	
}
