<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/admin/org/orgContainer.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/orgEmp.css" />
<div class="sub-title m-0">
	<div <c:if test="${activePage == 'orgChart'}">class="sub-title-active"</c:if>><a href="org">조직도 관리</a></div>
	<div <c:if test="${activePage == 'position'}">class="sub-title-active"</c:if>><a href="position">직급 관리</a></div>
	<div <c:if test="${activePage == 'employee'}">class="sub-title-active"</c:if>><a href="employee">멤버 관리</a></div>
</div>
<div class="main-line mx-0 mb-5"></div>

<section style="margin: 0 auto;">
	<div class="d-flex justify-content-between align-item-center my-2">
		<div class="w-25 d-flex align-item-center">
			<button type="button" class="dept-update-btn btn btn-outline-secondary d-flex justify-content-between align-items-center" style="width: 100px; height: 37px; border-color: #e2e2e2;" 
				data-bs-toggle="modal" data-bs-target="#dept-update-modal">
				<i class="fas fa-pencil-alt w-25 d-flex justify-content-center"></i>
				<span style="font-size: .875rem;">선택 수정</span>
			</button>
		</div>
		<div class="input-group" style="width: 30%;">
			<select class="form-select form-select-sm" id="search-menu" style="flex:1;">
			    <option value="0" selected>이름</option>
			    <option value="1">직급</option>
			    <option value="2">부서</option>
			</select>
			<input class="form-control" id="search" onkeyup="enterkeySearch()" autocomplete="off" placeholder="검색" style="flex:2; height: 37.77px !important;" />
			<button class="btn btn-outline-secondary" style="border-color: #dee2e6;" type="button"><i class="fa-solid fa-magnifying-glass"></i></button>
		</div>
	</div>

	<table class="table table-hover table-header-bg">
		<thead>
			<tr>
				<th scope="col" class="justify-start align-middle ps-4" style="width: 5%"><input class="check-all-select" type="checkbox" /></th>
				<th scope="col" class="text-center align-middle" style="width: 15%">사진</th>
				<th scope="col" class="align-middle" style="width: 15%">이름</th>
				<th scope="col" class="align-middle" style="width: 15%">조직</th>
				<th scope="col" class="align-middle" style="width: 10%">직급</th>
				<th scope="col" class="align-middle">이메일</th>
				<th scope="col" class="align-middle">연락처</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${empDeptList}" var="emp">
				<tr class="table-group-divider"	>
					<td class="justify-start align-middle ps-4 table-font-size"><input class="check-box" type="checkbox" data-empid="${emp.empInfo.empId}"/></td>
					<td class="text-center align-middle table-font-size">
						<img class="profile-img" src="${pageContext.request.contextPath}/admin/imageDown?empId=${emp.empInfo.empId}" width="40" height="40" 
							onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/image/employeePicture.png'; this.width=40; this.height=40;">
					</td>
					<td class="align-middle table-font-size">${emp.empInfo.empName}</td>
					<td class="align-middle table-font-size deptName">${emp.deptName }</td>
					<td class="align-middle table-font-size">${emp.empInfo.position }</td>
					<td class="align-middle table-font-size">${emp.empInfo.empEmail }</td>
					<td class="align-middle table-font-size">${emp.empInfo.empTel }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<div class="pagination">
		<c:if test="${pager.groupNo>1}">
			<a href="
				<c:choose>
		            <c:when test="${isSearch == false}">
		                employee?pageNo=${pager.startPageNo - 1}
		            </c:when>
		            <c:otherwise>
		                searchDeptEmp?query=${query}&category=${category}&pageNo=${pager.pager.startPageNo - 1}
		            </c:otherwise>
	        	</c:choose>">
	    		<img src="${pageContext.request.contextPath}/resources/image/prev_icon.png" alt="prev" style="width: 15px">
			</a>
		</c:if>
		<c:forEach begin="${pager.startPageNo}" end="${pager.endPageNo}" step="1" var="i">
			<c:if test="${pager.pageNo==i}">
				<c:choose>
				    <c:when test="${isSearch == false}">
				        <c:set var="pageUrl" value="employee?pageNo=${i}" />
				    </c:when>
				    <c:otherwise>
				        <c:set var="pageUrl" value="searchDeptEmp?query=${query}&category=${category}&pageNo=${i}" />
				    </c:otherwise>
				</c:choose>
				
				<button class="page-num" onclick="location.href='${pageUrl}'" style="color: #686868">
				    ${i}
				</button>
			</c:if>
			<c:if test="${pager.pageNo!=i}">
				<c:choose>
				    <c:when test="${isSearch == false}">
				        <c:set var="pageUrl" value="employee?pageNo=${i}" />
				    </c:when>
				    <c:otherwise>
				        <c:set var="pageUrl" value="searchDeptEmp?query=${query}&category=${category}&pageNo=${i}" />
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
		                employee?pageNo=${pager.endPageNo + 1}
		            </c:when>
		            <c:otherwise>
		                searchDeptEmp?query=${query}&category=${category}&pageNo=${pager.endPageNo + 1}
		            </c:otherwise>
	        	</c:choose>">
	    		<img src="${pageContext.request.contextPath}/resources/image/next_icon.png" alt="next" style="width: 15px">
			</a>
		</c:if>
	</div>
</section>


<div class="modal fade" id="dept-update-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
  			<div class="dept-move card">
				<div class="modal-top">
					<p class="mini-title">직책명 변경</p>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="mini-line"></div>
				<div class="modal-box">
					<div class="modal-box-in">
						<p class="modal-label">변경전 부서</p>
						<div class="premove pre-pos-dept"></div>
					</div>
					<div class="modal-box-in">
						<label class="modal-label">변경후 부서</label>
						<select class="aftermove after-pos-dept">
							<c:forEach items="${deptList}" var="dept">
								<option value="${dept.deptId}"> ${dept.deptName} </option>
							</c:forEach>
						</select>	
					</div>
				</div>
				<div class='button-list'>
					<button class="button-large reject" data-bs-dismiss="modal" aria-label="Close">취소</button>
					<button class="button-large accept change-btn-accept" data-posclass="">변경</button>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	let contextPath = '${pageContext.request.contextPath}';
</script>
<script src="${pageContext.request.contextPath}/resources/js/admin/orgEmp.js"></script>
<%@ include file="/WEB-INF/views/admin/org/orgContainerFooter.jsp"%>