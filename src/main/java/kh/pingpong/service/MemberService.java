package kh.pingpong.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kh.pingpong.controller.FileController;
import kh.pingpong.dao.MemberDAO;
import kh.pingpong.dto.BankDTO;
import kh.pingpong.dto.CountryDTO;
import kh.pingpong.dto.FileDTO;
import kh.pingpong.dto.HobbyDTO;
import kh.pingpong.dto.LanguageDTO;
import kh.pingpong.dto.MemberDTO;

@Service
public class MemberService {
	
	@Autowired
	MemberDAO mdao = new MemberDAO();
	
	public List<BankDTO> bankList() throws Exception{
		return mdao.bankList();
	}
	
	public List<CountryDTO> countryList() throws Exception{
		return mdao.countryList();
	}
	
	public List<LanguageDTO> lanList() throws Exception{
		return mdao.lanList();
	}
	
	public List<HobbyDTO> hobbyList() throws Exception{		
		return mdao.hobbyList();
	}
	
	@Transactional("txManager")
	public int memberInsert(MemberDTO mdto, FileDTO fdto) throws Exception{	
		int result = mdao.memberInsert(mdto,fdto);
		mdao.memberFile(fdto);		
		return result;
	}
	
	public MemberDTO memberSelect(MemberDTO loginInfo) throws Exception{
		return mdao.memberSelect(loginInfo);
	}
	
	/*  */
	public Boolean isIdPwSame(MemberDTO mdto) throws Exception{
		if(mdao.isIdPwSame(mdto)>0) {
			return true;
		}else {
			return false;
		} 
	}
	
	public MemberDTO loginInfo(MemberDTO mdto) throws Exception{
		return mdao.loginInfo(mdto); 
	}
	
	/* 아아디 중복체크 */
	public Boolean duplcheckId(MemberDTO mdto) throws Exception{
		if(mdao.duplcheckId(mdto)>0) {
			return true;
		}else {
			return false;
		}
	}
	
	/* 아이디 찾기 */
	public List<MemberDTO> idFindProc(MemberDTO mdto) throws Exception{
		return mdao.idFindProc(mdto);
	}
	
	/* 비밀번호 찾기 */
	public int pwFindProc(MemberDTO mdto) throws Exception{
		return mdao.pwFindProc(mdto);
	}
	
	/* 비밀번호 수정 */
	public int pwModifyProc(MemberDTO mdto) throws Exception{
		return mdao.pwModifyProc(mdto);
	}

	/* 회원탈퇴 */
	@Transactional("txManager")
	public int memWithdrawal(MemberDTO mdto) throws Exception{
		mdao.memProfileDele(mdto);
		return mdao.memWithdrawal(mdto);
	}
	
	/* :::: 회원정보수정 :::: */
	/* 전화번호 */
	public int myInfoMoPhone(MemberDTO mdto) throws Exception{
		return mdao.myInfoMoPhone(mdto);
	}
	
	/* 주소 */
	public int myInfoMoAddress(MemberDTO mdto) throws Exception{
		return mdao.myInfoMoAddress(mdto);
	}
	
	/* 은행 */
	public int myInfoMobank(MemberDTO mdto) throws Exception{
		return mdao.myInfoMobank(mdto);
	}
	
	/* 프로필 */
	@Transactional("txManager")
	public int myInfoProfile(MemberDTO mdto, FileDTO fdto) throws Exception{
		mdao.myInfoProfileFile(mdto, fdto);
		return mdao.myInfoProfile(mdto, fdto);
	}
	
	/* 나라 */
	public int myInfoCountry(MemberDTO mdto) throws Exception{
		return mdao.myInfoCountry(mdto);
	}
	
	/* 할 수 있는 언어  */
	public int myInfoLang_can(MemberDTO mdto) throws Exception{
		return mdao.myInfoLang_can(mdto);
	}
	
	/* 배우고 싶은 언어  */
	public int myInfoLang_learn(MemberDTO mdto) throws Exception{
		return mdao.myInfoLang_learn(mdto);
	}
	
	/* 취미  */
	public int myInfoHobby(MemberDTO mdto) throws Exception{
		return mdao.myInfoHobby(mdto);
	}
	
	/* introduce */
	public int myInfoIntroduce(MemberDTO mdto) throws Exception{
		return mdao.myInfoIntroduce(mdto);
	}
		
	
	//파트너 / 튜터 목록 가져오기 /
	public List<MemberDTO> personList(String type) throws Exception{
		return mdao.personList(type);
	}
}









