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
import org.springframework.web.multipart.MultipartFile;

import com.oti.thirtyone.dto.Departments;
import com.oti.thirtyone.dto.EmployeesDto;
import com.oti.thirtyone.dto.NoticeDto;
import com.oti.thirtyone.dto.NoticeFileDto;
import com.oti.thirtyone.dto.NoticeFormDto;
import com.oti.thirtyone.dto.Pager;
import com.oti.thirtyone.security.EmployeeDetails;
import com.oti.thirtyone.service.DepartmentService;
import com.oti.thirtyone.service.NoticeService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/notice")
public class NoticeController {

	@Autowired
	NoticeService noticeService;

	@Autowired
	DepartmentService departmentService;

	// 공지사항 조회
	@GetMapping("/noticeList")
	public String noticeList(Model model, @RequestParam(defaultValue = "1") int pageNo, HttpSession session,
			NoticeDto noticeDto) {

		int totalRows = noticeService.countRows();

		if (totalRows == 0) {
			Pager pager = new Pager(10, 5, 0, pageNo);

		} else {

			Pager pager = new Pager(10, 5, totalRows, pageNo);
			session.setAttribute("pager", pager);

			List<NoticeDto> notice = noticeService.selectListPager(pager);
			log.info(notice.toString());

			model.addAttribute("title", "공지사항");
			model.addAttribute("notice", notice);
			model.addAttribute("noticeDto", noticeDto);

		}
		return "notice/noticeList";
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
			return "notice/noticeList";
	}

	// 공지사항 상세페이지
	@GetMapping("/noticeDetail")
	public String noticeDetail(Model model, int noticeId/*, NoticeFormDto noticeForm*/) {

		NoticeDto notice = noticeService.selectByNoticeId(noticeId);
		List<NoticeFileDto> noticeFile = noticeService.selectAttachFiles(noticeId);
		NoticeDto prevNext = noticeService.prevNext(noticeId);

		/*noticeService.insertNoticeTarget(notice);
		
		notice.setDeptId(noticeForm.getDeptId());*/
		notice.setPrevNum(prevNext.getPrevNum());
		notice.setPrevTitle(prevNext.getPrevTitle());
		notice.setNextNum(prevNext.getNextNum());
		notice.setNextTitle(prevNext.getNextTitle());
		notice.setDeptId(notice.getDeptId());

		model.addAttribute("title", "공지사항");
		model.addAttribute("notice", notice);
		model.addAttribute("noticeFile", noticeFile);

		log.info(prevNext.getPrevNum() + "");
		log.info("Notice ID:" + notice.getNoticeId());
		log.info("Dept ID:" + notice.getDeptId());
		noticeService.updateHitCount(noticeId);
		return "notice/noticeDetail";
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

	@GetMapping("/noticeWriteForm")
	public String noticeWriteForm(Model model/* , int deptId */) {

		/* String deptName = departmentService.getDeptName(deptId); */

		model.addAttribute("title", "공지사항 작성");
		/*
		 * model.addAttribute("deptName", deptName); model.addAttribute("deptId",
		 * deptId);
		 */
		return "notice/noticeWriteForm";
	}

	// 공지사항 작성
	@PostMapping("/noticeWrite")
	public ResponseEntity<String> noticeWrite(NoticeFormDto notice, Model model, Authentication authentication,
			NoticeDto noticeDto) throws Exception {
		NoticeDto dbNotice = new NoticeDto();
		List<Departments> deptList = departmentService.getDeptList();

		EmployeeDetails employeeDetails = (EmployeeDetails) authentication.getPrincipal();
		EmployeesDto employees = employeeDetails.getEmployee();

		dbNotice.setDeptId(notice.getDeptId());
		dbNotice.setEmpId(employees.getEmpId());
		dbNotice.setNoticeTitle(notice.getNoticeTitle());
		dbNotice.setNoticeContent(notice.getNoticeContent());
		dbNotice.setNoticeDate(notice.getNoticeDate());
		dbNotice.setNoticeImportant(notice.getNoticeImportant());
		dbNotice.setNoticeAllTarget(notice.getNoticeAllTarget());
		log.info(notice.toString());

		noticeService.noticeWrite(dbNotice);

		noticeDto.setNoticeId(dbNotice.getNoticeId());
		/*noticeService.insertNoticeTarget(noticeDto);*/
		
		if (notice.getDeptId() != null && notice.getDeptId().length > 0) {
			noticeService.insertNoticeTarget(noticeDto);
			noticeService.updateNoticeTarget(noticeDto);
		}

		MultipartFile[] files = notice.getAttachFile();
		for (MultipartFile mf : files) {
			if (!mf.isEmpty()) {
				NoticeFileDto dbFile = new NoticeFileDto();
				dbFile.setNoticeFileName(mf.getOriginalFilename());
				dbFile.setNoticeFileData(mf.getBytes());
				dbFile.setNoticeFileType(mf.getContentType());
				dbFile.setNoticeFileId(1);
				dbFile.setNoticeId(dbNotice.getNoticeId());
				log.info(dbFile.toString());
				noticeService.insertNoticeFile(dbFile);
			}
		}
		log.info(notice.toString());
		log.info("하이루");

		model.addAttribute("employees", employees);
		model.addAttribute("noticeDto", noticeDto);
		log.info("공지사항이 성공적으로 저장되었습니다.");
		log.info("deptId: " + Arrays.toString(notice.getDeptId()));

		return ResponseEntity.ok("OK");
	}

	@GetMapping("/updateNoticeForm")
	public String updateNoticeForm(int noticeId, Model model, NoticeFileDto noticeFie) {
		NoticeDto notice = noticeService.selectByNoticeId(noticeId);
		NoticeFileDto noticeFile = noticeService.selectAttachByNoticeId(noticeId);
		List<NoticeFileDto> noticeFiles = noticeService.selectAttachFiles(noticeId);

		model.addAttribute("notice", notice);
		model.addAttribute("noticeFile", noticeFile);
		model.addAttribute("noticeFiles", noticeFiles);

		return "notice/updateNoticeForm";
	}

	// 공지사항 수정
	@PostMapping("/updateNotice")
	public String updateNotice(NoticeFormDto notice) throws Exception {
		NoticeDto dbNotice = new NoticeDto();
		dbNotice.setNoticeId(notice.getNoticeId());
		dbNotice.setNoticeTitle(notice.getNoticeTitle());
		dbNotice.setNoticeContent(notice.getNoticeContent());
		dbNotice.setNoticeDate(notice.getNoticeDate());
		dbNotice.setNoticeImportant(notice.getNoticeImportant());
		dbNotice.setNoticeAllTarget(notice.getNoticeAllTarget());

		log.info(notice.toString());
		log.info(dbNotice.toString());

		noticeService.updateNotice(dbNotice);

		MultipartFile[] files = notice.getAttachFile();

		for (MultipartFile mf : files) {
			if (!mf.isEmpty()) {
				NoticeFileDto dbFile = new NoticeFileDto();
				dbFile.setNoticeFileName(mf.getOriginalFilename());
				dbFile.setNoticeFileData(mf.getBytes());
				dbFile.setNoticeFileType(mf.getContentType());
				dbFile.getNoticeFileId();
				dbFile.setNoticeId(dbNotice.getNoticeId());
				log.info(dbFile.toString());
				noticeService.updateNoticeFile(dbFile);
			}
		}
		log.info(notice.toString());
		log.info("마바사");
		return "redirect:/notice/noticeDetail?noticeId=" + notice.getNoticeId();
	}

	// 공지사항 삭제
	@GetMapping("/deleteNotice")
	public String deleteNotice(int noticeId, HttpSession session) {
		/*noticeService.deleteNoticeFile(noticeId);
		noticeService.deleteNotice(noticeId);*/
		noticeService.deactivateNoticeById(noticeId);

		Pager pager = (Pager) session.getAttribute("pager");
		int pageNo = pager.getPageNo();

		return "redirect:/notice/noticeList?pageNo=" + pageNo;
	}

	// 공지사항 수정에서 파일 삭제
	@PostMapping("/deleteFileFromDb")
	public ResponseEntity<NoticeFileDto> deleteFileFromDb(@RequestBody NoticeFileDto noticeFile) {
		noticeService.deleteFileFromDb(noticeFile);
		log.info(noticeFile + " ");
		return ResponseEntity.ok(noticeFile);
	}

	// 부서 모달
	@GetMapping("/deptList")
	public ResponseEntity<List<Departments>> deptList() {
		log.info("실행");
		List<Departments> deptList = departmentService.getDeptList();
		log.info(deptList + " ");
		return ResponseEntity.ok(deptList);
	}
}
