package com.oti.thirtyone.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.oti.thirtyone.dto.EmployeesDto;
import com.oti.thirtyone.security.EmployeeDetailService;
import com.oti.thirtyone.security.EmployeeDetails;
import com.oti.thirtyone.service.EmployeesService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/emp")
@Slf4j
public class EmployeeController {
	
	@Autowired
	EmployeesService empService;
	@Autowired
	EmployeeDetailService empDetailService;
	
	@RequestMapping("loginForm")
	public String loginForm() {
		return "employee/loginForm";
	}
	
	@GetMapping("empDetail")
	public String empDetail(Model model){		
		model.addAttribute("title", "정원석님의 정보 수정하기");
		
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
	@ResponseBody
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
}
