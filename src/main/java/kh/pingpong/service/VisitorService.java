package kh.pingpong.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.pingpong.dao.VisitorDAO;
import kh.pingpong.dto.VisitorDTO;

@Service
public class VisitorService {
	@Autowired
	private VisitorDAO vdao;
	
	public int insertVisitor(VisitorDTO vdto) {
		return vdao.insertVisitor(vdto);
	}
	
	public int updateVisitCount(String visit_date) {
		return vdao.updateVisitCount(visit_date);
	}
	
	public List<VisitorDTO> selectSevenDays() {
		return vdao.selectSevenDays();
	}
	
	public boolean selectToday(String visit_date) {
		int result = vdao.selectToday(visit_date);
		boolean exist = false;
		
		if (result > 0) {
			exist = true;
		}
		
		return exist;
	}
}
