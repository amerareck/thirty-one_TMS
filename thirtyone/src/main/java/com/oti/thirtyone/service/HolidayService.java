package com.oti.thirtyone.service;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oti.thirtyone.dao.AttendanceDao;
import com.oti.thirtyone.dao.DocumentFolderDAO;
import com.oti.thirtyone.dao.EmployeesDao;
import com.oti.thirtyone.dao.HolidayDao;
import com.oti.thirtyone.dao.HolidayRequestDao;
import com.oti.thirtyone.dao.PositionDao;
import com.oti.thirtyone.dto.ApprovalDTO;
import com.oti.thirtyone.dto.CalendarDto;
import com.oti.thirtyone.dto.HolidayDto;
import com.oti.thirtyone.dto.HolidayRequestDto;
import com.oti.thirtyone.dto.Pager;
import com.oti.thirtyone.dto.PositionsDto;

import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class HolidayService {

	@Autowired
	HolidayRequestDao hdrDao;

	@Autowired
	HolidayDao holidayDao;

	@Autowired
	EmployeesDao empDao;
	
	@Autowired
	AttendanceDao atdDao;
	
	@Autowired
	DocumentFolderDAO docFolderDao;
	
	@Autowired
	PositionDao positionDao;

	public List<HolidayRequestDto> getHdrReqAllbyEmpId(String empId, Pager pager) {
		return hdrDao.selectHdrAllByEmpId(empId, pager);
	}

	public int countRowsByEmpId(String empId) {
		return hdrDao.countRowsByEmpId(empId);
	}
	
	public int countRowsByEmpIdForPorcess(String empId) {
		return hdrDao.countRowsByEmpIdForPorcess(empId);
	}


	public CalendarDto formatInputCalendar(String empName, String title, Date startdate, Date enddate,
			String background, String border, String text) {
		CalendarDto atdCalendarDto = new CalendarDto();

		String startyear = "20" + (startdate.getYear() + "").split("1")[1];
		String startmonth = String.valueOf(startdate.getMonth() + 1);
		String startday = String.valueOf(startdate.getDate()).length() > 1 ? String.valueOf(startdate.getDate())
				: "0" + startdate.getDate();

		String endyear = "20" + (enddate.getYear() + "").split("1")[1];
		String endmonth = String.valueOf(enddate.getMonth() + 1);
		String endday = String.valueOf(enddate.getDate()).length() > 1 ? String.valueOf(enddate.getDate() + 1)
				: "0" + (enddate.getDate() + 1);

		atdCalendarDto.setTitle(empName + "휴가");
		atdCalendarDto.setStart(startyear + "-" + startmonth + "-" + startday);
		atdCalendarDto.setEnd(endyear + "-" + endmonth + "-" + endday);
		atdCalendarDto.setBackgroundColor(background);
		atdCalendarDto.setBorderColor(border);
		atdCalendarDto.setTextColor(text);

		return atdCalendarDto;
	}

	public List<CalendarDto> getHdrCalendar(String empId, String year, String month) {
		List<HolidayRequestDto> hdrList = hdrDao.selectHdrByEmpId(empId);
		List<CalendarDto> hdrCalList = new LinkedList<CalendarDto>();

		for (HolidayRequestDto hdrReq : hdrList) {
			hdrCalList.add(formatInputCalendar("", "휴가", hdrReq.getHdrStartDate(), hdrReq.getHdrEndDate(), "rgba(31, 95, 255)", "rgba(31, 95, 255)", "white"));
		}
		List<ApprovalDTO> eventHdrList = docFolderDao.selectHdrByEmpId(empId);
		for(ApprovalDTO eventHdr : eventHdrList) {
			if(eventHdr.getDocHolidayType() != null) {
				if(eventHdr.getDocHolidayType().equals("familyEvent")){
					hdrCalList.add(formatInputCalendar("", "경조사", eventHdr.getDocHolidayStartDate(), eventHdr.getDocHolidayEndDate(), "#F5F5F5", "#F5F5F5)", "black"));
				}else if(eventHdr.getDocHolidayType().equals("sickLeave")) {
					hdrCalList.add(formatInputCalendar("", "병가", eventHdr.getDocHolidayStartDate(), eventHdr.getDocHolidayEndDate(),  "#F5F5F5", "#F5F5F5)", "black"));
				}
			}
		}
		return hdrCalList;
	}

	public double[] getRemainHoliday(String empId) {
		HolidayDto hd = holidayDao.selectAnnualHoliday(empId);
		double[] holiday = new double[2];
		holiday[0] = hd.getHdUsed();
		holiday[1] = hd.getHdCount() - hd.getHdUsed();
		return holiday;
	}

	public HolidayDto getAnnualHoliday(String empId) {
		return holidayDao.selectAnnualHoliday(empId);
	}

	public HolidayDto getSubstituteHoliday(String empId) {
		return holidayDao.selectSubstituteHoliday(empId);
	}

	public void insertHdrRequest(HolidayRequestDto holidayRequest) {
		hdrDao.insertHdrRequest(holidayRequest);
	}

	public int countRowsByDeptHoliday(int deptId) {
		return hdrDao.countRowByDeptHoliday(deptId);
	}

	public List<HolidayRequestDto> getHdrByDept(int deptId, Pager pager) {
		return hdrDao.selectHdrByDept(deptId, pager);
	}

	public List<CalendarDto> getDeptHdrCalendar(int deptId, String year, String month) {
		List<HolidayRequestDto> hdrList = hdrDao.selectDeptHdrCalendar(deptId, year + "/" + month + "/15");
		List<CalendarDto> hdrCalList = new LinkedList<CalendarDto>();
		for (HolidayRequestDto hdrReq : hdrList) {
			String empName = empDao.selectByEmpId(hdrReq.getHdrEmpId()).getEmpName();
			hdrCalList.add(formatInputCalendar(empName, "휴가", hdrReq.getHdrStartDate(), hdrReq.getHdrEndDate(),
					"rgba(31, 95, 255)", "rgba(31, 95, 255)", "white"));
		}
		return hdrCalList;
	}

	@Transactional
	public boolean setAlternateHoliday(ApprovalDTO apr) {
		HolidayDto result = holidayDao.selectAltHolidayDataById(apr);
		if(result == null) {
			result = new HolidayDto();
			result.setEmpId(apr.getEmpId());
			result.setHdCategory(2);
			result.setHdCount(0);
			result.setHdUsed(0);
			if(holidayDao.insertHolidayData(result) != 1) throw new RuntimeException("대체휴가 삽입 에러");
		}
		result.setHdCount(result.getHdCount()+1);
		if(holidayDao.updateAlternateHoliday(result) != 1) throw new RuntimeException("대체휴가 업데이트 에러");
		else return true;
	}

	public List<HolidayDto> getHolidayByEmpId(String empId) {
		List<HolidayDto> holiday = holidayDao.selectHolidayByEmpId(empId);
		return holiday;
	}

	public List<HolidayRequestDto> selectHdrListByAprId(String hdrApprover, Pager pager) {
		List<HolidayRequestDto> hdrAprList = hdrDao.selectHdrListByAprId(hdrApprover, pager);
		return hdrAprList;
	}

	@Transactional
	public void updateHdrAccept(int hdrId, String status, String empId, int hdCategory) {
		log.info("status" + status);
		hdrDao.updateHdrAccept(hdrId, status);
		if (status.equals("승인")) {
			HolidayRequestDto hdrDto = hdrDao.selectHdrByHdrId(hdrId);
			atdDao.insertHdrPeriod(hdrDto);
			holidayDao.updateHdrCount(empId, hdrDto.getHdrUsedDay(), hdCategory);
		}
	}	
		
	public void updateRequestForm(HolidayRequestDto holidayRequest) {
		hdrDao.updateRequestForm(holidayRequest);
	}
	
	//db에서 수정할 정보 가져오기
	public List<HolidayRequestDto> selectHolidayRequestById(int hdrId) {
		List<HolidayRequestDto> hdrList = hdrDao.selectHolidayRequestById(hdrId);
		return hdrList;
	}
	
	//직급 정보 가져오기
	public List<PositionsDto> selectHdrPosition(int hdrId) {
		List<PositionsDto> positionList = positionDao.selectHdrPosition(hdrId);
		return positionList;
	}

	public void deleteRequest(int hdrId) {
		hdrDao.deleteRequest(hdrId);
	}

	public int countRowsByApproverId(String approverId) {
		return hdrDao.countRowsByApproverId(approverId);
	}
}