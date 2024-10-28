<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/empDetail.css" />
<div class="content-box">
	<div class="main-container" >
		<p class="title-31">${title}</p>
		<form class="emp-update-form" action="${pageContext.request.contextPath}/emp/updateEmp">
		<div class="emp-subtitle sub-title">
			<div><a href="#">기본정보</a></div>
		</div>
		<div class="main-line"></div>
			<div class="top-container">
				<input type="number" id="modifier" name="modifier" style="display: none;" value="2">
				<div class="left-container">
					<div>
						<p>사진</p>
						<label for="profileImg">
							<img src="${pageContext.request.contextPath}/resources/image/profile-img-update.png">
						</label>
						<input type="file" id="profileImg" name="profileImg" style="display:none;">
					</div>
				</div>
				<div class="middle-container">
					<div>
						<label for="empNum">사원번호</label>
						<input type="text" value="${empInfo.empNumber }" disabled>
					</div>
					<div>
						<label for="empEmail">이메일</label>
						<input type="email" value="${empInfo.empEmail }" disabled>
					</div>
					<div>
						<label for="empPosition">직급</label>
						<select class="form-select" id="empPosition" name="empPosition">
							<option selected>${empInfo.position }</option>
							<c:forEach items="${posList}" var="pos"> 
								<option>${pos.position }</option>
							</c:forEach>
						</select>
					</div>
					<div>
						<label for="empNum">입사일</label>
						<input type="date" value="<fmt:formatDate value='${empInfo.empHiredate}' pattern='yyyy-MM-dd'/>" disabled>
					</div>
					<div>
						<label for="empNum">퇴사일</label>
						<input type="text" value="${empInfo.empResignationDate == null ? 'N/A' : empInfo.empResignationDate}" disabled>
					</div>
					<div>
						<label for="empDept">부서</label>
						<select class="form-select" id="empDept" name="empDept">
							<option value="${empInfo.deptId}" selected> ${deptName }</option>
							<c:forEach items="${deptList}" var="dept"> 
								<option value="${dept.deptId}" >${dept.deptName}</option>
							</c:forEach>
						</select>
					</div>
					 
				</div>
				<div class="right-container">
					<div>
						<label for="empName">이름</label>
						<input type="text" id="empName" name="empName" value="${empInfo.empName }">
					</div>
					<div>
						<label for="empPostal">우편번호</label>
						<input type="text" id="empPostal" name="empPostal" value="${empInfo.empPostal}" disabled>
					</div>
					<div>
						<label for="empAddress">주소</label>
						<input type="text" id="empAddress" name="empAddress" value="${empInfo.empAddress }" disabled>
					</div>
					<div>
						<label for="empDetailAddress">상세 주소</label>
						<input type="text" id="empDetailAddress" name="empDetailAddress" value="${empInfo.empDetailAddress }" disabled>
					</div>
					<div>
						<label for="empTel">전화번호</label>
						<input type="tel" id="empTel" name="empTel"value="${empInfo.empTel }" disabled>
						
					</div>
					<div>
						<label for="empBirth">생년월일</label>
						<input type="date" value="<fmt:formatDate value='${empDept.empInfo.empBirth}' pattern='yyyy-MM-dd'/>" disabled>
					</div>
					<div>
						<label for="empStatus">재직상태</label>
						<select class="form-select" id="empStatus" name="empStatus">
							<option selected> ${empInfo.empState}</option>
							<c:forEach items="${stateList}" var="state"> 
								<option>${state}</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<div class="bottom-container">
				<label for="empMemo">메모</label>
				<textarea id="empMemo" name="empMemo" rows="6"></textarea>
				<div class="button-box">
					<button class="button-large" type="reset">취소</button>
					<button class="button-large" type="submit">직원 상세정보 저장</button>
				</div>
			</div>
		</form>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/admin/empDetail.js"></script>
		
<%@ include file="/WEB-INF/views/common/footer.jsp"%>