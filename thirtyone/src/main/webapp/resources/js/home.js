       
document.addEventListener('DOMContentLoaded', function() {

//	$('.main-container').css({
//		'box-shadow': 'none',
//		'margin': '0px'
//	})
//	$('.main-line').css('display', 'none');
//	
	updateToday("true");
	updateClock("true");
	
	setInterval(function() {
		updateClock("true");
	}, 1000);
	
	var calendarEl = document.getElementById('calendar');

	var calendar = new FullCalendar.Calendar(calendarEl, {
	    initialView: 'dayGridMonth',
	    initialDate: '2024-10-20',
	    headerToolbar: {
	      left: 'prev',
	      center: 'title',
	      right: 'next'
	    },
	    events: [
	      {
	        title: 'All Day Event',
	        start: '2024-10-01'
	      },
	      {
	        title: 'Long Event',
	        start: '2024-10-07',
	        end: '2024-10-10'
	      },
	      {
	        groupId: '999',
	        title: 'Repeating Event',
	        start: '2024-10-09T16:00:00'
	      },
	      {
	        groupId: '999',
	        title: 'Repeating Event',
	        start: '2024-10-16T16:00:00'
	      },
	      {
	        title: 'Conference',
	        start: '2024-10-11',
	        end: '2024-10-13'
	      },
	      {
	        title: 'Meeting',
	        start: '2024-10-12T10:30:00',
	        end: '2024-10-12T12:30:00'
	      },
	      {
	        title: 'Birthday Party',
	        start: '2024-10-13T07:00:00'
	      },
	
	    ]
	});
	
	calendar.render();
});
/*
function getEmpInfo() {
	$.ajax({
		method: "get",
		url: contextPath+'/getInfo',
		success: function(data){
			
			if(data.atdDto !== null){
				if(data.atd.checkIn === null || data.atd.checkIn == undefined){
					$('.sidebar-start-time span:nth-child(2)').html('--:--');
				}else{
					$('.sidebar-start-time span:nth-child(2)').html(formatDateToTime(data.atd.checkIn));
				}
				if(data.atd.checkOut === null || data.atd.checkOut == undefined){
					$('.sidebar-start-time span:nth-child(2)').html('--:--');
				}else{
					$('.sidebar-end-time span:nth-child(2)').html(formatDateToTime(data.atd.checkOut));
				}
			}
		};
	});
}*/

$('.start-time-btn, .end-time-btn').on('click', function () {
	location.reload();
	
})
