document.addEventListener('DOMContentLoaded', function () {
/*
 * var calendarEl = document.getElementById('calendar');
 * 
 * var calendar = new FullCalendar.Calendar(calendarEl, { initialView:
 * 'dayGridMonth', initialDate: '2024-10-20', headerToolbar: { left: 'prev',
 * center: 'title', right: 'next' }, events: [
 *  { title: '정원석 휴가', start: '2024-10-11', end: '2024-10-13' }, { title: '서지혜
 * 휴가', start: '2024-10-12', end: '2024-10-16' },
 *  ] });
 * 
 * calendar.render();
 */
	
	$(document).on("click", ".requestAccept", function() {
		let hdrId = $(this).data("hdrid");
		let hdCategory = $(this).data("hdcategory");
		let empId = $(this).data("empid");
		console.log(empId);
				
		Swal.fire({
			title: '휴가 신청을 승인하시겠습니까?',
			text: '확인을 누르면 휴가 신청이 승인됩니다.',
			icon: 'warning',
			
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			confirmButtonText: '확인',
			cancelButtonText: '취소',
			
			reverseButtons: true
		
		}).then(result => {
			$.ajax({
				method: "POST",
				url: contextPath + "/holiday/hdrAccept",
				data: {"hdrId" : hdrId, "status" : '승인', "hdCategory" : hdCategory, "empId" : empId},
				success: function(data) {
					if (result.isConfirmed) {
						Swal.fire({
							title: '휴가 신청이 승인되었습니다.', 
							icon: 'success'
						}).then(() => {
							location.reload();
						});
					}
				}
			});

		
		});
	});
	
	$(document).on("click", ".requestReject", function() {
		let hdrId = $(this).data("hdrid");
		let hdCategory = $(this).data("hdcategory");
		let empId = $(this).data("empid");
		console.log("hdrId: ", hdrId);
//		$.ajax({
//			method: "POST",
//			url: contextPath + "/holiday/hdrAccept",
//			data: {"hdrId" : hdrId, "status" : '반려', "hdCategory" : hdCategory, "empId" : empId},
//			success: function(data) {
		Swal.fire({
			title: '휴가 신청을 반려하시겠습니까?',
			text: '확인을 누르면 휴가 신청이 반려됩니다.',
			icon: 'warning',
			
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			confirmButtonText: '확인',
			cancelButtonText: '취소',
			
			reverseButtons: true
		
		}).then(result => {
			$.ajax({
				method: "POST",
				url: contextPath + "/holiday/hdrAccept",
				data: {"hdrId" : hdrId, "status" : '반려', "hdCategory" : hdCategory, "empId" : empId},
				success: function(data) {
					if (result.isConfirmed) {
						Swal.fire({
							title: '휴가 신청이 반려되었습니다.', 
							icon: 'success'
						}).then(() => {
							location.reload();
						});
					}
				}
			
			});
		})
//	});
	});
});