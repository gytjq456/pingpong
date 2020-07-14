package kh.pingpong.dto;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class GroupDTO {
	private int seq;
	private String title;
	private String writer_id;
	private String writer_name;
	private String hobby_type;
	private String apply_start;
	private String apply_end;
	private String start_date;
	private String end_date;
	private String period;
	private int max_num;
	private int cur_num;
	private String location;
	private String location_lat;
	private String location_lng;
	private String contents;
	private Timestamp write_date;
	private int view_count;
	private int like_count;
	private int app_count;
	private int review_count;
	private Double review_point;
	private String applying;
	private String proceeding;
	private String date;
	private String sysname;
	
	public GroupDTO() {}
	public GroupDTO(int seq, String title, String writer_id, String writer_name, String hobby_type, String apply_start, String apply_end, String start_date,
			String end_date, String period, int max_num, int cur_num, String location, String location_lat, String location_lng, String contents, Timestamp write_date,
			int view_count, int like_count, int app_count, int review_count, Double review_point, String applying, String proceeding) {
		super();
		this.seq = seq;
		this.title = title;
		this.writer_id = writer_id;
		this.writer_name = writer_name;
		this.hobby_type = hobby_type;
		this.apply_start = apply_start;
		this.start_date = start_date;
		this.end_date = end_date;
		this.period = period;
		this.max_num = max_num;
		this.cur_num = cur_num;
		this.location = location;
		this.location_lat = location_lat;
		this.location_lng = location_lng;
		this.contents = contents;
		this.write_date = write_date;
		this.view_count = view_count;
		this.like_count = like_count;
		this.app_count = app_count;
		this.review_count = review_count;
		this.review_point = review_point;
		this.applying = applying;
		this.proceeding = proceeding;
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
	public String getWriter_id() {
		return writer_id;
	}
	public void setWriter_id(String writer_id) {
		this.writer_id = writer_id;
	}
	public String getWriter_name() {
		return writer_name;
	}
	public void setWriter_name(String writer_name) {
		this.writer_name = writer_name;
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
	public String getPeriod() {
		return period;
	}
	public void setPeriod(String period) {
		this.period = period;
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
	public String getLocation_lat() {
		return location_lat;
	}
	public void setLocation_lat(String location_lat) {
		this.location_lat = location_lat;
	}
	public String getLocation_lng() {
		return location_lng;
	}
	public void setLocation_lng(String location_lng) {
		this.location_lng = location_lng;
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
	public Double getReview_point() {
		return review_point;
	}
	public void setReview_point(Double review_point) {
		this.review_point = review_point;
	}
	public String getApplying() {
		return applying;
	}
	public void setApplying(String applying) {
		this.applying = applying;
	}
	public String getProceeding() {
		return proceeding;
	}
	public void setProceeding(String proceeding) {
		this.proceeding = proceeding;
	}
	public String getDate() {
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
			this.date = new SimpleDateFormat("YYYY-MM-dd").format(write_date);
			return date;
		}
	}
	public void setDate(String date) {
		this.date = date;
	}
	
	public String getSysname() {
		return sysname;
	}
	
	public void setSysname(String sysname) {
		this.sysname = sysname;
	}
	
	
	
	
}