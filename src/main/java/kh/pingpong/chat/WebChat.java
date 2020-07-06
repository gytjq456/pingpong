package kh.pingpong.chat;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import kh.pingpong.dto.MemberDTO;
import kh.pingpong.service.ChatService;

@ServerEndpoint(value="/chat", configurator = HttpSessionCofigurator.class)
public class WebChat {
	private ChatService chatService = MyApplicationContextAware.getApplicationContext().getBean(ChatService.class);
	private static Map<Session , String> clients = Collections.synchronizedMap(new HashMap<>());

	// memebers : 방번호마다 현재 접속하고 있는 멤버의 목록을 저장  
	private static Map<String , List<Session>> members = Collections.synchronizedMap(new HashMap<>());

	// 세션값
	private HttpSession session;
	// 로그인 정보,들어온 방의 번호 : 세션값을 통해 가져옴
	private String roomId;
	private MemberDTO mdto;

	@OnOpen
	public void onConnect(Session client, EndpointConfig config) {
		System.out.println(client.getId() + "님이 접속했습니다.");
		this.session = (HttpSession)config.getUserProperties().get("session");
		//clients.add(client);
		System.out.println("eqwe");
		//mdto = (MemberDTO)this.session.getAttribute("loginInfo");
		roomId = chatService.rndTxt();
		System.out.println("roomId = " + roomId  );

		//clients에 세션정보와 방의 번호를 저장
		clients.put(client , roomId);

		// members 내에 roomNum 방번호가 존재하면 방을 만들지 않음, 존재하지 않으면 방을 만듬
		boolean memberExist = true;
		for(String i : members.keySet()) {
			if(i == roomId) {
				memberExist = false;
				break;
			}
		}
		if(memberExist) {
			members.put(roomId, new ArrayList<>());
		}


		members.get(roomId).add(client);
	}


	// 메세지 보내기
	@OnMessage
	public void onMessage(Session session, String message) throws Exception{
		MemberDTO mdto = (MemberDTO)this.session.getAttribute("loginInfo");
		JSONParser parser = new JSONParser();
		Object obj = parser.parse( message );
		JSONObject jsonObj = (JSONObject) obj;		
		String chatRoom = (String) jsonObj.get("chatRoom");
		String target = (String) jsonObj.get("target");
		String type = (String) jsonObj.get("type");
		System.out.println(message);
		if(type != null && type.contentEquals("register")) {
			String user = (String) jsonObj.get("userId");
		}
		
		
		synchronized(members.get(roomId)) {
			for(Session client : members.get(roomId)) {
				if(client.getId().contentEquals(session.getId())){
					try {
						Basic basic = client.getBasicRemote();
						//System.out.println(message);
						basic.sendText(message);
						//chatService.chatTxtInsert(message);
					} catch (Exception e) {
						e.printStackTrace();
						// TODO: handle exception
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
