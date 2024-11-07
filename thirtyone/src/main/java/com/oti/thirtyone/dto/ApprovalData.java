package com.oti.thirtyone.dto;

import java.util.Date;

import lombok.Data;

@Data
public class ApprovalData {
	private String docNumber; // 문서번호
	private String approvalResult; // 결재 결과(승인, 반려, 보류)
	private String approvalType; // 결재 유형(일반, 전결, 대결, 선결)
	private String approvalComment; // 결재 의견
	private Date approvalDate; // 결재 일자
	private String docData; //문서 데이터
	private int approvalSeq; // 결재 순번
	
	private String approver; // 결재자
}
