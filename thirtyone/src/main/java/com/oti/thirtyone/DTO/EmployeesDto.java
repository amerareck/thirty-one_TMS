package com.oti.thirtyone.DTO;

import java.util.Date;

import lombok.Data;

@Data
public class EmployeesDto {
	private String empId;
	private int empNumber;
	private String empPassword;
	private String empEmail;
	private int empGender;
	private Date empBirth;
	private int empPostal;
	private String empAddress;
	
}
