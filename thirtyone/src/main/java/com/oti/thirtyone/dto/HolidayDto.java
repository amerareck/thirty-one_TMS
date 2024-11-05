package com.oti.thirtyone.dto;

import lombok.Data;

@Data
public class HolidayDto {
	private int hd_category; // 휴가 유형 (1 : 연차, 2: 대체 휴가, 3: 병가)
	private String empId; // 휴가를 가진 사원
	private int hd_count; // 휴가일수(유형 전체)
	private int hd_used; //	사용일수(누적)
}
