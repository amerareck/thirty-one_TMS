document.addEventListener('DOMContentLoaded', function () {
	const contentForm = document.getElementById("contentForm");
	
	flatpickr("#choiceDay", {
	    mode: "range",
	    dateFormat: "Y-m-d",
	    inline: true
	});
	let formData = new FormData(contentForm); // 폼 데이터 동적으로 가져오기
	
	contentForm.addEventListener("submit", function(event) {
		event.preventDefault();
		
		const selectedRange = document.getElementById("choiceDay").value; // 날짜 범위 값 가져오기
		
		if (selectedRange) {
			const dates = selectedRange.split('to');
			const startDate = dates[0];
			const endDate = dates[1];
			
			formData.append("hdrStartDate", startDate);
			formData.append("hdrEndDate", endDate);
			
		}
		
		submitForm();				
	});
	
	function submitForm() {
		$.ajax ({
			method: 'POST',
			url: contextPath + '/holiday/request',
			data: formData,
			processData: false,
			contentType: false,
			success: function(response) {
				console.log("AJAX 성공", response);
			},
			error: function(xhr) {
				console.error('Error', xhr.status);
				console.log(xhr.reponseText);
			}
		});
	}
	
})