package kh.pingpong.chat;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
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

import kh.pingpong.dto.ChatRoomDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.service.ChatService;


@ServerEndpoint(value="/", configurator = HttpSessionCofigurator.class)
public class WebChat {
	private ChatService chatService = MyApplicationContextAware.getApplicationContext().getBean(ChatService.class);

	private static Set<Session> loginClients = Collections.synchronizedSet(new HashSet<Session>());

	// clients : 현재 접속한 세션이 어떤 방에 접속중인지 방 번호를 저장 
	private static Map<Session , String> clients = Collections.synchronizedMap(new HashMap<>());

	// memebers : 방번호마다 현재 접속하고 있는 멤버의 목록을 저장  
	private static Map<String , List<Session>> members = Collections.synchronizedMap(new HashMap<>());
	private static Map<String , List<Integer>> membersChk = Collections.synchronizedMap(new HashMap<>());


	private static Set<String> loginList = new HashSet<String>();

	// 세션값
	private HttpSession session;

	// 로그인 정보
	private MemberDTO mdto;
	private Session client;
	@OnOpen
	public void onConnect(Session client, EndpointConfig config) throws Exception{
		System.out.println(client.getId() + "님이 접속했습니다.");
		this.session = (HttpSession)config.getUserProperties().get("session");
		mdto = (MemberDTO)this.session.getAttribute("loginInfo");

		loginClients.add(client);

	}


	// 메세지 보내기
	@OnMessage
	public void onMessage(Session session, String message) throws Exception{
		MemberDTO mdto = (MemberDTO)this.session.getAttribute("loginInfo");
		JSONParser parser = new JSONParser();
		Object obj = parser.parse( message );
		JSONObject jsonObj = (JSONObject) obj;		



		String type = (String) jsonObj.get("type");
		String chatRoom = (String) jsonObj.get("chatRoom");
		String targetId = (String) jsonObj.get("targetId");
		String userName = (String) jsonObj.get("userName");
		String userid = (String) jsonObj.get("userid");
		System.out.println("message = " + message);


		if(type.contentEquals("login")) {
			loginList.add(message);
			synchronized (loginClients) {
				for(Session client : loginClients) {
					Basic basic = client.getBasicRemote();					
					basic.sendText(loginList.toString());	
				}
			}
		}


		if(type.contentEquals("register")) {
			//clients에 세션정보와 방의 번호를 저장
			clients.put(this.client , chatRoom);
			// members 내에 roomNum 방번호가 존재하면 방을 만들지 않음, 존재하지 않으면 방을 만듬
			boolean memberExist = true;
			for(String i : members.keySet()) {
				if(i.contentEquals(chatRoom)) {
					memberExist = false;
					break;
				}
			}
			if(memberExist) {
				members.put(chatRoom, new ArrayList<>());
			}
			try{members.get(chatRoom).remove(session);}catch(Exception e) {
				e.printStackTrace();
			}
			// members 맵에 해당 방번호 list에 세션정보를 추가한다 
			members.get(chatRoom).add(session);

		}

		if(type.contentEquals("close")) {
			//members.get(chatRoom).remove(session);
		}


		if(type.contentEquals("message")) {
			System.out.println("chatRoom===" + chatRoom);
			System.out.println(members.get(chatRoom).size());
			ChatRoomDTO chatDto = new ChatRoomDTO();
//			synchronized (members.get(chatRoom)) {		
//				for(Session client : members.get(chatRoom)) {
//					System.out.println("getClient =" + clients.get(this.client));
//					//if(clients.get(this.client).contentEquals(chatRoom)) {
//						Basic basic = client.getBasicRemote();					
//						if(!client.getId().contentEquals(session.getId())) {					
//							basic.sendText(message);						
//						}
//					//}
//				}
//			}
			synchronized (loginClients) {
				for(Session client : loginClients) {
					if(!client.getId().contentEquals(session.getId())) {
						Basic basic = client.getBasicRemote();					
						basic.sendText(message);	
					}
				}
				chatService.chatTxtInsert(message);
			}				
		}
	}


	@OnClose
	public void onClose(Session session){
		JSONObject jo1 = new JSONObject();
		jo1.put("type", "logout");
		jo1.put("userid", mdto.getId());

		synchronized (loginClients) {
			for(Session client : loginClients) {
				Basic basic = client.getBasicRemote();
				try {
					basic.sendText(jo1.toJSONString());						
				} catch (Exception e) {
				}
			}
		}

		loginClients.remove(session);
		for(String st : members.keySet()) {
			members.get(st).remove(session);
		}



	}

	@OnError
	public void onError(Session session, Throwable t) {
		System.out.println("에러");
		t.printStackTrace();
		loginClients.remove(session);
		for(String st : members.keySet()) {
			members.get(st).remove(session);
		}
	}

}
