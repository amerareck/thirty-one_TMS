package com.oti.thirtyone.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.oti.thirtyone.dto.EmployeesDto;
import com.oti.thirtyone.security.EmployeeDetails;
import com.oti.thirtyone.service.DepartmentService;

import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class HomeController {

	@Autowired
	DepartmentService deptService;
	
	@GetMapping("/")
	public String home(Model model, Authentication authentication){
		if(authentication != null) {
			EmployeeDetails empDetails = (EmployeeDetails) authentication.getPrincipal();
			EmployeesDto empDto = empDetails.getMember();
			String empName= empDto.getEmpName();
			String empPosition = empDto.getPosition();
			int deptId = empDto.getDeptId();
			
			String deptName = deptService.getDeptName(deptId);
			
			model.addAttribute("empNamePosition", empName + " " + empPosition);
			model.addAttribute("empDept", deptName);
		}
		model.addAttribute("title", "");
		model.addAttribute("selectedTitle", "home");
		return "home";
	}
	
}
