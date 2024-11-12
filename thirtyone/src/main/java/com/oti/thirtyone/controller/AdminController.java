package com.oti.thirtyone.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.oti.thirtyone.dto.AttendanceDto;
import com.oti.thirtyone.dto.Departments;
import com.oti.thirtyone.dto.DocFilesDTO;
import com.oti.thirtyone.dto.EmployeesDto;
import com.oti.thirtyone.dto.JoinFormDto;
import com.oti.thirtyone.dto.Pager;
import com.oti.thirtyone.dto.PositionsDto;
import com.oti.thirtyone.dto.ReasonDto;
import com.oti.thirtyone.service.AttendanceService;
import com.oti.thirtyone.service.DepartmentService;
import com.oti.thirtyone.service.EmployeesService;
import com.oti.thirtyone.service.PositionService;
import com.oti.thirtyone.service.ReasonService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	EmployeesService empService;
	@Autowired
	DepartmentService deptService;
	@Autowired
	PositionService posService;
	@Autowired
	ReasonService reasonService;
	@Autowired
	AttendanceService atdSErvice;
	
	@ModelAttribute
	public void settings(Model model) {
		model.addAttribute("admin", true);
	}
	
	@GetMapping("")
	@Secured("ROLE_ADMIN")
	public String adminMain(Model model) {
		List<Map<String, Object>> empInfoList = new LinkedList<>();
		List<EmployeesDto> empList = empService.getEmpInfoHead();
		
		for(EmployeesDto emp : empList) {
			Map<String, Object> empInfo = new HashMap<>();
			empInfo.put("emp", emp);
			empInfo.put("deptName", deptService.getDeptName(emp.getDeptId()));
			empInfoList.add(empInfo);
		}
		List<ReasonDto> reasonList = reasonService.getLatestReason();
		List<Map<String, Object>> reasonInfoList = new LinkedList<>();
		for(ReasonDto reason : reasonList) {
			Map<String, Object> reasonInfo = new HashMap<>();
			EmployeesDto emp = empService.getEmpInfo(reason.getEmpId());
			String deptName = deptService.getDeptName(emp.getDeptId());
			reasonInfo.put("reason", reason);
			reasonInfo.put("emp", emp);
			reasonInfo.put("deptName", deptName);
			reasonInfoList.add(reasonInfo);
		}
		
		model.addAttribute("reasonInfoList", reasonInfoList);
		model.addAttribute("empInfoList", empInfoList);
		model.addAttribute("selectedTitle", "home");
		return "admin/admin";	
	}
	
	@GetMapping("/joinForm")
	@Secured("ROLE_ADMIN")
	public String joinForm(Model model){
		List<Departments> deptList = deptService.getDepartmentList();
		
		model.addAttribute("deptList", deptList);
		model.addAttribute("selectedTitle", "adminEmp");
		model.addAttribute("selectedSub", "adminCreate");
		return "admin/joinForm";
	}
	
	@PostMapping("/join")
	public String empJoin(JoinFormDto formDto ) throws IOException{
		EmployeesDto empDto = new EmployeesDto();
		empDto.setEmpId(formDto.getEmpId());
		empDto.setEmpName(formDto.getEmpName());
		empDto.setEmpEmail(formDto.getEmpEmail());
		empDto.setEmpGender(formDto.getEmpGender());
		empDto.setEmpBirth(formDto.getEmpBirth());
		empDto.setEmpPostal(formDto.getEmpPostal());
		empDto.setEmpAddress(formDto.getEmpAddress());
		empDto.setEmpDetailAddress(formDto.getEmpDetailAddress());
		empDto.setEmpTel(formDto.getEmpTel());
		empDto.setDeptId(formDto.getDeptId());
		empDto.setPosition(formDto.getPosition());
		
		MultipartFile profileImg = formDto.getEmpImage();
		
		if(profileImg != null) {
			log.info("asd");
			empDto.setEmpImageData(profileImg.getBytes());
			empDto.setEmpImageName(profileImg.getOriginalFilename());
			empDto.setEmpImageType(profileImg.getContentType());
		}
		
		PasswordEncoder passwordEncoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
		int empNumber = empService.getNewEmpNumber();
		empDto.setEmpNumber(empNumber);
		empDto.setEmpPassword(passwordEncoder.encode(String.valueOf(empNumber)));
		log.info(""+empDto.getEmpNumber());
		empService.joinEmp(empDto);
		
		return "redirect: searchList";
	}
	
	@GetMapping("/searchList")
	@Secured("ROLE_ADMIN")
	public String searchList(Model model, @RequestParam(defaultValue = "1") int pageNo, HttpSession session) {
		
		int totalRows = empService.countRows();
		Pager pager = new Pager(10, 5, totalRows, pageNo);
		session.setAttribute("pager", pager);
		List<EmployeesDto> empList = empService.selectEmpList(pager);
		List<Map<String, Object>> empDeptList = new LinkedList<>();

		for(EmployeesDto empDto : empList) {
			Map<String, Object> empDept = new HashMap<>();
			empDept.put("empInfo", empDto);
			String deptName = deptService.getDeptName(empDto.getDeptId());
			empDept.put("deptName", deptName);
			empDeptList.add(empDept);
		}

		model.addAttribute("total", totalRows);
		model.addAttribute("empDeptList", empDeptList);
		model.addAttribute("selectedTitle", "adminEmp");
		model.addAttribute("selectedSub", "searchList");
		model.addAttribute("title", "직원관리");

		model.addAttribute("isSearch", false);
		return "admin/searchList";
	}
	
	@GetMapping("/searchEmp")
	@Secured("ROLE_ADMIN")
	public String searchList(Model model, String query, int category,
			 	@RequestParam(defaultValue = "1") int pageNo, HttpSession session){
		int totalRows = empService.countRowsBySearch(query, category);
		Pager pager = new Pager(10, 5, totalRows, pageNo);
		session.setAttribute("pager", pager);
		List<EmployeesDto> empList = empService.getEmpListBySearch(query, category, pager);
		List<Map<String, Object>> empDeptList = new LinkedList<>();
		
		for(EmployeesDto empDto : empList) {
			Map<String, Object> empDept = new HashMap<>();
			empDept.put("empInfo", empDto);
			String deptName = deptService.getDeptName(empDto.getDeptId());
			empDept.put("deptName", deptName);
			empDeptList.add(empDept);
		}
		
		model.addAttribute("total", totalRows);
		model.addAttribute("empDeptList", empDeptList);
		model.addAttribute("selectedTitle", "adminEmp");
		model.addAttribute("selectedSub", "searchList");
		model.addAttribute("title", "직원관리");
		model.addAttribute("query", query);
		model.addAttribute("category", category);
		model.addAttribute("isSearch", true);
		return "admin/searchList";
	}
	
	@GetMapping("/empDetail")
	@Secured("ROLE_ADMIN")
	public String empDetail(Model model, String empId) {
		log.info("asdasfasf:   " + empId);
		EmployeesDto empDto = empService.getEmpInfo(empId);
		String deptName = deptService.getDeptName(empDto.getDeptId());
		
		List<Departments> deptList = deptService.getDeptList();
		List<PositionsDto> positionList = posService.getPosList();
		
		String[] stateList = {"재직", "휴직", "퇴직"}; //ENUM으로 변경 예정
		
		model.addAttribute("stateList", stateList);
		model.addAttribute("posList", positionList);
		model.addAttribute("deptList", deptList);
		model.addAttribute("deptName", deptName);
		model.addAttribute("empInfo", empDto);
		model.addAttribute("title", empDto.getEmpName() + "님의 정보 수정하기");
		model.addAttribute("selectedTitle", "adminEmp");
		model.addAttribute("selectedSub", "searchList");
		
		return "admin/empDetail";
	}
	
	@GetMapping("atdList")
	@Secured("ROLE_ADMIN")
	public String atdList(Model model, @RequestParam(defaultValue = "1") int pageNo, HttpSession session) {
		int totalRows = reasonService.countRows();
		Pager pager = new Pager(10, 5, totalRows, pageNo);
		log.info(pager.toString());
		session.setAttribute("pager", pager);
		
		List<ReasonDto> reasonList = reasonService.getReasonList(pager);
		List<Map<String, Object>> reasonInfoList = new LinkedList<>();
		
		for(ReasonDto reason : reasonList) {
			Map<String, Object> tempInfo = new HashMap<>();
			
			String empId = reason.getEmpId();
			EmployeesDto empDto = empService.getEmpInfo(empId);
			String deptName = deptService.getDeptName(empDto.getDeptId());
			AttendanceDto atdDto = atdSErvice.getAtdInfoOneDay(empId, reason.getAtdDate());
			
			List<DocFilesDTO> fileList = reasonService.getReasonFileList(reason.getReasonId());
			
			
			tempInfo.put("fileList", fileList);
			tempInfo.put("reason", reason);
			tempInfo.put("emp", empDto);
			tempInfo.put("deptName", deptName);
			tempInfo.put("atd", atdDto);
			reasonInfoList.add(tempInfo);
			
		}
		
		model.addAttribute("reasonList", reasonInfoList);
		model.addAttribute("pager", pager);
		model.addAttribute("title", "근태 관리");
		model.addAttribute("selectedTitle", "adminEmp");
		model.addAttribute("selectedSub", "atdList");
		return "admin/atdList";
	}
	
	@GetMapping("/org")
	@Secured("ROLE_ADMIN")
	public String getOrgChartPage(Model model, @RequestParam(defaultValue = "1") int pageNo, HttpSession session) {
		int totalRows = deptService.countRows();
		Pager pager = new Pager(10, 5, totalRows, pageNo);
		session.setAttribute("pager", pager);
		List<Departments> deptList = deptService.getDeptListByRegion(pager);
		List<Map<String, Object>> deptMapList = new LinkedList<>();
		
		for(Departments dept: deptList) {
			Map<String, Object> deptInfoList = new HashMap<>();
			String empName = empService.getEmpInfo(dept.getEmpId()).getEmpName();
			deptInfoList.put("dept", dept);
			deptInfoList.put("headName", empName);
			deptMapList.add(deptInfoList);
		}
		
		model.addAttribute("pager", pager);
		model.addAttribute("deptList", deptMapList);
		model.addAttribute("title", "조직도");
		model.addAttribute("selectedTitle", "org");
		model.addAttribute("selectedSub", "organization");
		model.addAttribute("activePage","orgChart");
		
		return "admin/org/orgChartManagement";
	}
	
	@GetMapping("/position")
	@Secured("ROLE_ADMIN")
	public String getPositionPage(Model model) {
		List<PositionsDto> posList = posService.getPosList();

		model.addAttribute("posList", posList);
		model.addAttribute("title", "조직도");
		model.addAttribute("selectedTitle", "org");
		model.addAttribute("selectedSub", "organization");
		model.addAttribute("activePage","position");
		
		return "admin/org/orgPosition";
	}
	
	@PostMapping("/createPos")
	public ResponseEntity<String> createPos(String pos){
		posService.createPos(pos);
		return ResponseEntity.ok("OK");
	}
	
	@GetMapping("/moveUpPos")
	public ResponseEntity<String> moveUpPos(int posClass){
		if(posClass == 1) return ResponseEntity.ok("OK");
		int prePosClass = posClass - 1;
		posService.moveUpPos(posClass, prePosClass);
		
		return ResponseEntity.ok("OK");
	}
	
	@GetMapping("/moveDownPos")
	public ResponseEntity<String> moveDownPos(int posClass){
		if(posClass == 1) return ResponseEntity.ok("OK");
		int afterPosClass = posClass + 1;
		posService.moveUpPos(afterPosClass, posClass);
		
		return ResponseEntity.ok("OK");
	}
	
	@PostMapping("/changePosName")
	public ResponseEntity<String> changePosName(int posClass, String posName){
		String prePosName = posService.getPosName(posClass);
		log.info("posClass : " + posClass + " posName : " + posName + " prePosName : " + prePosName);
		posService.chagePosName(posClass, posName, prePosName);
		return ResponseEntity.ok("OK");
	}
	
	@GetMapping("/employee")
	@Secured("ROLE_ADMIN")
	public String getEmployeePage(Model model, @RequestParam(defaultValue = "1") int pageNo, HttpSession session) {

		int totalRows = empService.countRows();
		Pager pager = new Pager(10, 5, totalRows, pageNo);
		session.setAttribute("pager", pager);
		
		List<EmployeesDto> empList = empService.selectEmpList(pager);
		List<Map<String, Object>> empDeptList = new LinkedList<>();

		for(EmployeesDto empDto : empList) {
			Map<String, Object> empDept = new HashMap<>();
			empDept.put("empInfo", empDto);
			String deptName = deptService.getDeptName(empDto.getDeptId());
			empDept.put("deptName", deptName);
			empDeptList.add(empDept);
		}
		List<Departments> deptList = deptService.getDeptList();
		
		model.addAttribute("deptList", deptList);
		model.addAttribute("empDeptList", empDeptList);
		model.addAttribute("title", "조직도");
		model.addAttribute("selectedTitle", "org");
		model.addAttribute("selectedSub", "organization");
		model.addAttribute("activePage","employee");
		model.addAttribute("isSearch", false);
		return "admin/org/orgEmployee";
	}
	
	@PostMapping("/changeEmpDept")
	public ResponseEntity<String> changeEmpDept(@RequestBody Map<String, Object> data){
		List<String> empIdList = (List<String>) data.get("empList");
		empService.updateEmpDept(empIdList,  Integer.parseInt((String) data.get("deptId")));
		
		return ResponseEntity.ok("OK");
	}
	
	@GetMapping("/searchDeptEmp")
	@Secured("ROLE_ADMIN")
	public String searchEmpListByDept(Model model, String query, int category,
			 	@RequestParam(defaultValue = "1") int pageNo, HttpSession session){
		int totalRows = empService.countRowsBySearch(query, category);
		Pager pager = new Pager(10, 5, totalRows, pageNo);
		session.setAttribute("pager", pager);
		List<EmployeesDto> empList = empService.getEmpListBySearch(query, category, pager);
		List<Map<String, Object>> empDeptList = new LinkedList<>();
		
		for(EmployeesDto empDto : empList) {
			Map<String, Object> empDept = new HashMap<>();
			empDept.put("empInfo", empDto);
			String deptName = deptService.getDeptName(empDto.getDeptId());
			empDept.put("deptName", deptName);
			empDeptList.add(empDept);
		}
		
		model.addAttribute("total", totalRows);
		model.addAttribute("empDeptList", empDeptList);
		model.addAttribute("title", "조직도");
		model.addAttribute("selectedTitle", "org");
		model.addAttribute("selectedSub", "organization");
		model.addAttribute("activePage","employee");
		model.addAttribute("query", query);
		model.addAttribute("category", category);
		model.addAttribute("isSearch", true);
		return "admin/org/orgEmployee";
	}
	
	@GetMapping("/imageDown")
	public void imageDown(String empId,
					HttpServletResponse response) throws Exception{
		EmployeesDto empDto = empService.getEmpInfo(empId);
		
		if(empDto.getEmpImageName() != null) {
			
			String contentType = empDto.getEmpImageType();
			response.setContentType(contentType);		
			
			OutputStream out = response.getOutputStream();
			out.write(empDto.getEmpImageData());
			out.flush();
			out.close();
		}
	}
	
	@GetMapping("/empAtdStatus")
	@ResponseBody
	public Map<String, int[]> empAtdStatus() {
		return empService.getEmpAtdStatus();
	}
}
