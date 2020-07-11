package kh.pingpong.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kh.pingpong.config.Configuration;
import kh.pingpong.dao.DiscussionDAO;
import kh.pingpong.dto.CommentDTO;
import kh.pingpong.dto.DiscussionDTO;
import kh.pingpong.dto.LanguageDTO;
import kh.pingpong.dto.LikeListDTO;
import kh.pingpong.dto.ReportListDTO;

@Service
public class DiscussionService {
	
	@Autowired
	DiscussionDAO disDao;
	
	// 토론 글쓰기 페이지에서 언어 목록 불러오기
	public List<LanguageDTO> langSelectlAll() throws Exception{
		return disDao.langSelectlAll();
	}
	
	// 토론 글 쓰기
	public int insert(DiscussionDTO disDTO) throws Exception{
		return disDao.insert(disDTO);
	}
	
	// 토론 전체 목록 가져오기
	public List<DiscussionDTO> selectAll(int cpage) throws Exception{
		Map<String, Object> search = new HashMap<>();
		int start = cpage * Configuration.DISCUSSION_COUNT_PER_PAGE - (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		
		search.put("start", start);
		search.put("end", end);			
		List<DiscussionDTO> list = disDao.selectAll(search);
		for(DiscussionDTO disDto : list) {
			String contents = disDto.getContents();
			String contReplace = contents.replaceAll("(<img.+\">)", "");
			disDto.setContents(contReplace);
		}		
		return list;
	}
	
	// 토론 키워드 목록 검색
	public List<DiscussionDTO> kewordSch(int cpage,Map<String, Object> search) throws Exception{
		int start = cpage * Configuration.DISCUSSION_COUNT_PER_PAGE - (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		search.put("start", start);
		search.put("end", end);		
		List<DiscussionDTO> list = disDao.kewordSch(search);
		for(DiscussionDTO disDto : list) {
			String contents = disDto.getContents();
			String contReplace = contents.replaceAll("(<img.+\">)", "");
			disDto.setContents(contReplace);
		}		
		return list;
	}
	
	// 토론 게시글 보기
	@Transactional("txManager")
	public DiscussionDTO selectOne(int seq, Boolean isGet) throws Exception{
		if(!isGet) {
			disDao.viewCount(seq);
		}
		return disDao.selectOne(seq);
	}

	// 토론 글 삭제
	public int delete(int seq) throws Exception{
		System.out.println("service" + seq);
		return disDao.delete(seq);
	}
	
	// 토론 글 수정하기
	public int modify(DiscussionDTO disDto) throws Exception{
		return disDao.modify(disDto);
	}
	
	//같은게시물 같은사람이 신고했는지
	public int report(ReportListDTO rldto) throws Exception{
		int result = disDao.report(rldto);
		return result;
	}
	
	//신고테이블에 저장
	public int reportProc(ReportListDTO rldto) throws Exception{
		int result = disDao.reportProc(rldto);
		return result;
	}
	
	
	// 게시글 좋아요 
	public int like(int seq) throws Exception{
		return disDao.like(seq);
	}
	
	// 게시글 좋아요 취소
	public int likedelete(int seq) throws Exception{
		return disDao.likedelete(seq);
	}
	
	// 댓글 쓰기
	public int commentInsert(CommentDTO commDTO) throws Exception{
		return disDao.commentInsert(commDTO);
	}
	
	// 토론 댓글 가져오기
	
	public List<CommentDTO> selectComment(int parent_Seq) throws Exception{
		return disDao.selectComment(parent_Seq);
	}
	
	// 댓글 좋아요 
	public int commentLike(int seq) throws Exception{
		return disDao.commentLike(seq);
	}
	
	// 댓글 좋아요 취소
	public int commentLikeCancel(int seq) throws Exception{
		return disDao.commentLikeCancel(seq);
	}
	// 댓글 싫아요 취소
	public int commentHateCancel(int seq) throws Exception{
		return disDao.commentHateCancel(seq);
	}
	
	
	// 댓글 싫어요
	public int commentHate(int seq) throws Exception{
		return disDao.commentHate(seq);
	}
	
	// 베스트 댓글
	public List<CommentDTO> bestComment(int seq) throws Exception{
		return disDao.bestComment(seq);
	}
	
	// 토론 댓글 삭제
	public int commentDelete(CommentDTO commDTO) throws Exception{
		return disDao.commentDelete(commDTO);
	}
	
	
	// 토론 리스트 검색 최신순 / 인기순
	public List<DiscussionDTO> searchAlign(String alignType, Map<String, Object> search, int cpage) throws Exception{
		int start = cpage * Configuration.DISCUSSION_COUNT_PER_PAGE - (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		search.put("start", start);
		search.put("end", end);	
		return disDao.searchAlign(alignType,search);
	}
	
	// 토론 더 보기 추천순
	public List<DiscussionDTO> moreList(int seq) throws Exception{
		return disDao.moreList(seq);
	}
	
	// 토론 상세페이지 번역을 위한 기준언어 가져오기
	public LanguageDTO langSelectlOne(String original_lang) throws Exception {
		return disDao.langSelectlOne(original_lang);
	}
	
	// 토론 게시글 페이징
	public String getPageNavi_discussion(int userCurrentPage, Map<String, Object> search) throws SQLException, Exception {
		int recordTotalCount = disDao.getArticleCount_discussion(search); 
		
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
		
		String type = (String)search.get("type");
		String keyword = (String)search.get("keyword");
		String align = (String)search.get("alignType");
		System.out.println("페이징 = "+type);
		System.out.println("페이징 = "+keyword);
		System.out.println("페이징 = "+align);
		
		if(align != null) {
			// 정렬
			if(needPrev) {
				sb.append("<li><a href='/discussion/align?cpage="+(startNavi-1)+"&align="+align+"&type="+type+"&keyword="+keyword+"'><</a></li>");
			}
			for(int i = startNavi ; i<=endNavi; i++) {
				if(userCurrentPage == i) {
					sb.append("<li class='on'><a href='/discussion/align?cpage="+i+"&align="+align+"&type="+type+"&keyword="+keyword+"'>"+i+"</a></li>");//
				}else {
					sb.append("<li><a href='/discussion/align?cpage="+i+"&align="+align+"&type="+type+"&keyword="+keyword+"'>"+i+"</a></li>");//
				}
			}
			if(needNext) {       
				sb.append("<li><a href='/discussion/align?cpage="+(endNavi+1)+"&align="+align+"&type="+type+"&keyword="+keyword+"'>></a></li>");
			}	
		}else {
			if(search.containsKey("keyword")) {
				// 키워드 검색시
				if(needPrev) {
					sb.append("<li><a href='/discussion/kewordSch?cpage="+(startNavi-1)+"&type="+type+"&keyword="+keyword+"'><</a></li>");
				}
				for(int i = startNavi ; i<=endNavi; i++) {
					if(userCurrentPage == i) {
						sb.append("<li class='on'><a href='/discussion/kewordSch?cpage="+i+"&type="+type+"&keyword="+keyword+"'>"+i+"</a></li>");//
					}else {
						sb.append("<li><a href='/discussion/kewordSch?cpage="+i+"&type="+type+"&keyword="+keyword+"'>"+i+"</a></li>");//
					}
				}
				if(needNext) {       
					sb.append("<li><a href='/discussion/kewordSch?cpage="+(endNavi+1)+"&type="+type+"&keyword="+keyword+"'>></a></li>");
				}
			}else {
				if(needPrev) {
					sb.append("<li><a href='/discussion/list?cpage="+(startNavi-1)+"'><</a></li>");
				}
				for(int i = startNavi ; i<=endNavi; i++) {
					if(userCurrentPage == i) {
						sb.append("<li class='on'><a href='/discussion/list?cpage="+i+"'>"+i+"</a></li>");//袁몃ŉ二쇰뒗 寃�
					}else {
						sb.append("<li><a href='/discussion/list?cpage="+i+"'>"+i+"</a></li>");//袁몃ŉ二쇰뒗 寃�
					}
				}
				if(needNext) {
					sb.append("<li><a href='/discussion/list?cpage="+(endNavi+1)+"'>></a></li>");
				}
			}
		}
		
		sb.append("</ul>");
		
		return sb.toString();
	}
	
	
	// 좋아요 체크
	public Boolean selectLike(Map<Object, Object> param) throws Exception {
		return disDao.selectLike(param);
	}
	
	// 좋아요 취소
	public int deletetLike(LikeListDTO ldto) throws Exception {
		return disDao.deleteLike(ldto);
	}
	
	// 싫어요 취소
	public int deletetHate(LikeListDTO ldto) throws Exception {
		return disDao.deletetHate(ldto);
	}
	
	// 싫어요 체크
	public Boolean selecHate(Map<Object, Object> param) throws Exception {
		return disDao.selecHate(param);
	}
	
	public int insertLike(LikeListDTO ldto) throws Exception {
		return disDao.insertLike(ldto);
	}
	
	public int insertHate(LikeListDTO ldto) throws Exception {
		return disDao.insertHate(ldto);
	}
	
}
