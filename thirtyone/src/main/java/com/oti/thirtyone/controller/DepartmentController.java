package com.oti.thirtyone.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oti.thirtyone.dto.CalendarDto;
import com.oti.thirtyone.dto.Departments;
import com.oti.thirtyone.dto.EmployeesDto;
import com.oti.thirtyone.dto.HolidayRequestDto;
import com.oti.thirtyone.dto.Pager;
import com.oti.thirtyone.enums.HolidayType;
import com.oti.thirtyone.security.EmployeeDetails;
import com.oti.thirtyone.service.AttendanceService;
import com.oti.thirtyone.service.DepartmentService;
import com.oti.thirtyone.service.EmployeesService;
import com.oti.thirtyone.service.HolidayService;

import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("dept")
@Log4j2
public class DepartmentController {

	@Autowired
	DepartmentService deptService;
	@Autowired
	EmployeesService empService;
	@Autowired
	AttendanceService atdService;
	@Autowired
	HolidayService holidayService;
	
	@GetMapping("/")
	@Secured("ROLE_USER")
	public String deptMain(Model model, Authentication authentication, @RequestParam(defaultValue = "1") int atdPageNo,
			@RequestParam(defaultValue = "1") int pageNo, HttpSession session) {
		
		EmployeeDetails empDetail = (EmployeeDetails) authentication.getPrincipal();
		EmployeesDto empDto = empDetail.getEmployee();
		int deptId = empDto.getDeptId();
		
		int totalRows = empService.countRowsByDept(deptId);
		Pager pager = new Pager(9, 5, totalRows, atdPageNo);
		session.setAttribute("pager", pager);

		List<EmployeesDto> empList = empService.getEmpAllByDeptId(empDto, pager);
		List<Map<String, Object>> deptEmpList = new LinkedList<>();
		
		for(EmployeesDto emp : empList) {
			Map<String, Object> tempMap = new HashMap<>();
			tempMap.put("deptName", deptService.getDeptName(emp.getDeptId()));
			tempMap.put("atd", atdService.getAtdInfo(emp.getEmpId()));
			tempMap.put("emp", emp);
			deptEmpList.add(tempMap);
		}
		
		int totalRowsHoliday = holidayService.countRowsByDeptHoliday(deptId);
		Pager hdpager = new Pager(4, 5, totalRowsHoliday, pageNo);
		session.setAttribute("hdpager", hdpager);
		
		List<HolidayRequestDto> hrdList = holidayService.getHdrByDept(deptId, hdpager);
		List<Map<String, Object>> deptHdList = new LinkedList<>();
		
		for(HolidayRequestDto hdr : hrdList) {
			Map<String, Object> tempMap = new HashMap<>();
			EmployeesDto emp = empService.getEmpInfo(hdr.getHdrEmpId());
			tempMap.put("emp", emp);
			hdr.setHdName(HolidayType.getCategoryByCode(hdr.getHdCategory()));
			tempMap.put("dept", deptService.getDeptName(deptId));
			tempMap.put("hdr", hdr);
			deptHdList.add(tempMap);
		}
		
		model.addAttribute("today", new Date());
		model.addAttribute("deptHdList", deptHdList);
		model.addAttribute("deptEmpList", deptEmpList);
		model.addAttribute("pager", pager);
		model.addAttribute("hdpager", hdpager);
		model.addAttribute("title", "정원석님의 부서 관리");
		model.addAttribute("selectedSub", "deptAtd");
		model.addAttribute("selectedTitle", "hr");
		return "department/department";
	}
	
	@GetMapping("/deptAtdStatus")
	@ResponseBody
	public Map<String, int[]> deptAtdStatus(Authentication authentication) {
		EmployeeDetails empDetail = (EmployeeDetails) authentication.getPrincipal();
		EmployeesDto empDto = empDetail.getEmployee();
		int deptId = empDto.getDeptId();
		
		return deptService.getDeptAtdStatus(deptId);
	}
	
	@GetMapping("/holiday")
	@Secured("ROLE_USER")
	public String deptHoliday(Model model) {
		model.addAttribute("title", "정원석님의 부서 관리");
		model.addAttribute("selectedSub", "deptAtd");
		model.addAttribute("selectedTitle", "hr");
		return "department/deptHoliday";
	}
	
	@GetMapping("/deptHoliday")
	@ResponseBody
	public List<CalendarDto> deptHoliday(String year, String month, Authentication authentication) {
		EmployeeDetails empDetail = (EmployeeDetails) authentication.getPrincipal();
		EmployeesDto empDto = (EmployeesDto) empDetail.getEmployee();
		
		List<CalendarDto> hdrCalendarList = holidayService.getDeptHdrCalendar(empDto.getDeptId(), year, month);
		return hdrCalendarList;
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
