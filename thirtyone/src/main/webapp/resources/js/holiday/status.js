document.addEventListener('DOMContentLoaded', function () {

	flatpickr("#choiceDay", {
	    mode: "range",
	    dateFormat: "Y-m-d",
	    defaultDate: ["2024-10-14", "2024-10-20"],
	});
	

	var calendarEl = document.getElementById('calendar');
	let today = new Date();
	let todayYear = today.getFullYear();
	let todayMonth = ('0' + (today.getMonth() + 1)).slice(-2);
	
	
	var calendar = new FullCalendar.Calendar(calendarEl, {
	    initialView: 'dayGridMonth',
	    initialDate: formatDate(today),
	    headerToolbar: {
	      left: 'prev',
	      center: 'title',
	      right: 'next'
	    },
	    events: function (fetchInfo, successCallback, failureCallback){
	    	$.ajax({
	    		method: "get",
	    		url: contextPath + "/holiday/myhdrCalendar",
	    		data: {'year' : todayYear , 'month' : todayMonth },
	    		success: function(data){
	    			successCallback(data);
	    		},
	            error: function() {
	                failureCallback();
	            }
	    	})
	    },
	    dataSet: function(info){
			var currentDate = calendar.getDate();
            var month = currentDate.getMonth()+1;
            var year = currentDate.getFullYear();
            
            $.ajax({
				method: "get",
				url: contextPath + "/holiday/myhdrCalendar",
				data: {'year' : year , 'month' : month },
				success: function(data) {
					calendar.getEvents().forEach(event => event.remove());
					data.forEach(eventData => {
						calendar.addEvent(eventData);
					});
					
				},
	            error: function() {
	                failureCallback();
	            }
			})
	    }
	});
	
	calendar.render();
	
	const ctx2 = document.getElementById('doughnut-chart').getContext('2d');
	
	
	
	$.ajax({
		method: "get",
		url: contextPath + "/holiday/ramainHoliday",
		success: function(result){
			let hdrChart = new Chart(ctx2,{
				type: 'doughnut',
				data: {
					labels: [
					'사용일수',
				    '남은휴가'
				  ],
				  datasets: [{
				    label: '연차',
				    data: result,
				    backgroundColor: [
				      'rgb(31, 95, 255)',
				      'rgb(181, 202, 255)',
				    ],
				    hoverOffset: 4
				  }]
				},
				options: {
				    maintainAspectRatio: false,
			        plugins: {
			            legend: {
			                display: false
			            },
			        }
			    },
			    plugins: [{
		            id: 'textInside',
		            beforeDraw: function(chart) {
		                const width = chart.width;
		                const height = chart.height;
		                const ctx = chart.ctx;
		                ctx.restore();
		                
		                const total = chart.data.datasets[0].data.reduce((a, b) => a + b, 0);
		                const usedDays = chart.data.datasets[0].data[0];
		                const usagePercent = ((usedDays / total) * 100).toFixed(0) + "%";
		                
		                const text1 = "사용률";
		                const fontSize1 = (height / 12).toFixed(2); 
		                ctx.font = fontSize1 + "px 'Noto Sans'"; 
		                ctx.textBaseline = "middle";
		                const textX1 = Math.round((width - ctx.measureText(text1).width) / 2);
		                const textY1 = height / 2 - 15; 
		                ctx.fillStyle = 'rgb(31, 95, 255)', 
		                ctx.fillText(text1, textX1, textY1);

		                
		                const fontSize2 = (height / 6).toFixed(2); 
		                ctx.font = fontSize2 + "px 'Roboto'";
		                const textX2 = Math.round((width - ctx.measureText(usagePercent).width) / 2);
		                const textY2 = height / 2 + 10; 
		                ctx.fillText(usagePercent, textX2, textY2);

		                ctx.save();
		            }
		        }]
			})
			
		}
		
	})
	
	
});

function deleteRequest(hdrId) {
	/*if (confirm('해당 휴가 신청 내역을 삭제하시겠습니까?')) {*/
		
		/*$.ajax({
			url: contextPath + '/holiday/deleteRequest',
			type: 'POST',
			data: {hdrId : hdrId},
			success: function(response) {*/
				
				Swal.fire({
					title: '휴가 신청 내역을 삭제하시겠습니까?',
					text: '확인을 누르면 휴가 신청 내역이 삭제됩니다.',
					icon: 'warning',
					
					showCancelButton: true,
					confirmButtonColor: '#3085d6',
					cancelButtonColor: '#d33',
					confirmButtonText: '확인',
					cancelButtonText: '취소',
					
					reverseButtons: true
				
				}).then(result => {
					if (result.isConfirmed) {
						
						$.ajax({
							url: contextPath + '/holiday/deleteRequest',
							type: 'POST',
							data: {hdrId : hdrId},
							success: function(response) {
						
						Swal.fire({
							title: '휴가 신청이 삭제되었습니다.', 
							text: '휴가 내역에서 확인해주세요.', 
							icon: 'success'
						}).then(() => {
							location.reload();
						});
					},
					error: function(error) {
						
						Swal.fire({
							title: '휴가 신청 내역 삭제에 실패했습니다.',
							text: '휴가 신청 내역을 삭제하는 과정에 문제가 발생했습니다. 나중에 다시 시도해주세요.',
							icon: 'error',
							confirmButtonText: '확인',
							confirmButtonColor: '#FF6347'
						});
						
					}
				});	
			}
		});
	}
/*}*/


$('.delete-btn').on("click", function(){
	deleteRequest($(this).data('hdrid'));
})

function formatDate(date) {
    let year = date.getFullYear();
    let month = ('0' + (date.getMonth() + 1)).slice(-2); 
    let day = ('0' + date.getDate()).slice(-2);
    
    return `${year}-${month}-${day}`;
}

function formatMonthDay(date) {
	const targetDate = new Date(date);
	let month = ('0' + (targetDate.getMonth() + 1)).slice(-2); 
	let day = ('0' + targetDate.getDate()).slice(-2);
	
	return `${month}-${day}`;
}

function formatTime(date){

	const dateTime = new Date(date);

	const hours = dateTime.getHours();
	const minutes = dateTime.getMinutes();

	return `${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}`;
}