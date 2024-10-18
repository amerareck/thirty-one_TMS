<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700" rel="stylesheet">

	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
	<script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js"></script>
	<link href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.css" rel="stylesheet">
	<script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.bundle.min.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/header.css"/>
	
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
	
	<script src="${pageContext.request.contextPath}/resources/js/common/header.js"></script>
	
	<title>31</title>
	
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
				<span class="sidebar-today">2024년10월17일</span>
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
				<div class="sidebar-home sidebar-title">
					<div>
						<img class="home-icon sidebar-icon" src="${pageContext.request.contextPath}/resources/image/icon/home.svg"
						data-original-src="${pageContext.request.contextPath}/resources/image/icon/home.svg"
						data-active-src="${pageContext.request.contextPath}/resources/image/icon/home-selected.svg"
						/>
						<a href="#">홈</a>
					</div>
					<img class="arrow home-arrow" src="${pageContext.request.contextPath}/resources/image/icon/arrow.svg"
						data-original-src="${pageContext.request.contextPath}/resources/image/icon/arrow.svg"
						data-active-src="${pageContext.request.contextPath}/resources/image/icon/arrow-selected.svg"/>
				 </div>
				 <div class="sidebar-notice sidebar-title">
					<div>
						<img class="notice-icon sidebar-icon" src="${pageContext.request.contextPath}/resources/image/icon/notice.svg"
						data-original-src="${pageContext.request.contextPath}/resources/image/icon/notice.svg"
						data-active-src="${pageContext.request.contextPath}/resources/image/icon/notice-selected.svg"/>
						<a href="#">공지사항</a>
					</div>
					<img class="arrow notice-arrow" src="${pageContext.request.contextPath}/resources/image/icon/arrow.svg"
						data-original-src="${pageContext.request.contextPath}/resources/image/icon/arrow.svg"
						data-active-src="${pageContext.request.contextPath}/resources/image/icon/arrow-selected.svg"/>
				</div>
				<div class="sidebar-approval sidebar-title">
					<div>
						<img class="approval-icon sidebar-icon" src="${pageContext.request.contextPath}/resources/image/icon/approval.svg"
						data-original-src="${pageContext.request.contextPath}/resources/image/icon/approval.svg"
						data-active-src="${pageContext.request.contextPath}/resources/image/icon/approval-selected.svg"/>
						<a href="#">전자결재</a>
					</div>
					<img class="arrow approval-arrow" src="${pageContext.request.contextPath}/resources/image/icon/arrow.svg"
						data-original-src="${pageContext.request.contextPath}/resources/image/icon/arrow.svg"
						data-active-src="${pageContext.request.contextPath}/resources/image/icon/arrow-selected.svg"/>
				</div>
				<div class="sidebar-subtitle-box">
					<div class="sidebar-subtitle"><a href="#">기안서 작성</a></div>
					<div class="sidebar-subtitle" data-subtitle="apr-subtitle"><a href="#">결재 하기</a></div>
					<div class="sidebar-subtitle"><a href="#">결재 전단계</a></div>
					<div class="sidebar-subtitle" data-subtitle="preresult-recall-subtitle"><a href="#">기결/회수</a></div>
					<div class="sidebar-subtitle" data-subtitle="apr-rejection-subtitle"><a href="#">승인/반려</a></div>
					<div class="sidebar-subtitle" data-subtitle="doc-subtitle"><a href="#">문서함</a></div>
					<div class="sidebar-subtitle"><a href="#">설정</a></div>
				</div>

				<div class="sidebar-hr sidebar-title">
					<div>
						<img class="hr-icon sidebar-icon" src="${pageContext.request.contextPath}/resources/image/icon/hr.svg"
						data-original-src="${pageContext.request.contextPath}/resources/image/icon/hr.svg"
						data-active-src="${pageContext.request.contextPath}/resources/image/icon/hr-selected.svg"/> 
						<a href="#">HR</a>
					</div>
					<img class="arrow hr-arrow" src="${pageContext.request.contextPath}/resources/image/icon/arrow.svg"
						data-original-src="${pageContext.request.contextPath}/resources/image/icon/arrow.svg"
						data-active-src="${pageContext.request.contextPath}/resources/image/icon/arrow-selected.svg"/>
				</div>
				<div class="sidebar-subtitle-box">
					<div class="sidebar-subtitle" data-subtitle="attendance-subtitle"><a href="#">근태</a></div>
					<div class="sidebar-subtitle" data-subtitle="holiday-subtitle"><a href="#">휴가</a></div>
					<div class="sidebar-subtitle" data-subtitle="dept-att-subtitle"><a href="#">부서</a></div>
				</div>

			</div>
		</div>
		<div class="content-box">
			<div class="main-container" >
				<p class="title">${title}</p>
				<div class="attendance-subtitle subtitle">
					<div><a href="#">근태 현황</a></div>
					<div><a href="#">근무 시간</a></div>
					<div><a href="#">근태 처리</a></div>
				</div>
				<div class="holiday-subtitle subtitle">
					<div><a href="#">휴가 현황</a></div>
					<div><a href="#">휴가 신청</a></div>
					<div><a href="#">휴가 처리</a></div>
				</div>
				<div class="dept-att-subtitle subtitle">
					<div><a href="#">부서 근태</a></div>
					<div><a href="#">부서 일정</a></div>
				</div>
				<div class="apr-subtitle subtitle">
					<div><a href="#">결재 대기</a></div>
					<div><a href="#">전체 결재 목록</a></div>
				</div>
				<div class="preresult-recall-subtitle subtitle">
					<div><a href="#">결재 상신</a></div>
					<div><a href="#">회수 문서</a></div>
				</div>
				<div class="apr-rejection-subtitle subtitle">
					<div><a href="#">승인 문서</a></div>
					<div><a href="#">반려 문서</a></div>
				</div>
				<div class="doc-subtitle subtitle">
					<div><a href="#">부서결재함</a></div>
					<div><a href="#">완결 문서</a></div>
					<div><a href="#">참조 문서</a></div>
				</div>
				
				<div class="main-line"></div>

		
		
					