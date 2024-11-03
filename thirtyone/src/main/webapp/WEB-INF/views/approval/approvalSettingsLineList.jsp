<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="d-flex align-items-center justify-content-between">
    <h3 class="fw-bold my-0 p-0" style="width: 40%;">결재선 목록</h3>
    <div class="input-group mt-1" style="width: 50%;">
        <input type="text" class="form-control" style="height: 25px; font-size: .8rem;" placeholder="결재선 검색" aria-label="결재선 검색" />
        <button class="btn btn-outline-secondary d-flex align-items-center" type="button" style="height: 25px !important; font-size: 0.85rem; border-color: #dee2e6;" id="approvalLineSearch"><i class="fa-solid fa-magnifying-glass"></i></button>
    </div>
</div>

<hr class="mt-2 mb-2" style="border-top: 2px solid" />

<table class="table table-hover table-bordered table-font-sm">
    <thead>
        <tr class="align-middle text-center">
            <th scope="col" style="width: 65%">이름</th>
            <th scope="col" style="width: 35%">조회/삭제</th>
        </tr>
    </thead>
    <tbody>
    	<c:forEach items="${empAPL}" var="aplRows">
			<tr class="align-middle text-center">
	            <th scope="row">
	                <span class="text-custom-grey">${aplRows.aprLineName}</span>
	            </th>
	            <td>
	            	<div class="d-flex align-items-center justify-content-center">
	                 <button type="button" class="btn btn-dark btn-sm btn-custom-grey me-1">조회</button>
	                 <button type="button" class="btn btn-secondary btn-sm btn-custom-lightgrey">삭제</button>
	            	</div>
	            </td>
        	</tr>
    	</c:forEach>
        <tr class="align-middle text-center">
            <th scope="row">
                <span class="text-custom-grey">기본결재선1</span>
            <%-- 
                <button type="button" class="btn btn-custom-sm w-100">
                </button>
             --%>
            </th>
            <td>
            	<div class="d-flex align-items-center justify-content-center">
                 <button type="button" class="btn btn-dark btn-sm btn-custom-grey me-1">조회</button>
                 <button type="button" class="btn btn-secondary btn-sm btn-custom-lightgrey">삭제</button>
            	</div>
            </td>
        </tr>
        <tr class="align-middle text-center">
            <th scope="row">
                <span class="text-custom-grey">기본결재선2</span>
            <%-- 
                <button type="button" class="btn btn-custom-sm w-100">
                </button>
            --%>
            </th>
            <td>
            	<div class="d-flex align-items-center justify-content-center">
                 <button type="button" class="btn btn-dark btn-sm btn-custom-grey me-1">조회</button>
                 <button type="button" class="btn btn-secondary btn-sm btn-custom-lightgrey">삭제</button>
            	</div>
            </td>
        </tr>
        <tr class="align-middle text-center">
            <th scope="row">
                <span class="text-custom-grey">기본결재선3</span>
            <%-- 
                <button type="button" class="btn btn-custom-sm w-100">
                </button>
             --%>
            </th>
            <td>
            	<div class="d-flex align-items-center justify-content-center">
                 <button type="button" class="btn btn-dark btn-sm btn-custom-grey me-1">조회</button>
                 <button type="button" class="btn btn-secondary btn-sm btn-custom-lightgrey">삭제</button>
            	</div>
            </td>
        </tr>
    </tbody>
</table>
<nav class="w-100" style="align-self: flex-end;">
    <ul class="pagination pagination-not-effect align-items-center justify-content-center mb-0">
    	<li class="page-item disabled">
    		<a class="pagination-size page-link text-dark page-border-none" href="#" tabindex="-1" aria-disabled="true"><i class="fa-solid fa-chevron-left page-font-size-sm"></i></a>
      	</li>
      	<li class="page-item"><a class="pagination-size page-link text-dark page-border-none page-font-size-sm" href="#">1</a></li>
      	<li class="page-item"><a class="pagination-size page-link text-dark page-border-none page-font-size-sm" href="#">2</a></li>
      	<li class="page-item"><a class="pagination-size page-link text-dark page-border-none page-font-size-sm" href="#">3</a></li>
      	<li class="page-item"><a class="pagination-size page-link text-dark page-border-none page-font-size-sm" href="#">4</a></li>
      	<li class="page-item"><a class="pagination-size page-link text-dark page-border-none page-font-size-sm" href="#">5</a></li>
      	<li class="page-item">
        	<a class="pagination-size page-link text-dark page-border-none" href="#"><i class="fa-solid fa-chevron-right page-font-size-sm"></i></a>
      	</li>
	</ul>
</nav>