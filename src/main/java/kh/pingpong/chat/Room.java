package kh.pingpong.chat;

import java.util.ArrayList;
import java.util.List;

public class Room{
	private String roomId;
	private String memberId;
	private String uid;
	public Room() {
		super();
		// TODO Auto-generated constructor stub
	}


	public Room(String roomId, String memberId) {
		super();
		this.roomId = roomId;
		this.memberId = memberId;
	}


	public String getRoomId() {
		return roomId;
	}


	public void setRoomId(String roomId) {
		this.roomId = roomId;
	}


	public String getMemberId() {
		return memberId;
	}


	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}


	/**
	 * @return the uid
	 */
	public String getUid() {
		return uid;
	}


	/**
	 * @param uid the uid to set
	 */
	public void setUid(String uid) {
		this.uid = uid;
	}

	

	
	
}
