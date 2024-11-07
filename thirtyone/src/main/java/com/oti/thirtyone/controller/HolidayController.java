package com.oti.thirtyone.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

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
import com.oti.thirtyone.dto.EmployeesDto;
import com.oti.thirtyone.dto.HolidayDto;
import com.oti.thirtyone.dto.HolidayFormDto;
import com.oti.thirtyone.dto.HolidayRequestDto;
import com.oti.thirtyone.dto.Pager;
import com.oti.thirtyone.enums.HolidayType;
import com.oti.thirtyone.security.EmployeeDetails;
import com.oti.thirtyone.service.HolidayService;

import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("holiday")
@Log4j2
public class HolidayController {

	@Autowired
	HolidayService hdService;
	
	@GetMapping("/")
	public String holidayMain(Model model, Authentication authentication, @RequestParam(defaultValue = "1") int pageNo, HttpSession session) {
		String empId = authentication.getName();
		int totalRows = hdService.countRowsByEmpId(empId);
		Pager pager = new Pager(9, 5, totalRows, pageNo);
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
	public String holidayRequestForm(Model model) {		
		model.addAttribute("title", "정원석님의 휴가 관리");
		model.addAttribute("selectedTitle", "hr");
		model.addAttribute("selectedSub", "holiday");
		return "holiday/requestForm";	
	}
	
	@PostMapping("/request")
	public ResponseEntity<String> holidayRequest(Model model, Authentication authentication , 
			@ModelAttribute HolidayFormDto hdrForm) throws Exception {
	
		EmployeeDetails employeeDetails = (EmployeeDetails) authentication.getPrincipal();
		EmployeesDto employees = employeeDetails.getEmployee();
		
		HolidayRequestDto hdrReq = new HolidayRequestDto();
		
		//String 형식의 날짜를 Date 형식으로 변환
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			/*Date submittedDate = sdf.parse(hdrForm.getHdrSubmittedDate());*/
			Date hdrStartDate = sdf.parse(hdrForm.getHdrStartDate()); //String을 Date로 변환
			Date hdrEndDate = sdf.parse(hdrForm.getHdrEndDate());
			/*Date usedDay = sdf.parse(hdrForm.getHdrUsedDay());*/
			
			/*hdrReq.setHdrSubmittedDate(submittedDate);*/ //Date 객체를 설정
			hdrReq.setHdrStartDate(hdrStartDate);
			hdrReq.setHdrEndDate(hdrEndDate);
			
			//휴가 일수를 계산하여 설정(휴가 시작일과 종료일 차이)
			//신청일수
			
			

			/*hdrReq.setHdrSubmittedDate(submittedDate); insert에서 sysdate로 하기*/ 
			hdrReq.setHdrStartDate(hdrStartDate);
			hdrReq.setHdrEndDate(hdrEndDate);
			/*hdrReq.setHdrCompletedDate(hdrForm.getHdrCompletedDate());*/
			
			log.info(sdf);
			log.info(hdrReq.getHdrStartDate() + "1111111111111");
			log.info(hdrReq.getHdrEndDate() + "1111111111111");
	
		} catch (ParseException e) {
			//날짜 형식이 맞지 않으면 예외
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid date format");
		}
		

		hdrReq.setHdrUsedDay(hdrForm.getHdrUsedDay());
		hdrReq.setHdrContent(hdrForm.getHdrContent());
		hdrReq.setHdrStatus(hdrForm.getHdrStatus());
		/*hdrReq.setHdrUsedDay(hdrForm.getHdrUsedDay());*/
		hdrReq.setHdCategory(hdrForm.getHdCategory());
		hdrReq.setHdrEmpId(employees.getEmpId());
		hdrReq.setHdrApprover(hdrForm.getHdrApprover());
		/*hdrReq.setHdName(hdrForm.getHdName());*/
		hdrReq.setHolidayType(hdrForm.getHolidayType());
		hdrReq.setHolidayPeriod(hdrForm.getHolidayPeriod());
		hdrReq.setHolidayTime(hdrForm.getHolidayTime());
		
		log.info(hdrReq.getHdrStartDate() + "2222222222");
		log.info(hdrReq.getHdrEndDate() + "2222222222");

		
		hdService.insertHdrRequest(hdrReq);
		
		model.addAttribute("employees", employees);
		return ResponseEntity.ok("OK");
		/*return "redirect:/holiday/request";*/
	}
	
	@GetMapping("/process")
	public String holidayProcess(Model model, @RequestParam(defaultValue = "1") int pageNo) {		
		
		model.addAttribute("title", "정원석님의 휴가 관리");
		model.addAttribute("selectedTitle", "hr");
		model.addAttribute("selectedSub", "holiday");
		return "holiday/holidayProcess";	
	}
}
