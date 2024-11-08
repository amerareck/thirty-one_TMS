<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/alert/alert.css" />
<div class="content-box">
	<div class="main-container" >
		<p class="title-31">${title}</p>
		<div class="holiday-subtitle sub-title">
			<div class="selected-sub-title"><a href="#">읽지않은 알람</a></div>
			<div><a href="#">알람 내역</a></div>  
		</div>
		<button id="alert-check"> 체크 </button>
		<button id="connect"> connect </button>
		<div></div>
		<div class="main-line"></div>
			<div class="full-container">
				<div class="middle-container">
					<div class="search">
						<select class="form-select" id="search-menu" name="holiday-type">
							<option value="0" selected>이름</option>
							<option value="1">직급</option>
							<option value="2">부서</option>
						</select>
					</div>
				</div>
				<div class="alert-list-box">
					<div class="alert-list-table">
					  	<c:forEach begin="1" end="5">
						   <div class="alert-content">
						      <div>
						      	<div class="button-mini apr-state">승인</div>
						      </div>
						      <div >
						      	  <p><span>[근태]10월 27일 근태확인 </span>- 출근 확인 체크를 하지 않으셨습니다. 확인 후 출근 체크를 해주시기 바랍니다.</p>
						      	  <p>2024.10.27</p>
					      	  </div>
						  </div>
				    	</c:forEach>
		    	    </div>
				  	<div class="pagination">
						<c:if test="${pager.groupNo>1}">
							<a href="process?pageNo=${pager.startPageNo-1}"> 
								<img src="${pageContext.request.contextPath}/resources/image/prev_icon.png" alt="prev" style="width: 15px">
							</a>
						</c:if>
						<c:forEach begin="${pager.startPageNo}" end="${pager.endPageNo}" step="1" var="i">
							<c:if test="${pager.pageNo==i}">
								<button class="page-num active"
									onclick="location.href='${pageContext.request.contextPath}/atd/process?pageNo=${i}'"
									style="color: #686868">${i}</button>
							</c:if>
							<c:if test="${pager.pageNo!=i}">
								<button class="page-num"
									onclick="location.href='${pageContext.request.contextPath}/atd/process?pageNo=${i}'">
									${i}</button>
							</c:if>
						</c:forEach>
						<c:if test="${pager.groupNo<pager.totalGroupNo}">
							<a href="process?pageNo=${pager.endPageNo+1}">
								<img src="${pageContext.request.contextPath}/resources/image/next_icon.png" alt="next" style="width: 15px">
							</a>
						</c:if>
					</div>
				</div>
			</div>
		</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<script src="${pageContext.request.contextPath}/resources/js/alert/alert.js"></script>