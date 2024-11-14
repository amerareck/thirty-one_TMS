<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/attendance/attendanceTime.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
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
		<canvas id="myChart" width="1200" height="400"></canvas>
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

<div class="modal fade" id="atdRequestModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
  			<div class="dept-move card">
				<p class="mini-title">사유서</p>
				<div class="mini-line"></div>
				<form class="reason-report">
					<div>
						<label for="empName">이름</label>
						<input type="text" class="form-control" id="empName" value="${emp.empName}" disabled>
					</div>
					<div>
						<label for="empDept">부서</label>
						<input type="text" class="form-control" id="empDept" value="${deptName }" disabled>
					</div>
					<div>
						<label for="checkIn">출근 시간</label>
						<input type="datetime" class="form-control" name="checkIn" id="checkIn" readonly>
					</div>
					<div>
						<label for="checkOut">퇴근 시간</label>
						<input type="datetime" class="form-control" id="checkOut" name="checkOut" disabled>
					</div>
					<div>
					  <label for="formFile" class="form-label">첨부 파일</label>
					  <input class="form-control" onchange="addFile(this);" type="file" id="formFile" name="formFile" multiple>
					</div>
					<div class="file-list"></div>
					<div>
					  <label for="reason" class="form-label reason">사유</label>
					  <textarea class="form-control" id="reason" name="reason" rows="6" placeholder="여기에 내용을 입력하세요"></textarea>
					</div>
					<div class="button-box">
						<button type="button" class="button-large reject" data-bs-dismiss="modal" aria-label="Close">취소</button>
						<button class="button-large accept" onclick="submitForm(event)">제출</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="atdUpdateModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
  			<div class="dept-move card">
				<p class="mini-title">사유서</p>
				<div class="mini-line"></div>
				<form class="update-reason-report">
					<div>
						<label for="empName">이름</label>
						<input type="text" class="form-control" id="empName" value="${emp.empName}" disabled>
					</div>
					<div>
						<label for="empDept">부서</label>
						<input type="text" class="form-control" id="empDept" value="${deptName }" disabled>
					</div>
					<div>
						<label for="checkIn">출근 시간</label>
						<input type="datetime" class="form-control" name="checkIn" id="update-checkIn" readonly>
					</div>
					<div>
						<label for="checkOut">퇴근 시간</label>
						<input type="datetime" class="form-control" name="checkOut" id="update-checkOut" disabled>
					</div>
					<div>
					  <label for="formFile" class="form-label">첨부 파일</label>
					  <input class="form-control" onchange="addFile(this);" type="file" id="formFile" name="formFile" multiple>
					</div>
					<div class="update-file-list"></div>
					<div>
					  <label for="reason" class="form-label reason">사유</label>
					  <textarea class="form-control" id="update-reason" name="reason" rows="6" placeholder="여기에 내용을 입력하세요"></textarea>
					</div>
					<div class="button-box">
						<button type="button" class="button-large reject" data-bs-dismiss="modal" aria-label="Close">취소</button>
						<button type="button"  class="button-large update-accept" onclick="updateForm(event)">제출</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>

<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<script type="text/javascript">
	contextPath = '${pageContext.request.contextPath}';
</script>

<script src="${pageContext.request.contextPath}/resources/js/attendance/attendanceTime.js"></script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>