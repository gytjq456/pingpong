package kh.pingpong.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kh.pingpong.chat.Room;
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
		String roomId = Configuration.room;
		
		
		String usersIds = mdto.getId() +"," +chatDto.getChatMemberId();
		String usersId = chatDto.getChatMemberId();
		String usersNames = chatDto.getUsers() +","+mdto.getName();
		
		String chatRoomId = chatService.chatRoomIdSch(mdto.getId(),usersId);
		//System.out.println("chatRoomId = " +chatRoomId);
		int result = 0;
		
		if(chatRoomId == null) {
			roomId = chatService.rndTxt();
			session.setAttribute("roomId", roomId);
			chatDto.setUsers(usersNames);
			chatDto.setChatMemberId(usersIds);	
			chatDto.setRoomId(roomId);
			result = chatService.chatInsert(chatDto);
			chatRoomId = chatService.chatRoomIdSch(mdto.getId(),usersId);
		}
		session.setAttribute("roomId", chatRoomId);
		List<ChatRecordDTO> chatRecord = chatService.chatRecordList(chatRoomId);
		Configuration.chatRecord = chatRecord;
		
		if(chatRecord.size() == 0) {
			return new Gson().toJson(chatRoomId);
		}else {
			if(result > 0) {
				return new Gson().toJson(chatRecord);
			}else{
				//chatInfo.put("roomId",chatRoomId);
				return new Gson().toJson(chatRecord);
			}
		}
	}

	
	
}
