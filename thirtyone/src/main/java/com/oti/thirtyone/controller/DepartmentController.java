package com.oti.thirtyone.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oti.thirtyone.dto.Departments;
import com.oti.thirtyone.dto.EmployeesDto;
import com.oti.thirtyone.service.DepartmentService;
import com.oti.thirtyone.service.EmployeesService;

import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("dept")
@Log4j2
public class DepartmentController {

	@Autowired
	DepartmentService deptService;
	
	@Autowired
	EmployeesService empService;
	
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
	
	@PostMapping("addDept")
	public ResponseEntity<String> addDept(int deptId, String deptName, String regionalOffice, int empNumber) {
		Departments deptDto = new Departments();
		EmployeesDto empDto = empService.getEmpInfoByEmpNum(empNumber);
		
		deptDto.setDeptId(deptId);
		deptDto.setDeptName(deptName);
		deptDto.setRegionalOffice(regionalOffice);
		deptDto.setEmpId(empDto.getEmpId());
		
		deptService.createDept(deptDto);
		return ResponseEntity.ok("OK");
	}
	
	@PostMapping("changeRegion")
	public ResponseEntity<String> changeRegion(String region, int deptId) {
		deptService.updateDeptRegionalOffice(region, deptId);
		return ResponseEntity.ok("OK");
	}
	@PostMapping("changeDeptHead")
	public ResponseEntity<String> changeDeptHead(int deptHead, int deptId) {
		EmployeesDto empDto = empService.getEmpInfoByEmpNum(deptHead);
		String empId = empDto.getEmpId();
		deptService.updateDeptHead(empId, deptId);
		empService.updateEmpDept(empId, deptId);
		return ResponseEntity.ok("OK");
	}

	@PostMapping("changeDeptName")
	public ResponseEntity<String> changeDeptName(String deptName, int deptId) {
		deptService.updateDeptName(deptName, deptId);
		return ResponseEntity.ok("OK");
	}
	
	@PostMapping("deleteDept")
	public ResponseEntity<Boolean> deleteDept(int deptId){
		int cntRow = empService.countRowsByDept(deptId);
		if(cntRow > 0) {
			return ResponseEntity.ok(false);
		}
		
		deptService.deleteDept(deptId);
		return ResponseEntity.ok(true);
	}
	
	@GetMapping("hasDeptId")
	public ResponseEntity<Boolean> hasDeptId(int deptId){
		String deptName = deptService.getDeptName(deptId);
		if(deptName == null || deptName.trim().isEmpty() ) 
			return ResponseEntity.ok(true);			
		else
			return ResponseEntity.ok(false);
	}
}
