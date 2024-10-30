package com.oti.thirtyone.service;

import org.springframework.stereotype.Service;

import com.oti.thirtyone.dto.ApprovalDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ApprovalService {
	
	public boolean setDraftForm(ApprovalDTO dto) {
		
		return false;
	}

	public String getDocType(String draftType) {
		switch (draftType) {
		case "holidayDocument" :
			return "HLD";
		case "businessTripDocument":
			return "BTD";
		case "businessTripReport":
			return "BTR";
		case "holidayWork":
			return "HLW";
		case "workOvertime":
			return "WOT";
		}
		return null;
	}

}
