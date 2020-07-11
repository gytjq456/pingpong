package kh.pingpong.dto;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class DiscussionDTO {
	private int seq;
	private String writer;
	private String title;
	private String contents;
	private String caution;
	private String language;
	private Timestamp write_date;
	private int view_count;
	private int like_count;
	private int comment_count;
	private String dateString;
	private String id;
	
	
	public DiscussionDTO() {
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
		System.out.println(dateString);
	}


	
	public DiscussionDTO(int seq, String writer, String title, String contents, String caution, String language, Timestamp write_date, int view_count,
			int like_count, int comment_count, String id) {
		super();
		this.seq = seq;
		this.writer = writer;
		this.title = title;
		this.contents = contents;
		this.caution = caution;
		this.language = language;
		this.write_date = write_date;
		this.view_count = view_count;
		this.like_count = like_count;
		this.comment_count = comment_count;
		this.id = id;
		//this.dateString = dateString;
		/*this.dateString = new SimpleDateFormat("YYYY-MM-dd").format(write_date);*/
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


	public String getCaution() {
		return caution;
	}


	public void setCaution(String caution) {
		this.caution = caution;
	}


	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
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



	public int getComment_count() {
		return comment_count;
	}



	public void setComment_count(int comment_count) {
		this.comment_count = comment_count;
	}



	/**
	 * @return the id
	 */
	public String getId() {
		return id;
	}



	/**
	 * @param id the id to set
	 */
	public void setId(String id) {
		this.id = id;
	}

	

	
}



