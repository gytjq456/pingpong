package kh.pingpong.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kh.pingpong.config.Configuration;
import kh.pingpong.dto.BlacklistDTO;
import kh.pingpong.dto.CorrectDTO;
import kh.pingpong.dto.DeleteApplyDTO;
import kh.pingpong.dto.DiscussionDTO;
import kh.pingpong.dto.FileDTO;
import kh.pingpong.dto.GroupDTO;
import kh.pingpong.dto.LanguageDTO;
import kh.pingpong.dto.LessonDTO;
import kh.pingpong.dto.LocationDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.NewsDTO;
import kh.pingpong.dto.PartnerDTO;
import kh.pingpong.dto.ReportListDTO;
import kh.pingpong.dto.TuteeDTO;
import kh.pingpong.dto.TutorAppDTO;

@Service
public class AdminService {
	@Autowired
	private AdminDAO adao;
	
	// 회원 목록
	public List<MemberDTO> memberList(int cpage) {
		Map<String, Integer> page = new HashMap<>();
		
		int start = cpage * Configuration.DISCUSSION_COUNT_PER_PAGE - (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		
		page.put("start", start);
		page.put("end", end);
		
		return adao.memberList(page);
	}
	
	// 회원 뷰
	public MemberDTO memberView(String id) {
		return adao.memberView(id);
	}
	
	// 파트너 목록
	public List<PartnerDTO> partnerList(int cpage) {
		Map<String, Integer> page = new HashMap<>();
		
		int start = cpage * Configuration.DISCUSSION_COUNT_PER_PAGE - (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		
		page.put("start", start);
		page.put("end", end);
		
		return adao.partnerList(page);
	}
	
	// 파트너 뷰
	public PartnerDTO partnerView(int seq) {
		return adao.partnerView(seq);
	}
	
	// 그룹 목록
	public List<GroupDTO> groupList(int cpage) {
		Map<String, Integer> page = new HashMap<>();
		
		int start = cpage * Configuration.DISCUSSION_COUNT_PER_PAGE - (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		
		page.put("start", start);
		page.put("end", end);
		
		return adao.groupList(page);
	}
	
	// 그룹 뷰
	public GroupDTO groupView(int seq) {
		return adao.groupView(seq);
	}
	
	// 튜터 목록
	public List<MemberDTO> tutorList(int cpage) {
		Map<String, Integer> page = new HashMap<>();
		
		int start = cpage * Configuration.DISCUSSION_COUNT_PER_PAGE - (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		
		page.put("start", start);
		page.put("end", end);
		
		return adao.tutorList(page);
	}
	
	// 튜터 뷰
	public MemberDTO tutorView(String id) {
		return adao.tutorView(id);
	}
	
	// 튜터 신청 목록
	public List<TutorAppDTO> tutorAppList(int cpage) {
		Map<String, Integer> page = new HashMap<>();
		
		int start = cpage * Configuration.DISCUSSION_COUNT_PER_PAGE - (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		
		page.put("start", start);
		page.put("end", end);
		
		return adao.tutorAppList(page);
	}
	
	// 튜터 신청 뷰
	public TutorAppDTO tutorAppView(int seq) {
		return adao.tutorAppView(seq);
	}
	//자격증 파일들 보기
	public List<FileDTO> licenseViewFile(int seq){
		return adao.licenseViewFile(seq);
	}
	
	// 강의 목록
	public List<LessonDTO> lessonList(int cpage) {
		Map<String, Integer> page = new HashMap<>();
		
		int start = cpage * Configuration.DISCUSSION_COUNT_PER_PAGE - (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		
		page.put("start", start);
		page.put("end", end);
		
		return adao.lessonList(page);
	}
	
	// 강의 뷰
	public LessonDTO lessonView(int seq) {
		return adao.lessonView(seq);
	}
	
	// 강의 신청 목록
	public List<LessonDTO> lessonAppList(int cpage) {
		Map<String, Integer> page = new HashMap<>();
		
		int start = cpage * Configuration.DISCUSSION_COUNT_PER_PAGE - (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		
		page.put("start", start);
		page.put("end", end);
		
		return adao.lessonAppList(page);
	}
	
	// 강의 신청 뷰
	public LessonDTO lessonAppView(int seq) {
		return adao.lessonAppView(seq);
	}
	
	// 강의 삭제 목록
	public List<DeleteApplyDTO> lessonDelList(int cpage) {
		Map<String, Integer> page = new HashMap<>();
		
		int start = cpage * Configuration.DISCUSSION_COUNT_PER_PAGE - (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		
		page.put("start", start);
		page.put("end", end);
		
		return adao.lessonDelList(page);
	}
	
	// 강의 삭제 뷰
	public DeleteApplyDTO lessonDelView(int seq) {
		return adao.lessonDelView(seq);
	}
	
	// 튜티 목록
	public List<TuteeDTO> tuteeList(int cpage) {
		Map<String, Integer> page = new HashMap<>();
		
		int start = cpage * Configuration.DISCUSSION_COUNT_PER_PAGE - (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		
		page.put("start", start);
		page.put("end", end);
		
		return adao.tuteeList(page);
	}
	
	// 튜티 뷰, 환불 신청 뷰
	public TuteeDTO tuteeView(int seq) {
		return adao.tuteeView(seq);
	}
	
	// 환불 신청 목록
	public List<TuteeDTO> refundList(int cpage) {
		Map<String, Integer> page = new HashMap<>();
		
		int start = cpage * Configuration.DISCUSSION_COUNT_PER_PAGE - (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		
		page.put("start", start);
		page.put("end", end);
		
		return adao.refundList(page);
	}
	
	// 토론 게시글 목록
	public List<DiscussionDTO> discussionList(int cpage) {
		Map<String, Integer> page = new HashMap<>();
		
		int start = cpage * Configuration.DISCUSSION_COUNT_PER_PAGE - (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		
		page.put("start", start);
		page.put("end", end);
		
		return adao.discussionList(page);
	}
	
	// 토론 게시글 뷰
	public DiscussionDTO discussionView(int seq) {
		return adao.discussionView(seq);
	}
	
	// 첨삭 게시글 목록
	public List<CorrectDTO> correctList(int cpage) {
		Map<String, Integer> page = new HashMap<>();
		
		int start = cpage * Configuration.DISCUSSION_COUNT_PER_PAGE - (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		
		page.put("start", start);
		page.put("end", end);
		
		return adao.correctList(page);
	}
	
	// 첨삭 게시글 뷰
	public CorrectDTO correctView(int seq) {
		return adao.correctView(seq);
	}
	
	// 소식통 게시글 목록
	public List<NewsDTO> newsList(int cpage) {
		Map<String, Integer> page = new HashMap<>();
		
		int start = cpage * Configuration.DISCUSSION_COUNT_PER_PAGE - (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		
		page.put("start", start);
		page.put("end", end);
		
		return adao.newsList(page);
	}
	
	// 소식통 게시글 뷰
	public NewsDTO newsView(int seq) {
		return adao.newsView(seq);
	}
	
	// 신고 목록
	public List<ReportListDTO> reportList(int cpage) {
		Map<String, Integer> page = new HashMap<>();
		
		int start = cpage * Configuration.DISCUSSION_COUNT_PER_PAGE - (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		
		page.put("start", start);
		page.put("end", end);
		
		return adao.reportList(page);
	}
	
	// 신고 뷰
	public ReportListDTO reportView(int seq) {
		return adao.reportView(seq);
	}
	
	// 삭제
	public int deleteOne(Map<String, Object> param) {
		return adao.deleteOne(param);
	}
	
	// 튜터 삭제
	public int deleteTutor(String id) {
		return adao.deleteTutor(id);
	}
	
	// 파트너 삭제
	@Transactional("txManager")
	public int deletePartner(Map<String, Object> param) {
		adao.deleteOne(param);
		return adao.deletePartner(param.get("columnValue").toString());
	}
	
	// 튜티 삭제
	@Transactional("txManager")
	public int deleteTutee(Map<String, Object> param) {
		adao.deleteOne(param);
		return adao.deleteTutee((int)param.get("parent_seq"));
	}
	
	// 튜티 환불
	public int refundTutee(Map<String, Object> param) {
		return adao.deleteOne(param);
	}
	
	// 튜터 승인
	@Transactional("txManager")
	public int updateTutorApp(int seq, String id) {
		adao.updateTutorAppPass(seq);
		return adao.updateTutorAppGrade(id);
	}
	
	// 강의 신청 승인
	public int updateLessonPass(int seq) {
		return adao.updateLessonPass(seq);
	}
	
	// 강의 삭제 승인
	@Transactional("txManager")
	public int deleteApplyLesson(int seq, int parent_seq) {
		Map<String, Object> param = new HashMap<>();
		
		param.put("tableName", "delete_app");
		param.put("columnName", "parent_seq");
		param.put("columnValue", seq);
		
		adao.deleteOne(param);
		return adao.deleteApplyLesson(parent_seq);
	}
	
	// 신고 승인
	@Transactional("txManager")
	public int updateReportList(Map<String, Object> param) {
		if (param.containsKey("tableName")) {
			adao.deleteOne(param);
		}
		
		if (adao.isAlreadyReport(param) != null) {
			List<Integer> seqs = adao.isAlreadyReport(param);
			
			if (seqs.size() > 0) {
				for (int i = 0; i < seqs.size(); i++) {
					adao.updateReportListPass(seqs.get(i));
				}
			}
		}
		
		String id = param.get("id").toString();
		String name = adao.getNameForBlack(id);
		
		adao.updateReportCount(id);
		
		param.put("name", name);
		
		int report_count = adao.getReportCount(param.get("id").toString());
		
		if (report_count > 0 && report_count % 3 == 0) {
			boolean black = adao.isBlacklist(id);
			if (!black) {
				adao.insertBlacklist(param);
			}
		}
		
		return adao.updateReportListPass((int)param.get("seq"));
	}
	
	// 체크박스로 여러 개 삭제
	@Transactional("txManager")
	public int deleteAll(Map<String, Object> param) {
		String tableName = param.get("tableName").toString();
		String pageName = param.get("pageName").toString();
		if (tableName.contentEquals("partner")) {
			adao.deleteSelectedPartner(param);
		} else if (tableName.contentEquals("tutee") && pageName.contentEquals("tuteeList")) {
			Object[] valueList = (Object[])param.get("valueList");
			int val = 0;
			for (int i = 0; i < valueList.length; i++) {
				val = Integer.parseInt(valueList[i].toString());
				val = adao.getLessonSeqByTutee(val);
				adao.deleteTutee(val);
			}
		}
		return adao.deleteAll(param);
	}
	
	// 체크박스로 여러 튜터 삭제
	public int deleteSelectedTutor(List<String> list) {
		return adao.deleteSelectedTutor(list);
	}
	
	// 체크박스로 여러 개 승인
	@Transactional("txManager")
	public int acceptAll(Map<String, Object> param) {
		String tableName = param.get("tableName").toString();
		List<String> seqList = (List<String>)param.get("valueList");
		
		if (tableName.contentEquals("reportlist")) {
			Map<String, Object> report = new HashMap<>();
			for (int i = 0; i < seqList.size(); i++) {
				Map<String, Object> black = new HashMap<>();
				
				int seq = Integer.parseInt(seqList.get(i));
				String id = adao.getIdFromReportList(seq);
				String name = adao.getNameForBlack(id);
				
				adao.updateReportCount(id);
				
				black.put("id", id);
				black.put("name", name);
				
				int report_count = adao.getReportCount(id);
				
				if (report_count > 0 && report_count % 3 == 0) {
					adao.insertBlacklist(black);
				}
				
				String category = adao.getCategoryFromRep(seq);
				int parent_seq = adao.getParentSeqFromRep(seq);
				
				report.put("category", category);
				report.put("columnName", "seq");
				report.put("columnValue", parent_seq);
				
				if (adao.isAlreadyReport(report) != null) {
					List<Integer> seqs = adao.isAlreadyReport(report);
					
					if (seqs.size() > 0) {
						for (int j = 0; j < seqs.size(); j++) {
							adao.updateReportListPass(seqs.get(j));
						}
					}
				}
				
				if (category.contentEquals("그룹")) {
					report.put("tableName", "grouplist");
					adao.deleteOne(report);
				} else if (category.contentEquals("토론")) {
					report.put("tableName", "discussion");
					adao.deleteOne(report);
				} else if (category.contentEquals("첨삭")) {
					report.put("tableName", "correct");
					adao.deleteOne(report);
				} else if (category.contentEquals("소식통")) {
					report.put("tableName", "news");
					adao.deleteOne(report);
				}
			}
		} else if (tableName.contentEquals("tutor_app")) {
			List<String> idList = new ArrayList<>();
			for (int i = 0; i < seqList.size(); i++) {
				String id = adao.getIdFromTutorApp(Integer.parseInt(seqList.get(i)));
				idList.add(id);
			}
			param.put("idList", idList);
			
			adao.acceptAllTutorApp(param);
		} else if (tableName.contentEquals("lesson")) {
			adao.acceptAllLessonDel(param);
		}
		
		return adao.acceptAll(param);
	}
	
	// 여러 강의 삭제 승인
	public int acceptDeleteLessons(List<Integer> list) {
		Map<String, Object> param = new HashMap<>();
		
		param.put("columnName", "seq");
		
		for (int i = 0; i < list.size(); i++) {
			param.put("tableName", "delete_app");
			
			int seq = list.get(i);
			int parent_seq = adao.getParentSeqFromDel(seq);
			param.put("columnValue", seq);
			
			adao.deleteOne(param);
			
			param.put("tableName", "lesson");
			param.put("columnValue", parent_seq);
			
			adao.deleteOne(param);
		}
		return 0;
	}
	
	// 언어 선호 조회
	public List<LanguageDTO> selectFiveLang() {
		return adao.selectFiveLang();
	}
	
	// 지역 선호 조회
	public List<LocationDTO> selectFiveLoc() {
		return adao.selectFiveLoc();
	}
	
	// 블랙리스트 목록
	public List<BlacklistDTO> blacklistList(int cpage) {
		Map<String, Integer> param = new HashMap<>();
		
		int start = cpage * Configuration.DISCUSSION_COUNT_PER_PAGE - (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.DISCUSSION_COUNT_PER_PAGE - 1);
		
		param.put("start", start);
		param.put("end", end);
		
		return adao.blacklistList(param);
	}
	
	// 블랙리스트 뷰
	public BlacklistDTO blacklistView(int seq) {
		return adao.blacklistView(seq);
	}
	
	// 블랙리스트 만료
	public int doneBlacklist(String today_date) {
		return adao.doneBlacklist(today_date);
	}
	
	// 로그인 시 블랙리스트 확인
	public boolean isBlacklist(String id) {
		return adao.isBlacklist(id);
	}
	
	// 페이징
	public String getPageNav(int currentPage, Map<String, String> param) throws Exception{
		// 총 게시물
		int recordTotalCount = adao.selectCount(param);

		int pageTotalCount = 0; //전체페이지 개수

		if(recordTotalCount % Configuration.DISCUSSION_COUNT_PER_PAGE > 0) {
			pageTotalCount = recordTotalCount / Configuration.DISCUSSION_COUNT_PER_PAGE + 1;
		}else {
			pageTotalCount = recordTotalCount / Configuration.DISCUSSION_COUNT_PER_PAGE;
		}

		if(currentPage < 1) {
			currentPage = 1;
		}else if(currentPage > pageTotalCount) {
			currentPage = pageTotalCount;
		}

		int startNav = (currentPage - 1) / Configuration.NAVI_COUNT_PER_PAGE * Configuration.NAVI_COUNT_PER_PAGE + 1;
		int endNav = startNav + Configuration.NAVI_COUNT_PER_PAGE - 1;
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
		if(needPrev) {
			sb.append("<li><a href='/admins/" + param.get("pageName") + "?cpage=" + (startNav - 1) + "' id='prevPage'><</a></li>");
		}

		for(int i=startNav; i<= endNav; i++) {
			if(currentPage == i) {
				sb.append("<li class='on'><a href='/admins/" + param.get("pageName") + "?cpage=" + i + "'>" + i + "</a></li>");
			}else {
				sb.append("<li><a href='/admins/" + param.get("pageName") + "?cpage=" + i + "'>" + i + "</a></li>");
			}
		}

		if(needNext) {
			sb.append("<li><a href='/admins/" + param.get("pageName") + "?cpage=" + (endNav + 1) + "' id='prevPage'>></a></li>");
		}
		sb.append("</ul>");

		return sb.toString();
	}
}
