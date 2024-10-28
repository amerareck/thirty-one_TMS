<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/employee/empPwUpdate.css" />
<div class="emp-create-box card">
	<h2>비밀번호 재설정 하기</h2>
	<p>새로운 비밀번호를 입력해주세요.</p>
	<div class="emp-create-form">

		<label for="curPw">현재 비밀번호</label>
		<input type="password" id="curPw" name="curPw" class="form-control mb-3" placeholder="현재 비밀번호를 입력해주세요."/>
		<div class="curpw-check input-pw"><span></span></div>
		<label for="updatePw">변경할 비밀번호</label>
		<input type="password" class="form-control " id="updatePw" name="updatePw" placeholder="변경할 비밀 번호를 입력해주세요."/>
		<div class="changed-pw input-pw"><span></span></div>
		<input type="password" class="form-control " id="updatePwCheck" name="updatePwCheck" placeholder="변경할 비밀번호를 다시 한번 입력해 주세요"/>
		<div class="pw-check input-pw"><span></span></div>
		
		<div class="bottom-container">
			<div class="button-box">
				<button class="button-large" type="reset">취소</button>
				<button class="button-large pwChangeBtn">저장</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	const contextPath = '${pageContext.request.contextPath}';
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/employee/empPwUpdate.js"></script>
		
<%@ include file="/WEB-INF/views/common/footer.jsp"%>