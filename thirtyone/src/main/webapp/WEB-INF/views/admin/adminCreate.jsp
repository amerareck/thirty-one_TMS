<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminCreate.css" />
<div class="emp-create-box card">
	<h2>회원 등록</h2>
	<form action="#" method="post" class="emp-create-form">
		<div class="top-container">
			<div>
				<label for="empImg">사진</label>
				<img id="emp-img" src="${pageContext.request.contextPath}/resources/image/profile_input.png"/>
			</div>
			<div>
				<label for="empName">이름</label>
				<input type="text" id="empName" name="empName" class="form-control" placeholder="이름을 입력해주세요">
				<label for="empName">생년월일</label>
				<input type="date" class="form-control" placeholder="2024-10-22">
			</div>
		</div>
		<label for="empId">아이디</label>
		<div class="d-flex flex-row mb-3">
			<input type="text" class="form-control" placeholder="아이디를 입력해주세요."/>
			<button class="id-check">중복확인</button>
		</div>
		<label for="empTel">전화번호</label>
		<input type="text" class="form-control mb-3" placeholder="전화번호를 입력해주세요."/>
		<label for="empAddress">주소</label>
		<div class="d-flex flex-row mb-2">
			<input type="text" class="form-control" placeholder="우편번호를 입력해주세요."/>
			<button class="id-check">주소찾기</button>
		</div>
		<input type="text" class="form-control mb-2" placeholder="주소를 입력해주세요."/>
		<input type="text" class="form-control mb-3" placeholder="상세주소를 입력해주세요."/>
		<div class="d-flex flex-row">
			<div class="d-flex flex-column">
				<label for="empGender">성별</label>
				<select class="form-select" id="empGender" name="empGender">
				    <option selected>선택</option>
				    <option>남자</option>
				    <option>여자</option>
		  		</select>
			</div>
			<div class="d-flex flex-column">
				<label for="empDept">부서</label>
				<select class="form-select" id="empDept" name="empDept">
				    <option selected>선택</option>
				    <option>공공사업1DIV</option>
				    <option>공공사업2DIV</option>
				    <option>공공사업3DIV</option>
		  		</select>
			</div>
			<div class="d-flex flex-column mb-4">
				<label for="empPosition">직급</label>
				<select class="form-select" id="empPosition" name="empPosition">
				    <option selected>선택</option>
				    <option>대표이사</option>
				    <option>부장</option>
				    <option>차장</option>
				    <option>과장</option>
				    <option>사원</option>
				    <option>대리</option>
		  		</select>
			</div>
		</div>
		<button type="submit" class="button-x-large">회원 등록</button>
	</form>
</div>


<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/admin/adminCreate.js"></script>
		
<%@ include file="/WEB-INF/views/common/footer.jsp"%>