package kh.pingpong.service;

import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.pingpong.dao.ChatDAO;
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
	
	
	public int chatInsert(Map<String,String> chatInfo) throws Exception{
		return chatDao.chatInsert(chatInfo);
	}
	
	public String chatRoomSch(Map<String,String> chatInfo) throws Exception{
		return chatDao.chatRoomSch(chatInfo);
	}
	public List<String> chatRoomAll() throws Exception{
		return chatDao.chatRoomAll();
	}

}
