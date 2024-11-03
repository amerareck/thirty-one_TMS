package com.oti.thirtyone.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.oti.thirtyone.dto.EmpApprovalLineDTO;
import com.oti.thirtyone.dto.Pager;

@Mapper
public interface ApprovalLineDAO {

	int insertApprovalLine(EmpApprovalLineDTO item);

	int insertNewApprovalLine(EmpApprovalLineDTO item);

	int selectCountApprovalLine(EmpApprovalLineDTO item);

	int updateApprovalLine(EmpApprovalLineDTO item);

	int deleteApprovalLine(EmpApprovalLineDTO item);

	List<EmpApprovalLineDTO> selectApprovalLineByIdx(EmpApprovalLineDTO item);

	EmpApprovalLineDTO selectApprovalLineName(EmpApprovalLineDTO dto);

	List<EmpApprovalLineDTO> selectAllApprovalLineByEmpId(String userId);

	List<EmpApprovalLineDTO> selectApprovalLineByPager(Pager pager);

}
