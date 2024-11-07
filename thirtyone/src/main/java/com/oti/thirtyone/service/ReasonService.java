package com.oti.thirtyone.service;

import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oti.thirtyone.dao.AttendanceDao;
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
	@Autowired
	AttendanceDao adtDao;
	
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

	@Transactional
	public void updateReasonStatus(int reasonId, String empId, String atdDate, String status) {
		reasonDao.updateReasonStatus(reasonId, status);
		if(status.equals("승인")) {
			adtDao.updateStatus(reasonId, empId, atdDate);
		}
		reasonDao.updateReasonCompletedDate(reasonId);
	}

	public List<ReasonDto> getReasonList(Pager pager) {
		return reasonDao.selectReasonList(pager);
	}

	public int countRows() {
		return reasonDao.countRows();
	}

	public void updateReason(ReasonDto reasonDto) {
		reasonDao.updateReason(reasonDto);
		
	}

	public void deleteFile(int fileId) {
		fileDao.deleteReasonFile(fileId);
		
	}

	public List<ReasonDto> getLatestReason() {
		return reasonDao.selectLatestReason(6);
	}

}
