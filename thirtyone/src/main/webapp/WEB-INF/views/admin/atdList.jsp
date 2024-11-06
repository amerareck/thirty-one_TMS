<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/atdList.css" />
<div class="content-box">
	<div class="main-container" >
		<p class="title-31">${title}</p>
		<div class="middle-container">
			<p>근태현황</p>
			<div class="search">
				<select class="form-select" id="search-menu" name="holiday-type">
					<option selected>이름</option>
					<option value="1">직급</option>
					<option value="2">부서</option>
				</select>
				<div class="searchBar">
					<input type="text" placeholder=" 이름검색" id="search" autocomplete="off">
					<button type="button" class="btn top-btn">
						<img
							src="${pageContext.request.contextPath}/resources/image/search_icon.png"
							alt="검색 아이콘">
					</button>
				</div>
			</div>
		</div>
		<div class="full-container">
			<table class="table table-hover table-header-bg">
		        <thead>
		          <tr>
		            <th scope="col" class="text-center align-middle">내역</th>
		            <th scope="col" class="text-center align-middle">부서</th>
		            <th scope="col" class="text-center align-middle">직급</th>
		            <th scope="col" class="text-center align-middle">사원명</th>
		            <th scope="col" class="text-center align-middle">출근 시간</th>
		            <th scope="col" class="text-center align-middle">퇴근 시간</th>
		            <th scope="col" class="text-center align-middle">상태</th>
		            <th scope="col" class="text-center align-middle">변경 사유</th>
		            <th scope="col" class="text-center align-middle">변경</th>
		          </tr>
		        </thead>
		        <tbody>
		           <c:forEach items="${reasonList }" var="reason" varStatus="status">
			          <tr>
			            <td class="text-center align-middle table-font-size">${reason.reason.reasonType}</td>
			            <td class="text-center align-middle table-font-size">${reason.deptName}</td>
			            <td class="text-center align-middle table-font-size">${reason.emp.position }</td>
			            <td class="text-center align-middle table-font-size">${reason.emp.empName }</td>
			            <td class="text-center align-middle table-font-size"><fmt:formatDate value='${reason.atd.checkIn}' pattern='yyyy-MM-dd HH:mm'/></td>
			            <td class="text-center align-middle table-font-size"><fmt:formatDate value='${reason.atd.checkOut}' pattern='yyyy-MM-dd HH:mm'/></td>
			            <td class="text-center align-middle table-font-size">${reason.reason.reasonStatus }</td>
			            <td class="text-center align-middle table-font-size">${reason.reason.reasonContent }</td>
			            <td class="text-center align-middle">
			            	<c:if test="${reason.reason.reasonStatus != '승인'}">
			            		<button class="btn" data-bs-toggle="modal" data-bs-target="#atdUpdate${status.index}">변경</button>
			            	</c:if>
		            	</td>
			          </tr>
			          		<!-- Modal -->
						<div class="modal fade" id="atdUpdate${status.index}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
						  <div class="modal-dialog">
						  	<div class="modal-content">
						  		<div class="modal-header">
						    		<p class="mini-title">근태 수정</p>
						    		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					    		</div>
								<div class="mini-line"></div>
								<div class="atd-update-form">
									<div>
										<label for="today">일자</label>
										<input type="text" id="today" name="today" value="<fmt:formatDate value='${reason.atd.atdDate}' pattern='yyyy-MM-dd'/>" disabled>
									</div>
									<div>
										<label for="dept">부서</label>
										<input type="text" id="dept" name="dept" value="${reason.deptName}" disabled>
									</div>
									<div>
										<label for="name">이름</label>
										<input type="text" id="name" name="name" value="${reason.emp.empName }" disabled>
									</div>
									<div>
										<label for="type">구분</label>
										<div class="reason-type">${reason.reason.reasonType}</div>
									</div>
									<div>
										<label for="startTime">출근시간</label>
										<div class="time-box">
											<fmt:formatDate value='${reason.atd.checkIn}' pattern='yyyy-MM-dd HH:mm'/>
										</div>
									</div>
									<div>
										<label for="startTime">퇴근시간</label>
										<div class="time-box"> 
											<fmt:formatDate value='${reason.atd.checkOut}' pattern='yyyy-MM-dd HH:mm'/>
										</div>
									</div>
									<div class="reason-box">
										<label for="reason">사유</label>
										<textarea id="reason" rows="5" disabled>${reason.reason.reasonContent }</textarea>
									</div>
									<div>
										<label for="formFileMultiple" class="form-label">첨부 파일</label>
				 						<div class="file-list">
				 							<c:forEach items="${reason.fileList }" var="file">
				 								<a href="${pageContext.request.contextPath}/atd/attachDownload?fileId=${file.docFileId}">${file.docFileName}</a>
				 							</c:forEach>
				 						</div>
									</div>
									<div class="button-box">
										<button class="button-large" data-bs-dismiss="modal" aria-label="Close">취소</button>
										<button class="button-large accept" data-reasonid="${reason.reason.reasonId}" data-empid="${reason.reason.empId}" data-atddate="<fmt:formatDate value='${reason.atd.checkIn}' pattern='yyyy-MM-dd'  />">승인</button>
									</div>
								</div>
							</div>
						  </div>
						</div>
		            </c:forEach>
		         </tbody>
	        </table>
        	<div class="pagination">
				<c:if test="${pager.groupNo>1}">
					<a href="process?pageNo=${pager.startPageNo-1}"> 
						<img src="${pageContext.request.contextPath}/resources/image/prev_icon.png" alt="prev" style="width: 110px">
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
						<img src="${pageContext.request.contextPath}/resources/image/next_icon.png" alt="next" style="width: 110px">
					</a>
				</c:if>
			</div>
        </div>


<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/admin/atdList.js"></script>
		
<%@ include file="/WEB-INF/views/common/footer.jsp"%>