<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<meta name='viewport' content='width=device-width, initial-scale=1'>

<script
	src="${pageContext.request.contextPath}/resources/js/noticeList.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/noticeList.css">
	
	<div class="content-box">
			<div class="main-container" >
				<p class="title-31">${title}</p>


<div class="cardBox">

	<div class="listTop">
		<div class="text">써리원의 사내 공지사항을 조회합니다.</div>

		<div class="search">
			<!-- <div id="choiceDay" class="flatpickr-input" readonly="readonly" value="연도-월-일">
			<img src="/thirtyone/resources/image/calendar-icon.svg"></div> -->
			<input type="date" id="date" min="1994-01-01" max="2077-12-31"
				value="연도-월-일">

			<div class="searchBar">
				<input type="text" placeholder=" 이름검색" id="search"
					onkeyup="enterkeySearch()" autocomplete="off">
				<button type="button" class="btn search">
					<img
						src="${pageContext.request.contextPath}/resources/image/search_icon.png"
						alt="검색 아이콘">
				</button>
			</div>
			<%-- <input type="hidden" name="empId" value="${notice.empId}"> --%>
		</div>
	</div>

	<div class="line"></div>
	<table class="tableTitle">
		<tr>
			<td>번호</td>
			<td>제목</td>
			<td>작성자</td>
			<td>작성날짜</td>
			<td>조회수</td>
		</tr>

	</table>

	<div class="line" style="border: 2.5px solid #F0F0F0;"></div>

	<c:forEach var="notice" items="${notice}">
	
	<table class="tableContent">
		<tr
			onclick="location.href='${pageContext.request.contextPath}/notice/noticeDetail?noticeId=${notice.noticeId}'">
			
			<td>
				<c:choose>
					<c:when test="${notice.noticeImportant == '1'}">
						<img
						src="${pageContext.request.contextPath}/resources/image/important_btn.png" alt="중요도" >
					</c:when>
					<c:otherwise>
						${notice.noticeId}
					</c:otherwise>
				</c:choose></td>
			<td>${notice.noticeTitle}</td>
			<td>${notice.empId}</td>
			<td><fmt:formatDate value= "${notice.noticeDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<td>${notice.noticeHitCount}</td>
		</tr>
		<tbody class="line"></tbody>
	</table>
	</c:forEach>

	<button class="button-medium"
		onclick="location.href='${pageContext.request.contextPath}/notice/noticeWriteForm'">+
		작성하기</button>
		
		<div class="pagination">
			<a href="noticeList?pageNo=1">
				<img src="${pageContext.request.contextPath}/resources/image/prev_icon.png" alt="prev" style="width:110px">
			</a>
			
			<c:if test="${pager.groupNo>1}">
				<a href="noticeList?pageNo=${pager.startPageNo-1}">이전</a>			
			</c:if>	
			
			<c:forEach begin="${pager.startPageNo}" end="${pager.endPageNo}" step="1" var="i">
				<c:if test="${pager.pageNo==i}">
					<button class="page-num active" onclick="location.href='${pageContext.request.contextPath}/notice/noticeList?pageNo=${i}'" style="color:#686868">
						${i}
					</button>	
				</c:if>
				<c:if test="${pager.pageNo!=i}">
					<button class="page-num" onclick="location.href='${pageContext.request.contextPath}/notice/noticeList?pageNo=${i}'">
						${i}
					</button>
				</c:if>
		</c:forEach>
		
		<c:if test="${pager.groupNo<pager.totalGroupNo}">
			<a href="noticeList?pageNo=${pager.endPageNo+1}">다음</a>
		</c:if>
		
		<a href="noticeList?pageNo=${pager.totalPageNo}">
			<img src="${pageContext.request.contextPath}/resources/image/next_icon.png" alt="next" style="width:110px">
		</a>
		
		</div>
		
		
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
