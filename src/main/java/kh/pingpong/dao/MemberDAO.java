package kh.pingpong.dao;

import java.util.HashMap;
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
	
	public int memberInsert(MemberDTO mdto, FileDTO fdto) {
		Map<String, Object> memberAdd = new HashMap<>();
		memberAdd.put("mdto",mdto);
		memberAdd.put("fdto",fdto);
		return mybatis.insert("Member.memberInsert",memberAdd);
	}
	
	public int memberFile(FileDTO fdto) {
		
		System.out.println(fdto.getRealpath());
		return mybatis.insert("Member.memberFile",fdto);
	}	
	
	public MemberDTO memberSelect(MemberDTO loginInfo) {		
		return mybatis.selectOne("Member.memberSelect", loginInfo);
	}
	
	/* 아디 비번 일치? */
	public int isIdPwSame(MemberDTO mdto) {
		return mybatis.selectOne("Member.isIdPwSame",mdto);
	}
	
	/* 회원DTO 넣기 */
	public MemberDTO loginInfo(MemberDTO mdto) {
		return mybatis.selectOne("Member.loginInfo", mdto);
	}
	
	/* 아아디 중복체크  */
	public int duplcheckId(MemberDTO mdto) {
		return mybatis.selectOne("Member.duplcheckId", mdto);
	}
	
	/* 아이디찾기 */
	public List<MemberDTO> idFindProc(MemberDTO mdto) {		
		System.out.println(mdto.getName() + mdto.getEmail() + "  DAO");
		return mybatis.selectList("Member.idFindProc", mdto);
	}
	
	/* 비밀번호찾기 */
	public int pwFindProc(MemberDTO mdto) {		
		return mybatis.selectOne("Member.pwFindProc", mdto);
	}
	
	/* 비밀번호수정 */
	public int pwModifyProc(MemberDTO mdto) {
		System.out.println(mdto.getPw());
		return mybatis.update("Member.pwModifyProc", mdto);
	}
	
}














