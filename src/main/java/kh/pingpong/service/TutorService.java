package kh.pingpong.service;

import java.io.File;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kh.pingpong.config.Configuration;
import kh.pingpong.dao.FileDAO;
import kh.pingpong.dao.TutorDAO;
import kh.pingpong.dto.DeleteApplyDTO;
import kh.pingpong.dto.FileDTO;
import kh.pingpong.dto.JjimDTO;
import kh.pingpong.dto.LessonDTO;
import kh.pingpong.dto.LikeListDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.ReportListDTO;
import kh.pingpong.dto.ReviewDTO;
import kh.pingpong.dto.TuteeDTO;
import kh.pingpong.dto.TutorAppDTO;

@Service
public class TutorService {

	@Autowired
	private TutorDAO tdao;
	
	@Autowired
	private FileDAO fdao;
	
	public int tutorTrue(String id) throws Exception{
		int result = tdao.tutorTrue(id);
		return result;
	}
	
	public String passWhether(String id) throws Exception{
		String result= tdao.passWhether(id);
		return result;
	}
	
	@Transactional("txManager")
	public void tutorAppSend(TutorAppDTO tadto, List<FileDTO> fileList, String filePath) throws Exception{
		
		//파일 여러개를 string으로 변경하여 ndto에 Files_name 넣음
		String[] files_insert = new String[fileList.size()];
		int i = 0;
		for(FileDTO f : fileList) {
			files_insert[i++] = f.getSysname();
		}
		String arrayS = Arrays.toString(files_insert);
		String arrayS_result = arrayS.substring(1, arrayS.length()-1);
		tadto.setLicense(arrayS_result);
		
		tdao.insert(tadto);
		//---------------------------------------�뙆�씪 �뾽濡쒕뱶
		File tempFilepath = new File(filePath);
		if (!tempFilepath.exists()) {
			tempFilepath.mkdir();
		}
		
		for(FileDTO file : fileList) {
			fdao.tutorFileInsert(file);
		}
	}
	
	public List<MemberDTO> tutorList(int cpage) throws Exception{
		List<MemberDTO> mdto = tdao.tutorList(cpage);
		return mdto;
	}
	
	//리스트 전부 뽑기
	public List<LessonDTO> lessonList(int cpage,String orderBy) throws Exception{
		List<LessonDTO> ldto = tdao.lessonList(cpage, orderBy);
		return ldto;
	}
	
	//모집중, 진행중, 마감 눌렀을 때 리스트
	public List<LessonDTO> lessonListPeriod(int cpage, Map<String,String> param) throws Exception{
		List<LessonDTO> ldto = tdao.lessonListPeriod(cpage, param);
		return ldto;
	}
	
	//키워드로 검색해서 리스트뽑기
	public List<LessonDTO> search(int cpage, Map<String,String> param) throws Exception{
		List<LessonDTO> ldto = tdao.search(cpage, param);
		return ldto;
	}
	
	public LessonDTO lessonView(int seq) throws Exception{
		LessonDTO ldto = tdao.lessonView(seq);
		return ldto;
	}
	
	public int lessonCancleProc(DeleteApplyDTO dadto) throws Exception{
		int result = tdao.lessonCancleProc(dadto);
		return result;
	}
	
	//강위취소 판별 유무
	public int lessonCancle(Map<Object, Object> param) throws Exception{
		int result = tdao.lessonCancle(param);
		return result;
	}
	
	public int lessonAppProc(LessonDTO ldto) throws Exception{
		int view_count=0;
		ldto.setView_count(view_count);
		int result = tdao.lessonAppProc(ldto);
		return result;
	}
	
	public int lessonAppUpdateProc(LessonDTO ldto) throws Exception{
		int result = tdao.lessonAppUpdateProc(ldto);
		return result;
	}
	
	public int updateViewCount(int seq) throws Exception{
		int result = tdao.updateViewCount(seq);
		return result;
	}

	//좋아요 테이블 값넣기 & 카운트세기
	@Transactional("txManager")
	public int likeTrue(LikeListDTO lldto) throws Exception{
		int result = tdao.likeTrue(lldto);
		tdao.updateLikeCount(lldto.getParent_seq());
		return result;
	}
	//좋아요 눌러있는지 아닌지 확인하기
	public boolean LikeIsTrue(Map<Object, Object> param) throws Exception{
		boolean result = tdao.LikeIsTrue(param);
		return result;
	}
	
	//강의 결제한사람이 또 결제하는지
	public int payTrue(TuteeDTO ttdto) throws Exception{
		int result = tdao.payTrue(ttdto);
		return result;
	}
	
	//강의 취소한사람이 또 취소하는지
	public int refundTrue(TuteeDTO ttdto) throws Exception{
		int result = tdao.refundTrue(ttdto);
		return result;
	}
	//찜 테이블 값넣기
	public int insertJjim(JjimDTO jdto) throws Exception{
		int result = tdao.insertJjim(jdto);
		return result;
	}
	//찜 눌러져있는지 아닌지 확인하기
	public boolean JjimIsTrue(Map<Object, Object> param) throws Exception{
		boolean result = tdao.JjimIsTrue(param);
		return result;
	}
	//찜 테이블에서 값 삭제하기 찜취소
	public int deleteJjim(JjimDTO jdto) throws Exception{
		int result = tdao.deleteJjim(jdto);
		return result;
	}
	
	//같은게시물 같은사람이 신고했는지
	public int report(ReportListDTO rldto) throws Exception{
		int result = tdao.report(rldto);
		return result;
	}
	
	//신고테이블에 저장
	public int reportProc(ReportListDTO rldto) throws Exception{
		int result = tdao.reportProc(rldto);
		return result;
	}
	
	//모집중 진행중 마감 시간에따라 알아서 바뀌게하기
	public int updateIngDate(String today_date) throws Exception{
		int result = tdao.updateIngDate(today_date);
		return result;
	}
	
	//리뷰 평점/갯수 늘리기
	public void reviewUpdate(ReviewDTO rdto) throws Exception{

		System.out.println(rdto.getParent_seq() + rdto.getCategory());
		tdao.reviewUpdate(rdto);
	}
	
	//튜티 인서트
	//현재인원 늘리는것까지
	@Transactional("txManager")
	public int tuteeInsert(TuteeDTO ttdto) throws Exception{
		
		tdao.tuteeInsert(ttdto);
		ttdto.setCancle(ttdto.getCancle());
		System.out.println(ttdto.getCancle());
		return tdao.tuteeCurnumCount(ttdto);
	}
	
	//강위취소 튜티 환불금액 update 하고 강의 취소 'Y'로 바꾸기
	//현재인원 늘리기 / 줄이기
	@Transactional("txManager")
	public int refundInsert(TuteeDTO ttdto) throws Exception{
		tdao.refundInsert(ttdto);
		System.out.println(ttdto.getCancle());
		return tdao.tuteeCurnumCountMinus(ttdto);
	}

	//레슨 페이징 만 이동
		public String getPageNavi_lesson(int userCurrentPage, Map<String, String> param) throws SQLException, Exception {
			System.out.println(param.get("keyword"));
			
			int recordTotalCount = tdao.getArticleCount_lesson(param); 
			String orderBy = param.get("orderBy").toString();
			
			int pageTotalCount = 0; // 모든 페이지 개수
			
			if(recordTotalCount % Configuration.RECORD_COUNT_PER_PAGE > 0) {
				pageTotalCount = recordTotalCount / Configuration.RECORD_COUNT_PER_PAGE + 1;
				//게시글 개수를 페이지당 게시글로 나누어 나머지 값이 있으면 한 페이지를 더한다.
			}else {
				pageTotalCount = recordTotalCount / Configuration.RECORD_COUNT_PER_PAGE;
			}
			
			int currentPage = userCurrentPage;//현재 내가 위치한 페이지 번호.	클라이언트 요청값
			//공격자가 currentPage를 변조할 경우에 대한 보안처리
			if(currentPage < 1) {
				currentPage = 1;
			}else if(currentPage > pageTotalCount) {
				currentPage = pageTotalCount;
			}
			
			int startNavi = (currentPage - 1) / Configuration.NAVI_COUNT_PER_PAGE * Configuration.NAVI_COUNT_PER_PAGE + 1;
			
			int endNavi = startNavi + Configuration.NAVI_COUNT_PER_PAGE - 1;
			
			if(endNavi > pageTotalCount) {endNavi = pageTotalCount;}
			
			boolean needPrev = true;
			boolean needNext = true;
			
			if(startNavi == 1) {needPrev = false;}
			if(endNavi == pageTotalCount) {needNext = false;}		
			
			StringBuilder sb = new StringBuilder();
			
			String pagingUrl = null;
			
			if (!param.containsKey("ing")&& !param.containsKey("keyword") && !param.containsKey("end_date") && !param.containsKey("location")) {
				pagingUrl = "lessonList?orderBy=" + orderBy;
			}
			
			if (param.containsKey("ing")) {
				if (param.get("ing").toString().contentEquals("applying='N' and proceeding")) {
					pagingUrl = "lessonListPeriod?orderBy=" + orderBy + "&ing=done"+
							"&keywordSelect=" + param.get("keywordSelect").toString()+ "&keyword="+ param.get("keyword").toString();
				} else {
					pagingUrl = "lessonListPeriod?orderBy=" + orderBy + "&ing=" + param.get("ing").toString()+
							"&keywordSelect=" + param.get("keywordSelect").toString()+ "&keyword="+ param.get("keyword").toString();
				}
			}
			
			if(param.containsKey("keyword")) {
				if(!param.containsKey("ing")) {
					pagingUrl = "searchKeword?orderBy=" +orderBy + "&keywordSelect=" + param.get("keywordSelect").toString()+ "&keyword="+ param.get("keyword").toString();
				}else if(param.get("ing").toString().contentEquals("applying='N' and proceeding")){
					pagingUrl = "lessonListPeriod?orderBy=" + orderBy + "&ing=done"+
							"&keywordSelect=" + param.get("keywordSelect").toString()+ "&keyword="+ param.get("keyword").toString();
				}else {
					pagingUrl = "lessonListPeriod?orderBy=" + orderBy + "&ing=" + param.get("ing").toString()+
							"&keywordSelect=" + param.get("keywordSelect").toString()+ "&keyword="+ param.get("keyword").toString();
				}
			}
			
			if (param.containsKey("start_date")) {
				pagingUrl = "searchDate?orderBy=" + orderBy + "&start_date=" + param.get("start_date").toString() + "&end_date=" + param.get("end_date").toString();
			}
			
			if (param.containsKey("location")) {
				pagingUrl = "searchMap?orderBy=" + orderBy + "&location=" + param.get("location").toString();
			}
			
			
			sb.append("<ul>");
			if(needPrev) {
				sb.append("<li><a href='/tutor/"+pagingUrl+"&cpage="+(startNavi-1)+"'><</a></li>");
			}
			for(int i = startNavi ; i<=endNavi; i++) {

				
				if(userCurrentPage == i) {
					sb.append("<li class='on'><a href='/tutor/"+pagingUrl+"&cpage="+i+"'>"+i+"</a>");//袁몃ŉ二쇰뒗 寃�
				}else {
					sb.append("<li><a href='/tutor/"+pagingUrl+"&cpage="+i+"'>"+i+"</a></li>");//袁몃ŉ二쇰뒗 寃�
				}
			}
			if(needNext) {

				sb.append("<li><a href='/tutor/"+pagingUrl+"&cpage="+(endNavi+1)+"'>></a></li>");
			}
			
			sb.append("</ul>");
			return sb.toString();
		}
		
		//튜터 페이징 만 이동
			public String getPageNavi_tutor(int userCurrentPage) throws SQLException, Exception {
				int recordTotalCount = tdao.getArticleCount_tutor(); 
				
				int pageTotalCount = 0; // 모든 페이지 개수
				
				if(recordTotalCount % Configuration.RECORD_COUNT_PER_PAGE > 0) {
					pageTotalCount = recordTotalCount / Configuration.RECORD_COUNT_PER_PAGE + 1;
					//게시글 개수를 페이지당 게시글로 나누어 나머지 값이 있으면 한 페이지를 더한다.
				}else {
					pageTotalCount = recordTotalCount / Configuration.RECORD_COUNT_PER_PAGE;
				}
				
				int currentPage = userCurrentPage;//현재 내가 위치한 페이지 번호.	클라이언트 요청값
				//공격자가 currentPage를 변조할 경우에 대한 보안처리
				if(currentPage < 1) {
					currentPage = 1;
				}else if(currentPage > pageTotalCount) {
					currentPage = pageTotalCount;
				}
				
				int startNavi = (currentPage - 1) / Configuration.NAVI_COUNT_PER_PAGE * Configuration.NAVI_COUNT_PER_PAGE + 1;
				
				int endNavi = startNavi + Configuration.NAVI_COUNT_PER_PAGE - 1;
				
				if(endNavi > pageTotalCount) {endNavi = pageTotalCount;}
				
				boolean needPrev = true;
				boolean needNext = true;
				
				if(startNavi == 1) {needPrev = false;}
				if(endNavi == pageTotalCount) {needNext = false;}		
				
				StringBuilder sb = new StringBuilder();
				
				sb.append("<ul>");
				if(needPrev) {
					sb.append("<li><a href='tutorList?cpage="+(startNavi-1)+"'><</a></li>");
				}
				for(int i = startNavi ; i<=endNavi; i++) {
					if(currentPage == i) {
						sb.append("<li class='on'><a href='tutorList?cpage="+i+"'>"+i+"</a></li>");//꾸며주는 것
					}else {
						sb.append("<li><a href='tutorList?cpage="+i+"'>"+i+"</a></li>");//꾸며주는 것
					}
				}
				if(needNext) {

					sb.append("<li><a href='tutorList?cpage="+(endNavi+1)+"'>></a></li>");
				}
				sb.append("</ul>");
				return sb.toString();
			}
	
}
