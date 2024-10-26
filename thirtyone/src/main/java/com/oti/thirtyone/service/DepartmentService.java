package com.oti.thirtyone.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oti.thirtyone.dao.DepartmentDao;

import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class DepartmentService {

	@Autowired
	DepartmentDao deptDao;

	public String getDeptName(int deptId) {
		String result = deptDao.selectDeptName(deptId);		
		return result;
	}

	public String getRegionalOffice(int deptId) {
		String result = deptDao.selectRegionalOffice(deptId);
		return result;
	}
	
	
}
