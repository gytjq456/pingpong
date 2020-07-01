package kh.pingpong.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.pingpong.dto.FileDTO;

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
	
	
}
