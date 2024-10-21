document.addEventListener('DOMContentLoaded', function () {

	flatpickr("#choiceDay", {
	    mode: "range",
	    dateFormat: "Y-m-d",
	    defaultDate: ["2024-10-14", "2024-10-20"],
	});
	

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
	
	const ctx2 = document.getElementById('doughnut-chart').getContext('2d');
	
	new Chart(ctx2,{
		type: 'doughnut',
		data: {
			labels: [
			'사용일수',
		    '남은휴가'
		  ],
		  datasets: [{
		    label: 'My First Dataset',
		    data: [12.5, 4.5],
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
                
                const text1 = "사용률";
                const fontSize1 = (height / 12).toFixed(2); 
                ctx.font = fontSize1 + "px 'Noto Sans'"; 
                ctx.textBaseline = "middle";
                const textX1 = Math.round((width - ctx.measureText(text1).width) / 2);
                const textY1 = height / 2 - 15; 
                ctx.fillStyle = 'rgb(31, 95, 255)', 
                ctx.fillText(text1, textX1, textY1);

                const text2 = "74%";
                const fontSize2 = (height / 6).toFixed(2); 
                ctx.font = fontSize2 + "px 'Roboto'";
                const textX2 = Math.round((width - ctx.measureText(text2).width) / 2);
                const textY2 = height / 2 + 10; 
                ctx.fillText(text2, textX2, textY2);

                ctx.save();
            }
        }]
	})
});