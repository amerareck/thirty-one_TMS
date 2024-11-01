package com.oti.thirtyone.dao;

import org.apache.ibatis.annotations.Mapper;

import com.oti.thirtyone.dto.DocFilesDTO;

@Mapper
public interface DocFilesDAO {

	int insertDraftAttachFile(DocFilesDTO dto);

}
