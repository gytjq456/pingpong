package kh.pingpong.dto;

import java.sql.Timestamp;

public class BlacklistDTO {
	private int seq;
	private String id;
	private String name;
	private String reason;
	private Timestamp start_date;
	private Timestamp end_date;
	
	public BlacklistDTO() {}
	public BlacklistDTO(int seq, String id, String name, String reason, Timestamp start_date, Timestamp end_date) {
		super();
		this.seq = seq;
		this.id = id;
		this.name = name;
		this.reason = reason;
		this.start_date = start_date;
		this.end_date = end_date;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public Timestamp getStart_date() {
		return start_date;
	}
	public void setStart_date(Timestamp start_date) {
		this.start_date = start_date;
	}
	public Timestamp getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Timestamp end_date) {
		this.end_date = end_date;
	}
}
