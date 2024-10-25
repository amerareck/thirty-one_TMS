<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="modal" id="approvalContext">
	<div class="modal-dialog">
	    <div class="modal-content">
	        <div class="modal-header">
	            <h3 class="modal-title fw-bold">전자결재 내용</h3>
	        </div>
	        
	        <div class="modal-body px-1 w-100 h-100">
	        	<div class="form-container w-100 px-5 py-2" >
		            <div class="d-flex justify-content-between w-100 p-2 my-2">
		                <div class="d-flex align-items-center justify-content-start" style="width: 30%">
		                    <label for="submittedDate" class="form-label fw-bold m-0" style="width: 30%" >상신 일자</label>
		                    <span id="submittedDate" style="width: auto">2024-10-10</span>
		                </div>
		                <div class="d-flex align-items-center justify-content-start" style="width: 30%;">
		                    <label for="submittor" class="form-label fw-bold m-0" style="width: 30%">기안자</label>
		                    <span id="submittor" style="width: auto;">[공공사업1Div] 정준하 과장</span>
		                </div>
		                <div class="d-flex align-items-center justify-content-start" style="width: 30%;">
		                    <label for="referrer" class="form-label fw-bold m-0" style="width: 30%">참조자</label><br />
		                    <span id="referrer" style="width: auto;">[경영지원실]김태호 부장</span>
		                </div>
		            </div>
		            <div class="d-flex justify-content-between w-100 p-2 my-2">
		                <div class="d-flex align-items-center justify-content-start" style="width: 30%">
		                    <label for="approveDraft" class="form-label fw-bold m-0" style="width: 30%" >결재</label>
		                    <select class="form-select" style="width: 70%;">
		                        <option value="approval" selected>승인</option>
		                        <option value="approva2">보류</option>
		                        <option value="approva3">반려</option>
		                    </select>
		                </div>
		                <div class="d-flex align-items-center justify-content-start" style="width: 30%">
		                    <label for="approvalType" class="form-label fw-bold m-0" style="width: 30%">결재 유형</label>
		                    <select class="form-select" style="width: 70%;" id="approvalType" disabled>
		                        <option value="approvalType1" selected>일반</option>
		                        <option value="approvalType2">전결</option>
		                        <option value="approvalType3">대결</option>
		                        <option value="approvalType4">선결</option>
		                    </select>
		                </div>
		                <div class="d-flex align-items-center justify-content-start" style="width: 30%">
	                    	<label for="approvalStatus" class="form-label fw-bold m-0" style="width: 30%">결재 상태</label>
	                		<input type="text" readonly class="form-control-plaintext" id="approvalStatus" value="대기" style="width: 70%;">
		                </div>
		            </div>
		            <div class="d-flex justify-content-between w-100 p-2 my-2">
		                <div class="d-flex align-items-top justify-content-start" style="width: 70%">
		                    <label for="approveComment" class="form-label fw-bold m-0" style="width: 13%">의견</label>
		                    <textarea class="form-control" id="approveComment" cols="3" style="width: 80%"></textarea>
		                </div>
		            </div>
	        	</div>
	
	            <hr style="margin: 20px 0" />
	
	            <div class="d-flex document-container w-100 p-2">
	                <div class="mt-2" style="width:80%;">
	                	<div class="w-100 h-100">
		                    <textarea id="documentContext" class="w-100 h-100"></textarea>
	                	</div>
	                </div>
	                <div class="approvalLineList my-auto" style="width:20%">
	                    <div class="d-flex flex-column approval-line-cube border border-dark p-2 mt-2" style="margin: 0 auto;">
	                        <p class="approval-line-cube-info">공공사업본부</p>
	                        <p class="approval-line-cube-info">공공사업1Div</p>
	                        <span class="text-center fs-6 mt-auto" style="font-size: 11pt;"><b>박명수</b> 차장</span>
	                        <div class="fw-bold fs-5 text-center mt-auto">대기</div>
	                    </div>
	                    <div class="text-center my-3">
	                        <i class="fa-solid fa-chevron-down"></i>
	                    </div>
	                    <div class="d-flex flex-column approval-line-cube border border-dark p-2 mt-2" style="margin: 0 auto;">
	                        <p class="approval-line-cube-info">공공사업본부</p>
	                        <p class="approval-line-cube-info">공공사업1Div</p>
	                        <span class="text-center fs-6 mt-auto" style="font-size: 11pt;"><b>유재석</b> 부장</span>
	                        <div class="fw-bold fs-5 text-center mt-auto">대기</div>
	                    </div>
	                    <div class="text-center my-3">
	                        <i class="fa-solid fa-chevron-down"></i>
	                    </div>
	                    <div class="d-flex flex-column approval-line-cube border border-dark p-2 mt-2" style="margin: 0 auto;">
	                        <p class="approval-line-cube-info">임원실</p>
	                        <p class="approval-line-cube-info">대표이사</p>
	                        <span class="text-center fs-6 mt-auto" style="font-size: 11pt;"><b>오티아이</b> 대표</span>
	                        <div class="fw-bold fs-5 text-center mt-auto">대기</div>
	                    </div>
	                </div>
	            </div>
	        </div>
	
	        <div class="modal-footer d-flex justify-content-center" style="margin: 40px 0; padding: 20px 12px; border-top: none;">
	            <button type="button" class="btn btn-custom-cancel button-large text-center mx-2" data-bs-dismiss="modal">취소</button>
	            <button type="button" class="btn btn-custom-confirm button-large text-center ms-2">결정</button>
	        </div>
	    </div>
	</div>
</div>