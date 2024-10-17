package com.oti.thirtyone.DAO;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface EmployeesDao {

	EmployeesDao selectByempId(String username);

	String getempRole();

	String getEmpId();

	String getEmpPassword();

	boolean isEnabled();

}
