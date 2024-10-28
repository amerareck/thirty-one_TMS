package com.oti.thirtyone.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oti.thirtyone.dao.EmployeesDao;
import com.oti.thirtyone.dto.EmployeesDto;

import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class EmployeesService {
	
	@Autowired
	EmployeesDao empDao;

	public void joinEmp(EmployeesDto empDto) {
		log.info(empDto.toString());
		empDao.insertEmp(empDto);
		
	}

	public int getDeptId(String empId) {
		int result = empDao.selectDeptId(empId);
		return result;
	}

	public boolean hasEmpId(String empId) {		
		return empDao.selectByEmpId(empId) != null ? false : true;
	}
	
	
}
