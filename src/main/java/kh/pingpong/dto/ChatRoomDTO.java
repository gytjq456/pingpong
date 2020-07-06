package kh.pingpong.dto;

public class ChatRoomDTO {
	private String roomId;
	private String users;
	private String chatMemberId;
	
	public ChatRoomDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	

	public ChatRoomDTO(String roomId, String users, String chatMemberId) {
		super();
		this.roomId = roomId;
		this.users = users;
		this.chatMemberId = chatMemberId;
	}



	public String getRoomId() {
		return roomId;
	}



	public void setRoomId(String roomId) {
		this.roomId = roomId;
	}



	public String getUsers() {
		return users;
	}



	public void setUsers(String users) {
		this.users = users;
	}



	public String getChatMemberId() {
		return chatMemberId;
	}



	public void setChatMemberId(String chatMemberId) {
		this.chatMemberId = chatMemberId;
	}




	
	
}
