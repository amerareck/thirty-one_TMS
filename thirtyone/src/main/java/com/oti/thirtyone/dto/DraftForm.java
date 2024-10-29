package com.oti.thirtyone.dto;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class DraftForm {
	private String draftType;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date holidayStartDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date holidayEndDate;
	private String holidayType;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date bizTripStartDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date bizTripEndDate;
	private String bizTripPurposeForm;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date holidayWorkStartDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date holidayWorkEndDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date workOvertimeStartDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date workOvertimeEndDate;
	private String draftTitle;
	private List<String> draftReference;
	private List<String> draftApprovalLine;
	private MultipartFile draftAttachFile;
	private String documentData;
}
