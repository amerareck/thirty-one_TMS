package com.oti.thirtyone.Security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.SimpleUrlLogoutSuccessHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LogoutSuccessHandeler 
	extends SimpleUrlLogoutSuccessHandler{
	
	@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {
		
		setDefaultTargetUrl("/loginForm");
		super.onLogoutSuccess(request, response, authentication);
	}

}
