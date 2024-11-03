
document.addEventListener('DOMContentLoaded', function () {
	
	updateToday("true");
	updateClock("true");
	
	setInterval(function() {
		updateClock("true");
	}, 1000);
	
	
	
	const ctx = document.getElementById('myChart').getContext('2d');
	const ctx2 = document.getElementById('chart').getContext('2d');
	const labels = ['정상출근', '연장근무', '지각', '조퇴',  '결근'];
	
	let barChart = new Chart(ctx, {
	    type: 'bar',
	    data: {
	  	  labels: labels,
		  datasets: [{
		    axis: 'y',
		    label: 'My First Dataset',
		    data: [5, 5, 5, 10, 12],
		    fill: false,
		    backgroundColor: [
			      'rgb(255, 99, 132)',
			      'rgb(54, 162, 235)',
			      'rgb(255, 205, 86)',
			      'rgba(75, 192, 192, 0.4)',
			      'rgba(54, 162, 235, 0.4)'
		    ],
		    spacing: 30 ,
		    borderWidth: 1,
		    barThickness: 25
		  }]
		},
		options: {
			plugins: {
	            legend: {
	                display: false,
	            }
			},
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
	
	let dounhnutChart = new Chart(ctx2,{
		type: 'doughnut',
		data: {
			labels: labels,
		  datasets: [{
		    data: [5, 5, 5, 12, 12],
		    backgroundColor: [
		      'rgb(255, 99, 132)',
		      'rgb(54, 162, 235)',
		      'rgb(255, 205, 86)',
		      'rgba(75, 192, 192, 0.4)',
		      'rgba(54, 162, 235, 0.4)'
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
	
	$.ajax({
		method: "get",
		url: contextPath + "/atd/atdStatusMonthly",
		success: function(result){
			barChart.data.datasets[0].data = result;
			dounhnutChart.data.datasets[0].data = result;
			barChart.update();
			dounhnutChart.update();
		}
		
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
	                data.forEach(event => {
	                    const eventType = event.title.split(' ')[0];
	                    const orderMap = { "출근": 1, "지각": 2, "퇴근": 3, "조퇴": 4, "연장근무": 5, "휴가" : 6, "결근": 7 };
	                    event.order = orderMap[eventType] || 8;  
	                });
					successCallback(data);
				},
	            error: function() {
	                failureCallback();
	            }
			})
		},
	    eventOrder: "order,start",
	    eventOrderStrict: true, 
		datesSet: function(info){
			var currentDate = calendar.getDate();
            var month = currentDate.getMonth()+1;
            var year = currentDate.getFullYear();


            $.ajax({
				method: "get",
				url: contextPath + "/atd/atdCalendar",
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
			
		},
	});
	
	calendar.render();

	
})


