package com.oti.thirtyone.dao;

import org.apache.ibatis.annotations.Mapper;

import com.oti.thirtyone.dto.AlternateApproverDTO;

@Mapper
public interface AlternateApproverDAO {

	AlternateApproverDTO selectAltApproverOne(AlternateApproverDTO dto);
	int updateAltApproverState(AlternateApproverDTO dto);

}
