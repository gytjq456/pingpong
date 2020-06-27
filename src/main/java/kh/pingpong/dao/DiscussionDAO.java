package kh.pingpong.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import kh.pingpong.dto.CommentDTO;
import kh.pingpong.dto.DiscussionDTO;
import kh.pingpong.dto.LanguageDTO;


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
	public List<DiscussionDTO> selectAll() throws Exception{
		List<DiscussionDTO> result = mybatis.selectList("Discussion.selectAll");
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
	
	// 댓글 쓰기
	@Transactional("txManager")
	public int commentInsert(CommentDTO commDTO) throws Exception{
		mybatis.update("Discussion.disCommentCount", commDTO);
		return mybatis.insert("Discussion.commentInsert",commDTO);
	}
	
	// 댓글 가져오기
	public List<CommentDTO> selectComment(int parent_Seq) throws Exception{
		return mybatis.selectList("Discussion.selectComment",parent_Seq);
	}
	
	
	// 댓글 좋아요
	public int commentLike(int seq) throws Exception{
		return mybatis.update("Discussion.commentLike",seq);
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
	public int commentDelete(int seq) throws Exception{
		return mybatis.delete("Discussion.commentDelete",seq);
	}
	
}
