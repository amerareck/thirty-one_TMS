package com.oti.thirtyone.Security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AuthenticationFailureHandler 
	extends SimpleUrlAuthenticationFailureHandler{
	
	// 인증실패했을 때 자동으로 시작
	@Override
	public void onAuthenticationFailure(
				HttpServletRequest request, 
				HttpServletResponse response,
				AuthenticationException exception) throws IOException, ServletException {
		log.info("실행");
		setDefaultFailureUrl("/loginForm");
		
		super.onAuthenticationFailure(request, response, exception);
	}

}
