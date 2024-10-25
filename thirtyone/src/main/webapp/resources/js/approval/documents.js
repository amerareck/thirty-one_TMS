tinymce.init({
    language: 'ko_KR',
    selector: '#documentContext',
    readonly: true,
    menubar: false,
    toolbar: false,
    plugins: 'autoresize',
    autoresize_min_height: 500,
    autoresize_max_height: 800,
    width: '100%',
    height: '100%',
    content_css: "/thirtyone/resources/css/document-form/businessTripReport.css",
    setup: function (editor) {
        editor.on('dragstart', function (e) {
            e.preventDefault();
        });
        editor.on('mousedown', function (e) {
            e.preventDefault();
        });
        editor.on('init', function () {
            const htmlContent = `
            <div class="doc-content c99" style="width: 100%">
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
        editor.iframeElement.style.width = '100%';
        editor.iframeElement.style.height = '100%';
    })},
});

tinymce.init({
	language: 'ko_KR',
    selector: '#draftDocument',
    height: '600px',
    content_css: "/thirtyone/resources/css/document-form/businessTripReport.css",
    plugins: [
        'anchor', 'autolink', 'charmap', 'codesample', 'emoticons', 'image', 'link', 'lists', 'media', 'searchreplace', 'table', 'visualblocks', 'wordcount'
    ],
    toolbar: 'undo redo | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table | align lineheight | numlist bullist indent outdent | emoticons charmap | removeformat',
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
});