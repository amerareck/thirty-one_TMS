package com.oti.thirtyone.dto;

import java.util.Date;

import lombok.Data;

@Data
public class DocumentApprovalLineDTO {
	private String docNumber; // 문서 번호
	private String docAprApprover; // 결재자
	private String docAprComment; // 결재 의견
	private String docAprState; // 결재 상태 (승인, 보류, 반려 등)
	private String docAprType; // 결재 유형 (일반, 전결, 대결, 선결 등)
	private Date docAprDate; // 결재 처리 일자
	private int docAprSeq; // 결재선 순서 (낮은 순서부터 높은 순서까지 순차적 처리)
	
}
