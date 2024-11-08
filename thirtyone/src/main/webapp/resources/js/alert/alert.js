//const notificationsDiv = document.getElementById('notifications');
//const connectButton = document.getElementById('connect');
//const sendAlertButton = document.getElementById('alert-check');
//let eventSource = null;
//
//        // SSE 스트림에 연결하는 함수
//        connectButton.addEventListener('click', () => {
////            const empId = document.getElementById('empId').value.trim();
////            if (!empId) {
////                alert('Please enter a valid Employee ID.');
////                return;
////            }
//
//            // 기존 연결이 있으면 닫기
//            if (eventSource) {
//                eventSource.close();
//            }
//
//            // SSE 스트림에 연결
//            eventSource = new EventSource(`/thirtyone/alert/stream?`);
//
//            // 기본 메시지 수신 핸들러
//            eventSource.onmessage = function(event) {
//                const notification = JSON.parse(event.data);
//                const p = document.createElement('p');
//                p.textContent = `[${new Date(notification.timestamp).toLocaleTimeString()}] ${notification.message}`;
//                notificationsDiv.appendChild(p);
//
//                toast.show();
//            };
//
//            // 특정 이벤트("notification") 수신 핸들러
//            eventSource.addEventListener('notification', function(event) {
//                const notification = JSON.parse(event.data);
//                const p = document.createElement('p');
//                p.textContent = `[${new Date(notification.timestamp).toLocaleTimeString()}] ${notification.message}`;
//                notificationsDiv.appendChild(p);
//
//                toast.show();
//            });
//
//            // 에러 핸들러
//            eventSource.onerror = function(err) {
//                console.error("EventSource failed:", err);
//                eventSource.close();
//                // 5초 후에 재연결 시도
//                setTimeout(() => {
//                    connectButton.click();
//                }, 5000);
//            };
//        });
//
//        // 버튼 클릭 시 서버로 알림 전송하는 함수
//        sendAlertButton.addEventListener('click', () => {
//            
//
////            if (!empId) {
////                alert('Please enter a valid Employee ID.');
////                return;
////            }
////
////            if (!message) {
////                alert('Please enter a message.');
////                return;
////            }
//
//            // AJAX 요청을 통해 서버로 알림 전송
//            fetch(`/thirtyone/alert/send?message=${encodeURIComponent('asdfa')}`, {
//                method: 'POST'
//            })
//            .then(response => response.text())
//            .then(data => {
//                alert(data); // "Alert sent" 메시지 표시
//            })
//            .catch(error => {
//                console.error('Error sending alert:', error);
//                alert('Failed to send alert.');
//            });
//        });
//
//
//
//const toastEl = document.getElementById('liveToast');
//
//const toast = new bootstrap.Toast(toastEl, {
//  autohide: false 
//});
