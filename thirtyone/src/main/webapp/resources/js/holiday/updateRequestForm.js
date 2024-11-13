document.addEventListener('DOMContentLoaded', function () {
    const contentForm = document.getElementById("contentForm");
    const holidayTypeSelect = document.getElementById("holiday-duration");
    const holidayPeriodSelect = document.getElementById('holiday-period');
    const holidayTimeSelect = document.getElementById('holiday-time');
    const hdCategorySelect = document.getElementById('hdCategory');
    const usedDay = document.getElementById("hdrUsedDay");
    const positionSelect = document.getElementById("position");
    const approverSelect = document.getElementById("hdrApprover");
       
    // 휴가 날짜 선택 (Flatpickr)
    const calendar = flatpickr("#choiceDay", {
    	mode: "range",
    	dateFormat: "Y-m-d",
    	inline: true,
    	onChange: function(selectedDates, dateStr, instance) {  		
    		calculateUsedDay(selectedDates);
    		
    		//선택된 날짜를 input 필드에 설정
    		document.getElementById("choiceDay").value = dateStr; //날짜를 인풋 필드에 반영
    	}
    });
    
    function fetchHolidayRequest(hdrId) {
    	console.log("hdrId 확인: ", hdrId);
    	$.ajax ({
    		url: '/holiday/updateRequestForm/' + hdrId,
    		method: 'GET',
    		success: function(data) {
    			populateHolidayForm(data); //가져온 데이터를 폼에 채워넣음
    		},
    		error: function(error) {
    			console.error("휴가 요청 정보를 가져오는 데 실패했습니다.", error);
    		}
    	});
    }
    
    
    function populateHolidayForm(data) {
    	console.log("populateHolidayForm 데이터: ", data);
    	if (data && data.hdrStartDate && data.hdrEndDate) {
    	
	    	$('#hdrStartDate').val(data.hdrStartDate);
	    	$('#hdrEndDate').val(data.hdrEndDate);
	    	$('#hdrContent').val(data.hdrContent);
	    	$('#hdCategory').val(data.hdCategory);
	    	$('#hdrApprover').val(data.hdrApprover);
	    	
	    	if (data.hdCategory === '2') {
	    		disableholidayTypeSelect();
	    	} else {
	    		enableholidayTypeSelect();
	    	}
	    	
	    	if (data.holidayType === '2') {
	    		holidayPeriodSelect.disabled = false;
	    		holidayTimeSelect.disabled = true;
	    	} else if (data.holidayType === '3') {
	    		holidayPeriodSelect.disabled = true;
	    		holidayTimeSelect.disabled = false;
	    	} else {
	    		holidayPeriodSelect.disabled = true;
	    		holidayTimeSelect.disabled = true;
	    	}	
    	
	    	
	    	
	    	//데이터 로드 후 선택된 날짜 설정
	    	calendar.setDate([data.hdrStartDate, data.hdrEndDate]); //데이터의 시작일과 종료일로 설정
    	} else {
    		console.error("Invalid or missing data: ", data);
    		}
    	}
    
    
    
    
    
    //초기 상태로 승인자 목록 비활성화
    approverSelect.disabled = true;
      
    
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
    holidayTypeSelect.addEventListener('change', function() {
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
    
    
    //대체휴무 선택시 반차 반반차 비활성화    
    hdCategorySelect.addEventListener('change', function() {
    	const holidayCategory = this.value;
	    	
	    if (holidayCategory == '2') {
	    	disableholidayTypeSelect(); //대체휴무인 경우 반차와 반반차 비활성화
	    } else {
	    	enableholidayTypeSelect(); //대체휴무가 아닌 경우 활성화
	    }	
    });
    
    //대체휴무일 경우, 반차/반반차를 비활성화
    function disableholidayTypeSelect() {
    	const options = holidayTypeSelect.querySelectorAll('option');
    	options.forEach(option => {
    		if (option.value === '2' || option.value === '3') {
    			option.disabled = true;
    			option.style.color = '#afafaf';  			
    		}
    	});
    	holidayTypeSelect.value = '1';
    }
    
    //대체휴무가 아닌 경우 반차/반반차 활성화
    function enableholidayTypeSelect() {
    	const options = holidayTypeSelect.querySelectorAll('option');
    	options.forEach (option => {
    		option.disabled = false;
    		option.style.color = '';
    	});
    }
    
    //페이지 로드 시, 대체휴무 상태에 맞춰 필드 초기화
    hdCategorySelect.dispatchEvent(new Event('change'));
	/*});*/
    	
    // 페이지 로드 시 초기 상태
    holidayPeriodSelect.disabled = holidayTypeSelect.value !== "2";
    holidayTimeSelect.disabled = holidayTypeSelect.value !== "3";
    

    // 직급별로 사원 목록 로드  
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
        const positionValue = positionSelect.value;
        console.log("선택된 직급:" , positionValue);

        if (!positionValue || positionValue === "0") {
        	console.error('직급을 선택해주세요.');
        	return;
        }
        console.log(positionClass);
        
        
        //서버로 직급 데이터 요청
        fetch('getPositions?position=' + encodeURIComponent(positionValue))
        	.then(response => response.json())
        	.then(data => {
        		const positionSelect = document.getElementById('position');
        		positionSelect.innerHTML = '<option value="0" selected>직급을 선택해 주세요.</option>'; //초기값 설정
        		
        		//반환된 직급 데이터가 배열 형태로 있는지 확인
        		if (Array.isArray(data)) {
        			data.forEach(position => {
        				var option = document.createElement("option");
        				option.value = position.id; //직급 ID로 설정
        				option.textContent = position.name; //직급 이름으로 설정
        				positionSelect.appendChild(option);
        			});
        		} else {
        			console.error("직급 데이터가 배열이 아닙니다.");
        		}
        	})
        	.catch(error => {
        		console.error("직급 데이터를 가져오는 중 오류 발생:", error);
        		alert("직급 데이터를 가져오는 데 실패했습니다.");
        	});
        
        //페이지 로드 시, 직급에 맞게 승인자 목록 처리
        positionSelect.dispatchEvent(new Event('change'));
        

        // AJAX 요청
	   fetch('getEmployeesByPosition?positionClass='+ encodeURIComponent(positionValue))
       .then(response => response.json())
            .then(data => {
                // 사원 데이터 처리
                var approverSelect = document.getElementById("hdrApprover");
                approverSelect.innerHTML = '<option value="0" selected>이름을 선택해 주세요.</option>';
                
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

    //직책 선택시 승인권자 활성화/비활성화
    document.getElementById('position').addEventListener('change', function() {
    	const positionValue = this.value;
    	const approverSelect = document.getElementById('hdrApprover');
    	
    	if (positionValue === "0") {
    		approverSelect.disabled = true;
    		approverSelect.value = "0";
    	} else {
    		approverSelect.disabled = false;
    	}
    });
    
    contentForm.addEventListener("submit", function(event) {
		event.preventDefault();
        event.stopPropagation();
        
        const formData = new FormData(contentForm);		
        
        const usedDay = document.getElementById('hdrUsedDay').value;
        formData.append("hdrUsedDay", usedDay);
        
        for (let [key, value] of formData.entries()) {
            console.log(key, value); // 각 키와 값이 출력됩니다.
        }
        
        if (contentValidChk()) {
			submitForm(formData);
			console.log("contentValidChk:	", contentValidChk);
		}
		
	});
    

	    // AJAX로 폼 제출
	    function submitForm(formData) {
	        $.ajax({
	            method: 'POST',
	            url: contextPath + '/holiday/updateRequest',
	            data: formData,
	            processData: false,
	            contentType: false,
	            success: function(response) {
	                alert("휴가 신청이 수정되었습니다.");
	                window.location.href = contextPath + '/holiday/';
	            },
	            error: function(xhr) {
	                console.error('Error', xhr.status);
	                alert("휴가 신청 실패: " + xhr.responseText);
	            }
	        });
	    }
	    
	    //유효성 검사
	    function contentValidChk() {
	    	const choiceDay = document.getElementById("choiceDay").value;
	    	const positionValue = positionSelect.value;
	        const approverValue = approverSelect.value;
	        const hdrContent = document.getElementById('hdrContent').value;
	        console.log("positionValue: ", positionValue);
	        const holidayTypeValue = holidayTypeSelect.value;
	        const holidayPeriodValue = holidayPeriodSelect.value;
	        const holidayTimeValue = holidayTimeSelect.value;
	        const hdCategoryValue = hdCategorySelect.value;
	        
	        console.log("approverValue: ", approverValue);
	        
	        if (!choiceDay) {
	        	alert("날짜를 선택해 주세요.");
	        	return false;
	        }
	        
	        if (hdCategoryValue === "0") {
	        	alert("휴가 유형을 선택해주세요.");
	        	return false;
	        }
	        
	        if (holidayTypeValue === "0") {
	        	alert("종일 / 반차 / 반반차를 선택해주세요.");
	        	return false;
	        }
	        
	        if (holidayTypeValue === "2" && holidayPeriodValue === "0") {
	        	alert("반차 시간대를 선택해주세요.");
	        	return false;
	        }
	        
	        if (holidayTypeValue === "3" && holidayTimeValue === "0") {
	        	alert("반반차 시간대를 선택해주세요.");
	        	return false;
	        }
	        
	        if (positionValue === "0") {
	        	alert("승인권자의 직급을 선택해주세요.");
	        	return false;	        	
	        }
	        
	        if (approverValue === "0" || approverValue === "") {
	        	alert("승인권자를 선택해주세요.");
	        	return false;	        	
	        }
	        
	        if (!hdrContent) {
	        	alert("사유를 작성해주세요.");
	        	return false;
	        }
	        return true;
	    }

	});
