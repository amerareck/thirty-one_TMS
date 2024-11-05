package com.oti.thirtyone.dto;

import lombok.Data;

@Data
public class CalendarDto {
	private String title;
	private String start;
	private String end;
	private String backgroundColor;
	private String borderColor;
	private String textColor;
	
	public CalendarDto() {}
	
	public CalendarDto(String title, String start, String end, String backgroundColor, String borderColor,
			String textColor) {
		this.title = title;
		this.start = start;
		this.end = end;
		this.backgroundColor = backgroundColor;
		this.borderColor = borderColor;
		this.textColor = textColor;
	}
	
	
}

	