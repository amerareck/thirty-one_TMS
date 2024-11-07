<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="/WEB-INF/views/approval/approvalContainer.jsp" %>
	
<div class="sub-title m-0">
	<div <c:if test="${activePage == 'ready'}">class="sub-title-active"</c:if>><a href="approveList?type=ready">결재 대기</a></div>
	<div <c:if test="${activePage == 'all'}">class="sub-title-active"</c:if>><a href="approveList?type=all">전체 결재 목록</a></div>
</div>
<div class="main-line mx-0 mb-5"></div>

<section style="margin: 0 auto;">
	<div class="d-flex justify-content-between align-item-center my-2">
	    <div class="w-25 d-flex align-item-center">
	        <h5 class="fw-bold" style="margin:auto 0; color:#5A5A5A;">${sectionTitle}</h5>
	    </div>
	    <div class="input-group" style="width: 40%;">
	        <select class="form-select form-select-sm" style="flex:1;">
	            <option selected>전체</option>
	            <option value="draftTitle">제목</option>
	            <option value="draftType">유형</option>
	            <option value="draftAuthor">기안자</option>
	        </select>
	        <input class="form-control col-8" placeholder="검색 유형 입력" style="flex:3;" />
	        <button class="btn btn-outline-secondary" style="border-color: #dee2e6;" type="button"><i class="fa-solid fa-magnifying-glass"></i></button>
	    </div>
	</div>

	<table class="table table-hover table-header-bg">
	    <thead>
	      <tr>
	        <th scope="col" class="text-center align-middle">기안 유형</th>
	        <th scope="col" class="text-center align-middle">문서 번호</th>
	        <th scope="col" class="text-center align-middle">품의 제목</th>
	        <th scope="col" class="text-center align-middle">부서</th>
	        <th scope="col" class="text-center align-middle">직급</th>
	        <th scope="col" class="text-center align-middle">기안자</th>
	        <th scope="col" class="text-center align-middle">결재</th>
	        <th scope="col" class="text-center align-middle">상태</th>
	      </tr>
	    </thead>
	    <tbody>
			<c:if test="${not empty aprList}">
	    	<c:forEach items="${aprList}" var="apr" varStatus="i" >
			<tr>
				<td class="text-center align-middle table-font-size">${apr.docFormName}</td>
				<td class="text-center align-middle table-font-size">${apr.docNumber}</td>
				<td class="text-center align-middle table-font-size">${apr.docTitle}</td>
				<td class="text-center align-middle table-font-size">${apr.deptName}</td>
				<td class="text-center align-middle table-font-size">${apr.empInfo.position}</td>
				<td class="text-center align-middle table-font-size">${apr.empInfo.empName}</td>
				<td class="text-center align-middle"><button class="btn btn-outline-secondary btn-ssm" data-bs-toggle="modal" data-bs-target="#approvalContext-${i.index}">결재</button></td>
				<c:if test="${apr.docAprStatus == '대기'}"><td class="text-center align-middle"><img src="${pageContext.request.contextPath}/resources/image/approval-await.png" width="50px" height="20px" /></td></c:if>
				<c:if test="${apr.docAprStatus == '진행'}"><td class="text-center align-middle"><img src="${pageContext.request.contextPath}/resources/image/approval-doing.png" width="50px" height="20px" /></td></c:if>
				<c:if test="${apr.docAprStatus == '승인'}"><td class="text-center align-middle"><img src="${pageContext.request.contextPath}/resources/image/approval-approve.png" width="50px" height="20px" /></td></c:if>
				<c:if test="${apr.docAprStatus == '반려'}"><td class="text-center align-middle"><img src="${pageContext.request.contextPath}/resources/image/approval-rejected.png" width="50px" height="20px" /></td></c:if>
			</tr>
	    	</c:forEach>
			</c:if>
			<c:if test="${empty aprList}">
				<tr><td colspan="8" class="text-center align-bottom">결재하실 문서가 존재하지 않습니다.</td></tr>
			</c:if>
	    </tbody>
	</table>

	<c:if test="${pager.totalRows > 0}">
		<nav class="d-flex justify-content-center" style="width: 95%">
			<ul class="pagination pagination-not-effect justify-content-center pagination-size">
				<li class="page-item ${pager.startPageNo == 1 ? 'disabled' : ''}">
					<a class="page-link page-border-none text-dark" href="submitted?type=retrieval&pageNo=${pager.endPageNo-pager.pagesPerGroup}" tabindex="-1" aria-disabled="true"><i class="fa-solid fa-chevron-left"></i></a>
				</li>
				<c:forEach begin="${pager.startPageNo}" end="${pager.endPageNo}" var="i">
					<li class="page-item ${pager.pageNo == i ? 'disabled' : ''}"><a class="page-link text-dark page-border-none ${pager.pageNo==i ? 'fw-bold' : ''} ${i == pager.startPageNo ? 'ms-5' : 'ms-1'} ${i == pager.endPageNo ? 'me-5' : ''}" href="#">${i}</a></li>
				</c:forEach>
				<li class="page-item ${pager.totalPageNo == pager.endPageNo ? 'disabled' : ''}">
					<a class="page-link page-border-none text-dark" href="submitted?type=retrieval&pageNo=${pager.endPageNo+1}"><i class="fa-solid fa-chevron-right"></i></a>
				</li>
			</ul>
		</nav>
	</c:if>
</section>

<%@ include file="/WEB-INF/views/approval/approvalContext.jsp" %>
<%@ include file="/WEB-INF/views/approval/approvalContainerFooter.jsp" %>