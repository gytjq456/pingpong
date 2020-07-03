package kh.pingpong.chat;

import java.util.Collections;
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

import kh.pingpong.config.Configuration;
import kh.pingpong.dto.ChatRecordDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.service.ChatService;

@ServerEndpoint(value="/chat", configurator = HttpSessionCofigurator.class)
public class WebChat {

	private ChatService chatService = MyApplicationContextAware.getApplicationContext().getBean(ChatService.class);


	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<>());
	HttpSession session;
	@OnOpen
	public void onConnect(Session client, EndpointConfig config) {
		System.out.println(client.getId() + "님이 접속했습니다.");
		clients.add(client);
		this.session = (HttpSession)config.getUserProperties().get("session");
	}


	// 메세지 보내기
	@OnMessage
	public void onMessage(Session session, String message) throws Exception{
		//System.out.println("message :" + message);
		JSONParser parser = new JSONParser();
		Object obj = parser.parse( message );
		JSONObject jsonObj = (JSONObject) obj;		
		String chatRoom = (String) jsonObj.get("chatRoom");
		//System.out.println(message);
		chatService.chatTxtInsert(message);
		synchronized(clients) {
			System.out.println("roomId =" + Configuration.chatCreate.get("roomId"));
			System.out.println("chatRoom = " + chatRoom);
			for(Session client : clients) {
				if(Configuration.chatCreate.get("roomId").contentEquals(chatRoom)) {
					if(!client.getId().contentEquals(session.getId())){
						try {
							Basic basic = client.getBasicRemote();
							System.out.println(message);
							basic.sendText(message);
						} catch (Exception e) {
							e.printStackTrace();
							// TODO: handle exception
						}
					}
				}
			}
		}
	}

	@OnClose
	public void onClose(Session session){
		System.out.println("yy");
		clients.remove(session);
	}

	@OnError
	public void onError(Session session, Throwable t) {
		System.out.println("tt");
		t.printStackTrace();
		clients.remove(session);
	}

}
