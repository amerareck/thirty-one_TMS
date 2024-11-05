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
					      <th scope="col">신청일</th>
					      <th scope="col">신청일수</th>
					      <th scope="col">사유</th>
					      <th scope="col">상태</th>
					    </tr>
					  </thead>
					  <tbody>
					  	<c:forEach items="${hdrReqList }" var="hdrReq">
						    <tr>
						      <th scope="row">${hdrReq.hdName }</th>
						      <td><fmt:formatDate value="${hdrReq.hdrStartDate}" pattern="yyyy-MM-dd" /> ~ <fmt:formatDate value="${hdrReq.hdrEndDate}" pattern="yyyy-MM-dd" /></td>
						      <td><fmt:formatDate value="${hdrReq.hdrSubmittedDate}" pattern="MM-dd" /></td>
						      <td>${hdrReq.hdrUsedDay}일</td>
						      <td>${hdrReq.hdrContent}</td>
						      <td><div class="btn accept-state">${hdrReq.hdrStatus }</div></td>
						    </tr>
					    </c:forEach>
				      </tbody>
				    </table>
				    <div class="pagination">
						<c:if test="${pager.groupNo>1}">
							<a href="process?pageNo=${pager.startPageNo-1}"> 
								<img src="${pageContext.request.contextPath}/resources/image/prev_icon.png" alt="prev" style="width: 110px">
							</a>
						</c:if>
						<c:forEach begin="${pager.startPageNo}" end="${pager.endPageNo}" step="1" var="i">
							<c:if test="${pager.pageNo==i}">
								<button class="page-num active"
									onclick="location.href='${pageContext.request.contextPath}/atd/process?pageNo=${i}'"
									style="color: #686868">${i}</button>
							</c:if>
							<c:if test="${pager.pageNo!=i}">
								<button class="page-num"
									onclick="location.href='${pageContext.request.contextPath}/atd/process?pageNo=${i}'">
									${i}</button>
							</c:if>
						</c:forEach>
						<c:if test="${pager.groupNo<pager.totalGroupNo}">
							<a href="process?pageNo=${pager.endPageNo+1}">
								<img src="${pageContext.request.contextPath}/resources/image/next_icon.png" alt="next" style="width: 110px">
							</a>
						</c:if>
					</div>
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
							<div><span>연차 부여일수</span><span>${annual.hdCount} 일</span></div>
							<div><span>대체휴가</span><span>${substitute != null || substitute.hdCount == 0 ? substitute.hdCount : "- "}일</span></div>
							<div><span>연차 사용일수</span><span>${annual.hdUsed} 일</span></div>
							<div><span>연차 잔여일수</span><span>${annual.hdCount - annual.hdUsed} 일</span></div>
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
<script type="text/javascript">
	contextPath = '${pageContext.request.contextPath}'
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/holiday/status.js"></script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>