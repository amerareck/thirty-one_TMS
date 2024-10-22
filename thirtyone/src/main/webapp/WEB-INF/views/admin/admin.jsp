<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/admin.css" />
	<div class="content-box">
		<p class="title">${title}</p>
		<div class="top-container">
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
							<canvas id="attendance-rate" style="width:250px;  height: 250px;"></canvas>
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
							<canvas id="emp-rate" style="width:250px; height: 250px;"></canvas>
						</div>
					</div>
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
			<div class="emp-status card">
				<div class="emp-status-top">
					<p class="mini-title">근로자 현황</p>
					<a href="#">더보기</a>
				</div>			
				<div class="emp-status-box">
					<c:forEach begin="1" end="6">
					<div class="admin-profile-box">
						<img class="admin-profile-img" src="${pageContext.request.contextPath}/resources/image/profileDefault.png">
				    	<div class="admin-profile-info">
				    		<h4>오티아이 부장</h4>
				    		<p>공공사업1div</p>
				    	</div>
			    		<img class="next-profile" src="${pageContext.request.contextPath}/resources/image/arrow/page-right-arrow.svg">
			    	</div>
			    	</c:forEach>
			    	<nav class="mt-3 mb-3">
		                <ul class="pagination justify-content-center">
		                  <li class="page-item disabled">
		                    <a class="page-link text-dark" href="#" tabindex="-1" aria-disabled="true"><img class="arrow-left" src="${pageContext.request.contextPath}/resources/image/arrow/page-left-arrow.svg" width="7px"></a>
		                  </li>
		                  <li class="page-item"><a class="page-link text-dark page-border-none ms-1" href="#">1</a></li>
		                  <li class="page-item"><a class="page-link text-dark page-border-none " href="#">2</a></li>
		                  <li class="page-item"><a class="page-link text-dark page-border-none " href="#">3</a></li>
		                  <li class="page-item"><a class="page-link text-dark page-border-none " href="#">4</a></li>
		                  <li class="page-item"><a class="page-link text-dark page-border-none me-1" href="#">5</a></li>
		                  <li class="page-item">
		                    <a class="page-link text-dark" href="#"><img class="arrow-right" src="${pageContext.request.contextPath}/resources/image/arrow/page-right-arrow.svg" width="7px"></a>
		                  </li>
		                </ul>
		            </nav>
				</div>
			</div>
		</div>
		<div class="bottom-container">
			<div class="new-atd-request-box card">
				<div class="emp-status-top">
					<p class="mini-title">신규 근태신청 현황</p>
					<a href="#">더보기</a>
				</div>	
				<div class="mini-line"></div>
				<div class="new-request-box">
					<c:forEach begin="1" end="6">
						<div class="new-request">
							<div class="status-btn">승인</div>
					    	<p>공공사업1DIV팀 / 정원석</p>
					    	<p>2024/10/09 13:35:37</p>
				    	</div>
			    	</c:forEach>
		    	</div>
			</div>
			<div class="admin-notice card">
			<div class="emp-status-top">
				<p class="mini-title">공지사항</p>
				<a href="#">더보기</a>
			</div>
			<div class="mini-line"></div>
			<div class="new-request-box">
				<c:forEach begin="1" end="6">
					<div class="new-request">
						<div class="notice-btn">중요</div>
				    	<p>공지사항입니다.</p>
				    	<p>2024/10/09 13:35:37</p>
			    	</div>
		    	</c:forEach>
	    	</div>
		</div>			
	</div>
		

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>		

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/admin/admin.js"></script>
		
<%@ include file="/WEB-INF/views/common/footer.jsp"%>