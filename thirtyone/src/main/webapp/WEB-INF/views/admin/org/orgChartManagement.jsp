<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/admin/org/orgContainer.jsp"%>
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
		      <th scope="col" class="text-center align-middle">
		      	<div class="input-group input-group-sm">
		      		<input class="form-control input-text" placeholder="부서" />
		      		<button class="btn btn-outline-secondary btn-sm btn-border"><i class="fas fa-pencil-alt"></i></button>
		      	</div>
		      </th>
		      <th scope="col" class="text-center align-middle">
				<div class="input-group input-group-sm">
					<input class="form-control input-text" placeholder="부서장" />
					<button class="btn btn-outline-secondary btn-sm btn-border"><i class="fas fa-pencil-alt"></i></button>
				</div>
		      </th>
		      <th scope="col" class="text-center align-middle">
				<div class="input-group input-group-sm">
					<input class="form-control input-text" placeholder="부서아이디" />
					<button class="btn btn-outline-secondary btn-sm btn-border"><i class="fas fa-pencil-alt"></i></button>
				</div>
		      </th>
		    </tr>
	    </thead>
	    <tbody class="table-font row-height">
		    <tr class="table-group-divider">
				<td class="text-center align-middle p-2">
					<div class="d-flex justify-content-between align-items-top p-3">
				  		<div class="d-flex align-items-center">공공사업1Div.</div>
				  		<div class="dropdown">
				   			<button class="btn btn-sm border-0 dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
				   				<i class="fas fa-ellipsis-h"></i>
				   			</button>
				   			<ul class="dropdown-menu margin-item-zero">
							    <li>
							    	<div class="d-flex align-items-center justify-content-center p-2">
								    	<i class="fa-solid fa-plus w-25"></i>
								    	<button class="dropdown-item w-75 text-start" type="button">조직 생성</button>
							    	</div>
							    </li>
							    <li>
							    	<div class="d-flex align-items-center justify-content-center p-2">
								    	<i class="fa-solid fa-arrows-rotate w-25"></i>
								    	<button class="dropdown-item w-75 text-start" type="button">조직 순서 변경</button>
								    </div>
							    </li>
							    <li>
							    	<div class="d-flex align-items-center justify-content-center p-2">
								    	<i class="fa-solid fa-square-arrow-up-right w-25 d-flex justify-content-center"></i>
								    	<button class="dropdown-item w-75" type="button">조직 이동</button>
								    </div>
							    </li>
							    <li>
							    	<div class="d-flex align-items-center justify-content-center p-2">
								    	<i class="fas fa-pencil-alt w-25 d-flex justify-content-center"></i>
								    	<button class="dropdown-item w-75" type="button">명칭 변경</button>
								    </div>
							    </li>
							    <li>
							    	<div class="d-flex align-items-center justify-content-center p-2">
								    	<i class="fa-regular fa-trash-can w-25 d-flex justify-content-center"></i>
								    	<button class="dropdown-item w-75" type="button">삭제하기</button>
								    </div>
							    </li>
							</ul>
						</div>
					</div>
				</td>
				<td class="text-center align-middle p-3">
					<div class="d-flex justify-content-between align-items-top">
		      			<div class="d-flex align-items-center">홍길동</div>
			      		<div class="dropdown">
				      		<button class="btn btn-sm border-0 dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
				      			<i class="fas fa-ellipsis-h"></i>
				      		</button>
				      		<ul class="dropdown-menu margin-item-zero">
							    <li>
							    	<div class="d-flex align-items-center justify-content-center p-2">
								    	<i class="fas fa-pencil-alt w-25 d-flex justify-content-center"></i>
								    	<button class="dropdown-item w-75 text-start" type="button">부서장 변경</button>
							    	</div>
							    </li>
							    <li>
							    	<div class="d-flex align-items-center justify-content-center p-2">
								    	<i class="fa-regular fa-trash-can w-25 d-flex justify-content-center"></i>
								    	<button class="dropdown-item w-75 text-start" type="button">삭제하기</button>
							    	</div>
							    </li>
							</ul>		
		      			</div>
		      		</div>
		      	</td>
		      	<td class="text-center align-middle p-3">
					<div class="d-flex justify-content-between align-items-top">
		      			<div class="d-flex align-items-center">001</div>
			      		<div class="dropdown">
				      		<button class="btn btn-sm border-0 dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
				      			<i class="fas fa-ellipsis-h"></i>
				      		</button>
				      		<ul class="dropdown-menu margin-item-zero">
							    <li>
							    	<div class="d-flex align-items-center justify-content-center p-2">
								    	<i class="fas fa-pencil-alt w-25 d-flex justify-content-center"></i>
								    	<button class="dropdown-item w-75 text-start" type="button">부서아이디 변경</button>
							    	</div>
							    </li>
							    <li>
							    	<div class="d-flex align-items-center justify-content-center p-2">
								    	<i class="fa-regular fa-trash-can w-25 d-flex justify-content-center"></i>
								    	<button class="dropdown-item w-75 text-start" type="button">삭제하기</button>
							    	</div>
							    </li>
							</ul>		
		      			</div>
		      		</div>
		      	</td>
		    </tr>
		    <tr class="table-group-divider">
				<td class="text-center align-middle p-2">
					<div class="d-flex justify-content-between align-items-top p-3">
				  		<div class="d-flex align-items-center">공공사업1Div.</div>
				  		<div class="dropdown">
				   			<button class="btn btn-sm border-0 dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
				   				<i class="fas fa-ellipsis-h"></i>
				   			</button>
				   			<ul class="dropdown-menu margin-item-zero">
							    <li>
							    	<div class="d-flex align-items-center justify-content-center p-2">
								    	<i class="fa-solid fa-plus w-25"></i>
								    	<button class="dropdown-item w-75 text-start" type="button">조직 생성</button>
							    	</div>
							    </li>
							    <li>
							    	<div class="d-flex align-items-center justify-content-center p-2">
								    	<i class="fa-solid fa-arrows-rotate w-25"></i>
								    	<button class="dropdown-item w-75 text-start" type="button">조직 순서 변경</button>
								    </div>
							    </li>
							    <li>
							    	<div class="d-flex align-items-center justify-content-center p-2">
								    	<i class="fa-solid fa-square-arrow-up-right w-25 d-flex justify-content-center"></i>
								    	<button class="dropdown-item w-75" type="button">조직 이동</button>
								    </div>
							    </li>
							    <li>
							    	<div class="d-flex align-items-center justify-content-center p-2">
								    	<i class="fas fa-pencil-alt w-25 d-flex justify-content-center"></i>
								    	<button class="dropdown-item w-75" type="button">명칭 변경</button>
								    </div>
							    </li>
							    <li>
							    	<div class="d-flex align-items-center justify-content-center p-2">
								    	<i class="fa-regular fa-trash-can w-25 d-flex justify-content-center"></i>
								    	<button class="dropdown-item w-75" type="button">삭제하기</button>
								    </div>
							    </li>
							</ul>
						</div>
					</div>
				</td>
				<td class="text-center align-middle p-3">
					<div class="d-flex justify-content-between align-items-top">
		      			<div class="d-flex align-items-center">홍길동</div>
			      		<div class="dropdown">
				      		<button class="btn btn-sm border-0 dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
				      			<i class="fas fa-ellipsis-h"></i>
				      		</button>
				      		<ul class="dropdown-menu margin-item-zero">
							    <li>
							    	<div class="d-flex align-items-center justify-content-center p-2">
								    	<i class="fas fa-pencil-alt w-25 d-flex justify-content-center"></i>
								    	<button class="dropdown-item w-75 text-start" type="button">부서장 변경</button>
							    	</div>
							    </li>
							    <li>
							    	<div class="d-flex align-items-center justify-content-center p-2">
								    	<i class="fa-regular fa-trash-can w-25 d-flex justify-content-center"></i>
								    	<button class="dropdown-item w-75 text-start" type="button">삭제하기</button>
							    	</div>
							    </li>
							</ul>		
		      			</div>
		      		</div>
		      	</td>
		      	<td class="text-center align-middle p-3">
					<div class="d-flex justify-content-between align-items-top">
		      			<div class="d-flex align-items-center">001</div>
			      		<div class="dropdown">
				      		<button class="btn btn-sm border-0 dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
				      			<i class="fas fa-ellipsis-h"></i>
				      		</button>
				      		<ul class="dropdown-menu margin-item-zero">
							    <li>
							    	<div class="d-flex align-items-center justify-content-center p-2">
								    	<i class="fas fa-pencil-alt w-25 d-flex justify-content-center"></i>
								    	<button class="dropdown-item w-75 text-start" type="button">부서아이디 변경</button>
							    	</div>
							    </li>
							    <li>
							    	<div class="d-flex align-items-center justify-content-center p-2">
								    	<i class="fa-regular fa-trash-can w-25 d-flex justify-content-center"></i>
								    	<button class="dropdown-item w-75 text-start" type="button">삭제하기</button>
							    	</div>
							    </li>
							</ul>		
		      			</div>
		      		</div>
		      	</td>
		    </tr>
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
<%@ include file="/WEB-INF/views/admin/org/orgContainerFooter.jsp"%>