package kh.pingpong.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kh.pingpong.dao.DiscussionDAO;
import kh.pingpong.dto.CommentDTO;
import kh.pingpong.dto.DiscussionDTO;
import kh.pingpong.dto.LanguageDTO;

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
	public List<DiscussionDTO> selectAll() throws Exception{
		List<DiscussionDTO> list = disDao.selectAll();
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
		return disDao.delete(seq);
	}
	
	// 토론 글 수정하기
	public int modify(DiscussionDTO disDto) throws Exception{
		return disDao.modify(disDto);
	}
	
	
	// 게시글 좋아요 
	public int like(int seq) throws Exception{
		return disDao.like(seq);
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
	public List<DiscussionDTO> searchAlign(String alignType){
		return disDao.searchAlign(alignType);
	}
	
	// 토론 더 보기 추천순
	public List<DiscussionDTO> moreList(int seq){
		return disDao.moreList(seq);
	}
	
	
}
