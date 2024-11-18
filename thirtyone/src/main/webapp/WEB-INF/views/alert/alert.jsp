<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/alert/alert.css" />
    
<div class="content-box">
	<div class="main-container" >
		<p class="title-31">${title}</p>
		<div class="holiday-subtitle sub-title">
			<div class="selected-sub-title"><a href="${pageContext.request.contextPath}/alert">읽지않은 알람</a></div>
			<div><a href="${pageContext.request.contextPath}/alert/list">알람 내역</a></div>  
		</div>
		<div></div>
		<div class="main-line"></div>
			<div class="full-container">
				<c:if test="${alertList != null && alertList.size() > 0}">
					<div class="alert-list-box">
						<div class="alert-list-table">
						  	<c:forEach items="${alertList}" var="alert">
							   <div class="alert-content">
							      <div>
							      	<c:choose>
							      		<c:when test="${alert.alertType == '결재'}">
							      			<div class="button-mini apr-state">${alert.alertType}</div>
							      		</c:when>
							      		<c:when test="${alert.alertType == '근태'}">
							      			<div class="button-mini attendance-state">${alert.alertType}</div>
							      		</c:when>
							      		<c:otherwise>
							      			<div class="button-mini holiday-state">${alert.alertType}</div>						      		
							      		</c:otherwise>
							      	</c:choose>
							      </div>
							      <div >
							      	  <p><span>[${alert.alertType}]</span>- ${alert.alertContent }</p>
							      	  <p><fmt:formatDate value="${alert.alertTime}" pattern="yyyy-MM-dd HH:mm" /></p>
						      	  </div>
							  </div>
					    	</c:forEach>
			    	    </div>
<!-- 					  	<div class="pagination"> -->
<%-- 							<c:if test="${pager.groupNo>1}"> --%>
<%-- 								<a href="${pageContext.request.contextPath}/alert?pageNo=${pager.startPageNo-1}">  --%>
<%-- 									<img src="${pageContext.request.contextPath}/resources/image/prev_icon.png" alt="prev" style="width: 15px"> --%>
<!-- 								</a> -->
<%-- 							</c:if> --%>
<%-- 							<c:forEach begin="${pager.startPageNo}" end="${pager.endPageNo}" step="1" var="i"> --%>
<%-- 								<c:if test="${pager.pageNo==i}"> --%>
<!-- 									<button class="page-num active" -->
<%-- 										onclick="location.href='${pageContext.request.contextPath}/alert?pageNo=${i}'" --%>
<%-- 										style="color: #686868">${i}</button> --%>
<%-- 								</c:if> --%>
<%-- 								<c:if test="${pager.pageNo!=i}"> --%>
<!-- 									<button class="page-num" -->
<%-- 										onclick="location.href='${pageContext.request.contextPath}/alert?pageNo=${i}'"> --%>
<%-- 										${i}</button> --%>
<%-- 								</c:if> --%>
<%-- 							</c:forEach> --%>
<%-- 							<c:if test="${pager.groupNo<pager.totalGroupNo}"> --%>
<%-- 								<a href="${pageContext.request.contextPath}/alert?pageNo=${pager.endPageNo+1}"> --%>
<%-- 									<img src="${pageContext.request.contextPath}/resources/image/next_icon.png" alt="next" style="width: 15px"> --%>
<!-- 								</a> -->
<%-- 							</c:if> --%>
<!-- 						</div> -->
					</div>
				</c:if>
				<c:if test="${alertList == null || alertList.size() == 0}">
				</c:if>
			</div>
		</div>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<script src="${pageContext.request.contextPath}/resources/js/alert/alert.js"></script>