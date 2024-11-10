package com.oti.thirtyone.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oti.thirtyone.dao.ApprovalLineDAO;
import com.oti.thirtyone.dao.AttendanceDao;
import com.oti.thirtyone.dao.DocumentApprovalLineDAO;
import com.oti.thirtyone.dao.EmployeesDao;
import com.oti.thirtyone.dto.AttendanceDto;
import com.oti.thirtyone.dto.DocumentApprovalLineDTO;
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
	@Autowired
	DocumentApprovalLineDAO docAprLineDAO;
	@Autowired
	AttendanceDao atdDao;

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
	
	@Transactional
	public boolean setApprovalLine(List<EmpApprovalLineDTO> aplForm) {
		if(aplForm == null || aplForm.isEmpty()) return false;
		
		for (EmpApprovalLineDTO item : aplForm) {
	        if (empApprovalLineDAO.insertNewApprovalLine(item) != 1) {
	            throw new RuntimeException();
	        }
	    }
	    return true;
	}
	
	public boolean updateApprovalLine(List<EmpApprovalLineDTO> aplForm) {
		if(aplForm == null || aplForm.isEmpty()) return false;
		
		if(aplForm.get(0).getAprLineIndex() == 0) {
			aplForm.forEach(item -> {
				item.setAprLineIndex(empApprovalLineDAO.selectApprovalLineIndexbyName(item).getAprLineIndex());
				item.setAprLineName(item.getChangeName());
			});
		}
		empApprovalLineDAO.deleteApprovalLine(aplForm.get(0));
		for(EmpApprovalLineDTO empAPL : aplForm) {
			if(empApprovalLineDAO.insertApprovalLine(empAPL) != 1) return false;
		}
		
		return true;
	}
	
	public List<EmpApprovalLineDTO> getApprovalLineListByUserId(String userId) {
		return empApprovalLineDAO.selectAllApprovalLineByEmpId(userId);
	}
	
	public List<EmpApprovalLineDTO> getApprovalLineListByUserId(String userId, String aprLineName) {
		EmpApprovalLineDTO dto = new EmpApprovalLineDTO();
		dto.setEmpId(userId);
		dto.setAprLineName(aprLineName);
		
		return empApprovalLineDAO.selectApprovalLineByLineName(dto);
	}
	
	public List<EmpApprovalLineDTO> getApprovalLineListByPager(Pager pager) {
		return empApprovalLineDAO.selectApprovalLineByPager(pager);
	}

	public int getApprovalLineCount(String name) {
		EmpApprovalLineDTO dto = new EmpApprovalLineDTO();
		dto.setEmpId(name);
		return empApprovalLineDAO.selectApprovalLineTotalCount(dto);
	}

	public List<EmpApprovalLineDTO> getApprovalLineListByIndex(EmpApprovalLineDTO dto) {
		return empApprovalLineDAO.selectApprovalLineListByIndex(dto);
	}

	public boolean removeEmpApprovalLine(EmpApprovalLineDTO dto) {
		return empApprovalLineDAO.deleteApprovalLine(dto) == 1;
	}

	public int getSearchApprovalLineCount(EmpApprovalLineDTO dto) {
		return empApprovalLineDAO.selectApprovalLineCountByKeyword(dto);
	}

	public List<EmpApprovalLineDTO> getSearchApprovalLineList(Pager pager) {
		return empApprovalLineDAO.selectApprovalLineListByKeyword(pager);
	}

	public List<String> getApprovalLineNames(String empId) {
		return empApprovalLineDAO.selectApprovalLineNames(empId);
	}

	public EmpApprovalLineDTO getApprovalLineIndexByName(EmpApprovalLineDTO dto) {
		return empApprovalLineDAO.selectApprovalLineIndexbyName(dto);
	}

	public EmployeesDto getReviewingApprover(String docNumber) {
		DocumentApprovalLineDTO empId = docAprLineDAO.selectReviewingApproverEmpId(docNumber);
		if(empId == null) return null;
		
		EmployeesDto result = getEmpInfo(empId.getDocAprApprover());
		result.setDocAprState(empId.getDocAprState());
		return result;
	}

	public EmployeesDto getLastApprover(String lastApprover) {
		return getEmpInfo(lastApprover);
	}

	public int getNewEmpNumber() {
		int empNumber = empDao.selectLatestEmpNumber();
		return empNumber + 1;
	}

	public List<EmployeesDto> getEmpAllByDeptId(EmployeesDto empDto, Pager pager) {
		List<EmployeesDto> empList = empDao.selectEmpAllByDeptId(empDto, pager);
		return empList;
	}

	public Map<String, int[]> getEmpAtdStatus() {
		int[] empAtdStatus = new int[8]; //[출근, 퇴근, 출근전, 지각, 조퇴, 휴가, 출장, 결근]
		Map<String, int[]> empAtdMap = new HashMap<>();
		
		List<EmployeesDto> empList = empDao.selectEmpAll();
		for (EmployeesDto empDto : empList) {
			AttendanceDto atd = atdDao.selectAtdByEmpId(empDto.getEmpId());
			if(atd == null) {
				empAtdStatus[2]++;
			}else {
				if(atd.getAtdState().equals("정상출근") && atd.getCheckOut() != null ) {
					empAtdStatus[1]++;
				}else if(atd.getAtdState().equals("정상출근")) {
					empAtdStatus[0]++;
				}else if(atd.getAtdState().equals("지각")) {
					empAtdStatus[3]++;
				}else if(atd.getAtdState().equals("조퇴")) {
					empAtdStatus[4]++;
				}else if(atd.getAtdState().equals("휴가")) {
					empAtdStatus[5]++;
				}else if(atd.getAtdState().equals("출장")) {
					empAtdStatus[6]++;
				}else if(atd.getAtdState().equals("결근")) {
					empAtdStatus[7]++;
				}
			}
		}
		int[] empAtdCur = new int[2];
		empAtdCur[1] = empAtdStatus[7] + empAtdStatus[2] + empAtdStatus[5] + empAtdStatus[6];
		empAtdCur[0] = empList.size() - empAtdCur[1];
		
		empAtdMap.put("deptAtdStatus", empAtdStatus);
		empAtdMap.put("deptAtdCur", empAtdCur);
		return empAtdMap;
	}

	public List<EmployeesDto> getEmpInfoHead() {
		return empDao.selectEmpInfoHead();
	}
	
	//직원조회
	public List<EmployeesDto> getEmployeesByPosition(String positionClass) {
		return empDao.getEmployeesByPosition(positionClass);
	}

	//모든 직원 목록
	public List<EmployeesDto> getAllEmployees() {
		return empDao.selectAllEmployees();
	}

//	@Transactional
	public void absenceProccess() {
		List<String> empList = empDao.getEmployeesIfAbsence();
		for(String empId : empList) {
			log.info(empId);
			atdDao.insertAtdIfAbsence(empId);	
		}
		
	}

	public List<EmployeesDto> getEmployeeListByEmpId(List<String> list) {
		return empDao.selectEmployeeListByEmpIds(list);
	}
}
