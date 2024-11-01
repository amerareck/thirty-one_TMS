package com.oti.thirtyone.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.oti.thirtyone.dto.AttendanceDto;

@Mapper
public interface AttendanceDao {

	int selectCheckInToday(String empId);

	int insertCheckIn(String empId);

	int updateCheckOut(String empId);

	AttendanceDto selectAtdByEmpId(String empId);

	List<AttendanceDto> selectAtdMonthly(@Param("empId") String empId, @Param("month") String month);

}
