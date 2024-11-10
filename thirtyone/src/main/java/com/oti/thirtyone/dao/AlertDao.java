package com.oti.thirtyone.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.oti.thirtyone.dto.AlertDto;
import com.oti.thirtyone.dto.Pager;

@Mapper
public interface AlertDao {

	int insertAlert(AlertDto alert);

	List<AlertDto> selectAlertListByEmpId(@Param("pager") Pager pager,@Param("empId") String empId);

	List<AlertDto> selectAlertListNotReaded(@Param("pager") Pager pager,@Param("empId") String empId);
	
	int countRowsByEmpId(String empId);

	int countRowsNotReaded(String empId);

	int updateStatusToRead(int alertId);


}
