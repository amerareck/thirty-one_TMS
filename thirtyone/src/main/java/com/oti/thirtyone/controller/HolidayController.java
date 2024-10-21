package com.oti.thirtyone.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("holiday")
public class HolidayController {

	@GetMapping("/")
	public String holidayMain(Model model) {
		model.addAttribute("title", "정원석님의 휴가 관리");
		return "holiday/status";	
	}
	@GetMapping("/request")
	public String holidayRequest(Model model) {		
		model.addAttribute("title", "정원석님의 휴가 관리");
		return "holiday/request";	
	}
}
