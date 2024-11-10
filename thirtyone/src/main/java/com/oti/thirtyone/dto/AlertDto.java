package com.oti.thirtyone.dto;

import java.util.Date;

import lombok.Data;

@Data
public class AlertDto {
	private int alertId;
	private String alertContent;
	private String alertType;
	private Date alertTime;
	private boolean alertReadStatus;
	private String empId;
	

    public AlertDto() {}


	public AlertDto(String alertContent, String alertType, String empId, Date alertTime) {
		this.alertContent = alertContent;
		this.alertType = alertType;
		this.empId = empId;
		this.alertTime = alertTime;
	}


}
