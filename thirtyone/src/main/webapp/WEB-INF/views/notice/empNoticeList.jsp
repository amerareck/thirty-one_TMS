<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<meta name='viewport' content='width=device-width, initial-scale=1'>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/noticeList.css">

<div class="content-box">
	<div class="main-container">
		<p class="title-31">${title}</p>

		<div class="cardBox">

			<div class="listTop">
				<div class="text">써리원의 사내 공지사항을 조회합니다.</div>

				<form action="${pageContext.request.contextPath}/emp/searchNotice"
					method="GET">
					<input type="hidden" value="${pager.pageNo}" name="pageNo">
					<div class="search">
						<div class="searchBar">
							<input type="text" placeholder=" 제목검색" id="enterkeySearch"
								value="${param.noticeTitle}" name="noticeTitle"
								onkeyup="enterkeySearch()" autocomplete="off">
							<button type="submit" class="btn search">
								<img
									src="${pageContext.request.contextPath}/resources/image/search_icon.png"
									alt="검색 아이콘">
							</button>
						</div>
						<button class="btn search" id="searchCancel"
							onclick="clearSearch()">취소</button>
					</div>
				</form>
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
						onclick="location.href='${pageContext.request.contextPath}/notice/empNoticeDetail?noticeId=${notice.noticeId}'">

						<td><c:choose>
								<c:when test="${notice.noticeImportant == '1'}">
									<img
										src="${pageContext.request.contextPath}/resources/image/important_btn.png"
										alt="중요도">
								</c:when>
								<c:otherwise>
						${pager.totalRows - (pager.pageNo-1) * 10 - status.index}
					</c:otherwise>
							</c:choose></td>
						<td>${notice.noticeTitle}</td>
						<td>${notice.empId}</td>
						<td><fmt:formatDate value="${notice.noticeDate}"
								pattern="yyyy-MM-dd HH:mm:ss" /></td>
						<td>${notice.noticeHitCount}</td>
					</tr>
					<tbody class="line"></tbody>
				</table>
			</c:forEach>

			<div class="pagination">
				<!-- 페이징 처리 -->
				<c:choose>
					<c:when test="${pager.pageNo > 1}">
						<a
							href="${pageContext.request.contextPath}/notice/empNoticeList?pageNo=1&noticeTitle=${noticeTitle}">
							<img
							src="${pageContext.request.contextPath}/resources/image/double_prev_icon.png"
							alt="doublePrev" style="width: 20px">
						</a>
						<a
							href="${pageContext.request.contextPath}/notice/empNoticeList?pageNo=${pager.pageNo-1}&noticeTitle=${noticeTitle}">
							<img
							src="${pageContext.request.contextPath}/resources/image/prev_icon.png"
							alt="prev" style="width: 20px; margin-right: 15px;">
						</a>
					</c:when>
				</c:choose>

				<!-- 페이지 번호 출력 -->
				<c:forEach begin="${pager.startPageNo}" end="${pager.endPageNo}"
					var="i">
					<c:choose>
						<c:when test="${i == pager.pageNo}">
							<span style="color: #686868">${i}</span>
						</c:when>
						<c:otherwise>
							<a
								href="${pageContext.request.contextPath}/notice/empNoticeList?pageNo=${i}&noticeTitle=${noticeTitle}"
								style="color: #c7c7c7">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<c:choose>
					<c:when test="${pager.pageNo < pager.totalPageNo}">
						<a
							href="${pageContext.request.contextPath}/notice/empNoticeList?pageNo=${pager.pageNo+1}&noticeTitle=${noticeTitle}">
							<img
							src="${pageContext.request.contextPath}/resources/image/next_icon.png"
							alt="next" style="width: 20px; margin-left: 15px;">
						</a>
						<a
							href="${pageContext.request.contextPath}/notice/empNoticeList?pageNo=${pager.totalPageNo}&noticeTitle=${noticeTitle}">
							<img
							src="${pageContext.request.contextPath}/resources/image/double_next_icon.png"
							alt="next" style="width: 20px">
						</a>
					</c:when>
				</c:choose>
			</div>


			<%@ include file="/WEB-INF/views/common/footer.jsp"%>

			<script>
			document.addEventListener("DOMContentLoaded", function() {
				function enterkeySearch(event) {
					if (window.event.keyCode == 13) {
						event.preventDefault();
						document.querySelector('form').submit();
					}
				}

				document.getElementById("searchCancel").addEventListener("click", (e) => {
					e.preventDefault();
					const inputSearch = document.getElementById("enterkeySearch");
					inputSearch.value = '';
					location.href = "${pageContext.request.contextPath}/notice/empNoticeList?pageNo=1";
				});
			});
		</script>

		</div>
	</div>