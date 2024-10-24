<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link
		href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
		rel="stylesheet">
	<link
		href="https://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700"
		rel="stylesheet">
	<link rel="stylesheet"
		href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/resources/css/style.css" />	
	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/resources/css/employee/loginForm.css" />
	
	<script
		src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.bundle.min.js"></script>
		
	<title>ThirtyOne - 근태관리시스템</title>
	
</head>
<body>
	<div class="full-controller">
		<img class="login-logo" src="${pageContext.request.contextPath }/resources/image/login-logo.png">
		<div class="login-box">
			<h2>로그인</h2>
			<p>써리원의 근태관리센터에 오신것을 	환영합니다.</p>
			
			<form class="login-form">
			<div>
				<label for="empId">아이디</label>
				<input type="text" placeholder="아이디를 입력해주세요." required>
			</div>
			<div>
				<label for="empPassword">비밀번호</label>
				<input type="password" placeholder="비밀번호를 입력해주세요." required>
				<a href="#">비밀번호를 잊으셨나요?</a>
			</div>
				<button class="button-x-large">로그인</button>
			</form>
			
		</div>
	</div>
	
	
</body>
</html>