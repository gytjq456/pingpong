package kh.pingpong.dto;

import java.sql.Timestamp;

public class CorrectCDTO {
	private int seq;
	private String id;
	private String writer;
	private String title;
	private String contents;
	private Timestamp write_date;
	private int like_count;
	private int parent_seq;
	private String thumNail;
	public CorrectCDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	

	public CorrectCDTO(int seq, String id, String writer, String title, String contents, Timestamp write_date,
			int like_count, int parent_seq, String thumNail) {
		super();
		this.seq = seq;
		this.id = id;
		this.writer = writer;
		this.title = title;
		this.contents = contents;
		this.write_date = write_date;
		this.like_count = like_count;
		this.parent_seq = parent_seq;
		this.thumNail = thumNail;
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

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
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

	public int getLike_count() {
		return like_count;
	}

	public void setLike_count(int like_count) {
		this.like_count = like_count;
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
	
	
	
	
	
	
}
