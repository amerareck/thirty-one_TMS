package com.oti.thirtyone.DAO;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface EmployeesDao {

	EmployeesDao selectByMid(String username);

	String getMrole();

	String getMid();

	String getMpassword();

	boolean isMenabled();

}
