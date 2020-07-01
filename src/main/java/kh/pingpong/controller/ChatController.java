package kh.pingpong.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kh.pingpong.service.ChatService;

@Controller
@RequestMapping("/chatting")
public class ChatController {
	
	@Autowired
	ChatService chatService;
	
	@ResponseBody
	@RequestMapping("create")
	public String create(String user) throws Exception{
		String roomId = chatService.rndTxt();
		String myName = "이효섭";
		String users = user +","+myName;
		Map<String,String> chatInfp = new HashMap<>();
		chatInfp.put("roomId",roomId);
		chatInfp.put("users",users);
		int isChatRoom = chatService.chatRoomSch(chatInfp);
		System.out.println(isChatRoom);
		int result = 0;
		if(isChatRoom == 0) {
			result = chatService.chatInsert(chatInfp);
		}
		if(result > 0) {
			return String.valueOf(true);
		}else {
			return String.valueOf(false);
		}
	}
	
}
