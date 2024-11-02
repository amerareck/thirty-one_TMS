/*// 체크박스
	function getCheckboxValue() {   
	   console.log("호출됨");
	   
	   const deptNameCheck = $('input[name="deptId"]:checked');
	   console.log(deptNameCheck);
	   const result = document.getElementById("result");
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
	   $("#getCheckboxValue").click(function(event) {
	      event.preventDefault();
	      getCheckboxValue();
	   $("#exampleModal").modal("hide");
	      
	});

document.addEventListener("DOMContentLoaded", function() {
	
	const contentForm = document.getElementById("contentForm");
	const uploadFile = document.getElementById("uploadFile"); 
	const fileBoxDisplay = document.getElementById("fileBox");
	let filesArray = [];


$('#deptSearch').click(openDeptModal); 
   console.log("찾기");
   
   
   function openDeptModal() {
		
		   $.ajax({
		      method: 'GET',
	      url: contextPath +'/notice/deptList',
	      success: function(data) {
	         console.log("AJAX 성공", data);
	         const modalBody = document.getElementById("modalBody");
	         modalBody.innerHTML = "";
	         data.forEach(dept => {
	            const deptCheck = document.createElement("div");
	            deptCheck.classList.add('form-check');
	            deptCheck.innerHTML = `
	            <input class="form-check-input" type="checkbox" name="deptId" value="${dept.deptId}"
	            id="dept_${dept.deptName}">
	            <label class="form-check-label" for="dept_${dept.deptName}">${dept.deptName}</label>
	            `;
	            modalBody.appendChild(deptCheck);
	         });   
	         
	         $("#exampleModal").modal("show");
	   },
	      error: function(xhr, status, error) {
	         console.error('Error', xhr.status, error);      
		      }
	   });
   }
   

function submitForm() {
   	const formData = new FormData(contentForm);
   	filesArray.forEach(file => formData.append('attachFile', file)); // 파일 추가

   	const selectedDeptIds = getCheckedDeptIds();
   	const noticeId = 1;
   	
   	selectedDeptIds.forEach(deptId => {
   		formData.append('deptId[]', deptId);
   	});
   	formData.append('noticeId', noticeId);
   	
   	console.log("부서 ID:", [...formData]);
   	}


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
		
		error: function(xhr, status, error) {
			console.error('Error', xhr.status, error);
			console.log(xhr.responseText);
		}
	});
	}
  	
   	// 체크박스
	function getCheckboxValue() {   
		   console.log("호출됨");
		   
		   const deptNameCheck = $('input[name="deptId"]:checked');
		   console.log(deptNameCheck);
		   const result = document.getElementById("result");
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
		   $("#getCheckboxValue").click(function(event) {
		      event.preventDefault();
		      getCheckboxValue();
		   $("#exampleModal").modal("hide");
		      
		});

	document.addEventListener("DOMContentLoaded", function() {
		
		const contentForm = document.getElementById("contentForm");
		const uploadFile = document.getElementById("uploadFile"); 
		const fileBoxDisplay = document.getElementById("fileBox");
		let filesArray = [];

		

	$('#deptSearch').click(openDeptModal); 
	   console.log("찾기");
	   
	   
	   function openDeptModal() {
			
			   $.ajax({
			      method: 'GET',
		      url: contextPath +'/notice/deptList',
		      success: function(data) {
		         console.log("AJAX 성공", data);
		         const modalBody = document.getElementById("modalBody");
		         modalBody.innerHTML = "";
		         data.forEach(dept => {
		            const deptCheck = document.createElement("div");
		            deptCheck.classList.add('form-check');
		            deptCheck.innerHTML = `
		            <input class="form-check-input" type="checkbox" name="deptId" value="${dept.deptId}"
		            id="dept_${dept.deptName}">
		            <label class="form-check-label" for="dept_${dept.deptName}">${dept.deptName}</label>
		            `;

		            modalBody.appendChild(deptCheck);
		         });   

		         $("#exampleModal").modal("show");
		   },
		      error: function(xhr, status, error) {
		         console.error('Error', xhr.status, error);      
			      }
		   });
	   }


	   function getCheckedDeptIds() {
		const deptNameCheck = $('input[name="deptId"]:checked');
		const selectedDeptIds = [];
		
		deptNameCheck.each(function() {
			selectedDeptIds.push($(this).val());
		});
		return selectedDeptIds;
	   }

	
   contentForm.addEventListener("submit", function(e) {
      e.preventDefault();

      if (contentValidChk()) {
   	   submitForm();
      }
   });


   $('#summernote').summernote();
   

// 유효성 검사
function contentValidChk() {
	var titleBox = document.getElementById("titleBox").value;
   var summernote = $("#summernote").summernote('code');
   
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

const dropZone = document.querySelector("#dropZone");
dropZone.addEventListener('dragover', (e) => e.preventDefault());
dropZone.addEventListener('drop', handleDrop);

function handleDrop(event) {
	event.preventDefault();
    event.stopPropagation();
	const files = event.dataTransfer.files;
	handleFiles(files);
}

// 파일 처리 함수
function handleFiles(files) {
	Array.from(files).forEach(file => {
		if (file.type.match('image.*')) {
			
			if (!filesArray.includes(file)) {
				filesArray.push(file);
				const reader = new FileReader();
				reader.onload = (event) => {
					const imgElement = document.createElement("img");
					imgElement.src = event.target.result;
					imgElement.style.width = '100px';
					fileBoxDisplay.appendChild(imgElement);
			};
			reader.readAsDataURL(file);
			}
		} else {
			alert("이미지 파일이 아닙니다.");
		}
	});
	displayFileList();
}


//파일 목록 표시
function displayFileList() {
	fileBoxDisplay.innerHTML = '';
	if (filesArray.length === 0) {
		fileBoxDisplay.innerHTML = fileBoxDisplay.innerHTML = '<p><img src="/thirtyone/resources/image/plusFile_icon.png" alt="plusFile" style="width: 44px" id="preview" />&nbsp;마우스로 파일을 끌어놓으세요.</p>';
	} else {
		filesArray.forEach((file, index) => {
			 const imgElement = document.createElement("img");
	            imgElement.src = URL.createObjectURL(file);
	            imgElement.style.width = '100px';
	            imgElement.style.margin = '5px';      	         
	            fileBoxDisplay.appendChild(imgElement)
	            // 삭제 버튼 추가
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
	            fileBoxDisplay.appendChild(removeButton);
	         });
	      
	   }
}

//파일 삭제 함수
function removeFile(index) {
   filesArray.splice(index, 1); // 배열에서 파일 제거
   displayFileList(); // 이미지 미리보기 업데이트
}

uploadFile.addEventListener("change", (event) => {
	const tempList = Array.from(event.target.files);
	tempList.forEach(file => {
		filesArray.push(file);
	});
	displayFileList();
});

document.querySelector(".fileBox").addEventListener("click", () => {
	uploadFile.click();
	});
});

*/





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
	
	//체크박스 값 업데이트
	function updateDepartmentSelection() {
		console.log("호출됨");
		const deptNameCheck = $('input[name="deptId"]:checked');
		const selectedDeptName = [];
		
		result.innerHTML = "";
		
		if (deptNameCheck.lenght === 0) {
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
		const deptNameCheck = $('input[name="deptId"]:checked');
		return deptNameCheck.map(function() {
			return $(this).val();
		}).get();
	}
	

	
	//공지 작성 폼 제출
	function submitForm() {
		const formData = new FormData(contentForm);
		
		/*const empDiv = document.getElementById("empId");
		const empId = empDiv.getAttribute("data-value");*/
		
		
		console.log("Form Data:", [...formData]);
		
		filesArray.forEach(file => formData.append('attachFile', file));
		
		const checkedDeptIds = getCheckedDeptIds();
		checkedDeptIds.forEach(deptId => formData.append('deptId', deptId)); // 배열처럼 사용
		console.log("부서 ID:", checkedDeptIds);
		
		
		$.ajax({
			method: 'POST',
			url: contextPath + '/notice/noticeWrite',
			data: formData,
			processData: false,
			contentType: false,
			success: function(response) {
				const noticeId = response.noticeId;
				console.log("작성 AJAX 성공", response);
				location.href = contextPath + '/notice/noticeList';
			},
			error: function(xhr) {
				console.error('Error', xhr.status);
				console.log(xhr.responseText);
			}
		});
	}
	
	//폼 제출 이벤트 리스너
	contentForm.addEventListener("submit", function(e) {
		e.preventDefault();
		if (contentValidChk()) {
			submitForm();
		}
	});
	
	$('#summernote').summernote();
	
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
	
	//파일 처리
	const dropZone = document.querySelector("#dropZone");
	dropZone.addEventListener('dragover', (e) => e.preventDefault());
	dropZone.addEventListener('drop', handleDrop);
	
	uploadFile.addEventListener("change", (event) => {
		const tempList = Array.from(event.target.files);
		tempList.forEach(file => {
			if (file.type.match('image.*')) {
				filesArray.push(file);
				displayFileList();
			} else {
				alert("이미지 파일이 아닙니다.");
			}
		});
	});
	
	document.querySelector(".fileBox").addEventListener("click", () => {
		uploadFile.click();
	});
	
	//드래그 앤 드롭
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
		displayFileList();
	}
	
	//파일 목록 표시
	function displayFileList() {
		fileBoxDisplay.innerHTML = '';
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
                	removeFile(index);
                });
                fileBoxDisplay.appendChild(removeButton);
				
			});
		}
	}
	
	//파일 삭제 함수
	function removeFile(index) {
		filesArray.splice(index, 1);
		displayFileList();
	}
});
	
	








