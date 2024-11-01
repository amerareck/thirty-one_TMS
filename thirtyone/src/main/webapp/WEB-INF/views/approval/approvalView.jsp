<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="modal" id="approvalView">
	<div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	        <div class="modal-header">
	            <h3 class="modal-title fw-bold">전자결재 열람</h3>
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
		                    <label for="approvalCompleteDate" class="form-label fw-bold m-0" style="width: 30%" >완결 일자</label>
		                    <span id="approvalCompleteDate" style="width: auto;">2024-10-12</span>
		                </div>
		                <div class="d-flex align-items-center justify-content-start" style="width: 30%">
		                    <label for="finalApprover" class="form-label fw-bold m-0" style="width: 30%">최종결재자</label>
		                    <span id="finalApprover" style="width: auto;">[공공사업1Div] 유재석 부장</span>
		                </div>
		                <div class="d-flex align-items-center justify-content-start" style="width: 30%">
	                    	<label for="approvalStatus" class="form-label fw-bold m-0" style="width: 30%">결재 상태</label>
	                		<input type="text" readonly class="form-control-plaintext" id="approvalStatus" value="승인" style="width: 70%;">
		                </div>
		            </div>
		            <div class="d-flex justify-content-between w-100 p-2 my-2">
		                <div class="d-flex align-items-top justify-content-start" style="width: 70%">
		                    <label for="approveComment" class="form-label fw-bold m-0" style="width: 13%">최종 의견</label>
		                    <div class="d-flex align-items-top flex-column" id="approveComment" style="width: 80%">
		                    	<div class="w-100 mb-1">
		                    		<span class="fw-bold w-25">김이박 차장</span>
		                    		<span class="w-75">- 의견 없음</span>
								</div>
								<div class="w-100 mb-1">
		                    		<span class="fw-bold w-25">유재석 부장</span>
		                    		<span class="w-75">- 출장 후, 미팅 바랍니다.</span>
								</div>
		                    </div>
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
	                        <p class="approval-line-cube-info">&nbsp;</p>
	                        <span class="text-center fs-6 mt-auto" style="font-size: 11pt;"><b>박명수</b> 차장</span>
	                        <p class="approval-line-cube-info">&nbsp;</p>
	                        <p class="approval-line-cube-info text-center">[대결]</p>
	                        <p class="approval-line-cube-info text-center">(24-10-12)</p>
	                        <span class="text-center fs-6 mt-auto" style="font-size: 11pt;"><b>김이박</b> 차장</span>
	                        <p class="approval-line-cube-info">&nbsp;</p>
	                        <div class="fw-bold fs-5 text-center mt-auto">승인</div>
	                    </div>
	                    <div class="text-center my-3">
	                        <i class="fa-solid fa-chevron-down"></i>
	                    </div>
	                    <div class="d-flex flex-column approval-line-cube border border-dark p-2 mt-2" style="margin: 0 auto;">
	                        <p class="approval-line-cube-info">공공사업본부</p>
	                        <p class="approval-line-cube-info">공공사업1Div</p>
	                        <p class="approval-line-cube-info">&nbsp;</p>
	                        
	                        <p class="approval-line-cube-info text-center">[전결]</p>
	                        <p class="approval-line-cube-info text-center">(24-10-12)</p>
	                        <span class="text-center fs-6 mt-auto" style="font-size: 11pt;"><b>유재석</b> 부장</span>
	                        <p class="approval-line-cube-info">&nbsp;</p>
	                        <div class="fw-bold fs-5 text-center mt-auto">승인</div>
	                    </div>
	                    <div class="text-center my-3">
	                        <i class="fa-solid fa-chevron-down"></i>
	                    </div>
	                    <div class="d-flex flex-column approval-line-cube border border-dark p-2 mt-2" style="margin: 0 auto;">
	                        <p class="approval-line-cube-info">임원실</p>
	                        <p class="approval-line-cube-info">대표이사</p>
	                        <p class="approval-line-cube-info">&nbsp;</p>
	                        <span class="text-center fs-6 mt-auto" style="font-size: 11pt;"><b>오티아이</b> 대표</span>
	                        <p class="approval-line-cube-info">&nbsp;</p>
	                        <div class="fw-bold fs-5 text-center mt-auto">위임</div>
	                    </div>
	                </div>
	            </div>
	        </div>
	
	        <div class="modal-footer d-flex justify-content-center" style="margin: 40px 0; padding: 20px 12px; border-top: none;">
	            <button type="button" class="btn btn-custom-confirm button-large text-center ms-2" data-bs-dismiss="modal">확인</button>
	        </div>
	    </div>
	</div>
</div>