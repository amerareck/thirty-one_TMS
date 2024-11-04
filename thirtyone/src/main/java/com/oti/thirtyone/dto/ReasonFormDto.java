package com.oti.thirtyone.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ReasonFormDto {
	private String state;
	private String checkIn;
	private String reason;
	private MultipartFile[] attachFiles;
	
}
