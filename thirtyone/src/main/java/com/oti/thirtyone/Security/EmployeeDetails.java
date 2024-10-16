package com.oti.thirtyone.Security;

import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.oti.thirtyone.DAO.EmployeesDao;


public class EmployeeDetails extends User{
	
	private EmployeesDao member;
	
	public EmployeeDetails(
			EmployeesDao member,
			List<GrantedAuthority> authorities) {
		
		super(
			member.getMid(), 
			member.getMpassword(),
			member.isMenabled(),
			true, true, true,
			authorities
			);
		this.member = member;
	}
	
	public EmployeesDao getMember() {
		return member;
	}
}
