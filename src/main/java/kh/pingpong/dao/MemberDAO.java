package kh.pingpong.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
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
	
	public int memberInsert(MemberDTO mdto) {
		return mybatis.insert("Member.memberInsert",mdto);
	}
	
	public int memberFile(FileDTO fdto) {
		return mybatis.insert("Member.memberFile",fdto);
	}
	
	
}
