package com.oti.thirtyone.dao;

import org.apache.ibatis.annotations.Mapper;

import com.oti.thirtyone.dto.ApprovalDTO;

@Mapper
public interface DocumentManagementSeqDAO {

	// 문서 번호 생성을 위한 자료 입력
	int insertDocumentInfo(ApprovalDTO dto);

	ApprovalDTO selectRecentDocumentInfo(ApprovalDTO dto);

}
