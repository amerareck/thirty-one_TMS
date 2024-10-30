package com.oti.thirtyone.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.oti.thirtyone.dto.DraftForm;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class DraftValidator implements Validator {
	@Override
	public boolean supports(Class<?> clazz) {
		log.info("실행");
		return DraftForm.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		log.info("실행");
		DraftForm draft = (DraftForm) target;

		String draftType = draft.getDraftType();
		if (draftType == null || draftType.trim().isEmpty() || draftType.equals("default")) {
			errors.rejectValue("draftType", "errors.draftType.required", "문서 유형은 반드시 선택해야 합니다.");
		} else {
			switch (draftType) {
				case "holidayDocument":
					if(draft.getHolidayStartDate() == null || draft.getHolidayEndDate() == null) {
						errors.rejectValue("holidayStartDate", "errors.dateOfHoliday.required", "휴가 일자는 반드시 선택해야 합니다.");
					}
					if(draft.getHolidayType() == null || draft.getHolidayType().equals("default")) {
						errors.rejectValue("holidayType", "errors.holidayType.required", "휴가 신청 유형은 반드시 선택해야 합니다.");
					}
					break;
				case "businessTripDocument":
				case "businessTripReport":
					if(draft.getBizTripStartDate() == null || draft.getBizTripEndDate() == null) {
						errors.rejectValue("bizTripStartDate", "errors.dateOfBizTrip.required", "출장 일자는 반드시 선택해야 합니다.");
					}
					if(draft.getBizTripPurposeForm() == null || draft.getBizTripPurposeForm().trim().isEmpty()) {
						errors.rejectValue("bizTripPurposeForm", "errors.purposeOfBizTrip.required", "출장 목적은 반드시 입력해야 합니다.");
					}
					break;
				case "holidayWork":
					if(draft.getHolidayWorkStartDate() == null || draft.getHolidayWorkEndDate() == null) {
						errors.rejectValue("holidayWorkStartDate", "errors.datetimeOfholidayWork.required", "근무 일자는 반드시 선택해야 합니다.");
					}
					break;
				case "workOvertime":
					if(draft.getWorkOvertimeStartDate() == null || draft.getWorkOvertimeEndDate() == null) {
						errors.rejectValue("workOvertimeStartDate", "errors.datetimeOfWorkOvertime.required", "근무 일자는 반드시 선택해야 합니다.");
					}
					break;
			}
			
			if(draft.getDraftTitle() == null || draft.getDraftTitle().trim().isEmpty()) {
				errors.rejectValue("draftTitle", "errors.draftTitleContainer.required", "문서 제목은 반드시 입력해야 합니다.");
			} else if(draft.getDraftTitle().length() < 101) {
				errors.rejectValue("draftTitle", "errors.draftTitleContainer.length", "문서 제목은 100자 이하여야 합니다.");
			}
				
			if(draft.getDraftApprovalLine() == null || draft.getDraftApprovalLine().isEmpty()) {
				errors.rejectValue("draftApprovalLine", "errors.pickApprovalLineContainer.required", "결재선은 반드시 존재해야 합니다.");
			}
			
			if(draft.getDocumentData() == null || draft.getDocumentData().isEmpty()) {
				errors.rejectValue("documentData", "errors.documentEmpty.empty", "문서가 서버로 전송되지 않았습니다. 다시 한번 시도해 주세요.");
			}
			
		}
		
	}
}
