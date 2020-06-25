package kh.pingpong.dto;

public class GroupApplyDTO {
	private int seq;
	private String writer;
	private String name;
	private int age;
	private String gender;
	private String address;
	private String profile;
	private String lang_can;
	private String lang_learn;
	private String contents;
	private int parent_seq;
	
	public GroupApplyDTO() {}
	public GroupApplyDTO(int seq, String writer, String name, int age, String gender, String address, String profile,
			String lang_can, String lang_learn, String contents, int parent_seq) {
		super();
		this.seq = seq;
		this.writer = writer;
		this.name = name;
		this.age = age;
		this.gender = gender;
		this.address = address;
		this.profile = profile;
		this.lang_can = lang_can;
		this.lang_learn = lang_learn;
		this.contents = contents;
		this.parent_seq = parent_seq;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
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
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
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
	public String getLang_learn() {
		return lang_learn;
	}
	public void setLang_learn(String lang_learn) {
		this.lang_learn = lang_learn;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public int getParent_seq() {
		return parent_seq;
	}
	public void setParent_seq(int parent_seq) {
		this.parent_seq = parent_seq;
	}
}
