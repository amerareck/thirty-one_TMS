package com.oti.thirtyone.dto;

import java.util.Date;

import lombok.Data;

@Data
public class ApprovalDTO {
	private String docNumber; // 문서 번호
	private Date draftDate; // 문서 작성일
	private String docRetentionPeriod; // 보존연한
	private String docTitle; // 문서 제목
	private String docDocumentData; // 본안 문서 데이터
	private String empId; // 작성자 이름
	private String docFormCode; // 고유 문서 번호
	private String docHolidayType; // 휴가 유형 (출산, 경조사, 병가 등)
	private int docHolidayDay; // 신청 휴가 일수
	private Date docHolidayStartDate; // 휴가 시작일
	private Date docHolidayEndDate; // 휴가 종료일
	private int docBiztripDay; // 출장 일수
	private Date docBiztripStartDate; // 출장 시작일
	private Date docBiztripEndDate; // 출장 종료일
	private String docBiztripPurpose; // 출장 목적
	private Date docHolidayWorkStartDate; // 휴일 근무 시작일
	private Date docHolidayWorkEndDate; // 휴일 근무 종료일
	private int docHolidayWorkRecognizedTime; // 휴일 근무 인정 시간
	private Date docWorkOvertimeStartDate; // 연장 근무 시작일
	private Date docWorkOvertimeEndDate; // 연장 근무 종료일
	private int docWorkOvertimeRecognizedTime; // 연장 근무 인정 시간
	
}
