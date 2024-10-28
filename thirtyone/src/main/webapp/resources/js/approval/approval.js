// jstree를 이용한 조직도 로딩
$(function() {
	var path = window.location.pathname;
    console.log("페이지 경로:", path);
    
    if(path === '/thirtyone/approval/draft') {
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
					<option value="${val.empId}">${val.name} ${val.empPosition}</option>
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
    const myElement = contentDocument.getElementById('holidayDocumentReferrer');
    
    
    if($(myElement).children().length>0) {
    	$(myElement).append(`<span id="${selectedReferrer.val()}">, ${selectedReferrer.text()}</span>`);
    } else {
    	$(myElement).append(`<span id="${selectedReferrer.val()}">${selectedReferrer.text()}</span>`);
    }
});

$('#removeDraftReferrer').on('click', function(){
	const selectedReferrer = $('#draftRefSelectBox option:selected');
	selectedReferrer.remove();
	
	const editor = tinymce.get('draftDocument');
    const contentDocument = editor.getDoc();
    const myElement = contentDocument.getElementById('holidayDocumentReferrer');
    $(myElement).find(`#${selectedReferrer.val()}`).remove();
    
    const child = $(myElement).children(':first');
    child.text(child.text().replace(/, /g, ''));
});

$('#draftTitle').on('keyup', function(){
	const editor = tinymce.get('draftDocument');
    const contentDocument = editor.getDoc();
    const myElement = contentDocument.getElementById('holidayDocumentTitle');
    
    $(myElement).text($('#draftTitle').val());
});

$('#holidayStartDate').on('change', function(){
	const editor = tinymce.get('draftDocument');
    const contentDocument = editor.getDoc();
    const myElement = contentDocument.getElementById('holidayDocumentStartDay');
    
    $(myElement).text($('#holidayStartDate').val()+'  ~ ');
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
