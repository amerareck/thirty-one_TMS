<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminCreate.css" />
<div class="emp-create-box card">
	<h2>회원 등록</h2>
	<form action="join" method="post" class="emp-create-form">
		<div class="top-container">
			<div>
				<label for="empImg">사진</label>
				<img id="empImg" name="empImg" src="${pageContext.request.contextPath}/resources/image/profile_input.png"/>
			</div>
			<div>
				<label for="empName">이름</label>
				<input type="text" id="empName" name="empName" class="form-control" placeholder="이름을 입력해주세요">
				<label for="empBirth">생년월일</label>
				<input type="date" id="empBirth" name="empBirth" class="form-control" placeholder="2024-10-22">
			</div>
		</div>
		<label for="empId">아이디</label>
		<div class="d-flex flex-row mb-3">
			<input type="text" id="empId" name="empId"  class="form-control"  placeholder="아이디를 입력해주세요."/>
			<button class="id-check">중복확인</button>
		</div>
		<label for="empTel">이메일</label>
		<input type="email" id="empTel" name="empTel"  class="form-control mb-3" placeholder="이메일을 입력해주세요."/>
		<label for="empEmail">전화번호</label>
		<input type="text" id="empEmail" name="empEmail"  class="form-control mb-3" placeholder="전화번호를 입력해주세요."/>
		<label for="empAddress">주소</label>
		<div class="d-flex flex-row mb-2">
			<input type="text" id="empPostal" name="empPostal" class="form-control" placeholder="우편번호를 입력해주세요."/>
			<button class="id-check">주소찾기</button>
		</div>
		<input type="text" id="empAddress" name="empAddress" class="form-control mb-2" placeholder="주소를 입력해주세요."/>
		<input type="text" id="empDetailAddress" name="empDetailAddress" class="form-control mb-3" placeholder="상세주소를 입력해주세요."/>
		<div class="d-flex flex-row">
			<div class="d-flex flex-column">
				<label for="empGender">성별</label>
				<select class="form-select" id="empGender" name="empGender">
				    <option selected>선택</option>
				    <option value="1">남자</option>
				    <option value="2">여자</option>
		  		</select>
			</div>
			<div class="d-flex flex-column">
				<label for="deptId">부서</label>
				<select class="form-select" id="deptId" name="deptId">
				    <option selected>선택</option>
				    <option value="1">공공사업1DIV</option>
				    <option value="2">공공사업2DIV</option>
				    <option value="3">공공사업3DIV</option>
		  		</select>
			</div>
			<div class="d-flex flex-column mb-4">
				<label for="position">직급</label>
				<select class="form-select" id="position" name="position">
				    <option selected>선택</option>
				    <option value="대표이사" >대표이사</option>
				    <option value="부장">부장</option>
				    <option value="차장">차장</option>
				    <option value="과장">과장</option>
				    <option value="대리">대리</option>
				    <option value="사원">사원</option>
		  		</select>
			</div>
		</div>
		<button type="submit" class="button-x-large">회원 등록</button>
	</form>
</div>


<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/admin/adminCreate.js"></script>
		
<%@ include file="/WEB-INF/views/common/footer.jsp"%>