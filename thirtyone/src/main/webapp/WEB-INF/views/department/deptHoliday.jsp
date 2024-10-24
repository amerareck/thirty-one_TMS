<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/department/deptHoliday.css" />
<div class="content-box">
	<div class="main-container" >
		<p class="title-31">${title}</p>
		<div class="dept-atd-subtitle sub-title">
			<div><a href="#">부서 근태</a></div>
			<div><a href="#">부서 일정</a></div>
		</div>
		<div class="main-line"></div>
		<div id="calendar" class="main-calendar"></div>
		
		
		
		
		
		
		
		
		
		
		
		
		
<script src="${pageContext.request.contextPath}/resources/js/department/deptHoliday.js"></script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>