package com.oti.thirtyone.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.expression.ParseException;
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

import com.oti.thirtyone.dto.CalendarDto;
import com.oti.thirtyone.dto.Departments;
import com.oti.thirtyone.dto.EmployeesDto;
import com.oti.thirtyone.dto.HolidayDto;
import com.oti.thirtyone.dto.HolidayFormDto;
import com.oti.thirtyone.dto.HolidayRequestDto;
import com.oti.thirtyone.dto.Pager;
import com.oti.thirtyone.dto.PositionsDto;
import com.oti.thirtyone.enums.HolidayType;
import com.oti.thirtyone.security.EmployeeDetails;
import com.oti.thirtyone.service.DepartmentService;
import com.oti.thirtyone.service.EmployeesService;
import com.oti.thirtyone.service.HolidayService;
import com.oti.thirtyone.service.PositionService;

import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("holiday")
@Log4j2
public class HolidayController {

	@Autowired
	HolidayService hdService;

	@Autowired
	PositionService positionService;

	@Autowired
	DepartmentService departmentService;
	
	@Autowired
	EmployeesService employeesService;

	@GetMapping("")
	public String holidayMain(Model model, Authentication authentication, @RequestParam(defaultValue = "1") int pageNo,
			HttpSession session) {
		String empId = authentication.getName();
		int totalRows = hdService.countRowsByEmpId(empId);
		Pager pager = new Pager(4, 5, totalRows, pageNo);
		session.setAttribute("pager", pager);
		List<HolidayRequestDto> hdrReqList = hdService.getHdrReqAllbyEmpId(empId, pager);
		for (HolidayRequestDto hdrReq : hdrReqList) {
			hdrReq.setHdName(HolidayType.getCategoryByCode(hdrReq.getHdCategory()));
		}
		HolidayDto annualDto = hdService.getAnnualHoliday(empId);
		HolidayDto substituteDto = hdService.getSubstituteHoliday(empId);

		model.addAttribute("substitute", substituteDto);
		model.addAttribute("annual", annualDto);
		model.addAttribute("pager", pager);
		model.addAttribute("hdrReqList", hdrReqList);
		model.addAttribute("title", "정원석님의 휴가 관리");
		model.addAttribute("selectedTitle", "hr");
		model.addAttribute("selectedSub", "holiday");
		return "holiday/status";
	}

	@GetMapping("/myhdrCalendar")
	@ResponseBody
	public List<CalendarDto> myhdrCalendar(String year, String month, Authentication authentication) {
		String empId = authentication.getName();
		List<CalendarDto> hdrCalendarList = hdService.getHdrCalendar(empId, year, month);
		return hdrCalendarList;
	}

	@GetMapping("/ramainHoliday")
	@ResponseBody
	public double[] remainHoliday(Authentication authentication) {
		String empId = authentication.getName();
		double[] holiday = hdService.getRemainHoliday(empId);
		return holiday;
	}

	@GetMapping("/requestForm")
	public String holidayRequestForm(Model model, Authentication authentication) {
		
		EmployeeDetails employeeDetails = (EmployeeDetails) authentication.getPrincipal();
		EmployeesDto employee = employeeDetails.getEmployee();
		
		String deptName = departmentService.getDeptName(employee.getDeptId());
		
		List<EmployeesDto> employees = employeesService.getAllEmployees();	
		List<PositionsDto> position = positionService.getPosList();
		List<Departments> dept = departmentService.getDepartmentList();		
		List<HolidayDto> holiday = hdService.getHolidayByEmpId(employee.getEmpId());
		for (HolidayDto hdDto : holiday) {
			hdDto.setHdName(HolidayType.getCategoryByCode(hdDto.getHdCategory()));
		}
		
		model.addAttribute("title", "정원석님의 휴가 관리");
		model.addAttribute("selectedTitle", "hr");
		model.addAttribute("selectedSub", "holiday");
		
		model.addAttribute("holiday", holiday);
		model.addAttribute("deptName", deptName);
		model.addAttribute("employees", employees);
		model.addAttribute("employee", employee);
		log.info("Employee added to model: {}", employee != null ? employee.toString() : "null");

		model.addAttribute("position", position);
		model.addAttribute("dept", dept);

		log.info("Employees: {}", employee != null ? employee.toString() : "null");
		log.info("Position List: {}", position != null ? position.toString() : "null");
		log.info("Department List: {}", dept != null ? dept.toString() : "null");
		
		return "holiday/requestForm";
	}
	
	//휴가 신청
	@PostMapping("/request")
	public ResponseEntity<String> holidayRequest(Model model, Authentication authentication,
			@ModelAttribute HolidayFormDto hdrForm) throws Exception {
		log.info(hdrForm.toString());
		EmployeeDetails employeeDetails = (EmployeeDetails) authentication.getPrincipal();
		EmployeesDto employee = employeeDetails.getEmployee();
		
		HolidayRequestDto hdrReq = new HolidayRequestDto();
		
		double hdrUsedDay = hdrForm.getHdrUsedDay();
		

		// String 형식의 날짜를 Date 형식으로 변환
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			/*double usedDay = 1.0;
			String formattedUsedDay = String.format("%.1f", usedDay).replaceAll("||.0$", "");*/

			Date hdrStartDate = sdf.parse(hdrForm.getHdrStartDate()); // String을 Date로 변환
			Date hdrEndDate = sdf.parse(hdrForm.getHdrEndDate());

			hdrReq.setHdrStartDate(hdrStartDate);
			hdrReq.setHdrEndDate(hdrEndDate);

		} catch (ParseException e) {
			// 날짜 형식이 맞지 않으면 예외
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid date format");
		}

		hdrReq.setHdrEmpId(employee.getEmpId());
		hdrReq.setHdrUsedDay(hdrForm.getHdrUsedDay());
		hdrReq.setHdrContent(hdrForm.getHdrContent());
		hdrReq.setHdrStatus(hdrForm.getHdrStatus());
		hdrReq.setHdCategory(hdrForm.getHdCategory());
		hdrReq.setHolidayType(hdrForm.getHolidayType());
		hdrReq.setHolidayPeriod(hdrForm.getHolidayPeriod());
		hdrReq.setHolidayTime(hdrForm.getHolidayTime());
		
		//승인자 설정
		String hdrApprover = hdrForm.getHdrApprover();
		hdrReq.setHdrApprover(hdrApprover);

		hdService.insertHdrRequest(hdrReq);
		model.addAttribute("hdrUsedDay", hdrUsedDay);
		return ResponseEntity.ok("OK" + hdrUsedDay);
	}

	@GetMapping("/getEmployeesByPosition")
	public ResponseEntity<List<EmployeesDto>> getEmployeesByPosition(@RequestParam String positionClass, Authentication authentication) {
		EmployeeDetails empDetails = (EmployeeDetails) authentication.getPrincipal();
		EmployeesDto empDto = empDetails.getEmployee();
		
		// 직급에 맞는 사원 목록을 반환하는 로직
		List<EmployeesDto> employees = employeesService.getEmployeesByPosition(positionClass, empDto.getDeptId());
		return ResponseEntity.ok(employees);
	}
	
	//휴가처리
	@GetMapping("/process")
	public String holidayProcess(Model model, @RequestParam(defaultValue = "1") int pageNo,
			Authentication authentication, HttpSession session) {
		
		EmployeeDetails employeeDetails = (EmployeeDetails) authentication.getPrincipal();
		EmployeesDto employee = employeeDetails.getEmployee(); //나의 정보
		
		String empId = authentication.getName();
		int totalRows = hdService.countRowsByEmpId(empId);
		Pager pager = new Pager(4, 5, totalRows, pageNo);
		session.setAttribute("pager", pager);
		
		List<HolidayRequestDto> hdrAprList = hdService.selectHdrListByAprId(empId, pager);
		List<Map<String, Object>> hdrInfoList = new LinkedList<>();
		
		for (HolidayRequestDto  hdrApr : hdrAprList) {
			Map<String, Object> hdrInfo = new HashMap<>();
			EmployeesDto empDto = employeesService.getEmpInfo(hdrApr.getHdrEmpId()); //결재 올린사람의 정보
			String deptName = departmentService.getDeptName(empDto.getDeptId());
			hdrApr.setHdName(HolidayType.getCategoryByCode(hdrApr.getHdCategory()));
			hdrInfo.put("emp", empDto);
			hdrInfo.put("deptName", deptName);
			hdrInfo.put("hdrApr", hdrApr);
			
			hdrInfoList.add(hdrInfo);		
		}			
				
		model.addAttribute("title", "정원석님의 휴가 관리");
		model.addAttribute("selectedTitle", "hr");
		model.addAttribute("selectedSub", "holiday");
		model.addAttribute("hdrInfoList", hdrInfoList);			
		model.addAttribute("pager", pager);
		return "holiday/holidayProcess";
	}
	
	//승인 반려
	@PostMapping("/hdrAccept")
	public ResponseEntity<String> selectHdrAccept(int hdrId, String status, int hdCategory, Authentication authentication, String empId) {

		hdService.updateHdrAccept(hdrId, status, empId, hdCategory);
		return ResponseEntity.ok("ok");
	}
	

}
