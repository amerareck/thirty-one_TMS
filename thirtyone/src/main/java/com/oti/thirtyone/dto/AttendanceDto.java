package com.oti.thirtyone.dto;

import java.util.Date;

import lombok.Data;

@Data
public class AttendanceDto {
	
	private Date atdDate;
	private String empId;
	private Date checkIn;
	private Date checkOut;
	private String atdState;
	private int atdStandardTime;
	private int atdOverTime;
	private int atdApprovedTime;
	
}
