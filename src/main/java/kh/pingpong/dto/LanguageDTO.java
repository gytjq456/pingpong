package kh.pingpong.dto;

public class LanguageDTO {
	private int seq;
	private String language;
	private String language_country;
	private int lang_count;
	
	public LanguageDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public LanguageDTO(int seq, String language, String language_country, int lang_count) {
		super();
		this.seq = seq;
		this.language = language;
		this.language_country = language_country;
		this.lang_count = lang_count;
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
	public int getLang_count() {
		return lang_count;
	}
	public void setLang_count(int lang_count) {
		this.lang_count = lang_count;
	}

	
}
