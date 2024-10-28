package com.oti.thirtyone.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oti.thirtyone.dao.NoticeDao;
import com.oti.thirtyone.dto.NoticeDto;
import com.oti.thirtyone.dto.NoticeFileDto;
import com.oti.thirtyone.dto.Pager;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class NoticeService {
	
	@Autowired
	private NoticeDao noticeDao;


	public void noticeWrite(NoticeDto notice) {
		noticeDao.noticeWrite(notice);
	}
	
	public void insertNoticeFile(NoticeFileDto notice) {
		noticeDao.insertNoticeFile(notice);
	}
	
	public List<NoticeDto> selectListPager(Pager pager) {
		List<NoticeDto> list = noticeDao.selectListPager(pager);
		return list;
	}
	
	public int countRows() {
		int totalRows = noticeDao.countRows();
		return totalRows;
	}
	
	//상세페이지 조회
	public NoticeDto selectByNoticeId(int noticeId) {
		return noticeDao.selectByNoticeId(noticeId);
	}
	
	//이전글 다음글
	public NoticeDto prevNext(int noticeId) {
		return noticeDao.prevNext(noticeId);
	}

	//파일
	public NoticeFileDto selectAttachByNoticeId(int noticeId) {
		NoticeFileDto noticeFile = noticeDao.selectAttachByNoticeId(noticeId);
		return noticeFile;
	}
	
	
	//공지사항 수정
	public void updateNotice(NoticeDto notice) {
		noticeDao.updateNotice(notice);
	}
	
	public void updateNoticeFile(NoticeFileDto notice) {
		noticeDao.updateNoticeFile(notice);
	}
	
	public void updateHitCount(int noticeId) {
		noticeDao.updateHitCount(noticeId);
	}
	
	//공지사항 삭제
	public void deleteNoticeFile(int noticeId) {
		noticeDao.deleteNoticeFile(noticeId);
	}

	public void deleteNotice(int noticeId) {
		noticeDao.deleteNotice(noticeId);
	}	
}

