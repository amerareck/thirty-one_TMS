package com.oti.thirtyone.dto;

import lombok.Data;

@Data
public class AttendanceCalendarDto {
	private String title;
	private String start;
	private String end;
	private String backgroundColor;
	private String borderColor;
	private String textColor;
	
	public AttendanceCalendarDto() {}
	
	public AttendanceCalendarDto(String title, String start, String end, String backgroundColor, String borderColor,
			String textColor) {
		this.title = title;
		this.start = start;
		this.end = end;
		this.backgroundColor = backgroundColor;
		this.borderColor = borderColor;
		this.textColor = textColor;
	}
	
	
}

	