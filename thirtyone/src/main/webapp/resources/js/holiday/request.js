	document.addEventListener('DOMContentLoaded', function () {
	    const contentForm = document.getElementById("contentForm");
	    
	    flatpickr("#choiceDay", {
	        mode: "range",  // 범위 선택 모드
	        dateFormat: "Y-m-d",
	        inline: true,
	        onChange: function(selectedDates, dateStr, instance) {
	            console.log("선택된 날짜", selectedDates);
	            
	            // 날짜가 1개만 선택된 경우 (하루짜리 휴가)
	            if (selectedDates.length == 1) {
	                let startDate = selectedDates[0];  // 선택된 시작 날짜
	                let endDate = selectedDates[0];    // 동일한 종료일
	                console.log("하루휴가", startDate, endDate);
	                
	                // 날짜 범위가 두 개일 때만 setDate 호출 / 하루휴가의 경우 setDate 호출하지 않음
	                if (selectedDates.length > 1) {
	                instance.setDate([startDate, endDate], true);
	                }
	            }
	        }
	    });
	    
	    //휴가 유형에 따라 필드 숨기거나 보이게 하는 로직
	    document.getElementById('holiday-duration').addEventListener('change', function() {
	    	let holidayType = this.value;
	    	document.getElementById('holiday-period').style.display = holidayType === "2" ? 'inline' : 'none'; // 반차일 경우 AM/PM 표시
	    	document.getElementById('holiday-time').style.display = holidayType === "3" ? 'inline' : 'none'; //반반차일 경우 시간 표시
	    });
	    
	    function formatDate(date) {
	        let year = date.getFullYear();
	        let month = ('0' + (date.getMonth() + 1)).slice(-2);
	        let day = ('0' + date.getDate()).slice(-2);
	        
	        return `${year}-${month}-${day}`;
	    }
	    
	    contentForm.addEventListener("submit", function(event) {
	        event.preventDefault();
	        
	        const selectedDates = flatpickr("#choiceDay").selectedDates; // 선택된 날짜 범위 값 가져오기
	        let startDate, endDate;
	        
	        // 날짜 범위가 2개일 경우 (여러 일자 선택)
	        if (selectedDates.length == 2) {
	            startDate = selectedDates[0]; // 시작일
	            endDate = selectedDates[1];   // 종료일
	            console.log("선택된 날짜2", selectedDates);
	        
	        // 날짜 범위가 1개일 경우 (하루짜리 휴가)
	        } else if (selectedDates.length == 1) { // 시작일과 종료일이 같을 때 = 하루
	            startDate = selectedDates[0]; // 시작일
	            endDate = selectedDates[0];   // 종료일
	            console.log("하루휴가", selectedDates);
	        } else {
	            // 날짜 선택이 없는 경우
	            console.error("날짜가 선택되지 않았습니다.");
	            return;
	        }
	        
	        // 시작일과 종료일을 ISO 형식으로 변환하여 hidden input에 설정 > Date를 String으로 바꿔주기 위해
	        const formattedStartDate = formatDate(startDate);
	        const formattedEndDate = formatDate(endDate);
	
	        document.querySelector('[name="hdrStartDate"]').value = formattedStartDate;
	        document.querySelector('[name="hdrEndDate"]').value = formattedEndDate;
	        
	        // 새로운 FormData 객체를 폼 데이터 동적으로 가져오기 전에 생성
	        let formData = new FormData(contentForm);  // 폼 데이터 동적으로 가져오기
	        // 폼 데이터가 올바르게 설정되었는지 확인
	        console.log("Updated Form Data:", formData);
	        
	       
	        /*formData.append("hdrStartDate", formattedStartDate);
	        formData.append("hdrEndDate", formattedEndDate);*/
	
	        console.log("FormData before AJAX:", formData);
	        for (let [key, value] of formData.entries()) {
	        	console.log(key, value); // Check form data content
	        }
	
	        console.log("Form Data object:", formData);
	
	        // AJAX로 폼 제출
	        submitForm(formData);                
	    });
	    
	    function submitForm(formData) {
	    	console.log("Form Data:", [...formData]);
	    	
	        $.ajax({
	            method: 'POST',
	            url: contextPath + '/holiday/request',
	            data: formData,
	            processData: false,
	            contentType: false,
	            success: function(response) {
	                console.log("AJAX 성공", response);
	                alert("휴가 신청이 완료되었습니다.");
	                window.location.href = '/thirtyone/holiday';
	            },
	            error: function(xhr) {
	                console.error('Error', xhr.status);
	                console.log(xhr.responseText);
	                alert("휴가 신청 실패: " + xhr.responseText);
	            }
	        });
	    }    
	});
