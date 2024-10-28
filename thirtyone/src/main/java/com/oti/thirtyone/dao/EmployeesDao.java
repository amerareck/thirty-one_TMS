package com.oti.thirtyone.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.oti.thirtyone.dto.EmployeesDto;
import com.oti.thirtyone.dto.Pager;

@Mapper
public interface EmployeesDao {

	EmployeesDto selectByEmpId(String empId);

	int insertEmp(EmployeesDto empDto);

	int selectDeptId(String empId);

	int updateEmpPw(Map<String, String> empInfo);

	int updateEmpInfoByEmp(EmployeesDto empDto);

	List<EmployeesDto> selectEmpList(Pager pager);

	int countRows();

}
