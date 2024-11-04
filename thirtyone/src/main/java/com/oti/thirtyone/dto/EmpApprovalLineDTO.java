package com.oti.thirtyone.dto;

import lombok.Data;

@Data
public class EmpApprovalLineDTO {
	private String aprLineName; // 결재선 이름(북마크 이름)
	private int aprLineSeq; // 결재 순번
	private String empId; // 결재선 북마크 주인(사원 ID)
	private String aprLineApprover; // 결재자 ID
	private int aprLineIndex; // 결재라인 index
	
	private int approverDeptId; // 결재자 부서
	private String empName; // 결재자 이름
	private String position; // 결재자 직위
	
	private EmployeesDto aplLineApproverDTO; // 결재자 정보
	private PositionsDto positionDTO; // 결재자 직위 정보
}