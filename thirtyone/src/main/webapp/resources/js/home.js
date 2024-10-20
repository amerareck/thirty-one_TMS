document.addEventListener('DOMContentLoaded', function() {

	$('.main-container').css({
		'box-shadow': 'none',
		'margin': '0px'
	})
	$('.main-line').css('display', 'none');
	
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

