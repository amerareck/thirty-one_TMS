package com.oti.thirtyone.service;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oti.thirtyone.dao.AttendanceDao;
import com.oti.thirtyone.dto.AttendanceDto;

import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class AttendanceService {
	
	@Autowired
	AttendanceDao atdDao;

	public double distanceCalculation(double lat, double lng, String regionalOffice) {
		double[] seoul = {37.583729, 126.999942};
		double[] sejong = {36.496289, 127.262671};
		double[] jincheon = {36.905176, 127.550420};
		final int EARTH_RADIUS = 6371; // Radius of the earth
		
		double officeLat = 0;
		double officeLng = 0;
		if(regionalOffice.equals("서울")) {
			officeLat = seoul[0];
			officeLng = seoul[1];
		}else if(regionalOffice.equals("세종")) {
			officeLat = sejong[0];
			officeLng = sejong[1];
		}else if(regionalOffice.equals("진천")) {
			officeLat = jincheon[0];
			officeLng = jincheon[1];			
		}
		
		 
		double dLat = Math.toRadians(officeLat - lat);
		double dLon = Math.toRadians(officeLng - lng);

		double a = Math.sin(dLat/2)* Math.sin(dLat/2)+ Math.cos(Math.toRadians(lat))* Math.cos(Math.toRadians(officeLat))* Math.sin(dLon/2)* Math.sin(dLon/2);
		double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
		double distance =EARTH_RADIUS* c * 1000; 
		
		return distance;
	}

	public boolean checkIn(String empId) {
		int isCheckIn = atdDao.selectCheckInToday(empId);
		log.info(isCheckIn);
		if(isCheckIn == 0) atdDao.insertCheckIn(empId);
		return isCheckIn > 0;
		
	}
	
	public boolean checkOut(String empId) {
		int isCheckIn = atdDao.selectCheckInToday(empId);
		log.info(isCheckIn);
		if(isCheckIn > 0) atdDao.updateCheckOut(empId);
		return isCheckIn > 0;
		
	}

	public AttendanceDto getAtdInfo(String empId) {
		AttendanceDto atdDto = atdDao.selectAtdByEmpId(empId);
		return atdDto;
	}

	public Boolean isLateCheck(AttendanceDto atdDto) {
		Date checkInDate = atdDto.getCheckIn();
		
		Date isOnTime = new Date(checkInDate.getYear(), checkInDate.getMonth(), checkInDate.getDate(), 9, 0, 0);
		if(checkInDate.before(isOnTime))
			return true;
		else
			return false;
	}

	public Map<String, Long> getTimeWork(AttendanceDto atdDto) {
		Date checkInDate = atdDto.getCheckIn();
		
		Date curTime = new Date();
		
		long workTimeMillis = curTime.getTime() - checkInDate.getTime();
		long workTimeHour = (workTimeMillis / (1000 * 60 * 60)) % 24;
		long workTimeMinute = (workTimeMillis /  (1000 * 60)) % 60;
		
	    Map<String, Long> timeDifference = new HashMap<>();
        timeDifference.put("hour", workTimeHour);
        timeDifference.put("minute", workTimeMinute);
		return timeDifference;
	}
	
	
	
}
