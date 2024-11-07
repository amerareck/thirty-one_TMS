package com.oti.thirtyone.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ReasonFormDto {
	private int reasonId;
	private String state;
	private String checkIn;
	private String reason;
	private int[] deleteFileList;
	private MultipartFile[] attachFiles;
	
}
