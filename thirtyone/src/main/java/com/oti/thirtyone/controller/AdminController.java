package com.oti.thirtyone.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.oti.thirtyone.dto.Departments;
import com.oti.thirtyone.dto.EmployeesDto;
import com.oti.thirtyone.dto.JoinFormDto;
import com.oti.thirtyone.dto.Pager;
import com.oti.thirtyone.dto.PositionsDto;
import com.oti.thirtyone.service.DepartmentService;
import com.oti.thirtyone.service.EmployeesService;
import com.oti.thirtyone.service.PositionService;

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
	
	@ModelAttribute
	public void settings(Model model) {
		model.addAttribute("admin", true);
	}
	
	@GetMapping("")
	public String adminMain(Model model) {
		model.addAttribute("selectedTitle", "home");
		return "admin/admin";	
	}
	
	@GetMapping("/joinForm")
	public String joinForm(Model model){
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
			empDto.setEmpImageData(profileImg.getBytes());
			empDto.setEmpImageName(profileImg.getOriginalFilename());
			empDto.setEmpImageType(profileImg.getContentType());
		}
		
		PasswordEncoder passwordEncoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
		empDto.setEmpPassword(passwordEncoder.encode("admin1234"));
		
		// 추가로 변경해야 함 (로직 적으로)
		empDto.setEmpNumber(2024000);
		log.info("asd");
		empService.joinEmp(empDto);
		
		return "admin/searchList";
	}
	
	@GetMapping("/searchList")
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
		
		return "admin/searchList";
	}
	
	@GetMapping("/searchEmp")
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
		return "admin/searchList";
	}
	
	@GetMapping("/empDetail")
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
	public String atdList(Model model) {
		model.addAttribute("title", "근태 관리");
		model.addAttribute("selectedTitle", "adminEmp");
		model.addAttribute("selectedSub", "atdList");
		return "admin/atdList";
	}
	
	@GetMapping("/org")
	public String getOrgChartPage(Model model, @RequestParam(defaultValue = "1") int pageNo, HttpSession session) {
		int totalRows = empService.countRows();
		Pager pager = new Pager(10, 5, totalRows, pageNo);
		session.setAttribute("pager", pager);
		List<Departments> deptList = deptService.getDeptListByRegion(pager);

		model.addAttribute("deptList", deptList);
		model.addAttribute("title", "조직도");
		model.addAttribute("selectedTitle", "org");
		model.addAttribute("selectedSub", "organization");
		model.addAttribute("activePage","orgChart");
		
		return "admin/org/orgChartManagement";
	}
	
	@GetMapping("/position")
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
		posService.chagePosName(posClass, posName, prePosName);
		return ResponseEntity.ok("OK");
	}
	
	@GetMapping("/employee")
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
		
		model.addAttribute("empDeptList", empDeptList);
		model.addAttribute("title", "조직도");
		model.addAttribute("selectedTitle", "org");
		model.addAttribute("selectedSub", "organization");
		model.addAttribute("activePage","employee");
		
		return "admin/org/orgEmployee";
	}
}
