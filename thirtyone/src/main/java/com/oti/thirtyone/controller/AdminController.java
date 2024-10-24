package com.oti.thirtyone.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("admin")
public class AdminController {
	@ModelAttribute
	public void settings(Model model) {
		model.addAttribute("admin", true);
	}
	
	@GetMapping("/")
	public String adminMain(Model model) {
		model.addAttribute("selectedTitle", "home");
		return "admin/admin";	
	}
	
	@GetMapping("/create")
	public String adminCreate(Model model){
		model.addAttribute("selectedTitle", "adminEmp");
		model.addAttribute("selectedSub", "adminCreate");
		return "admin/adminCreate";
	}
	
	@GetMapping("/searchList")
	public String searchList(Model model) {
		model.addAttribute("selectedTitle", "adminEmp");
		model.addAttribute("selectedSub", "searchList");
		model.addAttribute("title", "직원관리");
		return "admin/searchList";
	}
	
	@GetMapping("/empDetail")
	public String empDetail(Model model) {
		model.addAttribute("title", "정원석님의 정보 수정하기");
		model.addAttribute("selectedTitle", "adminEmp");
		model.addAttribute("selectedSub", "empDetail");
		return "admin/empDetail";
	}
	
	@GetMapping("atdList")
	public String atdList(Model model) {
		model.addAttribute("title", "근태 관리");
		model.addAttribute("selectedTitle", "adminEmp");
		model.addAttribute("selectedSub", "atdList");
		return "admin/atdList";
	}
	
	@GetMapping("/org")
	public String getOrgChartPage(Model model) {
		log.info("실행");
		
		model.addAttribute("title", "조직도");
		model.addAttribute("selectedTitle", "org");
		model.addAttribute("selectedSub", "organization");
		model.addAttribute("activePage","orgChart");
		
		return "admin/org/orgChartManagement";
	}
	
	@GetMapping("/position")
	public String getPositionPage(Model model) {
		log.info("실행");
		
		model.addAttribute("title", "조직도");
		model.addAttribute("selectedTitle", "org");
		model.addAttribute("selectedSub", "organization");
		model.addAttribute("activePage","position");
		
		return "admin/org/orgPosition";
	}
	
	@GetMapping("/employee")
	public String getEmployeePage(Model model) {
		log.info("실행");
		
		model.addAttribute("title", "조직도");
		model.addAttribute("selectedTitle", "org");
		model.addAttribute("selectedSub", "organization");
		model.addAttribute("activePage","employee");
		
		return "admin/org/orgEmployee";
	}
}
