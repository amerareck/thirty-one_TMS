package com.oti.thirtyone.security;

import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.oti.thirtyone.dao.EmployeesDao;
import com.oti.thirtyone.dto.EmployeesDto;


public class EmployeeDetails extends User{
	
	private EmployeesDto member;
	
	public EmployeeDetails(
			EmployeesDto member,
			List<GrantedAuthority> authorities) {
		
		super(
			member.getEmpId(), 
			member.getEmpPassword(),
			!member.getEmpState().equals("퇴직"),
			true, true, true,
			authorities
			);
		this.member = member;
	}
	
	public EmployeesDto getMember() {
		return member;
	}
}
