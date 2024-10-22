<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div class="card w-100">
	<div class="card-body">
		<div class="sectionContainer d-flex justify-content-center p-0 w-100 h-100">
			<div class="defaultApprovalLineSetting h-100" style="width: 55%; margin-right: 10px;">
				<iframe src="${pageContext.request.contextPath}/resources/html/approvalLine.html" width="100%" height="100%"></iframe>
			</div>
			<div class="proxySetting1 h-100" style="width: 45%;">
				<iframe class="mb-1" src="${pageContext.request.contextPath}/resources/html/approvalProxySetting.html" width="100%" height="328px;" ></iframe>
				<iframe class="my-1" src="${pageContext.request.contextPath}/resources/html/approvalProxyCheck.html" width="100%" height="177px;"></iframe>
				<iframe class="my-1" src="${pageContext.request.contextPath}/resources/html/approvalLineCheckList.html" width="100%" height="350px;"></iframe>
			</div>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>