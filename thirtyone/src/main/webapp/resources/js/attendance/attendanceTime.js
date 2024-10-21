
function formatDate(date) {
    let year = date.getFullYear();
    let month = ('0' + (date.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 +1
    let day = ('0' + date.getDate()).slice(-2);
    
    return `${year}-${month}-${day}`;
}

document.addEventListener('DOMContentLoaded', function () {

	flatpickr("#choiceDay", {
	    mode: "range",
	    dateFormat: "Y-m-d",
	    defaultDate: ["2024-10-14", "2024-10-20"],
	    onChange: function(selectedDates, dateStr, instance) {
	        if (selectedDates.length == 1) {
	            let startDate = selectedDates[0];
	            let dayOfWeek = startDate.getDay(); 
	            
	            let monday = new Date(startDate);
	            monday.setDate(startDate.getDate() - (dayOfWeek === 0 ? 6 : dayOfWeek - 1));
	            
	            let sunday = new Date(monday);
	            sunday.setDate(monday.getDate() + 6);
	            instance.setDate([monday, sunday], true);
	            $("#choiceDay p").html(formatDate(monday) + " ~ " + formatDate(sunday));
	        }
	    }
	});
	
	const ctx = document.getElementById('myChart').getContext('2d');
	
	const DATA_COUNT = 7;
	const NUMBER_CFG1 = [8.5, 9, 8.9, 8.9, 11, 8, 8];
	const NUMBER_CFG2 = [18.2, 18, 18, 20, 18, 8, 8];
	const NUMBER_CFG3 = [18, 18, 18, 18, 18, 0, 0];
	const NUMBER_CFG4 = [0, 0, 0, 20, 0, 0, 0];
	const NUMBER_CFG5 = [0, 0, 0, 0, 10, 0, 0];
	const COLORS = {
		    red: 'rgb(255, 99, 132)',
		    blue: 'rgb(54, 162, 235)'
		};
	const labels = ['10/14', '10/15', '10/16', '10/17', '10/18', '10/19', '10/20'];
	const data = {
	  labels: labels,
	  datasets: [
	    {
	      label: '출근 시간',
	      data: NUMBER_CFG1,
	      borderColor: 'rgba(31, 95, 255, 1)',
	      backgroundColor: 'rgba(31, 95, 255, 1)',
	      type: 'line',
	      order: 0
	    },
	    {
	      label: '퇴근 시간',
	      data: NUMBER_CFG2,
	      borderColor: 'rgba(101, 224, 224, 1)',
	      backgroundColor: 'rgba(101, 224, 224, 1)',
	      type: 'line',
	      order: 1
	    },
	    {
	    	label: '기존 근무',
	    	data: NUMBER_CFG3,
	    	backgroundColor: 'rgba(217, 217, 217, 1)',
	    	barThickness: 100,
	    	order: 4,
	    },
	    {
	    	label: '연장 근무',
	    	data: NUMBER_CFG4,
	    	backgroundColor: 'rgba(181, 202, 255, 1)',
	    	barThickness: 100,
	    	order: 3,

	    },
	    {
	    	label: '지각',
	    	data: NUMBER_CFG5,
	    	backgroundColor: 'rgba(224, 101, 101, 1)',
	    	barThickness: 100,
	    	order: 2,
	    },
	  ]
	};
	
	new Chart (ctx, {
	  type: 'bar',
	  data: data,
	  options: {
	    responsive: true,
	    scales: {
	      x: {
	        stacked: true, 
	        ticks: {
                font: {
                    size: 16 
                }
            }
	      },
	      y: {
	        beginAtZero: true,
	        stacked: false,
	        min: 8, 
	        suggestedMax: 22,  
            ticks: {
                stepSize: 2 
            }
	      }
	    },
	    plugins: {
	      legend: {
	    	  display: false
	      },
	    }
	  },
	});
	

});