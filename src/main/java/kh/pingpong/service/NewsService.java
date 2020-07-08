package kh.pingpong.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.pingpong.dao.NewsDAO;

@Service
public class NewsService {
	
	@Autowired
	private NewsDAO newsdao;
	
	public int newsInsert() {
		return 0;
	}
	
}
