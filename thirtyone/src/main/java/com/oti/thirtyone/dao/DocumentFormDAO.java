package com.oti.thirtyone.dao;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DocumentFormDAO {

	String selectDocFormName(String docFormCode);
	
}
