package com.oti.thirtyone.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.oti.thirtyone.dto.EmpApprovalLineDTO;
import com.oti.thirtyone.dto.EmployeesDto;
import com.oti.thirtyone.dto.JoinFormDto;
import com.oti.thirtyone.dto.PositionsDto;
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
		json.put("deptId", userData.getDeptId());
		json.put("deptName", deptService.getDeptName(userData.getDeptId()));
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
	
	@GetMapping("getEmpNumber")
	public ResponseEntity<List<EmployeesDto>> getEmpNumber(String empName){
		List<EmployeesDto> numberList = empService.getEmpInfoByName(empName);
		
		return ResponseEntity.ok(numberList);
	}
	
	@PostMapping("setApprovalLine")
	public void setApprovalLineToEmp(
			@RequestBody List<EmpApprovalLineDTO> aplForm, 
			Authentication auth, 
			HttpServletResponse res) throws IOException {
		log.info("실행");
		
		// List 요소들을 검증해야 하는데, 검증 방법을 아직 모르므로... (애매함) 직접 수행.
		Set<String> names = new HashSet<>();
		JSONObject errors = new JSONObject();
		aplForm.forEach(item -> item.setEmpId(auth.getName()));
		boolean isError = false;
		
		for(EmpApprovalLineDTO form : aplForm) {
			if(!names.add(form.getAprLineApprover())) {
				errors.put("errors", true);
				errors.put("duplication", "결재자는 중복될 수 없습니다.");
				isError = true;
				break;
			}
		}
		
		if (!isError) {
			List<PositionsDto> posList = posService.getPosList();
			aplForm.forEach(item -> {
			    item.setAplLineApproverDTO(empService.getEmpInfo(item.getAprLineApprover()));
			    posList.forEach(elem -> {
			        if (item.getAplLineApproverDTO() != null && 
			            elem.getPosition().equals(item.getAplLineApproverDTO().getPosition())) {
			            item.setPositionDTO(elem);
			        }
			    });
			});

			for(int i=1; i<aplForm.size(); i++) {
				if(!aplForm.get(i).getPositionDTO()
						.isCompareRankForHigherEquels(aplForm.get(i-1).getPositionDTO())) {
					errors.put("errors", true);
					errors.put("seqError", "낮은 직급은 후순위 결재자가 될 수 없습니다.");
					isError = true;
					break;
				}
			}
		}
		
		if(isError) {
			PrintWriter pw = res.getWriter();
			res.setContentType("application/json; charset=UTF-8");
			res.setCharacterEncoding("UTF-8");
			pw.println(errors.toString());
			pw.flush();
			pw.close();
			return;
		}
		
		if(aplForm.get(0).getHandler().equals("save")) {
			empService.setApprovalLine(aplForm);
		} else {
			empService.updateApprovalLine(aplForm);
		}
		
		JSONObject json = new JSONObject();
		json.put("status", "ok");
		PrintWriter pw = res.getWriter();
		res.setContentType("application/json; charset=UTF-8");
		res.setCharacterEncoding("UTF-8");
		pw.println(json.toString());
		pw.flush();
		pw.close();
	}
	
	@GetMapping(value="getEmpApprovalLine", produces = "application/json; charset=UTF-8")
	public void getEmpApprovalLine(EmpApprovalLineDTO dto, Authentication auth, HttpServletResponse res) {
		log.info("실행");
		
		dto.setEmpId(auth.getName());
		List<EmpApprovalLineDTO> list = empService.getApprovalLineListByIndex(dto);
		list.forEach(item -> {
			EmployeesDto approverInfo = empService.getEmpInfo(item.getAprLineApprover());
			item.setApproverDeptId(approverInfo.getDeptId());
			item.setEmpName(approverInfo.getEmpName());
			item.setPosition(approverInfo.getPosition());
		});
		
		JSONObject json = new JSONObject();
		json.put("list", list);
		try(PrintWriter pw = res.getWriter()) {
			res.setContentType("application/json; charset=UTF-8");
			res.setCharacterEncoding("UTF-8");
			pw.println(json.toString());
			pw.flush();
		} catch(IOException ioex) {
			ioex.printStackTrace();
		}
	}
	
	@PostMapping("deleteEmpApl")
	public void deleteEmpApprovalLine(EmpApprovalLineDTO dto, Authentication auth, HttpServletResponse res) {
		log.info("실행");
		
		dto.setEmpId(auth.getName());
		empService.removeEmpApprovalLine(dto);
		
		JSONObject json = new JSONObject();
		json.put("status", "ok");
		res.setContentType("application/json; charset=UTF-8");
		res.setCharacterEncoding("UTF-8");
		
		try(PrintWriter pw = res.getWriter()) {
			pw.println(json.toString());
			pw.flush();
		} catch(IOException ioex) {
			ioex.printStackTrace();
		}
	}
	
	@GetMapping("getAllEmpApprovalLine")
	public void getAllEmpApprovalLine(Authentication auth, HttpServletResponse res) {
		log.info("실행");
		
		JSONObject json = new JSONObject();
		int count = empService.getApprovalLineCount(auth.getName());
		Map<String, List<EmpApprovalLineDTO>> result = new HashMap<>();
		List<String> aprLineNames = empService.getApprovalLineNames(auth.getName());
		json.put("aprLineNames", aprLineNames);
		for(int i=0; i<count; i++) {
			List<EmpApprovalLineDTO> list = empService.getApprovalLineListByUserId(auth.getName(), aprLineNames.get(i));
			list.forEach(item -> {
				EmployeesDto approver = empService.getEmpInfo(item.getAprLineApprover());
				item.setEmpName(approver.getEmpName());
				item.setPosition(approver.getPosition());
				item.setApproverDeptId(approver.getDeptId());
				item.setApproverDeptName(deptService.getDeptName(approver.getDeptId()));
			});
			result.put(aprLineNames.get(i), list);
		}
		
		json.put("empAPL", result);
		res.setContentType("application/json; charset=UTF-8");
		res.setCharacterEncoding("UTF-8");
		
		try(PrintWriter pw = res.getWriter()) {
			pw.println(json.toString());
			pw.flush();
		} catch(IOException ioex) {
			ioex.printStackTrace();
		}
	}
	
	@GetMapping("getAprIndex")
	public void getAprIndex(EmpApprovalLineDTO dto, Authentication auth, HttpServletResponse res) {
		log.info("실행");
		dto.setEmpId(auth.getName());
		
		JSONObject json = new JSONObject();
		json.put("aprIndex", empService.getApprovalLineIndexByName(dto).getAprLineIndex());
		res.setContentType("application/json; charset=UTF-8");
		res.setCharacterEncoding("UTF-8");
		
		try(PrintWriter pw = res.getWriter()) {
			pw.println(json.toString());
			pw.flush();
		} catch(IOException ioex) {
			ioex.printStackTrace();
		}
	}
}
