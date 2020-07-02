package kh.pingpong.dto;

public class ChatRoomDTO {
	private int roomId;
	private String users;
	private String chatMemberId;
	private String chatRecord;
	
	public ChatRoomDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	

	public ChatRoomDTO(int roomId, String users, String chatMemberId, String chatRecord) {
		super();
		this.roomId = roomId;
		this.users = users;
		this.chatMemberId = chatMemberId;
		this.chatRecord = chatRecord;
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
