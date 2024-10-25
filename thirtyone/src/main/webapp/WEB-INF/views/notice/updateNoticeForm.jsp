<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<meta name='viewport' content='width=device-width, initial-scale=1'>


<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/noticeWriteForm.css">

<div class="content-box">
			<div class="main-container" >
				<p class="title-31">${title}</p>

<div class="cardBox">
	<div class="text">
		써리원의 사내 공지사항을 작성합니다.
		<button type="button" class="btn list"
			onclick="location.href='${pageContext.request.contextPath}/notice/noticeList'">목록</button>
	</div>

	<div class="content">
		<div class="line" style="border: 2.5px solid #F0F0F0;"></div>

		<form id="contentForm" method="POST" action="updateNotice" enctype="multipart/form-data">
			<div class="noticeTitle">
				<div class="notice-title">
					<img class="star-icon"
						src="${pageContext.request.contextPath}/resources/image/star_icon.png"
						alt="star" style="width: 9px" />제목
				</div>
				<input type="text" id="titleBox" name="noticeTitle" value="${notice.noticeTitle}"/>
			</div>
			<div class="line"></div>

			<div class="noticeTarget">
				<div class="notice-target" >공지 대상</div>
				<button type="button" class="button-small search"
					data-bs-toggle="modal" data-bs-target="#exampleModal">찾기</button>


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
							<div class="modal-body">

							<%-- <c:forEach var="dept" items="${deptItem}">  --%>
								<!-- 체크 -->
								<div class="form-check">
									<input class="form-check-input" type="checkbox" name="deptId" value="${dept.deptName}"
										id="flexCheckDefault" onclick="getCheckboxValue()"><label class="form-check-label"
										for="flexCheckDefault"></label>
								</div>
							<%-- </c:forEach> --%>

							</div>
							<div class="modal-footer">
								<button type="button" class="button-medium cancel"
									data-bs-dismiss="modal">취소</button>
								<button type="submit" class="button-medium save" onclick="getCheckboxValue()">확인</button>
							</div>
						</div>
					</div>
				</div>



				<div class="targetBox" id="result">미선택 시, 전체직원에게 공지가 노출됩니다.</div>

				<div class="notice-target">중요도</div>
				<div class="custom-select" style="width: 75px;">
					<select class="form-select" id="formSelect" name="noticeImportant" required>
						<%-- <c:choose test="${notice.notieImportant == '0'">
							${notice.noticeImportant}</c:choose> --%>				
						<option value="">선택</option>
						<option value="0">기본</option>
						<option value="1">중요</option>
						<%-- <option value="${notice.noticeImportant} active">${notice.noticeImportant}</option> --%>
					</select>
				</div>
			</div>
			<div class="line"></div>

			<div class="plusFile">
				<div class="plus-file">첨부파일</div>

				<div class="fileContent" href="javascript:" id="dropZone">
						<div class="fileBox">
							<img
								src="${pageContext.request.contextPath}/resources/image/plusFile_icon.png"
								alt="plusFile" style="width: 44px" id="preview" />
							<p>마우스로 파일을 끌어놓으세요.</p>
						</div>
						<div class="line file"></div> <input type="file" id="uploadFile" 
						class="button-small upload" value="내 PC" accept="image/*" name="attachFile" multiple><%-- <img
						src="${pageContext.request.contextPath}/resources/image/upload_icon.png"
						alt="upload" style="width: 18px;" /> --%>
				</div>
			</div>

			<div class="line"></div>
			<div class="contentBtn">
				<!-- <div contenteditable="true"> -->
				<textarea id="editor" name="noticeContent" rows="10" cols="100" style="white-space:pre;">${notice.noticeContent}</textarea>
			</div>
			<div class="noticeButton">
				<button class="button-medium cancel"
					onclick="location.href='${pageContext.request.contextPath}/notice/noticeDetail?noticeId=${notice.noticeId}'">취소</button>
				<input type="submit" class="button-medium" id="save" value="수정"></input>
			</div>
			<input type="text" name="noticeId" value="${notice.noticeId}" style="display:hidden">
	</form>
	</div>
</div>
<script
	src="${pageContext.request.contextPath}/resources/js/noticeWriteForm.js"></script>
<script src="https://cdn.ckeditor.com/4.25.0/standard/ckeditor.js"></script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>