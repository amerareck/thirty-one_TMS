<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:forEach items="${aprList}" var="apr" varStatus="i" >
<c:set var="index" value="${i.index}" />
<div class="modal approveModal" id="approvalContext-${index}">
<div class="d-none approve-modal-index">${index}</div>
	<div class="modal-dialog" style="max-width: 1080px;">
	    <div class="modal-content">
	        <div class="modal-header">
	            <h3 class="modal-title fw-bold">전자결재 내용</h3>
	        </div>
	        
	        <div class="modal-body px-1 w-100 h-100">
	        	<div class="form-container w-100 px-5 py-2" >
		            <div class="d-flex justify-content-between w-100 p-2 my-2">
		                <div class="d-flex align-items-start justify-content-start" style="width: 30%">
		                    <label for="submittedDate" class="form-label fw-bold m-0" style="width: 30%" >상신 일자</label>
		                    <span id="submittedDate" style="width: auto"><fmt:formatDate value="${apr.docDraftDate}" pattern="yyyy-MM-dd"/></span>
		                </div>
		                <div class="d-flex align-items-start justify-content-start" style="width: 30%;">
		                    <label for="submittor" class="form-label fw-bold m-0" style="width: 30%">기안자</label>
		                    <span id="submittor" style="width: auto;">[${apr.deptName}]&nbsp;${apr.empInfo.empName}&nbsp;${apr.empInfo.position}</span>
		                </div>
		                <div class="d-flex align-items-start justify-content-start" style="width: 30%;">
		                    <label for="referrer" class="form-label fw-bold m-0" style="width: 30%">참조자</label><br />
		                    <div class="d-flex align-items-start justify-content-center flex-column">
		                    <c:forEach items="${apr.docReferenceList}" var="ref" varStatus="idx">
		                    <span id="referrer"style="width: auto;" class="${apr.docReferenceList.size()-1 == idx.index ? '' : 'pb-2'}" >[${ref.deptName}]${ref.empName}&nbsp;${ref.position}</span>
		                    </c:forEach>
		                    </div>
		                </div>
		            </div>
		            <div class="d-flex justify-content-between w-100 p-2 my-2">
	                <div class="d-flex align-items-start justify-content-start" style="width: 30%">
	                    <label for="approveDraft" class="form-label fw-bold m-0 mt-2" style="width: 30%" >결재</label>
	                    <select class="form-select approval-result" style="width: 70%;">
	                        <option value="승인" selected>승인</option>
	                        <option value="보류">보류</option>
	                        <option value="반려">반려</option>
	                    </select>
	                </div>
		            <c:if test="${apr.alternativeApproval}" >
		                <div class="d-flex align-items-start justify-content-start" style="width: 30%">
		                    <label for="approvalType" class="form-label fw-bold m-0 mt-2" style="width: 30%">결재 유형</label>
		                    <select class="form-select approval-type" style="width: 70%;" id="approvalType" disabled>
		                        <option value="일반" disabled>일반</option>
		                        <option value="전결" disabled>전결</option>
		                        <option value="대결" selected>대결</option>
		                        <option value="선결" disabled >선결</option>
		                    </select>
		                </div>
		            </c:if>
		            <c:if test ="${!apr.alternativeApproval}" >
		                <div class="d-flex align-items-start justify-content-start" style="width: 30%">
		                    <label for="approvalType" class="form-label fw-bold m-0 mt-2" style="width: 30%">결재 유형</label>
		                    <select class="form-select approval-type" style="width: 70%;" id="approvalType">
		                        <option value="일반" selected>일반</option>
		                        <option value="전결" >전결</option>
		                        <option value="대결" disabled >대결</option>
		                        <option value="선결" disabled >선결</option>
		                    </select>
		                </div>
		            </c:if>
		                <div class="d-flex align-items-start justify-content-start pt-2" style="width: 30%">
	                    	<label for="approvalStatus" class="form-label fw-bold m-0" style="width: 30%; line-height: 1.4">결재 상태</label>
	                		<input type="text" readonly class="form-control-plaintext p-0" id="approvalStatus" value="${apr.docAprStatus}" style="width: 70%;">
		                </div>
		            </div>
		            <div class="d-flex justify-content-between w-100 p-2 my-2">
		                <div class="d-flex align-items-top justify-content-start" style="width: 70%">
		                    <label for="approveComment" class="form-label fw-bold m-0" style="width: 15%">결재 의견</label>
		                    <div class="d-flex align-items-top flex-column" id="approveComment-${index}" style="width: 80%" data-seq-count="${apr.docApprovalLine.size()}">
		                    	<c:forEach items="${apr.docApprovalLine}" var="aprLine">
			                    	<c:if test="${aprLine.docAprState == '승인' || aprLine.docAprState == '반려'}" >
				                    	<div class="w-100 mb-1">
				                    		<c:if test="${empty aprLine.approverProxyInfo}">
				                    			<span class="fw-bold w-25">${aprLine.approverInfo.empName}&nbsp;${aprLine.approverInfo.position}</span>
			                    			</c:if>
			                    			<c:if test="${not empty aprLine.approverProxyInfo}">
				                    			<span class="fw-bold w-25">${aprLine.approverProxyInfo.empName}&nbsp;${aprLine.approverProxyInfo.position}</span>
			                    			</c:if>
				                    		<span class="w-75">- ${aprLine.docAprComment}</span>
										</div>
			                    	</c:if>
			                    	<c:if test="${aprLine.docAprState == '대기' || aprLine.docAprState == '진행' || aprLine.docAprState == '보류'}" >
			                    		<div class="w-100 mb-1">
			                    			<c:if test="${empty aprLine.approverProxyInfo}">
				                    			<span class="fw-bold w-25">${aprLine.approverInfo.empName}&nbsp;${aprLine.approverInfo.position}</span>
			                    			</c:if>
			                    			<c:if test="${not empty aprLine.approverProxyInfo}">
				                    			<span class="fw-bold w-25">${aprLine.approverProxyInfo.empName}&nbsp;${aprLine.approverProxyInfo.position}</span>
			                    			</c:if>
				                    		<span class="w-75">- 결재 전</span>
										</div>
			                    	</c:if>
		                    	</c:forEach>
		                    </div>
		                </div>
		            </div>
		            <div class="d-flex justify-content-between w-100 p-2 my-2">
		                <div class="d-flex align-items-top justify-content-start" style="width: 70%">
		                    <label for="approveComment" class="form-label fw-bold m-0" style="width: 13%">의견</label>
		                    <textarea class="form-control approval-comment" id="approveComment" cols="3" style="width: 80%"></textarea>
		                </div>
		            </div>
	        	</div>
	
	            <hr style="margin: 20px 0" />
	
	            <div class="d-flex document-container w-100 p-2 justify-content-center align-items-center">
	                <div class="d-none reviewer-info" data-seq="${apr.reviewingApproverSeq}" data-position="${apr.nowApprover.position}" data-name="${apr.nowApprover.empName}"></div>
	                <div class="mt-2 w-100 h-auto" style="width:80%;">
	                    <textarea id="documentContext-${index}" class="w-auto h-auto" data-docNumber="${apr.docNumber}"></textarea>
	                </div>
	                <div class="approvalLineList my-auto" style="width:20%">
	                    <c:forEach items="${apr.docApprovalLine}" var="docApr" varStatus="idx" >
	                		<div class="d-flex flex-column approval-line-cube border border-dark p-2 mt-2" style="margin: 0 auto;">
		                        <c:if test="${not empty docApr.approverProxyInfo}">
		                        	<p class="approval-line-cube-info">${docApr.approverProxyInfo.deptName}</p>
			                        <p class="approval-line-cube-info">&nbsp;</p>
			                        <span class="text-center fs-6 mt-auto" style="font-size: 11pt;"><b>${docApr.approverProxyInfo.empName}</b>&nbsp;${docApr.approverProxyInfo.position}</span>
			                        <p class="approval-line-cube-info">&nbsp;</p>
			                        <p class="approval-line-cube-info text-center">(<fmt:formatDate value="${docApr.docAprDate}" pattern="yy-MM-dd" />)</p>
			                        <div class="fw-bold fs-5 text-center mt-auto">대결</div>
		                        <hr/>
		                        </c:if>
		                        <p class="approval-line-cube-info">${docApr.approverInfo.deptName}</p>
		                        <p class="approval-line-cube-info">&nbsp;</p>
		                        <span class="text-center fs-6 mt-auto" style="font-size: 11pt;"><b>${docApr.approverInfo.empName}</b>&nbsp;${docApr.approverInfo.position}</span>
		                        <p class="approval-line-cube-info">&nbsp;</p>
		                        <div class="fw-bold fs-5 text-center mt-auto">${docApr.docAprState}</div>
		                        <p class="approval-line-cube-info">&nbsp;</p>
	                    	</div>
	                    	<c:if test="${idx.count != apr.docApprovalLine.size()}">
		                    	<div class="text-center my-3">
		                        	<i class="fa-solid fa-chevron-down"></i>
		                    	</div>
	                    	</c:if>
	                	</c:forEach>
	                </div>
	            </div>
	        </div>
	
	        <div class="modal-footer d-flex justify-content-center" style="margin: 40px 0; padding: 20px 12px; border-top: none;">
	            <button type="button" class="btn btn-custom-cancel button-large text-center mx-2" data-bs-dismiss="modal">취소</button>
	            <button type="button" class="btn btn-custom-confirm button-large text-center ms-2 approveSubmit">결정</button>
	        </div>
	    </div>
	</div>
</div>
</c:forEach>