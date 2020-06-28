package kh.pingpong.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.pingpong.config.Configuration;
import kh.pingpong.dto.DeleteApplyDTO;
import kh.pingpong.dto.GroupApplyDTO;
import kh.pingpong.dto.GroupDTO;
import kh.pingpong.dto.HobbyDTO;
import kh.pingpong.dto.LikeListDTO;

@Repository
public class GroupDAO {
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public List<HobbyDTO> selectHobby() {
		return mybatis.selectList("Group.selectHobby");
	}
	
	public int insertGroup(GroupDTO gdto) {
		System.out.println(gdto.getApply_start());
		return mybatis.insert("Group.insert", gdto);
	}
	
	public List<GroupDTO> selectList(int cpage, String orderBy) {
		Map<String, Object> param = new HashMap<>();

		int start = cpage * Configuration.RECORD_COUNT_PER_PAGE - (Configuration.RECORD_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.RECORD_COUNT_PER_PAGE - 1);
		
		param.put("start", start);
		param.put("end", end);
		param.put("orderBy", orderBy);
		
		return mybatis.selectList("Group.selectList", param);
	}
	
	public GroupDTO selectBySeq(int seq) {
		return mybatis.selectOne("Group.selectBySeq", seq);
	}
	
	public int searchSeq(String writer) {
		return mybatis.selectOne("Group.searchSeq", writer);
	}
	
	public int delete(int seq) {
		return mybatis.delete("Group.delete", seq);
	}
	
	public int update(GroupDTO gdto) {
		return mybatis.update("Group.update", gdto);
	}
	
	public int selectCount() {
		return mybatis.selectOne("Group.selectCount");
	}
	
	public int updateViewCount(int seq) {
		return mybatis.update("Group.updateViewCount", seq);
	}
	
	public int insertApp(GroupApplyDTO gadto) {
		return mybatis.insert("Group.insertApp", gadto);
	}
	
	public int selectApplyForm(int parent_seq) {
		return mybatis.selectOne("Group.selectApplyForm", parent_seq);
	}
	
	public int insertDeleteApply(DeleteApplyDTO dadto) {
		return mybatis.insert("Group.insertDeleteApply", dadto);
	}
	
	public int insertLike(LikeListDTO ldto) {
		return mybatis.insert("Group.insertLike", ldto);
	}
	
	public int updateLike(int seq) {
		return mybatis.update("Group.updateLike", seq);
	}
	
	public boolean selectLike(Map<Object, Object> param) {
		Integer result = mybatis.selectOne("Group.selectLike", param);
		boolean checkLike = true;
		if (result == null) {
			checkLike = false;
		}
		
		return checkLike;
	}
	
	public int updateIngDate(String today_date) {
		int resultApplying = mybatis.update("Group.updateApplying", today_date);
		int resultProceeding = mybatis.update("Group.updateProceeding", today_date);
		return resultApplying + resultProceeding;
	}
	
	public List<GroupDTO> selectOrderBy(String tableName) {
		return mybatis.selectList("Group.selectOrderBy", tableName);
	}
}
