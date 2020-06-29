package kh.pingpong.service;

import java.io.File;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kh.pingpong.config.Configuration;
import kh.pingpong.dao.FileDAO;
import kh.pingpong.dao.TutorDAO;
import kh.pingpong.dto.DeleteApplyDTO;
import kh.pingpong.dto.FileDTO;
import kh.pingpong.dto.LessonDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.TutorAppDTO;

@Service
public class TutorService {

	@Autowired
	private TutorDAO tdao;
	
	@Autowired
	private FileDAO fdao;
	
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
	
	public List<LessonDTO> lessonList(int cpage) throws Exception{
		List<LessonDTO> ldto = tdao.lessonList(cpage);
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
	
	
	
	//레슨 페이징 만 이동
		public String getPageNavi_lesson(int userCurrentPage) throws SQLException, Exception {
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
				sb.append("<a href='lessonList?cpage="+(startNavi-1)+"'><</a>");
			}
			for(int i = startNavi ; i<=endNavi; i++) {

				sb.append("<a href='lessonList?cpage="+i+"'>"+i+"</a>");//袁몃ŉ二쇰뒗 寃�
			}
			if(needNext) {

				sb.append("<a href='lessonList?cpage="+(endNavi+1)+"'>></a>");
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
