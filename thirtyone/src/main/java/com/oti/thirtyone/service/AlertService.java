package com.oti.thirtyone.service;

import java.io.IOException;
import java.util.Date;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.oti.thirtyone.dao.AlertDao;
import com.oti.thirtyone.dto.AlertDto;

import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class AlertService {
	
	private Map<String, SseEmitter> emitters;
    private ExecutorService executor;
	
    @Autowired
    AlertDao alertDao;
    
	//thread의 안전성을 보장
	@PostConstruct
	public void init() {
		emitters = new ConcurrentHashMap<>();
		executor = Executors.newFixedThreadPool(10); 
		log.info("AlertService initialized with thread 	pool size {}", 10);
	}
	
	/**
     * 클라이언트가 SSE 스트림에 구독할 때 호출되는 메서드
     *
     * @param empId 클라이언트의 empId
     * @return SseEmitter 객체
     */
	public SseEmitter subscribe(String empId) {
        SseEmitter emitter = new SseEmitter(Long.MAX_VALUE); // 타임아웃 설정 (무제한)
        
        // 기존에 같은 empId로 등록된 Emitter가 있으면 제거
        if (emitters.containsKey(empId)) {
            emitters.get(empId).complete();
            emitters.remove(empId);
        }
        
        emitters.put(empId, emitter);
        log.info("emitter를 한번 보겠습니다." + emitters.toString());
        
        // Emitter 완료, 타임아웃, 에러 시 Map에서 제거
        emitter.onCompletion(() -> emitters.remove(empId));
        emitter.onTimeout(() -> emitters.remove(empId));
        emitter.onError((e) -> {
            emitters.remove(empId);
        });

        return emitter;
    }
	
    /**
     * 특정 empId를 가진 클라이언트에게 알림을 전송하는 메서드
     *
     * @param empId   수신자 empId
     * @param message 전송할 메시지
     */
	public void sendAlert(String empId, String alertContent, String alertType) {
		log.info("Attempting to send alert to empId {}: ", empId, alertContent, alertType);
        AlertDto alert = new AlertDto(alertContent, alertType, empId, new Date());
        
        alertDao.insertAlert(alert);
        //insert 들어갈 자리

        SseEmitter emitter = emitters.get(empId);
        if (emitter != null) {
        	log.info("Emitter found for empId {}. Sending notification.", empId);
            executor.submit(() -> {
                try {
                    emitter.send(SseEmitter.event()
                            .name("alert") // 이벤트 이름
                            .data(alert));
                    log.info("Sent alert to empId {}: {}", empId, alertContent, alertType);
                } catch (IOException e) {
                    emitter.completeWithError(e);
                    emitters.remove(empId);
                    log.warn("Failed to send SSE to empId {}: {}", empId, e.getMessage());
                }
            });
        } else {
        	log.warn("No active emitter found for empId {}", empId);
        }
    }
	
	/**
     * 모든 클라이언트에게 알림을 전송하는 메서드
     *
     * @param message 전송할 메시지
     */
    public void sendAlertToAll(String alertContent, String alertType) {


         emitters.forEach((empId, emitter) -> {
             executor.submit(() -> {
                 try {
                	 AlertDto alert = new AlertDto(alertContent, alertType, empId, new Date());
                     emitter.send(SseEmitter.event()
                             .name("alert")
                             .data(alert));
                     log.info("Sent alert to empId {}: {}", empId, alertContent, alertType);
                 } catch (IOException e) {
                     emitter.completeWithError(e);
                     emitters.remove(empId);
                     log.warn("Failed to send SSE to empId {}: {}", empId, e.getMessage());
                 }
             });
         });
    }
    
    @PreDestroy 
    public void destroy() {
        try {
            executor.shutdown();
            if (!executor.awaitTermination(60, TimeUnit.SECONDS)) {
                executor.shutdownNow();
            }
            log.info("Executor service shut down successfully.");
        } catch (InterruptedException e) {
            executor.shutdownNow();
            Thread.currentThread().interrupt();
            log.error("Executor service shutdown interrupted.", e);
        }
    }
    
}
