package kh.pingpong.dto;

public class LocationDTO {
	private int seq;
	private String loc_name;
	private int loc_count;
	
	public LocationDTO() {}
	public LocationDTO(int seq, String loc_name, int loc_count) {
		super();
		this.seq = seq;
		this.loc_name = loc_name;
		this.loc_count = loc_count;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getLoc_name() {
		return loc_name;
	}
	public void setLoc_name(String loc_name) {
		this.loc_name = loc_name;
	}
	public int getLoc_count() {
		return loc_count;
	}
	public void setLoc_count(int loc_count) {
		this.loc_count = loc_count;
	}
}
