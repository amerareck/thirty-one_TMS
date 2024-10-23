document.addEventListener('DOMContentLoaded', function () {
	const ctx = document.getElementById('attendance-rate').getContext('2d');
	const ctx2 = document.getElementById('emp-rate').getContext('2d');
	
	new Chart(ctx,{
		type: 'doughnut',
		data: {
			labels: [
			'출근',
		    '결근'
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

                const text2 = "74%";
                const fontSize2 = (height / 8).toFixed(2); 
                ctx.font = "bold " + fontSize2 + "px 'Roboto'";
                const textX2 = Math.round((width - ctx.measureText(text2).width) / 2);
                const textY2 = height / 2 + 15; 
                ctx.fillText(text2, textX2, textY2);

                ctx.save();
            }
        }]
	})
	
	new Chart(ctx2,{
		type: 'doughnut',
		data: {
			labels: [
				'근무중',
				'자리비움'
				],
				datasets: [{
					label: 'My First Dataset',
					data: [11, 2],
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
				
				const text1 = "출근자";
				const fontSize1 = (height / 15).toFixed(2); 
				ctx.font = fontSize1 + "px 'Noto Sans'"; 
				ctx.textBaseline = "middle";
				const textX1 = Math.round((width - ctx.measureText(text1).width) / 2);
				const textY1 = height / 2 - 20; 
				ctx.fillStyle = 'rgb(31, 95, 255)', 
				ctx.fillText(text1, textX1, textY1);
				
				const text2 = "13명";
				const fontSize2 = (height / 8).toFixed(2); 
				ctx.font = "bold " + fontSize2 + "px 'Roboto'";
				const textX2 = Math.round((width - ctx.measureText(text2).width) / 2);
				const textY2 = height / 2 + 15; 
				ctx.fillText(text2, textX2, textY2);
				
				ctx.save();
			}
		}]
	})
	
})