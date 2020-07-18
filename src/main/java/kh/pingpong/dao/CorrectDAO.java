package kh.pingpong.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import kh.pingpong.dto.CommentDTO;
import kh.pingpong.dto.Correct_CommentDTO;
import kh.pingpong.dto.DiscussionDTO;
import kh.pingpong.dto.CorrectDTO;
import kh.pingpong.dto.JjimDTO;
import kh.pingpong.dto.LanguageDTO;
import kh.pingpong.dto.LikeListDTO;
import kh.pingpong.dto.ReportListDTO;

@Repository
public class CorrectDAO {

	@Autowired
	private SqlSessionTemplate mybatis;

	public List<LanguageDTO> langSelectlAll() {
		return mybatis.selectList("Correct.languageList");
	}
	
	public List<CorrectDTO> moreList(int seq){
		return mybatis.selectList("Correct.moreList", seq);
	}

	public LanguageDTO langSelectlOne(String original_lang) throws Exception {
		return mybatis.selectOne("Correct.langSelectlOne", original_lang);
	}

	public int insert(CorrectDTO dto) throws Exception {
		return mybatis.insert("Correct.insert", dto);
	}

	public List<CorrectDTO> selectAll(int cpage) throws Exception{

		Map <String, Integer> param = new HashMap<>();
		int start =cpage * 10 - (10-1);
		int end = start + (10-1);
		param.put("start", start);
		param.put("end", end);
		return mybatis.selectList("Correct.selectAll", param);

	} 

	public CorrectDTO selectOne(int seq) throws Exception{
		return mybatis.selectOne("Correct.selectOne", seq);
	}

	@Transactional("txManager")
	public int commentInsert(Correct_CommentDTO cdto) throws Exception{
		return mybatis.insert("Correct.commentInsert",cdto);
	}
	public List<Correct_CommentDTO> selectc(int parent_seq) throws Exception{
		return mybatis.selectList("Correct.selectc",parent_seq);
	} 

	public List<Correct_CommentDTO> bestcomm(int parent_seq) throws Exception{
		return mybatis.selectList("Correct.best",parent_seq);
	} 

	public int viewcount(int seq) throws Exception {
		return mybatis.update("Correct.viewcount",seq);
	}
	public int modify(CorrectDTO dto) throws Exception{
		return mybatis.update("Correct.modify",dto);
	}

	public int comment_like(LikeListDTO ldto) throws Exception{
		return mybatis.insert("Correct.comment_like",ldto);
	}

	public int comment_likecancle(LikeListDTO ldto) throws Exception{
		return mybatis.delete("Correct.comment_likecancle",ldto);
	}

	public boolean comment_LikeIsTrue(Map<String, Object> param2) throws Exception{
		int result = mybatis.selectOne("Correct.comment_LikeIsTrue", param2);
		boolean comment_checkLike=false;
		System.out.println("result :"+result);
		if(result>0) {
			comment_checkLike=true;
		}

		return comment_checkLike;
	}

	public int comment_likecount(LikeListDTO ldto) throws Exception {
		return mybatis.selectOne("Correct.comment_likecount", ldto);
	}

	public int correctcount() throws Exception{
		return mybatis.selectOne("Correct.correctcount");
	}

	public int countrep(Correct_CommentDTO cdto) throws Exception {
		return mybatis.update("Correct.countrep",cdto);
	}

	public int countupdate(Correct_CommentDTO cdto) throws Exception {
		return mybatis.update("Correct.countupdate",cdto);
	}

	public int delete(CorrectDTO dto) throws Exception {
		return mybatis.delete("Correct.delete",dto);
	}

	public int commentDelete(Correct_CommentDTO cdto) throws Exception{
		return mybatis.delete("Correct.commentDelete",cdto);
	}

	public int selectReport(ReportListDTO rldto) {
		return mybatis.selectOne("Correct.selectReport", rldto);
	}

	public int insertReport(ReportListDTO rldto) {
		return mybatis.insert("Correct.insertReport", rldto);
	}

	public int comment_report(ReportListDTO rldto) throws Exception{
		return mybatis.selectOne("Correct.comment_report", rldto);
	}

	public int comment_reportProc(ReportListDTO rldto) throws Exception{
		return mybatis.insert("Correct.comment_reportProc", rldto);
	}

	public int comment_like_update(int comm_seq) throws Exception {
		return mybatis.update("Correct.comment_like_update", comm_seq);
	}
	
	public int comment_likecancle_update(int comm_seq) throws Exception {
		return mybatis.update("Correct.comment_likecancle_update", comm_seq);
	}


}
