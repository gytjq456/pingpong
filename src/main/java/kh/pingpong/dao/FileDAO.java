package kh.pingpong.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.pingpong.dto.FileDTO;
import kh.pingpong.dto.NewsDTO;

@Repository
public class FileDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	@RequestMapping("fileOneInsert")
	public void fileOneInsert() {
		
	}
	
	public int tutorFileInsert(FileDTO fdto) throws Exception{
		System.out.println(fdto.getOriname()+":" + fdto.getSysname() + ": " + fdto.getRealpath());
		return mybatis.insert("Tutor.insertFiles", fdto);
	}
	
	public FileDTO downloadFile(NewsDTO ndto) throws Exception{
		return mybatis.selectOne("News.newsViewFileOne", ndto);
	}
	
	
}
