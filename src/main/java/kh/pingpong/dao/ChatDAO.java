package kh.pingpong.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.pingpong.dto.ChatRecordDTO;
import kh.pingpong.dto.ChatRoomDTO;

@Repository
public class ChatDAO {

	@Autowired
	private SqlSessionTemplate mybatis;
	
	//방 생성
	public int chatInsert(ChatRoomDTO chatDto) throws Exception{
		return mybatis.insert("Chat.insert",chatDto);
	}	
	
	//방번호 검색
	public String chatRoomIdSch(String master, String partner) throws Exception{
		Map<String,String> userInfo = new HashMap<>();
		userInfo.put("master", master);
		userInfo.put("partner", partner);
		return mybatis.selectOne("Chat.chatRoomIdSch",userInfo);
	}	

	//모든 방 가져오기
	public List<String> chatRoomAll() throws Exception{
		return mybatis.selectList("Chat.chatRoomAll");
	}	
	
	// 채팅하는 방 가져오기
	public String chatMyRoom(String roomId) throws Exception{
		return mybatis.selectOne("Chat.chatMyRoom",roomId);
	}	
	
	//채팅방 기록 가져오기
	public List<ChatRecordDTO> chatRecordList(String roomId) throws Exception{
		return mybatis.selectList("Chat.chatRecordList",roomId);
	}
	
	//채팅 내용 입력
	public int chatTxtInsert(ChatRecordDTO chatDto) throws Exception{
		return mybatis.insert("Chat.chatTxtInsert",chatDto);
	}	
}
