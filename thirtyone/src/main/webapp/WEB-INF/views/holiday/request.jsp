<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/holiday/request.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">

<div class="holiday-request-box card">
	<p class="mini-title">휴가 신청</p>
	<div class="mini-line"></div>
	<form method="post" class="holiday-request">
		<div class="holiday-select1">
			<label for="holiday-type">휴가유형</label>
			<select class="form-select" id="holiday-type" name="holiday-type">
				<option selected>휴가 유형을 선택해 주세요.</option>
				<option value="1">연차(5일)</option>
				<option value="2">대체휴가(2일)</option>
				<option value="3">기타</option>
			</select>
		</div>
		<div class="holiday-select2">
			<div></div>
			<select class="form-select" id="holiday-duration" name="holiday-type">
				<option selected>선택</option>
				<option value="1">종일</option>
				<option value="2">반차</option>
				<option value="3">반반차</option>
			</select>
			<label for='half-holiday'>반차</label>
			<select class="form-select" id="holiday-period" name="holiday-period">
				<option selected>선택</option>
				<option value="1">AM</option>
				<option value="2">PM</option>
			</select>
			<label for='half-holiday'>반반차</label>
			<select class="form-select" id="holiday-time" name="holiday-time">
				<option selected>선택</option>
				<option value="1">09</option>
				<option value="2">10</option>
				<option value="3">11</option>
				<option value="4">12</option>
				<option value="5">13</option>
				<option value="6">14</option>
				<option value="7">15</option>
				<option value="8">16</option>
			</select>
		</div>
		<div class="mini-line"></div>
		<div class="holiday-select3">
			<p>휴가 일자 선택</p>
			<div id="choiceDay"></div>
		</div>
		<div class="mini-line"></div>
		<div class="holiday-select4">
			<p >사유</p>
			<textarea rows="6"></textarea>
		</div>
		<div class="holiday-button">
			<button class="button-large reject">반려</button>
			<button class="button-large accept">승인</button>
		</div>
	</form>
</div>

<script src="${pageContext.request.contextPath}/resources/js/holiday/request.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>