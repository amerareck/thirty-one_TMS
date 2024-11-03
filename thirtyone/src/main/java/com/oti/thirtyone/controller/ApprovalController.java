package com.oti.thirtyone.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.json.JSONArray;
import org.json.JSONObject;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oti.thirtyone.dto.ApprovalDTO;
import com.oti.thirtyone.dto.DocumentApprovalLineDTO;
import com.oti.thirtyone.dto.DocumentReferenceDTO;
import com.oti.thirtyone.dto.Departments;
import com.oti.thirtyone.dto.DocFilesDTO;
import com.oti.thirtyone.dto.DraftForm;
import com.oti.thirtyone.dto.EmpApprovalLineDTO;
import com.oti.thirtyone.dto.EmployeesDto;
import com.oti.thirtyone.dto.PageParam;
import com.oti.thirtyone.service.ApprovalService;
import com.oti.thirtyone.service.DepartmentService;
import com.oti.thirtyone.service.EmployeesService;
import com.oti.thirtyone.validator.DraftValidator;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/approval")
public class ApprovalController {
	
	@Autowired
    private ServletContext servletContext;
	@Autowired
	private DepartmentService deptService;
	@Autowired
	private EmployeesService empService;
	@Autowired
	private ApprovalService approvalService;
	
	@ModelAttribute
	public void settings(Model model) {
		model.addAttribute("selectedTitle", "approval");
		model.addAttribute("ApprovalRequest", true);
		model.addAttribute("commonCSS", false);
		
	}

	@GetMapping("/draft")
	public String getDraftFormPage(Model model){
		log.info("실행");
		
		model.addAttribute("selectedSub", "draft");
		model.addAttribute("title", "기안서 작성");
		
		List<Departments> deptList = deptService.getDepartmentList();
		deptList.removeIf(elem -> elem.getDeptId() == 999);
		model.addAttribute("departments", deptList);
		
		return "approval/draftForm";
	}
	
	@GetMapping("/settings")
	public String getApprovalSettingPage(Authentication auth, Model model) {
		log.info("실행");
		
		model.addAttribute("selectedSub", "settings");
		model.addAttribute("title", "전자 결재 설정");
		
		List<EmpApprovalLineDTO> empAPL = empService.getApprovalLineListByUserId(auth.getName());
		model.addAttribute("empAPL", empAPL);
		
		return "approval/approvalSettings";
	}
	
	@GetMapping("/result")
	public String getApproveListPage(PageParam param, Model model) {
		log.info("실행");
		String result = "";
		
		model.addAttribute("selectedSub", "result");
		model.addAttribute("title", "결재 승인/반려");
		
		if(param.getType()!=null && param.getType().equals("reject")) {
			model.addAttribute("activePage", "reject");
			result = "approval/approvalRejected";
		} else { //default page, type="approve"
			model.addAttribute("activePage", "approve");
			result = "approval/approvalApprove";
		}
		
		return result;
	}
	
	@GetMapping("/archive")
	public String getDeptOfficeBoxPage(PageParam param, Model model) {
		log.info("실행");
		model.addAttribute("selectedSub", "archive");
		model.addAttribute("title", "문서함");
		
		if(param.getType()!=null && param.getType().equals("completeDoc")) {
			model.addAttribute("activePage", "completeDoc");
			model.addAttribute("sectionTitle", "완결 문서함");
		} else if(param.getType()!=null && param.getType().equals("referenceDoc")) {
			model.addAttribute("activePage", "referenceDoc");
			model.addAttribute("sectionTitle", "참조 문서함");
		} else { //default page, type="deptDoc"
			model.addAttribute("activePage", "deptDoc");
			model.addAttribute("sectionTitle", "부서 문서함");
			
		}
		
		return "approval/approvalDeptOfficeBox";
	}
	
	@GetMapping("/submitted")
	public String getSubmittedPage(PageParam param, Model model) {
		log.info("실행");
		
		model.addAttribute("selectedSub", "submitted");
		model.addAttribute("title", "기결/회수");
		
		if(param.getType()!=null && param.getType().equals("retrieval")) {
			model.addAttribute("activePage", "retrieval");
			model.addAttribute("sectionTitle", "결재 회수 목록");
			
		} else { //default page, type="submitted"
			model.addAttribute("activePage", "submitted");
			model.addAttribute("sectionTitle", "결재 상신 목록");
		}
		
		return "approval/approvalSubmitted";
	}
	
	@GetMapping("/before")
	public String getBeforePage(PageParam param, Model model) {
		log.info("실행");
		
		model.addAttribute("selectedSub", "before");
		model.addAttribute("title", "결재 전단계");
		model.addAttribute("sectionTitle", "결재 전단계 문서");
		
		return "approval/approvalBeforeStep";
	}
	
	@GetMapping("/approveList")
	public String getApproveReadyPage(PageParam param, Model model) {
		log.info("실행");
		
		model.addAttribute("selectedSub", "approveList");
		model.addAttribute("title", "결재 하기");
		
		if (param.getType()!=null && param.getType().equals("all")) {
			model.addAttribute("activePage", "all");
			model.addAttribute("sectionTitle", "전체 결재 목록");
			
		} else { //defualt page, type="ready"
			model.addAttribute("activePage", "ready");
			model.addAttribute("sectionTitle", "결재 대기");
		}
		
		return "approval/approvalReadyList";
	}
	
	@ResponseBody
	@GetMapping(value = "/getDraftDoc", produces = "text/html; charset=UTF-8")
	public String getDraftDocument(String type, Model model) throws IOException {
		log.info("실행");
		
		String realPath = servletContext.getRealPath("/WEB-INF/views/documentSample/"+type+".html");
        File docHTML = new File(realPath);
		Document document = Jsoup.parse(docHTML, "UTF-8");
		Element element = document.getElementById(type);
		
		return element != null ? element.html() : "";
	}
	
	@GetMapping(value = "/getOrgChart", produces = "application/json; charset=UTF-8")
	public void getOrgChart(HttpServletResponse res) {
		log.info("실행");
		
		List<Departments> orgList = deptService.getDepartmentList();
		orgList.removeIf(elem -> elem.getDeptId() == 999);
		
		JSONObject json = new JSONObject();
		JSONObject orgChart = new JSONObject();
		JSONObject core = new JSONObject();
		JSONArray data = new JSONArray();
		JSONObject topDept = new JSONObject();
		topDept.put("text", "ThirtyOne");
		topDept.put("icon", "fa-solid fa-building");
		topDept.put("state", new JSONObject().put("opened", true));
		
		JSONArray childs = new JSONArray();
		for(int i=0; i<orgList.size(); i++) {
			JSONObject dept = new JSONObject();
			dept.put("id", Integer.toString(orgList.get(i).getDeptId()));
			dept.put("text", orgList.get(i).getDeptName());
			dept.put("icon", "fas fa-users");
			childs.put(dept);
		}
		
		topDept.put("children", childs);
		data.put(topDept);
		core.put("data", data);
		
		JSONObject themes = new JSONObject();
		themes.put("dots", false);
		themes.put("icons", true);
		
		orgChart.put("core", core);
		orgChart.put("themes", themes);
		json.put("status", "ok");
		json.put("org-chart", orgChart);
		
		try(PrintWriter pw = res.getWriter()) {
			res.setContentType("application/json; charset=UTF-8");
			res.setCharacterEncoding("UTF-8");
			pw.println(json.toString());
			pw.flush();
		} catch(IOException ioe) {
			ioe.printStackTrace();
		}
	}
	
	@GetMapping(value = "/getOrgEmp", produces = "application/json; charset=UTF-8")
	public void getOrgEmployee(int deptId, HttpServletResponse res) {
		log.info("실행");
		
		List<EmployeesDto> empList = empService.getEmployeeListByDeptId(deptId);
		JSONObject json = new JSONObject();
		JSONArray orgEmp = new JSONArray();
		
		for(EmployeesDto emp : empList) {
			JSONObject empInfo = new JSONObject();
			if(emp.getDeptId() != deptId) continue;
			
			empInfo.put("empId", emp.getEmpId());
			empInfo.put("name", emp.getEmpName());
			empInfo.put("empPosition", emp.getPosition());
			orgEmp.put(empInfo);
		}
		
		json.put("status", "ok");
		json.put("empInfo", orgEmp);
		
		try(PrintWriter pw = res.getWriter()) {
			res.setContentType("application/json; charset=UTF-8");
			res.setCharacterEncoding("UTF-8");
			pw.println(json.toString());
			pw.flush();
		} catch(IOException ioe) {
			ioe.printStackTrace();
		}
	}
	
	@PostMapping("getDeptName")
	public void getDeptNames(@RequestBody List<String> approvalDeptId, HttpServletResponse res) {
		log.info("실행");
		
		JSONObject json = new JSONObject();
		JSONArray deptNames = new JSONArray();
		
		for(String deptId : approvalDeptId) {
			deptNames.put(deptService.getDeptName(Integer.parseInt(deptId)));
		}
		
		json.put("status", "ok");
		json.put("deptNames", deptNames);
		try(PrintWriter pw = res.getWriter()) {
			res.setContentType("application/json; charset=UTF-8");
			res.setCharacterEncoding("UTF-8");
			pw.println(json.toString());
			pw.flush();
		} catch(IOException ioe) {
			ioe.printStackTrace();
		}
	}
	
	@InitBinder("draftForm")
	public void boardSubmitBinder(WebDataBinder binder) {
		log.info("InitBinder 실행");
		binder.setValidator(new DraftValidator());
	}
	
	@PostMapping("draftSubmit")
	public String draftSubmit(@Valid DraftForm form, Errors error, Model model, Authentication auth) throws IOException {
		log.info("실행");
		//log.info(form.toString());
		
		if(error.hasErrors()) {
			log.info("유효성 검출");
			
            error.getFieldErrors().forEach(
            		fieldError -> model.addAttribute(fieldError.getField(), fieldError.getDefaultMessage())
            );
            log.info(error.getFieldErrors().toString());
            model.addAttribute("form", form);
            List<Departments> deptList = deptService.getDepartmentList();
    		deptList.removeIf(elem -> elem.getDeptId() == 999);
    		model.addAttribute("departments", deptList);
    		List<EmployeesDto> reference = new ArrayList<>();
    		for(String ref : form.getDraftReference()) {
    			reference.add(empService.getEmpInfo(ref));
    		}
    		model.addAttribute("reference", reference);
            
            return "approval/draftForm";
		}
		
		ApprovalDTO dto = new ApprovalDTO();
		dto.setDocFormCode(approvalService.getDocType(form.getDraftType()));
		switch(dto.getDocFormCode()) {
		case "HLD":
			dto.setDocHolidayStartDate(form.getHolidayStartDate());
			dto.setDocHolidayEndDate(form.getHolidayEndDate());
			dto.setDocHolidayDay(form.getHolidayStartDate().getDate() - form.getHolidayEndDate().getDate());
			dto.setDocHolidayType(form.getHolidayType());
			break;
		case "BTD":
		case "BTR":
			dto.setDocBiztripStartDate(form.getBizTripStartDate());
			dto.setDocBiztripEndDate(form.getBizTripEndDate());
			dto.setDocBiztripDay(form.getBizTripStartDate().getDate() - form.getBizTripEndDate().getDate());
			dto.setDocBiztripPurpose(form.getBizTripPurposeForm());
			break;
		case "HLW":
			dto.setDocHolidayWorkStartDate(form.getHolidayWorkStartDate());
			break;
		case "WOT":
			dto.setDocWorkOvertimeEndDate(form.getWorkOvertimeEndDate());
			break;
		}
		
		dto.setDocDraftDate(new Date());
		dto.setEmpId(auth.getName());
		dto.setDeptId(empService.getDeptId(dto.getEmpId()));
		dto.setDocTitle(form.getDraftTitle());
		dto.setDocApprovalLine(new ArrayList<DocumentApprovalLineDTO>());
		dto.setDocDocumentData(form.getDocumentData());
		dto.setDocNumber(form.getDocNumber());
		
		approvalService.setDraftForm(dto);
		
		List<String> aplLine = form.getDraftApprovalLine();
		for(String name : aplLine) {
			DocumentApprovalLineDTO aplDto = new DocumentApprovalLineDTO();
			String[] arr = name.split("-");
			aplDto.setDocAprSeq(Integer.parseInt(arr[0]));
			aplDto.setDocAprApprover(arr[1]);
			aplDto.setDocNumber(dto.getDocNumber());
			aplDto.setDocAprState("대기");
			dto.getDocApprovalLine().add(aplDto);
		}
		approvalService.setApprovalLineFromDoc(dto);
		
		List<String> aplReferenceList = form.getDraftReference();
		dto.setDocReferenceList(new ArrayList<DocumentReferenceDTO>());
		for(String empId : aplReferenceList) {
			DocumentReferenceDTO dr = new DocumentReferenceDTO();
			dr.setEmpId(empId);
			dr.setDocNumber(form.getDocNumber());
			dto.getDocReferenceList().add(dr);
		}
		approvalService.setDocumentReference(dto);
		
		
		if(!form.getDraftAttachFile().isEmpty()) {
			dto.setDocAttachFile(new DocFilesDTO());
			dto.getDocAttachFile().setDocFileName(form.getDraftAttachFile().getOriginalFilename());
			dto.getDocAttachFile().setDocFileType(form.getDraftAttachFile().getContentType());
			dto.getDocAttachFile().setDocFileData(form.getDraftAttachFile().getBytes());
			approvalService.setDraftAttachFile(dto.getDocAttachFile());
		}
		
		log.info(dto.toString());
		
		return "redirect:/home";
	}
	
	@PostMapping("/getDocNumber")
	public void getDocNumber(ApprovalDTO dto, Authentication auth, HttpServletResponse res) throws IOException {
		log.info("실행");
		log.info("draftType: "+dto.getDraftType());
		
		String user = auth.getName();
		dto.setDeptId(empService.getDeptId(user));
		dto.setDocFormCode(approvalService.getDocType(dto.getDraftType()));
		dto.setDocDraftDate(new Date());
		
		String docNumber = approvalService.createDocNumber(dto);
		
		JSONObject json = new JSONObject();
		json.put("docNumber", docNumber);
		res.setContentType("application/json; charset=UTF-8");
		res.setCharacterEncoding("UTF-8");
		PrintWriter pw = res.getWriter();
		pw.println(json.toString());
		pw.flush();
		pw.close();
	}
}
