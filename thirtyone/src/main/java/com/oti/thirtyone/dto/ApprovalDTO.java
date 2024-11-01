package com.oti.thirtyone.dto;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ApprovalDTO {
	private String docNumber; // 문서 번호
	private Date docDraftDate; // 문서 작성일
	private String docRetentionPeriod; // 보존연한
	private String docTitle; // 문서 제목
	private String docDocumentData; // 본안 문서 데이터
	private String empId; // 작성자 이름
	private String docFormCode; // 고유 문서 번호
	private List<DocumentApprovalLineDTO> docApprovalLine; // 문서 결재선
	private List<DocumentReferenceDTO> docReferenceList; // 문서 참조자
	private DocFilesDTO docAttachFile; // 첨부파일
	
	private String docHolidayType; // 휴가 유형 (출산, 경조사, 병가 등)
	private int docHolidayDay; // 신청 휴가 일수
	private Date docHolidayStartDate; // 휴가 시작일
	private Date docHolidayEndDate; // 휴가 종료일
	private int docBiztripDay; // 출장 일수
	private Date docBiztripStartDate; // 출장 시작일
	private Date docBiztripEndDate; // 출장 종료일
	private String docBiztripPurpose; // 출장 목적
	private Date docHolidayWorkStartDate; // 휴일 근무 종료일
	private Date docWorkOvertimeEndDate; // 연장 근무 종료일
	
	private int deptId; //기안 부서(= 기안자의 소속 부서)
	private int docMgtYear; //기안 연도
	private int docMgtSeq; // 기안시퀀스
	
	private String draftType; // 기안유형
	
}
