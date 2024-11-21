<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	
<div class="modal" id="selectAltApproverModal" >
	<div class="modal-dialog modal-approval-line modal-dialog-centered">
	    <div class="modal-content">
	        <div class="modal-header">
	            <h3 class="modal-title fw-bold">사원 검색</h3>
	        </div>
	        
	        <div class="modal-body p-3 w-100">
	            <div class="w-100 h-100">
					<div class="w-100 d-flex justify-content-center mb-1">
						<div class="input-group" style="width:98%">
				  			<input type="text" class="form-control" id="searchAltApprover" class="selectEmployeesFromModal" placeholder="사원 검색">
				      		<button class="btn btn-outline-secondary" id="btnSearchAltApprover" style="border-color: #dee2e6;" type="button"><i class="fa-solid fa-magnifying-glass"></i></button>
				  		</div>
				 	</div>
				 	<div class="d-flex p-2 w-100">
				    <!-- 좌측: 조직도 (jstree) -->
				    	<div style="width: 60%">
				        	<div class="tree-container">
				            	<div id="deptEmpListForProxyModal">
				                <!-- jstree -->
				             	</div>
				     		</div>
				     	</div>
				     	<div class="w-50">
				      		<div class="user-select-container w-100">
				          		<select id="selectedEmployeeForProxyModal" class="deptEmployees" multiple="multiple">
				          		</select>
				   			</div>
				       	</div>
				    </div>
				</div>
	        </div>
	        <div class="modal-footer">
				<button type="button" class="btn btn-secondary me-2" style="background-color: #5A5A5A;" data-bs-dismiss="modal" >취소</button>
				<button type="button" class="btn btn-primary me-1" id="btnSelectAltApprover" style="background-color: #1F5FFF;" data-bs-dismiss="modal" >결정</button>
	        </div>
    	</div>
	</div>
</div>