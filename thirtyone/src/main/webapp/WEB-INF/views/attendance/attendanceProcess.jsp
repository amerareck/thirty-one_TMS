<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/attendance/attendanceProcess.css" />
    
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<div class="content-box">
	<div class="main-container" >
		<p class="title-31">${title}</p>
		<div class="attendance-subtitle sub-title">
			<div ><a href="${pageContext.request.contextPath}/atd/">근태 현황</a></div>
			<div ><a href="${pageContext.request.contextPath}/atd/time">근무 시간</a></div>
			<div class="selected-sub-title"><a href="${pageContext.request.contextPath}/atd/process">근태 처리</a></div>
		</div>
		<div class="main-line"></div>
		<div class="flex-container">
			<div class="process-list-box card">
				<p class="mini-title">처리 목록</p>
				<div>
					<table class="table process-list-table">
						<thead class="header-dept">
						  <tr>
						    <th scope="col">이름</th>
						    <th scope="col">일자</th>
						    <th scope="col">상태</th>
						  </tr>
						</thead>
						<tbody>
							<c:forEach items="${reasonList}" var="reason">
							  <tr class="process-tr" data-reasonid="${reason.reason.reasonId}" data-empid="${reason.emp.empId}">
							    <th scope="row" class="process-profile-box">
							    	<img class="process-profile-img" src="${pageContext.request.contextPath}/resources/image/profileDefault.png">
							    	<div class="process-profile-info">
							    		<h4>${reason.emp.empName }</h4>
							    		<p>${reason.deptName}</p>
							    	</div>
							    </th>
							    <td><fmt:formatDate value='${reason.reason.atdDate}' pattern='yyyy-MM-dd'/></td>
							    <td>${reason.reason.reasonType }</td>
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
			<div class="reason-report-box card">
				<p class="mini-title">사유서</p>
				<div class="mini-line"></div>
			</div>
		</div>
<script type="text/javascript">
	contextPath = '${pageContext.request.contextPath}';
</script>

<script src="${pageContext.request.contextPath}/resources/js/attendance/attendanceProcess.js"></script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>