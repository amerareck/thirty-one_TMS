package com.oti.thirtyone.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.oti.thirtyone.dto.ApprovalDTO;
import com.oti.thirtyone.dto.DocumentApprovalLineDTO;
import com.oti.thirtyone.dto.PageParam;

@Mapper
public interface DocumentApprovalLineDAO {

	int insertDocumentApprovalLine(DocumentApprovalLineDTO dto);

	List<DocumentApprovalLineDTO> selectPenddingApprovalListById(PageParam param);

	List<DocumentApprovalLineDTO> selectDraftApprovalLineByDocNumber(String docNumber);

	DocumentApprovalLineDTO selectReviewingApproverEmpId(String docNumber);

	int updateDocAprStatus(ApprovalDTO dto);

	List<DocumentApprovalLineDTO> selectApprovalLineOneself(ApprovalDTO empId);

	List<String> selectDocNumberIncludeOneself(ApprovalDTO dto);

	int selectDocAprSeq(DocumentApprovalLineDTO documentApprovalLineDTO);

	int updateDraftApprovalLine(DocumentApprovalLineDTO dal);

	DocumentApprovalLineDTO selectAprLineOneByDocNumAndSeq(DocumentApprovalLineDTO documentApprovalLineDTO);

	List<String> selectDocNumbersIncludeUser(String name);

	List<String> selectApprovalWaitListDocNumberByEmpId(String empId);

	List<String> selectApproveReadyDocNumberByEmpId(String empId);

	int selectApprovalLineWaitSeqByDocNum(String docNumber);

	List<DocumentApprovalLineDTO> selectDocAprLinesByDocNumbers(List<ApprovalDTO> approveList);

	List<String> selectProxyApprovalDocNumberByEmpId(List<String> list);

}
