package kh.pingpong.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import kh.pingpong.config.Configuration;
import kh.pingpong.dto.CommentDTO;
import kh.pingpong.dto.DiscussionDTO;
import kh.pingpong.dto.LanguageDTO;
import kh.pingpong.dto.LikeListDTO;


@Repository
public class DiscussionDAO {

	@Autowired
	private SqlSessionTemplate mybatis;

	// 토론 글쓰기 페이지에서 언어 목록 불러오기
	public List<LanguageDTO> langSelectlAll() {
		return mybatis.selectList("Discussion.languageList");
	}

	// 토론 글 쓰기
	public int insert(DiscussionDTO disDTO) throws Exception{
		return mybatis.insert("Discussion.insert",disDTO);
	}

	// 토론 전체 목록 가져오기
	public List<DiscussionDTO> selectAll(Map<String, Object> search) throws Exception{
		List<DiscussionDTO> result = mybatis.selectList("Discussion.selectAll",search);
		return result;
	} 
	// 토론 키워드 목록 검색 
	public List<DiscussionDTO> kewordSch(Map<String, Object> search) throws Exception{
		List<DiscussionDTO> result = mybatis.selectList("Discussion.kewordSch",search);
		return result;
	} 

	// 토론 게시글 보기
	public DiscussionDTO selectOne(int seq) throws Exception{

		return mybatis.selectOne("Discussion.selectOne", seq);
	}

	//조회수
	public int viewCount(int seq) throws Exception{
		return mybatis.update("Discussion.viewCount",seq);
	}	

	// 토론 게시글 삭제
	public int delete(int seq) throws Exception {
		System.out.println("daop" + seq);
		return mybatis.delete("Discussion.delete", seq);
	}

	// 토론 글 수정
	public int modify(DiscussionDTO disDto) throws Exception{
		return mybatis.update("Discussion.modify",disDto);
	}

	// 댓글 좋아요
	public int like(int seq) throws Exception{
		return mybatis.update("Discussion.like",seq);
	}
	// 댓글 좋아요 취소
	public int likedelete(int seq) throws Exception{
		return mybatis.update("Discussion.likedelete",seq);
	}

	// 댓글 쓰기
	@Transactional("txManager")
	public int commentInsert(CommentDTO commDTO) throws Exception{
		int writeResult = mybatis.insert("Discussion.commentInsert",commDTO);
		int commentCount = mybatis.selectOne("Discussion.commentCount",commDTO.getParent_seq());
		System.out.println(commentCount);
		Map<String, Integer> result = new HashMap<>();
		result.put("parent_seq", commDTO.getParent_seq());
		result.put("commentCount", commentCount);	
		mybatis.update("Discussion.disCommentCount", result);
		return writeResult;
	}

	// 댓글 가져오기
	public List<CommentDTO> selectComment(int parent_Seq) throws Exception{
		return mybatis.selectList("Discussion.selectComment",parent_Seq);
	}


	// 댓글 좋아요
	public int commentLike(int seq) throws Exception{
		return mybatis.update("Discussion.commentLike",seq);
	}
	// 댓글 좋아요 취소
	public int commentLikeCancel(int seq) throws Exception{
		return mybatis.update("Discussion.commentLikeCancel",seq);
	}
	// 댓글 싫어요 취소
	public int commentHateCancel(int seq) throws Exception{
		return mybatis.update("Discussion.commentHateCancel",seq);
	}

	// 댓글 싫아요
	public int commentHate(int seq) throws Exception{
		return mybatis.update("Discussion.commentHate",seq);
	}

	// 베스트 댓글
	public List<CommentDTO> bestComment(int seq) throws Exception{
		return mybatis.selectList("Discussion.bestComment",seq);
	}

	// 댓글 삭제
	public int commentDelete(CommentDTO commDTO) throws Exception{
		int deleteResult = mybatis.delete("Discussion.commentDelete",commDTO.getSeq());
		int commentCount = mybatis.selectOne("Discussion.commentCount",commDTO.getSeq());
		Map<String, Integer> result = new HashMap<>();
		result.put("parent_seq", commDTO.getParent_seq());
		result.put("commentCount", commentCount);
		mybatis.update("Discussion.disCommentCount", result);
		return deleteResult;
	}

	// 토론 리스트 검색 최신순 / 인기순
	public List<DiscussionDTO> searchAlign(String alignType, Map<String, Object> search){
		return mybatis.selectList("Discussion.alignType", search);
	}

	// 토론 더 보기 추천순a
	public List<DiscussionDTO> moreList(int seq){
		return mybatis.selectList("Discussion.moreList", seq);
	}
	
	
	// 토론 상세페이지 번역을 위한 기준언어 가져오기
	public LanguageDTO langSelectlOne(String original_lang) throws Exception {
		return mybatis.selectOne("Discussion.langSelectlOne", original_lang);
	}
	
	
	// 토론 게시글 페이징
	public int getArticleCount_discussion(Map<String, Object> search) throws Exception{
		return mybatis.selectOne("Discussion.getArticleCount_discussion",search);
	}
	
	// like_list insert
	// 좋아요 
	public int insertLike(LikeListDTO ldto) throws Exception{
		return mybatis.insert("Discussion.insertLike",ldto);
	}
	
	// 좋아요 취소
	public int deleteLike(LikeListDTO ldto) throws Exception{
		return mybatis.delete("Discussion.deletetLike",ldto);
	}
	
	// 싫어요
	public int insertHate(LikeListDTO ldto) throws Exception{
		return mybatis.insert("Discussion.insertHate",ldto);
	}
	// 싫어요 취소
	public int deletetHate(LikeListDTO ldto) throws Exception{
		return mybatis.delete("Discussion.deletetHate",ldto);
	}
	
	public Boolean selectLike(Map<Object, Object> param) throws Exception{
		Integer result = mybatis.selectOne("Discussion.selectLike", param);
		boolean checkLike = true;
		if (result == null) {
			checkLike = false;
		}
		
		return checkLike;
	}
	public Boolean selecHate(Map<Object, Object> param) throws Exception{
		Integer result = mybatis.selectOne("Discussion.selecHate", param);
		boolean checkLike = true;
		if (result == null) {
			checkLike = false;
		}
		
		return checkLike;
	}
	
	
	
}
