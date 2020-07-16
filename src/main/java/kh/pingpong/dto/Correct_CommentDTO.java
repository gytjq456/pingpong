package kh.pingpong.dto;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class Correct_CommentDTO {
	private int comm_seq;
	private String id;
	private String writer;
	private String contents;
	private Timestamp write_date;
	private int like_count;
	private int parent_seq;
	private String thumNail;
	private String dateString;

	public Correct_CommentDTO() {

		super();
		// TODO Auto-generated constructor stub
	}
	
	public String getDateString() {
		long write_date = this.write_date.getTime();
		long current_date = System.currentTimeMillis();
		long getTime = (current_date - write_date)/1000;
		if(getTime < 60) {
			return "방금 전";
		}else if(getTime < 300) {
			return "5분 이내";
		}else if(getTime < 3600) {
			return "1시간 이내";
		}else if(getTime < 86400) {
			return "24시간 이내";
		}else {
			return dateString;
		}
	}
	
	public void setDateString(String dateString) {
		this.dateString = dateString;
	}

	public Correct_CommentDTO(int like_count) {
		super();
		this.like_count = like_count;
	}




	public Correct_CommentDTO(int comm_seq, String id, String writer, String contents, Timestamp write_date, int parent_seq, String thumNail) {

		this.comm_seq = comm_seq;
		this.id = id;
		this.writer = writer;
		this.contents = contents;
		this.write_date = write_date;
		this.parent_seq = parent_seq;
		this.thumNail = thumNail;
		this.dateString = new SimpleDateFormat("YYYY-MM-dd").format(write_date);
	}



	public int getComm_seq() {
		return comm_seq;
	}

	public void setComm_seq(int comm_seq) {
		this.comm_seq = comm_seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
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


	public int getParent_seq() {
		return parent_seq;
	}

	public void setParent_seq(int parent_seq) {
		this.parent_seq = parent_seq;
	}



	public String getThumNail() {
		return thumNail;
	}

	public void setThumNail(String thumNail) {
		this.thumNail = thumNail;
	}
	
	public int getLike_count() {
		return like_count;
	}
	
	
	public void setLike_count(int like_count) {
		this.like_count = like_count;
	}
	
	
	
	
	
}
