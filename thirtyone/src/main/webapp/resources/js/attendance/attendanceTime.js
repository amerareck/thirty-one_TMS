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
			
			drawGraph(data);
			
			$(".worktime-info").empty();
			console.log(data.reasonList);
			data.reasonList.forEach(function (reason){
				reason.atdDate = formatMonthDay(reason.atdDate);
			})
		
			data.atdList.forEach(function(atd) {
				let formattedMonthDay = formatMonthDay(atd.atdDate);
				
				let button = `<td><img class="atd-request-form" src="${contextPath}/resources/image/icon/doc.svg" data-bs-toggle="modal" data-bs-target="#atdRequestModal"></td>`
				if(atd.atdState === '정상출근' || atd.atdState === '휴가' || atd.atdState === '출장')
					button = `<td><img class="atd-request-form" src="${contextPath}/resources/image/icon/doc.svg" style="cursor: default"></td>`
				data.reasonList.forEach(function (reason) {
					if(formattedMonthDay === reason.atdDate){
						const status = reason.reasonStatus;
						if(status === '대기'){
							button = `<td><img class="atd-request-form update-req-form" src="${contextPath}/resources/image/icon/doc-selected.svg" data-reasonid='${reason.reasonId}'></td>`
						}else if(status === '승인'){
							button = `<td><img class="atd-request-form" src="${contextPath}/resources/image/icon/doc-accept.svg" style="cursor: default;"></td>`
						}else if(status === '반려'){
							button = `<td><img class="atd-request-form update-req-form" src="${contextPath}/resources/image/icon/doc-reject.svg" data-reasonid='${reason.reasonId}'></td>`							
						}
					}
				})
				let formattedCheckIn = atd.checkIn !== null ? formatTime(atd.checkIn) : "--:--";
				let formattedCheckOut = atd.checkOut !== null ? formatTime(atd.checkOut) : "--:--";
				let formattedOverTime = atd.atdOverTime;
				let formattedStandardTime = atd.atdStandardTime !== null ? `${atd.atdStandardTime}시간 00분` : "0시간00분";
				let atdState = atd.atdState !== null ? atd.atdState : "-";
				let atdHtml =`
					<tr>
					  <th scope="row">${formattedMonthDay}</th>
					  <td class="atd-state" data-state="${atdState}">${atdState}</td>
					  <td class="request-checkin" data-checkin="${atd.checkIn}">${formattedCheckIn}</td>
					  <td class="request-checkout" data-checkout="${atd.checkOut}">${formattedCheckOut}</td>
					  <td>${formattedOverTime}</td>
					  <td>${formattedStandardTime}</td>
					  <td><img src="${contextPath}/resources/image/icon/clock.svg"></td>`
					  + button+ "</tr>";
			    
			    $(".worktime-info").append(atdHtml); 
			})
			
			
		}
	})
}

$(document).on('click', ".atd-request-form", function(){
	let checkIn = $(this).closest('tr').find(".request-checkin").data('checkin');
	let checkOut = $(this).closest('tr').find(".request-checkout").data('checkout');
	let state = $(this).closest('tr').find(".atd-state").data('state');
	let checkInDate = new Date(checkIn);
	let checkOutDate = new Date(checkOut);
	
	let formatedCheckIn = checkIn !== null ? formatDate(checkInDate) + " " + formatTime(checkIn) : "--:--" ;
	let formatedCheckOut = checkOut !== null ? formatDate(checkOutDate) + " " + formatTime(checkOut) : "--:--";
	
	$(".file-list").empty();
	$("#checkIn").val(formatedCheckIn);
	$("#checkOut").val(formatedCheckOut);
	$("#update-checkIn").val(formatedCheckIn);
	$("#update-checkOut").val(formatedCheckOut);
	$(".accept").data('state', state);
	$(".update-accept").data('state', state);

})

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

$(document).on("click", ".update-req-form", function (){
	deleteFileList = [];
	const reasonid = $(this).data('reasonid');
	$.ajax({
		method: "get",
		url: contextPath+"/atd/reasonReqInfo",
		data : {"reasonId":reasonid},
		success: function (data) {
			
			let fileListHtml = "";
	        data.fileList.forEach((file, index) => {
	            fileListHtml += `<div id="file${file.docFileId}">
	            					<p>${file.docFileName}</p>
	            					<a href="attachDownload?fileId=${file.docFileId}">
		            					<i class="bi bi-download"></i>
	            					</a>
	            					<a class="delete" onclick="deleteFilebyDown(${file.docFileId});">
	            					 	<i class="bi bi-x-circle"></i>
	        					 	</a>
        					 	</div>`;
	        });
	        $('.update-file-list').empty();
	        $('.update-file-list').append(fileListHtml);
			$('#update-reason').val(data.reason.reasonContent);
			$('.update-accept').text("수정");
			$('.update-accept').data('reasonid', reasonid);
			$('#atdUpdateModal').modal('show');
		}
		
			
	})
})

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
    return value - 10; 
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

var fileNo = 0;
var filesArr = new Array();

/* 첨부파일 추가 */
function addFile(obj){
    var maxFileCnt = 5;   // 첨부파일 최대 개수
    var attFileCnt = document.querySelectorAll('.filebox').length;    // 기존 추가된 첨부파일 개수
    var remainFileCnt = maxFileCnt - attFileCnt;    // 추가로 첨부가능한 개수
    var curFileCnt = obj.files.length;  // 현재 선택된 첨부파일 개수

    // 첨부파일 개수 확인
    if (curFileCnt > remainFileCnt) {
        alert("첨부파일은 최대 " + maxFileCnt + "개 까지 첨부 가능합니다.");
    }

    for (var i = 0; i < Math.min(curFileCnt, remainFileCnt); i++) {

        const file = obj.files[i];

        // 첨부파일 검증
        if (validation(file)) {
            // 파일 배열에 담기
            var reader = new FileReader();
            reader.onload = function () {
                filesArr.push(file);
            };
            reader.readAsDataURL(file)

            // 목록 추가
            let htmlData = '';
            htmlData += '<div id="file' + fileNo + '" class="filebox">';
            htmlData += '   <p class="name">' + file.name + '</p>';
            htmlData += '   <a class="delete" onclick="deleteFile(' + fileNo + ');"><i class="bi bi-x-circle"></i></a>';
            htmlData += '</div>';
            $('.file-list').append(htmlData);
            $('.update-file-list').append(htmlData); 
            fileNo++;
        } else {
            continue;
        }
    }
    // 초기화
    document.querySelector("input[type=file]").value = "";
}

/* 첨부파일 검증 */
function validation(obj){
    const fileTypes = ['application/pdf', 'image/gif', 'image/jpeg', 'image/png', 'image/bmp', 'image/tif', 'application/haansofthwp', 'application/x-hwp'];
    if (obj.name.length > 100) {
        alert("파일명이 100자 이상인 파일은 제외되었습니다.");
        return false;
    } else if (obj.size > (100 * 1024 * 1024)) {
        alert("최대 파일 용량인 100MB를 초과한 파일은 제외되었습니다.");
        return false;
    } else if (obj.name.lastIndexOf('.') == -1) {
        alert("확장자가 없는 파일은 제외되었습니다.");
        return false;
    } else if (!fileTypes.includes(obj.type)) {
        alert("첨부가 불가능한 파일은 제외되었습니다.");
        return false;
    } else {
        return true;
    }
}

/* 첨부파일 삭제 */
function deleteFile(num) {
    document.querySelector("#file" + num).remove();
    filesArr[num].is_delete = true;
}


/* 폼 전송 */
function submitForm(e) {
	e.preventDefault();
	let state = $('.accept').data('state');
	
	console.log(state);
    // 폼데이터 담기
    let form = document.querySelector(".reason-report");
    let formData = new FormData(form);
    let newFormData = new FormData();
    
    newFormData.append("state", state);
    for (var i = 0; i < filesArr.length; i++) {
        // 삭제되지 않은 파일만 폼데이터에 담기
        if (!filesArr[i].is_delete) {
            newFormData.append("attachFiles", filesArr[i]);
        }
    }
    
    for( let[key, value] of formData.entries()){
    	if(key !== "formFile")
    		newFormData.append(key, value);
    }
    
    for (let [key, value] of newFormData.entries()) {
        console.log(key, value); // 각 키와 값이 출력됩니다.
    }
    
    $.ajax({
        method: 'POST',
        url: contextPath + '/atd/reasonRequest',
        dataType: 'json', 
        processData: false,
        contentType: false,
        data: newFormData,
        success: function (data) {
        	if(data)
        		location.reload();
        	else 
        		alert("이미 제출한 사유서 입니다.");
        	
        },
        error: function (xhr, desc, err) {
            alert('에러가 발생 하였습니다.');
            return;
        }
    })
}

let deleteFileList = [];
function deleteFilebyDown(fileId){
	deleteFileList.push(fileId);
	$("#file"+fileId).remove();
}

function updateForm(event){
	event.preventDefault();
	let state = $('.update-accept').data('state');
	let reasonid = $('.update-accept').data('reasonid');
	console.log("check", state);
	console.log("checkReasonId", reasonid);
    // 폼데이터 담기
    let form = document.querySelector(".update-reason-report");
    let formData = new FormData(form);
    let newFormData = new FormData();
    
    newFormData.append("state", state);
    newFormData.append('reasonId', reasonid);
    for (var i = 0; i < filesArr.length; i++) {
        // 삭제되지 않은 파일만 폼데이터에 담기
        if (!filesArr[i].is_delete) {
            newFormData.append("attachFiles", filesArr[i]);
        }
    }
    newFormData.append("deleteFileList", deleteFileList);
    for( let[key, value] of formData.entries()){
    	if(key !== "formFile")
    		newFormData.append(key, value);
    }
    
    for (let [key, value] of newFormData.entries()) {
        console.log(key, value); // 각 키와 값이 출력됩니다.
    }
    
    $.ajax({
        method: 'POST',
        url: contextPath + '/atd/reasonUpdate',
        dataType: 'json', 
        processData: false,
        contentType: false,
        data: newFormData,
        success: function (data) {
        	if(data){
        		location.reload();
        	}else 
        		alert("이미 제출한 사유서 입니다.");
        	
        },
        error: function (xhr, desc, err) {
            alert('에러가 발생 하였습니다.');
            return;
        }
    })
}



