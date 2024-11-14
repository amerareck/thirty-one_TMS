<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/admin.css" />
<div class="content-box">
	<p class="title">${title}</p>
	<div class="top-container">
		<div class="attendance-stauts card">
			<div class="atd-status-top">
				<p class="mini-title">일일 근로 현황</p>
				<p>
					<fmt:formatDate value='${today}' pattern='yyyy년 MM월 dd일' />
				</p>
			</div>
			<div class="mini-line"></div>
			<div class="atd-status-box">
				<div class="dounut-box">
					<div class="work-status"></div>
					<div>
						<canvas id="attendance-rate" style="width: 250px; height: 250px;"></canvas>
					</div>
					<div>
						<canvas id="emp-rate" style="width: 250px; height: 250px; margin-left: 50px;"></canvas>
					</div>
				</div>
				<table class="table atd-status-table">
					<thead>
						<tr>
							<td>출근율</td>
							<td>총원</td>
							<td>출근전</td>
							<td>출근</td>
							<td>퇴근</td>
							<td>지각</td>
							<td>조퇴</td>
							<td>휴가</td>
							<td>출장</td>
							<td>결근</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="emp-status card">
			<div class="emp-status-top">
				<p class="mini-title">근로자 현황</p>
				<a href="${pageContext.request.contextPath}/admin/searchList">더보기</a>
			</div>
			<div class="mini-line"></div>
			<div class="emp-status-box">
				<c:forEach items="${empInfoList}" var="empInfo">
					<div class="admin-profile-box">
						<img class="admin-profile-img"
							src="${pageContext.request.contextPath}/admin/imageDown?empId=${empInfo.emp.empId}"
							width="29" height="29"
							onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/image/sky-profile-img.png'; this.width=29; this.height=29;">
						<div class="admin-profile-info"
							onclick="location.href='${pageContext.request.contextPath}/admin/empDetail?empId=${empInfo.emp.empId}'"
							style="cursor: pointer;">
							<h4>${empInfo.emp.empName }${empInfo.emp.position }</h4>
							<p>${empInfo.deptName}</p>
						</div>
						<img class="next-profile"
							src="${pageContext.request.contextPath}/resources/image/arrow/page-right-arrow.svg">
					</div>
				</c:forEach>
				<%-- <div class="pagination">
						<c:if test="${hdpager.groupNo>1}">
							<a href="?pageNo=${hdpager.startPageNo - 1}">
					    		<img src="${pageContext.request.contextPath}/resources/image/prev_icon.png" alt="prev" style="width: 15px">
							</a>
						</c:if>
						<c:forEach begin="${hdpager.startPageNo}" end="${hdpager.endPageNo}" step="1" var="i">
							<c:if test="${hdpager.pageNo==i}">									
								<button class="page-num" onclick="location.href='?pageNo=${i}'" style="color: #686868">
								    ${i}
								</button>
							</c:if>
							<c:if test="${hdpager.pageNo!=i}">									
								<button class="page-num" onclick="location.href='?pageNo=${i}'">
								    ${i}
								</button>
							</c:if>
						</c:forEach>
						<c:if test="${hdpager.groupNo<pager.totalGroupNo}">
							<a href="?pageNo=${hdpager.endPageNo + 1}">
					    		<img src="${pageContext.request.contextPath}/resources/image/next_icon.png" alt="next" style="width: 15px">
							</a>
						</c:if>
					</div> --%>
			</div>
		</div>
	</div>
	<div class="bottom-container">
		<div class="new-atd-request-box card">
			<div class="emp-status-top">
				<p class="mini-title">신규 근태신청 현황</p>
				<a href="${pageContext.request.contextPath}/admin/atdList">더보기</a>
			</div>
			<div class="mini-line"></div>
			<div class="new-request-box" id="reasonRequest">
				<c:forEach items="${reasonInfoList }" var="reason">
					<div class="new-request">
						<div class="status-btn">${reason.reason.reasonStatus}</div>
						<p>${reason.deptName}/${reason.emp.empName }</p>
						<p>
							<fmt:formatDate value='${reason.reason.atdDate}'
								pattern='yyyy-MM-dd HH:mm' />
						</p>
					</div>
				</c:forEach>
			</div>
		</div>
		<div class="admin-notice card">
			<div class="emp-status-top">
				<p class="mini-title">공지사항</p>
				<a href="${pageContext.request.contextPath}/notice/noticeList">더보기</a>
			</div>
			<div class="mini-line"></div>
			<div class="new-request-box" id="noticeRequest">
				<c:forEach begin="1" end="5" items="${noticeList}" var="notice" varStatus="status">
					<div class="new-request">
						<div class="notice-btn">
							<td><c:choose>
									<c:when test="${notice.noticeImportant == '1'}">
										<img
											src="${pageContext.request.contextPath}/resources/image/important_btn.png"
											alt="중요도" style="width:47px;">
									</c:when>
									<c:otherwise>
						${pager.totalRows - (pager.pageNo-1) * 10 - status.index}
					</c:otherwise>
								</c:choose></td>

						</div>
						<p>${notice.noticeTitle}</p>
						<p><fmt:formatDate value='${notice.noticeDate}'
								pattern='yyyy-MM-dd HH:mm' /></p>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>


	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>

	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/js/admin/admin.js"></script>

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>