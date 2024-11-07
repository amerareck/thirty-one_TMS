package com.oti.thirtyone.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.oti.thirtyone.dto.EmployeesDto;
import com.oti.thirtyone.dto.Pager;

@Mapper
public interface EmployeesDao {

	EmployeesDto selectByEmpId(String empId);

	int insertEmp(EmployeesDto empDto);

	int selectDeptId(String empId);

	int updateEmpPw(Map<String, String> empInfo);

	int updateEmpInfoByEmp(EmployeesDto empDto);

	int updateEmpInfoByAdmin(EmployeesDto empDto);

	List<EmployeesDto> selectEmpList(Pager pager);

	int countRows();

	List<EmployeesDto> selectEmpListByName(Map<String, Object> searchInfo);

	List<EmployeesDto> selectEmpListByPos(Map<String, Object> searchInfo);

	List<EmployeesDto> selectEmpListByDept(Map<String, Object> searchInfo);

	int countRowsByName(String query);

	int countRowsByPos(String query);

	int countRowsByDept(String query);

	EmployeesDto selectEmpInfoByeEmpNum(int deptHead);

	int countRowsByDeptId(int deptId);

	int updateEmpDept(@Param("empId") String empId, @Param("deptId") int deptId);

	int updateEmpPosAll(@Param("posName") String posName, @Param("prePos") String prePosName);

	List<EmployeesDto> selectEmpInfoByName(String empName);

	List<EmployeesDto> selectEmployeesByDeptId(int deptId);

	int selectLatestEmpNumber();

	List<EmployeesDto> selectEmpAllByDeptId(@Param("emp") EmployeesDto empDto, @Param("pager") Pager pager);

	List<EmployeesDto> selectDeptEmpAll(int deptId);

	List<EmployeesDto> selectEmpAll();

	List<EmployeesDto> selectEmpInfoHead();

}
