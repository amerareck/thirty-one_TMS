package com.oti.thirtyone.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.oti.thirtyone.dto.Departments;
import com.oti.thirtyone.dto.EmployeesDto;
import com.oti.thirtyone.dto.NoticeDto;
import com.oti.thirtyone.dto.NoticeFileDto;
import com.oti.thirtyone.dto.NoticeFormDto;
import com.oti.thirtyone.dto.NoticeTargetDto;
import com.oti.thirtyone.dto.Pager;
import com.oti.thirtyone.security.EmployeeDetails;
import com.oti.thirtyone.service.DepartmentService;
import com.oti.thirtyone.service.NoticeService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/empNotice")
public class EmpNoticeController {

	@Autowired
	NoticeService noticeService;

	@Autowired
	DepartmentService departmentService;

	// 공지사항 조회
	@GetMapping("/empNoticeList")
	public String noticeList(Model model, @RequestParam(defaultValue = "1") int pageNo, HttpSession session,
			NoticeDto noticeDto) {

		int totalRows = noticeService.countRows();

		if (totalRows == 0) {
			Pager pager = new Pager(10, 5, 0, pageNo);

		} else {

			Pager pager = new Pager(10, 5, totalRows, pageNo);
			session.setAttribute("pager", pager);

			List<NoticeDto> notice = noticeService.selectListPager(pager);

			model.addAttribute("title", "공지사항");
			model.addAttribute("notice", notice);
			model.addAttribute("noticeDto", noticeDto);

		}
		return "empNotice/empNoticeList";
	}

	// 공지사항 검색
	@GetMapping("/searchNotice")
	public String searchNotice(Model model, @RequestParam(defaultValue = "1") int pageNo, HttpSession session,
			@RequestParam("noticeTitle") String noticeTitle) {

		int totalRows = noticeService.searchCountRows(noticeTitle);

		Pager pager = new Pager(10, 5, totalRows, pageNo);
		model.addAttribute("pager", pager);

		if (totalRows > 0) {
			List<NoticeDto> notice = noticeService.searchNotice(noticeTitle, pager);
			model.addAttribute("title", "공지사항");
			model.addAttribute("notice", notice);

		} else {
			model.addAttribute("title", "공지사항 - 검색 결과 없음");
			model.addAttribute("notice", new ArrayList<>());
		}
		model.addAttribute("noticeTitle", noticeTitle);
		log.info("Search Title: " + noticeTitle);
		return "empNotice/empNoticeList";
	}

	// 공지사항 상세페이지
	@GetMapping("/empNoticeDetail")
	public String noticeDetail(Model model, int noticeId) {

		NoticeDto notice = noticeService.selectByNoticeId(noticeId);
		log.info("Notice fetched: " + notice);
		List<NoticeFileDto> noticeFile = noticeService.selectAttachFiles(noticeId);
		NoticeDto prevNext = noticeService.prevNext(noticeId);

		List<NoticeTargetDto> noticeDeptList = noticeService.selectDeptId(noticeId);
		List<Departments> deptList = departmentService.getDeptList();
		log.info("Notice Dept List: " + noticeDeptList);
		log.info("Dept List: " + deptList);

		List<String> deptName = new ArrayList<>();

		for (NoticeTargetDto noticeDept : noticeDeptList) {
			for (Departments dept : deptList) {
				if (noticeDept.getDeptId() == dept.getDeptId()) {
					deptName.add(dept.getDeptName());
				}
			}
		}
		
		String deptNamestr = String.join(", ", deptName); // deptName 리스트를 쉼표로 구분된 문자열로 변환

		notice.setPrevNum(prevNext.getPrevNum());
		notice.setPrevTitle(prevNext.getPrevTitle());
		notice.setNextNum(prevNext.getNextNum());
		notice.setNextTitle(prevNext.getNextTitle());
		notice.setDeptId(notice.getDeptId());

		model.addAttribute("title", "공지사항");
		model.addAttribute("notice", notice);
		model.addAttribute("noticeFile", noticeFile);
		model.addAttribute("noticeDeptList", noticeDeptList);
		model.addAttribute("deptName", deptName);
		model.addAttribute("deptNamestr", deptNamestr);

		log.info(prevNext.getPrevNum() + "");
		log.info("Notice ID:" + notice.getNoticeId());
		log.info("Dept ID:" + notice.getDeptId());
		log.info("Dept Name:" + deptName);
		noticeService.updateHitCount(noticeId);
		return "empNotice/empNoticeDetail";
	}

	// 파일 다운로드
	@GetMapping("/attachDownload")
	public void attachDownload(int noticeFileId, HttpServletResponse response, Model model) throws Exception {
		log.info(noticeFileId + "rk");
		NoticeFileDto noticeFile = noticeService.selectAttachByNoticeId(noticeFileId);
		/* noticeService.selectAttachFiles(noticeId); */

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

}
