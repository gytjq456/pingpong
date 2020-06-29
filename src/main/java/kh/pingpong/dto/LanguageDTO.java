package kh.pingpong.dto;

public class LanguageDTO {
	private int seq;
	private String language;
	private String language_country;
	
	
	public LanguageDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public LanguageDTO(int seq, String language, String language_country) {
		super();
		this.seq = seq;
		this.language = language;
		this.language_country = language_country;
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
	public String getLanguage_country() {
		return language_country;
	}
	public void setLanguage_country(String language_country) {
		this.language_country = language_country;
	}
	

	
}
