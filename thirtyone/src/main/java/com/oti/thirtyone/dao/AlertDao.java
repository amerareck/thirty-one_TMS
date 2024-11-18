package com.oti.thirtyone.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.oti.thirtyone.dto.AlertDto;
import com.oti.thirtyone.dto.Pager;

@Mapper
public interface AlertDao {

	int insertAlert(AlertDto alert);

	List<AlertDto> selectAlertListByEmpId(@Param("pager") Pager pager,@Param("empId") String empId, @Param("query") String query);

	List<AlertDto> selectAlertListNotReaded(@Param("empId") String empId);
	
	int countRowsByEmpId(@Param("empId") String empId, @Param("query") String query);

	int countRowsNotReaded(String empId);

	int updateStatusToRead(int alertId);

	int insertAlertAll(List<AlertDto> alertList);

	List<Integer> selectAlertSeq(int size);


}
