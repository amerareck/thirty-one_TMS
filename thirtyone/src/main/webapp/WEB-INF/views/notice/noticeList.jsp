<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<meta name='viewport' content='width=device-width, initial-scale=1'>

<script
	src="${pageContext.request.contextPath}/resources/js/noticeList.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/noticeList.css">
	
	<div class="content-box">
			<div class="main-container" >
				<p class="title">${title}</p>


<div class="cardBox">

	<div class="listTop">
		<div class="text">써리원의 사내 공지사항을 조회합니다.</div>

		<div class="search">
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

	<%-- <c:forEach var="list" items="${noticeList}"> --%>
	<table class="tableContent">
		<tr
			onclick="location.href='${pageContext.request.contextPath}/notice/noticeDetail'">
			<td><img
				src="${pageContext.request.contextPath}/resources/image/important_btn.png"
				alt="중요도"></td>
			<td>2022년도 직장인 건강검진 안내</td>
			<td>오티아이</td>
			<td>2022/10/09</td>
			<td>12</td>
		</tr>
		<tbody class="line"></tbody>

		<tr>
			<td><img
				src="${pageContext.request.contextPath}/resources/image/important_btn.png"
				alt="중요도"></td>
			<td>5월 사내행사 일정 안내</td>
			<td>오티아이</td>
			<td>2023/05/02</td>
			<td>7</td>
		</tr>
		<tbody class="line"></tbody>

		<tr>
			<td>9</td>
			<td>회사 소개자료 공유</td>
			<td>오티아이</td>
			<td>2024/10/17</td>
			<td>4</td>
		</tr>
		<tbody class="line"></tbody>

		<tr>
			<td>8</td>
			<td>9월 구내식당 메뉴안내</td>
			<td>오티아이</td>
			<td>2024/09/17</td>
			<td>0</td>
		</tr>
		<tbody class="line"></tbody>

		<tr>
			<td>7</td>
			<td>2024년도 6월 성실신고</td>
			<td>오티아이</td>
			<td>2024/07/09</td>
			<td>1</td>
		</tr>
		<tbody class="line"></tbody>

		<tr>
			<td>6</td>
			<td>사옥이전 안내</td>
			<td>오티아이</td>
			<td>2024/05/09</td>
			<td>0</td>
		</tr>
		<tbody class="line"></tbody>

		<tr>
			<td>5</td>
			<td>5월 구내식당 메뉴안내</td>
			<td>오티아이</td>
			<td>2024/05/09</td>
			<td>0</td>
		</tr>
		<tbody class="line"></tbody>

		<tr>
			<td>4</td>
			<td>대체공휴일 휴무안내</td>
			<td>오티아이</td>
			<td>2023/05/02</td>
			<td>2</td>
		</tr>
	</table>
	<%-- </c:forEach> --%>

	<button class="button-medium"
		onclick="location.href='${pageContext.request.contextPath}/notice/noticeWrite'">+
		작성하기</button>
		
		
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
