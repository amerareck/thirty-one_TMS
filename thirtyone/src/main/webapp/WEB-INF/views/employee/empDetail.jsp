<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/employee/empDetail.css" />
<div class="content-box">
	<div class="main-container" >
		<p class="title-31">${title}</p>
		<div class="emp-subtitle sub-title">
			<div><a href="#">기본정보</a></div>
		</div>
		<div class="main-line"></div>
		<form class="emp-update-form">
			<div class="top-container">
				<div class="left-container">
					<div>
						<img src="${pageContext.request.contextPath}/resources/image/sky-profile-img.png">	
					</div>
				</div>
				<div class="middle-container">
					<div>
						<label for="empNum">사원번호</label>
						<input type="text" value="2005" disabled>
					</div>
					<div>
						<label for="empEmail">이메일</label>
						<input type="email" id="empEmail" name="empEmail" value="2005@naver.com">
					</div>
					<div>
						<label for="empPosition">직급</label>
						<input type="text" id="empPosition" name="empPosition" value="사원" disabled>
					</div>
					<div>
						<label for="empNum">입사일</label>
						<input type="date" value="2024-10-20" disabled>
					</div>
					<div>
						<label for="empDept">부서</label>
						<input type="text" id="empPosition" name="empPosition" value="공공사업1DIV" disabled>

					</div>
					<div>
						<label for="empStatus">재직상태</label>
						<input type="text" id="empStatus" name="empStatus" value="재직" disabled>
					</div>
				</div>
				<div class="right-container">
					<div>
						<label for="empName">이름</label>
						<input type="text" id="empName" name="empName" value="정원석" disabled>
					</div>
					<div>
						<label for="empAddress">주소</label>
						<input type="text" id="empAddress" name="#empAddress" value="서울시 혜화로 헤화 101-1">
					</div>
					<div>
						<label for="empTel">전화번호</label>
						<input type="tel" id="empTel" name="empTel" value="010-1234-5678">
						
					</div>
					<div>
						<label for="empBirth">생년월일</label>
						<input type="date" value="1995-11-16" disabled>
					</div>
				</div>
			</div>
			<div class="bottom-container">
				<div class="button-box">
					<button class="button-large" type="reset">취소</button>
					<button class="button-large" type="submit">상세정보 저장</button>
				</div>
			</div>
		</form>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/employee/empDetail.js"></script>
		
<%@ include file="/WEB-INF/views/common/footer.jsp"%>