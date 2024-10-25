package com.oti.thirtyone.controller;

import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.oti.thirtyone.dto.NoticeDto;
import com.oti.thirtyone.dto.NoticeFileDto;
import com.oti.thirtyone.dto.NoticeFormDto;
import com.oti.thirtyone.dto.Pager;
import com.oti.thirtyone.service.NoticeService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/notice")
public class NoticeController {
	
	@Autowired
	NoticeService noticeService;
	
	@GetMapping("/noticeList")
	public String selectNotice(Model model, 
			@RequestParam(defaultValue="1") int pageNo,
			HttpSession session) {
		
		int totalRows = noticeService.countRows();
		Pager pager = new Pager(10, 5, totalRows, pageNo);
		session.setAttribute("pager", pager);
		
		List<NoticeDto> list = noticeService.selectListPager(pager);
		
		model.addAttribute("title", "공지사항");		
		model.addAttribute("notice", list);
		return "notice/noticeList";
	}
	
	@GetMapping("/noticeWriteForm")
	public String noticeWriteForm(Model model) {
		model.addAttribute("title", "공지사항 작성");
		return "notice/noticeWriteForm";		
	}
	
	@GetMapping("/noticeDetail")
	public String noticeDetail(Model model, int noticeId) {
		
		NoticeDto notice = noticeService.selectByNoticeId(noticeId);
		NoticeFileDto noticeFile = noticeService.selectAttachByNoticeId(noticeId);
		
		model.addAttribute("title", "공지사항");
		model.addAttribute("notice", notice);
		model.addAttribute("noticeFile", noticeFile);
		return "notice/noticeDetail";
	}
	
	
	@GetMapping("/attachDownload")
	public void attachDownload(int noticeId, HttpServletResponse response) throws Exception {
		NoticeFileDto noticeFile = noticeService.selectAttachByNoticeId(noticeId);
		
		String contentType = noticeFile.getNoticeFileType();
		response.setContentType(contentType);
		
		String fileName = noticeFile.getNoticeFileName();
		String encodingFileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + encodingFileName + "\"");
		
		ServletOutputStream out = response.getOutputStream();
		out.write(noticeFile.getNoticeFileData());
		out.flush();
		out.close();
	}
	
	@PostMapping("/noticeWrite")
	public String noticeWrite(NoticeFormDto notice, Model model) throws Exception {
		NoticeDto dbNotice = new NoticeDto();
		dbNotice.setNoticeTitle(notice.getNoticeTitle());
		dbNotice.setNoticeContent(notice.getNoticeContent());
		dbNotice.setNoticeDate(notice.getNoticeDate());
		dbNotice.setNoticeImportant(notice.getNoticeImportant());
		dbNotice.setNoticeAllTarget(notice.getNoticeAllTarget());
		
		noticeService.noticeWrite(dbNotice);
		
		MultipartFile mf = notice.getAttachFile();

		if(!mf.isEmpty()) {
		NoticeFileDto dbFile = new NoticeFileDto();
		dbFile.setNoticeFileName(mf.getOriginalFilename());
		dbFile.setNoticeFileData(mf.getBytes());
		dbFile.setNoticeFileType(mf.getContentType());
		dbFile.setNoticeFileId(1);
		dbFile.setNoticeId(dbNotice.getNoticeId());
		log.info(dbFile.toString());
		noticeService.insertNoticeFile(dbFile);
		}
		
		log.info(notice.toString());
		log.info("하이루");
		return "redirect:/notice/noticeList";
	}
	
	@GetMapping("/updateNoticeForm")
	public String updateNoticeForm(int noticeId, Model model, NoticeFileDto noticeFie) {
		NoticeDto notice = noticeService.selectByNoticeId(noticeId);
		NoticeFileDto noticeFile = noticeService.selectAttachByNoticeId(noticeId);
		model.addAttribute("notice", notice);
		model.addAttribute("noticeFile", noticeFile);
		return "notice/updateNoticeForm";
	}
	
	@PostMapping("/updateNotice")
	public String updateNotice(NoticeFormDto notice) throws Exception {
		NoticeDto dbNotice = new NoticeDto();
		dbNotice.setNoticeTitle(notice.getNoticeTitle());
		dbNotice.setNoticeContent(notice.getNoticeContent());
		dbNotice.setNoticeDate(notice.getNoticeDate());
		dbNotice.setNoticeImportant(notice.getNoticeImportant());
		dbNotice.setNoticeAllTarget(notice.getNoticeAllTarget());
		
		log.info(notice.toString());
		log.info(dbNotice.toString());
		
		noticeService.updateNotice(dbNotice);
		
		MultipartFile mf = notice.getAttachFile();
		
		if(!mf.isEmpty()) {
			NoticeFileDto dbFile = new NoticeFileDto();
			dbFile.setNoticeFileName(mf.getOriginalFilename());
			dbFile.setNoticeFileData(mf.getBytes());
			dbFile.setNoticeFileType(mf.getContentType());
			dbFile.getNoticeFileId();
			dbFile.setNoticeId(dbNotice.getNoticeId());
			log.info(dbFile.toString());
			noticeService.updateNoticeFile(dbFile);
		}
		log.info(notice.toString());
		log.info("마바사");          
		return "redirect:/notice/noticeDetail?noticeId=" + notice.getNoticeId();
	}
	
	@GetMapping("/updateHitCount")
	public String updateHitCount(int noticeId, Model model) {
		noticeService.updateHitCount(noticeId);
		log.info("조회수");
		return noticeDetail(model, noticeId);
	}
}
