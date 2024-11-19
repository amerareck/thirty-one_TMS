<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
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

			<form method="post" action="requestForm" class="holiday-request"
				id="contentForm">
				
			<div class="holidaySelects">	
				<div class="holiday-select3">
					<p>휴가 일자 선택</p>
					<div id="choiceDay">
						<input type="hidden" name="hdrStartDate" id="hdrStartDate">
						<input type="hidden" name="hdrEndDate" id="hdrEndDate"> <input
							type="hidden" name="hdrUsedDay" id="hdrUsedDay">
					</div>
				</div>
				
				<div class="holiday-select1">
					<label for="holiday-type">휴가유형</label> <select class="form-select"
						id="hdCategory" name="hdCategory">
						<option value="0">휴가 유형을 선택해 주세요.</option>
						<c:forEach var="holiday" items="${holiday}">
							<option value="${holiday.hdCategory}">${holiday.hdName}(${holiday.hdCount - holiday.hdUsed >= 0? holiday.hdCount - holiday.hdUsed : 0.0}일)</option>
						</c:forEach>
					</select>
				</div>
				
				<div class="holiday-select2">
					<div></div>
					<select class="form-select" id="holiday-duration"
						name="holidayType">
						<option value="0">선택</option>
						<option value="1">종일</option>
						<option value="2">반차</option>
						<option value="3">반반차</option>
					</select> 
			</div>		
				<div class="holiday-halfSelect">	
					<label for='half-holiday'>반차</label> <select class="form-select"
						id="holiday-period" name="holidayPeriod">
						<option value="0">선택</option>
						<option value="1">AM</option>
						<option value="2">PM</option>
					</select> <label for='half-holiday'>반반차</label> <select class="form-select"
						id="holiday-time" name="holidayTime">
						<option value="0">선택</option>
						<option value="1">09:00 - 11:00</option>
						<option value="2">11:00 - 13:00</option>
						<option value="3">13:00 - 15:00</option>
						<option value="4">15:00 - 17:00</option>
					</select>
				</div>	
				</div>
				
				<div class="holiday-select3">
					<label for="holiday-type">승인권자</label> <input value="${deptName}"
						id="deptId" name="deptId" disabled> <select
						class="form-select" id="position" name="position" required>
						<option value="0" selected>직급을 선택해 주세요.</option>
						<c:forEach items="${position}" var="position">
							<option value="${position.position}">${position.position}</option>
						</c:forEach>
					</select> <select class="form-select" id="hdrApprover" name="hdrApprover"
						required>
						<option value="0" selected>승인권자를 선택해 주세요.</option>
						<c:forEach items="${employees}" var="employees">
							<option value="${employees.empId}">${employees.empName}</option>
						</c:forEach>
					</select>
				</div>



			
				

				
				
				<!-- <div class="mini-line"></div>

				
</div>
				<div class="mini-line"></div> -->


				<div class="mini-line"></div>
				<div class="holiday-select4">
					<p>사유</p>
					<textarea rows="6" id="hdrContent" name="hdrContent"></textarea>
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
			src="${pageContext.request.contextPath}/resources/js/holiday/request.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

		<%@ include file="/WEB-INF/views/common/footer.jsp"%> --%>
		
		
		<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/holiday/request.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">

<div class="content-box">
    <div class="main-container">
        <p class="title-31">${title}</p>
        <div class="holiday-subtitle sub-title">
            <div>
                <a href="${pageContext.request.contextPath}/holiday/">휴가 현황</a>
            </div>
            <div class="selected-sub-title">
                <a href="${pageContext.request.contextPath}/holiday/requestForm">휴가 신청</a>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/holiday/process">휴가 처리</a>
            </div>
        </div>
        <div class="main-line"></div>
        <div class="holiday-request-box card">
            <form method="post" action="requestForm" class="holiday-request" id="contentForm">
                <div class="holiday-flex-container">
                    <!-- Left: Calendar Selection -->
                    <div class="holiday-calendar">
                        <p>휴가 일자 선택</p>
                        <div id="choiceDay">
                            <input type="hidden" name="hdrStartDate" id="hdrStartDate">
                            <input type="hidden" name="hdrEndDate" id="hdrEndDate">
                            <input type="hidden" name="hdrUsedDay" id="hdrUsedDay">
                        </div>
                    </div>

                    <!-- Right: Holiday Type Selection -->
                    <div class="holiday-details">
                    <div class="holiday-select-wrapper">
                        <!-- 휴가 유형 -->
                        <div class="holiday-select1">
                            <label for="holiday-type">휴가유형</label>
                            <select class="form-select" id="hdCategory" name="hdCategory">
                                <option value="0">휴가 유형을 선택해 주세요.</option>
                                <c:forEach var="holiday" items="${holiday}">
                                    <option value="${holiday.hdCategory}">${holiday.hdName}(${holiday.hdCount - holiday.hdUsed >= 0 ? holiday.hdCount - holiday.hdUsed : 0.0}일)</option>
                                </c:forEach>
                            </select>
                        </div>
                       

                        <!-- 휴가 기간(종일/반차/반반차) -->
                        <div class="holiday-select2">
                            <label for="holiday-duration">휴가 기간</label>
                            <select class="form-select" id="holiday-duration" name="holidayType">
                                <option value="0">선택</option>
                                <option value="1">종일</option>
                                <option value="2">반차</option>
                                <option value="3">반반차</option>
                            </select>
                        </div>

                        <!-- 반차/반반차 유형 선택 -->
                        <div class="holiday-halfSelect">
                            <label for="holiday-period">반차</label>
                            <select class="form-select" id="holiday-period" name="holidayPeriod">
                                <option value="0">선택</option>
                                <option value="1">AM</option>
                                <option value="2">PM</option>
                            </select>
                        </div>
                        
						<div class="holiday-halfHalfSelect">
                            <label for="holiday-time">반반차</label>
                            <select class="form-select" id="holiday-time" name="holidayTime">
                                <option value="0">선택</option>
                                <option value="1">09:00 - 11:00</option>
                                <option value="2">11:00 - 13:00</option>
                                <option value="3">13:00 - 15:00</option>
                                <option value="4">15:00 - 17:00</option>
                            </select>
                         </div>
					</div>
                        <!-- 승인권자 -->
                        <div class="holiday-select3">
                            <label for="hdrApprover">승인권자</label>
               		  </div>
	                  	<div class="positionEmp">
                            <input value="${deptName}" id="deptId" name="deptId" disabled>
                            
                            <select class="form-select" id="position" name="position" required>
                                <option value="0" selected>직급을 선택해 주세요.</option>
                                <c:forEach items="${position}" var="position">
                                    <option value="${position.position}">${position.position}</option>
                                </c:forEach>
                            </select>
                            <select class="form-select" id="hdrApprover" name="hdrApprover" required>
                                <option value="0" selected>승인권자를 선택해 주세요.</option>
                                <c:forEach items="${employees}" var="employees">
                                    <option value="${employees.empId}">${employees.empName}</option>
                                </c:forEach>
                            </select>
                           </div>  
                

                <!-- 사유 입력란 -->
                <div class="holiday-select4">
                    <p>사유</p>
                    <textarea rows="6" id="hdrContent" name="hdrContent"></textarea>
                </div>
                        </div>
    </div>

                <!-- 버튼 -->
                <div class="holiday-button">
                    <button type="button" class="button-large reject" onclick="location.href='${pageContext.request.contextPath}/holiday/'">취소</button>
                    <input type="submit" class="button-large accept" value="확인">
                </div>

                <input type="hidden" name="hdrStatus">
            </form>
        </div>
</div>
</div>

<script src="${pageContext.request.contextPath}/resources/js/holiday/request.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
		