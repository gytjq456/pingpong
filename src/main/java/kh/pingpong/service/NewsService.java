package kh.pingpong.service;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import kh.pingpong.config.Configuration;
import kh.pingpong.dao.NewsDAO;
import kh.pingpong.dto.FileDTO;
import kh.pingpong.dto.NewsDTO;

@Service
public class NewsService {
	
	@Autowired
	private NewsDAO newsdao;
	
	@Transactional("txManager")
	public int newsInsert(NewsDTO ndto, FileDTO ftndto, List<FileDTO> filseA) throws Exception{
		
		//첨부파일을 string으로 변경하여 ndto에 Files_name넣음
		String[] files_insert = new String[filseA.size()];
		int i = 0;
		for(FileDTO f : filseA) {
			files_insert[i++] = f.getSysname();
		}
		String arrayS = Arrays.toString(files_insert);
		String arrayS_result = arrayS.substring(1, arrayS.length()-1);
		ndto.setFiles_name(arrayS_result);
		
		//insert 진행
		newsdao.newsInsert(ndto, ftndto);
		
		//프로필 DB 저장
		newsdao.newsInsert_thumb(ftndto);
		
		//첨부파일 DB 저장
		for(FileDTO all: filseA) {
			newsdao.newsInsert_files(all);
		}
		
		return 1;
	}
	
	//list & 네비바
	public String getPageNavi_news(int userCurrentPage) throws Exception{
		int recordTotalCount = newsdao.newsBoard_count(); 
		
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
				sb.append("<li><a href='/news/listProc?cpage="+(startNavi-1)+"'><</a></li>");
			}
			for(int i = startNavi ; i<=endNavi; i++) {
				if(currentPage == i) {
					sb.append("<li class='on'><a href='/news/listProc?cpage="+i+"'>"+i+"</a></li>");//꾸며주는 것
				}else {
					sb.append("<li><a href='/news/listProc?cpage="+i+"'>"+i+"</a></li>");//꾸며주는 것
				}
			}
			if(needNext) {
				sb.append("<li><a href='/news/listProc?cpage="+(endNavi+1)+"'>></a></li>");
			}
		sb.append("</ul>");
		
		return sb.toString();
	}
	
	//list 게시물
	public List<NewsDTO> newsPage(int cpage) throws Exception {
		return newsdao.newsPage(cpage);
	}	
	
	//view 페이지 게시물
	public NewsDTO newsViewOne(NewsDTO ndto) throws Exception{
		return newsdao.newsViewOne(ndto);
	}
	
	//글 수정 (news테이블 수정 + 첨부파일 변경시)
	@Transactional("txManager")
	public int modifyProcAll(NewsDTO ndto, List<FileDTO> filseA) throws Exception{
		//첨부파일들을 string으로 변경하여 ndto에 Files_name 넣음
		String[] files_insert = new String[filseA.size()];
		int i = 0;
		for(FileDTO f : filseA) {
			files_insert[i++] = f.getSysname();
		}
		String arrayS = Arrays.toString(files_insert);
		String arrayS_result = arrayS.substring(1, arrayS.length()-1);
		ndto.setFiles_name(arrayS_result);
		
		System.out.println(":: 배열의 이름  :: " + arrayS_result);
		
		//뉴스 업로드		
		System.out.println("ndto :: " + ndto.getFiles_name());
		System.out.println("ndto :: " + ndto.getSeq());
		System.out.println("ndto :: " + ndto.getTitle());
		newsdao.newsUpdate_new_filesAll(ndto);
		
		System.out.println("파일들 수정 + sevice");
		//첨부파일들 저장
		for(FileDTO filesAll: filseA) {
			filesAll.setParent_seq(ndto.getSeq());
			newsdao.newsUpdate_files(filesAll);
		}
		
		return 1;
	}
	
	//글 수정 (news테이블 수정 + 프로필 변경)
	@Transactional("txManager")
	public int modifyProc(NewsDTO ndto, FileDTO ftndto) throws Exception{
		//파일 한개 세팅
		ftndto.setParent_seq(ndto.getSeq());
		
		//news글 update
		newsdao.newsUpdate_new(ndto, ftndto);
		
		System.out.println("프로필 수정 service");
		//프로필저장
		newsdao.newsUpdate_ftn(ftndto);

		return 1;
	}
	
	//글 수정 (news테이블 수정)
	@Transactional("txManager")
	public int modifyProc_news(NewsDTO ndto) throws Exception{
		newsdao.modifyProc_news(ndto);
		return 1;
	}
	
	//list 파일 select
	public List <FileDTO> newsViewFile(NewsDTO ndto) throws Exception{
		return newsdao.newsViewFile(ndto);
	}
	
	//글수정 파일 하나 삭제 
	public int dele_fileOne(NewsDTO ndto) throws Exception{
		return newsdao.fileDelete(ndto);
	}
	
	//게시글 삭제
	@Transactional("txManager")
	public int delete(NewsDTO ndto) throws Exception{
		newsdao.fileDelete(ndto);
		newsdao.dele_thumbnail(ndto);
		return newsdao.delete(ndto);
	}
	
	//조회순
	public int viewCount(NewsDTO ndto) throws Exception{
		return newsdao.viewCount(ndto);
	}
	
	/* 글 정렬 */
	public List<NewsDTO> schAlign(String schAlign, int cpage) throws Exception{
		return newsdao.schAlign(schAlign, cpage);
	}
	
}
