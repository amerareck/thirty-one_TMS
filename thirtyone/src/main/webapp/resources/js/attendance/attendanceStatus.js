
document.addEventListener('DOMContentLoaded', function () {
	
	updateToday("true");
	updateClock("true");
	
	setInterval(function() {
		updateClock("true");
	}, 1000);
	
	
	const ctx = document.getElementById('myChart').getContext('2d');
	const ctx2 = document.getElementById('chart').getContext('2d');
	const labels = ['정상출근', '연장근무', '조퇴', '지각', '결근'];
	new Chart(ctx, {
	    type: 'bar',
	    data: {
	  	  labels: labels,
		  datasets: [{
		    axis: 'y',
		    label: 'My First Dataset',
		    data: [5, 5, 5, 10, 12],
		    fill: false,
		    backgroundColor: [
		      'rgba(255, 99, 132, 0.2)',
		      'rgba(255, 159, 64, 0.2)',
		      'rgba(255, 205, 86, 0.2)',
		      'rgba(75, 192, 192, 0.2)',
		      'rgba(54, 162, 235, 0.2)',
		    ],
		    spacing: 30 ,
		    borderWidth: 1,
		    barThickness: 25
		  }]
		},
		options: {
		    indexAxis: 'y',
		    maintainAspectRatio: false,
		    scales: {
	            x: {
	                beginAtZero: true,
	                ticks: {
	                    stepSize: 4, 
	                }
	            }
	        }
		  }
	});
	
	new Chart(ctx2,{
		type: 'doughnut',
		data: {
			labels: [
		    '정상출근',
		    '연장근무',
		    '조퇴',
		    '지각',
		    '결근'
		  ],
		  datasets: [{
		    label: 'My First Dataset',
		    data: [5, 5, 5, 12, 12],
		    backgroundColor: [
		      'rgb(255, 99, 132)',
		      'rgb(54, 162, 235)',
		      'rgb(255, 205, 86)',
		      'rgba(75, 192, 192, 0.2)',
		      'rgba(54, 162, 235, 0.2)'
		    ],
		    hoverOffset: 4
		  }]
		},
		options: {
	        plugins: {
	            legend: {
	                display: true,
	                position: 'bottom',
                	labels: { padding : 10}
	            },
	            datalabels: {
	                color: 'white',
	                anchor: 'center', 
	                align: 'center',
	                font:{
	                	size: 16
	                },
	                formatter: (value, context) => {
	                    return value; 
	                }
	            }
	        }
	    },
	    plugins: [ChartDataLabels]
	})
	

	var calendarEl = document.getElementById('calendar');

	var calendar = new FullCalendar.Calendar(calendarEl, {
	    initialView: 'dayGridMonth',
	    contentHeight: 700,
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
})