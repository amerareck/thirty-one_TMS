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
	minDate: new Date(),
});

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

// jstree를 이용한 조직도 로딩
$(function() {
	var path = window.location.pathname;
    console.log("페이지 경로:", path);
    
    if(path === '/thirtyone/approval/draft' || path === '/thirtyone/approval/draftSubmit' || path=== '/thirtyone/approval/settings') {
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
    
    if($('#approvalLineBox .approval-line-item').length + selectedOptions.length > 5) {
    	alert('결재자는 5인을 초과할 수 없습니다.');
    	return;
    }
    let approvalLines = '';
    for(let i=0; i<selectedValues.length; i++) {
    	let name = selectedTexts[i].split(" ")[0];
    	let position = selectedTexts[i].split(" ")[1];
    	let empid= selectedValues[i];
    	approvalLines += `
    	<div class="approval-line-item" data-deptId="${selectedDept}" data-empId="${empid}" style="width: 85%">
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
    }
    $('#approvalLineBox').append(approvalLines);
});

$('#approvalLineBox').on('click', '.btn-line-up', function(e){
	e.stopPropagation();
	const target = $(this).closest('.approval-line-item');
	target.insertBefore(target.prev());
});

$('#approvalLineBox').on('click', '.btn-line-down', function(e){
	e.stopPropagation();
	const target = $(this).closest('.approval-line-item');
	target.insertAfter(target.next());
});

$('#approvalLineBox').on('click', '.btn-line-remove', function(e){
	e.stopPropagation();
	const target = $(this).closest('.approval-line-item');
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
				    
				    for(let i=0; i<=approvalEmpId.length; i++) {
				    	const empPosition = $(contentDocument.getElementById('approvalLine-position-'+i));	
				    	const empName = $(contentDocument.getElementById('approvalLine-name-'+i));
				    	
				    	if(i==0) {
				    		empPosition.text(memberInfo.position);
				    		empName.text(memberInfo.empName);
				    		$(contentDocument.getElementById('approval-result-'+i)).text('상신');
				    		$(contentDocument.getElementById('approval-result-date-'+i)).text('('+formattedDate+')');
				    	} else {
				    		empPosition.text(approvalPosition[i-1]);
				    		empName.text(approvalNames[i-1]);
				    	}
				    }
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

$('#approvalLineCall').on('click', function(){
	if ($('#documentForm').val() === 'default') {
		alert('기안 양식을 먼저 선택해 주세요.');
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
	if ($('#documentForm').val() === 'default') {
		alert('기안 양식을 먼저 선택해 주세요.');
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
		alert('이미 존재하는 참조자입니다.');
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
    const startDay = $('#workOvertimeStartDatetime').val().split(' ')[0];
    const year = startDay.split('-')[0];
    const month = startDay.split('-')[1];
    const day = startDay.split('-')[2];
    const startTime = $('#workOvertimeStartDatetime').val().split(' ')[1];
    const hour = startTime.split(':')[0];
    const today = new Date();
    today.setHours(18, 0, 0);
    const overtime = new Date();
    overtime.setDate(parseInt(day));
    overtime.setHours(parseInt(hour), 0, 0);
    console.log(overtime);
    const totalHour = (overtime - today) / (60 * 60 * 1000);
    
    $(myElement).text(today.getFullYear()+'년\u00A0'+today.getMonth()+'월\u00A0'+today.getDate()+'일\u00A0'+today.getHours()+'시\u00A0');
    $(endElement).text(year+'년\u00A0'+month+'월\u00A0'+day+'일\u00A0'+hour+'시\u00A0(총\u00A0'+parseInt(totalHour)+'시간)');
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
	$('#draftRefSelectBox').prop('selected', true);
	const draftType = $('#documentForm').find('option:selected').val();
	console.log(draftType);
	$.ajax({
		url: "getDocNumber",
		method: "post",
		data: {draftType},
		success: function(data) {
			$('#docNumber').val(data.docNumber);
			const editor = tinymce.get('draftDocument');
		    const contentDocument = editor.getDoc();
		    const myElement = contentDocument.getElementById('draftDocumentId');
		    
		    $(myElement).text(data.docNumber);
		    $('#draftForm').submit();
		},
		error: function (xhr, status, error) {
            console.log('Error: ' + error);
        },
	});
	
});
