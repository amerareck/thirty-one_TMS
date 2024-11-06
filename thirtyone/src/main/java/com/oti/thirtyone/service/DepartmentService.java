package com.oti.thirtyone.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oti.thirtyone.dao.AttendanceDao;
import com.oti.thirtyone.dao.DepartmentDao;
import com.oti.thirtyone.dao.EmployeesDao;
import com.oti.thirtyone.dto.AttendanceDto;
import com.oti.thirtyone.dto.Departments;
import com.oti.thirtyone.dto.EmployeesDto;
import com.oti.thirtyone.dto.Pager;

import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class DepartmentService {

	@Autowired
	DepartmentDao deptDao;
	@Autowired
	AttendanceDao atdDao;
	@Autowired
	EmployeesDao empDao;

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

	public List<Departments> getDepartmentList() {
		return deptDao.selectDepartments();
	}

	public int countRows() {
		int totalRows = deptDao.countRows();
		return totalRows;
	}

	public Departments getDeptInfo(int deptId) {
		return deptDao.selectDept(deptId);
	}

	public Map<String, int[]> getDeptAtdStatus(int deptId) {
		int[] deptAtdStatus = new int[8]; //[출근, 퇴근, 출근전, 지각, 조퇴, 휴가, 출장, 결근]
		Map<String, int[]> deptAtdMap = new HashMap<>();
		
		List<EmployeesDto> empList = empDao.selectDeptEmpAll(deptId);
		for (EmployeesDto empDto : empList) {
			AttendanceDto atd = atdDao.selectAtdByEmpId(empDto.getEmpId());
			if(atd == null) {
				deptAtdStatus[2]++;
			}else {
				if(atd.getAtdState().equals("정상출근") && atd.getCheckOut() != null ) {
					deptAtdStatus[1]++;
				}else if(atd.getAtdState().equals("정상출근")) {
					deptAtdStatus[0]++;
				}else if(atd.getAtdState().equals("지각")) {
					deptAtdStatus[3]++;
				}else if(atd.getAtdState().equals("조퇴")) {
					deptAtdStatus[4]++;
				}else if(atd.getAtdState().equals("휴가")) {
					deptAtdStatus[5]++;
				}else if(atd.getAtdState().equals("출장")) {
					deptAtdStatus[6]++;
				}else if(atd.getAtdState().equals("결근")) {
					deptAtdStatus[7]++;
				}
			}
		}
		int[] deptAtdCur = new int[2];
		deptAtdCur[1] = deptAtdStatus[7] + deptAtdStatus[2] + deptAtdStatus[5] + deptAtdStatus[6];
		deptAtdCur[0] = empList.size() - deptAtdCur[1];
		
		deptAtdMap.put("deptAtdStatus", deptAtdStatus);
		deptAtdMap.put("deptAtdCur", deptAtdCur);
		return deptAtdMap;
	}


	
	
}
