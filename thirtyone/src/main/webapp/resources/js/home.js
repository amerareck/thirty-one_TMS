       
document.addEventListener('DOMContentLoaded', function() {

//	$('.main-container').css({
//		'box-shadow': 'none',
//		'margin': '0px'
//	})
//	$('.main-line').css('display', 'none');
//	
	updateToday("true");
	updateClock("true");
	
	setInterval(function() {
		updateClock("true");
	}, 1000);
	
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

var options = {
	enableHighAccuracy: true,
	timeout: 5000,
	maximumAge: 0,
};

function success(pos, atd) {
	var crd = pos.coords;
	console.log(atd);
	
	$.ajax({
		method: 'Get',
		url: '/thirtyone/atd/' + atd,
		data: {
			"latitude" : crd.latitude,
			"longitude" : crd.longitude
		},
		success : function (data){
			if(!data)
				alert("지역이 다릅니다.");
			location.reload();
		},
		error : function (request, status, error){
					  
		}
	})

}

function error(err) {
  console.warn(`ERROR(${err.code}): ${err.message}`);
}	
		

$(".start-time-btn").on("click", function(){ 
	navigator.geolocation.getCurrentPosition((pos) => success(pos, "checkIn"), error, options);
});

$(".end-time-btn").on("click", function(){ 
	navigator.geolocation.getCurrentPosition((pos) => success(pos, "checkOut"), error, options);
});
