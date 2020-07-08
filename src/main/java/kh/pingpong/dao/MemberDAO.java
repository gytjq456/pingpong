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
	
	public List<BankDTO> bankList() throws Exception{
		return mybatis.selectList("Member.bankList");
	}
	
	public List<HobbyDTO> hobbyList() throws Exception{
		return mybatis.selectList("Member.hobbyList");
	}
	
	public List<LanguageDTO> lanList() throws Exception{
		return mybatis.selectList("Member.lanList");
	}
	
	public List<CountryDTO> countryList() throws Exception{
		return mybatis.selectList("Member.countryList");
	}
	
	/* 회원가입 */
	public int memberInsert(MemberDTO mdto, FileDTO fdto) throws Exception{
		Map<String, Object> memberAdd = new HashMap<>();
		memberAdd.put("mdto",mdto);
		memberAdd.put("fdto",fdto);
		return mybatis.insert("Member.memberInsert",memberAdd);
	}
	
	/* 사진파일 데이터베이스에 저장 */
	public int memberFile(FileDTO fdto) throws Exception{		
		System.out.println(fdto.getRealpath());
		return mybatis.insert("Member.memberFile",fdto);
	}	
	
	public MemberDTO memberSelect(MemberDTO loginInfo) throws Exception{		
		return mybatis.selectOne("Member.memberSelect", loginInfo);
	}
	
	/* 아디 비번 일치? */
	public int isIdPwSame(MemberDTO mdto) throws Exception{
		return mybatis.selectOne("Member.isIdPwSame",mdto);
	}
	
	/* 회원DTO 넣기 */
	public MemberDTO loginInfo(MemberDTO mdto) throws Exception{
		return mybatis.selectOne("Member.loginInfo", mdto);
	}
	
	/* 아아디 중복체크  */
	public int duplcheckId(MemberDTO mdto) throws Exception{
		return mybatis.selectOne("Member.duplcheckId", mdto);
	}
	
	/* 아이디찾기 */
	public List<MemberDTO> idFindProc(MemberDTO mdto) throws Exception{	
		System.out.println(mdto.getName() + mdto.getEmail() + "  DAO");
		return mybatis.selectList("Member.idFindProc", mdto);
	}
	
	/* 비밀번호찾기 */
	public int pwFindProc(MemberDTO mdto) throws Exception{	
		return mybatis.selectOne("Member.pwFindProc", mdto);
	}
	
	/* 비밀번호수정 */
	public int pwModifyProc(MemberDTO mdto) throws Exception{
		return mybatis.update("Member.pwModifyProc", mdto);
	}
	
	/* 회원탈퇴 */
	public int memWithdrawal(MemberDTO mdto) throws Exception{
		return mybatis.delete("Member.memWithdrawal", mdto);
	}
	
	/* 회원탈퇴 프로필 삭제 */
	public int memProfileDele(MemberDTO mdto) throws Exception{
		return mybatis.delete("Member.memProfileDele", mdto);
	}
	
	/* :::: 회원정보수정  :::: */
	/* 전화번호 */
	public int myInfoMoPhone(MemberDTO mdto) throws Exception{
		return mybatis.update("Member.myInfoMoPhone", mdto);
	}
	
	/* 주소 */
	public int myInfoMoAddress(MemberDTO mdto) throws Exception{
		return mybatis.update("Member.myInfoMoAddress", mdto);
	}
	
	/* 은행 */
	public int myInfoMobank(MemberDTO mdto) throws Exception{
		return mybatis.update("Member.myInfoMobank", mdto);
	}
	
	/* 프로필 */
	public int myInfoProfile(MemberDTO mdto,FileDTO fdto) throws Exception{
		Map<String, Object> myInfoPAdd = new HashMap<>();
		myInfoPAdd.put("mdto",mdto);
		myInfoPAdd.put("fdto",fdto);
		return mybatis.insert("Member.myInfoProfile",myInfoPAdd);
	}
	
	/* 프로필 데이터베이스에 update 저장 */
	public int myInfoProfileFile(MemberDTO mdto, FileDTO fdto) throws Exception{
		Map<String, Object> myInfoPAdd = new HashMap<>();
		myInfoPAdd.put("mdto",mdto);
		myInfoPAdd.put("fdto",fdto);
		
		System.out.println(fdto.getRealpath());
		
		return mybatis.update("Member.myInfoProfileFile",myInfoPAdd);
	}	
	
	/* 나라 */
	public int myInfoCountry(MemberDTO mdto) throws Exception{
		return mybatis.update("Member.myInfoCountry", mdto);
	}
	
	/* 할 수 있는 언어  */
	public int myInfoLang_can(MemberDTO mdto) throws Exception{
		return mybatis.update("Member.myInfoLang_can", mdto);
	}
	
	/* 배우고 싶은 언어  */
	public int myInfoLang_learn(MemberDTO mdto) throws Exception{
		return mybatis.update("Member.myInfoLang_learn", mdto);
	}
	
	/* 취미  */
	public int myInfoHobby(MemberDTO mdto) throws Exception{
		return mybatis.update("Member.myInfoHobby", mdto);
	}
	
	/* introduce */
	public int myInfoIntroduce(MemberDTO mdto) throws Exception{
		return mybatis.update("Member.myInfoIntroduce", mdto);
	}
	
	/* introduce */
	public int scheduleAgeUp() throws Exception{
		System.out.println("크론식에 들어 왔나요?");
		return mybatis.update("Member.scheduleAgeUp");
	}
	
	/* 언어 선호 */
	public int updateLangCount(String[] language) throws Exception {
		return mybatis.update("Member.updateLangCount", language);
	}
	
	/* 지역 선호 */
	public int updateLocCount(String loc_name) throws Exception {
		return mybatis.update("Member.updateLocCount", loc_name);
	}
}














