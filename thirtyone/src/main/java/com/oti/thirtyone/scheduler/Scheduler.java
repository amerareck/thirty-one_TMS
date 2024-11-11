package com.oti.thirtyone.scheduler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.oti.thirtyone.service.EmployeesService;

import lombok.extern.log4j.Log4j2;

@Component
@Log4j2
public class Scheduler {

	@Autowired
	EmployeesService empService;
	
	@Scheduled(cron = "0 00 14 * * MON-FRI")
	public void absenceProccess() {
		log.info("스케줄러 실행됨");
		empService.absenceProccess();
	}
	
}
