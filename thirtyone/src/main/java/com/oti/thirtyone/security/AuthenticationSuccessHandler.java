package com.oti.thirtyone.security;

import java.io.IOException;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AuthenticationSuccessHandler 

	extends SimpleUrlAuthenticationSuccessHandler{
	
	@Override
	public void onAuthenticationSuccess(
			HttpServletRequest request, 
			HttpServletResponse response,
			Authentication authentication) throws ServletException, IOException {
		Set<String> roles = AuthorityUtils.authorityListToSet(authentication.getAuthorities());
		
		if( roles.contains("ROLE_ADMIN")) {
			setDefaultTargetUrl("/admin");
		}else {
			setDefaultTargetUrl("/home");
		}
			
		super.onAuthenticationSuccess(request, response, authentication);
		
	}
}
