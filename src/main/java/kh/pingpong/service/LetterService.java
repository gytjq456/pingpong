package kh.pingpong.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kh.pingpong.dao.LetterDAO;
import kh.pingpong.dto.LetterDTO;

@Service
public class LetterService {
	@Autowired
	private LetterDAO ldao;
	
	// 쪽지 생성
	@Transactional("txManager")
	public int insertLetter(LetterDTO ldto) throws Exception {
		ldao.insertSendLetter(ldto);
		return ldao.insertReceiveLetter(ldto);
	}
	
	// 보낸 쪽지/받은 쪽지 리스트
	public List<LetterDTO> receiveLetterList(String id) throws Exception {
		return ldao.receiveLetterList(id);
	}

	public List<LetterDTO> sendLetterList(String id) throws Exception {
		return ldao.sendLetterList(id);
	}
	
	// 쪽지 뷰
	public LetterDTO receiveLetterView(int seq) throws Exception {
		return ldao.receiveLetterView(seq);
	}

	public LetterDTO sendLetterView(int seq) throws Exception {
		return ldao.sendLetterView(seq);
	}
	
	// 쪽지 삭제
	public int deleteReceiveLetter(int seq) throws Exception {
		return ldao.deleteReceiveLetter(seq);
	}
	
	public int deleteSendLetter(int seq) throws Exception {
		return ldao.deleteSendLetter(seq);
	}
	
	// 쪽지 읽음 전환
	@Transactional("txManager")
	public int updateRead(int seq) throws Exception {
		ldao.updateSendRead(seq);
		return ldao.updateReceiveRead(seq);
	}
}
