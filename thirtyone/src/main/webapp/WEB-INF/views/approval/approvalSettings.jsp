<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/approval/approvalContainer.jsp"%>

<div class="sectionContainer d-flex justify-content-center p-0 w-100 h-100">
	<div class="defaultApprovalLineSetting h-100 me-3" style="width: 55%; margin-right: 10px;">
		<div class="card h-100">
		    <div class="card-body p-4">
				<iframe src="${pageContext.request.contextPath}/resources/html/approvalLine.html" width="100%" height="765px"></iframe>
		    </div>
		</div>
	</div>
	<div class="proxySetting1 h-100" style="width: 45%;">
		<div class="card mb-2">
		    <div class="card-body p-4">
				<iframe src="${pageContext.request.contextPath}/resources/html/approvalProxySetting.html" width="100%" height="277px" ></iframe>
		    </div>
		</div>
	    <div class="card my-2">
		    <div class="card-body p-4">
				<iframe src="${pageContext.request.contextPath}/resources/html/approvalProxyCheck.html" width="100%" height="160px;"></iframe>					        
		    </div>
		</div>
		<div class="card my-2">
	        <div class="card-body p-4 w-100">
				<iframe src="${pageContext.request.contextPath}/resources/html/approvalLineCheckList.html" width="100%" height="292px;"></iframe>			            
	        </div>
	    </div>
	</div>
</div>
<%@ include file="/WEB-INF/views/approval/approvalContainerFooter.jsp"%>