document.addEventListener("DOMContentLoaded", function() {
    const contentForm = document.getElementById("contentForm");
    const uploadFile = document.getElementById("uploadFile");
    const fileBoxDisplay = document.getElementById("fileBox");
    const result = document.getElementById("result");
    let filesArray = []; // 새로 선택한 파일 목록
    let existingFiles = []; // 기존 파일 목록
    let updateFiles = [];
    let deleteFileId = [];
    var noticeId = document.getElementById("noticeId").value;
    console.log("Notice ID:", noticeId);
    
    // 부서 검색 및 체크박스 처리
    $('#deptSearch').click(openDeptModal);
    $('#getCheckboxValue').click(handleCheckboxValue);
    $('#summernote').summernote();

    getExistingFiles();
    /*loadExistingFiles();*/

    // 기존 파일 로드
    function loadExistingFiles(existingFileData) {
    	console.log("existingFileData: ", existingFileData);
        if (Array.isArray(existingFileData)) {
            existingFiles = existingFileData; // 기존 파일 정보 배열에 저장
        } else {
            existingFiles = []; // 배열이 아니면 빈 배열로 초기화
        }
        displayExistingFiles(existingFiles); // 기존 파일 표시
    }
    
    console.log('AJAX 요청을 보냅니다...');
    // 페이지 로드 시 기존 파일 정보를 서버에서 가져오기
    function getExistingFiles() {
        $.ajax({
            method: 'GET',
            url: contextPath + '/notice/updateNoticeByDb?noticeId=' + noticeId,
            success: function(existingFileData) {
                console.log('성공적인 응답:', existingFileData);
                loadExistingFiles(existingFileData);
                displayExistingFiles(existingFileData);
            },
            error: function(xhr) {
                console.error('파일 정보를 가져오는 데 실패했습니다.', xhr.status);
                alert('파일을 가져오는 데 문제가 발생했습니다. 나중에 다시 시도해주세요.');
            }
        });
    }

    // 기존 파일 표시
    function displayExistingFiles(existingFileData) {
        const dataTransfer = new DataTransfer();
        fileBoxDisplay.innerHTML = ''; // 기존 파일 표시 전 초기화
        console.log("existingFiles: ", existingFiles);
        if (existingFiles.length === 0) {
            fileBoxDisplay.innerHTML = '<p><img src="/thirtyone/resources/image/plusFile_icon.png" alt="plusFile" style="width: 44px" />&nbsp;마우스로 파일을 끌어놓으세요.</p>';
        } else {
        	existingFiles.forEach((file, index) => {
        		const noticeFileId = file.noticeFileId;
                if (!(file instanceof File)) {
                    console.log("[file]",[file]);
                    console.log("type",file.noticeFileType);
                    console.log("file.name",file.noticeFileName);
                    console.log(" new Date(file.lastModified).getTime() ");

                    
                    // Base64 문자열을 디코딩하여 바이너리 데이터로 변환
                    const byteCharacters = atob(file.noticeFileData);
                    const byteNumbers = new Array(byteCharacters.length);
                    for (let i = 0; i < byteCharacters.length; i++) {
                        byteNumbers[i] = byteCharacters.charCodeAt(i);
                    }
                    const byteArray = new Uint8Array(byteNumbers);

                    // 바이너리 데이터를 Blob으로 변환
                    const blob = new Blob([byteArray], { type: file.noticeFileType });

  
                    
                    
                    // file이 File 객체가 아닌 경우, 새로 File 객체를 만들어서 추가
                    file = new File([blob], file.noticeFileName, { type: file.noticeFileType });
                }
                const isDuplicate = updateFiles.some(item => 
	                item.name === file.name &&
	                item.size === file.size &&
	                item.type === file.type
	            );
	            if (!isDuplicate) {
                	updateFiles.push(file);
                }
	            
	            
	            
                const fileElement = document.createElement("div");
                fileElement.style.display = 'flex';
                fileElement.style.alignItems = 'center';        
                console.log("file",file);
                console.log("file.type.match('image.*')",file.type.match('image.*'));
                
                if (file.type.match('image.*')) {           
                	console.log("들어오나");
                    const imgElement = document.createElement("img");
                    imgElement.src = "/thirtyone/notice/attachDownload?noticeFileId="+noticeFileId;  // 이미지 URL 설정
                    imgElement.style.width = '100px';
                    imgElement.style.margin = '5px';
                    fileBoxDisplay.appendChild(imgElement);
                } else {
                	console.log("집");
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
                    removeExistingFile(noticeFileId, index); // 기존 파일 삭제
                });
                
                fileBoxDisplay.appendChild(removeButton);
                fileBoxDisplay.appendChild(fileElement);
                
                // DataTransfer에 File 객체 추가
                dataTransfer.items.add(file);
            });
        }
        uploadFile.files = dataTransfer.files; // 파일 입력 영역에 파일 설정
    }

    // 기존 파일 삭제
    function removeExistingFile(fileId, index) {
    	console.log("fileId " + fileId);
    	deleteFileId.push(fileId);
        existingFiles.splice(index, 1); // 배열에서 파일 제거
    	
//        deleteFileFromDb(fileId).then(() => {
        displayExistingFiles(existingFiles); // UI 업데이트
//        }); > 다없어지지 않게 화면상에서 없어지게 수정
    }

    // db에서 파일 삭제
//    function deleteFileFromDb(fileId) {
//        return $.ajax({
//            method: 'POST',
//            url: contextPath + '/notice/deleteFileFromDb',
//            contentType: 'application/json',
//            data: JSON.stringify({ noticeFileId: fileId }),
//            success: function(response) {
//                console.log('파일 삭제 성공');
//            },
//            error: function(xhr) {
//                console.error('파일 삭제 실패', xhr.status);
//            }
//        });
//    }

    // 파일 선택 이벤트
    uploadFile.addEventListener("change", (event) => {
        let tempList = Array.from(event.target.files); // FileList를 배열로 변환
        /*tempList.forEach(file => filesArray.push(file));*/
        tempList.forEach(file => { 
        	filesArray.some(item =>{
		        item.name === file.name &&
		        item.size === file.size &&
		        item.type === file.type
        	});
        	filesArray.push(file);
        }); 
        
        displayFileList(); // 새 파일 목록 표시
    });
    
    
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
    
    // 드래그 앤 드롭
    function handleDrop(event) {
        event.preventDefault();
        const files = event.dataTransfer.files;
        handleFiles(files);
    }

    // 드래그 앤 드롭으로 파일 처리
    function handleFiles(files) {
        Array.from(files).forEach(file => filesArray.push(file));
        displayFileList(); // 파일 목록 표시
    }

    // 파일 목록 표시
    function displayFileList() {
        displayExistingFiles(existingFiles); // 기존 파일 다시 표시
        if (filesArray.length === 0) {
			fileBoxDisplay.innerHTML = '<p><img src="/thirtyone/resources/image/plusFile_icon.png" alt="plusFile" style="width: 44px" />&nbsp;마우스로 파일을 끌어놓으세요.</p>';
		} else {
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
    }

    // 새로 선택된 파일 삭제
    function removeFile(index) {
        filesArray.splice(index, 1);
        displayFileList();
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

                // 선택된 부서 있을시 체크박스 상태 업데이트
                const selectedDeptIds = getSelectedDeptIds();
                selectedDeptIds.forEach(deptId => {
                    const checkbox = document.getElementById(`dept_${deptId}`);
                    if (checkbox) checkbox.checked = true;
                });

                $("#exampleModal").modal("show");
            },
            error: function(xhr) {
                console.error('Error', xhr.status);
            }
        });
    }

    // 이미 선택된 부서 id 가져오기
    function getSelectedDeptIds() {
        return existingFiles.map(file => file.deptId);
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
    
  //폼 제출 이벤트 리스너
	contentForm.addEventListener("submit", function(event) {
		event.preventDefault();
        event.stopPropagation();
        const formData = new FormData(contentForm);				

        if (contentValidChk()) {
			submitForm(formData);
		}
	});
    
  //유효성 검사
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
	
	
	//공지 작성 폼 제출
	function submitForm(formData) {
		console.log("=========================================================")
		console.log("Form Data:", [...formData]);
		console.log("updateFiles: ", updateFiles);
		
//		updateFiles.forEach(file => formData.append('attachFile', file));
		filesArray.forEach(file => formData.append('attachFile', file));
		formData.append("deleteFileId", deleteFileId);
		for (let [key, value] of formData.entries()) {
            console.log(key, value); // 각 키와 값이 출력됩니다.
        }
		console.log("filesArray: ", filesArray);
		
		const checkedDeptIds = getCheckedDeptIds().map(id => parseInt(id));
		checkedDeptIds.forEach(deptId => formData.append('deptId[]', deptId)); // 배열처럼 사용
		console.log("부서 ID:", checkedDeptIds);
		
		
		$.ajax({
			method: 'POST',
			url: contextPath + '/notice/updateNotice',
			data: formData,
			processData: false,
			contentType: false,
			success: function(response) {
				const noticeId = response.noticeId;
				alert("공지사항 수정이 성공적으로 되었습니다!");
				console.log("작성 AJAX 성공", response);
				location.href = contextPath + '/notice/noticeList';
			},
			error: function(xhr) {
				console.error('Error', xhr.status);
				console.log(xhr.responseText);
			}
		});
	}
});
