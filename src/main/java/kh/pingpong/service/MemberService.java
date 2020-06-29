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
	
	
	
	
}









