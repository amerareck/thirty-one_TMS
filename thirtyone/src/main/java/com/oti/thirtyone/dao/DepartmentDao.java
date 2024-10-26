package com.oti.thirtyone.dao;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DepartmentDao {

	String selectDeptName(int deptId);

	String selectRegionalOffice(int deptId);

}
