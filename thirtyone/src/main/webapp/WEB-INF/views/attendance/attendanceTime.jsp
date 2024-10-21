<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/attendance/attendanceTime.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<div class="content-box">
	<div class="main-container" >
		<p class="title">${title}</p>
		<div class="attendance-subtitle subtitle">
			<div><a href="#">근태 현황</a></div>
			<div><a href="#">근무 시간</a></div>
			<div><a href="#">근태 처리</a></div>
		</div>
		<div class="main-line"></div>
		<p class="mini-title">월별 근태 현황</p>
		<div class="legend-and-period">
			<div id="choiceDay">
				<p>2024-10-14 ~ 2024-10-20</p>
				<img src="${pageContext.request.contextPath}/resources/image/calendar-icon.svg">
			</div>
			<img class='legend' src="${pageContext.request.contextPath}/resources/image/legend.png">
		
		</div>
		<canvas id="myChart" style="width: 100px; height: 40px;"></canvas>
		<table class="table worktime-list">
		  <thead>
		    <tr>
		      <th scope="col">날짜</th>
		      <th scope="col">출결</th>
		      <th scope="col">연장근무</th>
		      <th scope="col">인정근무</th>
		      <th scope="col">연장신청</th>
		      <th scope="col">사유서</th>
		      <th scope="col">상태</th>
		    </tr>
		  </thead>
		  <tbody>
		    <tr>
		      <th scope="row">10.14 월</th>
		      <td>정상 근무</td>
		      <td>-</td>
		      <td>8시간 00분</td>
		      <td><img src="${pageContext.request.contextPath}/resources/image/icon/clock.svg"></td>
		      <td><img src="${pageContext.request.contextPath}/resources/image/icon/doc.svg"></td>
		      <td><div class="btn accept-state" >승인</div></td>
		    </tr>
		    <tr>
		      <th scope="row">10.15 화</th>
		      <td>정상 근무</td>
		      <td>-</td>
		      <td>8시간 00분</td>
		      <td><img src="${pageContext.request.contextPath}/resources/image/icon/clock.svg"></td>
		      <td><img src="${pageContext.request.contextPath}/resources/image/icon/doc.svg"></td>
		      <td></td>
		    </tr>
		    <tr>
		      <th scope="row">10.16 수</th>
		      <td>정상 근무</td>
		      <td>-</td>
		      <td>8시간 00분</td>
		      <td><img src="${pageContext.request.contextPath}/resources/image/icon/clock.svg"></td>
		      <td><img src="${pageContext.request.contextPath}/resources/image/icon/doc.svg"></td>
		      <td><div class="btn wating-state" >대기</div></td>
		    </tr>
		    <tr>
		      <th scope="row">10.17 목</th>
		      <td>정상 근무</td>
		      <td>-</td>
		      <td>8시간 00분</td>
		      <td><img src="${pageContext.request.contextPath}/resources/image/icon/clock.svg"></td>
		      <td><img src="${pageContext.request.contextPath}/resources/image/icon/doc.svg"></td>
		      <td><div class="btn accept-state" >승인</div></td>
		    </tr>
		    <tr>
		      <th scope="row">10.18 금</th>
		      <td>정상 근무</td>
		      <td>-</td>
		      <td>8시간 00분</td>
		      <td><img src="${pageContext.request.contextPath}/resources/image/icon/clock.svg"></td>
		      <td><img src="${pageContext.request.contextPath}/resources/image/icon/doc.svg"></td>
		      <td><div class="btn accept-state" >승인</div></td>
		    </tr>
		    <tr>
		      <th scope="row">10.19 토</th>
		      <td>정상 근무</td>
		      <td>-</td>
		      <td>8시간 00분</td>
		      <td><img src="${pageContext.request.contextPath}/resources/image/icon/clock.svg"></td>
		      <td><img src="${pageContext.request.contextPath}/resources/image/icon/doc-selected.svg"></td>
		      <td><div class="btn accept-state" >승인</div></td>
		    </tr>
		    <tr>
		      <th scope="row">10.20 일</th>
		      <td>정상 근무</td>
		      <td>-</td>
		      <td>8시간 00분</td>
		      <td><img src="${pageContext.request.contextPath}/resources/image/icon/clock-selected.svg"></td>
		      <td><img src="${pageContext.request.contextPath}/resources/image/icon/doc.svg"></td>
		      <td><div class="btn accept-state" >승인</div></td>
		    </tr>
		  </tbody>
		</table>


<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>

<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<script src="${pageContext.request.contextPath}/resources/js/attendance/attendanceTime.js"></script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>