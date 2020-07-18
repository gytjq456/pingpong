package kh.pingpong.dto;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;


public class LessonDTO {
	private int seq;
	private String id;
	private String name;
	private String email;
	private String phone_country;
	private String phone;
	private String category;
	private String title;
	private int price;
	private String language;
	private String apply_start;
	private String apply_end;
	private String start_date;
	private String end_date;
	private String start_hour;
	private String start_minute;
	private String end_hour;
	private String end_minute;
	private int max_num;
	private int cur_num;
	private String location;
	private String location_lat;
	private String location_lng;
	private String curriculum;
	private int like_count;
	private int view_count;
	private int review_count;
	private float review_point;
	private String applying;
	private String proceeding;
	private String pass;
	
	private String sysname;
	
	public LessonDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public LessonDTO(int seq, String id, String name, String email, String phone_country, String phone, String category,
			String title, int price, String language, String apply_start, String apply_end, String start_date,
			String end_date, String start_hour, String start_minute, String end_hour, String end_minute, int max_num,
			int cur_num, String location, String location_lat, String location_lng, String curriculum, int like_count,
			int view_count, int review_count, float review_point, String applying, String proceeding, String pass,
			String sysname) {
		super();
		this.seq = seq;
		this.id = id;
		this.name = name;
		this.email = email;
		this.phone_country = phone_country;
		this.phone = phone;
		this.category = category;
		this.title = title;
		this.price = price;
		this.language = language;
		this.apply_start = apply_start;
		this.apply_end = apply_end;
		this.start_date = start_date;
		this.end_date = end_date;
		this.start_hour = start_hour;
		this.start_minute = start_minute;
		this.end_hour = end_hour;
		this.end_minute = end_minute;
		this.max_num = max_num;
		this.cur_num = cur_num;
		this.location = location;
		this.location_lat = location_lat;
		this.location_lng = location_lng;
		this.curriculum = curriculum;
		this.like_count = like_count;
		this.view_count = view_count;
		this.review_count = review_count;
		this.review_point = review_point;
		this.applying = applying;
		this.proceeding = proceeding;
		this.pass = pass;
		this.sysname = sysname;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone_country() {
		return phone_country;
	}

	public void setPhone_country(String phone_country) {
		this.phone_country = phone_country;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
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

	public String getStart_hour() {
		return start_hour;
	}

	public void setStart_hour(String start_hour) {
		this.start_hour = start_hour;
	}

	public String getStart_minute() {
		return start_minute;
	}

	public void setStart_minute(String start_minute) {
		this.start_minute = start_minute;
	}

	public String getEnd_hour() {
		return end_hour;
	}

	public void setEnd_hour(String end_hour) {
		this.end_hour = end_hour;
	}

	public String getEnd_minute() {
		return end_minute;
	}

	public void setEnd_minute(String end_minute) {
		this.end_minute = end_minute;
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

	public String getCurriculum() {
		return curriculum;
	}

	public void setCurriculum(String curriculum) {
		this.curriculum = curriculum;
	}

	public int getLike_count() {
		return like_count;
	}

	public void setLike_count(int like_count) {
		this.like_count = like_count;
	}

	public int getView_count() {
		return view_count;
	}

	public void setView_count(int view_count) {
		this.view_count = view_count;
	}

	public int getReview_count() {
		return review_count;
	}

	public void setReview_count(int review_count) {
		this.review_count = review_count;
	}

	public float getReview_point() {
		return review_point;
	}

	public void setReview_point(float review_point) {
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

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getSysname() {
		return sysname;
	}

	public void setSysname(String sysname) {
		this.sysname = sysname;
	}


	
}
