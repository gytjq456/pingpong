package kh.pingpong.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
		
		String myName = mdto.getName();
		String roomId = chatService.rndTxt();
		String usersIds = userId +","+mdto.getId();
		String usersNames = userName +","+myName;
		
		Map<String,String> chatInfp = new HashMap<>();
		chatInfp.put("roomId",roomId);
		chatInfp.put("usersName",usersNames);
		chatInfp.put("usersIds",usersIds);
		int isChatRoom = chatService.chatRoomSch(chatInfp);
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
