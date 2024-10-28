package com.oti.thirtyone.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oti.thirtyone.dao.PositionDao;
import com.oti.thirtyone.dto.PositionsDto;

import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class PositionService {
	@Autowired
	PositionDao posDao;

	public List<PositionsDto> getPosList() {
		return posDao.selectPosList();
	}
}
