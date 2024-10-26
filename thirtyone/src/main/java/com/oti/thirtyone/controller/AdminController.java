package com.oti.thirtyone.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.oti.thirtyone.dto.EmployeesDto;
import com.oti.thirtyone.dto.JoinFormDto;
import com.oti.thirtyone.service.EmployeesService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	EmployeesService empService;
	
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
		empDto.setEmpPassword(passwordEncoder.encode("2024001"));
		
		// 추가로 변경해야 함 (로직 적으로)
		empDto.setEmpNumber(2024001);
		log.info("asd");
		empService.joinEmp(empDto);
		
		return "admin/searchList";
	}
	
	@GetMapping("/searchList")
	public String searchList(Model model) {
		model.addAttribute("selectedTitle", "adminEmp");
		model.addAttribute("selectedSub", "searchList");
		model.addAttribute("title", "직원관리");
		return "admin/searchList";
	}
	
	@GetMapping("/empDetail")
	public String empDetail(Model model) {
		model.addAttribute("title", "정원석님의 정보 수정하기");
		model.addAttribute("selectedTitle", "adminEmp");
		model.addAttribute("selectedSub", "empDetail");
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
	public String getOrgChartPage(Model model) {
		log.info("실행");
		
		model.addAttribute("title", "조직도");
		model.addAttribute("selectedTitle", "org");
		model.addAttribute("selectedSub", "organization");
		model.addAttribute("activePage","orgChart");
		
		return "admin/org/orgChartManagement";
	}
	
	@GetMapping("/position")
	public String getPositionPage(Model model) {
		log.info("실행");
		
		model.addAttribute("title", "조직도");
		model.addAttribute("selectedTitle", "org");
		model.addAttribute("selectedSub", "organization");
		model.addAttribute("activePage","position");
		
		return "admin/org/orgPosition";
	}
	
	@GetMapping("/employee")
	public String getEmployeePage(Model model) {
		log.info("실행");
		
		model.addAttribute("title", "조직도");
		model.addAttribute("selectedTitle", "org");
		model.addAttribute("selectedSub", "organization");
		model.addAttribute("activePage","employee");
		
		return "admin/org/orgEmployee";
	}
}
