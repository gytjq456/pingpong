package kh.pingpong.service;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kh.pingpong.config.Configuration;
import kh.pingpong.dao.GroupDAO;
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

@Service
public class GroupService {
	@Autowired
	private GroupDAO gdao;
	
	@Autowired
	private HttpSession session;
	
	public List<HobbyDTO> selectHobby() {
		return gdao.selectHobby();
	}
	
	@Transactional("txManager")
	public int insertGroup(GroupDTO gdto) throws ParseException {
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		String writer_id = loginInfo.getId();
		gdao.insertGroup(gdto);
		return gdao.searchSeq(writer_id);
	}
	
	public GroupDTO selectBySeq(int seq) throws Exception{
		return gdao.selectBySeq(seq);
	}
	
	public int delete(int seq) {
		return gdao.delete(seq);
	}
	
	@Transactional("txManager")
	public int update(GroupDTO gdto) throws ParseException {
		return gdao.update(gdto);
	}
	
	public int updateViewCount(int seq) {
		return gdao.updateViewCount(seq);
	}
	
	@Transactional("txManager")
	public int insertApp(GroupApplyDTO gadto) {
		gdao.updateAppCount(gadto.getParent_seq());
		return gdao.insertApp(gadto);
	}
	
	@Transactional("txManager")
	public int cancelApply(GroupApplyDTO gadto) {
		int seq = gdao.selectApplySeq(gadto);
		return gdao.cancelApply(seq);
	}
	
	public boolean selectApplyForm(GroupApplyDTO gadto) {
		return gdao.selectApplyForm(gadto);
	}
	
	@Transactional("txManager")
	public int insertDeleteApply(DeleteApplyDTO dadto) {
		GroupMemberDTO gmdto = new GroupMemberDTO();
		
		gmdto.setId(dadto.getId());
		gmdto.setParent_seq(dadto.getParent_seq());
		
		gdao.updateGroupMemberOut(dadto.getParent_seq());
		gdao.deleteGroupMember(gmdto);
		return gdao.insertDeleteApply(dadto);
	}
	
	public List<GroupMemberDTO> selectGroupMemberList(int parent_seq) {
		return gdao.selectGroupMemberList(parent_seq);
	}
	
	public boolean selectGroupMemberById(GroupMemberDTO gmdto) {
		return gdao.selectGroupMemberById(gmdto);
	}
	
	@Transactional("txManager")
	public int insertLike(LikeListDTO ldto) {
		gdao.updateLike(ldto.getParent_seq());
		return gdao.insertLike(ldto);
	}
	
	public boolean selectLike(Map<Object, Object> param) {
		return gdao.selectLike(param);
	}
	
	public int updateIngDate(String today_date) {
		return gdao.updateIngDate(today_date);
	}
	
	public List<GroupDTO> relatedGroup(List<String> hobby_arr) {
		return gdao.relatedGroup(hobby_arr);
	}
	
	public List<GroupDTO> selectGroupList(int cpage, Map<String, Object> search) {
		return gdao.selectGroupList(cpage, search);
	}
	
	public int selectGroupCount(Map<String, Object> search) {
		return gdao.selectGroupCount(search);
	}
	
	public int insertJjim(JjimDTO jdto) {
		return gdao.insertJjim(jdto);
	}
	
	public int deleteJjim(JjimDTO jdto) {
		return gdao.deleteJjim(jdto);
	}
	
	public boolean selectJjim(JjimDTO jdto) {
		return gdao.selectJjim(jdto);
	}
	
	public int selectReport(ReportListDTO rldto) {
		return gdao.selectReport(rldto);
	}
	
	public int insertReport(ReportListDTO rldto) {
		return gdao.insertReport(rldto);
	}
	
	public String getPageNav(int currentPage, Map<String, Object> search) throws Exception{
		// 총 게시물
		int recordTotalCount = gdao.selectGroupCount(search);
		String orderBy = search.get("orderBy").toString();

		int pageTotalCount = 0; //전체페이지 개수

		if(recordTotalCount % Configuration.RECORD_COUNT_PER_PAGE > 0) {
			pageTotalCount = recordTotalCount / Configuration.RECORD_COUNT_PER_PAGE + 1;
		}else {
			pageTotalCount = recordTotalCount / Configuration.RECORD_COUNT_PER_PAGE;
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
		
		String pagingUrl = "/group/";
		
		if (!search.containsKey("ing") && !search.containsKey("keywordType") && !search.containsKey("hobbyType") && !search.containsKey("period") && !search.containsKey("start_date") && !search.containsKey("location")) {
			pagingUrl = pagingUrl + "main?orderBy=" + orderBy;
		}
		
		if (search.containsKey("ing")) {
			if (search.get("ing").toString().contentEquals("applying = 'N' and proceeding")) {
				pagingUrl = pagingUrl + "mainOption?orderBy=" + orderBy + "&ing=done";
			} else {
				pagingUrl = pagingUrl + "mainOption?orderBy=" + orderBy + "&ing=" + search.get("ing").toString();
			}
		} 
		
		if (search.containsKey("keywordType")) {
			if (search.containsKey("hobbyType")) {
				if (search.containsKey("period")) {
					pagingUrl = pagingUrl + "search?orderBy=" + orderBy + "&keywordType=" + search.get("keywordType").toString() +
							"&keywordValue=" + search.get("keywordValue").toString() + "&hobbyType=" + search.get("hobbyType").toString() +
							"&period=" + search.get("period").toString();
				} else {
					pagingUrl = pagingUrl + "search?orderBy=" + orderBy + "&keywordType=" + search.get("keywordType").toString() +
							"&keywordValue=" + search.get("keywordValue").toString() + "&hobbyType=" + search.get("hobbyType").toString() +
							"&period=null";
				}
			} else {
				if (search.containsKey("period")) {
					pagingUrl = pagingUrl + "search?orderBy=" + orderBy + "&keywordType=" + search.get("keywordType").toString() +
							"&keywordValue=" + search.get("keywordValue").toString() + "&hobbyType=&period=" + search.get("period").toString();
				} else {
					pagingUrl = pagingUrl + "search?orderBy=" + orderBy + "&keywordType=" + search.get("keywordType").toString() +
							"&keywordValue=" + search.get("keywordValue").toString() + "&hobbyType=&period=null";
				}
			}
		} else {
			if (search.containsKey("hobbyType")) {
				if (search.containsKey("period")) {
					pagingUrl = pagingUrl + "search?orderBy=" + orderBy + "&keywordType=null&keywordValue=null&hobbyType=" + search.get("hobbyType").toString() +
							"&period=" + search.get("period").toString();
				} else {
					pagingUrl = pagingUrl + "search?orderBy=" + orderBy + "&keywordType=null&keywordValue=null&hobbyType=" + search.get("hobbyType").toString() +
							"&period=null";
				}
			} else {
				if (search.containsKey("period")) {
					pagingUrl = pagingUrl + "search?orderBy=" + orderBy + "&keywordType=null&keywordValue=null&hobbyType=&period=" + search.get("period").toString();
				}
			}
		} 
		
		if (search.containsKey("start_date")) {
			pagingUrl = pagingUrl + "searchDate?orderBy=" + orderBy + "&start_date=" + search.get("start_date").toString() + "&end_date=" + search.get("end_date").toString();
		}
		
		if (search.containsKey("location")) {
			pagingUrl = pagingUrl + "searchLocation?orderBy=" + orderBy + "&location=" + search.get("location").toString();
		}
		
		if(needPrev) {
			sb.append("<li><a href='" + pagingUrl + "&cpage=" + (startNav - 1) + "' id='prevPage'><</a></li>");
		}

		for(int i=startNav; i<= endNav; i++) {
			if(currentPage == i) {
				sb.append("<li class='on'><a href='" + pagingUrl + "&cpage=" + i + "'>" + i + "</a></li>");
			}else {
				sb.append("<li><a href='" + pagingUrl + "&cpage=" + i + "'>" + i + "</a></li>");
			}
		}

		if(needNext) {
			sb.append("<li><a href='" + pagingUrl + "&cpage=" + (endNav + 1) + "' id='prevPage'>></a></li>");
		}
		sb.append("</ul>");

		return sb.toString();
	}
	
	// 리뷰 글쓰기
	public int reviewWrite(ReviewDTO redto) throws Exception{
		return gdao.reviewWrite(redto);
	}
	
	//리뷰 리스트 출력
	public List<ReviewDTO> reviewList(int seq) throws Exception{
		return gdao.reviewList(seq);
	}
	
	// 내가 등록한 그룹 신청서 관리
	public List<GroupApplyDTO> allAppList(int seq) throws Exception {
		return gdao.allAppList(seq);
	}
	
	// 내가 작성한 그룹 신청서 관리
	public GroupApplyDTO myAppView(Map<String, Object> param) throws Exception {
		return gdao.myAppView(param);
	}
}
