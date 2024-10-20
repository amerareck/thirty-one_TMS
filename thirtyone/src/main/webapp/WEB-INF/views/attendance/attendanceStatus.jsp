<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/attendance/attendanceStatus.css" />
<script src="${pageContext.request.contextPath}/resources/js/attendance/attendanceStatus.js"></script>



<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div class="temp-container">
	<div class="left-container">
		<div class="today-attendance card">
			<p class="mini-title">오늘의 근무</p>
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
					<span>출근</span> <span>08:43</span> 
				</button>
				<button class="end-time-btn">
					<span>퇴근</span> <span>18:01</span>
				</button>
			</div>
			<div class="atd-box-bottom">
				<p>10시간</p>
				<div class="work-time-bar"></div>
				<div><span>0H</span><span>8H</span><span>12H</span><span>14H</span></div>
			</div>
		</div>
		<div class="month-atd-status card">
			<p class="mini-title">나의 근태 현황</p>
			<div class="mini-line"></div>
			<div class="graph-box">
				<div>
					<canvas id="chart" style="height: 130px;"></canvas>	
				</div>
				<div>
			  		<canvas id="myChart" style="width: 200px; height: 250px;"></canvas>
			  	</div>
			</div>
		</div>
	</div>
	<div class="right-container">
		<div class="callneder card">
			<p class="mini-title">월별 근태 현황</p>
			<div class="mini-line"></div>
			<div id="calendar" class="main-calendar"></div>
		</div>
	</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>