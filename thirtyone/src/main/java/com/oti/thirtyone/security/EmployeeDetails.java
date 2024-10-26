package com.oti.thirtyone.security;

import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.oti.thirtyone.dao.EmployeesDao;
import com.oti.thirtyone.dto.EmployeesDto;


public class EmployeeDetails extends User{
	
	private EmployeesDto employee;
	
	public EmployeeDetails(
			EmployeesDto employee,
			List<GrantedAuthority> authorities) {
		
		super(
			employee.getEmpId(), 
			employee.getEmpPassword(),
			!employee.getEmpState().equals("퇴직"),
			true, true, true,
			authorities
			);
		this.employee = employee;
	}
	
	public EmployeesDto getEmployee() {
		return employee;
	}
}
