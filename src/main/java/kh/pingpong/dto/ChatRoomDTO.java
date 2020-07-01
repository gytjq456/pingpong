package kh.pingpong.dto;

public class ChatRoomDTO {
	private int roomId;
	private String user;
	
	public ChatRoomDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public ChatRoomDTO(int roomId, String user) {
		super();
		this.roomId = roomId;
		this.user = user;
	}
	
	public int getRoomId() {
		return roomId;
	}
	public String getUser() {
		return user;
	}
	
	
}
