package com.oti.thirtyone.controller;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.oti.thirtyone.service.AlertService;

import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/alert")
@Log4j2
public class AlertController {

	@Autowired
	AlertService alertService;
	

    // 별도의 스레드에서 알림을 전송하기 위한 ExecutorService
    private ExecutorService executor = Executors.newSingleThreadExecutor();
    
	@GetMapping("")
	public String alert(Model model) {
		
		
		model.addAttribute("title", "알람");
		return "alert/alert";
	}

	@GetMapping("list")
	public String alertList(Model model) {
		
		
		model.addAttribute("title", "알람");
		return "alert/alertList";
	}
	
    @GetMapping("/stream")
    public SseEmitter stream() {
    	log.info("여긴 와??");
        SseEmitter emitter = alertService.subscribe();

        // 예제: 5초마다 알림 전송 (실제 애플리케이션에서는 이벤트 기반으로 전송)
        executor.execute(() -> {
            alertService.sendAlert("Server time: " + System.currentTimeMillis());
        });

        return emitter;
    }
    
    @PostMapping("/send")
    @ResponseBody
    public ResponseEntity<String> sendAlert(@RequestParam("message") String message) {
        alertService.sendAlert(message);
        return ResponseEntity.ok("Alert sent");
    }
}
