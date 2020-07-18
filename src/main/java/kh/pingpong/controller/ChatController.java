package kh.pingpong.controller;

import java.util.Arrays;
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
		MemberDTO mdto = (MemberDTO)session.getAttribute("loginInfo");
		String[] usersIdArray = {mdto.getId(),chatDto.getChatMemberId()};
		Arrays.sort(usersIdArray);
		//String usersIds = mdto.getId() +"," +chatDto.getChatMemberId();
		String usersIds = usersIdArray[0]+","+usersIdArray[1];
		String usersId = chatDto.getChatMemberId();
		String usersNames = chatDto.getUsers() +","+mdto.getName();
		System.out.println(Arrays.toString(usersIdArray));
		
		String chatRoomId = chatService.chatRoomIdSch(usersIdArray[0],usersIdArray[1]);
		System.out.println("==== 방 ===" + chatRoomId);
		int result = 0;
		if(chatRoomId == null) {
			String roomId = chatService.rndTxt();
			Configuration.room = roomId;
			chatDto.setUsers(usersNames);
			chatDto.setChatMemberId(usersIds);	
			chatDto.setRoomId(roomId);
			result = chatService.chatInsert(chatDto);
		}else {
			Configuration.room = chatRoomId;
		}
		
		List<ChatRecordDTO> chatRecord = chatService.chatRecordList(Configuration.room);
		//Configuration.chatRecord = chatRecord;
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
