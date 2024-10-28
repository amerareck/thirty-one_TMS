package com.oti.thirtyone.dto;

import java.util.Date;

import lombok.Data;

@Data
public class EmployeesDto {
	private String empId;
	private int empNumber;
	private String empPassword;
	private String empName;
	private String empEmail;
	private int empGender;
	private Date empBirth;
	private int empPostal;
	private String empAddress;
	private String empDetailAddress;
	private String empTel;
	private String empImageName;
	private byte[] empImageData;
	private String empImageType;
	private String empState;
	private Date empHiredate;
	private Date empResignationDate;
	private String empRole;
	private int deptId;
	private String position;
	
	public EmployeesDto() {}
	public EmployeesDto(String empId, String empName, int deptId, String position) {
		this.empId = empId;
		this.empName = empName;
		this.deptId = deptId;
		this.position = position;
	}
	
	
	
	
}
