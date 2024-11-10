package com.oti.thirtyone.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.oti.thirtyone.dto.ApprovalDTO;
import com.oti.thirtyone.dto.HolidayDto;

@Mapper
public interface HolidayDao {

	HolidayDto selectAnnualHoliday(String empId);

	HolidayDto selectSubstituteHoliday(String empId);

	int insertHolidayData(HolidayDto result);

	HolidayDto selectAltHolidayDataById(ApprovalDTO apr);

	int updateAlternateHoliday(HolidayDto result);
	
	int selectAltHolidayCount(ApprovalDTO apr);

	List<HolidayDto> selectHolidayByEmpId(String empId);

	HolidayDto selectHdInfo(@Param("empId") String empId, @Param("hdCategory") int hdCategory);

	int updateHdrCount(@Param("empId") String empId, @Param("hdUsed") double hdrUsedDay, @Param("hdCategory") int hdCategory);
}
