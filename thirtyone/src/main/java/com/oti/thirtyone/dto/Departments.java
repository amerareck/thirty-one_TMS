package com.oti.thirtyone.dto;

import lombok.Data;

@Data
public class Departments {
	private int deptId; // 부서ID
	private String deptName; // 부서명
	private String empId; // 부서장
	private String regionalOffice; // 소속 지사
	
	public Departments() {}
	public Departments(int deptId, String deptName, String empId, String regionalOffice) {
		this.deptId = deptId;
		this.deptName = deptName;
		this.empId = empId;
		this.regionalOffice = regionalOffice;
	}

}
