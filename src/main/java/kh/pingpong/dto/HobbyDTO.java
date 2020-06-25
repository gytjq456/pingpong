package kh.pingpong.dto;

public class HobbyDTO {
	private int seq;
	private String hobby;
	
	public HobbyDTO() {}
	public HobbyDTO(int seq, String hobby) {
		super();
		this.seq = seq;
		this.hobby = hobby;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getHobby() {
		return hobby;
	}
	public void setHobby(String hobby) {
		this.hobby = hobby;
	}
}
