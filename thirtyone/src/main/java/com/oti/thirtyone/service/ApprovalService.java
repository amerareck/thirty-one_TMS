package com.oti.thirtyone.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oti.thirtyone.dao.AlternateApproverDAO;
import com.oti.thirtyone.dao.DocFilesDAO;
import com.oti.thirtyone.dao.DocumentApprovalLineDAO;
import com.oti.thirtyone.dao.DocumentFolderDAO;
import com.oti.thirtyone.dao.DocumentFormDAO;
import com.oti.thirtyone.dao.DocumentManagementSeqDAO;
import com.oti.thirtyone.dao.DocumentReferenceDAO;
import com.oti.thirtyone.dto.AlternateApproverDTO;
import com.oti.thirtyone.dto.ApprovalDTO;
import com.oti.thirtyone.dto.DocFilesDTO;
import com.oti.thirtyone.dto.DocumentApprovalLineDTO;
import com.oti.thirtyone.dto.DocumentReferenceDTO;
import com.oti.thirtyone.dto.Pager;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class ApprovalService {
	@Autowired
	DocumentFolderDAO documentFolderDAO;
	@Autowired
	DocumentManagementSeqDAO docMgtSeqDAO;
	@Autowired
	DocFilesDAO docFilesDAO;
	@Autowired
	DocumentApprovalLineDAO docApprovalLineDAO;
	@Autowired
	DocumentReferenceDAO docReferDAO;
	@Autowired
	DocumentFormDAO docFormDAO;
	@Autowired
	AlternateApproverDAO altApproverDAO;
	@Autowired
	AttendanceService atdService;
	@Autowired
	EmployeesService empService;
	@Autowired
	DepartmentService deptService;
	@Autowired
	HolidayService hdService;
	
	public boolean setDraftForm(ApprovalDTO dto) {
		switch(dto.getDocFormCode()) {
			case "HLD" :
				return documentFolderDAO.insertDraftByHLD(dto) == 1;
			case "BTD" :
			case "BTR" :
				return documentFolderDAO.insertDraftByBT(dto) == 1;
			case "HLW" :
				return documentFolderDAO.insertDraftByHLW(dto) == 1;
			case "WOT" :
				return documentFolderDAO.insertDraftByWOL(dto) == 1;
		}
		log.info("기안 DB 반영 실패");
		return false;
	}
	
	public boolean setDraftAttachFile(DocFilesDTO dto) {
		return docFilesDAO.insertDraftAttachFile(dto) == 1;
	}

	public String getDocType(String draftType) {
		switch (draftType) {
			case "holidayDocument":
				return "HLD";
			case "businessTripDocument":
				return "BTD";
			case "businessTripReport":
				return "BTR";
			case "holidayWork":
				return "HLW";
			case "workOvertime":
				return "WOT";
		}
		return null;
	}

	public String createDocNumber(ApprovalDTO dto) {
		dto.setDocMgtYear(dto.getDocDraftDate().getYear()+1900);
		docMgtSeqDAO.insertDocumentInfo(dto);
		
		ApprovalDTO aplDto = docMgtSeqDAO.selectRecentDocumentInfo(dto);
		int seq = 10000 + aplDto.getDocMgtSeq();

		return aplDto.getDocFormCode()+"-"+aplDto.getDeptId()+"-"+aplDto.getDocMgtYear()+"-"+Integer.toString(seq).substring(1);
	}

	public boolean setApprovalLineFromDoc(ApprovalDTO dto) {
		List<DocumentApprovalLineDTO> dal = dto.getDocApprovalLine();
		boolean result = true;
		for(DocumentApprovalLineDTO dalDTO : dal) {
			if(docApprovalLineDAO.insertDocumentApprovalLine(dalDTO) != 1) {
				result = false;
			}
		}
		return result;
	}

	public boolean setDocumentReference(ApprovalDTO dto) {
		boolean result = true;
		for(DocumentReferenceDTO ele : dto.getDocReferenceList()) {
			if(docReferDAO.insertDocumentReference(ele) != 1) result = false;
		}
		
		return result;
	}

	public List<ApprovalDTO> getDraftDocumentById(String name) {
		return documentFolderDAO.selectDraftDocumentById(name);
	}

	public List<DocumentApprovalLineDTO> getDraftApprovalLine(String docNumber) {
		List<DocumentApprovalLineDTO> dal = docApprovalLineDAO.selectDraftApprovalLineByDocNumber(docNumber);
		dal.forEach(item -> {
		    if (item.getDocAprProxy() != null) {
		        item.setApproverInfo(empService.getEmpInfo(item.getDocAprProxy()));
		    }
		    item.setApproverInfo(empService.getEmpInfo(item.getDocAprApprover()));
		    item.getApproverInfo().setDeptName(deptService.getDeptName(item.getApproverInfo().getDeptId()));
		});
		
		return dal;
	}

	public List<DocumentReferenceDTO> getDraftReferenceList(String docNumber) {
		return docReferDAO.selectDraftReferenceList(docNumber);
	}

	public ApprovalDTO getDocumentContext(ApprovalDTO aprDTO) {
		return documentFolderDAO.selectDocumentContext(aprDTO);
	}

	public String getDocCssByDocType(String docFormCode) {
		switch (docFormCode) {
			case "HLD" :
				return "holidayDocument.css";
			case "BTD" :
				return "businessTripDocument.css";
			case "BTR" :
				return "businessTripReport.css";
			case "HLW" :
				return "holidayWork.css";
			case "WOT" :
				return "workOvertime.css";
		}
		return null;
	}

	public boolean updateDocAprStatus(ApprovalDTO dto) {
		boolean result = documentFolderDAO.updateDocAprStatus(dto) == 1;
		
		if(result) {
			ApprovalDTO recall = documentFolderDAO.selectRecalledDocument(dto);
			docApprovalLineDAO.updateDocAprStatus(recall);
			docReferDAO.deleteDocumentReferences(recall);
		}
		return result;
	}

	public List<ApprovalDTO> getRecallDocumentListById(String empId) {
		return documentFolderDAO.selectRecalledDocumentsById(empId);
	}

	public ApprovalDTO getDraftDocumentSingle(ApprovalDTO param) {
		return documentFolderDAO.selectRecalledDocument(param);
	}

	public boolean deactivatedDocumentStatus(String prevDocNumber) {
		return documentFolderDAO.updateDeactivateDocument(prevDocNumber) == 1;
	}

	public List<ApprovalDTO> getDraftWaitForApproval(ApprovalDTO apr) {
		List<List<DocumentApprovalLineDTO>> dict = new ArrayList<>();
		
		// 자신이 결재자로 등록된 문서 번호 획득.
		List<String> docNumberList = docApprovalLineDAO.selectDocNumberIncludeOneself(apr);
		// 문서 번호를 기준으로 결재자 라인 획득. (문서1 == 결재라인1)
		for(String docNumber : docNumberList) {
			apr.setDocNumber(docNumber);
			dict.add(docApprovalLineDAO.selectApprovalLineOneself(apr));
		}
		
		// 결재라인 묶음 중에서 자신의 결재 순번이 아니면 제거.
		// 자신의 결재 순번이 0이 아니면서, 자신의 앞 순번이 "대기"면 제거.
		Iterator<List<DocumentApprovalLineDTO>> iterator = dict.iterator();
		while (iterator.hasNext()) {
		    List<DocumentApprovalLineDTO> ele = iterator.next();
		    
		    for (int i=0; i<ele.size(); i++) {
		        if (ele.get(i).getDocAprApprover().equals(apr.getEmpId())) {
		            if (i==0 || !ele.get(i-1).getDocAprState().equals("대기")) break;  
		            iterator.remove();
		            break;
		        }
		    }
		}
		
		// 정리된 문서 번호를 기준으로 ApprovalDTO를 받아오고 리턴.
		List<ApprovalDTO> result = new ArrayList<>();
		for(int i=0; i<dict.size(); i++) {
			ApprovalDTO element = documentFolderDAO.selectDraftSingleByDocNumber(dict.get(i).get(0).getDocNumber());
			element.setDocApprovalLine(dict.get(i));
			element.setDocReferenceList(docReferDAO.selectDraftReferenceList(dict.get(i).get(0).getDocNumber()));
			element.setNowApprover(empService.getEmpInfo(apr.getEmpId()));
			element.setReviewingApprover(element.getNowApprover().getEmpId());
			element.setReviewingApproverDeptId(element.getNowApprover().getDeptId());
			element.setReviewingApproverDeptName(deptService.getDeptName(element.getReviewingApproverDeptId()));
			element.setReviewingApproverPosition(element.getNowApprover().getPosition());
			element.setDocFormName(docFormDAO.selectDocFormName(element.getDocFormCode()));
			result.add(element);
		}
		return result;
	}
	
	public List<String> getApproveReadyDocNumberByEmpId(String empId) {
		return docApprovalLineDAO.selectApprovalWaitListDocNumberByEmpId(empId);
	}
	
	public List<String> getApprovalRecentStepListDocNumberByEmpId(String empId) {
		return docApprovalLineDAO.selectApproveReadyDocNumberByEmpId(empId);
	}
	
	public ApprovalDTO getDraftSingleByDocNumber(String docNumber) {
		return documentFolderDAO.selectDraftSingleByDocNumber(docNumber);
	}
	
	public List<ApprovalDTO> getDraftsByDocNumbers(Pager pager) {
		return documentFolderDAO.selectDraftsByDocNumbers(pager);
	}

	public String getDocFormName(String docFormCode) {
		return docFormDAO.selectDocFormName(docFormCode);
	}

	@Transactional
	public void approveDraft(ApprovalDTO dto) {
		DocumentApprovalLineDTO dal = dto.getApproveInfo();
		// 결재선 반영
		if(dal.getDocAprComment().isEmpty()) dal.setDocAprComment("의견 없음");
		docApprovalLineDAO.updateDraftApprovalLine(dal);
		
		switch (dal.getDocAprState()) {
			case "보류":
				dto.setDocAprStatus("진행");
				documentFolderDAO.updateDraftDocumentFromApprove(dto);
				break;
			case "반려":
				dto.setDocAprStatus("반려");
				documentFolderDAO.updateDraftDocumentFromApprove(dto);		
				try {
					updateDocAprStateToDelegation(dto);
				} catch (Exception e) {
					throw new RuntimeException("결재선 반영 에러", e);
				}
				break;
			case "승인":
				if(dal.getDocAprType().equals("일반") || dal.getDocAprType().equals("대결")) {
					dal.setDocAprSeq(dal.getDocAprSeq()+1);
					if(docApprovalLineDAO.selectAprLineOneByDocNumAndSeq(dal) != null) {
						dto.setDocAprStatus("진행");
						documentFolderDAO.updateDraftDocumentFromApprove(dto);
						break;
					}
				}
				dto.setDocAprStatus("승인");
				documentFolderDAO.updateDraftDocumentFromApprove(dto);
				
				try {
					updateDocAprStateToDelegation(dto);
					afterApprove(dto);
				} catch (Exception e) {
					throw new RuntimeException("승인 결재 후 에러", e);
				}
				break;
		}
	}
	
	@Transactional
	public void updateDocAprStateToDelegation(ApprovalDTO dto) {
		List<DocumentApprovalLineDTO> dal = docApprovalLineDAO.selectApprovalLineOneself(dto);
		for(int i=dto.getApproveInfo().getDocAprSeq()+1; i<dal.size(); i++) {
			DocumentApprovalLineDTO param = new DocumentApprovalLineDTO();
			param.setDocNumber(dal.get(i).getDocNumber());
			param.setDocAprSeq(i);
			param.setDocAprState("위임");
			param.setDocAprComment("의견 없음");
			param.setDocAprDate(new Date());
			param.setDocAprApprover(dal.get(i).getDocAprApprover());
			docApprovalLineDAO.updateDraftApprovalLine(param);
		}
		
		if(dto.getApproveInfo().getDocAprType().equals("선결")) {
			int seq = docApprovalLineDAO.selectApprovalLineWaitSeqByDocNum(dto.getDocNumber());
			for(int i=dto.getApproveInfo().getDocAprSeq()-1; i>=seq; i--) {
				DocumentApprovalLineDTO param = new DocumentApprovalLineDTO();
				param.setDocNumber(dal.get(i).getDocNumber());
				param.setDocAprSeq(i);
				param.setDocAprState("후열");
				param.setDocAprComment("의견 없음");
				param.setDocAprDate(new Date());
				param.setDocAprApprover(dal.get(i).getDocAprApprover());
				docApprovalLineDAO.updateDraftApprovalLine(param);
			}
		}
	}
	
	@Transactional
	public void afterApprove(ApprovalDTO apr) {
		try {
			apr = documentFolderDAO.selectDraftSingleByDocNumber(apr.getDocNumber());
			switch (apr.getDocFormCode()) {
				case "HLD":
					apr.setAtdState("휴가");
					atdService.updateAtdStateByApproval(apr);
					break;
				case "BTD":
					apr.setAtdState("출장");
					atdService.updateAtdStateByApproval(apr);
					break;
				case "HLW":
					hdService.setAlternateHoliday(apr);
					break;
				case "WOT":
					atdService.updateAtdStateByApproval(apr);
					break;
				default:
					throw new RuntimeException("결재 승인 후 처리 무시됨");
			}
		} catch (Exception e) {
			throw new RuntimeException("승인 이후 추가 처리 로직에서 예외 발생", e);
		}
	}

	public boolean checkProxyForDraftApproval(ApprovalDTO dto) {
		DocumentApprovalLineDTO dal = docApprovalLineDAO.selectAprLineOneByDocNumAndSeq(dto.getApproveInfo());
		AlternateApproverDTO param = new AlternateApproverDTO();
		param.setEmpId(dal.getDocAprApprover());
		param.setAltAprEmp(dto.getNowApprover().getEmpId());
		param = altApproverDAO.selectAltApproverOne(param);
		if(param != null) {
			//return altApproverDAO.updateAltApproverState(param) == 1;
			return param.isAltAprState();
		}
		else {
			return false;
		}
	}

	public List<String> getDocNumberToAprLineIncludeUser(String name) {
		return docApprovalLineDAO.selectDocNumbersIncludeUser(name);
	}

	public List<ApprovalDTO> getApproveDraftForEmpId(String empId) {
		return documentFolderDAO.selectApproveDraftByEmpId(empId);
	}

	public List<DocumentApprovalLineDTO> getDocAprLinesByDocNumbers(List<ApprovalDTO> approveList) {
		return docApprovalLineDAO.selectDocAprLinesByDocNumbers(approveList);
	}

	public List<DocumentReferenceDTO> getDocRefsByDocNumbers(List<ApprovalDTO> approveList) {
		return docReferDAO.selectDocRefsByDocNumbers(approveList);
	}

	public List<ApprovalDTO> getRejectDraftForEmpId(String empId) {
		return documentFolderDAO.selectRejectDraftByEmpId(empId);
	}

	public List<ApprovalDTO> getDepartmentsDrafts(int deptId) {
		return documentFolderDAO.selectDepartmentsDrafts(deptId);
	}

	public List<ApprovalDTO> getDepartmentsCompleteDrafts(int deptId) {
		return documentFolderDAO.selectDepartmentsCompleteDrafts(deptId);
	}

	public List<ApprovalDTO> getDraftsForReference(String empId) {
		return documentFolderDAO.selectDraftsForReference(empId);
	}

	public boolean setAltApprover(AlternateApproverDTO form) {
		return altApproverDAO.insertAltApprover(form) == 1;
	}

	public AlternateApproverDTO getCurrentAltApproverInfoByEmpId(String empId) {
		return altApproverDAO.selectCurrentAltApprover(empId);
	}
	
	public List<AlternateApproverDTO> getCurrentProxyInfoByEmpId(String empId) {
		return altApproverDAO.selectCurrentProxyInfoByEmpId(empId);
	}

	public List<String> getProxyApprovalDocNumbersByEmpId(List<String> list) {
		return docApprovalLineDAO.selectProxyApprovalDocNumberByEmpId(list);
	}

	public List<String> getProxyEmpIdsById(String altAprEmp) {
		return altApproverDAO.selectProxyEmpIdsByAltAprEmp(altAprEmp);
	}

	public List<ApprovalDTO> getAllDraftsByEmpId(String empId) {
		return documentFolderDAO.selectAllDraftsByEmpId(empId);
	}

	public boolean updateAltApproveByEmpid(AlternateApproverDTO form) {
		AlternateApproverDTO alt = altApproverDAO.selectAltApproverOne(form);
		if(alt != null) {
			Calendar calendar = Calendar.getInstance();
			calendar.set(Calendar.YEAR, 1900);
			alt.setAltAprEndDate(calendar.getTime());
			calendar.set(Calendar.MONTH, Calendar.DECEMBER);
			calendar.set(Calendar.DATE, 31);
			alt.setAltAprStartDate(calendar.getTime());
			alt.setAltAprState(false);
			
			altApproverDAO.updateAltApprover(alt);
			return true;
		} else {
			return false;
		}
	}

	public void checkAltApproverByAllEmp() {
		List<AlternateApproverDTO> altList = altApproverDAO.selectAltApproverDateByAllEmp();
		
		// 기간 지난 대결자 지정 및 기간 도래한 대결자 지정.
		if(altApproverDAO.updateAltApproverStateByList(altList) < 1) {
			throw new RuntimeException("대결자 업데이트 스케쥴러 에러");
		};
		
	}

}
