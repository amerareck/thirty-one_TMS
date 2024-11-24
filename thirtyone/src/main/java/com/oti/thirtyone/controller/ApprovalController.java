package com.oti.thirtyone.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;
import javax.validation.Valid;

import org.json.JSONArray;
import org.json.JSONObject;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
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

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.oti.thirtyone.dto.AlternateApproverDTO;
import com.oti.thirtyone.dto.ApprovalDTO;
import com.oti.thirtyone.dto.ApprovalData;
import com.oti.thirtyone.dto.Departments;
import com.oti.thirtyone.dto.DocFilesDTO;
import com.oti.thirtyone.dto.DocumentApprovalLineDTO;
import com.oti.thirtyone.dto.DocumentReferenceDTO;
import com.oti.thirtyone.dto.DraftForm;
import com.oti.thirtyone.dto.EmpApprovalLineDTO;
import com.oti.thirtyone.dto.EmployeesDto;
import com.oti.thirtyone.dto.PageParam;
import com.oti.thirtyone.dto.Pager;
import com.oti.thirtyone.service.AlertService;
import com.oti.thirtyone.service.ApprovalService;
import com.oti.thirtyone.service.AttendanceService;
import com.oti.thirtyone.service.DepartmentService;
import com.oti.thirtyone.service.EmployeesService;
import com.oti.thirtyone.validator.ArtApproverValidator;
import com.oti.thirtyone.validator.DraftValidator;

import lombok.extern.slf4j.Slf4j;
import oracle.ucp.common.FailoverStats.Item;

@Slf4j
@Controller
@RequestMapping("/approval")
@Secured("ROLE_USER")
public class ApprovalController {
	
	@Autowired
    private ServletContext servletContext;
	@Autowired
	private DepartmentService deptService;
	@Autowired
	private EmployeesService empService;
	@Autowired
	private ApprovalService approvalService;
	@Autowired
	AlertService alertService;
	
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
	
	@GetMapping("/redraft")
	public String getRedraftForm(ApprovalDTO param, Authentication auth, Model model) {
		log.info("실행");
		
		String result = getDraftFormPage(model);
		param.setEmpId(auth.getName());
		param = approvalService.getDraftDocumentSingle(param);
		param.setDocApprovalLine(approvalService.getDraftApprovalLine(param.getDocNumber()));
		param.getDocApprovalLine().forEach(item -> {
			item.setApproverInfo(empService.getEmpInfo(item.getDocAprApprover()));
			item.getApproverInfo().setDeptName(deptService.getDeptName(item.getApproverInfo().getDeptId()));
		});
		param.setEmpInfo(empService.getEmpInfo(param.getEmpId()));
		
		model.addAttribute("draft", param);
		model.addAttribute("redraft", true);
		model.addAttribute("draftCss", approvalService.getDocCssByDocType(param.getDocFormCode()));
		
		return result;
	}
	
	@GetMapping("/settings")
	public String getApprovalSettingPage(Authentication auth, Model model) {
		log.info("실행");
		
		model.addAttribute("selectedSub", "settings");
		model.addAttribute("title", "전자 결재 설정");
		
		Pager pager = new Pager(3, 5, empService.getApprovalLineCount(auth.getName()), 1);
		pager.setEmpId(auth.getName());
		
		List<EmpApprovalLineDTO> empAPL = empService.getApprovalLineListByPager(pager);
		model.addAttribute("empAPL", empAPL);
		model.addAttribute("pager", pager);
		
		// 나의 대리자: altApprover, 권한 대행: proxy
		// proxy의 경우 emp는 내가 대행하는 권한의 사원 정보를 뜻합니다.
		AlternateApproverDTO altApprover = approvalService.getCurrentAltApproverInfoByEmpId(auth.getName());
		if(altApprover != null) {
			Date now = new Date();
			// 이미 대결 위임 기간이 지난 경우는 렌더링 제외
			if(now.getTime() < altApprover.getAltAprEndDate().getTime()) {
				altApprover.setAltAprEmpInfo(empService.getEmpInfo(altApprover.getAltAprEmp()));
				model.addAttribute("altApprover", altApprover);
			}
		}
		List<AlternateApproverDTO> proxy = approvalService.getCurrentProxyInfoByEmpId(auth.getName());
		if(!proxy.isEmpty()) {
			List<String> nameList = new ArrayList<>();
			proxy.forEach(item -> nameList.add(item.getEmpId()));
			List<EmployeesDto> allEmpInfo = empService.getEmployeeListByEmpId(nameList);
			for(int i=0; i<allEmpInfo.size(); i++) proxy.get(i).setEmpInfo(allEmpInfo.get(i));
			model.addAttribute("proxyList", proxy);
		}
		
		return "approval/approvalSettings";
	}
	
	@GetMapping("/result")
	public String getApproveListPage(PageParam param, Authentication auth, Model model) {
		log.info("실행");
		String result = "";
		
		model.addAttribute("selectedSub", "result");
		model.addAttribute("title", "결재 승인/반려");
		param.setPageNo(param.getPageNo() == 0 ? 1 : param.getPageNo());
		List<ApprovalDTO> draftList = null;
		
		if(param.getType()!=null && param.getType().equals("reject")) {
			model.addAttribute("activePage", "reject");
			
			draftList = approvalService.getRejectDraftForEmpId(auth.getName());
			result = "approval/approvalRejected";
			
		} else { //default page, type="approve"
			model.addAttribute("activePage", "approve");
			
			draftList = approvalService.getApproveDraftForEmpId(auth.getName());
			result = "approval/approvalApprove";
		}
		if(param.getSearch() != null) {
			draftList = getPickupSearchList(param, draftList);
			model.addAttribute("search", true);
			model.addAttribute("paramObj", param);
		}
		
		Pager pager = new Pager(7, 5, draftList.size(), param.getPageNo());
		List<ApprovalDTO> pageNoDraftList = draftList.stream()
			    .skip(pager.getStartRowNo() - 1)
			    .limit(pager.getEndRowNo() - pager.getStartRowNo()+1)
			    .collect(Collectors.toList());

			draftList.clear();
			draftList.addAll(pageNoDraftList);
		
		List<DocumentApprovalLineDTO> docAprLineList = approvalService.getDocAprLinesByDocNumbers(draftList);
		List<DocumentReferenceDTO> docRefList = approvalService.getDocRefsByDocNumbers(draftList);
		Set<String> empIdSet = new HashSet<>();
		empIdSet.add(auth.getName());
		
		draftList.stream().forEach(item -> {
			item.setDocApprovalLine(docAprLineList.parallelStream()
				.filter(elem -> elem.getDocNumber().equals(item.getDocNumber()))
				.collect(Collectors.toList()));
			item.getDocApprovalLine().sort(Comparator.comparingInt(DocumentApprovalLineDTO::getDocAprSeq));
			item.setDocReferenceList(docRefList.parallelStream()
				.filter(elem -> elem.getDocNumber().equals(item.getDocNumber()))
				.collect(Collectors.toList()));
			item.getDocApprovalLine().forEach(elem -> empIdSet.add(elem.getDocAprApprover()));
			item.getDocReferenceList().forEach(elem -> empIdSet.add(elem.getEmpId()));
		});
		List<EmployeesDto> empList = empService.getEmployeeListByEmpId(new ArrayList<String>(empIdSet));
		
		draftList.stream().forEach(item -> {
			item.setEmpInfo(empList.stream().filter(elem -> elem.getEmpId().equals(auth.getName())).findFirst().get());
			item.setDeptId(item.getEmpInfo().getDeptId());
			item.setDeptName(item.getEmpInfo().getDeptName());
			item.setEmpPosition(item.getEmpInfo().getPosition());
			item.setEmpName(item.getEmpInfo().getEmpName());
			item.setApproveState(item.getDocAprStatus());
			item.getDocApprovalLine().stream()
				.forEach(elem -> elem.setApproverInfo(empList.stream()
							.filter(ele -> ele.getEmpId().equals(elem.getDocAprApprover()))
							.findFirst().get()));
			item.getDocReferenceList().stream()
				.forEach(elem -> {
					EmployeesDto empInfo = empList.stream()
							.filter(ele -> ele.getEmpId().equals(elem.getEmpId()))
							.findFirst().get();
					elem.setDeptId(empInfo.getDeptId());
					elem.setDeptName(empInfo.getDeptName());
					elem.setEmpName(empInfo.getEmpName());
					elem.setPosition(empInfo.getPosition());
				});
			item.setLastApprover(item.getDocApprovalLine().get(item.getDocApprovalLine().size()-1).getApproverInfo());
			item.setReviewingApproverSeq(0);
			for(int i=1; i<item.getDocApprovalLine().size(); i++) {
				if(item.getDocApprovalLine().get(i).getDocAprState().equals("승인") || 
					item.getDocApprovalLine().get(i).getDocAprState().equals("반려")) {
					item.setReviewingApproverSeq(i);
				}
			}
			
			//완결 문서의 경우 최종 결재자를 바꿔서 출력
			if(item.getDocAprStatus().equals("승인") || item.getDocAprStatus().equals("반려")) {
				for(int i=0; i<item.getDocApprovalLine().size(); i++) {
					if(item.getDocApprovalLine().get(i).getDocAprState().equals("승인") || 
						item.getDocApprovalLine().get(i).getDocAprState().equals("반려")) {
						item.setLastApprover(item.getDocApprovalLine().get(i).getApproverInfo());
					}
				}
			}
			
			//첨부파일
			DocFilesDTO docfile = new DocFilesDTO();
			docfile.setDocNumber(item.getDocNumber());
			item.setDocAttatchFileList(approvalService.getDocAttachFileListNoData(docfile));
		});
		model.addAttribute("draftList", draftList);
		model.addAttribute("pager", pager);
		
		return result;
	}
	
	@GetMapping("/archive")
	public String getDeptOfficeBoxPage(PageParam param, Authentication auth, Model model) {
		log.info("실행");
		model.addAttribute("selectedSub", "archive");
		model.addAttribute("title", "문서함");
		
		List<ApprovalDTO> draftList = null;
		param.setPageNo(param.getPageNo() == 0 ? 1 : param.getPageNo());
		EmployeesDto myInfo = empService.getEmpInfo(auth.getName());
		
		if(param.getType()!=null && param.getType().equals("completeDoc")) {
			model.addAttribute("activePage", "completeDoc");
			model.addAttribute("sectionTitle", "완결 문서함");
			
			draftList = approvalService.getDepartmentsCompleteDrafts(myInfo.getDeptId());
		} else if(param.getType()!=null && param.getType().equals("referenceDoc")) {
			model.addAttribute("activePage", "referenceDoc");
			model.addAttribute("sectionTitle", "참조 문서함");
			
			draftList = approvalService.getDraftsForReference(myInfo.getEmpId());
		} else { //default page, type="deptDoc"
			model.addAttribute("activePage", "deptDoc");
			model.addAttribute("sectionTitle", "부서 문서함");
			
			draftList = approvalService.getDepartmentsDrafts(myInfo.getDeptId());
		}
		if(param.getSearch() != null) {
			draftList = getPickupSearchList(param, draftList);
			model.addAttribute("search", true);
			model.addAttribute("paramObj", param);
		}
		
		Pager pager = new Pager(7, 5, draftList.size(), param.getPageNo());
		List<ApprovalDTO> pageNoDraftList = draftList.stream()
			    .skip(pager.getStartRowNo() - 1)
			    .limit(pager.getEndRowNo() - pager.getStartRowNo()+1)
			    .collect(Collectors.toList());

		draftList.clear();
		draftList.addAll(pageNoDraftList);
		
		List<DocumentApprovalLineDTO> docAprLineList = approvalService.getDocAprLinesByDocNumbers(draftList);
		List<DocumentReferenceDTO> docRefList = approvalService.getDocRefsByDocNumbers(draftList);
		Set<String> empIdSet = new HashSet<>();
		empIdSet.add(auth.getName());
		
		draftList.stream().forEach(item -> {
			item.setDocApprovalLine(docAprLineList.parallelStream()
				.filter(elem -> elem.getDocNumber().equals(item.getDocNumber()))
				.collect(Collectors.toList()));
			item.getDocApprovalLine().sort(Comparator.comparingInt(DocumentApprovalLineDTO::getDocAprSeq));
			item.setDocReferenceList(docRefList.parallelStream()
				.filter(elem -> elem.getDocNumber().equals(item.getDocNumber()))
				.collect(Collectors.toList()));
			item.getDocApprovalLine().forEach(elem -> empIdSet.add(elem.getDocAprApprover()));
			item.getDocReferenceList().forEach(elem -> empIdSet.add(elem.getEmpId()));
			empIdSet.add(item.getEmpId());
		});
		List<EmployeesDto> empList = empService.getEmployeeListByEmpId(new ArrayList<String>(empIdSet));
		
		draftList.stream().forEach(item -> {
			item.setEmpInfo(empList.stream().filter(elem -> elem.getEmpId().equals(item.getEmpId())).findFirst().get());
			item.setDeptId(item.getEmpInfo().getDeptId());
			item.setDeptName(item.getEmpInfo().getDeptName());
			item.setEmpPosition(item.getEmpInfo().getPosition());
			item.setEmpName(item.getEmpInfo().getEmpName());
			item.setApproveState(item.getDocAprStatus());
			item.getDocApprovalLine().stream()
				.forEach(elem -> elem.setApproverInfo(empList.stream()
							.filter(ele -> ele.getEmpId().equals(elem.getDocAprApprover()))
							.findFirst().get()));
			item.getDocReferenceList().stream()
				.forEach(elem -> {
					EmployeesDto empInfo = empList.stream()
							.filter(ele -> ele.getEmpId().equals(elem.getEmpId()))
							.findFirst().get();
					elem.setDeptId(empInfo.getDeptId());
					elem.setDeptName(empInfo.getDeptName());
					elem.setEmpName(empInfo.getEmpName());
					elem.setPosition(empInfo.getPosition());
				});
			item.setLastApprover(item.getDocApprovalLine().get(item.getDocApprovalLine().size()-1).getApproverInfo());
			item.setReviewingApproverSeq(0);
			for(int i=1; i<item.getDocApprovalLine().size(); i++) {
				if(item.getDocApprovalLine().get(i).getDocAprState().equals("승인") || 
					item.getDocApprovalLine().get(i).getDocAprState().equals("반려")) {
					//item.setLastApprover(item.getDocApprovalLine().get(item.getDocApprovalLine().size()-1).getApproverInfo());
					item.setReviewingApproverSeq(i);
				}
			}
			
			//완결 문서의 경우 최종 결재자를 바꿔서 출력
			if(item.getDocAprStatus().equals("승인") || item.getDocAprStatus().equals("반려")) {
				for(int i=0; i<item.getDocApprovalLine().size(); i++) {
					if(item.getDocApprovalLine().get(i).getDocAprState().equals("승인") || 
						item.getDocApprovalLine().get(i).getDocAprState().equals("반려")) {
						item.setLastApprover(item.getDocApprovalLine().get(i).getApproverInfo());
					}
				}
			}
			
			//첨부파일
			DocFilesDTO docfile = new DocFilesDTO();
			docfile.setDocNumber(item.getDocNumber());
			item.setDocAttatchFileList(approvalService.getDocAttachFileListNoData(docfile));
		});
		model.addAttribute("draftList", draftList);
		model.addAttribute("pager", pager);
		
		return "approval/approvalDeptOfficeBox";
	}
	
	@GetMapping("/submitted")
	public String getSubmittedPage(PageParam param, Authentication auth, Model model) {
		log.info("실행");
		
		model.addAttribute("selectedSub", "submitted");
		model.addAttribute("title", "기결/회수");
		model.addAttribute("urlName", "submitted");
		param.setPageNo(param.getPageNo() == 0 ? 1 : param.getPageNo());
		
		if(param.getType()!=null && param.getType().equals("retrieval")) {
			model.addAttribute("activePage", "retrieval");
			model.addAttribute("sectionTitle", "결재 회수 목록");
			
			List<ApprovalDTO> recallTotalList = approvalService.getRecallDocumentListById(auth.getName());
			if(param.getSearch() != null) {
				recallTotalList = getPickupSearchList(param, recallTotalList);
				model.addAttribute("search", true);
				model.addAttribute("paramObj", param);
			}
			List<ApprovalDTO> recallList = recallTotalList;
			
			Pager pager = new Pager(7, 5, recallList.size(), param.getPageNo());
			recallList.removeIf(item -> {
	            int index = recallList.indexOf(item)+1;
	            return index < pager.getStartRowNo() || index > pager.getEndRowNo();
	        });
			
			List<EmployeesDto> empList = empService.getAllEmployees();
			EmployeesDto empDTO = empList.stream().filter(elem -> elem.getEmpId().equals(auth.getName())).findFirst().get();
			recallList.parallelStream().forEach(item -> {
				item.setDeptId(empDTO.getDeptId());
				item.setDeptName(empDTO.getDeptName());
				item.setEmpPosition(empDTO.getPosition());
				item.setEmpName(empDTO.getEmpName());
				item.setApproveState(item.getDocAprStatus());
				item.setDocApprovalLine(approvalService.getDraftApprovalLine(item.getDocNumber()));
				//회수 문서에는 참조자가 전부 삭제되어 있음. 참조자는 회수 문서를 조회하면 안되니까.
				//item.setDocReferenceList(approvalService.getDraftReferenceList(item.getDocNumber()));
				
				item.getDocApprovalLine().forEach(elem -> {
					elem.setApproverInfo(empList.stream().filter(ele -> ele.getEmpId().equals(elem.getDocAprApprover())).findFirst().get());
					//elem.getApproverInfo().setDeptName(deptService.getDeptName(elem.getApproverInfo().getDeptId()));
				});
				List<DocumentApprovalLineDTO> dalList = item.getDocApprovalLine().stream()
						.sorted(Comparator.comparing(DocumentApprovalLineDTO::getDocAprSeq).reversed())
						.collect(Collectors.toList());
				for(DocumentApprovalLineDTO elem : dalList) {
					if(elem.getDocAprState().equals("승인") || 
						elem.getDocAprState().equals("반려") || 
						elem.getDocAprState().equals("보류")) {
						item.setReviewingApprover(elem.getApproverInfo().getEmpName());
					    item.setReviewingApproverPosition(elem.getApproverInfo().getPosition());
					    item.setReviewingApproverDeptId(elem.getApproverInfo().getDeptId());
					    item.setApproveState(item.getDocAprStatus());
					    item.setLastApprover(item.getDocApprovalLine().get(item.getDocApprovalLine().size() - 1).getApproverInfo());
					    break;
					}
				}
				if(item.getReviewingApprover() == null || item.getReviewingApprover().isEmpty()) {
					item.setReviewingApprover(item.getDocApprovalLine().get(0).getApproverInfo().getEmpName());
				    item.setReviewingApproverPosition(item.getDocApprovalLine().get(0).getApproverInfo().getPosition());
				    item.setReviewingApproverDeptId(item.getDocApprovalLine().get(0).getApproverInfo().getDeptId());
				    item.setApproveState(item.getDocAprStatus());
				    item.setLastApprover(item.getDocApprovalLine().get(item.getDocApprovalLine().size() - 1).getApproverInfo());
				}
				
				//완결 문서의 경우 최종 결재자를 바꿔서 출력
				if(item.getDocAprStatus().equals("승인") || item.getDocAprStatus().equals("반려")) {
					for(int i=0; i<item.getDocApprovalLine().size(); i++) {
						if(item.getDocApprovalLine().get(i).getDocAprState().equals("승인") || 
							item.getDocApprovalLine().get(i).getDocAprState().equals("반려")) {
							item.setLastApprover(item.getDocApprovalLine().get(i).getApproverInfo());
						}
					}
				}
				//첨부파일
				DocFilesDTO docfile = new DocFilesDTO();
				docfile.setDocNumber(item.getDocNumber());
				item.setDocAttatchFileList(approvalService.getDocAttachFileListNoData(docfile));
			});
			
			model.addAttribute("recalledList", recallList);
			model.addAttribute("pager", pager);
			
		} else { //default page, type="submitted"
			model.addAttribute("activePage", "submitted");
			model.addAttribute("sectionTitle", "결재 상신 목록");
			
			List<ApprovalDTO> approvalTotalList = approvalService.getDraftDocumentById(auth.getName());
			if(param.getSearch() != null) {
				approvalTotalList = getPickupSearchList(param, approvalTotalList);
				model.addAttribute("search", true);
				model.addAttribute("paramObj", param);
			}
			List<ApprovalDTO> approvalList = approvalTotalList;
			
			Pager pager = new Pager(7, 5, approvalList.size(), param.getPageNo());
			approvalList.removeIf(item -> {
	            int index = approvalList.indexOf(item)+1;
	            return index < pager.getStartRowNo() || index > pager.getEndRowNo();
	        });
			
			List<EmployeesDto> empList = empService.getAllEmployees();
			EmployeesDto empDTO = empList.stream().filter(elem -> elem.getEmpId().equals(auth.getName())).findFirst().get();
			approvalList.parallelStream().forEach(item -> {
				item.setDeptId(empDTO.getDeptId());
				item.setDeptName(empDTO.getDeptName());
				item.setEmpPosition(empDTO.getPosition());
				item.setEmpName(empDTO.getEmpName());
				item.setDocApprovalLine(approvalService.getDraftApprovalLine(item.getDocNumber()));
				item.setDocReferenceList(approvalService.getDraftReferenceList(item.getDocNumber()));
				item.getDocApprovalLine().forEach(elem -> elem.setApproverInfo(
						empList.stream()
							.filter(ele -> ele.getEmpId().equals(elem.getDocAprApprover()))
							.findFirst()
							.get()
						));
				List<DocumentApprovalLineDTO> dalList = item.getDocApprovalLine().stream()
						.sorted(Comparator.comparing(DocumentApprovalLineDTO::getDocAprSeq).reversed())
						.collect(Collectors.toList());
				for(DocumentApprovalLineDTO elem : dalList) {
					if(elem.getDocAprState().equals("승인") || 
						elem.getDocAprState().equals("반려") || 
						elem.getDocAprState().equals("보류")) {
						item.setReviewingApprover(elem.getApproverInfo().getEmpName());
					    item.setReviewingApproverPosition(elem.getApproverInfo().getPosition());
					    item.setReviewingApproverDeptId(elem.getApproverInfo().getDeptId());
					    item.setApproveState(item.getDocAprStatus());
					    item.setLastApprover(item.getDocApprovalLine().get(item.getDocApprovalLine().size() - 1).getApproverInfo());
					    break;
					}
				}
				
				if(item.getReviewingApprover() == null || item.getReviewingApprover().isEmpty()) {
					item.setReviewingApprover(item.getDocApprovalLine().get(0).getApproverInfo().getEmpName());
				    item.setReviewingApproverPosition(item.getDocApprovalLine().get(0).getApproverInfo().getPosition());
				    item.setReviewingApproverDeptId(item.getDocApprovalLine().get(0).getApproverInfo().getDeptId());
				    item.setApproveState(item.getDocAprStatus());
				    item.setLastApprover(item.getDocApprovalLine().get(item.getDocApprovalLine().size() - 1).getApproverInfo());
				}
				
				//완결 문서의 경우 최종 결재자를 바꿔서 출력
				if(item.getDocAprStatus().equals("승인") || item.getDocAprStatus().equals("반려")) {
					for(int i=0; i<item.getDocApprovalLine().size(); i++) {
						if(item.getDocApprovalLine().get(i).getDocAprState().equals("승인") || 
							item.getDocApprovalLine().get(i).getDocAprState().equals("반려")) {
							item.setLastApprover(item.getDocApprovalLine().get(i).getApproverInfo());
						}
					}
				}
				
				//첨부파일
				DocFilesDTO docfile = new DocFilesDTO();
				docfile.setDocNumber(item.getDocNumber());
				item.setDocAttatchFileList(approvalService.getDocAttachFileListNoData(docfile));
			});
			
			model.addAttribute("draftList", approvalList);
			model.addAttribute("pager", pager);
		}
		
		return "approval/approvalSubmitted";
	}
	
	private List<ApprovalDTO> getPickupSearchList(PageParam param, List<ApprovalDTO> recallList) {
		String type = param.getSearch();
		log.info("##### param: "+param.toString());
		List<ApprovalDTO> result = null;
		recallList.forEach(item -> log.info("draftDept: "+item.getDeptId()));
		switch(type) {
			case "draftTitle" : 
				result = recallList.stream().filter(item -> item.getDocTitle().contains(param.getKeyword())).collect(Collectors.toList());
				break;
			case "draftAuthor" : 
				result = recallList.stream().filter(item -> item.getEmpName().contains(param.getKeyword())).collect(Collectors.toList());
				break;
			case "draftType" :
				result = recallList.stream().filter(item -> item.getDocFormName().equals(param.getKeyword())).collect(Collectors.toList());
				break;
			case "draftState" :
				result = recallList.stream().filter(item -> item.getDocAprStatus().equals(param.getKeyword())).collect(Collectors.toList());
				break;
			case "draftDept" :
				result = recallList.stream().filter(item -> item.getDeptId() == Integer.parseInt(param.getKeyword())).collect(Collectors.toList());
				break;
			default :
				result = new ArrayList<>();
		}
		return result;
	}

	@GetMapping("/before")
	public String getBeforePage(PageParam param, Authentication auth, Model model) {
		log.info("실행");
		param.setPageNo(param.getPageNo() == 0 ? 1 : param.getPageNo());
		
		model.addAttribute("selectedSub", "before");
		model.addAttribute("title", "결재 전단계");
		model.addAttribute("sectionTitle", "결재 전단계 문서");
		
		List<String> docNumbers = approvalService.getApproveReadyDocNumberByEmpId(auth.getName());;
		List<String> proxyIds = approvalService.getProxyEmpIdsById(auth.getName());
		List<String> proxyDraft = approvalService.getProxyApprovalDocNumbersByEmpId(proxyIds);
		
		docNumbers.addAll(proxyDraft);
		List<ApprovalDTO> draftList;
		Pager pager = new Pager(7, 5, docNumbers.size(), param.getPageNo());
		pager.setDocNumbers(docNumbers);

		if(param.getSearch() != null) {
			pager = new Pager(docNumbers.size(), 5, docNumbers.size(), 1);
			pager.setDocNumbers(docNumbers);
			List<ApprovalDTO> drafts = approvalService.getDraftsByDocNumbers(pager);
			drafts = getPickupSearchList(param, drafts);
			pager = new Pager(7, 5, drafts.size(), param.getPageNo());
			draftList = drafts.stream().skip(pager.getStartRowNo()-1).limit(pager.getRowsPerPage()).collect(Collectors.toList());
			log.info("draftListSize: "+Integer.toString(draftList.size()));
			model.addAttribute("search", true);
			model.addAttribute("paramObj", param);
		} else {
			draftList = approvalService.getDraftsByDocNumbers(pager);
		}

		List<DocumentApprovalLineDTO> docAprLineList = approvalService.getDocAprLinesByDocNumbers(draftList);
		List<DocumentReferenceDTO> docRefList = approvalService.getDocRefsByDocNumbers(draftList);
		Set<String> empIdSet = new HashSet<>();
		empIdSet.add(auth.getName());
		
		draftList.stream().forEach(item -> {
			item.setDocApprovalLine(docAprLineList.parallelStream()
				.filter(elem -> elem.getDocNumber().equals(item.getDocNumber()))
				.collect(Collectors.toList()));
			item.getDocApprovalLine().sort(Comparator.comparingInt(DocumentApprovalLineDTO::getDocAprSeq));
			item.setDocReferenceList(docRefList.parallelStream()
				.filter(elem -> elem.getDocNumber().equals(item.getDocNumber()))
				.collect(Collectors.toList()));
			item.getDocApprovalLine().forEach(elem -> {
				empIdSet.add(elem.getDocAprApprover());
				if(elem.getDocAprProxy() != null) empIdSet.add(elem.getDocAprProxy());
			});
			item.getDocReferenceList().forEach(elem -> empIdSet.add(elem.getEmpId()));
			empIdSet.add(item.getEmpId());
		});
		List<EmployeesDto> empList = empService.getEmployeeListByEmpId(new ArrayList<String>(empIdSet));
		draftList.parallelStream().forEach(item -> item.setAlternativeApproval(proxyDraft.contains(item.getDocNumber())));
		
		draftList.stream().forEach(item -> {
			item.setEmpInfo(empList.stream().filter(elem -> elem.getEmpId().equals(item.getEmpId())).findFirst().get());
			item.setDeptId(item.getEmpInfo().getDeptId());
			item.setDeptName(item.getEmpInfo().getDeptName());
			item.setEmpPosition(item.getEmpInfo().getPosition());
			item.setEmpName(item.getEmpInfo().getEmpName());
			item.setApproveState(item.getDocAprStatus());
			item.getDocApprovalLine().stream()
				.forEach(elem -> elem.setApproverInfo(empList.stream()
							.filter(ele -> ele.getEmpId().equals(elem.getDocAprApprover()))
							.findFirst().get()));
			item.getDocReferenceList().stream()
				.forEach(elem -> {
					EmployeesDto empInfo = empList.stream()
							.filter(ele -> ele.getEmpId().equals(elem.getEmpId()))
							.findFirst().get();
					elem.setDeptId(empInfo.getDeptId());
					elem.setDeptName(empInfo.getDeptName());
					elem.setEmpName(empInfo.getEmpName());
					elem.setPosition(empInfo.getPosition());
				});
			item.setLastApprover(item.getDocApprovalLine().get(0).getApproverInfo());
			item.setReviewingApproverSeq(0);
			for(int i=1; i<item.getDocApprovalLine().size(); i++) {
				if(item.getDocApprovalLine().get(i).getDocAprState().equals("승인") || 
					item.getDocApprovalLine().get(i).getDocAprState().equals("반려")) {
					item.setLastApprover(item.getDocApprovalLine().get(i).getApproverInfo());
					item.setReviewingApproverSeq(i);
				}
			}
			item.setNowApprover(empList.parallelStream().filter(elem -> elem.getEmpId().equals(auth.getName())).findFirst().get());
			item.getDocApprovalLine().parallelStream().forEach(elem -> {
				if(elem.getDocAprProxy() != null) {
					elem.setApproverProxyInfo(
						empList.stream().filter(ele -> ele.getEmpId().equals(elem.getDocAprProxy())).findFirst().orElse(null)
					);
				}
				if(elem.getApproverInfo().getAltAprEmp() != null && elem.getApproverInfo().getAltAprEmp().equals(auth.getName())) {
					item.setReviewingApproverSeq(elem.getDocAprSeq());
				} else if(elem.getApproverInfo().getEmpId().equals(auth.getName())){
					item.setReviewingApproverSeq(elem.getDocAprSeq());
				}
			});
			
			List<DocumentApprovalLineDTO> dalList = item.getDocApprovalLine().stream()
					.sorted(Comparator.comparing(DocumentApprovalLineDTO::getDocAprSeq))
					.collect(Collectors.toList());
			for(DocumentApprovalLineDTO elem : dalList) {
				if(elem.getDocAprState().equals("대기") || elem.getDocAprState().equals("보류")) {
					item.setReviewingApprover(elem.getApproverInfo().getEmpName());
				    item.setReviewingApproverPosition(elem.getApproverInfo().getPosition());
				    item.setReviewingApproverDeptId(elem.getApproverInfo().getDeptId());
				    item.setApproveState(item.getDocAprStatus());
				    item.setLastApprover(item.getDocApprovalLine().get(item.getDocApprovalLine().size() - 1).getApproverInfo());
				    break;
				}
			}
			if(item.getReviewingApprover() == null || item.getReviewingApprover().isEmpty()) {
				item.setReviewingApprover(item.getDocApprovalLine().get(0).getApproverInfo().getEmpName());
			    item.setReviewingApproverPosition(item.getDocApprovalLine().get(0).getApproverInfo().getPosition());
			    item.setReviewingApproverDeptId(item.getDocApprovalLine().get(0).getApproverInfo().getDeptId());
			    item.setApproveState(item.getDocAprStatus());
			    item.setLastApprover(item.getDocApprovalLine().get(item.getDocApprovalLine().size() - 1).getApproverInfo());
			}
			
			//첨부파일
			DocFilesDTO docfile = new DocFilesDTO();
			docfile.setDocNumber(item.getDocNumber());
			item.setDocAttatchFileList(approvalService.getDocAttachFileListNoData(docfile));
		});
		
		log.info("### list size: "+draftList.size());
		model.addAttribute("aprList", draftList);
		model.addAttribute("pager", pager);
		
		return "approval/approvalBeforeStep";
	}
	
	@GetMapping("/approveList")
	public String getApproveReadyPage(PageParam param, Authentication auth, Model model) {
		log.info("실행");
		param.setPageNo(param.getPageNo() == 0 ? 1 : param.getPageNo());
		
		model.addAttribute("selectedSub", "approveList");
		model.addAttribute("title", "결재 하기");
		
		List<String> docNumbers = null;
		List<String> proxyIds = approvalService.getProxyEmpIdsById(auth.getName());
		List<String> proxyDraft = approvalService.getProxyApprovalDocNumbersByEmpId(proxyIds);
		
		if (param.getType()!=null && param.getType().equals("all")) {
			model.addAttribute("activePage", "all");
			model.addAttribute("sectionTitle", "전체 결재 목록");
			
			docNumbers = approvalService.getDocNumberToAprLineIncludeUser(auth.getName());
		} else { //defualt page, type="ready"
			model.addAttribute("activePage", "ready");
			model.addAttribute("sectionTitle", "결재 대기");
			
			docNumbers = approvalService.getApprovalRecentStepListDocNumberByEmpId(auth.getName());
		}
		
		docNumbers.addAll(proxyDraft);
		List<ApprovalDTO> draftList;
		Pager pager = new Pager(7, 5, docNumbers.size(), param.getPageNo());
		pager.setDocNumbers(docNumbers);

		if(param.getSearch() != null) {
			pager = new Pager(docNumbers.size(), 5, docNumbers.size(), 1);
			pager.setDocNumbers(docNumbers);
			List<ApprovalDTO> drafts = approvalService.getDraftsByDocNumbers(pager);
			drafts = getPickupSearchList(param, drafts);
			pager = new Pager(7, 5, drafts.size(), param.getPageNo());
			draftList = drafts.stream().skip(pager.getStartRowNo()-1).limit(pager.getRowsPerPage()).collect(Collectors.toList());
			log.info("draftListSize: "+Integer.toString(draftList.size()));
			model.addAttribute("search", true);
			model.addAttribute("paramObj", param);
		} else {
			draftList = approvalService.getDraftsByDocNumbers(pager);
		}
		
		List<DocumentApprovalLineDTO> docAprLineList = approvalService.getDocAprLinesByDocNumbers(draftList);
		List<DocumentReferenceDTO> docRefList = approvalService.getDocRefsByDocNumbers(draftList);
		Set<String> empIdSet = new HashSet<>();
		empIdSet.add(auth.getName());
		
		draftList.stream().forEach(item -> {
			item.setDocApprovalLine(docAprLineList.parallelStream()
				.filter(elem -> elem.getDocNumber().equals(item.getDocNumber()))
				.collect(Collectors.toList()));
			item.getDocApprovalLine().sort(Comparator.comparingInt(DocumentApprovalLineDTO::getDocAprSeq));
			item.setDocReferenceList(docRefList.parallelStream()
				.filter(elem -> elem.getDocNumber().equals(item.getDocNumber()))
				.collect(Collectors.toList()));
			item.getDocApprovalLine().forEach(elem -> {
				empIdSet.add(elem.getDocAprApprover());
				if(elem.getDocAprProxy() != null) empIdSet.add(elem.getDocAprProxy());
			});
			item.getDocReferenceList().forEach(elem -> empIdSet.add(elem.getEmpId()));
			empIdSet.add(item.getEmpId());
		});
		List<EmployeesDto> empList = empService.getEmployeeListByEmpId(new ArrayList<String>(empIdSet));
		draftList.parallelStream().forEach(item -> item.setAlternativeApproval(proxyDraft.contains(item.getDocNumber())));
		
		draftList.stream().forEach(item -> {
			item.setEmpInfo(empList.stream().filter(elem -> elem.getEmpId().equals(item.getEmpId())).findFirst().get());
			item.setDeptId(item.getEmpInfo().getDeptId());
			item.setDeptName(item.getEmpInfo().getDeptName());
			item.setEmpPosition(item.getEmpInfo().getPosition());
			item.setEmpName(item.getEmpInfo().getEmpName());
			item.setApproveState(item.getDocAprStatus());
			item.getDocApprovalLine().stream()
				.forEach(elem -> elem.setApproverInfo(empList.stream()
							.filter(ele -> ele.getEmpId().equals(elem.getDocAprApprover()))
							.findFirst().get()));
			item.getDocReferenceList().stream()
				.forEach(elem -> {
					EmployeesDto empInfo = empList.stream()
							.filter(ele -> ele.getEmpId().equals(elem.getEmpId()))
							.findFirst().get();
					elem.setDeptId(empInfo.getDeptId());
					elem.setDeptName(empInfo.getDeptName());
					elem.setEmpName(empInfo.getEmpName());
					elem.setPosition(empInfo.getPosition());
				});
			item.setLastApprover(item.getDocApprovalLine().get(0).getApproverInfo());
			item.setReviewingApproverSeq(0);
			for(int i=1; i<item.getDocApprovalLine().size(); i++) {
				if(item.getDocApprovalLine().get(i).getDocAprState().equals("승인") || 
					item.getDocApprovalLine().get(i).getDocAprState().equals("반려")) {
					item.setLastApprover(item.getDocApprovalLine().get(i).getApproverInfo());
				}
				if(item.getDocApprovalLine().get(i).getDocAprApprover().equals(auth.getName())) {
					item.setReviewingApprover(auth.getName());
					item.setReviewingApproverSeq(item.getDocApprovalLine().get(i).getDocAprSeq());
				}
			}
			item.setNowApprover(empList.parallelStream().filter(elem -> elem.getEmpId().equals(auth.getName())).findFirst().get());
			item.getDocApprovalLine().parallelStream().forEach(elem -> {
				if(elem.getDocAprProxy() != null) {
					elem.setApproverProxyInfo(
						empList.stream().filter(ele -> ele.getEmpId().equals(elem.getDocAprProxy())).findFirst().orElse(null)
					);
				}
				if(elem.getApproverInfo().getAltAprEmp() != null && elem.getApproverInfo().getAltAprEmp().equals(auth.getName())) {
					item.setReviewingApproverSeq(elem.getDocAprSeq());
				}
			});
			
			List<DocumentApprovalLineDTO> dalList = item.getDocApprovalLine().stream()
					.sorted(Comparator.comparing(DocumentApprovalLineDTO::getDocAprSeq))
					.collect(Collectors.toList());
			for(DocumentApprovalLineDTO elem : dalList) {
				if(elem.getDocAprState().equals("대기") || elem.getDocAprState().equals("보류")) {
					item.setReviewingApprover(elem.getApproverInfo().getEmpName());
				    item.setReviewingApproverPosition(elem.getApproverInfo().getPosition());
				    item.setReviewingApproverDeptId(elem.getApproverInfo().getDeptId());
				    item.setApproveState(item.getDocAprStatus());
				    item.setLastApprover(item.getDocApprovalLine().get(item.getDocApprovalLine().size() - 1).getApproverInfo());
				    break;
				}
			}
			if(item.getReviewingApprover() == null || item.getReviewingApprover().isEmpty()) {
				item.setReviewingApprover(item.getDocApprovalLine().get(0).getApproverInfo().getEmpName());
			    item.setReviewingApproverPosition(item.getDocApprovalLine().get(0).getApproverInfo().getPosition());
			    item.setReviewingApproverDeptId(item.getDocApprovalLine().get(0).getApproverInfo().getDeptId());
			    item.setApproveState(item.getDocAprStatus());
			    item.setLastApprover(item.getDocApprovalLine().get(item.getDocApprovalLine().size() - 1).getApproverInfo());
			}
			
			//첨부파일
			DocFilesDTO docfile = new DocFilesDTO();
			docfile.setDocNumber(item.getDocNumber());
			item.setDocAttatchFileList(approvalService.getDocAttachFileListNoData(docfile));
		});
		
		model.addAttribute("aprList", draftList);
		model.addAttribute("pager", pager);
		
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
		log.info(form.toString());
		
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
    		if(form.getDraftReference() != null && !form.getDraftReference().isEmpty()) {
    			for(String ref : form.getDraftReference()) {
    				reference.add(empService.getEmpInfo(ref));
    			}
    		}
    		if(form.getDraftApprovalLine() != null && !form.getDraftApprovalLine().isEmpty()) {
    			form.setRedraftAprLineList(new ArrayList<>());
    			form.getDraftApprovalLine().forEach(item -> {
    				String[] aprLineName = item.split("-");
    				form.getRedraftAprLineList().add(empService.getEmpInfo(aprLineName[1]));
    			});
    		}
    		model.addAttribute("reference", reference);
    		model.addAttribute("isError", true);
            return getDraftFormPage(model);
		}
		// 재기안의 경우 문서 비활성화
		if(form.isRedraft()) {
			approvalService.deactivatedDocumentStatus(form.getPrevDocNumber());
		}
		ApprovalDTO dto = new ApprovalDTO();
		int dateLen = 0;
		dto.setDateList(new ArrayList<Date>());
		dto.setDocFormCode(approvalService.getDocType(form.getDraftType()));
		switch(dto.getDocFormCode()) {
		case "HLD":
			dto.setDocHolidayStartDate(form.getHolidayStartDate());
			dto.setDocHolidayEndDate(form.getHolidayEndDate());
			dateLen = (form.getHolidayEndDate().getDate() - form.getHolidayStartDate().getDate())+1;
			for(int i=0; i<dateLen; i++) {
				Date date = (Date) form.getHolidayStartDate().clone();
				date.setDate(date.getDate()+i);
				if(!dto.isWeekend(date)) dto.getDateList().add(date);
			}
			dto.setDocHolidayDay(dto.getDateList().size());
			dto.setDocHolidayType(form.getHolidayType());
			break;
		case "BTD":
		case "BTR":
			dto.setDocBiztripStartDate(form.getBizTripStartDate());
			dto.setDocBiztripEndDate(form.getBizTripEndDate());
			dateLen = (form.getBizTripEndDate().getDate() - form.getBizTripStartDate().getDate())+1;
			for(int i=0; i<dateLen; i++) {
				Date date = (Date) form.getBizTripStartDate().clone();
				date.setDate(date.getDate()+i);
				if(!dto.isWeekend(date)) dto.getDateList().add(date);
			}
			dto.setDocBiztripDay(dto.getDateList().size());
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
			dto.getDocAttachFile().setDocNumber(form.getDocNumber());
			approvalService.setDraftAttachFile(dto.getDocAttachFile());
		}
		
		// 첫번째 결재자에게 알람 송신
		EmployeesDto empData = empService.getEmpInfo(dto.getDocApprovalLine().get(0).getDocAprApprover());
		String alertContent = empData.getEmpName()+" "+empData.getPosition()+"님, 대기결재함에 ["+dto.getDocNumber()+" / "+dto.getDocTitle()+"] 문서가 상신되었습니다.";
		alertService.sendAlert(empData.getEmpId(), alertContent, "결재");
		
		return "redirect:/approval/submitted?type=submitted";
	}
	
	@PostMapping("/getDocNumber")
	public void getDocNumber(ApprovalDTO dto, Authentication auth, HttpServletResponse res) throws IOException {
		log.info("실행");
		log.info("draftType: "+dto.getDraftType());
		JSONObject json = new JSONObject();
		
		if(dto.getDraftType().equals("default")) {
			json.put("status", "error");
			json.put("errorMessage", "문서 유형은 반드시 선택해야 합니다.");
			
			res.setContentType("application/json; charset=UTF-8");
			res.setCharacterEncoding("UTF-8");
			PrintWriter pw = res.getWriter();
			pw.println(json.toString());
			pw.flush();
			pw.close();
			return;
		}
		
		String user = auth.getName();
		dto.setDeptId(empService.getDeptId(user));
		dto.setDocFormCode(approvalService.getDocType(dto.getDraftType()));
		dto.setDocDraftDate(new Date());
		
		String docNumber = approvalService.createDocNumber(dto);
		
		json.put("docNumber", docNumber);
		res.setContentType("application/json; charset=UTF-8");
		res.setCharacterEncoding("UTF-8");
		PrintWriter pw = res.getWriter();
		pw.println(json.toString());
		pw.flush();
		pw.close();
	}
	
	@GetMapping("/getApprovalLineList")
	public String getApprovalLineList(int pageNo, Authentication auth, Model model) {
		log.info("실행");
		Pager pager = new Pager(3, 5, empService.getApprovalLineCount(auth.getName()), pageNo);
		pager.setEmpId(auth.getName());
		model.addAttribute("pager", pager);
		
		List<EmpApprovalLineDTO> empAPL = empService.getApprovalLineListByPager(pager);
		model.addAttribute("empAPL", empAPL);
		
		return "approval/approvalSettingsLineList";
	}
	
	@GetMapping("/getApprovalLineListJson")
	public void getApprovalLineListJson(EmpApprovalLineDTO dto, Authentication auth, HttpServletResponse res) throws JsonProcessingException {
		log.info("실행");
		Pager pager = new Pager(3, 5, empService.getApprovalLineCount(auth.getName()), dto.getPageNo());
		pager.setEmpId(auth.getName());
		
		JSONObject json = new JSONObject();
		ObjectMapper mapper = new ObjectMapper();
		String pagerJson = mapper.writeValueAsString(pager);
		json.put("pager", pagerJson);
		
		List<EmpApprovalLineDTO> resultList = empService.getApprovalLineListByPager(pager);
		json.put("resultList", resultList);
		
		res.setContentType("application/json; charset=UTF-8");
		res.setCharacterEncoding("UTF-8");
		try(PrintWriter pw = res.getWriter()) {
			pw.println(json.toString());
			pw.flush();
		} catch(IOException ioex) {
			ioex.printStackTrace();
		}
	}
	
	@GetMapping("/searchApprovalLine")
	public void searchApprovalLine(EmpApprovalLineDTO dto, Authentication auth, HttpServletResponse res) throws JsonProcessingException {
		log.info("실행");
		dto.setEmpId(auth.getName());
		log.info(dto.toString());
		Pager pager = new Pager(3, 5, empService.getSearchApprovalLineCount(dto), dto.getPageNo());
		pager.setKeyword(dto.getKeyword());
		pager.setEmpId(auth.getName());
		
		List<EmpApprovalLineDTO> resultList = empService.getSearchApprovalLineList(pager);
		
		JSONObject json = new JSONObject();
		json.put("resultList", resultList);
		//json.put("pager", pager);
		
		ObjectMapper mapper = new ObjectMapper();
		String pagerJson = mapper.writeValueAsString(pager);
		json.put("pager", pagerJson);
		
		res.setContentType("application/json; charset=UTF-8");
		res.setCharacterEncoding("UTF-8");
		try(PrintWriter pw = res.getWriter()) {
			pw.println(json.toString());
			pw.flush();
		} catch(IOException ioex) {
			ioex.printStackTrace();
		}
	}
	
	@GetMapping("getDocumentContext")
	public void getDocumentContext(ApprovalDTO aprDTO, Authentication auth, HttpServletResponse res) {
		log.info("실행");
		aprDTO.setEmpId(auth.getName());
		ApprovalDTO docDTO = approvalService.getDocumentContext(aprDTO);
		String docData = Jsoup.parse(docDTO.getDocDocumentData()).getElementsByClass("doc-content").outerHtml();
		String docCss = approvalService.getDocCssByDocType(docDTO.getDocFormCode());
		
		JSONObject json = new JSONObject();
		json.put("html", docData);
		json.put("css", docCss);
		
		res.setContentType("application/json; charset=UTF-8");
		res.setCharacterEncoding("UTF-8");
		try(PrintWriter pw = res.getWriter()) {
			pw.println(json.toString());
			pw.flush();
		} catch(IOException ioex) {
			ioex.printStackTrace();
		}
	}
	
	@PostMapping("updateDocAprStatus")
	public void updateDocumentApprovalStatus(@RequestBody ApprovalDTO dto, Authentication auth, HttpServletResponse res) {
		log.info("실행");
		
		dto.setEmpId(auth.getName());
		JSONObject json = new JSONObject();
		if(!approvalService.updateDocAprStatus(dto)) {
			json.put("status", "impossible");
			json.put("message", "결재가 이미 진행 중이거나, 문서가 존재하지 않습니다.");
		} else {
			json.put("status", "ok");
		}
		
		res.setContentType("application/json; charset=UTF-8");
		res.setCharacterEncoding("UTF-8");
		try(PrintWriter pw = res.getWriter()) {
			pw.println(json.toString());
			pw.flush();
		} catch(IOException ioex) {
			ioex.printStackTrace();
		}
	}
	
	@PostMapping("deleteDoc")
	public void deactiveDocument(@RequestBody ApprovalDTO dto, Authentication auth, HttpServletResponse res) {
		log.info("실행");
		
		dto.setEmpId(auth.getName());
		JSONObject json = new JSONObject();
		if(!approvalService.deactivatedDocumentStatus(dto.getDocNumber())) {
			json.put("status", "impossible");
			json.put("message", "결재가 이미 진행 중이거나, 문서가 존재하지 않습니다.");
		} else {
			json.put("status", "ok");
		}
		
		res.setContentType("application/json; charset=UTF-8");
		res.setCharacterEncoding("UTF-8");
		try(PrintWriter pw = res.getWriter()) {
			pw.println(json.toString());
			pw.flush();
		} catch(IOException ioex) {
			ioex.printStackTrace();
		}
	}
	
	@PostMapping("submitApproval")
	public void submitApproval(@RequestBody ApprovalData data, Authentication auth, HttpServletResponse res) {
		log.info("실행");
		data.setApprovalDate(new Date());
		data.setApprover(auth.getName());
		log.info(data.toString());
		JSONObject json = new JSONObject();
		
		ApprovalDTO dto = approvalService.getDraftSingleByDocNumber(data.getDocNumber());
		dto.setNowApprover(empService.getEmpInfo(data.getApprover()));
		dto.setDocNumber(data.getDocNumber());
		Document doc = Jsoup.parse(data.getDocData());
		dto.setDocDocumentData(doc.body().getElementsByClass("doc-content").outerHtml());
		dto.setApproveInfo(new DocumentApprovalLineDTO());
		dto.getApproveInfo().setDocNumber(data.getDocNumber());
		dto.getApproveInfo().setDocAprApprover(data.getApprover());
		dto.getApproveInfo().setDocAprComment(data.getApprovalComment());
		dto.getApproveInfo().setDocAprDate(data.getApprovalDate());
		dto.getApproveInfo().setDocAprState(data.getApprovalResult());
		dto.getApproveInfo().setDocAprType(data.getApprovalType());
		dto.getApproveInfo().setDocAprSeq(data.getApprovalSeq());
		//dto.setDocAprStatus(approvalService.checkDocAprStatus(dto));
		//approvalService.approveDraft(dto);
		List<DocumentApprovalLineDTO> aprLineList = approvalService.getDraftApprovalLine(dto.getApproveInfo().getDocNumber());
		
		//결재 유형에 달리 로직을 수행.
		switch (dto.getApproveInfo().getDocAprType()) {
			case "대결":
				if(!approvalService.checkProxyForDraftApproval(dto)) {
					json.put("status", "no-authority");
					json.put("message", "결재 권한이 존재하지 않습니다. 대리자 설정을 확인해 주세요.");
					
					res.setContentType("application/json; charset=UTF-8");
					res.setCharacterEncoding("UTF-8");
					try(PrintWriter pw = res.getWriter()) {
						pw.println(json.toString());
						pw.flush();
					} catch(IOException ioex) {
						ioex.printStackTrace();
					}
					return;
				}
				dto.getApproveInfo().setDocAprProxy(auth.getName());
				dto.getApproveInfo().setApproverProxyInfo(empService.getEmpInfo(auth.getName()));
				dto.getApproveInfo().setDocAprApprover(approvalService.getDraftApprovalLine(data.getDocNumber()).get(data.getApprovalSeq()).getDocAprApprover());
			case "일반":
			case "전결":
				for(DocumentApprovalLineDTO item : aprLineList) {
					if(item.getDocAprSeq() == data.getApprovalSeq()) break;
					if(!item.getDocAprState().equals("승인")) {
						json.put("status", "no-approval-seq");
						json.put("message", "아직 선순위 결재자가 결재하지 않았습니다.\n선결을 통해 결재를 진행해 주세요.");
						
						res.setContentType("application/json; charset=UTF-8");
						res.setCharacterEncoding("UTF-8");
						try(PrintWriter pw = res.getWriter()) {
							pw.println(json.toString());
							pw.flush();
						} catch(IOException ioex) {
							ioex.printStackTrace();
						}
						return;
					}
				}
			case "선결":
				approvalService.approveDraft(dto);
		}
		
		json.put("status", "ok");
		
		// 알람 처리
		ApprovalDTO resultDraft = approvalService.getDraftSingleByDocNumber(data.getDocNumber());
		EmployeesDto draftor = empService.getEmpInfo(resultDraft.getEmpId());
		EmployeesDto approver = empService.getEmpInfo(auth.getName());
		if(resultDraft.getDocAprStatus().equals("승인") || resultDraft.getDocAprStatus().equals("반려")) {
			String alertContent = draftor.getEmpName()+" "+draftor.getPosition()+"님, ["+resultDraft.getDocNumber()+" / "+resultDraft.getDocTitle()+"] 문서가 "+resultDraft.getDocAprStatus()+"되었습니다.";
			alertService.sendAlert(draftor.getEmpId(), alertContent, "결재");
			
		} else {
			// 다음 결재자에게 알람 송신
			List<DocumentApprovalLineDTO> aprList = approvalService.getDraftApprovalLine(resultDraft.getDocNumber());
			for(DocumentApprovalLineDTO dal : aprList) {
				if (dal.getDocAprState().equals("대기")) {
					String alertContent = dal.getApproverInfo().getEmpName()+" "+dal.getApproverInfo().getPosition()+"님, 대기결재함에 ["+resultDraft.getDocNumber()+" / "+resultDraft.getDocTitle()+"] 문서가 상신되었습니다.";
					alertService.sendAlert(dal.getDocAprApprover(), alertContent, "결재");
					break;
				}
			}
			
			// 기안자에게 결재 결과 송신
			for(DocumentApprovalLineDTO dal : aprList) {
				if(dal.getDocAprApprover().equals(auth.getName())) {
					String alertContent = 
							draftor.getEmpName()+" "+draftor.getPosition()+"님, ["+resultDraft.getDocNumber()+" / "+resultDraft.getDocTitle()+"] 문서를 "+approver.getEmpName()+" "+approver.getPosition()+"께서 결재하였습니다. (결재 결과: "+dal.getDocAprState()+")";
					alertService.sendAlert(draftor.getEmpId(), alertContent, "결재");
					break;
				}
			}
		}
		
		res.setContentType("application/json; charset=UTF-8");
		res.setCharacterEncoding("UTF-8");
		try(PrintWriter pw = res.getWriter()) {
			pw.println(json.toString());
			pw.flush();
		} catch(IOException ioex) {
			ioex.printStackTrace();
		}
	}
	
	@InitBinder("alternateApproverDTO")
	public void altApproverSubmitBinder(WebDataBinder binder) {
		log.info("InitBinder 실행");
		binder.setValidator(new ArtApproverValidator());
	}
	
	@PostMapping("submitAltApprover")
	public void submitAltApprover(@RequestBody @Valid AlternateApproverDTO form, Errors error, Authentication auth, HttpServletResponse res) {
		log.info("실행");
		form.setEmpId(auth.getName());
		log.info("form data: "+form.toString());
		
		JSONObject json = new JSONObject();
		if(error.hasErrors()) {
			log.info("유효성 검출");
			JSONObject errors = new JSONObject();
			
            error.getFieldErrors().forEach(
            	fieldError -> errors.put(fieldError.getField(), fieldError.getDefaultMessage())
            );
            log.info(error.getFieldErrors().toString());
            
            // 사용자 입력 데이터 복원을 위한 데이터 반환.
            errors.put("form", form);
            json.put("status", "error");
            json.put("error", errors);
            
            res.setContentType("application/json; charset=UTF-8");
    		res.setCharacterEncoding("UTF-8");
    		try(PrintWriter pw = res.getWriter()) {
    			pw.println(json.toString());
    			pw.flush();
    		} catch(IOException ioex) {
    			ioex.printStackTrace();
    		}
    		return;
		}
		form.getAltAprStartDate().setHours(0);
		form.getAltAprEndDate().setHours(0);
		form.getAltAprEndDate().setDate(form.getAltAprEndDate().getDate()+1);
		form.getAltAprEndDate().setSeconds(form.getAltAprEndDate().getSeconds()-1);
		Date nowDate = new Date();
		if(form.getAltAprStartDate().getTime() <= nowDate.getTime() && nowDate.getTime() < form.getAltAprEndDate().getTime()) {
			form.setAltAprState(true);
		}
		
		approvalService.setAltApprover(form);
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
	
	@PostMapping("deleteAltApprove")
	public void deleteAltApprove(
			@RequestBody AlternateApproverDTO form, 
			Authentication auth, 
			HttpServletRequest req, 
			HttpServletResponse res) throws Exception {
	    log.info("실행");
	    form.setEmpId(auth.getName());
	    log.info("form data: " + form.toString());
	    
	    JSONObject json = new JSONObject();
	    if (approvalService.updateAltApproveByEmpid(form)) {
	        json.put("status", "ok");

	        StringWriter stringWriter = new StringWriter();
	        PrintWriter printWriter = new PrintWriter(stringWriter);

	        // JSP 파일을 포함하여 HTML 결과를 캡처
	        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/approval/approvalSettingsProxy.jsp");
	        dispatcher.include(req, new HttpServletResponseWrapper(res) {
	            @Override
	            public PrintWriter getWriter() {
	                return printWriter;
	            }
	        });

	        // HTML 내용 이스케이프 처리
	        log.info(stringWriter.toString());
	        String htmlContent = stringWriter.toString().replaceAll("\n", "").replaceAll("\r", "").replaceAll("\"", "\\\\\"");
	        json.put("html", htmlContent);
	    } else {
	        json.put("status", "fail");
	        json.put("message", "결재 권한을 위임했거나, 예정 중인 사원을 찾을 수 없습니다.");
	    }

	    res.setContentType("application/json; charset=UTF-8");
	    res.setCharacterEncoding("UTF-8");
	    PrintWriter pw = res.getWriter();
	    pw.println(json.toString());
	    pw.flush();
	    pw.close();
	}
	
	@GetMapping("getDeptList")
	public void getDeptList(HttpServletResponse res) throws IOException {
		log.info("실행");
		JSONObject json = new JSONObject();
		JSONArray deptId = new JSONArray();
		JSONArray deptName = new JSONArray();
		List<Departments> list = deptService.getDepartmentList();
		list.removeIf(item -> item.getDeptId() == 100 || item.getDeptId() == 999);
		list.forEach(item -> {
			deptId.put(item.getDeptId());
			deptName.put(item.getDeptName());
		});
		json.put("deptIds", deptId);
		json.put("deptNames", deptName);
		
		res.setContentType("application/json; charset=UTF-8");
	    res.setCharacterEncoding("UTF-8");
	    PrintWriter pw = res.getWriter();
	    pw.println(json.toString());
	    pw.flush();
	    pw.close();
	}
	
	@GetMapping("searchEmployees")
	public void searchEmployeesForAprLineModal(String keyword, HttpServletResponse res) throws IOException {
		log.info("실행");
		List<EmployeesDto> list = empService.getEmpInfoByKeyword(keyword);
		JSONArray arr = new JSONArray();
		list.stream().forEach(item -> {
			JSONObject obj = new JSONObject();
			obj.put("empId", item.getEmpId());
			obj.put("empName", item.getEmpName());
			obj.put("position", item.getPosition());
			arr.put(obj);
		});
		
		res.setContentType("application/json; charset=UTF-8");
	    res.setCharacterEncoding("UTF-8");
	    PrintWriter pw = res.getWriter();
	    pw.println(arr.toString());
	    pw.flush();
	    pw.close();
	}
	
	@GetMapping("download")
	public void getAttatchFile(String docNumber, int attachNo, HttpServletResponse res) throws IOException {
		log.info("실행");
		DocFilesDTO form = new DocFilesDTO();
		form.setDocNumber(docNumber);
		List<DocFilesDTO> result = approvalService.getDocAttachFile(form);
		
	    if (!result.isEmpty()) {
	        DocFilesDTO data = null;
	        for (DocFilesDTO item : result) {
	            if (item.getDocFileId() == attachNo) {
	                data = item;
	                break;
	            }
	        }
	        if (data != null) {
	            String contentType = data.getDocFileType();
	            res.setContentType(contentType);

	            String fileName = data.getDocFileName();
	            String encodingFileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
	            res.setHeader("Content-Disposition", "attachment; filename=\"" + encodingFileName + "\"");

	            ServletOutputStream out = res.getOutputStream();
	            out.write(data.getDocFileData());
	            out.flush();
	            out.close();
	            return;
	        }
	    }
	    
	    res.sendError(HttpServletResponse.SC_NOT_FOUND, "첨부파일을 찾을 수 없습니다.");
	}
}
