package com.oti.thirtyone.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oti.thirtyone.dao.DocFilesDAO;
import com.oti.thirtyone.dao.ReasonDao;
import com.oti.thirtyone.dto.DocFilesDTO;
import com.oti.thirtyone.dto.Pager;
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

	public List<ReasonDto> getReasonListByImprover(String empId, Pager pager) {
		return reasonDao.selectReasonListByImprover(empId, pager);
		
	}

	public int countRowsByImprover(String empId) {
		return reasonDao.countRowsByImprover(empId);
	}

	public ReasonDto getReasoninfo(int reasonId) {
		return reasonDao.selectReason(reasonId);
	}

	public DocFilesDTO getReasonFile(int fileId) {
		return fileDao.selectReasonFile(fileId);
	}

	public List<DocFilesDTO> getReasonFileList(int reasonId) {
		return fileDao.selectReasonFileList(reasonId);
	}

	public void updateReasonStatus(int reasonId) {
		reasonDao.updateReasonStatus(reasonId);
	}

}
