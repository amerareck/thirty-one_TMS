package com.oti.thirtyone.dto;

import lombok.Data;

@Data
public class DocumentReferenceDTO {
	String docNumber; // 문서번호
	String empId; // 참조자 id
	String empName; // 참조자 성명
	String position; // 참조자 직급
	int deptId; // 참조자 부서
	String deptName; // 참조자 이름
}
