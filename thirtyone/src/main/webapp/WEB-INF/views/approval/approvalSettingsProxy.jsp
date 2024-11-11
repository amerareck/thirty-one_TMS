<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<h3 class="fw-bold my-0 pb-0" style="padding-top: 16pt;">대결자 설정</h3>
<hr class="mt-2 mb-2" style="border-top: 2px solid" />

<div class="d-flex align-items-center mt-3 w-100 px-2 pt-2">
    <h5 class="fw-bold m-0 p-0 pt-1" style="width: 40%; height: 22px;">결재 대리자</h5>
	<div class="d-flex justify-content-end" style="width: 60%">
		<span class="fw-boldtext-body-tertiary" style="font-size: 0.85rem; font-weight: 500; padding-top: 6px;">대리자 없음</span>
		<button type="button" class="btn btn-tertiary btn-sm d-flex align-items-center" style="height: 22px; margin-top: 3px;" data-bs-toggle="modal" data-bs-target="#selectAltApproverModal"><i class="fa-solid fa-magnifying-glass"></i></button>
	</div>
	<div class="d-none proxy-info"></div>
</div>
<hr class="my-1 mx-auto" style="width: 97%"/>
<div class="d-flex align-items-center justify-content-between mt-3 w-100 px-2 pt-2">
    <h5 class="fw-bold m-0 p-0 pt-1" style="width: 20%; height: 22px;">대결 기간</h5>
	<div class="d-flex align-items-center justify-content-end" style="width: 70%;">
	   <input type="date" id="proxyStartDate" class="form-control p-2" style="width: 44%; height: 25px; font-size: 0.8rem;" placeholder="위임 시작일" readonly >
	   <span class="fw-bold mx-2">~</span>
	   <input type="date" id="proxyEndDate" class="form-control p-2" style="width: 44%; height: 25px; font-size: 0.8rem;" placeholder="위임 종료일" readonly >
	</div>
</div>
<hr class="mt-2 mb-1 mx-auto" style="width: 98%"/>
<div class="d-flex align-items-center justify-content-between mt-3 mb-2 w-100 px-2 pt-2">
    <h5 class="fw-bold m-0 p-0" style="width: 20%; height: 22px;">대결 사유</h5>
	<textarea class="form-control" cols="3" style="width: 68.5%; font-size:0.8rem;"></textarea>
</div>
<hr class="mt-1 mb-2 mx-auto" style="width: 98%"/>
<div class="d-flex justify-content-center mt-4">
    <button type="button" class="btn btn-custom-cancel btn-custom-sm me-3" id="btnResetApprovalProxy">취소</button>
    <button type="button" class="btn btn-custom-confirm btn-custom-sm" id="btnSubmitApprovalProxy">확인</button>
</div>

<%@ include file="/WEB-INF/views/approval/approvalSettingSelectEmp.jsp" %>