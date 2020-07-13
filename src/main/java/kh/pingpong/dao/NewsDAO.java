package kh.pingpong.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.pingpong.dto.FileDTO;
import kh.pingpong.dto.FileTnDTO;
import kh.pingpong.dto.NewsDTO;

@Repository
public class NewsDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public int newsInsert_new(NewsDTO ndto, FileTnDTO ftndto) throws Exception{
		
		Map<String, Object> newsAdd = new HashMap<>(); 
		newsAdd.put("ndto", ndto);
		newsAdd.put("ftndto", ftndto);		
		
		return mybatis.insert("News.newsInsert_new", newsAdd);
	}
	
	public int newsInsert_ftn(FileTnDTO ftndto) throws Exception{
		return mybatis.insert("News.newsInsert_ftn", ftndto);		
	}
	
	public int newsInsert_filseA(FileDTO a) throws Exception{
		return mybatis.insert("News.newsInsert_filseA", a);		
	}
	
	public List<NewsDTO> newsSelect() throws Exception{
		List<NewsDTO> a = mybatis.selectList("News.newsSelect");
		return a;
	}
	
	public NewsDTO newsViewOne(NewsDTO ndto) throws Exception{
		return mybatis.selectOne("News.newsViewOne", ndto);
	}
	
	//list 파일 select
	public List <FileTnDTO> newsViewFile(NewsDTO ndto) throws Exception{
		return mybatis.selectList("News.newsViewFile", ndto);
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
	
}






