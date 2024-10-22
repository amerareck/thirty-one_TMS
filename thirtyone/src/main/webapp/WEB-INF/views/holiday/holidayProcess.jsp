<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/holiday/holidayProcess.css" />
<div class="content-box">
	<div class="main-container" >
		<p class="title-31">${title}</p>
		<div class="holiday-subtitle sub-title">
			<div><a href="#">휴가 현황</a></div>
			<div><a href="#">휴가 신청</a></div>
			<div><a href="#">휴가 처리</a></div>
		</div>
		<div class="main-line"></div>
		<div class="full-container">
			<div class="left-container ">
				<div class="holiday-accept card">
					<p class="mini-title">휴가 승인</p>
					<div class="mini-line"></div>
					<div class="accept-box">
						<p class="accept-label">신청자</p>
						<div class="profile-box">
							<img class="process-profile-img" src="${pageContext.request.contextPath}/resources/image/profileDefault.png">
					    	<div class="process-profile-info">
					    		<h4>오티아이 부장</h4>
					    		<p>공공사업1div</p>
					    	</div>
				    	</div>
						<div class="mini-mini-line"></div>
						<p class="accept-label holiday-type">연차</p>
						<p class="holiday-period">2024-10-16(수) ~ 2024-10-18(금)</p>
						<div class="holiday-time">3일</div>
						<p class="accept-label">사유</p>
						<div class="holiday-reason">여행을 위한 연차 사용</div>
						<div class="holiday-file">
							<p class="accept-label">파일</p>
							<a class="choiced-file">선택된 파일 없음</a>
						</div>
			    	</div>
					<div class='button-list'>
						<button class="button-large reject">반려</button>
						<button class="button-large accept">승인</button>
					</div>
				</div>
			</div>
			<div class="right-container ">
				<div class="holiday-list-box card">
					<p class="mini-title">휴가 신청 내역</p>
					<table class="table holiday-list-table">
						<tbody >
						  <tr>
						    <td scope="col">이름</td>
						    <td scope="col">기간</td>
						    <td scope="col">상태</td>
						    <td scope="col">휴가항목</td>
						  </tr>
						  <tr>
						    <td class="holiday-profile-box">
						    	<img class="holiday-profile-img" src="${pageContext.request.contextPath}/resources/image/profileDefault.png">
						    	<div class="holiday-profile-info">
						    		<h4>오티아이 부장</h4>
						    		<p>공공사업1div</p>
						    	</div>
						    </td>
						    <td>2024-10-16 ~ 2024-10-18</td>
						    <td>승인</td>
						    <td>연차</td>
						  </tr>
						  <tr>
						    <td class="holiday-profile-box">
						    	<img class="holiday-profile-img" src="${pageContext.request.contextPath}/resources/image/profileDefault.png">
						    	<div class="holiday-profile-info">
						    		<h4>오티아이 부장</h4>
						    		<p>공공사업1div</p>
						    	</div>
						    </td>
						    <td>2024-10-16 ~ 2024-10-18</td>
						    <td>승인</td>
						    <td>연차</td>
						  </tr>
						  <tr>
						    <td class="holiday-profile-box">
						    	<img class="holiday-profile-img" src="${pageContext.request.contextPath}/resources/image/profileDefault.png">
						    	<div class="holiday-profile-info">
						    		<h4>오티아이 부장</h4>
						    		<p>공공사업1div</p>
						    	</div>
						    </td>
						    <td>2024-10-16 ~ 2024-10-18</td>
						    <td>승인</td>
						    <td>연차</td>
						  </tr>
						  <tr>
						    <td class="holiday-profile-box">
						    	<img class="holiday-profile-img" src="${pageContext.request.contextPath}/resources/image/profileDefault.png">
						    	<div class="holiday-profile-info">
						    		<h4>오티아이 부장</h4>
						    		<p>공공사업1div</p>
						    	</div>
						    </td>
						    <td>2024-10-16 ~ 2024-10-18</td>
						    <td>승인</td>
						    <td>연차</td>
						  </tr>
					 	</tbody>
				  	</table>
				  	<nav class="mt-3 mb-3">
		                <ul class="pagination justify-content-center">
		                  <li class="page-item disabled">
		                    <a class="page-link text-dark" href="#" tabindex="-1" aria-disabled="true"><img class="arrow-left" src="${pageContext.request.contextPath}/resources/image/arrow/page-left-arrow.svg"></a>
		                  </li>
		                  <li class="page-item"><a class="page-link text-dark page-border-none ms-5" href="#">1</a></li>
		                  <li class="page-item"><a class="page-link text-dark page-border-none ms-1" href="#">2</a></li>
		                  <li class="page-item"><a class="page-link text-dark page-border-none ms-1" href="#">3</a></li>
		                  <li class="page-item"><a class="page-link text-dark page-border-none ms-1" href="#">4</a></li>
		                  <li class="page-item"><a class="page-link text-dark page-border-none ms-1 me-5" href="#">5</a></li>
		                  <li class="page-item">
		                    <a class="page-link text-dark" href="#"><img class="arrow-right" src="${pageContext.request.contextPath}/resources/image/arrow/page-right-arrow.svg"></a>
		                  </li>
		                </ul>
		            </nav>
				</div>
				<div class="holiday-dept-box card">
					<p class="mini-title">부서 휴가 일정</p>
					<div class="mini-line"></div>
					<div id="calendar" class="main-calendar"></div>
				</div>
			</div>
		</div>

<script src="${pageContext.request.contextPath}/resources/js/holiday/holidayProcess.js"></script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>