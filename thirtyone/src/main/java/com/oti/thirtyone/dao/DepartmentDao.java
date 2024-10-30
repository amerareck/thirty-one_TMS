package com.oti.thirtyone.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.oti.thirtyone.dto.Departments;
import com.oti.thirtyone.dto.Pager;

@Mapper
public interface DepartmentDao {

	String selectDeptName(int deptId);

	String selectRegionalOffice(int deptId);

	List<Departments> selectDeptList();

	List<Departments> selectDeptListByRegion(Pager pager);

	int insertDept(Departments deptDto);

	int updateDeptRegionalOffice(@Param("regionalOffice")String region, @Param("deptId") int deptId);

	int updateDeptHead(@Param("empId") String empId, @Param("deptId") int deptId);

	int updateDeptName(@Param("deptName") String deptName, @Param("deptId") int deptId);

	int deleteDept(int deptId);

	List<Departments> selectDepartments();

	int countRows();

}
