package kh.pingpong.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.pingpong.dto.VisitorDTO;

@Repository
public class VisitorDAO {
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public int insertVisitor(VisitorDTO vdto) {
		return mybatis.insert("Visitor.insertVisitor", vdto);
	}
	
	public int updateVisitCount(String visit_date) {
		return mybatis.update("Visitor.updateVisitCount", visit_date);
	}
	
	public List<VisitorDTO> selectSevenDays() {
		return mybatis.selectList("Visitor.selectSevenDays");
	}
	
	public int selectToday(String visit_date) {
		int result = 0;
		
		if (mybatis.selectOne("Visitor.selectToday", visit_date) != null) {
			result = 1;
		}
		
		return result;
	}
}
