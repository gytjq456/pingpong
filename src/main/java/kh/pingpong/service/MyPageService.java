package kh.pingpong.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.pingpong.config.Configuration;
import kh.pingpong.dao.MyPageDAO;
import kh.pingpong.dto.GroupApplyDTO;
import kh.pingpong.dto.GroupDTO;
import kh.pingpong.dto.LessonDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.PartnerDTO;

@Service
public class MyPageService {
	
	@Autowired
	private MyPageDAO mpdao;
	
	//그룹 관련
	public List<GroupDTO> selectGroupList(){
		return mpdao.selectGroupList();
	}
	
	public List<GroupDTO> selectByIdInGroup(Map<String, Object> param){
		int start = (int)param.get("lcpage") * Configuration.LETTER_COUNT_PER_PAGE - (Configuration.LETTER_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.LETTER_COUNT_PER_PAGE - 1);
		
		param.put("start", start);
		param.put("end", end);
		
		return mpdao.selectByIdInGroup(param);
	}
	
	public List<GroupApplyDTO> selectByIdInGroupMem(Map<String, Object> param){
		int start = (int)param.get("mcpage") * Configuration.LETTER_COUNT_PER_PAGE - (Configuration.LETTER_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.LETTER_COUNT_PER_PAGE - 1);
		
		param.put("start", start);
		param.put("end", end);
		
		return mpdao.selectByIdInGroupMem(param);
	}
	

	//튜터 / 튜티 관련
	public List<LessonDTO> selectLessonList(Map<String, Object> param){
		int start = (int)param.get("cpage") * Configuration.LETTER_COUNT_PER_PAGE - (Configuration.LETTER_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.LETTER_COUNT_PER_PAGE - 1);
		
		param.put("start", start);
		param.put("end", end);
		
		return mpdao.selectLessonList(param);
	}

	public List<LessonDTO> selectTuteeList(Map<String, Object> param){
		int start = (int)param.get("cpage") * Configuration.LETTER_COUNT_PER_PAGE - (Configuration.LETTER_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.LETTER_COUNT_PER_PAGE - 1);
		
		param.put("start", start);
		param.put("end", end);
		
		return mpdao.selectTuteeList(param);
	}
	
	//파트너 관련
	public List<PartnerDTO> selectPartnerList(){
		return mpdao.selectPartnerList();
	}
	
	//찜 관련
	public List<PartnerDTO> selectPartnerJjim(Map<String, Object> param){
		int start = (int)param.get("pcpage") * Configuration.LETTER_COUNT_PER_PAGE - (Configuration.LETTER_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.LETTER_COUNT_PER_PAGE - 1);
		
		param.put("start", start);
		param.put("end", end);
		
		return mpdao.selectPartnerJjim(param);
	}
	public List<GroupDTO> selectGroupJjim(Map<String, Object> param){
		int start = (int)param.get("gcpage") * Configuration.LETTER_COUNT_PER_PAGE - (Configuration.LETTER_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.LETTER_COUNT_PER_PAGE - 1);
		
		param.put("start", start);
		param.put("end", end);
		
		return mpdao.selectGroupJjim(param);
	}
	public List<LessonDTO> selectLessonJjim(Map<String, Object> param){
		int start = (int)param.get("lcpage") * Configuration.LETTER_COUNT_PER_PAGE - (Configuration.LETTER_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.LETTER_COUNT_PER_PAGE - 1);
		
		param.put("start", start);
		param.put("end", end);
		
		return mpdao.selectLessonJjim(param);
	}
	
	// 페이징
	public String getPageNav(Map<String, Object> param) throws Exception{
		String cpageName = "";
		String otherPageName = "";
		String restPageName = "";
		
		String tableName = param.get("tableName").toString();
		
		int currentPage = 1;
		int otherPage = 1;
		int restPage = 1;

		// 총 게시물
		int recordTotalCount = 0;
		
		if (tableName.contentEquals("grouplist")) {
			cpageName = "lcpage";
			otherPageName = "mcpage";
			
			currentPage = (int)param.get("lcpage");
			otherPage = (int)param.get("mcpage");
			
			recordTotalCount = mpdao.selectCount(param);
		} else if (tableName.contentEquals("groupmember")) {
			cpageName = "mcpage";
			otherPageName = "lcpage";
			
			currentPage = (int)param.get("mcpage");
			otherPage = (int)param.get("lcpage");
			
			recordTotalCount = mpdao.selectCount(param);
		} else if (tableName.contentEquals("partner")) {
			param.put("category", "파트너");

			cpageName = "pcpage";
			otherPageName = "gcpage";
			restPageName = "lcpage";
			
			currentPage = (int)param.get("pcpage");
			otherPage = (int)param.get("gcpage");
			restPage = (int)param.get("lcpage");
			
			recordTotalCount = mpdao.jjimCount(param);
		} else if (tableName.contentEquals("group")) {
			param.put("category", "그룹");

			cpageName = "gcpage";
			otherPageName = "pcpage";
			restPageName = "lcpage";
			
			currentPage = (int)param.get("gcpage");
			otherPage = (int)param.get("pcpage");
			restPage = (int)param.get("lcpage");
			
			recordTotalCount = mpdao.jjimCount(param);
		} else if (tableName.contentEquals("lesson")) {
			param.put("category", "강의");
			
			cpageName = "lcpage";
			otherPageName = "gcpage";
			restPageName = "lcpage";
			
			currentPage = (int)param.get("lcpage");
			otherPage = (int)param.get("gcpage");
			restPage = (int)param.get("pcpage");
			
			recordTotalCount = mpdao.jjimCount(param);
		} else if (tableName.contentEquals("tutor") || tableName.contentEquals("tutee")) {
			currentPage = (int)param.get("cpage");
			
			recordTotalCount = mpdao.selectCount(param);
		}
		
		int pageTotalCount = 0; //전체페이지 개수

		if(recordTotalCount % Configuration.LETTER_COUNT_PER_PAGE > 0) {
			pageTotalCount = recordTotalCount / Configuration.LETTER_COUNT_PER_PAGE + 1;
		}else {
			pageTotalCount = recordTotalCount / Configuration.LETTER_COUNT_PER_PAGE;
		}

		if(currentPage < 1) {
			currentPage = 1;
		} else if(currentPage > pageTotalCount) {
			currentPage = pageTotalCount;
		}

		int startNav = (currentPage - 1) / Configuration.LETTER_NAVI_COUNT_PER_PAGE * Configuration.LETTER_NAVI_COUNT_PER_PAGE + 1;
		int endNav = startNav + Configuration.LETTER_NAVI_COUNT_PER_PAGE - 1;
		if(endNav > pageTotalCount) {
			endNav = pageTotalCount;
		} 

		boolean needPrev = true;
		boolean needNext = true;	

		if(startNav == 1) {
			needPrev = false;
		}
		if(endNav == pageTotalCount) {
			needNext = false;
		}					

		StringBuilder sb = new StringBuilder();

		sb.append("<ul>");
		
		if (tableName.contentEquals("grouplist") || tableName.contentEquals("groupmember")) {
			if(needPrev) {
				sb.append("<li><a href='/mypage/groupRecord?" + cpageName + "=" + (startNav - 1) + "&" + otherPageName + "=" + otherPage + "' id='prevPage'><</a></li>");
			}
	
			for(int i=startNav; i<= endNav; i++) {
				if(currentPage == i) {
					sb.append("<li class='on'><a href='/mypage/groupRecord?" + cpageName + "=" + i + "&" + otherPageName + "=" + otherPage + "'>" + i + "</a></li>");
				}else {
					sb.append("<li><a href='/mypage/groupRecord?" + cpageName + "=" + i + "&" + otherPageName + "=" + otherPage + "'>" + i + "</a></li>");
				}
			}
	
			if(needNext) {
				sb.append("<li><a href='/mypage/groupRecord?" + cpageName + "=" + (endNav + 1) + "&" + otherPageName + "=" + otherPage + "' id='prevPage'>></a></li>");
			}
		} else if (tableName.contentEquals("partner") || tableName.contentEquals("group") || tableName.contentEquals("lesson")) {
			if(needPrev) {
				sb.append("<li><a href='/mypage/likeRecord?" + cpageName + "=" + (startNav - 1) + "&" + otherPageName + "=" + otherPage + "&" + restPageName + "=" + restPage + "' id='prevPage'><</a></li>");
			}
	
			for(int i=startNav; i<= endNav; i++) {
				if(currentPage == i) {
					sb.append("<li class='on'><a href='/mypage/likeRecord?" + cpageName + "=" + i + "&" + otherPageName + "=" + otherPage + "&" + restPageName + "=" + restPage + "'>" + i + "</a></li>");
				}else {
					sb.append("<li><a href='/mypage/likeRecord?" + cpageName + "=" + i + "&" + otherPageName + "=" + otherPage + "&" + restPageName + "=" + restPage + "'>" + i + "</a></li>");
				}
			}
	
			if(needNext) {
				sb.append("<li><a href='/mypage/likeRecord?" + cpageName + "=" + (endNav + 1) + "&" + otherPageName + "=" + otherPage + "&" + restPageName + "=" + restPage + "' id='prevPage'>></a></li>");
			}
		} else if (tableName.contentEquals("tutor") || tableName.contentEquals("tutee")) {
			if(needPrev) {
				sb.append("<li><a href='/mypage/tutorRecord?cpage=" + (startNav - 1) + "' id='prevPage'><</a></li>");
			}
	
			for(int i=startNav; i<= endNav; i++) {
				if(currentPage == i) {
					sb.append("<li class='on'><a href='/mypage/tutorRecord?cpage=" + i + "'>" + i + "</a></li>");
				}else {
					sb.append("<li><a href='/mypage/tutorRecord?cpage=" + i + "'>" + i + "</a></li>");
				}
			}
	
			if(needNext) {
				sb.append("<li><a href='/mypage/tutorRecord?cpage=" + (endNav + 1) + "' id='prevPage'>></a></li>");
			}
		}
		sb.append("</ul>");

		return sb.toString();

	}
}
