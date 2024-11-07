<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/holiday/request.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<div class="content-box">
	<div class="main-container" >
		<p class="title-31">${title}</p>
		<div class="holiday-subtitle sub-title">
			<div><a href="${pageContext.request.contextPath}/holiday/" >휴가 현황</a></div>
			<div  class="selected-sub-title"><a href="${pageContext.request.contextPath}/holiday/requestForm">휴가 신청</a></div>
			<div><a href="${pageContext.request.contextPath}/holiday/process">휴가 처리</a></div>
		</div>
		<div class="main-line"></div>
		<div class="holiday-request-box card">
			<!-- <p class="mini-title">휴가 신청</p>
			<div class="mini-line"></div> -->
			
			<form method="post" action="request" class="holiday-request" id="contentForm">
				<div class="holiday-select1">
					<label for="holiday-type">휴가유형</label>
					<select class="form-select" id="hdCategory" name="hdCategory">
						<option value="0">휴가 유형을 선택해 주세요.</option>
						<option value="1">연차(5일)</option>
						<option value="2">대체휴가(2일)</option>
						<option value="3">기타</option>
					</select>
				</div>
					
				<div class="holiday-select2">
					<div></div>
					<select class="form-select" id="holiday-duration" name="holidayType">
						<option value="0">선택</option>
						<option value="1">종일</option>
						<option value="2">반차</option>
						<option value="3">반반차</option>
					</select>
					<label for='half-holiday'>반차</label>
					<select class="form-select" id="holiday-period" name="holidayPeriod">
						<option value="0">선택</option>
						<option value="1">AM</option>
						<option value="2">PM</option>
					</select>
					<label for='half-holiday'>반반차</label>
					<select class="form-select" id="holiday-time" name="holidayTime">
						<option value="0">선택</option>
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
					<label for="holiday-type">승인권자</label>
					<select class="form-select" id="hdrApprover" name="hdrApprover">
						<option value="0">승인권자를 선택해 주세요.</option>
						<option value="1">부장</option>
						<option value="2">차장</option>
						<option value="3">과장</option>
						<option value="4">대리</option>
					</select>
				</div>
				
				<div class="mini-line"></div>
				
				<div class="holiday-select3">
					<p>휴가 일자 선택</p>
					<div id="choiceDay">
					<input type="hidden" name="hdrStartDate" id="hdrStartDate">
					<input type="hidden" name="hdrEndDate" id="hdrEndDate">
					</div>
				</div>
				<div class="mini-line"></div>
				<div class="holiday-select4">
					<p >사유</p>
					<textarea rows="6" id="hdrContent" name="hdrContent"></textarea>
				</div>
				<div class="holiday-button">
					<button class="button-large reject">반려</button>
					<input type="submit" class="button-large accept" value="승인">
				</div>
				
				<input type="hidden" name="hdrStatus">
			</form>
		</div>

<script src="${pageContext.request.contextPath}/resources/js/holiday/request.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>