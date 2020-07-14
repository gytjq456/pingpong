package kh.pingpong.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
	public List<LetterDTO> receiveLetterList(String id) throws Exception {
		return mybatis.selectList("Letter.receiveLetterList", id);
	}

	public List<LetterDTO> sendLetterList(String id) throws Exception {
		return mybatis.selectList("Letter.sendLetterList", id);
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
}
