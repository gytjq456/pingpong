package kh.pingpong.dto;

public class ChatRoomDTO {
	private int roomId;
	private String users;
	private String chatMemberId;
	
	public ChatRoomDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	

	public ChatRoomDTO(int roomId, String users, String chatMemberId) {
		super();
		this.roomId = roomId;
		this.users = users;
		this.chatMemberId = chatMemberId;
	}



	public int getRoomId() {
		return roomId;
	}

	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}

	public String getUser() {
		return users;
	}

	public void setUser(String user) {
		this.users = user;
	}

	public String getChatMemberId() {
		return chatMemberId;
	}

	public void setChatMemberId(String chatMemberId) {
		this.chatMemberId = chatMemberId;
	}

	
	
}
