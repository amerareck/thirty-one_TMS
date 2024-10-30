<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/admin/org/orgContainer.jsp"%>
<div class="sub-title m-0">
	<div <c:if test="${activePage == 'orgChart'}">class="sub-title-active"</c:if>><a href="org">조직도 관리</a></div>
	<div <c:if test="${activePage == 'position'}">class="sub-title-active"</c:if>><a href="position">직급 관리</a></div>
	<div <c:if test="${activePage == 'employee'}">class="sub-title-active"</c:if>><a href="employee">멤버 관리</a></div>
</div>
<div class="main-line mx-0 mb-5"></div>

<section style="margin: 0 auto;">
	<div class="d-flex justify-content-between align-item-center my-2">
		<div class="w-25 d-flex align-item-center">
			<button type="button" class="btn btn-outline-secondary d-flex justify-content-between align-items-center" style="width: 100px; height: 37px; border-color: #e2e2e2;">
				<i class="fas fa-pencil-alt w-25 d-flex justify-content-center"></i>
				<span style="font-size: .875rem;">선택 수정</span>
			</button>
		</div>
		<div class="input-group" style="width: 30%;">
			<select class="form-select form-select-sm" style="flex:1;">
			    <option value="empName" selected>이름</option>
			    <option value="empDept">부서</option>
			    <option value="empPosition">직급</option>
			</select>
			<input class="form-control" placeholder="검색" style="flex:2; height: 37.77px !important;" />
			<button class="btn btn-outline-secondary" style="border-color: #dee2e6;" type="button"><i class="fa-solid fa-magnifying-glass"></i></button>
		</div>
	</div>

	<table class="table table-hover table-header-bg">
		<thead>
			<tr>
				<th scope="col" class="justify-start align-middle ps-4" style="width: 5%"><input type="checkbox" /></th>
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
				<tr class="table-group-divider">
					<td class="justify-start align-middle ps-4 table-font-size"><input type="checkbox" /></td>
					<td class="text-center align-middle table-font-size"><img src="${pageContext.request.contextPath}/resources/image/employeePicture.png" width="40px"/></td>
					<td class="align-middle table-font-size">${emp.empInfo.empName}</td>
					<td class="align-middle table-font-size">${emp.deptName }</td>
					<td class="align-middle table-font-size">${emp.empInfo.position }</td>
					<td class="align-middle table-font-size">${emp.empInfo.empEmail }</td>
					<td class="align-middle table-font-size">${emp.empInfo.empTel }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<div class="mt-5 mb-3 d-flex justify-content-center align-items-center w-100">
		<nav class="d-flex justify-content-center">
			<ul class="pagination pagination-not-effect justify-content-center pagination-size">
				<li class="page-item disabled">
					<a class="page-link page-border-none text-dark" href="#" tabindex="-1" aria-disabled="true"><i class="fa-solid fa-chevron-left"></i></a>
				</li>
				<li class="page-item"><a class="page-link text-dark page-border-none ms-5" href="#">1</a></li>
				<li class="page-item"><a class="page-link text-dark page-border-none ms-1" href="#">2</a></li>
				<li class="page-item"><a class="page-link text-dark page-border-none ms-1" href="#">3</a></li>
				<li class="page-item"><a class="page-link text-dark page-border-none ms-1" href="#">4</a></li>
				<li class="page-item"><a class="page-link text-dark page-border-none ms-1 me-5" href="#">5</a></li>
				<li class="page-item">
					<a class="page-link page-border-none text-dark" href="#"><i class="fa-solid fa-chevron-right"></i></a>
				</li>
			</ul>
		</nav>
	</div>
</section>
<%@ include file="/WEB-INF/views/admin/org/orgContainerFooter.jsp"%>