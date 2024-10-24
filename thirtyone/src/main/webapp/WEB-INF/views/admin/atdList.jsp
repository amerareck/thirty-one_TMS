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
					<option selected>멤버이름</option>
					<option value="1">종일</option>
					<option value="2">반차</option>
					<option value="3">반반차</option>
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
		           <c:forEach begin="1" end="10">
			          <tr>
			            <td class="text-center align-middle table-font-size">지각</td>
			            <td class="text-center align-middle table-font-size">공공사업1DIV</td>
			            <td class="text-center align-middle table-font-size">사원</td>
			            <td class="text-center align-middle table-font-size">정원석</td>
			            <td class="text-center align-middle table-font-size">2024-10-14 10:12</td>
			            <td class="text-center align-middle table-font-size">-</td>
			            <td class="text-center align-middle table-font-size">미승인</td>
			            <td class="text-center align-middle table-font-size">-</td>
			            <td class="text-center align-middle">
			            	<button class="btn" data-bs-toggle="modal" data-bs-target="#atdUpdate">변경</button>
		            	</td>
			          </tr>
		            </c:forEach>
		         </tbody>
	        </table>
	        	<nav class="mt-5 mb-3">
	               <ul class="pagination justify-content-center">
	                 <li class="page-item disabled">
	                   <a class="page-link text-dark" href="#" tabindex="-1" aria-disabled="true"><img class="arrow-left" src="${pageContext.request.contextPath}/resources/image/arrow/page-left-arrow.svg" width="10px"></a>
	                 </li>
	                 <li class="page-item"><a class="page-link text-dark page-border-none ms-3" href="#">1</a></li>
	                 <li class="page-item"><a class="page-link text-dark page-border-none ms-1" href="#">2</a></li>
	                 <li class="page-item"><a class="page-link text-dark page-border-none ms-1" href="#">3</a></li>
	                 <li class="page-item"><a class="page-link text-dark page-border-none ms-1" href="#">4</a></li>
	                 <li class="page-item"><a class="page-link text-dark page-border-none ms-1 me-3" href="#">5</a></li>
	                 <li class="page-item">
	                   <a class="page-link text-dark mb-4" href="#"><img class="arrow-right" src="${pageContext.request.contextPath}/resources/image/arrow/page-right-arrow.svg" width="10px"></a>
	                 </li>
	               </ul>
	          	</nav>
        </div>
		<!-- Modal -->
		<div class="modal fade" id="atdUpdate" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		  	<div class="modal-content">
		  		<div class="modal-header">
		    		<p class="mini-title">근태 수정</p>
		    		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	    		</div>
				<div class="mini-line"></div>
				<form class="atd-update-form" >
					<div>
						<label for="today">일자</label>
						<input type="text" id="today" name="today" value="2024-10-17" disabled>
					</div>
					<div>
						<label for="dept">부서</label>
						<input type="text" id="dept" name="dept" value="공공사업1DIV" disabled>
					</div>
					<div>
						<label for="name">이름</label>
						<input type="text" id="name" name="name" value="정원석" disabled>
					</div>
					<div>
						<label for="type">구분</label>
						<select class="form-select">
							<option selected>지각</option>
							<option selected>결근</option>
							<option selected>조퇴</option>
						</select>
					</div>
					<div>
						<label for="startTime">출근시간</label>
						<div class="time-box">
							<select class="form-select">
								<c:forEach begin="08" end="18" varStatus="status" >
									<option value="${status.index}">${status.index}</option>					
								</c:forEach>
							</select>
							<span>시</span>
							<input type="number" min="00" max="59" value="12">
							<span>분</span>
						</div>
					</div>
					<div>
						<label for="startTime">퇴근시간</label>
						<div class="time-box">
							<select class="form-select">
									<option value="0" selected> 시간</option>
								<c:forEach begin="09" end="24" varStatus="status" >
									<option value="${status.index}">${status.index}</option>					
								</c:forEach>
							</select>
							<span>시</span>
							<input type="number" min="00" max="59">
							<span>분</span>
						</div>
					</div>
					<div class="reason-box">
						<label for="reason">사유</label>
						<textarea id="reason" rows="5"></textarea>
					</div>
					<div>
						<label for="formFileMultiple" class="form-label">첨부 파일</label>
 						<input class="form-control" type="file" id="formFileMultiple" multiple>
					</div>
					<div class="button-box">
						<button class="button-large" aria-label="Close">취소</button>
						<button class="button-large" type="submit">저장</button>
					</div>
				</form>
			</div>
		  </div>
		</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/admin/atdList.js"></script>
		
<%@ include file="/WEB-INF/views/common/footer.jsp"%>