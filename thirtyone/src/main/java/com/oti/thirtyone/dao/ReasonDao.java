package com.oti.thirtyone.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.oti.thirtyone.dto.Pager;
import com.oti.thirtyone.dto.ReasonDto;

@Mapper
public interface ReasonDao {

	int insertReason(@Param("reason") ReasonDto reasonDto, @Param("day") String day);

	int selectReasonNum(@Param("empId") String empId, @Param("day") String day);

	List<ReasonDto> selectReasonListByImprover(@Param("empId") String empId, @Param("pager") Pager pager);

	int countRowsByImprover(String empId);

	ReasonDto selectReason(int reasonId);

	int updateReasonStatus(int reasonId);

	int updateReasonCompletedDate(int reasonId);

	int countRows();

	List<ReasonDto> selectReasonList(Pager pager);

}
