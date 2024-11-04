package com.oti.thirtyone.dto;

import java.util.Date;

import lombok.Data;

@Data
public class ReasonDto {
	private int reasonId; //사유서 아이디
	private String reasonType; //사유서 유형
	private String reasonContent; //사유
	private String reasonStatus; //결재 상태
	private Date reasonCompletedDate; // 결재 일자
	private Date atdDate; //출근 일자
	private String empId; //작성자
	private String reasonImprover; //결재자
	
}
