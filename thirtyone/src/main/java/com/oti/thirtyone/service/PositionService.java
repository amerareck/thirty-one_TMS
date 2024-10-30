package com.oti.thirtyone.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oti.thirtyone.dao.EmployeesDao;
import com.oti.thirtyone.dao.PositionDao;
import com.oti.thirtyone.dto.PositionsDto;

import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class PositionService {
	@Autowired
	PositionDao posDao;
	@Autowired
	EmployeesDao empDao;
	
	public List<PositionsDto> getPosList() {
		return posDao.selectPosList();
	}

	public void createPos(String pos) {
		posDao.insertPos(pos);
		
	}

	public void moveUpPos(int posClass, int prePosClass) {
		posDao.updateMovePos(posClass, prePosClass);
	}
	
	@Transactional
	public void chagePosName(int posClass, String posName, String prePosName) {
		posDao.insertPos(posName);
		empDao.updateEmpPosAll(posName, prePosName);
		posDao.deletePos(prePosName);
		posDao.updatePosName(posClass, posName);
	}

	public String getPosName(int posClass) {
		return posDao.selectPosName(posClass);
	}
}
