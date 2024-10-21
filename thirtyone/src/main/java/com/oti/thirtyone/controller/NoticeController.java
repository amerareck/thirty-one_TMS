package com.oti.thirtyone.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/notice")
public class NoticeController {
	
	@GetMapping("/noticeList")
	public String noticeList(Model model) {
		model.addAttribute("title", "공지사항");
		return "notice/noticeList";
	}
	
	@GetMapping("/noticeWrite")
	public String noticeWrite(Model model) {
		model.addAttribute("title", "공지사항 작성");
		return "notice/noticeWrite";
		
	}
	
	@GetMapping("/noticeDetail")
	public String noticeDetail(Model model) {
		model.addAttribute("title", "공지사항");
		return "notice/noticeDetail";
	}
}
