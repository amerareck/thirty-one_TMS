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
		model.addAttribute("selectedTitle", "hr");
		model.addAttribute("selectedSub", "attendance");
		return "attendance/attendanceStatus"; 
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
