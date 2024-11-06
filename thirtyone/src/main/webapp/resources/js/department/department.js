document.addEventListener('DOMContentLoaded', function () {
	const ctx = document.getElementById('attendance-rate').getContext('2d');
	const ctx2 = document.getElementById('emp-rate').getContext('2d');
	const labels = ['출근', '퇴근', '출근전', '지각', '조퇴', '휴가', '출장', '결근'];
	
	let barChart = new Chart(ctx2, {
	    type: 'bar',
	    data: {
	  	  labels: labels,
		  datasets: [{
		    axis: 'y',
		    label: 'My First Dataset',
		    data: [12, 1, 2, 2, 0, 2, 1, 1],
		    fill: false,
		    backgroundColor: [
			      'rgb(255, 99, 132)',
			      'rgb(54, 162, 1, 0.4)',
			      'rgb(54, 162, 235)',
			      'rgb(255, 205, 86)',
			      'rgba(75, 192, 192, 0.4)',
			      'rgba(54, 162, 235, 0.4)',
			      'rgba(1, 162, 235, 0.4)',
			      'rgba(54, 2, 235, 0.4)'
		    ],
		    spacing: 10 ,
		    barThickness: 15
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
	
	let doughnutChart = new Chart(ctx,{
		type: 'doughnut',
		data: {
			labels: [
			'출근',
		    '미출근'
		  ],
		  datasets: [{
		    label: 'My First Dataset',
		    data: [17, 3],
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
                
                const text1 = "출근율";
                const fontSize1 = (height / 15).toFixed(2); 
                ctx.font = fontSize1 + "px 'Noto Sans'"; 
                ctx.textBaseline = "middle";
                const textX1 = Math.round((width - ctx.measureText(text1).width) / 2);
                const textY1 = height / 2 - 20; 
                ctx.fillStyle = 'rgb(31, 95, 255)', 
                ctx.fillText(text1, textX1, textY1);
                

                const total = chart.data.datasets[0].data.reduce((a, b) => a + b, 0);
                const usedDays = chart.data.datasets[0].data[0];
                const usagePercent = ((usedDays / total) * 100).toFixed(0) + "%";
                
                const fontSize2 = (height / 8).toFixed(2); 
                ctx.font = "bold " + fontSize2 + "px 'Roboto'";
                const textX2 = Math.round((width - ctx.measureText(usagePercent).width) / 2);
                const textY2 = height / 2 + 15; 
                ctx.fillText(usagePercent, textX2, textY2);
                $(".atd-status-table tbody tr td").eq(0).text(usagePercent);
                ctx.save();
            }
        }]
	})
	
	$.ajax({
		method: "get",
		url: contextPath + "/dept/deptAtdStatus",
		success: function(result){
			console.log(result);
			barChart.data.datasets[0].data = result.deptAtdStatus;
			doughnutChart.data.datasets[0].data = result.deptAtdCur;
			barChart.update();
			doughnutChart.update();
			
			let totalEmp =  result.deptAtdStatus.reduce((accumulator, currentValue) => accumulator + currentValue, 0);
			
			let workHtml = '<h3>근무 현황</h3>' 
						+ '<div><span>총원</span><span>' + formatNumber(totalEmp) +'</span></div>'
						+ '<div><span>출근전</span><span>' + formatNumber(result.deptAtdStatus[2]) + '</span></div>'
						+ '<div><span>출근</span><span>' + formatNumber(result.deptAtdStatus[0]) + '</span></div>'
						+ '<div><span>퇴근</span><span>' + formatNumber(result.deptAtdStatus[1]) + '</span></div>'
						+ '<div><span>지각</span><span>' + formatNumber(result.deptAtdStatus[3]) + '</span></div>'
						+ '<div><span>조퇴</span><span>'+ formatNumber(result.deptAtdStatus[4]) + '</span></div>'
						+ '<div><span>휴가</span><span>'+ formatNumber(result.deptAtdStatus[5]) + '</span></div>'
						+ '<div><span>출장</span><span>'+ formatNumber(result.deptAtdStatus[6]) + '</span></div>'
						+ '<div><span>결근</span><span>'+ formatNumber(result.deptAtdStatus[7]) + '</span></div>'
			$('.work-status').append(workHtml);
			$(".atd-status-table tbody tr td").eq(1).text(formatNumber(totalEmp));
			$(".atd-status-table tbody tr td").eq(2).text(formatNumber(result.deptAtdStatus[2]));
			$(".atd-status-table tbody tr td").eq(3).text(formatNumber(result.deptAtdStatus[0]));
			$(".atd-status-table tbody tr td").eq(4).text(formatNumber(result.deptAtdStatus[1]));
			$(".atd-status-table tbody tr td").eq(5).text(formatNumber(result.deptAtdStatus[3]));
			$(".atd-status-table tbody tr td").eq(6).text(formatNumber(result.deptAtdStatus[4]));
			$(".atd-status-table tbody tr td").eq(7).text(formatNumber(result.deptAtdStatus[5]));
			$(".atd-status-table tbody tr td").eq(8).text(formatNumber(result.deptAtdStatus[6]));
			$(".atd-status-table tbody tr td").eq(9).text(formatNumber(result.deptAtdStatus[7]));
			
			
		}
	})
	
})

function formatNumber(number){
	return String(number).padStart(2, '0');
}