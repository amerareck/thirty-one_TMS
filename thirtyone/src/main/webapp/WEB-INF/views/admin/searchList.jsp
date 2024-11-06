<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/searchList.css" />
<div class="content-box">
	<div class="main-container" >
		<p class="title-31">${title}</p>
		<div class="top-container"><button class="button-medium" onclick="location.href='${pageContext.request.contextPath}/admin/joinForm'">+ 직원 추가하기</button></div>
		<div class="middle-container">
			<p>검색된 직원수: ${total}</p>
			<div class="search">
				<select class="form-select" id="search-menu" name="holiday-type">
					<option value="0" selected>이름</option>
					<option value="1">직급</option>
					<option value="2">부서</option>
				</select>
				<div class="searchBar">
					<input type="text" placeholder=" 검색" id="search"
						onkeyup="enterkeySearch()" autocomplete="off">
					<button type="button" class="btn search-btn">
						<img
							src="${pageContext.request.contextPath}/resources/image/search_icon.png"
							alt="검색 아이콘">
					</button>
				</div>
			</div>
		</div>
		<div class="bottom-container">
			<table class="tableContent">
				<thead>
					<tr>
						<td>이름</td>
						<td>직급</td>
						<td>입사일</td>
						<td>부서</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${empDeptList}" var="empDept">
						<tr onclick="location.href = '${pageContext.request.contextPath}/admin/empDetail?empId=${empDept.empInfo.empId}'">
							<td>${empDept.empInfo.empName}</td>
							<td>${empDept.empInfo.position}</td>
							<td><fmt:formatDate value='${empDept.empInfo.empHiredate}' pattern='yyyy-MM-dd'/></td>
							<td>${empDept.deptName}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
				<div class="pagination">
					<c:if test="${pager.groupNo>1}">
						<a href="
							<c:choose>
					            <c:when test="${isSearch == false}">
					                searchList?pageNo=${pager.startPageNo - 1}
					            </c:when>
					            <c:otherwise>
					                searchEmp?query=${query}&category=${category}&pageNo=${pager.pager.startPageNo - 1}
					            </c:otherwise>
				        	</c:choose>">
				    		<img src="${pageContext.request.contextPath}/resources/image/prev_icon.png" alt="prev" style="width: 15px">
						</a>
					</c:if>
					<c:forEach begin="${pager.startPageNo}" end="${pager.endPageNo}" step="1" var="i">
						<c:if test="${pager.pageNo==i}">
							<c:choose>
							    <c:when test="${isSearch == false}">
							        <c:set var="pageUrl" value="searchList?pageNo=${i}" />
							    </c:when>
							    <c:otherwise>
							        <c:set var="pageUrl" value="searchEmp?query=${query}&category=${category}&pageNo=${i}" />
							    </c:otherwise>
							</c:choose>
							
							<button class="page-num" onclick="location.href='${pageUrl}'" style="color: #686868">
							    ${i}
							</button>
						</c:if>
						<c:if test="${pager.pageNo!=i}">
							<c:choose>
							    <c:when test="${isSearch == false}">
							        <c:set var="pageUrl" value="searchList?pageNo=${i}" />
							    </c:when>
							    <c:otherwise>
							        <c:set var="pageUrl" value="searchEmp?query=${query}&category=${category}&pageNo=${i}" />
							    </c:otherwise>
							</c:choose>
							
							<button class="page-num" onclick="location.href='${pageUrl}'">
							    ${i}
							</button>
						</c:if>
					</c:forEach>
					<c:if test="${pager.groupNo<pager.totalGroupNo}">
						<a href="
							<c:choose>
					            <c:when test="${isSearch == false}">
					                searchList?pageNo=${pager.endPageNo + 1}
					            </c:when>
					            <c:otherwise>
					                searchEmp?query=${query}&category=${category}&pageNo=${pager.endPageNo + 1}
					            </c:otherwise>
				        	</c:choose>">
				    		<img src="${pageContext.request.contextPath}/resources/image/next_icon.png" alt="next" style="width: 15px">
						</a>
					</c:if>
				</div>
			</div>
	
<script type="text/javascript">
	contextPath = '${pageContext.request.contextPath}';
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/admin/searchList.js"></script>
		
<%@ include file="/WEB-INF/views/common/footer.jsp"%>