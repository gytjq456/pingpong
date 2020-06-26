package kh.pingpong.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.pingpong.dao.TutorDAO;
import kh.pingpong.dto.TutorAppDTO;

@Service
public class TutorService {

	@Autowired
	private TutorDAO tdao;
	
	public int tutorAppSend(TutorAppDTO tadto) throws Exception{
		return tdao.insert(tadto);
	}
	
}
