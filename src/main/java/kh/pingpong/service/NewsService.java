package kh.pingpong.service;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kh.pingpong.dao.NewsDAO;
import kh.pingpong.dto.FileDTO;
import kh.pingpong.dto.FileTnDTO;
import kh.pingpong.dto.NewsDTO;

@Service
public class NewsService {
	
	@Autowired
	private NewsDAO newsdao;
	
	@Transactional("txManager")
	public int newsInsert(NewsDTO ndto, FileDTO ftndto, List<FileDTO> filseA) throws Exception{
		
		//파일 여러개를 string으로 변경하여 ndto에 Files_name 넣음
		String[] files_insert = new String[filseA.size()];
		int i = 0;
		for(FileDTO f : filseA) {
			files_insert[i++] = f.getSysname();
		}
		String arrayS = Arrays.toString(files_insert);
		String arrayS_result = arrayS.substring(1, arrayS.length()-1);
		ndto.setFiles_name(arrayS_result);
		
		//파일 한개 세팅
		newsdao.newsInsert_new(ndto, ftndto);
		newsdao.newsInsert_ftn(ftndto); //프로필저장
		
		for(FileDTO all: filseA) {
			newsdao.newsInsert_filseA(all);
		}
		
		return 1;
	}
	
	public List<NewsDTO> newsSelect() throws Exception{
		return newsdao.newsSelect();
	}
	
	public NewsDTO newsViewOne(NewsDTO ndto) throws Exception{
		return newsdao.newsViewOne(ndto);
	}
	
	//글 수정 (news테이블 수정 + 프로필 변경 + 첨부파일 변경시)
	@Transactional("txManager")
	public int modifyProcAll(NewsDTO ndto, FileDTO ftndto, List<FileDTO> filseA) throws Exception{
		//첨부파일들을 string으로 변경하여 ndto에 Files_name 넣음
		String[] files_insert = new String[filseA.size()];
		int i = 0;
		for(FileDTO f : filseA) {
			files_insert[i++] = f.getSysname();
		}
		String arrayS = Arrays.toString(files_insert);
		String arrayS_result = arrayS.substring(1, arrayS.length()-1);
		ndto.setFiles_name(arrayS_result);
		
		//프로필저장
		newsdao.newsUpdate_ftn(ftndto);
		
		//첨부파일들 저장
		for(FileDTO filesAll: filseA) {
			newsdao.newsUpdate_files(filesAll);
		}
		
		//파일 한개 세팅
		ftndto.setParent_seq(ndto.getSeq());
		newsdao.newsUpdate_new(ndto, ftndto);
		
		return 1;
	}
	
	//글 수정 (news테이블 수정 + 프로필 변경)
	@Transactional("txManager")
	public int modifyProc(NewsDTO ndto, FileDTO ftndto) throws Exception{
		//파일 한개 세팅
		ftndto.setParent_seq(ndto.getSeq());
		newsdao.newsUpdate_new(ndto, ftndto);
			
		//프로필저장
		newsdao.newsUpdate_ftn(ftndto);

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
	
	//new 게시판 카운트
	
	//뉴스 페이징
	
	
}
