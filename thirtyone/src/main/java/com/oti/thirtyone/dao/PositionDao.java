package com.oti.thirtyone.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.oti.thirtyone.dto.PositionsDto;

@Mapper
public interface PositionDao {

	List<PositionsDto> selectPosList();

}
