package com.oti.thirtyone.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/atd")
public class AttendanceController {
	
	@GetMapping("")
	public String movedAttendance(Model model) {
		model.addAttribute("title", "정원석님의 근태 관리");
		return "attendance/attendanceStatus"; 
	}
	
	@GetMapping("/process")
	public String atdProcess(Model model) {
		model.addAttribute("title", "정원석님의 근태 관리");
		return "attendance/attendanceProcess"; 
	}

}
