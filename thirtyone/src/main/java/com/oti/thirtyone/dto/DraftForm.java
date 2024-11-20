package com.oti.thirtyone.dto;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class DraftForm {
	private String draftType; // 기안 유형
	private String docNumber; // 문서 번호
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date holidayStartDate; // 휴가 시작일
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date holidayEndDate; // 휴가 종료일
	private String holidayType; // 휴가 유형
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date bizTripStartDate; // 출장 시작일
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date bizTripEndDate; // 출장 종료일
	private String bizTripPurposeForm; // 출장 목표
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date holidayWorkStartDate; // 휴일 근무 종료일
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private Date workOvertimeEndDate; // 연장 근무 종료 시간
	private String draftTitle; // 기안 제목
	private List<String> draftReference; // 참조자 리스트
	private List<String> draftApprovalLine; // 결재선
	private MultipartFile draftAttachFile; // 첨부파일
	private String documentData; // 기안서
	
	private String prevDocNumber; // 재기안 문서번호
	private boolean redraft; // 재기안 확인
	private List<EmployeesDto> redraftAprLineList; // 재기안 결재라인 리스트
	private String approvalLineSelect; // 북마크 결재선 이름
	
	public boolean isWeekend(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);

        return (dayOfWeek == Calendar.SATURDAY || dayOfWeek == Calendar.SUNDAY);
    }
}
