<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<div class="toast-container position-fixed bottom-0 end-0 p-3">
   <div id="liveToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="toast-header">
      <div class="alert-top-text">
      	<img src="${pageContext.request.contextPath}/resources/image/logo.png"/> 새로운 알람이 도착했습니다.
      	<button type="button" class="btn-close alert-close-btn" data-bs-dismiss="toast" aria-label="Close"></button>
      </div>
    </div>
    <div class="alert-line"></div>
    <div class="toast-body">
    	<div id="alert-content">
    		<p><span>정원석님!</span> 출근 확인 체크를 하지 않으셨습니다. 확인 후 출근 체크를 해주시기 바랍니다.</p>
    	</div>
    </div>
  </div>
</div>

<script src="${pageContext.request.contextPath}/resources/js/common/footer.js"></script>