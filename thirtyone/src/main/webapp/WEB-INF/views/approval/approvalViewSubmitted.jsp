<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:forEach items="${draftList}" var="draft" varStatus="i" >
<div class="modal" id="approvalView-${i.index}">
	<div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	        <div class="modal-header">
	            <h3 class="modal-title fw-bold">전자결재 열람</h3>
	        </div>
	        
	        <div class="modal-body px-1 w-100 h-100">
	        	<div class="form-container w-100 px-5 py-2" >
		            <div class="d-flex justify-content-between w-100 p-2 my-2">
		                <div class="d-flex align-items-center justify-content-start" style="width: 25%">
		                    <label for="submittedDate" class="form-label fw-bold m-0" style="width: 40%" >상신 일자</label>
		                	<span id="submittedDate" style="width: auto"><fmt:formatDate value="${draft.docDraftDate}" pattern="yyyy-MM-dd" /></span> 
		                </div>
		                <div class="d-flex align-items-center justify-content-start" style="width: 35%;">
		                    <label for="submittor" class="form-label fw-bold m-0" style="width: 30%">기안자</label>
		                    <span id="submittor" style="width: auto;">[${draft.deptName}] ${draft.empName} ${draft.empPosition}</span>
		                </div>
		                <div class="d-flex align-items-start justify-content-start" style="width: 30%;">
		                    <label for="referrer" class="form-label fw-bold m-0 align-self-center" style="width: 30%">참조자</label><br />
	                    	<div class="d-flex align-items-center justify-content-start flex-column">
		                    <c:forEach items="${draft.docReferenceList}" var="refer" varStatus="i" >
				                    <span id="referrer" style="width: auto;" class="${draft.docReferenceList.size()-1 == i.index ? '' : 'pb-2'}">[${refer.deptName}]&nbsp;${refer.empName}&nbsp;${refer.position}</span>
		                    </c:forEach>
	                    	</div>
		                </div>
		            </div>
		            <div class="d-flex justify-content-between w-100 p-2 my-2">
		                <div class="d-flex align-items-center justify-content-start" style="width: 25%">
		                    <label for="approvalCompleteDate" class="form-label fw-bold m-0" style="width: 40%" >완결 일자</label>
		                	<c:set var="lastIndex" value="${draft.docApprovalLine.size() - 1}" />
							<c:if test="${draft.docApprovalLine[lastIndex].docAprState == '대기' || draft.docApprovalLine[lastIndex].docAprState == '보류'}">
		                    	<span id="approvalCompleteDate" style="width: auto;">N/A</span>
		                    </c:if>
		                    <c:if test="${draft.docApprovalLine[lastIndex].docAprState == '승인' || draft.docApprovalLine[lastIndex].docAprState == '반려' || draft.docApprovalLine[lastIndex].docAprState == '위임'}">
		                    	<span id="approvalCompleteDate" style="width: auto;"><fmt:formatDate value="${draft.docApprovalLine[lastIndex].docAprDate}" pattern="yyyy-MM-dd" /></span>
		                    </c:if>
		                </div>
		                <div class="d-flex align-items-center justify-content-start" style="width: 35%">
		                    <label for="finalApprover" class="form-label fw-bold m-0" style="width: 30%">최종결재자</label>
			                    <span id="finalApprover" style="width: auto;">[${draft.lastApprover.deptName}] ${draft.lastApprover.empName} ${draft.lastApprover.position}</span>
		                </div>
		                <div class="d-flex align-items-center justify-content-start" style="width: 30%">
	                    	<label for="approvalStatus" class="form-label fw-bold m-0" style="width: 30%">결재 상태</label>
	                		<input type="text" readonly class="form-control-plaintext" id="approvalStatus" value="${draft.approveState}" style="width: 70%;">
		                </div>
		            </div>
		            <div class="d-flex justify-content-between w-100 p-2 my-2">
		                <div class="d-flex align-items-top justify-content-start" style="width: 70%">
		                    <label for="approveComment" class="form-label fw-bold m-0" style="width: 15%">최종 의견</label>
		                    <div class="d-flex align-items-top flex-column" id="approveComment" style="width: 80%">
		                    	<c:forEach items="${draft.docApprovalLine}" var="aprLine">
			                    	<c:if test="${aprLine.docAprState == '승인' || aprLine.docAprState == '반려'}" >
				                    	<div class="w-100 mb-1">
				                    		<span class="fw-bold w-25">${aprLine.approverInfo.empName}&nbsp;${aprLine.approverInfo.position}</span>
				                    		<span class="w-75">- ${aprLine.docAprComment}</span>
										</div>
			                    	</c:if>
			                    	<c:if test="${aprLine.docAprState == '대기' || aprLine.docAprState == '진행' || aprLine.docAprState == '보류'}" >
			                    		<div class="w-100 mb-1">
				                    		<span class="fw-bold w-25">${aprLine.approverInfo.empName}&nbsp;${aprLine.approverInfo.position}</span>
				                    		<span class="w-75">- 결재 전</span>
										</div>
			                    	</c:if>
		                    	</c:forEach>
		                    </div>
		                </div>
		            </div>
	        	</div>
	
	            <hr style="margin: 20px 0" />
	
	            <div class="d-flex document-container w-100 p-2 justify-content-center align-items-center">
	                <div class="mt-2 w-75 h-auto">
		                <textarea id="documentContext" class="w-auto h-auto"></textarea>
	                </div>
	                <div class="approvalLineList my-auto" style="width:20%">
	                    <div class="d-flex flex-column approval-line-cube border border-dark p-2 mt-2" style="margin: 0 auto;">
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
</c:forEach>