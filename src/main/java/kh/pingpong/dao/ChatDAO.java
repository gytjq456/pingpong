package kh.pingpong.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.pingpong.dto.ChatRecordDTO;

@Repository
public class ChatDAO {

	@Autowired
	private SqlSessionTemplate mybatis;
	
	//방 생성
	public int chatInsert(Map<String,String> chatInfp) throws Exception{
		return mybatis.insert("Chat.insert",chatInfp);
	}	
	
	//방번호 검색
	public String chatRoomIdSch(Map<String,String> chatInfo) throws Exception{
		return mybatis.selectOne("Chat.chatRoomIdSch",chatInfo);
	}	

	//모든 방 가져오기
	public List<String> chatRoomAll() throws Exception{
		return mybatis.selectList("Chat.chatRoomAll");
	}	
	
	//채팅방 기록 가져오기
	public List<ChatRecordDTO> chatRecordList(String roomId) throws Exception{
		return mybatis.selectList("Chat.chatRecordList",roomId);
	}
	
	//채팅 내용 입력
	public int chatTxtInsert(ChatRecordDTO chatDto) throws Exception{
		System.out.println("test : "+ chatDto.getChatRecord());
		System.out.println("test : "+ chatDto.getRoomId());
		return mybatis.insert("Chat.chatTxtInsert",chatDto);
	}	
}
