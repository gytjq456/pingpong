package kh.pingpong.chat;

import java.util.Collections;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import kh.pingpong.config.Configuration;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.service.ChatService;

@ServerEndpoint(value="/chat", configurator = HttpSessionCofigurator.class)
public class WebChat {

	private ChatService chatService = MyApplicationContextAware.getApplicationContext().getBean(ChatService.class);


	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<>());
	//private String roomId;
	HttpSession session;
	@OnOpen
	public void onConnect(Session client, EndpointConfig config) {
		System.out.println(client.getId() + "님이 접속했습니다.");
		String chatRoom = null;
		try {
			chatRoom = chatService.chatRoomSch(Configuration.chatCreate);
			System.out.println("test :" + chatRoom);
		} catch (Exception e) {
			// TODO: handle exception
		}

		if(Configuration.chatCreate.get("roomId").contentEquals(chatRoom)) {
			clients.add(client);
		}
		this.session = (HttpSession)config.getUserProperties().get("session");
		for (String mapkey : Configuration.chatCreate.keySet()){
			System.out.println("key1:"+mapkey+",value1:"+Configuration.chatCreate.get(mapkey));
		}
	}


	// 메세지 보내기
	@OnMessage
	public void onMessage(Session session, String message) throws Exception{
		MemberDTO mdto = (MemberDTO)this.session.getAttribute("loginInfo");

		System.out.println("message :" + message);
		JSONParser parser = new JSONParser();
		Object obj = parser.parse( message );
		JSONObject jsonObj = (JSONObject) obj;		
		String chatRoom = (String) jsonObj.get("chatRoom");

		synchronized(clients) {
			for(Session client : clients) {
				if(!client.getId().contentEquals(session.getId())){
					Basic basic = client.getBasicRemote();
					try {
						if(Configuration.chatCreate.get("roomId").contentEquals(chatRoom)) {
							System.out.println("방번호가 같아여");
							basic.sendText(message);
						}
					} catch (Exception e) {
					}
				}
			}
		}
	}

	@OnClose
	public void onClose(Session session) {
		clients.remove(session);
	}

	@OnError
	public void onError(Session session, Throwable t) {
		clients.remove(session);
	}

}
