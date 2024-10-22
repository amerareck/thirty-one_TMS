<%@ page language="java" contentType="text/html; charset=UTF-8"pageEncoding="UTF-8"%>
	
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결재선 설정</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/themes/default/style.min.css" />
    <link rel="stylesheet" href="../../../resources/css/approval/approvalLine.css" />


</head>
<body>

<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title fw-bold">결재선 설정</h5>
        </div>
        <hr style="margin: 10px 0 10px 0" />
        <div class="modal-body">
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
            <div class="row" style="padding: 10px 13px 10px 7px;">
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

        <div class="modal-footer">
            <button type="button" class="btn btn-secondary me-2" style="background-color: #5A5A5A;" >취소</button>
            <button type="button" class="btn btn-primary me-1" style="background-color: #1F5FFF;" >결정</button>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/jstree.min.js"></script>

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
</body>
</html>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>