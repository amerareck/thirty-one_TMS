document.addEventListener('DOMContentLoaded', function () {
    const contentForm = document.getElementById("contentForm");
    const holidayTypeSelect = document.getElementById("holiday-duration");
    const holidayPeriodSelect = document.getElementById('holiday-period');
    const holidayTimeSelect = document.getElementById('holiday-time');
    const hdCategorySelect = document.getElementById('hdCategory');
    const usedDay = document.getElementById("hdrUsedDay");
    const positionSelect = document.getElementById("position");
    const approverSelect = document.getElementById("hdrApprover");
    
    let alertShown = false; // 알림이 이미 보여졌는지 여부를 확인하는 변수

    // 초기 상태로 승인자 목록 비활성화
    approverSelect.disabled = true;
    
    // 직급 선택 시 승인자 목록 활성화/비활성화 처리
    /*
	 * positionSelect.addEventListener('change', function() { const
	 * positionValue = this.value; if (positionValue == "0") {
	 * positionSelect.disabled = true; positionSelect.value = "0"; //승인자 값 초기화 }
	 * else { positionSelect.disabled = false; } });
	 */
    
    // 페이지 로드 시, 직급에 맞게 승인자 목록 처리
    positionSelect.dispatchEvent(new Event('change'));
    
    // 휴가 날짜 선택 (Flatpickr)
    const calendar = flatpickr("#choiceDay", {
        mode: "range",
        dateFormat: "Y-m-d",
        inline: true,
        onChange: function(selectedDates, dateStr, instance) {
        	console.log('asd');
        	calculateUsedDay(selectedDates);
        	alertShown = false;
        }
    });
    
    // 휴가 유형 변경 시 계산 갱신
    holidayTypeSelect.addEventListener('change', () => {
    	const selectedDates = calendar.selectedDates;
    	calculateUsedDay(selectedDates);
    });
    
    // 사용일수 계산 함수
    function calculateUsedDay(selectedDates) {
		let daysDifference = 0;
		
		if (selectedDates.length === 1) {
			daysDifference = 1;
		} else if (selectedDates.length === 2) {
			let startDate = selectedDates[0];
			let endDate = selectedDates[1];
			
			// 주말 제외 날짜 계산
			let countWeekdays = 0;
			let currentDate = new Date(startDate);
			while (currentDate <= endDate) {
				if (currentDate.getDay() !== 0 && currentDate.getDay() !== 6) { // 0:
																				// 일요일,
																				// 6:
																				// 토요일
					countWeekdays++;					
				}
				currentDate.setDate(currentDate.getDate() + 1);
			}
			daysDifference = countWeekdays;
			
			
			/*
			 * daysDifference = Math.ceil((endDate - startDate) / (1000 * 3600 *
			 * 24)) + 1; // 날짜 차이 계산
			 */		
		}
	    console.log("selectedDates: ", selectedDates );
	    console.log("daysDifference: ", daysDifference );
        // 휴가 유형에 따른 사용일수 설정
    	let usedDayValue = 0;
    	
    	if (holidayTypeSelect.value == "1") {
            usedDayValue = daysDifference; // 전체
        } else if (holidayTypeSelect.value == "2" && daysDifference > 1) {
            holidayTypeSelect.value = "1";
            alertIfNeeded();
            usedDayValue = 1;
        } else if (holidayTypeSelect.value == "3" && daysDifference > 1) {
            holidayTypeSelect.value = "1";
            alertIfNeeded();
            usedDayValue = 1;
        } else if (holidayTypeSelect.value == "3") {
            usedDayValue = 0.25;
        } else if (holidayTypeSelect.value == "2") {
            usedDayValue = 0.5 * daysDifference;
        }
    	
        console.log("usedDayValue 1 : " + usedDayValue);
        // 소수점 처리
        usedDayValue = (usedDayValue === 0.25 || usedDayValue === 0.5 || usedDayValue === 1) 
			? usedDayValue.toFixed(2) 
			: usedDayValue.toFixed(1);             

        console.log("usedDayValue: " + usedDayValue);
        // `usedDay` 값 업데이트
        document.getElementById('hdrUsedDay').value = usedDayValue;
            
            
        // 선택된 날짜로 시작일, 종료일 설정
        if (selectedDates.length > 0) {
        	const startDate = selectedDates[0];
        	const endDate = selectedDates.length === 2 ? selectedDates[1] : selectedDates[0];            

            // 시작일, 종료일 설정
            document.querySelector('[name="hdrStartDate"]').value = formatDate(startDate);
            document.querySelector('[name="hdrEndDate"]').value = formatDate(endDate);
            }
        }
    
    // 날짜 형식 포맷 함수
    function formatDate(date) {
        let year = date.getFullYear();
        let month = ('0' + (date.getMonth() + 1)).slice(-2);
        let day = ('0' + date.getDate()).slice(-2);
        return `${year}-${month}-${day}`;
    }
    
	 // 알림 한 번만 띄우는 함수
	    function alertIfNeeded() {
	        if (!alertShown) {
	        	
	        	Swal.fire({
	        	    title: '날짜를 재선택해주세요!',
	        	    text: '반차 / 반반차는 1일 이하의 기간만 가능합니다.',
	        	    icon: 'error',
	        	    confirmButtonText: '확인',
	        	    confirmButtonColor: '#FF6347'
	        	});
	        	
	            alertShown = true; // 알림을 한 번만 띄운다고 설정
	        }
	    }

    // 휴가 유형에 따라 필드 숨기기/보이기
    holidayTypeSelect.addEventListener('change', function() {
        const holidayType = this.value;        
        console.log("holidayType " + holidayType);
        alertShown = false; // 휴가 유형을 변경할 때마다 alertShown을 초기화
       
	    // 반차 반반차 비활성화 처리
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
    
    
    // 대체휴무 선택시 반차 반반차 비활성화
    hdCategorySelect.addEventListener('change', function() {
    	const holidayCategory = this.value;
	    	
	    if (holidayCategory == '2') {
	    	disableholidayTypeSelect(); // 대체휴무인 경우 반차와 반반차 비활성화
	    } else {
	    	enableholidayTypeSelect(); // 대체휴무가 아닌 경우 활성화
	    }	
    });
    
    // 대체휴무일 경우, 반차/반반차를 비활성화
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
    
    // 대체휴무가 아닌 경우 반차/반반차 활성화
    function enableholidayTypeSelect() {
    	const options = holidayTypeSelect.querySelectorAll('option');
    	options.forEach (option => {
    		option.disabled = false;
    		option.style.color = '';
    	});
    }
    
    // 페이지 로드 시, 대체휴무 상태에 맞춰 필드 초기화
    hdCategorySelect.dispatchEvent(new Event('change'));
	/* }); */
    	
    // 페이지 로드 시 초기 상태
    holidayPeriodSelect.disabled = holidayTypeSelect.value !== "2";
    holidayTimeSelect.disabled = holidayTypeSelect.value !== "3";
    

    // 직급별로 사원 목록 로드
    const allowedPositions = ['과장', '차장', '부장'];
    
    // 직급 필터링 함수
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
        /* const positionClass = document.getElementById("position").value; */
        console.log("positionClass:" , positionClass);

        if (!positionClass) {
        	console.error('직급을 선택해주세요.');
        	return;
        }
        console.log(positionClass);
        
   
    /*
	 * approverSelect.addEventListener('change', () => { const empName =
	 * approverSelect.value;
	 * 
	 * if (!empName) { console.error('사원 정보가 없습니다.'); return; }
	 */

     // AJAX 요청
	   fetch('getEmployeesByPosition?positionClass='+ encodeURIComponent(positionClass))
       .then(response => {
            /* .then(response => { */
                if (!response.ok) {
                    throw new Error('네트워크 응답이 정상적이지 않습니다: ' + response.statusText);
                }
                return response.json(); // 응답이 정상적일 때만 JSON 파싱
            })
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
                
                const Toast = Swal.mixin({
                	toast: true,
                	position: 'center-center',
                	showConfirmButton: false,
                	timer: 3000,
                	timerProgressBar: true,
                	didOpen: (toast) => {
                		toast.addEventListener('mouseenter', Swal.stopTimer)
                		toast.addEventListener('mouseleave', Swal.resumeTimer)
                	}
                })
                
                Toast.fire({
                	icon: 'warning',
            		title: '직급에 맞는 사원을 불러오는 데 실패했습니다. 잠시 후 다시 시도해 주세요.'
                })
            /* }); */
            });
    })

    // 직책 선택시 승인권자 활성화/비활성화
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
	            url: contextPath + '/holiday/request',
	            data: formData,
	            processData: false,
	            contentType: false,
	            success: function(response) {
	            	
	            	Swal.fire({
						title: '휴가 신청을 완료하시겠습니까?',
						text: '확인을 누르면 휴가 신청이 완료됩니다.',
						icon: 'warning',
						
						showCancelButton: true,
						confirmButtonColor: '#3085d6',
						cancelButtonColor: '#d33',
						confirmButtonText: '확인',
						cancelButtonText: '취소',
						
						reverseButtons: true
					
					}).then(result => {
						if (result.isConfirmed) {
							Swal.fire({
								title: '휴가 신청이 완료되었습니다.', 
								text: '신청 내역에서 확인해주세요.', 
								icon: 'success'
							}).then(() => {
								location.href = contextPath + '/holiday/';
							});
						}
					});
	                /*window.location.href = contextPath + '/holiday/';*/
	            },
	            error: function(xhr) {
	                console.error('Error', xhr.status);
	                
	                Swal.fire({
	                    title: '휴가 신청이 실패했습니다.',
	                    text: '휴가 신청 과정에 문제가 발생했습니다. 나중에 다시 시도해주세요.',
	                    icon: 'error',
	                    confirmButtonText: '확인',
	                    confirmButtonColor: '#FF6347'
	                });
	            }
	        });
	    }
	    
	    // 유효성 검사
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
	        	Swal.fire({
				    title: '날짜를 선택해 주세요.',
				    text: '날짜가 비어있습니다. 휴가 기간을 지정해주세요.',
				    icon: 'warning',
				    confirmButtonText: '확인',
				    confirmButtonColor: '#FF6347'
				});
	        	return false;
	        }
	        
	        if (hdCategoryValue === "0") {
	        	Swal.fire({
				    title: '휴가 유형을 선택해주세요.',
				    text: '휴가 유형이 비어있습니다. 휴가 유형을 선택해주세요.',
				    icon: 'warning',
				    confirmButtonText: '확인',
				    confirmButtonColor: '#FF6347'
				});
	        	return false;
	        }
	        
	        if (holidayTypeValue === "0") {
	        	Swal.fire({
				    title: '종일 / 반차 / 반반차를 선택해주세요.',
				    text: '종일 / 반차 / 반반차 부분이 비어있습니다. 해당 유형을 선택해주세요.',
				    icon: 'warning',
				    confirmButtonText: '확인',
				    confirmButtonColor: '#FF6347'
				});
	        	return false;
	        }
	        
	        if (holidayTypeValue === "2" && holidayPeriodValue === "0") {
	        	Swal.fire({
				    title: '반차 시간대를 선택해주세요.',
				    text: '반차 시간대가 비어있습니다. 해당 유형을 선택해주세요.',
				    icon: 'warning',
				    confirmButtonText: '확인',
				    confirmButtonColor: '#FF6347'
				});
	        	return false;
	        }
	        
	        if (holidayTypeValue === "3" && holidayTimeValue === "0") {
	        	Swal.fire({
				    title: '반반차 시간대를 선택해주세요.',
				    text: '반반차 시간대가 비어있습니다. 해당 유형을 선택해주세요.',
				    icon: 'warning',
				    confirmButtonText: '확인',
				    confirmButtonColor: '#FF6347'
				});
	        	return false;
	        }
	        
	        if (positionValue === "0") {
	        	Swal.fire({
				    title: '승인권자의 직급을 선택해주세요.',
				    text: '직급이 비어있습니다. 직급을 선택해주세요.',
				    icon: 'warning',
				    confirmButtonText: '확인',
				    confirmButtonColor: '#FF6347'
				});
	        	return false;	        	
	        }
	        
	        if (approverValue === "0" || approverValue === "") {
	        	Swal.fire({
				    title: '승인권자를 선택해주세요.',
				    text: '승인권자가 비어있습니다. 승인권자를 선택해주세요.',
				    icon: 'warning',
				    confirmButtonText: '확인',
				    confirmButtonColor: '#FF6347'
				});
	        	return false;	        	
	        }
	        
	        if (!hdrContent) {
	        	Swal.fire({
				    title: '사유를 작성해주세요.',
				    text: '사유가 비어있습니다. 내용을 입력해주세요.',
				    icon: 'warning',
				    confirmButtonText: '확인',
				    confirmButtonColor: '#FF6347'
				});
	        	return false;
	        }
	        return true;
	    }
	    
	});
