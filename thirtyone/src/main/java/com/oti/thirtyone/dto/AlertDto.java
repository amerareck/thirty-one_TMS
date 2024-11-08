package com.oti.thirtyone.dto;

import java.util.Date;

import lombok.Data;

@Data
public class AlertDto {
    private String message;
    private long timestamp;

    public AlertDto() {}

    public AlertDto(String message, long timestamp) {
        this.message = message;
        this.timestamp = timestamp;
    }
//	private int alertId;
//	private String alertContent;
//	private String alertType;
//	private Date alertTime;
//	private boolean alertReadStatus;
//	private String empId;
//	
//
//    public AlertDto() {}
//
//
//	public AlertDto(int alertId, String alertContent, String alertType, Date alertTime, boolean alertReadStatus,
//			String empId) {
//		this.alertId = alertId;
//		this.alertContent = alertContent;
//		this.alertType = alertType;
//		this.alertTime = alertTime;
//		this.alertReadStatus = alertReadStatus;
//		this.empId = empId;
//	}


}
