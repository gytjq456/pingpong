package kh.pingpong.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.pingpong.config.Configuration;
import kh.pingpong.dto.DeleteApplyDTO;
import kh.pingpong.dto.JjimDTO;
import kh.pingpong.dto.LessonDTO;
import kh.pingpong.dto.LikeListDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.ReportListDTO;
import kh.pingpong.dto.ReviewDTO;
import kh.pingpong.dto.TuteeDTO;
import kh.pingpong.dto.TutorAppDTO;

@Repository
public class TutorDAO {

	@Autowired
	private SqlSessionTemplate mybatis;
	
	public int tutorTrue(String id) throws Exception{
		return mybatis.selectOne("Tutor.tutorTrue", id);
	}
	
	public String passWhether(String id) throws Exception{
		return mybatis.selectOne("Tutor.passWhether", id);
	}
	
	public LessonDTO lessonView(int seq) throws Exception{
		return mybatis.selectOne("Tutor.lessonView", seq);
	}

	//리뷰 갯수랑 평점 업데이트
	public void reviewUpdate(ReviewDTO rdto) throws Exception{
		System.out.println(rdto.getParent_seq() + rdto.getCategory());
		Double reviewAvg = mybatis.selectOne("Tutor.reviewAvg", rdto);
		if(reviewAvg != null) {
			reviewAvg = mybatis.selectOne("Tutor.reviewAvg", rdto);
		}else {
			reviewAvg = 0.0;
		}
		int reviewCount = mybatis.selectOne("Tutor.reviewCount", rdto);
		Map<String, Object> paramVal = new HashMap<>();
		int seq = rdto.getParent_seq();
		paramVal.put("seq", seq);
		paramVal.put("reviewCount", reviewCount);
		paramVal.put("reviewAvg", reviewAvg);	
		mybatis.update("Tutor.groupReviewPoint",paramVal);		
		mybatis.update("Tutor.groupReviewCount",paramVal);
		
	}
	
	public int lessonCancleProc(DeleteApplyDTO dadto) throws Exception{
		return mybatis.insert("Tutor.lessonCancleProc", dadto);
	}
	
	//레슨 취소 신청 눌렀는지 판별 유무 
	public int lessonCancle(Map<Object, Object> param) throws Exception{
		return mybatis.selectOne("Tutor.lessonCancle", param);
	}
	
	public int updateViewCount(int seq) throws Exception{
		return mybatis.update("Tutor.updateViewCount", seq);
	}
	public int updateLikeCount(int seq) throws Exception{
		return mybatis.update("Tutor.updateLikeCount", seq);
	}
	
	public int likeTrue(LikeListDTO lldto) throws Exception{
		return mybatis.insert("Tutor.likeTrue", lldto);
	}
	
	public boolean LikeIsTrue(Map<Object,Object> param) throws Exception{
		 int result = mybatis.selectOne("Tutor.LikeIsTrue", param);
		 boolean checkLike=false;
		 
		 if(result>0) {
			 checkLike=true;
		 }
		 
		 return checkLike;
	}
	
	public int insertJjim(JjimDTO jdto) throws Exception{
		return mybatis.insert("Tutor.insertJjim",jdto);
	}
	
	public boolean JjimIsTrue(Map<Object, Object> param) throws Exception{
		int result = mybatis.selectOne("Tutor.JjimIsTrue", param);
		boolean checkJjim=false;
		
		if(result>0) {
			checkJjim=true;
		}
		return checkJjim;
	}
	//찜취소
	public int deleteJjim(JjimDTO jdto) throws Exception{
		return mybatis.delete("Tutor.deleteJjim", jdto);
	}
	
	//같은게시물에 같은사람이 신고했는지 확인
	public int report(ReportListDTO rldto) throws Exception{
		return mybatis.selectOne("Tutor.report", rldto);
	}
	
	//신고테이블에 저장
	public int reportProc(ReportListDTO rldto) throws Exception{
		return mybatis.insert("Tutor.reportProc", rldto);
	}
	
	//�뒠�꽣 �떊泥��꽌 insert
	public int insert(TutorAppDTO tadto) throws Exception{
		return mybatis.insert("Tutor.insert",tadto);
	}
	
	public int lessonAppProc(LessonDTO ldto) throws Exception{
		return mybatis.insert("Tutor.lessonAppProc", ldto);
	}
		
	public int lessonAppUpdateProc(LessonDTO ldto) throws Exception{
		System.out.println(ldto.getApply_end()+ ldto.getMax_num()+ldto.getSeq()+ldto.getCurriculum());
		return mybatis.update("Tutor.lessonAppUpdateProc", ldto);
	}
	
	public List<MemberDTO> tutorList(int cpage) throws Exception{
		int start = cpage*Configuration.RECORD_COUNT_PER_PAGE - (Configuration.RECORD_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.RECORD_COUNT_PER_PAGE - 1);
		
		Map<String, String> param = new HashMap<>();
		param.put("cpage", String.valueOf(cpage));
		param.put("start", String.valueOf(start));
		param.put("end", String.valueOf(end));
		
		return mybatis.selectList("Tutor.selectTutorList", param);
	}
	public int getArticleCount_tutor() throws SQLException, Exception {
		return mybatis.selectOne("Tutor.getArticleCount_tutor");
	}

	
	//--------------------------
	//이건 전체리스트 뽑는거
	public List<LessonDTO> lessonList(int cpage, String orderBy) throws Exception{
		int start = cpage*Configuration.RECORD_COUNT_PER_PAGE - (Configuration.RECORD_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.RECORD_COUNT_PER_PAGE - 1);
		
		Map<String, String> param = new HashMap<>();
		param.put("cpage", String.valueOf(cpage));
		param.put("start", String.valueOf(start));
		param.put("end", String.valueOf(end));
		param.put("orderBy", orderBy);
		
		return mybatis.selectList("Tutor.selectLessonList", param);
	}
	
	//모집중, 진행중, 마감 클릭했을 때 뽑는거. 
	public List<LessonDTO> lessonListPeriod(int cpage, Map<String, String> param) throws Exception{
		int start = cpage*Configuration.RECORD_COUNT_PER_PAGE - (Configuration.RECORD_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.RECORD_COUNT_PER_PAGE - 1);
		
		param.put("cpage", String.valueOf(cpage));
		param.put("start", String.valueOf(start));
		param.put("end", String.valueOf(end));
		
		return mybatis.selectList("Tutor.selectLessonListPeriod", param);
	}
	
	public int getArticleCount_lesson(Map<String, String> param) throws SQLException, Exception {
		return mybatis.selectOne("Tutor.getArticleCount_lesson",param);
	}
	
	//모집중 진행중 마감 시간에 따라 알아서 바뀌게하기 스케쥴러
	public int updateIngDate(Map<String, String> param) throws Exception{
		int resultApplying = mybatis.update("Tutor.updateApplying", param);
		int resultProceeding1 = mybatis.update("Tutor.updateProceeding1", param);
		int resultProcedding2 = mybatis.update("Tutor.updateProceeding2", param);
		return resultApplying + resultProceeding1 + resultProcedding2;
	}
	
	//키워드로 검색해서 리스트 뽑기
	public List<LessonDTO> search(int cpage, Map<String, String> param) throws Exception{
		int start = cpage*Configuration.RECORD_COUNT_PER_PAGE - (Configuration.RECORD_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.RECORD_COUNT_PER_PAGE - 1);
		
		param.put("cpage", String.valueOf(cpage));
		param.put("start", String.valueOf(start));
		param.put("end", String.valueOf(end));
		
		return mybatis.selectList("Tutor.search", param);
	}
	
	//튜티 insert
	public int tuteeInsert(TuteeDTO ttdto) throws Exception{
		return mybatis.insert("Tutor.tuteeInsert", ttdto);
	}
	
	//튜티 현재인원 늘리기
	public int tuteeCurnumCount(TuteeDTO ttdto) throws Exception{
		return mybatis.update("Tutor.tuteeCurnumCount", ttdto);
	}
	
	//튜티 현재인원 줄이기
	public int tuteeCurnumCountMinus(TuteeDTO ttdto) throws Exception{
		return mybatis.update("Tutor.tuteeCurnumCountMinus", ttdto);
	}
	
	//결제한 사람이 또 결제하는지
	public int payTrue(TuteeDTO ttdto) throws Exception{
		return mybatis.selectOne("Tutor.payTrue", ttdto);
	}
	
	//결제 취소한사람이 또 취소하는지
	public int refundTrue(TuteeDTO ttdto) throws Exception{
		return mybatis.selectOne("Tutor.refundTrue", ttdto);
	}

	//강위취소 튜티 환불금액 update 하고 강의 취소 'Y'로 바꾸기
	public int refundInsert(TuteeDTO ttdto) throws Exception{
		return mybatis.update("Tutor.refundInsert", ttdto);
	}
}
