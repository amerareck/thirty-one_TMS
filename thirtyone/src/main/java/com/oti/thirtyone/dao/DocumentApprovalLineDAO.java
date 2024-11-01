package com.oti.thirtyone.dao;

import org.apache.ibatis.annotations.Mapper;

import com.oti.thirtyone.dto.DocumentApprovalLineDTO;

@Mapper
public interface DocumentApprovalLineDAO {

	int insertDocumentApprovalLine(DocumentApprovalLineDTO dto);

}
