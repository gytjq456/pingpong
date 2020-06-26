package kh.pingpong.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.pingpong.dto.BankDTO;
import kh.pingpong.dto.CountryDTO;
import kh.pingpong.dto.FileDTO;
import kh.pingpong.dto.HobbyDTO;
import kh.pingpong.dto.LanguageDTO;
import kh.pingpong.dto.MemberDTO;

@Repository
public class MemberDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public List<BankDTO> bankList(){
		return mybatis.selectList("Member.bankList");
	}
	
	public List<HobbyDTO> hobbyList() {
		return mybatis.selectList("Member.hobbyList");
	}
	
	public List<LanguageDTO> lanList() {
		return mybatis.selectList("Member.lanList");
	}
	
	public List<CountryDTO> countryList(){
		return mybatis.selectList("Member.countryList");
	}
	
	public int memberInsert(MemberDTO mdto, FileDTO fdto) {
		Map<String, Object> memberAdd = new HashMap<>();
		memberAdd.put("mdto",mdto);
		memberAdd.put("fdto",fdto);
		System.out.println(mdto.getPhone_country() +"gkgkgkgkgkgkgk");
		System.out.println(mdto.getPhone()+"밍밍");
		return mybatis.insert("Member.memberInsert",memberAdd);
	}
	
	public int memberFile(FileDTO fdto) {
		return mybatis.insert("Member.memberFile",fdto);
	}
	
	
}
