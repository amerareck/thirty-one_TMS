package com.oti.thirtyone.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
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

import com.oti.thirtyone.dto.EmployeesDto;
import com.oti.thirtyone.dto.JoinFormDto;
import com.oti.thirtyone.security.EmployeeDetailService;
import com.oti.thirtyone.security.EmployeeDetails;
import com.oti.thirtyone.service.ApprovalService;
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
	// DB에 정상적으로 데이터 삽입되기 전까지, 임시 데이터가 저장되어 있는 곳에 접근하기 위해 선언. 차후에 삭제요망.
	@Autowired
	ApprovalService approvalService;
	
	
	@RequestMapping("loginForm")
	public String loginForm() {
		return "employee/loginForm";
	}
	
	@GetMapping("empDetail")
	public String empDetail(Model model, Authentication authentication){
		EmployeeDetails userInfo = (EmployeeDetails) authentication.getPrincipal();
		EmployeesDto empDto = userInfo.getEmployee();
		String deptName = deptService.getDeptName(empDto.getDeptId());

		model.addAttribute("title", "정원석님의 정보 수정하기");
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
		String empId = authentication.getName();
		
		EmployeesDto empDto = new EmployeesDto();
		empDto.setEmpId(empId);
		if(formDto.getModifier() == 1) {
			empDto.setEmpEmail(formDto.getEmpEmail());
			empDto.setEmpPostal(formDto.getEmpPostal());
			empDto.setEmpAddress(formDto.getEmpAddress());
			empDto.setEmpDetailAddress(formDto.getEmpDetailAddress());
			empDto.setEmpTel(formDto.getEmpTel());				
			
			empService.updateEmpInfoByEmp(empDto);
			
		}else {				
			log.info(formDto.toString());
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
		}
		

		EmployeeDetails userDetails = (EmployeeDetails) empDetailService.loadUserByUsername(empId);
		authentication = 
				new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
		SecurityContextHolder.getContext().setAuthentication(authentication);
		
		if(formDto.getModifier() == 1)
			return "redirect:/emp/empDetail";
		else 
			return "redirect:/admin/empDetail";
	}
	
	@GetMapping("getUserInfo")
	public void getUserInfo(Authentication auth, HttpServletResponse res) {
		log.info("실행");
		
		String userId = auth.getName();
		EmployeesDto userData = empService.getEmpInfo(userId);
		
		JSONObject json = new JSONObject();
		json.put("empId", userId);
		json.put("empNumber", userData.getEmpNumber());
		json.put("empName", userData.getEmpName());
		json.put("empTel", userData.getEmpTel());
		json.put("empHiredate", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(userData.getEmpHiredate()));
		//부서 테이블이 완성되기 전까지, 임시 데이터에서 가져오겠습니다.
		//json.put("deptId", userData.getDeptId());
		//json.put("deptName", deptService.getDeptName(userData.getDeptId()));
		json.put("deptId", 111);
		json.put("deptName", approvalService.getDeptName(111));
		json.put("position", userData.getPosition());
		
		try(PrintWriter pw = res.getWriter()) {
			res.setContentType("application/json; charset=UTF-8");
			res.setCharacterEncoding("UTF-8");
			pw.println(json.toString());
			pw.flush();
		} catch(IOException ioe) {
			ioe.printStackTrace();
		}
	}
}
