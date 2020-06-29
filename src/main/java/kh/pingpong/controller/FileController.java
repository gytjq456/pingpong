package kh.pingpong.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import kh.pingpong.dao.FileDAO;
import kh.pingpong.dto.BankDTO;
import kh.pingpong.dto.CountryDTO;
import kh.pingpong.dto.FileDTO;
import kh.pingpong.dto.HobbyDTO;
import kh.pingpong.dto.LanguageDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.TutorAppDTO;

@Controller
public class FileController {
	

	@Autowired
	public FileDAO fdao = new FileDAO();
	
	/* 맴버 파일 업로드 */
	public FileDTO fileOneInsert(MemberDTO mdto, FileDTO fdto, String realPath) throws Exception{
		
		MultipartFile profile = mdto.getProfile();
		
		System.out.println(realPath + " :: 리얼패스");
		File filePath = new File(realPath);
		
		//폴더 존재여부
		if(!filePath.exists()) {
			filePath.mkdirs(); //하위폴더를 만들려고 했는데 상위폴더가 없어! 그럼 자동으로 만들어줌			
		}
		
		//현재시간
		String write_date = new SimpleDateFormat("YYYY-MM-dd-ss").format(System.currentTimeMillis());
		
		/* 하드디스크 파일 업로드 */		
		fdto.setOriname(profile.getOriginalFilename());
		fdto.setSysname(write_date + "_" + profile.getOriginalFilename());
		fdto.setRealpath(realPath + fdto.getSysname());
		fdto.setCategory(fdto.getCategory());
		String systemFileName = write_date +"_"+fdto.getOriname(); 
		
		//파일을 저장하기 위한 파일 객체 생성
		File fileDownload = new File(realPath + "/" + systemFileName);		
		profile.transferTo(fileDownload); //파일 저장
		
		//MemberDTO
		mdto.setProfile(profile);
		
		return fdto;
	}	
	

}
