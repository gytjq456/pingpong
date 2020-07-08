package kh.pingpong.dto;

public class VisitorDTO {
	private int seq;
	private String visit_date;
	private int visit_count;
	
	public VisitorDTO() {}
	public VisitorDTO(int seq, String visit_date, int visit_count) {
		super();
		this.seq = seq;
		this.visit_date = visit_date;
		this.visit_count = visit_count;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getVisit_date() {
		return visit_date;
	}
	public void setVisit_date(String visit_date) {
		this.visit_date = visit_date;
	}
	public int getVisit_count() {
		return visit_count;
	}
	public void setVisit_count(int visit_count) {
		this.visit_count = visit_count;
	}
}
