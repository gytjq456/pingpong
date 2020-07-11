package kh.pingpong.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.pingpong.dao.MainClassDAO;
import kh.pingpong.dto.GroupDTO;
import kh.pingpong.dto.LessonDTO;

@Service
public class ClassService {
	
	@Autowired
	MainClassDAO maindao;

	public List<GroupDTO> groupClassList(String day) throws Exception{
		List<GroupDTO> list = maindao.groupClassList(day);
		for(GroupDTO groupDto : list) {
			String contents = groupDto.getContents();
			String contReplace = contents.replaceAll("(<img.+\">)", "");
			groupDto.setContents(contReplace);
		}
		return list;
	}
	public List<LessonDTO> lessonClassList(String day) throws Exception{
		List<LessonDTO> list = maindao.lessonClassList(day);
		for(LessonDTO LessonDto : list) {
			String contents = LessonDto.getCurriculum();
			String contReplace = contents.replaceAll("(<img.+\">)", "");
			LessonDto.setCurriculum(contReplace);
		}
		return list;
	}
	
	public List<Map<String,String>> groupList(String addr) throws Exception{
		List<Map<String,String>> list = maindao.groupList(addr);
		return list;
	}
	
	public List<LessonDTO> lessonList(String addr) throws Exception{
		List<LessonDTO> list = maindao.lessonList(addr);
		return list;
	}
	
}
