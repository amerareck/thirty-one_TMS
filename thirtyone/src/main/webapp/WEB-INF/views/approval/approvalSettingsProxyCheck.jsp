<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<h3 class="fw-bold my-0 p-0">대행 권한</h3>
<hr class="mt-2 mb-2" style="border-top: 2px solid" />
<div class="d-flex align-items-start justify-content-start mt-3 w-100 px-2">
	<h5 class="fw-bold m-0 p-0" style="width: 40%; height: 22px;">부여 권한</h5>
	<c:if test="${empty proxyList}">
	<span class="fw-bold text-dark d-flex justify-content-end" id="proxyAuthority" style="width: 60%; font-size: 0.9rem;">N/A</span>
	</c:if>
	<c:if test="${not empty proxyList}">
	<div class="d-flex flex-column justify-content-start" style="width: 60%; font-size: 0.9rem;">
	<c:forEach items="${proxyList}" var="proxy" varStatus="i">
		<span class="fw-bold text-dark d-flex justify-content-end ${i.index!=proxyList.size() ? 'pb-2' : ''}" style="font-size: 0.9rem;">${i.count})&nbsp;[${proxy.empInfo.deptName}] ${proxy.empInfo.empName} ${proxy.empInfo.position}</span>
	</c:forEach>
	</div>
	</c:if>
	<%--
	<span class="fw-bold text-dark d-flex justify-content-end" style="width: 60%; font-size: 0.9rem;">[공공사업1Div] 박명수 차장</span>
	--%>
</div>
<hr class="my-1 mx-auto" style="width: 97%"/>
<div class="d-flex align-items-start justify-content-between mt-3 w-100 px-2">
	<h5 class="fw-bold m-0 p-0" style="width: 40%; height: 22px;">부여 기간</h5>
	<c:if test="${empty proxyList}">
	<span class="fw-bold text-dark d-flex justify-content-end" id="emptyGrantAuthority"style="width: 60%; font-size: 0.9rem;">N/A</span>
	</c:if>
	<c:if test="${not empty proxyList}">
	<div class="d-flex flex-column">
		<c:forEach items="${proxyList}" var="proxy" varStatus="i" >
			<div class="d-flex align-content-center ${i.index!=proxyList.size() ? 'pb-1' : ''}">
				<span class="fw-bold text-start" style="font-size: 0.9rem;">${i.count})&nbsp;</span>
			  	<span class="text-body-secondary" style="font-size: 0.9rem;"><fmt:formatDate value="${proxy.altAprStartDate}" pattern="yyyy-MM-dd"/></span>
			   	<span class="fw-bold mx-2 text-center" style="font-size: 0.9rem;">~</span>
			   	<span class="text-body-secondary" style="font-size: 0.9rem;"><fmt:formatDate value="${proxy.altAprEndDate}" pattern="yyyy-MM-dd"/></span>
			</div>
		</c:forEach>
	</div>
	</c:if>
</div>
<hr class="my-1 mx-auto" style="width: 97%"/>