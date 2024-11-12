package com.oti.thirtyone.scheduler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.oti.thirtyone.service.AlertService;
import com.oti.thirtyone.service.EmployeesService;

import lombok.extern.log4j.Log4j2;

@Component
@Log4j2
public class Scheduler {

	@Autowired
	EmployeesService empService;
	@Autowired
	AlertService alertService; 
	
//	@Scheduled(cron = "0 00 14 * * MON-FRI")
//	public void absenceProccess() {
//		log.info("스케줄러 실행됨");
//		empService.absenceProccess();
//	}
	
//	@Scheduled(cron = "0 55 08 * * MON-FRI")
//	public void checkInAlert() {
//		log.info("일괄적으로 출근 알람 실행됨");
//		String alertContent = "아직 출근을 체크하지 않았습니다. 출근 버튼을 눌러주세요.";
//		alertService.sendAlertToNoCheckIn(alertContent, "근태");
//		
//	}
//
//	@Scheduled(cron = "0 56 23 * * MON-FRI")
//	public void checkOutAlert() {
//		log.info("일괄적으로 출근 알람 실행됨");
//		String alertContent = "아직 퇴근을 체크하지 않았습니다. 퇴근 버튼을 눌러주세요.";
//		alertService.sendAlertToNoCheckOut(alertContent, "근태");
//		
//	}
//	
}
