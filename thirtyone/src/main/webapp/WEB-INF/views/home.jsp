<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/home.css" />
	<div class="content-box">
		<p class="title">${title}</p>
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
				<div id="calendar" class="main-calendar"></div>
			</div>
		</div>
		
		<div class='bottom-container'>
			<div class="dept-attendance card">
				<div>
					<p class="mini-title">부서 근무 현황</p>
					<div class="search">
						<div class="main-search-drop">검색창</div>
						<div class="main-search-box">이름 검색</div>
					</div>
				</div>
				<div class="dept-attendance-cur">
					<table class="table dept-attendance-table">
						<thead class="header-dept">
						  <tr>
						    <th scope="col">이름</th>
						    <th scope="col">상태</th>
						    <th scope="col">메시지</th>
						  </tr>
						</thead>
						<tbody>
						  <tr>
						    <th scope="row" class="dept-profile-box">
						    	<img class="dept-profile-img" src="${pageContext.request.contextPath}/resources/image/profileDefault.png">
						    	<div class="dept-profile-info">
						    		<h4>오티아이 부장</h4>
						    		<p>공공사업1div</p>
						    	</div>
						    </th>
						    <td><div class="button-small dept-atd-state">미출근</div></td>
						    <td></td>
						  </tr>
						  <tr>
						    <th scope="row" class="dept-profile-box">
						    	<img class="dept-profile-img" src="${pageContext.request.contextPath}/resources/image/profileDefault.png">
						    	<div class="dept-profile-info">
						    		<h4>오티아이 부장</h4>
						    		<p>정원석 사원</p>
						    	</div>
					    	</th>
						    <td><div class="button-small dept-atd-state">미출근</div></td>
						    <td>@fat</td>
						  </tr>
						  <tr>
						    <th scope="row" class="dept-profile-box">
						    	<img class="dept-profile-img" src="${pageContext.request.contextPath}/resources/image/profileDefault.png">
						    	<div class="dept-profile-info">
						    		<h4>오티아이 부장</h4>
						    		<p>정원석 사원</p>
						    	</div>
					    	</th>
						    <td><div class="button-small dept-atd-state">미출근</div></td>
						    <td>@fat</td>
						  </tr>
						  <tr>
						    <th scope="row" class="dept-profile-box">
						    	<img class="dept-profile-img" src="${pageContext.request.contextPath}/resources/image/profileDefault.png">
						    	<div class="dept-profile-info">
						    		<h4>오티아이 부장</h4>
						    		<p>정원석 사원</p>
						    	</div>
					    	</th>
						    <td><div class="button-small dept-atd-state">미출근</div></td>
						    <td>@fat</td>
						  </tr>
						  <tr>
						    <th scope="row" class="dept-profile-box">
						    	<img class="dept-profile-img" src="${pageContext.request.contextPath}/resources/image/profileDefault.png">
						    	<div class="dept-profile-info">
						    		<h4>오티아이 부장</h4>
						    		<p>정원석 사원</p>
						    	</div>
					    	</th>
						    <td><div class="button-small dept-atd-state">미출근</div></td>
						    <td>@fat</td>
						  </tr>
						  <tr>
						    <th scope="row" class="dept-profile-box">
						    	<img class="dept-profile-img" src="${pageContext.request.contextPath}/resources/image/profileDefault.png">
						    	<div class="dept-profile-info">
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
			<div class="approval-list card">
				<p class="mini-title">결재 내역</p>
				<div class="apr-list-box">
					<p>기안<span>0</span></p>
					<p>결재<span>3</span></p>
					<p>승인<span>0</span></p>
					<p>반려<span>1</span></p>
				</div>
				<div>
					<table class="table approval-list-table">
						<thead>
							<tr>
							  <th scope="col">결재상태</th>
							  <th rowspan="3">제목</th>
							  <th rowspan="3">완결날짜</th>
							</tr>
						</thead>
						<tbody >
						  <tr>
						    <th scope="row"><img src="#"></th>
						    <td rowspan="3">[휴근][정원석][10/21] 휴일근무 신청</td>
						    <td rowspan="3">2024/10/09</td>
						  </tr>
						</tbody>
						<tbody >
						  <tr>
						    <th scope="row"><img src="#"></th>
						    <td rowspan="3">[휴근][정원석][10/21] 휴일근무 신청</td>
						    <td rowspan="3">2024/10/09</td>
						  </tr>
						</tbody>
						<tbody >
						  <tr>
						    <th scope="row"><img src="#"></th>
						    <td rowspan="3">[휴근][정원석][10/21] 휴일근무 신청</td>
						    <td rowspan="3">2024/10/09</td>
						  </tr>
						</tbody>
						<tbody >
						  <tr>
						    <th scope="row"><img src="#"></th>
						    <td rowspan="3">[휴근][정원석][10/21] 휴일근무 신청</td>
						    <td rowspan="3">2024/10/09</td>
						  </tr>
						</tbody>
						<tbody >
						  <tr>
						    <th scope="row"><img src="#"></th>
						    <td rowspan="3">[휴근][정원석][10/21] 휴일근무 신청</td>
						    <td rowspan="3">2024/10/09</td>
						  </tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>

	</div>
</div>



<script src="${pageContext.request.contextPath}/resources/js/home.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/common/header.js"></script>