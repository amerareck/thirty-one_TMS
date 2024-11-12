package com.oti.thirtyone.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oti.thirtyone.dao.AttendanceDao;
import com.oti.thirtyone.dao.DocumentFolderDAO;
import com.oti.thirtyone.dao.HolidayRequestDao;
import com.oti.thirtyone.dao.ReasonDao;
import com.oti.thirtyone.dto.ApprovalDTO;
import com.oti.thirtyone.dto.AttendanceDto;
import com.oti.thirtyone.dto.CalendarDto;
import com.oti.thirtyone.dto.HolidayRequestDto;
import com.oti.thirtyone.dto.ReasonDto;

import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class AttendanceService {
	
	@Autowired
	AttendanceDao atdDao;
	@Autowired
	ReasonDao reasonDao;
	@Autowired
	DocumentFolderDAO docFolderDao;
	@Autowired
	HolidayRequestDao hdrDao;
	
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
		LocalDateTime now = LocalDateTime.now();
		
		
		if(isCheckIn == 0) {
			if(now.getHour() >= 9) atdDao.insertCheckIn(empId, "지각");
			else atdDao.insertCheckIn(empId, "정상출근");
		}
		return isCheckIn > 0;
		
	}
	
	public boolean checkOut(String empId) {
		int isCheckIn = atdDao.selectCheckInToday(empId);
		LocalDateTime now = LocalDateTime.now();

		if(isCheckIn > 0) {
			if(now.getHour() <= 17) 
				atdDao.updateCheckOut(empId, "조퇴");
			else 
				atdDao.updateCheckOut(empId, "정상출근");
		}
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
	
	public CalendarDto formatInputCalendar(String title, Date date, String background, String border, String text) {
		CalendarDto atdCalendarDto = new CalendarDto();
		
		String year = "20" + (date.getYear()+"").split("1")[1];
		String month = String.valueOf(date.getMonth()+1);
		String day = String.valueOf(date.getDate()).length() > 1 ? String.valueOf(date.getDate()) : "0"+date.getDate() ;
		String hour = String.valueOf(date.getHours()).length() > 1 ? String.valueOf(date.getHours()) : "0" + date.getHours(); 
		String minute = String.valueOf(date.getMinutes()).length() > 1 ? String.valueOf(date.getMinutes()) : "0" + date.getMinutes();
		if(title.equals("연장근무") || title.equals("출장") || title.equals("휴가"))
			atdCalendarDto.setTitle(title);
		else
			atdCalendarDto.setTitle(title+" " + hour+":"+minute);
		atdCalendarDto.setStart(year+"-"+month+"-"+day);
		atdCalendarDto.setBackgroundColor(background);
		atdCalendarDto.setBorderColor(border);
		atdCalendarDto.setTextColor(text);
		
		
		return atdCalendarDto;
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

		atdCalendarDto.setTitle(empName + title);
		atdCalendarDto.setStart(startyear + "-" + startmonth + "-" + startday);
		atdCalendarDto.setEnd(endyear + "-" + endmonth + "-" + endday);
		atdCalendarDto.setBackgroundColor(background);
		atdCalendarDto.setBorderColor(border);
		atdCalendarDto.setTextColor(text);

		return atdCalendarDto;
	}
	
	public List<CalendarDto> getAtdInfoList(String empId, String year, String month) {
		
		if(month.length() == 1) {
			month="0" + month;
		}
		log.info(year + " " + month);		
		List<AttendanceDto> atdCalendarList = atdDao.selectAtdForMonths(empId, year+"/"+month+"/15");
		List<HolidayRequestDto> hdrList = hdrDao.selectHdrByEmpId(empId);
		List<ApprovalDTO> eventHdrList = docFolderDao.selectHdrByEmpId(empId);
		
		List<CalendarDto> calendarList = new LinkedList<CalendarDto>();
		
		for (HolidayRequestDto hdrReq : hdrList) {
			calendarList.add(formatInputCalendar("", "휴가", hdrReq.getHdrStartDate(), hdrReq.getHdrEndDate(), "rgba(31, 95, 255)", "rgba(31, 95, 255)", "white"));
		}
		
		for(ApprovalDTO eventHdr : eventHdrList) {

			if(eventHdr.getDocHolidayType() != null) {
				if(eventHdr.getDocHolidayType().equals("familyEvent")){
					calendarList.add(formatInputCalendar("", "경조사", eventHdr.getDocHolidayStartDate(), eventHdr.getDocHolidayEndDate(), "#F5F5F5", "#F5F5F5)", "black"));
				}else if(eventHdr.getDocHolidayType().equals("sickLeave")) {
					calendarList.add(formatInputCalendar("", "병가", eventHdr.getDocHolidayStartDate(), eventHdr.getDocHolidayEndDate(),  "#F5F5F5", "#F5F5F5)", "black"));
				}
			}
		}
		
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
			}else if(title.equals("출장")) {
				calendarList.add(formatInputCalendar("출장", atd.getAtdDate(), "white", "#000000", "#000000"));
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
        
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date startDate = dateFormat.parse(monday);
        Date endDate = dateFormat.parse(sunday);
        
        List<Date> dateList = new ArrayList<>();
        
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(startDate);

        while (!calendar.getTime().after(endDate)) {
            dateList.add(calendar.getTime()); 
            calendar.add(Calendar.DATE, 1);
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

		List<AttendanceDto> atdWeekly = atdDao.selectAtdWeekly(monday, sunday, empId);
		List<ReasonDto> reasonWeekly = reasonDao.selectReasonWeekly(monday, sunday,empId);
		
		List<AttendanceDto> atdList = new LinkedList<>();
		List<Date> weeklyDate = getWeeklyDate(monday, sunday);
		List<String> checkIn = new LinkedList<>();
		List<String> checkOut = new LinkedList<>();
		List<Integer> workTime = new LinkedList<>();
		List<Integer> overTime = new LinkedList<>();
		List<String> lateTime = new LinkedList<>();
		List<ReasonDto> reasonList = new LinkedList<>();
		List<Map<String, Object>> overTimeList = new LinkedList<>();
		Map<String, Object> dataList = new HashMap<>();

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		for(Date thisDay : weeklyDate) {
			Map<String, Object> overTimeMap = new HashMap<>();
			String overTimeStatus = docFolderDao.selectOverTimeStatus(thisDay, empId);
			overTimeMap.put("date", thisDay);
			overTimeMap.put("overTimeStatus", overTimeStatus);
			overTimeList.add(overTimeMap);
			boolean check = false;
			for(AttendanceDto atd : atdWeekly) {
				
				if(dateFormat.format(thisDay).equals(dateFormat.format(atd.getAtdDate()))) {
					check = true;
					Date checkInDate = atd.getCheckIn();
					Date checkOutDate = atd.getCheckOut();
					if(checkInDate != null) {
						checkIn.add(formatHours(checkInDate) +":"+ formatMinutes(checkInDate));
					}else {
						checkIn.add("00:00"); checkOut.add("00:00"); workTime.add(0); overTime.add(0); lateTime.add("00:00");
					}
					if(checkOutDate != null) {
						checkOut.add(formatHours(checkOutDate) +":"+ formatMinutes(checkOutDate));
						workTime.add(atd.getAtdStandardTime()/60);
						if(atd.getAtdOverTime() != 0) {
							overTime.add((atd.getAtdOverTime() + atd.getAtdStandardTime())/60);
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
				checkIn.add("00:00"); checkOut.add("00:00"); workTime.add(0); overTime.add(0); lateTime.add("00:00");
				AttendanceDto tempAtd = new AttendanceDto();
				tempAtd.setAtdDate(thisDay);
				atdList.add(tempAtd);
			}
			
			for(ReasonDto reason : reasonWeekly) {
				if(dateFormat.format(thisDay).equals(dateFormat.format(reason.getAtdDate()))) {
					reasonList.add(reason);
				}
			}
			
		}
		
		dataList.put("overTimeList", overTimeList);
		dataList.put("atdList", atdList);
		dataList.put("checkIn", checkIn);
		dataList.put("checkOut", checkOut);
		dataList.put("workTime", workTime);
		dataList.put("overTime", overTime);
		dataList.put("lateTime", lateTime);
		dataList.put("weeklyData", weeklyDate);
		dataList.put("reasonList", reasonList);
		return dataList;
	}

	public AttendanceDto getAtdInfoOneDay(String empId, String day) {
		return atdDao.selectAtdOneDay(empId, day);
		
	}

	public AttendanceDto getAtdInfoOneDay(String empId, Date atdDate) {
		return atdDao.selectAtdOneDayByDate(empId, atdDate);
	}
	
	@Transactional
	public boolean updateAtdStateByApproval(ApprovalDTO apr) {
		boolean result = true;
		int start = 0, end = 0;
		apr.setDocDocumentData("");
		switch (apr.getDocFormCode()) {
			case "HLD" :
				apr.setAtdState("휴가");
				apr.setDateList(new ArrayList<Date>());
				start = apr.getDocHolidayStartDate().getDate();
				end = apr.getDocHolidayEndDate().getDate();
				for(int i=start; i<=end; i++) {
					Date item = (Date) apr.getDocHolidayStartDate().clone();
					item.setDate(i);
					apr.getDateList().add(item);
				}
				apr.getDateList().removeIf(item -> apr.isWeekend(item));
				break;
				
			case "BTD" :
				apr.setAtdState("출장");
				apr.setDateList(new ArrayList<Date>());
				start = apr.getDocBiztripStartDate().getDate();
				end = apr.getDocBiztripEndDate().getDate();
				for(int i=0; i<apr.getDocBiztripDay(); i++) {
					Date item = (Date) apr.getDocBiztripStartDate().clone();
					item.setDate(i);
					apr.getDateList().add(item);
				}
				apr.getDateList().removeIf(item -> apr.isWeekend(item));
				break;
				
			case "WOT" :
				Date tempDate = apr.getDocWorkOvertimeEndDate();
				if(tempDate.getHours() < 5) tempDate.setDate(tempDate.getDate()-1);
				tempDate.setHours(18);
				long ms = apr.getDocWorkOvertimeEndDate().getTime() - tempDate.getTime();
				int minutes = (int)(ms/(1000*60));
				apr.setAtdOverTime(minutes);
				tempDate.setHours(0);
				apr.setAtdDate(tempDate);
				AttendanceDto item = atdDao.selectAtdForApproval(apr);
				if(item == null) {
					if(atdDao.insertAtdDefaultData(apr) == 1) {
						item = atdDao.selectAtdForApproval(apr);
					} else {
						throw new RuntimeException("업데이트 실패");
					}
				}
				if(atdDao.updateAtdOvertime(item) != 1) {
					throw new RuntimeException("업데이트 실패");
				}
				return result;
			default :
				return false;
		}
		
		Iterator<Date> iter = apr.getDateList().iterator();
		while(iter.hasNext()) {
			apr.setAtdDate(iter.next());
			AttendanceDto item = atdDao.selectAtdForApproval(apr);
			if(item == null) {
				if(atdDao.insertAtdDefaultData(apr) == 1) {
					item = atdDao.selectAtdForApproval(apr);
					item.setAtdState(apr.getAtdState());
				} else {
					throw new RuntimeException("업데이트 실패");
				}
			}
			
			if(atdDao.updateAtdStateByApproval(item) != 1) {
				throw new RuntimeException("업데이트 실패");
			}
		}
		return result;
	}
	
//	public List<HolidayDto> insertHdrPeriod(String empId) {
//		List<HolidayDto> holiday = atdDao.insertHdrPeriod(empId);
//		return holiday;
//	}
//	
}
