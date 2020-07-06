package kh.pingpong.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import kh.pingpong.config.Configuration;
import kh.pingpong.dto.CorrectCDTO;
import kh.pingpong.dto.CorrectDTO;

@Repository
public class CorrectDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
//	public int getSeq() throws Exception{
//		return mybatis.selectOne("correct.nextSeq");
//	}
	
	public int insert(CorrectDTO dto) throws Exception {
		return mybatis.insert("Correct.insert", dto);
	}
	
	public List<CorrectDTO> selectAll(int cpage) throws Exception{
		
		Map <String, Integer> param = new HashMap<>();
		int start =cpage * 10 - (10-1);
		int end = start + (10-1);
		param.put("start", start);
		param.put("end", end);
		return mybatis.selectList("Correct.selectAll", param);
		
	} 
	
	public CorrectDTO selectOne(int seq) throws Exception{
		return mybatis.selectOne("Correct.selectOne", seq);
	}

	@Transactional("txManager")
	public int commentInsert(CorrectCDTO cdto) throws Exception{
//	mybatis.update("Correct.CommentCount", dto);
	return mybatis.insert("Correct.commentInsert",cdto);
	}
	public List<CorrectCDTO> selectc(int parent_seq) throws Exception{
	return mybatis.selectList("Correct.selectc",parent_seq);
	} 
	
	public List<CorrectCDTO> bestcomm(int parent_seq) throws Exception{
		return mybatis.selectList("Correct.selectc2",parent_seq);
		} 
	
	public int viewcount(int seq) throws Exception {
		return mybatis.update("Correct.viewcount",seq);
	}
	public int modify(CorrectDTO dto) throws Exception{
		return mybatis.update("Correct.modify",dto);
	}
//	public int select(correct_dto dto) throws Exception {
//		return mybatis.select("Correct.select", dto);
//	}
	
	public int like(CorrectDTO dto) throws Exception{
		return mybatis.update("Correct.like", dto);
	}
	
	public int hate(CorrectDTO dto) throws Exception{
		return mybatis.update("Correct.hate", dto);
	}
	
	public int commentlike(CorrectDTO dto) throws Exception{
		return mybatis.update("Correct.commentlike", dto);
	}
	
	public int commenthate(CorrectDTO dto) throws Exception{
		return mybatis.update("Correct.commenthate", dto);
	}
	
	public int correctcount() throws Exception{
		return mybatis.selectOne("Correct.correctcount");
	}
	
	public int countrep(CorrectCDTO cdto) throws Exception {
		return mybatis.update("Correct.countrep",cdto);
	}
	
	public int delete(CorrectDTO dto) throws Exception {
		return mybatis.delete("Correct.delete",dto);
	}
	
	}
