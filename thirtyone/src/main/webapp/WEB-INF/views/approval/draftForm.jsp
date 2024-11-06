<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/approval/approvalContainer.jsp"%>
<form action="draftSubmit" method="post" enctype="multipart/form-data" id="draftForm">
    <div class="d-flex align-items-top justify-content-between mb-4">
        <div class="d-flex align-items-top" style="width: 60%;">
        	<label for="documentForm" class="fw-bold mt-2 ${not empty draftType ? 'mb-2' : ''}" style="width: 25%;">결재 양식</label>
        	<div style="width: 75%;">
        		<c:if test="${redraft}">
	            <select class="form-select w-100" id="documentForm" name="draftType" style="height: 37.78px;" aria-describedby="documentFormValidation">
	                <option value="default" disabled>결재 양식 선택</option>
	                <option value="holidayDocument" ${draft.docFormCode=='HLD' ? 'selected': ''} >근태 신청서(휴가)</option>
	                <option value="businessTripDocument" ${draft.docFormCode=='BTD' ? 'selected': ''} >출장 신청서</option>
	                <option value="businessTripReport" ${draft.docFormCode=='BTR' ? 'selected': ''} >출장 복명서</option>
	                <option value="holidayWork" ${draft.docFormCode=='HLW' ? 'selected': ''} >휴일근무 신청서</option>
	                <option value="workOvertime" ${draft.docFormCode=='WOT' ? 'selected': ''} >연장근무 신청서</option>
	           	</select>
        		</c:if>
        		<c:if test="${!redraft}">
	            <select class="form-select w-100" id="documentForm" name="draftType" style="height: 37.78px;" aria-describedby="documentFormValidation">
	                <option value="default" ${form.draftType=='default' ? 'selected': ''} selected disabled>결재 양식 선택</option>
	                <option value="holidayDocument" ${form.draftType=='holidayDocument' ? 'selected': ''} >근태 신청서(휴가)</option>
	                <option value="businessTripDocument" ${form.draftType=='businessTripDocument' ? 'selected': ''} >출장 신청서</option>
	                <option value="businessTripReport" ${form.draftType=='businessTripReport' ? 'selected': ''} >출장 복명서</option>
	                <option value="holidayWork" ${form.draftType=='holidayWork' ? 'selected': ''} >휴일근무 신청서</option>
	                <option value="workOvertime" ${form.draftType=='workOvertime' ? 'selected': ''} >연장근무 신청서</option>
	           	</select>
        		</c:if>
	           	<div id="documentFormValidation" class="form-text">${draftType}</div>
        	</div>
        </div>
        <div class="d-flex flex-column align-items-top" id="draftDetailForm" style="width: 40%;">
        	<div class="d-flex align-items-center w-100 mb-3 hol-doc ${draft.docFormCode=='HLD' ? '': 'hidden'}">
				<label for="dateOfHoliday" class="fw-bold ${not empty holidayStartDate ? 'mb-4' : 'mb-2'}" style="width: 25%; margin-left: 20px">신청 기간</label>
				<div style="width: 75%;">
					<div id="dateOfHoliday" class="d-flex align-items-center w-100" aria-describedby="dateOfHolidayValidation" >
						<input type="text" id="holidayStartDate" name="holidayStartDate" class="form-control p-2" style="height: 35px; font-size: 0.9rem;" placeholder="휴가 시작일" readonly >
						<span class="fw-bold mx-2">~</span>
						<input type="text" id="holidayEndDate" name="holidayEndDate" class="form-control p-2" style="height: 35px; font-size: 0.9rem;" placeholder="휴가 종료일" readonly >
					</div>
					<div id="dateOfHolidayValidation" class="form-text">${holidayStartDate}</div>
				</div>
          	</div>
          	<div class="d-flex align-items-center w-100 mb-3 hol-doc ${draft.docFormCode=='HLD' ? '': 'hidden'}">
          		<label for="holidayType" class="fw-bold ${not empty holidayType ? 'mb-4' : 'mb-2'}" style="width: 25%; margin-left: 20px">휴가 유형</label>
          		<div style="width: 75%;">
	        		<select id="holidayType" class="form-select w-100" name="holidayType" style="font-size: 0.9rem" aria-describedby="holidayTypeValidation" >
	        			<option value="default" selected disabled>유형 선택</option>
	        			<option value="familyEvent">경조사</option>
	        			<option value="childbirth">출산</option>
	        			<option value="sickLeave">병가</option>
	        		</select>
	        		<div id="holidayTypeValidation" class="form-text">${holidayType}</div>
          		</div>
        	</div>
        	<div class="d-flex align-items-center w-100 mb-3 biz-trip ${draft.docFormCode=='BTD' || draft.docFormCode=='BTR' ? '': 'hidden'}">
          		<label for="dateOfBizTrip" class="fw-bold ${not empty bizTripStartDate ? 'mb-4' : 'mb-2'}" style="width: 25%; margin-left: 20px">신청 기간</label>
          		<div style="width: 75%;">
	        		<div id="dateOfBizTrip" class="d-flex align-items-center w-100"  aria-describedby="dateOfBizTripValidation" >
						<input type="text" id="bizTripStartDate" name="bizTripStartDate" class="form-control p-2" style="height: 35px; font-size: 0.9rem;" placeholder="출장 시작일" readonly >
						<span class="fw-bold mx-2">~</span>
						<input type="text" id="bizTripEndDate" name="bizTripEndDate" class="form-control p-2" style="height: 35px; font-size: 0.9rem;" placeholder="출장 종료일" readonly >
					</div>
					<div id="dateOfBizTripValidation" class="form-text">${bizTripStartDate}</div>
          		</div>
        	</div>
        	<div class="d-flex align-items-center w-100 mb-3 biz-trip ${draft.docFormCode=='BTD' || draft.docFormCode=='BTR' ? '': 'hidden'}" >
          		<label for="purposeOfBizTrip" class="fw-bold ${not empty bizTripPurposeForm ? 'mb-4' : 'mb-2'}" style="width: 25%; margin-left: 20px">출장 목적</label>
        		<div id="purposeOfBizTrip" class="d-flex flex-column align-items-start" style="width: 75%;">
					<textarea class="form-control w-100" id="bizTripPurposeForm" name="bizTripPurposeForm" cols="2" placeholder="간략하게 목적만 작성하시오." style="font-size: 0.9rem;" aria-describedby="bizTripPurposeValidation"></textarea>
					<div id="bizTripPurposeValidation" class="form-text">${bizTripPurposeForm}</div>
				</div>
        	</div>
        	<div class="d-flex align-items-center justify-content-between w-100 hol-work ${draft.docFormCode=='HLW' ? '': 'hidden'}" >
				<label for="datetimeOfholidayWork" class="fw-bold ${not empty holidayWorkStartDate ? 'mb-4' : 'mb-2'}" style="width: 25%; margin-left: 20px; margin-right: 10px;">근무 신청</label>
				<div class="w-75">
					<input type="text" id="holidayWorkStartDatetime" name="holidayWorkStartDate" class="form-control p-2" style="height: 35px; font-size: 0.8rem;" placeholder="휴가근무 신청일" aria-describedby="datetimeOfholidayWorkValidation" readonly >
					<div id="datetimeOfholidayWorkValidation" class="form-text">${holidayWorkStartDate}</div>
          		</div>
          	</div>
          	<div class="d-flex align-items-center w-100 work-over ${draft.docFormCode=='WOT' ? '': 'hidden'}" >
				<label for="datetimeOfWorkOvertime" class="fw-bold ${not empty workOvertimeEndDate ? 'mb-4' : 'mb-2'}" style="width: 25%; margin-left: 20px; margin-right: 10px;">근무 종료</label>
				<div class="w-75">
					<input type="text" id="workOvertimeStartDatetime" name="workOvertimeEndDate" class="form-control p-2" style="height: 35px; font-size: 0.8rem;" placeholder="추가근무 종료시각" aria-describedby="datetimeOfWorkOvertimeValidation" readonly >
					<div id="datetimeOfWorkOvertimeValidation" class="form-text">${workOvertimeEndDate}</div>
				</div>
          	</div>
        </div>
    </div>
    <div class="d-flex mb-4">
        <div class="d-flex align-items-center" id="draftTitleContainer" style="width: 60%;">
            <label for="draftTitle" class="fw-bold ${not empty draftTitle ? 'mb-4' : 'mb-2'}" style="width: 30%; margin-right:2px;">제목</label>
            <div style="width: 90%;">
            	<c:if test="${redraft}" >
		            <input type="text" class="form-control w-100" id="draftTitle" name="draftTitle" aria-describedby="draftTitleValidation" value="${draft.docTitle}" />
            	</c:if>
            	<c:if test="${!redraft}" >
		            <input type="text" class="form-control w-100" id="draftTitle" name="draftTitle" aria-describedby="draftTitleValidation" value="${form.draftTitle}" />
            	</c:if>
	            <div id="draftTitleValidation" class="form-text">${draftTitle}</div>
            </div>
        </div>
    </div>
    <div class="d-flex mb-4">
        <div style="width:15%;">
            <label for="draftReferrer" class="fw-bold mb-2 mt-2">참조자</label>
        </div>
        <div class="d-flex align-items-top" style="width: 85%;">
            <div class="me-3" style="width: 25%;">
                <select class="form-select" id="draftDepartmentSelect">
                    <option selected disabled>부서 선택</option>
                    <c:forEach items="${departments}" var="dept">
                    	<option value="${dept.deptId}">${dept.deptName}</option>
                    </c:forEach>
                </select>
            </div>
            <div style="width: 30%;">
            	<select class="form-select" id="draftReferrer" style="width: 98%;" disabled >
            		<option selected>참조자 선택</option>
            	</select>
            	<%-- 
                <select class="form-select" id="draftReferrer" style="width: 98%;">
                    <option selected>참조자 선택</option>
                    <option value="referrer-1">정원석 사원</option>
                    <option value="referrer-2">서지혜 사원</option>
                    <option value="referrer-3">엄성현 사원</option>
                </select>
            	--%>
            </div>
            <div class="d-flex align-items-top justify-content-start" style="width: 50%;">
                <select multiple class="form-select ms-3" id="draftRefSelectBox" name="draftReference" size="3" style="width: 50%">
                	<c:forEach items="${reference}" var="draftReference" >
                		<option value="${draftReference.empId}" selected>${draftReference.empName}&nbsp;${draftReference.position}</option>
                	</c:forEach>
                	<%-- 
	                <option value="selected-referrer-1">서지혜 사원</option>
                	--%>
                </select>
                <div class="d-flex ms-1" style="margin-top: 1px; flex-direction: column;">
	                <button type="button" class="btn btn-secondary btn-sm mb-1" id="addDraftReferrer">추가</button>
	                <button type="button" class="btn btn-secondary btn-sm" id="removeDraftReferrer">삭제</button>
                </div>
            </div>
        </div>
    </div>
    <div class="d-flex flex-column mb-4" style="width: 100%;">
        <div class="d-flex align-items-center" id="pickApprovalLineContainer" style="width: 100%;" >
            <label for="approvalLineSelect" class="fw-bold ${not empty draftApprovalLine ? 'mb-4' : 'mb-2'}" style="width: 15%;">결재 라인</label>
            <div style="width: 45%;">
	            <select class="form-select w-100" id="approvalLineSelect" data-redraft="${redraft}" aria-describedby="draftApprovalLineValidation">
	                <option selected value="selected-apprval-1">기본 결재선</option>
	                <option value="selected-apprval-2">기본 결재선2</option>
	                <option value="selected-apprval-3">기본 결재선3</option>
	            </select>
		        <div id="draftApprovalLineValidation" class="form-text">${draftApprovalLine}</div>
            </div>
            <button type="button" class="btn btn-secondary ${not empty draftApprovalLine ? 'mb-3' : 'mb-2'}" style="margin-left: 20px;" id="approvalLineCall">결재선 선택</button>
        </div>
    </div>
    <div class="d-none" id="approvalLineInfo">
    	<select name="draftApprovalLine" multiple>
    		<c:if test="${redraft}">
    			<c:forEach items="${draft.docApprovalLine}" var="aprLine" >
	    			<option selected value="${aprLine.docAprSeq}-${aprLine.docAprApprover}"></option>
    			</c:forEach>
    		</c:if>
    	</select>
    	<input type="hidden" id="docNumber" name="docNumber" value="" />
    	<c:if test="${redraft}">
    		<input type="hidden" name="prevDocNumber" value="${draft.docNumber}" />
    		<input type="hidden" name="redraft" value="${redraft}" />
    	</c:if>
    </div>
    <div class="d-flex align-items-center justify-content-center mb-4" id="approvalLineDiagram">
    	<c:if test="${redraft}">
    	<c:forEach items="${draft.docApprovalLine}" var="aprLine" varStatus="i">
    		<div class="custom-card text-end">
	            <div class="name-text mt-1">${aprLine.approverInfo.empName}&nbsp;<span class="role-text">${aprLine.approverInfo.position}</span></div>
	            <div class="dept-text mt-2">${aprLine.approverInfo.deptName}</div>
	        </div>
	        <c:if test="${draft.docApprovalLine.size() != i.count}">
	        	<div class="mx-3">
		            <img src="${pageContext.request.contextPath}/resources/image/approval-arrow.png" width="20px" />
		        </div>
	        </c:if>
    	</c:forEach>
    	</c:if>
    	<%-- 
        <div class="custom-card text-end">
            <div class="name-text mt-1">정준하 <span class="role-text">과장</span></div>
            <div class="dept-text mt-2">공공사업1DIV</div>
        </div>
        <div class="mx-3">
            <img src="${pageContext.request.contextPath}/resources/image/approval-arrow.png" width="20px" />
        </div>
        <div class="custom-card text-end">
            <div class="name-text mt-1">박명수 <span class="role-text">차장</span></div>
            <div class="dept-text mt-2">공공사업1DIV</div>
        </div>
        <div class="mx-3">
            <img src="${pageContext.request.contextPath}/resources/image/approval-arrow.png" width="20px" />
        </div>
        <div class="custom-card text-end">
            <div class="name-text mt-1">유재석 <span class="role-text">부장</span></div>
            <div class="dept-text mt-2">공공사업1DIV</div>
        </div>
    	--%>
    </div>
	<div class="d-flex align-items-center" style="width: 100%;">
		<div class="d-flex align-items-center mb-1" style="width: 15%;">
			<label for="approvalAttachFile w-100" class="fw-bold">첨부 파일</label>
		</div>
		<div class="d-flex flex-column align-items-start me-3" style="width: 85%;">
			<div class="d-flex align-items-center justify-content-start w-100 d-none">
				<span class="text-secondary attachFont" id="attatchNameTag">전동열차_지연증명서.pdf</span>
				<button type="button" class="btn p-0 ms-2" id="deleteAttacthFile"><img src="${pageContext.request.contextPath}/resources/image/close-icon.png" width="10px" /></button>
			</div>
			<div class="d-flex align-items-center justify-content-start w-100">
				<input type="file" id="approvalAttachFile" name="draftAttachFile" class="form-control" style="width: 50%" />
			</div>
		</div>
	</div>
    
    <hr class="hr my-5" />

    <div>
		<div style="width: 90%; margin: 0 auto;">
		    <textarea id="draftDocument" name="documentData"></textarea>
		</div>
	</div>
</form>

<c:if test="${not empty documentData}">
	<script>
		alert('${documentData}');
	</script>
</c:if>

<%@ include file="/WEB-INF/views/approval/approvalLine.jsp" %>
<%@ include file="/WEB-INF/views/approval/approvalContainerFooter.jsp"%>