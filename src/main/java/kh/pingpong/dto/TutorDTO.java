package kh.pingpong.dto;

public class TutorDTO {
	private int seq;
	private String id;
	private String name;
	private String email;
	private String country;
	private String phone;
	private String profile;
	private String lang_can;
	private String address;
	private String introduce;
	private int class_num;
	private String class_name;
	private int max_num;
	private int cur_num;
	private int like_count;
	private int review_count;
	private int review_point;
	
	public TutorDTO() {}

	public TutorDTO(int seq, String id, String name, String email, String country, String phone, String profile,
			String lang_can, String address, String introduce, int class_num, String class_name, int max_num,
			int cur_num, int like_count, int review_count, int review_point) {
		super();
		this.seq = seq;
		this.id = id;
		this.name = name;
		this.email = email;
		this.country = country;
		this.phone = phone;
		this.profile = profile;
		this.lang_can = lang_can;
		this.address = address;
		this.introduce = introduce;
		this.class_num = class_num;
		this.class_name = class_name;
		this.max_num = max_num;
		this.cur_num = cur_num;
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

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public String getLang_can() {
		return lang_can;
	}

	public void setLang_can(String lang_can) {
		this.lang_can = lang_can;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getIntroduce() {
		return introduce;
	}

	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}

	public int getClass_num() {
		return class_num;
	}

	public void setClass_num(int class_num) {
		this.class_num = class_num;
	}

	public String getClass_name() {
		return class_name;
	}

	public void setClass_name(String class_name) {
		this.class_name = class_name;
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
