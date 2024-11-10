document.addEventListener('DOMContentLoaded', function () {
    const contentForm = document.getElementById("contentForm");
    const holidayTypeSelect = document.getElementById("holiday-duration");
    const usedDay = document.getElementById("hdrUsedDay");

    // 휴가 날짜 선택 (Flatpickr)
    const calendar = flatpickr("#choiceDay", {
        mode: "range",
        dateFormat: "Y-m-d",
        inline: true,
        onChange: function(selectedDates, dateStr, instance) {
        	
        	calculateUsedDay(selectedDates);
        }
    });
    
    //휴가 유형 변경 시 계산 갱신
    holidayTypeSelect.addEventListener('change', () => {
    	const selectedDates = calendar.selectedDates;
    	calculateUsedDay(selectedDates);
    });
    
    //사용일수 계산 함수
    function calculateUsedDay(selectedDates) {
		let daysDifference = 0;
		
		if (selectedDates.length === 1) {
			daysDifference = 1;
		} else if (selectedDates.length === 2) {
			let startDate = selectedDates[0];
			let endDate = selectedDates[1];
			
			//주말 제외 날짜 계산
			let countWeekdays = 0;
			let currentDate = new Date(startDate);
			while (currentDate <= endDate) {
				if (currentDate.getDay() !== 0 && currentDate.getDay() !== 6) { //0: 일요일, 6: 토요일
					countWeekdays++;					
				}
				currentDate.setDate(currentDate.getDate() + 1);
			}
			daysDifference = countWeekdays;
			
			
			/*daysDifference = Math.ceil((endDate - startDate) / (1000 * 3600 * 24)) + 1; // 날짜 차이 계산
*/		
		}
	    console.log("selectedDates: ", selectedDates );
	    console.log("daysDifference: ", daysDifference );
        //휴가 유형에 따른 사용일수 설정
    	let usedDayValue = 0;
    	
        if (holidayTypeSelect.value == "1") {
        	usedDayValue = daysDifference; // 전체
        	
 	   	} else if (holidayTypeSelect.value == "2" && daysDifference > 1) {
 		   holidayTypeSelect.value = "1";
 		   alert("반차는 1일 이하의 기간만 가능합니다.");
 		   usedDayValue = 1;
 		   
 	   	} else if (holidayTypeSelect.value == "3" && daysDifference > 1) {
 	   		holidayTypeSelect.value = "1";
  		   alert("반반차는 1일 이하의 기간만 가능합니다.");
  		   usedDayValue = 1;
  		   
 	   	} else if (holidayTypeSelect.value == "3") {
 	   		usedDayValue = 0.25;	   		
 	   		console.log("0.25 " +  usedDay);
 	   		
 	   	} else if (holidayTypeSelect.value == "2") {
 	   		usedDayValue = 0.5 * daysDifference;
 	   	}
        console.log("usedDayValue 1 : " + usedDayValue);
        //소수점 처리
        usedDayValue = (usedDayValue === 0.25 || usedDayValue === 0.5 || usedDayValue === 1) 
			? usedDayValue.toFixed(2) 
			: usedDayValue.toFixed(1);             

        console.log("usedDayValue: " + usedDayValue);
        // `usedDay` 값 업데이트
        document.getElementById('hdrUsedDay').value = usedDayValue;
            
            
        //선택된 날짜로 시작일, 종료일 설정
        if (selectedDates.length > 0) {
        	const startDate = selectedDates[0];
        	const endDate = selectedDates.length === 2 ? selectedDates[1] : selectedDates[0];            

            // 시작일, 종료일 설정
            document.querySelector('[name="hdrStartDate"]').value = formatDate(startDate);
            document.querySelector('[name="hdrEndDate"]').value = formatDate(endDate);
            }
        }
    
    //날짜 형식 포맷 함수
    function formatDate(date) {
        let year = date.getFullYear();
        let month = ('0' + (date.getMonth() + 1)).slice(-2);
        let day = ('0' + date.getDate()).slice(-2);
        return `${year}-${month}-${day}`;
    }

    // 휴가 유형에 따라 필드 숨기기/보이기
    const holidayDurationSelect = document.getElementById('holiday-duration');
    const holidayPeriodSelect = document.getElementById('holiday-period');
    const holidayTimeSelect = document.getElementById('holiday-time');
    
    holidayDurationSelect.addEventListener('change', function() {
        const holidayType = this.value;
        
        console.log("holidayType " + holidayType);
        
	    //반차 반반차 비활성화 처리    
		if (holidayType == "2") {
			holidayPeriodSelect.disabled = false;
			holidayTimeSelect.disabled = true;	
		} else if (holidayType == "3") {
			holidayPeriodSelect.disabled = true;
			holidayTimeSelect.disabled = false;
		} else {
			holidayPeriodSelect.disabled = true;
			holidayTimeSelect.disabled = true;	
		}
		
		flatpickr("#choiceDay", {
	        mode: "range",
	        dateFormat: "Y-m-d",
	        inline: true
		});
    });

    // 페이지 로드 시 초기 상태
    holidayPeriodSelect.disabled = holidayDurationSelect.value !== "2";
    holidayTimeSelect.disabled = holidayDurationSelect.value !== "3";
    

    // 직급별로 사원 목록 로드
    const positionSelect = document.getElementById('position');
    const approverSelect = document.getElementById('hdrApprover');
    
    const allowedPositions = ['과장', '차장', '부장'];
    
    //직급 필터링 함수
    function filterPositions() {
    	Array.from(positionSelect.options).forEach(option => {
    		if (!allowedPositions.includes(option.textContent)) {
    			option.hidden = true;
    		} else {
    			option.hidden = false;
    		}
    	});
    }
    
    filterPositions();
    
    positionSelect.addEventListener('change', function() {
        const positionClass = $(this).val();
        /*const positionClass = document.getElementById("position").value;*/
        console.log("positionClass:" , positionClass);

        if (!positionClass) {
        	console.error('직급을 선택해주세요.');
        	return;
        }
        console.log(positionClass);
        
   
    /*approverSelect.addEventListener('change', () => {
	   const empName = approverSelect.value;
	   
	   if (!empName) {
		   console.error('사원 정보가 없습니다.');
		   return;
	   }*/

     // AJAX 요청
	   fetch('getEmployeesByPosition?positionClass='+ encodeURIComponent(positionClass))
       .then(response => {
            /*.then(response => {*/
                if (!response.ok) {
                    throw new Error('네트워크 응답이 정상적이지 않습니다: ' + response.statusText);
                }
                return response.json(); // 응답이 정상적일 때만 JSON 파싱
            })
            .then(data => {
                // 사원 데이터 처리
                var approverSelect = document.getElementById("hdrApprover");
                approverSelect.innerHTML = '<option selected>이름을 선택해 주세요.</option>';
                
                // 새로운 옵션을 dropdown에 추가
                data.forEach(employees => {
                    var option = document.createElement("option");
                    option.value = employees.empId;
                    option.textContent = employees.empName;
                    approverSelect.appendChild(option);
                });
            })
            .catch(error => {
                console.error("사원 데이터를 가져오는 중 오류 발생:", error);
                alert('직급에 맞는 사원을 불러오는 데 실패했습니다. 잠시 후 다시 시도해 주세요.');
            /*});*/
            });
    })

    // 직급 필터링
    /*const positionSelect = document.getElementById('position');
    const allowedPositions = ['과장', '차장', '부장'];

    Array.from(positionSelect.options).forEach(option => {
        if (!allowedPositions.includes(option.textContent)) {
            option.hidden = true;
        }
    });*/
    
    contentForm.addEventListener("submit", function(event) {
		event.preventDefault();
        event.stopPropagation();
        
        const formData = new FormData(contentForm);		
        
        const usedDay = document.getElementById('hdrUsedDay').value;
        formData.append("hdrUsedDay", usedDay);
        
        for (let [key, value] of formData.entries()) {
            console.log(key, value); // 각 키와 값이 출력됩니다.
        }
		submitForm(formData);
		
	});
    

	    // AJAX로 폼 제출
	    function submitForm(formData) {
	        $.ajax({
	            method: 'POST',
	            url: contextPath + '/holiday/request',
	            data: formData,
	            processData: false,
	            contentType: false,
	            success: function(response) {
	                alert("휴가 신청이 완료되었습니다.");
	                window.location.href = contextPath + '/holiday/';
	            },
	            error: function(xhr) {
	                console.error('Error', xhr.status);
	                alert("휴가 신청 실패: " + xhr.responseText);
	            }
	        });
	    }
	});
