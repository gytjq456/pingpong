package kh.pingpong.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.pingpong.service.NewsService;

@Controller
@RequestMapping("/news/")
public class NewsController {
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private FileController fcon;
	
	@Autowired
	private NewsService newservice;
	
	/* new list jsp */
	@RequestMapping("list")
	public String list() {
		return "/news/list";
	}
	
	/* 글쓰기 jsp */
	@RequestMapping("write")
	public String write() {
		System.out.println("아아아아아");
		return "/news/write";
	}
}
