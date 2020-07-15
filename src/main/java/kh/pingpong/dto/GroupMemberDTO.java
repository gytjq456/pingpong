package kh.pingpong.dto;

public class GroupMemberDTO {
	private int seq;
	private String id;
	private String name;
	private String profile;
	private int parent_seq;
	private String parent_title;
	private String sysname;
	
	public GroupMemberDTO() {}
	public GroupMemberDTO(int seq, String id, String name, String profile, int parent_seq, String parent_title) {
		super();
		this.seq = seq;
		this.id = id;
		this.name = name;
		this.profile = profile;
		this.parent_seq = parent_seq;
		this.parent_title = parent_title;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public int getParent_seq() {
		return parent_seq;
	}
	public void setParent_seq(int parent_seq) {
		this.parent_seq = parent_seq;
	}
	public String getParent_title() {
		return parent_title;
	}
	public void setParent_title(String parent_title) {
		this.parent_title = parent_title;
	}

	
	public String getSysname() {
		return sysname;
	}
	
	public void setSysname(String sysname) {
		this.sysname = sysname;
	}
	
	
	
	
}
