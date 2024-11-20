$('.approvalViews').on('shown.bs.modal', function () {
    const index = $(this).attr('id').split('-')[1];
    $.ajax({
    	url: 'getDocumentContext',
    	method: 'get',
    	data: {docNumber: $('#documentContext-'+index).attr('data-docNumber')},
    	success: function(data){
    		const cssName = data.css;
    		tinymce.init({
    		    language: 'ko_KR',
    		    selector: '#documentContext-'+index,
    		    readonly: true,
    		    menubar: false,
    		    toolbar: false,
    		    plugins: 'autoresize',
    		    autoresize_min_height: 500,
    		    autoresize_max_height: 800,
    		    width: '100%',
    		    height: '100%',
    		    content_css: "/thirtyone/resources/css/document-form/"+cssName,
    		    setup: function (editor) {
    		        editor.on('dragstart', function (e) {
    		            e.preventDefault();
    		        });
    		        editor.on('mousedown', function (e) {
    		            e.preventDefault();
    		        });
    		        editor.on('keydown', function (e) {
    		            e.preventDefault();
    		        });
    		        editor.on('keyup', function (e) {
    		            e.preventDefault();
    		        });
    		        editor.on('init', function () {
    		            htmlContent = data.html;
    		        	
	    		        editor.setContent(htmlContent);
	    		        editor.iframeElement.style.width = '100%';
	    		        editor.iframeElement.style.height = '100%';
    		        })
    		    },
    		});
    	},
    	error: function (xhr, status, error) {
            console.log('Error: ' + error);
        },
    });
});

$('.approveModal').on('shown.bs.modal', function () {
    const index = $(this).attr('id').split('-')[1];
    const docNumber = $('#documentContext-'+index).attr('data-docnumber');
    console.log(docNumber);
    $.ajax({
    	url: 'getDocumentContext',
    	method: 'get',
    	data: {docNumber},
    	success: function(data){
    		const cssName = data.css;
    		tinymce.init({
    		    language: 'ko_KR',
    		    selector: '#documentContext-'+index,
    		    readonly: true,
    		    menubar: false,
    		    toolbar: false,
    		    plugins: 'autoresize',
    		    autoresize_min_height: 500,
    		    autoresize_max_height: 800,
    		    width: '100%',
    		    height: '100%',
    		    content_css: "/thirtyone/resources/css/document-form/"+cssName,
    		    setup: function (editor) {
    		        editor.on('dragstart', function (e) {
    		            e.preventDefault();
    		        });
    		        editor.on('mousedown', function (e) {
    		            e.preventDefault();
    		        });
    		        editor.on('keydown', function (e) {
    		            e.preventDefault();
    		        });
    		        editor.on('keyup', function (e) {
    		            e.preventDefault();
    		        });
    		        editor.on('init', function () {
    		            htmlContent = data.html;
    		        	
	    		        editor.setContent(htmlContent);
	    		        editor.iframeElement.style.width = '100%';
	    		        editor.iframeElement.style.height = '100%';
    		        })
    		    },
    		});
    	},
    	error: function (xhr, status, error) {
            console.log('Error: ' + error);
        },
    });
});

//기안서 양식 선택 시.
$('#documentForm').on('change', function() {
    const selectedValue = $(this).val();
    if(selectedValue === 'default') {
    	return;
    } else {
    	const aprLineBookMark = $('#approvalLineSelect');
    	$('#approvalLineSelect').empty();
    	$('#approvalLineInfo select').empty();
    	$('#approvalLineDiagram').empty();
    	$.ajax({
        	url: '../emp/getAllEmpApprovalLine',
        	method: 'get',
        	success: function(data) {
        		if(aprLineBookMark.attr('data-errors')) {
        			aprLineBookMark.append('<option selected value="default">북마크 결재선 선택</option>');
        		}
        		const names = data.aprLineNames;
        		for(let i=0; i<names.length; i++) {
        			const context = `
        				<option value="${names[i]}">${names[i]}</option>
        			`;
        			aprLineBookMark.append(context);
        		}
        	},
    		error: function (xhr, status, error) {
                console.log('Error: ' + error);
            }
        });
    	$('#approvalLineSelect').prop('disabled', false);
    	$('#draftDetailForm').children('div').each(function(){
    		$(this).addClass('hidden');
    	});
    	
    	switch (selectedValue) {
    	case 'holidayDocument' :
    		$('.hol-doc').each(function(){
    			$(this).removeClass('hidden');
    		});
    		break;
    	case 'businessTripDocument' :
    	case 'businessTripReport' :
    		$('.biz-trip').each(function(){
    			$(this).removeClass('hidden');
    		});
    		break;
    	case 'holidayWork' :
    		$('.hol-work').each(function(){
    			$(this).removeClass('hidden');
    		});
    		break;
    	case 'workOvertime' :
    		$('.work-over').each(function(){
    			$(this).removeClass('hidden');
    		});
    		break;
    	}
    }
    
    $.ajax({
        url: 'getDraftDoc',
        method: 'GET',
        data: { type: selectedValue },
        dataType: 'html',
        success: function(response) {
	    	tinymce.remove('#draftDocument');
	    	tinymce.init({
	    		language: 'ko_KR',
	            selector: '#draftDocument',
	            height: '600px',
	            content_css: "/thirtyone/resources/css/document-form/"+selectedValue+".css",
	            plugins: [
	                'anchor', 'autolink', 'charmap', 'codesample', 'emoticons', 'image', 'link', 'lists', 'media', 'searchreplace', 'table', 'visualblocks', 'wordcount'
	            ],
	            toolbar: 'undo redo | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table | align lineheight | numlist bullist indent outdent | emoticons charmap | removeformat',
	            setup: function(editor) {
	                editor.on('init', function() {
	                    editor.setContent(response);
	                    // 기안서 기본 값 대입
	        	        $.ajax({
	        	        	url: '../emp/getUserInfo',
	        	        	method: 'get',
	        	        	success: function(data) {
	        	        		const memberInfo = {};
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
	        				    
	        				    $(contentDocument.getElementById('draftEmpDepartment')).text(memberInfo.deptName);
	        				    $(contentDocument.getElementById('draftDocumentDate')).text(date.getFullYear()+'/'+month+'/'+day);
	        				    $(contentDocument.getElementById('draftDocumentAuthor')).text(memberInfo.empName);
	        				    $(contentDocument.getElementById('draftAuthorDepartment')).text(memberInfo.deptName);
	        				    $(contentDocument.getElementById('draftAuthorHiredate')).text('\u00A0'+memberInfo.empHiredate.split(' ')[0]);
	        				    $(contentDocument.getElementById('draftAuthorName')).text(memberInfo.empName);
	        				    $(contentDocument.getElementById('draftAuthorPosition')).text(memberInfo.position);
	        				    $(contentDocument.getElementById('draftAuthorEmpNumber')).text('\u00A0'+memberInfo.empNumber);
	        				    $(contentDocument.getElementById('draftAuthorTel')).text('\u00A0'+memberInfo.empTel);
	        				    $(contentDocument.getElementById('draftSubmitDate'))
	        				    	.text(date.getFullYear()+'년\u00A0\u00A0'+month+'월\u00A0\u00A0'+day+'일');
	        				    
	        	        	},
	        	        	error: function (xhr, status, error) {
	        	                console.log('Error: ' + error);
	        	            }
	        	        });
	               });
	            }
	        })
        },
        error: function (xhr, status, error) {
            console.log('Error: ' + error);
        },
    });
});

$(function(){
	const selectedValue = $('#documentForm').val();
    if(selectedValue === 'default') {
    	return;
    } else {
    	$('#draftDetailForm').children('div').each(function(){
    		$(this).addClass('hidden');
    	});
    	
    	switch (selectedValue) {
    	case 'holidayDocument' :
    		$('.hol-doc').each(function(){
    			$(this).removeClass('hidden');
    		});
    		break;
    	case 'businessTripDocument' :
    	case 'businessTripReport' :
    		$('.biz-trip').each(function(){
    			$(this).removeClass('hidden');
    		});
    		break;
    	case 'holidayWork' :
    		$('.hol-work').each(function(){
    			$(this).removeClass('hidden');
    		});
    		break;
    	case 'workOvertime' :
    		$('.work-over').each(function(){
    			$(this).removeClass('hidden');
    		});
    		break;
    	}
    }
});