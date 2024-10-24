package com.oti.thirtyone.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("admin")
public class AdminController {

	@GetMapping("/")
	public String adminMain(Model model) {
		model.addAttribute("admin" ,true);
		return "admin/admin";	
	}
	
	@GetMapping("/create")
	public String adminCreate(Model model){
		model.addAttribute("admin", true);
		return "admin/adminCreate";
	}
	
	@GetMapping("/searchList")
	public String searchList(Model model) {
		model.addAttribute("title", "직원관리");
		model.addAttribute("admin", true);
		return "admin/searchList";
	}
	
	@GetMapping("/empDetail")
	public String empDetail(Model model) {
		model.addAttribute("title", "정원석님의 정보 수정하기");
		model.addAttribute("admin", true);
		return "admin/empDetail";
	}
	
	@GetMapping("atdList")
	public String atdList(Model model) {
		model.addAttribute("title", "근태 관리");
		model.addAttribute("amdin", true);
		return "admin/atdList";
	}
}
