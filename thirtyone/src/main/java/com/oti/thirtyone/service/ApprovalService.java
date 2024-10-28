package com.oti.thirtyone.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.oti.thirtyone.dto.Departments;
import com.oti.thirtyone.dto.EmployeesDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ApprovalService {
	
	public List<Departments> getOrgChart() {
		//DB 연결 전, 임시로 데이터 생성 및 전송.
		//차후 동일한 데이터를 DB에서 받아와 리턴하겠음.
		
		//부서 생성
		List<Departments> deptList = new ArrayList<>();
		deptList.add(new Departments(100, "대표이사", "오티아이", "서울"));
		deptList.add(new Departments(111, "공공사업1Div", "유재석", "서울"));
		deptList.add(new Departments(112, "공공사업2Div", "강호동", "세종"));
		deptList.add(new Departments(113, "공공사업3Div", "신동엽", "진천"));
		deptList.add(new Departments(121, "전략사업1Div", "강산애", "서울"));
		deptList.add(new Departments(122, "전략사업2Div", "전현무", "세종"));
		deptList.add(new Departments(123, "전략사업3Div", "김희민", "진천"));
		deptList.add(new Departments(131, "인사팀", "고인사", "서울"));
		deptList.add(new Departments(132, "재무팀", "나재무", "서울"));
		
		return deptList;
	}
	
	public List<EmployeesDto> getOrgEmp() {
		log.info("실행");
		
		//DB 연결 전, 임시로 데이터 생성 및 전송.
		//차후 동일한 데이터를 DB에서 받아와 리턴하겠음.
		
		//부서원 생성
		List<EmployeesDto> empList = new ArrayList<>();
		empList.add(new EmployeesDto("10000", "오티아이", 100, "대표이사"));
		empList.add(new EmployeesDto("11101", "유재석", 111, "부장"));
		empList.add(new EmployeesDto("11102", "박명수", 111, "차장"));
		empList.add(new EmployeesDto("11103", "정준하", 111, "과장"));
		empList.add(new EmployeesDto("11104", "정형돈", 111, "과장"));
		empList.add(new EmployeesDto("11105", "노홍철", 111, "대리"));
		empList.add(new EmployeesDto("11106", "하동훈", 111, "대리"));
		empList.add(new EmployeesDto("11107", "정원석", 111, "사원"));
		empList.add(new EmployeesDto("11108", "서지혜", 111, "사원"));
		empList.add(new EmployeesDto("11109", "엄성현", 111, "사원"));
		empList.add(new EmployeesDto("11201", "강호동", 112, "부장"));
		empList.add(new EmployeesDto("11202", "지상렬", 112, "차장"));
		empList.add(new EmployeesDto("11203", "김C", 112, "과장"));
		empList.add(new EmployeesDto("11204", "엄태웅", 112, "과장"));
		empList.add(new EmployeesDto("11205", "이수근", 112, "대리"));
		empList.add(new EmployeesDto("11206", "은지원", 112, "대리"));
		empList.add(new EmployeesDto("11207", "엠씨몽", 112, "사원"));
		empList.add(new EmployeesDto("11208", "이승기", 112, "사원"));
		empList.add(new EmployeesDto("11209", "김종민", 112, "사원"));
		empList.add(new EmployeesDto("11301", "신동엽", 113, "부장"));
		empList.add(new EmployeesDto("11302", "김승우", 113, "차장"));
		empList.add(new EmployeesDto("11303", "유해진", 113, "과장"));
		empList.add(new EmployeesDto("11304", "차태현", 113, "과장"));
		empList.add(new EmployeesDto("11305", "성시경", 113, "대리"));
		empList.add(new EmployeesDto("11306", "김주원", 113, "대리"));
		empList.add(new EmployeesDto("11307", "김주혁", 113, "사원"));
		empList.add(new EmployeesDto("11308", "김준호", 113, "사원"));
		empList.add(new EmployeesDto("11309", "윤시윤", 113, "사원"));
		empList.add(new EmployeesDto("12101", "강산애", 121, "부장"));
		empList.add(new EmployeesDto("12102", "이용진", 121, "차장"));
		empList.add(new EmployeesDto("12103", "김선호", 121, "과장"));
		empList.add(new EmployeesDto("12104", "고라비", 121, "과장"));
		empList.add(new EmployeesDto("12105", "연정훈", 121, "대리"));
		empList.add(new EmployeesDto("12106", "나인우", 121, "대리"));
		empList.add(new EmployeesDto("12107", "김동현", 121, "사원"));
		empList.add(new EmployeesDto("12108", "문세윤", 121, "사원"));
		empList.add(new EmployeesDto("12109", "김태연", 121, "사원"));
		empList.add(new EmployeesDto("12201", "전현무", 122, "부장"));
		empList.add(new EmployeesDto("12202", "박나래", 122, "차장"));
		empList.add(new EmployeesDto("12203", "이장우", 122, "과장"));
		empList.add(new EmployeesDto("12204", "이주승", 122, "과장"));
		empList.add(new EmployeesDto("12205", "김대호", 122, "대리"));
		empList.add(new EmployeesDto("12206", "서인국", 122, "대리"));
		empList.add(new EmployeesDto("12207", "김태원", 122, "사원"));
		empList.add(new EmployeesDto("12208", "강현탁", 122, "사원"));
		empList.add(new EmployeesDto("12209", "이성재", 122, "사원"));
		empList.add(new EmployeesDto("12301", "김희민", 123, "부장"));
		empList.add(new EmployeesDto("12302", "이태곤", 123, "차장"));
		empList.add(new EmployeesDto("12303", "황석정", 123, "과장"));
		empList.add(new EmployeesDto("12304", "양요섭", 123, "과장"));
		empList.add(new EmployeesDto("12305", "김민준", 123, "대리"));
		empList.add(new EmployeesDto("12306", "강민혁", 123, "대리"));
		empList.add(new EmployeesDto("12307", "강나미", 123, "사원"));
		empList.add(new EmployeesDto("12308", "육중완", 123, "사원"));
		empList.add(new EmployeesDto("12309", "김동완", 123, "사원"));
		empList.add(new EmployeesDto("13101", "고인사", 131, "부장"));
		empList.add(new EmployeesDto("13102", "황치열", 131, "차장"));
		empList.add(new EmployeesDto("13103", "김영철", 131, "과장"));
		empList.add(new EmployeesDto("13104", "한채아", 131, "과장"));
		empList.add(new EmployeesDto("13105", "이국주", 131, "대리"));
		empList.add(new EmployeesDto("13106", "김반장", 131, "대리"));
		empList.add(new EmployeesDto("13107", "장우혁", 131, "사원"));
		empList.add(new EmployeesDto("13108", "윤현민", 131, "사원"));
		empList.add(new EmployeesDto("13109", "이시언", 131, "사원"));
		empList.add(new EmployeesDto("13201", "나재무", 132, "부장"));
		empList.add(new EmployeesDto("13202", "한혜연", 132, "차장"));
		empList.add(new EmployeesDto("13203", "김용건", 132, "과장"));
		empList.add(new EmployeesDto("13204", "한혜진", 132, "과장"));
		empList.add(new EmployeesDto("13205", "장도연", 132, "대리"));
		empList.add(new EmployeesDto("13206", "손담비", 132, "대리"));
		empList.add(new EmployeesDto("13207", "김헨리", 132, "사원"));
		empList.add(new EmployeesDto("13208", "김성훈", 132, "사원"));
		empList.add(new EmployeesDto("13209", "차서원", 132, "사원"));
		
		return empList;
	}

}
