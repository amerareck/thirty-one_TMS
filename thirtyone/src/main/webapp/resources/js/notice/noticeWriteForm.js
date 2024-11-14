document.addEventListener("DOMContentLoaded", function() {
	const contentForm = document.getElementById("contentForm");
	const uploadFile = document.getElementById("uploadFile");
	const fileBoxDisplay = document.getElementById("fileBox");
	const result = document.getElementById("result");
	let filesArray = [];
	
	$('#deptSearch').click(openDeptModal);
	$('#getCheckboxValue').click(handleCheckboxValue);
	
	function openDeptModal() {
		$.ajax({
			method: 'GET',
			url: contextPath + '/notice/deptList',
			success: function(data) {
				const modalBody = document.getElementById("modalBody");
				console.log(modalBody);
				if(modalBody.children.length == 0){
					modalBody.innerHTML = "";
					data.forEach(dept => {
						const deptCheck = document.createElement("div");
						deptCheck.classList.add('form-check');
						deptCheck.innerHTML = `
							<input class= "form-check-input" type="checkBox" name="deptId" value="${dept.deptId}" id="dept_${dept.deptName}">
							<label class="form-check-label" for="dept_${dept.deptName}">${dept.deptName}</label>
							`;
						modalBody.appendChild(deptCheck);
					});
				}
				$("#exampleModal").modal("show");
			},
			error: function(xhr) {
				console.error('Error', xhr.status);
			}						
		});
	}
	
	//체크박스 값 업데이트
	function updateDepartmentSelection() {
		console.log("호출됨");
		const deptNameCheck = $('input[name="deptId"]:checked');
		const selectedDeptName = [];		
		result.innerHTML = "";
		
		if (deptNameCheck.length === 0) {
			result.innerHTML = "미선택 시, 전체직원에게 공지가 노출됩니다.";
		} else {
			deptNameCheck.each(function() {
				selectedDeptName.push($(this).next('label').text());
			});
			result.innerHTML = selectedDeptName.join(", ");
		}
	}
	
	//체크박스 버튼 클릭 처리
	function handleCheckboxValue(event) {
		event.preventDefault();
		updateDepartmentSelection();
		$("#exampleModal").modal("hide");
	}
	
	//선택된 부서 ID 가져오기
	function getCheckedDeptIds() {
		/*const deptNameCheck = $('input[name="deptId"]:checked');*/
		return $('input[name="deptId"]:checked').map(function() {
			return $(this).val();
		}).get();
	}
	
	
	//폼 제출 이벤트 리스너
	contentForm.addEventListener("submit", function(event) {
		event.preventDefault();
        event.stopPropagation();
        const formData = new FormData(contentForm);				
        
        if (contentValidChk()) {
			submitForm(formData);
		}
	});
	
	
	/*function formatData(formData) {
	    // 데이터를 포맷하는 로직
	    // formData에 포함된 데이터를 가공하여 서버로 보낼 데이터로 변환
	    return formData;  // 예시로 그냥 그대로 반환
	}*/
	

	
	//공지 작성 폼 제출
	function submitForm(formData) {
		console.log("Form Data:", [...formData]);
		
		filesArray.forEach(file => formData.append('attachFile', file));
		
		for (let [key, value] of formData.entries()) {
            console.log(key, value); // 각 키와 값이 출력됩니다.
        }
		console.log("filesArray: ", filesArray);
		
		const checkedDeptIds = getCheckedDeptIds().map(id => parseInt(id));
		checkedDeptIds.forEach(deptId => formData.append('deptId[]', deptId)); // 배열처럼 사용
		console.log("부서 ID:", checkedDeptIds);
		
		
		$.ajax({
			method: 'POST',
			url: contextPath + '/notice/noticeWrite',
			data: formData,
			processData: false,
			contentType: false,
			success: function(response) {
				const noticeId = response.noticeId;

				Swal.fire({
					title: '공지사항 작성을 완료하시겠습니까?',
					text: '확인을 누르면 공지사항 작성이 완료됩니다.',
					icon: 'warning',
					
					showCancelButton: true,
					confirmButtonColor: '#1F5FFF',
					cancelButtonColor: '#d33',
					confirmButtonText: '확인',
					cancelButtonText: '취소',
					
					reverseButtons: true
				
				}).then(result => {
					if (result.isConfirmed) {
						Swal.fire({
							title: '공지사항 작성이 완료되었습니다.', 
							text: '공지사항 목록에서 확인해주세요.', 
							icon: 'success'
						}).then(() => {
							location.href = contextPath + '/notice/noticeList';
						});
					}
				});
			/*	})*/
				
				
				console.log("작성 AJAX 성공", response);
				/*location.href = contextPath + '/notice/noticeList';*/
			},
			error: function(xhr) {
				console.error('Error', xhr.status);
				console.log(xhr.responseText);
				
				Swal.fire({
                    title: '공지사항 작성이 실패했습니다.',
                    text: '공지사항 작성 과정에 문제가 발생했습니다. 나중에 다시 시도해주세요.',
                    icon: 'error',
                    confirmButtonText: '확인',
                    confirmButtonColor: '#FF6347'
                });
			}
		});
	}

	
	$('#summernote').summernote();
	
	//유효성 검사
	function contentValidChk() {
		const titleBox = document.getElementById("titleBox").value;
		const summernote = $("#summernote").summernote('code');
		
		if (!titleBox) {
			Swal.fire({
			    title: '제목을 입력해주세요.',
			    text: '제목이 비어있습니다. 제목을 입력해주세요.',
			    icon: 'warning',
			    confirmButtonText: '확인',
			    confirmButtonColor: '#FF6347'
			});
			return false;
		}
		
		if (!summernote || summernote === '<p><br></p>') {
			Swal.fire({
			    title: '내용을 입력해주세요.',
			    text: '내용이 비어있습니다. 내용을 입력해주세요.',
			    icon: 'warning',
			    confirmButtonText: '확인',
			    confirmButtonColor: '#FF6347'
			});
			return false;
		}
		return true;
	}
	
	//파일 처리
	const dropZone = document.querySelector("#dropZone");
	dropZone.addEventListener('dragover', (e) => e.preventDefault());
	dropZone.addEventListener('drop', handleDrop);
	
	
	uploadFile.addEventListener("change", () => {
		// filesArray = Array.from(event.target.files); => 파일이 1개씩 들어오면 filesArray의 길이는
		// 영원히 1;
		// 파일이 들어올때마다 배열로 변화시켜 filesArray에 추가한다면 filesArray의 값은 입력된 파일의 개수만큼 증가된다.
	   let tempList = Array.from(event.target.files); // FileList를 배열로 변환
	   tempList.forEach(function (file, index)  {
	      filesArray.push(file);
	   })
	   
	    // 새로운 파일 입력 요소 생성
	    const newFileInput = document.createElement("input");
	    newFileInput.type = "file";
	    newFileInput.name = "attachFile[]"; // 'files' 배열로 서버에 전달되도록 동일한 name 사용
	    newFileInput.multiple = true; // 여러 파일 선택 허용

	    // 새 파일 입력 요소를 폼에 추가
	    /* document.getElementById("dropZone").appendChild(newFileInput); */	   
	   console.log(filesArray);
	   displayFileList();
	});

	document.querySelector(".fileBox").addEventListener("click", () => {
		uploadFile.click();
	});
	
	//드래그 앤 드롭
	function handleDrop(event) {
		event.preventDefault();
		const files = event.dataTransfer.files;
		handleFiles(files);
	}
	
	//파일 처리 함수
	function handleFiles(files) {
		Array.from(files).forEach(file => {
				filesArray.push(file);
		});
		displayFileList();
	}
	
	//파일 목록 표시
	function displayFileList() {
		fileBoxDisplay.innerHTML = '';
		if (filesArray.length === 0) {
			fileBoxDisplay.innerHTML = '<p><img src="/thirtyone/resources/image/plusFile_icon.png" alt="plusFile" style="width: 44px" />&nbsp;마우스로 파일을 끌어놓으세요.</p>';
		} else {
			filesArray.forEach((file, index) => {
				const fileElement = document.createElement("div");
				fileElement.style.display = 'flex';
				fileElement.style.alignItems = 'center';		
				
				if (file.type.match('image.*')) {					
					const imgElement = document.createElement("img");
					imgElement.src = URL.createObjectURL(file);
					imgElement.style.width = '100px';
					imgElement.style.margin = '5px';
					fileBoxDisplay.appendChild(imgElement);
				} else {
					
					const fileName = document.createElement("span");
					fileName.textContent = file.name;
					fileElement.appendChild(fileName);
				}	
				
				const removeButton = document.createElement("button");
				removeButton.innerHTML = '<img src="/thirtyone/resources/image/cancel_icon.png" style="width: 30px">';
                removeButton.style.background = 'transparent';
                removeButton.style.border = 'none';
                removeButton.style.cursor = 'pointer';
                removeButton.style.margin = '-40px 0px 20px -45px';
	            
	            removeButton.addEventListener("click", (event) => {
	               event.preventDefault();
	               event.stopPropagation();
	               removeFile(index)
                });
                fileElement.appendChild(removeButton);		
                fileBoxDisplay.appendChild(fileElement);
			});
		}
	}
	
	//파일 삭제 함수
	function removeFile(index) {
		filesArray.splice(index, 1);
		updateFileListDisplay();
		displayFileList();
		
	}
	
	// input 요소의 FileList를 업데이트
	function updateFileListDisplay() {
	   const dataTransfer = new DataTransfer();
	   filesArray.forEach(file => dataTransfer.items.add(file));
	   uploadFile.files = dataTransfer.files; // input 요소에 업데이트된 파일 목록 설정
	}
});
	
	