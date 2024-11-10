package com.oti.thirtyone.dao;

import org.apache.ibatis.annotations.Mapper;

import com.oti.thirtyone.dto.AlertDto;

@Mapper
public interface AlertDao {

	int insertAlert(AlertDto alert);

}
