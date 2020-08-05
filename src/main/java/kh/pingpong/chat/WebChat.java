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


	private static List<String> loginList = Collections.synchronizedList(new ArrayList<String>());

	// 세션값
	private HttpSession session;

	// 로그인 정보
	private MemberDTO mdto;
	private Session client;
	String userid;
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
		this.userid = (String) jsonObj.get("userid");
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
		
		if(type.contentEquals("message")) {
			ChatRoomDTO chatDto = new ChatRoomDTO();
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
		loginClients.remove(session);
		synchronized (loginClients) {
			for(Session client : loginClients) {
				Basic basic = client.getBasicRemote();
				try {
					basic.sendText(jo1.toJSONString());						
				} catch (Exception e) {
				}
			}
		}
		
		for(int i=0; i<loginList.size(); i++) {
			if(loginList.get(i).contains(this.userid)) {
				loginList.remove(i);
			}
		}




	}

	@OnError
	public void onError(Session session, Throwable t) {
		System.out.println("에러");
		t.printStackTrace();
		loginClients.remove(session);
	}

}
