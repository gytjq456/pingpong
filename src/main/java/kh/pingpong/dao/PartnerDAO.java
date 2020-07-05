package kh.pingpong.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.pingpong.config.Configuration;
import kh.pingpong.dto.HobbyDTO;
import kh.pingpong.dto.LanguageDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.PartnerDTO;

@Repository
public class PartnerDAO {	

	@Autowired 
	SqlSessionTemplate mybatis;
	
	// 취미 선택
	public List<HobbyDTO> selectHobby() throws Exception{
		return mybatis.selectList("Partner.selectHobby");
	}
	
	// 언어 선택
	public List<LanguageDTO> selectLanguage() throws Exception{
		return mybatis.selectList("Partner.selectLanguage");
	}
	
	//리뷰
	public PartnerDTO selectBySeq(int seq) throws Exception{
		Double reviewAvg = mybatis.selectOne("Partner.reviewAvg",seq);
		if(reviewAvg != null) {
			reviewAvg = mybatis.selectOne("Partner.reviewAvg",seq);
		}else {
			reviewAvg = 0.0;
		}
		int reviewCount = mybatis.selectOne("Partner.reviewCount",seq);
		Map<String, Object> paramVal = new HashMap<>();
		paramVal.put("seq", seq);
		paramVal.put("reviewCount", reviewCount);
		paramVal.put("reviewAvg", reviewAvg);
		mybatis.update("Partner.partnerReviewPoint",paramVal);
		mybatis.update("Partner.partnerReviewCount",paramVal);
		return mybatis.selectOne("Partner.selectBySeq", seq);
	}
	
	//게시글 
	public int getArticleCount() throws Exception{
		return mybatis.selectOne("Partner.getArticleCount");
	}
	
	//파트너 게시글 페이징
	public List<PartnerDTO> selectByPageNo(int cpage) throws Exception{
		int start =cpage * Configuration.RECORD_COUNT_PER_PAGE - (Configuration.RECORD_COUNT_PER_PAGE-1);
		int end = start + (Configuration.RECORD_COUNT_PER_PAGE-1);
		Map <String, Integer> param = new HashMap<>();
		param.put("start", start);
		param.put("end", end);
		return mybatis.selectList("Partner.selectByPageNo", param);
	}
	
	//파트너 검색
	public List<PartnerDTO> search(int cpage, Map<String, Object> search, PartnerDTO pdto/* , String orderBy */) throws Exception{
		int start =cpage * Configuration.RECORD_COUNT_PER_PAGE - (Configuration.RECORD_COUNT_PER_PAGE-1);
		int end = start + (Configuration.RECORD_COUNT_PER_PAGE-1);
		search.put("start", start);
		search.put("end", end);
		search.put("pdto", pdto);
		//search.put("orderBy",orderBy);
		return mybatis.selectList("Partner.search",search);
	}
	
	//멤버 선택
	public MemberDTO selectMember(String id) throws Exception{
		return mybatis.selectOne("Partner.selectMember", id);
	}
	//파트너 등록
	public int insertPartner(Map<String, Object> insertP) throws Exception{
		return mybatis.insert("Partner.insertPartner", insertP);
	}
	//파트너 등록 후 멤버 등급 partner로 변경
	public int updateMemberGrade(MemberDTO mdto) throws Exception{
		return mybatis.update("Partner.updateMemberGrade",mdto);
	}
	
	//파트너 삭제
	public int deletePartner(MemberDTO mdto) throws Exception{
		return mybatis.delete("Partner.deletePartner", mdto);
	}
	
	public List<PartnerDTO> partnerListAll() throws Exception{
		return mybatis.selectList("Partner.partnerListAll");
	}
	
}
