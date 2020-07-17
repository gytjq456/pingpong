package kh.pingpong.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kh.pingpong.config.Configuration;
import kh.pingpong.dao.CorrectDAO;
import kh.pingpong.dto.CorrectDTO;
import kh.pingpong.dto.Correct_CommentDTO;
import kh.pingpong.dto.JjimDTO;
import kh.pingpong.dto.LanguageDTO;
import kh.pingpong.dto.LikeListDTO;
import kh.pingpong.dto.ReportListDTO;

@Service
public class CorrectService {
	@Autowired
	private CorrectDAO dao;

	public List<LanguageDTO> langSelectlAll() throws Exception{
		return dao.langSelectlAll();
	}

	public LanguageDTO langSelectlOne(String original_lang) throws Exception {
		return dao.langSelectlOne(original_lang);
	}

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

	public int comment_like(LikeListDTO ldto) throws Exception {
		return dao.comment_like(ldto);
	}

	public int comment_likecancle(LikeListDTO ldto) throws Exception {
		return dao.comment_likecancle(ldto);
	}

	public boolean commentLikeIsTrue(Map<String, Object> param2) throws Exception {
		boolean result =dao.comment_LikeIsTrue(param2);
		return result;
	}

	public int comment_likecount(LikeListDTO ldto) throws Exception {
		return dao.comment_likecount(ldto);
	}


	public int countrep(Correct_CommentDTO cdto) throws Exception {
		return dao.countrep(cdto);
	}

	public int countupdate(Correct_CommentDTO cdto) throws Exception {
		return dao.countupdate(cdto);
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

	public int comment_reportProc(ReportListDTO rldto) throws Exception{
		int result = dao.comment_reportProc(rldto);
		return result;
	}
	public String correct_paging (int userCurrentPage) throws Exception {
		int recordTotalCount = dao.correctcount(); 
		System.out.println(recordTotalCount);
		int pageTotalCount = 0;

		if(recordTotalCount % 10 > 0) {
			pageTotalCount = recordTotalCount / 10 + 1;

		}else {
			pageTotalCount = recordTotalCount / 10;
		}

		int currentPage = userCurrentPage;
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

	public int comment_like_update(int comm_seq) throws Exception {
		return dao.comment_like_update(comm_seq);
	}
	
	public int comment_likecancle_update(int comm_seq) throws Exception {
		return dao.comment_likecancle_update(comm_seq);
	}

}
