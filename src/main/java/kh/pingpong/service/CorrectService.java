package kh.pingpong.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kh.pingpong.config.Configuration;
import kh.pingpong.dao.CorrectDAO;
import kh.pingpong.dto.CorrectCDTO;
import kh.pingpong.dto.CorrectDTO;

@Service
public class CorrectService {
	@Autowired
	private CorrectDAO dao;
	
//	@Transactional("txManager")
//	public void correctWrite(correct_dto dto) throws Exception{
//		dto.setSeq(cdao.getSeq());
//		cdao.insert(dto);
//		
//	}]
	public int insert(CorrectDTO dto) throws Exception {
		return dao.insert(dto);
	}
	
	public List<CorrectDTO> selectAll() throws Exception{
		List<CorrectDTO> list = dao.selectAll();
		for(CorrectDTO disDto : list) {
			String contents = disDto.getContents();
			String contReplace = contents.replaceAll("(<img.+\">)", "");
			disDto.setContents(contReplace);
		}		
		return list;
	}
	@Transactional("txManager")
	public CorrectDTO selectOne(int seq, Boolean in) throws Exception{
		if(!in) {
			dao.viewcount(seq);
		}
		return dao.selectOne(seq);
	}
	public int commentInsert(CorrectCDTO cdto) throws Exception{
		return dao.commentInsert(cdto);
	}
	
	public List<CorrectCDTO> selectcAll(int parent_seq) throws Exception{
		return dao.selectc(parent_seq);
	}
	
	public List<CorrectCDTO> bestcomm(int parent_seq) throws Exception{
		return dao.bestcomm(parent_seq);
	}
	
	public int modify(CorrectDTO dto) throws Exception{
		return dao.modify(dto);
	}
	
	public int like(CorrectDTO dto) throws Exception {
		return dao.like(dto);
	}
	public int hate(CorrectDTO dto) throws Exception {
		return dao.hate(dto);
	}
	
	public int commentlike(CorrectDTO dto) throws Exception {
		return dao.commentlike(dto);
	}
	public int commenthate(CorrectDTO dto) throws Exception {
		return dao.commenthate(dto);
	}
	
	public int countrep(CorrectCDTO cdto) throws Exception {
		return dao.countrep(cdto);
	}
	
	public int delete(CorrectDTO dto) throws Exception {
		return dao.delete(dto);
	}
	public String correct_paging (int userCurrentPage) throws Exception {
		int recordTotalCount = dao.correctcount(); 
		
		int pageTotalCount = 0; // 모든 페이지 개수
		
		if(recordTotalCount % 10 > 0) {
			pageTotalCount = recordTotalCount / 10 + 1;
			//게시글 개수를 페이지당 게시글로 나누어 나머지 값이 있으면 한 페이지를 더한다.
		}else {
			pageTotalCount = recordTotalCount / 10;
		}
		
		int currentPage = userCurrentPage;//현재 내가 위치한 페이지 번호.	클라이언트 요청값
		//공격자가 currentPage를 변조할 경우에 대한 보안처리
		if(currentPage < 1) {
			currentPage = 1;
		}else if(currentPage > pageTotalCount) {
			currentPage = pageTotalCount;
		}
		
		int startNavi = (currentPage - 1) / Configuration.NAVI_COUNT_PER_PAGE * Configuration.NAVI_COUNT_PER_PAGE + 1;
		
		int endNavi = startNavi + Configuration.NAVI_COUNT_PER_PAGE - 1;
		
		if(endNavi > pageTotalCount) {endNavi = pageTotalCount;}
		
		boolean needPrev = true;
		boolean needNext = true;
		
		if(startNavi == 1) {needPrev = false;}
		if(endNavi == pageTotalCount) {needNext = false;}		
		
		StringBuilder sb = new StringBuilder();
		sb.append("<ul>");
		if(needPrev) {
			sb.append("<li><a href='/correct/correct_list?cpage="+(startNavi-1)+"'><</a></li>");
		}
		for(int i = startNavi ; i<=endNavi; i++) {
			if(userCurrentPage == i) {
				sb.append("<li class='on'><a href='/correct/correct_list?cpage="+i+"'>"+i+"</a></li>");//袁몃ŉ二쇰뒗 寃�
			}else {
				sb.append("<li><a href='/correct/correct_list?cpage="+i+"'>"+i+"</a></li>");
			}
		}
		if(needNext) {
			sb.append("<li><a href='/correct/correct_list?cpage="+(endNavi+1)+"'>></a></li>");
		}
		sb.append("</ul>");
		
		return sb.toString();
	}
	

}
