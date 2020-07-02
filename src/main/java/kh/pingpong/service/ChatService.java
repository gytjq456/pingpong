package kh.pingpong.service;

import java.util.List;
import java.util.Map;
import java.util.Random;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.pingpong.dao.ChatDAO;
import kh.pingpong.dto.ChatRecordDTO;
import kh.pingpong.dto.ChatRoomDTO;
@Service
public class ChatService {
	
	@Autowired
	ChatDAO chatDao;
	
	public String rndTxt() {
		StringBuffer temp =new StringBuffer();
		Random rnd = new Random();
		for(int i=0;i<10;i++)
		{
			int rIndex = rnd.nextInt(3);
			switch (rIndex) {
			case 0:
				// a-z
				temp.append((char) ((int) (rnd.nextInt(26)) + 97));
				break;
			case 1:
				// A-Z
				temp.append((char) ((int) (rnd.nextInt(26)) + 65));
				
				break;
			case 2:
				// 0-9
				temp.append((rnd.nextInt(10)));
				break;
			}
		}
		String AuthenticationKey = temp.toString();
		return AuthenticationKey;
	}
	
	//방 생성
	public int chatInsert(Map<String,String> chatInfo) throws Exception{
		return chatDao.chatInsert(chatInfo);
	}
	
	//방번호 검색
	public String chatRoomIdSch(Map<String,String> chatInfo) throws Exception{
		return chatDao.chatRoomIdSch(chatInfo);
	}
	
	//모든 방 가져오기
	public List<String> chatRoomAll() throws Exception{
		return chatDao.chatRoomAll();
	}
	
	//채팅방 기록 가져오기
	public List<ChatRecordDTO> chatRecordList(String roomId) throws Exception{
		return chatDao.chatRecordList(roomId);
	}
	
	//채팅방 입력
	public int chatTxtInsert(String message) throws Exception{
		System.out.println("채팅 서비스");
		ChatRecordDTO chatDto = new ChatRecordDTO();
		JSONParser parser = new JSONParser();
		Object obj = parser.parse( message );
		JSONObject jsonObj = (JSONObject) obj;		
		String chatRoom = (String) jsonObj.get("chatRoom");
		String txt = (String) jsonObj.get("text");
		String id = (String) jsonObj.get("id");
		chatDto.setRoomId(chatRoom);
		chatDto.setSendUser(id);
		chatDto.setChatRecord(txt);
		int result = chatDao.chatTxtInsert(chatDto);
		return result;
	}

}
