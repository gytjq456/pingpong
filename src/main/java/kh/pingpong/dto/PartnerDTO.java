package kh.pingpong.dto;

import java.sql.Timestamp;

public class PartnerDTO {
	private int seq;
	private String id;
	private String name;
	private int age;
	private String gender;
	private String email;
	private String country;
	private String phone_country;
	private String phone;
	private String address;
	private String sysname; //profile
	private String lang_can;
	private String lang_learn;
	private String hobby;
	private String introduce;
	private Timestamp partner_date;
	private int review_count;
	private Double review_point;
	private String contact;
	
	public PartnerDTO(int seq, String id, String name, int age, String gender, String email, String country,
			String phone_country, String phone, String address, String sysname, String lang_can, String lang_learn,
			String hobby, String introduce, Timestamp partner_date, int review_count, Double review_point,
			String contact) {
		super();
		this.seq = seq;
		this.id = id;
		this.name = name;
		this.age = age;
		this.gender = gender;
		this.email = email;
		this.country = country;
		this.phone_country = phone_country;
		this.phone = phone;
		this.address = address;
		this.sysname = sysname;
		this.lang_can = lang_can;
		this.lang_learn = lang_learn;
		this.hobby = hobby;
		this.introduce = introduce;
		this.partner_date = partner_date;
		this.review_count = review_count;
		this.review_point = review_point;
		this.contact = contact;
	}
	
	public PartnerDTO() {
		super();
		// TODO Auto-generated constructor stub
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
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
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
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getSysname() {
		return sysname;
	}
	public void setSysname(String sysname) {
		this.sysname = sysname;
	}
	public String getLang_can() {
		return lang_can;
	}
	public void setLang_can(String lang_can) {
		this.lang_can = lang_can;
	}
	public String getLang_learn() {
		return lang_learn;
	}
	public void setLang_learn(String lang_learn) {
		this.lang_learn = lang_learn;
	}
	public String getHobby() {
		return hobby;
	}
	public void setHobby(String hobby) {
		this.hobby = hobby;
	}
	public String getIntroduce() {
		return introduce;
	}
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	public Timestamp getPartner_date() {
		return partner_date;
	}
	public void setPartner_date(Timestamp partner_date) {
		this.partner_date = partner_date;
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
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	
	
}
