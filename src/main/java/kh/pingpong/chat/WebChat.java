package kh.pingpong.chat;

import java.util.Collections;
import java.util.HashSet;
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

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import kh.pingpong.dto.MemberDTO;
import kh.pingpong.service.ChatService;

@ServerEndpoint(value="/chat", configurator = HttpSessionCofigurator.class)
public class WebChat {
	
	private ChatService cservice = MyApplicationContextAware.getApplicationContext().getBean(ChatService.class);
	
	
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
	public void onMessage(Session session, String message) {
		System.out.println("test");
		MemberDTO mdto = (MemberDTO)this.session.getAttribute("loginInfo");
//		
//		JSONParser jsonParse = new JSONParser(); 
//		//JSONParse에 json데이터를 넣어 파싱한 다음 JSONObject로 변환한다. 
//		JSONObject jsonObj = (JSONObject) jsonParse.parse(message); 
//		//JSONObject에서 PersonsArray를 get하여 JSONArray에 저장한다. 
//		JSONArray personArray = (JSONArray) jsonObj.get("Persons");


        System.out.println("* BOOKS *");


		
		
		System.out.println("mg :" + message);
		synchronized(clients) {
			for(Session client : clients) {
				if(!client.getId().contentEquals(session.getId())){
					Basic basic = client.getBasicRemote();
					try {
						basic.sendText(message);
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
