package kh.pingpong.dto;

public class CountryDTO {

	private int seq;
	private String name;
	
	public CountryDTO(int seq, String name) {
		super();
		this.seq = seq;
		this.name = name;
	}

	public CountryDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	
}
