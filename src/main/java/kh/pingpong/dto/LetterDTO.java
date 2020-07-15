package kh.pingpong.dto;

import java.sql.Timestamp;

public class LetterDTO {
	private int seq;
	private String from_id;
	private String from_name;
	private String to_id;
	private String to_name;
	private String contents;
	private Timestamp write_date;
	private String read;
	
	public LetterDTO() {}
	public LetterDTO(int seq, String from_id, String from_name, String to_id, String to_name, String contents,
			Timestamp write_date, String read) {
		super();
		this.seq = seq;
		this.from_id = from_id;
		this.from_name = from_name;
		this.to_id = to_id;
		this.to_name = to_name;
		this.contents = contents;
		this.write_date = write_date;
		this.read = read;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getFrom_id() {
		return from_id;
	}
	public void setFrom_id(String from_id) {
		this.from_id = from_id;
	}
	public String getFrom_name() {
		return from_name;
	}
	public void setFrom_name(String from_name) {
		this.from_name = from_name;
	}
	public String getTo_id() {
		return to_id;
	}
	public void setTo_id(String to_id) {
		this.to_id = to_id;
	}
	public String getTo_name() {
		return to_name;
	}
	public void setTo_name(String to_name) {
		this.to_name = to_name;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public Timestamp getWrite_date() {
		return write_date;
	}
	public void setWrite_date(Timestamp write_date) {
		this.write_date = write_date;
	}
	public String getRead() {
		return read;
	}
	public void setRead(String read) {
		this.read = read;
	}
}
