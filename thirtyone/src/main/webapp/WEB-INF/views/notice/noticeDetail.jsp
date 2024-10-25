<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<meta name='viewport' content='width=device-width, initial-scale=1'>


<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/noticeDetail.css">
	
	<div class="content-box">
			<div class="main-container" >
				<p class="title-31">${title}</p>



<div class="cardBox">
	<div class="text">
		써리원의 사내 공지사항을 조회합니다.
		<button type="button" class="btn list"
			onclick="location.href='${pageContext.request.contextPath}/notice/noticeList'">삭제</button>
			<button type="button" class="btn list"
			onclick="location.href='${pageContext.request.contextPath}/notice/updateNoticeForm?noticeId=${notice.noticeId}'">수정</button>
		<button type="button" class="btn list"
			onclick="location.href='${pageContext.request.contextPath}/notice/noticeList'">목록</button>
	</div>

	<div class="content">
		<div class="line" style="border: 2.5px solid #F0F0F0;"></div>

			<div class="noticeTitle">
				<div class="notice-title">제목
				</div>
				<div class="titleContent">${notice.noticeTitle}</div>
			</div>
			<div class="line"></div>
			
			
		<div class="noticeLine">	
			<div class="noticeDate">
				<div class="notice-date">작성날짜
				</div>
				<div class="dateContent">
				<fmt:formatDate value= "${notice.noticeDate}" pattern="yyyy-MM-dd-HH:mm:ss"/>
				</div>
			</div>
			
			<div class="empId">
				<div class="emp-id">작성자
				</div>
				<div class="empContent">${notice.empId}</div>
			</div>	
				
			<div class="hitCount">	
				<div class="hit-count">조회수
				</div>
				<div class="hitCountNumber">${notice.noticeHitCount}</div>
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

				<div class="fileContent">
					<c:choose>
						<c:when test="${noticeFile.noticeFileName != null }">
							<img src= "attachDownload?noticeId=${notice.noticeId}" width="80">
							<p>다운로드: <a href="attachDownload?noticeId=${noticeFile.noticeId}"><i class="bi bi-download"></i></a></p>
						</c:when>
						
						<c:otherwise>없음</c:otherwise>
					</c:choose>	
				</div>
			</div>
			
			<div class="line"></div>
			<div class="noticeContent">${notice.noticeContent}</div>
			</div>
			
			<div class="line"></div>
			<div class="preTitle" onclick="location.href='${pageContext.request.contextPath}/notice/noticeDetail?noticeId=${notice.noticeId-1}'">
				<div class="pre-title" >이전글
				</div>
				<c:choose>
					<c:when test="${notice.noticeId-1 != null}">
						<div class="preContent">${notice.noticeTitle}</div>
					</c:when>
					<c:otherwise>
						이전글이 없습니다.
					</c:otherwise>
				</c:choose>
			</div>
			<div class="line"></div>
			
			
			<div class="nextTitle" onclick="location.href='${pageContext.request.contextPath}/notice/noticeDetail?noticeId=${notice.noticeId+1}'">
				<div class="next-title">다음글
				</div>
				<c:choose>
					<c:when test="${notice.noticeId+1 != null}">
						<div class="preContent">${notice.noticeTitle}</div>
					</c:when>
					<c:otherwise>
						다음글이 없습니다.
					</c:otherwise>
				</c:choose>
			</div>
			<div class="line" style="border: 2.5px solid #F0F0F0;"></div>


</div>
<script
	src="${pageContext.request.contextPath}/resources/js/notice_write.js"></script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>