package kh.pingpong.service;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kh.pingpong.dao.FileDAO;
import kh.pingpong.dao.TutorDAO;
import kh.pingpong.dto.FileDTO;
import kh.pingpong.dto.LessonDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.dto.TutorAppDTO;

@Service
public class TutorService {

	@Autowired
	private TutorDAO tdao;
	
	@Autowired
	private FileDAO fdao;
	
	@Transactional("txManager")
	public void tutorAppSend(TutorAppDTO tadto, List<FileDTO> fileList, String filePath) throws Exception{
		
		tdao.insert(tadto);
		//---------------------------------------파일 업로드
		File tempFilepath = new File(filePath);
		if (!tempFilepath.exists()) {
			tempFilepath.mkdir();
		}

		for(FileDTO file : fileList) {
			fdao.tutorFileInsert(file);
		}
	}
	
	public List<MemberDTO> tutorList() throws Exception{
		List<MemberDTO> mdto = tdao.tutorList();
		return mdto;
	}
	
	public List<LessonDTO> lessonList() throws Exception{
		List<LessonDTO> ldto = tdao.lessonList();
		return ldto;
	}
	
}
