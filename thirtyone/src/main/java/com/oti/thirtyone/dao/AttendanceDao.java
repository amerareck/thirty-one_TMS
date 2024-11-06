package com.oti.thirtyone.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.oti.thirtyone.dto.AttendanceDto;

@Mapper
public interface AttendanceDao {

	int selectCheckInToday(String empId);

	int insertCheckIn(@Param("empId") String empId,@Param("state") String state);

	int updateCheckOut(@Param("empId") String empId,@Param("state") String state);

	AttendanceDto selectAtdByEmpId(String empId);

	List<AttendanceDto> selectAtdForMonths(@Param("empId") String empId, @Param("month") String month);

	List<AttendanceDto> selectAtdMonthly(@Param("empId") String empId, @Param("month") String string);

	List<AttendanceDto> selectAtdWeekly(@Param("monday") String monday, @Param("sunday") String sunday, @Param("empId") String empId);

	AttendanceDto selectAtdOneDay(@Param("empId") String empId,@Param("day") String day);

	AttendanceDto selectAtdOneDayByDate(@Param("empId")String empId,@Param("day") Date atdDate);

	int updateStatus(@Param("reasonId")int reasonId,@Param("empId") String empId, @Param("atdDate") String atdDate);



}
