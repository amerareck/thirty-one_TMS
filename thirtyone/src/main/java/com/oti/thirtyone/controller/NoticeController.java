package com.oti.thirtyone.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oti.thirtyone.dto.NoticeDto;
import com.oti.thirtyone.service.NoticeService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/notice")
public class NoticeController {
	
	@Autowired
	NoticeService noticeService;
	
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
	
	@PostMapping("/insertNotice")
	public void insertNotice(NoticeDto notice) {
		log.info("실행");
		NoticeDto dbNotice = new NoticeDto();
		dbNotice.setNoticeTitle(notice.getNoticeTitle());
		dbNotice.setNoticeContent(notice.getNoticeContent());
		dbNotice.setNoticeImportant(notice.getNoticeImportant());
		dbNotice.setEmpId(notice.getEmpId());
		log.info(notice.toString());
		noticeService.insertNotice(dbNotice);
	}
}
