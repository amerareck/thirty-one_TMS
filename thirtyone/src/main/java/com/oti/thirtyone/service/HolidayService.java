package com.oti.thirtyone.service;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oti.thirtyone.dao.EmployeesDao;
import com.oti.thirtyone.dao.HolidayDao;
import com.oti.thirtyone.dao.HolidayRequestDao;
import com.oti.thirtyone.dto.CalendarDto;
import com.oti.thirtyone.dto.HolidayDto;
import com.oti.thirtyone.dto.HolidayRequestDto;
import com.oti.thirtyone.dto.Pager;

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
	
	public List<HolidayRequestDto> getHdrReqAllbyEmpId(String empId, Pager pager) {
		return hdrDao.selectHdrAllByEmpId(empId, pager);
	}

	public int countRowsByEmpId(String empId) {
		return hdrDao.countRowsByEmpId(empId);
	}
	
	public CalendarDto formatInputCalendar(String empName, String title, Date startdate, Date enddate, String background, String border, String text) {
		CalendarDto atdCalendarDto = new CalendarDto();
		
		String startyear = "20" + (startdate.getYear()+"").split("1")[1];
		String startmonth = String.valueOf(startdate.getMonth()+1);
		String startday = String.valueOf(startdate.getDate()).length() > 1 ? String.valueOf(startdate.getDate()) : "0"+startdate.getDate() ;

		String endyear = "20" + (enddate.getYear()+"").split("1")[1];
		String endmonth = String.valueOf(enddate.getMonth()+1);
		String endday = String.valueOf(enddate.getDate()).length() > 1 ? String.valueOf(enddate.getDate()) : "0"+enddate.getDate() ;
		
		atdCalendarDto.setTitle(empName + "휴가");
		atdCalendarDto.setStart(startyear+"-"+startmonth+"-"+startday);
		atdCalendarDto.setEnd(endyear+"-"+endmonth+"-"+endday);
		atdCalendarDto.setBackgroundColor(background);
		atdCalendarDto.setBorderColor(border);
		atdCalendarDto.setTextColor(text);
		
		
		return atdCalendarDto;
	}
	
	public List<CalendarDto> getHdrCalendar(String empId, String year, String month) {
		List<HolidayRequestDto> hdrList = hdrDao.selectHdrByEmpId(empId);
		List<CalendarDto> hdrCalList = new LinkedList<CalendarDto>();
		
		for(HolidayRequestDto hdrReq : hdrList) {
			hdrCalList.add(formatInputCalendar("", "휴가", hdrReq.getHdrStartDate(), hdrReq.getHdrEndDate(), "#B5CAFF", "#B5CAFF", "white"));
		}
		
		return hdrCalList;
	}

	public double[] getRemainHoliday(String empId) {
		HolidayDto hd = holidayDao.selectAnnualHoliday(empId);
		double[] holiday = new double[2];
		holiday[0] = hd.getHdUsed();
		holiday[1] = hd.getHdCount()-hd.getHdUsed();
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
		List<HolidayRequestDto> hdrList = hdrDao.selectDeptHdrCalendar(deptId, year+"/"+month+"/15");
		List<CalendarDto> hdrCalList = new LinkedList<CalendarDto>();
		for(HolidayRequestDto hdrReq : hdrList) {
			String empName = empDao.selectByEmpId(hdrReq.getHdrEmpId()).getEmpName();
			hdrCalList.add(formatInputCalendar(empName, "휴가", hdrReq.getHdrStartDate(), hdrReq.getHdrEndDate(), "#B5CAFF", "#B5CAFF", "white"));
		}
		return hdrCalList;
	}

}
