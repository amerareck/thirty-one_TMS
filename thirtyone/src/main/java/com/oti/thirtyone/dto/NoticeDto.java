package com.oti.thirtyone.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class NoticeDto {
	private int noticeId;
	private String noticeTitle;
	private String noticeContent;
	private Date noticeDate;
	private int noticeHitCount;
	private int noticeImportant;
	private int noticeAllTarget;
	private int noticeDeleted;
	private String empId;
	
}
