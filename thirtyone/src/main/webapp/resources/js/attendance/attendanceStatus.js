
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
	let today = new Date();
	let todayYear = today.getFullYear();
	let todayMonth = ('0' + (today.getMonth() + 1)).slice(-2);
	

	var calendar = new FullCalendar.Calendar(calendarEl, {
		initialView: 'dayGridMonth',
		views:{
			dayGridMonth: {
				titleFormat: { year: 'numeric', month: 'long' }
			}
		},
		contentHeight: 700,
		initialDate: today,
		headerToolbar: {
			left: 'prev',
			center: 'title',
			right: 'next'
		},
		events: function (fetchInfo, successCallback, failureCallback){
			$.ajax({
				method: "get",
				url: contextPath + "/atd/atdCalendar",
				data: {'year' : todayYear , 'month' : todayMonth },
				success: function(data) {
					successCallback(data);
				},
	            error: function() {
	                failureCallback();
	            }
			})
		},
		datesSet: function(info){
			var currentDate = calendar.getDate();
            var month = currentDate.getMonth()+1;
            var year = currentDate.getFullYear();


            $.ajax({
				method: "get",
				url: contextPath + "/atd/atdCalendar",
				data: {'year' : year , 'month' : month },
				success: function(data) {
					console.log(data);
					calendar.getEvents().forEach(event => event.remove());
					
					data.forEach(eventData => {
						calendar.addEvent(eventData);
					});
					
				},
	            error: function() {
	                failureCallback();
	            }
			})
			
		},
	});
	
	calendar.render();

	
})

$(".fc-prev-button").on('click', function() {
	var calendarEl = document.getElementById('calendar');
	console.log("asd");
	console.log(calendarEl);
	
//	$.ajax({
//		method: "get",
//		url: contextPath + "/atd/atdCalendar",
//		data: {'year' : todayYear , 'month' : todayMonth },
//		success: function(data) {
//			var calendar = new FullCalendar.Calendar(calendarEl, {
//				initialView: 'dayGridMonth',
//				contentHeight: 700,
//				initialDate: today,
//				headerToolbar: {
//					left: 'prev',
//					center: 'title',
//					right: 'next'
//				},
//				events: data 
//			});
//			calendar.render();
//		}
//	})
})

