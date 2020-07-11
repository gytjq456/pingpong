package kh.pingpong.dto;

import java.sql.Timestamp;

public class CorrectDTO {
	private int seq;
	private String id;
	private String writer;
	private String language;
	private String title;
	private String type;
	private String contents;
	private Timestamp write_date;
	private int view_count;
	private int like_count;
	private int hate_count;
	private int reply_count;
	
	public CorrectDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	
	
	public CorrectDTO(int seq, String id, String writer, String language, String title, String type, String contents,
			Timestamp write_date, int view_count, int like_count, int hate_count, int reply_count) {
		super();
		this.seq = seq;
		this.id = id;
		this.writer = writer;
		this.language = language;
		this.title = title;
		this.type = type;
		this.contents = contents;
		this.write_date = write_date;
		this.view_count = view_count;
		this.like_count = like_count;
		this.hate_count = hate_count;
		this.reply_count = reply_count;
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

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
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

	public int getView_count() {
		return view_count;
	}

	public void setView_count(int view_count) {
		this.view_count = view_count;
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

	public int getReply_count() {
		return reply_count;
	}

	public void setReply_count(int reply_count) {
		this.reply_count = reply_count;
	}
	
	
	

	

}
