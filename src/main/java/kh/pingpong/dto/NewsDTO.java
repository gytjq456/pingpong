package kh.pingpong.dto;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

public class NewsDTO {
	private int seq;
	private String title;
	private String writer;
	private String category;
	private Timestamp start_date;
	private Timestamp end_date;
	private String location;
	private MultipartFile thumbnail;
	private String files;
	private String contents;
	private Timestamp write_date;
	private int view_count;
	private int like_count;
	private int comment_count;
	
	public NewsDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public NewsDTO(int seq, String title, String writer, String category, Timestamp start_date, Timestamp end_date,
			String location, MultipartFile thumbnail, String files, String contents, Timestamp write_date,
			int view_count, int like_count, int comment_count) {
		super();
		this.seq = seq;
		this.title = title;
		this.writer = writer;
		this.category = category;
		this.start_date = start_date;
		this.end_date = end_date;
		this.location = location;
		this.thumbnail = thumbnail;
		this.files = files;
		this.contents = contents;
		this.write_date = write_date;
		this.view_count = view_count;
		this.like_count = like_count;
		this.comment_count = comment_count;
	}


	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
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

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public MultipartFile getThumbnail() {
		return thumbnail;
	}

	public void setThumbnail(MultipartFile thumbnail) {
		this.thumbnail = thumbnail;
	}

	public String getFiles() {
		return files;
	}

	public void setFiles(String files) {
		this.files = files;
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

	public int getComment_count() {
		return comment_count;
	}

	public void setComment_count(int comment_count) {
		this.comment_count = comment_count;
	}
	
	
}
