<%@ page language="java" contentType="text/html; charset=UTF-8"pageEncoding="UTF-8"%>
	
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>전자결재 - 검토</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/themes/default/style.min.css" />
    <link rel="stylesheet" href="../../../resources/css/document-form/businessTripReport.css" />
    <link rel="stylesheet" href="../../../resources/css/approval/approvalLine.css" />
    <script src="https://cdn.tiny.cloud/1/zt811056qttf1h18ihxacac59l9xi81x71c2zv8l9cs330q6/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>


</head>
<body>

<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title fw-bold">전자결재 내용</h5>
        </div>
        <hr style="margin: 10px 0 10px 0" />
        <div class="modal-body px-1">
            <div class="d-flex justify-content-between" style="padding: 10px 15px 10px 7px;">
                <div class="col-3 d-flex justify-content-between">
                    <label for="submittedDate" class="form-label fw-bold" >일자</label>
                    <span id="submittedDate" class="me-5">2024-10-10</span>
                </div>
                <div class="col-5 d-flex justify-content-between">
                    <label for="submittor" class="form-label fw-bold">기안자</label>
                    <span id="submittor" class="me-5">[공공사업1Div] 정준하 과장</span>
                </div>
                <div class="col-4">
                    <label for="referrer" class="form-label fw-bold mb-1">참조자</label><br />
                    <span id="referrer">[경영지원실]김태호 부장</span>
                </div>
            </div>
            <div class="d-flex justify-content-between" style="padding: 10px 15px 10px 7px;">
                <div class="col-3 d-flex justify-content-between">
                    <label for="approveDraft" class="form-label fw-bold" >결재</label>
                    <select class="form-select w-50" style="margin-right: 27px;">
                        <option value="approval" selected>승인</option>
                        <option value="approva2">보류</option>
                        <option value="approva3">반려</option>
                    </select>
                </div>
                <div class="col-5 d-flex justify-content-between">
                    <label for="approvalType" class="form-label fw-bold">결재 유형</label>
                    <select class="form-select w-50" style="margin-right: 60px;" id="approvalType" disabled>
                        <option value="approvalType1" selected>일반</option>
                        <option value="approvalType2">전결</option>
                        <option value="approvalType3">대결</option>
                        <option value="approvalType4">선결</option>
                    </select>
                </div>
                <div class="col-4"> </div>
            </div>
            <div class="d-flex justify-content-between" style="padding: 10px 15px 10px 7px;">
                <div class="col-8 d-flex">
                    <label for="approveComment" class="form-label fw-bold col-1" style="margin-right: 30px;">의견</label>
                    <textarea class="form-control w-75" id="approveComment" cols="3"></textarea>
                </div>
            </div>

            <hr style="margin: 20px 0" />

            <div class="d-flex document-container">
                <div class="col-10">
                    <script>
                        tinymce.init({
                            language: 'ko_KR',
                            selector: '#documentContext',
                            height: 700,
                            readonly: true,
                            menubar: false,
                            toolbar: false,
                            content_css: "../../../resources/css/document-form/businessTripReport.css",
                            setup: function (editor) {
                                editor.on('dragstart', function (e) {
                                    e.preventDefault();
                                });
                                editor.on('mousedown', function (e) {
                                    e.preventDefault();
                                });
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
                        });
                    </script>
                    <div class="" style="width:95%;"; >
                        <textarea id="documentContext"></textarea>
                    </div>
                </div>
                <div class="approvalLineList col-2">
                    <div class="d-flex flex-column approval-line-cube border border-dark p-2 mt-2" style="margin: 0 auto;">
                        <p class="approval-line-cube-info">공공사업본부</p>
                        <p class="approval-line-cube-info">공공사업1Div</p>
                        <span class="text-center fs-6 mt-auto" style="font-size: 11pt;"><b>박명수</b> 차장</span>
                        <div class="fw-bold fs-5 text-center mt-auto">대기</div>
                    </div>
                    <div class="text-center my-3">
                        <i class="fa-solid fa-chevron-down"></i>
                    </div>
                    <div class="d-flex flex-column approval-line-cube border border-dark p-2 mt-2" style="margin: 0 auto;">
                        <p class="approval-line-cube-info">공공사업본부</p>
                        <p class="approval-line-cube-info">공공사업1Div</p>
                        <span class="text-center fs-6 mt-auto" style="font-size: 11pt;"><b>유재석</b> 부장</span>
                        <div class="fw-bold fs-5 text-center mt-auto">대기</div>
                    </div>
                    <div class="text-center my-3">
                        <i class="fa-solid fa-chevron-down"></i>
                    </div>
                    <div class="d-flex flex-column approval-line-cube border border-dark p-2 mt-2" style="margin: 0 auto;">
                        <p class="approval-line-cube-info">임원실</p>
                        <p class="approval-line-cube-info">대표이사</p>
                        <span class="text-center fs-6 mt-auto" style="font-size: 11pt;"><b>오티아이</b> 대표</span>
                        <div class="fw-bold fs-5 text-center mt-auto">대기</div>
                    </div>
                </div>
            </div>
            
        </div>
        <hr style="margin: 20px 0" />

        <div class="modal-footer d-flex justify-content-center my-4">
            <button type="button" class="btn btn-custom-cancel button-large text-center mx-2">취소</button>
            <button type="button" class="btn btn-custom-confirm button-large text-center ms-2">결정</button>
            <!--
                <button type="button" class="btn btn-secondary me-2" style="background-color: #5A5A5A;" >취소</button>
                <button type="button" class="btn btn-primary me-1" style="background-color: #1F5FFF;" >결정</button>
                -->
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