package com.oti.thirtyone.dto;

import lombok.Data;

@Data
public class HolidayDto {
	private int hdCategory; // 휴가 유형 (1 : 연차, 2: 대체 휴가, 3: 병가)
	private String empId; // 휴가를 가진 사원
	private double hdCount; // 휴가일수(유형 전체)
	private double hdUsed; //	사용일수(누적)
	private String hdName;
}
