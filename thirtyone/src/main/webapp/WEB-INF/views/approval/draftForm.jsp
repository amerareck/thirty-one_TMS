<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>	
<div class="sectionContainer" style="width: 100%">
	<div class="card">
        <div class="card-body p-4">
        	<form action="#" method="post" enctype="multipart/form-data">
	            <div class="d-flex align-items-top justify-content-between mb-4">
	                <div class="d-flex align-items-top" style="width: 60%;">
	                	<label for="documentForm" class="fw-bold mt-2" style="width: 25%;">결재 양식</label>
	                    <select class="form-select" id="documentForm" style="width: 75%; height: 37.78px">
	                        <option selected>결재 양식 선택</option>
	                        <option value="HLD">근태 신청서(휴가)</option>
	                        <option value="BST">출장 신청서</option>
	                        <option value="BTR">출장 복명서</option>
	                        <option value="HLW">휴일근무 신청서</option>
	                        <option value="WOT">연장근무신청서</option>
                    	</select>
	                </div>
	                <div class="d-flex flex-column align-items-top" style="width: 40%;">
	                	<div class="d-flex align-items-center w-100 mb-3">
		                    <label for="dateOfHoliday" class="fw-bold mb-2" style="width: 25%; margin-left: 20px">신청 기간</label>
		                    <div id="dateOfHoliday" class="d-flex align-items-center" style="width: 75%;">
							   <input type="date" id="holidayStartDate" class="form-control p-2" style="height: 35px; font-size: 0.9rem;" placeholder="휴가 시작일" readonly >
							   <span class="fw-bold mx-2">~</span>
							   <input type="date" id="holidayEndDate" class="form-control p-2" style="height: 35px; font-size: 0.9rem;" placeholder="휴가 종료일" readonly >
							</div>
	                	</div>
	                	<div class="d-flex align-items-center w-100">
	                		<label for="holidayType" class="fw-bold mb-2" style="width: 25%; margin-left: 20px">휴가 유형</label>
	                		<select id="holidayType" class="form-select" style="width: 75%;">
	                			<option value="familyEvent">경조사</option>
	                			<option value="childbirth">출산</option>
	                			<option value="sickLeave">병가</option>
	                		</select>
	                	</div>
	                </div>
	            </div>
	            <div class="d-flex mb-4">
	                <div class="d-flex align-items-center" style="width: 60%;">
	                    <label for="draftTitle" class="fw-bold mb-2" style="width: 30%; margin-right:2px;">제목</label>
	                    <input type="text" class="form-control" id="draftTitle" style="width: 90%;" />
	                </div>
	            </div>
	            <div class="d-flex mb-4">
	                <div style="width:15%;">
	                    <label for="draftReferrer" class="fw-bold mb-2 mt-2">참조자</label>
	                </div>
	                <div class="d-flex align-items-top" style="width: 85%;">
	                    <div class="me-3" style="width: 25%;">
	                        <select class="form-select" id="draftDepartmentSelect">
	                            <option selected>부서 선택</option>
	                            <option value="department-1">공공사업1Div</option>
	                            <option value="department-2">공공사업2Div</option>
	                            <option value="department-3">공공사업3Div</option>
	                        </select>
	                    </div>
	                    <div style="width: 30%;">
	                        <select class="form-select" id="draftReferrer" style="width: 98%;">
	                            <option selected>참조자 선택</option>
	                            <option value="referrer-1">정원석 사원</option>
	                            <option value="referrer-2">서지혜 사원</option>
	                            <option value="referrer-3">엄성현 사원</option>
	                        </select>
	                    </div>
	                    <div class="d-flex align-items-top justify-content-start" style="width: 50%;">
	                        <select multiple class="form-select ms-3" id="draftRefSelectBox" size="3" style="width: 35%">
	                            <option value="selected-referrer-1">서지혜 사원</option>
	                        </select>
	                        <div class="d-flex ms-1" style="margin-top: 1px; flex-direction: column;">
		                        <button type="button" class="btn btn-secondary btn-sm mb-1">추가</button>
		                        <button type="button" class="btn btn-secondary btn-sm">삭제</button>
	                        </div>
	                    </div>
	                </div>
	            </div>
	            <div class="d-flex mb-5" style="width: 100%;">
	                <div class="d-flex align-items-center" style="width: 100%;">
	                    <label for="approvalLineSelect" class="fw-bold" style="width: 15%;">결재 라인</label>
	                    <select class="form-select" id="approvalLineSelect" style="width: 45%;">
	                        <option selected value="selected-apprval-1">기본 결재선</option>
	                        <option value="selected-apprval-2">기본 결재선2</option>
	                        <option value="selected-apprval-3">기본 결재선3</option>
	                    </select>
	                    <button type="button" class="btn btn-secondary" style="margin-left: 20px; height: 90%;">결재선 선택</button>
	                </div>
	            </div>
	            <div class="d-flex align-items-center justify-content-center mb-4">
	                <div class="custom-card text-end">
	                    <div class="name-text mt-1">정준하 <span class="role-text">과장</span></div>
	                    <div class="dept-text mt-2">공공사업1DIV</div>
	                </div>
	                <div class="mx-3">
	                    <img src="${pageContext.request.contextPath}/resources/image/approval-arrow.png" width="20px" />
	                </div>
	                <div class="custom-card text-end">
	                    <div class="name-text mt-1">박명수 <span class="role-text">차장</span></div>
	                    <div class="dept-text mt-2">공공사업1DIV</div>
	                </div>
	                <div class="mx-3">
	                    <img src="${pageContext.request.contextPath}/resources/image/approval-arrow.png" width="20px" />
	                </div>
	                <div class="custom-card text-end">
	                    <div class="name-text mt-1">유재석 <span class="role-text">부장</span></div>
	                    <div class="dept-text mt-2">공공사업1DIV</div>
	                </div>
	            </div>
	            <div class="d-flex flex-column align-items-start" style="width: 100%;">
	            	<div class="d-flex align-items-center me-3" style="width: 100%;">
		                <label for="approvalAttachFile" class="fw-bold" style="width: 15%;">첨부 파일</label>
		                <div class="d-flex align-items-center justify-content-start" style="width: 80%;">
			                <span class="text-secondary attachFont">전동열차_지연증명서.pdf</span>
		    	            <button type="button" class="btn p-0 ms-2" id="deleteAttacthFile"><img src="${pageContext.request.contextPath}/resources/image/close-icon.png" width="10px" /></button>
	            	    </div>
	            	</div>
	                <div class="d-flex" style="width: 100%;">
	                    <div style="width: 15%; height: 100%">&nbsp;</div>
	                    <input type="file" id="approvalAttachFile" class="form-control" style="width: 50%" />
	                </div>
	            </div>
	            
	            <hr class="hr my-5" />
	
	            <div>
	                <script>
	                    tinymce.init({
	                        language: 'ko_KR',
	                        selector: 'textarea',
	                        content_css: '${pageContext.request.contextPath}/resources/css/document-form/businessTripReport.css',
	                        plugins: [
	                        'anchor', 'autolink', 'charmap', 'codesample', 'emoticons', 'image', 'link', 'lists', 'media', 'searchreplace', 'table', 'visualblocks', 'wordcount',
	                        'checklist', 'mediaembed', 'casechange', 'export', 'formatpainter', 'pageembed', 'a11ychecker', 'tinymcespellchecker', 'permanentpen', 'powerpaste', 'advtable', 'advcode', 'editimage', 'advtemplate', 'ai', 'mentions', 'tinycomments', 'tableofcontents', 'footnotes', 'mergetags', 'autocorrect', 'typography', 'inlinecss', 'markdown', 'autoresize'
	                        ],
	                        toolbar: 'undo redo | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table mergetags | addcomment showcomments | spellcheckdialog a11ycheck typography | align lineheight | checklist numlist bullist indent outdent | emoticons charmap | removeformat',
	                        tinycomments_mode: 'embedded',
	                        tinycomments_author: 'Author name',
	                        setup: function (editor) {
	                            editor.on('init', function () {
	                                const htmlContent = `
	                                <div class="c22 doc-content c99">
					                    <p class="c4 c20">&nbsp;</p>
					                    <table class="c25" style="width: 100%; border-collapse: collapse; border-color: #000000; border-style: solid; height: 956.948px;" border="1">
					                    <tbody>
					                        <tr class="c17" style="height: 80px;">
					                        <td class="c38" style="width: 100.102%; border-color: #000000;" colspan="9" rowspan="1">
					                            <p class="c3"><span class="c34 c48">출장 복명서</span></p>
					                        </td>
					                        </tr>
					                        <tr class="c23" style="height: 23.5312px;">
					                        <td class="c27" style="width: 100.102%; border-color: #000000;" colspan="9" rowspan="1">
					                            <p class="c42"><span class="c6 c34">문서번호: </span> <span class="c2">BTR-111-2024-0001</span></p>
					                        </td>
					                        </tr>
					                        <tr class="c23" style="height: 23.5312px;">
					                        <td class="c7" style="width: 12.5127%; border-color: #000000;" colspan="2" rowspan="2">
					                            <p class="c3"><span class="c8 c6">기안부서</span></p>
					                        </td>
					                        <td class="c11" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="2">
					                            <p class="c3"><span class="c0">공공사업1Div.</span></p>
					                        </td>
					                        <td class="c11" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c3"><span class="c0">사원</span></p>
					                        </td>
					                        <td class="c11" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c3"><span class="c0">대표이사</span></p>
					                        </td>
					                        <td class="c11" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        <td class="c11" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        <td class="c11" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        <td class="c11" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        </tr>
					                        <tr class="c23" style="height: 23.5312px;">
					                        <td class="c11" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c3"><span class="c0">정원석</span></p>
					                        </td>
					                        <td class="c11" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c3"><span class="c0">오티아이</span></p>
					                        </td>
					                        <td class="c11" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        <td class="c11" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        <td class="c11" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        <td class="c11" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        </tr>
					                        <tr class="c19" style="height: 30px;">
					                        <td class="c7" style="width: 12.5127%; border-color: #000000;" colspan="2" rowspan="1">
					                            <p class="c3"><span class="c6">기안일</span></p>
					                        </td>
					                        <td class="c11" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        <td class="c11" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="3">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        <td class="c11" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="3">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        <td class="c11" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="3">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        <td class="c11" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="3">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        <td class="c11" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="3">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        <td class="c11" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="3">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        </tr>
					                        <tr class="c19" style="height: 30px;">
					                        <td class="c7" style="width: 12.5127%; border-color: #000000;" colspan="2" rowspan="1">
					                            <p class="c3"><span class="c6">기안자</span></p>
					                        </td>
					                        <td class="c11" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        </tr>
					                        <tr class="c19" style="height: 30px;">
					                        <td class="c7" style="width: 12.5127%; border-color: #000000;" colspan="2" rowspan="1">
					                            <p class="c3"><span class="c6">보존연한</span></p>
					                        </td>
					                        <td class="c11" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c3"><span class="c0">영구</span></p>
					                        </td>
					                        </tr>
					                        <tr class="c19" style="height: 30px;">
					                        <td class="c7" style="width: 12.5127%; border-color: #000000;" colspan="2" rowspan="1">
					                            <p class="c3"><span class="c6">참조자</span></p>
					                        </td>
					                        <td class="c1" style="width: 87.589%; border-color: #000000;" colspan="7" rowspan="1">
					                            <p class="c21"><span class="c0">정준하</span></p>
					                        </td>
					                        </tr>
					                        <tr class="c19" style="height: 30px;">
					                        <td class="c7" style="width: 12.5127%; border-color: #000000;" colspan="2" rowspan="1">
					                            <p class="c3"><span class="c6">제목</span></p>
					                        </td>
					                        <td class="c1" style="width: 87.589%; border-color: #000000;" colspan="7" rowspan="1">
					                            <p class="c21"><span class="c0">출장 복명서</span></p>
					                        </td>
					                        </tr>
					                        <tr class="c19" style="height: 30px;">
					                        <td class="c7" style="width: 12.5127%; border-color: #000000;" colspan="2" rowspan="1">
					                            <p class="c3"><span class="c6">귀속부서</span></p>
					                        </td>
					                        <td class="c15" style="width: 37.5381%; border-color: #000000;" colspan="3" rowspan="1">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        <td class="c7" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c3"><span class="c6">소속부서</span></p>
					                        </td>
					                        <td class="c15" style="width: 37.5381%; border-color: #000000;" colspan="3" rowspan="1">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        </tr>
					                        <tr class="c19" style="height: 30px;">
					                        <td class="c7" style="width: 12.5127%; border-color: #000000;" colspan="2" rowspan="2">
					                            <p class="c3"><span class="c8 c6">PJT 명</span></p>
					                        </td>
					                        <td class="c15" style="width: 37.5381%; border-color: #000000;" colspan="3" rowspan="2">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        <td class="c7" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c3"><span class="c6">성 명</span></p>
					                        </td>
					                        <td class="c15" style="width: 37.5381%; border-color: #000000;" colspan="3" rowspan="1">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        </tr>
					                        <tr class="c19" style="height: 30px;">
					                        <td class="c7" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c3"><span class="c6">직 위</span></p>
					                        </td>
					                        <td class="c15" style="width: 37.5381%; border-color: #000000;" colspan="3" rowspan="1">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        </tr>
					                        <tr class="c30" style="height: 25.0625px;">
					                        <td class="c7" style="width: 12.5127%; border-color: #000000;" colspan="2" rowspan="1">
					                            <p class="c3"><span class="c6">출발지</span></p>
					                        </td>
					                        <td class="c1 c22" style="width: 87.589%; border-color: #000000;" colspan="7" rowspan="1">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        </tr>
					                        <tr class="c30" style="height: 25.0625px;">
					                        <td class="c7" style="width: 12.5127%; border-color: #000000;" colspan="2" rowspan="1">
					                            <p class="c3"><span class="c6">경유지</span></p>
					                        </td>
					                        <td class="c1" style="width: 87.589%; border-color: #000000;" colspan="7" rowspan="1">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        </tr>
					                        <tr class="c30" style="height: 25.0625px;">
					                        <td class="c7" style="width: 12.5127%; border-color: #000000;" colspan="2" rowspan="1">
					                            <p class="c3"><span class="c6">목적지</span></p>
					                        </td>
					                        <td class="c1" style="width: 87.589%; border-color: #000000;" colspan="7" rowspan="1">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        </tr>
					                        <tr class="c23" style="height: 23.5312px;">
					                        <td class="c7" style="width: 12.5127%; border-color: #000000;" colspan="2" rowspan="2">
					                            <p class="c3"><span class="c6 c8">출장기간</span></p>
					                        </td>
					                        <td class="c43" style="width: 50.0509%; border-color: #000000;" colspan="4" rowspan="1">
					                            <p class="c3"><span class="c0">20&nbsp; &nbsp; 년&nbsp; &nbsp; 월&nbsp; &nbsp; 일 (오전/오후) 시</span></p>
					                        </td>
					                        <td class="c15" style="width: 37.5381%; border-color: #000000;" colspan="3" rowspan="2">
					                            <p class="c21"><span class="c0">&nbsp;( N박 M일)</span></p>
					                        </td>
					                        </tr>
					                        <tr class="c23" style="height: 23.5312px;">
					                        <td class="c43" style="width: 50.0509%; border-color: #000000;" colspan="4" rowspan="1">
					                            <p class="c3"><span class="c0">20&nbsp; &nbsp; 년&nbsp; &nbsp; 월&nbsp; &nbsp; 일 (오전/오후) 시</span></p>
					                        </td>
					                        </tr>
					                        <tr class="c23" style="height: 23.5312px;">
					                        <td class="c7" style="width: 12.5127%; border-color: #000000;" colspan="2" rowspan="1">
					                            <p class="c3"><span class="c6">출장목적</span></p>
					                        </td>
					                        <td class="c1" style="width: 87.589%; border-color: #000000;" colspan="7" rowspan="1">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        </tr>
					                        <tr class="c23" style="height: 23.5312px;">
					                        <td class="c7" style="width: 12.5127%; border-color: #000000;" colspan="2" rowspan="1">
					                            <p class="c3"><span class="c6 c34">항목</span></p>
					                        </td>
					                        <td class="c15 c28" style="width: 37.5381%; border-color: #000000;" colspan="3" rowspan="1">
					                            <p class="c3"><span class="c6 c34">출장여비</span></p>
					                        </td>
					                        <td class="c7" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c3"><span class="c6 c34">금액</span></p>
					                        </td>
					                        <td class="c15 c28" style="width: 37.5381%; border-color: #000000;" colspan="3" rowspan="1">
					                            <p class="c3"><span class="c6 c34">산출내역</span></p>
					                        </td>
					                        </tr>
					                        <tr class="c23" style="height: 23.5312px;">
					                        <td class="c16 c22" style="width: 3.81485%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c3"><span class="c2">1</span></p>
					                        </td>
					                        <td class="c22 c39" style="width: 8.69786%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c3"><span class="c2">일당</span></p>
					                        </td>
					                        <td class="c11 c22" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c3"><span class="c2">일 X N</span></p>
					                        </td>
					                        <td class="c24 c22" style="width: 25.0254%; border-color: #000000;" colspan="2" rowspan="1">
					                            <p class="c42"><span class="c2">원&nbsp; &nbsp;&nbsp;</span></p>
					                        </td>
					                        <td class="c11 c22" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        <td class="c15 c22" style="width: 37.5381%; border-color: #000000;" colspan="3" rowspan="1">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        </tr>
					                        <tr class="c23" style="height: 23.5312px;">
					                        <td class="c16" style="width: 3.81485%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c3"><span class="c2">2</span></p>
					                        </td>
					                        <td class="c39" style="width: 8.69786%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c3"><span class="c2">숙박료</span></p>
					                        </td>
					                        <td class="c11" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c3"><span class="c2">일 X N</span></p>
					                        </td>
					                        <td class="c24" style="width: 25.0254%; border-color: #000000;" colspan="2" rowspan="1">
					                            <p class="c42"><span class="c2">원&nbsp; &nbsp;&nbsp;</span></p>
					                        </td>
					                        <td class="c11" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        <td class="c15" style="width: 37.5381%; border-color: #000000;" colspan="3" rowspan="1">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        </tr>
					                        <tr class="c23" style="height: 26.1979px;">
					                        <td class="c16" style="width: 3.81485%; border-color: #000000;" colspan="1" rowspan="4">
					                            <p class="c3"><span class="c33 c35">3</span></p>
					                        </td>
					                        <td class="c39" style="width: 8.69786%; border-color: #000000;" colspan="1" rowspan="4">
					                            <p class="c3"><span class="c33 c35">유류대</span></p>
					                        </td>
					                        <td class="c11" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="2">
					                            <p class="c3"><span class="c33 c35">유류기준</span></p>
					                        </td>
					                        <td class="c24" style="width: 25.0254%; border-color: #000000;" colspan="2" rowspan="1">
					                            <p class="c3"><span class="c2"><input type="checkbox"> 휘발유<input type="checkbox">경유<input type="checkbox">가스</span></p>
					                        </td>
					                        <td class="c11" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="4">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        <td class="c15" style="width: 37.5381%; border-color: #000000;" colspan="3" rowspan="4">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        </tr>
					                        <tr class="c23" style="height: 23.5312px;">
					                        <td class="c24" style="width: 25.0254%; border-color: #000000;" colspan="2" rowspan="1">
					                            <p class="c3"><span class="c2">배기량 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;cc</span></p>
					                        </td>
					                        </tr>
					                        <tr class="c23" style="height: 23.5312px;">
					                        <td class="c11" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c3"><span class="c2">운행거리</span></p>
					                        </td>
					                        <td class="c24" style="width: 25.0254%; border-color: #000000;" colspan="2" rowspan="1">
					                            <p class="c3"><span class="c2">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; km </span></p>
					                        </td>
					                        </tr>
					                        <tr class="c49" style="height: 40.3958px;">
					                        <td class="c11" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c3"><span class="c2">유류단가</span></p>
					                        </td>
					                        <td class="c24" style="width: 25.0254%; border-color: #000000;" colspan="2" rowspan="1">
					                            <p class="c21"><span class="c33 c35">1리터&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;원</span></p>
					                            <p class="c21"><span class="c2">1리터&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;km</span></p>
					                        </td>
					                        </tr>
					                        <tr class="c23" style="height: 23.5312px;">
					                        <td class="c16" style="width: 3.81485%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c3"><span class="c2">4</span></p>
					                        </td>
					                        <td class="c39" style="width: 8.69786%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c3"><span class="c2">교통비1</span></p>
					                        </td>
					                        <td class="c15" style="width: 37.5381%; border-color: #000000;" colspan="3" rowspan="1">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        <td class="c11" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        <td class="c15" style="width: 37.5381%; border-color: #000000;" colspan="3" rowspan="1">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        </tr>
					                        <tr class="c23" style="height: 23.5312px;">
					                        <td class="c16" style="width: 3.81485%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c3"><span class="c2">5</span></p>
					                        </td>
					                        <td class="c39" style="width: 8.69786%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c3"><span class="c2">교통비2</span></p>
					                        </td>
					                        <td class="c15" style="width: 37.5381%; border-color: #000000;" colspan="3" rowspan="1">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        <td class="c11" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        <td class="c15" style="width: 37.5381%; border-color: #000000;" colspan="3" rowspan="1">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        </tr>
					                        <tr class="c23" style="height: 23.5312px;">
					                        <td class="c16" style="width: 3.81485%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c3"><span class="c2">6</span></p>
					                        </td>
					                        <td class="c39" style="width: 8.69786%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c3"><span class="c2">교통비3</span></p>
					                        </td>
					                        <td class="c15" style="width: 37.5381%; border-color: #000000;" colspan="3" rowspan="1">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        <td class="c11" style="width: 12.5127%; border-color: #000000;" colspan="1" rowspan="1">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        <td class="c15" style="width: 37.5381%; border-color: #000000;" colspan="3" rowspan="1">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        </tr>
					                        <tr class="c50" style="height: 21.3333px;">
					                        <td class="c38" style="width: 100.102%; border-color: #000000;" colspan="9" rowspan="1">
					                            <p class="c4">&nbsp;</p>
					                        </td>
					                        </tr>
					                        <tr class="c45" style="height: 144.396px;">
					                        <td class="c44" style="width: 100.102%; border-color: #000000;" colspan="9" rowspan="1">
					                            <p class="c3 c29">&nbsp;</p>
					                            <p class="c3"><span class="c33 c6">상기와 같이 출장 내역을 보고합니다.</span></p>
					                            <p class="c3 c29">&nbsp;</p>
					                            <p class="c3"><span class="c33 c6">20&nbsp; &nbsp; 년&nbsp; &nbsp; 월&nbsp; &nbsp; 일</span></p>
					                            <p class="c3 c29">&nbsp;</p>
					                            <p class="c3 c29">&nbsp;</p>
					                            <p class="c3"><span class="c33 c47">(주) ThirtyOne</span></p>
					                            <p class="c3 c29">&nbsp;</p>
					                        </td>
					                        </tr>
					                    </tbody>
					                    </table>
					                    <p class="c4 c20">&nbsp;</p>
				                	</div>
	                                `;
	                                editor.setContent(htmlContent);
	                            })},
	                        mergetags_list: [
	                        { value: 'First.Name', title: 'First Name' },
	                        { value: 'Email', title: 'Email' },
	                        ],
	                        ai_request: (request, respondWith) => respondWith.string(() => Promise.reject('See docs to implement AI Assistant')),
	                    });
	                    </script>
	                <div style="width: 85%; margin: 0 auto;">
	                    <textarea>Welcome to TinyMCE!</textarea>
	                </div>
	            </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>
<script>
   flatpickr.localize(flatpickr.l10ns.ko);
   flatpickr("#holidayStartDate", {
       dateFormat: "Y-m-d",
       allowInput: true,
       conjunction: " ~ "
   });
   flatpickr("#holidayEndDate", {
       dateFormat: "Y-m-d",
       allowInput: true
   });
</script>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>