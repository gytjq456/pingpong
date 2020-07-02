package kh.pingpong.controller;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kh.pingpong.config.Configuration;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.service.ChatService;

@Controller
@RequestMapping("/chatting")
public class ChatController {
	
	@Autowired
	ChatService chatService;
	
	@Autowired
	private HttpSession session;
	
	@ResponseBody
	@RequestMapping("create")
	public String create(String userId, String userName) throws Exception{
		MemberDTO mdto = (MemberDTO)session.getAttribute("loginInfo");
		String roomId = null;
		String myName = mdto.getName();
		String usersIds = mdto.getId() +"," +userId;
		String usersNames = userName +","+myName;
		
		Map<String,String> chatInfo = Configuration.chatCreate;
		chatInfo.put("usersName",usersNames);
		chatInfo.put("usersIds",usersIds);
		chatInfo.put("master",mdto.getId());
		chatInfo.put("partner",userId);
		
		
		System.out.println("asdasd");
		String chatRoomId = chatService.chatRoomSch(chatInfo);;
		Boolean isChatRoom = false;
		int result = 0;
		
		if(chatRoomId == null) {
			roomId = chatService.rndTxt();
			chatInfo.put("roomId",roomId);
			result = chatService.chatInsert(chatInfo);
			System.out.println("a:"+isChatRoom);
		}
		chatRoomId = chatService.chatRoomSch(chatInfo); 
		
		System.out.println("result = " +result);
		System.out.println("result = " +isChatRoom);
		if(result > 0) {
			return chatRoomId;
		}else {
			chatInfo.put("roomId",chatRoomId);
			return chatRoomId;
		}
	}
	
}
