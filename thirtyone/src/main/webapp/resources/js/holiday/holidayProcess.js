document.addEventListener('DOMContentLoaded', function () {
/*	var calendarEl = document.getElementById('calendar');

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
	        title: '정원석 휴가',
	        start: '2024-10-11',
	        end: '2024-10-13'
	      },
	      {
	        title: '서지혜 휴가',
	        start: '2024-10-12',
	        end: '2024-10-16'
	      },
	
	    ]
	});
	
	calendar.render();*/
	
	$(document).on("click", ".requestAccept", function() {
		let hdrId = $(this).data("hdrid");
		let hdCategory = $(this).data("hdcategory");
		let empId = $(this).data("empid");
		console.log(empId);
		$.ajax({
			method: "POST",
			url: contextPath + "/holiday/hdrAccept",
			data: {"hdrId" : hdrId, "status" : '승인', "hdCategory" : hdCategory, "empId" : empId},
			success: function(data) {
				alert("승인되었습니다.");
				location.reload();
			}
		})
	})
	
	$(document).on("click", ".requestReject", function() {
		let hdrId = $(this).data("hdrid");
		console.log("hdrId: ", hdrId);
		$.ajax({
			method: "POST",
			url: contextPath + "/holiday/hdrAccept",
			data: {"hdrId" : hdrId, "status" : '반려'},
			success: function(data) {
				alert("반려되었습니다.");
				location.reload();
			}
		})
	})
	
});