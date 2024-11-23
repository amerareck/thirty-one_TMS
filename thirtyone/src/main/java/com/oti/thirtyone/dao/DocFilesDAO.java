package com.oti.thirtyone.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.oti.thirtyone.dto.DocFilesDTO;

@Mapper
public interface DocFilesDAO {

	int insertDraftAttachFile(DocFilesDTO dto);

	int insertReasonFile(DocFilesDTO fileDto);

	DocFilesDTO selectReasonFile(int fileId);

	List<DocFilesDTO> selectReasonFileList(int reasonId);

	int deleteReasonFile(int fileId);

	List<DocFilesDTO> selectDocAttachFileList(DocFilesDTO form);
	List<DocFilesDTO> selectDocAttachFilesNoData(DocFilesDTO docfile);

}
