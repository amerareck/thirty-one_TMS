package com.oti.thirtyone.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oti.thirtyone.dao.DocFilesDAO;
import com.oti.thirtyone.dao.DocumentApprovalLineDAO;
import com.oti.thirtyone.dao.DocumentFolderDAO;
import com.oti.thirtyone.dao.DocumentManagementSeqDAO;
import com.oti.thirtyone.dao.DocumentReferenceDAO;
import com.oti.thirtyone.dto.ApprovalDTO;
import com.oti.thirtyone.dto.DocFilesDTO;
import com.oti.thirtyone.dto.DocumentApprovalLineDTO;
import com.oti.thirtyone.dto.DocumentReferenceDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
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
	
	public boolean setDraftForm(ApprovalDTO dto) {
		switch(dto.getDocFormCode()) {
			case "HLD" :
				return documentFolderDAO.insertDraftByHLD(dto) == 1;
			case "BTD" :
			case "BTR" :
				return documentFolderDAO.insertDraftByBT(dto) == 1;
			case "HLW" :
				return documentFolderDAO.insertDraftByHLW(dto) == 1;
			case "WOL" :
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

}
