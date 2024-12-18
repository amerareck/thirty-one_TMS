package com.oti.thirtyone.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.oti.thirtyone.dto.NoticeDto;
import com.oti.thirtyone.dto.NoticeFileDto;
import com.oti.thirtyone.dto.NoticeTargetDto;
import com.oti.thirtyone.dto.Pager;

@Mapper
public interface NoticeDao {
	//공지사항 작성
	 public int noticeWrite(NoticeDto notice);

	 //공지사항 첨부파일
	 public int insertNoticeFile(NoticeFileDto notice);
	 
	 //공지사항 조회
	 public List<NoticeDto> selectListPager(Pager pager);	 
	 public int countRows();
	 
	 //공지사항 검색
	 public List<NoticeDto> searchNotice(@Param("noticeTitle") String noticeTitle, @Param("pager") Pager pager);
	 public int searchCountRows(@Param("noticeTitle") String noticeTitle, @Param("deptId")int deptId);
	 
	 //공지사항 부서별 조회
	 public List<NoticeDto> searchNoticeByDeptId(@Param("noticeTitle") String noticeTitle, @Param("pager") Pager pager, @Param("deptId") int deptId);
	 public int searchDeptIdCountRows(int deptId);
	 public List<NoticeDto> empSearchNotice(@Param("noticeTitle") String noticeTitle, @Param("pager") Pager pager, @Param("deptId") int deptId);

	 
	 //공지사항 상세페이지 조회
	 public NoticeDto selectByNoticeId(int noticeId);	 
	 public NoticeFileDto selectAttachByNoticeId(int noticeId);
	 public List<NoticeFileDto> selectAttachFiles(int noticeId);
	 public NoticeDto prevNext(int noticeId);
	 
	 //공지사항 수정
	 public int updateNotice(NoticeDto notice);
	 public int updateNoticeFile(NoticeFileDto notice);
	
	 //조회수
	 public int updateHitCount(int noticeId);
	 
	 //공지사항 삭제
	 /*public int deleteNoticeFile(int noticeId);*/
	 /*public int deleteNotice(int noticeId);*/
	 public int deactivateNoticeById(int noticeId);
	 public int deleteFileFromDb(int fileId);

	 //부서
	 public int insertNoticeTarget(NoticeDto notice);
	 public int updateNoticeTarget(NoticeDto notice);
	 public List<NoticeTargetDto> selectDeptId(int noticeId);

	 //파일 수정
	 public int hasNoticeFileId(int noticeFileId);

	 public int hasNoticeTarget(@Param("deptId") int deptId, @Param("noticeId") int noticeId);

	public int insertNoticeTargetOne(@Param("deptId") int deptId, @Param("noticeId") int noticeId);

	public int deleteNoticeTarget(@Param("deptId") int exDeptId, @Param("noticeId") int noticeId);

	public int updateNoticeTargetToZero(NoticeDto notice);

	

}
