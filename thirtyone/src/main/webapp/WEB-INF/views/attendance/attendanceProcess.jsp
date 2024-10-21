<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/attendance/attendanceProcess.css" />
<script src="${pageContext.request.contextPath}/resources/js/attendance/attendanceProcess.js"></script>
    
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
		<div class="flex-container">
			<div class="process-list-box card">
				<p class="mini-title">처리 목록</p>
				<div>
					<table class="table process-list-table">
						<thead class="header-dept">
						  <tr>
						    <th scope="col">이름</th>
						    <th scope="col">일자</th>
						    <th scope="col">상태</th>
						  </tr>
						</thead>
						<tbody>
						  <tr>
						    <th scope="row" class="process-profile-box">
						    	<img class="process-profile-img" src="${pageContext.request.contextPath}/resources/image/profileDefault.png">
						    	<div class="process-profile-info">
						    		<h4>오티아이 부장</h4>
						    		<p>공공사업1div</p>
						    	</div>
						    </th>
						    <td>2024-10-17</td>
						    <td>지각</td>
						  </tr>
						  <tr>
						    <th scope="row" class="process-profile-box">
						    	<img class="process-profile-img" src="${pageContext.request.contextPath}/resources/image/profileDefault.png">
						    	<div class="process-profile-info">
						    		<h4>오티아이 부장</h4>
						    		<p>정원석 사원</p>
						    	</div>
					    	</th>
						    <td>2024-10-17</td>
						    <td>지각</td>
						  </tr>
						  <tr>
						    <th scope="row" class="process-profile-box">
						    	<img class="process-profile-img" src="${pageContext.request.contextPath}/resources/image/profileDefault.png">
						    	<div class="process-profile-info">
						    		<h4>오티아이 부장</h4>
						    		<p>정원석 사원</p>
						    	</div>
					    	</th>
						    <td>2024-10-17</td>
						    <td>지각</td>
						  </tr>
						  <tr>
						    <th scope="row" class="process-profile-box">
						    	<img class="process-profile-img" src="${pageContext.request.contextPath}/resources/image/profileDefault.png">
						    	<div class="process-profile-info">
						    		<h4>오티아이 부장</h4>
						    		<p>정원석 사원</p>
						    	</div>
					    	</th>
						    <td>2024-10-17</td>
						    <td>지각</td>
						  </tr>
						  <tr>
						    <th scope="row" class="process-profile-box">
						    	<img class="process-profile-img" src="${pageContext.request.contextPath}/resources/image/profileDefault.png">
						    	<div class="process-profile-info">
						    		<h4>오티아이 부장</h4>
						    		<p>정원석 사원</p>
						    	</div>
					    	</th>
						    <td>2024-10-17</td>
						    <td>지각</td>
						  </tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="reason-report-box card">
				<p class="mini-title">사유서</p>
				<div class="mini-line"></div>
				<form class="reason-report" method="post">
					<div>
						<label for="empName">이름</label>
						<input type="text" class="form-control" id="empName" placeholder="이름을 입력해주세요." required>
					</div>
					<div>
						<label for="empDept">부서</label>
						<input type="text" class="form-control" id="empDept" placeholder="부서를 입력해주세요." required>
					</div>
					<div>
						<label for="empName">출근 시간</label>
						<input type="datetime" class="form-control" id="empName" placeholder="출근 시간을 입력해주세요." required>
					</div>
					<div>
					  <label for="formFile" class="form-label">첨부 파일</label>
					  <input class="form-control" type="file" id="formFile">
					</div>
					<div>
					  <label for="reason" class="form-label reason">지각 사유</label>
					  <textarea class="form-control" id="reason" rows="6"></textarea>
					</div>
					<div>
						<button class="button-large reject">반려</button>
						<button class="button-large accept">승인</button>
					</div>
				</form>
			</div>
		</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>