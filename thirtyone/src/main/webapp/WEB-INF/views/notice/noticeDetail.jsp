<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>


<meta name='viewport' content='width=device-width, initial-scale=1'>


<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/noticeDetail.css">



<div class="cardBox">
	<div class="text">
		써리원의 사내 공지사항을 조회합니다.
		<button type="button" class="btn list"
			onclick="location.href='${pageContext.request.contextPath}/notice/noticeList'">삭제</button>
			<button type="button" class="btn list"
			onclick="location.href='${pageContext.request.contextPath}/notice/noticeWrite'">수정</button>
		<button type="button" class="btn list"
			onclick="location.href='${pageContext.request.contextPath}/notice/noticeList'">목록</button>
	</div>

	<div class="content">
		<div class="line" style="border: 2.5px solid #F0F0F0;"></div>

			<div class="noticeTitle">
				<div class="notice-title">제목
				</div>
				<div class="titleContent">2024년도 6월 성실신고</div>
			</div>
			<div class="line"></div>
			
			
		<div class="noticeLine">	
			<div class="noticeDate">
				<div class="notice-date">작성날짜
				</div>
				<div class="dateContent">2024/06/12</div>
			</div>
			
			<div class="empId">
				<div class="emp-id">작성자
				</div>
				<div class="empContent">오티아이</div>
			</div>	
				
			<div class="hitCount">	
				<div class="hit-count">조회수
				</div>
				<div class="hitCountNumber">5</div>
			</div>	
		</div>				
			<div class="line"></div>


			<div class="noticeTarget">
				<div class="notice-target">공지 대상</div>
				<div class="target">전체</div>
			</div>
			<div class="line"></div>

			<div class="plusFile">
				<div class="plus-file">첨부파일</div>

				<div class="fileContent">없음</div>
			</div>
			
			<div class="line"></div>
			<div class="noticeContent">6월 말까지 종합소득세 신고 및 납부 확인.</div>
			</div>
			
			<div class="line"></div>
			<div class="preTitle" onclick="location.href='${pageContext.request.contextPath}/notice/noticeList'">
				<div class="pre-title" >이전글
				</div>
				<div class="preContent">사옥이전 안내</div>
			</div>
			<div class="line"></div>
			
			<div class="nextTitle" onclick="location.href='${pageContext.request.contextPath}/notice/noticeList'">
				<div class="next-title">다음글
				</div>
				<div class="nextContent">9월 구내식당 메뉴안내</div>
			</div>
			<div class="line" style="border: 2.5px solid #F0F0F0;"></div>


</div>
<script
	src="${pageContext.request.contextPath}/resources/js/notice_write.js"></script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>