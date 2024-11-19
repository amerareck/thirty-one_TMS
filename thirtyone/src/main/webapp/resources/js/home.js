
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
	    		url: contextPath + "/holiday/myhdrCalendar",
	    		data: {'year' : todayYear , 'month' : todayMonth },
	    		success: function(data){
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
				url: contextPath + "/holiday/myhdrCalendar",
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

var options = {
	enableHighAccuracy: true,
	timeout: 5000,
	maximumAge: 0,
};

function success(pos, atd) {
	var crd = pos.coords;
	
	$.ajax({
		method: 'Get',
		url: '/thirtyone/atd/' + atd + '?' + new Date().getTime(),
		data: {
			"latitude" : crd.latitude,
			"longitude" : crd.longitude
		},
		success : function (data){
			console.log(crd);
			if(!data){
				Swal.fire({
				  icon: "error",
				  title: "지역이 다른 곳입니다.",
				  text: "해당 지역에서 버튼을 눌러주세요."
				}).then((result) => {
					  if (result.isConfirmed) {
						    location.reload(); 
					  }
				});
			
			}else{
				location.reload();
			}
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
