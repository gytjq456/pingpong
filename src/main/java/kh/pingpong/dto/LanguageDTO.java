package kh.pingpong.dto;

public class LanguageDTO {

	private int seq;
	private String language;
	
	public LanguageDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public LanguageDTO(int seq, String language) {
		super();
		this.seq = seq;
		this.language = language;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}
	
	

}
