<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/employee/empDetail.css" />
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<div class="content-box">
	<div class="main-container" >
		<p class="title-31">${title}</p>
		<div class="emp-subtitle sub-title">
			<div><a href="#">기본정보</a></div>
		</div>
		<div class="main-line"></div>
		<form method="post" action="updateEmp" class="emp-update-form" name="formInfo">
			<div class="top-container">
				<input type="number" name='modifier' id='modifier' value=1 style="display:none;">
				<div class="left-container">
					<div>
						<img src="${pageContext.request.contextPath}/resources/image/sky-profile-img.png">	
					</div>
				</div>
				<div class="middle-container">
					<div>
						<label for="empNum">사원번호</label>
						<input type="text" value="${empInfo.empNumber}" disabled>
					</div>
					<div>
						<label for="empEmail">이메일</label>
						<input type="email" id="empEmail" name="empEmail" value="${empInfo.empEmail}">
					</div>
					<div>
						<label for="empPosition">직급</label>
						<input type="text" id="empPosition" name="empPosition" value="${empInfo.position }" disabled>
					</div>
					<div>
						<label for="empNum">입사일</label>
						<input type="date" value="<fmt:formatDate value='${empInfo.empHiredate }' pattern='yyyy-MM-dd'/>" disabled>
					</div>
					<div>
						<label for="empDept">부서</label>
						<input type="text" id="empPosition" name="empPosition" value="${deptName}" disabled>

					</div>
					<div>
						<label for="empStatus">재직상태</label>
						<input type="text" id="empStatus" name="empStatus" value="${empInfo.empState }" disabled>
					</div>
				</div>
				<div class="right-container">
					<div>
						<label for="empName">이름</label>
						<input type="text" id="empName" name="empName" value="${empInfo.empName }" disabled>
					</div>
					<div class="emp-postal-box">
						<label for="empPostal">우편번호</label>
						<input type="text" id="empPostal" name="empPostal" value="${empInfo.empPostal }" readonly>
						
						<button class="search-address" id="btnZipcode" type="button">주소찾기</button>
					</div>
					<div>
						<label for="empAddress">주소</label>
						<input type="text" id="empAddress" name="empAddress" value="${empInfo.empAddress }" readonly>
					</div>
					<div>
						<label for="empDetailAddress">상세 주소</label>
						<input type="text" id="empDetailAddress" name="empDetailAddress" value="${empInfo.empDetailAddress }" >
					</div>
					<div>
						<label for="empTel">전화번호</label>
						<input type="tel" id="empTel" name="empTel" value="${empInfo.empTel}">
						
					</div>
					<div>
						<label for="empBirth">생년월일</label>
						<input type="date" value="<fmt:formatDate value='${empInfo.empBirth}' pattern='yyyy-MM-dd'/>" disabled>
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