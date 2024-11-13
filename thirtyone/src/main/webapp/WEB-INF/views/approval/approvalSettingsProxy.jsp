<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<h3 class="fw-bold my-0 pb-0" style="padding-top: 16pt;">대결자 설정</h3>
<hr class="mt-2 mb-2" style="border-top: 2px solid" />

<div class="d-flex align-items-center mt-3 w-100 px-2 pt-2">
    <h5 class="fw-bold m-0 p-0 pt-1" style="width: 40%; height: 22px;">결재 대리자</h5>
    <c:if test="${empty altApprover}">
	<div class="d-flex justify-content-end" style="width: 60%">
		<span class="fw-bold text-body-tertiary" id="altApproverInfo" style="font-size: 0.85rem; font-weight: 500; padding-top: 6px;" aria-describedby="altApproverEmpValidation">대리자 없음</span>
		<button type="button" class="btn btn-tertiary btn-sm d-flex align-items-center" style="height: 22px; margin-top: 3px;" data-bs-toggle="modal" data-bs-target="#selectAltApproverModal"><i class="fa-solid fa-magnifying-glass"></i></button>
	</div>
	<div class="d-none proxy-info"></div>
    </c:if>
    <c:if test="${not empty altApprover}">
    <div class="d-flex justify-content-end" style="width: 60%">
		<span class="fw-bold text-body-tertiary" id="altApproverInfo" style="font-size: 0.85rem; font-weight: 500; padding-top: 6px;" aria-describedby="altApproverEmpValidation">[${altApprover.altAprEmpInfo.deptName}] ${altApprover.altAprEmpInfo.empName} ${altApprover.altAprEmpInfo.position}</span>
		<span class="d-none" id="altAprEmp">${altApprover.altAprEmpInfo.empId}</span>
	</div>
    </c:if>
</div>
<div id="altApproverEmpValidation" class="form-text d-flex justify-content-end" style="font-size: .775em; margin-right: 7px;"></div>
<hr class="my-1 mx-auto" style="width: 97%"/>
<div class="d-flex align-items-center justify-content-between mt-2 w-100 px-2 pt-2">
    <h5 class="fw-bold m-0 p-0 pt-1" style="width: 20%; height: 22px;">대결 기간</h5>
    <c:if test="${empty altApprover}">
	<div class="d-flex align-items-center justify-content-end" style="width: 70%;" aria-describedby="altApproverDateValidation">
	   <input type="date" id="proxyStartDate" class="form-control p-2" style="width: 44%; height: 25px; font-size: 0.8rem;" placeholder="위임 시작일" readonly >
	   <span class="fw-bold mx-2">~</span>
	   <input type="date" id="proxyEndDate" class="form-control p-2" style="width: 44%; height: 25px; font-size: 0.8rem;" placeholder="위임 종료일" readonly >
	</div>
    </c:if>
    <c:if test="${not empty altApprover}" >
    <div class="d-flex align-items-center justify-content-end" style="width: 70%;" aria-describedby="altApproverDateValidation">
	    <span class="fw-bold text-body-tertiary" id="proxyStartDate" style="font-size: 0.85rem; font-weight: 500; padding-top: 6px;"><fmt:formatDate value="${altApprover.altAprStartDate}" pattern="yyyy-MM-dd"/></span>
	    <span class="fw-bold mx-2 pt-2">~</span>
	    <span class="fw-bold text-body-tertiary" id="proxyEndDate" style="font-size: 0.85rem; font-weight: 500; padding-top: 6px;"><fmt:formatDate value="${altApprover.altAprEndDate}" pattern="yyyy-MM-dd"/></span>
	</div>
    </c:if>
</div>
<div id="altApproverDateValidation" class="form-text d-flex justify-content-end" style="font-size: .775em; margin-right: 7px; margin-top: 9px;"></div>
<hr class="my-1 mx-auto" style="width: 98%"/>
<div class="d-flex align-items-center justify-content-between mt-2 mb-3 w-100 px-2 pt-2">
    <h5 class="fw-bold m-0 p-0" style="width: 20%; height: 22px;">대결 사유</h5>
    <c:if test="${empty altApprover}">
	<textarea class="form-control" id="proxyReasonArea" cols="3" style="width: 68.5%; font-size:0.8rem;"></textarea>
    </c:if>
    <c:if test="${not empty altApprover}">
    <span class="fw-bold text-body-tertiary" id="proxyReasonArea" style="font-size: 0.85rem; font-weight: 500; padding-top: 6px;">${altApprover.altAprContent}</span>
    </c:if>
</div>
<hr class="my-1 mx-auto" style="width: 98%"/>
<c:if test="${empty altApprover}" >
<div class="d-flex justify-content-end mt-4">
    <button type="button" class="btn btn-secondary btn-sm me-2" style="background-color: #c8c8c8; border-color: #c8c8c8;" id="btnResetApprovalProxy">취소</button>
    <button type="button" class="btn btn-secondary btn-sm me-1" style="background-color: #5f5f5f;" id="btnSubmitApprovalProxy">확인</button>
</div>
</c:if>
<c:if test="${not empty altApprover}" >
<div class="d-flex justify-content-end mt-4">
    <button type="button" class="btn btn-secondary btn-sm me-1" style="background-color: #5f5f5f;" id="btnCancleApprovalProxy">해제</button>
</div>
</c:if>

<%@ include file="/WEB-INF/views/approval/approvalSettingSelectEmp.jsp" %>