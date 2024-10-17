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
				<div class="sidebar-hr"></div>
			</div>
			<%-- ############################### 아코디언 #################################### --%>
			<div class="nav-bar">
				<div class="sidebar-home">
					<div>
						<img class="home-icon" src="${pageContext.request.contextPath}/resources/image/home-icon.png"/>
						<span>홈</span>
					</div>
					<img class="arrow home-arrow" src="${pageContext.request.contextPath}/resources/image/arrow.png"/>
				 </div>
				 <div class="sidebar-notice">
					<div>
						<img class="notice-icon" src="${pageContext.request.contextPath}/resources/image/notice-icon.png"/>
						<span>공지사항</span>
					</div>
					<img class="arrow notice-arrow" src="${pageContext.request.contextPath}/resources/image/arrow.png"/>
				</div>
				<div class="sidebar-approval">
					<div>
						<img class="approval-icon" src="${pageContext.request.contextPath}/resources/image/approval-icon.png"/>
						<span>전자결재</span>
					</div>
					<img class="arrow approval-arrow" src="${pageContext.request.contextPath}/resources/image/arrow.png"/>
				</div>
				<div class="sidebar-hr">
					<div>
						<img class="hr-icon" src="${pageContext.request.contextPath}/resources/image/hr-icon.png"/> 
						<span>HR</span>
					</div>
					<img class="arrow hr-arrow" src="${pageContext.request.contextPath}/resources/image/arrow.png"/>
				</div>
			</div>
		</div>
		<div class="content-box" > 
		
		
					