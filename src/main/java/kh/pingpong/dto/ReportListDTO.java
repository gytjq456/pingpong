package kh.pingpong.dto;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class ReportListDTO {
	private int seq;
	//게시물에 대한 아이디와 게시물에 신고갯수
	private String id;
	
	//신고자에 대한거
	private String reason;
	private String reporter;
	private Timestamp report_date;
	
	private int parent_seq;
	private String category;
	private String pass;
	private String sDate;
	
	
	public ReportListDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ReportListDTO(int seq, String id, String reason, String reporter, Timestamp report_date, int parent_seq,
			String category, String pass, String sDate) {
		super();
		this.seq = seq;
		this.id = id;
		this.reason = reason;
		this.reporter = reporter;
		this.report_date = report_date;
		this.parent_seq = parent_seq;
		this.category = category;
		this.pass = pass;
		this.sDate = new SimpleDateFormat("YYYY-MM-dd").format(report_date);
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

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getReporter() {
		return reporter;
	}

	public void setReporter(String reporter) {
		this.reporter = reporter;
	}

	public Timestamp getReport_date() {
		return report_date;
	}

	public void setReport_date(Timestamp report_date) {
		this.report_date = report_date;
	}

	public int getParent_seq() {
		return parent_seq;
	}

	public void setParent_seq(int parent_seq) {
		this.parent_seq = parent_seq;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getsDate() {
		return sDate;
	}

	public void setsDate(String sDate) {
		this.sDate = sDate;
	}
	
	

	
}
