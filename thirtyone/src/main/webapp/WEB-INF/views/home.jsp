<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/home.css" />
	<div class="content-box">
		<p class="title">${title}</p>
		<div class="full-container">
			<div class="left-container">
				<div class="today-attendance card">
					<p class="mini-title">나의 근무현황</p>
					<div class="mini-line"></div>
					<div class="atd-box-top">
						<div class="atd-time">
							<p class="mini-today"></p>
							<h1 class="mini-today-time"></h1>
						</div>
						<c:if test="${atd.checkIn == null }">
							<div class="atd-state">출근 전 </div>
						</c:if>
						<c:if test="${atd.checkIn != null && atd.checkOut == null }">
							<div class="atd-state">근무 중 </div>
						</c:if>
						<c:if test="${atd.checkIn != null && atd.checkOut != null }">
							<div class="atd-state">퇴근 완료</div>
						</c:if>
					</div>
					<div class="atd-box-middle"> 
						<c:if test="${atd.checkIn == null}">
							<button class="start-time-btn null-atd"> 
<%-- 								<img src="${pageContext.request.contextPath}/resources/image/icon/check-icon.svg"> --%>
								<span>출근</span> <span>--:--</span> 
							</button>
							<button class="end-time-btn null-atd">
<%-- 								<img src="${pageContext.request.contextPath}/resources/image/icon/check-icon.svg"> --%>
								<span>퇴근</span> <span>--:--</span>
							</button>
						</c:if>
						<c:if test="${atd.checkIn != null}">
							<button class="start-time-btn" disabled> 
								<img src="${pageContext.request.contextPath}/resources/image/icon/check-icon.svg">
								<span>출근</span> <span><fmt:formatDate value="${atd.checkIn}" pattern="HH:mm" /></span> 
							</button>
							<c:if test="${atd.checkOut == null }">
								<button class="end-time-btn null-atd">
	<%-- 								<img src="${pageContext.request.contextPath}/resources/image/icon/check-icon.svg"> --%>
									<span>퇴근</span> <span>--:--</span>
								</button>
							</c:if>
							<c:if test="${atd.checkOut != null }">
								<button class="end-time-btn" disabled>
									<img src="${pageContext.request.contextPath}/resources/image/icon/check-icon.svg">
									<span>퇴근</span> <span><fmt:formatDate value="${atd.checkOut}" pattern="HH:mm" /></span>
								</button>
							</c:if>
						</c:if>
					</div>
					<div class="atd-box-bottom">
						<p>${workTime.hour}시간</p>
						<div class="work-time-bar" style="background-image: linear-gradient(to right, #1F5FFF 0%, #1F5FFF ${workTime.workpart}%, #BEFDB7 ${workTime.workpart+10}%, #BEFDB7 100% )"></div>
						<div><span>0H</span><span>7H</span><span>11H</span><span>14H</span></div>
					</div>
				</div>
				<div class="approval-list card">
					<p class="mini-title">기안서 결재 현황</p>
					<div class="apr-list-box">
						<p>대기<span>${readyCount}</span></p>
						<p>진행<span>${processCount}</span></p>
						<p>승인<span>${approveCount}</span></p>
						<p>반려<span>${rejectCount}</span></p>
					</div>
					<%-- <div>
						<table class="table approval-list-table">
							<thead>
								<tr>
								  <th scope="col">결재상태</th>
								  <th rowspan="3">제목</th>
								  <th rowspan="3">상신날짜</th>
								  <th rowspan="3">완결날짜</th>
								</tr>
							</thead>
							<tbody >
						  		<c:forEach begin="1" end="7">
								  <tr>
								    <th scope="row"><div class="button-mini button-mini-accept">승인</div></th>
								    <td rowspan="3">[휴근][정원석][10/21] 휴일근무 신청</td>
								    <td rowspan="3">2024/10/09</td>
								    <td rowspan="3">2024/10/09</td>
								  </tr>
							  	</c:forEach>
							</tbody>
						</table>
					</div>
					<nav class="mt-5 mb-3">
		                <ul class="pagination justify-content-center">
		                  <li class="page-item disabled">
		                    <a class="page-link text-dark" href="#" tabindex="-1" aria-disabled="true"><img class="arrow-left" src="${pageContext.request.contextPath}/resources/image/arrow/page-left-arrow.svg"></a>
		                  </li>
		                  <li class="page-item"><a class="page-link text-dark page-border-none ms-5" href="#">1</a></li>
		                  <li class="page-item"><a class="page-link text-dark page-border-none ms-1" href="#">2</a></li>
		                  <li class="page-item"><a class="page-link text-dark page-border-none ms-1" href="#">3</a></li>
		                  <li class="page-item"><a class="page-link text-dark page-border-none ms-1" href="#">4</a></li>
		                  <li class="page-item"><a class="page-link text-dark page-border-none ms-1 me-5" href="#">5</a></li>
		                  <li class="page-item">
		                    <a class="page-link text-dark" href="#"><img class="arrow-right" src="${pageContext.request.contextPath}/resources/image/arrow/page-right-arrow.svg"></a>
		                  </li>
		                </ul>
		            </nav>--%>
				</div> 
				
			</div>
			
			<div class='right-container'>
				<div class="my-holiday card">
					<p class="mini-title">나의 휴가 일정</p>
					<div class="mini-line"></div>
					<div id="calendar" class="main-calendar"></div>
				</div>
			</div>
		</div>
	</div>

<%@ include file="/WEB-INF/views/common/message.jsp"%>
				<%-- <div class="dept-attendance card">
					<div>
						<p class="mini-title">부서 근무 현황</p>
						<div class="search">
							<div class="main-search-drop">검색창</div>
							<div class="main-search-box">이름 검색</div>
						</div>
					</div>
					<div class="dept-attendance-cur">
						<table class="table dept-attendance-table">
							<thead class="header-dept">
							  <tr>
							    <th scope="col">이름</th>
							    <th scope="col">상태</th>
							    </tr>
							</thead>
							<tbody>
								<c:forEach begin="1" end="5">
								  <tr>
								    <th scope="row" class="dept-profile-box">
								    	<img class="dept-profile-img" src="${pageContext.request.contextPath}/resources/image/profileDefault.png">
								    	<div class="dept-profile-info">
								    		<h4>오티아이 부장</h4>
								    		<p>공공사업1div</p>
								    	</div>
								    </th>
								    <td><div class="button-small dept-atd-state">미출근</div></td>
								  </tr>
							  </c:forEach>
							</tbody>
						</table>
						<nav class="mt-5 mb-3">
		                <ul class="pagination justify-content-center">
		                  <li class="page-item disabled">
		                    <a class="page-link text-dark" href="#" tabindex="-1" aria-disabled="true"><img class="arrow-left" src="${pageContext.request.contextPath}/resources/image/arrow/page-left-arrow.svg"></a>
		                  </li>
		                  <li class="page-item"><a class="page-link text-dark page-border-none ms-5" href="#">1</a></li>
		                  <li class="page-item"><a class="page-link text-dark page-border-none ms-1" href="#">2</a></li>
		                  <li class="page-item"><a class="page-link text-dark page-border-none ms-1" href="#">3</a></li>
		                  <li class="page-item"><a class="page-link text-dark page-border-none ms-1" href="#">4</a></li>
		                  <li class="page-item"><a class="page-link text-dark page-border-none ms-1 me-5" href="#">5</a></li>
		                  <li class="page-item">
		                    <a class="page-link text-dark" href="#"><img class="arrow-right" src="${pageContext.request.contextPath}/resources/image/arrow/page-right-arrow.svg"></a>
		                  </li>
		                </ul>
		            </nav>
					</div>
				</div>  --%>
				<%-- 
			</div>
		</div>
	</div>
</div>
 --%>


<script src="${pageContext.request.contextPath}/resources/js/home.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/common/header.js"></script>