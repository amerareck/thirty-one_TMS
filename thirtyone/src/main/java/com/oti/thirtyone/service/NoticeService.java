package com.oti.thirtyone.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oti.thirtyone.dao.NoticeDao;
import com.oti.thirtyone.dto.NoticeDto;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class NoticeService {
	
	@Autowired
	private NoticeDao noticeDao;


	public void insertNotice(NoticeDto notice) {
		noticeDao.insertNotice(notice);
	}
}

