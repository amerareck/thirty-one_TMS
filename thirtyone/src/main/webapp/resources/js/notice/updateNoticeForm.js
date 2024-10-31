document.addEventListener("DOMContentLoaded", function() {

document.getElementById('contentForm').addEventListener("submit", function(e) {
	e.preventDefault();

	if (contentValidChk()) {
		contentForm.submit();
	}
});

$(document).ready(function() {
	$('#summernote').summernote()
});


// 유효성 검사
function contentValidChk() {
	var summernote = document.getElementById("summernote").value;
	var titleBox = document.getElementById("titleBox").value;
	
	if (titleBox.length === 0 || titleBox == "") {
		alert("제목을 입력해주세요.");
		return false;
	}

	if (summernote.length === 0) {
		alert("내용이 비어있습니다. 내용을 입력해주세요.");
		return false;
	}
	return true;
}
/*
 * $('textarea').on('keyup', function() { var editor = $(this).val(); var
 * titleBox = $(this).val();
 */



// 부트스트랩 모달
const exampleModal = document.getElementById('exampleModal')

exampleModal.addEventListener('shown.bs.modal', () => {
	exampleModal.focus()
})

$('#deptModal').click(function(e) {
	var param = $("form[name=deptId]").serialize();
	console.log(param);
})


// 드래그 앤 드랍
const box = document.querySelector("dropZone");

window.addEventListener("dragover", function(e) {
	console.log("드래그")
	e.preventDefault();
});

window.addEventListener("drop", function(e) {
	console.log("드랍")
	e.preventDefault();

	
	
	const files = e.dataTransfer.files;
	addFileList(files[0]);
	console.log(files[0]);
	
	const dataTransfer = new DataTransfer();


	
	for(var i=0; i<files.length; i++) {
		dataTransfer.items.add(files[i])
	}
	
})

function addFileList(files) {
	const fileList = document.getElementById("fileList");
};
// 드래그 앤 드랍 이미지 출력
const dropZone = document.querySelector("#dropZone");
const fileBox = document.querySelector(".fileBox");

dropZone.addEventListener('dragover', (e)=> {
	e.preventDefault();
});

dropZone.addEventListener('drop', (e)=> {
	e.preventDefault();
	
	
	const files = e.dataTransfer.files;
	console.log(files[0]);
	
	const type=files[0].type;
	
	if(type !=="image/png" && type !=="image/jpg" && type !=="image/jpeg" && type !=="image/gif") {
		alert("이미지 파일이 아닙니다.");
		return;
	}
	
	if(files.length > 0) {
		const reader=new FileReader();
		reader.onload=(event)=> {
			const data=event.target.result;
			console.log(data);
			
			$(".fileBox p").remove(); // 처음에만 empty사용 후 여러개 하고싶으면 append로
										// 추가해줘야 한다.
			$('#preview').attr("src", data);
			$('#preview').css("width", "100px");
			
		};
		reader.readAsDataURL(files[0]);
	}
});
// 빈 영역 클릭시 이미지 첨부 가능
document.querySelector(".fileBox").addEventListener("click", () => {
	document.querySelector("#uploadFile").click();
	});
});


// input:file 이미지 미리보기 & 삭제하기
/*$(function() {
	$("input:file").change(function() {
		const files = $(this).prop('files');
		const fileBox = $(".fileBox");
		
		if (files.length == 0) {
			fileBox.append('<p><img src="${pageContext.request.contextPath}/resources/image/plusFile_icon.png" alt="plusFile" style="width: 44px" id="preview" /> 마우스로 파일을 끌어놓으세요.</p>');
				
			} else {			
			
			for (let i=0; i < files.length; i++) {
				const reader=new FileReader();
				reader.onload=(event)=> {
					const data=event.target.result;				
					console.log(data);
					
					$(".fileBox p").empty();
	
					const imgElement = $('<img>', {
						src: data,
						css: {width: '100px', margin: '5px'}
					});
					
					const deleteFileId = files[i].id;
					
					const deleteFile = $( '<button>', {
						text: 'x',
						class: 'deleteFile', 
						css: {background: 'transparent', border: 'transparent'},	
						'data-delete-file': deleteFileId
					});				
					
					deleteFile.on("click", (e) => {
						e.preventDefault();
						e.stopPropagation();
						
						const noticeFileId = deleteFile.data('delete-file');
						
					$.ajax({
						method: 'POST',
						url: contextPath +'/notice/deleteFile',
						contentType: 'application/json',
						data: JSON.stringify({ 'noticeFileId':noticeFileId }),
						success: function(data) {
							
							imgElement.remove();
							deleteFile.remove();
							console.log('삭제완료')
						},
						error: function(xhr, status, error) {
							console.error('Error:', xhr.status, error);
						}
					});
				});

					$(".fileBox").append(imgElement);
					fileBox.append(imgElement).append(deleteFile);
				};
				reader.readAsDataURL(files[i]);
				}
			}
		}
	});
});*/

const uploadFile = document.getElementById("uploadFile");
const fileBoxDisplay = document.getElementById("fileBox");
let filesArray = [];

uploadFile.addEventListener("change", (event) => {
	filesArray = Array.from(event.target.files); // FileList를 배열로 변환
	displayFileList();
	console.log(filesArray);
});

// 파일 목록을 화면에 표시
function displayFileList() {	
	
	const fileBoxP = document.querySelector(".fileBox p");
	if (fileBoxP) {
	fileBoxP.innerHTML = "";
	}

	console.log(filesArray.length);
	if (filesArray.length === 0) {
		fileBoxDisplay.innerHTML = '<p><img src="/thirtyone/resources/image/plusFile_icon.png" alt="plusFile" style="width: 44px" id="preview" />&nbsp;마우스로 파일을 끌어놓으세요.</p>';
			
	} else {			
	
		 filesArray.forEach((file, index) => {
			
			const reader=new FileReader();
			reader.onload=(event)=> {
				
				const data=event.target.result;				
				console.log(data);			
		
				const imgElement = document.createElement("img");
				imgElement.src = data;
				imgElement.style.width = '100px';
				imgElement.style.margin = '5px';		
			
				fileBoxDisplay.appendChild(imgElement)
				
				const removeButton = document.createElement("button");
				removeButton.innerHTML = '<img src="/thirtyone/resources/image/cancel_icon.png" style="width: 30px">';
				
				removeButton.style.background = 'transparent';
				removeButton.style.border = 'none';
				removeButton.style.cursor = 'pointer';
				removeButton.style.margin = '-40px 0px 20px -45px';
				
				removeButton.addEventListener("click", (event) => {
					event.preventDefault();
					event.stopPropagation();
					removeFile(index);
				});	
				fileBoxDisplay.appendChild(removeButton);
			};
			
			reader.readAsDataURL(file);
		});
	}
}

// 파일 삭제 함수
function removeFile(index) {
	filesArray.splice(index, 1); // 배열에서 파일 제거
	updateFileListDisplay(); //파일 리스트 업데이트
	displayFileList(); //이미지 미리보기 업데이트
}
		
// input 요소의 FileList를 업데이트
function updateFileListDisplay() {
	const dataTransfer = new DataTransfer();
	filesArray.forEach(file => dataTransfer.items.add(file));
	uploadFile.files = dataTransfer.files; //input 요소에 업데이트된 파일 목록 설정
}		

//파일 값 불러오기
function getFile() {
	/*return filesArray.map(file => file.name);*/
}


// 체크박스
function getCheckboxValue() {
	
	const query = 'input[name="deptId"]:checked';
	const selectedEls =
		document.querySelectorAll(query);
	
	let result = '';
	selectedEls.forEach((el) => {
		result += el.value + ' ';
	});
	
	
	document.getElementById('result').innerText
		=result;
	console.log(result);
	
}


