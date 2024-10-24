package com.oti.thirtyone.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/emp")
@Slf4j
public class EmployeeController {
	
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
	
}
