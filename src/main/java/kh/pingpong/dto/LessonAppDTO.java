package kh.pingpong.dto;

public class LessonAppDTO {
	private int seq;
	private String id;
	private String name;
	private String email;
	private String phone;
	private String bank_name;
	private String account;
	private String profile;
	private int lesson_code;
	
	
	public LessonAppDTO() {
		super();
		// TODO Auto-generated constructor stub
	}


	public LessonAppDTO(int seq, String id, String name, String email, String phone, String bank_name, String account,
			String profile, int lesson_code) {
		super();
		this.seq = seq;
		this.id = id;
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.bank_name = bank_name;
		this.account = account;
		this.profile = profile;
		this.lesson_code = lesson_code;
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


	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
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


	public String getProfile() {
		return profile;
	}


	public void setProfile(String profile) {
		this.profile = profile;
	}


	public int getLesson_code() {
		return lesson_code;
	}


	public void setLesson_code(int lesson_code) {
		this.lesson_code = lesson_code;
	}


	
}
