package com.oti.thirtyone.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.oti.thirtyone.dto.ApprovalDTO;
import com.oti.thirtyone.dto.DocumentReferenceDTO;

@Mapper
public interface DocumentReferenceDAO {

	int insertDocumentReference(DocumentReferenceDTO dr);

	List<DocumentReferenceDTO> selectDraftReferenceList(String docNumber);

	int deleteDocumentReferences(ApprovalDTO dto);

}
