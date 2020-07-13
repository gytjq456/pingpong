package kh.pingpong.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.pingpong.config.Configuration;
import kh.pingpong.dto.FileDTO;
import kh.pingpong.dto.NewsDTO;

@Repository
public class NewsDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public int newsInsert_new(NewsDTO ndto, FileDTO ftndto) throws Exception{
		
		Map<String, Object> newsAdd = new HashMap<>(); 
		newsAdd.put("ndto", ndto);
		newsAdd.put("ftndto", ftndto);		
		
		return mybatis.insert("News.newsInsert_new", newsAdd);
	}
	
	public int newsInsert_ftn(FileDTO ftndto) throws Exception{
		return mybatis.insert("News.newsInsert_ftn", ftndto);		
	}
	
	public int newsInsert_filseA(FileDTO all) throws Exception{
		return mybatis.insert("News.newsInsert_filseA", all);		
	}
	
	public List<NewsDTO> newsSelect() throws Exception{
		List<NewsDTO> a = mybatis.selectList("News.newsSelect");
		return a;
	}
	
	public NewsDTO newsViewOne(NewsDTO ndto) throws Exception{
		return mybatis.selectOne("News.newsViewOne", ndto);
	}
	
	//news list 총 갯수
	public int newsBoard_count() {
		return mybatis.selectOne("News.newsBoard_count");
	}
	
	//list 게시물
	public List<NewsDTO> newsPage(int cpage) throws Exception {
		int start = cpage*Configuration.RECORD_COUNT_PER_PAGE - (Configuration.RECORD_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.RECORD_COUNT_PER_PAGE - 1);
		
		Map<String, Integer> pageNum = new HashMap<>();
		pageNum.put("start", start);
		pageNum.put("end", end);
		
		return mybatis.selectList("News.newsPage",pageNum);
	}	
	
	//list 파일 select
	public List <FileDTO> newsViewFile(NewsDTO ndto) throws Exception{
		return mybatis.selectList("News.newsViewFile", ndto);
	}
	
	//프로필 수정
	public int newsUpdate_ftn(FileDTO ftndto) throws Exception{
		return mybatis.update("News.newsUpdate_ftn", ftndto);
	}
	
	//파일들 수정
	public int newsUpdate_files(FileDTO filesAll) throws Exception {
		return mybatis.update("News.newsUpdate_files", filesAll);
	}
	
	//수정
	public int newsUpdate_new(NewsDTO ndto, FileDTO ftndto) throws Exception{
		Map<String, Object> newsAdd = new HashMap<>(); 
		newsAdd.put("ndto", ndto);
		newsAdd.put("ftndto", ftndto);		
		return mybatis.update("News.newsUpdate_new", newsAdd);
	}
	
	//게시글 삭제
	public int delete(NewsDTO ndto) throws Exception{
		return mybatis.delete("News.delete", ndto);
	}
	
	//files 삭제
	public int fileDelete(NewsDTO ndto) throws Exception{
		ndto.setCategory("news");
		return mybatis.delete("News.fileDelete", ndto);
	}
	
	//프로필 하나 삭제
	public int dele_thumbnail(NewsDTO ndto) throws Exception{
		ndto.setCategory("news_thumb");
		return mybatis.delete("News.fileDelete", ndto);
	}
	
	//view count
	public int viewCount(NewsDTO ndto) throws Exception{
		return mybatis.update("News.viewCount",ndto);
	}
	
	/* 글 정렬 */
	public List<NewsDTO> schAlign(String schAlign, int cpage) throws Exception{
		int start = cpage*Configuration.RECORD_COUNT_PER_PAGE - (Configuration.RECORD_COUNT_PER_PAGE - 1);
		int end = start + (Configuration.RECORD_COUNT_PER_PAGE - 1);
		
		Map<String, Object> schMap = new HashMap<>();
		schMap.put("schAlign", schAlign);
		schMap.put("start", start);
		schMap.put("end", end);
		
		System.out.println(schMap.get("schAlign") + " :::::");
		
		return mybatis.selectList("News.schAlign", schMap);
	}
}






