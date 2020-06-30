package kh.pingpong.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import kh.pingpong.dto.HobbyDTO;
import kh.pingpong.dto.LikeListDTO;
import kh.pingpong.dto.ReviewDTO;

@Repository
public class GroupDAO {
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public List<HobbyDTO> selectHobby() {
		return mybatis.selectList("Group.selectHobby");
	}
	
	public int insertGroup(GroupDTO gdto) throws ParseException {
		System.out.println(gdto.getApply_start());
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

		return mybatis.insert("Group.insert", gdto);
	}
	
	public List<GroupDTO> selectList(int cpage, String orderBy) {
		Map<String, Object> param = new HashMap<>();

		int start = cpage * Configuration.RECORD_COUNT_PER_PAGE - (Configuration.RECORD_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.RECORD_COUNT_PER_PAGE - 1);
		
		param.put("start", start);
		param.put("end", end);
		param.put("orderBy", orderBy);
		
		return mybatis.selectList("Group.selectList", param);
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
	
	public int selectApplyForm(int parent_seq) {
		return mybatis.selectOne("Group.selectApplyForm", parent_seq);
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
	
	public int updateIngDate(String today_date) {
		int resultApplying = mybatis.update("Group.updateApplying", today_date);
		int resultProceeding = mybatis.update("Group.updateProceeding", today_date);
		return resultApplying + resultProceeding;
	}
	
	public List<GroupDTO> selectOrderBy(String tableName) {
		return mybatis.selectList("Group.selectOrderBy", tableName);
	}
	
	public List<GroupDTO> selectListOption(int cpage, Map<String, Object> param) {
		int start = cpage * Configuration.RECORD_COUNT_PER_PAGE - (Configuration.RECORD_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.RECORD_COUNT_PER_PAGE - 1);
		
		param.put("start", start);
		param.put("end", end);
		
		return mybatis.selectList("Group.selectListOption", param);
	}
	
	public List<GroupDTO> search(int cpage, Map<String, Object> search) {
		int start = cpage * Configuration.RECORD_COUNT_PER_PAGE - (Configuration.RECORD_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.RECORD_COUNT_PER_PAGE - 1);
		
		search.put("start", start);
		search.put("end", end);
		
		List<GroupDTO> glist = new ArrayList<>();
		
		if (search.containsKey("searchType") && search.get("searchType").toString().contentEquals("contents")) {
			glist = mybatis.selectList("Group.searchContents", search);
		} else {
			glist = mybatis.selectList("Group.search", search);
		}
		
		return glist;
	}
	
	public List<GroupDTO> searchDate(int cpage, Map<String, Object> dates) {
		int start = cpage * Configuration.RECORD_COUNT_PER_PAGE - (Configuration.RECORD_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.RECORD_COUNT_PER_PAGE - 1);
		
		dates.put("start", start);
		dates.put("end", end);
		
		System.out.println(dates.get("dateStart"));
		System.out.println(dates.get("dateEnd"));
		
		return mybatis.selectList("Group.searchDate", dates);
	}
	
	//리뷰 글쓰기
	public int reviewWrite(ReviewDTO redto) throws Exception{
		return mybatis.insert("Group.reviewWrite",redto);
	}
	//리뷰 리스트
	public List<ReviewDTO> reviewList(int seq) {
		return mybatis.selectList("Group.reviewList",seq);
	}
}
