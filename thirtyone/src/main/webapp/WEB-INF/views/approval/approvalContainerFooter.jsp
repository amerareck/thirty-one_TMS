<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
			</div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/jstree.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="${pageContext.request.contextPath}/resources/js/approval/approval.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/approval/documents.js"></script>

<c:if test="${empty form.documentData}">
	<script>
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
		    	editor.on('init', function() {
		            editor.setContent('');
		        })
		    },
		});
	</script>
</c:if>
<c:if test="${not empty form.documentData}">
	<script>
	    const selectedValue = '${form.draftType}';
		const documentHtmlData = `<![CDATA[<c:out value="${form.documentData}" escapeXml="false" />]]>`;
		tinymce.init({
			language: 'ko_KR',
		    selector: '#draftDocument',
		    height: '600px',
		    content_css: "/thirtyone/resources/css/document-form/" + selectedValue + ".css",
		    plugins: [
		        'anchor', 'autolink', 'charmap', 'codesample', 'emoticons', 'image', 'link', 'lists', 'media', 'searchreplace', 'table', 'visualblocks', 'wordcount'
		    ],
		    toolbar: 'undo redo | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table | align lineheight | numlist bullist indent outdent | emoticons charmap | removeformat',
		    setup: function (editor) {
		    	editor.on('init', function() {
		    		editor.setContent(documentHtmlData);
		        })
		    },
		});
	</script>
</c:if>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>