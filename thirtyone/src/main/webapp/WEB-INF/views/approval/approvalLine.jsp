<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	
<div class="modal" id="approvalLine">
	<div class="modal-dialog modal-approval-line">
	    <div class="modal-content">
	        <div class="modal-header">
	            <h3 class="modal-title fw-bold">결재선 설정</h3>
	        </div>
	        
	        <div class="modal-body px-1 w-100 h-100">
	            <div class="w-100 h-100">
					<div class="w-100 d-flex justify-content-center mb-1">
						<div class="input-group" style="width:98%">
				  			<input type="text" class="form-control" placeholder="멤버 또는 조직 검색">
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
				          		<select multiple>
					              <option value="유재석">유재석 부장</option>
					              <option value="박명수">박명수 차장</option>
					              <option value="정준하">정준하 과장</option>
					              <option value="정형돈">정형돈 과장</option>
					              <option value="노홍철">노홍철 대리</option>
					              <option value="하동훈">하동훈 대리</option>
					              <option value="서지혜">서지혜 사원</option>
					              <option value="엄성현">엄성현 사원</option>
				          		</select>
				   			</div>
				   			<div class="d-flex justify-content-end" style="margin-left: 10px;" >
				  				<button type="button" class="btn btn-secondary btn-sm" style="background-color: #5A5A5A; margin: 7.5px 0" >추가</button>
							</div>
				       	</div>
				    </div>
				</div>

            	<hr style="margin: 20px 0" />

            	<!-- 결재 라인 및 라인 생성 -->
	            <div class="d-flex w-100 h-100">
				    <div class="w-100 p-2">
				        <label for="approval-line" class="form-label fw-bold">결재 라인</label>
				        <div class="d-flex justify-content-start align-items-center mb-2" style="height: 15%">
				            <select id="approval-line" class="form-select w-50 h-100 d-flex align-items-center font-size-small">
				                <option>기본 결재선</option>
				            </select>
				            <div class="input-group ms-1 h-100">
				                <input type="text" class="form-control h-100 d-flex align-items-center font-size-small" placeholder="결재선 이름" aria-label="결재 라인 생성">
				                <button class="btn btn-light h-100 d-flex align-items-center font-size-small" style="border-color: #dee2e6;" type="button">변경</button>
				                <button class="btn btn-light h-100 d-flex align-items-center font-size-small" style="border-color: #dee2e6;" type="button">삭제</button>
				            </div>
				        </div>
				
				        <div class="approval-line-container">
				            <div class="approval-line-item" style="width: 350px">
				                <div>
				                    <i class="fas fa-user pe-2"></i> <b>정준하 과장</b>
				                </div>
				                <div>
				                    <button class="btn btn-sm btn-outline-secondary line-handler-btn"><i class="fas fa-arrow-up"></i></button>
				                    <button class="btn btn-sm btn-outline-secondary line-handler-btn"><i class="fas fa-arrow-down"></i></button>
				                    <button class="btn btn-sm btn-outline-danger line-handler-btn"><i class="fas fa-times"></i></button>
				                </div>
				            </div>
				            <div class="approval-line-item" style="width: 350px">
				                <div>
				                    <i class="fas fa-user pe-2"></i> <b>박명수 차장</b>
				                </div>
				                <div>
				                    <button class="btn btn-sm btn-outline-secondary line-handler-btn"><i class="fas fa-arrow-up"></i></button>
				                    <button class="btn btn-sm btn-outline-secondary line-handler-btn"><i class="fas fa-arrow-down"></i></button>
				                    <button class="btn btn-sm btn-outline-danger line-handler-btn"><i class="fas fa-times"></i></button>
				                </div>
				            </div>
				            <div class="approval-line-item" style="width: 350px">
				                <div>
				                    <i class="fas fa-user pe-2"></i> <b>유재석 부장</b>
				                </div>
				                <div>
				                    <button class="btn btn-sm btn-outline-secondary line-handler-btn"><i class="fas fa-arrow-up"></i></button>
				                    <button class="btn btn-sm btn-outline-secondary line-handler-btn"><i class="fas fa-arrow-down"></i></button>
				                    <button class="btn btn-sm btn-outline-danger line-handler-btn"><i class="fas fa-times"></i></button>
				                </div>
				            </div>
				        </div>
				        <div class="d-flex justify-content-end my-2" style="margin-left: 10px;" >
				  			<button type="button" class="btn btn-secondary btn-sm" style="background-color: #5A5A5A;" >추가</button>
						</div>
					</div>
				</div>
	        </div>

	        <div class="modal-footer">
	            <button type="button" class="btn btn-secondary me-2" style="background-color: #5A5A5A;" >취소</button>
	            <button type="button" class="btn btn-primary me-1" style="background-color: #1F5FFF;" >결정</button>
	        </div>
    	</div>
	</div>
</div>