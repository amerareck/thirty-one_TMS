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

	int insertHdrRequest(HolidayRequestDto holidayRequest);

	int countRowByDeptHoliday(int deptId);

	List<HolidayRequestDto> selectHdrByDept(@Param("deptId") int deptId, @Param("pager") Pager pager);

	List<HolidayRequestDto> selectDeptHdrCalendar(@Param("deptId")int deptId, @Param("month") String month);
	
	List<HolidayRequestDto> selectHdrListByAprId (@Param("hdrApprover") String hdrApprover, @Param("pager") Pager pager);
	
	int updateHdrAccept(@Param("hdrId") int hdrId, @Param("status") String status);
	
	int updateHdrUsedDay(String empId);
}
