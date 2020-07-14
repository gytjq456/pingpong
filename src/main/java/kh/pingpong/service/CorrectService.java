package kh.pingpong.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kh.pingpong.config.Configuration;
import kh.pingpong.dao.CorrectDAO;
import kh.pingpong.dto.CommentDTO;
import kh.pingpong.dto.Correct_CommentDTO;
import kh.pingpong.dto.CorrectDTO;
import kh.pingpong.dto.JjimDTO;
import kh.pingpong.dto.LikeListDTO;
import kh.pingpong.dto.ReportListDTO;

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

	public List<CorrectDTO> selectAll(int cpage) throws Exception{
		List<CorrectDTO> list = dao.selectAll(cpage);
		for(CorrectDTO dto : list) {
			String contents = dto.getContents();
			String contReplace = contents.replaceAll("(<img.+\">)", "");
			dto.setContents(contReplace);
		}		
		return list;
	}
	@Transactional("txManager")
	public CorrectDTO selectOne(int seq) throws Exception{
		return dao.selectOne(seq);
	}

	public CorrectDTO viewcount(int seq,boolean in) throws Exception{
		if(!in) {
			dao.viewcount(seq);
		}
		return dao.selectOne(seq);
	}

	public int commentInsert(Correct_CommentDTO cdto) throws Exception{
		return dao.commentInsert(cdto);
	}

	public List<Correct_CommentDTO> selectcAll(int parent_seq) throws Exception{
		return dao.selectc(parent_seq);
	}

	public List<Correct_CommentDTO> bestcomm(int parent_seq) throws Exception{
		return dao.bestcomm(parent_seq);
	}

	public int modify(CorrectDTO dto) throws Exception{
		return dao.modify(dto);
	}

	public int like(LikeListDTO ldto) throws Exception {
		return dao.like(ldto);
	}

	public int likecancle(LikeListDTO ldto) throws Exception {
		return dao.likecancle(ldto);
	}

	public boolean LikeIsTrue(LikeListDTO ldto) throws Exception {
		boolean result =dao.LikeIsTrue(ldto);
		return result;
	}

	public int likecount(LikeListDTO ldto) throws Exception {
		return dao.likecount(ldto);
	}


	public int countrep(Correct_CommentDTO cdto) throws Exception {
		return dao.countrep(cdto);
	}

	public int delete(CorrectDTO dto) throws Exception {
		return dao.delete(dto);
	}


	public int commentDelete(Correct_CommentDTO cdto) throws Exception{
		return dao.commentDelete(cdto);
	}
	
	public int selectReport(ReportListDTO rldto) {
		return dao.selectReport(rldto);
	}
	public int insertReport(ReportListDTO rldto) {
		return dao.insertReport(rldto);
	}
	
	public int comment_report(ReportListDTO rldto) throws Exception{
		int result = dao.comment_report(rldto);
		return result;
	}
	
	//신고테이블에 저장
	public int comment_reportProc(ReportListDTO rldto) throws Exception{
		int result = dao.comment_reportProc(rldto);
		return result;
	}
	public String correct_paging (int userCurrentPage) throws Exception {
		int recordTotalCount = dao.correctcount(); 
		System.out.println(recordTotalCount);
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
				sb.append("<li class='on'><a href='/correct/correct_list?cpage="+i+"'>"+i+"</a></li>");
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
