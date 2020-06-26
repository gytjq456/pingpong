package kh.pingpong.dto;

import java.sql.Timestamp;


public class LessonDTO {
	private int seq;
	private int tutor_seq;
	private String tutor_name;
	private String title;
	private String language;
	private int price;
	private Timestamp deadline;
	private Timestamp start_date;
	private Timestamp end_date;
	private Timestamp start_time;
	private Timestamp end_time;
	private int max_num;
	private int cur_num;
	private String location;
	private String curriculum;
	private int like_count;
	private int review_count;
	private int review_point;
	
	
	public LessonDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public LessonDTO(int seq, int tutor_seq, String tutor_name, String title, String language, int price,
			Timestamp deadline, Timestamp start_date, Timestamp end_date, Timestamp start_time, Timestamp end_time,
			int max_num, int cur_num, String location, String curriculum, int like_count, int review_count,
			int review_point) {
		super();
		this.seq = seq;
		this.tutor_seq = tutor_seq;
		this.tutor_name = tutor_name;
		this.title = title;
		this.language = language;
		this.price = price;
		this.deadline = deadline;
		this.start_date = start_date;
		this.end_date = end_date;
		this.start_time = start_time;
		this.end_time = end_time;
		this.max_num = max_num;
		this.cur_num = cur_num;
		this.location = location;
		this.curriculum = curriculum;
		this.like_count = like_count;
		this.review_count = review_count;
		this.review_point = review_point;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public int getTutor_seq() {
		return tutor_seq;
	}
	public void setTutor_seq(int tutor_seq) {
		this.tutor_seq = tutor_seq;
	}
	public String getTutor_name() {
		return tutor_name;
	}
	public void setTutor_name(String tutor_name) {
		this.tutor_name = tutor_name;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public Timestamp getDeadline() {
		return deadline;
	}
	public void setDeadline(Timestamp deadline) {
		this.deadline = deadline;
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
	public Timestamp getStart_time() {
		return start_time;
	}
	public void setStart_time(Timestamp start_time) {
		this.start_time = start_time;
	}
	public Timestamp getEnd_time() {
		return end_time;
	}
	public void setEnd_time(Timestamp end_time) {
		this.end_time = end_time;
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
