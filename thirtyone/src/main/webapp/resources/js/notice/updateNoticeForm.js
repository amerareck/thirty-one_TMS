document.addEventListener("DOMContentLoaded", function() {
	const contentForm = document.getElementById("contentForm");
	const uploadFile = document.getElementById("uploadFile");
	const fileBoxDisplay = document.getElementById("fileBox");
	const result = document.getElementById("result");
	let filesArray = []; // 새로 선택한 파일 목록
	let existingFiles = []; // 기존 파일 목록

	// 부서 검색 및 체크박스 처리
	$('#deptSearch').click(openDeptModal);
	$('#getCheckboxValue').click(handleCheckboxValue);
	


	// 기존 파일 로드
	function loadExistingFiles(existingFileData) {
		existingFiles = existingFileData; // 기존 파일 정보 배열에 저장
		displayExistingFiles(); // 기존 파일 표시
	}
	

	//페이지 로드 시 기존 파일 정보를 서버에서 가져오기
	function getExistingFiles() {
		$.ajax({
			method: 'GET',
			url: contextPath + '/notice/updateNoticeForm?noticeId=' + noticeId,
			success: function(existingFileData) {
				loadExistingFiles(existingFileData);
			},
			error: function(xhr) {
				console.error('Error fetching existing files', xhr.status);
			}
		});
	}

	// 기존 파일 표시
	function displayExistingFiles() {
		fileBoxDisplay.innerHTML = ''; // 기존 파일 표시 전 초기화
		existingFiles.forEach((file, index) => {
			const imgElement = document.createElement("img");
			imgElement.src = file.fileUrl;
			imgElement.style.width = '100px';
			imgElement.style.margin = '5px';
			fileBoxDisplay.appendChild(imgElement);
			
			const removeButton = document.createElement("button");
			removeButton.innerHTML = '<img src="/thirtyone/resources/image/cancel_icon.png" style="width: 30px">';
			removeButton.style.background = 'transparent';
			removeButton.style.border = 'none';
			removeButton.style.cursor = 'pointer';
			removeButton.style.margin = '-40px 0px 20px -45px';
			removeButton.addEventListener("click", (event) => {
				event.preventDefault();
				event.stopPropagation();
				removeExistingFile(index); // 기존 파일 삭제
			});
			fileBoxDisplay.appendChild(removeButton);
		});
	}

	// 기존 파일 삭제
	function removeExistingFile(index) {
		existingFiles.splice(index, 1); // 배열에서 파일 제거
		displayExistingFiles(); // UI 업데이트
	}

	// 파일 선택 이벤트
	uploadFile.addEventListener("change", (event) => {
		const tempList = Array.from(event.target.files);
		tempList.forEach(file => {
			if (file.type.match('image.*')) {
				filesArray.push(file);
			} else {
				alert("이미지 파일이 아닙니다.");
			}
		});
		displayFileList(); // 선택한 파일 목록 표시
	});

	// 파일 목록 표시
	function displayFileList() {
		fileBoxDisplay.innerHTML = ''; // 기존 내용 제거
		displayExistingFiles(); // 기존 파일 다시 표시

		filesArray.forEach((file, index) => {
			const imgElement = document.createElement("img");
			imgElement.src = URL.createObjectURL(file);
			imgElement.style.width = '100px';
			imgElement.style.margin = '5px';
			fileBoxDisplay.appendChild(imgElement);
			
			const removeButton = document.createElement("button");
			removeButton.innerHTML = '<img src="/thirtyone/resources/image/cancel_icon.png" style="width: 30px">';
			removeButton.style.background = 'transparent';
			removeButton.style.border = 'none';
			removeButton.style.cursor = 'pointer';
			removeButton.addEventListener("click", (event) => {
				event.preventDefault();
				event.stopPropagation();
				removeFile(index); // 새로 선택한 파일 삭제
			});
			fileBoxDisplay.appendChild(removeButton);
		});
	}

	// 새로 선택된 파일 삭제
	function removeFile(index) {
		filesArray.splice(index, 1); // 배열에서 파일 제거
		displayFileList(); // UI 업데이트
	}
	
	//db에서 파일 삭제
	function deleteFileFromDb(index) {
		const fileId = existingFiles[index].id; //삭제할 파일 ID
		$.ajax ({
			method: 'POST',
			url: contextPath + '/notice/deleteFileFromDb',
			contentType: 'application/json',
			data: JSON.stringify({noticeFileId: fileId}),
			success: function(response) {
				existingFiles.splice(index, 1);
				displayExistingFiles();
			},
			error: function(xhr) {
				console.error('Error deleting file', xhr.status);
			}
		});
				
	}

	// 폼 제출 이벤트 리스너
	contentForm.addEventListener("submit", function(e) {
		e.preventDefault();
		if (contentValidChk()) {
			submitForm();
		}
	});

	// 공지 작성 폼 제출
	function submitForm() {
		const formData = new FormData(contentForm);				
		
		// 기존 파일 ID를 전송
		existingFiles.forEach(file => formData.append('existingFileIds', file.id));
		// 새로 추가된 파일 전송
		filesArray.forEach(file => formData.append('attachFile', file));
		
		$.ajax({
			method: 'POST',
			url: contextPath + '/notice/noticeWrite',
			data: formData,
			processData: false,
			contentType: false,
			success: function(response) {
				console.log("작성 AJAX 성공", response);
				location.href = contextPath + '/notice/noticeList';
			},
			error: function(xhr) {
				console.error('Error', xhr.status);
				console.log(xhr.responseText);
			}
		});
	}
	
	// Summernote 초기화
	$('#summernote').summernote();
	
	// 유효성 검사
	function contentValidChk() {
		const titleBox = document.getElementById("titleBox").value;
		const summernote = $("#summernote").summernote('code');
		
		if (!titleBox) {
			alert("제목을 입력해주세요.");
			return false;
		}
		
		if (!summernote || summernote === '<p><br></p>') {
			alert("내용이 비어있습니다. 내용을 입력해주세요.");
			return false;
		}
		return true;
	}

	
	// 부서 관련 함수들
	function openDeptModal() {
		$.ajax({
			method: 'GET',
			url: contextPath + '/notice/deptList',
			success: function(data) {
				const modalBody = document.getElementById("modalBody");
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
				$("#exampleModal").modal("show");
			},
			error: function(xhr) {
				console.error('Error', xhr.status);
			}						
		});
	}

	// 체크박스 값 업데이트
	function updateDepartmentSelection() {
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

	// 체크박스 버튼 클릭 처리
	function handleCheckboxValue(event) {
		event.preventDefault();
		updateDepartmentSelection();
		$("#exampleModal").modal("hide");
	}

	// 선택된 부서 ID 가져오기
	function getCheckedDeptIds() {
		return $('input[name="deptId"]:checked').map(function() {
			return $(this).val();
		}).get();
	}

	// 파일 처리: 드래그 앤 드롭 이벤트
	const dropZone = document.querySelector("#dropZone");
	dropZone.addEventListener('dragover', (e) => e.preventDefault());
	dropZone.addEventListener('drop', handleDrop);

	function handleDrop(event) {
		event.preventDefault();
		const files = event.dataTransfer.files;
		Array.from(files).forEach(file => {
			if (file.type.match('image.*')) {
				filesArray.push(file);
			} else {
				alert("이미지 파일이 아닙니다.");
			}
		});
		displayFileList(); // 드롭한 파일 목록 표시
	}

	document.querySelector(".fileBox").addEventListener("click", () => {
		uploadFile.click();
	});
});
