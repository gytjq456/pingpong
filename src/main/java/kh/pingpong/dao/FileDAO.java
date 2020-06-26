package kh.pingpong.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;

@Repository
public class FileDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	@RequestMapping("fileOneInsert")
	public void fileOneInsert() {
		
	}
	
}
