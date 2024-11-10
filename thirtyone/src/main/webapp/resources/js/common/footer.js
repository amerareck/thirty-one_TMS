//const sendAlertButtons = document.querySelectorAll('.send-alert-btn');
const alertDiv = document.getElementById('alert-div-div-div');
let eventSource = null;

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

    // 에러 핸들러
    eventSource.onerror = function(err) {
        console.error("EventSource failed:", err);
        eventSource.close();
        // 5초 후에 재연결 시도
        setTimeout(() => {
            subscribeToSSE(empId);
        }, 5000);
    };
}

// 알림을 화면에 표시하는 함수
function displayAlert(alert) {
		console.log("Notification received:", alert);
	const alertTime = new Date(alert.alertTime);
    const toastEl = document.getElementById('liveToast');
    const toast = new bootstrap.Toast(toastEl, {
        autohide: true,
        delay: 5000
    });
    
    const p = document.createElement('p');
    p.textContent = `[${alert.alertType}]\n${alert.alertContent}`;
    alertDiv.appendChild(p);
    $('.toast-header small').text(alertTime);
    
    toast.show();
}