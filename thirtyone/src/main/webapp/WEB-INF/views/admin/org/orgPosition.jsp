<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/admin/org/orgContainer.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/orgPosition.css" />

<div class="sub-title m-0">
	<div <c:if test="${activePage == 'orgChart'}">class="sub-title-active"</c:if>><a href="org">조직도 관리</a></div>
	<div <c:if test="${activePage == 'position'}">class="sub-title-active"</c:if>><a href="position">직급 관리</a></div>
	<div <c:if test="${activePage == 'employee'}">class="sub-title-active"</c:if>><a href="employee">멤버 관리</a></div>
</div>
<div class="main-line mx-0 mb-5"></div>

<section style="margin: 0 auto;">
	<table class="table table-col-line">
		<thead>
		    <tr>
		      <th scope="col" class="text-start align-middle w-75 table-border-none" >
		      	<div class="fw-bold w-100 ps-4 my-2" style="color: #6B6B6B">직책명</div>
		      </th>
		      <th scope="col" class="text-start align-middle w-25 table-border-none">
		      </th>
		    </tr>
	    </thead>
	    <tbody class="table-font row-height-md">
		    <c:forEach items="${posList}" var="pos">
			    <tr class="table-group-divider td-padding">
					<td class="text-center align-middle table-border-none">
						<div class="d-flex justify-content-between align-items-top td-div-padding">
					  		<div class="d-flex align-items-center" style="color: #6B6B6B">${pos.position}</div>
						</div>
					</td>
					<td class="text-end align-middle p-3table-border-none h-100">
						<div class="d-flex text-center align-items-center h-75 ms-auto" style="width: 60%; color: #6b6b6b;">
							<i class="pos-icon fa-solid fa-caret-up w-25 h-100" data-pos="${pos.positionClass}" style="font-size: 24px;"></i>
							<i class="pos-icon fa-solid fa-caret-down w-25 h-100"  data-pos="${pos.positionClass}"style="font-size: 24px;"></i>
							<i class="pos-icon fas fa-pencil-alt w-25 h-100" data-pos="${pos.positionClass}" style="font-size: 18px;"></i>
							<i class="pos-icon fa-regular fa-trash-can w-25" data-pos="${pos.positionClass}" style="font-size: 18px;"></i>
			      		</div>
			      	</td>
			    </tr>
			 </c:forEach>   
		    <tr class="table-group-divider td-padding">
				<td class="text-center align-middle table-border-none" colspan="2">
					<div class="d-flex justify-content-between align-items-center td-div-padding" style="color: #9f9f9f;">
				  		<input class="add-position" type="text" placeholder="추가할 직책을 입력해주세요.">
			  			<button type="button" class="btn btn-sm add-pos-btn" style="color: #9f9f9f;"><i class="fa-solid fa-plus me-2"></i><span>신규 직책 추가</span></button>
					</div>
				</td>
		    </tr>
		    
	    </tbody>
	</table>
</section>

<script type="text/javascript">
	let contextPath = '${pageContext.request.contextPath}';
</script>
<script src="${pageContext.request.contextPath}/resources/js/admin/orgPosition.js"></script>
<%@ include file="/WEB-INF/views/admin/org/orgContainerFooter.jsp"%>