<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	
<div class="modal" id="approvalLine" >
	<div class="modal-dialog modal-approval-line modal-dialog-centered">
	    <div class="modal-content">
	        <div class="modal-header">
	            <h3 class="modal-title fw-bold">결재선 설정</h3>
	        </div>
	        
	        <div class="modal-body px-1 w-100">
	            <div class="w-100 h-100">
					<div class="w-100 d-flex justify-content-center mb-1">
						<div class="input-group" style="width:98%">
				  			<input type="text" class="form-control" placeholder="사원 검색">
				      		<button class="btn btn-outline-secondary" style="border-color: #dee2e6;" type="button"><i class="fa-solid fa-magnifying-glass"></i></button>
				  		</div>
				 	</div>
				 	<div class="d-flex p-2 w-100">
				    <!-- 좌측: 조직도 (jstree) -->
				    	<div style="width: 60%">
				        	<div class="tree-container">
				            	<div id="orgDepartment">
				                <!-- jstree -->
				             	</div>
				     		</div>
				     	</div>
				     	<div class="w-50">
				      		<div class="user-select-container w-100">
				          		<select id="deptEmployees" multiple>
				          		</select>
				   			</div>
				   			<div class="d-flex justify-content-end" style="margin-left: 10px;" >
				  				<button type="button" class="btn btn-secondary btn-sm" id="approvalLineEmpSelect" style="background-color: #5A5A5A; margin: 7.5px 0" >추가</button>
							</div>
				       	</div>
				    </div>
				</div>

            	<hr style="margin: 20px 0" />

            	<!-- 결재 라인 및 라인 생성 -->
	            <div class="d-flex w-100 h-100">
				    <div class="w-100 p-2">
				    	<div class="d-flex align-items-center justify-content-between">
				        <label for="approval-line" class="form-label fw-bold">결재 라인</label>
				        <div class="d-flex justify-content-start align-items-center mb-2" style="height: 15%">
				            <select id="approval-line" class="form-select d-flex align-items-center font-size-small w-50" style="height: 33.5px;">
				                <option>기본 결재선</option>
				            </select>
				            <div class="input-group ms-1" style="height: 85%">
				                <input type="text" class="form-control d-flex align-items-center font-size-small " style="height: 85%" placeholder="결재선 이름" aria-label="결재 라인 생성">
				                <button class="btn btn-light d-flex align-items-center font-size-small" style="border-color: #dee2e6; height: 33.33px !important;" type="button">변경</button>
				                <button class="btn btn-light d-flex align-items-center font-size-small" style="border-color: #dee2e6; height: 33.33px !important;" type="button">삭제</button>
				            </div>
				        </div>
				    	</div>
				
				        <div class="approval-line-container d-flex flex-column justify-content-center align-items-center" id="approvalLineBox" style="height: 75%">
				            <div class="approval-line-item" data-deptId="111" data-empid="jjh5285" style="width: 85%">
				                <div>
				                    <i class="fas fa-user pe-2"></i> <b class="apl-emp-name">정준하</b> <b class="apl-emp-position">과장</b>
				                </div>
				                <div>
				                    <button class="btn btn-sm btn-outline-secondary line-handler-btn btn-line-up" ><i class="fas fa-arrow-up"></i></button>
				                    <button class="btn btn-sm btn-outline-secondary line-handler-btn btn-line-down" ><i class="fas fa-arrow-down"></i></button>
				                    <button class="btn btn-sm btn-outline-danger line-handler-btn btn-line-remove" ><i class="fas fa-times"></i></button>
				                </div>
				            </div>
				            <div class="approval-line-item" data-deptId="111" data-empid="pms1542" style="width: 85%">
				                <div>
				                    <i class="fas fa-user pe-2"></i> <b class="apl-emp-name">박명수</b> <b class="apl-emp-position">차장</b>
				                </div>
				                <div>
				                    <button class="btn btn-sm btn-outline-secondary line-handler-btn btn-line-up" ><i class="fas fa-arrow-up"></i></button>
				                    <button class="btn btn-sm btn-outline-secondary line-handler-btn btn-line-down" ><i class="fas fa-arrow-down"></i></button>
				                    <button class="btn btn-sm btn-outline-danger line-handler-btn btn-line-remove" ><i class="fas fa-times"></i></button>
				                </div>
				            </div>
				            <div class="approval-line-item" data-deptId="111" data-empid="yjs012" style="width: 85%">
				                <div>
				                    <i class="fas fa-user pe-2"></i> <b class="apl-emp-name">유재석</b> <b class="apl-emp-position">부장</b>
				                </div>
				                <div>
				                    <button class="btn btn-sm btn-outline-secondary line-handler-btn btn-line-up" ><i class="fas fa-arrow-up"></i></button>
				                    <button class="btn btn-sm btn-outline-secondary line-handler-btn btn-line-down" ><i class="fas fa-arrow-down"></i></button>
				                    <button class="btn btn-sm btn-outline-danger line-handler-btn btn-line-remove" ><i class="fas fa-times"></i></button>
				                </div>
				            </div>
				        </div>
				        <div class="d-flex justify-content-end my-2" style="margin-left: 10px;" >
				  			<button type="button" class="btn btn-secondary btn-sm mb-2" style="background-color: #5A5A5A;" >추가</button>
						</div>
					</div>
				</div>
	        </div>
	        <div class="modal-footer">
	            <button type="button" class="btn btn-secondary me-2" style="background-color: #5A5A5A;" data-bs-dismiss="modal" >취소</button>
	            <button type="button" class="btn btn-primary me-1" id="btnApprovalLineSelect" style="background-color: #1F5FFF;" data-bs-dismiss="modal" >결정</button>
	        </div>
    	</div>
	</div>
</div>