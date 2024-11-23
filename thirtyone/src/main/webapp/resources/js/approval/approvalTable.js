$('.recalled-document').on('click', function(){
	Swal.fire({
		  title: "문서를 회수하시겠습니까?",
		  text: "회수한 문서는 결재 진행을 하지 않습니다.",
		  icon: "warning",
		  showCancelButton: true,
		  confirmButtonColor: "#3085d6",
		  cancelButtonColor: "#d33",
		  confirmButtonText: "회수",
		  cancelButtonText: "취소"
		}).then((result) => {
		  if (result.isConfirmed) {
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
							Swal.fire({
								  icon: "error",
								  title: "회수 불가 문서",
								  text: data.message,
								});
						}
					},
					error: function (xhr, status, error) {
			            console.log('Error: ' + error);
			        },
				});
		  }
		});
});

$('.re-draft').on('click', function(){
	Swal.fire({
		  title: "다시 재상신하시겠습니까?",
		  text: "다시 상신한 문서는 문서번호가 새로 발급되며,\n기존 문서는 폐기됩니다.",
		  icon: "warning",
		  showCancelButton: true,
		  confirmButtonColor: "#3085d6",
		  cancelButtonColor: "#d33",
		  confirmButtonText: "재작성",
		  cancelButtonText: "취소"
		}).then((result) => {
		  if (result.isConfirmed) {
			  const docNumber = $(this).closest('tr').find('td.docNumber').text();
			  //location.href = 'redraft?docNumber='+docNumber;
		  }
		});
});

$('.deactivation').on('click', function(){
	Swal.fire({
		  title: "정말로 문서를 폐기하시겠습니까?",
		  text: "폐기된 문서는 복구할 수 없습니다.",
		  icon: "warning",
		  showCancelButton: true,
		  confirmButtonColor: "#3085d6",
		  cancelButtonColor: "#d33",
		  confirmButtonText: "폐기",
		  cancelButtonText: "취소"
		}).then((result) => {
		  if (result.isConfirmed) {
			  const docNumber = $(this).closest('tr').find('td.docNumber').text();
				$.ajax({
					url: 'deleteDoc',
					method: 'post',
					data: JSON.stringify({docNumber}),
					contentType: "application/json",
					success: function(data){
						if (data.status=='ok') {
							//location.href = 'submitted?type=retrieval&pageNo=1';
						} else if (data.status=='impossible') {
							alert(data.message);
						}
					},
					error: function (xhr, status, error) {
			            console.log('Error: ' + error);
			        },
				});
		  }
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
    		<span id="approval-result-type-${reviewerSeq}" class="${cssClass}" style="font-size: .75rem;">[전결]</span>
    		<br/>
    	`);
    }
    
    if(approvalData.approvalType === '대결') {
    	const proxyTemp = $(contentDocument.getElementById('approval-result-'+reviewerSeq));
    	proxyTemp.prepend(`
    		<span id="approval-result-empName-${reviewerSeq}" class="${cssClass}" style="font-size: .85em;">${reviewerInfo.attr('data-name')} ${reviewerInfo.attr('data-position')}</span>
    		<br/>
        `);
    	proxyTemp.prepend(`
			<span id="approval-result-type-${reviewerSeq}" class="${cssClass}" style="font-size: .85em;">[대결]</span>
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
				Swal.fire({
					  icon: "error",
					  text: data.message
				});
			} else if(data.status == 'no-approval-seq') {
				Swal.fire({
					  icon: "error",
					  text: data.message
				});
			} else if(data.status == 'ok') {
				location.href = 'approveList?type=all&pageNo=1';
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

$('.select-search-draft').on('change', function() {
	const type = $(this).val();
	console.log(type);
	$(this).next('.input-search-draft').remove();
	if(type === 'draftTitle') {
		$(this).after(`
				<input class="form-control col-8 input-search-draft draft-title" placeholder="검색 유형 입력" style="flex:3;" />
		`);
		
	} else if (type === 'draftType') {
		$(this).after(`
				<select class="form-select form-select-sm col-8 input-search-draft draft-type" style="flex: 3;">
					<option value="근태신청서">근태신청서</option>
					<option value="출장품의서">출장품의서</option>
					<option value="출장보고서">출장보고서</option>
					<option value="휴일근무신청서">휴일근무신청서</option>
					<option value="연장근무신청서">연장근무신청서</option>
				</select>
		`);
		
	} else if (type === 'draftAuthor') {
		$(this).after(`
				<input class="form-control col-8 input-search-draft draft-author" placeholder="검색 유형 입력" style="flex:3;" />
		`);
	} else if (type === 'draftState') {
		$(this).after(`
				<select class="form-select form-select-sm col-8 input-search-draft draft-state" style="flex: 3;">
					<option value="대기">&nbsp;&nbsp;대기</option>
					<option value="진행">&nbsp;&nbsp;진행</option>
					<option value="승인">&nbsp;&nbsp;승인</option>
					<option value="반려">&nbsp;&nbsp;반려</option>
				</select>
		`);
	} else if (type === 'draftDept') {
		$(this).after(`
				<select class="form-select form-select-sm col-8 input-search-draft draft-dept" style="flex: 3;">
					<option value="" disabled="disabled" >&nbsp;&nbsp;부서 선택</option>
				</select>
		`);
		
		$.ajax({
			url: 'getDeptList',
			method: 'get',
			success: function(data) {
				const id = data.deptIds;
				const name = data.deptNames;
				for(let i=0; i<id.length; i++) {
					$('select.draft-dept').append(`
						<option value="${id[i]}">&nbsp;&nbsp;${name[i]}</option>
					`);
				}
			},
			error: function (xhr, status, error) {
	            console.log('Error: ' + error);
			},
		});
	}
});

$('.btnApprovalSearch').on('click', function(){
	const inputDiv = $(this).closest('.approval-search-input-group');
	const url = inputDiv.attr('data-url');
	const param = {};
	param.type = inputDiv.attr('data-active-page');
	param.pageNo = inputDiv.attr('data-page-no');
	param.search = inputDiv.find('select.select-search-draft').val();
	param.keyword = inputDiv.find('.input-search-draft').val();
	
	console.log(param);
	
	location.href = url+'?type='+param.type+'&pageNo='+param.pageNo+'&search='+param.search+'&keyword='+param.keyword;
});

$(function(){
	if($('.select-search-draft').val() === 'draftDept') {
		$.ajax({
	        url: 'getDeptList',
	        method: 'get',
	        success: function(data) {
	            const id = data.deptIds;
	            const name = data.deptNames;
	            for(let i=0; i<id.length; i++) {
	                $('select.draft-dept').append(`
	                    <option value="${id[i]}">${name[i]}</option>
	                `);
	            }
	        },
	        error: function (xhr, status, error) {
	            console.log('Error: ' + error);
	        },
	    });
	}
});



