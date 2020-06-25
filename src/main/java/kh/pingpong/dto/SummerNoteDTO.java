package kh.pingpong.dto;

import org.springframework.web.multipart.MultipartFile;

public class SummerNoteDTO {

	MultipartFile file;

	
	public SummerNoteDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public SummerNoteDTO(MultipartFile file) {
		super();
		this.file = file;
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}
	
	
	
}
