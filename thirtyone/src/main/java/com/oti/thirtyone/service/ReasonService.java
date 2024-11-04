package com.oti.thirtyone.service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oti.thirtyone.dao.DocFilesDAO;
import com.oti.thirtyone.dao.ReasonDao;
import com.oti.thirtyone.dto.DocFilesDTO;
import com.oti.thirtyone.dto.ReasonDto;

import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class ReasonService {
	
	@Autowired
	ReasonDao reasonDao;
	
	@Autowired
	DocFilesDAO fileDao;
	
	@Transactional
	public void insertReason(ReasonDto reasonDto, String day) {
		reasonDao.insertReason(reasonDto, day);
		
	}

	public void insertReasonFile(DocFilesDTO fileDto) {
		fileDao.insertReasonFile(fileDto);
		
	}

	public boolean hasReasonOfDay(String empId, String day) {
		int reasonNum = reasonDao.selectReasonNum(empId, day);
		log.info(reasonNum);
		if(reasonNum > 0)
			return false;
		else
			return true;
	}

}
