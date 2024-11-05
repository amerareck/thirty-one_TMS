package com.oti.thirtyone.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oti.thirtyone.dto.CalendarDto;
import com.oti.thirtyone.dto.HolidayDto;
import com.oti.thirtyone.dto.HolidayRequestDto;
import com.oti.thirtyone.dto.Pager;
import com.oti.thirtyone.enums.HolidayType;
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
	
	@GetMapping("/request")
	public String holidayRequest(Model model) {		
		model.addAttribute("title", "정원석님의 휴가 관리");
		model.addAttribute("selectedTitle", "hr");
		model.addAttribute("selectedSub", "holiday");
		return "holiday/request";	
	}
	@GetMapping("/process")
	public String holidayProcess(Model model) {		
		model.addAttribute("title", "정원석님의 휴가 관리");
		model.addAttribute("selectedTitle", "hr");
		model.addAttribute("selectedSub", "holiday");
		return "holiday/holidayProcess";	
	}
}
