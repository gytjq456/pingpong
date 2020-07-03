package kh.pingpong.dto;

public class JjimDTO {
	private int seq;
	private String id;
	private String category;
	private int parent_seq;
	
	public JjimDTO() {}
	public JjimDTO(int seq, String id, String category, int parent_seq) {
		super();
		this.seq = seq;
		this.id = id;
		this.category = category;
		this.parent_seq = parent_seq;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
