package com.oti.thirtyone.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oti.thirtyone.dto.AttendanceDto;
import com.oti.thirtyone.dto.EmployeesDto;
import com.oti.thirtyone.security.EmployeeDetails;
import com.oti.thirtyone.service.AttendanceService;
import com.oti.thirtyone.service.DepartmentService;

import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class HomeController {

	@Autowired
	DepartmentService deptService;
	@Autowired
	AttendanceService atdService;
	
	@GetMapping("/home")
	public String home(Model model, Authentication authentication){
		if(authentication != null) {
			EmployeeDetails empDetails = (EmployeeDetails) authentication.getPrincipal();
			EmployeesDto empDto = empDetails.getEmployee();
			String empId = empDto.getEmpId();
			String empName= empDto.getEmpName();
			String empPosition = empDto.getPosition();
			int deptId = empDto.getDeptId();
			
			String deptName = deptService.getDeptName(deptId);
			AttendanceDto atdDto = atdService.getAtdInfo(empId);
			
			if(atdDto != null && atdDto.getCheckIn() != null) {
				boolean isLateCheck = atdService.isLateCheck(atdDto); 
				Map<String, Long> workTime = atdService.getTimeWork(atdDto);
				model.addAttribute("workTime", workTime);
			}
			
			model.addAttribute("atd", atdDto);
			model.addAttribute("empNamePosition", empName + " " + empPosition);
			model.addAttribute("empDept", deptName);
		}
		model.addAttribute("title", "");
		model.addAttribute("selectedTitle", "home");
		return "home";
	}
	
	@GetMapping("/")
	public String loginForm() {
		return "employee/loginForm";
	}
	
	@GetMapping("/getInfo")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> getInfo(Model model, Authentication authentication) {
		EmployeeDetails empDetail = (EmployeeDetails) authentication.getPrincipal();
		EmployeesDto empDto = empDetail.getEmployee();
		
		String deptName = deptService.getDeptName(empDto.getDeptId());
		AttendanceDto atdDto = atdService.getAtdInfo(empDto.getEmpId());
		
		
		Map<String, Object> empInfo = new HashMap<>(); 
		empInfo.put("empName", empDto.getEmpName());
		empInfo.put("position", empDto.getPosition());
		empInfo.put("deptName", deptName);
		empInfo.put("empRole", empDto.getEmpRole());
		empInfo.put("atd", atdDto);
		
		return ResponseEntity.ok(empInfo);
		
	}
	
}
