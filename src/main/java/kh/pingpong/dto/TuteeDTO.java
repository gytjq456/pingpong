package kh.pingpong.dto;

public class TuteeDTO {
	private int seq;
	private String id;
	private String name;
	private String email;
	private String phone;
	private String bank_name;
	private String account;
	private String profile;
	private int parent_seq;
	
	
	public TuteeDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public TuteeDTO(int seq, String id, String name, String email, String phone, String bank_name,
			String account, String profile, int parent_seq) {
		super();
		this.seq = seq;
		this.id = id;
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.bank_name = bank_name;
		this.account = account;
		this.profile = profile;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getBank_name() {
		return bank_name;
	}

	public void setBank_name(String bank_name) {
		this.bank_name = bank_name;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
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
	
	
	
}
