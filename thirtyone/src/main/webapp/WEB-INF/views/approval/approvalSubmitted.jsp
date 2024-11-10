<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/approval/approvalContainer.jsp"%>
	
<div class="sub-title m-0">
	<div <c:if test="${activePage == 'submitted'}">class="sub-title-active"</c:if>><a href="submitted?type=submitted">결재 상신</a></div>
	<div <c:if test="${activePage == 'retrieval'}">class="sub-title-active"</c:if>><a href="submitted?type=retrieval">회수 문서</a></div>
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
	<c:if test="${activePage == 'submitted'}">
	
	<table class="table table-hover table-header-bg" data-activePage="submitted">
		<thead>
			<tr>
				<th scope="col" class="text-center align-middle"><input type="checkbox" /></th>
				<th scope="col" class="text-center align-middle">기안 유형</th>
				<th scope="col" class="text-center align-middle">문서 번호</th>
				<th scope="col" class="text-center align-middle">품의 제목</th>
				<th scope="col" class="text-center align-middle">부서</th>
				<th scope="col" class="text-center align-middle">기안자</th>
				<th scope="col" class="text-center align-middle">검토자</th>
				<th scope="col" class="text-center align-middle">회수</th>
				<th scope="col" class="text-center align-middle">상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${draftList}" var="draft" varStatus="i" >
				<tr>
					<td class="text-center align-middle table-font-size"><input type="checkbox" /></td>
					<td class="text-center align-middle table-font-size">${draft.docFormName}</td>
					<td class="text-center align-middle table-font-size docNumber">${draft.docNumber}</td>
					<td class="text-center align-middle table-font-size"><button class="btn" data-bs-toggle="modal" data-bs-target="#approvalView-${i.index}" style="font-size: 10pt !important;">${draft.docTitle}</button></td>
					<td class="text-center align-middle table-font-size">${draft.deptName}</td>
					<td class="text-center align-middle table-font-size">${draft.empName}&nbsp;${draft.empPosition}</td>
					<td class="text-center align-middle table-font-size">${draft.reviewingApprover}&nbsp;${draft.reviewingApproverPosition}</td>
					<td class="text-center align-middle"><button class="btn btn-outline-secondary btn-ssm recalled-document">회수</button></td>
					<c:if test="${draft.docAprStatus == '대기'}"><td class="text-center align-middle"><img src="${pageContext.request.contextPath}/resources/image/approval-await.png" width="50px" height="20px" /></td></c:if>
					<c:if test="${draft.docAprStatus == '진행'}"><td class="text-center align-middle"><img src="${pageContext.request.contextPath}/resources/image/approval-doing.png" width="50px" height="20px" /></td></c:if>
					<c:if test="${draft.docAprStatus == '승인'}"><td class="text-center align-middle"><img src="${pageContext.request.contextPath}/resources/image/approval-approve.png" width="50px" height="20px" /></td></c:if>
					<c:if test="${draft.docAprStatus == '반려'}"><td class="text-center align-middle"><img src="${pageContext.request.contextPath}/resources/image/approval-rejected.png" width="50px" height="20px" /></td></c:if>
				</tr>
			</c:forEach>
			<c:if test="${empty draftList}">
				<tr><td colspan="10" class="text-center align-bottom">기안된 문서가 존재하지 않습니다.</td></tr>
			</c:if>
		</tbody>
	</table>
	
	<div class="mt-5 mb-3 d-flex justify-content-center align-items-center w-100">
		<c:if test="${pager.totalRows > 0}">
		<nav class="d-flex justify-content-center" style="width: 95%">
			<ul class="pagination pagination-not-effect justify-content-center pagination-size">
				<li class="page-item ${pager.startPageNo == 1 ? 'disabled' : ''}">
					<a class="page-link page-border-none text-dark" href="submitted?type=submitted&pageNo=${pager.endPageNo-pager.pagesPerGroup}" tabindex="-1" aria-disabled="true"><i class="fa-solid fa-chevron-left"></i></a>
				</li>
				<c:forEach begin="${pager.startPageNo}" end="${pager.endPageNo}" var="i">
					<li class="page-item ${pager.pageNo == i ? 'disabled' : ''}"><a class="page-link text-dark page-border-none ${pager.pageNo==i ? 'fw-bold' : ''} ${i == pager.startPageNo ? 'ms-5' : 'ms-1'} ${i == pager.endPageNo ? 'me-5' : ''}" href="#">${i}</a></li>
				</c:forEach>
				<%-- 
				<li class="page-item"><a class="page-link text-dark page-border-none ms-5" href="#">1</a></li>
				<li class="page-item"><a class="page-link text-dark page-border-none ms-1" href="#">2</a></li>
				<li class="page-item"><a class="page-link text-dark page-border-none ms-1" href="#">3</a></li>
				<li class="page-item"><a class="page-link text-dark page-border-none ms-1" href="#">4</a></li>
				<li class="page-item"><a class="page-link text-dark page-border-none ms-1 me-5" href="#">5</a></li>
				 --%>
				<li class="page-item ${pager.totalPageNo == pager.endPageNo ? 'disabled' : ''}">
					<a class="page-link page-border-none text-dark" href="submitted?type=submitted&pageNo=${pager.endPageNo+1}"><i class="fa-solid fa-chevron-right"></i></a>
				</li>
			</ul>
		</nav>
		<div style="width: 5%;"><button class="btn btn-secondary btn-sm" style="background-color: #C3C3C3; border-color: #C3C3C3;">회수</button></div>
		</c:if>
	</div>
	</c:if>
	
	<%-- 회수 문서 --%>
	<c:if test="${activePage == 'retrieval'}">
	
	<table class="table table-hover table-header-bg">
		<thead>
			<tr>
				<th scope="col" class="text-center align-middle">기안 유형</th>
				<th scope="col" class="text-center align-middle">문서 번호</th>
				<th scope="col" class="text-center align-middle">품의 제목</th>
				<th scope="col" class="text-center align-middle">부서</th>
				<th scope="col" class="text-center align-middle">기안자</th>
				<th scope="col" class="text-center align-middle">재상신</th>
				<th scope="col" class="text-center align-middle">폐기</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${recalledList}" var="draft" varStatus="i" >
				<tr>
					<td class="text-center align-middle table-font-size">${draft.docFormName}</td>
					<td class="text-center align-middle table-font-size docNumber">${draft.docNumber}</td>
					<td class="text-center align-middle table-font-size"><button class="btn" data-bs-toggle="modal" data-bs-target="#approvalView-${i.index}" style="font-size: 10pt !important;">${draft.docTitle}</button></td>
					<td class="text-center align-middle table-font-size">${draft.deptName}</td>
					<td class="text-center align-middle table-font-size">${draft.empName}&nbsp;${draft.empPosition}</td>
					<td class="text-center align-middle"><button class="btn btn-outline-secondary btn-ssm re-draft">재상신</button></td>
					<td class="text-center align-middle"><button class="btn btn-outline-secondary btn-ssm deactivation">폐기</button></td>
				</tr>
			</c:forEach>
			<c:if test="${empty recalledList}">
				<tr><td colspan="10" class="text-center align-bottom">회수 문서가 존재하지 않습니다.</td></tr>
			</c:if>
		</tbody>
	</table>
	
	<div class="mt-5 mb-3 d-flex justify-content-center align-items-center w-100">
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
		<div style="width: 5%;"><button class="btn btn-secondary btn-sm" style="background-color: #C3C3C3; border-color: #C3C3C3;">회수</button></div>
		</c:if>
	</div>
	</c:if>
</section>
<%@ include file="/WEB-INF/views/approval/approvalViewSubmitted.jsp"%>
<%@ include file="/WEB-INF/views/approval/approvalContainerFooter.jsp"%>