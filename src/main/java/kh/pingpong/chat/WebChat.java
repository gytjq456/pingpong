package kh.pingpong.chat;

import java.util.Collections;
import java.util.HashMap;
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
	public static Map<String,String> test = new HashMap<>();
	HttpSession session;
	@OnOpen
	public void onConnect(Session client, EndpointConfig config) {
		System.out.println(client.getId() + "님이 접속했습니다.");
		this.session = (HttpSession)config.getUserProperties().get("session");
		//Configuration.chatCreate.put("client",client.getId());
		clients.add(client);
		try {
			MemberDTO mdto = (MemberDTO)this.session.getAttribute("loginInfo");
			if(mdto.getId() != null) {
				test.put(client.getId(),mdto.getId());
				System.out.println(mdto.getId());
			}

			for (Map.Entry<String, String> entry : test.entrySet()) {
				System.out.println("[key]:" + entry.getKey() + ", [value]:" + entry.getValue());
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
	}


	// 메세지 보내기
	@OnMessage
	public void onMessage(Session session, String message) throws Exception{


		//System.out.println("뭘까~~ =" + Configuration.chatCreate.get("chatRoomId"));
		//String roomId = Configuration.chatCreate.get("roomId");
		//System.out.println("채팅 roomId" + roomId);
		synchronized(clients) {
			MemberDTO mdto = (MemberDTO)this.session.getAttribute("loginInfo");
			//System.out.println("message :" + message);
			//System.out.println(message);
			JSONParser parser = new JSONParser();
			Object obj = parser.parse( message );
			JSONObject jsonObj = (JSONObject) obj;		
			String chatRoom = (String) jsonObj.get("chatRoom");
			System.out.println("chatRoom222 = " + chatRoom);
		
			for(Session client : clients) { 
				System.out.println("스태틱" + Configuration.chatCreate.get(chatRoom).getMemberId());
				System.out.println("아니야" + test.get(session.getId()));
				if(!client.getId().contentEquals(session.getId())){
					if(Configuration.chatCreate.containsKey(chatRoom)){
						if(Configuration.chatCreate.get(chatRoom).getMemberId().contains(mdto.getId())) {
							try {
								Basic basic = client.getBasicRemote();
								System.out.println(message);
								basic.sendText(message);
								chatService.chatTxtInsert(message);
							} catch (Exception e) {
								e.printStackTrace();
								// TODO: handle exception
							}
						}
					}
				}
			}
		}
	}

	@OnClose
	public void onClose(Session session){
		System.out.println("종료");
		clients.remove(session);
	}

	@OnError
	public void onError(Session session, Throwable t) {
		System.out.println("에러");
		t.printStackTrace();
		clients.remove(session);
	}

}
