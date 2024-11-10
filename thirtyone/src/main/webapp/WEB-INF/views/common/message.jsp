<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="toast-container position-fixed bottom-0 end-0 p-3">
   <div id="liveToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="toast-header">
      <strong class="me-auto">새로운 알림이 도착했습니다.</strong>
      <small></small>
      <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
    <div class="toast-body">
    	<div id="alert-div-div-div">
    	</div>	
    	
    </div>
  </div>
</div>


<script src="${pageContext.request.contextPath}/resources/js/common/footer.js"></script>