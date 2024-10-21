<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	
<div class="sectionContainer d-flex">
	<div class="defaultApprovalLineSetting" style="width: 55%; margin-right: 10px;">
		<div class="card" >
	        <div class="card-body" style=height:850px;>
	        	<div class="d-flex align-item-center justify-content-between ms-1">
	            	<h4 class="fw-bold">기본 결재선 설정</h4>
		        </div>
		        <hr class="my-2" style="border-top: 2px solid" />
		        <div class="approval-container">
		            <div class="row" style="padding: 10px 15px 10px 7px;">
		                <!-- 좌측: 조직도 (jstree) -->
		                <div class="col-6">
		                    <div class="input-group mb-2">
		                        <input type="text" class="form-control" placeholder="멤버 또는 조직 검색">
		                        <button class="btn btn-outline-secondary" style="border-color: #dee2e6;" type="button"><i class="fa-solid fa-magnifying-glass"></i></button>
		                    </div>
		                    
		                    <div class="tree-container">
		                        <div id="jstree-demo">
		                            <!-- jstree -->
		                        </div>
		                    </div>
		                </div>
		                <div class="col-1"></div>
		
		                <div class="col-5 user-select-container">
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
		                <div class="d-flex justify-content-end p-0 mt-2" >
		                    <button type="button" class="btn btn-secondary" style="background-color: #5A5A5A;" >추가</button>
		                </div>
		            </div>
		
		            <hr style="margin: 20px 0" />
		
		            <!-- 결재 라인 및 라인 생성 -->
		            <div class="row my-4" style="padding: 10px 13px 10px 7px;">
		                <div class="col-12 p-0">
		                    <label for="approval-line" class="form-label fw-bold">결재 라인</label>
		                    <div class="d-flex justify-content-start align-items-center mb-2">
		                        <select id="approval-line" class="form-select w-50">
		                            <option>기본 결재선</option>
		                        </select>
		                        <div class="input-group ms-1">
		                            <input type="text" class="form-control" placeholder="결재선 이름, 내용 변경" aria-label="결재 라인 생성">
		                            <button class="btn btn-light" style="border-color: #dee2e6;" type="button">변경</button>
		                            <button class="btn btn-light" style="border-color: #dee2e6;" type="button">삭제</button>
		                        </div>
		                    </div>
		                    
		
		                    <div class="approval-line-container">
		                        <div class="approval-line-item">
		                            <div>
		                                <i class="fas fa-user pe-2"></i> <b>정준하 과장</b>
		                            </div>
		                            <div>
		                                <button class="btn btn-sm btn-outline-secondary"><i class="fas fa-arrow-up"></i></button>
		                                <button class="btn btn-sm btn-outline-secondary"><i class="fas fa-arrow-down"></i></button>
		                                <button class="btn btn-sm btn-outline-danger"><i class="fas fa-times"></i></button>
		                            </div>
		                        </div>
		                        <div class="approval-line-item">
		                            <div>
		                                <i class="fas fa-user pe-2"></i> <b>박명수 차장</b>
		                            </div>
		                            <div>
		                                <button class="btn btn-sm btn-outline-secondary"><i class="fas fa-arrow-up"></i></button>
		                                <button class="btn btn-sm btn-outline-secondary"><i class="fas fa-arrow-down"></i></button>
		                                <button class="btn btn-sm btn-outline-danger"><i class="fas fa-times"></i></button>
		                            </div>
		                        </div>
		                        <div class="approval-line-item">
		                            <div>
		                                <i class="fas fa-user pe-2"></i> <b>유재석 부장</b>
		                            </div>
		                            <div>
		                                <button class="btn btn-sm btn-outline-secondary"><i class="fas fa-arrow-up"></i></button>
		                                <button class="btn btn-sm btn-outline-secondary"><i class="fas fa-arrow-down"></i></button>
		                                <button class="btn btn-sm btn-outline-danger"><i class="fas fa-times"></i></button>
		                            </div>
		                        </div>
		                    </div>
		                </div>
		            </div>
		        </div>
		
		        <div class="d-flex justify-content-end mt-5">
		            <button type="button" class="btn btn-secondary me-2" style="background-color: #5A5A5A;" >취소</button>
		            <button type="button" class="btn btn-primary me-1" style="background-color: #1F5FFF;" >등록</button>
		        </div>
				<script>
				    // jstree
				    $(function() {
				        $('#jstree-demo').jstree({
				            'core' : {
				                'data' : [
				                    {
				                        "text" : "오티아이[OTI]", "icon" : "fa-solid fa-building",
				                        "children" : [
				                            { "text" : "공공사업본부", "icon" : "fas fa-users", 
				                              "children" : [
				                                { "text" : "공공사업Div1.", "icon" : "fas fa-users" },
				                                { "text" : "공공사업Div2.", "icon" : "fas fa-users" },
				                                { "text" : "공공사업Div3.", "icon" : "fas fa-users" }
				                              ]
				                            },
				                            { "text" : "전략사업본부", "icon" : "fas fa-users",
				                                "children" : [
				                                    { "text" : "전략사업Div1.", "icon" : "fas fa-users" },
				                                    { "text" : "전략사업Div2.", "icon" : "fas fa-users" },
				                                    { "text" : "전략사업Div3.", "icon" : "fas fa-users" }
				                                ]
				                             },
				                            { "text" : "경영지원실", "icon" : "fas fa-users",
				                                "children" : [
				                                    { "text" : "인사팀", "icon" : "fas fa-users" },
				                                    { "text" : "재무팀", "icon" : "fas fa-users" }
				                                ]
				                             },
				                            { "text" : "대표이사", "icon" : "fas fa-user" }
				                        ]
				                    }
				                ]
				            },
				            "themes" : {
				                "dots" : false,
				                "icons" : true
				            }
				        });
				    });
				</script>
	        </div>
	    </div>
	</div>
	<div class="proxySetting1" style="width: 45%;">
		<div class="card">
       		<div class="card-body">
            	<h4 class="fw-bold ms-4">대결자 설정</h4>
            	<hr style="border-top: 2px solid" />
            	<div class="p-1">
                	<div class="d-flex">
                    	<h5 class="fw-bold ms-5 col-3">결재 대리자</h5>
                    	<span class="fw-bold col-3 text-body-tertiary">선택되지 않음</span>
                    	<div class="col-2 d-flex justify-content-end">
                        	<button type="button" class="btn btn-primary btn-sm"  style="background-color: #1F5FFF;">선택하기</button>
                    	</div>
                	</div>
               		<hr />
	                <div class="d-flex">
	                    <h5 class="fw-bold ms-5 col-3 my-1">대결 기간</h5>
	                    <div class="d-flex col-5">
	                        <input type="date" id="proxyStartDate" class="form-control" placeholder="ex) 2024-10-01" readonly >
	                        <span class="fw-bold mx-2 mt-2">~</span>
	                        <input type="date" id="proxyEndDate" class="form-control" placeholder="ex) 2024-10-10" readonly >
	                    </div>
	                    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
	                    <script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>
	                    <script>
	                        flatpickr.localize(flatpickr.l10ns.ko);
	                        flatpickr("#proxyStartDate", {
	                            dateFormat: "Y-m-d",
	                            allowInput: true,
	                            conjunction: " ~ "
	                        });
	                        flatpickr("#proxyEndDate", {
	                            dateFormat: "Y-m-d",
	                            allowInput: true
	                        });
	                    </script>
	                </div>
                	<hr />
	                <div class="d-flex">
	                    <h5 class="fw-bold ms-5 col-3 my-1">대결 사유</h5>
	                    <div class="d-flex col-5">
	                        <textarea class="form-control" cols="3"></textarea>
	                    </div>
	                </div>
	                <div class="d-flex justify-content-center mt-4 mb-3">
	                    <button class="btn btn-custom-cancel me-3">취소</button>
	                    <button class="btn btn-custom-confirm">확인</button>
	           		</div>
       			</div>
   			</div>
   		</div>
	</div>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>