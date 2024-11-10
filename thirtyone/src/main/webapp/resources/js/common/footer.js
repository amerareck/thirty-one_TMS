//const sendAlertButtons = document.querySelectorAll('.send-alert-btn');
const alertDiv = document.getElementById('alert-content');
let eventSource = null;
let retryInterval = 3000; // 초기 재연결 간격 (3초)
const maxRetryInterval = 60000; // 최대 재연결 간격 (60초)
let retryTimer = null;

//페이지 로드 시 자동으로 SSE 스트림에 연결
window.addEventListener('load', () => {
	$.ajax({
		method: 'get',
		url: '/thirtyone/getEmpId',
		success: function(empId) {
			subscribeToSSE(empId);			
		}
	})
});


// 알림 전송 버튼 클릭 시 이벤트 핸들러
//sendAlertButtons.forEach(button => {
//    button.addEventListener('click', () => {
//    	console.log("hey hey hey!!");
//        const empId = button.getAttribute('data-empId');
//        const message = button.getAttribute('data-message');
//
//        if (!empId) {
//            alert('Employee ID is missing.');
//            return;
//        }
//
//        if (!message) {
//            alert('Message is missing.');
//            return;
//        }
//
//        // AJAX 요청을 통해 서버로 알림 전송
//        fetch(`/thirtyone/alert/send?empId=${encodeURIComponent(empId)}&message=${encodeURIComponent(message)}`, {
//            method: 'POST'
//        })
//        .then(response => response.text())
//        .then(data => {
//            alert(data); // "Alert sent to empId: X" 메시지 표시
//        })
//        .catch(error => {
//            console.error('Error sending alert:', error);
//            alert('Failed to send alert.');
//        });
	//    });
	//});

// SSE 스트림에 연결하는 함수
function subscribeToSSE(empId) {
    if (!empId) {
        console.error('Employee ID is missing.');
        return;
    }

    // 기존 연결이 있으면 닫기
    if (eventSource) {
        eventSource.close();
        alertDiv.innerHTML = ''; // 기존 알림 제거
    }

    // SSE 스트림에 연결
    eventSource = new EventSource(`/thirtyone/alert/stream?empId=${encodeURIComponent(empId)}`);
    console.log(empId);

    // 기본 메시지 수신 핸들러
    eventSource.onmessage = function(event) {
    	console.log("event", event);
        const alert = JSON.parse(event.data);
        displayAlert(alert);
    };

    // 특정 이벤트("alert") 수신 핸들러
    eventSource.addEventListener('alert', function(event) {
    	console.log("event", event);
        const alert = JSON.parse(event.data);
        displayAlert(alert);
    });
    
    eventSource.onopen = function() {
        console.log('SSE connection opened.');
        // 연결이 성공하면 재연결 간격을 초기화
        retryInterval = 3000;
    };

    // 에러 핸들러
    eventSource.onerror = function(err) {
        console.error("EventSource failed:", err);
        eventSource.close();

        // 재연결 시도 전에 기존 타이머가 있으면 제거
        if (retryTimer) {
            clearTimeout(retryTimer);
        }

        // 재연결 간격을 점진적으로 늘려감
        retryInterval = Math.min(retryInterval * 2, maxRetryInterval);
        console.log(`Attempting to reconnect in ${retryInterval / 1000} seconds...`);

        retryTimer = setTimeout(() => {
            subscribeToSSE();
        }, retryInterval);
    };
}

// 알림을 화면에 표시하는 함수
function displayAlert(alert) {
	$.ajax({
		method:"get",
		url: contextPath+'/getNumberNotReaded',
		success: function (data){
			$(".alert-num").empty();
			$(".alert-num").html(data);
			console.log(data);
		}
	})
	
	const alertTime = new Date(alert.alertTime);
    const toastEl = document.getElementById('liveToast');
    const toast = new bootstrap.Toast(toastEl, {
        autohide: true,
        delay: 5000
    });
    alertDiv.empty();
    const p = document.createElement('p');
    p.textContent = `[${alert.alertType}]\n${alert.alertContent}`;
    alertDiv.appendChild(p);
    $('.toast-header small').text(alertTime);
    
    toast.show();
}

$(".logout").on("click", function() {
    if (eventSource) {
        eventSource.close();
        console.log('SSE connection closed.');
    }
    if (retryTimer) {
        clearTimeout(retryTimer);
    }
});