<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	
<div class="sectionContainer w-100">
	<div class="card">
        <div class="card-body p-4">
        	<section style="margin: 0 auto;">
		        <div class="d-flex justify-content-between align-item-center my-2">
		            <div class="w-25 d-flex align-item-center">
		                <h5 class="fw-bold" style="margin:auto 0; color:#5A5A5A;">부서 문서함</h5>
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
		                <th scope="col" class="text-center align-middle">완결 일자</th>
		                <th scope="col" class="text-center align-middle">열람</th>
		                <th scope="col" class="text-center align-middle">상태</th>
		              </tr>
		            </thead>
		            <tbody>
		              <tr>
		                <td class="text-center align-middle table-font-size">출장 품의서</td>
		                <td class="text-center align-middle table-font-size">BST-111-2024-012</td>
		                <td class="text-center align-middle table-font-size">2024년 10월 세미나 참여의 건</td>
		                <td class="text-center align-middle table-font-size">공공사업1DIV</td>
		                <td class="text-center align-middle table-font-size">과장</td>
		                <td class="text-center align-middle table-font-size">정준하</td>
		                <td class="text-center align-middle table-font-size">/</td>
		                <td class="text-center align-middle"><button class="btn btn-outline-secondary btn-ssm">확인</button></td>
		                <td class="text-center align-middle"><img src="../../../resources/image/approval-await.png" width="50px" height="20px" /></td>
		              </tr>
		              <tr>
		                <td class="text-center align-middle table-font-size">근무 신청서</td>
		                <td class="text-center align-middle table-font-size">WOT-111-2024-102</td>
		                <td class="text-center align-middle table-font-size">10월 9일 휴일 근무 신청의 건</td>
		                <td class="text-center align-middle table-font-size">공공사업1DIV</td>
		                <td class="text-center align-middle table-font-size">사원</td>
		                <td class="text-center align-middle table-font-size">서지혜</td>
		                <td class="text-center align-middle table-font-size">/</td>
		                <td class="text-center align-middle"><button class="btn btn-outline-secondary btn-ssm">확인</button></td>
		                <td class="text-center align-middle"><img src="../../../resources/image/approval-await.png" width="50px" height="20px" /></td>
		              </tr>
		              <tr>
		                <td class="text-center align-middle table-font-size">출장 품의서</td>
		                <td class="text-center align-middle table-font-size">BST-111-2024-011</td>
		                <td class="text-center align-middle table-font-size">2024년 10월 세미나 참여의 건</td>
		                <td class="text-center align-middle table-font-size">공공사업1DIV</td>
		                <td class="text-center align-middle table-font-size">과장</td>
		                <td class="text-center align-middle table-font-size">정준하</td>
		                <td class="text-center align-middle table-font-size">2024-10-06</td>
		                <td class="text-center align-middle"><button class="btn btn-outline-secondary btn-ssm">확인</button></td>
		                <td class="text-center align-middle"><img src="../../../resources/image/approval-rejected.png" width="50px" height="20px" /></td>
		              </tr>
		              <tr>
		                <td class="text-center align-middle table-font-size">근무 신청서</td>
		                <td class="text-center align-middle table-font-size">WOT-111-2024-045</td>
		                <td class="text-center align-middle table-font-size">10월 3일 휴일 근무 신청의 건</td>
		                <td class="text-center align-middle table-font-size">공공사업1DIV</td>
		                <td class="text-center align-middle table-font-size">사원</td>
		                <td class="text-center align-middle table-font-size">엄성현</td>
		                <td class="text-center align-middle table-font-size">2024-10-02</td>
		                <td class="text-center align-middle"><button class="btn btn-outline-secondary btn-ssm">확인</button></td>
		                <td class="text-center align-middle"><img src="../../../resources/image/approval-approve.png" width="50px" height="20px" /></td>
		              </tr>
		              <tr>
		                <td class="text-center align-middle table-font-size">출장 품의서</td>
		                <td class="text-center align-middle table-font-size">BST-111-2024-044</td>
		                <td class="text-center align-middle table-font-size">10월 3일 휴일 근무 신청의 건</td>
		                <td class="text-center align-middle table-font-size">공공사업1DIV</td>
		                <td class="text-center align-middle table-font-size">사원</td>
		                <td class="text-center align-middle table-font-size">정원석</td>
		                <td class="text-center align-middle table-font-size">2024-10-02</td>
		                <td class="text-center align-middle"><button class="btn btn-outline-secondary btn-ssm">확인</button></td>
		                <td class="text-center align-middle"><img src="../../../resources/image/approval-approve.png" width="50px" height="20px" /></td>
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
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>