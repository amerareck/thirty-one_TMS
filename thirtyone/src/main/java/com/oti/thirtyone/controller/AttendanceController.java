package com.oti.thirtyone.controller;

import java.io.IOException;
import java.text.ParseException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.oti.thirtyone.dao.ReasonDao;
import com.oti.thirtyone.dto.AttendanceCalendarDto;
import com.oti.thirtyone.dto.AttendanceDto;
import com.oti.thirtyone.dto.Departments;
import com.oti.thirtyone.dto.DocFilesDTO;
import com.oti.thirtyone.dto.EmployeesDto;
import com.oti.thirtyone.dto.ReasonDto;
import com.oti.thirtyone.dto.ReasonFormDto;
import com.oti.thirtyone.security.EmployeeDetails;
import com.oti.thirtyone.service.AttendanceService;
import com.oti.thirtyone.service.DepartmentService;
import com.oti.thirtyone.service.EmployeesService;
import com.oti.thirtyone.service.ReasonService;

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
	@Autowired
	ReasonService reasonService;
	
	
	@GetMapping("")
	public String attendanceMain(Model model, Authentication authentication) {
		String empId = authentication.getName();

		AttendanceDto atdDto = atdService.getAtdInfo(empId);
		
		Map<String, Long> workTime = new HashMap<>();
		workTime.put("hour", (long) 0);
		if(atdDto != null && atdDto.getCheckIn() != null) {
//			boolean isLateCheck = atdService.isLateCheck(atdDto); 
			workTime = atdService.getTimeWork(atdDto);
			log.info(workTime.toString());
		}
		model.addAttribute("workTime", workTime);
		
		model.addAttribute("atd", atdDto);
		
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
		
		double distance = atdService.distanceCalculation(latitude, longitude, regionalOffice);
		boolean result = false;
		if(distance < 1000) {
			result = atdService.checkIn(empId);
		}
		
		return ResponseEntity.ok("출근");
	}
	
	@PostMapping("checkOut")
	public ResponseEntity<String> checkOut(double latitude, double longitude, Authentication authentication){
		String empId= authentication.getName();
		int deptId = empService.getDeptId(empId);
		String regionalOffice = deptService.getRegionalOffice(deptId);
		
		double distance = atdService.distanceCalculation(latitude, longitude, regionalOffice);
		boolean result = false;
		if(distance < 1000) {
			result = atdService.checkOut(empId);
		}
		
		return ResponseEntity.ok("출근");
	}
	
	
	@GetMapping("atdCalendar")
	@ResponseBody
	public List<AttendanceCalendarDto> atdCalender(Authentication authentication, String year, String month){
		String empId = authentication.getName();
		List<AttendanceCalendarDto> atdCalendarList = atdService.getAtdInfoList(empId, year, month);
		return atdCalendarList;
	}
	
	@GetMapping("/atdStatusMonthly")
	@ResponseBody
	public int[]atdStatusMonthly(Authentication authentication) {
		String empId = authentication.getName();
		int[] status = atdService.getAtdStats(empId);
		log.info(Arrays.toString(status));
		return status;
	}
	@GetMapping("/time")
	public String attendacnetime(Model model, Authentication authentication) {
		EmployeeDetails empDetail = (EmployeeDetails) authentication.getPrincipal();
		EmployeesDto empDto = empDetail.getEmployee();
		String deptName = deptService.getDeptName(empDto.getDeptId());
		
		model.addAttribute("deptName", deptName);
		model.addAttribute("emp", empDto);
		model.addAttribute("title", "정원석님의 근태 관리");
		model.addAttribute("selectedTitle", "hr");
		model.addAttribute("selectedSub", "attendance");
		
		return "attendance/attendanceTime";
	}
	
	@PostMapping("reasonRequest")
	public ResponseEntity<Boolean> reasonRequest(@ModelAttribute ReasonFormDto reasonForm, Authentication authentication) throws IOException {
		EmployeeDetails empDetail = (EmployeeDetails) authentication.getPrincipal();
		EmployeesDto empDto = empDetail.getEmployee();
		
		ReasonDto reasonDto = new ReasonDto();
		Departments deptDto = deptService.getDeptInfo(empDto.getDeptId());
		String empId = empDto.getEmpId();
		reasonDto.setEmpId(empId);
		reasonDto.setReasonContent(reasonForm.getReason());
		reasonDto.setReasonType(reasonForm.getState());
		reasonDto.setReasonImprover(deptDto.getEmpId());
		boolean hasReason = reasonService.hasReasonOfDay(empId, reasonForm.getCheckIn().split(" ")[0]);
		if(!hasReason) {
			log.info(hasReason);
			return ResponseEntity.ok(false);
		}
//		reasonService.insertReason(reasonDto, reasonForm.getCheckIn().split(" ")[0]);
//		
//		int reasonId = reasonDto.getReasonId();
//		log.info(reasonId);
//		MultipartFile[] files = reasonForm.getAttachFiles();
//		if(files != null && files.length > 0) {
//			for(MultipartFile file : files) {
//				DocFilesDTO fileDto = new DocFilesDTO();
//				fileDto.setDocFileName(file.getOriginalFilename());
//				fileDto.setDocFileType(file.getContentType());
//				fileDto.setDocFileData(file.getBytes());
//				fileDto.setReasonId(reasonId);
//				reasonService.insertReasonFile(fileDto);
//			}
//		}
		
		return ResponseEntity.ok(true);
	}
	
	@GetMapping("/process")
	public String atdProcess(Model model) {
		model.addAttribute("title", "정원석님의 근태 관리");
		model.addAttribute("selectedTitle", "hr");
		model.addAttribute("selectedSub", "attendance");
		return "attendance/attendanceProcess"; 
	}
	
	@PostMapping("getAtdForWeek")
	@ResponseBody
	public Map<String, Object> getAtdForWeek(@RequestParam List<String> week, Authentication authentication) throws ParseException{
		String empId = authentication.getName();
		Map<String, Object> atdList = atdService.getAtdInfoWeekly(week.get(0), week.get(1), empId);
		
		return atdList;
	}

}
