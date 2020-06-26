package kh.pingpong.dto;

import org.springframework.web.multipart.MultipartFile;

public class TutorAppDTO {
	private int seq;
	private String title;
	private String career;
	private String exp;
	private String recomm;
	private String introduce;
	private String pass;
	
	
	public TutorAppDTO() {
		super();
		// TODO Auto-generated constructor stub
	}


	public TutorAppDTO(int seq, String title, String career, String exp, String recomm, String introduce, String pass) {
		super();
		this.seq = seq;
		this.title = title;
		this.career = career;
		this.exp = exp;
		this.recomm = recomm;
		this.introduce = introduce;
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
