<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/alert/alert.css" />
<div class="content-box">
	<div class="main-container" >
		<p class="title-31">${title}</p>
		<div class="holiday-subtitle sub-title">
			<div><a href="${pageContext.request.contextPath}/alert">읽지않은 알람</a></div>
			<div class="selected-sub-title"><a href="${pageContext.request.contextPath}/alert/list">알람 내역</a></div>  
		</div>
		<div class="main-line"></div>
			<div class="full-container">
				<div class="middle-container">
					<div class="search">
						<select class="form-select" id="search-menu" name="holiday-type">
							<option value="" ${query=="" ? "selected" : ""}>전체</option>
							<option value="atd"  ${query=="atd" ? "selected" : ""} >근태</option>
							<option value="holiday" ${query=="holiday" ? "selected" : ""}>휴가</option>
							<option value="apr" ${query=="apr" ? "selected" : ""}>결재</option>
						</select>
					</div>
				</div>
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
				  	<div class="pagination">
						<c:if test="${pager.groupNo>1}">
							<a href="alert/list?pageNo=${pager.startPageNo-1}&query=${query}"> 
								<img src="${pageContext.request.contextPath}/resources/image/prev_icon.png" alt="prev" style="width: 15px">
							</a>
						</c:if>
						<c:forEach begin="${pager.startPageNo}" end="${pager.endPageNo}" step="1" var="i">
							<c:if test="${pager.pageNo==i}">
								<button class="page-num active"
									onclick="location.href='${pageContext.request.contextPath}/alert/list?pageNo=${i}&query=${query}'"
									style="color: #686868">${i}</button>
							</c:if>
							<c:if test="${pager.pageNo!=i}">
								<button class="page-num"
									onclick="location.href='${pageContext.request.contextPath}/alert/list?pageNo=${i}&query=${query}'">
									${i}</button>
							</c:if>
						</c:forEach>
						<c:if test="${pager.groupNo<pager.totalGroupNo}">
							<a href="alert/list?pageNo=${pager.endPageNo+1}&query=${query}">
								<img src="${pageContext.request.contextPath}/resources/image/next_icon.png" alt="next" style="width: 15px">
							</a>
						</c:if>
					</div>
				</div>
			</div>
		</div>
<script src="${pageContext.request.contextPath}/resources/js/alert/alert.js"></script>
<%-- <%@ include file="/WEB-INF/views/common/footer.jsp" %> --%>