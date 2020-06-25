package kh.pingpong.dto;

public class FileDTO {
	private int seq;
	private String sysname;
	private String oriname;
	private String category;
	private int parent_seq;
	
	public FileDTO(int seq, String sysname, String oriname, String category, int parent_seq) {
		super();
		this.seq = seq;
		this.sysname = sysname;
		this.oriname = oriname;
		this.category = category;
		this.parent_seq = parent_seq;
	}

	public FileDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getSysname() {
		return sysname;
	}

	public void setSysname(String sysname) {
		this.sysname = sysname;
	}

	public String getOriname() {
		return oriname;
	}

	public void setOriname(String oriname) {
		this.oriname = oriname;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public int getParent_seq() {
		return parent_seq;
	}

	public void setParent_seq(int parent_seq) {
		this.parent_seq = parent_seq;
	}
	
}
