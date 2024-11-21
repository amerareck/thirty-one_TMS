<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="/WEB-INF/views/approval/approvalContainer.jsp" %>
	
<div class="sub-title m-0">
    <div class="${activePage == 'ready' ? 'sub-title-active' : ''}"><a href="approveList?type=ready">결재 대기</a></div>
    <div class="${activePage == 'all' ? 'sub-title-active' : ''}"><a href="approveList?type=all">전체 결재 목록</a></div>
</div>
<div class="main-line mx-0 mb-5"></div>

<section style="margin: 0 auto;">
	<div class="d-flex justify-content-between align-item-center my-2">
	    <div class="w-25 d-flex align-item-center">
	        <h5 class="fw-bold" style="margin:auto 0; color:#5A5A5A;">${sectionTitle}</h5>
	    </div>
	    <div class="input-group approval-search-input-group" style="width: 40%;" data-active-page="${activePage}" data-page-no="${pager.pageNo}" data-url="${urlName}" >
			<select class="form-select form-select-sm select-search-draft" style="flex:1;">
			    <option value="draftTitle" ${paramObj.search == 'draftTitle'?'selected':''}>제목</option>
			    <option value="draftAuthor" ${paramObj.search == 'draftAuthor'?'selected':''} >기안자</option>
			    <option value="draftType" ${paramObj.search == 'draftType'?'selected':''} >기안 유형</option>
			    <option value="draftState" ${paramObj.search == 'draftState'?'selected':''} >기안 상태</option>
			    <c:if test="${activePage == 'referenceDoc'}">
			    <option value="draftDept" ${paramObj.search == 'draftDept'?'selected':''} >기안 부서</option>
			    </c:if>
			</select>
			<c:if test="${paramObj.search == 'draftTitle' || empty paramObj.search}">
				<input class="form-control col-8 input-search-draft draft-title" value="${paramObj.keyword}" placeholder="검색 유형 입력" style="flex:3;" />
			</c:if>
			<c:if test="${paramObj.search == 'draftType'}">
				<select class="form-select form-select-sm col-8 input-search-draft draft-type" style="flex: 3;">
					<option value="근태신청서" ${paramObj.keyword == '근태신청서'?'selected':''}>근태신청서</option>
					<option value="출장품의서" ${paramObj.keyword == '출장품의서'?'selected':''}>출장품의서</option>
					<option value="출장보고서" ${paramObj.keyword == '출장보고서'?'selected':''}>출장보고서</option>
					<option value="휴일근무신청서" ${paramObj.keyword == '휴일근무신청서'?'selected':''}>휴일근무신청서</option>
					<option value="연장근무신청서" ${paramObj.keyword == '연장근무신청서'?'selected':''}>연장근무신청서</option>
				</select>
			</c:if>
			<c:if test="${paramObj.search == 'draftState'}">
				<select class="form-select form-select-sm col-8 input-search-draft draft-state" style="flex: 3;">
					<option value="대기" ${paramObj.keyword == '대기'?'selected':''}>&nbsp;&nbsp;대기</option>
					<option value="진행" ${paramObj.keyword == '진행'?'selected':''}>&nbsp;&nbsp;진행</option>
					<option value="승인" ${paramObj.keyword == '승인'?'selected':''}>&nbsp;&nbsp;승인</option>
					<option value="반려" ${paramObj.keyword == '반려'?'selected':''}>&nbsp;&nbsp;반려</option>
				</select>
			</c:if>
			<c:if test="${paramObj.search == 'draftAuthor'}">
				<input class="form-control col-8 input-search-draft draft-author" value="${paramObj.keyword}" placeholder="검색 유형 입력" style="flex:3;" />
			</c:if>
			<c:if test="${paramObj.search == 'draftDept'}">
				<select class="form-select form-select-sm col-8 input-search-draft draft-dept" style="flex: 3;">
					<option value="" disabled="disabled" >&nbsp;&nbsp;부서 선택</option>
				</select>
				<span class="d-none">${paramObj.keyword}</span>
			</c:if>
			<button class="btn btn-outline-secondary btnApprovalSearch" style="border-color: #dee2e6;" type="button"><i class="fa-solid fa-magnifying-glass"></i></button>
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
	        <th scope="col" class="text-center align-middle">${activePage == 'ready' ? '결재' : '열람'}</th>
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
						<c:if test="${activePage == 'ready'}"><td class="text-center align-middle"><button class="btn btn-outline-secondary btn-ssm" data-bs-toggle="modal" data-bs-target="#approvalContext-${i.index}">결재</button></td></c:if>
						<c:if test="${activePage == 'all'}"><td class="text-center align-middle"><button class="btn btn-outline-secondary btn-ssm" data-bs-toggle="modal" data-bs-target="#approvalView-${i.index}">열기</button></td></c:if>
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
	<c:if test="${search}">
      	<c:if test="${pager.totalRows > 0}">
			<nav class="d-flex justify-content-center" style="width: 95%">
				<ul class="pagination pagination-not-effect justify-content-center pagination-size">
					<li class="page-item ${pager.startPageNo == 1 ? 'disabled' : ''}">
						<a class="page-link page-border-none text-dark" href="approveList?type=${activePage}&pageNo=${pager.endPageNo-pager.pagesPerGroup-1}&search=${paramObj.search}&keyword=${paramObj.keyword}" tabindex="-1" aria-disabled="true"><i class="fa-solid fa-chevron-left"></i></a>
					</li>
					<c:forEach begin="${pager.startPageNo}" end="${pager.endPageNo}" var="i">
						<li class="page-item ${pager.pageNo == i ? 'disabled' : ''}"><a class="page-link text-dark page-border-none ${pager.pageNo==i ? 'fw-bold' : ''} ${i == pager.startPageNo ? 'ms-5' : 'ms-1'} ${i == pager.endPageNo ? 'me-5' : ''}" href="${pageContext.request.contextPath}/approval/approveList?type=${activePage}&pageNo=${i}&search=${paramObj.search}&keyword=${paramObj.keyword}">${i}</a></li>
					</c:forEach>
					<li class="page-item ${pager.totalPageNo == pager.endPageNo ? 'disabled' : ''}">
						<a class="page-link page-border-none text-dark" href="approveList?type=${activePage}&pageNo=${pager.endPageNo+1}&search=${paramObj.search}&keyword=${paramObj.keyword}"><i class="fa-solid fa-chevron-right"></i></a>
					</li>
				</ul>
			</nav>
		</c:if>
    </c:if>
	<c:if test="${empty search}">
		<c:if test="${pager.totalRows > 0}">
			<nav class="d-flex justify-content-center" style="width: 95%">
				<ul class="pagination pagination-not-effect justify-content-center pagination-size">
					<li class="page-item ${pager.startPageNo == 1 ? 'disabled' : ''}">
						<a class="page-link page-border-none text-dark" href="approveList?type=${activePage}&pageNo=${pager.endPageNo-pager.pagesPerGroup-1}" tabindex="-1" aria-disabled="true"><i class="fa-solid fa-chevron-left"></i></a>
					</li>
					<c:forEach begin="${pager.startPageNo}" end="${pager.endPageNo}" var="i">
						<li class="page-item ${pager.pageNo == i ? 'disabled' : ''}"><a class="page-link text-dark page-border-none ${pager.pageNo==i ? 'fw-bold' : ''} ${i == pager.startPageNo ? 'ms-5' : 'ms-1'} ${i == pager.endPageNo ? 'me-5' : ''}" href="${pageContext.request.contextPath}/approval/approveList?type=${activePage}&pageNo=${i}">${i}</a></li>
					</c:forEach>
					<li class="page-item ${pager.totalPageNo == pager.endPageNo ? 'disabled' : ''}">
						<a class="page-link page-border-none text-dark" href="approveList?type=${activePage}&pageNo=${pager.endPageNo+1}"><i class="fa-solid fa-chevron-right"></i></a>
					</li>
				</ul>
			</nav>
		</c:if>
	</c:if>
	
</section>

<c:if test="${activePage == 'ready'}">
<%@ include file="/WEB-INF/views/approval/approvalContext.jsp" %>
</c:if>
<c:if test="${activePage == 'all'}">
<%@ include file="/WEB-INF/views/approval/approvalViewSubmitted.jsp" %>
</c:if>
<%@ include file="/WEB-INF/views/approval/approvalContainerFooter.jsp" %>