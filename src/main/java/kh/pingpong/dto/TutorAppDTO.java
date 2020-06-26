package kh.pingpong.dto;

public class TutorAppDTO {
	private String license;
	private String career;
	private String exp;
	private String recomm;
	private String introduce;
	private String pass;
	
	
	public TutorAppDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public TutorAppDTO(String license, String career, String exp, String recomm, String introduce, String pass) {
		super();
		this.license = license;
		this.career = career;
		this.exp = exp;
		this.recomm = recomm;
		this.introduce = introduce;
		this.pass = pass;
	}
	public String getLicense() {
		return license;
	}
	public void setLicense(String license) {
		this.license = license;
	}
	public String getCareer() {
		return career;
	}
	public void setCareer(String career) {
		this.career = career;
	}
	public String getExp() {
		return exp;
	}
	public void setExp(String exp) {
		this.exp = exp;
	}
	public String getRecomm() {
		return recomm;
	}
	public void setRecomm(String recomm) {
		this.recomm = recomm;
	}
	public String getIntroduce() {
		return introduce;
	}
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	
	
}
