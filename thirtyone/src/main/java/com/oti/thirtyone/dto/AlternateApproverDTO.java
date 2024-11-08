package com.oti.thirtyone.dto;

import java.util.Date;

import lombok.Data;

@Data
public class AlternateApproverDTO {
	private int altAprId;
	private Date altAprStartDate;
	private Date altAprEndDate;
	private String altAprContent;
	private boolean altAprState;
	private String empId;
	private String altAprEmp;
	
	private EmployeesDto empInfo;
	private EmployeesDto altAprEmpInfo;
}
