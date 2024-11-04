package com.oti.thirtyone.dao;

import org.apache.ibatis.annotations.Mapper;

import com.oti.thirtyone.dto.ApprovalDTO;

@Mapper
public interface DocumentFolderDAO {

	int insertDraftByHLD(ApprovalDTO dto);
	int insertDraftByBT(ApprovalDTO dto);
	int insertDraftByHLW(ApprovalDTO dto);
	int insertDraftByWOL(ApprovalDTO dto);
	
}