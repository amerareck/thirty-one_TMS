package com.oti.thirtyone.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oti.thirtyone.dao.HolidayRequestDao;
import com.oti.thirtyone.dto.HolidayRequestDto;
import com.oti.thirtyone.dto.Pager;

import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class HolidayService {
	
	@Autowired
	HolidayRequestDao hdrReqDao;
	
	public List<HolidayRequestDto> getHdrReqAllbyEmpId(String empId, Pager pager) {
		return hdrReqDao.selectHdrAllByEmpId(empId, pager);
	}

	public int countRowsByEmpId(String empId) {
		return hdrReqDao.countRowsByEmpId(empId);
	}

}
