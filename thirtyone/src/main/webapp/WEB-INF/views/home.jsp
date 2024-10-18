<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div class="top-container">
	<div class="today-attendance card">
		<p class="mini-title">나의 근무현황</p>
		<div class="mini-line"></div>
		<div class="atd-box-top">
			<div class="atd-time">
				<p class="mini-today">2024년10월17일</p>
				<h1 class="mini-today-time">19:02:40</h1>
			</div>
			<div class="atd-state">퇴근 완료 </div>
		</div>
		<div class="atd-box-middle"> 
			<button class="start-time-btn"> 
				<img src="${pageContext.request.contextPath}/resources/image/icon/check-icon.svg">
				<span>출근</span> <span>08:43</span> 
			</button>
			<button class="end-time-btn">
				<img src="${pageContext.request.contextPath}/resources/image/icon/check-icon.svg">
				<span>퇴근</span> <span>18:01</span>
			</button>
		</div>
		<div class="atd-box-bottom">
			<p>10시간</p>
			<div class="work-time-bar"></div>
			<div><span>0H</span><span>8H</span><span>12H</span><span>14H</span></div>
		</div>
	</div>
	
	<div class="my-holiday card">
		<p class="mini-title">나의 휴가 일정</p>
		<div class="mini-line"></div>
	</div>
</div>

<div class='bottom-container'>
	<div class="dept-attendance card">
		<p class="mini-title">부서 근무 현황</p>
		<div class="mini-line"></div>
	</div>
	<div class="approval-list card">
		<p class="mini-title">결재 내역</p>
		<div class="mini-line"></div>
	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>