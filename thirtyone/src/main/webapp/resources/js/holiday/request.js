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
                
                // 선택된 날짜 범위 업데이트
                instance.setDate([startDate, endDate], true);
            }
        }
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
        formData.set("hdrStartDate", formattedStartDate); // 기존 값 덮어쓰기
        formData.set("hdrEndDate", formattedEndDate);

        // 폼 데이터가 올바르게 설정되었는지 확인
        console.log("Updated Form Data:", formData);
        
        
        console.log("FormData before AJAX:", formData);
        for (let [key, value] of formData.entries()) {
            console.log(key, value); // Check form data content
        }


        // AJAX로 폼 제출
        submitForm(formData);                
    });
    
    function submitForm(formData) {
        $.ajax({
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
                console.log(xhr.responseText);
            }
        });
    }    
});
