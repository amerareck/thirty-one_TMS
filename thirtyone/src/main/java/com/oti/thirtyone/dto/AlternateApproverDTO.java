package com.oti.thirtyone.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class AlternateApproverDTO {
	private int altAprId;
	@DateTimeFormat(pattern = "yyyy-MM-dd") private Date altAprStartDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd") private Date altAprEndDate;
	private String altAprContent;
	private boolean altAprState;
	private String empId;
	private String altAprEmp;
	
	private EmployeesDto empInfo;
	private EmployeesDto altAprEmpInfo;
	
	// form에서 전달되는 필드들. (유효성 검증 목록)
	private String altAprEmpName;
	private String altAprPosition;
	private int altAprDeptId;
	private String altAprDeptName;
}
