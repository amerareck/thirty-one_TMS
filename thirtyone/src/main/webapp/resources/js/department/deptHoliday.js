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

document.addEventListener('DOMContentLoaded', function () {
//	var calendarEl = document.getElementById('calendar');

//	var calendar = new FullCalendar.Calendar(calendarEl, {
//	    initialView: 'dayGridMonth',
//	    initialDate: '2024-10-20',
//	    headerToolbar: {
//	      left: 'prev',
//	      center: 'title',
//	      right: 'next'
//	    },
//	    events: [
//	      
//	      {
//	        title: '정원석 휴가',
//	        start: '2024-10-11',
//	        end: '2024-10-13'
//	      },
//	      {
//	        title: '서지혜 휴가',
//	        start: '2024-10-12',
//	        end: '2024-10-16'
//	      },
//	
//	    ]
//	});
	var calendarEl = document.getElementById('calendar');
	let today = new Date();
	let todayYear = today.getFullYear();
	let todayMonth = ('0' + (today.getMonth() + 1)).slice(-2);
	
	
	var calendar = new FullCalendar.Calendar(calendarEl, {
	    initialView: 'dayGridMonth',
	    initialDate: formatDate(today),
	    headerToolbar: {
	      left: 'prev',
	      center: 'title',
	      right: 'next'
	    },
	    events: function (fetchInfo, successCallback, failureCallback){
	    	$.ajax({
	    		method: "get",
	    		url: contextPath + "/dept/deptHoliday",
	    		data: {'year' : todayYear , 'month' : todayMonth },
	    		success: function(data){
	    			console.log(data);
	    			successCallback(data);
	    		},
	            error: function() {
	                failureCallback();
	            }
	    	})
	    },
	    dataSet: function(info){
			var currentDate = calendar.getDate();
            var month = currentDate.getMonth()+1;
            var year = currentDate.getFullYear();
            
            $.ajax({
				method: "get",
				url: contextPath + "/dept/deptHoliday",
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
	    }
	});
	
	calendar.render();
	
});