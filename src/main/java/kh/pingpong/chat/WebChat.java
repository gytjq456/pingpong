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

@ServerEndpoint(value="/chat", configurator = HttpSessionCofigurator.class)
public class WebChat {

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
		String id = (String)this.session.getAttribute("loginInfo");
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
