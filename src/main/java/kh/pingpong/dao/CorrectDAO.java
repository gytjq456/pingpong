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
import kh.pingpong.dto.CorrectDTO;
import kh.pingpong.dto.JjimDTO;
import kh.pingpong.dto.LikeListDTO;
import kh.pingpong.dto.ReportListDTO;

@Repository
public class CorrectDAO {

	@Autowired
	private SqlSessionTemplate mybatis;

	//	public int getSeq() throws Exception{
	//		return mybatis.selectOne("correct.nextSeq");
	//	}

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
		//	mybatis.update("Correct.CommentCount", dto);
		return mybatis.insert("Correct.commentInsert",cdto);
	}
	public List<Correct_CommentDTO> selectc(int parent_seq) throws Exception{
		return mybatis.selectList("Correct.selectc",parent_seq);
	} 

	public List<Correct_CommentDTO> bestcomm(int parent_seq) throws Exception{
		return mybatis.selectList("Correct.selectc2",parent_seq);
	} 

	public int viewcount(int seq) throws Exception {
		return mybatis.update("Correct.viewcount",seq);
	}
	public int modify(CorrectDTO dto) throws Exception{
		return mybatis.update("Correct.modify",dto);
	}
	//	public int select(correct_dto dto) throws Exception {
	//		return mybatis.select("Correct.select", dto);
	//	}

	public int like(LikeListDTO ldto) throws Exception{
		return mybatis.insert("Correct.like",ldto);
	}
	public int likecancle(LikeListDTO ldto) throws Exception{
		return mybatis.delete("Correct.likecancle",ldto);
	}

	public boolean LikeIsTrue(LikeListDTO ldto) throws Exception{
		Integer result = mybatis.selectOne("Correct.LikeIsTrue", ldto);
		boolean checkLike=false;

		if(result>0) {
			checkLike=true;
		}

		return checkLike;
	}

	public int likecount(LikeListDTO ldto) throws Exception {
		return mybatis.selectOne("Correct.likecount", ldto);
	}

	public int correctcount() throws Exception{
		return mybatis.selectOne("Correct.correctcount");
	}

	public int countrep(Correct_CommentDTO cdto) throws Exception {
		return mybatis.update("Correct.countrep",cdto);
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

	//신고테이블에 저장
	public int comment_reportProc(ReportListDTO rldto) throws Exception{
		return mybatis.insert("Correct.comment_reportProc", rldto);
	}

	// likecount
	public int likecountAdd(CorrectDTO dto) throws Exception{
		System.out.println(dto.getSeq());
		return mybatis.update("Correct.likecountAdd", dto);
	}
	public int likecountMinus(CorrectDTO dto) throws Exception{
		System.out.println(dto.getSeq());
		return mybatis.update("Correct.likecountMinus", dto);
	}
	
	
}
