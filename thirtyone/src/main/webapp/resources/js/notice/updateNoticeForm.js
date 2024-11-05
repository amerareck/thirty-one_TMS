document.addEventListener("DOMContentLoaded", function() {
    const contentForm = document.getElementById("contentForm");
    const uploadFile = document.getElementById("uploadFile");
    const fileBoxDisplay = document.getElementById("fileBox");
    const result = document.getElementById("result");
    let filesArray = []; // 새로 선택한 파일 목록
    let existingFiles = []; // 기존 파일 목록
    
    var noticeId = document.getElementById("noticeId").value;
    console.log("Notice ID:", noticeId);
    getExistingFiles();
    
    // 부서 검색 및 체크박스 처리
    $('#deptSearch').click(openDeptModal);
    $('#getCheckboxValue').click(handleCheckboxValue);
    $('#summernote').summernote();

    // 기존 파일 로드
    function loadExistingFiles(existingFileData) {
        if (Array.isArray(existingFileData)) {
            existingFiles = existingFileData; // 기존 파일 정보 배열에 저장
        } else {
            existingFiles = []; // 배열이 아니면 빈 배열로 초기화
        }
        displayExistingFiles(); // 기존 파일 표시
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
            },
            error: function(xhr) {
                console.error('파일 정보를 가져오는 데 실패했습니다.', xhr.status);
                alert('파일을 가져오는 데 문제가 발생했습니다. 나중에 다시 시도해주세요.');
            }
        });
    }

    // 기존 파일 표시
    function displayExistingFiles() {
        const dataTransfer = new DataTransfer();
        fileBoxDisplay.innerHTML = ''; // 기존 파일 표시 전 초기화
        if (existingFiles.length === 0) {
            fileBoxDisplay.innerHTML = '<p><img src="/thirtyone/resources/image/plusFile_icon.png" alt="plusFile" style="width: 44px" />&nbsp;마우스로 파일을 끌어놓으세요.</p>';
        } else {
            existingFiles.forEach((file, index) => {
                if (!(file instanceof File)) {
                    // file이 File 객체가 아닌 경우, 새로 File 객체를 만들어서 추가
                    file = new File([file], file.name, { type: file.type, lastModified: new Date(file.lastModified).getTime() });
                }
                
                const fileElement = document.createElement("div");
                fileElement.style.display = 'flex';
                fileElement.style.alignItems = 'center';        
                
                if (file.type.match('image.*')) {                    
                    const imgElement = document.createElement("img");
                    imgElement.src = file.url || URL.createObjectURL(file);  // 이미지 URL 설정
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
                    removeExistingFile(file.id, index); // 기존 파일 삭제
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
        deleteFileFromDb(fileId).then(() => {
            existingFiles.splice(index, 1); // 배열에서 파일 제거
            displayExistingFiles(); // UI 업데이트
        });
    }

    // db에서 파일 삭제
    function deleteFileFromDb(fileId) {
        return $.ajax({
            method: 'POST',
            url: contextPath + '/notice/deleteFileFromDb',
            contentType: 'application/json',
            data: JSON.stringify({ noticeFileId: fileId }),
            success: function(response) {
                console.log('파일 삭제 성공');
            },
            error: function(xhr) {
                console.error('파일 삭제 실패', xhr.status);
            }
        });
    }

    // 파일 선택 이벤트
    uploadFile.addEventListener("change", (event) => {
        let tempList = Array.from(event.target.files); // FileList를 배열로 변환
        tempList.forEach(file => filesArray.push(file));
        displayFileList(); // 새 파일 목록 표시
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
			submitForm();
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
});
