package com.oti.thirtyone.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oti.thirtyone.service.EmployeesService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/emp")
@Slf4j
public class EmployeeController {
	
	@Autowired
	EmployeesService empService;
	
	@RequestMapping("loginForm")
	public String loginForm() {
		return "employee/loginForm";
	}
	
	@GetMapping("empDetail")
	public String empDetail(Model model){		
		model.addAttribute("title", "정원석님의 정보 수정하기");
		
		return "employee/empDetail";
	}
	
	@GetMapping("empPwUpdate")
	public String empPwUpdate() {
		
		return "employee/empPwUpdate";
	}
	
	@PostMapping("idCheck")
	public ResponseEntity<Boolean> idCheck(String empId){
		log.info("empId " + empId);
		boolean result = empService.hasEmpId(empId);
		
		return ResponseEntity.ok(result);
	}
	
}
