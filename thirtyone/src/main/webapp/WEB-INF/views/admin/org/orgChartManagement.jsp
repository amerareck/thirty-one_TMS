<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/admin/org/orgContainer.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/orgChart.css" />

<div class="sub-title m-0">
	<div <c:if test="${activePage == 'orgChart'}">class="sub-title-active"</c:if>><a href="org">조직도 관리</a></div>
	<div <c:if test="${activePage == 'position'}">class="sub-title-active"</c:if>><a href="position">직급 관리</a></div>
	<div <c:if test="${activePage == 'employee'}">class="sub-title-active"</c:if>><a href="employee">멤버 관리</a></div>
</div>
<div class="main-line mx-0 mb-5"></div>

<section style="margin: 0 auto;">
	<table class="table table-col-line">
		<thead>
		    <tr>
		      <th scope="col" class="text-center align-middle office-column">
		      	<div class="input-group input-group-sm">
		      		<input class="form-control input-text input-region" placeholder="지사" />
		      		<button class="btn btn-outline-secondary btn-sm btn-border office-btn"><i class="fas fa-pencil-alt"></i></button>
		      	</div>
		      </th>
		      <th scope="col" class="text-center align-middle">
		      	<div class="input-group input-group-sm">
		      		<input class="form-control input-text input-dept-name" placeholder="부서" />
		      		<button class="btn btn-outline-secondary btn-sm btn-border"><i class="fas fa-pencil-alt"></i></button>
		      	</div>
		      </th>
		      <th scope="col" class="text-center align-middle">
				<div class="input-group input-group-sm">
					<input class="form-control input-text input-dept-head" placeholder="부서장" />
					<button class="btn btn-outline-secondary btn-sm btn-border"><i class="fas fa-pencil-alt"></i></button>
				</div>
		      </th>
		      <th scope="col" class="text-center align-middle">
				<div class="input-group input-group-sm">
					<input class="form-control input-text input-dept-id" placeholder="부서아이디" />
					<button class="btn btn-outline-secondary btn-sm btn-border"><i class="fas fa-pencil-alt"></i></button>
				</div>
		      </th>
		      <th scope="col" class="text-center align-middle delte-btn">
				<div class="input-group input-group-sm add-dept-btn">
					<button class="button-medium add-department-btn"><span>+</span> 부서 추가하기</button>
				</div>
		      </th>
		    </tr>
	    </thead>
	    <tbody class="table-font row-height">
	    	
	    	<c:forEach items="#{deptList}" var="dept">
			    <tr class="table-group-divider">
			    	<td class="text-center align-middle office-column">
			    		${dept.regionalOffice}
			    	</td>
					<td class="text-center align-middle">
						<div class="d-flex justify-content-between align-items-top p-3">
					  		<div class="d-flex align-items-center">${dept.deptName}</div>
					  		<div class="dropdown">
					   			<button class="btn btn-sm border-0 dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
					   				<i class="fas fa-ellipsis-h"></i>
					   			</button>
					   			<ul class="dropdown-menu margin-item-zero">
								<!--     <li>
								    	<div class="d-flex align-items-center justify-content-center p-2">
									    	<i class="fa-solid fa-plus w-25"></i>
									    	<button class="dropdown-item w-75 text-start" type="button">조직 생성</button>
								    	</div>
								    </li> -->
	<!-- 							    <li>
								    	<div class="d-flex align-items-center justify-content-center p-2">
									    	<i class="fa-solid fa-arrows-rotate w-25"></i>
									    	<button class="dropdown-item w-75 text-start" type="button">조직 순서 변경</button>
									    </div>
								    </li> -->
								    <li>
								    	<div class="d-flex align-items-center justify-content-center p-2">
									    	<i class="fa-solid fa-square-arrow-up-right w-25 d-flex justify-content-center"></i>
									    	<button class="dropdown-item w-75 text-start dept-move-btn" type="button" data-bs-toggle="modal" data-bs-target="#departMoveModal" data-region="${dept.regionalOffice}" data-deptid="${dept.deptId}">조직 이동</button>
									    </div>
								    </li>
								    <li>
								    	<div class="d-flex align-items-center justify-content-center p-2">
									    	<i class="fas fa-pencil-alt w-25 d-flex justify-content-center"></i>
									    	<button class="dropdown-item w-75 text-start dept-name-btn" type="button" data-bs-toggle="modal" data-bs-target="#deptNameChangeModal"  data-deptname="${dept.deptName}" data-deptid="${dept.deptId}">명칭 변경</button>
									    </div>
								    </li>
<!-- 								    <li>
								    	<div class="d-flex align-items-center justify-content-center p-2">
									    	<i class="fa-regular fa-trash-can w-25 d-flex justify-content-center"></i>
									    	<button class="dropdown-item w-75 text-start" type="button">삭제하기</button>
									    </div>
								    </li> -->
								</ul>
							</div>
						</div>
					</td>
					<td class="text-center align-middle">
						<div class="d-flex justify-content-between align-items-top">
			      			<div class="d-flex align-items-center">${dept.empId }</div>
				      		<div class="dropdown">
					      		<button class="btn btn-sm border-0 dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
					      			<i class="fas fa-ellipsis-h"></i>
					      		</button>
					      		<ul class="dropdown-menu margin-item-zero">
								    <li>
								    	<div class="d-flex align-items-center justify-content-center p-2">
									    	<i class="fas fa-pencil-alt w-25 d-flex justify-content-center"></i>
									    	<button class="dropdown-item w-75 text-start dept-head-btn" type="button" data-bs-toggle="modal" data-bs-target="#deptHeadChangeModal" data-depthead="${dept.empId }" data-deptid="${dept.deptId}">부서장 변경</button>
								    	</div>
								    </li>
								   <!--  <li>
								    	<div class="d-flex align-items-center justify-content-center p-2">
									    	<i class="fa-regular fa-trash-can w-25 d-flex justify-content-center"></i>
									    	<button class="dropdown-item w-75 text-start" type="button">삭제하기</button>
								    	</div>
								    </li> -->
								</ul>		
			      			</div>
			      		</div>
			      	</td>
			      	<td class="text-center align-middle">
						<div class="d-flex justify-content-center align-items-top">
			      			<div class="d-flex text-center align-items-center">${dept.deptId}</div>
<%-- 				부서아이디는 변경되면 안됨	  					      		<div class="dropdown">
					      		<button class="btn btn-sm border-0 dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
					      			<i class="fas fa-ellipsis-h"></i>
					      		</button>
					    		<ul class="dropdown-menu margin-item-zero">
								    <li>
								    	<div class="d-flex align-items-center justify-content-center p-2">
									    	<i class="fas fa-pencil-alt w-25 d-flex justify-content-center"></i>
									    	<button class="dropdown-item w-75 text-start dept-id-btn" type="button" data-bs-toggle="modal" data-bs-target="#deptNumChangeModal" data-deptid="${dept.deptId}">부서아이디 변경</button>
								    	</div>
								    </li>
								   <!--  <li>
								    	<div class="d-flex align-items-center justify-content-center p-2">
									    	<i class="fa-regular fa-trash-can w-25 d-flex justify-content-center"></i>
									    	<button class="dropdown-item w-75 text-start" type="button">삭제하기</button>
								    	</div>
								    </li> -->
								</ul>	 	
			      			</div>--%>
			      		</div> 
			      	</td>
			      	<td class="text-center align-middle delete-btn">
			    		<i class="fa-regular fa-trash-can me-1"></i>
				    	<button class="dropdown-item text-start dept-delete-btn" type="button" data-deptid="${dept.deptId}">삭제하기</button>
			    	</td>
			    </tr>
		    </c:forEach>
	    </tbody>
	</table>

	<nav class="mt-5 mb-3 d-flex justify-content-center">
		<ul class="pagination pagination-not-effect justify-content-center pagination-size">
			<li class="page-item disabled">
				<a class="page-link page-border-none text-dark" href="#" tabindex="-1" aria-disabled="true"><i class="fa-solid fa-chevron-left"></i></a>
			</li>
			<li class="page-item"><a class="page-link text-dark page-border-none ms-5" href="#">1</a></li>
			<li class="page-item"><a class="page-link text-dark page-border-none ms-1" href="#">2</a></li>
			<li class="page-item"><a class="page-link text-dark page-border-none ms-1" href="#">3</a></li>
			<li class="page-item"><a class="page-link text-dark page-border-none ms-1" href="#">4</a></li>
			<li class="page-item"><a class="page-link text-dark page-border-none ms-1 me-5" href="#">5</a></li>
			<li class="page-item">
				<a class="page-link page-border-none text-dark" href="#"><i class="fa-solid fa-chevron-right"></i></a>
			</li>
		</ul>
   	</nav>
</section>


<div class="modal fade" id="departMoveModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
  			<div class="dept-move card">
				<div class="modal-top">
					<p class="mini-title">부서 이동</p>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="mini-line"></div>
				<div class="modal-box">
					<div class="modal-box-in">
						<p class="modal-label">변경전 지사</p>
						<div class="premove pre-office"></div>
					</div>
					<div class="modal-box-in">
						<label class="modal-label">변경후 지사</label>
						<select class="aftermove after-office">
								<option value='서울'>서울</option>
								<option value='세종'>세종</option>
								<option value='진천'>진천</option>
						</select>
					</div>
				</div>
				<div class='button-list'>
					<button class="button-large reject" data-bs-dismiss="modal" aria-label="Close">취소</button>
					<button class="button-large accept move-btn-accept" data-deptid="">변경</button>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="deptNameChangeModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
  			<div class="dept-move card">
				<div class="modal-top">
					<p class="mini-title">명칭 변경</p>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="mini-line"></div>
				<div class="modal-box">
					<div class="modal-box-in">
						<p class="modal-label">변경전 부서명</p>
						<div class="premove pre-dept"></div>
					</div>
					<div class="modal-box-in">
						<label class="modal-label">변경후 부서명</label>
						<input class="aftermove after-dept" placeholder="변경하실 부서명을 입력해주세요.">	
					</div>
				</div>
				<div class='button-list'>
					<button class="button-large reject" data-bs-dismiss="modal" aria-label="Close">취소</button>
					<button class="button-large accept dept-name-change-btn" data-deptid="">변경</button>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="deptHeadChangeModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
  			<div class="dept-move card">
				<div class="modal-top">
					<p class="mini-title">부서장 변경</p>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="mini-line"></div>
				<div class="modal-box">
					<div class="modal-box-in">
						<p class="modal-label">변경전 부서장</p>
						<div class="premove pre-dept-head"></div>
					</div>
					<div class="modal-box-in">
						<label class="modal-label">변경후 부서장</label>
						<input class="aftermove after-dept-head" placeholder="부서장을 입력해주세요.">	
					</div>
				</div>
				<div class='button-list'>
					<button class="button-large reject" data-bs-dismiss="modal" aria-label="Close">취소</button>
					<button class="button-large accept dept-head-change-btn" data-deptid="">변경</button>
				</div>
			</div>
		</div>
	</div>
</div>

<%-- <div class="modal fade" id="deptNumChangeModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
  			<div class="dept-move card">
  				<div class="modal-top">
					<p class="mini-title">부서 아이디 변경</p>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="mini-line"></div>
				<div class="modal-box">
					<div class="modal-box-in">
						<p class="modal-label">변경전 부서아이디</p>
						<div class="premove pre-dept-id"></div>
					</div>
					<div class="modal-box-in">
						<label class="modal-label">변경후 부서아이디</label>
						<input class="aftermove after-dept-id" placeholder="부서ID를 입력해주세요.">	
					</div>
				</div>
				<div class='button-list'>
					<button class="button-large reject" data-bs-dismiss="modal" aria-label="Close">취소</button>
					<button class="button-large accept dept-id-change-btn" data-deptid="">변경</button>
				</div>
			</div>
		</div>
	</div>
</div> --%>

<script type="text/javascript">
	const contextPath = '${pageContext.request.contextPath}';
</script>
<script src="${pageContext.request.contextPath}/resources/js/admin/orgChart.js"></script>
<%@ include file="/WEB-INF/views/admin/org/orgContainerFooter.jsp"%>

