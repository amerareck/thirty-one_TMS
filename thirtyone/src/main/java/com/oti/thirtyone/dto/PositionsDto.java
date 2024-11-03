package com.oti.thirtyone.dto;

import lombok.Data;

@Data
public class PositionsDto {
	private String position;
	private int positionClass;
	
	public boolean isCompareRankForHigherEquels(PositionsDto compPos) {
		if(this.position == null || this.position.isEmpty()) return false;
		return this.positionClass <= compPos.getPositionClass();
	}
}
