<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/attendance/attendanceProcess.css" />
<script src="${pageContext.request.contextPath}/resources/js/attendance/attendanceProcess.js"></script>
    
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<div class="flex-container">
	<div class="process-list-box card">
		<p class="mini-title">처리 목록</p>
		<div class="mini-line"></div>
		<div>
			<table class="table process-list-table">
				<thead class="header-dept">
				  <tr>
				    <th scope="col">이름</th>
				    <th scope="col">상태</th>
				    <th scope="col">메시지</th>
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
				    <td><div class="button-small dept-atd-state">미출근</div></td>
				    <td></td>
				  </tr>
				  <tr>
				    <th scope="row" class="process-profile-box">
				    	<img class="process-profile-img" src="${pageContext.request.contextPath}/resources/image/profileDefault.png">
				    	<div class="process-profile-info">
				    		<h4>오티아이 부장</h4>
				    		<p>정원석 사원</p>
				    	</div>
			    	</th>
				    <td><div class="button-small dept-atd-state">미출근</div></td>
				    <td>@fat</td>
				  </tr>
				  <tr>
				    <th scope="row" class="process-profile-box">
				    	<img class="process-profile-img" src="${pageContext.request.contextPath}/resources/image/profileDefault.png">
				    	<div class="process-profile-info">
				    		<h4>오티아이 부장</h4>
				    		<p>정원석 사원</p>
				    	</div>
			    	</th>
				    <td><div class="button-small dept-atd-state">미출근</div></td>
				    <td>@fat</td>
				  </tr>
				  <tr>
				    <th scope="row" class="process-profile-box">
				    	<img class="process-profile-img" src="${pageContext.request.contextPath}/resources/image/profileDefault.png">
				    	<div class="process-profile-info">
				    		<h4>오티아이 부장</h4>
				    		<p>정원석 사원</p>
				    	</div>
			    	</th>
				    <td><div class="button-small dept-atd-state">미출근</div></td>
				    <td>@fat</td>
				  </tr>
				  <tr>
				    <th scope="row" class="process-profile-box">
				    	<img class="process-profile-img" src="${pageContext.request.contextPath}/resources/image/profileDefault.png">
				    	<div class="process-profile-info">
				    		<h4>오티아이 부장</h4>
				    		<p>정원석 사원</p>
				    	</div>
			    	</th>
				    <td><div class="button-small dept-atd-state">미출근</div></td>
				    <td>@fat</td>
				  </tr>
				  <tr>
				    <th scope="row" class="process-profile-box">
				    	<img class="process-profile-img" src="${pageContext.request.contextPath}/resources/image/profileDefault.png">
				    	<div class="process-profile-info">
				    		<h4>오티아이 부장</h4>
				    		<p>정원석 사원</p>
				    	</div>
			    	</th>
				    <td><div class="button-small dept-atd-state">미출근</div></td>
				    <td>@fat</td>
				  </tr>
				</tbody>
			</table>
		</div>
	</div>
	<div class="reason-report-box card">
		<p class="mini-title">사유서</p>
		<div class="mini-line"></div>
	</div>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>