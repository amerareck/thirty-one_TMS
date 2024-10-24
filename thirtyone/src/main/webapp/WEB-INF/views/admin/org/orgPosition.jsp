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
		    <tr class="table-group-divider td-padding">
				<td class="text-center align-middle table-border-none">
					<div class="d-flex justify-content-between align-items-top td-div-padding">
				  		<div class="d-flex align-items-center" style="color: #6B6B6B">대표</div>
					</div>
				</td>
				<td class="text-end align-middle p-3table-border-none h-100">
					<div class="d-flex text-center align-items-center h-75 ms-auto" style="width: 60%; color: #6b6b6b;">
						<i class="fa-solid fa-caret-up w-25 h-100" style="font-size: 24px;"></i>
						<i class="fa-solid fa-caret-down w-25 h-100" style="font-size: 24px;"></i>
						<i class="fas fa-pencil-alt w-25 h-100" style="font-size: 18px;"></i>
						<i class="fa-regular fa-trash-can w-25" style="font-size: 18px;"></i>
		      		</div>
		      	</td>
		    </tr>
		    <tr class="table-group-divider td-padding">
				<td class="text-center align-middle table-border-none">
					<div class="d-flex justify-content-between align-items-top td-div-padding">
				  		<div class="d-flex align-items-center" style="color: #6B6B6B">이사</div>
					</div>
				</td>
				<td class="text-end align-middle p-3table-border-none h-100">
					<div class="d-flex text-center align-items-center h-75 ms-auto" style="width: 60%; color: #6b6b6b;">
						<i class="fa-solid fa-caret-up w-25 h-100" style="font-size: 24px;"></i>
						<i class="fa-solid fa-caret-down w-25 h-100" style="font-size: 24px;"></i>
						<i class="fas fa-pencil-alt w-25 h-100" style="font-size: 18px;"></i>
						<i class="fa-regular fa-trash-can w-25" style="font-size: 18px;"></i>
		      		</div>
		      	</td>
		    </tr>
		    <tr class="table-group-divider td-padding">
				<td class="text-center align-middle table-border-none">
					<div class="d-flex justify-content-between align-items-top td-div-padding">
				  		<div class="d-flex align-items-center" style="color: #6B6B6B">부장</div>
					</div>
				</td>
				<td class="text-end align-middle p-3table-border-none h-100">
					<div class="d-flex text-center align-items-center h-75 ms-auto" style="width: 60%; color: #6b6b6b;">
						<i class="fa-solid fa-caret-up w-25 h-100" style="font-size: 24px;"></i>
						<i class="fa-solid fa-caret-down w-25 h-100" style="font-size: 24px;"></i>
						<i class="fas fa-pencil-alt w-25 h-100" style="font-size: 18px;"></i>
						<i class="fa-regular fa-trash-can w-25" style="font-size: 18px;"></i>
		      		</div>
		      	</td>
		    </tr>
		    <tr class="table-group-divider td-padding">
				<td class="text-center align-middle table-border-none">
					<div class="d-flex justify-content-between align-items-top td-div-padding">
				  		<div class="d-flex align-items-center" style="color: #6B6B6B">차장</div>
					</div>
				</td>
				<td class="text-end align-middle p-3table-border-none h-100">
					<div class="d-flex text-center align-items-center h-75 ms-auto" style="width: 60%; color: #6b6b6b;">
						<i class="fa-solid fa-caret-up w-25 h-100" style="font-size: 24px;"></i>
						<i class="fa-solid fa-caret-down w-25 h-100" style="font-size: 24px;"></i>
						<i class="fas fa-pencil-alt w-25 h-100" style="font-size: 18px;"></i>
						<i class="fa-regular fa-trash-can w-25" style="font-size: 18px;"></i>
		      		</div>
		      	</td>
		    </tr>
		    <tr class="table-group-divider td-padding">
				<td class="text-center align-middle table-border-none">
					<div class="d-flex justify-content-between align-items-top td-div-padding">
				  		<div class="d-flex align-items-center" style="color: #6B6B6B">과장</div>
					</div>
				</td>
				<td class="text-end align-middle p-3table-border-none h-100">
					<div class="d-flex text-center align-items-center h-75 ms-auto" style="width: 60%; color: #6b6b6b;">
						<i class="fa-solid fa-caret-up w-25 h-100" style="font-size: 24px;"></i>
						<i class="fa-solid fa-caret-down w-25 h-100" style="font-size: 24px;"></i>
						<i class="fas fa-pencil-alt w-25 h-100" style="font-size: 18px;"></i>
						<i class="fa-regular fa-trash-can w-25" style="font-size: 18px;"></i>
		      		</div>
		      	</td>
		    </tr>
		    <tr class="table-group-divider td-padding">
				<td class="text-center align-middle table-border-none">
					<div class="d-flex justify-content-between align-items-top td-div-padding">
				  		<div class="d-flex align-items-center" style="color: #6B6B6B">대리</div>
					</div>
				</td>
				<td class="text-end align-middle p-3table-border-none h-100">
					<div class="d-flex text-center align-items-center h-75 ms-auto" style="width: 60%; color: #6b6b6b;">
						<i class="fa-solid fa-caret-up w-25 h-100" style="font-size: 24px;"></i>
						<i class="fa-solid fa-caret-down w-25 h-100" style="font-size: 24px;"></i>
						<i class="fas fa-pencil-alt w-25 h-100" style="font-size: 18px;"></i>
						<i class="fa-regular fa-trash-can w-25" style="font-size: 18px;"></i>
		      		</div>
		      	</td>
		    </tr>
		    <tr class="table-group-divider td-padding">
				<td class="text-center align-middle table-border-none">
					<div class="d-flex justify-content-between align-items-top td-div-padding">
				  		<div class="d-flex align-items-center" style="color: #6B6B6B">사원</div>
					</div>
				</td>
				<td class="text-end align-middle p-3table-border-none h-100">
					<div class="d-flex text-center align-items-center h-75 ms-auto" style="width: 60%; color: #6b6b6b;">
						<i class="fa-solid fa-caret-up w-25 h-100" style="font-size: 24px;"></i>
						<i class="fa-solid fa-caret-down w-25 h-100" style="font-size: 24px;"></i>
						<i class="fas fa-pencil-alt w-25 h-100" style="font-size: 18px;"></i>
						<i class="fa-regular fa-trash-can w-25" style="font-size: 18px;"></i>
		      		</div>
		      	</td>
		    </tr>
		    <tr class="table-group-divider td-padding">
				<td class="text-center align-middle table-border-none" colspan="2">
					<div class="d-flex justify-content-start align-items-center td-div-padding" style="color: #9f9f9f;">
						<i class="fa-solid fa-plus"></i>
				  		<button type="button" class="btn btn-sm" style="color: #9f9f9f;">신규 직책 추가</button>
					</div>
				</td>
		    </tr>
		    
	    </tbody>
	</table>
</section>
<%@ include file="/WEB-INF/views/admin/org/orgContainerFooter.jsp"%>