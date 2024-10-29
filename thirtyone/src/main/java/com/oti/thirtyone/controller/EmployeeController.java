package com.oti.thirtyone.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.oti.thirtyone.dto.Departments;
import com.oti.thirtyone.dto.EmployeesDto;
import com.oti.thirtyone.dto.JoinFormDto;
import com.oti.thirtyone.dto.PositionsDto;
import com.oti.thirtyone.security.EmployeeDetailService;
import com.oti.thirtyone.security.EmployeeDetails;
import com.oti.thirtyone.service.DepartmentService;
import com.oti.thirtyone.service.EmployeesService;
import com.oti.thirtyone.service.PositionService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/emp")
@Slf4j
public class EmployeeController {
	
	@Autowired
	EmployeesService empService;
	@Autowired
	EmployeeDetailService empDetailService;
	@Autowired
	DepartmentService deptService;
	@Autowired
	PositionService posService;
	
	
	@RequestMapping("loginForm")
	public String loginForm() {
		return "employee/loginForm";
	}
	
	@GetMapping("empDetail")
	public String empDetail(Model model, Authentication authentication){
		EmployeeDetails userInfo = (EmployeeDetails) authentication.getPrincipal();
		EmployeesDto empDto = userInfo.getEmployee();
		String deptName = deptService.getDeptName(empDto.getDeptId());

		model.addAttribute("title", empDto.getEmpName() + "님의 정보 수정하기");
		model.addAttribute("empInfo", empDto);
		model.addAttribute("deptName", deptName);
		
		return "employee/empDetail";
	}
	
	@GetMapping("empPwUpdate")
	public String empPwUpdate() {
		
		return "employee/empPwUpdate";
	}
	
	@PostMapping("idCheck")
	public ResponseEntity<Boolean> idCheck(String empId){
		log.info("empId " + empId);
		boolean result = empService.hasEmpId(empId);
		
		return ResponseEntity.ok(result);
	}
	
	@PostMapping("pwCheck")
	public ResponseEntity<Boolean> pwCheck(String empPassword, Authentication authentication){
		EmployeeDetails userInfo = (EmployeeDetails) authentication.getPrincipal();
		EmployeesDto userDto = userInfo.getEmployee();
		
		String encodePw = userDto.getEmpPassword();
		PasswordEncoder passwordEncoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
	    if(passwordEncoder.matches(empPassword, encodePw)) {
	    	return ResponseEntity.ok(true);
	    }else {
	    	return ResponseEntity.ok(false);
	    }
	}
	
	@PostMapping("updatePw")
	public void updatePw(String empPassword, Authentication authentication) {
		log.info(empPassword + " ");
		String empId = authentication.getName();
				
		PasswordEncoder passwordEncoder = 
				PasswordEncoderFactories.createDelegatingPasswordEncoder();
		String password = passwordEncoder.encode(empPassword);
		empService.updateEmpPw(empId, password);
		

		//사용자 상세 정보 얻기
		EmployeeDetails userDetails = (EmployeeDetails) empDetailService.loadUserByUsername(empId);
		//인증 객체 얻기
		authentication = 
				new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
		//스프링 시큐리티에 인증 객체 설정
		SecurityContextHolder.getContext().setAuthentication(authentication);
	}
	
	@PostMapping("updateEmp")
	public String updateEmp(JoinFormDto formDto, Authentication authentication) throws IOException {

		
		EmployeesDto empDto = new EmployeesDto();
		String empId = "";
		if(formDto.getModifier() == 1) {
			empId = authentication.getName();
			empDto.setEmpId(empId);
			empDto.setEmpEmail(formDto.getEmpEmail());
			empDto.setEmpPostal(formDto.getEmpPostal());
			empDto.setEmpAddress(formDto.getEmpAddress());
			empDto.setEmpDetailAddress(formDto.getEmpDetailAddress());
			empDto.setEmpTel(formDto.getEmpTel());				
			
			empService.updateEmpInfoByEmp(empDto);
			
			EmployeeDetails userDetails = (EmployeeDetails) empDetailService.loadUserByUsername(empId);
			authentication = 
					new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
			SecurityContextHolder.getContext().setAuthentication(authentication);

			return "redirect:/emp/empDetail";
		}else {				
			
			empId = formDto.getEmpId();
			empDto.setEmpId(empId);
			empDto.setEmpName(formDto.getEmpName());
			empDto.setDeptId(formDto.getDeptId());
			empDto.setPosition(formDto.getPosition());
			empDto.setEmpMemo(formDto.getEmpMemo());
			empDto.setEmpState(formDto.getEmpState());
			MultipartFile profileImg = formDto.getEmpImage();
			
			if(profileImg != null) {
				empDto.setEmpImageData(profileImg.getBytes());
				empDto.setEmpImageName(profileImg.getOriginalFilename());
				empDto.setEmpImageType(profileImg.getContentType());
			}

			empService.updateEmpInfoByAdmin(empDto);
			return "redirect:/admin/empDetail?empId="+empId;
		}

	}
}
