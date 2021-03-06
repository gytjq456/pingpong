package kh.pingpong.dto;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

public class MemberDTO {
	private String mem_type;
	private String id;
	private String pw;
	private String name;
	private int age;
	private String gender;
	private String email;
	private String phone_country;
	private String phone;
	private String address;
	private String bank_name;
	private String account;
	private MultipartFile profile;
	private String country;
	private String lang_can;
	private String lang_learn;
	private String hobby;
	private String grade;
	private String introduce;
	private int report_count;
	private Timestamp signup_date;
	
	private String sysname;
	
	private String emailPassword;
	private String memail;
	private String contents;
	public MemberDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MemberDTO(String mem_type, String id, String pw, String name, int age, String gender, String email,
			String phone_country, String phone, String address, String bank_name, String account, MultipartFile profile,
			String country, String lang_can, String lang_learn, String hobby, String grade, String introduce,
			int report_count, Timestamp signup_date, String sysname, String emailPassword, String memail,String contents) {
		super();
		this.mem_type = mem_type;
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.age = age;
		this.gender = gender;
		this.email = email;
		this.phone_country = phone_country;
		this.phone = phone;
		this.address = address;
		this.bank_name = bank_name;
		this.account = account;
		this.profile = profile;
		this.country = country;
		this.lang_can = lang_can;
		this.lang_learn = lang_learn;
		this.hobby = hobby;
		this.grade = grade;
		this.introduce = introduce;
		this.report_count = report_count;
		this.signup_date = signup_date;
		this.sysname = sysname;
		this.emailPassword = emailPassword;
		this.memail = memail;
		this.contents = contents;
	}
	
	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getMem_type() {
		return mem_type;
	}

	public void setMem_type(String mem_type) {
		this.mem_type = mem_type;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
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

	public String getBank_name() {
		return bank_name;
	}

	public void setBank_name(String bank_name) {
		this.bank_name = bank_name;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public MultipartFile getProfile() {
		return profile;
	}

	public void setProfile(MultipartFile profile) {
		this.profile = profile;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
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

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getIntroduce() {
		return introduce;
	}

	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}

	public int getReport_count() {
		return report_count;
	}

	public void setReport_count(int report_count) {
		this.report_count = report_count;
	}

	public Timestamp getSignup_date() {
		return signup_date;
	}

	public void setSignup_date(Timestamp signup_date) {
		this.signup_date = signup_date;
	}

	public String getSysname() {
		return sysname;
	}

	public void setSysname(String sysname) {
		this.sysname = sysname;
	}

	public String getEmailPassword() {
		return emailPassword;
	}

	public void setEmailPassword(String emailPassword) {
		this.emailPassword = emailPassword;
	}

	public String getMemail() {
		return memail;
	}

	public void setMemail(String memail) {
		this.memail = memail;
	}

		
}