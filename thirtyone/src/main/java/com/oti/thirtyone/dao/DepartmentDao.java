package com.oti.thirtyone.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.oti.thirtyone.dto.Departments;

@Mapper
public interface DepartmentDao {

	String selectDeptName(int deptId);

	String selectRegionalOffice(int deptId);

	List<Departments> selectDeptList();

}
