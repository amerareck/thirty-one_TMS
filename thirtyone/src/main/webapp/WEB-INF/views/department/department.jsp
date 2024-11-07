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
								<c:forEach items="${deptEmpList}" var="deptEmp">
								  <tr>
								    <th scope="row" class="dept-profile-box">
								    	<img class="dept-profile-img" src="${pageContext.request.contextPath}/resources/image/profileDefault.png">
								    	<div class="dept-profile-info">
								    		<h4>${deptEmp.emp.empName} ${deptEmp.emp.position}</h4>
								    		<p>${deptEmp.deptName }</p>
								    	</div>
								    </th>
								    <td>
									    <c:choose>
										    <c:when test="${deptEmp.atd != null }">
										    	<div class="button-small dept-atd-state">출근</div>
										    </c:when>
										    <c:otherwise>
										    	<div class="button-small dept-check-in-state">미출근</div>									    
										    </c:otherwise>
									    </c:choose>
								    </td>
								  </tr>
							  </c:forEach>
							</tbody>
						</table>
						<div class="pagination">
							<c:if test="${pager.groupNo>1}">
								<a href="?atdPageNo=${pager.startPageNo - 1}">
						    		<img src="${pageContext.request.contextPath}/resources/image/prev_icon.png" alt="prev" style="width: 15px">
								</a>
							</c:if>
							<c:forEach begin="${pager.startPageNo}" end="${pager.endPageNo}" step="1" var="i">
								<c:if test="${pager.pageNo==i}">									
									<button class="page-num" onclick="location.href='?atdPageNo=${i}'" style="color: #686868">
									    ${i}
									</button>
								</c:if>
								<c:if test="${pager.pageNo!=i}">									
									<button class="page-num" onclick="location.href='?atdPageNo=${i}'">
									    ${i}
									</button>
								</c:if>
							</c:forEach>
							<c:if test="${pager.groupNo<pager.totalGroupNo}">
								<a href="?atdPageNo=${pager.endPageNo + 1}">
						    		<img src="${pageContext.request.contextPath}/resources/image/next_icon.png" alt="next" style="width: 15px">
								</a>
							</c:if>
						</div>
					</div>
				</div>
			</div>
			<div class="right-container">
				<div class="attendance-stauts card">
					<div class="atd-status-top">
						<p class="mini-title">일일 근로 현황</p>
						<p><fmt:formatDate value='${today}' pattern='yyyy년 MM월 dd일'/></p>
					</div>			
					<div class="mini-line"></div>
					<div class="atd-status-box">
						<div class="dounut-box">
							<div class="work-status">
								
							</div>
							<div>
								<canvas id="attendance-rate" style="width:220px;  height: 220px;"></canvas>
							</div>
							<div>
								<canvas id="emp-rate" width=220 height=220></canvas>
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
				</div>
				<div class="dept-holiday-box card">
					<div>
						<p class="mini-title">부서원 근무 상태</p>
						<div class="search">
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
								<c:forEach items="${deptHdList }" var="deptHd">
								    <tr>
								        <td>
											<div class="dept-profile-box">
									    	    <img class="dept-profile-img" src="${pageContext.request.contextPath}/resources/image/profileDefault.png">
									    	    <div class="holiday-profile-info">
									    	 	    <h4>${deptHd.emp.empName} ${deptHd.emp.position} </h4>
									    		    <p>${deptHd.deptName}</p>
									    	    </div>
								    	    </div>
								        </td>
								        <td><fmt:formatDate value='${deptHd.hdr.hdrStartDate}' pattern='yyyy-MM-dd'/> ~ <fmt:formatDate value='${deptHd.hdr.hdrEndDate}' pattern='yyyy-MM-dd'/></td>
								        <td>${deptHd.hdr.hdName}</td>
								        <td>${deptHd.hdr.hdrUsedDay}일</td>
								    </tr>
							    </c:forEach>
							</tbody>
						</table>
						<div class="pagination">
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
						</div>
					</div>
				</div>
			</div>
		</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>		
<script type="text/javascript">
	const contextPath = '${pageContext.request.contextPath}'
</script>		

<script src="${pageContext.request.contextPath}/resources/js/department/department.js"></script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>