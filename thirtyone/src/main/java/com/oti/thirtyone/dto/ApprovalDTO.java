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
	private String docAprStatus; // 문서 결재 상태
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
	
	private EmployeesDto empInfo; // 기안자 정보
	private int deptId; //기안 부서(= 기안자의 소속 부서)
	private int docMgtYear; //기안 연도
	private int docMgtSeq; // 기안시퀀스
	
	private String deptName; //기안부서 명
	private String empPosition; //기안자 직급
	private String empName; // 기안자 이름
	private String reviewingApprover; // 검토자
	private String reviewingApproverPosition; // 검토자 직급
	private int reviewingApproverDeptId; // 검토자 직급부서 번호
	private String reviewingApproverDeptName; // 검토자 직급부서 이름
	private int reviewingApproverSeq; // 검토자 결재순번
	private String approveState; // 결재 진행 상황 -> 결재선을 통해서 가져온다.
	private String docFormName; // 기안유형한글
	private EmployeesDto nowApprover;
	private EmployeesDto lastApprover; // 최종검토자
	
	private DocumentApprovalLineDTO approveInfo; // 결재 업데이트 데이터.
	
	private String draftType; // 기안유형
	
	private Date atdDate; // 출근일자
	private String atdState; // 출근 상태
	private int atdOverTime;
	private int hdCount; // 대체휴무 부여일수
	
}
