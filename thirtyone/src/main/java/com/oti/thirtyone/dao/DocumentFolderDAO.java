package com.oti.thirtyone.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.oti.thirtyone.dto.ApprovalDTO;

@Mapper
public interface DocumentFolderDAO {

	int insertDraftByHLD(ApprovalDTO dto);
	int insertDraftByBT(ApprovalDTO dto);
	int insertDraftByHLW(ApprovalDTO dto);
	int insertDraftByWOL(ApprovalDTO dto);
	List<ApprovalDTO> selectDraftDocumentById(String name);
	ApprovalDTO selectDocumentContext(ApprovalDTO aprDTO);
	int updateDocAprStatus(ApprovalDTO dto);
	ApprovalDTO selectRecalledDocument(ApprovalDTO dto);
	List<ApprovalDTO> selectRecalledDocumentsById(String empId);
	int updateDeactivateDocument(String prevDocNumber);
	List<ApprovalDTO> selectDraftWaitForApproval(String empId);
	ApprovalDTO selectDraftSingleByDocNumber(String docNumber);
	int updateDraftDocumentFromApprove(ApprovalDTO dto);

	String selectOverTimeStatus(@Param("thisDay") Date thisDay, @Param("empId") String empId);
	
}
