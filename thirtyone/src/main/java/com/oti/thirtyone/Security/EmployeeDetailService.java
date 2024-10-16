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
//인터페이스를 구현함으로 써 UserDetailsService가 가지고 있는 메서드를 사용할 수 있다.
public class EmployeeDetailService implements UserDetailsService{
	@Autowired
	private EmployeesDao employeeDao;

	@Override
	public UserDetails loadUserByUsername(String username) 
			throws UsernameNotFoundException {
		// DB에서 데이터를 가지고 온다.
		EmployeesDao employee = employeeDao.selectByMid(username);
		if(employee==null) {
			throw new UsernameNotFoundException("Bad username");
		}
		
		List<GrantedAuthority> authorities = new ArrayList<>();
		// 멤버가 가지고 있는 권한을 객체화해서 목록으로 만듬(ROLE_ADMIN 등..)
		authorities.add(new SimpleGrantedAuthority(employee.getMrole()));
		
		UserDetails userDetails = new EmployeeDetails(employee, authorities);
		return userDetails;
	}
	

}
