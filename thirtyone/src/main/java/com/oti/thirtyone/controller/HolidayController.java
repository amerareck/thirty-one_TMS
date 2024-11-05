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
	HolidayService hdrService;
	
	@GetMapping("/")
	public String holidayMain(Model model, Authentication authentication, @RequestParam(defaultValue = "1") int pageNo, HttpSession session) {
		String empId = authentication.getName();
		int totalRows = hdrService.countRowsByEmpId(empId);
		Pager pager = new Pager(9, 5, totalRows, pageNo);
		session.setAttribute("pager", pager);
		List<HolidayRequestDto> hdrReqList = hdrService.getHdrReqAllbyEmpId(empId, pager);
		for (HolidayRequestDto hdrReq : hdrReqList) {
			hdrReq.setHdName(HolidayType.getCategoryByCode(hdrReq.getHdCategory()));
		}
		model.addAttribute("hdrReqList", hdrReqList);
		model.addAttribute("title", "정원석님의 휴가 관리");
		model.addAttribute("selectedTitle", "hr");
		model.addAttribute("selectedSub", "holiday");
		return "holiday/status";	
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
