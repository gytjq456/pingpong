package kh.pingpong.dto;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class ReviewDTO {
	private int seq;
	private String writer;
	private int point;
	private String contents;
	private Timestamp write_date;
	private String category;
	private int parent_seq;
	private String dateString;
	
	public ReviewDTO() {
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
			this.dateString = new SimpleDateFormat("YYYY-MM-dd").format(write_date);
			return dateString;
		}
	}



	public void setDateString(String dateString) {
		this.dateString = dateString;
	}



	public ReviewDTO(int seq, String writer, int point, String contents, Timestamp write_date, String category, int parent_seq) {
		super();
		this.seq = seq;
		this.writer = writer;
		this.point = point;
		this.contents = contents;
		this.write_date = write_date;
		this.category = category;
		this.parent_seq = parent_seq;
	}
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
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
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getParent_seq() {
		return parent_seq;
	}
	public void setParent_seq(int parent_seq) {
		this.parent_seq = parent_seq;
	}
	

	
	
}
