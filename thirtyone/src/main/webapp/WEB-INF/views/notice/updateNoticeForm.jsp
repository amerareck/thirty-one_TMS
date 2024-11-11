<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<meta name='viewport' content='width=device-width, initial-scale=1'>

<!-- include libraries(jQuery, bootstrap) -->
<!-- <link
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> -->

<!-- include summernote css/js -->
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote.min.js"></script>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/noticeWriteForm.css">

<div class="content-box">
	<div class="main-container">
		<p class="title-31">${title}</p>

		<div class="cardBox">
			<div class="text">
				써리원의 사내 공지사항을 작성합니다.
				<button type="button" class="btn list"
					onclick="location.href='${pageContext.request.contextPath}/notice/noticeList'">목록</button>
			</div>

			<div class="content">
				<div class="line" style="border: 2.5px solid #F0F0F0;"></div>

				<form id="contentForm" method="POST" action="updateNotice"
					enctype="multipart/form-data">
					<div class="noticeTitle">
						<div class="notice-title">
							<img class="star-icon"
								src="${pageContext.request.contextPath}/resources/image/star_icon.png"
								alt="star" style="width: 9px" />제목
						</div>
						<input type="text" id="titleBox" name="noticeTitle"
							value="${notice.noticeTitle}" />
					</div>
					<div class="line"></div>

					<div class="noticeTarget">
						<div class="notice-target">공지 대상</div>
						<button type="button" class="button-small search" id="deptSearch"
							data-bs-toggle="modal" data-bs-target="#ganadaramabasa">찾기</button>


						<div class="targetBox" id="result">
							<c:choose>
								<c:when test="${empty noticeDeptList}">
								미선택 시, 전체직원에게 공지가 노출됩니다.
								</c:when>
								<c:when test="${not empty noticeDeptList}">
									<c:forEach var="dept" items="${noticeDeptList}">
										<div class="target" style="margin-right: 5px;">${dept.deptId}</div>
									</c:forEach>
								</c:when>
							</c:choose>

						</div>

						<div class="notice-target">중요도</div>
						<div class="custom-select" style="width: 75px;">
							<select class="form-select" id="formSelect"
								name="noticeImportant" required>
								<option value="">선택</option>
								<option value="0">기본</option>
								<option value="1">중요</option>
							</select>
						</div>
					</div>

					<div class="line"></div>

					<div class="plusFile">
						<div class="plus-file">첨부파일</div>

						<div class="fileContent" href="javascript:" id="dropZone">
							<div class="fileBox" id="fileBox">
								<c:choose>
									<c:when test="${not empty noticeFiles}">
										<c:forEach var="noticeFiles" items="${noticeFiles}">
											<c:choose>
												<c:when
													test="${noticeFiles.noticeFileName.endsWith('.jpg') ||
														noticeFiles.noticeFileName.endsWith('.jpeg') ||
														noticeFiles.noticeFileName.endsWith('.png') ||
														noticeFiles.noticeFileName.endsWith('.gif')}">
													<img
														src="attachDownload?noticeFileId=${noticeFile.noticeFileId}"
														width="80">
												</c:when>
												<c:otherwise>
											${noticeFiles.noticeFileName}
											</c:otherwise>
											</c:choose>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<p>
											<img
												src="${pageContext.request.contextPath}/resources/image/plusFile_icon.png"
												alt="plusFile" style="width: 44px" id="preview" /> 마우스로 파일을
											끌어놓으세요.
										</p>
									</c:otherwise>
								</c:choose>
							</div>
							<div class="line file"></div>
							<input type="file" id="uploadFile" class="button-small upload"
								value="내 PC" name="attachFile123" multiple>



						</div>
					</div>

					<div class="line"></div>
					<div class="contentBtn">
						<!-- <div contenteditable="true"> -->
						<textarea id="summernote" name="noticeContent">${notice.noticeContent}</textarea>
					</div>
					<div class="noticeButton">
						<button class="button-medium cancel"
							onclick="location.href='${pageContext.request.contextPath}/notice/noticeDetail?noticeId=${notice.noticeId}'">취소</button>
						<input type="submit" class="button-medium" id="save" name="action"
							value="수정"></input>
					</div>
					<input type="hidden" name="noticeId" value="${notice.noticeId}"
						id="noticeId"> <input type="hidden" name="empId"
						value="${employees.empId}">

					<!-- Modal -->
					<div class="modal fade" id="exampleModal" tabindex="-1"
						aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<div class="modal-title" id="exampleModalLabel">부서 찾기</div>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body" id="modalBody">

									<%-- <c:forEach var="deptName" items="${deptName}">  --%>
									<!-- 체크 -->
									<div class="form-check">
										<input class="form-check-input" type="checkbox" name="deptId"
											value="${dept.deptId}" id="${dept.deptName}"
											onclick="getCheckboxValue()"><label
											class="form-check-label" for="${dept.deptName}"></label>
									</div>
									<%--  </c:forEach> --%>

								</div>
								<div class="modal-footer">
									<button type="button" class="button-medium cancel"
										data-bs-dismiss="modal">취소</button>
									<input type="submit" class="button-medium save"
										onclick="getCheckboxValue()" id="getCheckboxValue" value="확인">
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script
		src="${pageContext.request.contextPath}/resources/js/notice/updateNoticeForm.js"></script>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>