package kh.pingpong.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.pingpong.config.Configuration;
import kh.pingpong.dto.DeleteApplyDTO;
import kh.pingpong.dto.GroupApplyDTO;
import kh.pingpong.dto.GroupDTO;
import kh.pingpong.dto.GroupMemberDTO;
import kh.pingpong.dto.HobbyDTO;
import kh.pingpong.dto.JjimDTO;
import kh.pingpong.dto.LikeListDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.ReportListDTO;
import kh.pingpong.dto.ReviewDTO;

@Repository
public class GroupDAO {
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public List<HobbyDTO> selectHobby() {
		return mybatis.selectList("Group.selectHobby");
	}
	
	public int insertGroup(GroupDTO gdto) throws ParseException {
		String start_date = gdto.getStart_date();
		String end_date = gdto.getEnd_date();

		SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");

		Date start = fm.parse(start_date);
		Date end = fm.parse(end_date);
		
		Date today = new Date();
		
		if (start.getTime() - today.getTime() > 0) {
			gdto.setProceeding("B");
		} else {
			gdto.setProceeding("Y");
		}
		
		// Date로 변환된 두 날짜를 계산한 뒤 그 리턴값으로 long type 변수를 초기화 하고 있다.
        // 연산결과 -950400000. long type 으로 return 된다.
        long calDate = start.getTime() - end.getTime(); 
        
        // Date.getTime() 은 해당날짜를 기준으로1970년 00:00:00 부터 몇 초가 흘렀는지를 반환해준다. 
        // 이제 24*60*60*1000(각 시간값에 따른 차이점) 을 나눠주면 일수가 나온다.
        long calDateDays = calDate / (24 * 60 * 60 * 1000); 
 
        calDateDays = Math.abs(calDateDays);
        
        if (calDateDays >= 365) {
        	gdto.setPeriod("장기");
        } else {
        	gdto.setPeriod("단기");
        }
        System.out.println(gdto.getWriter_id());

		return mybatis.insert("Group.insert", gdto);
	}
	
	public GroupDTO selectBySeq(int seq) throws Exception{
		Double reviewAvg = mybatis.selectOne("Group.reviewAvg", seq);
		if(reviewAvg != null) {
			reviewAvg = mybatis.selectOne("Group.reviewAvg", seq);
		}else {
			reviewAvg = 0.0;
		}
		int reviewCount = mybatis.selectOne("Group.reviewCount", seq);
		Map<String, Object> paramVal = new HashMap<>();
		paramVal.put("seq", seq);
		paramVal.put("reviewCount", reviewCount);
		paramVal.put("reviewAvg", reviewAvg);	
		mybatis.update("Group.groupReviewPoint",paramVal);		
		mybatis.update("Group.groupReviewCount",paramVal);
		return mybatis.selectOne("Group.selectBySeq", seq);
	}
	
	public int searchSeq(String writer_id) {
		return mybatis.selectOne("Group.searchSeq", writer_id);
	}
	
	public int delete(int seq) {
		return mybatis.delete("Group.delete", seq);
	}
	
	public int update(GroupDTO gdto) throws ParseException {
		String start_date = gdto.getStart_date();
		String end_date = gdto.getEnd_date();

		SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");

		Date start = fm.parse(start_date);
		Date end = fm.parse(end_date);
		
		// Date로 변환된 두 날짜를 계산한 뒤 그 리턴값으로 long type 변수를 초기화 하고 있다.
        // 연산결과 -950400000. long type 으로 return 된다.
        long calDate = start.getTime() - end.getTime(); 
        
        // Date.getTime() 은 해당날짜를 기준으로1970년 00:00:00 부터 몇 초가 흘렀는지를 반환해준다. 
        // 이제 24*60*60*1000(각 시간값에 따른 차이점) 을 나눠주면 일수가 나온다.
        long calDateDays = calDate / (24 * 60 * 60 * 1000); 
 
        calDateDays = Math.abs(calDateDays);
        
        if (calDateDays >= 365) {
        	gdto.setPeriod("장기");
        } else {
        	gdto.setPeriod("단기");
        }
        
		return mybatis.update("Group.update", gdto);
	}
	
	public int selectCount() {
		return mybatis.selectOne("Group.selectCount");
	}
	
	public int updateViewCount(int seq) {
		return mybatis.update("Group.updateViewCount", seq);
	}
	
	public int insertApp(GroupApplyDTO gadto) {
		return mybatis.insert("Group.insertApp", gadto);
	}
	
	public int selectApplySeq(GroupApplyDTO gadto) {
		return mybatis.selectOne("Group.selectApplyForm", gadto);
	}
	
	public int cancelApply(int seq) {
		return mybatis.delete("Group.deleteApplyForm", seq);
	}
	
	public boolean selectApplyForm(GroupApplyDTO gadto) {
		Integer result = mybatis.selectOne("Group.selectApplyForm", gadto);
		boolean checkApply = true;
		if (result == null) {
			checkApply = false;
		}
		return checkApply;
	}
	
	public List<GroupMemberDTO> selectGroupMemberList(int parent_seq) {
		return mybatis.selectList("Group.selectGroupMemberList", parent_seq);
	}
	
	public boolean selectGroupMemberById(GroupMemberDTO gmdto) {
		Integer result = mybatis.selectOne("Group.selectGroupMemberById", gmdto);
		boolean checkMember = true;
		if (result == null) {
			checkMember = false;
		}
		return checkMember;
	}
	
	public int updateGroupMemberOut(int seq) {
		return mybatis.update("Group.updateGroupMemberOut", seq);
	}
	
	public int deleteGroupMember(GroupMemberDTO gmdto) {
		return mybatis.delete("Group.deleteGroupMember", gmdto);
	}
	
	public int insertDeleteApply(DeleteApplyDTO dadto) {
		return mybatis.insert("Group.insertDeleteApply", dadto);
	}
	
	public int insertLike(LikeListDTO ldto) {
		return mybatis.insert("Group.insertLike", ldto);
	}
	
	public int updateLike(int seq) {
		return mybatis.update("Group.updateLike", seq);
	}
	
	public boolean selectLike(Map<Object, Object> param) {
		Integer result = mybatis.selectOne("Group.selectLike", param);
		boolean checkLike = true;
		if (result == null) {
			checkLike = false;
		}
		
		return checkLike;
	}
	
	public int selectReport(ReportListDTO rldto) {
		return mybatis.selectOne("Group.selectReport", rldto);
	}
	
	public int insertReport(ReportListDTO rldto) {
		return mybatis.insert("Group.insertReport", rldto);
	}
	
	public int updateIngDate(String today_date) {
		int resultApplying = mybatis.update("Group.updateApplying", today_date);
		int resultProceedingN = mybatis.update("Group.updateProceedingN", today_date);
		int resultProceedingY = mybatis.update("Group.updateProceedingY", today_date);
		return resultApplying + resultProceedingN + resultProceedingY;
	}
	
	public List<GroupDTO> relatedGroup(List<String> hobby_arr) {
		return mybatis.selectList("Group.relatedGroup", hobby_arr);
	}
	
	public int updateAppCount(int seq) {
		return mybatis.update("Group.updateAppCount", seq);
	}
	
	public List<GroupDTO> selectGroupList(int cpage, Map<String, Object> search) {
		int start = cpage * Configuration.RECORD_COUNT_PER_PAGE - (Configuration.RECORD_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.RECORD_COUNT_PER_PAGE - 1);
		
		search.put("start", start);
		search.put("end", end);
		
		return mybatis.selectList("Group.selectGroupList", search);
	}
	
	public int selectGroupCount(Map<String, Object> search) {
		return mybatis.selectOne("Group.selectGroupCount", search);
	}
	
	// 찜하기
	public int insertJjim(JjimDTO jdto) {
		return mybatis.insert("Group.insertJjim", jdto);
	}
	
	// 찜 취소
	public int deleteJjim(JjimDTO jdto) {
		return mybatis.delete("Group.deleteJjim", jdto);
	}
	
	// 찜 확인
	public boolean selectJjim(JjimDTO jdto) {
		Integer result = mybatis.selectOne("Group.selectJjim", jdto);
		boolean checkJjim = true;
		if (result == null) {
			checkJjim = false;
		}
		
		return checkJjim;
	}
	
	//리뷰 글쓰기
	public int reviewWrite(ReviewDTO redto) throws Exception{
		return mybatis.insert("Group.reviewWrite",redto);
	}
	//리뷰 리스트
	public List<ReviewDTO> reviewList(int seq) {
		return mybatis.selectList("Group.reviewList",seq);
	}
	
	// 내가 등록한 그룹 신청서 관리
	public List<GroupApplyDTO> allAppList(List<Integer> seq) throws Exception {
		return mybatis.selectList("Group.allAppList", seq);
	}
	
	// 내가 작성한 그룹 신청서 관리
	public GroupApplyDTO myAppView(Map<String, Object> param) throws Exception {
		return mybatis.selectOne("Group.myAppView", param);
	}
	
	// 시퀀스로 그룹 신청서 찾기
	public GroupApplyDTO showApp(int seq) throws Exception {
		return mybatis.selectOne("Group.showApp", seq);
	}
	
	// 그룹 승인-시퀀스
	public int deleteAppAsAccept(int seq) throws Exception {
		return mybatis.delete("Group.deleteAppAsAccept", seq);
	}
	
	// 그룹 승인-아이디
	public int insertGroupMember(Map<String, Object> param) throws Exception {
		return mybatis.insert("Group.insertGroupMember", param);
	}
	
	// 그룹 승인-부모 시퀀스
	public int updateCurNum(int parent_seq) throws Exception {
		return mybatis.update("Group.updateCurNum", parent_seq);
	}
	
	// 그룹 신청 거절
	public int refuseApp(int seq) throws Exception {
		return mybatis.delete("Group.refuseApp", seq);
	}
	
	// 내 신청서 보기
	public GroupApplyDTO showMyApp(Map<String, Object> param) throws Exception {
		return mybatis.selectOne("Group.showMyApp", param);
	}
	
	// 리뷰 삭제하기
	public int reviewDelete(int seq) throws Exception{
		return mybatis.delete("Group.reviewDelete",seq);
	}
	
}
