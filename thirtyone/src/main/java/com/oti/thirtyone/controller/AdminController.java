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
	
}
