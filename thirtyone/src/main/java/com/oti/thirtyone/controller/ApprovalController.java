package com.oti.thirtyone.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/approval")
public class ApprovalController {
	
	@ModelAttribute
	public void settings(Model model) {
		model.addAttribute("ApprovalRequest", true);
		model.addAttribute("commonCSS", false);
	}

	@GetMapping("/draft")
	public String getDraftFormPage(Model model){
		log.info("실행");
		
		model.addAttribute("title", "결재 기안서 작성");
		
		return "approval/draftForm";
	}
	
	@GetMapping("/settings")
	public String getApprovalSettingPage(Model model) {
		log.info("실행");
		model.addAttribute("title", "기본 결제선 설정");
		
		return "approval/approvalSettings";
	}
	
}
