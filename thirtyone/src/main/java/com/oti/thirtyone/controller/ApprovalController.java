package com.oti.thirtyone.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oti.thirtyone.dto.PageParam;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/approval")
public class ApprovalController {
	
	@ModelAttribute
	public void settings(Model model) {
		model.addAttribute("selectedTitle", "approval");
		model.addAttribute("ApprovalRequest", true);
		model.addAttribute("commonCSS", false);
	}

	@GetMapping("/draft")
	public String getDraftFormPage(Model model){
		log.info("실행");
		
		model.addAttribute("selectedSub", "draft");
		model.addAttribute("title", "기안서 작성");
		
		return "approval/draftForm";
	}
	
	@GetMapping("/settings")
	public String getApprovalSettingPage(Model model) {
		log.info("실행");
		
		model.addAttribute("selectedSub", "settings");
		model.addAttribute("title", "전자 결재 설정");
		
		return "approval/approvalSettings";
	}
	
	@GetMapping("/result")
	public String getApproveListPage(PageParam param, Model model) {
		log.info("실행");
		String result = "";
		
		model.addAttribute("selectedSub", "result");
		model.addAttribute("title", "결재 승인/반려");
		
		if(param.getType()!=null && param.getType().equals("reject")) {
			model.addAttribute("activePage", "reject");
			result = "approval/approvalRejected";
		} else { //default page, type="approve"
			model.addAttribute("activePage", "approve");
			result = "approval/approvalApprove";
		}
		
		return result;
	}
	
	@GetMapping("/archive")
	public String getDeptOfficeBoxPage(PageParam param, Model model) {
		log.info("실행");
		model.addAttribute("selectedSub", "archive");
		model.addAttribute("title", "문서함");
		
		if(param.getType()!=null && param.getType().equals("completeDoc")) {
			model.addAttribute("activePage", "completeDoc");
			model.addAttribute("sectionTitle", "완결 문서함");
		} else if(param.getType()!=null && param.getType().equals("referenceDoc")) {
			model.addAttribute("activePage", "referenceDoc");
			model.addAttribute("sectionTitle", "참조 문서함");
		} else { //default page, type="deptDoc"
			model.addAttribute("activePage", "deptDoc");
			model.addAttribute("sectionTitle", "부서 문서함");
			
		}
		
		return "approval/approvalDeptOfficeBox";
	}
	
	@GetMapping("/submitted")
	public String getSubmittedPage(PageParam param, Model model) {
		log.info("실행");
		
		model.addAttribute("selectedSub", "submitted");
		model.addAttribute("title", "기결/회수");
		
		if(param.getType()!=null && param.getType().equals("retrieval")) {
			model.addAttribute("activePage", "retrieval");
			model.addAttribute("sectionTitle", "결재 회수 목록");
			
		} else { //default page, type="submitted"
			model.addAttribute("activePage", "submitted");
			model.addAttribute("sectionTitle", "결재 상신 목록");
		}
		
		return "approval/approvalSubmitted";
	}
	
	@GetMapping("/before")
	public String getBeforePage(PageParam param, Model model) {
		log.info("실행");
		
		model.addAttribute("selectedSub", "before");
		model.addAttribute("title", "결재 전단계");
		model.addAttribute("sectionTitle", "결재 전단계 문서");
		
		return "approval/approvalBeforeStep";
	}
	
	@GetMapping("/approveList")
	public String getApproveReadyPage(PageParam param, Model model) {
		log.info("실행");
		
		model.addAttribute("selectedSub", "approveList");
		model.addAttribute("title", "결제 하기");
		
		if (param.getType()!=null && param.getType().equals("all")) {
			model.addAttribute("activePage", "all");
			model.addAttribute("sectionTitle", "전체 결재 목록");
			
		} else { //defualt page, type="ready"
			model.addAttribute("activePage", "ready");
			model.addAttribute("sectionTitle", "결재 대기");
		}
		
		return "approval/approvalReadyList";
	}
}
