document.addEventListener('DOMContentLoaded', function () {
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
	        title: '정원석 휴가',
	        start: '2024-10-11',
	        end: '2024-10-13'
	      },
	      {
	        title: '서지혜 휴가',
	        start: '2024-10-12',
	        end: '2024-10-16'
	      },
	
	    ]
	});
	
	calendar.render();
	
});