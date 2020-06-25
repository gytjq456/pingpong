package kh.pingpong.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.pingpong.dao.DiscussionDAO;
import kh.pingpong.dto.DiscussionDTO;
import kh.pingpong.dto.LanguageDTO;

@Service
public class DiscussionService {
	
	@Autowired
	DiscussionDAO disDao;
	
	// 토론 글쓰기 페이지에서 언어 목록 불러오기
	public List<LanguageDTO> langSelectlAll() throws Exception{
		return disDao.langSelectlAll();
	}
	
	// 토론 글 쓰기
	public int insert(DiscussionDTO disDTO) throws Exception{
		return disDao.insert(disDTO);
	}
	
	// 토론 전체 목록 가져오기
	public List<DiscussionDTO> selectAll() throws Exception{
		List<DiscussionDTO> list = disDao.selectAll();
		for(DiscussionDTO disDto : list) {
			String contents = disDto.getContents();
			String contReplace = contents.replaceAll("(<img.+\">)", "");
			disDto.setContents(contReplace);
		}		
		return list;
	}
	
	// 토론 게시글 보기
	public DiscussionDTO selectOne(int seq) throws Exception{
		disDao.viewCount(seq);
		return disDao.selectOne(seq);
	}
	
	// 토론 글 삭제
	public int delete(int seq) throws Exception{
		return disDao.delete(seq);
	}
	
	// 토론 글 수정하기
	public int modify(DiscussionDTO disDto) throws Exception{
		return disDao.modify(disDto);
	}
	
}
