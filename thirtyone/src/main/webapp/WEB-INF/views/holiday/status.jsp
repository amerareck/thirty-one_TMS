<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/holiday/status.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<div class="content-box">
	<div class="main-container" >
		<p class="title-31">${title}</p>
		<div class="holiday-subtitle sub-title">
			<div  class="selected-sub-title"><a href="${pageContext.request.contextPath}/holiday/" >휴가 현황</a></div>
			<div><a href="${pageContext.request.contextPath}/holiday/request" >휴가 신청</a></div>
			<div><a href="${pageContext.request.contextPath}/holiday/process">휴가 처리</a></div>
		</div>
		<div class="main-line"></div>
		<div class="full-container">
			<div class="left-container">
				<div class="holiday-list-box card">
					<div class="holiday-title-box">
						<p class="mini-title">휴가 내역</p>
						<div id="choiceDay">
							<p>2024-10-14 ~ 2024-10-20</p>
							<img src="${pageContext.request.contextPath}/resources/image/calendar-icon.svg">
						</div>
					</div>
					<table class="table holiday-list-table">
					  <thead>
					    <tr>
					      <th scope="col">휴가항목</th>
					      <th scope="col">기간</th>
					      <th scope="col">상태</th>
					      <th scope="col">신청일</th>
					      <th scope="col">신청일수</th>
					      <th scope="col">사유</th>
					    </tr>
					  </thead>
					  <tbody>
					    <tr>
					      <th scope="row">연차</th>
					      <td>2024-10-16 ~ 2024-10-18</td>
					      <td><div class="btn accept-state">승인</div></td>
					      <td>2024-10-05</td>
					      <td>3일</td>
					      <td>연차</td>
					    </tr>
				      </tbody>
				      <tbody>
					    <tr>
					      <th scope="row">연차</th>
					      <td>2024-10-16 ~ 2024-10-18</td>
					      <td><div class="btn accept-state">승인</div></td>
					      <td>2024-10-05</td>
					      <td>3일</td>
					      <td>연차</td>
					    </tr>
				      </tbody>
				      <tbody>
					    <tr>
					      <th scope="row">연차</th>
					      <td>2024-10-16 ~ 2024-10-18</td>
					      <td><div class="btn accept-state">승인</div></td>
					      <td>2024-10-05</td>
					      <td>3일</td>
					      <td>연차</td>
					    </tr>
				      </tbody>
				      <tbody>
					    <tr>
					      <th scope="row">연차</th>
					      <td>2024-10-16 ~ 2024-10-18</td>
					      <td><div class="btn accept-state">승인</div></td>
					      <td>2024-10-05</td>
					      <td>3일</td>
					      <td>연차</td>
					    </tr>
				      </tbody>
				      <tbody>
					    <tr>
					      <th scope="row">연차</th>
					      <td>2024-10-16 ~ 2024-10-18</td>
						  <td><div class="btn wating-state" >대기</div></td>	
					      <td>2024-10-05</td>
					      <td>3일</td>
					      <td>연차</td>
					    </tr>
				      </tbody>
		    		  <tbody>
					    <tr>
					      <th scope="row">연차</th>
					      <td>2024-10-16 ~ 2024-10-18</td>
						  <td><div class="btn wating-state" >대기</div></td>	
					      <td>2024-10-05</td>
					      <td>3일</td>
					      <td>연차</td>
					    </tr>
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
			</div>
			<div class="right-container">
				<div class="holiday-schedule-box card">
					<p class="mini-title">나의 휴가일정</p>
					<div class="mini-line"></div>
					<div id="calendar" class="main-calendar"></div>
				</div>
				<div class="holiday-status-box card">
					<p class="mini-title">휴가 현황</p>
					<div class="holiday-status">
						<div class="holiday-status-detail">
							<div><span>부여일수</span><span>17일</span></div>
							<div><span>연차</span><span>15일</span></div>
							<div><span>대체휴가</span><span>2일</span></div>
							<div><span>사용일수</span><span>12.5일</span></div>
							<div><span>잔여일수</span><span>7.5일</span></div>
						</div>
						<div>
							<canvas id="doughnut-chart" style="width: 150px;"></canvas>	
						</div>
					</div>
				</div>
			</div>
		
		</div>


<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>

<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/holiday/status.js"></script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>