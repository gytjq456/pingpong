package kh.pingpong.dto;

public class ChatRecordDTO {

	private String roomId;
	private int seq;
	private String sendUser;
	private String chatRecord;
	private String writeDate;
	
	
	public ChatRecordDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ChatRecordDTO(String roomId, int seq, String sendUser, String chatRecord, String writeDate) {
		super();
		this.roomId = roomId;
		this.seq = seq;
		this.sendUser = sendUser;
		this.chatRecord = chatRecord;
		this.writeDate = writeDate;
	}
	
	public String getRoomId() {
		return roomId;
	}
	public void setRoomId(String roomId) {
		this.roomId = roomId;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getSendUser() {
		return sendUser;
	}
	public void setSendUser(String sendUser) {
		this.sendUser = sendUser;
	}
	public String getChatRecord() {
		return chatRecord;
	}
	public void setChatRecord(String chatRecord) {
		this.chatRecord = chatRecord;
	}

	public String getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}
	
	
	
	
}

