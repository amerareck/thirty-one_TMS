<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<meta name='viewport' content='width=device-width, initial-scale=1'>

<!-- include libraries(jQuery, bootstrap) -->
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote.min.js"></script>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/noticeDetail.css">

<div class="content-box">
	<div class="main-container">
		<p class="title-31">${title}</p>

		<div class="cardBox">
			<div class="text">
				써리원의 사내 공지사항을 조회합니다.
				<button type="button" class="btn list"
					onclick="location.href='${pageContext.request.contextPath}/notice/deleteNotice?noticeId=${notice.noticeId}'">삭제</button>
				<button type="button" class="btn list"
					onclick="location.href='${pageContext.request.contextPath}/notice/updateNoticeForm?noticeId=${notice.noticeId}'">수정</button>
				<button type="button" class="btn list"
					onclick="location.href='${pageContext.request.contextPath}/notice/noticeList'">목록</button>
			</div>

			<div class="content">
				<div class="line" style="border: 2.5px solid #F0F0F0;"></div>

				<div class="noticeTitle">
					<div class="notice-title">제목</div>
					<div class="titleContent">${notice.noticeTitle}</div>
				</div>
				<div class="line"></div>


				<div class="noticeLine">
					<div class="noticeDate">
						<div class="notice-date">작성날짜</div>
						<div class="dateContent">
							<fmt:formatDate value="${notice.noticeDate}"
								pattern="yyyy-MM-dd HH:mm:ss" />
						</div>
					</div>

					<div class="empId">
						<div class="emp-id">작성자</div>
						<div class="empContent">${notice.empId}</div>
					</div>

					<div class="hitCount">
						<div class="hit-count">조회수</div>
						<div class="hitCountNumber">${notice.noticeHitCount}</div>
					</div>
				</div>
				<div class="line"></div>

				<div class="noticeTarget">
					<div class="notice-target">공지 대상</div>
					<c:choose>
						<c:when test="${not empty deptName}">
							<c:forEach var="dept" items="${deptName}" varStatus="status">
								<div class="target" style="margin-right: 5px;">
									${dept}
									<c:if test="${!status.last}">,</c:if>
								</div>
							</c:forEach>

						</c:when>
						<c:otherwise>
							<p>전체</p>
						</c:otherwise>
					</c:choose>
				</div>

				<div class="line"></div>

				<div class="plusFile">
					<div class="plus-file">첨부파일</div>

					<div class="fileContent">
						<c:choose>
							<%-- <c:when test="${not empty noticeFiles}"> --%>
							<c:when test="${not empty noticeFile}">
								<c:forEach var="noticeFile" items="${noticeFile}">
									<c:choose>
										<c:when
											test="${noticeFile.noticeFileName.endsWith('.jpg') ||
														noticeFile.noticeFileName.endsWith('.jpeg') ||
														noticeFile.noticeFileName.endsWith('.png') ||
														noticeFile.noticeFileName.endsWith('.gif')}">
											<img
												src="attachDownload?noticeFileId=${noticeFile.noticeFileId}"
												width="80">
											<p>
												다운로드: <a
													href="attachDownload?noticeFileId=${noticeFile.noticeFileId}"><i
													class="bi bi-download"></i></a>
											</p>
										</c:when>
										<c:otherwise>
											${noticeFile.noticeFileName}
											<p>
												다운로드: <a
													href="attachDownload?noticeFileId=${noticeFile.noticeFileId}"><i
													class="bi bi-download"></i></a>
											</p>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</c:when>

							<c:otherwise>없음</c:otherwise>
						</c:choose>
					</div>
				</div>

				<div class="line"></div>
				<div class="noticeContent">${notice.noticeContent}</div>
			</div>

			<div class="line"></div>
			<div class="prevNext">
				<div class="nextTitle">
					<div class="next-title">다음글</div>
					<c:choose>
						<c:when test="${notice.nextNum == 0}">
							<input type="button" value="다음글이 없습니다."
								onclick="location.href='${pageContext.request.contextPath}/notice/noticeDetail?noticeId=${notice.nextNum}'"
								disabled>
						</c:when>
						<c:otherwise>
							<div class="preContent">
								<input type="button" value="${notice.nextTitle}"
									onclick="location.href='${pageContext.request.contextPath}/notice/noticeDetail?noticeId=${notice.nextNum}'">
							</div>
						</c:otherwise>
					</c:choose>
				</div>

				<div class="preTitle">
					<div class="pre-title">이전글</div>
					<c:choose>
						<c:when test="${notice.prevNum == 0}">
							<input type="button" value="이전글이 없습니다."
								onclick="location.href='${pageContext.request.contextPath}/notice/noticeDetail?noticeId=${notice.prevNum}'"
								disabled>
						</c:when>
						<c:otherwise>
							<div class="preContent">
								<input type="button" value="${notice.prevTitle}"
									onclick="location.href='${pageContext.request.contextPath}/notice/noticeDetail?noticeId=${notice.prevNum}'">
							</div>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="line"></div>

			</div>
			<div class="line" style="border: 2.5px solid #F0F0F0;"></div>


		</div>
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>