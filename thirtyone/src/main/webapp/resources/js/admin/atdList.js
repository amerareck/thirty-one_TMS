function formatTime(date){

	const dateTime = new Date(date);

	const hours = dateTime.getHours();
	const minutes = dateTime.getMinutes();

	return `${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}`;
}

function formatDate(date) {
	console.log(date);
    let year = date.getFullYear();
    let month = ('0' + (date.getMonth() + 1)).slice(-2); 
    let day = ('0' + date.getDate()).slice(-2);
    
    return `${year}-${month}-${day}`;
}

$(document).on("click", ".accept", function() {
	let reasonId = $(this).data("reasonid");
	let empId = $(this).data("empid");
	let atdDate = $(this).data("atddate");
	console.log(atdDate, empId, reasonId);
	$.ajax({
		method: "post",
		url: contextPath + "/atd/requsetAccept",
		data: {"reasonId": reasonId ,"empId" : empId, "atdDate": atdDate},
		success: function(data){
			alert("승인되었습니다.");
			location.reload();
		}
	})
})