package com.oti.thirtyone.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("dept")
public class DepartmentController {

	@GetMapping("/")
	public String deptMain(Model model) {
		model.addAttribute("title", "정원석님의 부서 관리");
		model.addAttribute("selectedSub", "deptAtd");
		model.addAttribute("selectedTitle", "hr");
		return "department/department";
	}
	
	@GetMapping("/holiday")
	public String deptHoliday(Model model) {
		model.addAttribute("title", "정원석님의 부서 관리");
		model.addAttribute("selectedSub", "deptAtd");
		model.addAttribute("selectedTitle", "hr");
		return "department/deptHoliday";
	}
	
	
}
