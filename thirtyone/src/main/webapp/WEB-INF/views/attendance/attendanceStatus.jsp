<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/attendance/attendanceStatus.css" />

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<div class="content-box">
	<div class="main-container" >
		<p class="title-31">${title}</p>
		<div class="attendance-subtitle sub-title">
			<div class="selected-sub-title"><a href="${pageContext.request.contextPath}/atd">근태 현황</a></div>
			<div ><a href="${pageContext.request.contextPath}/atd/time">근무 시간</a></div>
			<div><a href="${pageContext.request.contextPath}/atd/process">근태 처리</a></div>
		</div>
		<div class="main-line"></div>
		<div class="temp-container">
			<div class="left-container">
				<div class="today-attendance card">
					<p class="mini-title">오늘의 근무</p>
					<div class="mini-line"></div>
					<div class="atd-box-top">
						<div class="atd-time">
							<p class="mini-today"></p>
							<h1 class="mini-today-time"></h1>
						</div>
						<c:if test="${atd.checkIn == null }">
							<div class="atd-state">출근 전 </div>
						</c:if>
						<c:if test="${atd.checkIn != null && atd.checkOut == null }">
							<div class="atd-state">근무 중 </div>
						</c:if>
						<c:if test="${atd.checkIn != null && atd.checkOut != null }">
							<div class="atd-state">퇴근 완료</div>
						</c:if>
					</div>
					<div class="atd-box-middle"> 
						<c:if test="${atd.checkIn == null}">
							<button class="start-time-btn "> 
								<span>출근</span> <span>--:--</span> 
							</button>
							<button class="end-time-btn ">
								<span>퇴근</span> <span>--:--</span>
							</button>
						</c:if>
						<c:if test="${atd.checkIn != null}">
							<button class="start-time-btn" disabled> 
								<span>출근</span> <span><fmt:formatDate value="${atd.checkIn}" pattern="HH:mm" /></span> 
							</button>
							<c:if test="${atd.checkOut == null }">
								<button class="end-time-btn ">
									<span>퇴근</span> <span>--:--</span>
								</button>
							</c:if>
							<c:if test="${atd.checkOut != null }">
								<button class="end-time-btn" disabled>
									<span>퇴근</span> <span><fmt:formatDate value="${atd.checkOut}" pattern="HH:mm" /></span>
								</button>
							</c:if>
						</c:if>
					</div>
					<div class="atd-box-bottom">
						<p>${workTime.hour}시간</p>
						<div class="work-time-bar" style="background-image: linear-gradient(to right, #1F5FFF 0%, #1F5FFF ${workTime.workpart}%, #BEFDB7 ${workTime.workpart+10}%, #BEFDB7 100% )"></div>
						<div><span>0H</span><span>7H</span><span>11H</span><span>14H</span></div>
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

<script type="text/javascript">
	contextPath = '${pageContext.request.contextPath}';
</script>
<script src="${pageContext.request.contextPath}/resources/js/attendance/attendanceStatus.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>