<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700" rel="stylesheet">
	
	<link href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/header.css"/>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
	
	<script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.bundle.min.js"></script>
	<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
	
	
	<c:if test="${ApprovalRequest}">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/approval/approvalLine.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/document-form/businessTripReport.css" />
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/themes/default/style.min.css" />
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
		
		<script src="https://cdn.tiny.cloud/1/zt811056qttf1h18ihxacac59l9xi81x71c2zv8l9cs330q6/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
	</c:if>
	
	<title>ThirtyOne - 근태관리시스템</title>
	
</head>
<body>
	<div class="header">
		<img class="logo-image" src="${pageContext.request.contextPath}/resources/image/logo.png">
		<div class="profile-img-box">
			<img class="profile-img" src="${pageContext.request.contextPath}/resources/image/profileDefault.png">
			<div class="emp-name-box">
				<span class="emp-name">정원석사원</span>
				<span class="dept-name">공공사업1DIV</span>
			</div>
			<img class="three-dots-vertical" src="${pageContext.request.contextPath}/resources/image/three-dots-vertical.svg">
		</div>
	</div>
	<div class="container-box" >
		<div class="sidebar">
			<div class="sidebar-attendance">
				<p class="sidebar-today">2024년10월17일</p>
				<h1 class="sidebar-today-time">19:02:40</h1>
				<div class="sidebar-start-time">
					<span>출근시간</span>
					<span>08:43</span>
				</div>
				<div class="sidebar-end-time">
					<span>퇴근시간</span>
					<span>18:01</span>
				</div>
				<div class="sidebar-attendance-btn">
					<button class="button-small sidebar-start">출근하기</button>
					<button class="button-small sidebar-end">퇴근하기</button>
				</div>
				<div class="sidebar-line"></div>
			</div>
			<%-- ############################### 아코디언 #################################### --%>
			<div class="nav-bar">
				<div class="sidebar-home sidebar-title ${selectedTitle=='home'? 'selected' : ''}" onclick="location.href='${pageContext.request.contextPath}/'">
					<div>
					    <img class="home-icon sidebar-icon" 
					        src="${pageContext.request.contextPath}${selectedTitle != 'home' ? '/resources/image/icon/home.svg' : '/resources/image/icon/home-selected.svg'}" />
					    <a href="${pageContext.request.contextPath}/">홈</a>
					</div>
					<img class="arrow home-arrow" 
					    src="${pageContext.request.contextPath}${selectedTitle != 'home' ? '/resources/image/icon/arrow.svg' : '/resources/image/icon/arrow-selected.svg'}" />

				 </div>
				 <div class="sidebar-notice sidebar-title ${selectedTitle=='notice'? 'selected' : ''}" onclick="location.href='${pageContext.request.contextPath}/notice/noticeList'">
					<div>
						<img class="notice-icon sidebar-icon" 
							src="${pageContext.request.contextPath}${selectedTitle != 'notice' ? '/resources/image/icon/notice.svg' : '/resources/image/icon/notice-selected.svg'}" />
						<a href="#">공지사항</a>
					</div>
					<img class="arrow home-arrow" 
					    src="${pageContext.request.contextPath}${selectedTitle != 'notice' ? '/resources/image/icon/arrow.svg' : '/resources/image/icon/arrow-selected.svg'}" />
				</div>
				<div class="sidebar-approval sidebar-title ${selectedTitle=='approval'? 'selected' : ''}">
					<div>
						<img class="approval-icon sidebar-icon" 
						src="${pageContext.request.contextPath}${selectedTitle != 'approval' ? '/resources/image/icon/approval.svg' : '/resources/image/icon/approval-selected.svg'}" />
						<a href="#">전자결재</a>
					</div>
					<img class="arrow home-arrow" 
					    src="${pageContext.request.contextPath}${selectedTitle != 'approval' ? '/resources/image/icon/arrow.svg' : '/resources/image/icon/arrow-selected.svg'}" />
				</div>
				<div class="sidebar-subtitle-box ${selectedTitle=='approval'? 'selected-sub' : ''}">
					<div class="sidebar-subtitle ${selectedSub == 'draft' ? 'sub-selected' : ''}"><a href="${pageContext.request.contextPath}/approval/draft">기안서 작성</a></div>
					<div class="sidebar-subtitle ${selectedSub == 'apr' ? 'sub-selected' : ''}" data-subtitle="apr-subtitle"><a href="${pageContext.request.contextPath}/approval/approveList">결재 하기</a></div>
					<div class="sidebar-subtitle ${selectedSub == 'preApr' ? 'sub-selected' : ''}"><a href="${pageContext.request.contextPath}/approval/before">결재 전단계</a></div>
					<div class="sidebar-subtitle ${selectedSub == 'processStatus' ? 'sub-selected' : ''}" data-subtitle="preresult-recall-subtitle"><a href="${pageContext.request.contextPath}/approval/submitted">기결/회수</a></div>
					<div class="sidebar-subtitle ${selectedSub == 'processCompleted' ? 'sub-selected' : ''}" data-subtitle="apr-rejection-subtitle"><a href="${pageContext.request.contextPath}/approval/collected">승인/반려</a></div>
					<div class="sidebar-subtitle ${selectedSub == 'document' ? 'sub-selected' : ''}" data-subtitle="doc-subtitle"><a href="${pageContext.request.contextPath}/approval/deptBox">문서함</a></div>
					<div class="sidebar-subtitle ${selectedSub == 'settings' ? 'sub-selected' : ''}"><a href="${pageContext.request.contextPath}/approval/settings">설정</a></div>
				</div>

				<div class="sidebar-hr sidebar-title ${selectedTitle=='hr'? 'selected' : ''}" onclick="location.href='${pageContext.request.contextPath}/atd/'">
					<div>
						<img class="hr-icon sidebar-icon" 
							src="${pageContext.request.contextPath}${selectedTitle != 'hr' ? '/resources/image/icon/hr.svg' : '/resources/image/icon/hr-selected.svg'}" />
						<a href="#">HR</a>
					</div>
					<img class="arrow home-arrow" 
					    src="${pageContext.request.contextPath}${selectedTitle != 'hr' ? '/resources/image/icon/arrow.svg' : '/resources/image/icon/arrow-selected.svg'}" />
				</div>
				<div class="sidebar-subtitle-box  ${selectedTitle=='hr'? 'selected-sub' : ''}" >
					<div class="sidebar-subtitle ${selectedSub == 'attendance' ? 'sub-selected' : ''}" data-subtitle="attendance-subtitle"><a>근태</a></div>
					<div class="sidebar-subtitle ${selectedSub == 'holiday' ? 'sub-selected' : ''}" data-subtitle="holiday-subtitle"><a href="#">휴가</a></div>
					<div class="sidebar-subtitle ${selectedSub == 'deptAtd' ? 'sub-selected' : ''}" data-subtitle="dept-atd-subtitle"><a href="#">부서</a></div>
				</div>

			</div>
		</div>
<%-- 		<div class="content-box">
			<div class="main-container" >
			<p class="title-31">${title}</p> --%>
			<!--<div class="dept-atd-subtitle sub-title">
					<div><a href="#">부서 근태</a></div>
					<div><a href="#">부서 일정</a></div>
				</div>
				<div class="apr-subtitle sub-title">
					<div><a href="#">결재 대기</a></div>
					<div><a href="#">전체 결재 목록</a></div>
				</div>
				<div class="preresult-recall-subtitle sub-title">
					<div><a href="#">결재 상신</a></div>
					<div><a href="#">회수 문서</a></div>
				</div>
				<div class="apr-rejection-subtitle sub-title">
					<div><a href="#">승인 문서</a></div>
					<div><a href="#">반려 문서</a></div>
				</div>
				<div class="doc-subtitle sub-title">
					<div><a href="#">부서결재함</a></div>
					<div><a href="#">완결 문서</a></div>
					<div><a href="#">참조 문서</a></div>
				</div> -->
				
				<!-- <div class="main-line"></div> -->

		
		
					