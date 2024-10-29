package com.oti.thirtyone.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oti.thirtyone.dao.DepartmentDao;
import com.oti.thirtyone.dto.Departments;
import com.oti.thirtyone.dto.Pager;

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

	public List<Departments> getDeptList() {
		return deptDao.selectDeptList();
	}


	public List<Departments> getDeptListByRegion(Pager pager) {
		return deptDao.selectDeptListByRegion(pager);
	}

	public void createDept(Departments deptDto) {
		deptDao.insertDept(deptDto);
		
	}

	public void updateDeptRegionalOffice(String region, int deptId) {
		deptDao.updateDeptRegionalOffice(region, deptId);
		
	}

	public void updateDeptHead(String empId, int deptId) {
		deptDao.updateDeptHead(empId, deptId);
		
	}


	public void updateDeptName(String deptName, int deptId) {
		deptDao.updateDeptName(deptName, deptId);
	}

	public void deleteDept(int deptId) {
		deptDao.deleteDept(deptId);
	}
	
	
}
