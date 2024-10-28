<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/joinForm.css" />
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<div class="emp-create-box card">
	<h2>회원 등록</h2>
	<form action="join" method="post" class="emp-create-form" name="formInfo">
		<div class="top-container">
			<div>
				<label for="empImg">사진</label>
				<img id="empImg" name="empImg" src="${pageContext.request.contextPath}/resources/image/profile_input.png"/>
			</div>
			<div>
				<label for="empName">이름</label>
				<input type="text" id="empName" name="empName" class="form-control" placeholder="이름을 입력해주세요" required>
				<div id="inputNameMessage" class="error-message"></div>
				<label for="empBirth">생년월일</label>
				<input type="date" id="empBirth" name="empBirth" class="form-control" placeholder="2024-10-22" required>
				<div id="inputBirthMessage" class="error-message"></div>
			</div>
		</div>
		<label for="empId">아이디</label>
		<div class="d-flex flex-row mb-1">
			<input type="text" id="empId" name="empId"  class="form-control"  placeholder="아이디를 입력해주세요." required/>
			<button class="id-check" type="button" disabled>중복확인</button>
		</div>
		<div id="inputIdMessage" class="error-message"></div>
		<label for="empEmail">이메일</label>
		<input type="email" id="empEmail" name="empEmail"  class="form-control mb-1" placeholder="이메일을 입력해주세요." required/>
		<div id="inputEmailMessage" class="error-message"></div>
		<label for="empTel">전화번호</label>
		<input type="tel" id="empTel" name="empTel"  class="form-control mb-1" placeholder="전화번호를 입력해주세요." required/>
		<div id="inputTelMessage" class="error-message"></div>
		<label for="empPostal">주소</label>
		<div class="d-flex flex-row mb-2">
			<input type="text" id="empPostal" name="empPostal" class="form-control" placeholder="우편번호를 입력해주세요." required readonly/>
			<button class="search-address" id="btnZipcode" type="button">주소찾기</button>
		</div>
		<input type="text" id="empAddress" name="empAddress" class="form-control mb-2" placeholder="주소를 입력해주세요." required readonly/>
		<input type="text" id="empDetailAddress" name="empDetailAddress" class="form-control mb-3" placeholder="상세주소를 입력해주세요." required/>
		<div class="d-flex flex-row">
			<div class="d-flex flex-column">
				<label for="empGender">성별</label>
				<select class="form-select" id="empGender" name="empGender" required>
				    <option selected>선택</option>
				    <option value="1">남자</option>
				    <option value="2">여자</option>
		  		</select>
			</div>
			<div class="d-flex flex-column">
				<label for="deptId">부서</label>
				<select class="form-select" id="deptId" name="deptId" required>
				    <option selected>선택</option>
				    <option value="1">공공사업1DIV</option>
				    <option value="2">공공사업2DIV</option>
				    <option value="3">공공사업3DIV</option>
		  		</select>
			</div>
			<div class="d-flex flex-column mb-4">
				<label for="position">직급</label>
				<select class="form-select" id="position" name="position" required>
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
		<button type="submit" class="button-x-large" id="submit-btn">회원 등록</button>
	</form>
</div>


<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/admin/joinForm.js"></script>
		
<%@ include file="/WEB-INF/views/common/footer.jsp"%>