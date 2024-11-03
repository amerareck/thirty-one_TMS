package com.oti.thirtyone.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oti.thirtyone.dao.AttendanceDao;
import com.oti.thirtyone.dto.AttendanceCalendarDto;
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
		Date checkOutDate = atdDto.getCheckOut();
		Date curTime = new Date();
		long workTime = 0;
		if(checkOutDate == null)
			workTime = curTime.getTime() - checkInDate.getTime();
		else
			workTime = checkOutDate.getTime() - checkInDate.getTime();
		
		long workTimeHour = (workTime / (1000 * 60 * 60)) % 24;
		long workTimeMinute = (workTime /  (1000 * 60)) % 60;
		long workTimeWorkPart = (long) ((workTimeHour / 14.0) * 100);
		log.info("workTimeHour " + workTimeHour);
		log.info(workTimeWorkPart);
		
	    Map<String, Long> timeDifference = new HashMap<>();
        timeDifference.put("hour", workTimeHour);
        timeDifference.put("minute", workTimeMinute);
        timeDifference.put("workpart", workTimeWorkPart);
        
		return timeDifference;
	}
	public AttendanceCalendarDto formatInputCalendar(String title, Date date, String background, String border, String text) {
		AttendanceCalendarDto atdCalendarDto = new AttendanceCalendarDto();
		
		String year = "20" + (date.getYear()+"").split("1")[1];
		String month = String.valueOf(date.getMonth()+1);
		String day = String.valueOf(date.getDate()).length() > 1 ? String.valueOf(date.getDate()) : "0"+date.getDate() ;
		String hour = String.valueOf(date.getHours()).length() > 1 ? String.valueOf(date.getHours()) : "0" + date.getHours(); 
		String minute = String.valueOf(date.getMinutes()).length() > 1 ? String.valueOf(date.getMinutes()) : "0" + date.getMinutes();
		if(title.equals("연장근무"))
			atdCalendarDto.setTitle(title);
		else
			atdCalendarDto.setTitle(title+" " + hour+":"+minute);
		atdCalendarDto.setStart(year+"-"+month+"-"+day);
		atdCalendarDto.setBackgroundColor(background);
		atdCalendarDto.setBorderColor(border);
		atdCalendarDto.setTextColor(text);
		
		
		return atdCalendarDto;
	}
	
	public List<AttendanceCalendarDto> getAtdInfoList(String empId, String year, String month) {
		
		if(month.length() == 1) {
			month="0" + month;
		}
		log.info(year + " " + month);		
		List<AttendanceDto> atdCalendarList = atdDao.selectAtdForMonths(empId, year+"/"+month+"/15");
		List<AttendanceCalendarDto> calendarList = new LinkedList<AttendanceCalendarDto>();
		for (AttendanceDto atd : atdCalendarList) {
			String title = atd.getAtdState();
			
			if(title.equals("정상출근")) {
				if(atd.getCheckIn() != null) 
					calendarList.add(formatInputCalendar("출근", atd.getCheckIn(), "#B5CAFF", "#B5CAFF", "white") );
				if(atd.getCheckOut() != null) 
					calendarList.add(formatInputCalendar("퇴근", atd.getCheckOut(), "#C3C3C3", "#C3C3C3", "white" ));
			}else if(title.equals("지각")) {
				if(atd.getCheckIn() != null) 
					calendarList.add(formatInputCalendar("지각", atd.getCheckIn(), "white", "#B5CAFF", "#B5CAFF"));
				if(atd.getCheckOut() != null) 
					calendarList.add(formatInputCalendar("퇴근", atd.getCheckOut(), "#C3C3C3", "#C3C3C3", "white"));				
			}else if(title.equals("조퇴")) {
				if(atd.getCheckIn() != null) 
					calendarList.add(formatInputCalendar("출근", atd.getCheckIn(), "#B5CAFF", "#B5CAFF", "white"));
				if(atd.getCheckOut() != null) 
					calendarList.add(formatInputCalendar("조퇴", atd.getCheckOut(), "white", "#C3C3C3", "#C3C3C3"));
			}
			if(atd.getAtdOverTime() != 0) {
				calendarList.add(formatInputCalendar("연장근무", atd.getAtdDate(), "white", "#1F5FFF", "#1F5FFF"));
			}
			
			
		}
		return calendarList;
	}

	public int[] getAtdStats(String empId) {
		Date today = new Date();
		String month = (today.getMonth()+1)+"";
		if(month.length() == 1) {
			month="0" + month;
		}
		String year = "20" + (today.getYear()+"").split("1")[1];
		log.info(year);
		int[] stats = new int[5];
		
		List<AttendanceDto> atdList = atdDao.selectAtdMonthly(empId, year+"/"+month);		
		for(AttendanceDto atd : atdList) {
			log.info(atd.getAtdState());
			if(atd.getAtdState().equals("정상출근")) {
				stats[0]++;
			}else if(atd.getAtdState().equals("지각")) {
				stats[2]++;
			}else if(atd.getAtdState().equals("조퇴")) {
				stats[3]++;
			}else if(atd.getAtdState().equals("결근")) {
				stats[4]++;				
			}
			
			if(atd.getAtdOverTime() != 0) {
				stats[1]++;
			}
			
		}
		return stats;
	}
	public List<Date> getWeeklyDate(String monday, String sunday) throws ParseException{	        
        
        // 문자열을 Date로 변환
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date startDate = dateFormat.parse(monday);
        Date endDate = dateFormat.parse(sunday);
        
        // 날짜 범위를 저장할 리스트
        List<Date> dateList = new ArrayList<>();
        
        // 시작 날짜부터 끝 날짜까지 반복하며 리스트에 추가
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(startDate);

        while (!calendar.getTime().after(endDate)) {
            dateList.add(calendar.getTime()); // 현재 날짜를 리스트에 추가
            calendar.add(Calendar.DATE, 1); // 하루씩 증가
        }
        
        return dateList;
	}
	public String formatHours(Date date) {
		return String.valueOf(date.getHours()).length() > 1 ? String.valueOf(date.getHours()) : "0" + date.getHours();
	}
	public String formatMinutes(Date date) {
		return String.valueOf(date.getMinutes()).length() > 1 ? String.valueOf(date.getMinutes()) : "0" + date.getMinutes();
	}
	
	public Map<String, Object> getAtdInfoWeekly(String monday, String sunday, String empId) throws ParseException {
		log.info(monday +" " + sunday);
		List<AttendanceDto> atdWeekly = atdDao.selectAtdWeekly(monday, sunday, empId);
		
		List<AttendanceDto> atdList = new LinkedList<>();
		List<Date> weeklyDate = getWeeklyDate(monday, sunday);
		List<String> checkIn = new LinkedList<>();
		List<String> checkOut = new LinkedList<>();
		List<Integer> workTime = new LinkedList<>();
		List<Integer> overTime = new LinkedList<>();
		List<String> lateTime = new LinkedList<>();
		Map<String, Object> dataList = new HashMap<>();

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		for(Date thisDay : weeklyDate) {
			boolean check = false;
			for(AttendanceDto atd : atdWeekly) {
				
				if(dateFormat.format(thisDay).equals(dateFormat.format(atd.getAtdDate()))) {
					log.info("thisDay : " +  dateFormat.format(thisDay));
					check = true;
					Date checkInDate = atd.getCheckIn();
					Date checkOutDate = atd.getCheckOut();
					if(checkInDate != null) {
						checkIn.add(formatHours(checkInDate) +":"+ formatMinutes(checkInDate));
					}
					if(checkOutDate != null) {
						checkOut.add(formatHours(checkOutDate) +":"+ formatMinutes(checkOutDate));
						workTime.add(atd.getAtdStandardTime());
						if(atd.getAtdOverTime() != 0) {
							overTime.add(atd.getAtdOverTime() + atd.getAtdStandardTime());
						}else {
							overTime.add(0);							
						}
						if(atd.getAtdState().equals("지각")) {
							lateTime.add(formatHours(checkInDate) + ":" + formatMinutes(checkInDate));
						}else {
							lateTime.add("00:00");
						}
					}
					atdList.add(atd);
					
					break;
				}
			}
			if(!check){
				log.info("thisDay : " +  dateFormat.format(thisDay));
				checkIn.add("00:00"); checkOut.add("00:00"); workTime.add(0); overTime.add(0); lateTime.add("00:00");
				AttendanceDto tempAtd = new AttendanceDto();
				tempAtd.setAtdDate(thisDay);
				atdList.add(tempAtd);
			}
		}
		
		dataList.put("atdList", atdList);
		dataList.put("checkIn", checkIn);
		dataList.put("checkOut", checkOut);
		dataList.put("workTime", workTime);
		dataList.put("overTime", overTime);
		dataList.put("lateTime", lateTime);
		dataList.put("weeklyData", weeklyDate);
		
		return dataList;
	}
	
	
	
}
