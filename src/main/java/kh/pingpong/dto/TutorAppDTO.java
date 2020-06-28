package kh.pingpong.dto;

import org.springframework.web.multipart.MultipartFile;

public class TutorAppDTO {
	private int seq;
	private String title;
	private String license;
	private String career;
	private String exp;
	private String introduce;
	private String recomm;
	private String pass;
	
	
	public TutorAppDTO() {
		super();
		// TODO Auto-generated constructor stub
	}


	public TutorAppDTO(int seq, String title, String license, String career, String exp, String introduce,
			String recomm, String pass) {
		super();
		this.seq = seq;
		this.title = title;
		this.license = license;
		this.career = career;
		this.exp = exp;
		this.introduce = introduce;
		this.recomm = recomm;
		this.pass = pass;
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


	public String getIntroduce() {
		return introduce;
	}


	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}


	public String getRecomm() {
		return recomm;
	}


	public void setRecomm(String recomm) {
		this.recomm = recomm;
	}


	public String getPass() {
		return pass;
	}


	public void setPass(String pass) {
		this.pass = pass;
	}


}
