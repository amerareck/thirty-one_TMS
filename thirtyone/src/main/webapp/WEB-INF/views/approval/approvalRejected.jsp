<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/approval/approvalContainer.jsp"%>
	
<div class="sub-title m-0">
	<div <c:if test="${activePage == 'approve'}">class="sub-title-active"</c:if>><a href="result?type=approve">승인 문서</a></div>
	<div <c:if test="${activePage == 'reject'}">class="sub-title-active"</c:if>><a href="#">반려 문서</a></div>
</div>
<div class="main-line mx-0 mb-5"></div>
<section style="margin: 0 auto;">
    <div class="d-flex justify-content-between align-item-center my-2">
        <div class="w-25 d-flex align-item-center">
            <h5 class="fw-bold" style="margin:auto 0; color:#5A5A5A;">결재 반려 목록</h5>
        </div>
        <div class="input-group approval-search-input-group" style="width: 40%;" data-active-page="${activePage}" data-page-no="${pager.pageNo}" data-url="${urlName}" >
			<select class="form-select form-select-sm select-search-draft" style="flex:1;">
			    <option value="draftTitle" ${paramObj.search == 'draftTitle'?'selected':''}>제목</option>
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
            <th scope="col" class="text-center align-middle">기안자</th>
            <th scope="col" class="text-center align-middle">반려자</th>
            <th scope="col" class="text-center align-middle">반려 일자</th>
            <th scope="col" class="text-center align-middle">재기안</th>
          </tr>
        </thead>
        <tbody>
        <c:forEach items="${draftList}" var="draft" varStatus="i" >
			<tr>
				<td class="text-center align-middle table-font-size">${draft.docFormName}</td>
				<td class="text-center align-middle table-font-size docNumber">${draft.docNumber}</td>
				<td class="text-center align-middle table-font-size"><button class="btn" data-bs-toggle="modal" data-bs-target="#approvalView-${i.index}" style="font-size: 10pt !important;">${draft.docTitle}</button></td>
				<td class="text-center align-middle table-font-size">${draft.deptName}</td>
				<td class="text-center align-middle table-font-size">${draft.empName}&nbsp;${draft.empPosition}</td>
				<td class="text-center align-middle table-font-size">${draft.lastApprover.empName}&nbsp;${draft.lastApprover.position}</td>
				<td class="text-center align-middle table-font-size"><fmt:formatDate value="${draft.docApprovalLine[draft.reviewingApproverSeq].docAprDate}" pattern="yyyy-MM-dd"/></td>
				<c:if test="${activePage == 'approve'}">
					<td class="text-center align-middle"><button class="btn btn-outline-secondary btn-ssm" data-bs-toggle="modal" data-bs-target="#approvalView-${i.index}">열기</button></td>
				</c:if>
				<c:if test="${activePage == 'reject'}" >
					<td class="text-center align-middle"><button class="btn btn-outline-secondary btn-ssm re-draft">재상신</button></td>
				</c:if>
			</tr>
		</c:forEach>
		<c:if test="${empty draftList}">
			<tr><td colspan="10" class="text-center align-bottom">반려된 문서가 존재하지 않습니다.</td></tr>
		</c:if>
        <%-- 
          <tr>
            <td class="text-center align-middle table-font-size">출장 품의서</td>
            <td class="text-center align-middle table-font-size">BST-111-2024-022</td>
            <td class="text-center align-middle table-font-size">10월 21일 워크샵 교육 참여의 건</td>
            <td class="text-center align-middle table-font-size">공공사업1DIV</td>
            <td class="text-center align-middle table-font-size">사원</td>
            <td class="text-center align-middle table-font-size">정원석</td>
            <td class="text-center align-middle table-font-size">유재석 부장</td>
            <td class="text-center align-middle table-font-size">2024-09-28</td>
            <td class="text-center align-middle"><button class="btn btn-outline-secondary btn-ssm">수정</button></td>
          </tr>
          <tr>
            <td class="text-center align-middle table-font-size">근무 신청서</td>
            <td class="text-center align-middle table-font-size">WOT-111-2024-102</td>
            <td class="text-center align-middle table-font-size">9월 19일 연장 근무 신청의 건</td>
            <td class="text-center align-middle table-font-size">공공사업1DIV</td>
            <td class="text-center align-middle table-font-size">사원</td>
            <td class="text-center align-middle table-font-size">정원석</td>
            <td class="text-center align-middle table-font-size">박명수 차장</td>
            <td class="text-center align-middle table-font-size">2024-09-19</td>
            <td class="text-center align-middle"><button class="btn btn-outline-secondary btn-ssm">수정</button></td>
          </tr>
          <tr>
            <td class="text-center align-middle table-font-size">근무 신청서</td>
            <td class="text-center align-middle table-font-size">WOT-111-2024-098</td>
            <td class="text-center align-middle table-font-size">9월 18일 연장 근무 신청의 건</td>
            <td class="text-center align-middle table-font-size">공공사업1DIV</td>
            <td class="text-center align-middle table-font-size">사원</td>
            <td class="text-center align-middle table-font-size">정원석</td>
            <td class="text-center align-middle table-font-size">유재석 부장</td>
            <td class="text-center align-middle table-font-size">2024-09-18</td>
            <td class="text-center align-middle"><button class="btn btn-outline-secondary btn-ssm">수정</button></td>
          </tr>
          <tr>
            <td class="text-center align-middle table-font-size">출장 품의서</td>
            <td class="text-center align-middle table-font-size">BST-111-2024-009</td>
            <td class="text-center align-middle table-font-size">9월 01일 파견 교육 근무 신청의 건</td>
            <td class="text-center align-middle table-font-size">공공사업1DIV</td>
            <td class="text-center align-middle table-font-size">사원</td>
            <td class="text-center align-middle table-font-size">정원석</td>
            <td class="text-center align-middle table-font-size">박명수 차장</td>
            <td class="text-center align-middle table-font-size">2024-08-13</td>
            <td class="text-center align-middle"><button class="btn btn-outline-secondary btn-ssm">수정</button></td>
          </tr>
          <tr>
            <td class="text-center align-middle table-font-size">출장 품의서</td>
            <td class="text-center align-middle table-font-size">BST-111-2024-008</td>
            <td class="text-center align-middle table-font-size">9월 01일 파견 교육 근무 신청의 건</td>
            <td class="text-center align-middle table-font-size">공공사업1DIV</td>
            <td class="text-center align-middle table-font-size">사원</td>
            <td class="text-center align-middle table-font-size">정원석</td>
            <td class="text-center align-middle table-font-size">정준하 과장</td>
            <td class="text-center align-middle table-font-size">2024-08-12</td>
            <td class="text-center align-middle"><button class="btn btn-outline-secondary btn-ssm">수정</button></td>
          </tr>
        --%>
        </tbody>
      </table>

	<c:if test="${search}">
      	<c:if test="${pager.totalRows > 0}">
			<nav class="d-flex justify-content-center" style="width: 95%">
				<ul class="pagination pagination-not-effect justify-content-center pagination-size">
					<li class="page-item ${pager.startPageNo == 1 ? 'disabled' : ''}">
						<a class="page-link page-border-none text-dark" href="result?type=${activePage}&pageNo=${pager.endPageNo-pager.pagesPerGroup-1}&search=${paramObj.search}&keyword=${paramObj.keyword}" tabindex="-1" aria-disabled="true"><i class="fa-solid fa-chevron-left"></i></a>
					</li>
					<c:forEach begin="${pager.startPageNo}" end="${pager.endPageNo}" var="i">
						<li class="page-item ${pager.pageNo == i ? 'disabled' : ''}"><a class="page-link text-dark page-border-none ${pager.pageNo==i ? 'fw-bold' : ''} ${i == pager.startPageNo ? 'ms-5' : 'ms-1'} ${i == pager.endPageNo ? 'me-5' : ''}" href="${pageContext.request.contextPath}/approval/result?type=${activePage}&pageNo=${i}&search=${paramObj.search}&keyword=${paramObj.keyword}">${i}</a></li>
					</c:forEach>
					<li class="page-item ${pager.totalPageNo == pager.endPageNo ? 'disabled' : ''}">
						<a class="page-link page-border-none text-dark" href="result?type=${activePage}&pageNo=${pager.endPageNo+1}&search=${paramObj.search}&keyword=${paramObj.keyword}"><i class="fa-solid fa-chevron-right"></i></a>
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
						<a class="page-link page-border-none text-dark" href="result?type=${activePage}&pageNo=${pager.endPageNo-pager.pagesPerGroup}" tabindex="-1" aria-disabled="true"><i class="fa-solid fa-chevron-left"></i></a>
					</li>
					<c:forEach begin="${pager.startPageNo}" end="${pager.endPageNo}" var="i">
						<li class="page-item ${pager.pageNo == i ? 'disabled' : ''}"><a class="page-link text-dark page-border-none ${pager.pageNo==i ? 'fw-bold' : ''} ${i == pager.startPageNo ? 'ms-5' : 'ms-1'} ${i == pager.endPageNo ? 'me-5' : ''}" href="${pageContext.request.contextPath}/approval/result?type=${activePage}&pageNo=${i}">${i}</a></li>
					</c:forEach>
					<li class="page-item ${pager.totalPageNo == pager.endPageNo ? 'disabled' : ''}">
						<a class="page-link page-border-none text-dark" href="result?type=${activePage}&pageNo=${pager.endPageNo+1}"><i class="fa-solid fa-chevron-right"></i></a>
					</li>
				</ul>
			</nav>
		</c:if>
	</c:if>
</section>
<%@ include file="/WEB-INF/views/approval/approvalViewSubmitted.jsp"%>
<%@ include file="/WEB-INF/views/approval/approvalContainerFooter.jsp"%>