package kh.pingpong.dto;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

public class NewsDTO {
	private int seq;
	private String title;
	private String writer;
	private String category;
	private String start_date;
	private String end_date;
	private String location;
	private MultipartFile thumbnail;
	private String files_name;
	private String contents;
	private Timestamp write_date;
	private int view_count;
	private int like_count;
	private int comment_count;
	
	private String thumbnail_img;
	
	private String address;
	private String detailAddress;
	private String extraAddress;
	
	private String write_date_st;
	
	public NewsDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public NewsDTO(int seq, String title, String writer, String category, String start_date, String end_date,
			String location, MultipartFile thumbnail, String files_name, String contents, Timestamp write_date,
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
		this.files_name = files_name;
		this.contents = contents;
		this.write_date = write_date;
		this.view_count = view_count;
		this.like_count = like_count;
		this.comment_count = comment_count;
	}

	public NewsDTO(int seq, String title, String writer, String category, String start_date, String end_date,
			String location, MultipartFile thumbnail, String files_name, String contents, Timestamp write_date,
			int view_count, int like_count, int comment_count, String thumbnail_img, String address,
			String detailAddress, String extraAddress, String write_date_st) {
		super();
		this.seq = seq;
		this.title = title;
		this.writer = writer;
		this.category = category;
		this.start_date = start_date;
		this.end_date = end_date;
		this.location = location;
		this.thumbnail = thumbnail;
		this.files_name = files_name;
		this.contents = contents;
		this.write_date = write_date;
		this.view_count = view_count;
		this.like_count = like_count;
		this.comment_count = comment_count;
		this.thumbnail_img = thumbnail_img;
		this.address = address;
		this.detailAddress = detailAddress;
		this.extraAddress = extraAddress;
		this.write_date_st = write_date_st;
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

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
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

	public String getFiles_name() {
		return files_name;
	}

	public void setFiles_name(String files_name) {
		this.files_name = files_name;
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

	public String getThumbnail_img() {
		return thumbnail_img;
	}

	public void setThumbnail_img(String thumbnail_img) {
		this.thumbnail_img = thumbnail_img;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDetailAddress() {
		return detailAddress;
	}

	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}

	public String getExtraAddress() {
		return extraAddress;
	}

	public void setExtraAddress(String extraAddress) {
		this.extraAddress = extraAddress;
	}

	public String getWrite_date_st() {
		return write_date_st;
	}

	public void setWrite_date_st(String write_date_st) {
		this.write_date_st = write_date_st;
	}
	
}