package com.oti.thirtyone.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class JoinFormDto {
	private String empId;
	private String empPassword;
	private String empName;
	private String empEmail;
	private int empGender;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date empBirth;
	private int empPostal;
	private String empAddress;
	private String empDetailAddress;
	private String empTel;
	private MultipartFile empImage;
	private int deptId;
	private String position;
	private String empMemo;
	private String empState;
	private int modifier;
}
