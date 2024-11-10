package com.oti.thirtyone.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.oti.thirtyone.dto.ApprovalDTO;
import com.oti.thirtyone.dto.HolidayDto;

@Mapper
public interface HolidayDao {

	HolidayDto selectAnnualHoliday(String empId);

	HolidayDto selectSubstituteHoliday(String empId);

	int insertAlternateHoliday(ApprovalDTO apr);

	int selectAltHolidayCount(ApprovalDTO apr);

	List<HolidayDto> selectHolidayByEmpId(String empId);
}
