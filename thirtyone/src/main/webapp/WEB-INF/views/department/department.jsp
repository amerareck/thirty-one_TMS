<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/department/department.css" />
<div class="content-box">
	<div class="main-container" >
		<p class="title-31">${title}</p>
		<div class="dept-atd-subtitle sub-title">
			<div class="selected-sub-title"><a href="${pageContext.request.contextPath}/dept/">부서 근태</a></div>
			<div ><a href="${pageContext.request.contextPath}/dept/holiday">부서 일정</a></div>
		</div>
		<div class="main-line"></div>
		<div class="full-container">
			<div class="left-container">
				<div class="dept-attendance card">
					<div>
						<p class="mini-title">부서원 근무 상태</p>
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
								<c:forEach begin="1" end="8">
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
			                    <a class="page-link text-dark" href="#" tabindex="-1" aria-disabled="true"><img class="arrow-left" src="${pageContext.request.contextPath}/resources/image/arrow/page-left-arrow.svg" width="10px"></a>
			                  </li>
			                  <li class="page-item"><a class="page-link text-dark page-border-none ms-3" href="#">1</a></li>
			                  <li class="page-item"><a class="page-link text-dark page-border-none ms-1" href="#">2</a></li>
			                  <li class="page-item"><a class="page-link text-dark page-border-none ms-1" href="#">3</a></li>
			                  <li class="page-item"><a class="page-link text-dark page-border-none ms-1" href="#">4</a></li>
			                  <li class="page-item"><a class="page-link text-dark page-border-none ms-1 me-3" href="#">5</a></li>
			                  <li class="page-item">
			                    <a class="page-link text-dark" href="#"><img class="arrow-right" src="${pageContext.request.contextPath}/resources/image/arrow/page-right-arrow.svg" width="10px"></a>
			                  </li>
			                </ul>
		            	</nav>
					</div>
				</div>
			</div>
			<div class="right-container">
				<div class="attendance-stauts card">
					<div class="atd-status-top">
						<p class="mini-title">일일 근로 현황</p>
						<p>2024년 10월 10일</p>
					</div>			
					<div class="mini-line"></div>
					<div class="atd-status-box">
						<div class="dounut-box">
							<div class="work-status">
								<h3>근무 현황</h3>
								<div><span>총원</span><span>20</span></div>
								<div><span>출근전</span><span>03</span></div>
								<div><span>출근</span><span>13</span></div>
								<div><span>휴가</span><span>02</span></div>
								<div><span>휴직</span><span>01</span></div>
								<div><span>결근</span><span>01</span></div>
							</div>
							<div>
								<canvas id="attendance-rate" style="width:170px;  height: 170px;"></canvas>
							</div>
							<div class="attendance-emp">
								<h3>출근자 현황</h3>
								<div><span>근무중</span><span>11</span></div>
								<div><span>출근</span><span>01</span></div>
								<div><span>외근</span><span>00</span></div>
								<div><span>외출</span><span>01</span></div>
								<div><span>기타</span><span>00</span></div>
							</div>
							<div>
								<canvas id="emp-rate" style="width:170px; height: 170px;"></canvas>
							</div>
						</div>
						<div>
							<table class="table atd-status-table">
								<thead>
									<tr>
										<td>출근율</td>
										<td>총원</td>
										<td>출근전</td>
										<td>출근</td>
										<td>휴가</td>
										<td>결근</td>
										<td>근무중</td>
										<td>출장</td>
										<td>외근</td>
										<td>외출</td>
										<td>기타</td>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>74%</td>
										<td>20</td>
										<td>03</td>
										<td>13</td>
										<td>02</td>
										<td>01</td>
										<td>11</td>
										<td>01</td>
										<td>00</td>
										<td>01</td>
										<td>00</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="dept-holiday-box card">
					<div>
						<p class="mini-title">부서원 근무 상태</p>
						<div class="search">
							<div class="main-search-drop">검색창</div>
							<div class="main-search-box">이름 검색</div>
						</div>
					</div>
					<div class="dept-holiday">
						<table class="table dept-holiday-table">
							<thead class="header-dept-holiday">
							    <tr>
								    <th scope="col">이름</th>
								    <th scope="col">기간</th>
								    <th scope="col">휴가항목</th>
								    <th scope="col">신청일수</th>
						        </tr>
							</thead>
							<tbody>
								<c:forEach begin="1" end="4">
								    <tr>
								        <td>
											<div class="dept-profile-box">
									    	    <img class="dept-profile-img" src="${pageContext.request.contextPath}/resources/image/profileDefault.png">
									    	    <div class="holiday-profile-info">
									    	 	    <h4>오티아이 부장</h4>
									    		    <p>공공사업1div</p>
									    	    </div>
								    	    </div>
								        </td>
								        <td>2024-10-16 ~ 2024-10-18</td>
								        <td>연차</td>
								        <td>3일</td>
								    </tr>
							    </c:forEach>
							</tbody>
						</table>
						<nav class="mt-5 mb-3">
		                <ul class="pagination justify-content-center">
		                  <li class="page-item disabled">
		                    <a class="page-link text-dark" href="#" tabindex="-1" aria-disabled="true"><img class="arrow-left" src="${pageContext.request.contextPath}/resources/image/arrow/page-left-arrow.svg" width="10px"></a>
		                  </li>
		                  <li class="page-item"><a class="page-link text-dark page-border-none ms-3" href="#">1</a></li>
		                  <li class="page-item"><a class="page-link text-dark page-border-none ms-1" href="#">2</a></li>
		                  <li class="page-item"><a class="page-link text-dark page-border-none ms-1" href="#">3</a></li>
		                  <li class="page-item"><a class="page-link text-dark page-border-none ms-1" href="#">4</a></li>
		                  <li class="page-item"><a class="page-link text-dark page-border-none ms-1 me-3" href="#">5</a></li>
		                  <li class="page-item">
		                    <a class="page-link text-dark" href="#"><img class="arrow-right" src="${pageContext.request.contextPath}/resources/image/arrow/page-right-arrow.svg" width="10px"></a>
		                  </li>
		                </ul>
		            	</nav>
					</div>
				</div>
			</div>
		</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>		
		

<script src="${pageContext.request.contextPath}/resources/js/department/department.js"></script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>