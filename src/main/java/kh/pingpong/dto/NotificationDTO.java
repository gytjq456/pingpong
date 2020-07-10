package kh.pingpong.dto;

public class NotificationDTO {
	private int seq;
	private String id;
	private int parent_seq;
	private String contents;
	
	public NotificationDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public NotificationDTO(int seq, String id, int parent_seq, String contents) {
		super();
		this.seq = seq;
		this.id = id;
		this.parent_seq = parent_seq;
		this.contents = contents;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getParent_seq() {
		return parent_seq;
	}
	public void setParent_seq(int parent_seq) {
		this.parent_seq = parent_seq;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	
	
}
