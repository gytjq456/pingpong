package kh.pingpong.notification;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import kh.pingpong.dto.MemberDTO;

@Repository
public class EchoHandler extends TextWebSocketHandler{

	@Autowired
	SqlSession sqlsession;

	//로그인 한 전체
	List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	//1대1
	Map<String, WebSocketSession> userSessionsMap = new HashMap<String, WebSocketSession>();

	//클라이언트와 연결이후에 실행되는 메서드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception{
		sessions.add(session);
		
		String senderEmail = getEmail(session);
		userSessionsMap.put(senderEmail , session);
		System.out.println("{} 연결됨"+session.getId());
	}

	//클라이언트와 연결을 끊었을 때 실행되는 메서드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception{
		sessions.remove(session);
		System.out.println("{} 연결끊김"+session.getId());
	}

	//클라이언트가 서버로 메시지를 전송했을 때 실행되는 메서드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception{
		String msg = message.getPayload();
		if(!StringUtils.isEmpty(msg)) {
			String[] strs = msg.split(",");
			
			if(strs != null && strs.length == 5) {
				String cmd = strs[0];
				String caller = strs[1];
				String receiver = strs[2];
				String receiverEmail = strs[3];
				String seq = strs[4];
				
				//작성자가 로그인해서 있다면
				WebSocketSession boardWriterSession = userSessionsMap.get(receiverEmail);
				
				//리뷰
				if("reply".equals(cmd)&&boardWriterSession != null) {
					TextMessage tmpMsg = new TextMessage(caller + "님이 " + 
							"<a type='external' href='/partner/partnerView?seq="+seq+"'>" + seq + "</a> 번 게시글에 댓글을 남겼습니다.");
							boardWriterSession.sendMessage(tmpMsg);
				}
			}
		}
	}
	
	//웹소켓 email 가져오기
		private String getEmail(WebSocketSession session) {
			Map<String, Object> httpSession = session.getAttributes();
			MemberDTO loginUser = (MemberDTO)httpSession.get("memDTO");
			
			if(loginUser == null) {
				return session.getId();
			} else {
				return loginUser.getEmail();
			}
		}

}
