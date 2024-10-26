package com.oti.thirtyone.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oti.thirtyone.service.AttendanceService;
import com.oti.thirtyone.service.DepartmentService;
import com.oti.thirtyone.service.EmployeesService;

import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/atd")
@Log4j2
public class AttendanceController {
	
	@Autowired
	AttendanceService atdService;
	@Autowired
	DepartmentService deptService;
	@Autowired
	EmployeesService empService;
	
	
	@GetMapping("")
	public String movedAttendance(Model model) {
		model.addAttribute("title", "정원석님의 근태 관리");
		model.addAttribute("selectedTitle", "hr");
		model.addAttribute("selectedSub", "attendance");
		return "attendance/attendanceStatus"; 
	}
	
	@PostMapping("checkIn")
	public ResponseEntity<String> checkIn(double latitude, double longitude, Authentication authentication){
		String empId= authentication.getName();
		int deptId = empService.getDeptId(empId);
		String regionalOffice = deptService.getRegionalOffice(deptId);
		
		log.info(latitude + " ");
		log.info(longitude + " ");
		double distance = atdService.distanceCalculation(latitude, longitude, regionalOffice);
		log.info(distance);
		return ResponseEntity.ok("출근");
	}
	
	@GetMapping("/time")
	public String attendacnetime(Model model) {
		model.addAttribute("title", "정원석님의 근태 관리");
		model.addAttribute("selectedTitle", "hr");
		model.addAttribute("selectedSub", "attendance");
		return "attendance/attendanceTime";
	}
	
	@GetMapping("/process")
	public String atdProcess(Model model) {
		model.addAttribute("title", "정원석님의 근태 관리");
		model.addAttribute("selectedTitle", "hr");
		model.addAttribute("selectedSub", "attendance");
		return "attendance/attendanceProcess"; 
	}

}
