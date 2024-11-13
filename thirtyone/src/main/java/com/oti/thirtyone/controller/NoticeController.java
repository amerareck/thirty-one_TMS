package com.oti.thirtyone.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
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
@RequestMapping("/notice")
public class NoticeController {

	@Autowired
	NoticeService noticeService;

	@Autowired
	DepartmentService departmentService;

	// 공지사항 조회
	@GetMapping("/noticeList")
	@Secured("ROLE_ADMIN")
	public String noticeList(Model model, @RequestParam(defaultValue = "1") int pageNo, HttpSession session,
			NoticeDto noticeDto) {

		int totalRows = noticeService.countRows();

		if (totalRows == 0) {
			Pager pager = new Pager(10, 5, 0, pageNo);

		} else {

			Pager pager = new Pager(10, 5, totalRows, pageNo);
			session.setAttribute("pager", pager);

			List<NoticeDto> notice = noticeService.selectListPager(pager);
			
			
			model.addAttribute("selectedTitle", "notice");
			model.addAttribute("title", "공지사항");
			model.addAttribute("notice", notice);
			model.addAttribute("noticeDto", noticeDto);

		}
		return "notice/noticeList";
	}
	
	//부서별 공지사항
		/*@GetMapping("/searchNoticeByDeptId")
		public String searchNoticeByDeptId(Model model, Authentication authentication, int deptId,
				@RequestParam(defaultValue = "1") int pageNo, HttpSession session) {
			
			int totalRows = noticeService.searchDeptIdCountRows(deptId);

			Pager pager = new Pager(10, 5, totalRows, pageNo);
			model.addAttribute("pager", pager);
			
			EmployeeDetails employeeDetails = (EmployeeDetails) authentication.getPrincipal();
			EmployeesDto employees = employeeDetails.getEmployee();
			
			int deptIds = employees.getDeptId();
			
			List<NoticeDto> noticeList = noticeService.searchNoticeByDeptId(deptId, pager);
		    model.addAttribute("noticeList", noticeList); 
			
			List<Departments> deptList = departmentService.getDeptList();
			model.addAttribute("deptList", deptList);
			
			model.addAttribute("deptIds", deptIds);
			return "notice/searchNoticeByDeptId";
		}*/


	// 공지사항 검색
	@GetMapping("/searchNotice")
	@Secured("ROLE_ADMIN")
	public String searchNotice(Model model, @RequestParam(defaultValue = "1") int pageNo, HttpSession session,
			@RequestParam("noticeTitle") String noticeTitle, int deptId) {

		int totalRows = noticeService.searchCountRows(noticeTitle, deptId);

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
	@Secured("ROLE_ADMIN")
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

		model.addAttribute("selectedTitle", "notice");
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
	public String noticeWriteForm(Model model) {

		model.addAttribute("selectedTitle", "notice");
		model.addAttribute("title", "공지사항 작성");
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
		/* noticeService.insertNoticeTarget(noticeDto); */

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

		// 부서 목록 조회
		List<NoticeTargetDto> noticeDeptList = noticeService.selectDeptId(noticeId);
		List<Departments> deptList = departmentService.getDeptList();
		log.info("Notice Dept List: " + noticeDeptList);
		log.info("Dept List: " + deptList);

		// 부서 이름 리스트 생성
		List<String> deptName = new ArrayList<>();
		for (NoticeTargetDto noticeDept : noticeDeptList) {
			for (Departments dept : deptList) {
				if (noticeDept.getDeptId() == dept.getDeptId()) {
					deptName.add(dept.getDeptName());
				}
			}
		}

		//중요도 값
		int noticeImportant = notice.getNoticeImportant();

		model.addAttribute("notice", notice);

		model.addAttribute("deptName", deptName);

		model.addAttribute("noticeFile", noticeFile);
		model.addAttribute("noticeFiles", noticeFiles);
		model.addAttribute("noticeImportant", noticeImportant);
		model.addAttribute("deptList", deptList);

		return "notice/updateNoticeForm";
	}


	@ResponseBody
	@GetMapping("/updateNoticeByDb")
	public List<NoticeFileDto> updateNoticeByDb(int noticeId, Model model) {
		List<NoticeFileDto> noticeFiles = noticeService.selectAttachFiles(noticeId);
		for (NoticeFileDto noticeFileDto : noticeFiles) {
			log.info(noticeFileDto.getNoticeFileName());
			log.info(noticeFileDto.getNoticeId() + "");
		}
		model.addAttribute("noticeFiles", noticeFiles);
		return noticeFiles;
	}

	// 공지사항 수정
		@PostMapping("/updateNotice")
		public String updateNotice(Model model, NoticeFormDto notice) throws Exception {

			NoticeDto dbNotice = new NoticeDto();
			dbNotice.setNoticeId(notice.getNoticeId());
			dbNotice.setNoticeTitle(notice.getNoticeTitle());
			dbNotice.setNoticeContent(notice.getNoticeContent());
			dbNotice.setNoticeDate(notice.getNoticeDate());
			dbNotice.setNoticeImportant(notice.getNoticeImportant());
			dbNotice.setNoticeAllTarget(notice.getNoticeAllTarget());

			log.info(dbNotice.toString());

			noticeService.updateNotice(dbNotice);

			MultipartFile[] files = notice.getAttachFile();

			for (int fileId : notice.getDeleteFileId()) {
				log.info(" fileId = " + fileId);
				noticeService.deleteFileFromDb(fileId);
			}

			if (files != null) {
				for (MultipartFile mf : files) {
					NoticeFileDto dbFile = new NoticeFileDto();
//					if (!noticeService.hasNoticeFileId(dbFile.getNoticeFileId())) continue; //noticeFileId 가 없으면 밑에 구문을 실행시키지 않고 다음 index로 넘어간다.
					dbFile.setNoticeFileName(mf.getOriginalFilename());
					dbFile.setNoticeFileData(mf.getBytes());
					dbFile.setNoticeFileType(mf.getContentType());
					dbFile.getNoticeFileId();
					dbFile.setNoticeId(dbNotice.getNoticeId());
					noticeService.insertNoticeFile(dbFile); // db에 없으면 insert 있으면 노 insert
				}
			}
//			log.info(notice.toString());
			log.info("마바사");

			model.addAttribute("selectedTitle", "notice");
			return "redirect:/notice/noticeDetail?noticeId=" + notice.getNoticeId();
		}


	// 공지사항 삭제
	@GetMapping("/deleteNotice")
	public String deleteNotice(int noticeId, HttpSession session) {
		
		noticeService.deactivateNoticeById(noticeId);

		Pager pager = (Pager) session.getAttribute("pager");
		int pageNo = pager.getPageNo();

		return "redirect:/notice/noticeList?pageNo=" + pageNo;
	}

	// 공지사항 수정에서 파일 삭제
//	@PostMapping("/deleteFileFromDb")
//	public ResponseEntity<NoticeFileDto> deleteFileFromDb(@RequestBody NoticeFileDto noticeFile) {
//		noticeService.deleteFileFromDb(noticeFile);
//		log.info(noticeFile + " ");
//		return ResponseEntity.ok(noticeFile);
//	}

	// 부서 모달
	@GetMapping("/deptList")
	public ResponseEntity<List<Departments>> deptList() {
		log.info("실행");
		List<Departments> deptList = departmentService.getDeptList();
		log.info(deptList + " ");
		return ResponseEntity.ok(deptList);
	}
	
	
	
	
	//---------------------------------------------------
	
	
	
	
	// 공지사항 조회
		@GetMapping("/empNoticeList")
		public String empNoticeList(Model model, @RequestParam(defaultValue = "1") int pageNo, HttpSession session,
				NoticeDto noticeDto, Authentication authentication, String noticeTitle) {
			
			EmployeeDetails employeeDetails = (EmployeeDetails) authentication.getPrincipal();
			EmployeesDto employees = employeeDetails.getEmployee();

			int deptId = employees.getDeptId();
				
			int totalRows = noticeService.searchDeptIdCountRows(deptId);
			log.info(deptId + "");

			Pager pager = new Pager(10, 5, totalRows, pageNo);
			session.setAttribute("pager", pager);
			
			List<NoticeDto> notice = noticeService.searchNoticeByDeptId(noticeTitle, pager, deptId);
			
			log.info(notice.toString());
			model.addAttribute("selectedTitle", "notice");
			model.addAttribute("title", "공지사항");
			model.addAttribute("notice", notice);
			model.addAttribute("noticeDto", noticeDto);
			
			return "notice/empNoticeList";
		}

		// 공지사항 검색
		@GetMapping("/emp/searchNotice")
		public String empSearchNotice(Model model, @RequestParam(defaultValue = "1") int pageNo, HttpSession session,
				@RequestParam("noticeTitle") String noticeTitle, Authentication authentication) {
			
			EmployeeDetails employeeDetails = (EmployeeDetails) authentication.getPrincipal();
			int deptId = employeeDetails.getEmployee().getDeptId();

			int totalRows = noticeService.searchCountRows(noticeTitle, deptId);

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
			model.addAttribute("selectedTitle", "notice");
			model.addAttribute("noticeTitle", noticeTitle);
			log.info("Search Title: " + noticeTitle);
			return "notice/empNoticeList";
		}

		// 공지사항 상세페이지
		@GetMapping("/empNoticeDetail")
		public String empNoticeDetail(Model model, int noticeId, Authentication authentication) {
			
			EmployeeDetails employeeDetails = (EmployeeDetails) authentication.getPrincipal();
			int deptId = employeeDetails.getEmployee().getDeptId();

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

			model.addAttribute("selectedTitle", "notice");
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
			return "notice/empNoticeDetail";
		}
	}
