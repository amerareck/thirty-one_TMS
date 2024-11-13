package com.oti.thirtyone.dto;

import java.util.List;

import lombok.Data;

@Data
public class PageParam {
	private String type; // 페이지 유형
	private String empId; // 사용자 id
	private int pageNo; // 현재 페이지 번호
	private String search; // 검색 타입
	private String keyword; // 검색 키워드
	
	private DocumentReferenceDTO refDTO; // 문서참조자 객체
	private DocumentApprovalLineDTO aprDTO; // 문서결재라인 객체
	private DocFilesDTO docFilesDTO; // 문서 참조파일 객체
	private ApprovalDTO approvalDTO; // 결재문서 객체
	
	private List<ApprovalDTO> approvalList; // 결재문서 리스트
}
