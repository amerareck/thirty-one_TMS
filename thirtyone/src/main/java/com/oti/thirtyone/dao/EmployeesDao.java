package com.oti.thirtyone.dao;

import org.apache.ibatis.annotations.Mapper;

import com.oti.thirtyone.dto.EmployeesDto;

@Mapper
public interface EmployeesDao {

	EmployeesDto selectByEmpId(String empId);

	int insertEmp(EmployeesDto empDto);

	int selectDeptId(String empId);

}
