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

}
