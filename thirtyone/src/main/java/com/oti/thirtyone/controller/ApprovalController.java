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
	
	@GetMapping("/approve")
	public String getApproveListPage(Model model) {
		log.info("실행");
		model.addAttribute("title", "결재 승인 목록");
		
		return "approval/approvalApprove";
	}
	
	@GetMapping("/collected")
	public String getCollectedListPage(Model model) {
		log.info("실행");
		model.addAttribute("title", "결재 승인/반려");
		
		return "approval/approvalApprove";
	}
	
	@GetMapping("/deptBox")
	public String getDeptOfficeBoxPage(Model model) {
		log.info("실행");
		model.addAttribute("title", "부서문서함");
		
		return "approval/approvalDeptOfficeBox";
	}
	
	@GetMapping("submitted")
	public String getSubmittedPage(Model model) {
		log.info("실행");
		model.addAttribute("title", "기결/회수");
		
		return "approval/approvalSubmitted";
	}
	
	@GetMapping("before")
	public String getBeforePage(Model model) {
		log.info("실행");
		model.addAttribute("title", "결제 전단계");
		
		return "approval/approvalBeforeStep";
	}
	
	@GetMapping("approveList")
	public String getApproveReadyPage(Model model) {
		log.info("실행");
		model.addAttribute("title", "결제 진행");
		
		return "approval/approvalReadyList";
	}
}
