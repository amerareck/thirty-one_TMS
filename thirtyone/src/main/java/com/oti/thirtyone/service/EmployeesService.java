package com.oti.thirtyone.service;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oti.thirtyone.dao.ApprovalLineDAO;
import com.oti.thirtyone.dao.EmployeesDao;
import com.oti.thirtyone.dto.EmpApprovalLineDTO;
import com.oti.thirtyone.dto.EmployeesDto;
import com.oti.thirtyone.dto.Pager;

import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class EmployeesService {
	
	@Autowired
	EmployeesDao empDao;
	@Autowired
	ApprovalLineDAO empApprovalLineDAO;

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

	public void updateEmpPw(String empId, String empPassword) {
		Map<String, String> empInfo = new HashMap<>();
		empInfo.put("empId", empId);
		empInfo.put("empPassword", empPassword);
		empDao.updateEmpPw(empInfo);
	}

	public void updateEmpInfoByEmp(EmployeesDto empDto) {
		empDao.updateEmpInfoByEmp(empDto);
		
	}

	public void updateEmpInfoByAdmin(EmployeesDto empDto) {
		empDao.updateEmpInfoByAdmin(empDto);
	}

	public List<EmployeesDto> selectEmpList(Pager pager) {
		return empDao.selectEmpList(pager);
	}

	public int countRows() {
		int totalRows = empDao.countRows();
		return totalRows;
	}

	public EmployeesDto getEmpInfo(String empId) {
		return empDao.selectByEmpId(empId);
	}

	public List<EmployeesDto> getEmpListBySearch(String query, int category, Pager pager) {
		List<EmployeesDto> empList = new LinkedList<>();
		Map<String, Object> searchInfo = new HashMap<>();
		searchInfo.put("query", query);
		searchInfo.put("pager", pager);
		if(category == 0) {
			empList = empDao.selectEmpListByName(searchInfo);
		}else if(category == 1) {
			empList = empDao.selectEmpListByPos(searchInfo);
		}else {
			empList = empDao.selectEmpListByDept(searchInfo);
		}
			
		return empList;
	}

	public int countRowsBySearch(String query, int category) {
		
		if(category == 0) {
			return empDao.countRowsByName(query);
		}else if(category == 1) {
			return empDao.countRowsByPos(query);
		}else {
			return empDao.countRowsByDept(query);
		}
			
	}

	public EmployeesDto getEmpInfoByEmpNum(int empNumber) {
		return empDao.selectEmpInfoByeEmpNum(empNumber);
		
	}

	public int countRowsByDept(int deptId) {
		return empDao.countRowsByDeptId(deptId); 
	}

	public void updateEmpDept(String empId, int deptId) {
		empDao.updateEmpDept(empId, deptId);
	}
	
	public List<EmployeesDto> getEmployeeListByDeptId(int deptId) {
		return empDao.selectEmployeesByDeptId(deptId);
	}

	public void updateEmpDept(List<String> empIdList, int deptId) {
		for(String empId : empIdList) 
			empDao.updateEmpDept(empId, deptId);
		
	}

	public List<EmployeesDto> getEmpInfoByName(String empName) {
		return empDao.selectEmpInfoByName(empName);
	}

	public boolean setApprovalLine(List<EmpApprovalLineDTO> aplForm) {
		if(aplForm == null || aplForm.isEmpty()) return false;
		
		if (isApprovalLineName(aplForm.get(0))) {
			return updateApprovalLine(aplForm);
		} else {
			for (EmpApprovalLineDTO item : aplForm) {
		        if (empApprovalLineDAO.insertNewApprovalLine(item) != 1) {
		            return false;
		        }
		    }
		}
	    
	    return true;
	}
	
	public boolean isApprovalLineName(EmpApprovalLineDTO dto) {
		return empApprovalLineDAO.selectApprovalLineName(dto) != null;
	}
	
	public boolean updateApprovalLine(List<EmpApprovalLineDTO> aplForm) {
		if(aplForm == null || aplForm.isEmpty()) return false;
		
		int len = empApprovalLineDAO.selectCountApprovalLine(aplForm.get(0));
		if(aplForm.size() == len) {
			for(EmpApprovalLineDTO item : aplForm) {
				if(empApprovalLineDAO.updateApprovalLine(item) != 1) {
					return false;
				}
			}
		} else if(aplForm.size() > len) {
			for(int i=0; i<len; i++) {
				if(empApprovalLineDAO.updateApprovalLine(aplForm.get(i)) != 1) return false;
			}
			for(int i=len; i<aplForm.size(); i++) {
				if(empApprovalLineDAO.insertApprovalLine(aplForm.get(i)) != 1) return false;
			}
		} else if(aplForm.size() < len) {
			for(int i=0; i<aplForm.size(); i++) {
				if(empApprovalLineDAO.updateApprovalLine(aplForm.get(i)) != 1) return false;
			}
			aplForm = empApprovalLineDAO.selectApprovalLineByIdx(aplForm.get(aplForm.size()-1));
			for(int i=0; i<aplForm.size(); i++) {
				if(empApprovalLineDAO.deleteApprovalLine(aplForm.get(i)) != 1) return false;
			}
		}
		return true;
	}
	
	public List<EmpApprovalLineDTO> getApprovalLineListByUserId(String userId) {
		return empApprovalLineDAO.selectAllApprovalLineByEmpId(userId);
	}
	
	public List<EmpApprovalLineDTO> getApprovalLineListByPager(Pager pager) {
		return empApprovalLineDAO.selectApprovalLineByPager(pager);
	}
}
