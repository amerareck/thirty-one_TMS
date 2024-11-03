$('#approvalLineSettingSaveBtn').on('click', function(){
	const aplForm = [];
	$('.approval-line-item').each(function(){
		const element = {};
		element.aprLineName = $(approvalLineSettingNameForm).val();
		element.approverDeptId = $(this).attr('data-deptId');
		element.aprLineApprover = $(this).attr('data-empid');
		element.aprLineSeq = $(this).attr('data-seq');
		
		element.empName = $(this).find('.apl-emp-name').text();
		element.position = $(this).find('.apl-emp-position').text();
		
		aplForm.push(element);
	});
	console.log(aplForm);
	
	$.ajax({
		url: "../emp/setApprovalLine",
		method: "post",
		contentType: "application/json",
		data: JSON.stringify(aplForm),
		success: function(data){
			if(data.errors) {
				console.log('유효성 검증 실패, 에러 출력');
				const errorMessage = $('#approvalLineFormValidation');
				
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
			}
		},
		error: function (xhr, status, error) {
            console.log('Error: ' + error);
        },
	});
});