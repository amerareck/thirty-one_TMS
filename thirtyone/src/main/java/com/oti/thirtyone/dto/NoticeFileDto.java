package com.oti.thirtyone.dto;

import lombok.Data;

@Data
public class NoticeFileDto {	
	private int noticeFileId;
	private String noticeFileName;
	private byte[] noticeFileData;
	private String noticeFileType; 
	
	private int noticeId;
}
