package com.oti.thirtyone.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.oti.thirtyone.dto.AlertDto;

@Service
public class AlertService {
	
	private List<SseEmitter> emitters;
	
	//thread의 안전성을 보장
	@PostConstruct
	public void init() {
		emitters = new CopyOnWriteArrayList<>();
	}
	
//	클라이언트가 SSE 스트림에 구독할 때 호출되는 메서드입니다. 새로운 SseEmitter를 생성하고, emitters 목록에 추가합니다.
	public SseEmitter subscribe() {
        SseEmitter emitter = new SseEmitter(Long.MAX_VALUE); // 타임아웃 설정 (무제한)
        emitters.add(emitter);

        // 연결 완료, 타임아웃, 에러 발생 시 emitters 목록에서 제거
        emitter.onCompletion(() -> emitters.remove(emitter));
        emitter.onTimeout(() -> emitters.remove(emitter));
        emitter.onError((e) -> emitters.remove(emitter));

        return emitter;
    }
	
	public void sendAlert(String message) {
        AlertDto alert = new AlertDto(message, System.currentTimeMillis());
        //insert 들어갈 자리

        List<SseEmitter> deadEmitters = new ArrayList<>();
        for (SseEmitter emitter : emitters) {
            try {
                // SSE 이벤트 전송
                emitter.send(SseEmitter.event()
                        .name("alert") // 이벤트 이름
                        .data(alert));
            } catch (IOException e) {
                deadEmitters.add(emitter);
            }
        }
        emitters.removeAll(deadEmitters);
    }
}
