<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700"
	rel="stylesheet">

<link
	href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/style.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/common/header.css" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<script
	src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.bundle.min.js"></script>
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>


<c:if test="${ApprovalRequest}">
	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/resources/css/approval/approvalLine.css" />
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/themes/default/style.min.css" />
	<link rel="stylesheet"
		href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
</c:if>

<title>ThirtyOne - 근태관리시스템</title>

</head>
<body>
	<div class="header">
		<img class="logo-image"
			src="${pageContext.request.contextPath}/resources/image/logo.png" onclick="location.href = '${pageContext.request.contextPath}/home'">
		<div class="profile-img-box">
			<img class="profile-img"
				src="${pageContext.request.contextPath}/resources/image/profileDefault.png">
			<div class="emp-name-box">
				<span class="emp-name">
				</span> 
				<span class="dept-name">	
				</span>
			</div>
			<img class="three-dots-vertical dropdown-toggle"
				data-bs-toggle="dropdown" aria-expanded="false"
				src="${pageContext.request.contextPath}/resources/image/three-dots-vertical.svg">
			<ul class="dropdown-menu">
				<li><a class="dropdown-item" href="${pageContext.request.contextPath}/emp/empDetail">개인정보 수정</a></li>
				<li><a class="dropdown-item" href="${pageContext.request.contextPath}/emp/empPwUpdate">비밀번호 변경</a></li>
				<li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">로그아웃</a></li>
			</ul>
		</div>
	</div>
	<sec:authorize access="hasRole('ROLE_ADMIN')">
		<div class="container-box">
			<div class="sidebar">
				<%-- ############################### 아코디언 #################################### --%>
				<div class="nav-bar">
					<div
						class="sidebar-home sidebar-title ${selectedTitle=='home'? 'selected' : ''}"
						onclick="location.href='${pageContext.request.contextPath}/admin'">
						<div>
							<img class="home-icon sidebar-icon"
								src="${pageContext.request.contextPath}${selectedTitle != 'home' ? '/resources/image/icon/home.svg' : '/resources/image/icon/home-selected.svg'}" 
								data-original-src="${pageContext.request.contextPath}/resources/image/icon/home.svg"
								data-active-src="${pageContext.request.contextPath}/resources/image/icon/home-selected.svg"/>
							<a href="#">홈</a>
						</div>
						<img class="arrow home-arrow"
							src="${pageContext.request.contextPath}${selectedTitle != 'home' ? '/resources/image/icon/arrow.svg' : '/resources/image/icon/arrow-selected.svg'}" 
							data-original-src="${pageContext.request.contextPath}/resources/image/icon/arrow.svg"
							data-active-src="${pageContext.request.contextPath}/resources/image/icon/arrow-selected.svg"/>

					</div>
					<div
						class="sidebar-notice sidebar-title ${selectedTitle=='notice'? 'selected' : ''}"
						onclick="location.href='${pageContext.request.contextPath}/notice/noticeList'">
						<div>
							<img class="notice-icon sidebar-icon"
								src="${pageContext.request.contextPath}${selectedTitle != 'notice' ? '/resources/image/icon/notice.svg' : '/resources/image/icon/notice-selected.svg'}"
								data-original-src="${pageContext.request.contextPath}/resources/image/icon/notice.svg"
								data-active-src="${pageContext.request.contextPath}/resources/image/icon/notice-selected.svg"/>
							<a href="#">공지사항</a>
						</div>
						<img class="arrow home-arrow"
							src="${pageContext.request.contextPath}${selectedTitle != 'notice' ? '/resources/image/icon/arrow.svg' : '/resources/image/icon/arrow-selected.svg'}" 
							data-original-src="${pageContext.request.contextPath}/resources/image/icon/arrow.svg"
							data-active-src="${pageContext.request.contextPath}/resources/image/icon/arrow-selected.svg"/>
					</div>
					<div
						class="sidebar-emp sidebar-title ${selectedTitle=='adminEmp'? 'selected' : ''}">
						<div>
							<img class="approval-icon sidebar-icon"
								src="${pageContext.request.contextPath}${selectedTitle != 'adminEmp' ? '/resources/image/icon/emp.svg' : '/resources/image/icon/emp-selected.svg'}"
								data-original-src="${pageContext.request.contextPath}/resources/image/icon/emp.svg"
								data-active-src="${pageContext.request.contextPath}/resources/image/icon/emp-selected.svg" />
							<a href="#">회원관리</a>
						</div>
						<img class="arrow home-arrow"
							src="${pageContext.request.contextPath}${selectedTitle != 'adminEmp' ? '/resources/image/icon/arrow.svg' : '/resources/image/icon/arrow-selected.svg'}" 
							data-original-src="${pageContext.request.contextPath}/resources/image/icon/arrow.svg"
							data-active-src="${pageContext.request.contextPath}/resources/image/icon/arrow-selected.svg"/>
					</div>
					<div
						class="sidebar-subtitle-box ${selectedTitle=='adminEmp'? 'selected-sub' : ''}">
						<div class="sidebar-subtitle ${selectedSub == 'adminCreate' ? 'sub-selected' : ''}" 
							onclick="location.href='${pageContext.request.contextPath}/admin/joinForm'">
							<a href="#">회원등록</a>
						</div>
						<div class="sidebar-subtitle ${selectedSub == 'searchList' ? 'sub-selected' : ''}"
							onclick="location.href='${pageContext.request.contextPath}/admin/searchList'">
							<a href="#">회원수정</a>
						</div>
						<div
							class="sidebar-subtitle ${selectedSub == 'atdList' ? 'sub-selected' : ''}"
							onclick="location.href='${pageContext.request.contextPath}/admin/atdList'">
							<a href="#">근태관리</a>
						</div>
					</div>

					<div
						class="sidebar-org sidebar-title ${selectedTitle=='org'? 'selected' : ''}">
						<div>
							<img class="hr-icon sidebar-icon"
								src="${pageContext.request.contextPath}${selectedTitle != 'org' ? '/resources/image/icon/dept.svg' : '/resources/image/icon/dept-selected.svg'}" 
								data-original-src="${pageContext.request.contextPath}/resources/image/icon/dept.svg"
								data-active-src="${pageContext.request.contextPath}/resources/image/icon/dept-selected.svg" />
							<a href="#">조직관리</a>
						</div>
						<img class="arrow home-arrow"
							src="${pageContext.request.contextPath}${selectedTitle != 'org' ? '/resources/image/icon/arrow.svg' : '/resources/image/icon/arrow-selected.svg'}"
							data-original-src="${pageContext.request.contextPath}/resources/image/icon/arrow.svg"
							data-active-src="${pageContext.request.contextPath}/resources/image/icon/arrow-selected.svg" />
					</div>
					<div
						class="sidebar-subtitle-box  ${selectedTitle=='org'? 'selected-sub' : ''}">
						<div
							class="sidebar-subtitle ${selectedSub == 'organization' ? 'sub-selected' : ''}"
							onclick="location.href='${pageContext.request.contextPath}/admin/org'">
							<!-- data-subtitle="attendance-subtitle" -->
							<a>조직도</a>
						</div>
					</div>

				</div>
			</div>
	</sec:authorize>
	<sec:authorize access="!hasRole('ROLE_ADMIN')">
		<div class="container-box">
			<div class="sidebar">
				<div class="sidebar-attendance">
					<p class="sidebar-today"></p>
					<h1 class="sidebar-today-time"></h1>
					<div class="sidebar-start-time">
						<span>출근시간</span> <span>08:43</span>
					</div>
					<div class="sidebar-end-time">
						<span>퇴근시간</span> <span>18:01</span>
					</div>
					<div class="sidebar-attendance-btn">
						<button class="button-small sidebar-start">출근하기</button>
						<button class="button-small sidebar-end">퇴근하기</button>
					</div>
					<div class="sidebar-line"></div>
				</div>
				<%-- ############################### 아코디언 #################################### --%>
				<div class="nav-bar">
					<div class="sidebar-home sidebar-title ${selectedTitle=='home'? 'selected' : ''}" onclick="location.href='${pageContext.request.contextPath}/home'">
						<div>
						    <img class="home-icon sidebar-icon" 
						        src="${pageContext.request.contextPath}${selectedTitle != 'home' ? '/resources/image/icon/home.svg' : '/resources/image/icon/home-selected.svg'}" 
        						data-original-src="${pageContext.request.contextPath}/resources/image/icon/home.svg"
								data-active-src="${pageContext.request.contextPath}/resources/image/icon/home-selected.svg"/>
						    <a href="${pageContext.request.contextPath}/">홈</a>
						</div>
						<img class="arrow home-arrow" 
						    src="${pageContext.request.contextPath}${selectedTitle != 'home' ? '/resources/image/icon/arrow.svg' : '/resources/image/icon/arrow-selected.svg'}"
						    data-original-src="${pageContext.request.contextPath}/resources/image/icon/arrow.svg"
							data-active-src="${pageContext.request.contextPath}/resources/image/icon/arrow-selected.svg" />
					 </div>
					 <div class="sidebar-notice sidebar-title ${selectedTitle=='notice'? 'selected' : ''}" onclick="location.href='${pageContext.request.contextPath}/notice/noticeList'">
						<div>
							<img class="notice-icon sidebar-icon" 
								src="${pageContext.request.contextPath}${selectedTitle != 'notice' ? '/resources/image/icon/notice.svg' : '/resources/image/icon/notice-selected.svg'}" 
								data-original-src="${pageContext.request.contextPath}/resources/image/icon/notice.svg"
								data-active-src="${pageContext.request.contextPath}/resources/image/icon/notice-selected.svg"/>
							<a href="#">공지사항</a>
						</div>
						<img class="arrow home-arrow" 
						    src="${pageContext.request.contextPath}${selectedTitle != 'notice' ? '/resources/image/icon/arrow.svg' : '/resources/image/icon/arrow-selected.svg'}" 
						    data-original-src="${pageContext.request.contextPath}/resources/image/icon/arrow.svg"
							data-active-src="${pageContext.request.contextPath}/resources/image/icon/arrow-selected.svg"/>
					</div>
					<div class="sidebar-approval sidebar-title ${selectedTitle=='approval'? 'selected' : ''}">
						<div>
							<img class="approval-icon sidebar-icon" 
								src="${pageContext.request.contextPath}${selectedTitle != 'approval' ? '/resources/image/icon/approval.svg' : '/resources/image/icon/approval-selected.svg'}"
								data-original-src="${pageContext.request.contextPath}/resources/image/icon/approval.svg"
								data-active-src="${pageContext.request.contextPath}/resources/image/icon/approval-selected.svg" />
							<a href="#">전자결재</a>
						</div>
						<img class="arrow home-arrow" 
						    src="${pageContext.request.contextPath}${selectedTitle != 'approval' ? '/resources/image/icon/arrow.svg' : '/resources/image/icon/arrow-selected.svg'}"
						    data-original-src="${pageContext.request.contextPath}/resources/image/icon/arrow.svg"
							data-active-src="${pageContext.request.contextPath}/resources/image/icon/arrow-selected.svg" />
					</div>
					<div class="sidebar-subtitle-box ${selectedTitle=='approval'? 'selected-sub' : ''}">
						<div class="sidebar-subtitle ${selectedSub == 'draft' ? 'sub-selected' : ''}"><a href="${pageContext.request.contextPath}/approval/draft">기안서 작성</a></div>
						<div class="sidebar-subtitle ${selectedSub == 'approveList' ? 'sub-selected' : ''}"><a href="${pageContext.request.contextPath}/approval/approveList">결재 하기</a></div>
						<div class="sidebar-subtitle ${selectedSub == 'before' ? 'sub-selected' : ''}"><a href="${pageContext.request.contextPath}/approval/before">결재 전단계</a></div>
						<div class="sidebar-subtitle ${selectedSub == 'submitted' ? 'sub-selected' : ''}"><a href="${pageContext.request.contextPath}/approval/submitted">기결/회수</a></div>
						<div class="sidebar-subtitle ${selectedSub == 'result' ? 'sub-selected' : ''}" ><a href="${pageContext.request.contextPath}/approval/result">승인/반려</a></div>
						<div class="sidebar-subtitle ${selectedSub == 'archive' ? 'sub-selected' : ''}" ><a href="${pageContext.request.contextPath}/approval/archive">문서함</a></div>
						<div class="sidebar-subtitle ${selectedSub == 'settings' ? 'sub-selected' : ''}"><a href="${pageContext.request.contextPath}/approval/settings">설정</a></div>
					</div>
	
					<div class="sidebar-hr sidebar-title ${selectedTitle=='hr'? 'selected' : ''}">
						<div>
							<img class="hr-icon sidebar-icon" 
								src="${pageContext.request.contextPath}${selectedTitle != 'hr' ? '/resources/image/icon/hr.svg' : '/resources/image/icon/hr-selected.svg'}"
								data-original-src="${pageContext.request.contextPath}/resources/image/icon/hr.svg"
								data-active-src="${pageContext.request.contextPath}/resources/image/icon/hr-selected.svg" />
							<a href="#">HR</a>
						</div>
						<img class="arrow home-arrow" 
						    src="${pageContext.request.contextPath}${selectedTitle != 'hr' ? '/resources/image/icon/arrow.svg' : '/resources/image/icon/arrow-selected.svg'}"
						    data-original-src="${pageContext.request.contextPath}/resources/image/icon/arrow.svg"
							data-active-src="${pageContext.request.contextPath}/resources/image/icon/arrow-selected.svg" />
					</div>
					<div class="sidebar-subtitle-box  ${selectedTitle=='hr'? 'selected-sub' : ''}" >
						<div class="sidebar-subtitle ${selectedSub == 'attendance' ? 'sub-selected' : ''}" onclick="location.href='${pageContext.request.contextPath}/atd/'"><a>근태</a></div>
						<div class="sidebar-subtitle ${selectedSub == 'holiday' ? 'sub-selected' : ''}"  onclick="location.href='${pageContext.request.contextPath}/holiday/'" ><a>휴가</a></div>
						<div class="sidebar-subtitle ${selectedSub == 'deptAtd' ? 'sub-selected' : ''}"  onclick="location.href='${pageContext.request.contextPath}/dept/'" ><a>부서</a></div>
					</div>
				</div>
			</div>
		
	
	</sec:authorize>
	<script type="text/javascript">
		contextPath = '${pageContext.request.contextPath}';
	</script>
	
	