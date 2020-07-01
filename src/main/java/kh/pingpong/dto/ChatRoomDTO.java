package kh.pingpong.dto;

public class ChatRoomDTO {
	private int roomId;
	private String user;
	private String chatMemberId;
	
	public ChatRoomDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	

	public ChatRoomDTO(int roomId, String user, String chatMemberId) {
		super();
		this.roomId = roomId;
		this.user = user;
		this.chatMemberId = chatMemberId;
	}



	public int getRoomId() {
		return roomId;
	}

	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getChatMemberId() {
		return chatMemberId;
	}

	public void setChatMemberId(String chatMemberId) {
		this.chatMemberId = chatMemberId;
	}
	

	
	
	
}
