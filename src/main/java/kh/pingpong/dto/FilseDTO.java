package kh.pingpong.dto;

import org.springframework.web.multipart.MultipartFile;

public class FilseDTO {
	private MultipartFile[] files;
	private int[] fileSeq;
	
	public FilseDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public FilseDTO(MultipartFile[] files, int[] fileSeq) {
		super();
		this.files = files;
		this.fileSeq = fileSeq;
	}

	public MultipartFile[] getFiles() {
		return files;
	}

	public void setFiles(MultipartFile[] files) {
		this.files = files;
	}

	public int[] getFileSeq() {
		return fileSeq;
	}

	public void setFileSeq(int[] fileSeq) {
		this.fileSeq = fileSeq;
	}
	
	
}
