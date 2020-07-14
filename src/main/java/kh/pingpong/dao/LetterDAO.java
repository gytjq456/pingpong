package kh.pingpong.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.pingpong.config.Configuration;
import kh.pingpong.dto.LetterDTO;

@Repository
public class LetterDAO {
	@Autowired
	private SqlSessionTemplate mybatis;
	
	// 쪽지 생성
	public int insertReceiveLetter(LetterDTO ldto) throws Exception {
		return mybatis.insert("Letter.insertReceiveLetter", ldto);
	}
	
	public int insertSendLetter(LetterDTO ldto) throws Exception {
		return mybatis.insert("Letter.insertSendLetter", ldto);
	}
	
	// 보낸 쪽지/받은 쪽지 리스트
	public List<LetterDTO> receiveLetterList(Map<String, Object> param) throws Exception {
		int start = (int)param.get("rcpage") * Configuration.RECORD_COUNT_PER_PAGE - (Configuration.RECORD_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.RECORD_COUNT_PER_PAGE - 1);
		
		param.put("start", start);
		param.put("end", end);
		
		return mybatis.selectList("Letter.receiveLetterList", param);
	}

	public List<LetterDTO> sendLetterList(Map<String, Object> param) throws Exception {
		int start = (int)param.get("scpage") * Configuration.RECORD_COUNT_PER_PAGE - (Configuration.RECORD_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.RECORD_COUNT_PER_PAGE - 1);
		
		param.put("start", start);
		param.put("end", end);
		
		return mybatis.selectList("Letter.sendLetterList", param);
	}
	
	// 쪽지 뷰
	public LetterDTO receiveLetterView(int seq) throws Exception {
		return mybatis.selectOne("Letter.receiveLetterView", seq);
	}

	public LetterDTO sendLetterView(int seq) throws Exception {
		return mybatis.selectOne("Letter.sendLetterView", seq);
	}
	
	// 쪽지 삭제
	public int deleteReceiveLetter(int seq) throws Exception {
		return mybatis.delete("Letter.deleteReceiveLetter", seq);
	}

	public int deleteSendLetter(int seq) throws Exception {
		return mybatis.delete("Letter.deleteSendLetter", seq);
	}
	
	// 쪽지 읽음 전환
	public int updateReceiveRead(int seq) throws Exception {
		return mybatis.update("Letter.updateReceiveRead", seq);
	}

	public int updateSendRead(int seq) throws Exception {
		return mybatis.update("Letter.updateSendRead", seq);
	}
	
	// 페이징
	public int selectCount(String tableName) throws Exception {
		return mybatis.selectOne("Letter.selectCount", tableName);
	}
	
	// 여러 쪽지 삭제
	public int deleteSelected(Map<String, Object> param) throws Exception {
		return mybatis.delete("Letter.deleteSelected", param);
	}
}
