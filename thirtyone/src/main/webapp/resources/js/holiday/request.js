document.addEventListener('DOMContentLoaded', function () {
    const contentForm = document.getElementById("contentForm");

    // 휴가 날짜 선택 (Flatpickr)
    flatpickr("#choiceDay", {
        mode: "range",
        dateFormat: "Y-m-d",
        inline: true,
        onChange: function(selectedDates, dateStr, instance) {
            let startDate, endDate;

            if (selectedDates.length === 1) {
                startDate = selectedDates[0];
                endDate = selectedDates[0]; 
            } else if (selectedDates.length === 2) {
                startDate = selectedDates[0];
                endDate = selectedDates[1];
            } else {
                console.error("날짜가 선택되지 않았습니다.");
                return;
            }

            let daysDifference = (selectedDates.length > 1)
                ? Math.ceil((endDate - startDate) / (1000 * 3600 * 24)) + 1
                : 1;

            // `hdrUsedDay` 값 업데이트
            const usedDayInput = document.querySelector('[name="hdrUsedDay"]');
            if (usedDayInput) {
                usedDayInput.value = daysDifference;
            }

            // 시작일, 종료일 설정
            document.querySelector('[name="hdrStartDate"]').value = formatDate(startDate);
            document.querySelector('[name="hdrEndDate"]').value = formatDate(endDate);

            /*loadEmpByPosition();*/
        }
    });
    
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
        holidayPeriodSelect.disabled = holidayType !== "2";
        holidayTimeSelect.disabled = holidayType !== "3";
    });

    // 페이지 로드 시 초기 상태
    holidayPeriodSelect.disabled = holidayDurationSelect.value !== "2";
    holidayTimeSelect.disabled = holidayDurationSelect.value !== "3";
    
    //반차 반반차값 계산
    const holidayTypeSelect = document.getElementById("holiday-duration");
    const usedDayInput = document.getElementById("hdrUsedDay");
    
   holidayTypeSelect.addEventListener('change', () => {
	   let usedDay = 0;
	   
	   switch (holidayTypeSelect.value) {
	   	case '1':
	   		usedDay = 1;
	   		break;
	   	case '2':
	   		usedDay = 0.5;
	   		break;
	   	case '3':	
	   		usedDay = 0.25;
	   		break;
	   	default:
	   		usedDay = 0;
	   		break;
	   }
	   //휴가 사용일수를 입력 필드에 반영
	   usedDayInput.value = usedDay;
	   
   });

    

    // 직급별로 사원 목록 로드
    const position = document.getElementById('position');
    
    position.addEventListener('change', function() {
        const positionClass = document.getElementById("position").value;

        if (!positionClass) {
        	console.error('직급을 선택해주세요.');
        	return;
        }
        console.log(positionClass);

     // AJAX 요청
        fetch('getEmployeesByPosition?positionClass='+positionClass)
            .then(response => {
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
            });
    })

    // 직급 필터링
    const positionSelect = document.getElementById('position');
    const allowedPositions = ['과장', '차장', '부장'];

    Array.from(positionSelect.options).forEach(option => {
        if (!allowedPositions.includes(option.textContent)) {
            option.hidden = true;
        }
    });
    
    contentForm.addEventListener("submit", function(event) {
		event.preventDefault();
        event.stopPropagation();
        const formData = new FormData(contentForm);				
        console.log(formData);
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
