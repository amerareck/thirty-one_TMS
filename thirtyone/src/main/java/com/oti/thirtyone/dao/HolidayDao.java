package com.oti.thirtyone.dao;

import org.apache.ibatis.annotations.Mapper;

import com.oti.thirtyone.dto.ApprovalDTO;
import com.oti.thirtyone.dto.HolidayDto;

@Mapper
public interface HolidayDao {

	HolidayDto selectAnnualHoliday(String empId);

	HolidayDto selectSubstituteHoliday(String empId);

	int insertHolidayData(HolidayDto result);

	HolidayDto selectAltHolidayDataById(ApprovalDTO apr);

	int updateAlternateHoliday(HolidayDto result);
}
