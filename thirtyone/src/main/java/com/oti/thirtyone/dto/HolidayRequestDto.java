package com.oti.thirtyone.dto;

import java.util.Date;

import lombok.Data;

@Data
public class HolidayRequestDto {
	private int hdrId; //휴가 요청 아이디
	private Date hdrSubmittedDate; //휴가 상신일
	private Date hdrStartDate; //휴가 시작일
	private Date hdrEndDate; //휴가 종료일
	private String hdrContent; //휴가 사유
	private String hdrStatus; //휴가 결재 상태
	private Date hdrCompletedDate; //휴가 결재 처리 날짜
	private int hd_category; //휴가 유형
	private String hdEmpId; // 기안자(휴가 신청자)
	private String hdr_approver; // 결재자
	
	
}
