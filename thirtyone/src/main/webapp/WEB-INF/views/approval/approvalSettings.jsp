<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/approval/approvalContainer.jsp"%>

<div class="sectionContainer d-flex justify-content-center align-items-stretch p-0 w-100 h-100" id="approvalSettingsContainer" style="max-width: 1100px;">
	<div class="defaultApprovalLineSetting me-3 h-auto" style="width: 55%; margin-right: 10px;">
		<div class="card h-100">
		    <div class="card-body p-4 h-100" id="settingApprovalLine">
		    	<%@ include file="/WEB-INF/views/approval/approvalSettingsLine.jsp" %>
		    </div>
		</div>
	</div>
	<div class="proxySetting1 h-auto d-flex flex-column justify-content-between" style="width: 45%; max-width: 466px; min-height: 845px;">
		<div class="card mb-2 h-auto">
		    <div class="card-body p-4">
				<%@ include file="/WEB-INF/views/approval/approvalSettingsProxy.jsp" %>
		    </div>
		</div>
	    <div class="card my-2 h-auto">
		    <div class="card-body p-4">
				<%@ include file="/WEB-INF/views/approval/approvalSettingsProxyCheck.jsp" %>
		    </div>
		</div>
		<div class="card mt-2 mb-0 h-auto">
	        <div class="card-body p-4 w-100 d-flex flex-column" id="settingApprovalLineList">
	        	<%@ include file="/WEB-INF/views/approval/approvalSettingsLineList.jsp" %>
	        </div>
	    </div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="${pageContext.request.contextPath}/resources/js/approval/settings.js"></script>
<%@ include file="/WEB-INF/views/approval/approvalContainerFooter.jsp"%>