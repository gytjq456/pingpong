package kh.pingpong.dto;

import java.sql.Timestamp;

public class CommentDTO {
	private int seq;
	private String writer;
	private String contents;
	private String category;
	private Timestamp write_date;
	private String opinion;
	private int like_count;
	private int hate_count;
	private int parent_seq;
	
	
	public CommentDTO() {
		super();
		// TODO Auto-generated constructor stub
	}


	public CommentDTO(int seq, String writer, String contents, String category, Timestamp write_date, String opinion, int like_count,
			int hate_count, int parent_seq) {
		super();
		this.seq = seq;
		this.writer = writer;
		this.contents = contents;
		this.category = category;
		this.write_date = write_date;
		this.opinion = opinion; 
		this.like_count = like_count;
		this.hate_count = hate_count;
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


	public String getContents() {
		return contents;
	}


	public void setContents(String contents) {
		this.contents = contents;
	}


	public String getCategory() {
		return category;
	}


	public void setCategory(String category) {
		this.category = category;
	}


	public Timestamp getWrite_date() {
		return write_date;
	}


	public void setWrite_date(Timestamp write_date) {
		this.write_date = write_date;
	}

	

	public String getOpinion() {
		return opinion;
	}


	public void setOpinion(String opinion) {
		this.opinion = opinion;
	}


	public int getLike_count() {
		return like_count;
	}


	public void setLike_count(int like_count) {
		this.like_count = like_count;
	}


	public int getHate_count() {
		return hate_count;
	}


	public void setHate_count(int hate_count) {
		this.hate_count = hate_count;
	}


	public int getParent_seq() {
		return parent_seq;
	}


	public void setParent_seq(int parent_seq) {
		this.parent_seq = parent_seq;
	}

	
	
	
}
