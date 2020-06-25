package kh.pingpong.dto;

import java.sql.Timestamp;

public class GroupDTO {
	private int seq;
	private String title;
	private String writer;
	private String hobby_type;
	private String apply_start;
	private String apply_end;
	private String start_date;
	private String end_date;
	private int max_num;
	private int cur_num;
	private String location;
	private String contents;
	private Timestamp write_date;
	private int view_count;
	private int like_count;
	private int app_count;
	private int review_count;
	private int review_point;
	
	public GroupDTO() {}
	public GroupDTO(int seq, String title, String writer, String hobby_type, String apply_start, String apply_end, String start_date,
			String end_date, int max_num, int cur_num, String location, String contents, Timestamp write_date,
			int view_count, int like_count, int app_count, int review_count, int review_point) {
		super();
		this.seq = seq;
		this.title = title;
		this.writer = writer;
		this.hobby_type = hobby_type;
		this.apply_start = apply_start;
		this.start_date = start_date;
		this.end_date = end_date;
		this.max_num = max_num;
		this.cur_num = cur_num;
		this.location = location;
		this.contents = contents;
		this.write_date = write_date;
		this.view_count = view_count;
		this.like_count = like_count;
		this.app_count = app_count;
		this.review_count = review_count;
		this.review_point = review_point;
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
	public String getHobby_type() {
		return hobby_type;
	}
	public void setHobby_type(String hobby_type) {
		this.hobby_type = hobby_type;
	}
	public String getApply_start() {
		return apply_start;
	}
	public void setApply_start(String apply_start) {
		this.apply_start = apply_start;
	}
	public String getApply_end() {
		return apply_end;
	}
	public void setApply_end(String apply_end) {
		this.apply_end = apply_end;
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
	public int getMax_num() {
		return max_num;
	}
	public void setMax_num(int max_num) {
		this.max_num = max_num;
	}
	public int getCur_num() {
		return cur_num;
	}
	public void setCur_num(int cur_num) {
		this.cur_num = cur_num;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
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
	public int getApp_count() {
		return app_count;
	}
	public void setApp_count(int app_count) {
		this.app_count = app_count;
	}
	public int getReview_count() {
		return review_count;
	}
	public void setReview_count(int review_count) {
		this.review_count = review_count;
	}
	public int getReview_point() {
		return review_point;
	}
	public void setReview_point(int review_point) {
		this.review_point = review_point;
	}
}