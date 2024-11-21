$('.btn').on('click', function () {
    $(this).blur();
});

// datetime 라이브러리 설정(flatpickr)
flatpickr("#holidayStartDate", {
	dateFormat: "Y-m-d",
	allowInput: true,
	onChange: function(selectedDates, dateStr, instance) {
		const startDate = selectedDates[0];
		const endPicker = flatpickr("#holidayEndDate", {
			dateFormat: "Y-m-d",
			allowInput: true,
			minDate: startDate
		});
		endPicker.set('minDate', startDate);
	}
});

flatpickr("#bizTripStartDate", {
	dateFormat: "Y-m-d",
	allowInput: true,
	onChange: function(selectedDates, dateStr, instance) {
	const startDate = selectedDates[0];
	const endPicker = flatpickr("#bizTripEndDate", {
		dateFormat: "Y-m-d",
	    allowInput: true,
	    minDate: startDate
	});
	endPicker.set('minDate', startDate);
	}
});

flatpickr("#holidayWorkStartDatetime", {
	dateFormat: "Y-m-d",
	locale: {
	    firstDayOfWeek: 1 // 주의 첫 날 설정 (1 = 월요일)
	},
	allowInput: true,
	//minDate: new Date(),
});
/*
wotMinDate = new Date();
wotMinDate.setHours(18, 0, 0);
wotMaxDate = new Date();
wotMaxDate.setHours(4, 0, 0);
wotMaxDate.setDate(wotMaxDate.getDate()+1);
flatpickr("#workOvertimeStartDatetime", {
	enableTime: true,
	dateFormat: "Y-m-d H:i:S",
	time_24hr: true,
	locale: {
	    firstDayOfWeek: 1 // 주의 첫 날 설정 (1 = 월요일)
	},
	allowInput: true,
	minDate: wotMinDate,
	maxDate: wotMaxDate
});
*/
/*
//Flatpickr 설정
flatpickr("#workOvertimeStartDatetime", {
    enableTime: true,
    dateFormat: "Y-m-d H:i:S",
    time_24hr: true,
    locale: {
        firstDayOfWeek: 1 // 주의 첫 날 설정 (1 = 월요일)
    },
    allowInput: true,
    onChange: function(selectedDates, dateStr, instance) {
        if (selectedDates.length > 0) {
            const selectedDate = selectedDates[0];

            // 최소일자: 선택된 날짜의 18시
            const minDate = new Date(selectedDate);
            minDate.setHours(18, 0, 0);

            // 최대일자: 선택된 날짜의 익일 04시
            const maxDate = new Date(selectedDate);
            maxDate.setDate(maxDate.getDate() + 1);
            maxDate.setHours(4, 0, 0);

            instance.set('minDate', minDate);
            instance.set('maxDate', maxDate);
        }
    },
    onOpen: function(selectedDates, dateStr, instance) {
        instance.clear();
        instance.set('minDate', null);
        instance.set('maxDate', null);
    }
});
*/
flatpickr("#workOvertimeStartDatetime", {
    enableTime: true,
    dateFormat: "Y-m-d H:i",
    time_24hr: true,
    locale: {
        firstDayOfWeek: 1 // 주의 첫 날 설정 (1 = 월요일)
    },
    allowInput: true,
    defaultHour: 0,
    defaultMinute: 0,
    onReady: enforceTimeRestrictions,
    onValueUpdate: enforceTimeRestrictions
});

function enforceTimeRestrictions(selectedDates, dateStr, instance) {
    const date = selectedDates[0];
    if (!date) return;

    const hours = date.getHours();
    if (hours > 4 && hours < 18) {
        date.setHours(18, 0, 0, 0);
        instance.setDate(date, true);
    }
}



var aprLineData;
$(function() {
	// jstree를 이용한 조직도 로딩
	var path = window.location.pathname;
    console.log("페이지 경로:", path);
    
    if(path === '/thirtyone/approval/draft' || path === '/thirtyone/approval/draftSubmit' 
    	|| path=== '/thirtyone/approval/settings' || '/thirtyone/approval/redraft') {
    	let orgChart;
    	$.ajax({
    		url: "getOrgChart",
    		method: "get",
    		success: function(data) {
    			 if (data['status'] === 'ok' && data['org-chart']) {
                     $('#orgDepartment').jstree(data['org-chart']); 
                 } else {
                     console.error('Invalid org-chart structure:', data);
                 }
    		},
    		error: function (xhr, status, error) {
                console.log('Error: ' + error);
            }
    	});
    }
    
    // 결재선 북마크 로딩
    const aprLineBookMark = $('#approvalLineSelect');
    const aprLineModalSelect = $('#approval-line');
    $.ajax({
    	url: '../emp/getAllEmpApprovalLine',
    	method: 'get',
    	success: function(data) {
    		if(!aprLineBookMark.attr('data-errors')) {
    			aprLineBookMark.empty();
    			aprLineBookMark.append('<option selected value="default">북마크 결재선 선택</option>');
    		}
    		aprLineModalSelect.empty();
    		aprLineModalSelect.append('<option selected value="default">북마크 결재선 선택</option>');
    		const names = data.aprLineNames;
    		aprLineData = data.empAPL;
    		for(let i=0; i<names.length; i++) {
    			const context = `
    				<option value="${names[i]}">${names[i]}</option>
    			`;
    			aprLineBookMark.append(context);
    			aprLineModalSelect.append(context);
    		}
    		const redraft = aprLineBookMark.attr('data-redraft');
    		console.log(redraft);
    		if (!redraft) {
    			aprLineBookMark.prop('disabled', true);
    			if(aprLineBookMark.attr('data-errors')) {
    				aprLineBookMark.prop('disabled', false);
    			}
    		}
    	},
		error: function (xhr, status, error) {
            console.log('Error: ' + error);
        }
    });
    
    // 모달 결재라인 초기화
    $('#approvalLineBox').empty();
});

$('#approval-line').on('change', function(){
	const clickAPR = $(this).val();
	const targetAPR = aprLineData[clickAPR]; // type: Array.
	const aprLineBox = $('#approvalLineBox');
	
	aprLineBox.empty();
	for(let data of targetAPR) {
		const context = `
			<div class="approval-line-item" data-deptId="${data.approverDeptId}" data-empid="${data.aprLineApprover}" data-seq="${data.aprLineSeq}" style="width: 85%">
                <div>
                    <i class="fas fa-user pe-2"></i> <b class="apl-emp-name">${data.empName}</b> <b class="apl-emp-position">${data.position}</b>
                </div>
                <div>
                    <button class="btn btn-sm btn-outline-secondary line-handler-btn btn-line-up" ><i class="fas fa-arrow-up"></i></button>
                    <button class="btn btn-sm btn-outline-secondary line-handler-btn btn-line-down" ><i class="fas fa-arrow-down"></i></button>
                    <button class="btn btn-sm btn-outline-danger line-handler-btn btn-line-remove" ><i class="fas fa-times"></i></button>
                </div>
            </div>
		`;
		aprLineBox.append(context);
	}
	
});

$('#approvalLineSelect').on('change', function() {
	const diagram = $('#approvalLineDiagram');
	const aprInfo = $('#approvalLineInfo');
	const aprNames = [];
	
	console.log(aprLineData);
	const targetName = $(this).val();
	const target = aprLineData[targetName]; // type: Array.
	diagram.empty();
	
	for(let i=0; i<target.length; i++) {
		let context = `
			<div class="custom-card text-end">
	            <div class="name-text mt-1">${target[i].empName} <span class="role-text">${target[i].position}</span></div>
	            <div class="dept-text mt-2">${target[i].approverDeptName}</div>
	        </div>
		`;
		if(i!=target.length-1) {
			context += `
				<div class="mx-3">
					<img src="/thirtyone/resources/image/approval-arrow.png" width="20px" />
				</div>
			`;
		}
		diagram.append(context);
	}
	
	// 서버 전송을 위한 select 태그에 요소 삽입.
	const selectTag = $('#approvalLineInfo').find('select');
	selectTag.empty();
	for(let i=0; i<target.length; i++) {
		selectTag.append(`
			<option selected value="${i}-${target[i].aprLineApprover}"></option>
		`);
	}
	
	// document 결재선 반영
	insertDocumentApprovalLine(target.length, target);
});

// 조직도에 따른 멤버 동적 로딩
$('#orgDepartment').on('dblclick', '.jstree-node', function(e) {
	e.stopPropagation();
    var nodeId = $(this).attr('id');
    if(nodeId === 'j1_1') return;
    console.log("더블클릭된 노드 ID:", nodeId);
    
    $.ajax({
		url: "getOrgEmp?deptId="+nodeId,
		method: "get",
		success: function(data) {
			console.log(data);
			const empList = data['empInfo'];
			let options = '';
			for(let ele of empList) {
				options += '<option value="'+ele['empId']+'">'+ele['name']+' '+ele['empPosition']+'</option>\n';
			}
			
			$('#deptEmployees').empty();
			$('#deptEmployees').html(options);
		},
		error: function (xhr, status, error) {
            console.log('Error: ' + error);
        }
	});
});

// 결재선에 추가할 사원 선택
$('#approvalLineEmpSelect').on('click', function(){
	const selectedDept = $('#orgDepartment').jstree('get_selected');
	const selectedOptions = $('#deptEmployees option:selected');
	const selectedValues = [];
	const selectedTexts = [];
    selectedOptions.each(function() {
        selectedValues.push($(this).val());
        selectedTexts.push($(this).text());
    });
    let aplLineSeq = $('.approval-line-item').length;
    
    if($('#approvalLineBox .approval-line-item').length + selectedOptions.length > 5) {
    	Swal.fire({
    		  icon: "error",
    		  title: "결재자 초과",
    		  text: "결재자는 5인을 초과할 수 없습니다.",
    	});
    	//alert('결재자는 5인을 초과할 수 없습니다.');
    	return;
    }
    let approvalLines = [];
    for(let i=0; i<selectedValues.length; i++) {
    	let name = selectedTexts[i].split(" ")[0];
    	let position = selectedTexts[i].split(" ")[1];
    	let empid= selectedValues[i];
    	approvalLines[i] = `
    	<div class="approval-line-item" data-deptId="${selectedDept}" data-empId="${empid}" data-seq="${aplLineSeq}" style="width: 85%">
            <div>
                <i class="fas fa-user pe-2"></i> <b class="apl-emp-name">${name}</b> <b class="apl-emp-position">${position}</b>
            </div>
            <div>
                <button class="btn btn-sm btn-outline-secondary line-handler-btn btn-line-up" ><i class="fas fa-arrow-up"></i></button>
                <button class="btn btn-sm btn-outline-secondary line-handler-btn btn-line-down" ><i class="fas fa-arrow-down"></i></button>
                <button class="btn btn-sm btn-outline-danger line-handler-btn btn-line-remove" ><i class="fas fa-times"></i></button>
            </div>
        </div>
    	`;
    	aplLineSeq++;
    }
    $.each(approvalLines, function(index, item) {
        $('#approvalLineBox').prepend(item);
    });
});

$('#approvalLineBox').on('click', '.btn-line-up', function(e){
	e.stopPropagation();
	const target = $(this).closest('.approval-line-item');
	const temp = target.attr('data-seq');
	target.attr('data-seq', target.prev().attr('data-seq'));
	target.prev().attr('data-seq', temp);
	target.insertBefore(target.prev());
});

$('#approvalLineBox').on('click', '.btn-line-down', function(e){
	e.stopPropagation();
	const target = $(this).closest('.approval-line-item');
	const temp = target.attr('data-seq');
	target.attr('data-seq', target.next().attr('data-seq'));
	target.next().attr('data-seq', temp);
	target.insertAfter(target.next());
});

$('#approvalLineBox').on('click', '.btn-line-remove', function(e){
    e.stopPropagation();
    const target = $(this).closest('.approval-line-item');
    let nowNode = target.next();
    
    while (nowNode.length != 0) {
        let currentSeq = parseInt(nowNode.attr('data-seq'));
        nowNode.attr('data-seq', currentSeq - 1);
        nowNode = nowNode.next();
    }
	target.remove();
});

$('#btnApprovalLineSelect').on('click', function(e) {
	const approvalNames = [];
	const approvalPosition = [];
	const approvalDeptId = [];
	const approvalEmpId = [];
	const memberInfo = {};
	let approvalDeptNames;
	
	$('#approvalLineBox').find('.approval-line-item').each(function(){
		approvalNames.push($(this).find('.apl-emp-name').text());
		approvalPosition.push($(this).find('.apl-emp-position').text());
		approvalDeptId.push($(this).attr('data-deptId'));
		approvalEmpId.push($(this).attr('data-empid'));
	});
	
	for (let i=0; i<approvalEmpId.length; i++) {
	    for (let j=i+1; j<approvalEmpId.length; j++) {
	        if (approvalEmpId[i] === approvalEmpId[j]) {
	            Swal.fire({
	                icon: "error",
	                text: "동일한 사원이 결재선에 중복하여 있을 수 없습니다.",
	            });
	            return;
	        }
	    }
	}
	
	$.ajax({
		url: 'getDeptName',
		method: "post",
		contentType: "application/json",
        data: JSON.stringify(approvalDeptId),
		success: function(data) {
			approvalDeptNames = data.deptNames;
			console.log(approvalDeptNames);
			let diagramTags = '';
			$('#approvalLineDiagram').empty();
			for(let i=0; i<approvalEmpId.length; i++) {
				diagramTags += `
					<div class="custom-card text-end">
			            <div class="name-text mt-1">${approvalNames[i]} <span class="role-text">${approvalPosition[i]}</span></div>
			            <div class="dept-text mt-2">${approvalDeptNames[i]}</div>
					</div>
				`;
				if(i != approvalEmpId.length-1) {
					diagramTags += `
						<div class="mx-3">
				            <img src="/thirtyone/resources/image/approval-arrow.png" width="20px" />
				        </div>
					`;
				}
			}
			$('#approvalLineDiagram').html(diagramTags);
			
			// 서버 전송을 위한 select 태그에 요소 삽입.
			const selectTag = $('#approvalLineInfo').find('select');
			selectTag.empty();
			for(let i=0; i<approvalEmpId.length; i++) {
				selectTag.append(`
					<option selected value="${i}-${approvalEmpId[i]}"></option>
				`);
			}
			
			// document 결재선 반영
			const docAprLine = [];
			for(let i=0; i<approvalEmpId.length; i++) {
				const empInfo = {};
				empInfo.position = approvalPosition[i];
				empInfo.empName = approvalNames[i];
				docAprLine.push(empInfo);
			}
			
			insertDocumentApprovalLine(approvalEmpId.length, docAprLine);
		},
		error: function (xhr, status, error) {
            console.log('Error: ' + error);
        },
	});
});


function insertDocumentApprovalLine(AprLineLength, aprLineData) {
	const memberInfo = {};
	$.ajax({
		url: '../emp/getUserInfo',
		method: 'get',
		success: function(data) { //어떤 자료를 받아왔는지, 쉽게 알 수 있도록 요렇게 넣습니다...
			memberInfo.empId = data.empId;
			memberInfo.empNumber = data.empNumber;
			memberInfo.empName = data.empName;
			memberInfo.empTel = data.empTel;
			memberInfo.empHiredate = data.empHiredate;
			memberInfo.deptId = data.deptId;
			memberInfo.deptName = data.deptName;
			memberInfo.position = data.position;
			
			const editor = tinymce.get('draftDocument');
		    const contentDocument = editor.getDoc();
		    const date = new Date();
		    const year = String(date.getFullYear()).slice(-2);
		    const month = String(date.getMonth() + 1).padStart(2, '0');
		    const day = String(date.getDate()).padStart(2, '0');
		    const formattedDate = `${year}-${month}-${day}`;
		    
		    for(let i=0; i<=6; i++) {
		    	const empPosition = $(contentDocument.getElementById('approvalLine-position-'+i));	
		    	const empName = $(contentDocument.getElementById('approvalLine-name-'+i));
		    	
		    	if(i==0) {
		    		empPosition.text(memberInfo.position);
		    		empName.text(memberInfo.empName);
		    		$(contentDocument.getElementById('approval-result-'+i)).text('상신');
		    		$(contentDocument.getElementById('approval-result-date-'+i)).text('('+formattedDate+')');
		    	} else if(i<=AprLineLength){
		    		empPosition.text(aprLineData[i-1].position);
		    		empName.text(aprLineData[i-1].empName);
		    	} else {
		    		empPosition.text("");
		    		empName.text("");
		    	}
		    }
		},
		error: function (xhr, status, error) {
            console.log('Error: ' + error);
        },
	});
}

$('#approvalLineCall').on('click', function(){
	if ($('#documentForm').find('option:selected').val() === 'default') {
		Swal.fire({
			  icon: "error",
			  text: "기안 양식을 먼저 선택해 주세요.",
		});
		return false;
	} else {
		$('#approvalLine').modal('show');
	}
});

$('#draftDepartmentSelect').on('change', function(){
	$('#draftReferrer').empty();
	$('#draftReferrer').removeAttr('disabled');
	$.ajax({
		url: 'getOrgEmp?deptId='+$('#draftDepartmentSelect').val(),
		method: 'get',
		success: function(data){
			$.each(data.empInfo, function(i, val){
				const tag = `
					<option value="${val.empId}" selected>${val.name} ${val.empPosition}</option>
				`;
				$('#draftReferrer').append(tag);
			});
		},
		error: function (xhr, status, error) {
            console.log('Error: ' + error);
        },
	});
});

$('#addDraftReferrer').on('click', function(){
	if ($('#documentForm').find('option:selected').val() === 'default') {
		Swal.fire({
			  icon: "error",
			  text: "기안 양식을 먼저 선택해 주세요.",
		});
		return false;
	}
	
	const selectedReferrer = $('#draftReferrer option:selected');
	let check = true;
	
	$('#draftRefSelectBox option').each(function(){
		if($(this).val() === selectedReferrer.val()) {
			check = false;
			return false;
		}
	});
	
	if(check) {
		$('#draftRefSelectBox').append(selectedReferrer.prop('outerHTML'));		
	} else {
		Swal.fire({
			  icon: "error",
			  text: "이미 존재하는 참조자입니다.",
		});
	}
	
	const editor = tinymce.get('draftDocument');
    const contentDocument = editor.getDoc();
    const myElement = contentDocument.getElementById('draftDocumentReferrer');
    
    
    if($(myElement).children().length>0) {
    	$(myElement).append(`<span id="${selectedReferrer.val()}" style="font-size: 10pt;">, ${selectedReferrer.text()}</span>`);
    } else {
    	$(myElement).append(`<span id="${selectedReferrer.val()}" style="font-size: 10pt;">${selectedReferrer.text()}</span>`);
    }
});

$('#removeDraftReferrer').on('click', function(){
	const selectedReferrer = $('#draftRefSelectBox option:selected');
	selectedReferrer.remove();
	
	const editor = tinymce.get('draftDocument');
    const contentDocument = editor.getDoc();
    const myElement = contentDocument.getElementById('draftDocumentReferrer');
    $(myElement).find(`#${selectedReferrer.val()}`).remove();
    
    const child = $(myElement).children(':first');
    child.text(child.text().replace(/, /g, ''));
});

$('#draftTitle').on('keyup', function(){
	const editor = tinymce.get('draftDocument');
    const contentDocument = editor.getDoc();
    const myElement = contentDocument.getElementById('DocumentDraftTitle');
    
    $(myElement).text($('#draftTitle').val());
});

$('#holidayStartDate').on('change', function(){
	const editor = tinymce.get('draftDocument');
    const contentDocument = editor.getDoc();
    const myElement = contentDocument.getElementById('holidayDocumentStartDay');
    
    $(myElement).text($('#holidayStartDate').val()+'\u00A0\u00A0~\u00A0');
});

$('#holidayEndDate').on('change', function(){
	const editor = tinymce.get('draftDocument');
    const contentDocument = editor.getDoc();
    const myElement = contentDocument.getElementById('holidayDocumentEndDay');
    
    $(myElement).text($('#holidayEndDate').val());
});

$('#holidayType').on('change', function(){
	const editor = tinymce.get('draftDocument');
    const contentDocument = editor.getDoc();
    const myElement = contentDocument.getElementById('holidayDocumentType');
    
    $(myElement).text($('#holidayType option:selected').text());
});

$('#bizTripStartDate').on('change', function(){
	const editor = tinymce.get('draftDocument');
    const contentDocument = editor.getDoc();
    const myElement = contentDocument.getElementById('draftBizTripStartDay');
    const startDay = $('#bizTripStartDate').val();
    const year = startDay.split('-')[0];
    const month = startDay.split('-')[1];
    const day = startDay.split('-')[2];
    
    $(myElement).text(year+'년\u00A0'+month+'월\u00A0'+day+'일\u00A0\u00A0'+'(오전/오후)\u00A0\u00A0시');
});

$('#bizTripEndDate').on('change', function(){
	const editor = tinymce.get('draftDocument');
    const contentDocument = editor.getDoc();
    const myElement = contentDocument.getElementById('draftBizTripEndDay');
    const endDay = $('#bizTripEndDate').val();
    const year = endDay.split('-')[0];
    const month = endDay.split('-')[1];
    const day = endDay.split('-')[2];
    
    if($(myElement).attr('data-no-lodgment') == 'not') {
    	$(myElement).text(year+'년\u00A0'+month+'월\u00A0'+day+'일\u00A0\u00A0'+'(오전/오후)\u00A0\u00A0시\u00A0\u00A0');    	
    } else {
    	$(myElement).text(year+'년\u00A0'+month+'월\u00A0'+day+'일\u00A0\u00A0'+'(오전/오후)\u00A0\u00A0시\u00A0\u00A0(\u00A0\u00A0박\u00A0\u00A0일)');
    }
});

$('#bizTripPurposeForm').on('keyup', function(){
	const editor = tinymce.get('draftDocument');
    const contentDocument = editor.getDoc();
    const myElement = contentDocument.getElementById('bizTripPurpose');
    
    $(myElement).text($('#bizTripPurposeForm').val());
});

$('#holidayWorkStartDatetime').on('change', function(){
	const editor = tinymce.get('draftDocument');
    const contentDocument = editor.getDoc();
    const myElement = contentDocument.getElementById('workoverDatetime');
    const startDay = $('#holidayWorkStartDatetime').val().split(' ')[0];
    const year = startDay.split('-')[0];
    const month = startDay.split('-')[1];
    const day = startDay.split('-')[2];
    
    $(myElement).text(year+'년\u00A0'+month+'월\u00A0'+day+'일 (총 8시간)');   
});

$('#workOvertimeStartDatetime').on('change', function(){
	const editor = tinymce.get('draftDocument');
    const contentDocument = editor.getDoc();
    const myElement = contentDocument.getElementById('workovertimeStart');
    const endElement = contentDocument.getElementById('workovertimeEnd');
    
    const overtime = {};
    overtime.value = $(this).val();
    overtime.year = parseInt(overtime.value.split('-')[0]);
    overtime.month = parseInt(overtime.value.split('-')[1]).toString().padStart(2, '0');
    overtime.date = parseInt(overtime.value.split('-')[2].split(' ')[0]).toString().padStart(2, '0');
    overtime.hour = parseInt(overtime.value.split(' ')[1].split(':')[0]).toString().padStart(2, '0');
    overtime.minute = parseInt(overtime.value.split(' ')[1].split(':')[1]).toString().padStart(2, '0');
    overtime.obj = new Date(overtime.year, overtime.month-1, overtime.date, overtime.hour, overtime.minute, 0);
    console.log(overtime);
    
    const startDay = new Date(overtime.obj.getTime());
    if(overtime.hour < 5) startDay.setDate(overtime.obj.getDate()-1);
    startDay.setHours(18, 0, 0);
    const year = startDay.getFullYear();
    const month = startDay.getMonth()+1;
    const day = startDay.getDate();
    const hour = startDay.getHours();
    
    const wotTime = (overtime.obj - startDay) / (60 * 60 * 1000);
    
    $(myElement).text(year+'년\u00A0'+month.toString().padStart(2, '0')+'월\u00A0'+day.toString().padStart(2, '0')+'일\u00A0'+hour.toString().padStart(2, '0')+'시\u00A0');
    $(endElement).text(overtime.year+'년\u00A0'+overtime.month+'월\u00A0'+overtime.date+'일\u00A0'+overtime.hour+'시\u00A0(총\u00A0'+parseInt(wotTime)+'시간)');
});

$('#approvalAttachFile').on('change', function(){
	const fileName = this.files[0].name;
    $('#attatchNameTag').text(fileName);
    $('#attatchNameTag').closest('div.d-none').removeClass('d-none');
});

$('#deleteAttacthFile').on('click', function(){
	$('#approvalAttachFile').val('');
	$('#attatchNameTag').closest('div').addClass('d-none');
});

// 기안서 제출 버튼
$('#draftSubmitButton').on('click', function(){
	$('#draftRefSelectBox option').prop('selected', true);
	if($('#approvalLineSelect').val() === 'default') $('#approvalLineSelect').empty();
	const draftType = $('#documentForm').find('option:selected').val();
	console.log(draftType);
	$.ajax({
		url: "getDocNumber",
		method: "post",
		data: {draftType},
		success: function(data) {
			if(data.status === 'error') {
				Swal.fire({
				  icon: "error",
				  title: "빈 문서 유형",
				  text: "문서 유형이 없어 문서 번호를 생성할 수 없습니다.",
				});
				return;
			} else {
				$('#docNumber').val(data.docNumber);
				const editor = tinymce.get('draftDocument');
			    const contentDocument = editor.getDoc();
			    const myElement = contentDocument.getElementById('draftDocumentId');
			    
			    $(myElement).text(data.docNumber);
			    $('#draftForm').submit();
			}
		},
		error: function (xhr, status, error) {
            console.log('Error: ' + error);
        },
	});
	
});

// 북마크 결재선 수정 (모달)
$('#aprLineUpdateBtn').on('click', function(){
	const lineElem = $('.approval-line-item');
	const listData = [];
	const aprName = $('#approval-line').val();
	const chageName = $('#aprLineNewName').val();
	
	lineElem.each(function(){
		const dto = {};
		dto.aprLineName = aprName;
		dto.changeName = chageName;
		dto.approverDeptId = $(this).attr('data-deptId');
		dto.aprLineApprover = $(this).attr('data-empid');
		dto.aprLineSeq = $(this).attr('data-seq');
		dto.empName = $(this).find('b.apl-emp-name').text();
		dto.position = $(this).find('b.apl-emp-position').text();
		dto.handler = 'update';
		
		listData.push(dto);
	});
	
	$.ajax({
		url: "../emp/setApprovalLine",
		method: "post",
		contentType: "application/json",
		data: JSON.stringify(listData),
		success: function(data){
			if(data.errors) {
				console.log('유효성 검증 실패, 에러 출력');
				const errorMessage = $('#aprLineValidationText');
				
				if(data.duplication) {
					errorMessage.text(data.duplication);
				} else if(data.seqError) {
					errorMessage.text(data.seqError);
				} else {
					console.log('데이터가 전송되지 않음. 서버에서 확인 요망');
				}
				
			}
			if(data.status == 'ok') {
				console.log('데이터 삽입 성공');
				const select = $('#approval-line');
				select.empty();
				$.ajax({
					url: '../emp/getAllEmpApprovalLine',
					method: 'get',
					success: function(data){
						for(let elem of data.aprLineNames) {
							const context = `
								<option ${elem === chageName ? 'selected' : ''} value="${elem}">${elem}</option>
							`;
							select.append(context);
						}
					},
					error: function (xhr, status, error) {
			            console.log('Error: ' + error);
			        },
				});
			}
		},
		error: function (xhr, status, error) {
            console.log('Error: ' + error);
        },
	});
});

$('#aprLineDeleteBtn').on('click', function(){
	const aprLineName = $('#approval-line').val();
	$.ajax({
		url: "../emp/getAprIndex",
		method: "get",
		data: {aprLineName},
		success: function(data){
			$.ajax({
				url: '../emp/deleteEmpApl',
				method: 'post',
				data: {aprLineName, aprLineIndex: data.aprIndex},
				success: function(data) {
					$('#approval-line').find('option:selected').remove();
					$('#approvalLineBox').empty();
					$('#aprLineNewName').val('');
					$('#approvalLineSelect').find('option:selected').remove();
					$('#approvalLineSelect').find('option[value="default"]').prop('selected', true);
				},
				error: function (xhr, status, error) {
		            console.log('Error: ' + error);
		        },
			});
		},
		error: function (xhr, status, error) {
            console.log('Error: ' + error);
        },
	});
});

$('#selectEmployeesFromModal').on('input', function(){
	const keyword = $(this).val();
	if(keyword.length == 0) {
		$('#deptEmployees').empty();
		return;
	}
	$.ajax({
		url: 'searchEmployees',
		method: 'get',
		data: {keyword},
		success: function(data) {
			$('#deptEmployees').empty();
			for(let item of data) {
				$('#deptEmployees').append(`
					<option value="${item.empId}">${item.empName} ${item.position}</option>
				`);
			}
		},
		error: function (xhr, status, error) {
            console.log('Error: ' + error);
        },
	});
});

$('#searchAltApprover').on('input', function(){
	const keyword = $(this).val();
	if(keyword.length == 0) {
		$('.deptEmployees').empty();
		return;
	}
	$.ajax({
		url: 'searchEmployees',
		method: 'get',
		data: {keyword},
		success: function(data) {
			$('select.deptEmployees').empty();
			for(let item of data) {
				$('select.deptEmployees').append(`
					<option value="${item.empId}">${item.empName} ${item.position}</option>
				`);
			}
		},
		error: function (xhr, status, error) {
            console.log('Error: ' + error);
        },
	});
});
