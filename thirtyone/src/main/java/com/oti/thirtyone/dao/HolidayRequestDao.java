package com.oti.thirtyone.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.oti.thirtyone.dto.HolidayRequestDto;
import com.oti.thirtyone.dto.Pager;

@Mapper
public interface HolidayRequestDao {

	List<HolidayRequestDto> selectHdrAllByEmpId(@Param("empId") String empId, @Param("pager") Pager pager);

	int countRowsByEmpId(String empId);

	List<HolidayRequestDto> selectHdrByEmpId(String empId);

}
