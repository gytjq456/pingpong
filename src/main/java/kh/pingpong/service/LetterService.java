package kh.pingpong.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kh.pingpong.config.Configuration;
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
	public List<LetterDTO> receiveLetterList(Map<String, Object> param) throws Exception {
		return ldao.receiveLetterList(param);
	}

	public List<LetterDTO> sendLetterList(Map<String, Object> param) throws Exception {
		return ldao.sendLetterList(param);
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
	
	// 여러 쪽지 삭제
	public int deleteSelected(Map<String, Object> param) throws Exception {
		return ldao.deleteSelected(param);
	}
	
	// 페이징
	public String getPageNav(int currentPage, String tableName) throws Exception{
		// 총 게시물
		int recordTotalCount = ldao.selectCount(tableName);

		int pageTotalCount = 0; //전체페이지 개수

		if(recordTotalCount % Configuration.LETTER_COUNT_PER_PAGE > 0) {
			pageTotalCount = recordTotalCount / Configuration.LETTER_COUNT_PER_PAGE + 1;
		}else {
			pageTotalCount = recordTotalCount / Configuration.LETTER_COUNT_PER_PAGE;
		}

		if(currentPage < 1) {
			currentPage = 1;
		}else if(currentPage > pageTotalCount) {
			currentPage = pageTotalCount;
		}

		int startNav = (currentPage - 1) / Configuration.LETTER_NAVI_COUNT_PER_PAGE * Configuration.LETTER_NAVI_COUNT_PER_PAGE + 1;
		int endNav = startNav + Configuration.LETTER_NAVI_COUNT_PER_PAGE - 1;
		if(endNav > pageTotalCount) {
			endNav = pageTotalCount;
		} 

		boolean needPrev = true;
		boolean needNext = true;	

		if(startNav == 1) {
			needPrev = false;
		}
		if(endNav == pageTotalCount) {
			needNext = false;
		}					

		StringBuilder sb = new StringBuilder();
		sb.append("<ul>");
		if(needPrev) {
			sb.append("<li><a href='/mypage/letter?cpage=" + (startNav - 1) + "' id='prevPage'><</a></li>");
		}

		for(int i=startNav; i<= endNav; i++) {
			if(currentPage == i) {
				sb.append("<li class='on'><a href='/mypage/letter?cpage=" + i + "'>" + i + "</a></li>");
			}else {
				sb.append("<li><a href='/mypage/letter?cpage=" + i + "'>" + i + "</a></li>");
			}
		}

		if(needNext) {
			sb.append("<li><a href='/mypage/letter?cpage=" + (endNav + 1) + "' id='prevPage'>></a></li>");
		}
		sb.append("</ul>");

		return sb.toString();

	}
}
