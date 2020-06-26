package kh.pingpong.controller;

import java.io.File;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import kh.pingpong.dao.FileDAO;
import kh.pingpong.dto.FileDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.TutorAppDTO;

@Controller
public class FileController {

	@Autowired
	public FileDAO fdao = new FileDAO();
	
	/* 맴버 파일 업로드 */
//	@RequestMapping("fileOneInsert")
	/*
	 * public FileDTO fileOneInsert(MemberDTO mdto, String realPath) throws
	 * Exception{
	 * 
	 * MultipartFile profile = mdto.getProfile();
	 * 
	 * System.out.println(realPath + " :: 리얼패스"); File filePath = new
	 * File(realPath); //폴더 존재여부 if(!filePath.exists()) { filePath.mkdir(); //폴더 만들기
	 * }
	 * 
	 * 파일 업로드 FileDTO fdto = new FileDTO();
	 * 
	 * fdto.setOriname(profile.getOriginalFilename()); fdto.setSysname(mdto.getId()
	 * + "_" + profile.getOriginalFilename()); String systemFileName = mdto.getId()
	 * +"_"+fdto.getOriname();
	 * 
	 * //파일을 저장하기 위한 파일 객체 생성 File fileDownload = new File(realPath + "/" +
	 * systemFileName); profile.transferTo(fileDownload); //파일 저장
	 * 
	 * //MemberDTO mdto.setProfile(profile);
	 * 
	 * return fdto; }
	 */

	// 튜터 신청서 자격증 사진 파일 업로드
	public FileDTO tutorLicenseFile(TutorAppDTO tadto, FileDTO fdto, String realPath) throws Exception {

		return null;
	}

}
