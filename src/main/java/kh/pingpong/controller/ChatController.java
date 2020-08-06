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
		String usersIds = usersIdArray[0]+","+usersIdArray[1];
		String usersNames = chatDto.getUsers() +","+mdto.getName();
		String room;
		
		String chatRoomId = chatService.chatRoomIdSch(usersIdArray[0],usersIdArray[1]);
		int result = 0;
		if(chatRoomId == null) {
			String roomId = chatService.rndTxt();
			room = roomId;
			chatDto.setUsers(usersNames);
			chatDto.setChatMemberId(usersIds);	
			chatDto.setRoomId(roomId);
			result = chatService.chatInsert(chatDto);
		}else {
			room = chatRoomId;
		}
		
		List<ChatRecordDTO> chatRecord = chatService.chatRecordList(room);
		if(chatRecord.size() == 0) {
			return new Gson().toJson(room);
		}else {
			return new Gson().toJson(chatRecord);
		}
	}
}
