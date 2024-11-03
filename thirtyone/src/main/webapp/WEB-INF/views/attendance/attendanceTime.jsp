<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/attendance/attendanceTime.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<div class="content-box">
	<div class="main-container" >
		<p class="title-31">${title}</p>
		<div class="attendance-subtitle sub-title">
			<div ><a href="${pageContext.request.contextPath}/atd/">근태 현황</a></div>
			<div class="selected-sub-title"><a href="${pageContext.request.contextPath}/atd/time">근무 시간</a></div>
			<div><a href="${pageContext.request.contextPath}/atd/process">근태 처리</a></div>
		</div>
		<div class="main-line"></div>
		<p class="mini-title">월별 근태 현황</p>
		<div class="legend-and-period">
			<div id="choiceDay">
				<p></p>
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
		      <th scope="col">출근시간</th>
		      <th scope="col">퇴근시간</th>
		      <th scope="col">연장근무</th>
		      <th scope="col">인정근무</th>
		      <th scope="col">연장신청</th>
		      <th scope="col">사유서</th>
		    </tr>
		  </thead>
		  <tbody class="worktime-info">
		  </tbody>
		</table>


<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>

<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<script type="text/javascript">
	contextPath = '${pageContext.request.contextPath}';
</script>

<script src="${pageContext.request.contextPath}/resources/js/attendance/attendanceTime.js"></script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>