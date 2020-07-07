package kh.pingpong.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kh.pingpong.config.Configuration;
import kh.pingpong.dto.ChatRecordDTO;
import kh.pingpong.dto.ChatRoomDTO;
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
	@RequestMapping(value="create", produces="application/text;charset=utf8")
	public String create(ChatRoomDTO chatDto) throws Exception{
		System.out.println("들어옴");
		MemberDTO mdto = (MemberDTO)session.getAttribute("loginInfo");
		String usersIds = mdto.getId() +"," +chatDto.getChatMemberId();
		String usersId = chatDto.getChatMemberId();
		String usersNames = chatDto.getUsers() +","+mdto.getName();
		String chatRoomId = chatService.chatRoomIdSch(mdto.getId(),usersId);
		System.out.println("chatRoomId = " +chatRoomId);
		
		int result = 0;
		if(chatRoomId == null) {
			String roomId = chatService.rndTxt();
			Configuration.room.add(roomId);
			chatDto.setUsers(usersNames);
			chatDto.setChatMemberId(usersIds);	
			chatDto.setRoomId(roomId);
			result = chatService.chatInsert(chatDto);
		}else {
			System.out.println("??? = " + Configuration.room.size());
			
			System.out.println("???2222 = " + Configuration.room.size());
		}
		//List<ChatRecordDTO> chatRecord = chatService.chatRecordList(Configuration.room);
		List<ChatRecordDTO> chatRecord = new ArrayList<>();
		Configuration.chatRecord = chatRecord;
		if(chatRecord.size() == 0) {
			return new Gson().toJson(Configuration.room);
		}else {
			if(result > 0) {
				return new Gson().toJson(chatRecord);
			}else{
				return new Gson().toJson(chatRecord);
			}
		}
	}

//		//System.out.println("chatRoomId = " +chatRoomId);
//		int result = 0;
//		
//		if(chatRoomId == null) {
//			roomId = chatService.rndTxt();
//			session.setAttribute("roomId", roomId);
//			chatDto.setUsers(usersNames);
//			chatDto.setChatMemberId(usersIds);	
//			chatDto.setRoomId(roomId);
//			result = chatService.chatInsert(chatDto);
//			chatRoomId = chatService.chatRoomIdSch(mdto.getId(),usersId);
//		}
//		session.setAttribute("roomId", chatRoomId);
//		List<ChatRecordDTO> chatRecord = chatService.chatRecordList(chatRoomId);
//		Configuration.chatRecord = chatRecord;
//		
//		if(chatRecord.size() == 0) {
//			return new Gson().toJson(chatRoomId);
//		}else {
//			if(result > 0) {
//				return new Gson().toJson(chatRecord);
//			}else{
//				//chatInfo.put("roomId",chatRoomId);
//				return new Gson().toJson(chatRecord);
//			}
//		}
//	}

	
	
}
