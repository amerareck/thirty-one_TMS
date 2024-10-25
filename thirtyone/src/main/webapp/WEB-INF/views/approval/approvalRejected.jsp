<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/approval/approvalContainer.jsp"%>
	
<div class="sub-title m-0">
	<div <c:if test="${activePage == 'approve'}">class="sub-title-active"</c:if>><a href="result?type=approve">승인 문서</a></div>
	<div <c:if test="${activePage == 'reject'}">class="sub-title-active"</c:if>><a href="#">반려 문서</a></div>
</div>
<div class="main-line mx-0 mb-5"></div>
<section style="margin: 0 auto;">
    <div class="d-flex justify-content-between align-item-center my-2">
        <div class="w-25 d-flex align-item-center">
            <h5 class="fw-bold" style="margin:auto 0; color:#5A5A5A;">결재 반려 목록</h5>
        </div>
        <div class="input-group" style="width: 40%;">
            <select class="form-select form-select-sm" style="flex:1;">
                <option selected>전체</option>
                <option value="draftTitle">제목</option>
                <option value="draftType">유형</option>
                <option value="draftAuthor">기안자</option>
            </select>
            <input class="form-control col-8" placeholder="검색 유형 입력" style="flex:3;" />
            <button class="btn btn-outline-secondary" style="border-color: #dee2e6;" type="button"><i class="fa-solid fa-magnifying-glass"></i></button>
        </div>
    </div>

    <table class="table table-hover table-header-bg">
        <thead>
          <tr>
            <th scope="col" class="text-center align-middle">기안 유형</th>
            <th scope="col" class="text-center align-middle">문서 번호</th>
            <th scope="col" class="text-center align-middle">품의 제목</th>
            <th scope="col" class="text-center align-middle">부서</th>
            <th scope="col" class="text-center align-middle">직급</th>
            <th scope="col" class="text-center align-middle">기안자</th>
            <th scope="col" class="text-center align-middle">반려자</th>
            <th scope="col" class="text-center align-middle">반려 일자</th>
            <th scope="col" class="text-center align-middle">재기안</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td class="text-center align-middle table-font-size">출장 품의서</td>
            <td class="text-center align-middle table-font-size">BST-111-2024-022</td>
            <td class="text-center align-middle table-font-size">10월 21일 워크샵 교육 참여의 건</td>
            <td class="text-center align-middle table-font-size">공공사업1DIV</td>
            <td class="text-center align-middle table-font-size">사원</td>
            <td class="text-center align-middle table-font-size">정원석</td>
            <td class="text-center align-middle table-font-size">유재석 부장</td>
            <td class="text-center align-middle table-font-size">2024-09-28</td>
            <td class="text-center align-middle"><button class="btn btn-outline-secondary btn-ssm">수정</button></td>
          </tr>
          <tr>
            <td class="text-center align-middle table-font-size">근무 신청서</td>
            <td class="text-center align-middle table-font-size">WOT-111-2024-102</td>
            <td class="text-center align-middle table-font-size">9월 19일 연장 근무 신청의 건</td>
            <td class="text-center align-middle table-font-size">공공사업1DIV</td>
            <td class="text-center align-middle table-font-size">사원</td>
            <td class="text-center align-middle table-font-size">정원석</td>
            <td class="text-center align-middle table-font-size">박명수 차장</td>
            <td class="text-center align-middle table-font-size">2024-09-19</td>
            <td class="text-center align-middle"><button class="btn btn-outline-secondary btn-ssm">수정</button></td>
          </tr>
          <tr>
            <td class="text-center align-middle table-font-size">근무 신청서</td>
            <td class="text-center align-middle table-font-size">WOT-111-2024-098</td>
            <td class="text-center align-middle table-font-size">9월 18일 연장 근무 신청의 건</td>
            <td class="text-center align-middle table-font-size">공공사업1DIV</td>
            <td class="text-center align-middle table-font-size">사원</td>
            <td class="text-center align-middle table-font-size">정원석</td>
            <td class="text-center align-middle table-font-size">유재석 부장</td>
            <td class="text-center align-middle table-font-size">2024-09-18</td>
            <td class="text-center align-middle"><button class="btn btn-outline-secondary btn-ssm">수정</button></td>
          </tr>
          <tr>
            <td class="text-center align-middle table-font-size">출장 품의서</td>
            <td class="text-center align-middle table-font-size">BST-111-2024-009</td>
            <td class="text-center align-middle table-font-size">9월 01일 파견 교육 근무 신청의 건</td>
            <td class="text-center align-middle table-font-size">공공사업1DIV</td>
            <td class="text-center align-middle table-font-size">사원</td>
            <td class="text-center align-middle table-font-size">정원석</td>
            <td class="text-center align-middle table-font-size">박명수 차장</td>
            <td class="text-center align-middle table-font-size">2024-08-13</td>
            <td class="text-center align-middle"><button class="btn btn-outline-secondary btn-ssm">수정</button></td>
          </tr>
          <tr>
            <td class="text-center align-middle table-font-size">출장 품의서</td>
            <td class="text-center align-middle table-font-size">BST-111-2024-008</td>
            <td class="text-center align-middle table-font-size">9월 01일 파견 교육 근무 신청의 건</td>
            <td class="text-center align-middle table-font-size">공공사업1DIV</td>
            <td class="text-center align-middle table-font-size">사원</td>
            <td class="text-center align-middle table-font-size">정원석</td>
            <td class="text-center align-middle table-font-size">정준하 과장</td>
            <td class="text-center align-middle table-font-size">2024-08-12</td>
            <td class="text-center align-middle"><button class="btn btn-outline-secondary btn-ssm">수정</button></td>
          </tr>
        </tbody>
      </table>

      <nav class="mt-5 mb-3 d-flex justify-content-center">
        <ul class="pagination justify-content-center pagination-size">
          <li class="page-item disabled">
            <a class="page-link text-dark" href="#" tabindex="-1" aria-disabled="true"><i class="fa-solid fa-chevron-left"></i></a>
          </li>
          <li class="page-item"><a class="page-link text-dark page-border-none ms-5" href="#">1</a></li>
          <li class="page-item"><a class="page-link text-dark page-border-none ms-1" href="#">2</a></li>
          <li class="page-item"><a class="page-link text-dark page-border-none ms-1" href="#">3</a></li>
          <li class="page-item"><a class="page-link text-dark page-border-none ms-1" href="#">4</a></li>
          <li class="page-item"><a class="page-link text-dark page-border-none ms-1 me-5" href="#">5</a></li>
          <li class="page-item">
            <a class="page-link text-dark" href="#"><i class="fa-solid fa-chevron-right"></i></a>
          </li>
        </ul>
      </nav>
</section>
<%@ include file="/WEB-INF/views/approval/approvalContainerFooter.jsp"%>