package kh.pingpong.dto;

import org.springframework.web.multipart.MultipartFile;

public class FilesDTO {
	private MultipartFile[] filesAll;
	private int[] fileAllSeq;
	
	public FilesDTO(MultipartFile[] filesAll, int[] fileAllSeq) {
		super();
		this.filesAll = filesAll;
		this.fileAllSeq = fileAllSeq;
	}

	public FilesDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MultipartFile[] getFilesAll() {
		return filesAll;
	}

	public void setFilesAll(MultipartFile[] filesAll) {
		this.filesAll = filesAll;
	}

	public int[] getFileAllSeq() {
		return fileAllSeq;
	}

	public void setFileAllSeq(int[] fileAllSeq) {
		this.fileAllSeq = fileAllSeq;
	}
	
	
}
