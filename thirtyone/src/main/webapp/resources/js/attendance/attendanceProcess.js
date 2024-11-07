function formatTime(date){

	const dateTime = new Date(date);

	const hours = dateTime.getHours();
	const minutes = dateTime.getMinutes();

	return `${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}`;
}

function formatDate(date) {
    let year = date.getFullYear();
    let month = ('0' + (date.getMonth() + 1)).slice(-2); 
    let day = ('0' + date.getDate()).slice(-2);
    
    return `${year}-${month}-${day}`;
}

$(document).on("click", ".accept", function() {
	let reasonId = $(".accept").data("reasonid");
	let empId = $(".accept").data("empid");
	let atdDate = formatDate(new Date($(this).data("atddate")));
	
	$.ajax({
		method: "post",
		url: contextPath + "/atd/requsetStatus",
		data: {"reasonId": reasonId ,"empId" : empId, "atdDate": atdDate, "status": '승인'},
		success: function(data){
			alert("승인되었습니다.");
			location.reload();
		}
	})
})
$(document).on("click", ".reject", function() {
	let reasonId = $(".reject").data("reasonid");
	let empId = $(".reject").data("empid");
	let atdDate = formatDate(new Date($(this).data("atddate")));
	
	$.ajax({
		method: "post",
		url: contextPath + "/atd/requsetStatus",
		data: {"reasonId": reasonId ,"empId" : empId, "atdDate": atdDate, "status": '반려'},
		success: function(data){
			alert("반려되었습니다.");
			location.reload();
		}
	})
})

$(document).on("click", ".process-tr", function() {
	
	let empId = $(this).data("empid");
	let reasonId = $(this).data("reasonid");
	$.ajax({
		method:"get",
		url : contextPath + "/atd/getRequestReason",
		data: {"empId" : empId, "reasonId": reasonId},
		success:function (data){
			let checkIn = formatDate(new Date(data.atd.checkIn)) + " " +formatTime(data.atd.checkIn);
			let checkOut = formatDate(new Date(data.atd.checkOut)) + " " +formatTime(data.atd.checkOut);
			
			let fileListHtml = "";
	        data.fileList.forEach(file => {
	            fileListHtml += `<a href="attachDownload?fileId=${file.docFileId}">${file.docFileName}</a>`;
	        });
			
			const html = `
				<p class="mini-title">사유서</p>
				<div class="mini-line"></div>
				<div class="reason-report" method="post">
					<div>
						<label for="empName">이름</label>
						<input type="text" class="form-control" id="empName" value="${data.emp.empName} ${data.emp.position}" disabled>
					</div>
					<div>
						<label for="empDept">부서</label>
						<input type="text" class="form-control" id="empDept" value="${data.deptName}" disabled>
					</div>
					<div>
						<label for="empName">출근 시간</label>
						<input type="datetime" class="form-control" id="empName" value="${checkIn}" disabled>
					</div>
					<div>
						<label for="empName">퇴근 시간</label>
						<input type="datetime" class="form-control" id="empName" value="${checkOut}" disabled>
					</div>
					<div>
					  	<label for="formFile" class="form-label">첨부 파일</label>
					  	<div class="file-list">
						  	${fileListHtml}
					  	</div>
					</div>
					<div>
					  <label for="reason" class="form-label reason">사유</label>
					  <textarea class="form-control" id="reason" rows="6" disabled>${data.reason.reasonContent}</textarea>
					</div>
					<div class="button-box">
						<button class="button-large reject" data-reasonid="${data.reason.reasonId}" data-empid="${data.reason.empId}" data-atddate="${data.reason.atdDate}">반려</button>
						<button class="button-large accept" data-reasonid="${data.reason.reasonId}" data-empid="${data.reason.empId}" data-atddate="${data.reason.atdDate}">승인</button>
					</div>
				</div>`
				$('.reason-report-box').empty();
				$('.reason-report-box').append(html);
		}
	})
})