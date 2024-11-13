package com.oti.thirtyone.dao;

import java.util.List;

import javax.validation.Valid;

import org.apache.ibatis.annotations.Mapper;

import com.oti.thirtyone.dto.AlternateApproverDTO;

@Mapper
public interface AlternateApproverDAO {

	AlternateApproverDTO selectAltApproverOne(AlternateApproverDTO dto);
	int updateAltApproverState(AlternateApproverDTO dto);
	int insertAltApprover(@Valid AlternateApproverDTO form);
	AlternateApproverDTO selectCurrentAltApprover(String empId);
	List<AlternateApproverDTO> selectCurrentProxyInfoByEmpId(String empId);
	List<String> selectProxyEmpIdsByAltAprEmp(String altAprEmp);
	int updateAltApprover(AlternateApproverDTO alt);

}
