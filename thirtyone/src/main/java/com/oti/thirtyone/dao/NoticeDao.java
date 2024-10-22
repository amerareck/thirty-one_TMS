package com.oti.thirtyone.dao;

import org.apache.ibatis.annotations.Mapper;

import com.oti.thirtyone.dto.NoticeDto;

@Mapper
public interface NoticeDao {
	 public int insertNotice(NoticeDto notice);

}
