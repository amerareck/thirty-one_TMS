package com.oti.thirtyone.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oti.thirtyone.dao.NoticeDao;
import com.oti.thirtyone.dto.NoticeDto;
import com.oti.thirtyone.dto.NoticeFileDto;
import com.oti.thirtyone.dto.NoticeTargetDto;
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
	
	//검색
	public List<NoticeDto> searchNotice(String noticeTitle, Pager pager) {
		List<NoticeDto> list = noticeDao.searchNotice(noticeTitle, pager);
		return list;
	}
	
	public int searchCountRows(String noticeTitle, int deptId) {
		int totalRows = noticeDao.searchCountRows(noticeTitle, deptId);
		return totalRows;
	}	
	
	//부서별 조회
	public List<NoticeDto> searchNoticeByDeptId(String noticeTitle, Pager pager, int deptId) {		
		/*List<NoticeDto> list = noticeDao.searchNoticeByDeptId(deptId, pager);
		return list;*/
		return noticeDao.searchNoticeByDeptId(noticeTitle, pager, deptId);
	}
	
	//부서별 검색
	public List<NoticeDto> empSearchNotice(String noticeTitle, int deptId, Pager pager) {
		List<NoticeDto> list = noticeDao.empSearchNotice(noticeTitle, pager, deptId);
		return list;
	}
	
	public int searchDeptIdCountRows(int deptId) {
		int totalRows = noticeDao.searchDeptIdCountRows(deptId);
		return totalRows;
	}

	//특정파일
	public NoticeFileDto selectAttachByNoticeId(int noticeId) {
		NoticeFileDto noticeFile = noticeDao.selectAttachByNoticeId(noticeId);
		return noticeFile;
	}
	
	//여러파일
	public List<NoticeFileDto> selectAttachFiles(int noticeId) {
		List<NoticeFileDto> noticeFiles = noticeDao.selectAttachFiles(noticeId);
		return noticeFiles;
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
	/*public void deleteNoticeFile(int noticeId) {
		noticeDao.deleteNoticeFile(noticeId);
	}*/

	/*public void deleteNotice(int noticeId) {
		noticeDao.deleteNotice(noticeId);
	}*/

	public void deactivateNoticeById(int noticeId) {
		noticeDao.deactivateNoticeById(noticeId);
	}
	
	public void deleteFileFromDb(int fileId) {
		noticeDao.deleteFileFromDb(fileId);
	}
	
	//부서
	public void insertNoticeTarget(NoticeDto notice) { 	
		log.info(notice.toString());
		if(notice.getExistingDeptId() != null && notice.getDeptId() != null) {
			for(int exDeptId : notice.getExistingDeptId()) {
				boolean isCheckedDeptId = false;
				for(int deptId : notice.getDeptId()) {
					if(deptId == exDeptId) isCheckedDeptId=true;
					if(noticeDao.hasNoticeTarget(deptId, notice.getNoticeId()) == 0)
						noticeDao.insertNoticeTargetOne(deptId, notice.getNoticeId());
				}
				if(!isCheckedDeptId) noticeDao.deleteNoticeTarget(exDeptId, notice.getNoticeId()); 
				
			}
		}else if(notice.getExistingDeptId() == null && notice.getDeptId() != null) {
			for(int deptId : notice.getDeptId()) {
				if(noticeDao.hasNoticeTarget(deptId, notice.getNoticeId()) == 0)
					noticeDao.insertNoticeTargetOne(deptId, notice.getNoticeId());
			}
		}else if(notice.getDeptId() == null && notice.getExistingDeptId() != null) {
			for(int exDeptId: notice.getExistingDeptId()) {
				noticeDao.deleteNoticeTarget(exDeptId, notice.getNoticeId());
			}
			noticeDao.updateNoticeTargetToZero(notice);
		}
	}

	public void updateNoticeTarget(NoticeDto notice) {
		noticeDao.updateNoticeTarget(notice);
	}

	public List<NoticeTargetDto> selectDeptId(int noticeId) {
		List<NoticeTargetDto> notice = noticeDao.selectDeptId(noticeId);
		return notice;
	}

	public boolean hasNoticeFileId(int noticeFileId) {		
		int hasFile = noticeDao.hasNoticeFileId(noticeFileId);
		if (hasFile == 0) {
			return true;
		} else {
			return false;
		}
	}


}

