package kh.pingpong.service;

import java.io.File;
import java.sql.SQLException;
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
	
	//레슨 페이징 만 이동
		public String getPageNavi_lesson(int userCurrentPage, String orderBy) throws SQLException, Exception {
			int recordTotalCount = tdao.getArticleCount_lesson(); 
			
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
			
			if(needPrev) {
				sb.append("<a href='/tutor/lessonList?cpage="+(startNavi-1)+"&orderBy="+orderBy+"'><</a>");
			}
			for(int i = startNavi ; i<=endNavi; i++) {

				sb.append("<a href='/tutor/lessonList?cpage="+i+"&orderBy="+orderBy+"'>"+i+"</a>");//袁몃ŉ二쇰뒗 寃�
			}
			if(needNext) {

				sb.append("<a href='/tutor/lessonList?cpage="+(endNavi+1)+"&orderBy="+orderBy+"'>></a>");
			}
			
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
					
					if(needPrev) {
						sb.append("<a href='tutorList?cpage="+(startNavi-1)+"'><</a>");
					}
					for(int i = startNavi ; i<=endNavi; i++) {

						sb.append("<a href='tutorList?cpage="+i+"'>"+i+"</a>");//꾸며주는 것
					}
					if(needNext) {

						sb.append("<a href='tutorList?cpage="+(endNavi+1)+"'>></a>");
					}
					
					return sb.toString();
				}
	
}
