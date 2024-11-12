package com.oti.thirtyone.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.text.ParseException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.oti.thirtyone.dto.AttendanceDto;
import com.oti.thirtyone.dto.CalendarDto;
import com.oti.thirtyone.dto.Departments;
import com.oti.thirtyone.dto.DocFilesDTO;
import com.oti.thirtyone.dto.EmployeesDto;
import com.oti.thirtyone.dto.Pager;
import com.oti.thirtyone.dto.ReasonDto;
import com.oti.thirtyone.dto.ReasonFormDto;
import com.oti.thirtyone.security.EmployeeDetails;
import com.oti.thirtyone.service.AlertService;
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
	@Autowired
	AlertService alertService;
	
	
	@GetMapping("")
	@Secured("ROLE_USER")
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
	
	@GetMapping("checkIn")
	public ResponseEntity<Boolean> checkIn(double latitude, double longitude, Authentication authentication){
		String empId= authentication.getName();
		int deptId = empService.getDeptId(empId);
		String regionalOffice = deptService.getRegionalOffice(deptId);
		
		double distance = atdService.distanceCalculation(latitude, longitude, regionalOffice);

		if(distance < 1000) {
			atdService.checkIn(empId);
			return ResponseEntity.ok(true);
		}else {
			return ResponseEntity.ok(false);
		}
		
	}
	
	@GetMapping("checkOut")
	public ResponseEntity<String> checkOut(double latitude, double longitude, Authentication authentication){
		log.info("ASD");
		String empId= authentication.getName();
		int deptId = empService.getDeptId(empId);
		String regionalOffice = deptService.getRegionalOffice(deptId);
		
		double distance = atdService.distanceCalculation(latitude, longitude, regionalOffice);
		boolean result = false;
		if(distance < 1000) {
			log.info("ASD");
			result = atdService.checkOut(empId);
		}
		
		return ResponseEntity.ok("퇴근");
	}
	
	
	@GetMapping("atdCalendar")
	@ResponseBody
	public List<CalendarDto> atdCalendar(Authentication authentication, String year, String month){
		String empId = authentication.getName();
		List<CalendarDto> atdCalendarList = atdService.getAtdInfoList(empId, year, month);
		return atdCalendarList;
	}
	
	@GetMapping("/atdStatusMonthly")
	@ResponseBody
	public int[] atdStatusMonthly(Authentication authentication) {
		String empId = authentication.getName();
		int[] status = atdService.getAtdStats(empId);
		return status;
	}
	@GetMapping("/time")
	@Secured("ROLE_USER")
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
	
	@PostMapping("getAtdForWeek")
	@ResponseBody
	public Map<String, Object> getAtdForWeek(@RequestParam List<String> week, Authentication authentication) throws ParseException{
		String empId = authentication.getName();
		Map<String, Object> atdList = atdService.getAtdInfoWeekly(week.get(0), week.get(1), empId);
		return atdList;
	}
	
	@GetMapping("reasonReqInfo")
	@ResponseBody
	public Map<String, Object> reasonReqInfo(int reasonId) {
		Map<String, Object> reasonInfo = new HashMap<>();
		
		List<DocFilesDTO> fileList = reasonService.getReasonFileList(reasonId);
		ReasonDto reasonDto = reasonService.getReasoninfo(reasonId);
		
		reasonInfo.put("fileList", fileList);
		reasonInfo.put("reason", reasonDto);
		
		return reasonInfo;
		
	}

	@GetMapping("/process")
	@Secured("ROLE_USER")
	public String atdProcess(Model model, Authentication authentication, @RequestParam(defaultValue = "1") int pageNo, HttpSession session ) {
		String empId = authentication.getName();
		
		int totalRows = reasonService.countRowsByImprover(empId);
		Pager pager = new Pager(5, 5, totalRows, pageNo);
		session.setAttribute("pager", pager);
		
		List<ReasonDto> reasonList = reasonService.getReasonListByImprover(empId, pager);
		List<Map<String, Object>> reasonInfoList = new LinkedList<>();
		
		for(ReasonDto reason : reasonList) {
			Map<String, Object> reasonInfo = new HashMap<>();
			EmployeesDto empDto = empService.getEmpInfo(reason.getEmpId());
			String deptName = deptService.getDeptName(empDto.getDeptId());
			reasonInfo.put("emp", empDto);
			reasonInfo.put("deptName", deptName);
			reasonInfo.put("reason", reason);
			
			reasonInfoList.add(reasonInfo);
		}
		
		model.addAttribute("reasonList", reasonInfoList);
		model.addAttribute("title", "정원석님의 근태 관리");
		model.addAttribute("selectedTitle", "hr");
		model.addAttribute("selectedSub", "attendance");
		return "attendance/attendanceProcess"; 
	}
	
	@GetMapping("/getRequestReason")
	@ResponseBody
	public Map<String, Object> getRequestReason(String empId, int reasonId) {
		Map<String, Object> requestInfo = new HashMap<>();
		
		EmployeesDto empDto = empService.getEmpInfo(empId);
		ReasonDto reasonDto = reasonService.getReasoninfo(reasonId);
		String deptName = deptService.getDeptName(empDto.getDeptId());  
		AttendanceDto atdDto = atdService.getAtdInfoOneDay(empId, reasonDto.getAtdDate());
		List<DocFilesDTO> fileList = reasonService.getReasonFileList(reasonDto.getReasonId());
		
		requestInfo.put("fileList", fileList);
		requestInfo.put("emp", empDto);
		requestInfo.put("reason", reasonDto);
		requestInfo.put("deptName", deptName);
		requestInfo.put("atd", atdDto);
		
		return requestInfo;
	}
	
	@GetMapping("/attachDownload")
	public void attachDownload(int fileId, HttpServletResponse response) throws Exception {
		DocFilesDTO file = reasonService.getReasonFile(fileId);

		String contentType = file.getDocFileType();
		response.setContentType(contentType);
		
		String fileName = file.getDocFileName();
		String encodingFileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + encodingFileName + "\"");
		
		OutputStream out = response.getOutputStream();
		out.write(file.getDocFileData());
		out.flush();
		out.close();
	}
	
	@PostMapping("/requsetStatus")
	public ResponseEntity<String> requestAccept(int reasonId, String empId, String atdDate, String status) {
		reasonService.updateReasonStatus(reasonId, empId, atdDate, status);
		EmployeesDto empDto = empService.getEmpInfo(empId);
		String alertContent = "";
		if(status.equals("반려")) {
			alertContent=empDto.getEmpName() + "님이 근태 사유서를 반려하였습니다.";
			alertService.sendAlert(empId, alertContent, "휴가");
		}else {
			alertContent=empDto.getEmpName() + "님이 근태 사유서를 승인하였습니다.";
			alertService.sendAlert(empId, alertContent, "휴가");			
		}
		return ResponseEntity.ok("OK");
	}
	
	@Transactional
	@PostMapping("reasonRequest")
	public ResponseEntity<Boolean> reasonRequest(@ModelAttribute ReasonFormDto reasonForm, Authentication authentication) throws IOException {
		EmployeeDetails empDetail = (EmployeeDetails) authentication.getPrincipal();
		EmployeesDto empDto = empDetail.getEmployee();
		
		ReasonDto reasonDto = new ReasonDto();
		Departments deptDto = deptService.getDeptInfo(empDto.getDeptId());
		String empId = empDto.getEmpId();
		String improverId = deptDto.getEmpId();
		reasonDto.setEmpId(empId);
		reasonDto.setReasonContent(reasonForm.getReason());
		reasonDto.setReasonType(reasonForm.getState());
		reasonDto.setReasonImprover(improverId);
		boolean hasReason = reasonService.hasReasonOfDay(empId, reasonForm.getCheckIn().split(" ")[0]);
		if(!hasReason) {
			return ResponseEntity.ok(false);
		}
		reasonService.insertReason(reasonDto, reasonForm.getCheckIn().split(" ")[0]);
		
		int reasonId = reasonDto.getReasonId();
		log.info(reasonId);
		MultipartFile[] files = reasonForm.getAttachFiles();
		if(files != null && files.length > 0) {
			for(MultipartFile file : files) {
				DocFilesDTO fileDto = new DocFilesDTO();
				fileDto.setDocFileName(file.getOriginalFilename());
				fileDto.setDocFileType(file.getContentType());
				fileDto.setDocFileData(file.getBytes());
				fileDto.setReasonId(reasonId);
				reasonService.insertReasonFile(fileDto);
			}
		}
		String alertContent=empDto.getEmpName() + "님에게 근태 수정 요청을 신청 하였습니다.";
		alertService.sendAlert(improverId, alertContent, "근태");
		
		return ResponseEntity.ok(true);
	}
	
	@PostMapping("reasonUpdate")
	public ResponseEntity<Boolean> reasonUpdate(@ModelAttribute ReasonFormDto reasonForm, Authentication authentication) throws IOException{
		
		ReasonDto reasonDto = new ReasonDto();
		int reasonId = reasonForm.getReasonId();
		reasonDto.setReasonId(reasonId);
		reasonDto.setReasonContent(reasonForm.getReason());
		
		reasonService.updateReason(reasonDto);
		int[] deleteList = reasonForm.getDeleteFileList();
		if(deleteList.length > 0) {
			for(int fileId : deleteList) {
				reasonService.deleteFile(fileId);
			}
		}

		MultipartFile[] files = reasonForm.getAttachFiles();
		if(files != null && files.length > 0) {
			for(MultipartFile file : files) {
				DocFilesDTO fileDto = new DocFilesDTO();
				log.info(file.getOriginalFilename());
				fileDto.setDocFileName(file.getOriginalFilename());
				fileDto.setDocFileType(file.getContentType());
				fileDto.setDocFileData(file.getBytes());
				fileDto.setReasonId(reasonId);
				reasonService.insertReasonFile(fileDto);
			}
		}
		
		return ResponseEntity.ok(true);
	}
}

















