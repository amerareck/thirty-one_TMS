package com.oti.thirtyone.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.oti.thirtyone.dto.PositionsDto;

@Mapper
public interface PositionDao {

	List<PositionsDto> selectPosList();

	int insertPos(String pos);

	int updateMovePos(@Param("posClass") int posClass, @Param("prePosClass") int prePosClass);

	int updatePosName(@Param("posClass")int posClass, @Param("posName") String posName);

	String selectPosName(int posClass);

	int deletePos(String prePosName);

	List<PositionsDto> selectHdrPosition(int hdrId);

}
