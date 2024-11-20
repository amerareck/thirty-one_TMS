<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<h3 class="fw-bold mb-0 pb-0">결재선 설정</h3>
<hr class="mt-2 mb-4" style="border-top: 2px solid" />

<div class="w-100 h-auto">
	<div class="w-100 d-flex justify-content-center mb-0">
		<div class="input-group" style="width: 97%; ">
  			<input type="text" class="form-control" id="selectEmployeesFromModal" placeholder="사원 검색" style="height: 30px; font-size: .9rem;">
      		<button class="btn btn-outline-secondary" style="border-color: #dee2e6; height: 30px !important;" type="button"><i class="fa-solid fa-magnifying-glass"></i></button>
  		</div>
 	</div>
 	<div class="d-flex p-2 w-100 h-auto">
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
       	</div>
    </div>
    <div class="d-flex justify-content-end px-2 my-0" >
		<button type="button" class="btn btn-secondary btn-sm m-0" id="approvalLineEmpSelect" style="background-color: #5A5A5A; margin: 7.5px 0" >추가</button>
	</div>
</div>

<hr class="my-5" />

<!-- 결재 라인 및 라인 생성 -->
<div class="d-flex flex-column w-100 h-auto">
   	<div class="d-flex align-items-center justify-content-between ps-2 mb-0">
        <label for="approval-line" class="form-label fw-bold">결재 라인 북마크 설정</label>
   	</div>
   	
	<div class="p-2 mt-2" id="aplFormContainer" aria-describedby="approvalLineFormValidation">
		<div class="d-flex justify-content-center align-items-center mb-2" >
            <div class="input-group w-100" style="height: 85%">
                <input type="text" class="form-control d-flex align-items-center font-size-small " id="approvalLineSettingNameForm" style="height: 33.33px !important;" placeholder="결재선 이름" aria-label="결재 라인 생성">
                <button class="btn btn-light d-flex align-items-center font-size-small" id="approvalLineSettingSaveBtn" style="border-color: #dee2e6; height: 33.33px !important;" type="button">생성</button>
                <button class="btn btn-light d-flex align-items-center font-size-small" id="approvalLineSettingUpdateBtn" style="border-color: #dee2e6; height: 33.33px !important;" type="button">수정</button>
                <button class="btn btn-light d-flex align-items-center font-size-small removeApprovalLine" style="border-color: #dee2e6; height: 33.33px !important;" type="button">삭제</button>
            </div>
        </div>
        <div class="approval-line-container d-flex flex-column justify-content-start align-items-center h-auto" id="approvalLineBox">
            <%-- 결재선 box --%>
        </div>
        <div class="d-flex justify-content-end my-2" style="margin-left: 10px;" >
  			<button type="button" id="approvalLineClearBtn" class="btn btn-secondary btn-sm mb-2" style="background-color: #5A5A5A;" >Reset</button>
		</div>
	</div>
	<div id="approvalLineFormValidation" class="form-text m-0 px-2"></div>
</div>