package kh.pingpong.dto;

import java.sql.Timestamp;

public class AlarmDTO {
	private int alarm_seq;
	private String alarm_sender;
	private String alarm_receiver;
	private String alarm_content;
	private Timestamp alarm_date;
	private String alarm_read;
	public AlarmDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	public AlarmDTO(int alarm_seq, String alarm_sender, String alarm_receiver, String alarm_content,
			Timestamp alarm_date, String alarm_read) {
		super();
		this.alarm_seq = alarm_seq;
		this.alarm_sender = alarm_sender;
		this.alarm_receiver = alarm_receiver;
		this.alarm_content = alarm_content;
		this.alarm_date = alarm_date;
		this.alarm_read = alarm_read;
	}


	public int getAlarm_seq() {
		return alarm_seq;
	}
	public void setAlarm_seq(int alarm_seq) {
		this.alarm_seq = alarm_seq;
	}
	public String getAlarm_sender() {
		return alarm_sender;
	}
	public void setAlarm_sender(String alarm_sender) {
		this.alarm_sender = alarm_sender;
	}
	public String getAlarm_receiver() {
		return alarm_receiver;
	}
	public void setAlarm_receiver(String alarm_receiver) {
		this.alarm_receiver = alarm_receiver;
	}
	public String getAlarm_content() {
		return alarm_content;
	}
	public void setAlarm_content(String alarm_content) {
		this.alarm_content = alarm_content;
	}
	public Timestamp getAlarm_date() {
		return alarm_date;
	}
	public void setAlarm_date(Timestamp alarm_date) {
		this.alarm_date = alarm_date;
	}
	public String getAlarm_read() {
		return alarm_read;
	}
	public void setAlarm_read(String alarm_read) {
		this.alarm_read = alarm_read;
	}
	
	
	
	
}
