package com.oti.thirtyone.Security;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.oti.thirtyone.DAO.EmployeesDao;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j

public class EmployeeDetailService implements UserDetailsService{
	@Autowired
	private EmployeesDao employeeDao;

	@Override
	public UserDetails loadUserByUsername(String username) 
			throws UsernameNotFoundException {
		
		EmployeesDao employee = employeeDao.selectByempId(username);
		if(employee==null) {
			throw new UsernameNotFoundException("Bad username");
		}
		
		List<GrantedAuthority> authorities = new ArrayList<>();
		authorities.add(new SimpleGrantedAuthority(employee.getempRole()));
		
		UserDetails userDetails = new EmployeeDetails(employee, authorities);
		return userDetails;
	}
	

}
