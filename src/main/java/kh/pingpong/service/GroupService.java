package kh.pingpong.service;

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
import kh.pingpong.dto.HobbyDTO;
import kh.pingpong.dto.LikeListDTO;
import kh.pingpong.dto.MemberDTO;
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
	public int insertGroup(GroupDTO gdto) {
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		String writer = loginInfo.getId();
		gdao.insertGroup(gdto);
		return gdao.searchSeq(writer);
	}
	
	public List<GroupDTO> selectList(int cpage, String orderBy) {
		return gdao.selectList(cpage, orderBy);
	}
	
	public GroupDTO selectBySeq(int seq) throws Exception{
		return gdao.selectBySeq(seq);
	}
	
	public int delete(int seq) {
		return gdao.delete(seq);
	}
	
	@Transactional("txManager")
	public int update(GroupDTO gdto) {
		return gdao.update(gdto);
	}
	
	public int updateViewCount(int seq) {
		return gdao.updateViewCount(seq);
	}
	
	public int insertApp(GroupApplyDTO gadto) {
		return gdao.insertApp(gadto);
	}
	
	public int insertDeleteApply(DeleteApplyDTO dadto) {
		return gdao.insertDeleteApply(dadto);
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
	
	public List<GroupDTO> selectOrderBy(String tableName) {
		return gdao.selectOrderBy(tableName);
	}
	
	public List<GroupDTO> search(int cpage, Map<String, Object> search) {
		return gdao.search(cpage, search);
	}
	
	public List<GroupDTO> selectListOption(int cpage, Map<String, Object> param) {
		return gdao.selectListOption(cpage, param);
	}
	
	public String getPageNav(int currentPage, String orderBy) throws Exception{
		// 총 게시물
		int recordTotalCount = gdao.selectCount();

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
		if(needPrev) {
			sb.append("<li><a href='/group/main?orderBy=" + orderBy + "&cpage=" + (startNav - 1) + "' id='prevPage'><</a></li>");
		}

		for(int i=startNav; i<= endNav; i++) {
			if(currentPage == i) {
				sb.append("<li class='on'><a href='/group/main?orderBy=" + orderBy + "&cpage=" + i + "'>" + i + "</a></li>");
			}else {
				sb.append("<li><a href='/group/main?orderBy=" + orderBy + "&cpage=" + i + "'>" + i + "</a></li>");
			}
		}

		if(needNext) {
			sb.append("<li><a href='/group/main?orderBy=" + orderBy + "&cpage=" + (endNav + 1) + "' id='prevPage'>></a></li>");
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
}
