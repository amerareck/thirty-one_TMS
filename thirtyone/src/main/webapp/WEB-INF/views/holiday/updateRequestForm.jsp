<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/holiday/request.css" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<div class="content-box">
	<div class="main-container">
		<p class="title-31">${title}</p>
		<div class="holiday-subtitle sub-title">
			<div>
				<a href="${pageContext.request.contextPath}/holiday/">휴가 현황</a>
			</div>
			<div class="selected-sub-title">
				<a href="${pageContext.request.contextPath}/holiday/requestForm">휴가
					신청</a>
			</div>
			<div>
				<a href="${pageContext.request.contextPath}/holiday/process">휴가
					처리</a>
			</div>
		</div>
		<div class="main-line"></div>
		<div class="holiday-request-box card">
			<!-- <p class="mini-title">휴가 신청</p>
			<div class="mini-line"></div> -->

			<form method="post" action="updateRequestForm"
				class="holiday-request" id="contentForm">
				<div class="holiday-select3">
					<p>휴가 일자 선택</p>
					<div id="choiceDay">
						<input type="hidden" name="hdrStartDate" id="hdrStartDate" value="${holidayRequest[0].hdrStartDate}">
						<input type="hidden" name="hdrEndDate" id="hdrEndDate" value="${holidayRequest[0].hdrEndDate}"> 
						<input type="hidden" name="hdrUsedDay" id="hdrUsedDay" value="${holidayRequest[0].hdrUsedDay}">
					</div>
				</div>


				<div class="holiday-select1">
					<label for="holiday-type">휴가유형</label> <select class="form-select"
						id="hdCategory" name="hdCategory">
						<option value="0">휴가 유형을 선택해 주세요.</option>
						<c:forEach var="holiday" items="${holiday}">
							<option value="${holiday.hdCategory}" 
								${holiday.hdCategory == holidayRequest[0].hdCategory ? 'selected' : ''}>
								${holiday.hdName}(${holiday.hdCount - holiday.hdUsed}일)
							</option>
						</c:forEach>
					</select>
				</div>

				<div class="holiday-select2">
					<div></div>
					<%-- <select class="form-select" id="holiday-duration"
						name="holidayType">
						<option value="0">선택</option>
						<option value="1"
						<c:if test="${holidayRequest.holidayType == 1}">selected</c:if>>
						종일						
						</option>
						<option value="2"
						<c:if test="${holidayRequest.holidayType == 2}">selected</c:if>>
						반차</option>
						<option value="3"
						<c:if test="${holidayRequest.holidayType == 3}">selected</c:if>>
						반반차</option>
					</select> --%> 
					<%-- <select class="form-select" id="holiday-duration" name="holidayType">
					    <option value="0">선택</option>
					    <option value="1" ${holidayRequest[0].holidayType == 1 ? 'selected' : ''}>종일</option>
					    <option value="2" ${holidayRequest[0].holidayType == 2 ? 'selected' : ''}>반차</option>
					    <option value="3" ${holidayRequest[0].holidayType == 3 ? 'selected' : ''}>반반차</option>
					</select>
					
					
					<select class="form-select" id="holiday-period" name="holidayPeriod">
					    <option value="0">선택</option>
					    <option value="1" ${holidayRequest[0].holidayPeriod == 1 ? 'selected' : ''}>AM</option>
					    <option value="2" ${holidayRequest[0].holidayPeriod == 2 ? 'selected' : ''}>PM</option>
					</select>
					
					<!-- 반반차 시간 (오전/오후) -->
					<select class="form-select" id="holiday-time" name="holidayTime">
					    <option value="0">선택</option>
					    <option value="1" ${holidayRequest[0].holidayTime == 1 ? 'selected' : ''}>09:00 - 11:00</option>
					    <option value="2" ${holidayRequest[0].holidayTime == 2 ? 'selected' : ''}>11:00 - 13:00</option>
					    <option value="3" ${holidayRequest[0].holidayTime == 3 ? 'selected' : ''}>13:00 - 15:00</option>
					    <option value="4" ${holidayRequest[0].holidayTime == 4 ? 'selected' : ''}>15:00 - 17:00</option>
					</select> --%>
					
					
						<%-- <label for='half-holiday'>반차</label> <select class="form-select"
						id="holiday-period" name="holidayPeriod">
						<option value="0">선택</option>
						<option value="1"
						<c:if test="${holidayRequest.holidayPeriod == 1}">selected</c:if>>
						AM</option>
						<option value="2"
						<c:if test="${holidayRequest.holidayPeriod == 2}">selected</c:if>>
						PM</option>
					</select> <label for='half-holiday'>반반차</label> <select class="form-select"
						id="holiday-time" name="holidayTime">
						<option value="0">선택</option>
						<option value="1"
						<c:if test="${holidayRequest.holidayTime == 1}">selected</c:if>>
						09:00 - 11:00</option>
						<option value="2"
						<c:if test="${holidayRequest.holidayTime == 2}">selected</c:if>>
						11:00 - 13:00</option>
						<option value="3"
						<c:if test="${holidayRequest.holidayTime == 3}">selected</c:if>>
						13:00 - 15:00</option>
						<option value="4"
						<c:if test="${holidayRequest.holidayTime == 4}">selected</c:if>>
						15:00 - 17:00</option>
					</select> --%>
					
					
					<!-- 휴가 유형 -->
					<select class="form-select" id="holiday-duration" name="holidayType">
					    <option value="0">선택</option>
					    <option value="1" ${holidayRequest[0].holidayType == 1 ? 'selected' : ''}>종일</option>
					    <option value="2" ${holidayRequest[0].holidayType == 2 ? 'selected' : ''}>반차</option>
					    <option value="3" ${holidayRequest[0].holidayType == 3 ? 'selected' : ''}>반반차</option>
					</select>
					
					<!-- 반차 기간 (AM/PM) -->
					<select class="form-select" id="holiday-period" name="holidayPeriod">
					    <option value="0">선택</option>
					    <option value="1" ${holidayRequest[0].holidayPeriod == 1 ? 'selected' : ''}>AM</option>
					    <option value="2" ${holidayRequest[0].holidayPeriod == 2 ? 'selected' : ''}>PM</option>
					</select>
					
					<!-- 반반차 시간 (오전/오후) -->
					<select class="form-select" id="holiday-time" name="holidayTime">
						<option>${holidayRequest[0].holidayTime}</option>
					    <option value="0">선택</option>
					    <option value="1" ${holidayRequest[0].holidayTime == 1 ? 'selected' : ''}>09:00 - 11:00</option>
					    <option value="2" ${holidayRequest[0].holidayTime == 2 ? 'selected' : ''}>11:00 - 13:00</option>
					    <option value="3" ${holidayRequest[0].holidayTime == 3 ? 'selected' : ''}>13:00 - 15:00</option>
					    <option value="4" ${holidayRequest[0].holidayTime == 4 ? 'selected' : ''}>15:00 - 17:00</option>
					</select>
					
					
					
				</div>
				<div class="mini-line"></div>

				<div class="holiday-select3">
                    <label for="holiday-type">승인권자</label>
                    <input value="${deptName}" id="deptId" name="deptId" disabled>
                    <select class="form-select" id="position" name="position" required>
                        <option value="0" selected>직급을 선택해 주세요.</option>
						    <%-- <option value="1"
						    <c:if test="${position.position == 1}">selected</c:if>>
						    부장</option>
						    <option value="2"
						    <c:if test="${position.position == 2}">selected</c:if>>
						    차장</option>
						    <option value="3"
						    <c:if test="${position.position == 3}">selected</c:if>>
						    과장</option> --%>
						    <c:forEach items="${position}" var="pos">
						    	<option value="${pos.position}"
						    		<c:if test="${pos.position == selectedPosition}">selected</c:if>>
						    		${pos.position}</option>
				    		</c:forEach>
                    </select>
                    
                    <select class="form-select" id="hdrApprover" name="hdrApprover" required>
                        <option value="0" selected>승인권자를 선택해 주세요.</option>
                        <c:forEach items="${employees}" var="employees">
                            <option value="${employees.empId}" 
                                ${employees.empId == holidayRequest[0].hdrApprover ? 'selected' : ''}>
                                ${employees.empName}</option>
                        </c:forEach>
                    </select>
                </div>

				<div class="mini-line"></div>


				<div class="mini-line"></div>
				<div class="holiday-select4">
					<p>사유</p>
					<textarea rows="6" id="hdrContent" name="hdrContent">${holidayRequest[0].hdrContent}</textarea>

				</div>
				<div class="holiday-button">
					<button type="button" class="button-large reject"
						onclick="location.href='${pageContext.request.contextPath}/holiday/'">취소</button>
					<input type="submit" class="button-large accept" value="확인">
				</div>

				<input type="hidden" name="hdrStatus">
			</form>
		</div>

		<script
			src="${pageContext.request.contextPath}/resources/js/holiday/updateRequestForm.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

		<%@ include file="/WEB-INF/views/common/footer.jsp"%>