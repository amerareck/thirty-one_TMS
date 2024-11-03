let myChart;
let height; 

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

function calculateDate(date){
    const dayOfWeek = date.getDay();

    const monday = new Date(date);
    monday.setDate(date.getDate() - (dayOfWeek === 0 ? 6 : dayOfWeek - 1));


    const sunday = new Date(date);
    sunday.setDate(date.getDate() + (dayOfWeek === 0 ? 0 : 7 - dayOfWeek));

    return [ formatDate(monday), formatDate(sunday) ];

}

function getAtdforWeek(week){
	$.ajax({
		method : "post",
	    traditional: true, 
		url : contextPath + "/atd/getAtdForWeek",
		data : {"week" : week},
		success: function (data){	
			
			console.log(data);
			drawGraph(data);
			
			$(".worktime-info").empty();
			
			data.atdList.forEach(function(atd) {
				let formattedMonthDay = formatMonthDay(atd.atdDate);
				let formattedCheckIn = formatTime(atd.checkIn);
				let formattedCheckOut = formatTime(atd.checkOut);
				let formattedOverTime = atd.atdOverTime;
				let formattedStandardTime = `${atd.atdStandardTime}시간 00분`;
				
				let atdHtml =`				
					<tr>
					  <th scope="row">${formattedMonthDay} 월</th>
					  <td>${atd.atdState}</td>
					  <td>${formattedCheckIn}</td>
					  <td>${formattedCheckOut}</td>
					  <td>${formattedOverTime}</td>
					  <td>${formattedStandardTime}</td>
					  <td><img src="${contextPath}/resources/image/icon/clock.svg"></td>
					  <td><img src="${contextPath}/resources/image/icon/doc.svg"></td>
					</tr>
			    `
					
			    $(".worktime-info").append(atdHtml);
			})
			
			
		}
	})
}

document.addEventListener('DOMContentLoaded', function () {
	
	let currentWeek = calculateDate(new Date());
	
    $("#choiceDay p").html(currentWeek[0] + " ~ " + currentWeek[1]);
    getAtdforWeek(currentWeek);
    
	flatpickr("#choiceDay", {
	    mode: "range",
	    dateFormat: "Y-m-d",
	    defaultDate: calculateDate(new Date()),
	    onChange: function(selectedDates, dateStr, instance) {
	        if (selectedDates.length == 1) {
	            let startDate = selectedDates[0];
	            let currentWeek = calculateDate(startDate);
	            instance.setDate(currentWeek, true);
	            
	            $("#choiceDay p").html(currentWeek[0] + " ~ " + currentWeek[1]);
	            getAtdforWeek(currentWeek);
	        }
	    }
	});
	
});

function parseTimeToDecimal(time) {
    const [hours, minutes] = time.split(':').map(Number);
    return hours + minutes / 60;
}

function formatDecimalToTime(value) {
    const hours = Math.floor(value);
    const minutes = Math.round((value - hours) * 60);
    return hours + ':' + (minutes < 10 ? '0' : '') + minutes;
}

function formatTooltipValue(value) {
    return value - 10; // 툴팁에서는 원래 값으로 표시
}

function scaleData(value) {
    return value === 0 ? value : value+ 10;
}


function drawGraph(weekData){
	const ctx = document.getElementById('myChart');
	
	if (myChart) {
		updateChart(myChart, weekData);
		return;
	}
	
	const DATA_COUNT = 7;
	
	const chekIn = weekData.checkIn.map(parseTimeToDecimal);
    const checkOut = weekData.checkOut.map(parseTimeToDecimal);
    const lateTime = weekData.lateTime.map(parseTimeToDecimal);
	const workTime = weekData.workTime.map(scaleData);
	const overTime = weekData.overTime.map(scaleData);
	
	const COLORS = {
		    red: 'rgb(255, 99, 132)',
		    blue: 'rgb(54, 162, 235)'
		};
	const labels = weekData.weeklyData.map(formatMonthDay);
	const data = {
	  labels: labels,
	  datasets: [
	    {
	      label: '출근 시간',
	      data: chekIn,
	      borderColor: 'rgba(31, 95, 255, 1)',
	      backgroundColor: 'rgba(31, 95, 255, 1)',
	      type: 'line',
	      order: 0,
	    },
	    {
	      label: '퇴근 시간',
	      data: checkOut,
	      borderColor: 'rgba(101, 224, 224, 1)',
	      backgroundColor: 'rgba(101, 224, 224, 1)',
	      type: 'line',
	      order: 1,
	    },
	    {
	    	label: '기존 근무',
	    	data: workTime,
	    	backgroundColor: 'rgba(217, 217, 217, 1)',
	    	barThickness: 100,
	    	order: 4,
	    },
	    {
	    	label: '연장 근무',
	    	data: overTime,
	    	backgroundColor: 'rgba(181, 202, 255, 1)',
	    	barThickness: 100,
	    	order: 3,
	    },
	    {
	    	label: '지각',
	    	data: lateTime,
	    	backgroundColor: 'rgba(224, 101, 101, 1)',
	    	barThickness: 100,
	    	order: 2,
	    },
	  ]
	};
	
	myChart = new Chart (ctx, {
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
	          min: 8,
	          suggestedMax: 22,
	          position: 'left',
	          ticks: {
	            stepSize: 2,
	            callback: function(value) {
	              return formatDecimalToTime(value); 
	          }
	        }
	       }
	    },
	    plugins: {
	      legend: {
	    	  display: false
	      },
          tooltip: {
        	  callbacks: {
                  label: function(tooltipItem) {
                    const label = tooltipItem.dataset.label || '';
                    const value = tooltipItem.raw;
                    if (label === '기존 근무' || label === '연장 근무')  {
                    	return label + ': ' + formatTooltipValue(value);
                    } else {
                    	return label + ': ' + formatDecimalToTime(value); 
                    }
                  }
               }
          	}
    	}
	  },
	});
}

function updateChart(chart, weekData) {
    const chekIn = weekData.checkIn.map(parseTimeToDecimal);
    const checkOut = weekData.checkOut.map(parseTimeToDecimal);
    const lateTime = weekData.lateTime.map(parseTimeToDecimal);
    const workTime = weekData.workTime.map(scaleData);
    const overTime = weekData.overTime.map(scaleData);
    const labels = weekData.weeklyData.map(formatMonthDay);

    chart.data.labels = labels;
    chart.data.datasets[0].data = chekIn;
    chart.data.datasets[1].data = checkOut;
    chart.data.datasets[2].data = workTime;
    chart.data.datasets[3].data = overTime;
    chart.data.datasets[4].data = lateTime;
    
    chart.update();
}
