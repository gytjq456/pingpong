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
	
	public List<HobbyDTO> selectHobby() throws Exception{
		return mybatis.selectList("Partner.selectHobby");
	}
	
	public List<LanguageDTO> selectLanguage() throws Exception{
		return mybatis.selectList("Partner.selectLanguage");
	}
	
	public PartnerDTO selectBySeq(int seq) throws Exception{
		return mybatis.selectOne("Partner.selectBySeq", seq);
	}
	
	public int getArticleCount() throws Exception{
		return mybatis.selectOne("Partner.getArticleCount");
	}
	public List<PartnerDTO> selectByPageNo(int cpage) throws Exception{
		int start =cpage * Configuration.RECORD_COUNT_PER_PAGE - (Configuration.RECORD_COUNT_PER_PAGE-1);
		int end = start + (Configuration.RECORD_COUNT_PER_PAGE-1);
		Map <String, Integer> param = new HashMap<>();
		param.put("start", start);
		param.put("end", end);
		return mybatis.selectList("Partner.selectByPageNo", param);
	}
	
	public List<PartnerDTO> search(int cpage, Map<String,Object> search, PartnerDTO pdto) throws Exception{
		int start =cpage * Configuration.RECORD_COUNT_PER_PAGE - (Configuration.RECORD_COUNT_PER_PAGE-1);
		int end = start + (Configuration.RECORD_COUNT_PER_PAGE-1);
		search.put("start", start);
		search.put("end", end);
		search.put("pdto", pdto);
	
		System.out.println(pdto.getAddress());
		System.out.println(pdto.getGender());
		System.out.println(pdto.getHobby());
		System.out.println(pdto.getLang_can());
		System.out.println(pdto.getLang_learn());
		return mybatis.selectList("Partner.search",search);
	}
	
	public MemberDTO selectMember(String id) throws Exception{
		return mybatis.selectOne("Partner.selectMember", id);
	}
	public int insertPartner(Map<String, Object> insertP) throws Exception{
		return mybatis.insert("Partner.insertPartner", insertP);
	}
	
	public List<PartnerDTO> partnerListAll() throws Exception{
		return mybatis.selectList("Partner.partnerListAll");
	}
}
