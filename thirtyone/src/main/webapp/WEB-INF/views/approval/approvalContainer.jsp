<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/document-form/businessTripDocument.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/document-form/businessTripReport.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/document-form/holidayDocument.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/document-form/holidayWork.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/document-form/workOvertime.css" />
<script src="https://cdn.tiny.cloud/1/4goby5nwvfox2v3joghm0derxikb93k0vbtgcjf42japthcq/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>

<div class="sectionContainer w-100">
	<div class="card">
        <div class="card-body p-4">
			<div class="d-flex align-items-center justify-content-between me-1">
				<p class="title-31 ps-1 pt-3">${title}</p>
				<c:if test="${title=='기안서 작성'}">
					<button id="draftSubmitButton" class="btn btn-secondary" style="width: 65px; height: 35px; padding: 3px; font-size: .9rem;">기안 상신</button>
				</c:if>
			</div>
			<hr class="m-0 mb-5" />
			<div class="px-4">