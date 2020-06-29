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
	
	
	
	//�젅�뒯 �럹�씠吏� 留� �씠�룞 
		public String getPageNavi_lesson(int userCurrentPage) throws SQLException, Exception {
			int recordTotalCount = tdao.getArticleCount_lesson(); 
			
			int pageTotalCount = 0; // 紐⑤뱺 �럹�씠吏� 媛쒖닔
			
			if(recordTotalCount % Configuration.RECORD_COUNT_PER_PAGE > 0) {
				pageTotalCount = recordTotalCount / Configuration.RECORD_COUNT_PER_PAGE + 1;
				//寃뚯떆湲� 媛쒖닔瑜� �럹�씠吏��떦 寃뚯떆湲�濡� �굹�늻�뼱 �굹癒몄� 媛믪씠 �엳�쑝硫� �븳 �럹�씠吏�瑜� �뜑�븳�떎.
			}else {
				pageTotalCount = recordTotalCount / Configuration.RECORD_COUNT_PER_PAGE;
			}
			
			int currentPage = userCurrentPage;	//�쁽�옱 �궡媛� �쐞移섑븳 �럹�씠吏� 踰덊샇.	�겢�씪�씠�뼵�듃 �슂泥�媛�
			//怨듦꺽�옄媛� currentPage瑜� 蹂�議고븷 寃쎌슦�뿉 ���븳 蹂댁븞泥섎━
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
		
		//�뒠�꽣 �럹�씠吏� 留� �씠�룞 
				public String getPageNavi_tutor(int userCurrentPage) throws SQLException, Exception {
					int recordTotalCount = tdao.getArticleCount_tutor(); 
					
					int pageTotalCount = 0; // 紐⑤뱺 �럹�씠吏� 媛쒖닔
					
					if(recordTotalCount % Configuration.RECORD_COUNT_PER_PAGE > 0) {
						pageTotalCount = recordTotalCount / Configuration.RECORD_COUNT_PER_PAGE + 1;
						//寃뚯떆湲� 媛쒖닔瑜� �럹�씠吏��떦 寃뚯떆湲�濡� �굹�늻�뼱 �굹癒몄� 媛믪씠 �엳�쑝硫� �븳 �럹�씠吏�瑜� �뜑�븳�떎.
					}else {
						pageTotalCount = recordTotalCount / Configuration.RECORD_COUNT_PER_PAGE;
					}
					
					int currentPage = userCurrentPage;	//�쁽�옱 �궡媛� �쐞移섑븳 �럹�씠吏� 踰덊샇.	�겢�씪�씠�뼵�듃 �슂泥�媛�
					//怨듦꺽�옄媛� currentPage瑜� 蹂�議고븷 寃쎌슦�뿉 ���븳 蹂댁븞泥섎━
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

						sb.append("<a href='tutorList?cpage="+i+"'>"+i+"</a>");//袁몃ŉ二쇰뒗 寃�
					}
					if(needNext) {

						sb.append("<a href='tutorList?cpage="+(endNavi+1)+"'>></a>");
					}
					
					return sb.toString();
				}
	
}
