package com.oti.thirtyone.dto;

import java.util.Date;

import lombok.Data;

@Data
public class EmployeesDto {
	private String empId; // ID
	private int empNumber; // 사번
	private String empPassword; // 비밀번호
	private String empName; // 사원 이름
	private String empEmail; // 사원 이메일
	private int empGender; // 사원 성별
	private Date empBirth; // 사원 생일
	private int empPostal; // 사원 우편번호
	private String empAddress; // 사원 주소
	private String empDetailAddress; // 사원 상세주소
	private String empTel; // 사원 연락처
	private String empImageName; // 사원 프로필사진 이름
	private byte[] empImageData; // 사원 프로필사진 데이터
	private String empImageType; // 사원 프로필사진 타입(MIME)
	private String empState; // 사원 상태 (정상, 휴직 등)
	private Date empHiredate; // 입사일자
	private Date empResignationDate; // 퇴사일자
	private String empRole; // 관리자 유무
	private String empMemo; // 사원 특이사항
	private int deptId; // 부서 번호
	private String position; // 사원 직위
	
	public EmployeesDto() {}
	public EmployeesDto(String empId, String empName, int deptId, String position) {
		this.empId = empId;
		this.empName = empName;
		this.deptId = deptId;
		this.position = position;
	}
	
	
	
	
}
