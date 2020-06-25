package kh.pingpong.dto;

public class BankDTO {
	private int seq;
	private String bank_name;
	
	public BankDTO(int seq, String bank_name) {
		super();
		this.seq = seq;
		this.bank_name = bank_name;
	}

	public BankDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getBank_name() {
		return bank_name;
	}

	public void setBank_name(String bank_name) {
		this.bank_name = bank_name;
	}
	
	
}
