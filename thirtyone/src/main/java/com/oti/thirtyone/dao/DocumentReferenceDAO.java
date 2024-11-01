package com.oti.thirtyone.dao;

import org.apache.ibatis.annotations.Mapper;

import com.oti.thirtyone.dto.DocumentReferenceDTO;

@Mapper
public interface DocumentReferenceDAO {

	int insertDocumentReference(DocumentReferenceDTO dr);

}
