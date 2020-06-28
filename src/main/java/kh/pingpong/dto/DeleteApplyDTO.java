package kh.pingpong.dto;

public class DeleteApplyDTO {
	private int seq;
	private String id;
	private String category;
	private String contents;
	private int parent_seq;
	
	public DeleteApplyDTO() {}
	public DeleteApplyDTO(int seq, String id, String category, String contents, int parent_seq) {
		super();
		this.seq = seq;
		this.id = id;
		this.category = category;
		this.contents = contents;
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
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public int getParent_seq() {
		return parent_seq;
	}
	public void setParent_seq(int parent_seq) {
		this.parent_seq = parent_seq;
	}
}
