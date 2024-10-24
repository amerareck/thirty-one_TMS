<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/empDetail.css" />
<div class="content-box">
	<div class="main-container" >
		<p class="title-31">${title}</p>
		<form class="emp-update-form">
			<div class="top-container">
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
						<input type="text" value="2005" disabled>
					</div>
					<div>
						<label for="empEmail">이메일</label>
						<input type="email" value="2005@naver.com" disabled>
					</div>
					<div>
						<label for="empPosition">직급</label>
						<select class="form-select" id="empPosition" name="empPosition">
							<c:forEach begin="1" end="5"> <option>직급</option></c:forEach>
						</select>
					</div>
					<div>
						<label for="empNum">입사일</label>
						<input type="date" value="2024-10-20" disabled>
					</div>
					<div>
						<label for="empNum">퇴사일</label>
						<input type="text" value="N/A" disabled>
					</div>
					<div>
						<label for="empDept">부서</label>
						<select class="form-select" id="empDept" name="empDept">
							<c:forEach begin="1" end="5"> <option>공공사업1DIV</option></c:forEach>
						</select>
					</div>
					 
				</div>
				<div class="right-container">
					<div>
						<label for="empName">이름</label>
						<input type="text" id="empName" name="empName" value="정원석">
					</div>
					<div>
						<label for="empAddress">주소</label>
						<input type="text" value="서울시 혜화로 헤화 101-1" disabled>
					</div>
					<div>
						<label for="empTel">전화번호</label>
						<input type="tel" value="010-1234-5678" disabled>
						
					</div>
					<div>
						<label for="empBirth">생년월일</label>
						<input type="date" value="1995-11-16" disabled>
					</div>
					<div>
						<label for="empStatus">재직상태</label>
						<select class="form-select" id="empStatus" name="empStatus">
							<c:forEach begin="1" end="5"> <option>재직</option></c:forEach>
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