package com.oti.thirtyone.dto;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class NoticeFormDto {
	private int noticeId;
	private String noticeTitle;
	private String noticeContent;
	private Date noticeDate;
	private int noticeHitCount;
	private int noticeImportant;
	private int noticeAllTarget;
	private int noticeDeleted;
	private String empId;
	
	private MultipartFile[] attachFile;
	private int[] deptId;
	private int[] deleteFileId;
	private int[] existingDeptId;

}
