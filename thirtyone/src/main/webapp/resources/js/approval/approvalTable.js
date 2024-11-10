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

$('.approveSubmit').on('click', function(e){
	e.stopPropagation();
	const index = $(this).closest('.approveModal').find('.approve-modal-index').text();
	const reviewerInfo = $(this).closest('.approveModal').find('div.reviewer-info');
	const reviewerSeq = parseInt(reviewerInfo.attr('data-seq'))+1;
	const approvalData = {};
	const approvalTotalSeq = $('#approveComment-'+index).attr('data-seq-count');
	approvalData.docNumber = $('#documentContext-'+index).attr('data-docnumber');
	approvalData.approvalResult = $(this).closest('.approveModal').find('select.approval-result').val();
	approvalData.approvalType = $(this).closest('.approveModal').find('select.approval-type').val();
	approvalData.approvalComment = $(this).closest('.approveModal').find('textarea.approval-comment').val();
	approvalData.approvalSeq = reviewerSeq-1;
	const docType = approvalData.docNumber.split('-')[0];
	
	const editor = tinymce.get('documentContext-'+index);
    const contentDocument = editor.getDoc();
    const date = new Date();
    const year = String(date.getFullYear()).slice(-2);
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    const formattedDate = `${year}-${month}-${day}`;
    
    const empPosition = $(contentDocument.getElementById('approvalLine-position-'+reviewerSeq));	
	const empName = $(contentDocument.getElementById('approvalLine-name-'+reviewerSeq));
	//empPosition.text(reviewerInfo.attr('data-postion'));
	//empName.text(reviewerInfo.attr('data-name'));
	$(contentDocument.getElementById('approval-result-'+reviewerSeq)).text(approvalData.approvalResult);
	$(contentDocument.getElementById('approval-result-date-'+reviewerSeq)).text('('+formattedDate+')');
    
	const cssClass = docType === 'HLD' ? 'c1' : 'BTD' ? 'c0' : 'BTR' ? 'c0' : 'HLW' ? 'c0' : 'c2';
    if(approvalData.approvalType === '선결') {
    	for(let i=reviewerSeq-1; i>0; i--) {
    		const aprResult = $(contentDocument.getElementById('approval-result-'+i)).text().trim();
    		if(aprResult === '') {
    			$(contentDocument.getElementById('approval-result-'+i)).text("후열");
    			$(contentDocument.getElementById('approval-result-date-'+i)).text('('+formattedDate+')');
    		}
        }
    	for(let i=reviewerSeq+1; i<=approvalTotalSeq; i++) {
    		$(contentDocument.getElementById('approval-result-' + i)).text("위임");
    		$(contentDocument.getElementById('approval-result-date-' + i)).text('(' + formattedDate + ')');
    	}
    	$(contentDocument.getElementById('approval-result-'+reviewerSeq)).before(`
    		<span id="approval-result-type-${reviewerSeq}" class="${cssClass}" style="font-size: .75rem;">[선결]</span>
    		<br/>
    	`);
    }
    
    if(approvalData.approvalType === '전결') {
    	for(let i=reviewerSeq+1; i<=approvalTotalSeq; i++) {
    		$(contentDocument.getElementById('approval-result-'+i)).text("위임");
			$(contentDocument.getElementById('approval-result-date-'+i)).text('('+formattedDate+')');
    	}
    	
    	$(contentDocument.getElementById('approval-result-'+reviewerSeq)).before(`
    		<span id="approval-result-type-${reviewerSeq}" class="${cssClass}" style="font-size: .75rem;>[전결]</span>
    		<br/>
    	`);
    }
    
    if(approvalData.approvalType === '대결') {
    	$(contentDocument.getElementById('approval-result-'+reviewerSeq)).before(`
    		<span id="approval-result-type-${reviewerSeq}" class="${cssClass}" style="font-size: .75rem;>[대결]</span>
        `);
    	$(contentDocument.getElementById('approval-result-'+reviewerSeq)).before(`
    		<br/>
    		<span id="approval-result-empName-${reviewerSeq}" class="${cssClass}">${reviewerInfo.attr('data-name')} ${reviewerInfo.attr('data-postion')}</span>
    		<br/>
        `);
    }
    
    if(approvalData.approvalResult === '반려') {
    	for(let i=reviewerSeq+1; i<=approvalTotalSeq; i++) {
    		$(contentDocument.getElementById('approval-result-' + i)).text("위임");
    		$(contentDocument.getElementById('approval-result-date-' + i)).text('(' + formattedDate + ')');
    	}
    }
	
	approvalData.docData = editor.getContent();
	console.log(approvalData);
	
	$.ajax({
		url: "submitApproval",
		method: "post",
		data: JSON.stringify(approvalData),
		contentType: "application/json",
		success: function(data) {
			if(data.status == 'no-authority') {
				alert(data.message);
			} else if(data.status == 'no-approval-seq') {
				alert(data.message);
			} else if(data.status == 'ok') {
				location.href = 'approveList?type=ready&pageNo=1';
			}
		},
		error: function (xhr, status, error) {
            console.log('Error: ' + error);
		},
	});
});

$('.approval-type').on('change', function(){
	const target = $(this).val();
	const targetDiv = $(this).closest('.d-flex.justify-content-between.w-100.p-2.my-2').find('.approval-result');
	if(target !== '전결') {
		targetDiv.prop('disabled', false);
	} else {
		targetDiv.find('option:selected').prop('selected', false);
		targetDiv.find('option[value="승인"]').prop('selected', true);
		targetDiv.prop('disabled', true);
	}
	
	if(target !== '선결') {
		targetDiv.prop('disalbed', false);
	} else {
		targetDiv.find('option:selected').prop('selected', false);
		targetDiv.find('option[value="승인"]').prop('selected', true);
		targetDiv.prop('disabled', true);
	}
});




