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
	public int newsInsert(NewsDTO ndto, FileTnDTO ftndto, List<FileDTO> filseA) throws Exception{
		
		//파일 여러개를 string으로 변경하여 ndto에 Files_name 넣음
		String[] files_insert = new String[3];
		int i = 0;
		for(FileDTO f : filseA) {
			files_insert[i++] = f.getSysname();
		}
		String arrayS = Arrays.toString(files_insert);
		String arrayS_result = arrayS.substring(1, arrayS.length()-1);
		ndto.setFiles_name(arrayS_result);
		
		//파일 한개 세팅
		System.out.println(ftndto.getCategory() + " :: " + ftndto.getParent_seq());
		
		newsdao.newsInsert_new(ndto, ftndto);
		newsdao.newsInsert_ftn(ftndto); //프로필저장
		
		for(FileDTO a: filseA) {
			newsdao.newsInsert_filseA(a);
		}
		
		return 1;
	}
	
	public List<NewsDTO> newsSelect() throws Exception{
		return newsdao.newsSelect();
	}
	
	public NewsDTO newsViewOne(NewsDTO ndto) throws Exception{
		return newsdao.newsViewOne(ndto);
	}
	
}
