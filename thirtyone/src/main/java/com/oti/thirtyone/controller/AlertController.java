package com.oti.thirtyone.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.oti.thirtyone.dto.AlertDto;
import com.oti.thirtyone.dto.Pager;
import com.oti.thirtyone.service.AlertService;

import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/alert")
@CrossOrigin(origins = "*")
@Log4j2
public class AlertController {

	@Autowired
	AlertService alertService;
    
	@GetMapping("/list")
	@Secured("ROLE_USER")
	public String alertList(Model model, Authentication authentication, 
						@RequestParam(defaultValue = "1") int pageNo, 
						String query, HttpSession session ) {
		String empId = authentication.getName();
		
		int totalRows = alertService.countRowsByEmpId(empId, query);
		Pager pager = new Pager(5, 5, totalRows, pageNo);
		session.setAttribute("pager", pager);
		List<AlertDto> alertList = alertService.getAlertListByEmpId(pager, empId, query);
		
		model.addAttribute("alertList", alertList);
		model.addAttribute("title", "알람");
		model.addAttribute("query", query);
		return "alert/alertList";
	}
	
	@GetMapping("")
	@Secured("ROLE_USER")
	public String notReadedAlert(Model model, Authentication authentication, @RequestParam(defaultValue = "1") int pageNo, HttpSession session ) {
		String empId = authentication.getName();
		
		
		int totalRows = alertService.countRowsNotReaded(empId);
		Pager pager = new Pager(5, 5, totalRows, pageNo);
		session.setAttribute("pager", pager);
		List<AlertDto> alertList = alertService.getAlertListNotReaded(pager, empId);
		
		alertService.updateAlertStatus(alertList);
		
		model.addAttribute("alertList", alertList);
		model.addAttribute("title", "알람");
		return "alert/alert";
	}

    @GetMapping("/stream")
    public SseEmitter stream(String empId) {
    	log.info("연결을 시작합니다." + empId);
    	return alertService.subscribe(empId);
    }
    
    /**
     * 버튼 클릭 시 이벤트를 발생시키기 위한 엔드포인트
     *
     * @param empId   수신자 empId
     * @param message 전송할 메시지
     * @return 응답 메시지
     */
    @PostMapping("/send")
    @ResponseBody
    public ResponseEntity<String> sendAlert(String empId, String alertContent,
    									String alertType ) {
    	
        alertService.sendAlert(empId, alertContent, alertType);
        log.info("empId " + empId);
        return ResponseEntity.ok("Alert sent to empId: " + empId);
    }
    
}
