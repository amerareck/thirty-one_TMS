$('.recalled-document').on('click', function(){
	if(!confirm('문서를 회수하시겠습니까?\n회수한 문서는 결재 진행을 하지 않습니다.')) return;
	
	const docNumber = $(this).closest('tr').find('td.docNumber').text();
	$.ajax({
		url: 'updateDocAprStatus',
		method: 'post',
		data: JSON.stringify({docNumber}),
		contentType: "application/json",
		success: function(data){
			if(data.status == 'ok') {
				location.href = 'submitted?type=retrieval&pageNo=1';
			} else {
				alert(data.message);
			}
		},
		error: function (xhr, status, error) {
            console.log('Error: ' + error);
        },
	});
});

$('.re-draft').on('click', function(){
	if(!confirm('다시 재상신하시겠습니까?\n다시 상신한 문서는 문서번호가 새로 발급되며,\n기존 문서는 폐기됩니다.')) return;
	
	const docNumber = $(this).closest('tr').find('td.docNumber').text();
	location.href = 'redraft?docNumber='+docNumber;
});

$('.deactivation').on('click', function(){
	if(!confirm('폐기된 문서는 복구할 수 없습니다.\n정말로 문서를 폐기하시겠습니까?')) return;
	
	const docNumber = $(this).closest('tr').find('td.docNumber').text();
	$.ajax({
		url: 'deleteDoc',
		method: 'post',
		data: JSON.stringify({docNumber}),
		contentType: "application/json",
		success: function(data){
			if (data.status=='ok') {
				location.href = 'submitted?type=retrieval&pageNo=1';
			} else if (data.status=='impossible') {
				alert(data.message);
			}
		},
		error: function (xhr, status, error) {
            console.log('Error: ' + error);
        },
	});
})